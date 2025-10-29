Return-Path: <linux-acpi+bounces-18335-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFDDC1A771
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 14:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 362261890522
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 12:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713D43563DD;
	Wed, 29 Oct 2025 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="b8vPVpOF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88543355812
	for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 12:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740947; cv=none; b=aJyX87qZiiVNz3ul+xiGZ5r+t48IwAHFMwP96zlHqr2si64QXClDoYA0b/S6etH1l8Vkp8iV1WvjCDvM3YJ+ImQNSihzLeAaXo+qHOd5IsbuoYHvXwzSTcL7Za8U0gqaUsJ+rez9cKSyIR3OrVvo0q1DCC0Y3pbM9fa9fH3mKQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740947; c=relaxed/simple;
	bh=RkTFxLSEsp+4zVxAcSqedLbjCQMJog5pe/IGgkn9Blc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FaU1Cu8rRzmLgUGhqtOTv5FGn4wbVTqkRjMY3iO9vXsUpKi4n0KlC3EegsD2ki2Er+IV6dh1lW7UWqDqTjTOCfBIm+qbVPJNjGarzoA0GnpGwUBUKrz3pvuluCqCEaEjF7iJQ+2duA+871CoPzqC4dGslCiEhAP1fs3HrU1qmVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=b8vPVpOF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4711b95226dso90885465e9.0
        for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 05:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761740944; x=1762345744; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fLlXh7xAPYabDwn/ZAn4Njm2Di9lLltNrVWmb7Qyaxc=;
        b=b8vPVpOF5wt9JlDaTglgD4QvG2xgIKO64CMm2T+dVkWaLVXk+ixqgYs54Ous4h5sVD
         /P5u1U7tdK1tzj9xNwl+RITgy3dhL+Uu1I6nBwPQqLJb+pfHHeKKG7rwr6O4QmEMdFP4
         mTiqoC9Fk083yNJP7l2NzxRwxzXfvyGaKJ6Kkp3OcJtpBi/n/Mxg3gk0MjcVp1PFReEi
         vNMXQTKaN2QoMiyddEhTxXVXARDdbD2Zfy1P6/g4Wi/EPodAIKlkvuCBYeGCnHS79Qff
         dEvG0uYjsdlOQkYPEdZkZ5/TKRfTAgZWe6CC+aEDphgpyLqMMAvEuWr6LTdbnmkrZyup
         tXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761740944; x=1762345744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLlXh7xAPYabDwn/ZAn4Njm2Di9lLltNrVWmb7Qyaxc=;
        b=pTHoXvTluB1f77oddGdyfRgChxrYmvqIHzuIP2S65au42X1cHYp6UDo2vx/6AqVC76
         tQQ8CSoIPzaZ0GscVWdHEWdSWghBbDgUqSQb/i4ZvdFUpZeetVG0Bi0FDLkzygy1uZoi
         V0Am42SHLMVOF2Vl0pvPRzVrN+G03iQihC7DttuDy9lyUVtmyvmQI7024h+B0LTXUTHo
         TQaO+6zUf4JWmYPrPHiAJz2EymmKvPBDNk0o2NDHPxz1sGsyi7OUZc8TNJdrYU9DybV7
         bVLMyznhCMGObXWcP67MvmFJH8ciiDc4Ou0hd/XKi+A+5IQx0gpEZgW0q9R8Hwu1wk70
         Ce0g==
X-Forwarded-Encrypted: i=1; AJvYcCWplvD7yHHZOL2F1CZj9Jue8BJGwGP1fYCeXQk5HdC4/Wn5gxtRWt4IpBUMVitqe9TsUQDUQov7aU+W@vger.kernel.org
X-Gm-Message-State: AOJu0YznhzPZ8/ruiY7Djqt1ErGT/SawaPTrNVJkv5APKvwOnrPly7GG
	EnHxyVr6VLzrbygpO2GoIgkRLMBv/2C3lf6N7Z/se2mPCIzTi+eE7XskndhSoWkUor8=
