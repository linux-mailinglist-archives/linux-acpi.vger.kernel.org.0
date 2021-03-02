Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E91332B450
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Mar 2021 06:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353129AbhCCE6P (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Mar 2021 23:58:15 -0500
Received: from mga11.intel.com ([192.55.52.93]:45308 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1575753AbhCBPoC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 2 Mar 2021 10:44:02 -0500
IronPort-SDR: SZRfZNVxEl/tHr9r5BvYAOibe+11yo4C7gZEVMRp6mqgqfT07T4Xv78niyjZS7eaTatUPtx7it
 vHPgQkepiyTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="183457082"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="183457082"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 07:36:13 -0800
IronPort-SDR: drYOvbiGuDNZ1H8x7/J/wyKXTBQSin7Lu0AbxgATrquuGyOTjIds7HMNRTQX11PIpfw5IQvrUB
 0OLYrrARjrPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="435736821"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 02 Mar 2021 07:35:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C33981F4; Tue,  2 Mar 2021 17:35:04 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v1 3/4] gpiolib: Introduce acpi_gpio_dev_init() and call it from core
Date:   Tue,  2 Mar 2021 17:34:50 +0200
Message-Id: <20210302153451.50593-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302153451.50593-1-andriy.shevchenko@linux.intel.com>
References: <20210302153451.50593-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In the ACPI case we may use the firmware node in the similar way
as it's done for OF case. We may use that fwnode for other purposes
in the future.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 7 +++++++
 drivers/gpio/gpiolib-acpi.h | 4 ++++
 drivers/gpio/gpiolib.c      | 1 +
 3 files changed, 12 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 495f779b2ab9..27a4a4e0a48d 100644
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

