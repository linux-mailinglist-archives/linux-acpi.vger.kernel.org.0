Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2510432DAF8
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 21:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbhCDUPU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Mar 2021 15:15:20 -0500
Received: from mga01.intel.com ([192.55.52.88]:6975 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231734AbhCDUOt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 Mar 2021 15:14:49 -0500
IronPort-SDR: pmSfc2n60SSZetXu5lhD3mMRzc7XgTFFf7JhPMjwKHu9qsuFsjpZrvQO2ktQ/Gm6+hMa4844F7
 jkICx3PHUT1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="207217334"
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="207217334"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 12:13:03 -0800
IronPort-SDR: vnRBuhcgY1/n8X16CGB2tqmuUMhu5j4qSZynT7Q+4kaAYs3mq6wjEIvTJni88B1feN1uyn3l72
 CTc2xY5aC1vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="406981974"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 04 Mar 2021 12:13:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A52C83C1; Thu,  4 Mar 2021 22:13:00 +0200 (EET)
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
Subject: [PATCH v3 4/5] gpiolib: Introduce acpi_gpio_dev_init() and call it from core
Date:   Thu,  4 Mar 2021 22:12:52 +0200
Message-Id: <20210304201253.14652-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210304201253.14652-1-andriy.shevchenko@linux.intel.com>
References: <20210304201253.14652-1-andriy.shevchenko@linux.intel.com>
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
index 2a3d562eb8c1..46ab1ce67ba0 100644
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

