Return-Path: <linux-acpi+bounces-18591-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AA1C3BC94
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 15:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 349F11B21251
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Nov 2025 14:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4225433E349;
	Thu,  6 Nov 2025 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nkvlScTR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D2A32BF33
	for <linux-acpi@vger.kernel.org>; Thu,  6 Nov 2025 14:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439582; cv=none; b=Lvd7Nn/paYZW3K+MgQevF6zvPclX8Kf1wsXM19vumZWMicuOGMMfhZZni7lZvMZBlzn0bPKo7qabV+99GhtJANM8dnvodGiNmVGkfaFqfqGl78ja2xmjpsES6TFG0o/XtUquyjZx4Numx3osgtDzhjYeG7OCplSF3cCshdiQVS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439582; c=relaxed/simple;
	bh=EkDE/RRl4qMOJOD0OLRUX9GMdTma2ZJklCXyTifECNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qhyqlD+/oVXFvFK2Mx5kTa5XD5+5SBTcfN7q27NzIruEg9LWpkbCH+PSk70rzPdEmioVx1sYnbFLsnnwQbMsEya3IDRy6tdYtC7iT9ylOxSDHoTK/2IVYocdxHTSOgGwfJJxF8eovJz4OxCBbw5aRZcfYrJvJy3POU3Fjsluevw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nkvlScTR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47721743fd0so5104785e9.2
        for <linux-acpi@vger.kernel.org>; Thu, 06 Nov 2025 06:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762439577; x=1763044377; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CBRf3veqjGbG6h9bzDEg53CibEdBQaqM7ZKj7lD8TRM=;
        b=nkvlScTRD+gKTlpPAdn/0OCmXug29C7ilQgcG9KXvAPpC8wf0dBthdneI44yy2K+fk
         pbaYKPMzl1nELw39e3wjx2DOIcOGZeT64hFfAedyVASzYU0KxAbz0YEqa0q8+LJhRhs6
         Yc5fN9BO+8VU+M0hMQEvS0pheYnxrlMkQu0XdR+SHB9HgTOSOtPpV+KbuSqBnZKV0D4+
         P2TbVxvuLxRbk1N+LrI54yyePhaFmw3Mt5IDWoMfOCVhd70II/nfXNDFNbEhiDTlGwjv
         uit2F7rpz5yTUvdsXOJTNQ/vFwMw/Vvi/ICOZUg26eSZKjfOlx3Desgy/f1OAlnbT6+x
         qxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762439577; x=1763044377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBRf3veqjGbG6h9bzDEg53CibEdBQaqM7ZKj7lD8TRM=;
        b=X/GTTcrVCvBO8RmjpEyk3Uy915pURxHJamHaqKi7nc8YzoVRK52psRW2RDv7eqV4kj
         /8WdBdF2Ow6O18WMFaTe0mYI1Dqa37aTikXGy6nG59MJBVILqP0bG6EjMhhyb4O6l4Do
         ACaaOXQLyZRsNU1RgfohIaziaPSqvFcQZ2USliq8SUFQ+B7ntJ3lUUr+VKxxqBoG5n9T
         fNkv5AdNms68yIGYEFwnXARaXdIGoyFTMWAAQwCg/gd55o0tnubyCat1HWT0TWmmhKs6
         700+7AOIwltqWj33+sUHyiLTOTIJt9IqmnjBLL4YdA5bToKJ6h0MCepRS0I+GjQcBcaH
         E52Q==
X-Forwarded-Encrypted: i=1; AJvYcCU852lYTUUGlsaIbbTSWeUfV1+PnP4iE1aQJUJw2Y1h4Zl1AZJWzgCD33gC0KA4FIYXFbna5SW2F7Ng@vger.kernel.org
X-Gm-Message-State: AOJu0YxboSJuzpTAqkv9UsoiW6J059a8ZW+oocewzFAsOXIilcdQEZff
	GygOOofFzt7qX+RxTQqa576EhQi+z8XrGfDhULHjF9/B4XFtcHI2cTuTsoZu+qIKBhk=
