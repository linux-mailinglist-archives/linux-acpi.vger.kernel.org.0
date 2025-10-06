Return-Path: <linux-acpi+bounces-17616-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 177A3BBE20B
	for <lists+linux-acpi@lfdr.de>; Mon, 06 Oct 2025 15:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 51A1F4EEC95
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Oct 2025 13:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAED287514;
	Mon,  6 Oct 2025 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ecq37Djg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8560C287268
	for <linux-acpi@vger.kernel.org>; Mon,  6 Oct 2025 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759755650; cv=none; b=MfHOxxgSl/xv8BFTf4ZTYwyZlBRNQIxJU9Uc6sdDHq+41K6Q3NFMbKS6cTGwcdU8qLzoZuJcMC46/O9w2GeKLkN1oDT//AvdD6MA31y+4CCfL2CPlrtKzffHMCnzYeTHs15Hoe3XVGCHwzqZRCghA/XP0A0NiUgbBOvRtcUZFZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759755650; c=relaxed/simple;
	bh=K8U+CHaEDTDTAOOAhIZGQLKRldV6biiXuo/pIPzTEZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OAqtX2LrSxCcliIIyteULlPAi7mGsldb+lz+sER+wJc06Fgz753/+3oL0QOxElLZ/RgJ+kuUzf0W9/6dfhrjd4PoCuNWDH8BQ6oP/zr0sh/IBfB5gBXcLylGk6bfEO/WmLjDZTvtIgxGZeD1dJQ2XwlOB+G5pZ8FoTZ+ydnSkPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ecq37Djg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e37d6c21eso35698185e9.0
        for <linux-acpi@vger.kernel.org>; Mon, 06 Oct 2025 06:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759755647; x=1760360447; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6pKa9jDqQ70bpsXEO6w9amEFdc6+U1mZOoJWBfQBYnU=;
        b=ecq37DjgMG+ZVpr3twoAHY6abMk19/hn0RwDKgRYMG6hcgjKMQvbgffI0K5820fJaA
         prGG/WZ751lrqbERuKQILKIuqvnk0/PE/OpF06y7Y1vHdEz3dPi3qNJO0oDBQrIpt7Bs
         GLZsY0Pgpo0pfj0D/VcRBtattHmSFYs2le/MEsCbJQt+Uc/UflvOGvYcJ6Lh1cfB+6Yq
         VbR82popzFAvnydO6lTyZuAX6CjE7EsSqTZvF+vOiWVuTgRmEqVozQZYGeooXccjP5MP
         o7y8Pa6D7xXY+p16EXClSDmtVfiF/iwdufK0vnGxts+cxOlFVCkeKxglIUHVzNhgLQSj
         Ikig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759755647; x=1760360447;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pKa9jDqQ70bpsXEO6w9amEFdc6+U1mZOoJWBfQBYnU=;
        b=LvDoNTgzYNbMoYC8KzvuuARHCXQPBD1BDIyls2KY1OVBr2t9NOoFq5fSI2adHRuiXL
         8uq7EnRY8kX+nn9Tbv9WZwnzJMs+VQgnceSosG4o+E32WOrnz+LMhGbBlN5/7RxnMj2P
         aKYxKRm5lICBT+A2Cu8R18ikphFTIPxnXtpsxfW40aqRVJ/xqn3CDirC00o6sgNSfgr4
         bqHsiW9lO+8sb+7TMrOEIJSqXbb/2AQOFw6sknotjyV8OVLuUytNp4Y9xZINOcBkWWp/
         B0wx5ebMgsIIQniQ73kGmGYBYnQfZ5yBotr0tz5Ctm+1lB4OVMznh+aqCts3OiMNPxoA
         PvfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/vGlLTFODUTQHtkAsTCNhUUgpILQfwSSZY3ymKzHQbgAhg5lf9w2A8jMvbA9gSjavYvagAJ1haJj1@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm03zTG5B+5DGDwSXwosvIvaxPwhgWkdblqoW0s6WBrfdUx9EZ
	GQl5nHKUArkMiDdIv6Kb3Pj0mbLJZQ92zb6LqHwzZ+qhOjC+R0MxhA3Nw5qjTEvjvow=
X-Gm-Gg: ASbGnctTFfxMLxzCoJROM/LSLgJrqM1tmuxcXiSsgAOPDT3yBnL4oydDJMoS+vdTpm6
	BZeqefT7O4Kzgu0s+b8BS4YIOyISKd4WPomha0P9vp//wTAlnFoBJmg5pSZkF0BC+oONwvSEqbV
	GfkMcKitJYBZ1oXuLU3rTjDDUcHjRQ5KtSXng32KPSz7QrY30KfZ4dR+WmJHew6qyLikaWi/rdi
	892SYg79oTuYMQCfPSvpUY8WtyerMFINrWaDTSb+d1GMtfuLP6/tFmijrU1h3eU1NsBBLmXRDyW
	gom34lLCr0cXf7G6t8qAndvTfw6V6fVOsCMkO3PkAZjQ4Wk7nWpA/FmennPQhRl8gmaWDPKYOx+
	EHByb+Di0hMlQNaYtY5AvxldgtfWjRnBMk26WBDDwtpfaMEXHrUJr
