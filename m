Return-Path: <linux-acpi+bounces-207-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 881BC7B06F5
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3748D282730
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAC8450C1
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:34:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F26F38FA6
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 14:29:41 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F23FC
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 07:29:39 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4063da036c9so36486165e9.3
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 07:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695824978; x=1696429778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AG+MBGFlKyeqAoI+zBkkhuwZdyh02KZ6W2Oat6+x/rc=;
        b=jkomhgG+Tbn+oHqiYbAzwP2qCyxutFq51q9Fcs/01QlhQvId6oAl7FycrwCnFlrjsP
         sFnHWdJplfjXkdFGs10AxABLEmXzvBcojyjCRce58rUUFnjvblmIRqem2hLSpQpZ/CSU
         RWKgx0Dibhagns2lZgXIXSyMlWd8KAjfr5sFc1P4RIN42SgwxOymINpdCKa3UmUj6L0w
         AMgRHOTp5Sg9Mp1KM6Q9d4JZycK14633XP0FZxYiZ1DGh4tpMnwhvMkgqbBztPtzhVnw
         DYK29q0dQlq6ncDrikvt8yTgJlZg/WOS2j24Iu2KDuUmXxmSiLZPCUbYjM1XuEUcTIo7
         ZJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695824978; x=1696429778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AG+MBGFlKyeqAoI+zBkkhuwZdyh02KZ6W2Oat6+x/rc=;
        b=imaP5D+tqkCSLgOAApNjPatdYx7LatRsLHRiehkI1xDO1ZHwDjdumnMbodvOlTxWFG
         ve3r9Kw6fGQRFMzXFnlPNoKEOIijnTpClTz79s8XkC7C9GD5/0YwMv/dMGzH2u7RRzTB
         DhoGEuE70PiwuaXLgBr4fbNHby6CJQIqoOztnaZGvs9UfZV17BUOQS5PWA7Z3ndkootJ
         RDqgq29FFNp8sXNEeqBrGkL1zjaMcCPwjOmTdhA+FbdBr/J/S+NpLsrIay5r2nda7c8W
         jy7jGLmgzDXalFXPfYRvyeFuSTDjavq9uR5AcnTj3HT6dR31YxxiVk800FhepuJEWK9T
         6WlQ==
X-Gm-Message-State: AOJu0Yx5BrU5FIUv3AJ2zYKFDyNwLWIqp/uVChou6eutYmMoyUz2qvd6
	oVybsLSbDimXXNod1Ayu5jH0TQ==
X-Google-Smtp-Source: AGHT+IF+734qHN0cowwb2rWZZ7nRSKb6cLjcj/UrCSuIQ9sXERwtpbK0/Z+jtA9CBM2mVhY8P27S2A==
X-Received: by 2002:a7b:c456:0:b0:405:3ca1:f6c6 with SMTP id l22-20020a7bc456000000b004053ca1f6c6mr2188112wmi.0.1695824978053;
        Wed, 27 Sep 2023 07:29:38 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4bb6:1525:9e22:4a15])
        by smtp.gmail.com with ESMTPSA id v2-20020a1cf702000000b003feae747ff2sm20448303wmh.35.2023.09.27.07.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 07:29:37 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 03/11] gpiolib: provide gpio_device_find()
Date: Wed, 27 Sep 2023 16:29:23 +0200
Message-Id: <20230927142931.19798-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230927142931.19798-1-brgl@bgdev.pl>
References: <20230927142931.19798-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

gpiochip_find() is wrong and its kernel doc is misleading as the
function doesn't return a reference to the gpio_chip but just a raw
pointer. The chip itself is not guaranteed to stay alive, in fact it can
be deleted at any point. Also: other than GPIO drivers themselves,
nobody else has any business accessing gpio_chip structs.

