Return-Path: <linux-acpi+bounces-12091-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5534A5C25E
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 14:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A0997A6AC3
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 13:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB691ADC93;
	Tue, 11 Mar 2025 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="bglGcDdD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E428190674
	for <linux-acpi@vger.kernel.org>; Tue, 11 Mar 2025 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699158; cv=none; b=YvZJy3b8dtpRvBpSPFd6QZXmLcE3YOxr0BwfZ8/qyaH2jexWFBpfZ82g4mBKgMgjc+rk1+4QesHVRmwrg+PrWRlmgUOtKLspEKotUq4wJ6spmsA8+jnGwox1bugrZaqoIQ2iuYlnyzQS6X/NK9LFmOzWMxEVQE4Vag7IOxlisGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699158; c=relaxed/simple;
	bh=/Iqas0WQOBZ008ctDnSlpQl1gFfo5cQ3VzS3/2/2/lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sJseJWrGoaCK0tqQJhPnRvn8DTjVEnGOzyd3XOpBe6W8E8Znz4U82D1QZAH+4qNr5Vny1soIOgGo7AzWs9Lr0nYqhn9BJVnUYKwaBmkopWz8NHcdH2L+0ExFUUeHFLWDOse0nJ+xa5++VgaxDMBXOKm3cIjSAItZlRXQT2X75u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=bglGcDdD; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2025031113190694ef8308f314d435ee
        for <linux-acpi@vger.kernel.org>;
        Tue, 11 Mar 2025 14:19:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=V9MOAbezxADuePVHN+zCf6zt7CO+jhqVXS6PS6yE13c=;
 b=bglGcDdDRM6gH7R34rlAq064yh5/mmitDggUq+KfcQyKUE1mkBiRf1rv2rdDmnWHwWJyVp
 mHw53MTbHDlQtQkuUwjqFhOhNz/pZAENqwu40l7kMxLjyQACi7ZaEYSEvSrb8mwoEO5ZtLKt
 QWJQQR5NZ+hDvTrpzgCKpd+xi2QmN0Bfj/9dYDLVGNljZkRMFqwVnOWQ/j9UglTZnLBlNvrY
 /5xGqWInEsiUKMWPdxy/HLSeBBYNPjP5wwNcvsPSI8Vvo50PNEPKP8HEVkYDbxWxTy21TRif
 hDVyfgSr8yMSg3ijNzuoeXNIIRs9L1fMXrcK5VgO4An8Oc6icYOfoMcw==;
From: Diogo Ivo <diogo.ivo@siemens.com>
Date: Tue, 11 Mar 2025 13:18:50 +0000
Subject: [PATCH] watchdog: Add driver for Intel OC WDT
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-ivo-intel_oc_wdt-v1-1-fd470460d9f5@siemens.com>
X-B4-Tracking: v=1; b=H4sIADk40GcC/x3MTQqAIBBA4avErBPM7IeuEiGSUw2EhooF0t2Tl
 t/ivQwBPWGAqcrgMVEgZwuauoL10HZHRqYYBBcdF2JglBwjG/FUblW3iWzQcmy1NL3mEkp2edz
 o+Zfz8r4f8iaMm2IAAAA=
X-Change-ID: 20250227-ivo-intel_oc_wdt-7a483a4d6a04
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, jan.kiszka@siemens.com, 
 benedikt.niedermayr@siemens.com, Diogo Ivo <diogo.ivo@siemens.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741699146; l=9419;
 i=diogo.ivo@siemens.com; s=20240529; h=from:subject:message-id;
 bh=/Iqas0WQOBZ008ctDnSlpQl1gFfo5cQ3VzS3/2/2/lc=;
 b=NDG64TvCTRw7fpow4B2h86mlaU2Gcr4/o/Nc6GsASIlknep8G8VkJ82eyunQi9JtnvMFtJ4Au
 r/79FhKuV8SC7I1U1xpzIb3vAV1ILqqmKsyEaZ25xpLyYq8dT8meQIO
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
 drivers/acpi/acpi_pnp.c         |   2 +
 drivers/watchdog/Kconfig        |  11 ++
 drivers/watchdog/Makefile       |   1 +
 drivers/watchdog/intel_oc_wdt.c | 235 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 249 insertions(+)

diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
index 01abf26764b00c86f938dea2ed138424f041f880..3f5a1840f573303c71f5d579e32963a5b29d2587 100644
--- a/drivers/acpi/acpi_pnp.c
+++ b/drivers/acpi/acpi_pnp.c
@@ -355,8 +355,10 @@ static bool acpi_pnp_match(const char *idstr, const struct acpi_device_id **matc
  * device represented by it.
  */
 static const struct acpi_device_id acpi_nonpnp_device_ids[] = {
+	{"INT3F0D"},
 	{"INTC1080"},
 	{"INTC1081"},
+	{"INTC1099"},
 	{""},
 };
 
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index f81705f8539aa0b12d156a86aae521aa40b4527d..16e6df441bb344c0f91b40bd76b6322ad3016e72 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1350,6 +1350,17 @@ config INTEL_MID_WATCHDOG
 
 	  To compile this driver as a module, choose M here.
 
+config INTEL_OC_WATCHDOG
+	tristate "Intel OC Watchdog"
+	depends on X86 && ACPI
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
index 0000000000000000000000000000000000000000..0a2df3440024090f7e342fe7da895a7930ac09b2
--- /dev/null
+++ b/drivers/watchdog/intel_oc_wdt.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel OC Watchdog driver
+ *
+ * Copyright (C) 2025, Siemens SA
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
+#define WDT_HEARTBEAT			60
+static int heartbeat = WDT_HEARTBEAT;
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
+			 * the watchdog and read the current timeout.
+			 */
+			nowayout = true;
+
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
+		dev_err(dev, "I/O address 0x%04llx already in use, device disabled\n",
+		       (u64)(oc_wdt->ctrl_res->start));
+		return -EBUSY;
+	}
+
+	wdd = &oc_wdt->wdd;
+	wdd->min_timeout = INTEL_OC_WDT_MIN_TOV;
+	wdd->max_timeout = INTEL_OC_WDT_MAX_TOV;
+	wdd->info = &intel_oc_wdt_info;
+	wdd->ops = &intel_oc_wdt_ops;
+	wdd->parent = dev;
+
+	ret = watchdog_init_timeout(wdd, heartbeat, dev);
+	if (ret) {
+		dev_info(dev, "invalid heartbeat (%d): %u s, defaulting to %d s\n",
+			 ret, heartbeat, WDT_HEARTBEAT);
+		wdd->timeout = WDT_HEARTBEAT;
+	}
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
+		.acpi_match_table = ACPI_PTR(intel_oc_wdt_match),
+	},
+	.probe = intel_oc_wdt_probe,
+};
+
+module_platform_driver(intel_oc_wdt_platform_driver);
+
+MODULE_AUTHOR("Diogo Ivo <diogo.ivo@siemens.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Intel OC Watchdog driver");
+MODULE_ALIAS("platform:" DRV_NAME);

---
base-commit: 4d872d51bc9d7b899c1f61534e3dbde72613f627
change-id: 20250227-ivo-intel_oc_wdt-7a483a4d6a04

Best regards,
-- 
Diogo Ivo <diogo.ivo@siemens.com>