X-Google-Smtp-Source: AGHT+IHVfVXF804VbQxWVSNoeBDUmpNoTUbLdSk8nlsC5TJ7pPo085L60e5shPycALSUqFXkTIsQZg==
X-Received: by 2002:a05:600c:354d:b0:46e:6a6a:5cf7 with SMTP id 5b1f17b1804b1-46e711026c4mr87577545e9.12.1759755646723;
        Mon, 06 Oct 2025 06:00:46 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ed2b:276f:1a72:aac0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619b86e1sm249725965e9.5.2025.10.06.06.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 06:00:45 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 06 Oct 2025 15:00:22 +0200
Subject: [PATCH 7/9] reset: make the provider of reset-gpios the parent of
 the reset device
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-reset-gpios-swnodes-v1-7-6d3325b9af42@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2973;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=Zc+xs5tXGUpl9lw3Fpnc7se6u+D5QtL6RaYw/hFc3wY=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo471w3VajOAmI2LiZSnq9w/PmWaCe3q6SYPRBE
 9uM3dLHU1WJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaOO9cAAKCRARpy6gFHHX
 ckSwEAC5br4Du9+yyIV7DxA1c9XCvP2k/N0Ximod1Z6yO1qv18SfTIPIGICwPRXxjSk76i99qdS
 WG7yX/XIZDBSrvMfTgZ+YTiY51Qh4Ttg+Io8eAfJHZzgplYEGKXVCcXI647SGTQjkLjcKA2q61G
 nkUcFsYOP/3pIHQ8iS8O7yhAmFmOD8wV0bwVhdsQzS7Wiy/NXK7uhXdip/QeUs30US0X3bBADOm
 nmzoAA48zEJpHRppAeXCkiAWQCVT1xtycOPejnIcMyCkEs+n2v7kLKQsZsJKgVwy0DUrBMtdq4M
 RwbPmETuwWa1bvokYGPhDw8jEyxsovqmgdnDOSKaYqIQhkUUo7qLR/wEcw2WLwTrM9Mo67+evWF
 UlKucTeEzS4MEsECRa6Md3N4rbM/bgO48+Y4mG6qv3ya3ZmyCS37pxfr8b4VxPXhumkMQcCEjs5
 Jgn7mTvpYamv0aam+h/X7BR02XFJtNcLX3Vs8lzqaL05qDn6rHrEUZhqzCYUKu0gQErrd8zkGvR
 GvzgZ1lpz8qhp1lXCSR7XJZjDLnBTNS0suTS+JRcwB5WA3api9Rzmml14mF++54HXPRX1lC2QBg
 kzVYwShdQjhKe11vv3aVrTX6HBDKe1XAeB91KmXQGwtUYdISv+v+2yYff0sGQrOzSsGTY9RkuZa
 /MWcXjbxzcks0Eg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Auxiliary devices really do need a parent so ahead of converting the
reset-gpios driver to registering on the auxiliary bus, make the GPIO
device that provides the reset GPIO the parent of the reset-gpio device.
To that end move the lookup of the GPIO device by fwnode to the
beginning of __reset_add_reset_gpio_device() which has the added benefor
of bailing out earlier, before allocating resources for the virtual
device, if the chip is not up yet.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/reset/core.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 5a696e2dbcc224a633e2b321da53b7bc699cb5f3..ad85ddc8dd9fcf8b512cb09168586e0afca257f1 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -849,11 +849,11 @@ static void __reset_control_put_internal(struct reset_control *rstc)
 	kref_put(&rstc->refcnt, __reset_control_release);
 }
 
-static int __reset_add_reset_gpio_lookup(int id, struct device_node *np,
+static int __reset_add_reset_gpio_lookup(struct gpio_device *gdev, int id,
+					 struct device_node *np,
 					 unsigned int gpio,
 					 unsigned int of_flags)
 {
-	const struct fwnode_handle *fwnode = of_fwnode_handle(np);
 	unsigned int lookup_flags;
 	const char *label_tmp;
 
@@ -868,10 +868,6 @@ static int __reset_add_reset_gpio_lookup(int id, struct device_node *np,
 		return -EINVAL;
 	}
 
-	struct gpio_device *gdev __free(gpio_device_put) = gpio_device_find_by_fwnode(fwnode);
-	if (!gdev)
-		return -EPROBE_DEFER;
-
 	label_tmp = gpio_device_get_label(gdev);
 	if (!label_tmp)
 		return -EINVAL;
@@ -919,6 +915,11 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 	if (args->args_count != 2)
 		return -ENOENT;
 
+	struct gpio_device *gdev __free(gpio_device_put) =
+		gpio_device_find_by_fwnode(of_fwnode_handle(args->np));
+	if (!gdev)
+		return -EPROBE_DEFER;
+
 	/*
 	 * Registering reset-gpio device might cause immediate
 	 * bind, resulting in its probe() registering new reset controller thus
@@ -946,7 +947,7 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 		goto err_ida_free;
 	}
 
-	ret = __reset_add_reset_gpio_lookup(id, args->np, args->args[0],
+	ret = __reset_add_reset_gpio_lookup(gdev, id, args->np, args->args[0],
 					    args->args[1]);
 	if (ret < 0)
 		goto err_kfree;
@@ -958,7 +959,8 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 	 * Hold reference as long as rgpio_dev memory is valid.
 	 */
 	of_node_get(rgpio_dev->of_args.np);
-	pdev = platform_device_register_data(NULL, "reset-gpio", id,
+	pdev = platform_device_register_data(gpio_device_to_device(gdev),
+					     "reset-gpio", id,
 					     &rgpio_dev->of_args,
 					     sizeof(rgpio_dev->of_args));
 	ret = PTR_ERR_OR_ZERO(pdev);

-- 
2.48.1