X-Gm-Gg: ASbGncuphk2u2Erp1TiOLxp8cEyPtL1YMf0KYd8zh5GbZB8TAr/SVxeWQsHPwQh5qez
	gg2mCtKZtHwKBhF2MSNCC53zLaEb6igO/w9PW7A11jvUHHvzSRFEeg50qaVOnV4ba0EzJ2wr1Xa
	Q35fh2rIFao0pCynLxU76FG3yZoVLOzAZGcUZU7UxwF/8tuKJl0oOJI1I9KvJf5XfDMxXq+8HBx
	rxosnIvaUaoCUYsldivIYCQ9tBdRI9WBlKcNFEAl/FF5lHxDUihM4W8Oj8oMxv5f0EWYxg/qpnZ
	dSuq6lChkhLxfFln91MClzKdx+w3K6k3WglFMowOyPM4gYmQc2h9iaVMZHD/sXSNBDcWMdGes8i
	3AAhPNnEOKRqaYyGKsaQD2A4QAnc90Vjb2NGvoUrj/RMguPbWuU57SEX8jKCrlIY1E41Sr2HN3s
	TSDyMgSUY/lb0xuw==
X-Google-Smtp-Source: AGHT+IHO3UylNl2KGxiz9gPrA6WTwUQSCel+a1JiWOuL3mx9boSALuIzdlOj9fKcjI5KOqgGUztaRQ==
X-Received: by 2002:a05:600c:348d:b0:46e:5100:326e with SMTP id 5b1f17b1804b1-4775cdf54b9mr51652505e9.23.1762439576626;
        Thu, 06 Nov 2025 06:32:56 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:d9de:4038:a78:acab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763de4fb5sm18871515e9.2.2025.11.06.06.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 06:32:55 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 06 Nov 2025 15:32:37 +0100
Subject: [PATCH v6 8/8] reset: gpio: use software nodes to setup the GPIO
 lookup
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-reset-gpios-swnodes-v6-8-69aa852de9e4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7011;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=Ao31mIgVUzpFpWDEWy5gl0RAjMbjdGgDZiop4RFld+8=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpDLGISK9diTWRcRc155/yr0n9uTHC0fqEsEKj1
 hLZNW8R8OOJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQyxiAAKCRARpy6gFHHX
 ctBqEACEOpOe4DMcGGg/2LAjcBGy/1ZSWig3u5pjB1TpSklhF9Zv7sfHAg7t6MTffVdoBkKP+TU
 UY4lJUvRlngckYoFB0WwZU4toQTLZato+0DR4jWeaNkBIyLMFabaNyxHU55zEyc0OJFE2ucQjvs
 Pe0Ce/IRMl8vMev7Ge1dtcrPXfc6OV5xMfg3U6EuTmeaBQ9QL5yld5QyFRMw7i7jnHU6cu/Bgpb
 6VY6X2G/f32vDv8xYVQimAWQZlcy+5lGAN+7GVI8a2EWcy6vF9yXp+bvnOhNnlDwZwy7F+PMkx1
 v2FQ7morG3A1o4wVaoU1U4D8Kf8ueh5j0Vu7vzc5g8o0dY2pDDtdqZwKjbZ19OjfOndnNTEkPqJ
 1FAQE0VP29lV9uu3oowVF2q4qCmAb8refNErjiJmsroLnV8JltEzUv6QXIPBgpe1UJCOAiLFNgI
 cENbRETaGRt2V7PMNNNg6S5kEyYnJnLy0EECi958hPJVK1mwC/IoX2x0IAgaXuthGJUqxdb7oMV
 9VqAqahRCPWqbr2V+Ntm3gNgAN+dLWwj/ffR/uu7Ynn2v6TjCphxUOSIzKbD4lIIdN4aY5xswy4
 0DAMqamXrZSn27IxbouxToz+mZKNcuzdX8BRiJlGBXWF5+CeULMDis6x4hX27uF4HZXqNiA6f41
 vpkjJP6iU7XChJw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

