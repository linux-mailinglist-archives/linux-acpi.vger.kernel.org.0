Return-Path: <linux-acpi+bounces-208-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2257B06F6
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0FDDD28262F
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E978D450CA
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:34:09 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A423A38FB7
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 14:29:42 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4658193
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 07:29:40 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4054f790190so101037265e9.2
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 07:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695824979; x=1696429779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTcEgfPoq9MntpjrBDVs2nRvtCmOFJGrOAf8mTlZ6ic=;
        b=yMGNr1kd3hLtrwjjnHhdG5D7rrhYIkgDkk4BxMJ6QcP26LpenmcAAuDPnHf2x5ArVt
         EgoK3A847GtHVbvzEw6m7lGUfHRpOEIlkETZaMT+0uBkyCCc4cyRTx91CSDrdjS6dx7b
         VlMWCtmFop9dmPdfsGynvahT/rsGD39zjTGZG7j1M8Fvb/t7eVpGu2Ni5rRpS5ixnY+X
         WhqaNKJgs/c145/0CyW2xlyasxa8FgO3ISVEs8QG8/OwNGCUU4xeLtMiM4Pzo2mG5FKp
         TXYoUbHI/YlQ9AGP8ed46DMSFpQzaXCONn4HUeRWYpoMXkQJ9LXrJNn97R0Q0r+K3i++
         tpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695824979; x=1696429779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTcEgfPoq9MntpjrBDVs2nRvtCmOFJGrOAf8mTlZ6ic=;
        b=tUOggT46o1DvgZQvLF/49w7bw1nro68q8t4owU8ratKe1uMtY8JCIMgxoOyA0FZwVY
         DoGqShCsxpzGKNQbkxV36yK8KTjs4P9829SFW6uKM/2WLEDPki3owGi5b617BHhfi5Rb
         uBjWfV2K9d/sVWgqJM05ApWNX9PH5Lz2nGla4yeP4aqdIOwlr4dhFVLdPdLQ7t9kn3Ap
         Jgem4Jt2QxrFG4Y0QjrRi/ZoC9ue9IeyUI2oF9MFXulKlfniDdz25gzP7Xv+j1kBDggz
         Vwtrd287vgmosNsMbBR0zyLjzAXO3b2wfcJbfT2R+FWbiVm5eNOr9uh5QaISdRxK+2F7
         v8jw==
X-Gm-Message-State: AOJu0Yw9UoCUjwkMDZcFeg3GUGrjsHbXQWDwZKom/0i+r8fK2rt9nPZA
	/xW63xC9e4J9szbU+Aqk+68dQDmAj5P6qt42xrA=
X-Google-Smtp-Source: AGHT+IGD00aBYBGbXwpAnwYAy0l31qfM0fAkxtSPt2jFAgPU61yc4YyTZH8mLIyu6+7WPpclnEKlJg==
X-Received: by 2002:a5d:5582:0:b0:31a:ddf0:93b with SMTP id i2-20020a5d5582000000b0031addf0093bmr1944891wrv.33.1695824978901;
        Wed, 27 Sep 2023 07:29:38 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4bb6:1525:9e22:4a15])
        by smtp.gmail.com with ESMTPSA id v2-20020a1cf702000000b003feae747ff2sm20448303wmh.35.2023.09.27.07.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 07:29:38 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 04/11] gpiolib: provide gpio_device_find_by_label()
Date: Wed, 27 Sep 2023 16:29:24 +0200
Message-Id: <20230927142931.19798-5-brgl@bgdev.pl>
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

By far the most common way of looking up GPIO devices is using their
label. Provide a helpers for that to avoid every user implementing their
own matching function.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c      | 21 +++++++++++++++++++++
 include/linux/gpio/driver.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 0371d23f0a46..9f20311e4c1a 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -20,6 +20,7 @@
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/string.h>
 
 #include <linux/gpio.h>
 #include <linux/gpio/driver.h>
@@ -1081,6 +1082,26 @@ struct gpio_device *gpio_device_find(void *data,
 }
 EXPORT_SYMBOL_GPL(gpio_device_find);
 
+static int gpio_chip_match_by_label(struct gpio_chip *gc, void *label)
+{
+	return gc->label && !strcmp(gc->label, label);
+}
+
+/**
+ * gpio_device_find_by_label() - wrapper around gpio_device_find() finding the
+ *                               GPIO device by its backing chip's label
+ * @label: Label to lookup
+ *
+ * Returns:
+ * Reference to the GPIO device or NULL. Reference must be released with
+ * gpio_device_put().
+ */
+struct gpio_device *gpio_device_find_by_label(const char *label)
+{
+	return gpio_device_find((void *)label, gpio_chip_match_by_label);
+}
+EXPORT_SYMBOL_GPL(gpio_device_find_by_label);
+
 static int gpiochip_match_name(struct gpio_chip *gc, void *data)
 {
 	const char *name = data;
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 6ad1f1a8ef2e..24996cba6465 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -610,6 +610,7 @@ struct gpio_chip *gpiochip_find(void *data,
 
 struct gpio_device *gpio_device_find(void *data,
 				int (*match)(struct gpio_chip *gc, void *data));
+struct gpio_device *gpio_device_find_by_label(const char *label);
 
 struct gpio_device *gpio_device_get(struct gpio_device *gdev);
 void gpio_device_put(struct gpio_device *gdev);
-- 
2.39.2


