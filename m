Return-Path: <linux-acpi+bounces-206-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A688D7B06F4
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5710B2826B6
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA9B450C1
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:34:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADF038FAD
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 14:29:40 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0F2196
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 07:29:38 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-405417465aaso103913705e9.1
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 07:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695824977; x=1696429777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrpKHVqqTjrma0ET7OV7WLFI0tFo3wgKkZ5ACtzRvkE=;
        b=nmzlb36S3PRwkaDm7sCBLiyf9gzPtuYW5+71NYnSTODLPEkvxqD6eFEDjzLV/BhDEC
         ZZ3HJgr/KtREJEjzG/QfVqlti7zgG5zq2NwUZX2tH2VT3DpYf4IbeepDRN8b+vHzCKLB
         x2XB/rWcW48Sg7zVcYZuZdcbPLOulbTGmjvLRr5Nnzg1MI+0lxf8mQHd1m6Pbb7eBrad
         javetCA1nJuUJuTfqd+OLM9wXAiKFJwMBUT45iq9uHWeaXR17ko5Y44xEmdIQ0ktRnlD
         a4jeje0kXF50jGUabgvIbPB06qJ7HQ1SjN6erZPzou/YeS1CqjfzTO2jEXGtIdQzgOWF
         MCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695824977; x=1696429777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrpKHVqqTjrma0ET7OV7WLFI0tFo3wgKkZ5ACtzRvkE=;
        b=GpK89EmZECkUT0F0sAFO5rF8CvwcX6U2oCk9Iz7Ii7mLisdYOiPUTJXmMJjJfHNaS9
         F2hoYVav/UGCr/C7jRR0ehHLgOMi4gR8oU2Z8X2PdzkduNSOwpC2MO50XGMH11LZYBeC
         vZvbD/JJ0I4PK8pnvW21DuU+sDgwTH4o17dCEvprho7Q+skXJC1sr5d6U/PdzbEAjVSl
         0s/gPyIEvIY2Rio9cIxq99YfwFWGVUdwxk9vLCrU6+vTLNpWU4pqhNZIMdI1hkPgBQl0
         CfNkJGCfKC7b5I1kXI/Vrpv9gq1EtnB2tqLf4nZQREDmSZ86UE1GAL+VQ4ZW/wwINFT+
         s/Bg==
X-Gm-Message-State: AOJu0YzNfW/OM7RQRHKXt4Wgj4OkI8AB+SP9KJyqvgiqZLOOwq88nKh3
	EyTAyGT1Y7vAzjbiUlhj1H7biA==
X-Google-Smtp-Source: AGHT+IF6eg+w62/RXPj0sQUskg5id/X4SSijgtC05ghaPIfi6qFHp0AB4DGHIGyu0H2TgbfYmlDZfQ==
X-Received: by 2002:a05:600c:21d4:b0:405:34e4:e756 with SMTP id x20-20020a05600c21d400b0040534e4e756mr2081697wmj.36.1695824977012;
        Wed, 27 Sep 2023 07:29:37 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4bb6:1525:9e22:4a15])
        by smtp.gmail.com with ESMTPSA id v2-20020a1cf702000000b003feae747ff2sm20448303wmh.35.2023.09.27.07.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 07:29:36 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 02/11] gpiolib: add support for scope-based management to gpio_device
Date: Wed, 27 Sep 2023 16:29:22 +0200
Message-Id: <20230927142931.19798-3-brgl@bgdev.pl>
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


