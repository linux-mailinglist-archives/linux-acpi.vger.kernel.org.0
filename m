Return-Path: <linux-acpi+bounces-260-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0167B1F8E
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 16:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B41C8282B64
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 14:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3CC3FB00
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 14:34:02 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91CB8C03
	for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 12:44:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6D41A2
	for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 05:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695905043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8cRziQNlPKsMBts0e+fMBLBJc4tPpGB3qzVuhcHy5Uc=;
	b=LmeobCqL4Jc/c1JiVxTDAe3xqNRNxlC4FDni4obcp9Z9xz7uE0QVHxrWrMJ3eCFu/oroVJ
	eTjADqruPRFSfmDy/USneEt/Y91xw6C+inBC4e6lYxKQe+aCQK6e+/mIQILrIfrRN3gdh2
	DhAuDsRd9XeHVggB0kR4ZutJ3Q565p8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-_ioslje2MAW9xZeX595H9w-1; Thu, 28 Sep 2023 08:44:02 -0400
X-MC-Unique: _ioslje2MAW9xZeX595H9w-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9b2c1159b0aso68155166b.3
        for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 05:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695905041; x=1696509841;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8cRziQNlPKsMBts0e+fMBLBJc4tPpGB3qzVuhcHy5Uc=;
        b=iG9plqkADURCchy4rkcAHXWNL1LTNw4v/8p4QDCoKMfIVRFyUZdzxrYs9dCdgHu6uN
         HrH22Oql3cUf2Futd8QJGIt0edsLtFuVmUFptlUoBE7J2ySTbKdnTuskC73qeAbxDGS+
         pcG6uClIBB/Frjln8XY4Jby+ha6KFaSHO7fcCYf4wiTrNNNtMztZYcgtFC4ufy1rDH56
         F/RYzFOUXRrjKJK0W9AWcNegFGKWR4k7BHgEt0h/uDDW6NF0P890lnDNjd/fkszI8zdG
         mIM2KfpPt4SrwAvz+Il8v8cTzfRmjL/dIo+BtaMc3ujcxJZSBCifjwhgYHP1q1ObseX8
         pxGg==
X-Gm-Message-State: AOJu0YwqQKmH3vddAv1ewLTgOgrp6l2byhLSF3UhvoKIXiZ0wUgO9p5Z
	3erjUne0hj/zG0pVsqRQsukJl5X8JmMnScCU/vjOYuiOXNtodKEbDvqs+XmjG87QTOqUpNPaZQi
	rDNXvHc2Px1USl6D+Sdm7Cw==
X-Received: by 2002:a17:907:2711:b0:9b2:6b4f:d5ab with SMTP id w17-20020a170907271100b009b26b4fd5abmr1171173ejk.29.1695905041264;
        Thu, 28 Sep 2023 05:44:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7zHVVtnXYAXKuMFhQ2h0p1jaG2SWEPqMGqXqvP8oQE1dSqZqqZ7+P9rXflTUJMO/VnuodKA==
X-Received: by 2002:a17:907:2711:b0:9b2:6b4f:d5ab with SMTP id w17-20020a170907271100b009b26b4fd5abmr1171148ejk.29.1695905040862;
        Thu, 28 Sep 2023 05:44:00 -0700 (PDT)
Received: from [192.168.1.217] ([109.36.138.103])
        by smtp.gmail.com with ESMTPSA id g27-20020a170906349b00b0099bc0daf3d7sm10741780ejb.182.2023.09.28.05.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 05:44:00 -0700 (PDT)
Message-ID: <64a5c0ff-bb63-15ac-1c06-182296e7f6dd@redhat.com>
Date: Thu, 28 Sep 2023 14:43:58 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: [PATCH v2 3/5] platform/x86: int3472: Stop using
 gpiod_toggle_active_low()
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use the new skl_int3472_gpiod_get_from_temp_lookup() helper to get
a gpio to pass to register_gpio_clock(), skl_int3472_register_regulator()
and skl_int3472_register_pled().

This removes all use of the deprecated gpiod_toggle_active_low() and
acpi_get_and_request_gpiod() functions.

Suggested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../x86/intel/int3472/clk_and_regulator.c     | 31 ++-----------
 drivers/platform/x86/intel/int3472/common.h   |  7 ++-
 drivers/platform/x86/intel/int3472/discrete.c | 43 +++++++++++++------
 drivers/platform/x86/intel/int3472/led.c      | 17 ++------
 4 files changed, 40 insertions(+), 58 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/clk_and_regulator.c b/drivers/platform/x86/intel/int3472/clk_and_regulator.c
