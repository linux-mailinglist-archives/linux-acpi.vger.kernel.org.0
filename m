Return-Path: <linux-acpi+bounces-17617-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70637BBE211
	for <lists+linux-acpi@lfdr.de>; Mon, 06 Oct 2025 15:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12FB84F0419
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Oct 2025 13:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AB22882B6;
	Mon,  6 Oct 2025 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="y758cxIC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA89285073
	for <linux-acpi@vger.kernel.org>; Mon,  6 Oct 2025 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759755652; cv=none; b=A1oM7VyKqTmxVfBJAroRleoAb/ZSsRAavvl2yMWrn+nH5PQRWrowZ6hRzfgeOuvwsdlJm/tv0lHH77CNXTP6Hv1ksDtwbk8P6jWgDZB50iODL5a+dT7ih2tXCe9cz95wkwGEY2aAuI5cw0W2iDX8sOHQp2PM0G7NXjEiAb0g2t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759755652; c=relaxed/simple;
	bh=+JKWx7l/NGPc9FMlvYOUnFzEo+vds2fhGntk/7dxXpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OpycLOf8AE7rqSIWKC/JiQXZo0Vus1DqLbIwcFNpXgveYyEfLLO940PcAHarIti29291co3qg0NNo9K0+VXOQXXSxD5E882aQw7LX6ABtwgzBAplcTKHIRduT1OKFwSFijv5Cwy7rOSD2TrRT1dVxxETa05qqZOg1kp/oyvC8r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=y758cxIC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e430494ccso28927335e9.1
        for <linux-acpi@vger.kernel.org>; Mon, 06 Oct 2025 06:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759755648; x=1760360448; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RVJyVOFkJy3oLbXktrQuphyyROzCpxmHBAoz+N8Ld0Q=;
        b=y758cxICsCIyMiTxXZkjLiojKK1A5P/vRAVtXN4oYs70RqIIwYBVzE0pYHlj1JfFlQ
         YW+pv3xcbFmwxm+ZsfzA1FmycOi+aqXoJxoEEVJNMrbmbNomXhEEZ68BIuvM1WvmhbeY
         NmLofOQnYyfsGJZvr9LqM5N4e1HM2i3+oC0prAcpz2NtXGAVfJETxBQZwgXBvvIStTcx
         jn5ABqJY7Juwj8yEw38ljV1yxjDFTrAVvfE7d1Lvh1qVy9NI6uyYcJzf1hAUbeBWxc+T
         z5mxAdB23KavtNxqF/+88J3XY1ibkatmcQ/naaFs77nrHLkyjB5I48OdZBTjyH2VE7Zb
         D6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759755648; x=1760360448;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVJyVOFkJy3oLbXktrQuphyyROzCpxmHBAoz+N8Ld0Q=;
        b=bYQGFw8MbjpGgI5tDRegzRj8NsX958umyOMgTi5TP4ghow9bV16jIxGrvysj934LDb
         ozqrQPyQLeRic3o9k+18Xv83NwCeX8a7Y263ps2859ypxelszS//MV9nCfS7/PYgpgGB
         mrnbDg7Sch0Om6ogqxpiWmw3fuBT2y8RaW5PrS6oxRhvQqcpiPC7qYat/pJiY73wkx4Q
         OYzLVdDNDaMF1M6oaoxBYzcLaGff03m0GRPFyjWqdPtfAge6IbHvExNNbHogmzPPXL7h
         19PXePzG9gS4BywwhzVCQqWuaItL/7e+68oH1ddwaiGEqX4JAWnL+a0wYcvIrzzkogKk
         oj3w==
X-Forwarded-Encrypted: i=1; AJvYcCWb9Cm5935f3Cf/8ysLIbdIr0WC85Rn6r5uuDUWdoRuxa/TQqjmrCdeke8/dQW0oFmbriaMNWVdiRyu@vger.kernel.org
X-Gm-Message-State: AOJu0YyRVSChO+voxp6NAy5Qy3kswJSSwyE+BMkmWBG5HHowmDu9LCq1
	N1fKfeutyOPkmhGtdYtEFbVBOZ+TvpNS09a8qXTzpACbR1eMGw2eDEBEflXvu7Nu+kg=
