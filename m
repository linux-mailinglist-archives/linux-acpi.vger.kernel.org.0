Return-Path: <linux-acpi+bounces-3309-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B1384E9A8
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Feb 2024 21:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E177228815E
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Feb 2024 20:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1708638F82;
	Thu,  8 Feb 2024 20:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lWRcnp35"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2514F38DF7
	for <linux-acpi@vger.kernel.org>; Thu,  8 Feb 2024 20:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707424032; cv=none; b=bT0NFx5a9SiZmkKsaonIleJtE6zG4/l7of4yCeDDjnqzHmCXgHMtRHXK5JxW1Dig2M05jEqqE4XUW45S8bwwLy5+ycrx+i6lOip91ZHfswl47N/koycjRA6CmCRCoDa2YkJIyo0QRo75Oda+nLKEmroK0h0HTFmvGgZHtaT5lEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707424032; c=relaxed/simple;
	bh=3P3uwJagr0FmLmf2/VrMSkMUj3jH7rR6a/yAEJUMRhs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sobl1f0F4coJZh3JKLOaVSo/CNDvma+KISPKhQZym/PDhCsmIlV2gimSKtjNRSbUFfbAu47FbZtaJJ0BRvUliE3bQukLrZQDtXAfrQ0zCi5F9L3Ovb3qui+ogUrIpa0q29Z9bBUt56q/VSZ85UyVk7TGEIaFH+STfenGWZ+91VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lWRcnp35; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40fe59b22dbso1947085e9.3
        for <linux-acpi@vger.kernel.org>; Thu, 08 Feb 2024 12:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707424027; x=1708028827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JVsqcGei7siW0fHnROYsdSsFWu3A0g1PQ15MBjzkZ40=;
        b=lWRcnp35W0+8rdXrny0vdDIly4q6V+Lq30BApLEdhp/GCruEuyiuacgkXq8T5hZh2R
         OYuxF1ysaHYFnSHGOrfHYH346x80LBgOqvG6ylRzOzCnRrV5kNpAJeSIhdQaCDts8u4l
         NmpoaBCRKGMcX8S1i4Fxd8xo4AGWknaYrpt4l2qw9QytufBDGekEU+r9NUiDFpkp4k6S
         k5XQjHFLl3WvZmPITaZJUydx13jwkbO0sLWunD36WYAoY5adURH4yt7oNxxOyF3j0N2T
         6k4Kms0/PEQnbR7xA2q9gKISvZ3himMUAH2STg1jYnO/2THUe5u4EKwMyWcFYzTJfTIw
         ttzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707424027; x=1708028827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JVsqcGei7siW0fHnROYsdSsFWu3A0g1PQ15MBjzkZ40=;
        b=emajvhXAKXt6rUQljpEEhsgB1tzzcqNhOSq3bXaEgobbut/jZLwUMDED+wKZOo5/MS
         rdsc3MIgEBQf4nJMDBAykhsdSnUuvmkX7PEuVZNi8tp0j2paGbRi5qwcnFrXgqkwTaKP
         UROu2UOpxl1UUCoQdWUIPXoDp5xrBEVKkyekPkmi5SB/abT6eOmAb9tXTPwNliAHLTwh
         jatjkswPLZdlXV6tZrKxYQ4WAN+wTx/E5VoR39f7bJ0NkwumIC+P/uf4mPT+4eEoWfEE
         fWWyNiSc2m/tJ3mpZY2k++nKAV5hfkwmvs9pzPg/y+No5ACPz3jqDSX3aW5t0nAlWf2h
         DIkA==
X-Gm-Message-State: AOJu0Yx8by3MSCeOhDH+jK/YIfr3ljhRWoLplUhzpgYggRMxHR2ZuPdT
	w6L8BTk2HLIAEHGRH18DuvK8dbH0nr/FjH5p/g64+kz7YupxVkHuoB2rZW5CU6k=