Provide a new gpio_device_find() function that returns a real reference
to the opaque gpio_device structure that is guaranteed to stay alive for
as long as there are active users of it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c      | 71 +++++++++++++++++++++++++++----------
 include/linux/gpio/driver.h |  3 ++
 2 files changed, 56 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index f84ad54d8dbd..0371d23f0a46 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1014,16 +1014,10 @@ void gpiochip_remove(struct gpio_chip *gc)
 }
 EXPORT_SYMBOL_GPL(gpiochip_remove);
 
-/**
- * gpiochip_find() - iterator for locating a specific gpio_chip
- * @data: data to pass to match function
- * @match: Callback function to check gpio_chip
+/*
+ * FIXME: This will be removed soon.
  *
- * Similar to bus_find_device.  It returns a reference to a gpio_chip as
- * determined by a user supplied @match callback.  The callback should return
- * 0 if the device doesn't match and non-zero if it does.  If the callback is
- * non-zero, this function will return to the caller and not iterate over any
- * more gpio_chips.
+ * This function is depracated, don't use.
  */
 struct gpio_chip *gpiochip_find(void *data,
 				int (*match)(struct gpio_chip *gc,
@@ -1031,21 +1025,62 @@ struct gpio_chip *gpiochip_find(void *data,
 {
 	struct gpio_device *gdev;
 	struct gpio_chip *gc = NULL;
-	unsigned long flags;
 
-	spin_lock_irqsave(&gpio_lock, flags);
-	list_for_each_entry(gdev, &gpio_devices, list)
-		if (gdev->chip && match(gdev->chip, data)) {
-			gc = gdev->chip;
-			break;
-		}
-
-	spin_unlock_irqrestore(&gpio_lock, flags);
+	gdev = gpio_device_find(data, match);
+	if (gdev) {
+		gc = gdev->chip;
+		gpio_device_put(gdev);
+	}
 
 	return gc;
 }
 EXPORT_SYMBOL_GPL(gpiochip_find);
 
+/**
+ * gpio_device_find() - find a specific GPIO device
+ * @data: data to pass to match function
+ * @match: Callback function to check gpio_chip
+ *
+ * Returns:
+ * New reference to struct gpio_device.
+ *
+ * Similar to bus_find_device(). It returns a reference to a gpio_device as
+ * determined by a user supplied @match callback. The callback should return
+ * 0 if the device doesn't match and non-zero if it does. If the callback
+ * returns non-zero, this function will return to the caller and not iterate
+ * over any more gpio_devices.
+ *
+ * The callback takes the GPIO chip structure as argument. During the execution
+ * of the callback function the chip is protected from being freed. TODO: This
+ * actually has yet to be implemented.
+ *
+ * If the function returns non-NULL, the returned reference must be freed by
+ * the caller using gpio_device_put().
+ */
+struct gpio_device *gpio_device_find(void *data,
+				     int (*match)(struct gpio_chip *gc,
+						  void *data))
+{
+	struct gpio_device *gdev;
+
+	/*
+	 * Not yet but in the future the spinlock below will become a mutex.
+	 * Annotate this function before anyone tries to use it in interrupt
+	 * context like it happened with gpiochip_find().
+	 */
+	might_sleep();
+
+	guard(spinlock_irqsave)(&gpio_lock);
+
+	list_for_each_entry(gdev, &gpio_devices, list) {
+		if (gdev->chip && match(gdev->chip, data))
+			return gpio_device_get(gdev);
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(gpio_device_find);
+
 static int gpiochip_match_name(struct gpio_chip *gc, void *data)
 {
 	const char *name = data;
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 1cedbc3d3200..6ad1f1a8ef2e 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -608,6 +608,9 @@ int devm_gpiochip_add_data_with_key(struct device *dev, struct gpio_chip *gc,
 struct gpio_chip *gpiochip_find(void *data,
 				int (*match)(struct gpio_chip *gc, void *data));
 
+struct gpio_device *gpio_device_find(void *data,
+				int (*match)(struct gpio_chip *gc, void *data));
+
 struct gpio_device *gpio_device_get(struct gpio_device *gdev);
 void gpio_device_put(struct gpio_device *gdev);
 
-- 
2.39.2


