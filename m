Return-Path: <linux-acpi+bounces-261-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA867B1F90
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 16:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B71F1282D92
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 14:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D76D3D396
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 14:34:07 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1348BF4
	for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 12:45:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEA01B4
	for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 05:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695905105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ZJst60DtOTAcHM/+YWWARhoXyKu+0XsCA0kzc+cFAY=;
	b=IbQB0B6U96tRCiPSmynGz0Mdqbq6KOelmGwW0SBWQJ8raFLNh0y7L05xc5l/tB13b/JmVZ
	jF9r02Fxlyu/kY4CIU1XkJx1810YCuUua6ZpTIYsERwYhIJQGBRMBQSwSwpoKk6ZW85heK
	RAD3w1cQ5Y4oAWEL+SN4LxolRllXKCQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-cB9bBm66PISrpBkDwf7e9g-1; Thu, 28 Sep 2023 08:45:02 -0400
X-MC-Unique: cB9bBm66PISrpBkDwf7e9g-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-993d7ca4607so1104811466b.1
        for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 05:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695905100; x=1696509900;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZJst60DtOTAcHM/+YWWARhoXyKu+0XsCA0kzc+cFAY=;
        b=gYToz08fvEqvjfFS6W+tZsoLYLtgoIRTX+YCZj2Rs71UMUxPw+cwsE2TDX5RYdEtO2
         J0z614Sftpvegj7Ma6mFQbgWW6hR+Xmoqy0T/lWDVrCo4NJVRffuflFDFm3b89QP/zMv
         w1d0oUyPnQufWJC30tZPwxETSNr1aPQXVbrGdruwQ+pSd5tHF7W9gTNkvwg4RtB8/Hfk
         uhfEXwzKU0irzQhZ/ZHNGSgnv0c1dWFJ6iyhnqBc/94qP+EPDc72lzt5pC02VKIKLOcr
         1+ceOCANamrex/0gjUp/KzbnCtB/jIdWMuoX4SngVPz+EDsAcEiUY2DwAwrt5RITmnV/
         tHyg==
X-Gm-Message-State: AOJu0Yw1aMgL+f2NG9BAkQWOlw11nkMMDFNYJPgqpJndK7nwjvHAsV+p
	LUQZOCLLneR1puLb3DbYK3YaJOYmSJ6/kBfSC3nuyrb5ktg966NFyVHZPgT9BMaWCSE8a0FhxxT
	xdwEcnTiy17ijH+7/ZTkqjQ==
X-Received: by 2002:a17:906:cc53:b0:9b2:8df4:c692 with SMTP id mm19-20020a170906cc5300b009b28df4c692mr1366416ejb.27.1695905100591;
        Thu, 28 Sep 2023 05:45:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBWHwp7nkBmFn/W7pmHIIzcfB55rotTWDT0eMe3PWuqOnoH9kN78RUdFR8Q28Hzep+vmDFMw==
X-Received: by 2002:a17:906:cc53:b0:9b2:8df4:c692 with SMTP id mm19-20020a170906cc5300b009b28df4c692mr1366399ejb.27.1695905100238;
        Thu, 28 Sep 2023 05:45:00 -0700 (PDT)
Received: from [192.168.1.217] ([109.36.138.103])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906374800b0099cf840527csm10849655ejc.153.2023.09.28.05.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 05:44:59 -0700 (PDT)
Message-ID: <d65e65c1-3a20-6aef-f25a-a261420e8a3d@redhat.com>
Date: Thu, 28 Sep 2023 14:44:57 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: [PATCH v2 4/5] platform/x86: int3472: Switch to devm_get_gpiod()
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

Switch to devm_get_gpiod() for discrete GPIOs for clks / regulators / LEDs
and let devm do the cleanup for us.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../x86/intel/int3472/clk_and_regulator.c     | 23 ++++---------------
 drivers/platform/x86/intel/int3472/discrete.c |  2 +-
 drivers/platform/x86/intel/int3472/led.c      |  7 +-----
 3 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/clk_and_regulator.c b/drivers/platform/x86/intel/int3472/clk_and_regulator.c