X-Gm-Gg: ASbGncvQYXsNCdELzVQJIZNhlbgyonAeIDlBJ0PDseE1tBZyiGW7DYGBwbWzBrio436
	hgwS1yDMzDcHqOzAvwmYAiTDwHO1QdleVdqPAu7I6xjj5r0cTHhlYqmotnt5oO0Hsu5Ct/7X5U6
	VSQOeuA4xjHFQ7ch/GXUxqwpOIjBDb+2pZQpfZtC1qM4FS0QhfC3Q/IFBVHo8L4pExqImZA2vKe
	7b+0egx79DjuVdbRyUIrwe/jiS7H2zRik64JanmQJmq2kJtEaNZYpBtcBQ0614q4PRQvQX2sEkm
	1JAKETGSfdkqm6/WE3Q7lVgfvRTG49TSiA8Ja/c6ROgkAwDnPOI8JV+dWJZKlJ/Jc+uUSUINQq2
	HW2HEp7TWOtlwc3lkUvvxS6Is5VtPBaD6Man5jjpF4DU2R0yHYaHVUCDib09WjrI=
X-Google-Smtp-Source: AGHT+IFlCtvcNUI7/9UCDYySnsA2ln8tnjyIuGxNS6pmkEEAPUcuxt4MMplcSTveGNvJxMUSaSAp9A==
X-Received: by 2002:a05:600c:8b83:b0:45b:8adf:cf2b with SMTP id 5b1f17b1804b1-46e71142e6fmr77497045e9.21.1759755648455;
        Mon, 06 Oct 2025 06:00:48 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ed2b:276f:1a72:aac0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619b86e1sm249725965e9.5.2025.10.06.06.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 06:00:47 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 06 Oct 2025 15:00:23 +0200
Subject: [PATCH 8/9] reset: gpio: convert the driver to using the auxiliary
 bus
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-reset-gpios-swnodes-v1-8-6d3325b9af42@linaro.org>
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
In-Reply-To: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4980;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=e1WjM0ZFklLnJ17T2rheOhCBlqmI5B5UMpfU921B1x0=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo471xNzeVNqTbZtwqmv6yknmoSEVvaZo52odAH
 xQbrrKmzMSJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaOO9cQAKCRARpy6gFHHX
 chOUEACgXCqiQjC+EWfJWYzYmL6O74m50iWj9aNOxM0bc87M1tYLvyTo4Pd4cNZP2mXjFPAkzOF
 rAG8GpV01eZeOerDxqHjc8pcLg4f1wbW9BlCLpQV03FnozcsKpyqu1EEjkySnQb7AqWge5QNcyn
 mPW4Pg54HTgh+v505ks0+TmzDnZyqDDpUK/oAYW9MoKoyM9+4IVStXepYAzEEA7X4Xk0Gc9VCS1
 D8PZV0t3eNzZLnN+m1zbRnn+DefsMdGuLwLr9yFUXpCjzv3r6Ny3deO/3VaYav9IgX3pLJT0EOJ
 SSYFpyV1Bf0ygUJoHvhUHuSnqFyqJS+GDwbv5l62Dp8Fh6CnRiHmtua29Oh7acLtoN9Dk2xKamG
 5jRz5o2ctXL1SsJkIyJDpMSEmdTWrcwJtHYsdt7B7YeH3NAneMfmTPdlvYAjAec5JfBOZUn1iG+
 2wM2ADVAL8js9AsLhcHYYqfKBfcVWjaHXt+RnqdbZU8l3Zkr0LuHCAwK1DyHB0phhtClaRIZxA/
 IoOYToEAg8BBLu4q9dTVvssuvXaLC26kirvnxnGm5xTzvPYGeOLcN2isH7hH5Eqg1eFm8p6hnGc
 xj9LcccT9h5S0APZf9tUSbeqQVJ/aMRrlq/5GwHCDMwBK6qSAPpJ53QVS2YLw/kzzd21tC03qJs
 0XYM8rvZEulPXCg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

As the reset-gpio devices are purely virtual and never instantiated from
real firmware nodes, let's convert the driver to using the - more
fitting - auxiliary bus.

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
index ad85ddc8dd9fcf8b512cb09168586e0afca257f1..c9f13020ca3a7b9273488497a7d4240d0af762b0 100644
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
index 2290b25b6703536f2245f15cab870bd7092d3453..7b43d61d0467aef5fbbad53d531294fa62f8084a 100644
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
+	{ .name = "reset.gpio", },
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


