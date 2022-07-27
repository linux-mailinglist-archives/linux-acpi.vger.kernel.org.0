Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92763582771
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Jul 2022 15:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiG0NP2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Jul 2022 09:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbiG0NP0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jul 2022 09:15:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8918E29CAE
        for <linux-acpi@vger.kernel.org>; Wed, 27 Jul 2022 06:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658927721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U+y7TFZ3Ee5r4ptEomdiW2SFODH9IkgojikP3FNy1cs=;
        b=PjQyY829s+vw4rmuZ7uyszEItK8uj9PHzbe8I/0E7/2K5TanfglIQU0ecUOdRL15PS8Rq9
        ByBa5x2U19bSPJ2v3ZLTsefAd7VYd2kjPgNnJ5TckYtxU+knmCXwr/mRQeL7nC4ISCLMJx
        enxFOC1FrS0clL+3QqzbnF9M6EpaP14=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-225-n35m_0yXNe2F6BE_5gjUUg-1; Wed, 27 Jul 2022 09:15:17 -0400
X-MC-Unique: n35m_0yXNe2F6BE_5gjUUg-1
Received: by mail-ed1-f70.google.com with SMTP id s17-20020a056402521100b0043ade613038so10776053edd.17
        for <linux-acpi@vger.kernel.org>; Wed, 27 Jul 2022 06:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U+y7TFZ3Ee5r4ptEomdiW2SFODH9IkgojikP3FNy1cs=;
        b=y5SpJtS1WrObvDWTKO2qu4bM17wdEl5QrbTVTbHyYQqpFrmpw+zpTcdI1KHvnTP6wu
         89Ta2TAYiQxjqES2CMqOaHIBb06bZj/c/at7b+l+sCxMeqJKebMUmWC/6z37DOB5Yu6b
         ia4v+fmWKeTp2C5leyTAArmUgg2z3a8+91OLtLaXbZ6ZaSAO6zymcxM707dKdFjArQ9D
         VbwoPOxNehYaoBovYWBT9DeQ1o05U9oyEoKXf7/Fc0gJlGNZeb3I3JoRida7kmqOPBjW
         AiXEC37tI0ca0m4ZaZx8lEY+/6DxxrZjZql21xteyDB1M2klCj7oqudb6HPdqlQYuWeL
         VoFw==
X-Gm-Message-State: AJIora9CMR5mfQxUZs9sKp99SUm3+mD4WmIn7HbiTaHy40HEw/LJN+y4
        IzDEK4/j6fExagbVL43IrbYXDqU4FYsGWrYqpjRJIl3DAcFh8RSAMXahur/MAj34kc/G6fWhoqQ
        MyUIwQ/xrUcjrFUCQ63KSaw==
X-Received: by 2002:a05:6402:3509:b0:43b:f09d:6517 with SMTP id b9-20020a056402350900b0043bf09d6517mr16570207edd.66.1658927716476;
        Wed, 27 Jul 2022 06:15:16 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ukQPBrJsqPdN0wQG0p8qXei5AQZzabHyiO4ItXNQEEIPT1UKi2T/RQuCdW6aJe0EnwTen4Ow==
X-Received: by 2002:a05:6402:3509:b0:43b:f09d:6517 with SMTP id b9-20020a056402350900b0043bf09d6517mr16570178edd.66.1658927716195;
        Wed, 27 Jul 2022 06:15:16 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id m5-20020a17090672c500b0072b56098fc6sm7631036ejl.127.2022.07.27.06.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 06:15:15 -0700 (PDT)
Message-ID: <4370433d-c2b7-ee00-e3cf-5389f6914e4c@redhat.com>
Date:   Wed, 27 Jul 2022 15:15:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] gpiolib: acpi: Add support to ignore programming an
 interrupt
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Pavel Krc <reg.krn@pkrc.net>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220719142142.247-1-mario.limonciello@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220719142142.247-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 7/19/22 16:21, Mario Limonciello wrote:
> gpiolib-acpi already had support for ignoring a pin for wakeup, but
> if an OEM configures a floating pin as an interrupt source then
> stopping it from being a wakeup won't do much good to stop the
> interrupt storm.
> 
> Add support for a module parameter and quirk infrastructure to
> ignore interrupts as well.
> 
> Tested-by: Pavel Krc <reg.krn@pkrc.net>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpio/gpiolib-acpi.c | 39 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index c2523ac26fac..375942d92d6f 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -32,9 +32,21 @@ MODULE_PARM_DESC(ignore_wake,
>  		 "controller@pin combos on which to ignore the ACPI wake flag "
>  		 "ignore_wake=controller@pin[,controller@pin[,...]]");
>  
> +static char *ignore_interrupt;
> +module_param(ignore_interrupt, charp, 0444);
> +MODULE_PARM_DESC(ignore_interrupt,
> +		 "controller@pin combos on which to ignore interrupt "
> +		 "ignore_interrupt=controller@pin[,controller@pin[,...]]");
> +
>  struct acpi_gpiolib_dmi_quirk {
>  	bool no_edge_events_on_boot;
>  	char *ignore_wake;
> +	char *ignore_interrupt;
> +};
> +
> +enum ignore_type {
> +	IGNORE_WAKEUP,
> +	IGNORE_INTERRUPT,
>  };

