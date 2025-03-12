Return-Path: <linux-acpi+bounces-12125-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25583A5E0DC
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 16:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41403188A515
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 15:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910AB256C95;
	Wed, 12 Mar 2025 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="IiP9JHgs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A68254B1A
	for <linux-acpi@vger.kernel.org>; Wed, 12 Mar 2025 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794377; cv=none; b=JqKuH0lE6FAZMccL0BTvaHQyPHaiSvFB9+D2nsGqtsSI1wLzdlhjQVliJZeoG3ysrzMZAe9hQJ0Soe0k5asI7XRPju4Vqcl8D5SYd8cSn5mKZYlLmo1KkuAjG1HZZioqO2W054EzKIcvUaF5i0X9JU12JBR5+p0NHfRbVfl3rZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794377; c=relaxed/simple;
	bh=0fAGnqDm0sNCNC9Cz6QwUPM/MFmquYjyu7P22U1/BFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NKQaouNJMwfGiiW2p4XER9iSNTZ3DCXOLsswef1zwMPuJvtePpgdrzGjSy42WfmPMhXKUjfypB+VhfTJS5aJUt2q4V9rDGfP/50oAfdD7TeHRVbj6wgXHGK7qZbPpF0tEtW/OHR1+hdobCAYi6R4SrB61OUhMfdzfYt9J+mCTCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=IiP9JHgs; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202503121546067d2da63bb18b9b4eb9
        for <linux-acpi@vger.kernel.org>;
        Wed, 12 Mar 2025 16:46:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=RXhAs6JS5IWG6vSKb+8+XO0kejzywoZL8sLRxtqJQcA=;
 b=IiP9JHgsvPeDscc1rKZV/MVt5v4LavTZQ4auUAR9AengBw8MVT1lNPz3znbRUgPwESIE99
 lzq1HOdaPoJVeCrZD/u/woNx9slXLAq6VKoiKZf7KKXPJBazVXw/ht6/bW51npYkmav/lUz+
 GTJFNivQxITjYq58XjaaVhshHzYM6YCOUkHGbkK5PNU+9Tx9cRlG/E26gRCtkb83eFN29awp
 C2E+D4XBOE8Oc0UrlnFAI1hZfBy+9vSt1lTt+APbMJDzLhDd3rMTQeCEu5vaiTICFYJayQ4h
 WDBENQeEdCZ8vK9x5iZC8dLdvNE50vfX9YMscns3Ek1RTh0KepQsuQwQ==;
From: Diogo Ivo <diogo.ivo@siemens.com>
Date: Wed, 12 Mar 2025 15:46:01 +0000
Subject: [PATCH v2 1/2] watchdog: Add driver for Intel OC WDT
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-ivo-intel_oc_wdt-v2-1-52d09738cd0b@siemens.com>
References: <20250312-ivo-intel_oc_wdt-v2-0-52d09738cd0b@siemens.com>
In-Reply-To: <20250312-ivo-intel_oc_wdt-v2-0-52d09738cd0b@siemens.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, jan.kiszka@siemens.com, 
 benedikt.niedermayr@siemens.com, Diogo Ivo <diogo.ivo@siemens.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741794365; l=8963;
 i=diogo.ivo@siemens.com; s=20240529; h=from:subject:message-id;
 bh=0fAGnqDm0sNCNC9Cz6QwUPM/MFmquYjyu7P22U1/BFs=;
 b=Z2Q8U1sDRGurec62pKn4+ZjmUbROkVAjv8tjh88cyXJQ5QygkpkDFS3u19neCwCig8doZ33oG
 pk9I098sMIDAmhxku2L4+aQFLryVtDxNWAA27fRAyJ39ypnhB0ETiQ6
X-Developer-Key: i=diogo.ivo@siemens.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328357:519-21489:flowmailer

Add a driver for the Intel Over-Clocking Watchdog found in Intel
Platform Controller (PCH) chipsets. This watchdog is controlled
via a simple single-register interface and would otherwise be
standard except for the presence of a LOCK bit that can only be
set once per power cycle, needing extra handling around it.

Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
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


