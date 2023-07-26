Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D757638CC
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jul 2023 16:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjGZOQR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 Jul 2023 10:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbjGZOQD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Jul 2023 10:16:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C219F4208
        for <linux-acpi@vger.kernel.org>; Wed, 26 Jul 2023 07:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690380812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KyY1COWWZwFG4H+/fy8Ic1ZEI+oVlwAbyLmr8esJTF4=;
        b=fg2mPODsIlbBFUASFAqq5z3cZ6tc0CtUYViinG5GRhM96tqpv3jsGuyY1blivSN57CNeVa
        JiUP/096B3j3H+iIODwFyHAvwL0s2u37FQAKUIJFFntnGzwIHgrTXF3zN5+2U8ODhpMuRD
        x+WofMw+UXSpTOdPOP049HeWvAkRqkg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-TQcEHEkcOtCdWC3Bh1pYyw-1; Wed, 26 Jul 2023 10:13:30 -0400
X-MC-Unique: TQcEHEkcOtCdWC3Bh1pYyw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-993c2d9e496so437856766b.0
        for <linux-acpi@vger.kernel.org>; Wed, 26 Jul 2023 07:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690380809; x=1690985609;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KyY1COWWZwFG4H+/fy8Ic1ZEI+oVlwAbyLmr8esJTF4=;
        b=Y2omLEpP2KTDnfLZbYCT+ytwDys8jQMTgsM9mgSBBPWgeGfJEAiPa+SHTvFvmfzpQw
         7CsHGI8J/sIhntyVp9/+FqlCJZzc6Gki88WSfmkEbrbouFu0HXY54hWm4ffR5jncYPAQ
         6AM2E8NwGjU4vl6rcS4WUrtgYa69cOW5efcfPAFxzgQ4blTY6d5l286G0AEKgdOLoYN5
         PC0sBU9hSZCkHuzwAjk/ycWhB3OLln+WwHLu/a/sRniwKkGtWlWKdc3DrqSY9U0oSEQg
         BmOkP/MrxkuVyEBG4lftCKhvbNUCeRX99Fj3T6Nu7aBKjulSN1aaxWP9NagqkJ/EVhN/
         ltZg==
X-Gm-Message-State: ABy/qLZkOeg+hdh/ZxC4QhusDeCjLkGCVJjzHz4BsjdXl5sBJTHg2d8r
        FMyBsHqjw+6ZCbjcc0DMihBpW0kI0ld7TNpM0wzLS2b/GOOUT3Zmi0lmWAhc9u11QcYUh+DtC1B
        CEgJaNHpRuFkM+kKwvW+a8w==
X-Received: by 2002:a17:907:78c9:b0:99a:7ff1:9b5a with SMTP id kv9-20020a17090778c900b0099a7ff19b5amr1914202ejc.4.1690380809506;
        Wed, 26 Jul 2023 07:13:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFdhfFeI7OOPveQLJFoZw4tzXl5uQexk/9zkYfeT1992uWM69oWilEd8x1eiUFOP6qI7Sc0Gg==
X-Received: by 2002:a17:907:78c9:b0:99a:7ff1:9b5a with SMTP id kv9-20020a17090778c900b0099a7ff19b5amr1914182ejc.4.1690380809169;
        Wed, 26 Jul 2023 07:13:29 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ko5-20020a170907986500b00988781076e2sm9639387ejc.78.2023.07.26.07.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 07:13:28 -0700 (PDT)
Message-ID: <33cdbf63-8fe4-da7e-5d36-6e63fe303b24@redhat.com>
Date:   Wed, 26 Jul 2023 16:13:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ACPI: scan: Create platform device for CS35L56
Content-Language: en-US, nl
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, rafael@kernel.org,
        lenb@kernel.org, markgross@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@opensource.cirrus.com,
        Simon Trimmer <simont@opensource.cirrus.com>
References: <20230726112759.18814-1-rf@opensource.cirrus.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230726112759.18814-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Richard,

On 7/26/23 13:27, Richard Fitzgerald wrote:
> From: Simon Trimmer <simont@opensource.cirrus.com>
> 
> The ACPI device CSC3556 is a Cirrus Logic CS35L56 mono amplifier which
> is used in multiples, and can be connected either to I2C or SPI.
> 
> There will be multiple instances under the same Device() node. Add it
> to ignore_serial_bus_ids and handle it in the serial-multi-instantiate
> driver.
> 
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I have 1 other serial-multi-instantiate.c patches in my fixes branch (see below) and since this just adds new hw-ids I think this can go upstream through my fixes branch too.

Rafael, do you agree with me taking this upstream as a 6.5 fix? And if yes may I have your ack for that ?

About that 1 patch, that adds a new IRQ type: IRQ_RESOURCE_AUTO and I wonder if this patch should not use that same new type right from the start:

https://git.kernel.org/pub/scm/linux/kernel/agit/pdx86/platform-drivers-x86.git/commit/?h=fixes&id=676b7c5ecab36274442887ceadd6dee8248a244f

This makes me realize that I should probably have pinged you and ask for feedback on that patch since it was send by a community member rather then by Cirrus. Note this is currently in Linus' master tree, so any fixes to it need to be submitted on top (not that I expect any issues since it still behaves as before on acpi_dev_gpio_irq_get() success and only adds an platform_get_irq() fallback when that fails).

Regards,

Hans



> ---
>  drivers/acpi/scan.c                             |  1 +
>  drivers/platform/x86/serial-multi-instantiate.c | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 5b145f1aaa1b..87e385542576 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1714,6 +1714,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>  		{"BSG1160", },
>  		{"BSG2150", },
>  		{"CSC3551", },
> +		{"CSC3556", },
>  		{"INT33FE", },
>  		{"INT3515", },
>  		/* Non-conforming _HID for Cirrus Logic already released */
> diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
> index f3dcbdd72fec..dcf2914b97c9 100644
> --- a/drivers/platform/x86/serial-multi-instantiate.c
> +++ b/drivers/platform/x86/serial-multi-instantiate.c
> @@ -316,6 +316,17 @@ static const struct smi_node cs35l41_hda = {
>  	.bus_type = SMI_AUTO_DETECT,
>  };
>  
> +static const struct smi_node cs35l56_hda = {
> +	.instances = {
> +		{ "cs35l56-hda", IRQ_RESOURCE_GPIO, 0 },
> +		{ "cs35l56-hda", IRQ_RESOURCE_GPIO, 0 },
> +		{ "cs35l56-hda", IRQ_RESOURCE_GPIO, 0 },
> +		{ "cs35l56-hda", IRQ_RESOURCE_GPIO, 0 },
> +		{}
> +	},
> +	.bus_type = SMI_AUTO_DETECT,
> +};
> +
>  /*
>   * Note new device-ids must also be added to ignore_serial_bus_ids in
>   * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
> @@ -324,6 +335,7 @@ static const struct acpi_device_id smi_acpi_ids[] = {
>  	{ "BSG1160", (unsigned long)&bsg1160_data },
>  	{ "BSG2150", (unsigned long)&bsg2150_data },
>  	{ "CSC3551", (unsigned long)&cs35l41_hda },
> +	{ "CSC3556", (unsigned long)&cs35l56_hda },
>  	{ "INT3515", (unsigned long)&int3515_data },
>  	/* Non-conforming _HID for Cirrus Logic already released */
>  	{ "CLSA0100", (unsigned long)&cs35l41_hda },

