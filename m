Return-Path: <linux-acpi+bounces-18525-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBC9C34952
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 09:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 594D95609AD
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 08:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC902E8DF5;
	Wed,  5 Nov 2025 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yp7LniJ5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180F52E7F27
	for <linux-acpi@vger.kernel.org>; Wed,  5 Nov 2025 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332494; cv=none; b=s4XLk6Slj3y/czNvae8MsO6iWPRcPgHNZden6eicbLVu5XKBrlMRP+4SwLlLI0sxhA8l6mOi3OjRV0Gm0H+K6e7seYf8rYgR+8m3j7+eG5poVD+NKb1Ckj5Bp6RwsAD0dDWU/lLFRkdGbwuKtrAm8PN8/OcmvvGpem035lxC1OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332494; c=relaxed/simple;
	bh=RblnhEgjT1ATQCpBOT39uE2nJPA2rhEO7IRHMN8Quh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jp3mcNgVxKyQRQ3UtVBg6pgFxWn2NGESsCu+sWkVAHGqD4i6O7juUHU14V+X2rkzIssQ5GcpHvjXFzkoIjg7qgUok2HrbTHMjlZ863VBbAS5b+8WJBLMn/pJcF7swjDHeS/iOJ5YNvwIcRu4ZIRU9mb5+ZYkZob9Bd8n3jM+s5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yp7LniJ5; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-429cf861327so925991f8f.0
        for <linux-acpi@vger.kernel.org>; Wed, 05 Nov 2025 00:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762332490; x=1762937290; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zRbag5R4phUt0lvwmog2563w0RmrCN5eKMWnzPULmkg=;
        b=yp7LniJ5k+tuz6kI2UeWTYCo9yKx6hiweep77Yjb74b8gsCiYivAQr8QQuahRPc9aU
         FaYzp8NSB+QttTGTvSqWYs8dSXktX9rtAvwiV0QOo8gfIFRnzLRPZ2aoeiomxGXfvsq6
         /h2WF6g+EFyZAUZd6UEmfTayOPSZfxQr53hkejJtkFG2C37OT0lPYqti6sWWH7sd3bB1
         +rcsKFvXqTKU8fPaUfkUvgKSc/dLNrAdJ0z0F+es/ri54QhiVg5pqqZSh9az2UewROTB
         s9YYTsStS1ZSK6clzDb8PhO19YxGQ9ZCnAMgs7kQVLamTawLLTnkuHG1HwavC3ft4bc4
         mRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762332490; x=1762937290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRbag5R4phUt0lvwmog2563w0RmrCN5eKMWnzPULmkg=;
        b=A7IdmG9l1M2c9EJZo7xrwFl5kGYOz0rr+364Td4W326KWWb7N80ja9NBOC/wj4216J
         B1ifKRVDPN0CQUUHsUKt2jQgXSW4/fpgEmOF38DE+3Tl2bwJc7gYbcBjJL9bEEyqSqdn
         0rss5IFVRUfCp8j0NovSQ4piyqPQtB+tRTuXrpLzkN6+rJHDnA2PD/3I14xXm2f+Aea4
         Pn9e3TEMmm3BAupCebqphW8oDrDTyakUNfLsJzQLzVaLxZknW5yqbyEVcBzyiD7cGoJh
         YOOK1gXbqzwujIzhXdorOlPRtxMQPmgpkY0QCarWeiT08RyBoT4S0I0AKZ3Y181QEYt1
         Dngw==
X-Forwarded-Encrypted: i=1; AJvYcCUA8KneREX/CgFz0qzW2xLR9vuFFkKIggoSd/XaE0RcsBPOSCDbtWxd9HYbFmQCqq72AFmN4XZ/9wV+@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfsr8DRtsoQw7ly1X6Opt+oZi8ea5Ww2C/m5RDUi4J5Vyepum9
	/kdSIoytUBVWw4Eryl/uLTJdiDv0jR+PVKX7KbZz2DhUK1ZlLzuftaC6BG7yrN+mWtyPCTbFih1
	n0vEcTSHDcg==
X-Gm-Gg: ASbGncs+n288kHHlViqC531AOtQs5z9wGGRc8yVQpZwcrJyjrI/d/OQ3GHKBSfOTnbG
	y1wWPswFnxztSMVnlIen0aFn+Q7cy8QuhIVCpp672ep1yUOG1gfZ42E0HVBABGjVFS//s8qUlt7
	UDAIBSZ9K0VNnFfbxBx1X1i0rSYJ5hqTUd+3zib7+ztRtglhRmGGYUnzYH5R4VsBu1gGnYsTP5K
	Y6xbLutSyU6/YoS9QqWbTXTsaceEaQlUE7Mg1aRQxLBcYK8G6w0zTmeslH7J5Qw9TzY2aQyPwm6
	tebUrJMBXyx/ueSe0862/lHPKYZ00GiUS/Av1JCuvWC1xCW9V1ct4fTP6PY5POb8hoCPu1rir13
	tmdX27iLaZw/1AyLIOzEHRJVY1y1FpT4w8bHisOXjR9rNuAkhvczBqGGBKN3ctznrUmxj8Q==
