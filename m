Return-Path: <linux-acpi+bounces-17613-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEEABBE1D8
	for <lists+linux-acpi@lfdr.de>; Mon, 06 Oct 2025 15:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27EE418854B6
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Oct 2025 13:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD91528688F;
	Mon,  6 Oct 2025 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="RJyNXgpk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B00285CB6
	for <linux-acpi@vger.kernel.org>; Mon,  6 Oct 2025 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759755644; cv=none; b=rtpUlDWUmuZTLDTUtK7oiKbrtUbNlDhkTphJY5hhFk19LGBf8zH0SCDpcizr4pOdBzH+HCckrh9eVqzoRVYk8QdbS/2ic5gTHVwn8DdzAwq03smWSWrgBFSEXutZQZiAUvDFyKL2jdpp6MRo5ELUukwbqQ83ZqZsvW+5/Yld4Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759755644; c=relaxed/simple;
	bh=5pnEeKqHYnawOAlljhNqLC8nrX9toglKozfFs0IQDGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mDq0i0wvq6ZnYP8qOYAJZioNaD2Cp9rCENdtTFOdmXuXOa7kdfP6OxS1zJhaY6IsiE1Kho5wlT/T3dmlStmLFvVdyS9o60I2KigCa9W7T4E2/JpqfO90XdmTbdZ12PqM/wcghCkIp9pa6PoKASTaoixKcCsZ6z01a+TaMRUayn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RJyNXgpk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e37d6c21eso35697355e9.0
        for <linux-acpi@vger.kernel.org>; Mon, 06 Oct 2025 06:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759755641; x=1760360441; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IB9li0p0kE9jGTTsXmkO4xLyhxPXUk87ZAQLNug4IQk=;
        b=RJyNXgpk89bTAvE79qK4tgAWBWIHCubMUeY9cjjFZ8Btb7Zhab4StlGZBbEcrwEKsB
         oZ+EWh6xvVmhnfxfYN/12d6PBh3P00UF/5rBOR7aljE76bLGAcPSBU8HFdtrigj6zIpM
         Uf6I72unEyTPuD5wqTpVEkGh/bX6K4r6uGWUrB6LW6q7DEU8qN+kl7VC8Eg1e5orDzX4
         RUul+l0w5tPB/sqRKWRW2pPKSOOSV1J19YVbpHLOLDbX79b/Iw9GeVSV4Xr8jWwAfjt9
         QEKca0m4llXzytWneQRNhfCbJ20ULA6MDxEWWU2YkeSxRu2+zc/wrplnkCH8RVeea5lm
         AQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759755641; x=1760360441;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IB9li0p0kE9jGTTsXmkO4xLyhxPXUk87ZAQLNug4IQk=;
        b=R2lgiYsmJ0FOkUk04X13TinIMN7q/DIkGGoEaH3hEvQBVhnpZei7oAh+rxf3bMrljO
         W4LDwv7DaVay/haekJwsbD36p4fEEuqJMmLAH9GpQoo4Eb//K69P6854GZ6Xu+jfZFrl
         Smk5raBJCQDXI+00aTl4XRrejU85Mvhpp9svuadrwQ9KQLCv4vvmwRO/oXj61vpZez4B
         oDD2yTFm943bup5A89/7R4NeeDD+HNWRXxe5EkyJqtREUzGYUA6+F2tMSem/6tLOvzOq
         4zgaQty0hKiDLAuo2Yhorq1tfYB01J/7Vq8q+aXdl6FT1OF2KRb7X+4jbmueAPNP0jMP
         /iRw==
X-Forwarded-Encrypted: i=1; AJvYcCVR0QH+vIm+vnVPlCIiEiksK1PXUwoHOgDT9hig44kIIso3AnsaW09nFOeUFdOzOGPvCZffn3s3n49p@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1JQdJWoiGpeisQ0g2TRIcPmYbGVD10xB30hbdFvOQu0vOOE4c
	F5/biwaYqUUSY4gOGnTKkHEguOOF6z/Q4ddWBJW2ZOfPBpjzkS+lL0Zt0dAb0GF8iD4=
X-Gm-Gg: ASbGncs6unGtN5PxzaBiw9Nj6fCZoEPz7jepeskb9V69BY9FXabc1aepa36cXyOlKL3
	0WUmiZv5MHL9e5fuC9BwLwz2S6JBWjkbf4KPNlGYU3ll4vXaY2NH6Z+2zdlE6V2v4GS3TSIbK7v
	B2qPe6hyRr/hFQRTFnjY2RtwGbdBmDwiZEEBfrgMTnYoxBs5BOvC8wuy5cu4mTnEITrVW2ZSi2W
	gK30jHOQulmF6wxgQVSn1SxCoksb6U16vNxdhon3+3uicjUPpk6HyMksviOQM8L7hShs7FuzCPL
	QQKbrEiq1AfoNN9eNUTWKEyaqtkaPzL44DaOIWhqwedRh4JMwEXbiSOAagdjyoWMOnYj5/4ZYGs
	mki3XN2IJwkcYYDzpNxZyPCBRkQ8bWTLrZAJOalXC0Cdcgc/iO7vF
