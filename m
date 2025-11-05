Return-Path: <linux-acpi+bounces-18524-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2E2C34922
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 09:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F0BF4F6612
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 08:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530732E7653;
	Wed,  5 Nov 2025 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="dy+gHzTa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694E22E610F
	for <linux-acpi@vger.kernel.org>; Wed,  5 Nov 2025 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332491; cv=none; b=V7xglKAWBGAd/9+uJFae17+KXjOWSABpCIoYk7wJFHig9OdNqX4ZzmBRvxtk2s1Ul4nUmsumWW5Pb5bOJQiqru6tK/1/jOcqOnTKULAia2LYSJqdnVuNMqfeTajXr5pobUAH8Y0Gf+sRoCeHFehKVvFzLIEN1VE//SnYiPzVRyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332491; c=relaxed/simple;
	bh=z0YSr7KrcAc/k0WngzdsyXNvl3twXbRlw/uwLjuKOK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lTbdgq5i62ykrfV7VgjHJEpjPOuCz7TcN2XUAsjpv4mp2i6dqk8Omf3Z2F7pVM5ptpPMtgNElzbzXvWi6ho85RPunyHBirY1ahyMxcyz1RelRhptvTh6/cJeuAuz6Tonc2VBN2VEFBHOPtQw+sXHjquYxGauKpOmsNYAMkHueq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=dy+gHzTa; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so4107507f8f.0
        for <linux-acpi@vger.kernel.org>; Wed, 05 Nov 2025 00:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762332488; x=1762937288; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fvp1VGmfGTlzha3gDCL6Cw0t8OXa3klcmoFT2A8KMRg=;
        b=dy+gHzTaCSQKVv7bgXbWEbOcCyH6y/WrrgmbhbIQA/Yy9pU2ivUe1q/EA8OnBKg9HA
         y+YywLZ/FsxpP5aCVTkIVpHfZQA+uuzDcjecsrMwJSwDS8/tE1MQ8bP15R5yw4q6e3dg
         NOqKSDSJ8AtCkbc3qiUtxIW+rFFdwY5jN6punOonfa7qF3j4Icao/xGPnDQuVZo37Pf3
         8vjbLnuWyP1EjF9U174ll8WGXOySVjBdFs4oceiGm2XH4OgV9RZF3VDnJ7QB8VPIr7/j
         A4fnTuD7DZjgecy+SFTnGvp4XUpK1aOEZGXmfqrftPnC7IxUWf1ZaEOzlQnCJJUE6E2g
         5ywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762332488; x=1762937288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fvp1VGmfGTlzha3gDCL6Cw0t8OXa3klcmoFT2A8KMRg=;
        b=iEzpj7gqeB0cH7dRdvRHu1SvzejW37kNKRGxC8Nn2DuP3b+3CLd3fA1VkzM1Lst8Ev
         j5oAuoq9InRSBQq05SYFRfP2SoRTiT3MbqdMJAG1q08vpPDNQYmBLyWXkm5iCnsdukwq
         I0nE4/ygEyvS437M2HI9C24jGxlSj0OtbIvdc5G6X58jOjEcArzg7ljDydAjNk1GSyZn
         K9FkoRMONjjxD7ACgZcshzxYzgcSFKJ/fBf29wiyaLN69uXI5b3VjoPGId/Lqw4WZBkQ
         PMvLKPi9QbwWyCOeGjp5GDzBDTrSjweBDj0Hp46sG6A/z5gzk4QQSuDFqcXiBFjJQKYc
         pi2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+SQ4PWbjqq45gHagKyOVT9hT6sgHYuA0ToGkIRXDKYzMqj4CCKiOl556bkyVYPbvO1R39goEeFJMX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3iyALyQTVoMjsJGB1tgUaD3McdM/WPZ2zg+s5GtmCoMR4oPRI
	0pJmSK3ERHjX/GvL+S2Z13q1g/c9RTbvV+h9jOQ6cI7c4W2+oaPUOD6Do4HmKT8xCuY=
X-Gm-Gg: ASbGnctF38GK1mtgCwJexbl/tVBo0Dq93vm7T3FaiKMjcP4JKWW6KJ2C9uI+m0iOwEp
	hh51Q+4i7OfD7Hrb/6fwFVQBBQqc1V5xV202mtpgP+tk1F2BrCuTP6WJB1sW5R6opYKgg3OjqAa
	/c9WYO4f1Mr/FlBlvVvGgUwx8AucIPI2slYusXa59IhB70VFmxS0iBmud3NakBFcwWYrCHJYA7z
	IldCZhKiAVUzvXd3XoV6VWZpsbXTXT1HKEITmXq1By5KIPvdeIY8odIzxU3QTxvwMA0FuCqktn+
	zqZI3NpjH+5qj/JFBtpkfJsM1N7MeplU7kI+QbZ4ydnKSHyDLaQi7fb2tBId28KaY4w/yyTV2Mw
	GdMA3ZBxBHuwU07PM5IVT6gG2YFgraT20AGACayAPQ1OFjrIGf/JT4Ap06HVYmxxdKF4Axw==