X-Google-Smtp-Source: AGHT+IHFdgupmZQjjNPKK2Hdlytw71iW5JNMxOC3/yJ6wdug8mwzbWkD+SzLbGPLgyoeDoEIfEht5Q==
X-Received: by 2002:a05:6000:22c4:b0:427:7f0:95f0 with SMTP id ffacd0b85a97d-429e33079c5mr1768149f8f.37.1762332489393;
        Wed, 05 Nov 2025 00:48:09 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:4e71:8371:5a52:77e4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f9cdbsm9315936f8f.34.2025.11.05.00.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 00:48:08 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 05 Nov 2025 09:47:38 +0100
Subject: [PATCH v5 7/8] reset: gpio: convert the driver to using the
 auxiliary bus
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-reset-gpios-swnodes-v5-7-1f67499a8287@linaro.org>
References: <20251105-reset-gpios-swnodes-v5-0-1f67499a8287@linaro.org>
In-Reply-To: <20251105-reset-gpios-swnodes-v5-0-1f67499a8287@linaro.org>
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
 bh=f8XqWT6MV/Vm24ULyDMORR+Vw3utb1iWh132/5v3Ubw=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpCw8yYVRHDD3E12dVJC0rwQ7WsEpfipPFL+dME
 BxRROEbJNiJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQsPMgAKCRARpy6gFHHX
 clX2EADDWk2TS8JzwJf2hluVKTYk9n+o8eO2Y9pzjRZH4g74ijOlyq9h4ylsvUU9IpCzgoAprqw
 txuWk8fggh5oezwQIbuvcyqc2MyQ2ToQtdCY7xH2cjU0Z7vq+ESQWQf+ZScaE0TznJPzx/255si
 KYdohT3woEhFCxiBlOBZIfXuRYiOveSkONsJ/T3IStbzMYSPa6ysPLsFONOm7O9d5RQ6POcQNiD
 AZgOHP7FR8JVTtz7D5WLv+cQlaAmpSPVKrhZh4lCSaWxmHdtEm1y3Jn0kGt5zHBtBzCyR5meiEj
 WVjQhZ5e7ZwNX+6qvYZhGeZqNkrRZLnNjh1hwoYUbDUW5VU1xQD+KCpgRYqRngCR4tq890Bcf+r
 WkqoLXbOhWy7MIxp9FDCNxdfl+xERhUdzgN8sDeejhiVAG0MMuNyqUovukwzE0xeeVOzIAZsfGC
 xcbpdXzcUbbkp/bpbdq5sCZ4fQMmqrKpagNFq/pX7z7UoTxUDGSQKWZyJx1UvgAnGJaGHQpeSUL
 34k0k32Kw2+k2bqZojmxaXci3qzEUeGTyU+JXw9gDRFXnzkxN59EXBC0koRj+MaFA6cCSNBb2Jo
 gokY95xgaLb22EM1NOO2YEWx7kfjpomRVZ7j6gKbguy/Yj+UKZ7SJTvCyA9z9dc+yVdNLRkP8Fg
 lIEdNUN39cRbJ4Q==
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
index 67ca87c9a86ecdbd41cbd3397d2a0c9921227eef..26c8efce0394b238691e87b04087b3d705bfadb0 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -99,6 +99,7 @@ config RESET_EYEQ
 config RESET_GPIO
 	tristate "GPIO reset controller"
 	depends on GPIOLIB
+	select AUXILIARY_BUS
 	help
 	  This enables a generic reset controller for resets attached via
 	  GPIOs.  Typically for OF platforms this driver expects "reset-gpios"
diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index af42f4d12bbbfcba225219eac6d6c7edbe2405cc..fcf1c24086e565015b0956fdd40334274a1edb00 100644
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
@@ -855,7 +855,7 @@ static int __reset_add_reset_gpio_lookup(struct gpio_device *gdev, int id,
 	if (!lookup)
 		return -ENOMEM;
 
-	lookup->dev_id = kasprintf(GFP_KERNEL, "reset-gpio.%d", id);
+	lookup->dev_id = kasprintf(GFP_KERNEL, "reset.gpio.%d", id);
 	if (!lookup->dev_id)
 		return -ENOMEM;
 
@@ -876,7 +876,7 @@ static int __reset_add_reset_gpio_lookup(struct gpio_device *gdev, int id,
 static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 {
 	struct reset_gpio_lookup *rgpio_dev;
-	struct platform_device *pdev;
+	struct auxiliary_device *adev;
 	int id, ret;
 
 	/*
@@ -932,11 +932,9 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
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
2.51.0


