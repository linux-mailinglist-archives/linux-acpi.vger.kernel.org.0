Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87BFC1DC13E
	for <lists+linux-acpi@lfdr.de>; Wed, 20 May 2020 23:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgETVTZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 May 2020 17:19:25 -0400
Received: from mga14.intel.com ([192.55.52.115]:62119 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgETVTZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 May 2020 17:19:25 -0400
IronPort-SDR: RJC3jIs/lfqrMKXnWXA7/xApBSk2Te93GAyVS/MabAvmHS6/52mXRMeE4n5126lMotPOX0aS5u
 8IluGkQE4nng==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 14:19:23 -0700
IronPort-SDR: bzpDiYVGjg1C84wFwOLdYXtwQZpqqrBrQQFurl4/mkkJHJitwmDeloWbm1V774Vs9fHGlCc0uY
 cqLHz9sv3/+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,415,1583222400"; 
   d="scan'208";a="253740025"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 20 May 2020 14:19:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E8AE21ED; Thu, 21 May 2020 00:19:17 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 5/5] gpio: pca953x: Override GpioInt() pin for Intel Galileo Gen 2
Date:   Thu, 21 May 2020 00:19:16 +0300
Message-Id: <20200520211916.25727-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520211916.25727-1-andriy.shevchenko@linux.intel.com>
References: <20200520211916.25727-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI table on Intel Galileo Gen 2 has wrong pin number for IRQ resource
of one of the I²C GPIO expanders. ACPI GPIO library provides a special
quirk which we may use in this case. With help of it, override GpioInt()
pin for the affected platform.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-pca953x.c | 44 +++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 1fca8dd7824f..2014563309be 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -10,6 +10,7 @@
 
 #include <linux/acpi.h>
 #include <linux/bitmap.h>
+#include <linux/dmi.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
@@ -113,6 +114,39 @@ static const struct acpi_device_id pca953x_acpi_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, pca953x_acpi_ids);
 
+#ifdef CONFIG_GPIO_PCA953X_IRQ
+static const struct acpi_gpio_params pca953x_interrupt_gpios = { 0, 0, true };
+
+static const struct acpi_gpio_mapping pca953x_acpi_interrupt_gpios[] = {
+	{ "interrupt-gpios", &pca953x_interrupt_gpios, 1, ACPI_GPIO_QUIRK_FORCE_PIN, 1 },
+	{ }
+};
+
+static int pca953x_acpi_interrupt_get_irq(struct device *dev)
+{
+	struct gpio_desc *desc;
+
+	if (devm_acpi_dev_add_driver_gpios(dev, pca953x_acpi_interrupt_gpios))
+		dev_warn(dev, "can't add GPIO ACPI mapping\n");
+
+	desc = devm_gpiod_get(dev, "interrupt", GPIOD_IN);
+	if (IS_ERR(desc))
+		return PTR_ERR(desc);
+
+	return gpiod_to_irq(desc);
+}
+
+static const struct dmi_system_id pca953x_dmi_acpi_interrupt_info[] = {
+	{
+		.ident = "Intel Galileo Gen 2",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "GalileoGen2"),
+		},
+	},
+	{}
+};
+#endif
+
 #define MAX_BANK 5
 #define BANK_SZ 8
 #define MAX_LINE	(MAX_BANK * BANK_SZ)
@@ -750,8 +784,18 @@ static int pca953x_irq_setup(struct pca953x_chip *chip, int irq_base)
 	struct irq_chip *irq_chip = &chip->irq_chip;
 	DECLARE_BITMAP(reg_direction, MAX_LINE);
 	DECLARE_BITMAP(irq_stat, MAX_LINE);
+	const struct dmi_system_id *id;
 	int ret;
 
+	id = dmi_first_match(pca953x_dmi_acpi_interrupt_info);
+	if (id) {
+		dev_info(&client->dev, "Applying ACPI interrupt quirk\n");
+
+		ret = pca953x_acpi_interrupt_get_irq(&client->dev);
+		if (ret > 0)
+			client->irq = ret;
+	}
+
 	if (!client->irq)
 		return 0;
 
-- 
2.26.2

