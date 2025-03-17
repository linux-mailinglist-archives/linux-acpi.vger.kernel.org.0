Return-Path: <linux-acpi+bounces-12291-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0573A64B19
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Mar 2025 11:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21D51704D0
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Mar 2025 10:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D63235C15;
	Mon, 17 Mar 2025 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="FV/2i076"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A190230BF2
	for <linux-acpi@vger.kernel.org>; Mon, 17 Mar 2025 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208927; cv=none; b=lAidkeJAsB4catSTInZGFGfUe2aWgNBiLj5RaT1W6Cgcu8xo0BetADz9wqf3dM0upc2Xyk2dCw0JrolI1xbvkW3IGfq3spWhbJhVzAqNUpNa73N34cRFzL9h2zbJ5C1gzlQ4R1A98sT9hZen23UvbujJ6lXXYkjvlODA55jQbyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208927; c=relaxed/simple;
	bh=nYqbhzy08/BbGO7iTOBd4DqRFDDemBXibNtuPrksK90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jyBtwQA7qV5G0Sv4tsA3miovBeVgKkLhaHxxoDdGSMGNGKH8zWaLTzgxxhe4E94og3oV+7BWuOAaKAGqCdN+ZQ9Y0AZs9Hp5JaalNHGmEUA/YUwSVlEFEPPHglRKQSSuBw/wmX+uoOynRn6Gj6aXTE52DTXwVBb9abcXpMMq+/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=FV/2i076; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250317105516a66db771cf77094ca5
        for <linux-acpi@vger.kernel.org>;
        Mon, 17 Mar 2025 11:55:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=xcTL4ykm16rd9CR7TKPQcrCBtBBgw/s6FbMlGco/TJA=;
 b=FV/2i076NVk6j1gkMZc7+90hlIDhrk3RqqufmCOgYFjbkDOLkU8FmWJTQyT8CmoBpZYjwa
 f4hWUhiJ8qNcLM0Tpy389uRsOnO6U4qwA0Z9foxUEWGV4MsD0bie02DxB1IbRVX+ayoO827u
 OuX9aXvz4e0ZDzWCAYWe/SPl5fLXvJeX8M2M9ujCBIj8pGywWryrYGsZdVbwhN1GnIW+gJFa
 c1sUyDGJB7FKza3cdgv1+M1Y6Jz7jTyTCjgCwnCSVp+Y0M6X20o+hE88C6F4pzH0GAWz2xa6
 /hoRsjq9KZelLn9wFU/5odWXTqXApVC7gY7jH6ggB6g9V2i/tUshULoQ==;
From: Diogo Ivo <diogo.ivo@siemens.com>
Date: Mon, 17 Mar 2025 10:55:06 +0000
Subject: [PATCH v3 1/2] watchdog: Add driver for Intel OC WDT
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-ivo-intel_oc_wdt-v3-1-32c396f4eefd@siemens.com>
References: <20250317-ivo-intel_oc_wdt-v3-0-32c396f4eefd@siemens.com>
In-Reply-To: <20250317-ivo-intel_oc_wdt-v3-0-32c396f4eefd@siemens.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, jan.kiszka@siemens.com, 
 benedikt.niedermayr@siemens.com, Diogo Ivo <diogo.ivo@siemens.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742208915; l=9052;
 i=diogo.ivo@siemens.com; s=20240529; h=from:subject:message-id;
 bh=nYqbhzy08/BbGO7iTOBd4DqRFDDemBXibNtuPrksK90=;
 b=mEbCDvhRWQ4V+HOJmuW7mOHZUCb36l5zydimVqyBTkYyulNd2ewq7y4L6MrrX330d9djvIAeU
 eM7CqWwcfkpD77xhXEoxip/FIEoBQps3YZXj47nE2kpeSi+DvoVcXds
X-Developer-Key: i=diogo.ivo@siemens.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328357:519-21489:flowmailer

Add a driver for the Intel Over-Clocking Watchdog found in Intel
Platform Controller (PCH) chipsets. This watchdog is controlled
via a simple single-register interface and would otherwise be
standard except for the presence of a LOCK bit that can only be
set once per power cycle, needing extra handling around it.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
v2->v3:
 - Collect R-b from Guenter

v1->v2:
 - Split v1 into two patches, adding the ACPI IDs in a separate patch
 - Initialize hearbeat module parameter to zero
 - Clarify wording around lock handling
 - Properly print resource with %pR when failing to obtain it
 - Enable compile testing and add dependency on HAS_IOPORT
 - Drop unneeded ACPI_PTR() and MODULE_ALIAS()
