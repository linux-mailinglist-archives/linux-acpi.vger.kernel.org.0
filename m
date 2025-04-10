Return-Path: <linux-acpi+bounces-12958-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEAEA84FAF
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 00:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E864C1747
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 22:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE17D20F088;
	Thu, 10 Apr 2025 22:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CC5pXv0r"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D2A204F81;
	Thu, 10 Apr 2025 22:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744324340; cv=none; b=J5jQwHisk6ODGZXJAkzNC1FX9GTtXYgLf8T9IChtgISs80pH9XvYpoWW4qnIgNQ6UOY4BKUIM0Mdgl/owUS9xua9FrfZv7Z8WlBCY26KzAdbugm+GmA8RGD8b1/J5+lNTdmnyDuszzQHoyVODTvVBigPg622iV2pBFTmcHwvjek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744324340; c=relaxed/simple;
	bh=L13SWnVs57xGYJxgwdRdph1jOjpiAExjEwjPMTGQvbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESBQ0YDvqts76pCy1nY1Sh1hqNUzoY1cQ5C/dM3uBIK+y04F/qO7u8tJCVDed+tt1QpEOB6aOZAdwNz0m6obif/M6s8ZvNa/ukEGVyMysEdx6P/x+bZmhZUabpQlgzpxF01c9kYx9l8yILWvbKZJAvc3f2dp1estj3XKRwvvUbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CC5pXv0r; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744324339; x=1775860339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L13SWnVs57xGYJxgwdRdph1jOjpiAExjEwjPMTGQvbY=;
  b=CC5pXv0r9SkMnqFif59scprTAIBvlOYMLTlNDOnYR2VGinM8ZZC/sNA0
   2AV4XaYXgf5MRoRCnt/Qm2RgHaqT3dXD92aJ4KRBYtllR+Qjp2CdWzNPM
   sOrYamjQvkwHIFe7htzr47jkR1jTODv7/lEhhdKLCWLwA8SYnGvkMB5Vo
   xpGIR9bW0v+bxll4UXPrDMjIOUWqxKUz7kl2VNPOnOsRPioLBMtsQdTJO
   VfYGVIgdlW7OySErPlVrSl7GuaMwrzDqP1B0s3zfuV0U2kxcz0J/Qev6B
   jP3tXYcTiyF+SURvr55t2y0gmlZN06scXW3G4EEkW7mLvHe73MGwVvIzn
   w==;
X-CSE-ConnectionGUID: 5xMJO57hTh+kwtwv9dFuxA==
X-CSE-MsgGUID: adLI8EhNTd6PrBQqPfeekA==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56845632"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="56845632"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 15:32:17 -0700
X-CSE-ConnectionGUID: pI3RrV+xQjOxcURhMsy7Pw==
X-CSE-MsgGUID: LAcaJ0tkQHWmMJCH8X2fRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="128988752"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 15:32:16 -0700
From: Tony Luck <tony.luck@intel.com>
To: rafael.j.wysocki@intel.com
Cc: lenb@kernel.org,
	Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 2/4] ACPI/MRRM: Minimal parse of ACPI MRRM table
Date: Thu, 10 Apr 2025 15:32:05 -0700
Message-ID: <20250410223207.257722-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250410223207.257722-1-tony.luck@intel.com>
References: <20250410223207.257722-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The resctrl file system code needs to know how many region tags
are supported. Parse the ACPI MRRM table and save the max_mem_region
value.

Provide a function for resctrl to collect that value.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/acpi.h     |  6 ++++++
 drivers/acpi/acpi_mrrm.c | 42 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/Kconfig         |  1 +
 drivers/acpi/Kconfig     |  3 +++
 drivers/acpi/Makefile    |  1 +
 5 files changed, 53 insertions(+)
 create mode 100644 drivers/acpi/acpi_mrrm.c

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 3f2e93ed9730..24aa7a0ae272 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -772,6 +772,12 @@ int acpi_get_local_u64_address(acpi_handle handle, u64 *addr);
 int acpi_get_local_address(acpi_handle handle, u32 *addr);
 const char *acpi_get_subsystem_id(acpi_handle handle);
 
+#ifdef CONFIG_ACPI_MRRM
+int acpi_mrrm_max_mem_region(void);
+#else
+static inline int acpi_mrrm_max_mem_region(void) { return -ENOENT; }
+#endif
+
 #else	/* !CONFIG_ACPI */
 
 #define acpi_disabled 1
diff --git a/drivers/acpi/acpi_mrrm.c b/drivers/acpi/acpi_mrrm.c
new file mode 100644
index 000000000000..ab8022e58da5
--- /dev/null
+++ b/drivers/acpi/acpi_mrrm.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025, Intel Corporation.
+ *
+ * Memory Range and Region Mapping (MRRM) structure
+ */
+
+#define pr_fmt(fmt) "acpi/mrrm: " fmt
+
+#include <linux/acpi.h>
+#include <linux/init.h>
+
+static int max_mem_region = -ENOENT;
+
+/* Access for use by resctrl file system */
+int acpi_mrrm_max_mem_region(void)
+{
+	return max_mem_region;
+}
+
+static __init int acpi_parse_mrrm(struct acpi_table_header *table)
+{
+	struct acpi_table_mrrm *mrrm;
+
+	mrrm = (struct acpi_table_mrrm *)table;
+	if (!mrrm)
+		return -ENODEV;
+
+	max_mem_region = mrrm->max_mem_region;
+
+	return 0;
+}
+
+static __init int mrrm_init(void)
+{
+	int ret;
+
+	ret = acpi_table_parse(ACPI_SIG_MRRM, acpi_parse_mrrm);
+
+	return ret;
+}
+device_initcall(mrrm_init);
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4b9f378e05f6..0e43069082df 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -38,6 +38,7 @@ config X86_64
 	select ARCH_HAS_ELFCORE_COMPAT
 	select ZONE_DMA32
 	select EXECMEM if DYNAMIC_FTRACE
+	select ACPI_MRRM if ACPI
 
 config FORCE_DYNAMIC_FTRACE
 	def_bool y
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 7f10aa38269d..7bc40c2735ac 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -576,6 +576,9 @@ config ACPI_FFH
 	  Enable this feature if you want to set up and install the FFH Address
 	  Space handler to handle FFH OpRegion in the firmware.
 
+config ACPI_MRRM
+	bool
+
 source "drivers/acpi/pmic/Kconfig"
 
 config ACPI_VIOT
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 797070fc9a3f..d1b0affb844f 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -66,6 +66,7 @@ acpi-$(CONFIG_ACPI_WATCHDOG)	+= acpi_watchdog.o
 acpi-$(CONFIG_ACPI_PRMT)	+= prmt.o
 acpi-$(CONFIG_ACPI_PCC)		+= acpi_pcc.o
 acpi-$(CONFIG_ACPI_FFH)		+= acpi_ffh.o
+acpi-$(CONFIG_ACPI_MRRM)	+= acpi_mrrm.o
 
 # Address translation
 acpi-$(CONFIG_ACPI_ADXL)	+= acpi_adxl.o
-- 
2.48.1