X-Gm-Gg: ASbGncvtCI9vObbNHpTq0hF7Qo+1HSYmfMkZbEeCWAmRpOlnZLc+MHLSpGsofrUjjLY
	d8j0fwW4NYZNG6d+LyOkHKFFRuq9c9RD7I2RFBdA8f3qaV41ogKiJldRWMUJlnHwnVj2rPUczOl
	Z+uDfSxDyuMndMXos45lzVdS8V59mSpooid9WTwehuJDEKiqr7PGROul0DivnZQxp5/3brTQtiN
	a7xxgXrN2lLr8UsJKfNk1BAsckcVnp20geKTJHMS7HQsW3pObCkAFsCgSz4mwHUq3fq15UYV/A/
	2KNJT38Bayc+c4B/d3azRXaPRFTvFS6bYj8XVesm222Z6pN/msCtUAgszoHVc8/wbu6ZIszNBRU
	QNy++b38esu7L05oZ32xb6SDXZluNDYpKnKrdMumtdeAis6TPmWJK2pohs5Vdr28M0c/NMlE/B9
	QZwOqm
X-Google-Smtp-Source: AGHT+IEmrlNYM4/BKZqEWQR8ej984BigmtUtonPiP+Xp70NP3czZd0lZUVc4JnSScrAAUADLMfErCw==
X-Received: by 2002:a05:600c:4450:b0:459:db7b:988e with SMTP id 5b1f17b1804b1-4771e3a1a0emr23887935e9.13.1761740943967;
        Wed, 29 Oct 2025 05:29:03 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69f2:5f2d:9ffc:a805])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3a88fdsm52775545e9.10.2025.10.29.05.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 05:29:02 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 Oct 2025 13:28:43 +0100
Subject: [PATCH v3 09/10] reset: gpio: convert the driver to using the
 auxiliary bus
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-reset-gpios-swnodes-v3-9-638a4cb33201@linaro.org>
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
In-Reply-To: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5084;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=36bSfD/pPj/bUmmxO7m0DLd6JwfWjaAwqV7NJKDs28Q=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpAgh/goZqLc2KGk7epetCE27WSzRyl46u5UE7j
 gNZmTvBFQGJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQIIfwAKCRARpy6gFHHX
 ckj8EADSykcIYcrf2Z9hVqZCvlpGv0gIcuMx1QaEkgH7lEnGn2XEPXP9Zvw8h4w2i5pbKINMSoG
 Y6/K2NUfD7UEh79q/RlFIaxzj5h/KYfzvjQGRC86mEZ0vh8QOYcN18O4O1xpAffV+9Q/XaA8UHT
 Zwj2SntueTZDRz1gMx1aDndelqLkswQ3F1NF+4lrhUqQ24SmMTJloAQxvPv5aQzJFpIMSVGtugW
 cU/rVt6FqGBx9VOEY35UxN2euJPI2zscEbI3qUFv5+kJjvPyWnNBkMdAxbbrkOfMCrkwXj4FD1G
 t2tljA2CBbYwA6nc4eICr980HvM2/+qtsa+oaQUC3vlvlgNqu1g5o7B55M9bHKbrul4E17wrx0X
 xB6WIOwdvLNKzGRLIAQ7EyXaVjy4KC2PU5r6t+8WprcUB7+7uw7KSndXJNThsYo0O79yHxzf6IK
 6XiT111Rj0fCgb3x59vrNbOtsMPayO/tWY/cwMb7Fn5Wl6zaJ1U0uxkbnaHy+CfCZRT4vds6qRI
 4AEm2WglVc+LmibGLgmNWUy3BwL9F6nfG1ZiIRHLeyQxjysrgwjM6mv7oSTPtkcnbIMXtCC4JMr
 bKWXQJZZ3CyhGl3mGTJuCBSZiaY7y5m9MsIISyzXxrSh045VhUwGUfG0Oh8JtB8pb9fLV1ZVUjR
 XvRIvQmdgyruApQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

As the reset-gpio devices are purely virtual and never instantiated from
real firmware nodes, let's convert the driver to using the - more
fitting - auxiliary bus.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/reset/Kconfig      |  1 +
 drivers/reset/core.c       | 14 ++++++--------
 drivers/reset/reset-gpio.c | 19 ++++++++++---------
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 3102f5d7a93690f262722733e475b1215f61051c..24c9048cc7a31d3a6c9fb9af0726a8387bb3154a 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -89,6 +89,7 @@ config RESET_EYEQ
 config RESET_GPIO
 	tristate "GPIO reset controller"
 	depends on GPIOLIB
