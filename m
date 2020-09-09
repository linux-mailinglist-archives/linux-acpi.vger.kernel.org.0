Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1500262AFB
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Sep 2020 10:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgIIIyz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Sep 2020 04:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgIIIyi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Sep 2020 04:54:38 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371E8C061796
        for <linux-acpi@vger.kernel.org>; Wed,  9 Sep 2020 01:54:37 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j2so2033831wrx.7
        for <linux-acpi@vger.kernel.org>; Wed, 09 Sep 2020 01:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=apIbSsxgZ3NvYShmhAM+VYa5iL4D093LfOrEXyfUml0=;
        b=p4MUG4M2XdBlzabakblhZUYnvPy0A6xxOG3JsXgWOADWrqUClY8fmjeIrCUCprQ7GG
         bb3EE+6VAi6L9wF+wroA1J8ovJqHafMlCeqlZGtrsYq5+EIRYSoJkXVUfO2I8X4C/wRC
         4Ki5zMK30W/x8pZLWVYBcRDU0j03j50BNuPYiM6arniagLqofm42K+jj1POFFJs2A5LW
         pGZ+4trgD3jAY7hxZnqsrEvndw9VT47fBzUs+mtjINjb8WRppjGiOMrShDavUCf49alo
         yfgiOa/QO+Up4wHeAVj9j8fSbcnwS2Qc9aSSzlt7rknW5WV6e8GzJ6cpKWUKYmbD2OY6
         t2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=apIbSsxgZ3NvYShmhAM+VYa5iL4D093LfOrEXyfUml0=;
        b=B9p2c62kVWbF1fnX30GcWwe396n1gdalHNCH7pIqxLb7s9mcn0s2/pjvO2fmOSbSD7
         PpPpneXWjAb5b6IxJhPFFsyX8K1MOtU3Q7wKvIvBsPmF9WZdhtDSFM1W2FVUdC6xWZ8R
         8HM3xWqqbHVWncmNLgqRl7r1to8JZpBVa5ysMwgOerpJ3XxoCiO8wZUitODTRt4zKix4
         eSdwN/LxGxJVKgPAncjhgl4xWZ3ER6EUmllQdVyDdlbQ5WyaeaFLj8CLtL5G7IcVw9PU
         cwcIVInDoxKrbgWZi2dqAH6ue9b1u0+DgRyZZC0u5XcaA4JtqdCfMkvRz/wLY1owzFjm
         kWzg==
X-Gm-Message-State: AOAM530nKWDbxC3La5ugwMO4B2QPLtiuZEaxaKOyZZXcLncr2IDn21tL
        DqlEu9W43inSlGaczOslvHV9RA==
X-Google-Smtp-Source: ABdhPJw8r23Zd9WJ0lZ/NbQON8+zBEaKodj2Fba4mT+MKk3C/AH7xF2QEYr1fuoGXOWvIDUohTQ8Og==
X-Received: by 2002:adf:e6c8:: with SMTP id y8mr2926512wrm.229.1599641675594;
        Wed, 09 Sep 2020 01:54:35 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-657-1-17-60.w109-210.abo.wanadoo.fr. [109.210.64.60])
        by smtp.gmail.com with ESMTPSA id n17sm3418812wrw.0.2020.09.09.01.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 01:54:35 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 3/3] gpiolib: unexport devprop_gpiochip_set_names()
Date:   Wed,  9 Sep 2020 10:54:26 +0200
Message-Id: <20200909085426.19862-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200909085426.19862-1-brgl@bgdev.pl>
References: <20200909085426.19862-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Now that devprop_gpiochip_set_names() is only used in a single place
inside drivers/gpio/gpiolib.c, there's no need anymore for it to be
exported or to even live in its own source file. Pull this function into
the core source file for gpiolib.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/Makefile          |  1 -
 drivers/gpio/gpiolib-devprop.c | 63 ----------------------------------
 drivers/gpio/gpiolib.c         | 47 +++++++++++++++++++++++++
 include/linux/gpio/driver.h    |  2 --
 4 files changed, 47 insertions(+), 66 deletions(-)
 delete mode 100644 drivers/gpio/gpiolib-devprop.c

diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 4f9abff4f2dc..639275eb4e4d 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -6,7 +6,6 @@ ccflags-$(CONFIG_DEBUG_GPIO)	+= -DDEBUG
 obj-$(CONFIG_GPIOLIB)		+= gpiolib.o
 obj-$(CONFIG_GPIOLIB)		+= gpiolib-devres.o
 obj-$(CONFIG_GPIOLIB)		+= gpiolib-legacy.o