GPIO machine lookup is a nice mechanism for associating GPIOs with
consumers if we don't know what kind of device the GPIO provider is or
when it will become available. However in the case of the reset-gpio, we
are already holding a reference to the device and so can reference its
firmware node. Let's setup a software node that references the relevant
GPIO and attach it to the auxiliary device we're creating.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/reset/core.c | 126 +++++++++++++++++++++++++++++----------------------
 1 file changed, 73 insertions(+), 53 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index cefeff10f6c82f5aef269a6d3a58d9d204ed6b7e..8262879e3f0d9ce67683c6baa00d9eea9e3c3ca3 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -14,6 +14,7 @@
 #include <linux/export.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
+#include <linux/gpio/property.h>
 #include <linux/idr.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
@@ -77,10 +78,12 @@ struct reset_control_array {
 /**
  * struct reset_gpio_lookup - lookup key for ad-hoc created reset-gpio devices
  * @of_args: phandle to the reset controller with all the args like GPIO number
+ * @swnode: Software node containing the reference to the GPIO provider
  * @list: list entry for the reset_gpio_lookup_list
  */
 struct reset_gpio_lookup {
 	struct of_phandle_args of_args;
+	struct fwnode_handle *swnode;
 	struct list_head list;
 };
 
@@ -822,52 +825,45 @@ static void __reset_control_put_internal(struct reset_control *rstc)
 	kref_put(&rstc->refcnt, __reset_control_release);
 }
 
-static int __reset_add_reset_gpio_lookup(struct gpio_device *gdev, int id,
-					 struct device_node *np,
-					 unsigned int gpio,
-					 unsigned int of_flags)
+static void reset_gpio_aux_device_release(struct device *dev)
 {
-	unsigned int lookup_flags;
-	const char *label_tmp;
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
 
-	/*
-	 * Later we map GPIO flags between OF and Linux, however not all
-	 * constants from include/dt-bindings/gpio/gpio.h and
-	 * include/linux/gpio/machine.h match each other.
-	 */
-	if (of_flags > GPIO_ACTIVE_LOW) {
-		pr_err("reset-gpio code does not support GPIO flags %u for GPIO %u\n",
-		       of_flags, gpio);
-		return -EINVAL;
+	kfree(adev);
+}
+
+static int reset_add_gpio_aux_device(struct device *parent,
+				     struct fwnode_handle *swnode,
+				     int id, void *pdata)
+{
+	struct auxiliary_device *adev;
+	int ret;
+
+	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
+	if (!adev)
+		return -ENOMEM;
+
+	adev->id = id;
+	adev->name = "gpio";
+	adev->dev.parent = parent;
+	adev->dev.platform_data = pdata;
+	adev->dev.release = reset_gpio_aux_device_release;
+	device_set_node(&adev->dev, swnode);
+
+	ret = auxiliary_device_init(adev);
+	if (ret) {
+		kfree(adev);
+		return ret;
 	}
 
-	label_tmp = gpio_device_get_label(gdev);
-	if (!label_tmp)
-		return -EINVAL;
+	ret = __auxiliary_device_add(adev, "reset");
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		kfree(adev);
+		return ret;
+	}
 
-	char *label __free(kfree) = kstrdup(label_tmp, GFP_KERNEL);
-	if (!label)
-		return -ENOMEM;
-
-	/* Size: one lookup entry plus sentinel */
-	struct gpiod_lookup_table *lookup __free(kfree) = kzalloc(struct_size(lookup, table, 2),
-								  GFP_KERNEL);
-	if (!lookup)
-		return -ENOMEM;
-
-	lookup->dev_id = kasprintf(GFP_KERNEL, "reset.gpio.%d", id);
-	if (!lookup->dev_id)
-		return -ENOMEM;
-
-	lookup_flags = GPIO_PERSISTENT;
-	lookup_flags |= of_flags & GPIO_ACTIVE_LOW;
-	lookup->table[0] = GPIO_LOOKUP(no_free_ptr(label), gpio, "reset",
-				       lookup_flags);
-
-	/* Not freed on success, because it is persisent subsystem data. */
-	gpiod_add_lookup_table(no_free_ptr(lookup));
-
-	return 0;
+	return ret;
 }
 
 /*
@@ -875,8 +871,10 @@ static int __reset_add_reset_gpio_lookup(struct gpio_device *gdev, int id,
  */
 static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 {
+	struct property_entry properties[2] = { };
+	unsigned int offset, of_flags, lflags;
 	struct reset_gpio_lookup *rgpio_dev;
-	struct auxiliary_device *adev;
+	struct device *parent;
 	int id, ret;
 
 	/*
@@ -895,6 +893,23 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 	 */
 	lockdep_assert_not_held(&reset_list_mutex);
 
+	offset = args->args[0];
+	of_flags = args->args[1];
+
+	/*
+	 * Later we map GPIO flags between OF and Linux, however not all
+	 * constants from include/dt-bindings/gpio/gpio.h and
+	 * include/linux/gpio/machine.h match each other.
+	 *
+	 * FIXME: Find a better way of translating OF flags to GPIO lookup
+	 * flags.
+	 */
+	if (of_flags > GPIO_ACTIVE_LOW) {
+		pr_err("reset-gpio code does not support GPIO flags %u for GPIO %u\n",
+		       of_flags, offset);
+		return -EINVAL;
+	}
+
 	struct gpio_device *gdev __free(gpio_device_put) =
 		gpio_device_find_by_fwnode(of_fwnode_handle(args->np));
 	if (!gdev)
@@ -909,6 +924,10 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 		}
 	}
 
