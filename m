Return-Path: <linux-acpi+bounces-212-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AC37B06FA
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A3DF92826B6
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAF9450C1
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:34:29 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F7038FB9
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 14:29:45 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5FB1A6
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 07:29:44 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40528376459so114553945e9.3
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 07:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695824982; x=1696429782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oE8FiVQ373WPhEqnnd0k+Q8JE+kP4cy31sdBOoqrMw8=;
        b=sbouSzjOVd8ltn4tAEi/FEWXTjCdMfo/mYaQjAD8QmocqofoCee9CszmOgufxFCVtr
         SFfMPymQLA0G8W/k7/mcZRtET+jNBkM8rX7EiZjyRaT125jzTpRbNQ67eI63mq1jXRah
         WuSkaaXuF9l0wTzAe1kINn/2XtV+wLSc1CWB1vRGhKxsiE8+5GDTJZJ1YQDt3dNcCyTj
         O9P5PLTNbfbAzdHcoS3JxAvyzq4YVaCeaLyAAdWtE1Jz0/Jfk2UN+BbJz0vniAx5Xc5M
         D2wxKsmbow5aOtGic4+UHZkV3PyRevTELg5eQTNEsOU0LP7PPOcwS5T4JBwn6ZIp80kQ
         INEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695824982; x=1696429782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oE8FiVQ373WPhEqnnd0k+Q8JE+kP4cy31sdBOoqrMw8=;
        b=W+ig2TecrIkTSazGcAE4fJoq+z1KPNSdfx4hYIBrebCJT7L7Lr3WxjrSfHmsQGNrbf
         a73Yr7h7/bHuZOPZOAs70yt/w7pBD1Z3Njclv/lvLYTECQ/jNmMyNULCdpDXCYKzrK4Z
         g9d8uGJwS2aeP1K8aQU0FliVUntUrtFmewx5v4i6zUFTWY4pd7kmapRP+P68i5yvdl59
         pgcqHXM7BNjbEw2/hoXRifyo5/Rf7oWjge5XbYnWBP+v84J0L7bXwXazPilXBlWB6TRy
         i1AguapE/meRecOTk40oa5M+39w7wp9V4HHokX9B5p8/pnS1/BI155OZ2TUPgGX67h4f
         jNCA==
X-Gm-Message-State: AOJu0YxRug2Dvk8iQIQNcTAwK4BoVqs2XuXIP2QSGL73jAc0wLfFs++P
	bP7uOvy0B6gD1SosLJr3vGqN6Q==
X-Google-Smtp-Source: AGHT+IENPJmvmWp0g+dGS8v34l0Gtx+t4X9kF9+AMSE7rr76Glskj8nT9+aAmH3ht7mwRdRjm2lEug==
X-Received: by 2002:a1c:4c13:0:b0:401:be77:9a50 with SMTP id z19-20020a1c4c13000000b00401be779a50mr2103103wmf.8.1695824982520;
        Wed, 27 Sep 2023 07:29:42 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4bb6:1525:9e22:4a15])
        by smtp.gmail.com with ESMTPSA id v2-20020a1cf702000000b003feae747ff2sm20448303wmh.35.2023.09.27.07.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 07:29:42 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 08/11] gpio: of: replace gpiochip_find_* with gpio_device_find_*
Date: Wed, 27 Sep 2023 16:29:28 +0200
Message-Id: <20230927142931.19798-9-brgl@bgdev.pl>
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

We're porting all users of gpiochip_find() to using gpio_device_find().
Update the OF GPIO code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-of.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 58c0bbe9d569..5ea97c14d77a 100644
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
@@ -372,7 +372,6 @@ static struct gpio_desc *of_get_named_gpiod_flags(const struct device_node *np,
 		     const char *propname, int index, enum of_gpio_flags *flags)
 {
 	struct of_phandle_args gpiospec;
-	struct gpio_chip *chip;
 	struct gpio_desc *desc;
 	int ret;
 
@@ -384,13 +383,15 @@ static struct gpio_desc *of_get_named_gpiod_flags(const struct device_node *np,
 		return ERR_PTR(ret);
 	}
 
-	chip = of_find_gpiochip_by_xlate(&gpiospec);
-	if (!chip) {
+	struct gpio_device *gdev __free(gpio_device_put) =
+				of_find_gpio_device_by_xlate(&gpiospec);
+	if (!gdev) {
 		desc = ERR_PTR(-EPROBE_DEFER);
 		goto out;
 	}
 
-	desc = of_xlate_and_get_gpiod_flags(chip, &gpiospec, flags);
+	desc = of_xlate_and_get_gpiod_flags(gpio_device_get_chip(gdev),
+					    &gpiospec, flags);
 	if (IS_ERR(desc))
 		goto out;
 
@@ -822,16 +823,16 @@ static int of_gpiochip_match_node(struct gpio_chip *chip, void *data)
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
@@ -848,11 +849,11 @@ static int of_gpio_notify(struct notifier_block *nb, unsigned long action,
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
@@ -865,11 +866,11 @@ static int of_gpio_notify(struct notifier_block *nb, unsigned long action,
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


