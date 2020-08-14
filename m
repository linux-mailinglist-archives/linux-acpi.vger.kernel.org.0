Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D5B244A61
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Aug 2020 15:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgHNN1a (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Aug 2020 09:27:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:52380 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgHNN1a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Aug 2020 09:27:30 -0400
IronPort-SDR: hyliyXcjhVy0myK25VXG5/imfhRTlTAOe3DArue5aSpJRkE89PgL7GclLldPaDbGknxK4Pgc2m
 ZfStHMFfJPbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="155508523"
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; 
   d="scan'208";a="155508523"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 06:27:29 -0700
IronPort-SDR: +icVMSf6RlHWc3M34U854sgttJdn5utgIrepnfHLBtLdFyeWAbMK0g/YMjIxTgilQoBVRDa9RE
 aIiukyp1u5jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; 
   d="scan'208";a="327883168"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 14 Aug 2020 06:27:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 34618163; Fri, 14 Aug 2020 16:27:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] ACPI / PMIC: Split out Kconfig and Makefile specific for ACPI PMIC
Date:   Fri, 14 Aug 2020 16:27:25 +0300
Message-Id: <20200814132726.11456-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It's a bit better to maintain and allows to avoid mistakes in the future
with PMIC OpRegion drivers, if we split out Kconfig and Makefile
for ACPI PMIC to its own folder.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed build error (lkp@intel.com)
 drivers/acpi/Kconfig       | 51 ++------------------------------------
 drivers/acpi/Makefile      |  9 +------
 drivers/acpi/pmic/Kconfig  | 51 ++++++++++++++++++++++++++++++++++++++
 drivers/acpi/pmic/Makefile |  9 +++++++
 4 files changed, 63 insertions(+), 57 deletions(-)
 create mode 100644 drivers/acpi/pmic/Kconfig
 create mode 100644 drivers/acpi/pmic/Makefile

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 7540a5179a47..6fb9453396dc 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -504,55 +504,6 @@ config ACPI_EXTLOG
 config ACPI_ADXL
 	bool
 
-menuconfig PMIC_OPREGION
-	bool "PMIC (Power Management Integrated Circuit) operation region support"
-	help
-	  Select this option to enable support for ACPI operation
-	  region of the PMIC chip. The operation region can be used
-	  to control power rails and sensor reading/writing on the
-	  PMIC chip.
-
-if PMIC_OPREGION
-config BYTCRC_PMIC_OPREGION
-	bool "ACPI operation region support for Bay Trail Crystal Cove PMIC"
-	depends on INTEL_SOC_PMIC
-	help
-	  This config adds ACPI operation region support for the Bay Trail
-	  version of the Crystal Cove PMIC.
-
-config CHTCRC_PMIC_OPREGION
-	bool "ACPI operation region support for Cherry Trail Crystal Cove PMIC"
-	depends on INTEL_SOC_PMIC
-	help
-	  This config adds ACPI operation region support for the Cherry Trail
-	  version of the Crystal Cove PMIC.
-
-config XPOWER_PMIC_OPREGION
-	bool "ACPI operation region support for XPower AXP288 PMIC"
-	depends on MFD_AXP20X_I2C && IOSF_MBI=y
-	help
-	  This config adds ACPI operation region support for XPower AXP288 PMIC.
-
-config BXT_WC_PMIC_OPREGION
-	bool "ACPI operation region support for BXT WhiskeyCove PMIC"
-	depends on INTEL_SOC_PMIC_BXTWC
-	help
-	  This config adds ACPI operation region support for BXT WhiskeyCove PMIC.
-
-config CHT_WC_PMIC_OPREGION
-	bool "ACPI operation region support for CHT Whiskey Cove PMIC"
-	depends on INTEL_SOC_PMIC_CHTWC
-	help
-	  This config adds ACPI operation region support for CHT Whiskey Cove PMIC.
-
-config CHT_DC_TI_PMIC_OPREGION
-	bool "ACPI operation region support for Dollar Cove TI PMIC"
-	depends on INTEL_SOC_PMIC_CHTDC_TI
-	help
-	  This config adds ACPI operation region support for Dollar Cove TI PMIC.
-
-endif
-
 config ACPI_CONFIGFS
 	tristate "ACPI configfs support"
 	select CONFIGFS_FS
@@ -568,6 +519,8 @@ config ACPI_PPTT
 	bool
 endif
 
+source "drivers/acpi/pmic/Kconfig"
+
 config TPS68470_PMIC_OPREGION
 	bool "ACPI operation region support for TPS68470 PMIC"
 	depends on MFD_TPS68470
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 9a957544e357..44929d248bfa 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -107,16 +107,9 @@ obj-$(CONFIG_ACPI_APEI)		+= apei/
 
 obj-$(CONFIG_ACPI_EXTLOG)	+= acpi_extlog.o
 
