Return-Path: <linux-acpi+bounces-18098-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF3EBFC540
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 15:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B5D6543704
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 13:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4176034D4E6;
	Wed, 22 Oct 2025 13:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QlFkgtWQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F1A34D4C2
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140493; cv=none; b=skCrINcfeZO2JQ8SDF3ex0N2oQA5uWMZH9YXe39o3lurpAqQf74MWc9cq8iXonTJ1C065rhMEf7cvIz6mJ7NDLxFxiyWK2gxltjdo9qnEGEx0uafzYh0kMxVKTIBt+VvieUFALyR1OPGhc4MEs+ohw+x9Q8igDAitdJo+RRik0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140493; c=relaxed/simple;
	bh=kmXAtSE3HnrhoN6jQo1dJ1cDI3xe1YoDYFqyP0G5bLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HXmPT8CHCuCeh3ve18UxiIdqQMIEh0xUw6msCDl0TCiKTVHwj8yBMqvZ6J3jCmDvTlY59foKqPTEpqhCKJN8MTFBi4FmanBVvtTq85AhfJ4Ni8v/HASZIAks00HvERDXsv7Zh7gf2f6MydmWuDSrHvnySflCF5tlsMRKcQ2b7cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QlFkgtWQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-471075c0a18so72664515e9.1
        for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 06:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761140489; x=1761745289; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfExIwUemKJ5MA3EQ5p1dELGI8YLjDgxSK0E7YT4mrQ=;
        b=QlFkgtWQ8TulI+HF1rimjT3uZh9Cd7tKnUZzESmeKxI6uYyTRK8xnaSRfJs2PJOVbL
         94dHZ+CEMvVQnlFeDVz+Y8UZdgjTpgbvBKOz6bcFb/SWct6W/wMnO6Qlcg7fqRY1YCF2
         tQalEY4dBDnDpEqwab4R8SCr40oPvPjN5D5gLtDCmN5T0uY13LQM2KDZDHuC0CyM2IFm
         AKu8iCdaIQd/dBFjjKxL5M8oYK400XD5Yz7DQW5NdI5u7gvp09jXp8MpKO/duR+S5SFE
         SchivIeR688jMMbDYDUTKt+753Bd32NYPeDX+k9hQjfzjxT7zqh5J91V9xTdBtKP2gtQ
         wMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761140489; x=1761745289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfExIwUemKJ5MA3EQ5p1dELGI8YLjDgxSK0E7YT4mrQ=;
        b=lu4YhoaglsaT7x7+c4crBhy47cU4hSQvqvG+kBAusBrS1a6Uriidy9P5y8rdfRXcgh
         LMfOdK1xYZUenC3qKWJW8ta6PW6rMBRw4psAQ/nX1uuznfv257QhZ6YkE8P8xtG1P9EJ
         iV4jsX+zF9uV4txanMgcTmNGNDOzeAv9l7qEDE911YeLVjd9N9JmgYdUXD5o8+Xtxzs8
         JtbmkpIC0TlKl2DoilID+40xBleJgXcy5nmN1c1HbgeRey9z3jXF9LctBxMx7tF99/HT
         QmrWoBMB+PXtlACFOwq0kQqZRPYbSWvLagajxtp7vTZck+iHMxX6FFt21JiPTBKOBopA
         rNpA==
X-Forwarded-Encrypted: i=1; AJvYcCVbQg5ZQ6j9N9GnXyvQjYJ083ZYwEkfzqd3JwI+tXqonATthRzoc43Wq37RdIhGmnmo+iTGV/96jdSY@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk3v4cLs6oZ1kqrmFUNOV8mjMyMT/x+s5D0BJNERjmt9xDTex2
	cBB/wYRNPvqWL9ZDoBF/1dom0tNqNR8rMqnqGQoIwfM4lBqzBDwx0FL2+nyvE4piIrk=
X-Gm-Gg: ASbGncs81EGoAAfdVAEjaGqftqEmXsIx0ghisHzFdAblwdp6Ri3CnIsBjVeIki6FZuH
	4Er30gEbVcKtj7xVUnoPoq0dTTsGYeNhbLxSwFfu9U/m7jHNKNBD0HPXd+MYNbKWF9jS10LKOxt
	d8KQHk0rpwGXKBmWBw8vcTdhvAcyvyMQwPaB0REm0XOa60IzPjBmPeGJ8llXsvHaeWUrGL/JUvL
	b8s64uvUVqgmJxlpCwviDVM/zKB8VguF3Pk7DQgHaFW4a9iOMIOeuQ/qDSvdoiCpiwIKZIDTL2J
	KCjGKSUYE9dpEi0ipJGdDM6qaz5K9b/BJCucQCX0fMxvsWHB5KhYc6VQUnZ+DZpTB5nPy3GyHoP
	7bODMDpyNj3o5hw0vJ6zypRoaD2JRILucmzdc4ZRTSY4QWQKulq6g/yjJNzop81LWu/+OpOY=