+	lflags = GPIO_PERSISTENT | (of_flags & GPIO_ACTIVE_LOW);
+	parent = gpio_device_to_device(gdev);
+	properties[0] = PROPERTY_ENTRY_GPIO("reset-gpios", parent->fwnode, offset, lflags);
+
 	id = ida_alloc(&reset_gpio_ida, GFP_KERNEL);
 	if (id < 0)
 		return id;
@@ -920,11 +939,6 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 		goto err_ida_free;
 	}
 
-	ret = __reset_add_reset_gpio_lookup(gdev, id, args->np, args->args[0],
-					    args->args[1]);
-	if (ret < 0)
-		goto err_kfree;
-
 	rgpio_dev->of_args = *args;
 	/*
 	 * We keep the device_node reference, but of_args.np is put at the end
@@ -932,19 +946,25 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 	 * Hold reference as long as rgpio_dev memory is valid.
 	 */
 	of_node_get(rgpio_dev->of_args.np);
-	adev = auxiliary_device_create(gpio_device_to_device(gdev), "reset",
-				       "gpio", &rgpio_dev->of_args, id);
-	ret = PTR_ERR_OR_ZERO(adev);
+
+	rgpio_dev->swnode = fwnode_create_software_node(properties, NULL);
+	ret = PTR_ERR(rgpio_dev->swnode);
 	if (ret)
-		goto err_put;
+		goto err_put_of_node;
+
+	ret = reset_add_gpio_aux_device(parent, rgpio_dev->swnode, id,
+					&rgpio_dev->of_args);
+	if (ret)
+		goto err_del_swnode;
 
 	list_add(&rgpio_dev->list, &reset_gpio_lookup_list);
 
 	return 0;
 
-err_put:
+err_del_swnode:
+	fwnode_remove_software_node(rgpio_dev->swnode);
+err_put_of_node:
 	of_node_put(rgpio_dev->of_args.np);
-err_kfree:
 	kfree(rgpio_dev);
 err_ida_free:
 	ida_free(&reset_gpio_ida, id);

-- 
2.51.0


