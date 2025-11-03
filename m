Return-Path: <linux-acpi+bounces-18431-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC04C2AC75
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 10:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CDD7188398D
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 09:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1790A2EDD7E;
	Mon,  3 Nov 2025 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="diuVwOjd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315552ED848
	for <linux-acpi@vger.kernel.org>; Mon,  3 Nov 2025 09:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162548; cv=none; b=ko5TsXdTMuVAv+Vu19WfGT4V3O3chgvvGAa7QPGCr/fTMAAGIrhwnQpAov8dkZPUfVjgZ8YI/0O28AeOl7T6IxRTk4FUO/t+cJvOGWQcssgD85aBPAmCS9xzdR5j1TaAHLA0qxoq8dSL7f0K5ZvZifkk3NmyFp4KrRd+eVNVPuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162548; c=relaxed/simple;
	bh=kksf8j+Hcw5JU8yFcOn2UF2PlDbCA9geMD8Jwj5RJbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fkn/g2wQmQnPqdneyU1/Myzkp/Gb6PrcwWRYavgpUPwvLZ8UZN4xiLSOK0tXNgnhUMUQccVR1MP8+kb9wXTLvyrKOoFtdvnLBrmCO9WrMXDXgknhVWYPC1bSjK8sAeqRWywtcZgb5XE9LPjKXTytcEh/7Fpag+2yZk4CLCIwAz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=diuVwOjd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4710665e7deso18959965e9.1
        for <linux-acpi@vger.kernel.org>; Mon, 03 Nov 2025 01:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762162544; x=1762767344; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQ/CHjiLyML2L8csBl+Z0R+SFBYXY+YFQ1rdbVNRMig=;
        b=diuVwOjdQtYK4d1yv8w3kiWum7gW6vBNhl7vYTCVemuRO0vYq0RpllM1OSfvONl8uj
         i95X37aEzqkbSAEZdkZi6LSjuPdlvephPk4A9tegzLE6JFWKlftSMt0jtTl5Qvhn2Y2L
         W4ExjXEPdQasTm/wJduXOQzHbBBmGEfibUcgPpp2yYFa5pVN5FzlztkdLfTqSf+ZDpZ8
         9S5FNH97f2JHJR9dja7fWhZxeuWC40Ys+hYXbffCU87bQe+XnX5e6cVXUg49frFofKOM
         yvUPLh+pCaWIOSbrIeQJht9WV3y7HPTJk/n8OJwxlZzt9ns68L8MwQoN+8pcJOhVFWOF
         cMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762162544; x=1762767344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQ/CHjiLyML2L8csBl+Z0R+SFBYXY+YFQ1rdbVNRMig=;
        b=lG0jXFt8hFK3RjrawaAsra88zTnFDIS02YKrFJy1tELaGB76ma4+Vu28jyGa1p2tnh
         V4F+dJtomKL3ZItcQkwnbDei28w4CuBjric/yT7OwdrpcCfgLUgRFuk5ZpIAQKfwxW35
         ECKZuMWq2ZqfPV2L83wWActntrG4Hm1F+xv7ZO5z/N1I526pNT0XSLgd2AWUz/4ve9Bp
         Sg1+aC8TqJPYrnpE9sMhJjkemXOTgOPCTSvO1DisAfcudek0pWNlL9AF1BaREvF7/sMD
         K+Seoq6yFcIpqjCWLkBFONeMnEmypuxvmdTD1ZcZKBnZ4H+C5DQTyr57j9HGZdVRA9XK
         YYIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUccV3MAYoi7q41ikluXTF4qIa8wWtILt5na6gel6iAYyJWi3ZZLtUQMWvZSLtF559YJS5a45MnNNbm@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6XWVxAfWWfExbJbgPFpIT+zquH4PUxVoiZ/FqdiTEYjuVRko6
	ZeNyNZzFwaZJslcUnMvqeTnJdQFadLIovztmF1cn8JE2wzdWa1NigeuPkJZBFuKmElE=
