Return-Path: <linux-acpi+bounces-213-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0B47B06FB
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 6CDE028276F
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55096450C1
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:34:34 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F4E38FB4
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 14:29:46 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1DC1A8
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 07:29:45 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40594697600so61976125e9.1
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 07:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695824983; x=1696429783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLhg+4lYTY7FPYRXcNep77vyeRRzOTuTNwtgzvDeQR4=;
        b=HO1mAQU6tmaCPTS9JAZrlTTnCInqtgPEMjxrsAIbYIe3YO4W5jK/aCM/aW1bczfu7x
         9m6S8G9Hyw2njR5JiKPkM7LrtGvV7oERGBSk8Fmfby6PDlV7AiErJCDg8ejwri6yZ0Kj
         R8KTIGiuVevz9Jk66B3amISn3JjvA5bZvGITWr92Map+b6cj4C4Nz+tslvN9FMtMA+T3
         8Mf4wWPX7LbwEqsjkY9orVPhPLn3IWvMFCqxWQYMZd8xEfCB3CIMMx387x6OR4wFs/Hm
         if/P3XPbOBWH1VRfrXNohBGBlHHLzyn6Q9bUs6pWBgSDnR/P/ZeZ2/Y38ZSMen3fI5yh
         qXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695824983; x=1696429783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLhg+4lYTY7FPYRXcNep77vyeRRzOTuTNwtgzvDeQR4=;
        b=YmrgCBiA98X40bcsqvOegIj0ygLi25EX+UmfdubZRxfxATdvteaYt2waLmsP17AYD7
         AnRVMJF4BKXv3ghBDAVpyfI2Sd18qM4seZ4UxaeyE0Vj5CFsQeZlKH0rc2UjhMa4KuFB
         TUpjUj/1+JofB0DBzpWl4uSe1FKs+rayxXHSbCxTa+d1+DmRpT8ucb8yvlKnuHwtO/ZZ
         m/nMCaqYmoNW7PD6ZUUw0umV4SGMG4B699I9DYfMm8QRTTmXj8DnBeA+zX0w6hRkTqd8
         FzeLL3/FkvudVyhoUVVYa03bONzz/goENcCT7F51RhtsfnIKFBkN3WmihaKJCkC/NQcJ
         uLzw==
X-Gm-Message-State: AOJu0YxcyDFKT+fiv3a4JoTsWQdAf9Wlpqwqtk06slGhLIB//vAukUnp
	h49ZhHwnIYowLnrg1WNlBltOoQ==
X-Google-Smtp-Source: AGHT+IHgX6kn5gQqg+82iM+KQ1iq+581c3IjMNjxD4MgKLxeaVlxoJ47mm9EuWENM8e9XcnMPTtOig==
X-Received: by 2002:a7b:c4cb:0:b0:403:8fb9:8d69 with SMTP id g11-20020a7bc4cb000000b004038fb98d69mr2229061wmk.25.1695824983655;
        Wed, 27 Sep 2023 07:29:43 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4bb6:1525:9e22:4a15])
        by smtp.gmail.com with ESMTPSA id v2-20020a1cf702000000b003feae747ff2sm20448303wmh.35.2023.09.27.07.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 07:29:43 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 09/11] gpio: acpi: replace gpiochip_find() with gpio_device_find()
Date: Wed, 27 Sep 2023 16:29:29 +0200
Message-Id: <20230927142931.19798-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230927142931.19798-1-brgl@bgdev.pl>
References: <20230927142931.19798-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We're porting all users of gpiochip_find() to using gpio_device_find().
Update the ACPI GPIO code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 17a86bdd9609..2ad21f34ee62 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -143,7 +143,6 @@ static int acpi_gpiochip_find(struct gpio_chip *gc, void *data)
  */
 static struct gpio_desc *acpi_get_gpiod(char *path, unsigned int pin)
 {
-	struct gpio_chip *chip;
 	acpi_handle handle;
 	acpi_status status;
 
@@ -151,11 +150,16 @@ static struct gpio_desc *acpi_get_gpiod(char *path, unsigned int pin)
 	if (ACPI_FAILURE(status))
 		return ERR_PTR(-ENODEV);
 
-	chip = gpiochip_find(handle, acpi_gpiochip_find);
-	if (!chip)
+	struct gpio_device *gdev __free(gpio_device_put) =
+				gpio_device_find(handle, acpi_gpiochip_find);
+	if (!gdev)
 		return ERR_PTR(-EPROBE_DEFER);
 
-	return gpiochip_get_desc(chip, pin);
+	/*
+	 * FIXME: keep track of the reference to the GPIO device somehow
+	 * instead of putting it here.
+	 */
+	return gpio_device_get_desc(gdev, pin);
 }
 
 /**
-- 
2.39.2


