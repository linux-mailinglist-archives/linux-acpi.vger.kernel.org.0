Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD2925DE73
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 17:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgIDPuP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 11:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgIDPqp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Sep 2020 11:46:45 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C21AC061235
        for <linux-acpi@vger.kernel.org>; Fri,  4 Sep 2020 08:46:38 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c15so7166649wrs.11
        for <linux-acpi@vger.kernel.org>; Fri, 04 Sep 2020 08:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U1nBCcNL8BeNxadPopc6bEehAwgvXwIu9mXvHzCgK8I=;
        b=p6+ozsPxwsblRZBCpVmBP7qVN0c1CSrx+fQWcqeSx2ykc5J0fyO83akiBJSKb4fObd
         yQkluWfXAW1xUpE/a/FmkvipuYuJFIXeBRQN6YHlrGEDwcxjGUjCifUpGQn+Z9PSKHB9
         tZ/AGLgg2kq+Hz2boTAN8B2I18BtR2A4vZ+P6IvHlxuVzx6IB+fPjeFu7Xh74RXA5AVm
         Un7a6R2xmZSajmcdaTmP9wx0IbBq3KvVxsT+swGdZAFNxWtBAmPcFm+pJx10udDTzex/
         LXUL3Kajpvv8vIpFGU0V2hdjPyqhZi0a0RY5fZOQYG8J9WZL4wcTCe2btth/wOeXwmQ6
         gL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U1nBCcNL8BeNxadPopc6bEehAwgvXwIu9mXvHzCgK8I=;
        b=f/0/GRefyT7NzaSGviIPs8d1Jj5RWvci7F/ib9BjetC0oo4IRza6jYkcoJyM/LZeyt
         t9U+cKUqPWVSEDG2OkTNYUgyJf4Ra5x2k6QE/SyHZVQzrox6zoQGc2mXUcUkjb4tyHuc
         x72JUG6cdeQ7VOLLfOsMn7kik3F32gNOHCfrNjkRRM2zNGsCaPYSq+yqtyKOiPqWrrVF
         U5agfLM5j5gbTwCA9v6nMg0VFdYQKaSLbPgltgpe5WgPEs+zEP51pDRMAzqGDMKKUVPJ
         J+cbnhLFOatnWNTQwwXoB0VtXwVBvDB7myIlbEgLVK46XZciJXtfmHxVOlL9COFC6pwY
         uS3Q==
X-Gm-Message-State: AOAM533XbUtpW1POHjDATqdtzowHRRdakuAMjcFUqPXpdmd4Hbj21LQe
        jJr+spteuftBEo/5+jUR+ksnK7fU942Xrg==
X-Google-Smtp-Source: ABdhPJxKPO93ctBJ7Ow4MExd8CKDovERdU03BsC4lwZGsWCoWTY7HZN7SxfvjywlGty5Qr0fODTzVw==
X-Received: by 2002:adf:e391:: with SMTP id e17mr7982842wrm.289.1599234397164;
        Fri, 04 Sep 2020 08:46:37 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id q4sm11983375wru.65.2020.09.04.08.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:46:36 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 05/23] gpiolib: unexport devprop_gpiochip_set_names()
Date:   Fri,  4 Sep 2020 17:45:29 +0200
Message-Id: <20200904154547.3836-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200904154547.3836-1-brgl@bgdev.pl>
References: <20200904154547.3836-1-brgl@bgdev.pl>
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
 drivers/gpio/gpiolib-devprop.c | 64 ----------------------------------
 drivers/gpio/gpiolib.c         | 48 +++++++++++++++++++++++++
 include/linux/gpio/driver.h    |  2 --
 4 files changed, 48 insertions(+), 67 deletions(-)
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
index a28659b4f9c9..000000000000
--- a/drivers/gpio/gpiolib-devprop.c
+++ /dev/null
@@ -1,64 +0,0 @@
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
-	count = device_property_read_string_array(dev, "gpio-line-names",
-						  NULL, 0);
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
index 0d390f0ec32c..15c99cf560ee 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -358,6 +358,54 @@ static int gpiochip_set_desc_names(struct gpio_chip *gc)
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
+	count = device_property_read_string_array(dev, "gpio-line-names",
+						  NULL, 0);
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

