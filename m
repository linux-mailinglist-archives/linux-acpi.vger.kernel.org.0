Return-Path: <linux-acpi+bounces-17618-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB11DBBE1FF
	for <lists+linux-acpi@lfdr.de>; Mon, 06 Oct 2025 15:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7090518889F5
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Oct 2025 13:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187D128851F;
	Mon,  6 Oct 2025 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="UnmSROMG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F85E2857F8
	for <linux-acpi@vger.kernel.org>; Mon,  6 Oct 2025 13:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759755654; cv=none; b=alob2/TgfTqfgHHbZRYePzqPmWgHUB3NNBJv7S3jwLn4bnfD5qXWrsUiJ+JzRrEMxlDsRXRTu6IHgB4AkxsfIuEqONd4c8aGSqipJVNtuig3IS3NXd/6NI2Xr5BqsAHq9bavil/0H8lc7YkUYD9kAB1HM49SOtz8CuEzCJoBe8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759755654; c=relaxed/simple;
	bh=3ITU5SMeBS5gbZ6+V2JyPdn7cXGWn2ep0zbQ9J0rsIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MxMO3F1p8K3ZYQT3c6j4gNtn7Ra7DXvDnVGABLnj5IUw8LAQvLsqifgoEiVffeDRHMr4P6oZS7jrqkbv5nuBU7AwOKG+ZVGQOKfdPgzqjlSCBzvhd+g6M6xsHyWGTxeQYm3acL/+Ek+cYuORaQu0gUznjnmzDDr7J5KvPfBzWOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=UnmSROMG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e42fa08e4so46690095e9.3
        for <linux-acpi@vger.kernel.org>; Mon, 06 Oct 2025 06:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759755650; x=1760360450; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQTP5tVg1KBqcYjkGWU/UXGNSpYIuMZY/FCVFHH95b4=;
        b=UnmSROMGZ2MmfEmnM0lKIrU/0z+R2U8y43ppUlZoCcXhQxl3+rjHLMrM3da/CFLIoE
         qRSQlqP75qHIvo0mNgZ6gH4wZg417V3w+MaZS2OpDAq1KzJ1iU0YoxvZ3hNA+KMl7QZx
         Bs9mDeyouFo/Lh7ChnC2AnH/jLZBEeDLPkc3GNy3USfVEa+pUOcVXOLz2upKYg61crhP
         0kdQPGAbO+sBBggt6s6yxVMnS5T3XDA6If1/jxt/a1pGYjy2lbmjl3LpcFKtIiVKiecS
         5Un+uSzyqtaWTvr8vj3hHEUi452NQ9FhxrN8FgLkkqauNpAEXXhY7VBrgcxNM7yEptt8
         Bfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759755650; x=1760360450;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQTP5tVg1KBqcYjkGWU/UXGNSpYIuMZY/FCVFHH95b4=;
        b=FT2RhH7srrCOFiiWM/EQZ16UNZBTbk5UF2g2tCtLoLKmZCrAfUXca/YfaQ3L6KYgJK
         MhejGQX26iSxRvMXKato+Q+QS4knG9UuVVJawYncIL2UCyXnnnBiJ6RxdjPfiM/q94dd
         urCMee+pzLZbWfmOY3e2sI0Pzw66TqpihubO3kZoPQTiExAqqBUfp7BC32v+ghGs0cqW
         9VXD8j1bZ4hp6bDQLp71fLhnaQuaCzg7HKWiK4h92099CcTeQdHBPjZAjL9mRQM/EY6F
         miPLFC/M7TK7YYSw+oFwzXJo2vhe75DGEg2X4qO1xiEq+UOOqfVPkP8s/mhk+dV+5OC/
         5ajQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuFD8NWWqIECpO4W0Bdc30IJgx4uvELs1wgJ3G46S23Q16XZyapAmgqqChGw4KSp/A5VU4x6Y5Jf6X@vger.kernel.org
X-Gm-Message-State: AOJu0YzBt7brqfONJZcDIo2fTXAc2Jcm0NWdt75UY+8g+EFbM8332RWn
	6Ogy3FrP49HPVfVvKUQWTRa4sc93qoO+dQgGkKChuht++iREsgC6sBrqe2ZVaPsveNg=