X-Gm-Gg: ASbGncsdiLrNVxM4bGyGObdDWk0aPBuut7QZ/lJpk+lCvN1cbswTACYcA3aVkgg8abO
	L4uWq6S/BqJGV+d+BR3RA+RBED5MhklazUKtHwpA6LYjAavmr6m6wwJsKioCw4B2Hd88iV7e456
	YtKgaVhMy9d27qJ5rLccQVoJFJz5sE/gMMKZgvYriNHZ6zRU4w4geXQKG+RmsGMlIV3TBxX3ceQ
	qp+YU3XYKkSPdJ4tQx1yjRPU8O3qkA5oK7HaDdxEAAMOtb+NdShGarRQmCzu/Wj6tfN8TWZAgd5
	hyL4wqCBIirub+nltww6FLAhMBaJxbOoMf4tYkMzKNZAtp65KTrI9igLohGY5hUTSMi95LBqf8L
	2oW8FeweiLM/sTuqQ1lD/mWRfrGGmDE9ImketjoZM+0PoDeZx/O9F29XJpGCKvfyfddhZKA==
X-Google-Smtp-Source: AGHT+IHN4PGzBvmPMYk45NnIf2vdYAtArzKxGN21jeZflOCEniXunDu4DmEIafaFywGvHU0MZkLB1A==
X-Received: by 2002:a05:600c:470c:b0:477:bf0:b9da with SMTP id 5b1f17b1804b1-477308aac1fmr112539605e9.19.1762162543855;
        Mon, 03 Nov 2025 01:35:43 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:e6eb:2a19:143f:b127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c4ac5d6sm147285675e9.8.2025.11.03.01.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 01:35:42 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Nov 2025 10:35:24 +0100
Subject: [PATCH v4 04/10] gpio: swnode: don't use the swnode's name as the
 key for GPIO lookup
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-reset-gpios-swnodes-v4-4-6461800b6775@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=+SgeJi/LAPcV3I1FaGjOhnzlzc7OwWZ5YSpBPYWiI+U=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpCHdlvyju2QWO0W3WvxOyVQeU+3VIAuq4ljqfl
 pw/rdKXyrqJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQh3ZQAKCRARpy6gFHHX
 cqCgD/9pcmvHz+OyJCli2yL4AcetwaZfy2T/yDpmBuJGCZtlA06onONyzWew3Ga9U+ryAPs+qWH
 yI6/icLhUGJodJoNF7WyjWgXn+GA6JaqINQzWEg7ZP0Vfa8K/k8iwKF4KDdrW+9fsB1uXkolkb1
 8139psdSciNoHGvvJHyISibTBLlN94PuIIyGOYhbrPk0fOgDWt1vmJDjmVSFP5V3DIaFhxe8XWr
 fc2A8wyV+GwCTACITyrnbqMvc/ZihSWr3W19Aec4HyRLkILGwrWcsyLSeJKVMUbEUjA+5ZkhkLW
 sB9Rpz9uCuQvk5rSOnsotoIGuyamrTMg6aN5VfhXfcpkGSeFQN1E8qHQU2fLM//bPg5OXJk1CKC
 HzeG9mBsjxv73d9q1IKeQcVexsMdMrYRvmNNbSFH/8AylASDKnyatdBJ0En/fGWl05NZQsmYtb1
 jkv/ZYUYixd99lA0UTPhowxxFSozpCTAwNENz5d8zNM9r/h6TnuXjlF9pP+1aSI1WeFcFxCco6L
 BE14qNE4TpomKdm3fI25GT7HHL5oNcISsWRbvOaNtL2aiPw5eX7R5sUlo+O5i1V/GaGPM4sSnzH
 3X5Ts8c8lMrAPLfR7S7+BL3QOhffeCgbXr3og6AOZ8kh3OZh3uWFV6QW6fkn1HuP5qs5oPq9X38
 i/qk7dOpUfyCQbA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Looking up a GPIO controller by label that is the name of the software
node is wonky at best - the GPIO controller driver is free to set
a different label than the name of its firmware node. We're already being
passed a firmware node handle attached to the GPIO device to
swnode_get_gpio_device() so use it instead for a more precise lookup.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-swnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.c
index f21dbc28cf2c8c2d06d034b7c89d302cc52bb9b5..e3806db1c0e077d76fcc71a50ca40bbf6872ca40 100644
--- a/drivers/gpio/gpiolib-swnode.c
+++ b/drivers/gpio/gpiolib-swnode.c
@@ -41,7 +41,7 @@ static struct gpio_device *swnode_get_gpio_device(struct fwnode_handle *fwnode)
 	    !strcmp(gdev_node->name, GPIOLIB_SWNODE_UNDEFINED_NAME))
 		return ERR_PTR(-ENOENT);
 
-	gdev = gpio_device_find_by_label(gdev_node->name);
+	gdev = gpio_device_find_by_fwnode(fwnode);
 	return gdev ?: ERR_PTR(-EPROBE_DEFER);
 }
 

-- 
2.51.0


