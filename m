Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0005331799
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Mar 2021 20:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhCHTp5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Mar 2021 14:45:57 -0500
Received: from mga06.intel.com ([134.134.136.31]:33058 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231534AbhCHTpx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Mar 2021 14:45:53 -0500
IronPort-SDR: SbuibB4qmHjmzyGibSzqhjtEOzLvzE+6+pcuPAt+ngGoAcygV5J8P6xj2FYybDhAT2rSAUMNXH
 LDWLWAAJE1Hg==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="249474608"
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="249474608"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 11:45:48 -0800
IronPort-SDR: Bxv7GtrSidG5hoObtJRA1/10lHlBqzdFWQkIVFw6pie37GfBsIerdhy6lUm23wCdaE7YfTKS/h
 9nTWQRvPbYIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="520046839"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 08 Mar 2021 11:45:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 137DD56B; Mon,  8 Mar 2021 21:45:42 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v5 5/6] gpiolib: Reuse device's fwnode to create IRQ domain
Date:   Mon,  8 Mar 2021 21:45:34 +0200
Message-Id: <20210308194535.66394-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210308194535.66394-1-andriy.shevchenko@linux.intel.com>
References: <20210308194535.66394-1-andriy.shevchenko@linux.intel.com>
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

Due to the nature of this change we may also deduplicate the WARN():s
because in either case (DT or ACPI) the fwnode will be set correctly
and %pfw is an equivalent to what the current code prints as a prefix.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 1853075df741..afee48e7dd41 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1456,9 +1456,9 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
 				struct lock_class_key *lock_key,
 				struct lock_class_key *request_key)
 {
+	struct fwnode_handle *fwnode = dev_fwnode(&gc->gpiodev->dev);
 	struct irq_chip *irqchip = gc->irq.chip;
 	const struct irq_domain_ops *ops = NULL;
-	struct device_node *np;
 	unsigned int type;
 	unsigned int i;
 
@@ -1470,7 +1470,6 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
 		return -EINVAL;
 	}
 
-	np = gc->gpiodev->dev.of_node;
 	type = gc->irq.default_type;
 
 	/*
@@ -1478,16 +1477,10 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
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
 
@@ -1508,7 +1501,7 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
 
 		if (!ops)
 			ops = &gpiochip_domain_ops;
-		gc->irq.domain = irq_domain_add_simple(np,
+		gc->irq.domain = irq_domain_create_simple(fwnode,
 			gc->ngpio,
 			gc->irq.first,
 			ops, gc);
-- 
2.30.1