X-Gm-Gg: ASbGncsT4h9VWQI23LK8VtAEaiFyR0n2c/17UGQeULTycJ8+3nwi0YcLeyeDmgV8q77
	CjkSIdowhCOzXv3grzAE1Fd66qw/a/C3Klp8IIENrdxWgkdPFN0bUiFuOaE1BAwMzJMd29tTWB6
	Bbq0G78Zb8gKH1dGpQbSktU3pdwA3GWLNxthtOB6BY1hUf5uHcZBd6iU+KB/gopsoYEbfbnclbt
	ryPsOXoyC92ly5GGiWSzP+7Aw9ZkfjbHKwluwcoTthIdQu9Du09tejvlF/721soe+84mjTes+bh
	zXAx9haoEOp/I5jaZzD1cBNkVz60P30kg9QSzqWkl1bdK2b40harTGGTs0pBxc65/NXICZrfm8J
	D7D960aPe8ZWr/sOOTZ9OrQ7z56eHGVKGp/IUkq8FAA==
X-Google-Smtp-Source: AGHT+IF+07vLyKlUC9AZcX/ELvnHFPy4Xnjef8d+glDiXjGJaJtY0fp2bybEmkWjDlxNv8CyAWcKSw==
X-Received: by 2002:a05:600c:19ce:b0:45f:2919:5e6c with SMTP id 5b1f17b1804b1-46e7110c3d5mr106900545e9.16.1759755650133;
        Mon, 06 Oct 2025 06:00:50 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ed2b:276f:1a72:aac0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619b86e1sm249725965e9.5.2025.10.06.06.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 06:00:48 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 06 Oct 2025 15:00:24 +0200
Subject: [PATCH 9/9] reset: gpio: use software nodes to setup the GPIO
 lookup
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-reset-gpios-swnodes-v1-9-6d3325b9af42@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7200;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=euQnOmMaUXav6qiP7aQUzAMCDMlmaWDfPNDFpx0Zd40=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo471xS0cpgGKN+eCwr4RM2flGdhV1fuNmW7IEy
 pih/wsr5euJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaOO9cQAKCRARpy6gFHHX
 coIXD/sE/r5VEuU12M8wenUEnCjWZoJJuKKYrWL2E7T4Hg5PiNgjOGaF62J0OdBofMxEpp7rkba
 V1Zb0qdvdTcb6zjP8tMlIiZf+DI7S8ifG7KBRU5kELDN9xifiv7wbUd2bCaDBIrjZduZjII2eGU
 XqQ+ySRjRpK2oa201uID8kJPlOQy8IsgNmhhhNAA100CDKAfs3m4prThhnkrJJTo7vR5npJ8Gvm
 I3J7mAAwAb4JZMHQ7gw7ddZEdYEtccdhMWJgy+mq3UoKLF40EjUH7EllFOLDZnMEauOuhhpmv1Z
 6QwQNgrctI1hykn++MHmdCmWN3Rc1ve+V2yH4z3wNhGnajq1AFvkd8r90U9e4CWTX2f7PEvwbfD
 dT4/c5j8d9zdeTQjNAcNrBlDeAOD0p6aovQc3ZAgsDl9WBb7sp3qCbDgVh5tvycyM22ZX5nVLS0
 ph12Vs8sJ9dXkAEbrhZk4suiee+dIafR5g5ipYuVz3AHnmhxbz5xuUCxapQK0kj5q9aoZzSJ7bq
 F71aDZP2VWHHZj5qJrZtiUAJics9X0DRE66hE6Qedl77sNKVCtIuEEOldJmj9BHLYyRBYT7IdxB
 MTffYjKJZy8PPvBBlqmCRkLOApcb+bob6RSos+/m8v/uXHTbW/wNC+E1rBDesJofLmkM2zlmc18
 gyLYW+PH5ODOiaw==
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
 drivers/reset/core.c | 132 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 78 insertions(+), 54 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index c9f13020ca3a7b9273488497a7d4240d0af762b0..b3e6ba7a9c3d756d2e30dc20edda9c02b624aefd 100644
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
+static void reset_aux_device_release(struct device *dev)
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
+	adev->dev.release = reset_aux_device_release;
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
@@ -903,8 +899,10 @@ static int __reset_add_reset_gpio_lookup(struct gpio_device *gdev, int id,
 static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 {
 	struct reset_gpio_lookup *rgpio_dev;
-	struct auxiliary_device *adev;
-	int id, ret;
+	struct property_entry properties[2];
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
@@ -936,6 +953,13 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 		}
 	}
 
+	lflags = GPIO_PERSISTENT | (of_flags & GPIO_ACTIVE_LOW);
+
+	memset(properties, 0, sizeof(properties));
+	properties[0] = PROPERTY_ENTRY_GPIO_FWNODE("reset-gpios",
+						   parent->fwnode,
+						   offset, lflags);
+
 	id = ida_alloc(&reset_gpio_ida, GFP_KERNEL);
 	if (id < 0)
 		return id;
@@ -947,11 +971,6 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
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
@@ -959,19 +978,24 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
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


