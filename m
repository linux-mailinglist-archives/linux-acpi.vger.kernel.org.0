Return-Path: <linux-acpi+bounces-259-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F21457B1F88
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 16:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A92AF282989
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 14:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921561365
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 14:33:57 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988CF8BF4
	for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 12:42:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93C2191
	for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 05:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695904976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIgaek/2vaj0JutvpQK/iD5J0G41ovSmgWF0taiXJOo=;
	b=ABnrU8gadb0LF5VFST68oT/RuNSM96XzrjGVavQwZAwyQuqyisMkamQbdSAvdoOBnQDdGT
	97ChURdTQth5gbFu1W+zRLEXaGT52yVPaaT7DUZ4ipXvO+yUCLGIvZQOoFXyQ8fG+ASPuT
	u8NRBfMCVaNEP9bZqomYqCFSxiK+6XI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-tm7NyJGWP-eQCm1ZJvHDoQ-1; Thu, 28 Sep 2023 08:42:54 -0400
X-MC-Unique: tm7NyJGWP-eQCm1ZJvHDoQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9b274cc9636so799129066b.0
        for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 05:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695904973; x=1696509773;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iIgaek/2vaj0JutvpQK/iD5J0G41ovSmgWF0taiXJOo=;
        b=c6PxDdRZ1/sAOA32qY+je9ukmf2iB48PFDjn+GpsWOvSDmvkNj6qSX35iuPPoopon/
         DCSp5LkwvupszHGLKN+fEbPkDB+H8dQuMi74TAqC9clwB/UjgqNUjkp/vljeJeuKjbzT
         Kl3zazUZodbDRYFxjjLUi/X5MPftv6cBTOV9EFXXHULUlNBL4HIlefKW0d2Z7N9bdlxR
         PbdgIIoSCgogOTAE4Xa+0VMXzuxMRmTWF7B1UfNGxZOXuxHRvFvv3uEQmsBKCP7XbG0a
         MaQpmHpy61+TQoXxZ/neK+KZFVN9Ul6Vw45ajS2AJBU+P73i/K0wNqdHBzgzs8Z1MvwP
         NhxQ==
X-Gm-Message-State: AOJu0YyYNjNPIpbm8eUNF5qyqr/r+okplDkRk5D0yOPDuDnt3skU3glW
	gMjvUJEPKtITXv7A2X3BobgULf/OgLPhQs/ZTjn+Xwfx1fTdWzsDokFiDa3d2gAmQPHPOtzvtwA
	EcO4hfApT1yjwyV+zwaR5mw==
X-Received: by 2002:a17:906:209e:b0:9a5:874a:9745 with SMTP id 30-20020a170906209e00b009a5874a9745mr1015778ejq.26.1695904973505;
        Thu, 28 Sep 2023 05:42:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlywnIyNYShfOZQqUKF/nPnEpW/BE9ULWRGFQaKFsFKQmtPIGivvU6o7bT5pQ/APNJZdsd4A==
X-Received: by 2002:a17:906:209e:b0:9a5:874a:9745 with SMTP id 30-20020a170906209e00b009a5874a9745mr1015758ejq.26.1695904973121;
        Thu, 28 Sep 2023 05:42:53 -0700 (PDT)
Received: from [192.168.1.217] ([109.36.138.103])
        by smtp.gmail.com with ESMTPSA id bv13-20020a170906b1cd00b00993a37aebc5sm10864511ejb.50.2023.09.28.05.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 05:42:52 -0700 (PDT)
Message-ID: <b8b1a3f0-3aca-341c-07ee-389b077a01f7@redhat.com>
Date: Thu, 28 Sep 2023 14:42:50 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: [PATCH v2 2/5] platform/x86: int3472: Add new
 skl_int3472_gpiod_get_from_temp_lookup() helper
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

Add a new skl_int3472_gpiod_get_from_temp_lookup() helper.

This is a preparation patch for removing usage of the deprecated
gpiod_toggle_active_low() and acpi_get_and_request_gpiod() functions.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
[hdegoede@redhat.com] use the new skl_int3472_fill_gpiod_lookup() helper
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel/int3472/discrete.c | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index 351ecf047944..a46c3a206aa3 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -99,6 +99,32 @@ static int skl_int3472_map_gpio_to_sensor(struct int3472_discrete_device *int347
 	return 0;
 }
 
+/* This should *really* only be used when there's no other way... */
+static struct gpio_desc *
+skl_int3472_gpiod_get_from_temp_lookup(struct int3472_discrete_device *int3472,
+				       struct acpi_resource_gpio *agpio,
+				       const char *func, u32 polarity)
+{
+	struct gpio_desc *desc;
+	int ret;
+
+	struct gpiod_lookup_table *lookup __free(kfree) =
+			kzalloc(struct_size(lookup, table, 1), GFP_KERNEL);
+	if (!lookup)
+		return ERR_PTR(-ENOMEM);
+
+	lookup->dev_id = dev_name(int3472->dev);
+	ret = skl_int3472_fill_gpiod_lookup(&lookup->table[0], agpio, func, polarity);
+	if (ret)
+		return ERR_PTR(ret);
+
+	gpiod_add_lookup_table(lookup);
+	desc = gpiod_get(int3472->dev, func, GPIOD_OUT_LOW);
+	gpiod_remove_lookup_table(lookup);
+
+	return desc;
+}
+
 static void int3472_get_func_and_polarity(u8 type, const char **func, u32 *polarity)
 {
 	switch (type) {
-- 
2.41.0


