Return-Path: <linux-acpi+bounces-18590-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B90C3BCA6
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 15:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CAF704E293A
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Nov 2025 14:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45983343D86;
	Thu,  6 Nov 2025 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YfKmtJ5g"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60F3342C90
	for <linux-acpi@vger.kernel.org>; Thu,  6 Nov 2025 14:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439579; cv=none; b=DioTC6UORODSPtNotvgHgY76oqzdOw6qtEy29SvghykIbrCnuPoXA/QSbGvhVSMM8fwyC5gYa1xwZ1WUIGJ1zPWxS/CObAjxYnBK1wa66NnqGpNJp2daSYk8x3GRSoMY53Df9JXGVG6IZXJRRVEUX37LA6L6NXj/cAUa76nop40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439579; c=relaxed/simple;
	bh=j86BUtaxmEhUJ/SWoFQBLDXy07v3EnQwuu18RQ828kY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bb1/TswU/IpcvHwmf6dH+F0NQJV3VK3yIsVKOFhWTxJ8PAffhN64tS84V39bFBYwTAJIgc0NroS4a+9TYfhkE6GwjbDmQbOtlvdED2kt0Pp9LQHvP4K/IG35k1zHtejMNZp8u+/b55PWXFDt9Fgqm8HKEEmjLbl/F21PKbTar5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YfKmtJ5g; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-429bcddad32so793505f8f.3
        for <linux-acpi@vger.kernel.org>; Thu, 06 Nov 2025 06:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762439575; x=1763044375; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KIaRc46XZMQqhsVHYY0qTS7geNIzPALSU+F0TjMM2vo=;
        b=YfKmtJ5gKUWuz0nc//LfvyzYH8ePqMjGEJdwvrofSxg2yRw9+pFzu/4218IoX1Lhzv
         XJEsGtOu+Cuz8Eh7XCGeVDnZjoqaOp5la9LcuYo3lVtGFZKLxJbqJ0FJKQeWOY1OBMuh
         QTsOk216wjffjeGy0MTpCP48uBrRqSWjx3Tnx3NrmRA7l4GFAxas0vgAkeNARSghHnLi
         s3Sh9s4+APbNDJzzN/IdlBbuGv3fc+1GxcrGZ8QWwDplKARP7d/qVraXLKBxoEUdKt8z
         OK/NDqsbyVUOdH/xGzvWUijPdmpcYV40HiuXoKbGs1Fc6RZ8wKj18VYJJ52l9yFf6MvW
         qncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762439575; x=1763044375;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIaRc46XZMQqhsVHYY0qTS7geNIzPALSU+F0TjMM2vo=;
        b=ht/VIFFr+XVTZcCQBCTgYWU/PQvK9ZybRRAWwFLfThonU7mvFW5d2dG+eiINMKwoS+
         QXEeUX6Hxcekyr33GYII7oZ1u/BUjYXRPHIqk1+it03b6NWmtj+7F+sqZzj8eYFAsjsk
         pUstUldzYifI+Jv+xCp9Bpvp/qTSJYXTdGjskttOeeqJEig/U+Fe9SVbYU1z9kDSdVWh
         OS0/MBJzKLwFOJk4sjAYsYaHuSd5x2vuVZMcXxqrI97Mocvv/JGrxTwDTlHLFISq04PJ
         lqNqelHXDd6kRvSJPY53t14SoePsyasP+OJGCEIvvAJutiqIpiXjDPa98vWafq6/oFP8
         vN6w==
X-Forwarded-Encrypted: i=1; AJvYcCXA2pKfUqf33rLU1MP3youkTz9aXO2nKhc2GGY4GlqdKFGN2S9A5iQlGrpEnTpvemgM6TkspmHw02nF@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmh5yq7Dzf2Hh2V9p1n4ufHOjSnk6Qlzq3vUB0P5FYgQrIj2oK
	x0tLXPe0G15FK+FTW+nJGyMPgfFz/3JGICXXqNIxoNB/apZXG2RxKCMuks9BFBYVX4c=
