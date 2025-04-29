Return-Path: <linux-acpi+bounces-13372-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1BAAA1C0F
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Apr 2025 22:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711B6467F25
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Apr 2025 20:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939C7264F81;
	Tue, 29 Apr 2025 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VlaqrMlb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA8B2620FA;
	Tue, 29 Apr 2025 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745958263; cv=none; b=fi7mK27NO677sOJm1ox+p4w8WPzMB587UTq6ekvKpEoNmm/iqL6SCQmnC58NFYET5FNhBqhKGqTYFyrePATS1M00pZubnZIoEdaNnxZ5IOLnwATVDFUYvB+kSSHg5TPs7Bz3azJcxX9YT9+7bL1zmR4u3Jkv8qHoLY1Y32OVSsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745958263; c=relaxed/simple;
	bh=pTiWjc5obwfd6KjattuPQp58CMusIzJRX+fwlUKvvXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7Y2zJv4RRxavkOj8ILtEvXXWgxMH+SXi6yF9gsw+dEGSXyOVpod4nqNsZ02wI7Ik/T16SiG/NfL2d+vbxSYkGUmpY2KuwHpDnqDDcbAbpI9se4+QV4oP/AqyKFNW8ZariXp+L6D4FsfMLnBWL/ndoqQPKUfXVFiSc9PMeemDSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VlaqrMlb; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745958262; x=1777494262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pTiWjc5obwfd6KjattuPQp58CMusIzJRX+fwlUKvvXY=;
  b=VlaqrMlbppMpE+E4aqcyQg6OHCYRnt0UrYkbGXZkDIfORAXUK14nWhjZ
   xz1f8tCryPTXZ49jV1rGzTV7OKp0pmzZgIOKCNda6iq90VwIC3jFjni0N
   1IEkg5eF8556hfQ+w/B5mmSex3bdlmj2lpOon9FWWkAas51BGLL7sMJ0P
   TSmoxa7w5zAvObqA22NuC1VOks78qpUHVGnTi+QJ8O2Ql66UqBTe2qgoA
   fO8aqEu35o2fa+GaLx7kfN3uBApNXh/kHX+BX+FT1QzvpE2LkzeipaFeM
   Xq4mhc1IjItEyGkF3CnuNsLg/XTwjvHxylwOVbKin7rBCVb3By5Y0HCtX
   Q==;
X-CSE-ConnectionGUID: nIINkZhDRb+f+GplVCn+Og==
X-CSE-MsgGUID: XLjCcSiPR32sUNEGOQvIUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47314071"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="47314071"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 13:24:19 -0700
X-CSE-ConnectionGUID: s8oumlQ0Th6IMaswpYdGHA==
X-CSE-MsgGUID: 6QlcBOYVQFuDjJrr4R7ELQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="139036131"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 13:24:18 -0700
From: Tony Luck <tony.luck@intel.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 2/4] ACPI/MRRM: Minimal parse of ACPI MRRM table
Date: Tue, 29 Apr 2025 13:24:09 -0700
Message-ID: <20250429202412.380637-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429202412.380637-1-tony.luck@intel.com>
References: <20250429202412.380637-1-tony.luck@intel.com>
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
 include/linux/acpi.h     |  9 +++++++++
 drivers/acpi/acpi_mrrm.c | 42 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/Kconfig         |  1 +
 drivers/acpi/Kconfig     |  3 +++
 drivers/acpi/Makefile    |  1 +
 5 files changed, 56 insertions(+)
 create mode 100644 drivers/acpi/acpi_mrrm.c

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 3f2e93ed9730..c409f4cecb09 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -772,6 +772,10 @@ int acpi_get_local_u64_address(acpi_handle handle, u64 *addr);
 int acpi_get_local_address(acpi_handle handle, u32 *addr);
 const char *acpi_get_subsystem_id(acpi_handle handle);
 
+#ifdef CONFIG_ACPI_MRRM
+int acpi_mrrm_max_mem_region(void);
+#endif
+
 #else	/* !CONFIG_ACPI */
 
 #define acpi_disabled 1
@@ -1092,6 +1096,11 @@ static inline acpi_handle acpi_get_processor_handle(int cpu)
 	return NULL;
 }
 
+static inline int acpi_mrrm_max_mem_region(void)
+{
+	return -ENOENT;
+}
+
 #endif	/* !CONFIG_ACPI */
 
 #ifdef CONFIG_ACPI_HMAT
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


