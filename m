Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B1F7A21B9
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Sep 2023 17:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbjIOPDt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Sep 2023 11:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbjIOPDj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Sep 2023 11:03:39 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490022130
        for <linux-acpi@vger.kernel.org>; Fri, 15 Sep 2023 08:03:33 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3ff1c397405so24672175e9.3
        for <linux-acpi@vger.kernel.org>; Fri, 15 Sep 2023 08:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694790212; x=1695395012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxu4Stw3TnchTs3E1ZMW4avWovvpHjhxTZTeZz76j+U=;
        b=q4pWlH6+vNlIKeIKF3OohzK2bHBScrILVC20saw5S643ykgMXw6FgpeZJfpHgOYd9E
         htDSdDiFnDwzp+hEKhZ1H7PcueepOjaYoj7oR/wbZXBWg9uUt2Xe6R0dyrqFCF8ScHRd
         U0eR5x/PjeUicRG2YfJaTV02MAuuuPHdtj4PxD70mn0DGEh+/FUvmOV4XGA4iM33+zBI
         kYYDaMjXwxXFbu7yxfgFqWbrkGJk0arQYpb+hpzDA8MOB3/wzb76THKA8TUqNuGxZLnM
         7MXqC5T8JDyIX+W8Z1aCPBdOsEOCmqIjaZsDhgQ/AhDlqGbWLl8Wli4JfPqjcFMVSfzT
         qVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694790212; x=1695395012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxu4Stw3TnchTs3E1ZMW4avWovvpHjhxTZTeZz76j+U=;
        b=qkxe+j7nsw/3aSU7/sl6ZcjASBU+CPnV2T3yDMqy+gyCQX2czcqO1E352Lb7LRJDON
         KA8s2A45zysL9cCN16giJtc/Z+ev8yCFGpOG2ghRtaJeGpFiEZRjvREOCvg+TxF2OaDR
         2X6rsb/GLtohNuZ7oWxbGcL5yEx0o0XKFfA7JE3wTo5mCOljC8s/rGnbMLbHVz8jiRbY
         CjFQVXQla70wKjIioIcwL6y6XNinbYnNEY9zFFP7zjYRWL3d16yLvRfxFrLlU4pj70HU
         cCueWEra1g/rnfT5kHHM8IKUei8hLuCzZ09r6pm5XZieA7Sb4nFgKSKj5DVKbi84IIHW
         NUOQ==
X-Gm-Message-State: AOJu0YzGOZr0SR5v5ZBcKeZcJ6MtRoAVsD3QDHXoWEjl0lftpu6R9O62
        SK/g50ol0DK5qMPIEr2GDnFfWA==
X-Google-Smtp-Source: AGHT+IEi8q6lvXBgZqOFvzjqXtX1Hg6TltZCZKdPEvd0Tp42WI2DjfKN8Be7Pi4kAX8uyF+ILCSwrQ==
X-Received: by 2002:a1c:ed10:0:b0:401:daf2:2737 with SMTP id l16-20020a1ced10000000b00401daf22737mr1945005wmh.30.1694790211489;
        Fri, 15 Sep 2023 08:03:31 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:aa19:4569:aeeb:c0d3])
        by smtp.gmail.com with ESMTPSA id hn40-20020a05600ca3a800b003fef19bb55csm4853369wmb.34.2023.09.15.08.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 08:03:30 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 01/11] gpiolib: make gpio_device_get() and gpio_device_put() public
Date:   Fri, 15 Sep 2023 17:03:16 +0200
Message-Id: <20230915150327.81918-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230915150327.81918-1-brgl@bgdev.pl>
References: <20230915150327.81918-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

In order to start migrating away from accessing struct gpio_chip by
users other than their owners, let's first make the reference management
functions for the opaque struct gpio_device public in the driver.h
header.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c      | 24 ++++++++++++++++++++++++
 drivers/gpio/gpiolib.h      | 10 ----------
 include/linux/gpio/driver.h |  3 +++
 3 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index edffa0d2acaa..f84ad54d8dbd 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1058,6 +1058,30 @@ static struct gpio_chip *find_chip_by_name(const char *name)
 	return gpiochip_find((void *)name, gpiochip_match_name);
 }
 
+/**
+ * gpio_device_get() - Increase the reference count of this GPIO device
+ * @gdev: GPIO device to increase the refcount for
+ *
+ * Returns:
+ * Pointer to @gdev.
+ */
+struct gpio_device *gpio_device_get(struct gpio_device *gdev)
+{
+	return to_gpio_device(get_device(&gdev->dev));
+}
+EXPORT_SYMBOL_GPL(gpio_device_get);
+
+/**
+ * gpio_device_put() - Decrease the reference count of this GPIO device and
+ *                     possibly free all resources associated with it.
+ * @gdev: GPIO device to decrease the reference count for
+ */
+void gpio_device_put(struct gpio_device *gdev)
+{
+	put_device(&gdev->dev);
+}
+EXPORT_SYMBOL_GPL(gpio_device_put);
+
 #ifdef CONFIG_GPIOLIB_IRQCHIP
 
 /*
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 9bff5c2cf720..3ccacf3c1288 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -86,16 +86,6 @@ static inline struct gpio_device *to_gpio_device(struct device *dev)
 	return container_of(dev, struct gpio_device, dev);
 }
 
-static inline struct gpio_device *gpio_device_get(struct gpio_device *gdev)
-{
-	return to_gpio_device(get_device(&gdev->dev));
-}
-
-static inline void gpio_device_put(struct gpio_device *gdev)
-{
-	put_device(&gdev->dev);
-}
-
 /* gpio suffixes used for ACPI and device tree lookup */
 static __maybe_unused const char * const gpio_suffixes[] = { "gpios", "gpio" };
 
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 8f0859ba7065..a2060dc3344b 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -606,6 +606,9 @@ int devm_gpiochip_add_data_with_key(struct device *dev, struct gpio_chip *gc,
 struct gpio_chip *gpiochip_find(void *data,
 				int (*match)(struct gpio_chip *gc, void *data));
 
+struct gpio_device *gpio_device_get(struct gpio_device *gdev);
+void gpio_device_put(struct gpio_device *gdev);
+
 bool gpiochip_line_is_irq(struct gpio_chip *gc, unsigned int offset);
 int gpiochip_reqres_irq(struct gpio_chip *gc, unsigned int offset);
 void gpiochip_relres_irq(struct gpio_chip *gc, unsigned int offset);
-- 
2.39.2

