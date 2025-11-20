Return-Path: <linux-acpi+bounces-19148-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 257A4C74352
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Nov 2025 14:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id CE22C2B1F0
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Nov 2025 13:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD36341050;
	Thu, 20 Nov 2025 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2UaiMPMD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B255F33C1AE
	for <linux-acpi@vger.kernel.org>; Thu, 20 Nov 2025 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763645070; cv=none; b=I+9HgHsaViW+MkcN81GKCurm9Nx6xpd6Nq1fReMu/v5VkmE9vcHEPOEHdNLWncaQ84ljTBsgNZzANfIXEZXFqPZS9CMSDhoKIdFyALS7BIR+O6bOyKA9S+D8c5EoL153vjfy6+MW3OgYlkmPU0WrGUqrOixxHCjedxOsHlUaPGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763645070; c=relaxed/simple;
	bh=TmnPwRPKxNqDK4kqJf7gkqi9ML3vw5hcnCB0TrZwF+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SuSdItj1vaz7jL2/WikFafAmlzB7QuAWanG2Yys8yB5QwVGButOH68/IJQ1LtR/3GEZchrIn6G9CAcWmrznNeGGjgdrVqnp6MX/L4Bet4DI/KRqShftuAiUc2UypRJgZHee+7rvEFyyaVXMHHquT03+IIsGv2WSUe7GVnl/MTNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2UaiMPMD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477632b0621so6218445e9.2
        for <linux-acpi@vger.kernel.org>; Thu, 20 Nov 2025 05:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763645061; x=1764249861; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4XjD0ueSQIVGxSnWq5N3fbydIO3JRz9g8LzIgvZUmG8=;
        b=2UaiMPMD8sG8UssyS9sKwozsoxbZT8fNWYYFijsRQiLud51+TaXDixljGfwhTBoa0B
         2YBSDAKvAvu1SLUCiJT0RXEO8x1mr9TxGSZcAxcrezztXGDejcuLEe3J1R/v3ZLfewdH
         Q9AKIaFlNvY6+x4PCwF/BWkKr9mxR0TAv1viTY/0kc7dE4Le3FJ+YI2L4yCNGbRnomLt
         JeovOk8QV8nAWMqPYjDpuKtQr8TojLC028raL9gMgnB2TbVKpdRT04+Hr+DyOgY8ybMn
         IgXMB8c9Xl2L29SVcYx9/dUiI4ozgwJNGkaeBrJlnU71Z2kYLaa7ut/5GaaHZKa67Vj8
         vvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763645061; x=1764249861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4XjD0ueSQIVGxSnWq5N3fbydIO3JRz9g8LzIgvZUmG8=;
        b=KjyKBgod1AQCFjNm+GrfHaiKiCIdUuWZtkzyXYpup9knsr987EIS9ams7km8/HSz8T
         mChvLXIjNRotF2FLSyxPJymJJgU386eefwI645XcwIe7jH+DDQ9PRlFagtRzbwlSROJc
         QL5tf9QLeDdB1/1Ds3/x8J5sVKRKDZmJUoHLuji//COhHaq5DaWceYiYUl1Hba9Iy/G+
         fCaHABNavfIaXzcfhfRtLLbwfmoeIdE+rqZcO1tW+ToQiStNoJXD3+oJ9kU/znS+RbdR
         fd5uE25TbAD3GrTRGGHrXYt8cnwtw4gSjHB41MZpTLjtR4yJhmropMWafcVRmD0zcSIF
         B7mg==
X-Forwarded-Encrypted: i=1; AJvYcCWQQ8LpfFHWxk0YIBoNtsHGVtGfypZVWSLzxHfaGKdAZH2/Wt5YRK1iDcxu5rRTbV9Vcq/95sTXbd7P@vger.kernel.org
X-Gm-Message-State: AOJu0YznSRUfe67X9vedki2gU8E+381zx9jpItm5J46g5tIAHsZ1Z1Nv
	iytr52LSpXz8iC1YETD0jYoixMfTc8cDiC6/3hJXKmdkORBvELxySKMSB5w+ZlhnoSA=
X-Gm-Gg: ASbGncsD/E7XxUZiEvEOkqzMs9dekoJEvVqEBAmELlhig8dC4+isLxgjrjYw23/yrRQ
	6EYcgHRMxaXXEUL7stqb3GLnwDoaH37UyAjd/mxdvDednt4nDRttOZZaMMUj5sLfTeQDryd0UgF
	PMeyPC15KOUkJdBl9ru2MRJNvzoZR80ZShNNeby45dr1EbeDgz8foEh0dQmFgqOTVj7coYcMA+w
	zBIp2cZR/crWyYyjsURfyXRdeeehuHwYbi2MMf37sWDIx3CKky5eWFI/7R1G+ZpdayMTrdFY2lk
	ID7mpBFxAesgLNJcIROQOQnyf/vecC7MUyjXI3+3KZGvwMcJp2P+gtvqQZmbA1gZhDzT6+IOxDY
	8vUN9HCu0gRgyRV281NSFb0HIcgm5Td6Bivl5XD0hGY+3y/NcLWYsHoV/1e/SiOzjY7HM91YENz
	kmGHc=
