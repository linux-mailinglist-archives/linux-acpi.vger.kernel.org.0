Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F75792F31
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Sep 2023 21:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjIEToJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Sep 2023 15:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjIEToI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Sep 2023 15:44:08 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36519B
        for <linux-acpi@vger.kernel.org>; Tue,  5 Sep 2023 12:44:04 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50098cc8967so4572967e87.1
        for <linux-acpi@vger.kernel.org>; Tue, 05 Sep 2023 12:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693943043; x=1694547843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qoy9g9WNv1Ww8bf2JXz77er47AU9+iMJIALN2tP54MA=;
        b=Z8r6tXK6Zu2yUx7QdkXCd7HpI0TlUC4AIFxSOZIljqeL/YzDuYg7UABcN3AyhVaotO
         aZJ9r+E2TH8UpEh6cK/0yiMLjhO5aVwHm10ALo75na4pDV7Ac5mxrmN/FsBa9P2JG6Nk
         rybK/RGnKwvIbIQIDtI8aKS/0rEqM7HWo7d27UPH/Viq8dSc12hidPyWBF+ETy0Fw9R1
         cqDl8B8nX0PIBuVo6m20tOVzNQC3mZEjxiR4eTdWXYE4j7zHccHZg02ozYCT3IL9Bzvh
         tsAKypJWMnQAVnLFlUWc/wWNiLDYtetDc0BtiTVGekiCKWCdE9avcJS+uiu6lG7tZBtd
         Uz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693943043; x=1694547843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qoy9g9WNv1Ww8bf2JXz77er47AU9+iMJIALN2tP54MA=;
        b=SNcBAmQNHqrpnTYZctTRjZ3FbpcJO1NHipu6jlHzOd/VN5dxgKiz2R2xu5uPFr5l46
         AHGcHXOey544eVwcXokgO1J5wfWfjzIxCzAlZvkessH/boocA6WOLNb2Nn66aA6L1EIE
         Yuuu1WGUHaApQRMTrN53aG8WSJ4DZRm8S/ch0g3dAAN0XI5usKcdZ3YwbsiUxsDWM8Yw
         8aP/ndYMv4eRT9JKmnfY2XiPPWQfOEy+i8XWMVgDgSoVgBK6az9s3K2RJQi7EVzLrh2J
         2elAbl+OjJ/r6RC4kgoiErvoNm62jSeu/+TRXD6QPWnVcjfiYZnMZoiw99/cljwyNxiL
         3AxA==
X-Gm-Message-State: AOJu0YxxLRxrSmATld8+lKlCbbIgiKsepOmc7u2+8ed0upz7t4fyMx4J
        xKZnHaXbSxyB3+CX+e3xzE474OXX7Xoh7z1HRkY=
X-Google-Smtp-Source: AGHT+IEhmajciJS3QAdA7TBRkBY7WkAdGBWeYPoavCET0UXaCYTtsM/vkqxleFzUGMa3M4KOPl8b/g==
X-Received: by 2002:a05:600c:2945:b0:3fe:d1e9:e6b8 with SMTP id n5-20020a05600c294500b003fed1e9e6b8mr470001wmd.12.1693940026666;
        Tue, 05 Sep 2023 11:53:46 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7a54:5dbc:6d09:48b7])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c249100b003fbc30825fbsm17550010wms.39.2023.09.05.11.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 11:53:46 -0700 (PDT)
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
Subject: [PATCH 17/21] gpio: of: replace gpiochip_find_* with gpio_device_find_*
Date:   Tue,  5 Sep 2023 20:53:05 +0200
Message-Id: <20230905185309.131295-18-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230905185309.131295-1-brgl@bgdev.pl>
References: <20230905185309.131295-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We're porting all users of gpiochip_find() to using gpio_device_find().
Update the OF GPIO code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-of.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 5515f32cf19b..9b087f93e049 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -127,10 +127,10 @@ static int of_gpiochip_match_node_and_xlate(struct gpio_chip *chip, void *data)
 				chip->of_xlate(chip, gpiospec, NULL) >= 0;
 }
 
