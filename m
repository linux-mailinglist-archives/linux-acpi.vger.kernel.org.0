Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA0632D5F0
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 16:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbhCDPEy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Mar 2021 10:04:54 -0500
Received: from mga05.intel.com ([192.55.52.43]:45940 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233162AbhCDPEW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 Mar 2021 10:04:22 -0500
IronPort-SDR: DUH7WGEK8Vg7a0UItxjCYdLUGB1R8ubHIofucOxqZOothBbcZExOLkH0MFCzjgMcaHa+mAhM7/
 q7OY0s+cR+3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="272434340"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="272434340"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 07:02:36 -0800
IronPort-SDR: kokDU6EFY8JqlmXaqU1WsmGeryJLAt6fHKIzu7sxQUC35bhFqJBpvOhuRJcwxu1V4F6YqWcizY
 lYG15hNZT42g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="374578935"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 04 Mar 2021 07:02:33 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DB4C73C1; Thu,  4 Mar 2021 17:02:32 +0200 (EET)
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
Subject: [PATCH v2 4/5] gpiolib: Introduce acpi_gpio_dev_init() and call it from core
Date:   Thu,  4 Mar 2021 17:02:14 +0200
Message-Id: <20210304150215.80652-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210304150215.80652-1-andriy.shevchenko@linux.intel.com>
References: <20210304150215.80652-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In the ACPI case we may use the firmware node in the similar way
as it's done for OF case. We may use that fwnode for other purposes
in the future.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-acpi.c | 7 +++++++
 drivers/gpio/gpiolib-acpi.h | 4 ++++
 drivers/gpio/gpiolib.c      | 1 +
 3 files changed, 12 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 1aacd2a5a1fd..21750be9c489 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1291,6 +1291,13 @@ void acpi_gpiochip_remove(struct gpio_chip *chip)
 	kfree(acpi_gpio);
 }
 
+void acpi_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev)
+{
+	/* Set default fwnode to parent's one if present */
+	if (gc->parent)
+		ACPI_COMPANION_SET(&gdev->dev, ACPI_COMPANION(gc->parent));
+}
+
 static int acpi_gpio_package_count(const union acpi_object *obj)
 {
 	const union acpi_object *element = obj->package.elements;
diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
index e2edb632b2cc..e476558d9471 100644
--- a/drivers/gpio/gpiolib-acpi.h
+++ b/drivers/gpio/gpiolib-acpi.h
@@ -36,6 +36,8 @@ struct acpi_gpio_info {
 void acpi_gpiochip_add(struct gpio_chip *chip);
 void acpi_gpiochip_remove(struct gpio_chip *chip);
 
+void acpi_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev);
+
 void acpi_gpiochip_request_interrupts(struct gpio_chip *chip);
 void acpi_gpiochip_free_interrupts(struct gpio_chip *chip);
 
@@ -58,6 +60,8 @@ int acpi_gpio_count(struct device *dev, const char *con_id);
 static inline void acpi_gpiochip_add(struct gpio_chip *chip) { }
 static inline void acpi_gpiochip_remove(struct gpio_chip *chip) { }
 
+static inline void acpi_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev) { }
+
 static inline void
 acpi_gpiochip_request_interrupts(struct gpio_chip *chip) { }
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 4af8a8c1316e..6827736ba05c 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -590,6 +590,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	gc->gpiodev = gdev;
 
 	of_gpio_dev_init(gc, gdev);
+	acpi_gpio_dev_init(gc, gdev);
 
 	gdev->id = ida_alloc(&gpio_ida, GFP_KERNEL);
 	if (gdev->id < 0) {
-- 
2.30.1