X-Google-Smtp-Source: AGHT+IFCE+4Da8gI0APq0iWn7f7Tme0BJA40NUIdTq6Amxypg2aQ2fAQIQCz8g+XzJc63cIpCBUPiA==
X-Received: by 2002:a05:6000:2382:b0:429:d6b7:6b9f with SMTP id ffacd0b85a97d-429e32f47f8mr2313937f8f.26.1762332487723;
        Wed, 05 Nov 2025 00:48:07 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:4e71:8371:5a52:77e4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f9cdbsm9315936f8f.34.2025.11.05.00.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 00:48:05 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 05 Nov 2025 09:47:37 +0100
Subject: [PATCH v5 6/8] reset: make the provider of reset-gpios the parent
 of the reset device
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-reset-gpios-swnodes-v5-6-1f67499a8287@linaro.org>
References: <20251105-reset-gpios-swnodes-v5-0-1f67499a8287@linaro.org>
In-Reply-To: <20251105-reset-gpios-swnodes-v5-0-1f67499a8287@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3056;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=wbCx8dCgwX5b7rXFrK7TZvcGe4EfqUhDGU8MlxrqJm4=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpCw8y94lVfYRIK3McHELuUpTU5D9HiSg4LMYZM
 EAFZ69aoMCJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQsPMgAKCRARpy6gFHHX
 ci/GEADK4gCdF+QDAPvyLEV4JJIEZZxgc1ErzGdn2kDofeunda+GvStXzppBh/AuLJ4gxCjfq0S
 l1wmQAggynStqV+JKrxGsCw/fDMxLObSyY1lgDa+usBSk+dFPTDAYhT5HAecSJn0/aCyPwp/5Mg
 2H7M5a8RpFXeuA2DqnLp+OtIUylDqO2DwEr8+R8CBrjJO11QRCbT1bXFKiC67sVTkLdfQCPntFh
 EdI1AyHFpBaKWzO794u1vQoSMRHEvZZwBdsMx/icWd1yLl3GKL0rSrvbd6HUuiKQjCU4QMdVAx7
 kNQf6Kcm+KrHm9TEsaDGEStQWonlDedBK6YQ3O4rngunRNW7mRXsmfFzP9MT5bNRnScjj3hJVK/
 mJyGTFXxwhyCFWwRPZyOvACvGKyiAUJEZjDJ67TnsuAilPYrWGMD4QK0CG9zsBU5VrDlXewu4zZ
 mk80DChNrF1wkVh+4TcUJVoxVIz1mlk722K2+uF/gNy1k+DKlyIbZIpCg3sQfnUWCog1o+V9KL2
 bRoSlxkfuz2ei975/7mushqLRkpUrmLgeStJqV0DNaMlbaqAHc/Qc/a0xkUbuXy9b54g3IZ+8r5
 UhTrrZYZiUZCDWECU3GVJQzil+X6wAuEzHjuKZKRg01NYjtlh9msW88V6H2Xgq0nCFYoell4GJr
 jHg0GjyJe3xm22A==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Auxiliary devices really do need a parent so ahead of converting the
reset-gpios driver to registering on the auxiliary bus, make the GPIO
device that provides the reset GPIO the parent of the reset-gpio device.
To that end move the lookup of the GPIO device by fwnode to the
beginning of __reset_add_reset_gpio_device() which has the added benefit
of bailing out earlier, before allocating resources for the virtual
device, if the chip is not up yet.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/reset/core.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index a368b14144e7bc29ae23becab2eb7a96a4adbe44..af42f4d12bbbfcba225219eac6d6c7edbe2405cc 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -822,11 +822,11 @@ static void __reset_control_put_internal(struct reset_control *rstc)
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
 
@@ -841,10 +841,6 @@ static int __reset_add_reset_gpio_lookup(int id, struct device_node *np,
 		return -EINVAL;
 	}
 
-	struct gpio_device *gdev __free(gpio_device_put) = gpio_device_find_by_fwnode(fwnode);
-	if (!gdev)
-		return -EPROBE_DEFER;
-
 	label_tmp = gpio_device_get_label(gdev);
 	if (!label_tmp)
 		return -EINVAL;
@@ -899,6 +895,11 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 	 */
 	lockdep_assert_not_held(&reset_list_mutex);
 
+	struct gpio_device *gdev __free(gpio_device_put) =
+		gpio_device_find_by_fwnode(of_fwnode_handle(args->np));
+	if (!gdev)
+		return -EPROBE_DEFER;
+
 	guard(mutex)(&reset_gpio_lookup_mutex);
 
 	list_for_each_entry(rgpio_dev, &reset_gpio_lookup_list, list) {
@@ -919,7 +920,7 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 		goto err_ida_free;
 	}
 
-	ret = __reset_add_reset_gpio_lookup(id, args->np, args->args[0],
+	ret = __reset_add_reset_gpio_lookup(gdev, id, args->np, args->args[0],
 					    args->args[1]);
 	if (ret < 0)
 		goto err_kfree;
@@ -931,7 +932,8 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
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
2.51.0


