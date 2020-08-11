Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E86241EAA
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Aug 2020 18:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgHKQvb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Aug 2020 12:51:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:54235 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728962AbgHKQva (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Aug 2020 12:51:30 -0400
IronPort-SDR: 2+6WQHTXySeqijjDrbHzXeeSAOFyJwfGwi/M1Q9E/4/Qyo+p/KwOT8QEK7o2TW7iY6qUAgmp/p
 DeKvsSXN8m9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="151446640"
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="151446640"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 09:51:29 -0700
IronPort-SDR: sSHW3Eq/BHVFJ+7cxph0GpWMj0gKFKXPkzmQ6B0JDvsZ4nkmgUye4ep/F+kuN7RxGrN+KZYQ4n
 Tz64AgARr3AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="469503894"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 11 Aug 2020 09:51:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E24B115C; Tue, 11 Aug 2020 19:51:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] ACPI / PMIC: Split out Kconfig and Makefile specific for ACPI PMIC
Date:   Tue, 11 Aug 2020 19:51:25 +0300
Message-Id: <20200811165126.45307-1-andriy.shevchenko@linux.intel.com>
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
 drivers/acpi/Kconfig       | 51 ++------------------------------------
 drivers/acpi/Makefile      |  9 +------
 drivers/acpi/pmic/Kconfig  | 49 ++++++++++++++++++++++++++++++++++++
 drivers/acpi/pmic/Makefile |  8 ++++++
 4 files changed, 60 insertions(+), 57 deletions(-)
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
index 000000000000..fbf52271d6cb
--- /dev/null
+++ b/drivers/acpi/pmic/Kconfig
@@ -0,0 +1,49 @@
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
index 000000000000..1433f2befca6
--- /dev/null
+++ b/drivers/acpi/pmic/Makefile
@@ -0,0 +1,8 @@
+
+obj-$(CONFIG_PMIC_OPREGION)	+= pmic/intel_pmic.o
+obj-$(CONFIG_BYTCRC_PMIC_OPREGION)	+= pmic/intel_pmic_bytcrc.o
+obj-$(CONFIG_CHTCRC_PMIC_OPREGION)	+= pmic/intel_pmic_chtcrc.o
+obj-$(CONFIG_XPOWER_PMIC_OPREGION)	+= pmic/intel_pmic_xpower.o
+obj-$(CONFIG_BXT_WC_PMIC_OPREGION)	+= pmic/intel_pmic_bxtwc.o
+obj-$(CONFIG_CHT_WC_PMIC_OPREGION)	+= pmic/intel_pmic_chtwc.o
+obj-$(CONFIG_CHT_DC_TI_PMIC_OPREGION)	+= pmic/intel_pmic_chtdc_ti.o
-- 
2.28.0

