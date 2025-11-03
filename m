Return-Path: <linux-acpi+bounces-18432-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A996C2ACB7
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 10:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D38CA4EFEA2
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 09:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5B12EE607;
	Mon,  3 Nov 2025 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="m4L7NfH0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B542C2ED870
	for <linux-acpi@vger.kernel.org>; Mon,  3 Nov 2025 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162548; cv=none; b=KhTtsG+Shndp8cRSEV6brnE4m2ARn4xahubSOtMO/q1AxwHltJGPC+Iv5/U7sfuXuWuc4rm8xpQF3KW6hIhQo5VzvtqIonk9MbWR8i7LMFqfATtu1KEREJEILnN9AH5JMisZaXATDqhn0Xy56Rh33WJ49vCeXMFflUfD/SGbRPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162548; c=relaxed/simple;
	bh=+skCMKtZUro42624JZ1QUZs6XXv2cnD0krG3QzW97Qk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WXwTCxn3NNcAqVKPc5nyCU0caQz6Hrbv8Xi1J0HxqcSMQm6TbZn8EojUIrGzVWaxA4BfltPrc2994Apg2gfK/CIy8crO2yByfGnl5oLBRAS9elcK5FbzbxZKatE/XWucr8Z1A/bO35QuijWr//GUDC9sHqZ8ZVtYur8Vu6GIS24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=m4L7NfH0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so33714905e9.0
        for <linux-acpi@vger.kernel.org>; Mon, 03 Nov 2025 01:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762162545; x=1762767345; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hARBiXPjJrSTvy/xdjK5sGzNu7AhBm6QjSrW+nMlBA=;
        b=m4L7NfH0Chet1jdap0A5tJniEQuBEREWWnBJhRNbFSuw1wz5HQfQevQ+xRONN3TNik
         rn69vY45o7xO/WiZrIEEhcWsjYneG1EjWYP9ZmUg5LmnWUUHKssErtI0lOfM9WXtnRO6
         5ZV05fiFvT7sGlIQDg3W9UOoWmdJ+GH3SmOwzhQA7xZsW3kaPE1r9eCVteEMoKmmqRHU
         UMKNuAUsh85R+ALDdxJ3pqYmpgXazbVn+d8Pmzo8MKbKbkhAuq86n7QwR2hAq6OtM85z
         9BrjLZjgLoi7ufYQAsN9bCLXHiGTi0kKW2L9Om7RuuafO9QHelM4p87i85bfuVDfnprk
         sxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762162545; x=1762767345;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hARBiXPjJrSTvy/xdjK5sGzNu7AhBm6QjSrW+nMlBA=;
        b=VSWCFOHduOaiOSCp0g7jLldXeGBF6BiMn8ffySlgj9eVUTS6+Xwdx64H3iY8CF49n+
         QfsBqyGRY/8njd0r6ZYAyZ4z/iEX188b+MwC2hBlIPDKNFXSNlftlJcxZs/UV3UHYDXP
         Tzn4BbnOMK2z60c0nARb2m+tfc0z8lZc78Axa0efr3Z8nvCnbPYiKzmRN4fKwetn7Mw6
         r8RZUWhv5HIkIYmpNdGSlUUp0ANkTBmcXJ5lQfzcG5U3Om/xj22BcGxSin8P5fQYZP8A
         rm5cYc4FELGxw0NhA/ONluICsgFrkfxBo7FLge2KZkbqr8wGG7pggg7P0CIsUN/Es2L3
         3AZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6XtcWxO1oAFJvjyaJX7VB1X001e/YXPD6CMvfxgisKM3n7umMoLjo7Kl/jsBSXwb69vp1vniyDhp1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3gyutTXrgs5d473RwGFBdzuHFMD36uf58kPhVLC4FRfo9JP5e
	fnbi9pE/4FchHhmFeGmFzpC+6Y+x0+SeQfdAefse51hCH8/vm3fMgr7XVcpTRMselNE=
X-Gm-Gg: ASbGncuhA7oaIL09hhWAdAFPLU0gx6Ea1YspdlwYz6ZEOGOU1jf0i5aMBVUOUOqD4ls
	xpDFow/ja4Hs/IQ8e/mKjsJKo+dxumeMteZNbCqsvEkrJDMNjF7g7y8powqKoUc4iaQymyC6X+W
	DQXlmON5D/rk4mq3gDvdqeYKlFxsN4JAqJIo0EBMwnHkPzdoghvLYwGyf6+XhnQ1uyja+eoTvtw
	jOKMrechQ8XuH3B1yQUIOkFKuPVDOEBzmDjJsxAjuWL/aclDTC3A41AzQBFzccf2BRoxMmyNlLV
	gtvD29D71ZQhPTIsH+S+FNMvxC19sGYrfYXfIX3CqCFmaWmfS/frmGgHRORNP6Emetg9yUPOUfw
	5smUcsscjAclIJTL32TTn6K0+kfrPzgm4VK0tUFSHljwMHi3oX5U2wjckEh5cp6Hoi27tG12g5w
	jECCdO
