Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E0179CD52
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 12:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjILKI2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Sep 2023 06:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbjILKHs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Sep 2023 06:07:48 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CEE10EB
        for <linux-acpi@vger.kernel.org>; Tue, 12 Sep 2023 03:07:44 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31f7638be6eso4633901f8f.3
        for <linux-acpi@vger.kernel.org>; Tue, 12 Sep 2023 03:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694513262; x=1695118062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wn0WZO6Z9Iv9tVXCCKVBW/P7aG4mocAlzskQGft1Ggk=;
        b=roarD3Np9PPSsurYw9g0+mefrC+xDObkFL0TUzFSFRKILUDa6LD7jYaQmDd9s4u8Fl
         MZnE2fmLJTakPxydcaYEKXF+gXD4tXPrZ18YugPE+K1GTl/8lylBj3xAYFuZu+NcRyyG
         85Pmdroa97bgDazsWJjkorEVmJsvir51Q6cmlpQQb1FYV/YFFpbzXaVaLaM23n45iTza
         ECTNfgKrvu6WIW5CO5aOxw22jF8Aht1T1jDDkKwD4U2TIWB218+g3GKnqSkC7aVmjU5P
         V9al6W2XX7mFmgyjptVGWAglovNL8Xkhiv9kH93G9UGYqitItJPAOmQXg31pDsjg7pqT
         t/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694513262; x=1695118062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wn0WZO6Z9Iv9tVXCCKVBW/P7aG4mocAlzskQGft1Ggk=;
        b=DcmGHq3nODcvfId1JLT8vBHaAe02HEG4VnkX1rurKRQZzXW3M012g+h6gs8feE2ik9
         BOeL1lq9kRyuDb+UN6H4pFGkxaWca162pZvNA4Ak1g0sZOOKoOYIuKw29KkmtiOw3xJY
         vg7CFMUNsUbH/13Lo8anjT1m55RYM7+vGCDIrg6y5LHFOn+i6EroB+D/YqC4nFmvO9Im
         ENgyD6lvWLE/eKtOr5K9G2QLlqtJ3JG4LGtBDSt2rF3f1ixoyL/TjjGTN9sa5nmoNWtG
         EY+bTjTqdameki5qCoduf00AYuWq4kEdsGcLW2WPut6MwHroFxf0SNxsVThXIhX8BJJB
         FRCw==
X-Gm-Message-State: AOJu0YxLSlHW0zk/LzFTlmVNqr4fdG7pOd5EAi+R4xK8uMXniVxQ86va
        oAcy1bd9n5tmakCqUnOqY+noyQ==
X-Google-Smtp-Source: AGHT+IH2daZg8uXPJjhCYIl6GfQ86zNLYz2ol3af+dz2gM+RSOisg+3ShVkHoECGNO+/nJOnpRG5eg==
X-Received: by 2002:adf:fe8c:0:b0:317:c2a9:9b0c with SMTP id l12-20020adffe8c000000b00317c2a99b0cmr10362258wrr.50.1694513262659;
        Tue, 12 Sep 2023 03:07:42 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:907f:4cd7:f0ae:6b2a])
        by smtp.gmail.com with ESMTPSA id h5-20020adfe985000000b0031ae8d86af4sm12351417wrm.103.2023.09.12.03.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 03:07:42 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 08/11] gpio: of: replace gpiochip_find_* with gpio_device_find_*
Date:   Tue, 12 Sep 2023 12:07:24 +0200
Message-Id: <20230912100727.23197-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912100727.23197-1-brgl@bgdev.pl>
References: <20230912100727.23197-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We're porting all users of gpiochip_find() to using gpio_device_find().
Update the OF GPIO code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-of.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 5515f32cf19b..ff13aa079a22 100644
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
+		ret = of_gpiochip_add_hog(gpio_device_get_chip(gdev), rd->dn);
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
+		of_gpiochip_remove_hog(gpio_device_get_chip(gdev), rd->dn);
 		of_node_clear_flag(rd->dn, OF_POPULATED);
 		return NOTIFY_OK;
 	}
-- 
2.39.2

