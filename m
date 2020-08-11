Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2BE241EA9
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Aug 2020 18:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgHKQva (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Aug 2020 12:51:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:13475 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729011AbgHKQva (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Aug 2020 12:51:30 -0400
IronPort-SDR: 95JEgdDuObkhRC8yQPI23IqdX44DRescn6b4DiJ4Df7BS4pEXlDzVjkKOFQ5e7iXUo1YYuyd2h
 2VuiWt13tqxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="153747263"
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="153747263"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 09:51:29 -0700
IronPort-SDR: Magi6xytkpCSqYJ8I7LFXk/ZjSl9yak3iJmWs+Nmvqf2RDA/IIA4uDSj8ZfQQvKOhwYJlQxm6R
 r8qknJ9fWkyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="334642462"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 11 Aug 2020 09:51:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id ECFB2FC; Tue, 11 Aug 2020 19:51:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] ACPI / PMIC: Move TPS68470 OpRegion driver to drivers/acpi/pmic/
Date:   Tue, 11 Aug 2020 19:51:26 +0300
Message-Id: <20200811165126.45307-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200811165126.45307-1-andriy.shevchenko@linux.intel.com>
References: <20200811165126.45307-1-andriy.shevchenko@linux.intel.com>
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
index fbf52271d6cb..30552ccb4680 100644
--- a/drivers/acpi/pmic/Kconfig
+++ b/drivers/acpi/pmic/Kconfig
@@ -47,3 +47,19 @@ config CHT_DC_TI_PMIC_OPREGION
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
index 1433f2befca6..6d3f9c971668 100644
--- a/drivers/acpi/pmic/Makefile
+++ b/drivers/acpi/pmic/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_XPOWER_PMIC_OPREGION)	+= pmic/intel_pmic_xpower.o
 obj-$(CONFIG_BXT_WC_PMIC_OPREGION)	+= pmic/intel_pmic_bxtwc.o
 obj-$(CONFIG_CHT_WC_PMIC_OPREGION)	+= pmic/intel_pmic_chtwc.o
 obj-$(CONFIG_CHT_DC_TI_PMIC_OPREGION)	+= pmic/intel_pmic_chtdc_ti.o
+obj-$(CONFIG_TPS68470_PMIC_OPREGION)	+= pmic/tps68470_pmic.o
-- 
2.28.0