---
---
 drivers/watchdog/Kconfig        |  11 ++
 drivers/watchdog/Makefile       |   1 +
 drivers/watchdog/intel_oc_wdt.c | 233 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 245 insertions(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index f81705f8539aa0b12d156a86aae521aa40b4527d..94d058c6c49a19f8fee97d82ceb653b60d1944cd 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1350,6 +1350,17 @@ config INTEL_MID_WATCHDOG
 
 	  To compile this driver as a module, choose M here.
 
+config INTEL_OC_WATCHDOG
+	tristate "Intel OC Watchdog"
+	depends on (X86 || COMPILE_TEST) && ACPI && HAS_IOPORT
+	select WATCHDOG_CORE
+	help
+	  Hardware driver for Intel Over-Clocking watchdog present in
+	  Platform Controller Hub (PCH) chipsets.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called intel_oc_wdt.
+
 config ITCO_WDT
 	tristate "Intel TCO Timer/Watchdog"
 	depends on X86 && PCI
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 8411626fa162268e8ccd06349f7193b15a9d281a..3a13f3e80a0f460b99b4f1592fcf17cc6428876b 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -149,6 +149,7 @@ obj-$(CONFIG_W83977F_WDT) += w83977f_wdt.o
 obj-$(CONFIG_MACHZ_WDT) += machzwd.o
 obj-$(CONFIG_SBC_EPX_C3_WATCHDOG) += sbc_epx_c3.o
 obj-$(CONFIG_INTEL_MID_WATCHDOG) += intel-mid_wdt.o
+obj-$(CONFIG_INTEL_OC_WATCHDOG) += intel_oc_wdt.o
 obj-$(CONFIG_INTEL_MEI_WDT) += mei_wdt.o
 obj-$(CONFIG_NI903X_WDT) += ni903x_wdt.o
 obj-$(CONFIG_NIC7018_WDT) += nic7018_wdt.o
diff --git a/drivers/watchdog/intel_oc_wdt.c b/drivers/watchdog/intel_oc_wdt.c
new file mode 100644
index 0000000000000000000000000000000000000000..7c0551106981b08f9e1d2eab8f3ddce99a2462aa
--- /dev/null
+++ b/drivers/watchdog/intel_oc_wdt.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel OC Watchdog driver
+ *
+ * Copyright (C) 2025, Siemens
+ * Author: Diogo Ivo <diogo.ivo@siemens.com>
+ */
+
+#define DRV_NAME	"intel_oc_wdt"
+
+#include <linux/acpi.h>
+#include <linux/bits.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/platform_device.h>
+#include <linux/watchdog.h>
+
+#define INTEL_OC_WDT_TOV		GENMASK(9, 0)
+#define INTEL_OC_WDT_MIN_TOV		1
+#define INTEL_OC_WDT_MAX_TOV		1024
+#define INTEL_OC_WDT_DEF_TOV		60
+
+/*
+ * One-time writable lock bit. If set forbids
+ * modification of itself, _TOV and _EN until
+ * next reboot.
+ */
+#define INTEL_OC_WDT_CTL_LCK		BIT(12)
+
+#define INTEL_OC_WDT_EN			BIT(14)
+#define INTEL_OC_WDT_NO_ICCSURV_STS	BIT(24)
+#define INTEL_OC_WDT_ICCSURV_STS	BIT(25)
+#define INTEL_OC_WDT_RLD		BIT(31)
+
+#define INTEL_OC_WDT_STS_BITS (INTEL_OC_WDT_NO_ICCSURV_STS | \
+			       INTEL_OC_WDT_ICCSURV_STS)
+
+#define INTEL_OC_WDT_CTRL_REG(wdt)	((wdt)->ctrl_res->start)
+
+struct intel_oc_wdt {
+	struct watchdog_device wdd;
+	struct resource *ctrl_res;
+	bool locked;
+};
+
+static int heartbeat;
+module_param(heartbeat, uint, 0);
+MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds. (default="
+		 __MODULE_STRING(WDT_HEARTBEAT) ")");
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+static int intel_oc_wdt_start(struct watchdog_device *wdd)
+{
+	struct intel_oc_wdt *oc_wdt = watchdog_get_drvdata(wdd);
+
+	if (oc_wdt->locked)
+		return 0;
+
+	outl(inl(INTEL_OC_WDT_CTRL_REG(oc_wdt)) | INTEL_OC_WDT_EN,
+	     INTEL_OC_WDT_CTRL_REG(oc_wdt));
+
+	return 0;
+}
+
+static int intel_oc_wdt_stop(struct watchdog_device *wdd)
+{
+	struct intel_oc_wdt *oc_wdt = watchdog_get_drvdata(wdd);
+
+	outl(inl(INTEL_OC_WDT_CTRL_REG(oc_wdt)) & ~INTEL_OC_WDT_EN,
+	     INTEL_OC_WDT_CTRL_REG(oc_wdt));
+
+	return 0;
+}
+
+static int intel_oc_wdt_ping(struct watchdog_device *wdd)
+{
+	struct intel_oc_wdt *oc_wdt = watchdog_get_drvdata(wdd);
+
+	outl(inl(INTEL_OC_WDT_CTRL_REG(oc_wdt)) | INTEL_OC_WDT_RLD,
+	     INTEL_OC_WDT_CTRL_REG(oc_wdt));
+
+	return 0;
+}
+
+static int intel_oc_wdt_set_timeout(struct watchdog_device *wdd,
+				    unsigned int t)
+{
+	struct intel_oc_wdt *oc_wdt = watchdog_get_drvdata(wdd);
+
+	outl((inl(INTEL_OC_WDT_CTRL_REG(oc_wdt)) & ~INTEL_OC_WDT_TOV) | (t - 1),
+	     INTEL_OC_WDT_CTRL_REG(oc_wdt));
+
+	wdd->timeout = t;
+
+	return 0;
+}
+
+static const struct watchdog_info intel_oc_wdt_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
+	.identity = DRV_NAME,
+};
+
+static const struct watchdog_ops intel_oc_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = intel_oc_wdt_start,
+	.stop = intel_oc_wdt_stop,
+	.ping = intel_oc_wdt_ping,
+	.set_timeout = intel_oc_wdt_set_timeout,
+};
+
+static int intel_oc_wdt_setup(struct intel_oc_wdt *oc_wdt)
+{
+	struct watchdog_info *info;
+	unsigned long val;
+
+	val = inl(INTEL_OC_WDT_CTRL_REG(oc_wdt));
+
+	if (val & INTEL_OC_WDT_STS_BITS)
+		oc_wdt->wdd.bootstatus |= WDIOF_CARDRESET;
+
+	oc_wdt->locked = !!(val & INTEL_OC_WDT_CTL_LCK);
+
+	if (val & INTEL_OC_WDT_EN) {
+		/*
+		 * No need to issue a ping here to "commit" the new timeout
+		 * value to hardware as the watchdog core schedules one
+		 * immediately when registering the watchdog.
+		 */
+		set_bit(WDOG_HW_RUNNING, &oc_wdt->wdd.status);
+
+		if (oc_wdt->locked) {
+			info = (struct watchdog_info *)&intel_oc_wdt_info;
+			/*
+			 * Set nowayout unconditionally as we cannot stop
+			 * the watchdog.
+			 */
+			nowayout = true;
+			/*
+			 * If we are locked read the current timeout value
+			 * and inform the core we can't change it.
+			 */
+			oc_wdt->wdd.timeout = (val & INTEL_OC_WDT_TOV) + 1;
+			info->options &= ~WDIOF_SETTIMEOUT;
+
+			dev_info(oc_wdt->wdd.parent,
+				 "Register access locked, heartbeat fixed at: %u s\n",
+				 oc_wdt->wdd.timeout);
+		}
+	} else if (oc_wdt->locked) {
+		/*
+		 * In case the watchdog is disabled and locked there
+		 * is nothing we can do with it so just fail probing.
+		 */
+		return -EACCES;
+	}
+
+	val &= ~INTEL_OC_WDT_TOV;
+	outl(val | (oc_wdt->wdd.timeout - 1), INTEL_OC_WDT_CTRL_REG(oc_wdt));
+
+	return 0;
+}
+
+static int intel_oc_wdt_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct intel_oc_wdt *oc_wdt;
+	struct watchdog_device *wdd;
+	int ret;
+
+	oc_wdt = devm_kzalloc(&pdev->dev, sizeof(*oc_wdt), GFP_KERNEL);
+	if (!oc_wdt)
+		return -ENOMEM;
+
+	oc_wdt->ctrl_res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (!oc_wdt->ctrl_res) {
+		dev_err(&pdev->dev, "missing I/O resource\n");
+		return -ENODEV;
+	}
+
+	if (!devm_request_region(&pdev->dev, oc_wdt->ctrl_res->start,
+				 resource_size(oc_wdt->ctrl_res), pdev->name)) {
+		dev_err(dev, "resource %pR already in use, device disabled\n",
+			oc_wdt->ctrl_res);
+		return -EBUSY;
+	}
+
+	wdd = &oc_wdt->wdd;
+	wdd->min_timeout = INTEL_OC_WDT_MIN_TOV;
+	wdd->max_timeout = INTEL_OC_WDT_MAX_TOV;
+	wdd->timeout = INTEL_OC_WDT_DEF_TOV;
+	wdd->info = &intel_oc_wdt_info;
+	wdd->ops = &intel_oc_wdt_ops;
+	wdd->parent = dev;
+
+	watchdog_init_timeout(wdd, heartbeat, dev);
+
+	ret = intel_oc_wdt_setup(oc_wdt);
+	if (ret)
+		return ret;
+
+	watchdog_set_drvdata(wdd, oc_wdt);
+	watchdog_set_nowayout(wdd, nowayout);
+	watchdog_stop_on_reboot(wdd);
+	watchdog_stop_on_unregister(wdd);
+
+	return devm_watchdog_register_device(dev, wdd);
+}
+
+static const struct acpi_device_id intel_oc_wdt_match[] = {
+	{ "INT3F0D" },
+	{ "INTC1099" },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, intel_oc_wdt_match);
+
+static struct platform_driver intel_oc_wdt_platform_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.acpi_match_table = intel_oc_wdt_match,
+	},
+	.probe = intel_oc_wdt_probe,
+};
+
+module_platform_driver(intel_oc_wdt_platform_driver);
+
+MODULE_AUTHOR("Diogo Ivo <diogo.ivo@siemens.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Intel OC Watchdog driver");

-- 
2.48.1