Please drop the enum; and ...

>  
>  /**
> @@ -317,14 +329,18 @@ static struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
>  	return desc;
>  }
>  
> -static bool acpi_gpio_in_ignore_list(const char *controller_in, unsigned int pin_in)
> +static bool acpi_gpio_in_ignore_list(const char *controller_in, unsigned int pin_in,
> +				     enum ignore_type type)
>  {

make the prototype:

static bool acpi_gpio_in_ignore_list(const char *ignore_list, const char *controller_in, unsigned int pin_in)

and ...

> -	const char *controller, *pin_str;
> +	const char *controller = NULL, *pin_str;
>  	unsigned int pin;
>  	char *endp;
>  	int len;
>  
> -	controller = ignore_wake;
> +	if (type == IGNORE_WAKEUP)
> +		controller = ignore_wake;
> +	else if (type == IGNORE_INTERRUPT)
> +		controller = ignore_interrupt;

Use:

	controller = ignore_list;

here; and ...

>  	while (controller) {
>  		pin_str = strchr(controller, '@');
>  		if (!pin_str)
> @@ -348,7 +364,12 @@ static bool acpi_gpio_in_ignore_list(const char *controller_in, unsigned int pin
>  
>  	return false;
>  err:
> -	pr_err_once("Error: Invalid value for gpiolib_acpi.ignore_wake: %s\n", ignore_wake);
> +	if (type == IGNORE_WAKEUP)
> +		pr_err_once("Error: Invalid value for gpiolib_acpi.ignore_wake: %s\n",
> +			    ignore_wake);
> +	else if (type == IGNORE_INTERRUPT)
> +		pr_err_once("Error: Invalid value for gpiolib_acpi.ignore_interrupt: %s\n",
> +			    ignore_interrupt);

change this to:

	pr_err_once("Error: Invalid value for gpiolib_acpi.ignore_...: %s\n", ignore_list);

and ...

>  	return false;
>  }
>  
> @@ -360,7 +381,7 @@ static bool acpi_gpio_irq_is_wake(struct device *parent,
>  	if (agpio->wake_capable != ACPI_WAKE_CAPABLE)
>  		return false;
>  
> -	if (acpi_gpio_in_ignore_list(dev_name(parent), pin)) {
> +	if (acpi_gpio_in_ignore_list(dev_name(parent), pin, IGNORE_WAKEUP)) {

adjust this to:

	if (acpi_gpio_in_ignore_list(ignore_wakeup, dev_name(parent), pin)) {

and ...

>  		dev_info(parent, "Ignoring wakeup on pin %u\n", pin);
>  		return false;
>  	}
> @@ -427,6 +448,11 @@ static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
>  		goto fail_unlock_irq;
>  	}
>  
> +	if (acpi_gpio_in_ignore_list(dev_name(chip->parent), pin, IGNORE_INTERRUPT)) {

this line to:

	if (acpi_gpio_in_ignore_list(ignore_interrupt, dev_name(parent), pin)) {

That IMHO is a cleaner way to handle this then introducing the enum type +
enum parameter to acpi_gpio_in_ignore_list().

Regards,

Hans



> +		dev_info(chip->parent, "Ignoring interrupt on pin %u\n", pin);
> +		return AE_OK;
> +	}
> +
>  	event = kzalloc(sizeof(*event), GFP_KERNEL);
>  	if (!event)
>  		goto fail_unlock_irq;
> @@ -1582,6 +1608,9 @@ static int __init acpi_gpio_setup_params(void)
>  	if (ignore_wake == NULL && quirk && quirk->ignore_wake)
>  		ignore_wake = quirk->ignore_wake;
>  
> +	if (ignore_interrupt == NULL && quirk && quirk->ignore_interrupt)
> +		ignore_interrupt = quirk->ignore_interrupt;
> +
>  	return 0;
>  }
>  

