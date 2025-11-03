Return-Path: <linux-acpi+bounces-18437-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D92FC2AC9C
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 10:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A630E348EC1
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 09:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CAE2F39BC;
	Mon,  3 Nov 2025 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WbyEUyYH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6012F25F3
	for <linux-acpi@vger.kernel.org>; Mon,  3 Nov 2025 09:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162558; cv=none; b=DAw9lffeRNE++5Nlsd5HmLr1Vu9K1DrAC083NgA4IXx1Wk9ivsEvorn1AtE9lfodfw+oWJC8DHUfsyLFDVVZAY0+fdghwf5iVLTIfljZ32h83wrGsbEyvHofFKReRePWFVLSPXt2My2wFWgSaWUpZWhYT/Ywd/LjGxFd97XM8XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162558; c=relaxed/simple;
	bh=LVirDKugKBwbbhccPkhESHv27V21xLYG8l1u0h8U634=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BNbzYqQzOLJt4AuLvAIRwKdEmm6IvQ3OHiGq1JzIiJ7KG+G2t3LtF/w0PbLWwldhXTZvX+2Ye2on5sNMwgkIb4g+lhfKsw7arA0wPaedWDU0TZ7RKACdiCRSCD2bZYZiNz/Ly8kXCZmkADn7+CcAkVe2opd1xKCpnEe/7HvLFSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WbyEUyYH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-475dc6029b6so37197375e9.0
        for <linux-acpi@vger.kernel.org>; Mon, 03 Nov 2025 01:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762162554; x=1762767354; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ccx+aLo9kBZlyDoxwdiUlxqcXIUYEmsoX9N+IulSngU=;
        b=WbyEUyYHMKr84mMD70rTZjLf3j6Lh6q35Gh/9YxOdly6LhgPDOAuJ+X0K8t1VkgvNX
         taduIJ3t8ujN/ZPD90NWCMqKI2WPnVUFF8am9GyJQpozlGFkwAUrxGzl3ubdmvRDWKRF
         U4SLxZeyws8LUZ48aAghIVvjAAVG89GNjT+K49RP/d538SYoOhlcChG0oEio7sxuHono
         8DY1rfF6PWWj5yMZhUpviXlOJSIctORwrf0TgPRxAnZqsEc2Am64Kfw7ddhKqNfsnpAd
         PZnXv/BHXp2SfGlFdN9pyShL/1FExajUFve/2GfQV5+sr+3SNnepQ8bdnUuT5AAWbQYg
         uGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762162554; x=1762767354;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ccx+aLo9kBZlyDoxwdiUlxqcXIUYEmsoX9N+IulSngU=;
        b=v3n5GYM+3o9+Jni7R3Cm7TYI2cX/W9t0EF3xP6V31PWzC1NAl8A6eKCETK/hXJk163
         3afTn/E9WjrzNBCExdTu0rMUaHSJfpME9mSXqC2LYYsTIMoNDdZOE3v4V60+WAtFI1H/
         UIj4j7EAHMOIDPdaajCDkceweSTfuorQgo9yCHwkgemxat50AXqigiMenx+deT3t69Kn
         mvCVQN8UUaQ3uRlaNFmcfTWh7a6P7GD7W/UQxlTvD/F7nCjlvAVeJ9wWjk/uRezj4+2F
         lDr8XUEnXcSjK9Er1y05wawJVf/T7GxKqSgVgslb9lsEAq7H5oiPzI7t3ZsuX5uOaaPx
         J03g==
X-Forwarded-Encrypted: i=1; AJvYcCXX9QEalS3C7mr/IhGNk5LKO3BhZzLVsAmEOdyWPkdAHXymcPhzhQ6SGqwktNx7rZXn/xI+g221OylY@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgnmir3bFfc1z+BtCXEX7Y2n0JSUlQfKtXpg5eLkh5I9a9MdMQ
	mMLB/aubivD+98J5Sbp/sCtfWG+TYJKD99xfDep9qZZR0fLOCM+1les0RB0F6oy2QLY=
X-Gm-Gg: ASbGncvBuMWub3Ub4yTjy38ZzMrWrS+xVB7ipcUfajF7UKbprdr2EJX8B2fXWM9jKud
	8a+unh5zIFKpZR5zOJYsb6GTMX5LY+M7DzzoeET0HQNdQ+1Ev5/n2cMJqO06EmzlkWdy00ylYsV
	5+OEERo8hwYndAOHVZ9jIToFVrRpmbvypxM8jyMwwf/RnNDg24Mw4FzhRd3sK8mmhICUPtI9QOI
	vA8qGOXiVdiYjSL+16hF1laG1RrNAcUckpt4PnN0CXQPhYbjOtbzPAowW5FRQfiYQWtYII2O5lS
	LTUUxVcKzS6cLQPtumzT8Jic7onXVOhN4ve0huCoEP4trDE3MvQ1OFm+Tnau/Lkq5A5uvSBqfu3
	yGuDP+3RWF2QJq3mGN+oGM7GnoZB3Pn62eohQo04dFnv3G4L2RkXcE3xdI61vc5hYzOi+IfEZZJ
	4FYbu6
