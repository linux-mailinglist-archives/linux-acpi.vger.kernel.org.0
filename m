Return-Path: <linux-acpi+bounces-76-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2327AD370
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 10:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A7E3728170E
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 08:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9001811CA7
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 08:32:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577D510A22;
	Mon, 25 Sep 2023 07:44:59 +0000 (UTC)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DABCC4;
	Mon, 25 Sep 2023 00:44:53 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0Vsmvt44_1695627888;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vsmvt44_1695627888)
          by smtp.aliyun-inc.com;
          Mon, 25 Sep 2023 15:44:49 +0800
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
Subject: [RFC PATCH v2 9/9] ACPI: APEI: ESRT: log ARM processor error
Date: Mon, 25 Sep 2023 15:44:26 +0800
Message-Id: <20230925074426.97856-10-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
References: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
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

Introduce a new pstore_record type, PSTORE_TYPE_CPER_PROC_ARM, so that
serialized ARM processor errors can be retrieved and saved as a file in
pstore file system. While the serialized errors is retrieved from ERST
backend, log it.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/erst.c | 6 ++++++
 fs/pstore/platform.c     | 1 +
 include/linux/pstore.h   | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index e0c44ea46acc..2b99573d1d5d 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -29,6 +29,7 @@
 #include <acpi/ghes.h>
 #include <linux/aer.h>
 #include <linux/pci.h>
+#include <linux/ras.h>
 #ifdef CONFIG_X86_MCE
 /* only define CREATE_TRACE_POINTS once */
 #include <trace/events/mce.h>
@@ -1092,6 +1093,11 @@ static ssize_t erst_reader(struct pstore_record *record)
 		cper_print_aer(
 			pdev, AER_FATAL,
 			(struct aer_capability_regs *)pcie_err->aer_info);
+	} else if (guid_equal(&rcd->sec_hdr.section_type, &CPER_SEC_PROC_ARM)) {
+		struct cper_sec_proc_arm *err = (struct cper_sec_proc_arm *)rcd->data;
+
+		record->type = PSTORE_TYPE_CPER_PROC_ARM;
+		log_arm_hw_error(err);
 	}
 	else
 		record->type = PSTORE_TYPE_MAX;
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 40a062546fe4..48ad3202284c 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -53,6 +53,7 @@ static const char * const pstore_type_names[] = {
 	"powerpc-opal",
 	"cper-mem",
 	"cper-pcie",
+	"cper-proc-arm",
 };
 
 static int pstore_new_entry;
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index e63f51e9c22e..83edff5aab0b 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -43,6 +43,7 @@ enum pstore_type_id {
 	/* APEI section */
 	PSTORE_TYPE_CPER_MEM		= 9,
 	PSTORE_TYPE_CPER_PCIE		= 10,
+	PSTORE_TYPE_CPER_PROC_ARM	= 11,
 
 	/* End of the list */
 	PSTORE_TYPE_MAX
-- 
2.41.0


