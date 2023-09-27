Return-Path: <linux-acpi+bounces-188-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 200357B01FC
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 12:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C3E61282AEF
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 10:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB92F1D543
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 10:34:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED921D69B
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 09:40:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CFDF3
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 02:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695807648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/i4A81R1SOe5sMSZk1FkdVOSrAXx6uhn5C/e/5JfxKw=;
	b=ASAgiM07qlWCCy7TqEZ0NSsi0nABZSFvYVjitVOXkK+hVs3Rc497nDFhlJWIcAk3NaI33X
	lt4wY1KAr8CwWZLQoLANZ9qNHgzkYXLe1FUsFyVsoUMWDYnWKzX+dxuuABNlNyVXxqeMw+
	7MQy13WYSe7dsJNkFOpZdBDodhdMf14=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-dJPc2qpCOxm4IaJ1wR_rEg-1; Wed, 27 Sep 2023 05:40:46 -0400
X-MC-Unique: dJPc2qpCOxm4IaJ1wR_rEg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5042bc93273so15403197e87.1
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 02:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695807645; x=1696412445;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/i4A81R1SOe5sMSZk1FkdVOSrAXx6uhn5C/e/5JfxKw=;
        b=PCIJqgjsbcTXiibNY77b/nWnBTABekncCWZiyQ5WSb2BZcC4l1YHFEbMfFBr0cKHLN
         5n0yCNZRwJ+7RLI/ydMJwhUHGx19LIrna6egz1E5aBtMqm4f5CSFYko2PbY9emmZSAa5
         s29n06MsvLMxYYh4ttG6ogULnjCPSRYIygQ5OqIi8hXBtWuxWlVnWR6Lr8HUpIoWTU/P
         wkGEMzTcbCpesdg5N7oDgtl/q+X47R2sxoER5Lz6m7EKp0UyU1jaaJ6l3tz05bvI2Iwp
         A2gJcWdQ44igmeYAz9DDcQHV/7xTwQZ8i/SQfrQ+666SZGDipmhNbfjg0BPXHQZbtRqp
         WgHQ==
X-Gm-Message-State: AOJu0Yz+JS0t/KLtJ0yaQXTFv1vkX/T0zXXPWOTrSWYVMTZ70M7Xxnge
	4niVkamGigB7oq42CzwLu1plQKp3GrYjxD/Zy2MI8d9mRXLGGPW9uOSwvt8P2bq6aIeHCJIBhip
	si35zFO5AaQf0KU1OQt257A==
X-Received: by 2002:ac2:4a8d:0:b0:500:a408:dbd with SMTP id l13-20020ac24a8d000000b00500a4080dbdmr1058992lfp.55.1695807644982;
        Wed, 27 Sep 2023 02:40:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjUVW20BZuFqVbLrrWpnov4PyrKwKTzDVOzlxaGka/uXwcB7ZIQIvSuGMN2Dj3juaFboTdSQ==
X-Received: by 2002:ac2:4a8d:0:b0:500:a408:dbd with SMTP id l13-20020ac24a8d000000b00500a4080dbdmr1058967lfp.55.1695807644119;
        Wed, 27 Sep 2023 02:40:44 -0700 (PDT)
Received: from [192.168.1.217] ([109.36.155.235])
        by smtp.gmail.com with ESMTPSA id r16-20020aa7cfd0000000b00530aae2d5bfsm7965154edy.9.2023.09.27.02.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 02:40:43 -0700 (PDT)
Message-ID: <2b5db794-c00f-e9f5-c0c9-4c5fb4df0802@redhat.com>
Date: Wed, 27 Sep 2023 11:40:40 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFT PATCH 2/4] platform/x86: int3472: led: don't use
 gpiod_toggle_active_low()
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Daniel Scally
 <djrscally@gmail.com>, Mark Gross <markgross@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230926145943.42814-1-brgl@bgdev.pl>
 <20230926145943.42814-3-brgl@bgdev.pl>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230926145943.42814-3-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 9/26/23 16:59, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Instead of acpi_get_and_request_gpiod() + gpiod_toggle_active_low(), use
> temporary lookup tables with appropriate lookup flags.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/platform/x86/intel/int3472/led.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/int3472/led.c b/drivers/platform/x86/intel/int3472/led.c
> index bca1ce7d0d0c..62e0cd5207a7 100644
> --- a/drivers/platform/x86/intel/int3472/led.c
> +++ b/drivers/platform/x86/intel/int3472/led.c
> @@ -25,18 +25,14 @@ int skl_int3472_register_pled(struct int3472_discrete_device *int3472,
>  	if (int3472->pled.classdev.dev)
>  		return -EBUSY;
>  
> -	int3472->pled.gpio = acpi_get_and_request_gpiod(path, agpio->pin_table[0],
> -							     "int3472,privacy-led");
> +	int3472->pled.gpio = skl_int3472_gpiod_get_from_temp_lookup(
> +				int3472->dev, path, agpio->pin_table[0],
> +				"int3472,privacy-led", polarity,
> +				GPIOD_OUT_LOW);

Yeah so this is not going to work, path here is an ACPI device path, e.g.
on my laptop (which actually uses the INT3472 glue code) the path-s of
the 2 GPIO controllers are: `\_SB_.GPI0` resp `\_SB_.PC00.XHCI.RHUB.HS08.VGPO`

Where as skl_int3472_gpiod_get_from_temp_lookup() stores the passed in path
in  gpiod_lookup_table.table[0].key, which is the dev_name() of the GPIO
controller's parent dev which are `INTC1055:00` resp. `INTC1096:00` .

So we are going to need to add some code to INT3472 to go from path to
a correct value for gpiod_lookup_table.table[0].key which means partly
reproducing most of acpi_get_gpiod:

        struct gpio_chip *chip;
        acpi_handle handle;
        acpi_status status;

        status = acpi_get_handle(NULL, path, &handle);
        if (ACPI_FAILURE(status))
                return ERR_PTR(-ENODEV);

        chip = gpiochip_find(handle, acpi_gpiochip_find);
        if (!chip)
                return ERR_PTR(-EPROBE_DEFER);

And then get the key from the chip. Which means using gpiochip_find
in the int3472 code now, which does not sound like an improvement.

I think that was is needed instead is adding an active_low flag
to acpi_get_and_request_gpiod() and then have that directly
set the active-low flag on the returned desc.

Regards,

Hans








>  	if (IS_ERR(int3472->pled.gpio))
>  		return dev_err_probe(int3472->dev, PTR_ERR(int3472->pled.gpio),
>  				     "getting privacy LED GPIO\n");
>  
> -	if (polarity == GPIO_ACTIVE_LOW)
> -		gpiod_toggle_active_low(int3472->pled.gpio);
> -
> -	/* Ensure the pin is in output mode and non-active state */
> -	gpiod_direction_output(int3472->pled.gpio, 0);
> -
>  	/* Generate the name, replacing the ':' in the ACPI devname with '_' */
>  	snprintf(int3472->pled.name, sizeof(int3472->pled.name),
>  		 "%s::privacy_led", acpi_dev_name(int3472->sensor));


