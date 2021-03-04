Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B13732D5F8
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 16:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbhCDPF4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Mar 2021 10:05:56 -0500
Received: from mga05.intel.com ([192.55.52.43]:45930 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233350AbhCDPFh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 Mar 2021 10:05:37 -0500
IronPort-SDR: oZyi+NMoAx+zvYk8X6advUO4g9T1DBuLhf8V/KgTR++dhLZjpL+9ADrEt0MyIN0EIX+gG1sFrB
 akVp5HNGwXXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="272434366"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="272434366"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 07:02:41 -0800
IronPort-SDR: T/lljRT6flKnT97E8+POoH1NlqQ9wNUlEhehBgu0CEOct+sHAS1Mv+QX2iIs8WS42UpR6ow5wK
 vTx3CzSS04UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="374579029"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 04 Mar 2021 07:02:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8FF7E29E; Thu,  4 Mar 2021 17:02:38 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 5/5] gpiolib: Reuse device's fwnode to create IRQ domain
Date:   Thu,  4 Mar 2021 17:02:15 +0200
Message-Id: <20210304150215.80652-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210304150215.80652-1-andriy.shevchenko@linux.intel.com>
References: <20210304150215.80652-1-andriy.shevchenko@linux.intel.com>
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
 drivers/gpio/gpiolib.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 6827736ba05c..254d59b088fe 100644
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
 
@@ -1504,15 +1497,10 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
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
+		gc->irq.domain = irq_domain_create_simple(fwnode, gc->ngpio,
+								  gc->irq.first,
+								  ops, gc);
 		if (!gc->irq.domain)
 			return -EINVAL;
 	}
-- 
2.30.1

