Return-Path: <linux-acpi+bounces-214-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFF07B06FC
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 41701282534
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F15450CA
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:34:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C8F38FB9
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 14:29:47 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0040E1AB
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 07:29:45 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so8612675e9.0
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 07:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695824984; x=1696429784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEkEuyWHPwtkJqqx/zp65rsN/kW+vWLAZiPV4yAfo60=;
        b=T53P/S8/9T02hxwplxxwI5HIC6fr8wFlqdkgtP2ngolZGGyetwJ2OesfrNIJvamTYS
         1KidFj6uhuN1LYs8XhqPz5ftp/0k6f366XXwijR2Qf4JWqPqN5wyCrv74tQ62c0diTdQ
         NsVzgg2zhYJ3wN8S/odCzkspPbl76jzMgml5pMqbUFwkxZ/AB1VlA9/oCQxwwzNCfOlV
         klGOy0zium87DDvTYfDBzoeas+R4ddkY2mOYSlIUJSptOk8nanwVOEZMDIDTeI7xi1o8
         hvr8x787z1GFZz/bpcaWZsK39DcIgUnU9kbEE9XJy1RfF3wiy5cVAlNl4Pw+zBE/H4Rb
         kWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695824984; x=1696429784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEkEuyWHPwtkJqqx/zp65rsN/kW+vWLAZiPV4yAfo60=;
        b=KW4RuhFhEV/Mcdqar35yvdbaUviPaDzJ4vrJ1MOa+DZMdqNVjIhgShrLMMg3hA3YEK
         51JadH3cGZb86u6a8A89Ced8rCrzHqBJ5w/BmTAalxC8BEf/zfngGn8BeGQnqsHPwNpm
         u/azYm8qHMSHYn0NLSVb9/Q0MMSBKx0Nr7dl2YIjELIPSm1fIxn+tO2eLH3/oVSjGnHI
         K9VZTy09+W+Ip8MX0iCfCAkitvvqNRF9JOEF0PhoxvtrmxK/+vi0gEVzb834a29JFNt3
         HUGHRikO09yIV8ryutY1ghfQkvhBoIXsZcb06urIQq64ed0OAvKXMlHEy3eGf5LQeUBS
         WIvQ==
X-Gm-Message-State: AOJu0Yym2OcfaRN5L/JLXJOQH2S2B+oDovdqz8pNMaZQWBsWSdX4LAi2
	6WPClh4WflzUWJxlH4KF/5Mdtg==
X-Google-Smtp-Source: AGHT+IFNb8l5Y6LCipefds19t5fIoqseWun2vJIxoTJoGFcSPsfaLd8QhwvSbDrL6X4lB0QT/ACnZg==
X-Received: by 2002:a5d:67cd:0:b0:323:306e:65cf with SMTP id n13-20020a5d67cd000000b00323306e65cfmr2124281wrw.10.1695824984517;
        Wed, 27 Sep 2023 07:29:44 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4bb6:1525:9e22:4a15])
        by smtp.gmail.com with ESMTPSA id v2-20020a1cf702000000b003feae747ff2sm20448303wmh.35.2023.09.27.07.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 07:29:44 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 10/11] gpio: swnode: replace gpiochip_find() with gpio_device_find_by_label()
Date: Wed, 27 Sep 2023 16:29:30 +0200
Message-Id: <20230927142931.19798-11-brgl@bgdev.pl>
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
Update the swnode GPIO code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-swnode.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.c
index b5a6eaf3729b..fa52bdb1a29a 100644
--- a/drivers/gpio/gpiolib-swnode.c
+++ b/drivers/gpio/gpiolib-swnode.c
@@ -31,22 +31,17 @@ static void swnode_format_propname(const char *con_id, char *propname,
 		strscpy(propname, "gpios", max_size);
 }
 
-static int swnode_gpiochip_match_name(struct gpio_chip *chip, void *data)
+static struct gpio_device *swnode_get_gpio_device(struct fwnode_handle *fwnode)
 {
-	return !strcmp(chip->label, data);
-}
+	const struct software_node *gdev_node;
+	struct gpio_device *gdev;
 
-static struct gpio_chip *swnode_get_chip(struct fwnode_handle *fwnode)
-{
-	const struct software_node *chip_node;
-	struct gpio_chip *chip;
-
-	chip_node = to_software_node(fwnode);
-	if (!chip_node || !chip_node->name)
+	gdev_node = to_software_node(fwnode);
+	if (!gdev_node || !gdev_node->name)
 		return ERR_PTR(-EINVAL);
 
-	chip = gpiochip_find((void *)chip_node->name, swnode_gpiochip_match_name);
-	return chip ?: ERR_PTR(-EPROBE_DEFER);
+	gdev = gpio_device_find_by_label(gdev_node->name);
+	return gdev ?: ERR_PTR(-EPROBE_DEFER);
 }
 
 struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
@@ -55,7 +50,6 @@ struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
 {
 	const struct software_node *swnode;
 	struct fwnode_reference_args args;
-	struct gpio_chip *chip;
 	struct gpio_desc *desc;
 	char propname[32]; /* 32 is max size of property name */
 	int error;
@@ -77,12 +71,17 @@ struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
 		return ERR_PTR(error);
 	}
 
-	chip = swnode_get_chip(args.fwnode);
+	struct gpio_device *gdev __free(gpio_device_put) =
+					swnode_get_gpio_device(args.fwnode);
 	fwnode_handle_put(args.fwnode);
-	if (IS_ERR(chip))
-		return ERR_CAST(chip);
+	if (IS_ERR(gdev))
+		return ERR_CAST(gdev);
 
-	desc = gpiochip_get_desc(chip, args.args[0]);
+	/*
+	 * FIXME: The GPIO device reference is put at return but the descriptor
+	 * is passed on. Find a proper solution.
+	 */
+	desc = gpio_device_get_desc(gdev, args.args[0]);
 	*flags = args.args[1]; /* We expect native GPIO flags */
 
 	pr_debug("%s: parsed '%s' property of node '%pfwP[%d]' - status (%d)\n",
-- 
2.39.2


