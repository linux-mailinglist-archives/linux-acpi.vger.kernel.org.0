Return-Path: <linux-acpi+bounces-67-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFDE7AD362
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 10:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4163E2815BF
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 08:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2624911C8E
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 08:32:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387F353BA;
	Mon, 25 Sep 2023 07:44:38 +0000 (UTC)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A8EDA;
	Mon, 25 Sep 2023 00:44:35 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VsmvswX_1695627867;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VsmvswX_1695627867)
          by smtp.aliyun-inc.com;
          Mon, 25 Sep 2023 15:44:31 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: keescook@chromium.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	bp@alien8.de,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	ardb@kernel.org,
	robert.moore@intel.com
Cc: linux-hardening@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-efi@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org,
	xueshuai@linux.alibaba.com,
	baolin.wang@linux.alibaba.com
Subject: [RFC PATCH v2 0/9] Use ERST for persistent storage of MCE and APEI errors 
Date: Mon, 25 Sep 2023 15:44:17 +0800
Message-Id: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

changes log since v1:
- fix a compile waring by dereferencing rcd pointer before memset
- add a compile error by add CONFIG_X86_MCE
- Link: https://lore.kernel.org/all/20230916130316.65815-3-xueshuai@linux.alibaba.com/

In certain scenarios (ie. hosts/guests with root filesystems on NFS/iSCSI
where networking software and/or hardware fails, and thus kdump fails), it
is necessary to serialize hardware error information available for
post-mortem debugging. Save the hardware error log into flash via ERST
before go panic, the hardware error log can be gotten from the flash after
system boot successful again, which is very useful in production.

On X86 platform, the kernel has supported to serialize and deserialize MCE
error record by commit 482908b49ebf ("ACPI, APEI, Use ERST for persistent
storage of MCE"). The process involves two steps:

- MCE Producer: When a hardware error is detected, MCE raised and its
  handler writes MCE error record into flash via ERST before panic
- MCE Consumor: After system reboot, /sbin/mcelog run, it reads /dev/mcelog
  to check flash for error record of previous boot via ERST

After /dev/mcelog character device deprecated by commit 5de97c9f6d85
("x86/mce: Factor out and deprecate the /dev/mcelog driver"), the
serialized MCE error record, of previous boot in persistent storage is not
collected via APEI ERST.

This patch set include two part:

- PATCH 1-3: rework apei_{read,write}_mce to use pstore data structure and emit
  the mce_record tracepoint, enabling the collection of MCE records by the
  rasdaemon tool.
- PATCH 4-9: use ERST for persistent storage of APEI errors, and emit
  tracepoints for CPER sections, enabling the collection of MCE records by the
  rasdaemon tool.

Shuai Xue (9):
  pstore: move pstore creator id, section type and record struct to
    common header
  ACPI: APEI: Use common ERST struct to read/write serialized MCE record
  ACPI: APEI: ERST: Emit the mce_record tracepoint
  ACPI: tables: change section_type of generic error data as guid_t
  ACPI: APEI: GHES: Use ERST to serialize APEI generic error before
    panic
  ACPI: APEI: GHES: export ghes_report_chain
  ACPI: APEI: ESRT: kick ghes_report_chain notifier to report serialized
    memory errors
  ACPI: APEI: ESRT: print AER to report serialized PCIe errors
  ACPI: APEI: ESRT: log ARM processor error

 arch/x86/kernel/cpu/mce/apei.c | 82 +++++++++++++++-------------------
 drivers/acpi/acpi_extlog.c     |  2 +-
 drivers/acpi/apei/erst.c       | 55 ++++++++++++++---------
 drivers/acpi/apei/ghes.c       | 48 +++++++++++++++++++-
 drivers/firmware/efi/cper.c    |  2 +-
 fs/pstore/platform.c           |  3 ++
 include/acpi/actbl1.h          |  5 ++-
 include/acpi/ghes.h            |  2 +-
 include/linux/pstore.h         | 29 ++++++++++++
 9 files changed, 154 insertions(+), 74 deletions(-)

-- 
2.41.0


