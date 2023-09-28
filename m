Return-Path: <linux-acpi+bounces-262-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7A97B1F93
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 16:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D897B282B19
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 14:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C863FB05
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 14:34:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7468BF4
	for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 12:45:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAF91AD
	for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 05:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695905156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ACdKckhs2IGUtv5AveDwU/IL9fYWvBeI2aPkdMd1dhI=;
	b=Mb0DhrS2dQCLHBuvdSxJLORbSDm5z8iWjnlATXhNvf0yEY76hYDh5FrZsW5MlfitvqPn+s
	ZJzzlOhLxhmu5FEVgJ0kcKPc/TMOm5tS8me8fAhJ8L9yMyjUR00sj+c8qXBgzg4gpppc2I
	DDHQE5ItkCDZXAIoVrRlPkWAFNPVinU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-vXBRe6I6M9m23RrPM9f4Aw-1; Thu, 28 Sep 2023 08:45:55 -0400
X-MC-Unique: vXBRe6I6M9m23RrPM9f4Aw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a5d86705e4so1130224366b.1
        for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 05:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695905154; x=1696509954;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ACdKckhs2IGUtv5AveDwU/IL9fYWvBeI2aPkdMd1dhI=;
        b=WIMKAxADOc4kRqsourY6m5GgnEFBGg+ZZDav6NmaVv+TPylCde/QdUjoXt/nbpZ+zq
         U9W56IIU4aksn45hA7CRvO4WlyX7wJL1warVNE/7Puxet7QyUYcInxYBw6Hl8Kmy7osm
         AjwljW/iPTLFcr5hM3PmluuBxrNiDTixJqnC5QC3fdWEBKoAo8grqJd8dshW+M/nv06P
         f55mxN+FUNT97Fxmdz6qnsru1uXtK6QVt/IHDvpwz+AAASVknSpZFmxvGiSN9klIjc52
         NNtTdERG3RyRbxmQ34tSSqE5s5nk1MLxflZDCzO+y2UrMdzi8xA7dqM7vZGOWHUju6M+
         X7+w==
X-Gm-Message-State: AOJu0YxAQFmRdV+BGwuhho0sUbf/+c0MeAVP86awWu/rtLzBX4XYG3tY
	DtDSVMzKSGl50wfkXQfvHt5eEu6MBRIoTMzhe94wuFrK5EYTZ5Df0D2nJf/u/DpQ9wEPDLJpD1c
	eVXrVlXM0BZ155pL83Zoa0g==
X-Received: by 2002:a17:906:3150:b0:9ae:696c:2c43 with SMTP id e16-20020a170906315000b009ae696c2c43mr1183232eje.28.1695905154395;
        Thu, 28 Sep 2023 05:45:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQnYwpJz4FRm5OEctCUqntpuOgB3RgSDa5zxu4Q3oNPpnc3WMFQcTzGCzOVBYL6EaWeUHW8A==
X-Received: by 2002:a17:906:3150:b0:9ae:696c:2c43 with SMTP id e16-20020a170906315000b009ae696c2c43mr1183223eje.28.1695905154189;
        Thu, 28 Sep 2023 05:45:54 -0700 (PDT)
Received: from [192.168.1.217] ([109.36.138.103])
        by smtp.gmail.com with ESMTPSA id lw13-20020a170906bccd00b0098884f86e41sm10683387ejb.123.2023.09.28.05.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 05:45:53 -0700 (PDT)
Message-ID: <93be52fc-fa87-423f-dde2-1b0b758ab632@redhat.com>
Date: Thu, 28 Sep 2023 14:45:51 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: [PATCH v2 5/5] gpio: acpi: remove acpi_get_and_request_gpiod()
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Daniel Scally
 <djrscally@gmail.com>, Mark Gross <markgross@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230926145943.42814-1-brgl@bgdev.pl>
 <e6817d30-b443-1a73-efae-84415604b19f@redhat.com>
In-Reply-To: <e6817d30-b443-1a73-efae-84415604b19f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

With no more users, we can remove acpi_get_and_request_gpiod().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Link: https://lore.kernel.org/r/20230926145943.42814-5-brgl@bgdev.pl
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpio/gpiolib-acpi.c   | 28 ----------------------------
 include/linux/gpio/consumer.h |  8 --------
 2 files changed, 36 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 17a86bdd9609..89ff93f3b579 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -158,34 +158,6 @@ static struct gpio_desc *acpi_get_gpiod(char *path, unsigned int pin)
 	return gpiochip_get_desc(chip, pin);
 }
 
-/**
- * acpi_get_and_request_gpiod - Translate ACPI GPIO pin to GPIO descriptor and
- *                              hold a refcount to the GPIO device.
- * @path:      ACPI GPIO controller full path name, (e.g. "\\_SB.GPO1")
- * @pin:       ACPI GPIO pin number (0-based, controller-relative)
- * @label:     Label to pass to gpiod_request()
- *
- * This function is a simple pass-through to acpi_get_gpiod(), except that
- * as it is intended for use outside of the GPIO layer (in a similar fashion to
- * gpiod_get_index() for example) it also holds a reference to the GPIO device.
- */
-struct gpio_desc *acpi_get_and_request_gpiod(char *path, unsigned int pin, char *label)
-{
-	struct gpio_desc *gpio;
-	int ret;
-
-	gpio = acpi_get_gpiod(path, pin);
-	if (IS_ERR(gpio))
-		return gpio;
-
-	ret = gpiod_request(gpio, label);
-	if (ret)
-		return ERR_PTR(ret);
-
-	return gpio;
-}
-EXPORT_SYMBOL_GPL(acpi_get_and_request_gpiod);
-
 static irqreturn_t acpi_gpio_irq_handler(int irq, void *data)
 {
 	struct acpi_gpio_event *event = data;
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 1c4385a00f88..9d1f598b8971 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -614,8 +614,6 @@ void acpi_dev_remove_driver_gpios(struct acpi_device *adev);
 int devm_acpi_dev_add_driver_gpios(struct device *dev,
 				   const struct acpi_gpio_mapping *gpios);
 
-struct gpio_desc *acpi_get_and_request_gpiod(char *path, unsigned int pin, char *label);
-
 #else  /* CONFIG_GPIOLIB && CONFIG_ACPI */
 
 #include <linux/err.h>
@@ -633,12 +631,6 @@ static inline int devm_acpi_dev_add_driver_gpios(struct device *dev,
 	return -ENXIO;
 }
 
-static inline struct gpio_desc *acpi_get_and_request_gpiod(char *path, unsigned int pin,
-							   char *label)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
 #endif /* CONFIG_GPIOLIB && CONFIG_ACPI */
 
 
-- 
2.41.0