-obj-$(CONFIG_GPIOLIB)		+= gpiolib-devprop.o
 obj-$(CONFIG_GPIOLIB)		+= gpiolib-cdev.o
 obj-$(CONFIG_OF_GPIO)		+= gpiolib-of.o
 obj-$(CONFIG_GPIO_SYSFS)	+= gpiolib-sysfs.o
diff --git a/drivers/gpio/gpiolib-devprop.c b/drivers/gpio/gpiolib-devprop.c
deleted file mode 100644
index 31599d89a85d..000000000000
--- a/drivers/gpio/gpiolib-devprop.c
+++ /dev/null
@@ -1,63 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device property helpers for GPIO chips.
- *
- * Copyright (C) 2016, Intel Corporation
- * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
- */
-
-#include <linux/property.h>
-#include <linux/slab.h>
-#include <linux/gpio/consumer.h>
-#include <linux/gpio/driver.h>
-#include <linux/export.h>
-
-#include "gpiolib.h"
-
-/**
- * devprop_gpiochip_set_names - Set GPIO line names using device properties
- * @chip: GPIO chip whose lines should be named, if possible
- *
- * Looks for device property "gpio-line-names" and if it exists assigns
- * GPIO line names for the chip. The memory allocated for the assigned
- * names belong to the underlying software node and should not be released
- * by the caller.
- */
-int devprop_gpiochip_set_names(struct gpio_chip *chip)
-{
-	struct gpio_device *gdev = chip->gpiodev;
-	struct device *dev = chip->parent;
-	const char **names;
-	int ret, i;
-	int count;
-
-	count = device_property_string_array_count(dev, "gpio-line-names");
-	if (count < 0)
-		return 0;
-
-	if (count > gdev->ngpio) {
-		dev_warn(&gdev->dev, "gpio-line-names is length %d but should be at most length %d",
-			 count, gdev->ngpio);
-		count = gdev->ngpio;
-	}
-
-	names = kcalloc(count, sizeof(*names), GFP_KERNEL);
-	if (!names)
-		return -ENOMEM;
-
-	ret = device_property_read_string_array(dev, "gpio-line-names",
-						names, count);
-	if (ret < 0) {
-		dev_warn(&gdev->dev, "failed to read GPIO line names\n");
-		kfree(names);
-		return ret;
-	}
-
-	for (i = 0; i < count; i++)
-		gdev->descs[i].name = names[i];
-
-	kfree(names);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(devprop_gpiochip_set_names);
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 0d390f0ec32c..943a2de340d8 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -358,6 +358,53 @@ static int gpiochip_set_desc_names(struct gpio_chip *gc)
 	return 0;
 }
 
+/*
+ * devprop_gpiochip_set_names - Set GPIO line names using device properties
+ * @chip: GPIO chip whose lines should be named, if possible
+ *
+ * Looks for device property "gpio-line-names" and if it exists assigns
+ * GPIO line names for the chip. The memory allocated for the assigned
+ * names belong to the underlying software node and should not be released
+ * by the caller.
+ */
+static int devprop_gpiochip_set_names(struct gpio_chip *chip)
+{
+	struct gpio_device *gdev = chip->gpiodev;
+	struct device *dev = chip->parent;
+	const char **names;
+	int ret, i;
+	int count;
+
+	count = device_property_string_array_count(dev, "gpio-line-names");
+	if (count < 0)
+		return 0;
+
+	if (count > gdev->ngpio) {
+		dev_warn(&gdev->dev, "gpio-line-names is length %d but should be at most length %d",
+			 count, gdev->ngpio);
+		count = gdev->ngpio;
+	}
+
+	names = kcalloc(count, sizeof(*names), GFP_KERNEL);
+	if (!names)
+		return -ENOMEM;
+
+	ret = device_property_read_string_array(dev, "gpio-line-names",
+						names, count);
+	if (ret < 0) {
+		dev_warn(&gdev->dev, "failed to read GPIO line names\n");
+		kfree(names);
+		return ret;
+	}
+
+	for (i = 0; i < count; i++)
+		gdev->descs[i].name = names[i];
+
+	kfree(names);
+
+	return 0;
+}
+
 static unsigned long *gpiochip_allocate_mask(struct gpio_chip *gc)
 {
 	unsigned long *p;
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 56485a040b82..4a7e295c3640 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -756,8 +756,6 @@ struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
 					    enum gpiod_flags dflags);
 void gpiochip_free_own_desc(struct gpio_desc *desc);
 
-int devprop_gpiochip_set_names(struct gpio_chip *gc);
-
 #ifdef CONFIG_GPIOLIB
 
 /* lock/unlock as IRQ */
-- 
2.26.1

