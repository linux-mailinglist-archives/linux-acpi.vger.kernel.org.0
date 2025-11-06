Return-Path: <linux-acpi+bounces-18589-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682BBC3BCEB
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 15:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89EC1420C79
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Nov 2025 14:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E28342CB3;
	Thu,  6 Nov 2025 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YF5neq0L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5865D341AD8
	for <linux-acpi@vger.kernel.org>; Thu,  6 Nov 2025 14:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439577; cv=none; b=doTlYKfdLknpPsLdTIo52r8Ts8SL6/ko6I8WLNeShnuTXVCJyT6BVNZ9Iur1NKN4FCMbA7KOHJ46274B6eIKdBmZB4UWcx1fTrJBMNS9AZ2YfcQ68/jLnzWcK6YgTbPCb44fkSr0CEpQWAT/IjqGl+iAaADw4iTZSbiTsVYAMmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439577; c=relaxed/simple;
	bh=WYtsFizQbM4aE384TZ7sPETgegiBGiPMgwHuc6DOszI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tJc2AxAIkEvrZxdFdNzjm2jwwoR6TvFbw3CXY04Bh4vt7EihK/1SBmAuNKSSm+pVZsAhXrkRQJuLrTnJXxX+huEuunzEncYrmOtZ0jkfQXSm3FJxLQmBBP+S4x4G4FQ3nxwaBBUMBi1wUjiFttOEZU6BLU29U94JHtcKJ6jyZIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YF5neq0L; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47755a7652eso7842795e9.0
        for <linux-acpi@vger.kernel.org>; Thu, 06 Nov 2025 06:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762439574; x=1763044374; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7IcwkvxZCoeChL6F0/utOZdZpB2dEpp7MA1q4biiOc=;
        b=YF5neq0LuZSHmReuqY3tsUucWbfhNm1STm0BAeH4xA3Q6/5j3PC2PZiVuVGToooGeg
         UX5ICkKqIR5Vsm2M1THtGDM3jiOv2sZIiDdsLoz7UriH4wHywsUIgdtxeCcdVTrtX3sU
         d5NwXVGcJLKpA/jnhfqAHg6daID1upjNqAcjrmJrM4bMGs6JvKUKWFlYpdxjo9bsY8O0
         gN6/UkiDE0fBDFgIkBVG8N7FN94k/LeNqJToHoSCxDwbbcuG0xKa26DL8XjdtAqcz2hE
         6QhuKLVhZOLsIq+uCW3IZggqfoZw/0AajJma7t9q1st7HahuRNCvJr5dRN5IAlM3qrpD
         SSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762439574; x=1763044374;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7IcwkvxZCoeChL6F0/utOZdZpB2dEpp7MA1q4biiOc=;
        b=V3b6IiLchYJOQYuKpyZyStzJH8TXPZbHKgdwawJ1g0jmL6I55ifxCEyCL1JXDCkCqe
         sp06NyKhYaTmGTA68nZDZw9dIJOv5QAuMFSHZQc0kednN1z5ttklmfc5aOznVPuwc7De
         6udfOHs+XPNRZbQzVoaHWwoEo6L1ygCtXPL8jUwTNlM/BZnG8KSACfkZuNA3leMlX/HO
         cDWWYOulXnfZSyWayjsbsSS2RgFYAU7ndGYAz7hAuMZtMRGHzQAJukExiOOGqVYUHA6e
         +Jga6GSrstk0K2G8brYpVViwI9OGd8ShkTP+vgegBj0RVYwZ/fTkv6LDvmjLaFmViRrt
         VyEg==
X-Forwarded-Encrypted: i=1; AJvYcCUt19iFd4MFV5WNS1KHAzP8pAP2m5UAVZZzwwQUWnxeSdhvWqlwkUDw/fMfhGj2JXG6LljW2Vdi9yzV@vger.kernel.org
X-Gm-Message-State: AOJu0YxBRpbEEgOsqqEZKbpnfzOGVti+sYaAL8qpfDnA4bIwSccRQTDW
	SE9ScBbNm3n6mMXhg+JPXNKhFmAvpKUe2Bq1RC4c589I7yesxCA1jCJp2S2cpmp0uJ4=
