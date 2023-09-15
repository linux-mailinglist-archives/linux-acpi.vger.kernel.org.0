Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E22B7A21C3
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Sep 2023 17:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbjIOPDv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Sep 2023 11:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbjIOPDk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Sep 2023 11:03:40 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F52E2701
        for <linux-acpi@vger.kernel.org>; Fri, 15 Sep 2023 08:03:34 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-402c46c49f4so24430185e9.1
        for <linux-acpi@vger.kernel.org>; Fri, 15 Sep 2023 08:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694790212; x=1695395012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrpKHVqqTjrma0ET7OV7WLFI0tFo3wgKkZ5ACtzRvkE=;
        b=FgCMXmFDIzlAc1Y36Z7Gi2/D1nnyT9x6k3UmWu/N4YCnglJ3a+/cEOPsi3zWJLFk9O
         7BB5tDMjrj6muGRofWTFYgNzaGeh85dBFDmB5g43M1LOfw8H5v9JR5P6UL3XH7lOz84U
         q/pciAQClXDG38V8rOzrBqPjRBgLY7WvNWaraU+Wg6MVFZY0oY7pXiwwJNRhbrD40VwO
         nRVrTmxruk0gaRlL8St5s58WNJSUXfrG2dCE6FLR8Y3eu6NAJ/E/BUw4QS99hidE8JqO
         5i5b3etAIiWlJjppCRE82z4EqstOAMZMjwrYdJTOQXC24072sJpO5c9/c9aQ2rcSd/9G
         PyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694790212; x=1695395012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrpKHVqqTjrma0ET7OV7WLFI0tFo3wgKkZ5ACtzRvkE=;
        b=RhqM30FpvJIyj0XWndzwrgtNIdUv1VnFshVuV+08joc0k710h7FxjoppI/lLFM+G6z
         KCsy/6bx4gCiqkuImwIir1YDqRkW+EkYRl8y65QRhHp4s7MiMBjb0i6OvkVFzEhwGTbR
         5XVci/dJhqh5XRo70XKZQZBg/LJsrwnzaHKysS8vFNahV9qlIjU39jKC2N8jXeddgeJW
         kMTk7/2kcUl7VLSKQFpg+m6/OMzg9OiQiemftlbl7E7zixDQH4xCpEroE4FijtDwUPJc
         iq4S+zYwB4CmCdmRZ4WpbCTgyou6+GZbSecceXeQ4bhKp592axJlcnabo1nyphdi856+
         2nMA==
X-Gm-Message-State: AOJu0Yzh8UIAjK7se9Guh0NasnMxzX5s/E85Hm0rDwzgqlxabOEB7YpU
        P5Sf55MUtCaeLjP/becJp8aULA==
X-Google-Smtp-Source: AGHT+IG0p8HCrm4Hku936xvcxIBII82hMMqqJD6cG6PYDBm8PIuWn4s9ODWxA3tccUosTgyG4iPtcw==
X-Received: by 2002:a05:600c:ad7:b0:402:f555:6523 with SMTP id c23-20020a05600c0ad700b00402f5556523mr1833444wmr.9.1694790212546;
        Fri, 15 Sep 2023 08:03:32 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:aa19:4569:aeeb:c0d3])
        by smtp.gmail.com with ESMTPSA id hn40-20020a05600ca3a800b003fef19bb55csm4853369wmb.34.2023.09.15.08.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 08:03:32 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 02/11] gpiolib: add support for scope-based management to gpio_device
Date:   Fri, 15 Sep 2023 17:03:17 +0200
Message-Id: <20230915150327.81918-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230915150327.81918-1-brgl@bgdev.pl>
References: <20230915150327.81918-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 include/linux/gpio/driver.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index a2060dc3344b..1cedbc3d3200 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -3,6 +3,8 @@
 #define __LINUX_GPIO_DRIVER_H
 
 #include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/err.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/irqhandler.h>
@@ -609,6 +611,9 @@ struct gpio_chip *gpiochip_find(void *data,
 struct gpio_device *gpio_device_get(struct gpio_device *gdev);
 void gpio_device_put(struct gpio_device *gdev);
 
+DEFINE_FREE(gpio_device_put, struct gpio_device *,
+	    if (IS_ERR_OR_NULL(_T)) gpio_device_put(_T));
+
 bool gpiochip_line_is_irq(struct gpio_chip *gc, unsigned int offset);
 int gpiochip_reqres_irq(struct gpio_chip *gc, unsigned int offset);
 void gpiochip_relres_irq(struct gpio_chip *gc, unsigned int offset);
-- 
2.39.2

