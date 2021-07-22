Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172883D2CD2
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jul 2021 21:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhGVSxz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Jul 2021 14:53:55 -0400
Received: from mga18.intel.com ([134.134.136.126]:46682 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229585AbhGVSxz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Jul 2021 14:53:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="198995770"
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="198995770"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 12:34:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="577417126"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jul 2021 12:34:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7006FE7; Thu, 22 Jul 2021 22:34:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v1 1/1] clk: x86: Rename clk-lpt to more specific clk-lpss-atom
Date:   Thu, 22 Jul 2021 22:34:50 +0300
Message-Id: <20210722193450.35321-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The LPT stands for Lynxpoint PCH. However the driver is used on a few
Intel Atom SoCs. Rename it to reflect this in a way how another clock
driver, i.e. clk-pmc-atom, is called.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Good to go either via ACPI or CCF tree.

 drivers/acpi/acpi_lpss.c                       |  6 ++++--
 drivers/clk/x86/Makefile                       |  2 +-
 drivers/clk/x86/{clk-lpt.c => clk-lpss-atom.c} | 12 ++++++------
 include/linux/platform_data/x86/clk-lpss.h     |  2 +-
 4 files changed, 12 insertions(+), 10 deletions(-)
 rename drivers/clk/x86/{clk-lpt.c => clk-lpss-atom.c} (76%)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 894b7e6ae144..7f163074e4e4 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -385,7 +385,9 @@ static struct platform_device *lpss_clk_dev;
 
 static inline void lpt_register_clock_device(void)
 {
-	lpss_clk_dev = platform_device_register_simple("clk-lpt", -1, NULL, 0);
+	lpss_clk_dev = platform_device_register_simple("clk-lpss-atom",
+						       PLATFORM_DEVID_NONE,
+						       NULL, 0);
 }
 
 static int register_device_clock(struct acpi_device *adev,
@@ -1337,7 +1339,7 @@ void __init acpi_lpss_init(void)
 	const struct x86_cpu_id *id;
 	int ret;
 
-	ret = lpt_clk_init();
+	ret = lpss_atom_clk_init();
 	if (ret)
 		return;
 
diff --git a/drivers/clk/x86/Makefile b/drivers/clk/x86/Makefile
index 18564efdc651..1244c4e568ff 100644
--- a/drivers/clk/x86/Makefile
+++ b/drivers/clk/x86/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_PMC_ATOM)		+= clk-pmc-atom.o
 obj-$(CONFIG_X86_AMD_PLATFORM_DEVICE)	+= clk-fch.o
-clk-x86-lpss-objs		:= clk-lpt.o
+clk-x86-lpss-y			:= clk-lpss-atom.o
 obj-$(CONFIG_X86_INTEL_LPSS)	+= clk-x86-lpss.o
 obj-$(CONFIG_CLK_LGM_CGU)	+= clk-cgu.o clk-cgu-pll.o clk-lgm.o
diff --git a/drivers/clk/x86/clk-lpt.c b/drivers/clk/x86/clk-lpss-atom.c
similarity index 76%
rename from drivers/clk/x86/clk-lpt.c
rename to drivers/clk/x86/clk-lpss-atom.c
index fbe9fd3ed948..aa9d0bb98f8b 100644
--- a/drivers/clk/x86/clk-lpt.c
+++ b/drivers/clk/x86/clk-lpss-atom.c
@@ -13,7 +13,7 @@
 #include <linux/platform_data/x86/clk-lpss.h>
 #include <linux/platform_device.h>
 
-static int lpt_clk_probe(struct platform_device *pdev)
+static int lpss_atom_clk_probe(struct platform_device *pdev)
 {
 	struct lpss_clk_data *drvdata;
 	struct clk *clk;
@@ -34,14 +34,14 @@ static int lpt_clk_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver lpt_clk_driver = {
+static struct platform_driver lpss_atom_clk_driver = {
 	.driver = {
-		.name = "clk-lpt",
+		.name = "clk-lpss-atom",
 	},
-	.probe = lpt_clk_probe,
+	.probe = lpss_atom_clk_probe,
 };
 
-int __init lpt_clk_init(void)
+int __init lpss_atom_clk_init(void)
 {
-	return platform_driver_register(&lpt_clk_driver);
+	return platform_driver_register(&lpss_atom_clk_driver);
 }
diff --git a/include/linux/platform_data/x86/clk-lpss.h b/include/linux/platform_data/x86/clk-lpss.h
index 207e1a317800..41df326583f9 100644
--- a/include/linux/platform_data/x86/clk-lpss.h
+++ b/include/linux/platform_data/x86/clk-lpss.h
@@ -15,6 +15,6 @@ struct lpss_clk_data {
 	struct clk *clk;
 };
 
-extern int lpt_clk_init(void);
+extern int lpss_atom_clk_init(void);
 
 #endif /* __CLK_LPSS_H */
-- 
2.30.2

