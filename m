Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C81792E56
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Sep 2023 21:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjIETIu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Sep 2023 15:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjIETIu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Sep 2023 15:08:50 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19815CFD
        for <linux-acpi@vger.kernel.org>; Tue,  5 Sep 2023 12:08:21 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99357737980so440871566b.2
        for <linux-acpi@vger.kernel.org>; Tue, 05 Sep 2023 12:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693940837; x=1694545637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Lyvqa4ehdDUPxRvhVu2QVwAbbRfiYfIlEbafqal+r0=;
        b=lEEqShX5an0woDEumjTRkdwov2J1Aamim6HKD7NWmSXmxtpGm51eKDmJj9mUoNNbBl
         mvqpyGajGth4QlpO6SfDV4jvUTp71yzQp4TpcodVrb7Yq15hwsZ0DcbmGkD5iCHVBikM
         iYarPmygjEg5cpixqZ6IvkDCiweejH/bUpXdaXtvi7scB4ai4K6W/upHmJmXeBAkKmNC
         FMdMlLQ/eTFkFsiCFubVUrtjZEPSMMDgMmsx3pEn82jlli8h7PY3DNKJaYSAvLAG+Xbl
         NmG6Y0zg8jdeAvhXKP8l/w0u7oZdBmcGyz2NJ6BipvJBHcrR479q2pE2sKO2x/I7v8P2
         qHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693940837; x=1694545637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Lyvqa4ehdDUPxRvhVu2QVwAbbRfiYfIlEbafqal+r0=;
        b=A6aJSFwZmlnatmNyKhOAYibTeCzA1zr1V8SX5mCHGYBM1xXHaf7PDzGL/GNVVqvRWo
         k1qHEybAPdqCi4fJTvJolLN88ERywCkA4XoiqmGEKU9qbfQkkTmi4rPu16D6+sxJrGzk
         5V9pL9VBJUqvr9TBNn9kih9d2oMacQV0EStQVn8n8/VFAf6OXVr4LUkeM537ar36W9st
         QCBx9iMUwNjI4YkxuZC4N3x/4byS/42XR+5Y9XrsnTVJysxedKIFeKS4+hq/Z/SmBQ0p
         fWZLvZidq3/4Ez5qt48sw9vIy/mEzl9fgo4Zo2UEvyLykmFb7YK4e++Abux7jwNWUpm5
         b9dQ==
X-Gm-Message-State: AOJu0YzKOxCi7VQMcpogM5AULrBdjtpxeNjcw+ltOnZhIZtYlDM/+MNt
        vA48JJM6ipqADE1fJQ02AciXq9VaTnVFxZ1mtvA=
X-Google-Smtp-Source: AGHT+IG/jv5LelRKHFkS+zSS/4W2MFsO0ZmIobecKNQDMGWNcj2BwZSzitK+fLdVa7TdoNhlKNwX4g==
X-Received: by 2002:a05:6000:1190:b0:313:f399:6cea with SMTP id g16-20020a056000119000b00313f3996ceamr489890wrx.4.1693940018296;
        Tue, 05 Sep 2023 11:53:38 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7a54:5dbc:6d09:48b7])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c249100b003fbc30825fbsm17550010wms.39.2023.09.05.11.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 11:53:37 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 10/21] gpiolib: replace find_chip_by_name() with gpio_device_find_by_label()
Date:   Tue,  5 Sep 2023 20:52:58 +0200
Message-Id: <20230905185309.131295-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230905185309.131295-1-brgl@bgdev.pl>
References: <20230905185309.131295-1-brgl@bgdev.pl>
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
---
 drivers/gpio/gpiolib.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 408f8a7753f9..90e8c3d8b6f6 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1161,18 +1161,6 @@ struct gpio_device *gpio_device_find_by_label(const char *label)
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
@@ -3924,21 +3912,22 @@ EXPORT_SYMBOL_GPL(gpiod_remove_lookup_table);
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
+			gpiochip_machine_hog(gdev->chip, hog);
 	}
 
 	mutex_unlock(&gpio_machine_hogs_mutex);
@@ -3999,7 +3988,7 @@ static struct gpio_desc *gpiod_find(struct device *dev, const char *con_id,
 		return desc;
 
 	for (p = &table->table[0]; p->key; p++) {
-		struct gpio_chip *gc;
+		struct gpio_device *gdev __free(gpio_device_put) = NULL;
 
 		/* idx must always match exactly */
 		if (p->idx != idx)
@@ -4021,9 +4010,8 @@ static struct gpio_desc *gpiod_find(struct device *dev, const char *con_id,
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
@@ -4036,15 +4024,15 @@ static struct gpio_desc *gpiod_find(struct device *dev, const char *con_id,
 			return ERR_PTR(-EPROBE_DEFER);
 		}
 
-		if (gc->ngpio <= p->chip_hwnum) {
+		if (gdev->chip->ngpio <= p->chip_hwnum) {
 			dev_err(dev,
 				"requested GPIO %u (%u) is out of range [0..%u] for chip %s\n",
-				idx, p->chip_hwnum, gc->ngpio - 1,
-				gc->label);
+				idx, p->chip_hwnum, gdev->chip->ngpio - 1,
+				gdev->chip->label);
 			return ERR_PTR(-EINVAL);
 		}
 
-		desc = gpiochip_get_desc(gc, p->chip_hwnum);
+		desc = gpiochip_get_desc(gdev->chip, p->chip_hwnum);
 		*flags = p->flags;
 
 		return desc;
-- 
2.39.2