X-Google-Smtp-Source: AGHT+IHebbAPMR7oXC5VLW2/w5/FrK+xciuNp+N6rz1Yq+ku7VJkWBjybJF2PazE1vgpg855HYVNnw==
X-Received: by 2002:a05:600d:41cd:b0:46e:1d8d:cfa2 with SMTP id 5b1f17b1804b1-46e7113dc01mr82047925e9.20.1759755641145;
        Mon, 06 Oct 2025 06:00:41 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ed2b:276f:1a72:aac0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619b86e1sm249725965e9.5.2025.10.06.06.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 06:00:39 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 06 Oct 2025 15:00:19 +0200
Subject: [PATCH 4/9] gpio: swnode: don't use the swnode's name as the key
 for GPIO lookup
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-reset-gpios-swnodes-v1-4-6d3325b9af42@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1995;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=j0RRfSQSsKVGeiwXPp8qsWRU8zLDV2TSTGFBIXN+YdY=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo471wtB/HnaJ+O09mQ+9lgzCae0qQw32NwTefs
 jSgoICyADGJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaOO9cAAKCRARpy6gFHHX
 ctnHD/4+TTw++elPkjzjI+nwSVBBsHusvZ7gjWSbofVCsBjApKaJ9Jkxm8Nlj/uyMBJ4WBQwwNo
 hpq036tS1eW5uIhf3nUOQ1tTJ9a0Z0LBUE7Vp7/Xsul0r6BB1JGZuW6MKXsSi160DQn/i0NK4RZ
 PvMLswbpfF/6d1JlYrD2l7+aBNwx6qG4sDt7HAdVoA4opQqYU1GE2zbOLFylFdVcPTKoypmVM5R
 YtUytXE52w8c00pwe8sZKJs8RHpz/6m8Rxe1YyH9Bt4X7BrAxxqJbaPNDXyrdew34ShdrpxnHrC
 ePzLlLx9GPkLxLG+GB8JjySOlClZyiqDzWH7F6XxWLjXm+mVS7X4AwvoN9JAZyRdZPDE6K5Acyv
 36sD88S8vx1ACVfqhh5OosZZJdyT2cdp+3+jlhQpGh74rLJomPs/67Xw8lagwFNwwnMF7H4VCXg
 m0qRihA289PN8TWMEF2feUNL5em0YXu3yRgf4OA1h90O2oxbJt/jVl3DH0CJb7hnXzbHfkhsaXE
 gVpBsfy6W+IOhPurkNZmV14obSmYS9RE9FA+tDi84Hi5VKn77gK3hZryWIJWEs+97srDMd17fan
 dyHc7gZalByu7pstT5/2NsYlFvSM+O+G7/QHZuUTuLLGzB6UXoI/FLDPiJXZLo0cNMBb0oG37rb
 Bj5vwuIyKtX6u+A==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Looking up a GPIO controller by label that is the name of the software
node is wonky at best - the GPIO controller driver is free to set
a different label than the name of its firmware node. We're already being
passed a firmware node handle attached to the GPIO device to
swnode_get_gpio_device() so use it instead for a more precise lookup.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-swnode.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.c
index f21dbc28cf2c8c2d06d034b7c89d302cc52bb9b5..573b5216cfda105bafa58e04fc5ad3a38d283698 100644
--- a/drivers/gpio/gpiolib-swnode.c
+++ b/drivers/gpio/gpiolib-swnode.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt) "gpiolib: swnode: " fmt
 
+#include <linux/cleanup.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/export.h>
@@ -26,23 +27,20 @@
 
 static struct gpio_device *swnode_get_gpio_device(struct fwnode_handle *fwnode)
 {
-	const struct software_node *gdev_node;
-	struct gpio_device *gdev;
-
-	gdev_node = to_software_node(fwnode);
-	if (!gdev_node || !gdev_node->name)
-		return ERR_PTR(-EINVAL);
+	struct gpio_device *gdev __free(gpio_device_put) =
+					gpio_device_find_by_fwnode(fwnode);
+	if (!gdev)
+		return ERR_PTR(-EPROBE_DEFER);
 
 	/*
 	 * Check for a special node that identifies undefined GPIOs, this is
 	 * primarily used as a key for internal chip selects in SPI bindings.
 	 */
 	if (IS_ENABLED(CONFIG_GPIO_SWNODE_UNDEFINED) &&
-	    !strcmp(gdev_node->name, GPIOLIB_SWNODE_UNDEFINED_NAME))
+	    !strcmp(fwnode_get_name(fwnode), GPIOLIB_SWNODE_UNDEFINED_NAME))
 		return ERR_PTR(-ENOENT);
 
-	gdev = gpio_device_find_by_label(gdev_node->name);
-	return gdev ?: ERR_PTR(-EPROBE_DEFER);
+	return no_free_ptr(gdev);
 }
 
 static int swnode_gpio_get_reference(const struct fwnode_handle *fwnode,

-- 
2.48.1


