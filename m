Return-Path: <linux-acpi+bounces-13465-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 740EEAA9AD2
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 19:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F8C3A4E49
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 17:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D399926D4C3;
	Mon,  5 May 2025 17:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cRtdpktA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7C5267B9F;
	Mon,  5 May 2025 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746466711; cv=none; b=AJ+T+SQC1EvLsfkj9L/dnz/DvvGOfeJUU+mKKQ8+70QtpfJ6J9PItoS2HGxPZ9eALMx0aphvQhPmQo4Yqi7F9ieJKqDd669QAKbJ0mb3bUebDpEjxbXZ9ONg8jM9ATJ2ZysndJMI61QKms/gNCPSMCg0yT7D0eGfOvaDi+jzBDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746466711; c=relaxed/simple;
	bh=41mM4CeORGI8LL+e/0a3kHADBGZX0dr9szgl004zu90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8GwJx2Pi4b4IPbaNKMR9LObvxTCVYuI8hRujPW6OFE5cJWgRkKtLmy0Fq1kDMuiS8DMVybpgvbk8/s50rzgXAwZxcEOegmJX/plIhnB9GBm5CcjDvO6rG8ilXhuZ62REr17EH4/x2svj6WNyV/wmYpXC8yeRrdoVZwOY3rryK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cRtdpktA; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746466710; x=1778002710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=41mM4CeORGI8LL+e/0a3kHADBGZX0dr9szgl004zu90=;
  b=cRtdpktA5nfybYBV4fk7RwoKA86FpnGb10HNNHH+9aoIwlS3VV5O2EL0
   NS02/MZpdCrhD8Vzf32lAX9sMmibZGVa0wrf1Bx3bClT0Se3iQKnQQfkm
   oO45WoCvLpjgL+2hSgBKC70G75ozV+Q5qfGig5cRRJtZ9K3qqLgWvCWh+
   hC2f4VXanIdE95QYRTjAM3mjfBi9uP1sb3hh/D8ktSSiPPUHfOFDUccc5
   kKt4wTtU2BDOdsEOygNf+uYLvyTgCrH6UZMzSO7rZkxzmkTVCrb6KN/VV
   0SIQ+jus+wCVJsdI4uexGXSqp3Z0G2wOLu/Fjccd35RUEU++xIH3d2Dgt
   w==;
X-CSE-ConnectionGUID: kzr9ms/3RSGU5hCivcejTQ==
X-CSE-MsgGUID: zR+cm7HaQpeytHV/YMG4Jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="47991515"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="47991515"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 10:38:27 -0700
X-CSE-ConnectionGUID: ZzpzMPuURhmahaMeavlM8g==
X-CSE-MsgGUID: X733MOeWTcGpLVCis5/v0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="140092226"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 10:38:27 -0700
From: Tony Luck <tony.luck@intel.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v5 1/3] ACPI/MRRM: Minimal parse of ACPI MRRM table
Date: Mon,  5 May 2025 10:38:17 -0700
Message-ID: <20250505173819.419271-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250505173819.419271-1-tony.luck@intel.com>
References: <20250505173819.419271-1-tony.luck@intel.com>
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
index fc372bbaa547..f2d8579de539 100644
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