X-Gm-Gg: ASbGncsnz+LEAPWzMccKEGMCoxT1+hxPekYdUq1td2BtvpVLkf3pDfu9iLRC0E+kbDp
	ndllmlfWiXIHnCILEj3A9ErGSNnQOJpfT+nkRP6oZnfeFb41thgSqy+XufPoBGevEFlYZc8YsEW
	bTY9CMQniFvm5928MKW6+o0UeylAfoEEiCb40k17yS0G675Uwl1PZvVLZPu6Ig4zkY6kCUJl/vk
	6LxGQ3ZvIQDOlSnL+2zLLNyQynF7p0LKUpjwWgRk7DcBDZ+ab5R/KsT3jt+tv7ZHxkEJtlT46P2
	FqaxK6jNgcF3f3rrGpAWufFfnu9270C3fLLsgQx2UfuZbdOtc2xtZ9aZZf80t684KAt0PQ0oyz0
	bYhNnHlI+/c9iMASKrEDYUy6GcX1+Wyng/1U4LaKpcQBh4Wth15bzkzjtV3PH9ytNv4mo
X-Google-Smtp-Source: AGHT+IHJdCKOGEmHwglYreXy5Bse1Ht9Zj2E+rvSJcOa7E6LW1TY2KvZ//8CiDhbRc9P4HFHJuuwfA==
X-Received: by 2002:a05:600c:1c94:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-4775ce23efemr74189185e9.17.1762439573533;
        Thu, 06 Nov 2025 06:32:53 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:d9de:4038:a78:acab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763de4fb5sm18871515e9.2.2025.11.06.06.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 06:32:52 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 06 Nov 2025 15:32:35 +0100
Subject: [PATCH v6 6/8] reset: make the provider of reset-gpios the parent
 of the reset device
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-reset-gpios-swnodes-v6-6-69aa852de9e4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3056;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=Ii5gmVXHOWj2TYAgDLdwPMX22jyvG1TmKArdiO0SOxI=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpDLGI5l3FF3L3dsFEJ/gvixZtSLWIepU2+Aso+
 YY1e1LkzYOJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQyxiAAKCRARpy6gFHHX
 cpZ5EADbU7IR5S1TwL7Fd99QpM8Zu7t+FI68IXzt5a8gczcc8DHYtzF814Z4g+uLAosB9HysHM9
 bgQ9kJ6RptXNasK4DBVpPBWZUoJqh1FrO3P6ZEn05eNRjC1hGK5wbUXUK6QuVgt8cv+4GsffJgc
 yD0YY344Q2MNZoACpGMXk+Wol+46SpvC0S7nZyvZjQaDgce9OdKegYKZraO/T9P1/Z2dc7WRek9
 ntSAx6+BPc1pJfBNwXye4Xgh2YMR+sYiooRo0at3VsAkz9dtl/8ZyiPpHdNnwjOXpHGysZx0DwR
 FmZfcDuxMLURmQ7Oz5aQmHxTcTrPQ6tZoZr5/8vGVuKzMcAI1/KlgNoRmJ8Ub6nz/WSkrOKedX4
 kNZSMoQUjUWdbZyu7Cl4uFbydqL7czxfFHc2z3l+KS3iGiCKAJkm4yL9RDRFBK/bUARKg7Np6Vf
 TM0gw19HFDXWiU84ITZdYMEWk4rIJcsPxKQtEg1I5ARjdNISOAn0xNPFIi29R7oGfPqsCC08RMG
 SKGkYxNtPy6wlm1CAfVld627EufBBupmHoOoqYlJwskfKwmVqH1So4/DqnDAU1fd3gZCJQ/SbmZ
 iBjnmE3YKQCLrpeEDrtMy5eH+8F6K7FJ7GYZVv/ytQoGCtHnZeO5SZBuAkVoaZabjg94L+t4Pwb
 PGgwI84FvtIuyzg==
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
index b3d3339dd6d30495b498b3f650d18fdd96a6bca7..31dcd25b465d795dda275f751ed6ce28d4dc27ee 100644
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


