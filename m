Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B9A33179C
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Mar 2021 20:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhCHTp4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Mar 2021 14:45:56 -0500
Received: from mga07.intel.com ([134.134.136.100]:40124 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231515AbhCHTps (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Mar 2021 14:45:48 -0500
IronPort-SDR: HybQ/MZS4pT8eBajAlGg+QgFidXl1GtH2eBGlF5v8GhIVfanM5MXSdLpXWdMG2m3aXEkuW1cPJ
 9iZApoTXS68w==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="252123774"
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="252123774"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 11:45:47 -0800
IronPort-SDR: BqCQwil12Yb/eUPqNVWwB069/uhL3jQ6jU0fgBk+IkNLZlAeKdXnRpHMUz6+2waLKRfjB/lT+8
 +nwB+ZF1eLhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="402942296"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 08 Mar 2021 11:45:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1F5E85BD; Mon,  8 Mar 2021 21:45:42 +0200 (EET)
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
Subject: [PATCH v5 6/6] gpiolib: Fold conditionals into a simple ternary operator
Date:   Mon,  8 Mar 2021 21:45:35 +0200
Message-Id: <20210308194535.66394-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210308194535.66394-1-andriy.shevchenko@linux.intel.com>
References: <20210308194535.66394-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It's quite spread code to initialize IRQ domain options.
Let's fold it into a simple oneliner.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
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

