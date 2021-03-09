Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A72633221B
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Mar 2021 10:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhCIJiB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Mar 2021 04:38:01 -0500
Received: from mga12.intel.com ([192.55.52.136]:30733 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229641AbhCIJho (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 9 Mar 2021 04:37:44 -0500
IronPort-SDR: unY5L+1d+ukZl9VtHQJISRnFxN8YRvY/hphjuV2C08IGt5kX190+rDZMv/CbXtFrRPWR1lNnu4
 DtcIRTOEk9eQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="167466266"
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="167466266"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 01:37:44 -0800
IronPort-SDR: VRIaFDlaMgPRCo8zHzNCl4Wl0Bm73Al2x9WB6eB1xTIXoAMiX2zGtCpdeogxYDt5BF0frb2YXS
 Y7FD6ztq4+iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="430694114"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 09 Mar 2021 01:37:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 957AD5D2; Tue,  9 Mar 2021 11:37:38 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v6 6/6] gpiolib: Fold conditionals into a simple ternary operator
Date:   Tue,  9 Mar 2021 11:37:36 +0200
Message-Id: <20210309093736.67925-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210309093736.67925-1-andriy.shevchenko@linux.intel.com>
References: <20210309093736.67925-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It's quite spread code to initialize IRQ domain options.
Let's fold it into a simple oneliner.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index afee48e7dd41..cee4333f8ac7 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1458,7 +1458,6 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
 {
 	struct fwnode_handle *fwnode = dev_fwnode(&gc->gpiodev->dev);
 	struct irq_chip *irqchip = gc->irq.chip;
-	const struct irq_domain_ops *ops = NULL;
 	unsigned int type;
 	unsigned int i;
 
@@ -1496,15 +1495,11 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
 			return ret;
 	} else {
 		/* Some drivers provide custom irqdomain ops */
-		if (gc->irq.domain_ops)
-			ops = gc->irq.domain_ops;
-
-		if (!ops)
-			ops = &gpiochip_domain_ops;
 		gc->irq.domain = irq_domain_create_simple(fwnode,
 			gc->ngpio,
 			gc->irq.first,
-			ops, gc);
+			gc->irq.domain_ops ?: &gpiochip_domain_ops,
+			gc);
 		if (!gc->irq.domain)
 			return -EINVAL;
 	}
-- 
2.30.1

