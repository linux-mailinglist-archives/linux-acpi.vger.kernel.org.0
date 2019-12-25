Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1D0B12A835
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Dec 2019 14:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfLYN1r (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Dec 2019 08:27:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42026 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726289AbfLYN1r (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Dec 2019 08:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577280467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L14kYmmUBRirMNQcmFvC3QEOg4F4FVINj4zyDvRtKy4=;
        b=HWKVRp0VIQNWHt8UaWexj1yWNU9K59JQe0vDrcaXgSBnbsVoR6AME90b+E98SzomuwLPzh
        +mDleHek/V6zHF1zRNjtHRPinWw5z5rtZzv/6pHK/VqMJxBdQTCcXLylQBR7br34OicAVo
        A4n2ngTWSspmTp0GWiVMNt6tyqunnYs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-4z2XuIwxOrmm92w53iI_kw-1; Wed, 25 Dec 2019 08:27:45 -0500
X-MC-Unique: 4z2XuIwxOrmm92w53iI_kw-1
Received: by mail-wr1-f72.google.com with SMTP id o6so7138586wrp.8
        for <linux-acpi@vger.kernel.org>; Wed, 25 Dec 2019 05:27:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L14kYmmUBRirMNQcmFvC3QEOg4F4FVINj4zyDvRtKy4=;
        b=N6DOnpPNVlIzRqiXS119iZpAjfBpp2+INsv6J46LCfvO8eQL7E6GY8UGM/wnwhvHLV
         aFAHRDxVjMdjgamCRtT6t1CXPbJuwV1dcEd3rtEkRWTP03Qdo5d8k2qGhi5RWd30m1ga
         TnWwdzfy6xAAp8gfYMFz26kxtIwYDjwLuM0Y/9RUw6q7OQ+QKusqlAMxfIRMrfp/P5Lf
         5KipDMkUYNb94UDZxV16Tld2k0ex0R9BL5pKH5ZFvVnddYDKIYZ/SLQUfvXOsEbx9cXb
         AkRNY7xiero/icmb2TSDTuqI839MrF46tE4CqQkYM1axxuQZqpzyqba3cNrph9SB4czT
         DwrQ==
X-Gm-Message-State: APjAAAV2xHGtbqJbXGZ4U2L6PPzL4Dwlm1HnBXv5rDyRe72/HcLvH+qG
        ulvuWUTZ8WJTCJlB0UqCv66iQ9w0hU3t+si35FjLz28l0o5/3is02gQSRyQBiFURp5RpUUT8yyw
        v2SVyDG0NkZITidzapmitNA==
X-Received: by 2002:adf:ffc7:: with SMTP id x7mr40318026wrs.159.1577280464084;
        Wed, 25 Dec 2019 05:27:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqzebYNxLyZcoSaWIT7WTvetSWpoPl8xnvq13Pd9ET2UuJg6dwHXgK2IDaUPj/pC+w5jVfiGyQ==
X-Received: by 2002:adf:ffc7:: with SMTP id x7mr40318016wrs.159.1577280463896;
        Wed, 25 Dec 2019 05:27:43 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id x6sm5554940wmi.44.2019.12.25.05.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Dec 2019 05:27:43 -0800 (PST)
Subject: Re: [PATCH] pinctrl: baytrail: Remove WARN when setting direct-irq
 pin to output
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Dmitry Mastykin <mastichi@gmail.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20191225132622.90592-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <aa56dc76-34fd-04a2-be94-2b61c5131f08@redhat.com>
Date:   Wed, 25 Dec 2019 14:27:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191225132622.90592-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 25-12-2019 14:26, Hans de Goede wrote:
> Suspending Goodix touchscreens requires changing the interrupt pin to
> output before sending them a power-down command. Followed by wiggling
> the interrupt pin to wake the device up, after which it is put back
> in input mode.
> 
> On Cherry Trail device the interrupt pin is listed as a GpioInt ACPI
> resource so we can do this without problems as long as we release the
> irq before changing the pin to output mode.
> 
> On Bay Trail devices with a Goodix touchscreen direct-irq mode is used
> in combination with listing the pin as a normal GpioIo resource. This
> works fine, but this triggers the WARN in byt_gpio_set_direction-s output
> path because direct-irq support is enabled on the pin.
> 
> This commit removes the WARN call, fixing a bunch of WARN splats in
> dmesg on each suspend/resume cycle.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

This is missing the dropping of rhe now unused conf_ref variable, I already
had this fixed, but forgot to do git commit --amend before sending this out,
v2 with this fixed coming up.

Regards,

Hans



> ---
>   drivers/pinctrl/intel/pinctrl-baytrail.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
> index c6f53ed626c9..e7cdfdb4a189 100644
> --- a/drivers/pinctrl/intel/pinctrl-baytrail.c
> +++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
> @@ -811,15 +811,7 @@ static int byt_gpio_set_direction(struct pinctrl_dev *pctl_dev,
>   	value &= ~BYT_DIR_MASK;
>   	if (input)
>   		value |= BYT_OUTPUT_EN;
> -	else
> -		/*
> -		 * Before making any direction modifications, do a check if gpio
> -		 * is set for direct IRQ.  On baytrail, setting GPIO to output
> -		 * does not make sense, so let's at least warn the caller before
> -		 * they shoot themselves in the foot.
> -		 */
> -		WARN(readl(conf_reg) & BYT_DIRECT_IRQ_EN,
> -		     "Potential Error: Setting GPIO with direct_irq_en to output");
> +
>   	writel(value, val_reg);
>   
>   	raw_spin_unlock_irqrestore(&byt_lock, flags);
> 