X-Google-Smtp-Source: AGHT+IH6vuUXtQR0V74bFxueAkhlb1rxpZ2IJm5JuJVY/HCjNaVgdMXz0xpHyMcS1GsLh4Ijmud52A==
X-Received: by 2002:a05:600c:154d:b0:475:d8b3:a9d5 with SMTP id 5b1f17b1804b1-477b8953efdmr36167295e9.10.1763645060976;
        Thu, 20 Nov 2025 05:24:20 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:37af:6c1f:28a:47d2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b82cc72dsm46762935e9.1.2025.11.20.05.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 05:24:20 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Nov 2025 14:24:03 +0100
Subject: [PATCH v7 8/9] reset: gpio: convert the driver to using the
 auxiliary bus
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-reset-gpios-swnodes-v7-8-a100493a0f4b@linaro.org>
References: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org>
In-Reply-To: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Mark Brown <broonie@kernel.org>, 
 Maciej Strozek <mstrozek@opensource.cirrus.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com, linux-spi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5143;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=KmSwa9RPZ6TcHq3hcL4F56YB9LD5MmMIEe1ovhHQ/ek=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpHxZ0kT6+RHdf8teKNwn/OCNtuIggjuyI0WJtv
 RrJ4k8WfqaJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaR8WdAAKCRAFnS7L/zaE
 w9oRD/4w+yTXcGQDgBD2AkFNCjVW169CvEZDNpxIWwn8p4/8WKdVbKIRy9ldTYs3xMQsC6SBYmO
 BbuZtGJJkxQsEHA33nRWUBlUTPNbseHPESTeNt8X9QOQX01uwF4t0mcN7v8fZ/h3Bf1XVX3VoeQ
 LtthcPFxv0I16Bxv2roIJvfnwVwYOmYbrnxW91DAiwKTmQ1Y2T/Ajw4rp9EAwqcHmdy2N10vcQR
 IvtulANBhSy3cLRG+afIeKDM2rWV86aFFktjV02p+ffUtfYcCibQeuXc9IegwtjftptH6RxCDUC
 jhg20ItvFg8t25huMvBlzIGB+g90L6gfs8YsBtNuCVnXJ/yXXtGUBf+f+mavGUrbbWgEg1p9bTH
 77wU9lOyKMfw0TLgPCrTXbTchX+0jddQEov2yCVwCpqMmM2MwiIR3xD3ZB9whRouzLXL1xffUG8
 0nL45YdejFVdx/gWaWI2WiW1ptKKgaCdBWkL7d4shrS7m6gkY/YPRt+NkpkQSjH4tyIeUOEfltN
 Wjz/KxArwX3u8m270Sso7GRWpFHi47r4zZ00MI9FgsKQica3Bg/aa2zt1aGypPieOmDKkYpsSeT
 5Igo4lrt+mm2mpDokz3YIuT4Nl8xVSfTIQf1TPFCowUWlW3SEkainSqgbPmT9MItYRj7aRBPv6Z
 +SBs2oQU7YGb/RA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

As the reset-gpio devices are purely virtual and never instantiated from
real firmware nodes, let's convert the driver to using the - more
fitting - auxiliary bus.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/reset/Kconfig      |  1 +
 drivers/reset/core.c       | 14 ++++++--------
 drivers/reset/reset-gpio.c | 19 ++++++++++---------
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 9951dbd50130946952f3bbfc4b97525978f494ae..e158a818fb0897a51af370a8e5ce058e1de3b4ee 100644
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
index 50ff078dea7fd84d59e505fc1f607f593ec6381f..1f5f8d85dc16142da3e3a9988f2737c83550cb2f 100644
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
@@ -852,7 +852,7 @@ static int __reset_add_reset_gpio_lookup(struct gpio_device *gdev, int id,
 	if (!lookup)
 		return -ENOMEM;
 
-	lookup->dev_id = kasprintf(GFP_KERNEL, "reset-gpio.%d", id);
+	lookup->dev_id = kasprintf(GFP_KERNEL, "reset.gpio.%d", id);
 	if (!lookup->dev_id)
 		return -ENOMEM;
 
@@ -873,7 +873,7 @@ static int __reset_add_reset_gpio_lookup(struct gpio_device *gdev, int id,
 static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 {
 	struct reset_gpio_lookup *rgpio_dev;
-	struct platform_device *pdev;
+	struct auxiliary_device *adev;
 	int id, ret;
 
 	/*
@@ -929,11 +929,9 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
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


