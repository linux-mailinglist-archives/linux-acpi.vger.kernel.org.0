Return-Path: <linux-acpi+bounces-258-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBCF7B1F80
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 16:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 52989282876
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 14:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350C23B290
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 14:33:52 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CA28BF4
	for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 12:41:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED149199
	for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 05:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695904883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEs40AJ4lM3j9ffIIAlvF9xgj3FRAy6IbL4eThz+ihA=;
	b=J9Mnl37A320nU97MqJJbiRiJVeSD2DSyVytTbPv0eREARjGTUxqrFtyRB/D0FEho926P0n
	6pR/KZr7HLWbQE5l2vS/zoUalWq9SkYDcge0//Lit2IVF1W+eaxgWB6GRoFh0/faaK9JMK
	OOV3yLrbEkhkrlVI43NJ4TGZfyRQfcA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-ZLEk1EBkN32exLYYksWEBQ-1; Thu, 28 Sep 2023 08:41:21 -0400
X-MC-Unique: ZLEk1EBkN32exLYYksWEBQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a348facbbso1086447566b.1
        for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 05:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695904880; x=1696509680;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TEs40AJ4lM3j9ffIIAlvF9xgj3FRAy6IbL4eThz+ihA=;
        b=I+5iw4PvHKI4pAbcjHI/7aTkHPoivN8yf+ts9hr2dNI3UQeJ1W/fpQq5Qd2VeV7xdF
         HBVWXpfvZ0uL+YAb9wOin3MEvRWZloed/q6j6bDqn1E+uK8wJ/dzY2UxqS0msTgq13YT
         X4OvVrxN72eTVfFktosW1niu1Je/wTiO52whF34WoEfltCGCKAssg+jv44ajicPr8GwN
         srSEBgyyWac2WvzlnxhJSNvf/A82rE5SSeWrYNBSMpmwAqplL+9ThWLSeIF7QBj1fohP
         Kl5h460a6BldImC4qqMmwlVm1uc+AJ26WzCMV7S3cL2wmJByzel6h1K5FUkdJaRCeqk8
         o2Ug==
X-Gm-Message-State: AOJu0YzpmEC7drMA05tjDaZpwSUx9AFYU9rprUXXl6RJeDLPdL8b1/Sb
	wdcgyRoHM7+szs9jhNjVDMMEfy4ZCR+Op6joTZaBVZOzAnjXpBlScbmpKg8rTeoo25lgNnDuK6d
	aLJ9rG90mvwr9iGceT+a1gg==
X-Received: by 2002:a17:907:2e19:b0:9ae:1de:f4fb with SMTP id ig25-20020a1709072e1900b009ae01def4fbmr1021196ejc.46.1695904880745;
        Thu, 28 Sep 2023 05:41:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQrMMPDdnzZMDPC6CzY2Wn/lmJ+Y++1/fNcc2MkMjcM125ZfydcGSvD4w4OtcykeO+6t+gXA==
X-Received: by 2002:a17:907:2e19:b0:9ae:1de:f4fb with SMTP id ig25-20020a1709072e1900b009ae01def4fbmr1021183ejc.46.1695904880436;
        Thu, 28 Sep 2023 05:41:20 -0700 (PDT)
Received: from [192.168.1.217] ([109.36.138.103])
        by smtp.gmail.com with ESMTPSA id qk8-20020a170906d9c800b009ad89697c86sm10937525ejb.144.2023.09.28.05.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 05:41:19 -0700 (PDT)
Message-ID: <a783ec82-79da-6235-0af8-505d252c59ff@redhat.com>
Date: Thu, 28 Sep 2023 14:41:17 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: [PATCH v2 1/5] platform/x86: int3472: Add new
 skl_int3472_fill_gpiod_lookup() helper
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
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a new skl_int3472_fill_gpiod_lookup() helper.

This is a preparation patch for removing usage of the deprecated
gpiod_toggle_active_low() and acpi_get_and_request_gpiod() functions.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel/int3472/discrete.c | 32 +++++++++++++------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index e33c2d75975c..351ecf047944 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -52,21 +52,15 @@ static void skl_int3472_log_sensor_module_name(struct int3472_discrete_device *i
 	}
 }
 
-static int skl_int3472_map_gpio_to_sensor(struct int3472_discrete_device *int3472,
-					  struct acpi_resource_gpio *agpio,
-					  const char *func, u32 polarity)
+static int skl_int3472_fill_gpiod_lookup(struct gpiod_lookup *table_entry,
+					 struct acpi_resource_gpio *agpio,
+					 const char *func, u32 polarity)
 {
 	char *path = agpio->resource_source.string_ptr;
-	struct gpiod_lookup *table_entry;
 	struct acpi_device *adev;
 	acpi_handle handle;
 	acpi_status status;
 
-	if (int3472->n_sensor_gpios >= INT3472_MAX_SENSOR_GPIOS) {
-		dev_warn(int3472->dev, "Too many GPIOs mapped\n");
-		return -EINVAL;
-	}
-
 	status = acpi_get_handle(NULL, path, &handle);
 	if (ACPI_FAILURE(status))
 		return -EINVAL;
@@ -75,13 +69,31 @@ static int skl_int3472_map_gpio_to_sensor(struct int3472_discrete_device *int347
 	if (!adev)
 		return -ENODEV;
 
-	table_entry = &int3472->gpios.table[int3472->n_sensor_gpios];
 	table_entry->key = acpi_dev_name(adev);
 	table_entry->chip_hwnum = agpio->pin_table[0];
 	table_entry->con_id = func;
 	table_entry->idx = 0;
 	table_entry->flags = polarity;
 
+	return 0;
+}
+
+static int skl_int3472_map_gpio_to_sensor(struct int3472_discrete_device *int3472,
+					  struct acpi_resource_gpio *agpio,
+					  const char *func, u32 polarity)
+{
+	int ret;
+
+	if (int3472->n_sensor_gpios >= INT3472_MAX_SENSOR_GPIOS) {
+		dev_warn(int3472->dev, "Too many GPIOs mapped\n");
+		return -EINVAL;
+	}
+
+	ret = skl_int3472_fill_gpiod_lookup(&int3472->gpios.table[int3472->n_sensor_gpios],
+					    agpio, func, polarity);
+	if (ret)
+		return ret;
+
 	int3472->n_sensor_gpios++;
 
 	return 0;
-- 
2.41.0


