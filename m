Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3E232B44D
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Mar 2021 06:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353123AbhCCE6K (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Mar 2021 23:58:10 -0500
Received: from mga05.intel.com ([192.55.52.43]:13563 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1448687AbhCBPhL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 2 Mar 2021 10:37:11 -0500
IronPort-SDR: DrB8s6oR9pxje8+VdYNVlccTzmzw93PiJkWT3r+kUdZD/DrwbvSzWSZTekFoM5TU2N/i8Yv06n
 /H2P+1AY1e5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="271859602"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="271859602"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 07:35:07 -0800
IronPort-SDR: 5vj6m/PZ3I2TO5brj7Ucb832XdB2x8EKteZwSy6Pkv4XobsQuuUq3dkzV97oND/svhTRB4ZpZy
 O+WwFBaQKO0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="595831038"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 02 Mar 2021 07:35:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6894213A; Tue,  2 Mar 2021 17:35:05 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v1 4/4] gpiolib: Reuse device's fwnode to create IRQ domain
Date:   Tue,  2 Mar 2021 17:34:51 +0200
Message-Id: <20210302153451.50593-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302153451.50593-1-andriy.shevchenko@linux.intel.com>
References: <20210302153451.50593-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When IRQ domain is created for an ACPI case, the name of it becomes unknown-%d
since for now it utilizes of_node member only and doesn't consider fwnode case.
Convert IRQ domain creation code to utilize fwnode instead.

Before/After the change on Intel Galileo Gen 2 with two GPIO (IRQ) controllers:

  unknown-1	==>	\_SB.PCI0.GIP0.GPO
  unknown-2	==>	\_SB.NIO3

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 6827736ba05c..54cfea4e4a03 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1457,9 +1457,9 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
 				struct lock_class_key *lock_key,
 				struct lock_class_key *request_key)
 {
+	struct fwnode_handle *fwnode = dev_fwnode(&gc->gpiodev->dev);
 	struct irq_chip *irqchip = gc->irq.chip;
-	const struct irq_domain_ops *ops = NULL;
-	struct device_node *np;
+	const struct irq_domain_ops *ops;
 	unsigned int type;
 	unsigned int i;
 
@@ -1471,7 +1471,6 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
 		return -EINVAL;
 	}
 
-	np = gc->gpiodev->dev.of_node;
 	type = gc->irq.default_type;
 
 	/*
@@ -1479,16 +1478,10 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
 	 * used to configure the interrupts, as you may end up with
 	 * conflicting triggers. Tell the user, and reset to NONE.
 	 */
-	if (WARN(np && type != IRQ_TYPE_NONE,
-		 "%s: Ignoring %u default trigger\n", np->full_name, type))
+	if (WARN(fwnode && type != IRQ_TYPE_NONE,
+		 "%pfw: Ignoring %u default trigger\n", fwnode, type))
 		type = IRQ_TYPE_NONE;
 
-	if (has_acpi_companion(gc->parent) && type != IRQ_TYPE_NONE) {
-		acpi_handle_warn(ACPI_HANDLE(gc->parent),
-				 "Ignoring %u default trigger\n", type);
-		type = IRQ_TYPE_NONE;
-	}
-
 	if (gc->to_irq)
 		chip_warn(gc, "to_irq is redefined in %s and you shouldn't rely on it\n", __func__);
 
@@ -1504,15 +1497,14 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
 			return ret;
 	} else {
 		/* Some drivers provide custom irqdomain ops */
-		if (gc->irq.domain_ops)
-			ops = gc->irq.domain_ops;
-
-		if (!ops)
-			ops = &gpiochip_domain_ops;
-		gc->irq.domain = irq_domain_add_simple(np,
-			gc->ngpio,
-			gc->irq.first,
-			ops, gc);
+		ops = gc->irq.domain_ops ?: &gpiochip_domain_ops;
+		if (gc->irq.first)
+			gc->irq.domain = irq_domain_create_legacy(fwnode, gc->ngpio,
+								  gc->irq.first, 0,
+								  ops, gc);
+		else
+			gc->irq.domain = irq_domain_create_linear(fwnode, gc->ngpio,
+								  ops, gc);
 		if (!gc->irq.domain)
 			return -EINVAL;
 	}
-- 
2.30.1

