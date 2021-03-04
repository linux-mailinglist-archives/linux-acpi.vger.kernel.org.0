Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BE132DB04
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 21:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237971AbhCDUQV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Mar 2021 15:16:21 -0500
Received: from mga07.intel.com ([134.134.136.100]:17133 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237483AbhCDUQK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 Mar 2021 15:16:10 -0500
IronPort-SDR: FJ/WzgRQoDv+2VzFgA/E46hdQvXw3ZEDiTyOMkfKUrz6wZ7hkZ/VSdOnuQQO17gZ0WH2BBmg6h
 AgaAyTtj2BJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="251537524"
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="251537524"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 12:13:03 -0800
IronPort-SDR: jDvoZbqh1YyXX2x7kCfpMk0WbIt+wBeQ6z8VNiOjeUQAf47LnitebRNrPQqO08piskAjNBZe16
 dYtnP1XBW/YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="518783505"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 04 Mar 2021 12:13:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9009F29E; Thu,  4 Mar 2021 22:13:00 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 3/5] gpiolib: Move of_node operations to gpiolib-of and correct fwnode use
Date:   Thu,  4 Mar 2021 22:12:51 +0200
Message-Id: <20210304201253.14652-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210304201253.14652-1-andriy.shevchenko@linux.intel.com>
References: <20210304201253.14652-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The initial value of the OF node based on presence of parent, but
at the same time this operation somehow appeared separately from others
that handle the OF case. On the other hand there is no need to assign
dev->fwnode in the OF case if code properly retrieves fwnode, i.e.
via dev_fwnode() helper.

Amend gpiolib.c and gpiolib-of.c code in order to group OF operations.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-of.c | 6 ++++--
 drivers/gpio/gpiolib.c    | 9 ++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index baf0153b7bca..bbcc7c073f63 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -1042,11 +1042,13 @@ void of_gpiochip_remove(struct gpio_chip *chip)
 
 void of_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev)
 {
+	/* Set default OF node to parent's one if present */
+	if (gc->parent)
+		gdev->dev.of_node = gc->parent->of_node;
+
 	/* If the gpiochip has an assigned OF node this takes precedence */
 	if (gc->of_node)
 		gdev->dev.of_node = gc->of_node;
 	else
 		gc->of_node = gdev->dev.of_node;
-	if (gdev->dev.of_node)
-		gdev->dev.fwnode = of_fwnode_handle(gdev->dev.of_node);
 }
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 083d7e1c7cde..2a3d562eb8c1 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -585,12 +585,9 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	if (!gdev)
 		return -ENOMEM;
 	gdev->dev.bus = &gpio_bus_type;
+	gdev->dev.parent = gc->parent;
 	gdev->chip = gc;
 	gc->gpiodev = gdev;
-	if (gc->parent) {
-		gdev->dev.parent = gc->parent;
-		gdev->dev.of_node = gc->parent->of_node;
-	}
 
 	of_gpio_dev_init(gc, gdev);
 
@@ -4212,11 +4209,13 @@ EXPORT_SYMBOL_GPL(gpiod_put_array);
 
 static int gpio_bus_match(struct device *dev, struct device_driver *drv)
 {
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+
 	/*
 	 * Only match if the fwnode doesn't already have a proper struct device
 	 * created for it.
 	 */
-	if (dev->fwnode && dev->fwnode->dev != dev)
+	if (fwnode && fwnode->dev != dev)
 		return 0;
 	return 1;
 }
-- 
2.30.1