index ef4b3141efcd..459f96c04ca1 100644
--- a/drivers/platform/x86/intel/int3472/clk_and_regulator.c
+++ b/drivers/platform/x86/intel/int3472/clk_and_regulator.c
@@ -162,9 +162,8 @@ int skl_int3472_register_dsm_clock(struct int3472_discrete_device *int3472)
 }
 
 int skl_int3472_register_gpio_clock(struct int3472_discrete_device *int3472,
-				    struct acpi_resource_gpio *agpio, u32 polarity)
+				    struct gpio_desc *gpio)
 {
-	char *path = agpio->resource_source.string_ptr;
 	struct clk_init_data init = {
 		.ops = &skl_int3472_clock_ops,
 		.flags = CLK_GET_RATE_NOCACHE,
@@ -174,19 +173,7 @@ int skl_int3472_register_gpio_clock(struct int3472_discrete_device *int3472,
 	if (int3472->clock.cl)
 		return -EBUSY;
 
-	int3472->clock.ena_gpio = acpi_get_and_request_gpiod(path, agpio->pin_table[0],
-							     "int3472,clk-enable");
-	if (IS_ERR(int3472->clock.ena_gpio)) {
-		ret = PTR_ERR(int3472->clock.ena_gpio);
-		int3472->clock.ena_gpio = NULL;
-		return dev_err_probe(int3472->dev, ret, "getting clk-enable GPIO\n");
-	}
-
-	if (polarity == GPIO_ACTIVE_LOW)
-		gpiod_toggle_active_low(int3472->clock.ena_gpio);
-
-	/* Ensure the pin is in output mode and non-active state */
-	gpiod_direction_output(int3472->clock.ena_gpio, 0);
+	int3472->clock.ena_gpio = gpio;
 
 	init.name = kasprintf(GFP_KERNEL, "%s-clk",
 			      acpi_dev_name(int3472->adev));
@@ -273,9 +260,8 @@ static const struct dmi_system_id skl_int3472_regulator_second_sensor[] = {
 };
 
 int skl_int3472_register_regulator(struct int3472_discrete_device *int3472,
-				   struct acpi_resource_gpio *agpio)
+				   struct gpio_desc *gpio)
 {
-	char *path = agpio->resource_source.string_ptr;
 	struct regulator_init_data init_data = { };
 	struct regulator_config cfg = { };
 	const char *second_sensor = NULL;
@@ -314,16 +300,7 @@ int skl_int3472_register_regulator(struct int3472_discrete_device *int3472,
 						int3472->regulator.supply_name,
 						&int3472_gpio_regulator_ops);
 
-	int3472->regulator.gpio = acpi_get_and_request_gpiod(path, agpio->pin_table[0],
-							     "int3472,regulator");
-	if (IS_ERR(int3472->regulator.gpio)) {
-		ret = PTR_ERR(int3472->regulator.gpio);
-		int3472->regulator.gpio = NULL;
-		return dev_err_probe(int3472->dev, ret, "getting regulator GPIO\n");
-	}
-
-	/* Ensure the pin is in output mode and non-active state */
-	gpiod_direction_output(int3472->regulator.gpio, 0);
+	int3472->regulator.gpio = gpio;
 
 	cfg.dev = &int3472->adev->dev;
 	cfg.init_data = &init_data;
diff --git a/drivers/platform/x86/intel/int3472/common.h b/drivers/platform/x86/intel/int3472/common.h
index 9f29baa13860..145dec66df64 100644
--- a/drivers/platform/x86/intel/int3472/common.h
+++ b/drivers/platform/x86/intel/int3472/common.h
@@ -117,16 +117,15 @@ int skl_int3472_get_sensor_adev_and_name(struct device *dev,
 					 const char **name_ret);
 
 int skl_int3472_register_gpio_clock(struct int3472_discrete_device *int3472,
-				    struct acpi_resource_gpio *agpio, u32 polarity);
+				    struct gpio_desc *gpio);
 int skl_int3472_register_dsm_clock(struct int3472_discrete_device *int3472);
 void skl_int3472_unregister_clock(struct int3472_discrete_device *int3472);
 
 int skl_int3472_register_regulator(struct int3472_discrete_device *int3472,
-				   struct acpi_resource_gpio *agpio);
+				   struct gpio_desc *gpio);
 void skl_int3472_unregister_regulator(struct int3472_discrete_device *int3472);
 
-int skl_int3472_register_pled(struct int3472_discrete_device *int3472,
-			      struct acpi_resource_gpio *agpio, u32 polarity);
+int skl_int3472_register_pled(struct int3472_discrete_device *int3472, struct gpio_desc *gpio);
 void skl_int3472_unregister_pled(struct int3472_discrete_device *int3472);
 
 #endif
diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index a46c3a206aa3..eb0cded5b92a 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -194,6 +194,7 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 	struct acpi_resource_gpio *agpio;
 	u8 active_value, pin, type;
 	union acpi_object *obj;
+	struct gpio_desc *gpio;
 	const char *err_msg;
 	const char *func;
 	u32 polarity;
@@ -244,22 +245,38 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 
 		break;
 	case INT3472_GPIO_TYPE_CLK_ENABLE:
-		ret = skl_int3472_register_gpio_clock(int3472, agpio, polarity);
-		if (ret)
-			err_msg = "Failed to register clock\n";
-
-		break;
 	case INT3472_GPIO_TYPE_PRIVACY_LED:
-		ret = skl_int3472_register_pled(int3472, agpio, polarity);
-		if (ret)
-			err_msg = "Failed to register LED\n";
-
-		break;
 	case INT3472_GPIO_TYPE_POWER_ENABLE:
-		ret = skl_int3472_register_regulator(int3472, agpio);
-		if (ret)
-			err_msg = "Failed to map regulator to sensor\n";
+		gpio = skl_int3472_gpiod_get_from_temp_lookup(int3472, agpio, func, polarity);
+		if (IS_ERR(gpio)) {
+			ret = PTR_ERR(gpio);
+			err_msg = "Failed to get GPIO\n";
+			break;
+		}
 
+		switch (type) {
+		case INT3472_GPIO_TYPE_CLK_ENABLE:
+			ret = skl_int3472_register_gpio_clock(int3472, gpio);
+			if (ret)
+				err_msg = "Failed to register clock\n";
+
+			break;
+		case INT3472_GPIO_TYPE_PRIVACY_LED:
+			ret = skl_int3472_register_pled(int3472, gpio);
+			if (ret)
+				err_msg = "Failed to register LED\n";
+
+			break;
+		case INT3472_GPIO_TYPE_POWER_ENABLE:
+			ret = skl_int3472_register_regulator(int3472, gpio);
+			if (ret)
+				err_msg = "Failed to map regulator to sensor\n";
+
+			break;
+		default: /* Never reached */
+			ret = -EINVAL;
+			break;
+		}
 		break;
 	default:
 		dev_warn(int3472->dev,
diff --git a/drivers/platform/x86/intel/int3472/led.c b/drivers/platform/x86/intel/int3472/led.c
index bca1ce7d0d0c..476cd637fc51 100644
--- a/drivers/platform/x86/intel/int3472/led.c
+++ b/drivers/platform/x86/intel/int3472/led.c
@@ -16,26 +16,15 @@ static int int3472_pled_set(struct led_classdev *led_cdev,
 	return 0;
 }
 
-int skl_int3472_register_pled(struct int3472_discrete_device *int3472,
-			      struct acpi_resource_gpio *agpio, u32 polarity)
+int skl_int3472_register_pled(struct int3472_discrete_device *int3472, struct gpio_desc *gpio)
 {
-	char *p, *path = agpio->resource_source.string_ptr;
+	char *p;
 	int ret;
 
 	if (int3472->pled.classdev.dev)
 		return -EBUSY;
 
-	int3472->pled.gpio = acpi_get_and_request_gpiod(path, agpio->pin_table[0],
-							     "int3472,privacy-led");
-	if (IS_ERR(int3472->pled.gpio))
-		return dev_err_probe(int3472->dev, PTR_ERR(int3472->pled.gpio),
-				     "getting privacy LED GPIO\n");
-
-	if (polarity == GPIO_ACTIVE_LOW)
-		gpiod_toggle_active_low(int3472->pled.gpio);
-
-	/* Ensure the pin is in output mode and non-active state */
-	gpiod_direction_output(int3472->pled.gpio, 0);
+	int3472->pled.gpio = gpio;
 
 	/* Generate the name, replacing the ':' in the ACPI devname with '_' */
 	snprintf(int3472->pled.name, sizeof(int3472->pled.name),
-- 
2.41.0