X-Google-Smtp-Source: AGHT+IG+c9TBxrNO8Rhcga0cjbgIHbzYpexTcWraDC03lZYlbHD8b28uw8YTYq3tgyvQ6c0CGDmtaQ==
X-Received: by 2002:a05:600c:3e07:b0:471:a96:d1b6 with SMTP id 5b1f17b1804b1-4773b1f9db7mr85016295e9.7.1762162554470;
        Mon, 03 Nov 2025 01:35:54 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:e6eb:2a19:143f:b127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c4ac5d6sm147285675e9.8.2025.11.03.01.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 01:35:53 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Nov 2025 10:35:30 +0100
Subject: [PATCH v4 10/10] reset: gpio: use software nodes to setup the GPIO
 lookup
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-reset-gpios-swnodes-v4-10-6461800b6775@linaro.org>
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
In-Reply-To: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7164;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=zGQChOLYdShQxCyhFrgghwt6h1bOoSffKyYTaLJagTw=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpCHdmkfkiw+TPahVB/J5Ozb3L+OfwnbkEAaAM8
 jTvH0EnPOmJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQh3ZgAKCRARpy6gFHHX
 ct08EACxza1Nitcc8hYrFjP4g8/IEkDBsLvHarp0JA2folddmog9HvZ+5ikQyAfCGA0QNJPGcwh
 wO3i/Qoe7yClroNovCJpbq4u5qhaXhhy7L9uvYekvU7ythdhwPP7mquZhP2oxBLXKgi6WdFmDTy
 O0Ag+0NMjhGHRCGnGASBJJ+LIhS2Ub9KwLxWQ1NznREdIMvSCRPNRkc3BUTLS4WvCipGf6OozKZ
 h9lK5HPErNsanQ55jm9twkdV7VPIU5mUBUFiSmLcbZTsYDTGQPZxDeq9ryizMtY1mlHnBBgWqsy
 DudImTzWMoEjPg/Cr+ovz07GFjG5hqIF0HSoHU0pXW+BJ1WTfZV9uAHWmlWsdQM4Xw6v3+cfrMu
 n7OisPGEys+O380l+82SLvRU3rbBXm2yeSvlmOrpA6vDXrL44wSLXwWAn62zR6qgquNmkA9Il+B
 yaEpBjODGUFTWd2Sb8fYz60lzzKT0IpWfyw0VfCW7WyNJpHzjdLuYcQdOrCKQBevz87KfRCPBYP
 fBZZbKva6K1RO6MN8xgeA+AkQYpfIc4n7yPdjaw+XQXVisYS1DE4TIZMvIfB+qwmsZJe2dAgH4Z
 aah7PYXttCW5fv7QERqORVou/+Y8g9Vm+H1kczeVtjhFV509pxETDA+Sua3tYkV+o/tJ7b7+RNg
 uRGLDCgqYkxB/Sw==
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
 drivers/reset/core.c | 132 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 78 insertions(+), 54 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index fcf1c24086e565015b0956fdd40334274a1edb00..770d82ed7978f1006882908d92526fc6d8be3299 100644
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
@@ -875,9 +871,11 @@ static int __reset_add_reset_gpio_lookup(struct gpio_device *gdev, int id,
  */
 static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 {
+	struct property_entry properties[] = { {}, {} };
 	struct reset_gpio_lookup *rgpio_dev;
-	struct auxiliary_device *adev;
-	int id, ret;
+	unsigned int offset, of_flags;
+	struct device *parent;
+	int id, ret, lflags;
 
 	/*
 	 * Currently only #gpio-cells=2 is supported with the meaning of:
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
@@ -909,6 +924,13 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 		}
 	}
 
+	lflags = GPIO_PERSISTENT | (of_flags & GPIO_ACTIVE_LOW);
+	parent = gpio_device_to_device(gdev);
+
+	properties[0] = PROPERTY_ENTRY_GPIO_FWNODE("reset-gpios",
+						   parent->fwnode,
+						   offset, lflags);
+
 	id = ida_alloc(&reset_gpio_ida, GFP_KERNEL);
 	if (id < 0)
 		return id;
@@ -920,11 +942,6 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
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
@@ -932,19 +949,26 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 	 * Hold reference as long as rgpio_dev memory is valid.
 	 */
 	of_node_get(rgpio_dev->of_args.np);
-	adev = auxiliary_device_create(gpio_device_to_device(gdev), "reset",
-				       "gpio", &rgpio_dev->of_args, id);
-	ret = PTR_ERR_OR_ZERO(adev);
+
+	rgpio_dev->swnode = fwnode_create_software_node(properties, NULL);
+	if (IS_ERR(rgpio_dev->swnode)) {
+		ret = PTR_ERR(rgpio_dev->swnode);
+		goto err_put_of_node;
+	}
+
+	ret = reset_add_gpio_aux_device(parent, rgpio_dev->swnode, id,
+					&rgpio_dev->of_args);
 	if (ret)
-		goto err_put;
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


