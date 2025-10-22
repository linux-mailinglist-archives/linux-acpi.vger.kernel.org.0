Return-Path: <linux-acpi+bounces-18096-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD090BFC622
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 16:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF03B665BFB
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 13:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAC634CFC2;
	Wed, 22 Oct 2025 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hDbl+cls"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4FC34CFAC
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140489; cv=none; b=Y1GMGwQnJAPQ8UV9tOIcnr1RMULuSkcTXlD9UorAd6GGIRXGkGbqkJFGOJSSdZJGah0YgBP0J2slRwbUvf03Wff9ZQE/y3/bzVHPg2q0IYmcMR1mDjcDWS3P0wlp1AamN1S1xEVENNhBSvDHmoAMev2yEfOICrt4IFefXKSM9r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140489; c=relaxed/simple;
	bh=K8U+CHaEDTDTAOOAhIZGQLKRldV6biiXuo/pIPzTEZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F+ZqEBB/LJc+pDkxNbXOwB2xHNSScJZ+QdYS3uR6FWY+lWt7G7q8blagMETmUbfr23tRp+sV8jo4ti52TZvcysSG0Dffz63w2FXkSbw1MXPJgpDtZ12kxB3/V8CmyeP6OReyy4X6Hd3cPVdkI6O3eDT3k2cy/J2WwuBGzjX5cvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hDbl+cls; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47100eae3e5so23860835e9.1
        for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 06:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761140485; x=1761745285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6pKa9jDqQ70bpsXEO6w9amEFdc6+U1mZOoJWBfQBYnU=;
        b=hDbl+clsC4I6duTYcdmEXkaRVm7iPBkIxr2mHkRdQ6JCgNN435e3uD3nNcvhTU82pt
         WIV55BNY0Teh5aBk64T7oKRQCaU4MI6hGuj9mPP+b/5TIaAZ+MapMvaynY4RP4AYWZim
         SOcsA2bBLhVAHIw17b2R047ieFBR4Gn9mFp4r7cStVrT93z16BDBHcLiKL61R37w5MwU
         haKfATbEdgLGtVn1zvLAKBFYjKMvEDP84XP52Zb3C5OKD//9pyQiFfXDRCoDJn+y1bjm
         rydXqxnKwb1bok7PW4NJ7l55CJFn8TUJT1EMhQ+OsFjNvQR5P72Q0jYc+RlDh1rzfkNj
         Tg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761140485; x=1761745285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pKa9jDqQ70bpsXEO6w9amEFdc6+U1mZOoJWBfQBYnU=;
        b=gXjTgrD1T31JmLuKifCr1x14m/Ca1c+EmPfDRwrkWSqi1S6HJdvRX8qBMebBvmGzmm
         5UsBHwcEaOsctCiXWCUoXwd5OgXs29KPkJTs/JJdaFCtwKqv3IfsNXqH/1rBFaJU3rkv
         /yvwJzQjdp0HZgBpalRqEcy7kl/6xdBoquNkkKYhQrKhKRK0jIwfhDoC+uW7jRGlpFxz
         4qLUNVOGf24GMU8147KohhTSXDPm+VsYSD/SQQovAkCERt3wpDRIl2KUSaRtT1o26enA
         ycgzP9+Cpdbc3T2Gz8NOvPwavxQN4Br8iXBo2rbD1moYMuBP2Ww3f9uC+oTVNm8D/QYO
         QyJw==
X-Forwarded-Encrypted: i=1; AJvYcCUDRmjY9s/Xy0h640sFQZ5Opn9IsOJy+RBQXpD/mWiWCKjlOz7QVWMJrL4L3pUP1lTzhhfhdC3HQajl@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtvw5fQyhR6cdmAwWl4EPBdfmxVZbTljF3QJuU8LuBdjDKMPSq
	Hok/QqIriz4D9N9wsIpkibtb+R844s4/KfreunHndnK9jaKPtBn7cIM97JMVyMLaUvCfygXO7Ev
	Pgi0TDXXqJQ==
