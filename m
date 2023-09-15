Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64F87A21C8
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Sep 2023 17:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbjIOPDx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Sep 2023 11:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235862AbjIOPDo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Sep 2023 11:03:44 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E95211E
        for <linux-acpi@vger.kernel.org>; Fri, 15 Sep 2023 08:03:39 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-404c023ef5eso2589105e9.2
        for <linux-acpi@vger.kernel.org>; Fri, 15 Sep 2023 08:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694790218; x=1695395018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n58Dhj0yqYdpmSQPkjKhq0W6VxWWLeN7p34YZuk8uDg=;
        b=SwHMEoMHrQ46jSXfhSbUhB7JoShVJg5QKC/R+9Sabb9JmeDEHLtUw+VHymmBi6zVxz
         9SkGiIcUnexESESBSuXLNL9TMwghUHAM7SfSGT5VRJxTtcBTI5r5vyzfHgUtFAx8R+RO
         CUMb1VKn3NMlkIG+cKGMlh8Ky7N1aohoV2u176A2goDbfdSbu9FN+7tMdvd0BVuU/t6a
         AIA4xWCgaryQrgEZq3seZRFOn1Ec3XE1DV0W5YSL2qjogD26iRgk1CwwOjGgDKtA9IwI
         qPOOnZ79yF9jx9Xx8nuiFAHJ9f62mvIVRqfPbn+hIk4krs1TLC7vvR/iKliX0r5kBoOY
         ywxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694790218; x=1695395018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n58Dhj0yqYdpmSQPkjKhq0W6VxWWLeN7p34YZuk8uDg=;
        b=rWvhjfzaoax7GFqZRgNGSjXWIhsaaM88FX4UBkZ28WosZjLgMnt6gHWSFMjqzJrEet
         8T2sc3RrDixed4Zr4fl03U1gsISZ1ua0FRvR85lOSlmxKuCTn8KnysrUSWJPxQy1sgrV
         fvE3ugtlBeQY5xBUKHrixd5w8nEubppQ34KtPuGwhW9Yd+gAqW+IidvxoiHI+dlV9YMQ
         Ovejw2r1nS+Z7ssCcK3r7tlshHuS10itFt8ooNLx2wMCwN2XmESk4gPtdovBcNQc/kJh
         s1FKKwIqElGilklGAH3BdaJmxT5OoJKC47tmtAXMkH/jiZzfpXKawz5f2zYLdLUU4AEv
         hyeA==
X-Gm-Message-State: AOJu0YwbLEfP5OuF8kgEecEgz9NQX7r0aPT1fYWV5j8j8mRrA3lGaTQc
        uL0w+I1Niyiqq7TKGAP7Fkcu6A==
X-Google-Smtp-Source: AGHT+IExBcM+4R9ST2+0cDoc4050urd9MUFqBjzaXfqR6IDJWFrCHLnzQmrxAJCB0F+lHz6OmUFi0w==
X-Received: by 2002:a05:600c:b52:b0:401:eb0:a974 with SMTP id k18-20020a05600c0b5200b004010eb0a974mr2046484wmr.3.1694790217924;
        Fri, 15 Sep 2023 08:03:37 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:aa19:4569:aeeb:c0d3])
        by smtp.gmail.com with ESMTPSA id hn40-20020a05600ca3a800b003fef19bb55csm4853369wmb.34.2023.09.15.08.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 08:03:37 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 07/11] gpiolib: replace find_chip_by_name() with gpio_device_find_by_label()
Date:   Fri, 15 Sep 2023 17:03:22 +0200
Message-Id: <20230915150327.81918-8-brgl@bgdev.pl>
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

Remove all remaining uses of find_chip_by_name() (and subsequently:
gpiochip_find()) from gpiolib.c and use the new
gpio_device_find_by_label() instead.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e26cbd10a246..4c734bfe6d32 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1145,18 +1145,6 @@ struct gpio_device *gpio_device_find_by_label(const char *label)
 }
 EXPORT_SYMBOL_GPL(gpio_device_find_by_label);
 
-static int gpiochip_match_name(struct gpio_chip *gc, void *data)
-{
-	const char *name = data;
-
-	return !strcmp(gc->label, name);
-}
-
-static struct gpio_chip *find_chip_by_name(const char *name)
-{
-	return gpiochip_find((void *)name, gpiochip_match_name);
-}
-
 /**
  * gpio_device_get() - Increase the reference count of this GPIO device
  * @gdev: GPIO device to increase the refcount for
@@ -3908,21 +3896,22 @@ EXPORT_SYMBOL_GPL(gpiod_remove_lookup_table);
  */
 void gpiod_add_hogs(struct gpiod_hog *hogs)
 {
-	struct gpio_chip *gc;
 	struct gpiod_hog *hog;
 
 	mutex_lock(&gpio_machine_hogs_mutex);
 
 	for (hog = &hogs[0]; hog->chip_label; hog++) {
+		struct gpio_device *gdev __free(gpio_device_put) = NULL;
+
 		list_add_tail(&hog->list, &gpio_machine_hogs);
 
 		/*
 		 * The chip may have been registered earlier, so check if it
 		 * exists and, if so, try to hog the line now.
 		 */
-		gc = find_chip_by_name(hog->chip_label);
-		if (gc)
-			gpiochip_machine_hog(gc, hog);
+		gdev = gpio_device_find_by_label(hog->chip_label);
+		if (gdev)
+			gpiochip_machine_hog(gpio_device_get_chip(gdev), hog);
 	}
 
 	mutex_unlock(&gpio_machine_hogs_mutex);
@@ -3977,13 +3966,14 @@ static struct gpio_desc *gpiod_find(struct device *dev, const char *con_id,
 	struct gpio_desc *desc = ERR_PTR(-ENOENT);
 	struct gpiod_lookup_table *table;
 	struct gpiod_lookup *p;
+	struct gpio_chip *gc;
 
 	table = gpiod_find_lookup_table(dev);
 	if (!table)
 		return desc;
 
 	for (p = &table->table[0]; p->key; p++) {
-		struct gpio_chip *gc;
+		struct gpio_device *gdev __free(gpio_device_put) = NULL;
 
 		/* idx must always match exactly */
 		if (p->idx != idx)
@@ -4005,9 +3995,8 @@ static struct gpio_desc *gpiod_find(struct device *dev, const char *con_id,
 			return ERR_PTR(-EPROBE_DEFER);
 		}
 
-		gc = find_chip_by_name(p->key);
-
-		if (!gc) {
+		gdev = gpio_device_find_by_label(p->key);
+		if (!gdev) {
 			/*
 			 * As the lookup table indicates a chip with
 			 * p->key should exist, assume it may
@@ -4020,6 +4009,8 @@ static struct gpio_desc *gpiod_find(struct device *dev, const char *con_id,
 			return ERR_PTR(-EPROBE_DEFER);
 		}
 
+		gc = gpio_device_get_chip(gdev);
+
 		if (gc->ngpio <= p->chip_hwnum) {
 			dev_err(dev,
 				"requested GPIO %u (%u) is out of range [0..%u] for chip %s\n",
@@ -4028,7 +4019,7 @@ static struct gpio_desc *gpiod_find(struct device *dev, const char *con_id,
 			return ERR_PTR(-EINVAL);
 		}
 
-		desc = gpiochip_get_desc(gc, p->chip_hwnum);
+		desc = gpio_device_get_desc(gdev, p->chip_hwnum);
 		*flags = p->flags;
 
 		return desc;
-- 
2.39.2

