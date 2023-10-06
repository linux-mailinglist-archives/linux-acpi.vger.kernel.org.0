Return-Path: <linux-acpi+bounces-468-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCDC7BBA66
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 16:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67149282282
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 14:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBF226E05
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 14:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BDE1D55B
	for <linux-acpi@vger.kernel.org>; Fri,  6 Oct 2023 13:04:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE012CE;
	Fri,  6 Oct 2023 06:04:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F871C15;
	Fri,  6 Oct 2023 06:05:02 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AFA0D3F641;
	Fri,  6 Oct 2023 06:04:22 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] ACPI: PCC: Updates for v6.7
Date: Fri,  6 Oct 2023 14:04:18 +0100
Message-ID: <20231006130418.659320-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Rafael,

I2C, HWMON and Hisilicon SoC changes are all acked-by respective maintainers.
All the changes are in the linux-next for some time now. Please pull!

Regards,
Sudeep

-->8

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/acpi-pcc-updates-6.7

for you to fetch changes up to a46e42c097982e258f89c64c5f52f30994bcfeda:

  soc: kunpeng_hccs: Migrate to use generic PCC shmem related macros (2023-09-29 11:55:37 +0100)

----------------------------------------------------------------
ACPI: PCC: Mailbox and generic updates for v6.7

Main updates include:
1. Addition of support for Type 4 PCC subspace that enables platform
   notification handling (Huisong Li).
2. Support for the shared interrupt amongst multiple PCC subspaces/
   channels (Huisong Li).
3. Consolidation of PCC shared memory region command and status
   bitfields definitions that were duplicated and scattered across
   multiple PCC client drivers (Sudeep Holla).

----------------------------------------------------------------
Huisong Li (2):
      mailbox: pcc: Add support for platform notification handling
      mailbox: pcc: Support shared interrupt for multiple subspaces

Sudeep Holla (4):
      ACPI: PCC: Add PCC shared memory region command and status bitfields
      i2c: xgene-slimpro: Migrate to use generic PCC shmem related macros
      hwmon: (xgene) Migrate to use generic PCC shmem related macros
      soc: kunpeng_hccs: Migrate to use generic PCC shmem related macros

 drivers/hwmon/xgene-hwmon.c            | 16 ++----
 drivers/i2c/busses/i2c-xgene-slimpro.c | 16 ++----
 drivers/mailbox/pcc.c                  | 91 ++++++++++++++++++++++++++++++----
 drivers/soc/hisilicon/kunpeng_hccs.c   |  8 +--
 include/acpi/pcc.h                     | 13 +++++
 5 files changed, 104 insertions(+), 40 deletions(-)