index 459f96c04ca1..16e36ac0a7b4 100644
--- a/drivers/platform/x86/intel/int3472/clk_and_regulator.c
+++ b/drivers/platform/x86/intel/int3472/clk_and_regulator.c
@@ -177,10 +177,8 @@ int skl_int3472_register_gpio_clock(struct int3472_discrete_device *int3472,
 
 	init.name = kasprintf(GFP_KERNEL, "%s-clk",
 			      acpi_dev_name(int3472->adev));
-	if (!init.name) {
-		ret = -ENOMEM;
-		goto out_put_gpio;
-	}
+	if (!init.name)
+		return -ENOMEM;
 
 	int3472->clock.frequency = skl_int3472_get_clk_frequency(int3472);
 
@@ -206,8 +204,6 @@ int skl_int3472_register_gpio_clock(struct int3472_discrete_device *int3472,
 	clk_unregister(int3472->clock.clk);
 out_free_init_name:
 	kfree(init.name);
-out_put_gpio:
-	gpiod_put(int3472->clock.ena_gpio);
 
 	return ret;
 }
@@ -219,7 +215,6 @@ void skl_int3472_unregister_clock(struct int3472_discrete_device *int3472)
 
 	clkdev_drop(int3472->clock.cl);
 	clk_unregister(int3472->clock.clk);
-	gpiod_put(int3472->clock.ena_gpio);
 }
 
 /*
@@ -266,7 +261,7 @@ int skl_int3472_register_regulator(struct int3472_discrete_device *int3472,
 	struct regulator_config cfg = { };
 	const char *second_sensor = NULL;
 	const struct dmi_system_id *id;
-	int i, j, ret;
+	int i, j;
 
 	id = dmi_first_match(skl_int3472_regulator_second_sensor);
 	if (id)
@@ -309,21 +304,11 @@ int skl_int3472_register_regulator(struct int3472_discrete_device *int3472,
 	int3472->regulator.rdev = regulator_register(int3472->dev,
 						     &int3472->regulator.rdesc,
 						     &cfg);
-	if (IS_ERR(int3472->regulator.rdev)) {
-		ret = PTR_ERR(int3472->regulator.rdev);
-		goto err_free_gpio;
-	}
 
-	return 0;
-
-err_free_gpio:
-	gpiod_put(int3472->regulator.gpio);
-
-	return ret;
+	return PTR_ERR_OR_ZERO(int3472->regulator.rdev);
 }
 
 void skl_int3472_unregister_regulator(struct int3472_discrete_device *int3472)
 {
 	regulator_unregister(int3472->regulator.rdev);
-	gpiod_put(int3472->regulator.gpio);
 }
diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index eb0cded5b92a..8171b16882b7 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -119,7 +119,7 @@ skl_int3472_gpiod_get_from_temp_lookup(struct int3472_discrete_device *int3472,
 		return ERR_PTR(ret);
 
 	gpiod_add_lookup_table(lookup);
-	desc = gpiod_get(int3472->dev, func, GPIOD_OUT_LOW);
+	desc = devm_gpiod_get(int3472->dev, func, GPIOD_OUT_LOW);
 	gpiod_remove_lookup_table(lookup);
 
 	return desc;
diff --git a/drivers/platform/x86/intel/int3472/led.c b/drivers/platform/x86/intel/int3472/led.c
index 476cd637fc51..9cbed694e2ca 100644
--- a/drivers/platform/x86/intel/int3472/led.c
+++ b/drivers/platform/x86/intel/int3472/led.c
@@ -39,7 +39,7 @@ int skl_int3472_register_pled(struct int3472_discrete_device *int3472, struct gp
 
 	ret = led_classdev_register(int3472->dev, &int3472->pled.classdev);
 	if (ret)
-		goto err_free_gpio;
+		return ret;
 
 	int3472->pled.lookup.provider = int3472->pled.name;
 	int3472->pled.lookup.dev_id = int3472->sensor_name;
@@ -47,10 +47,6 @@ int skl_int3472_register_pled(struct int3472_discrete_device *int3472, struct gp
 	led_add_lookup(&int3472->pled.lookup);
 
 	return 0;
-
-err_free_gpio:
-	gpiod_put(int3472->pled.gpio);
-	return ret;
 }
 
 void skl_int3472_unregister_pled(struct int3472_discrete_device *int3472)
@@ -60,5 +56,4 @@ void skl_int3472_unregister_pled(struct int3472_discrete_device *int3472)
 
 	led_remove_lookup(&int3472->pled.lookup);
 	led_classdev_unregister(&int3472->pled.classdev);
-	gpiod_put(int3472->pled.gpio);
 }
-- 
2.41.0