-static struct gpio_chip *of_find_gpiochip_by_xlate(
-					struct of_phandle_args *gpiospec)
+static struct gpio_device *
+of_find_gpio_device_by_xlate(struct of_phandle_args *gpiospec)
 {
-	return gpiochip_find(gpiospec, of_gpiochip_match_node_and_xlate);
+	return gpio_device_find(gpiospec, of_gpiochip_match_node_and_xlate);
 }
 
 static struct gpio_desc *of_xlate_and_get_gpiod_flags(struct gpio_chip *chip,
@@ -362,8 +362,8 @@ static void of_gpio_flags_quirks(const struct device_node *np,
 static struct gpio_desc *of_get_named_gpiod_flags(const struct device_node *np,
 		     const char *propname, int index, enum of_gpio_flags *flags)
 {
+	struct gpio_device *gdev __free(gpio_device_put) = NULL;
 	struct of_phandle_args gpiospec;
-	struct gpio_chip *chip;
 	struct gpio_desc *desc;
 	int ret;
 
@@ -375,13 +375,13 @@ static struct gpio_desc *of_get_named_gpiod_flags(const struct device_node *np,
 		return ERR_PTR(ret);
 	}
 
-	chip = of_find_gpiochip_by_xlate(&gpiospec);
-	if (!chip) {
+	gdev = of_find_gpio_device_by_xlate(&gpiospec);
+	if (!gdev) {
 		desc = ERR_PTR(-EPROBE_DEFER);
 		goto out;
 	}
 
-	desc = of_xlate_and_get_gpiod_flags(chip, &gpiospec, flags);
+	desc = of_xlate_and_get_gpiod_flags(gdev->chip, &gpiospec, flags);
 	if (IS_ERR(desc))
 		goto out;
 
@@ -813,16 +813,16 @@ static int of_gpiochip_match_node(struct gpio_chip *chip, void *data)
 	return device_match_of_node(&chip->gpiodev->dev, data);
 }
 
-static struct gpio_chip *of_find_gpiochip_by_node(struct device_node *np)
+static struct gpio_device *of_find_gpio_device_by_node(struct device_node *np)
 {
-	return gpiochip_find(np, of_gpiochip_match_node);
+	return gpio_device_find(np, of_gpiochip_match_node);
 }
 
 static int of_gpio_notify(struct notifier_block *nb, unsigned long action,
 			  void *arg)
 {
+	struct gpio_device *gdev __free(gpio_device_put) = NULL;
 	struct of_reconfig_data *rd = arg;
-	struct gpio_chip *chip;
 	int ret;
 
 	/*
@@ -839,11 +839,11 @@ static int of_gpio_notify(struct notifier_block *nb, unsigned long action,
 		if (of_node_test_and_set_flag(rd->dn, OF_POPULATED))
 			return NOTIFY_DONE;
 
-		chip = of_find_gpiochip_by_node(rd->dn->parent);
-		if (chip == NULL)
+		gdev = of_find_gpio_device_by_node(rd->dn->parent);
+		if (!gdev)
 			return NOTIFY_DONE;	/* not for us */
 
-		ret = of_gpiochip_add_hog(chip, rd->dn);
+		ret = of_gpiochip_add_hog(gdev->chip, rd->dn);
 		if (ret < 0) {
 			pr_err("%s: failed to add hogs for %pOF\n", __func__,
 			       rd->dn);
@@ -856,11 +856,11 @@ static int of_gpio_notify(struct notifier_block *nb, unsigned long action,
 		if (!of_node_check_flag(rd->dn, OF_POPULATED))
 			return NOTIFY_DONE;	/* already depopulated */
 
-		chip = of_find_gpiochip_by_node(rd->dn->parent);
-		if (chip == NULL)
+		gdev = of_find_gpio_device_by_node(rd->dn->parent);
+		if (!gdev)
 			return NOTIFY_DONE;	/* not for us */
 
-		of_gpiochip_remove_hog(chip, rd->dn);
+		of_gpiochip_remove_hog(gdev->chip, rd->dn);
 		of_node_clear_flag(rd->dn, OF_POPULATED);
 		return NOTIFY_OK;
 	}
-- 
2.39.2

