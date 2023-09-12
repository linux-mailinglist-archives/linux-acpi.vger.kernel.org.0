Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C0579CD3F
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 12:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbjILKIA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Sep 2023 06:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbjILKHo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Sep 2023 06:07:44 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6F6173C
        for <linux-acpi@vger.kernel.org>; Tue, 12 Sep 2023 03:07:40 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-403061cdf2bso28396165e9.2
        for <linux-acpi@vger.kernel.org>; Tue, 12 Sep 2023 03:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694513258; x=1695118058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MZjUI/NMnfmyOh6OB1AvMuCk2YD5ixBKSLX4RZNWFc=;
        b=qfwr1EkMM8qFs8wNofM6jBgK9fFkV3MPMU+Q8/fKY2o/+wI0K/2CebokXwXJTdnH5w
         cAbq9UJfrg1z38pceJjUck0bprWQfkFVI68DHZFUB0Y1wA35WytvmrGQr8KnXvHEQBs3
         8AkgxfWlDOyNxqf7suSWqPW5Q9EVNlonr6SBuEoajWnUBKoDH5afBcep67SNzypjNVsK
         TcFYKvCrLgYMGjCac0VhTtQQA4Pt9atNDFdakrPv0TryclhX0goNVclPDJVoFQu654Xk
         4Sa5Ep12GAYEiFHD3VSIbwLzB4I1/dI0ENiMqgAmt449aNtOBnxL+DC0WuGGhfbpMD2W
         XHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694513258; x=1695118058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MZjUI/NMnfmyOh6OB1AvMuCk2YD5ixBKSLX4RZNWFc=;
        b=InMdmzHZWrY+x/rA1HyWDKEt3jI9d1mm4+kX/jfFAa+A5bIi5Q3PU5xiUEMa5ctE63
         FCFjuWBPNQYMLqvggb0J6gdkGKDQTEYh3gMuHVp6EsStD9O4xd8j0w3WTNsbp2l2oYQV
         XzhMFqSCQGzj6JODFfWGqjjFC0o/QLPDu7p5a+W1YSuIPPvPHHRUPiS4yavRIn1xYNZo
         Ls74lZz9eOCEp76tUfe/3bMKze3lLbo9ijnIRIjVt0HEYxbNtZQx8LZtfTig/F4Fk3GQ
         zba94zCmF3nofcMr7qiawrG/iLR+chZtSIO0ODZPgZywA5KbSd2QKFPXGltK+PZvOQd7
         zAYg==
X-Gm-Message-State: AOJu0YwrpbAMCSiVlUIVmf+o4a/Wl2l3XiRQK2G6ib4H5CXP+CmviC/m
        j3O/C/z6Qm6HWM4NcyocShkcNyoaWDZaVfagTUw=
X-Google-Smtp-Source: AGHT+IHF/iMMmGOTrGuo7KDLPpHqEn+YLF3zk+Y31h6l72Ks1fJ9rEJA68eUo8lhYHd+mAmgCiL5JQ==
X-Received: by 2002:a05:600c:2294:b0:401:b204:3b98 with SMTP id 20-20020a05600c229400b00401b2043b98mr10678033wmf.19.1694513258428;
        Tue, 12 Sep 2023 03:07:38 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:907f:4cd7:f0ae:6b2a])
        by smtp.gmail.com with ESMTPSA id h5-20020adfe985000000b0031ae8d86af4sm12351417wrm.103.2023.09.12.03.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 03:07:38 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 03/11] gpiolib: provide gpio_device_find()
Date:   Tue, 12 Sep 2023 12:07:19 +0200
Message-Id: <20230912100727.23197-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912100727.23197-1-brgl@bgdev.pl>
References: <20230912100727.23197-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

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
index a52c6cc5162b..bf27cc8392fb 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -606,6 +606,9 @@ int devm_gpiochip_add_data_with_key(struct device *dev, struct gpio_chip *gc,
 struct gpio_chip *gpiochip_find(void *data,
 				int (*match)(struct gpio_chip *gc, void *data));
 
+struct gpio_device *gpio_device_find(void *data,
+				int (*match)(struct gpio_chip *gc, void *data));
+
 struct gpio_device *gpio_device_get(struct gpio_device *gdev);
 void gpio_device_put(struct gpio_device *gdev);
 
-- 
2.39.2

