Return-Path: <linux-acpi+bounces-19147-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C0806C743DC
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Nov 2025 14:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 8A1CF315B1
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Nov 2025 13:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA73340A47;
	Thu, 20 Nov 2025 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="n7B5i7X/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2214B33B6C8
	for <linux-acpi@vger.kernel.org>; Thu, 20 Nov 2025 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763645069; cv=none; b=rxxdajyM5eG75ZVl1U5hjXv0xhZq7GTV/FpkKgUizBL+d/Y35g9jSTYbmM3YmlwkyHD+nNffh+bjE3zTQQ+p/ydSJL3LeCVnHQKIzTRyCtafBM81d2nztx83v6WsIbGtO0/Q8WBaBxnHHqKos4SS+c4/Pygrha9/WcAG6fL7UGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763645069; c=relaxed/simple;
	bh=xH0CG842SvjgRIU9+ZvI7SWECNKFgSlkkOq1ntKdt0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MsdtWmE1MbqzPh5fOeKNdpCvVJd68dW6+8uEiw1QO3Ap2S0RAJ2kgNDY3h2+jWJ/CG3HRigIgM4mI3zqGV1J6ieEl2y6TabYaA15kDg1cIFeJEOkU9t4nMFf64pCpT9f70lcK5f+tkFQuc3i0sv4TKIb+uDKVLoQoJen2SAWcUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=n7B5i7X/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477b1cc8fb4so5956135e9.1
        for <linux-acpi@vger.kernel.org>; Thu, 20 Nov 2025 05:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763645059; x=1764249859; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31em30QMLEREEBSvcPXeWYIA2k37w8MVjGybg5HKctM=;
        b=n7B5i7X/3eNHhGxZqXrpKpn1GjBY27/y0ju9S+Vt6XarErvlB4cSNsccVOxN17Sd3J
         k0Xch9axtn7aX7LrZkScKKOpDxrHR6J0SubxZO5n1TcdxbKZ9tuA7Kh/Yc+0jsPkBNJu
         ULy6gFze72EEreznjeT+neDJEnO+D0xQJ0tCIJ5qlFUNw482GFTFL2ELmeV3oCDsgYoi
         dXMMSH7Z8tqN96zt3JmaC+ZejUyZWFifA0a0+wScOlGAoGWcr06Z7JZoQ6V45Kdr9Vle
         3/Nb4qUF4ekL/iqTmjQnf0ImCaM0MC5o+ZBwooxYCIoeXCgeyP+K061Ygm0hzHpvp1Pg
         NJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763645059; x=1764249859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=31em30QMLEREEBSvcPXeWYIA2k37w8MVjGybg5HKctM=;
        b=rb8fnWXht5GJDmhiTIkXo5drZZQT1u88nN2joADEdmeic1N2RrnvvWgs9FHkhV7j2I
         RXa+/jm85w69fxGklOVjJTho5RSgrDgZr9PlXUUAYGrwqFosT3ChQ8tDdayFMIhniH5V
         Ow5EO+P2USA/2Ya8ZqZqhg4YHtTRTsHquiLgf/lkkVxm6oZW8I/4KPSqPmKhDg0L67KH
         tdRgx4Nl0ya+Rqaz7wsL+ALvWZ7oziuNqInNpQ6cPdgAEkwBDtC99yypsZrGZ4xhAvsq
         e/kVwgITikHc257EoxsN5IOZ1OIjuDlorL75TbKh0XRJP7GTk+/UAMdjQ9hxtxTf/9x2
         z/xA==
X-Forwarded-Encrypted: i=1; AJvYcCVeL+bWIBTe/VsiHCoNK+BuRAdMf8i/u/2TY/5IopDyablAldzOZvozr4gm9RI6QMe8uPBqV2BXC+Us@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Ll09YitxqT1Q2ZYPkJL1RO7HjdHEmJ4+lhDu4sJb/Ru2BCpC
	riuJpm6JdFBDdMitg2t+XPIflFcxj1XsNL90Z6G78+H7lik3dKa/nut8Qbb0QpDoV0E=
X-Gm-Gg: ASbGnctb90ENVODspIlqCdSMxcZq5XAs+SdtbTim8qpaiDxGXW0GtCdyIwpvOxufXJa
	2UdL1pRGs/stqqQy1TKYv22xv+tSm+hbxYSI13LOVkLCCepbXbfO6avzZVezNA5hIMkumgKmozE
	svsD4ie/+tDIcng95yej0kZybVtk7cH+NsH5zv3dqiidSFCvEg2WdLN7zfGX/8HVfY2p/vwff40
	I50kooWMHXKYofWRGF0aqCNr4t4gEyc1O968bYXEnRg1d/oPr2o4JQAQCas6sUOhzc+ueszS9qm
	TinC+HTtyJOsbOI4S80sECc3N1QoXLHnPtZZ91mPj1UgG0+Cz2XEXLkAwltPQUl6C2GySZfJvZb
	hMPCCEzK9oUGITB5Xf3z4MocB2FSd+J12sq2nAUmhoJHwxmoEdNIA/fxWFBpNmCBPTqhpUvJM3X
	BpjJo=