X-Google-Smtp-Source: AGHT+IEHSRIwxKsr7Ga0xgWxfA5xX0X9ro2Xtcw0whMCgIiN8sbdJ2gBydfW5iJwTjS7/c2Lp4xRkA==
X-Received: by 2002:a05:600c:510b:b0:410:4a4:6cd0 with SMTP id o11-20020a05600c510b00b0041004a46cd0mr280276wms.33.1707424027212;
        Thu, 08 Feb 2024 12:27:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8vdVe1g94d63MmNRK8LV5w35qEHHLyJiAaP8z4fGuhssyY99zgJWQWR+dkI9+yD70cGXd8QIYrbxkVhch1Zq23QZzjYZjwjqI1hizJ9pYPagQM2sysH9CmKWS9FT5zB1x2IPNBwkS2TpWFJYddDjabhmeBSJzPtcTPoq8SBE7i2pmCd+5dm1s9OiSF1zKYIPfRlUOq7ZyId5pzUVcl6/sAJQKt12IRlwnHv2PJiO8boF4cJa4s1bSV8fmRSNO+uefS8t6N4TRcN7Bl1vnYhdH
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id e13-20020a05600c4e4d00b0040ffd94cd27sm375567wmq.45.2024.02.08.12.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 12:27:06 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] gpio: constify opaque pointer in gpio_device_find() match function
Date: Thu,  8 Feb 2024 21:27:04 +0100
Message-Id: <20240208202704.631203-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The match function used in gpio_device_find() should not modify the
contents of passed opaque pointer, because such modification would not
be necessary for actual matching and it could lead to quite unreadable,
spaghetti code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpio/gpiolib-acpi.c | 2 +-
 drivers/gpio/gpiolib-of.c   | 7 ++++---
 drivers/gpio/gpiolib.c      | 6 +++---
 include/linux/gpio/driver.h | 2 +-
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index cd3e9657cc36..899cd505073e 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -126,7 +126,7 @@ static DEFINE_MUTEX(acpi_gpio_deferred_req_irqs_lock);
 static LIST_HEAD(acpi_gpio_deferred_req_irqs_list);
 static bool acpi_gpio_deferred_req_irqs_done;
 
-static int acpi_gpiochip_find(struct gpio_chip *gc, void *data)
+static int acpi_gpiochip_find(struct gpio_chip *gc, const void *data)
 {
 	return device_match_acpi_handle(&gc->gpiodev->dev, data);
 }
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 77509aa19900..35d717fd393f 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -118,9 +118,10 @@ int of_gpio_get_count(struct device *dev, const char *con_id)
 	return ret ? ret : -ENOENT;
 }
 
-static int of_gpiochip_match_node_and_xlate(struct gpio_chip *chip, void *data)
+static int of_gpiochip_match_node_and_xlate(struct gpio_chip *chip,
+					    const void *data)
 {
-	struct of_phandle_args *gpiospec = data;
+	const struct of_phandle_args *gpiospec = data;
 
 	return device_match_of_node(&chip->gpiodev->dev, gpiospec->np) &&
 				chip->of_xlate &&
@@ -852,7 +853,7 @@ static void of_gpiochip_remove_hog(struct gpio_chip *chip,
 			gpiochip_free_own_desc(desc);
 }
 
-static int of_gpiochip_match_node(struct gpio_chip *chip, void *data)
+static int of_gpiochip_match_node(struct gpio_chip *chip, const void *data)
 {
 	return device_match_of_node(&chip->gpiodev->dev, data);
 }
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 24d046268a01..0e332b24c7b8 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1114,7 +1114,7 @@ EXPORT_SYMBOL_GPL(gpiochip_remove);
  */
 struct gpio_device *gpio_device_find(void *data,
 				     int (*match)(struct gpio_chip *gc,
-						  void *data))
+						  const void *data))
 {
 	struct gpio_device *gdev;
 
@@ -1136,7 +1136,7 @@ struct gpio_device *gpio_device_find(void *data,
 }
 EXPORT_SYMBOL_GPL(gpio_device_find);
 
-static int gpio_chip_match_by_label(struct gpio_chip *gc, void *label)
+static int gpio_chip_match_by_label(struct gpio_chip *gc, const void *label)
 {
 	return gc->label && !strcmp(gc->label, label);
 }
@@ -1156,7 +1156,7 @@ struct gpio_device *gpio_device_find_by_label(const char *label)
 }
 EXPORT_SYMBOL_GPL(gpio_device_find_by_label);
 
-static int gpio_chip_match_by_fwnode(struct gpio_chip *gc, void *fwnode)
+static int gpio_chip_match_by_fwnode(struct gpio_chip *gc, const void *fwnode)
 {
 	return device_match_fwnode(&gc->gpiodev->dev, fwnode);
 }
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 3a37d058cfcf..51b23211794d 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -629,7 +629,7 @@ int devm_gpiochip_add_data_with_key(struct device *dev, struct gpio_chip *gc,
 				    struct lock_class_key *request_key);
 
 struct gpio_device *gpio_device_find(void *data,
-				int (*match)(struct gpio_chip *gc, void *data));
+				int (*match)(struct gpio_chip *gc, const void *data));
 struct gpio_device *gpio_device_find_by_label(const char *label);
 struct gpio_device *gpio_device_find_by_fwnode(const struct fwnode_handle *fwnode);
 
-- 
2.34.1


