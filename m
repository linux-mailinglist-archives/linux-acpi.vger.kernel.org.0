Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0881325399
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Feb 2021 17:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhBYQf2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Feb 2021 11:35:28 -0500
Received: from mga11.intel.com ([192.55.52.93]:64509 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhBYQfZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Feb 2021 11:35:25 -0500
IronPort-SDR: 9MROr3sVW4uVNbMPfjENwq3SDhrTbZZsTpOUBTXjD4anoCv4HzU5048n0ZC1lKn0E8dWlda7NA
 n4nonc9ldwng==
X-IronPort-AV: E=McAfee;i="6000,8403,9906"; a="182156002"
X-IronPort-AV: E=Sophos;i="5.81,206,1610438400"; 
   d="scan'208";a="182156002"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 08:33:37 -0800
IronPort-SDR: fjDB3eGn2eE2JeLHekf1/qYF0tXgnHKtLDmvwTwVZZuQzwWsKi7fKvdtZDv9eVy1BTbJqg+Uu2
 /v3DPK/LO3TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,206,1610438400"; 
   d="scan'208";a="432360281"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Feb 2021 08:33:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 10DA854A; Thu, 25 Feb 2021 18:33:34 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 3/3] gpio: pca953x: Set IRQ type when handle Intel Galileo Gen 2
Date:   Thu, 25 Feb 2021 18:33:20 +0200
Message-Id: <20210225163320.71267-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210225163320.71267-1-andriy.shevchenko@linux.intel.com>
References: <20210225163320.71267-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The commit 0ea683931adb ("gpio: dwapb: Convert driver to using the
GPIO-lib-based IRQ-chip") indeliberately made a regression on how
IRQ line from GPIO I²C expander is handled. I.e. it reveals that
the quirk for Intel Galileo Gen 2 misses the part of setting IRQ type
which previously was predefined by gpio-dwapb driver. Now, we have to
reorganize the approach to call necessary parts, which can be done via
ACPI_GPIO_QUIRK_ABSOLUTE_NUMBER quirk.

Without this fix and with above mentioned change the kernel hangs
on the first IRQ event with:

    gpio gpiochip3: Persistence not supported for GPIO 1
    irq 32, desc: 62f8fb50, depth: 0, count: 0, unhandled: 0
    ->handle_irq():  41c7b0ab, handle_bad_irq+0x0/0x40
    ->irq_data.chip(): e03f1e72, 0xc2539218
    ->action(): 0ecc7e6f
    ->action->handler(): 8a3db21e, irq_default_primary_handler+0x0/0x10
       IRQ_NOPROBE set
    unexpected IRQ trap at vector 20

Fixes: ba8c90c61847 ("gpio: pca953x: Override IRQ for one of the expanders on Galileo Gen 2")
Depends-on: 0ea683931adb ("gpio: dwapb: Convert driver to using the GPIO-lib-based IRQ-chip")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-pca953x.c | 78 +++++++++++--------------------------
 1 file changed, 23 insertions(+), 55 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 825b362eb4b7..6898c27f71f8 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -112,8 +112,29 @@ MODULE_DEVICE_TABLE(i2c, pca953x_id);
 #ifdef CONFIG_GPIO_PCA953X_IRQ
 
 #include <linux/dmi.h>
-#include <linux/gpio.h>
-#include <linux/list.h>
+
+static const struct acpi_gpio_params pca953x_irq_gpios = { 0, 0, true };
+
+static const struct acpi_gpio_mapping pca953x_acpi_irq_gpios[] = {
+	{ "irq-gpios", &pca953x_irq_gpios, 1, ACPI_GPIO_QUIRK_ABSOLUTE_NUMBER },
+	{ }
+};
+
+static int pca953x_acpi_get_irq(struct device *dev)
+{
+	int ret;
+
+	ret = devm_acpi_dev_add_driver_gpios(dev, pca953x_acpi_irq_gpios);
+	if (ret)
+		dev_warn(dev, "can't add GPIO ACPI mapping\n");
+
+	ret = acpi_dev_gpio_irq_get_by(ACPI_COMPANION(dev), "irq-gpios", 0);
+	if (ret < 0)
+		return ret;
+
+	dev_info(dev, "ACPI interrupt quirk (IRQ %d)\n", ret);
+	return ret;
+}
 
 static const struct dmi_system_id pca953x_dmi_acpi_irq_info[] = {
 	{
@@ -132,59 +153,6 @@ static const struct dmi_system_id pca953x_dmi_acpi_irq_info[] = {
 	},
 	{}
 };
-
-#ifdef CONFIG_ACPI
-static int pca953x_acpi_get_pin(struct acpi_resource *ares, void *data)
-{
-	struct acpi_resource_gpio *agpio;
-	int *pin = data;
-
-	if (acpi_gpio_get_irq_resource(ares, &agpio))
-		*pin = agpio->pin_table[0];
-	return 1;
-}
-
-static int pca953x_acpi_find_pin(struct device *dev)
-{
-	struct acpi_device *adev = ACPI_COMPANION(dev);
-	int pin = -ENOENT, ret;
-	LIST_HEAD(r);
-
-	ret = acpi_dev_get_resources(adev, &r, pca953x_acpi_get_pin, &pin);
-	acpi_dev_free_resource_list(&r);
-	if (ret < 0)
-		return ret;
-
-	return pin;
-}
-#else
-static inline int pca953x_acpi_find_pin(struct device *dev) { return -ENXIO; }
-#endif
-
-static int pca953x_acpi_get_irq(struct device *dev)
-{
-	int pin, ret;
-
-	pin = pca953x_acpi_find_pin(dev);
-	if (pin < 0)
-		return pin;
-
-	dev_info(dev, "Applying ACPI interrupt quirk (GPIO %d)\n", pin);
-
-	if (!gpio_is_valid(pin))
-		return -EINVAL;
-
-	ret = gpio_request(pin, "pca953x interrupt");
-	if (ret)
-		return ret;
-
-	ret = gpio_to_irq(pin);
-
-	/* When pin is used as an IRQ, no need to keep it requested */
-	gpio_free(pin);
-
-	return ret;
-}
 #endif
 
 static const struct acpi_device_id pca953x_acpi_ids[] = {
-- 
2.30.0