X-Gm-Gg: ASbGncuCBHTQqbc1Bej74WM87xPEs2T/UJsljjQRBbFzGehoHsvYekS17GQw2G7lgRt
	hraDpH49nXwaZjGtOv0SbSJ05dOFE+Dqh976jWon5AlBteo+0Orq8hPA+gW7B80eBrHlbsB5lFN
	WNF6SeOlMyzNr1seTv/ZIbZvrk0bx/Vn9KeuG/r2vW6GNMcMZeDgzvBufUHL7IFr8PD7Eih/ugo
	o+fblx4o/7Vl1N2jffFhhLrLCe7LWubZDC1hctaZ77NOR47oDAfRWVe+CLcN18xs7FhL3EAjWu3
	gLKUeYxttnNSWectsLNRGmNrfj2ltMtA9K43Owy0LJVf74dsmrPTaZ03cRBF1mIVPNjeqeunlE5
	IwT6CeKl1FFIrsm+f+g9VJyNIIFpK+Paj8Th+DuXw6OWWj8EQvkEFkQj/vlzKLGs6J6c+hXc=
X-Google-Smtp-Source: AGHT+IEWodi9VtfUFgyR0PhAnN9d1R5dKHAQUd7Av95doTmMXw7eZ/NeFsiiRrgT3YqE4AKBtoHKjA==
X-Received: by 2002:a05:600c:64cf:b0:471:12ed:f698 with SMTP id 5b1f17b1804b1-4711786c793mr167093185e9.8.1761140485406;
        Wed, 22 Oct 2025 06:41:25 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69df:73af:f16a:eada])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b97f8sm24863066f8f.36.2025.10.22.06.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 06:41:24 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 22 Oct 2025 15:41:06 +0200
Subject: [PATCH v2 7/9] reset: make the provider of reset-gpios the parent
 of the reset device
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-reset-gpios-swnodes-v2-7-69088530291b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2973;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=Zc+xs5tXGUpl9lw3Fpnc7se6u+D5QtL6RaYw/hFc3wY=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo+N70lgZq/69WAbh86SPgtuNEqqEozH06DyaiZ
 R6ZoYzwJeOJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaPje9AAKCRARpy6gFHHX
 cr1hEACB871FkPQGyrxMmMwg4Chadg/Dp0ONPm/eImZG1uBp0NRFosuslDu84tSGaH++9yIU6VJ
 30U7x223V7RFMO+5zEFa6uo1AMgsqIu+3DRvY3JINIZ7HMQgZDf/2WXRQxTgKnJbn6734osLn/0
 WhizdzOz+JgrsPQR7daT7UtovtUOTpHGWVL0mtvVLQzYD9x/Ex14afMFoaINkbtmhq5le2S+fft
 EmUU28/S3OyHpjmWnBgCecSbmmjA3j/yISgPC4jbCq4tzE5VSQDzxSiRFSKz3wYgEh07R4M7R9O
 WKAnbl410ijLHiSyMLtMpLzWqfRBj35Q9t4YSaSGNpkoqbbafkCCWhQjDM7OZi4XFIdR0vRA4q5
 tvDt0eT5IGnihe3xmv1lZBGs/JyY5WF9n7pQo5j7hzrh23aADGI4c4SrYMumIVqELlXe+p1h1hw
 89gQqssC2sBn/FnySDHZGk+brD1N/v0doEXLKQR9iIAXMIan1GyBUFrcE7Jq34VttnXAoGfTMeB
 udmkYVvLdmyQJIe3QTxMF8myvfyxVcdG2wyEGueXWncvJin4xjcRwwcEXGUTPYm4kOBN8MPV0yB
 NGXDrgXjDdN39wYjnDccEB6H8swXqoeSf0UBG0CG4pNSTOjHpAmWigReTw5WB9e2Vd9s2XOhBns
 xjyALBpYdzZdzRA==
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