X-Gm-Gg: ASbGncty/utS4DzSL50XmNPI25BjzkXjCAzq9tMLLw42LDDo2Ub0+NJcMNnmDprQok6
	Zd5UCISB5cpNpQjV3ghTpy1dz9/TacnLV+e6ne1Cg7cwthFBdfFx6fip2E2HVjc66xH2DyQ1HQ4
	gDIPYzdzBkSZL9RNthtKifoRzhvPob1ouFJWJYrruRoZcBzM/tCCXkaqDbNoGLhcyF4GU1X4HF6
	sI0TFcHOBubGJazb9zDtaXIDCMj8ietl1DKQIIvCSpVsWONkWn29JqXGjWAjPulGAvvavBRSL5T
	Hc0brt+0F/RhFnuMbR9VA16Ifll3GdjTV104AxEr01XLz/tyLn2ClaOcnZe9HLD97b8GtRshavU
	qviigu2Je+CazD1CjMoFeCQo/qRT3kHHo/+wacUdr36kn3ZmKxJT9VHqJ9Bjx2SNJk1ot6xkFd2
	Ih6j0=
X-Google-Smtp-Source: AGHT+IHJ4x9Bsl7kc+pDxzziXipVXKzJ3UgPnkzFZteqICbtQCoOVD3/jSqMOxMxegdwEiqeIeb++Q==
X-Received: by 2002:a05:600c:b8a:b0:46e:53cb:9e7f with SMTP id 5b1f17b1804b1-4775cdd134bmr65869745e9.18.1762439575123;
        Thu, 06 Nov 2025 06:32:55 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:d9de:4038:a78:acab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763de4fb5sm18871515e9.2.2025.11.06.06.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 06:32:54 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 06 Nov 2025 15:32:36 +0100
Subject: [PATCH v6 7/8] reset: gpio: convert the driver to using the
 auxiliary bus
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-reset-gpios-swnodes-v6-7-69aa852de9e4@linaro.org>
References: <20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org>
In-Reply-To: <20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org>
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
 bh=TXv3pC6YgBdtVXMo+3iiNRgG6BJGBuMpbYpJAy7f2Qg=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpDLGI1zTyEAtJoMpIZn2+x83g1eHe5OzVTFyTJ
 NIJ2e4K0BaJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQyxiAAKCRARpy6gFHHX
 cqJaD/9b9ZvzmqxOgnvTe1+SCjl+C402PBz+X+k4e6V885WskRkEoKT932SVY3jnPXPuC2lh5Ha
 Qzw17O8yf/tpJBfZOPLXZYbN/SWx29yxy0BFnCCYBlTOtxQ4PXwpQPZqlZi+RluHUCpHrCIpbNp
 8W/n6cm40RZ3NoxTme6Gwz/KDZ7oqrMzsox42nKv5i5uakFqNhkQxeNpthxhlkOBL8QPb49NHJ1
 Gfq5u2DCgWyulKvATt1ibmv91ioi/UUa9wfGxTrSHfn6XtzHFei3z/ZW2rEL0t4jC/3YCqrBNCI
 OvVsXx542REYF6zqhgRDwHuA4he+HJfC+OvsVnqkvcJAkqomIPb9bX+H3uej8MPWHY1viL9WjAe
 EZfOTPZI/dFJ+1r3r9BwRKTMrZABS2lrUyuP7d7eEoDUykYNM2mGuIqwoP4AML872CMMM2x6owR
 fzHGFUOWAqvwv6MajA09Ml6O+L5bN9sVpZ610D/BsEG7S5QN4KeFxwvS8k37uCW+ICUva6rLc+C
 bH0CVPR3rwkwu7UOAojtBhsJZTxC+5cK9PTpSIMjI+z2psRxiVuEugzbvpSp/8GxlSEjei0IZ/G
 xqcr/I6/fSllaYcW7gZvpNIpoDXqYMf1J+xHLY4h6QvWV/KAi7kqpHjYmo7fCafgOw1ksMkr0Bj
 fzgTYUKzAb0Z5UA==
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
index 31dcd25b465d795dda275f751ed6ce28d4dc27ee..cefeff10f6c82f5aef269a6d3a58d9d204ed6b7e 100644
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