X-Google-Smtp-Source: AGHT+IF7IaKJSdToPk66ygauWBuIYI4bhnWeBOc7JZzNi0p9M3D/pOagfL4B+gAkxX0uQUM9td9stg==
X-Received: by 2002:a05:600c:3f14:b0:477:e09:f0f with SMTP id 5b1f17b1804b1-477307d763dmr110723125e9.8.1762162545082;
        Mon, 03 Nov 2025 01:35:45 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:e6eb:2a19:143f:b127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c4ac5d6sm147285675e9.8.2025.11.03.01.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 01:35:44 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Nov 2025 10:35:25 +0100
Subject: [PATCH v4 05/10] gpio: swnode: allow referencing GPIO chips by
 firmware nodes
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-reset-gpios-swnodes-v4-5-6461800b6775@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1899;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=M8Bc1P0DLQy5VPk7D0DtzmmkQ2KhHSrn6f+3txDi7M0=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpCHdl9AwQOZ0lLe1K4BR3pivzNYUL5uxic/vV6
 Dg6562lyRqJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQh3ZQAKCRARpy6gFHHX
 cnybEACaL21lCfB8IUqkV/9OqjRJ9SXXYy0LhUdavpRoQcKhHDq+3qVQZirvO+unRsSPea/cjVz
 I2JIk7YczwYX5rA4Z+bEcqG2R4N20Kyc191O1gh+3wZOxPllzfkbx0vExrSTnH+sSC4bbMAXH5o
 Sj5daga/hlpMB3ougK1i6xk3B0z77X9Pm5zVFjhXmQ8UkEMy9rJ+yW+vL9N7JeZZ6tQRzU8vqpa
 yYnMnNlrHhVQjBWLgMZ8T9XbbKtOKX2td6zV4e8kuy0e4EiEHfpuLSqiTMUdKJN2a0NE0YZkVtn
 yTGqYfNEte+deszdOJ6Ksxk2HQ279WIByqhkziuoEwLuiub4ofClLoSCM1lv+adN4nB+VuP2mWQ
 2EbT3liOLeqJFicQSUvskjxVdLdkAmZgiQcjjtMF8vBhP3Wkh9FqLx+SprGfKb4lF4aXfLeLaUL
 H4lapvKPWdtANyGYbxS18vmSUbzrRInMsOIri09t99KQmzstON9VLUpOspC+ojw/kSj/zglKvmL
 VErXH//Jhqgooc6PPwkTvMWocTwdZKRGx0hqOCdFFE8QsmEePKOnx8JkC9HaGa9lNg1bxg0lWJn
 OHKq9LNYzapsKAt+IggSXYs5YGc8N+/Whyh+1XcjFGIA4SDsa/XmfiG1K/GHX73Zx5cjwF5uiT4
 FKf3zwfOcN9AiXw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

When doing a software node lookup, we require both the fwnode that
references a GPIO chip as well as the node associated with that chip to
be software nodes. However, we now allow referencing generic firmware
nodes from software nodes in driver core so we should allow the same in
GPIO core. Make the software node name check optional and dependent on
whether the referenced firmware node is a software node. If it's not,
just continue with the lookup.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-swnode.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.c
index e3806db1c0e077d76fcc71a50ca40bbf6872ca40..16af83fcc5aa886dd009dedc26b1ac23e5cbc4ea 100644
--- a/drivers/gpio/gpiolib-swnode.c
+++ b/drivers/gpio/gpiolib-swnode.c
@@ -30,16 +30,15 @@ static struct gpio_device *swnode_get_gpio_device(struct fwnode_handle *fwnode)
 	struct gpio_device *gdev;
 
 	gdev_node = to_software_node(fwnode);
-	if (!gdev_node || !gdev_node->name)
-		return ERR_PTR(-EINVAL);
-
-	/*
-	 * Check for a special node that identifies undefined GPIOs, this is
-	 * primarily used as a key for internal chip selects in SPI bindings.
-	 */
-	if (IS_ENABLED(CONFIG_GPIO_SWNODE_UNDEFINED) &&
-	    !strcmp(gdev_node->name, GPIOLIB_SWNODE_UNDEFINED_NAME))
-		return ERR_PTR(-ENOENT);
+	if (gdev_node && gdev_node->name) {
+		/*
+		 * Check for a special node that identifies undefined GPIOs, this is
+		 * primarily used as a key for internal chip selects in SPI bindings.
+		 */
+		if (IS_ENABLED(CONFIG_GPIO_SWNODE_UNDEFINED) &&
+		    !strcmp(gdev_node->name, GPIOLIB_SWNODE_UNDEFINED_NAME))
+			return ERR_PTR(-ENOENT);
+	}
 
 	gdev = gpio_device_find_by_fwnode(fwnode);
 	return gdev ?: ERR_PTR(-EPROBE_DEFER);

-- 
2.51.0


