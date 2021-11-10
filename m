Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0604244C272
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Nov 2021 14:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbhKJNun (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Nov 2021 08:50:43 -0500
Received: from mga01.intel.com ([192.55.52.88]:5719 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232107AbhKJNue (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Nov 2021 08:50:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="256361079"
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="256361079"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 05:47:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="534051198"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 10 Nov 2021 05:47:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 64125155; Wed, 10 Nov 2021 15:47:46 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/2] gpiolib: acpi: Remove never used devm_acpi_dev_remove_driver_gpios()
Date:   Wed, 10 Nov 2021 15:47:42 +0200
Message-Id: <20211110134743.4300-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Remove never used devm_acpi_dev_remove_driver_gpios().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c   | 6 ------
 include/linux/gpio/consumer.h | 2 --
 2 files changed, 8 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 985e8589c58b..25ecc0a37054 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -604,12 +604,6 @@ int devm_acpi_dev_add_driver_gpios(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_acpi_dev_add_driver_gpios);
 
-void devm_acpi_dev_remove_driver_gpios(struct device *dev)
-{
-	WARN_ON(devres_release(dev, devm_acpi_dev_release_driver_gpios, NULL, NULL));
-}
-EXPORT_SYMBOL_GPL(devm_acpi_dev_remove_driver_gpios);
-
 static bool acpi_get_driver_gpio_data(struct acpi_device *adev,
 				      const char *name, int index,
 				      struct fwnode_reference_args *args,
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 97a28ad3393b..3ad67b4a72be 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -690,7 +690,6 @@ void acpi_dev_remove_driver_gpios(struct acpi_device *adev);
 
 int devm_acpi_dev_add_driver_gpios(struct device *dev,
 				   const struct acpi_gpio_mapping *gpios);
-void devm_acpi_dev_remove_driver_gpios(struct device *dev);
 
 struct gpio_desc *acpi_get_and_request_gpiod(char *path, int pin, char *label);
 
@@ -708,7 +707,6 @@ static inline int devm_acpi_dev_add_driver_gpios(struct device *dev,
 {
 	return -ENXIO;
 }
-static inline void devm_acpi_dev_remove_driver_gpios(struct device *dev) {}
 
 #endif /* CONFIG_GPIOLIB && CONFIG_ACPI */
 
-- 
2.33.0