X-Google-Smtp-Source: AGHT+IEXecxg5QFk63mFO+FspplntioJsgDc9pqGDG5H5xEPtvWbefQmM8ZTCVargBiZYfg5G09reA==
X-Received: by 2002:a05:600c:190a:b0:477:9a28:b0a4 with SMTP id 5b1f17b1804b1-477b8355eb2mr41764215e9.0.1763645059186;
        Thu, 20 Nov 2025 05:24:19 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:37af:6c1f:28a:47d2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b82cc72dsm46762935e9.1.2025.11.20.05.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 05:24:18 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Nov 2025 14:24:02 +0100
Subject: [PATCH v7 7/9] reset: make the provider of reset-gpios the parent
 of the reset device
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-reset-gpios-swnodes-v7-7-a100493a0f4b@linaro.org>
References: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org>
In-Reply-To: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Mark Brown <broonie@kernel.org>, 
 Maciej Strozek <mstrozek@opensource.cirrus.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com, linux-spi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3115;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=FhmNonzpYHgRFKsuekRiAhccBMXMP9k+uDJyjRxj7Ok=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpHxZ0WP52PZD2bEnzAEa+WWNWxyYU1nUOtyWS3
 5400vW/PNuJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaR8WdAAKCRAFnS7L/zaE
 w64nEACk3w/L1UOykoTfQ3nBiRV3xyrul9xLO6AQmJmsiY+ds+Z45OaQA15VzYrkrdLmHsxBCcT
 f8Y08HLZVsZIqYf0YKV4TLBoJQnRuPgVzlm8QfTwfCO1Kduf7wBpYReJGZMAcxooiQ4BG4wRBhZ
 UoK0BywjWsQ5tVX4qPMEq3GEv5zMhWtTb0QPu+Qc2vVlVJQmDdWOM/k54i2BMFIumG1JRR+FVKB
 MNU17clQQMnheah2PUyjSLOk26dFvneF1HjrzHQA4P0qtPP5m+ZCIfq8028gVPsolO1PRizrVyQ
 Td22bMHRYIkYKgBmf+uF09oel9NESSJjzSkJbwI/IcsrKWZadc0i2MertOTGI4ijwiq3n8IyFm2
 h+yrmIr9sY0RhMu3ZeKB+mzMJolfmLnTODbxi/A0Tabc51JmWE2B1jDxCa3Emundby0RuFUd6sT
 OujPW6uxgVGB2y7jiA5JX3jkqwNOHLAWUIS2lbwavf5Sl8X15EH3lZRjADMQtJd5gcRFTbAX9/o
 LJflkD5hVZM++f8eGkWaNWDa8qG7nGO8wXr9v2NaOjmAc80vhehqOrE8MoEASmuzfIjB88adXMK
 QRQhuTu4RQGIEqsEEhXoI9aPY2TOM0TBBjQLWqszgO9Ue6Q7hz4h3uw/FRlP5bJZmz9NtLXsrHJ
 zat+pdXbwPhYV5Q==
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
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/reset/core.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 5b6f314bdbdde84a1cf613fbf70ae39cbb5e20e2..50ff078dea7fd84d59e505fc1f607f593ec6381f 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -819,11 +819,11 @@ static void __reset_control_put_internal(struct reset_control *rstc)
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
 
@@ -838,10 +838,6 @@ static int __reset_add_reset_gpio_lookup(int id, struct device_node *np,
 		return -EINVAL;
 	}
 
-	struct gpio_device *gdev __free(gpio_device_put) = gpio_device_find_by_fwnode(fwnode);
-	if (!gdev)
-		return -EPROBE_DEFER;
-
 	label_tmp = gpio_device_get_label(gdev);
 	if (!label_tmp)
 		return -EINVAL;
@@ -896,6 +892,11 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 	 */
 	lockdep_assert_not_held(&reset_list_mutex);
 
+	struct gpio_device *gdev __free(gpio_device_put) =
+		gpio_device_find_by_fwnode(of_fwnode_handle(args->np));
+	if (!gdev)
+		return -EPROBE_DEFER;
+
 	guard(mutex)(&reset_gpio_lookup_mutex);
 
 	list_for_each_entry(rgpio_dev, &reset_gpio_lookup_list, list) {
@@ -916,7 +917,7 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 		goto err_ida_free;
 	}
 
-	ret = __reset_add_reset_gpio_lookup(id, args->np, args->args[0],
+	ret = __reset_add_reset_gpio_lookup(gdev, id, args->np, args->args[0],
 					    args->args[1]);
 	if (ret < 0)
 		goto err_kfree;
@@ -928,7 +929,8 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
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


