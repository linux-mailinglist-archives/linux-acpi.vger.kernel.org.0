Return-Path: <linux-acpi+bounces-211-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340B07B06F9
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D8C4528262F
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08EB450C3
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:34:24 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F68438FBE
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 14:29:44 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33138196
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 07:29:43 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-405497850dbso92771195e9.0
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 07:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695824981; x=1696429781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iq/2l1G2X3VlbEMC4JGFIfoN51ntSJ8lHp3eH0L/8mM=;
        b=Zh0x/nQ8jDWZNzIy56w3kaBAtLR+osipmo88W5sFXVC33xhvCRFVY+qQLQLZzC/ol3
         28ZKDh8pc2n5a69EGixt07TL7L/R7LKHyX8MUk0l10Gt52hj9bb5rANxsC+jaUmi0DNI
         Nrt3yiUpII1G5b6KF0utSyif3vrpl0Y5fCgGImqPP/jHpvpLVna+ouOhPYcRkg1D4irN
         Mp2SO/AZUZto5GqMrb3KRJsQcFGWFd3AAIu7d7hUbGY7AHiLgBrc1xvIk9GUKN3cZGNQ
         f6GUivMKgotTrt2d0GhuGVkHbEiSdQqxJc7QEX1u0T3NE1HXCmDast4xGbfB4wVHvk6E
         3rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695824981; x=1696429781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iq/2l1G2X3VlbEMC4JGFIfoN51ntSJ8lHp3eH0L/8mM=;
        b=rBHBQ1aoX7x0WJxc//GCkRZ0ISTqjcqJ07pYyTqq4GU/tJ+wJt8dxYKJy8Z8MfiYH8
         XX1QipnFYq5FaXWA/I+QdQYwT1BYiGUaYfwdkLC8vqxcBTqMN4olkdNYbHRcBBpiupES
         iG/JMBX+MBDXyR64mM7faznxxgnZm64piKUVIcP8vuy178yr/Z/XmT4PwIDgYdXWjyHl
         WphwQHJyUV+X7JUCgs6S05szJdwcEXCUZMRlOpoc9EoqA03409wmPVs5lbppZCmRjjQo
         aLuHeuqmO1Fv824vZJpAfH5K+/jzENImQ+kVmK52WeslcQRQ0yteSzgjenGMOTeL4ZRf
         /vkQ==
X-Gm-Message-State: AOJu0YyO5iuehUgyVu5KLhTDnuTF4M4c6mFlXLrGeSfjk9+hLzgjvhba
	AMVJIiGLMFaiy7gBZxrfYpThNA==
X-Google-Smtp-Source: AGHT+IFU9IDzdf2ZIm4nyCEV/MO/SgU3zg+UywTSBTwfjeOrDNNF5wj3OyDSLmSd/5oKq9WWO+fWrg==
X-Received: by 2002:a05:600c:230b:b0:405:3955:5872 with SMTP id 11-20020a05600c230b00b0040539555872mr1986626wmo.18.1695824981656;
        Wed, 27 Sep 2023 07:29:41 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4bb6:1525:9e22:4a15])
        by smtp.gmail.com with ESMTPSA id v2-20020a1cf702000000b003feae747ff2sm20448303wmh.35.2023.09.27.07.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 07:29:41 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 07/11] gpiolib: replace find_chip_by_name() with gpio_device_find_by_label()
Date: Wed, 27 Sep 2023 16:29:27 +0200
Message-Id: <20230927142931.19798-8-brgl@bgdev.pl>
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
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Remove all remaining uses of find_chip_by_name() (and subsequently:
gpiochip_find()) from gpiolib.c and use the new
gpio_device_find_by_label() instead.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e26cbd10a246..dcdac508dcd4 100644
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
@@ -3908,7 +3896,6 @@ EXPORT_SYMBOL_GPL(gpiod_remove_lookup_table);
  */
 void gpiod_add_hogs(struct gpiod_hog *hogs)
 {
-	struct gpio_chip *gc;
 	struct gpiod_hog *hog;
 
 	mutex_lock(&gpio_machine_hogs_mutex);
@@ -3920,9 +3907,10 @@ void gpiod_add_hogs(struct gpiod_hog *hogs)
 		 * The chip may have been registered earlier, so check if it
 		 * exists and, if so, try to hog the line now.
 		 */
-		gc = find_chip_by_name(hog->chip_label);
-		if (gc)
-			gpiochip_machine_hog(gc, hog);
+		struct gpio_device *gdev __free(gpio_device_put) =
+				gpio_device_find_by_label(hog->chip_label);
+		if (gdev)
+			gpiochip_machine_hog(gpio_device_get_chip(gdev), hog);
 	}
 
 	mutex_unlock(&gpio_machine_hogs_mutex);
@@ -3977,14 +3965,13 @@ static struct gpio_desc *gpiod_find(struct device *dev, const char *con_id,
 	struct gpio_desc *desc = ERR_PTR(-ENOENT);
 	struct gpiod_lookup_table *table;
 	struct gpiod_lookup *p;
+	struct gpio_chip *gc;
 
 	table = gpiod_find_lookup_table(dev);
 	if (!table)
 		return desc;
 
 	for (p = &table->table[0]; p->key; p++) {
-		struct gpio_chip *gc;
-
 		/* idx must always match exactly */
 		if (p->idx != idx)
 			continue;
@@ -4005,9 +3992,9 @@ static struct gpio_desc *gpiod_find(struct device *dev, const char *con_id,
 			return ERR_PTR(-EPROBE_DEFER);
 		}
 
-		gc = find_chip_by_name(p->key);
-
-		if (!gc) {
+		struct gpio_device *gdev __free(gpio_device_put) =
+					gpio_device_find_by_label(p->key);
+		if (!gdev) {
 			/*
 			 * As the lookup table indicates a chip with
 			 * p->key should exist, assume it may
@@ -4020,6 +4007,8 @@ static struct gpio_desc *gpiod_find(struct device *dev, const char *con_id,
 			return ERR_PTR(-EPROBE_DEFER);
 		}
 
+		gc = gpio_device_get_chip(gdev);
+
 		if (gc->ngpio <= p->chip_hwnum) {
 			dev_err(dev,
 				"requested GPIO %u (%u) is out of range [0..%u] for chip %s\n",
@@ -4028,7 +4017,7 @@ static struct gpio_desc *gpiod_find(struct device *dev, const char *con_id,
 			return ERR_PTR(-EINVAL);
 		}
 
-		desc = gpiochip_get_desc(gc, p->chip_hwnum);
+		desc = gpio_device_get_desc(gdev, p->chip_hwnum);
 		*flags = p->flags;
 
 		return desc;
-- 
2.39.2


