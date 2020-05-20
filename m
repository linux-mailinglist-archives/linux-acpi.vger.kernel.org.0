Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579601DC13A
	for <lists+linux-acpi@lfdr.de>; Wed, 20 May 2020 23:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgETVTW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 May 2020 17:19:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:7202 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727897AbgETVTV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 May 2020 17:19:21 -0400
IronPort-SDR: gV+tEyQrELzZOIWn8qvgZAc7g7AqvkP+snVeMpU7dok45E7hw9xnYWrKNuQwGeI2nM2FRXmOc6
 MKvCAfEEOokg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 14:19:20 -0700
IronPort-SDR: ov3bWESxsQAO61JMwzRb+UO7/a/M6qej7pLhyDRhPgTCjmoPapbsMep5I7PyMdA7aOFPH6kOiA
 IlKeu79FFkrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,415,1583222400"; 
   d="scan'208";a="466673558"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 20 May 2020 14:19:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BC2C9101; Thu, 21 May 2020 00:19:17 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/5] gpiolib: acpi: Introduce opaque data field for quirks
Date:   Thu, 21 May 2020 00:19:12 +0300
Message-Id: <20200520211916.25727-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some quirks may need an additional data to be provided.
Introduce special quirks data field.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c   | 13 +++++++------
 drivers/gpio/gpiolib-acpi.h   |  2 ++
 include/linux/gpio/consumer.h |  1 +
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 9276051663da..3aa976f9ad1a 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -502,7 +502,7 @@ EXPORT_SYMBOL_GPL(devm_acpi_dev_remove_driver_gpios);
 static bool acpi_get_driver_gpio_data(struct acpi_device *adev,
 				      const char *name, int index,
 				      struct fwnode_reference_args *args,
-				      unsigned int *quirks)
+				      struct acpi_gpio_info *info)
 {
 	const struct acpi_gpio_mapping *gm;
 
@@ -519,7 +519,8 @@ static bool acpi_get_driver_gpio_data(struct acpi_device *adev,
 			args->args[2] = par->active_low;
 			args->nargs = 3;
 
-			*quirks = gm->quirks;
+			info->quirks = gm->quirks;
+			info->quirks_data = gm->quirks_data;
 			return true;
 		}
 
@@ -716,7 +717,7 @@ static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode,
 				     struct acpi_gpio_lookup *lookup)
 {
 	struct fwnode_reference_args args;
-	unsigned int quirks = 0;
+	struct acpi_gpio_info info = {};
 	int ret;
 
 	memset(&args, 0, sizeof(args));
@@ -728,8 +729,7 @@ static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode,
 		if (!adev)
 			return ret;
 
-		if (!acpi_get_driver_gpio_data(adev, propname, index, &args,
-					       &quirks))
+		if (!acpi_get_driver_gpio_data(adev, propname, index, &args, &info))
 			return ret;
 	}
 	/*
@@ -746,7 +746,8 @@ static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode,
 	lookup->active_low = !!args.args[2];
 
 	lookup->info.adev = to_acpi_device_node(args.fwnode);
-	lookup->info.quirks = quirks;
+	lookup->info.quirks = info.quirks;
+	lookup->info.quirks_data = info.quirks_data;
 
 	return 0;
 }
diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
index 1c6d65cf0629..44cf55c9d35d 100644
--- a/drivers/gpio/gpiolib-acpi.h
+++ b/drivers/gpio/gpiolib-acpi.h
@@ -19,6 +19,7 @@ struct acpi_device;
  * @polarity: interrupt polarity as provided by ACPI
  * @triggering: triggering type as provided by ACPI
  * @quirks: Linux specific quirks as provided by struct acpi_gpio_mapping
+ * @quirks_data: optional data for the specific @quirks
  */
 struct acpi_gpio_info {
 	struct acpi_device *adev;
@@ -28,6 +29,7 @@ struct acpi_gpio_info {
 	int polarity;
 	int triggering;
 	unsigned int quirks;
+	unsigned long quirks_data;
 };
 
 #ifdef CONFIG_ACPI
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 901aab89d025..49743a499fda 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -676,6 +676,7 @@ struct acpi_gpio_mapping {
 #define ACPI_GPIO_QUIRK_ONLY_GPIOIO		BIT(1)
 
 	unsigned int quirks;
+	unsigned long quirks_data;
 };
 
 #if IS_ENABLED(CONFIG_GPIOLIB) && IS_ENABLED(CONFIG_ACPI)
-- 
2.26.2

