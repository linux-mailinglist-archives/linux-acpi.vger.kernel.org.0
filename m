Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F73331756
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Mar 2021 20:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhCHTc2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Mar 2021 14:32:28 -0500
Received: from mga18.intel.com ([134.134.136.126]:8747 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231389AbhCHTb7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Mar 2021 14:31:59 -0500
IronPort-SDR: BCxQTI+fqcB+B2pVTCNWe65+GPOTG8o1S+Uj9xG6zT+1FT/U6tz6o/Aj4GMg3tRs3BXPSzMSyb
 9s/T6562xW0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="175706702"
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="175706702"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 11:31:58 -0800
IronPort-SDR: FkqUZm3O6PYiHxoUTUxjO27Z+tuxF6GbFdqceGBIGzDEk0EK5KcLPEr/P8i/Ns7017WeiZij1z
 qr5CBIVPVI3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="408343974"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 08 Mar 2021 11:31:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BFCDC1EC; Mon,  8 Mar 2021 21:31:56 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 2/2] gpiolib: Fold conditionals into simple ternary operator
Date:   Mon,  8 Mar 2021 21:31:46 +0200
Message-Id: <20210308193146.65585-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210308193146.65585-1-andriy.shevchenko@linux.intel.com>
References: <20210308193146.65585-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It's quite spread code to initialize IRQ domain options.
Let's fold it into a simple oneliner.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v4: new patch (see changelog of previous one)
 drivers/gpio/gpiolib.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index afee48e7dd41..8c5ce377accc 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1458,7 +1458,7 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
 {
 	struct fwnode_handle *fwnode = dev_fwnode(&gc->gpiodev->dev);
 	struct irq_chip *irqchip = gc->irq.chip;
-	const struct irq_domain_ops *ops = NULL;
+	const struct irq_domain_ops *ops;
 	unsigned int type;
 	unsigned int i;
 
@@ -1496,11 +1496,7 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
 			return ret;
 	} else {
 		/* Some drivers provide custom irqdomain ops */
-		if (gc->irq.domain_ops)
-			ops = gc->irq.domain_ops;
-
-		if (!ops)
-			ops = &gpiochip_domain_ops;
+		ops = gc->irq.domain_ops ?: &gpiochip_domain_ops;
 		gc->irq.domain = irq_domain_create_simple(fwnode,
 			gc->ngpio,
 			gc->irq.first,
-- 
2.30.1

