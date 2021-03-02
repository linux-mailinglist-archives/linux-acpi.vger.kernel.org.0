Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CD732B44F
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Mar 2021 06:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353126AbhCCE6O (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Mar 2021 23:58:14 -0500
Received: from mga05.intel.com ([192.55.52.43]:13558 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1448714AbhCBPhL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 2 Mar 2021 10:37:11 -0500
IronPort-SDR: 9NBSU9DTNdEmVH4Xmyv4bDVRtorhOLwOn00MguGhIpiK8y2MJvk2Bh8l4jvEn28vGpmPyp6grX
 lzYVl7EbQ0mg==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="271859588"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="271859588"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 07:35:06 -0800
IronPort-SDR: uo8POYjRavLVeZ2tWSnGM6poeBH6UqiOpg/i867Eed3+DHcpga+lokVay5NhaS6D4T79Hry/j+
 +oFJdmi01lww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="595831035"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 02 Mar 2021 07:35:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F08D21F1; Tue,  2 Mar 2021 17:35:03 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v1 2/4] gpiolib: Move of_node operations to gpiolib-of and correct fwnode use
Date:   Tue,  2 Mar 2021 17:34:49 +0200
Message-Id: <20210302153451.50593-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302153451.50593-1-andriy.shevchenko@linux.intel.com>
References: <20210302153451.50593-1-andriy.shevchenko@linux.intel.com>
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
index 484ac92903ab..4af8a8c1316e 100644
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