X-Google-Smtp-Source: AGHT+IEPEOA7RggYEmPoDIO0+E2RmnVfpYLMBEbq6FywxOG4KxPHzSHzjlI3TZkyFbZBEIQnBiWT3A==
X-Received: by 2002:a05:6000:25c8:b0:428:3d75:b0e8 with SMTP id ffacd0b85a97d-4283d75c950mr11436344f8f.62.1761140489390;
        Wed, 22 Oct 2025 06:41:29 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69df:73af:f16a:eada])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b97f8sm24863066f8f.36.2025.10.22.06.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 06:41:28 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 22 Oct 2025 15:41:08 +0200
Subject: [PATCH v2 9/9] reset: gpio: use software nodes to setup the GPIO
 lookup
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-reset-gpios-swnodes-v2-9-69088530291b@linaro.org>
References: <20251022-reset-gpios-swnodes-v2-0-69088530291b@linaro.org>
In-Reply-To: <20251022-reset-gpios-swnodes-v2-0-69088530291b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7182;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=GpqWfoRVxSyb5DxpZnAD2OmXLWj91GbiRae7HNISm60=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo+N70O1r3YA0TWjKCf0+bm/mCXjIsUNvLh8W+3
 J5Ki2AlLESJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaPje9AAKCRARpy6gFHHX
 cjkjEACIIOMqMkMMhSh7gXtXg69x48pRB8KTsR3Yxzk4wWwJ3Q9RkxfvTniioGQKgiFgNnTxYaB
 0ZJX3otVkm1XsxqWQboShGoMAbOTRg5Ztpo966I88p8oS7Y3gTbo5FUROnMQm6KH0t3O6M3Lwzu
 QOx2STBaRZwM9E/ev7srtjthqMAjZsksjLnUexE66XIhUkxGtmTAgrADh/1vj/8zQ0SrbDQigOQ
 2HDAl+zgcSx5bs9kZRY7e3F7Bc4B3uLv+aSf1t7Mwsbav2tMF1AcB2iS2+A69+4l7NnMJqlOcfs
 oSXOSLKwt6G/B8jdZ3kMFvqehFofq/gUTDBqpYLHfNPfht2Wo0zL8agaEYJeDyN0ToGwtN88wdN
 t+FgLKShzNp/dKxzv3U6SNg9MRLM0+gaxNy5rmms64kmFo1Iippo1UKm6wsb9QNPNwr585CDbkw
 qhdDuGav/eGtT4jl8W9SXtln9d5qOtk7vO3+IX4urill/whCP6nhfecIVOGZJB6zY7HhkcYpOiM
 kPZcf/24w89KuqXfclgdcVCrQE2D+fzGBivmvFJdTvvIifn0aekF0KWNA8enpTV2nwcQeQg8B+M
 vyQWOw5mwbBDvlRUSutJAy2cLDSpgnHggPSUBeL5qXi1StdrCS4w4FTi3F3Z5ujl8RB0fdTBNEW
 qv4RIgsyrgYbm1A==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

GPIO machine lookup is a nice mechanism for associating GPIOs with
consumers if we don't know what kind of device the GPIO provider is or
when it will become available. However in the case of the reset-gpio, we
are already holding a reference to the device and so can reference its
firmware node. Let's setup a software node that references the relevant
GPIO and attach it to the auxiliary device we're creating.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/reset/core.c | 131 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 77 insertions(+), 54 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index c9f13020ca3a7b9273488497a7d4240d0af762b0..20378de4b813ab79a103ea81cf2cbcd2b76c0ccf 100644
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
 
@@ -849,52 +852,45 @@ static void __reset_control_put_internal(struct reset_control *rstc)
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
@@ -902,9 +898,11 @@ static int __reset_add_reset_gpio_lookup(struct gpio_device *gdev, int id,
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
@@ -915,11 +913,30 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 	if (args->args_count != 2)
 		return -ENOENT;
 
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
 		return -EPROBE_DEFER;
 
+	parent = gpio_device_to_device(gdev);
+
 	/*
 	 * Registering reset-gpio device might cause immediate
 	 * bind, resulting in its probe() registering new reset controller thus
@@ -936,6 +953,12 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 		}
 	}
 
+	lflags = GPIO_PERSISTENT | (of_flags & GPIO_ACTIVE_LOW);
+
+	properties[0] = PROPERTY_ENTRY_GPIO_FWNODE("reset-gpios",
+						   parent->fwnode,
+						   offset, lflags);
+
 	id = ida_alloc(&reset_gpio_ida, GFP_KERNEL);
 	if (id < 0)
 		return id;
@@ -947,11 +970,6 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
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
@@ -959,19 +977,24 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 	 * Hold reference as long as rgpio_dev memory is valid.
 	 */
 	of_node_get(rgpio_dev->of_args.np);
-	adev = auxiliary_device_create(gpio_device_to_device(gdev), "reset",
-				       "gpio", &rgpio_dev->of_args, id);
-	ret = PTR_ERR_OR_ZERO(adev);
+
+	rgpio_dev->swnode = fwnode_create_software_node(properties, NULL);
+	if (IS_ERR(rgpio_dev->swnode))
+		goto err_put_of_node;
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
2.48.1


