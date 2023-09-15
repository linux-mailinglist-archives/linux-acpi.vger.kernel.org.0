Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45ECC7A21C6
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Sep 2023 17:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbjIOPDv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Sep 2023 11:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbjIOPDp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Sep 2023 11:03:45 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656831FE0
        for <linux-acpi@vger.kernel.org>; Fri, 15 Sep 2023 08:03:40 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-404314388ceso22575055e9.2
        for <linux-acpi@vger.kernel.org>; Fri, 15 Sep 2023 08:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694790219; x=1695395019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edxEV8lZNyeIe2fc1/ECdrZnvrBbNnxqjxV4vEQlZ6k=;
        b=unxbODZv3/+gtWrSmauo07/beObjoMjXb5TxV71xYoUxGuCX1r8D2dTjXGFOmai2/Y
         DOnutSJkiccs2oWUcwtSnECWrNglBuV825scuvj8Dy0Qz/fd2woRrsCTXgUxhxKwui/J
         F/uxsbtzS39+xFRONRemEwYPLBajBym1iKAtshzTm4myf7dgcr85WT62tearrfM3VseN
         k1N2vxSOha7c4S5GL2/cbHhzklKMI3NUvEsWQ7MKN4IJ4HJeSzSQUvNL5RE74eSMu6vg
         m6ehkAPo3//DVlZRqJORrI3X39IiTo8aIGrbmsYLOSE4SZfj4fKlzx+pq5cCqlUU4K+D
         x/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694790219; x=1695395019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edxEV8lZNyeIe2fc1/ECdrZnvrBbNnxqjxV4vEQlZ6k=;
        b=BOimPmTt8UhVnKXU4MG6garhsH9otLpu7XW/YxP1gS3fWWuZvWC07ctu+CE4j5b12y
         ZZyJ+0evOQdGRqXF/B/xT5WazZwhDT7u6ve240Sb4RVQgsHIb56iUBabZuoNKlVH+fIW
         Uoc/gCls8Z02Y9GLqCdW5npXnu+CbrTgCXX7DB3IBSNAqoxmIzXqYwvfjxl8F389bruJ
         AeZg2lVXZ7XmdHot7u6z898LpQyTtRnB9eWFXgHqMOkqdx/lpQ9GAeFYI2r6ydiWWWFT
         BbS64EGfLTk+jEFXl7l+Mr1jpPGu0SqRBQvUEf+OkO1CYSDAmk00oM+2vEx9g5tXbs7z
         Nn+w==
X-Gm-Message-State: AOJu0Yzq53zPlTfiNmz3uTM/QLFZTiZvXuyWyD57cmcbuBzVIvMHSW3z
        CiZ9VwzCtkHYcX6qmMjracJ0bA==
X-Google-Smtp-Source: AGHT+IFfx4Vw8sI1KX54ZioumUficY0QqHvfFD61SdTbqEY3pEZjyIrAbN/Jg/gNRG5WmOBJUQ8CHg==
X-Received: by 2002:a7b:cc9a:0:b0:404:2dbb:8943 with SMTP id p26-20020a7bcc9a000000b004042dbb8943mr1889146wma.2.1694790218883;
        Fri, 15 Sep 2023 08:03:38 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:aa19:4569:aeeb:c0d3])
        by smtp.gmail.com with ESMTPSA id hn40-20020a05600ca3a800b003fef19bb55csm4853369wmb.34.2023.09.15.08.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 08:03:38 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 08/11] gpio: of: replace gpiochip_find_* with gpio_device_find_*
Date:   Fri, 15 Sep 2023 17:03:23 +0200
Message-Id: <20230915150327.81918-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230915150327.81918-1-brgl@bgdev.pl>
References: <20230915150327.81918-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We're porting all users of gpiochip_find() to using gpio_device_find().
Update the OF GPIO code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-of.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 5515f32cf19b..4987c86010c1 100644
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
 
@@ -375,13 +375,14 @@ static struct gpio_desc *of_get_named_gpiod_flags(const struct device_node *np,
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
+	desc = of_xlate_and_get_gpiod_flags(gpio_device_get_chip(gdev),
+					    &gpiospec, flags);
 	if (IS_ERR(desc))
 		goto out;
 
@@ -813,16 +814,16 @@ static int of_gpiochip_match_node(struct gpio_chip *chip, void *data)
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
@@ -839,11 +840,11 @@ static int of_gpio_notify(struct notifier_block *nb, unsigned long action,
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
@@ -856,11 +857,11 @@ static int of_gpio_notify(struct notifier_block *nb, unsigned long action,
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

