Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF89244A60
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Aug 2020 15:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgHNN1a (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Aug 2020 09:27:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:48463 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgHNN13 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Aug 2020 09:27:29 -0400
IronPort-SDR: cA3qU9E7CK31GJ37OLrTJ1QdFDeggwc+Dvua59sM843efa/XzIy/iF+E206OsqUIid+6FvS15v
 pNptsRbaCVeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="133924934"
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; 
   d="scan'208";a="133924934"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 06:27:29 -0700
IronPort-SDR: mEpv10o4cexyjZe5ePrOG9t4u0xglepB8A7iqVwDYAs9LlmYR0M9xgTgmavGyeVhG/3rBbpO64
 JniSXImCAqsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; 
   d="scan'208";a="278396428"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 14 Aug 2020 06:27:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3D0E015D; Fri, 14 Aug 2020 16:27:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/2] ACPI / PMIC: Move TPS68470 OpRegion driver to drivers/acpi/pmic/
Date:   Fri, 14 Aug 2020 16:27:26 +0300
Message-Id: <20200814132726.11456-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200814132726.11456-1-andriy.shevchenko@linux.intel.com>
References: <20200814132726.11456-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It is revealed now that TPS68470 OpRegion driver has been added
in slightly different scope. Let's move it to the drivers/acpi/pmic/
folder for sake of the unification.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed build error (lkp@intel.com)

 drivers/acpi/Kconfig       | 16 ----------------
 drivers/acpi/Makefile      |  1 -
 drivers/acpi/pmic/Kconfig  | 16 ++++++++++++++++
 drivers/acpi/pmic/Makefile |  1 +
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 6fb9453396dc..edf1558c1105 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -521,22 +521,6 @@ endif
 
 source "drivers/acpi/pmic/Kconfig"
 
-config TPS68470_PMIC_OPREGION
-	bool "ACPI operation region support for TPS68470 PMIC"
-	depends on MFD_TPS68470
-	help
-	  This config adds ACPI operation region support for TI TPS68470 PMIC.
-	  TPS68470 device is an advanced power management unit that powers
-	  a Compact Camera Module (CCM), generates clocks for image sensors,
-	  drives a dual LED for flash and incorporates two LED drivers for
-	  general purpose indicators.
-	  This driver enables ACPI operation region support control voltage
-	  regulators and clocks.
-
-	  This option is a bool as it provides an ACPI operation
-	  region, which must be available before any of the devices
-	  using this, are probed.
-
 endif	# ACPI
 
 config X86_PM_TIMER
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 44929d248bfa..44e412506317 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -110,7 +110,6 @@ obj-$(CONFIG_ACPI_EXTLOG)	+= acpi_extlog.o
 obj-$(CONFIG_ACPI_CONFIGFS)	+= acpi_configfs.o
 
 obj-y				+= pmic/
-obj-$(CONFIG_TPS68470_PMIC_OPREGION)	+= pmic/tps68470_pmic.o
 
 video-objs			+= acpi_video.o video_detect.o
 obj-y				+= dptf/
diff --git a/drivers/acpi/pmic/Kconfig b/drivers/acpi/pmic/Kconfig
index 357d1a846e68..56bbcb2ce61b 100644
--- a/drivers/acpi/pmic/Kconfig
+++ b/drivers/acpi/pmic/Kconfig
@@ -49,3 +49,19 @@ config CHT_DC_TI_PMIC_OPREGION
 	  This config adds ACPI operation region support for Dollar Cove TI PMIC.
 
 endif	# PMIC_OPREGION
+
+config TPS68470_PMIC_OPREGION
+	bool "ACPI operation region support for TPS68470 PMIC"
+	depends on MFD_TPS68470
+	help
+	  This config adds ACPI operation region support for TI TPS68470 PMIC.
+	  TPS68470 device is an advanced power management unit that powers
+	  a Compact Camera Module (CCM), generates clocks for image sensors,
+	  drives a dual LED for flash and incorporates two LED drivers for
+	  general purpose indicators.
+	  This driver enables ACPI operation region support control voltage
+	  regulators and clocks.
+
+	  This option is a bool as it provides an ACPI operation
+	  region, which must be available before any of the devices
+	  using this, are probed.
diff --git a/drivers/acpi/pmic/Makefile b/drivers/acpi/pmic/Makefile
index 773c267420bc..cd072c64920c 100644
--- a/drivers/acpi/pmic/Makefile
+++ b/drivers/acpi/pmic/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_XPOWER_PMIC_OPREGION)	+= intel_pmic_xpower.o
 obj-$(CONFIG_BXT_WC_PMIC_OPREGION)	+= intel_pmic_bxtwc.o
 obj-$(CONFIG_CHT_WC_PMIC_OPREGION)	+= intel_pmic_chtwc.o
 obj-$(CONFIG_CHT_DC_TI_PMIC_OPREGION)	+= intel_pmic_chtdc_ti.o
+obj-$(CONFIG_TPS68470_PMIC_OPREGION)	+= tps68470_pmic.o
-- 
2.28.0