+	select AUXILIARY_BUS
 	help
 	  This enables a generic reset controller for resets attached via
 	  GPIOs.  Typically for OF platforms this driver expects "reset-gpios"
diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 13236ab69f10ec80e19b982be2bee5e4b0f99388..e129c4c803eaa7e7e7122d96e9eff187f8dd826f 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -7,6 +7,7 @@
 
 #include <linux/acpi.h>
 #include <linux/atomic.h>
+#include <linux/auxiliary_bus.h>
 #include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -18,7 +19,6 @@
 #include <linux/kref.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
@@ -882,7 +882,7 @@ static int __reset_add_reset_gpio_lookup(struct gpio_device *gdev, int id,
 	if (!lookup)
 		return -ENOMEM;
 
-	lookup->dev_id = kasprintf(GFP_KERNEL, "reset-gpio.%d", id);
+	lookup->dev_id = kasprintf(GFP_KERNEL, "reset.gpio.%d", id);
 	if (!lookup->dev_id)
 		return -ENOMEM;
 
@@ -903,7 +903,7 @@ static int __reset_add_reset_gpio_lookup(struct gpio_device *gdev, int id,
 static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 {
 	struct reset_gpio_lookup *rgpio_dev;
-	struct platform_device *pdev;
+	struct auxiliary_device *adev;
 	int id, ret;
 
 	/*
@@ -959,11 +959,9 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 	 * Hold reference as long as rgpio_dev memory is valid.
 	 */
 	of_node_get(rgpio_dev->of_args.np);
-	pdev = platform_device_register_data(gpio_device_to_device(gdev),
-					     "reset-gpio", id,
-					     &rgpio_dev->of_args,
-					     sizeof(rgpio_dev->of_args));
-	ret = PTR_ERR_OR_ZERO(pdev);
+	adev = auxiliary_device_create(gpio_device_to_device(gdev), "reset",
+				       "gpio", &rgpio_dev->of_args, id);
+	ret = PTR_ERR_OR_ZERO(adev);
 	if (ret)
 		goto err_put;
 
diff --git a/drivers/reset/reset-gpio.c b/drivers/reset/reset-gpio.c
index 2290b25b6703536f2245f15cab870bd7092d3453..e5512b3b596b5290af20e5fdd99a38f81e670d2b 100644
--- a/drivers/reset/reset-gpio.c
+++ b/drivers/reset/reset-gpio.c
@@ -1,10 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/auxiliary_bus.h>
 #include <linux/gpio/consumer.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 
 struct reset_gpio_priv {
@@ -61,9 +61,10 @@ static void reset_gpio_of_node_put(void *data)
 	of_node_put(data);
 }
 
-static int reset_gpio_probe(struct platform_device *pdev)
+static int reset_gpio_probe(struct auxiliary_device *adev,
+			    const struct auxiliary_device_id *id)
 {
-	struct device *dev = &pdev->dev;
+	struct device *dev = &adev->dev;
 	struct of_phandle_args *platdata = dev_get_platdata(dev);
 	struct reset_gpio_priv *priv;
 	int ret;
@@ -75,7 +76,7 @@ static int reset_gpio_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, &priv->rc);
+	auxiliary_set_drvdata(adev, &priv->rc);
 
 	priv->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(priv->reset))
@@ -99,20 +100,20 @@ static int reset_gpio_probe(struct platform_device *pdev)
 	return devm_reset_controller_register(dev, &priv->rc);
 }
 
-static const struct platform_device_id reset_gpio_ids[] = {
-	{ .name = "reset-gpio", },
+static const struct auxiliary_device_id reset_gpio_ids[] = {
+	{ .name = "reset.gpio" },
 	{}
 };
-MODULE_DEVICE_TABLE(platform, reset_gpio_ids);
+MODULE_DEVICE_TABLE(auxiliary, reset_gpio_ids);
 
-static struct platform_driver reset_gpio_driver = {
+static struct auxiliary_driver reset_gpio_driver = {
 	.probe		= reset_gpio_probe,
 	.id_table	= reset_gpio_ids,
 	.driver	= {
 		.name = "reset-gpio",
 	},
 };
-module_platform_driver(reset_gpio_driver);
+module_auxiliary_driver(reset_gpio_driver);
 
 MODULE_AUTHOR("Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>");
 MODULE_DESCRIPTION("Generic GPIO reset driver");

-- 
2.48.1