-obj-$(CONFIG_PMIC_OPREGION)	+= pmic/intel_pmic.o
-obj-$(CONFIG_BYTCRC_PMIC_OPREGION) += pmic/intel_pmic_bytcrc.o
-obj-$(CONFIG_CHTCRC_PMIC_OPREGION) += pmic/intel_pmic_chtcrc.o
-obj-$(CONFIG_XPOWER_PMIC_OPREGION) += pmic/intel_pmic_xpower.o
-obj-$(CONFIG_BXT_WC_PMIC_OPREGION) += pmic/intel_pmic_bxtwc.o
-obj-$(CONFIG_CHT_WC_PMIC_OPREGION) += pmic/intel_pmic_chtwc.o
-obj-$(CONFIG_CHT_DC_TI_PMIC_OPREGION) += pmic/intel_pmic_chtdc_ti.o
-
 obj-$(CONFIG_ACPI_CONFIGFS)	+= acpi_configfs.o
 
+obj-y				+= pmic/
 obj-$(CONFIG_TPS68470_PMIC_OPREGION)	+= pmic/tps68470_pmic.o
 
 video-objs			+= acpi_video.o video_detect.o
diff --git a/drivers/acpi/pmic/Kconfig b/drivers/acpi/pmic/Kconfig
new file mode 100644
index 000000000000..357d1a846e68
--- /dev/null
+++ b/drivers/acpi/pmic/Kconfig
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menuconfig PMIC_OPREGION
+	bool "PMIC (Power Management Integrated Circuit) operation region support"
+	help
+	  Select this option to enable support for ACPI operation
+	  region of the PMIC chip. The operation region can be used
+	  to control power rails and sensor reading/writing on the
+	  PMIC chip.
+
+if PMIC_OPREGION
+
+config BYTCRC_PMIC_OPREGION
+	bool "ACPI operation region support for Bay Trail Crystal Cove PMIC"
+	depends on INTEL_SOC_PMIC
+	help
+	  This config adds ACPI operation region support for the Bay Trail
+	  version of the Crystal Cove PMIC.
+
+config CHTCRC_PMIC_OPREGION
+	bool "ACPI operation region support for Cherry Trail Crystal Cove PMIC"
+	depends on INTEL_SOC_PMIC
+	help
+	  This config adds ACPI operation region support for the Cherry Trail
+	  version of the Crystal Cove PMIC.
+
+config XPOWER_PMIC_OPREGION
+	bool "ACPI operation region support for XPower AXP288 PMIC"
+	depends on MFD_AXP20X_I2C && IOSF_MBI=y
+	help
+	  This config adds ACPI operation region support for XPower AXP288 PMIC.
+
+config BXT_WC_PMIC_OPREGION
+	bool "ACPI operation region support for BXT WhiskeyCove PMIC"
+	depends on INTEL_SOC_PMIC_BXTWC
+	help
+	  This config adds ACPI operation region support for BXT WhiskeyCove PMIC.
+
+config CHT_WC_PMIC_OPREGION
+	bool "ACPI operation region support for CHT Whiskey Cove PMIC"
+	depends on INTEL_SOC_PMIC_CHTWC
+	help
+	  This config adds ACPI operation region support for CHT Whiskey Cove PMIC.
+
+config CHT_DC_TI_PMIC_OPREGION
+	bool "ACPI operation region support for Dollar Cove TI PMIC"
+	depends on INTEL_SOC_PMIC_CHTDC_TI
+	help
+	  This config adds ACPI operation region support for Dollar Cove TI PMIC.
+
+endif	# PMIC_OPREGION
diff --git a/drivers/acpi/pmic/Makefile b/drivers/acpi/pmic/Makefile
new file mode 100644
index 000000000000..773c267420bc
--- /dev/null
+++ b/drivers/acpi/pmic/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_PMIC_OPREGION)		+= intel_pmic.o
+obj-$(CONFIG_BYTCRC_PMIC_OPREGION)	+= intel_pmic_bytcrc.o
+obj-$(CONFIG_CHTCRC_PMIC_OPREGION)	+= intel_pmic_chtcrc.o
+obj-$(CONFIG_XPOWER_PMIC_OPREGION)	+= intel_pmic_xpower.o
+obj-$(CONFIG_BXT_WC_PMIC_OPREGION)	+= intel_pmic_bxtwc.o
+obj-$(CONFIG_CHT_WC_PMIC_OPREGION)	+= intel_pmic_chtwc.o
+obj-$(CONFIG_CHT_DC_TI_PMIC_OPREGION)	+= intel_pmic_chtdc_ti.o
-- 
2.28.0

