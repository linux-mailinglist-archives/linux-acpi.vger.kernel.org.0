Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A6579CD3C
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 12:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbjILKH6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Sep 2023 06:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjILKHn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Sep 2023 06:07:43 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10007172D
        for <linux-acpi@vger.kernel.org>; Tue, 12 Sep 2023 03:07:39 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31dcf18f9e2so5424874f8f.0
        for <linux-acpi@vger.kernel.org>; Tue, 12 Sep 2023 03:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694513257; x=1695118057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooPiibuin/T1BXM3ci9G/toRB2k62lYI6dDd6XnUFKA=;
        b=JzQ9L+NIMBtxp4S6so12CVzTrS6VMV+PvLooJ2BjBkgHqO1plgvKW8RCbgKEloeGFD
         046DZjmXeH5knUu9bc6eutPrKq0yni51vumVr6ShmB12dLDrWw/MQWZC5vkBNr20ItW/
         DBy00PvwvdN24+s5uxIPwJp0PLfkcByOuT4FFQswwlY/y/ZzRb44/2u0nMMgFUII/hxt
         ACkRhcuQ0bjVj2RKBtnEM/ZYLN/UzbxefyZBSccVGY9MEZronwaft3F6VI9IYd6erjCW
         O6F5FWTIEJI2zKBrpUKG/6QK6+jY8ABAp3BzHUt9fCydufEMWx3OjW00/AemRiE4TOZB
         79LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694513257; x=1695118057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ooPiibuin/T1BXM3ci9G/toRB2k62lYI6dDd6XnUFKA=;
        b=NiYyx7Yl9V49b6V59M2CNIDSTEB6saskCw42e3vMX+H0tmQDl6PUfILDs5jGfD8ZH4
         QfLkiTcOcNEH5IvsblW2fiLc2CuBRLZJ7s0h7N1yhjfYkBwZJW661R7lkO2GBCfSsvzm
         VOc6Ern/FXEg5Qob5EqhIeObyQ1xNSqUiFTkumHJekVIL3Gl+pBD6ODD1ssdFKXKE3ZH
         YQFAwbroWmOuKVhuPh+C8p9NCw7Ga/AopelSOLzzVetmlUMoesuUBfXbLMWV42cem/hP
         lsoho0VnwfhM6wVXldUplLb/regv1ok2Ew/ZpkEL+zsLzX9dEM51RCTXqoVks4ETRDeR
         gKjg==
X-Gm-Message-State: AOJu0YzwDUdoHMtqvpo957cAggkU4L8IF8A5DDWkfqH3vd8sookz8gyU
        lU0KRQJQa0m9+fu0ZF1dJK/1FA==
X-Google-Smtp-Source: AGHT+IH6XDJfFYmBXwiNkL8kyXELSWjOJy6fzQulJyqX2CBJnihIyCKZaM/CWTqAl/+JXOsrNEi6LA==
X-Received: by 2002:a5d:560e:0:b0:314:1ebc:6e19 with SMTP id l14-20020a5d560e000000b003141ebc6e19mr9289691wrv.64.1694513257604;
        Tue, 12 Sep 2023 03:07:37 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:907f:4cd7:f0ae:6b2a])
        by smtp.gmail.com with ESMTPSA id h5-20020adfe985000000b0031ae8d86af4sm12351417wrm.103.2023.09.12.03.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 03:07:37 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 02/11] gpiolib: add support for scope-based management to gpio_device
Date:   Tue, 12 Sep 2023 12:07:18 +0200
Message-Id: <20230912100727.23197-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912100727.23197-1-brgl@bgdev.pl>
References: <20230912100727.23197-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

As the few users that need to get the reference to the GPIO device often
release it right after inspecting its properties, let's add support for
the automatic reference release to struct gpio_device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/linux/gpio/driver.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index a2060dc3344b..a52c6cc5162b 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -609,6 +609,8 @@ struct gpio_chip *gpiochip_find(void *data,
 struct gpio_device *gpio_device_get(struct gpio_device *gdev);
 void gpio_device_put(struct gpio_device *gdev);
 
+DEFINE_FREE(gpio_device_put, struct gpio_device *, if (_T) gpio_device_put(_T));
+
 bool gpiochip_line_is_irq(struct gpio_chip *gc, unsigned int offset);
 int gpiochip_reqres_irq(struct gpio_chip *gc, unsigned int offset);
 void gpiochip_relres_irq(struct gpio_chip *gc, unsigned int offset);
-- 
2.39.2

