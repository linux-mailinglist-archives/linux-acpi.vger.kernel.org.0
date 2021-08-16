Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21673ED3ED
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Aug 2021 14:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbhHPM2o (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Aug 2021 08:28:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59184 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234272AbhHPM2n (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Aug 2021 08:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629116891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8J8uBMlBdBuZQDmBUgS0XJpmfufRjyMynx7EajosaWQ=;
        b=Z6DypfmM+xwP6pTHwccokUkUxbvvmJYUqzdpeJz7N9RKTSId3BeAKfa5ny33J5HaxK4go1
        54iXXkVMfyfQ5WN3Y65Qe4NvLcK+60c9y7ikmSxQ3EaqQV3ts3z4HMMyRgQIOwooHO6QYg
        0RrYrp610D2kgzZG6Q1D1ySlb+ZVrZ4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-g1ByHYyzO_GwF9ZO_UUVhA-1; Mon, 16 Aug 2021 08:28:10 -0400
X-MC-Unique: g1ByHYyzO_GwF9ZO_UUVhA-1
Received: by mail-ed1-f70.google.com with SMTP id y22-20020a0564023596b02903bd9452ad5cso8736299edc.20
        for <linux-acpi@vger.kernel.org>; Mon, 16 Aug 2021 05:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8J8uBMlBdBuZQDmBUgS0XJpmfufRjyMynx7EajosaWQ=;
        b=bfd25zCTAhVI6BQXARrnbLJqlupaYQn3pReHHikec+82qEQqPiEfATZrOSNXsq8iIo
         DcLpvEfBpAObiN/6IpTTylGmPT/EOXKuF4bxDvSwUApQBwCLtuWodTL75gAsjcodrL9T
         2ukWLKPvZaCmI4vdyZGaV0iAH30anIIPewIEIjSTPmaA4beDvedikc6VbPVfp55Txoto
         2Bjk8IYSfjjJM4YwTLXBgVVvC+BSdY4244UCc723hhhyP6D7X16QAwKg6Dx1R7zowSiY
         Ro9CYfISm1ocIyE5K/QBDdrXD2t6xsb1MA+vD3I/4VErE9OVRGYa9+DTqAfKDq1lg5GN
         L0DA==
X-Gm-Message-State: AOAM531xZEsiH113iHrKv5lT+ztFb5Kt1ahnN2GEBTNhPKhw+rVY0wdK
        d6j44AIqy++EuccYHTR342aIbaYU/rmr7qUT30lw+alTxNUOq4CoWyBxVK8meSJiQzHhDIqIrJl
        4voqFVxaq1MSgIwANuduKmRrEWcw5Tmp3rN60QVX75/nIexSiWy4U+qI2KGRSqI6NtAOuKdqBuQ
        ==
X-Received: by 2002:aa7:c1c4:: with SMTP id d4mr19752504edp.301.1629116888829;
        Mon, 16 Aug 2021 05:28:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUmlBUHs63dKqL9LT4V4WRNxi+CMzooXe+Mwa29D+sBIDUIx5mArm48KO18Z6xhvLDCt7yJA==
X-Received: by 2002:aa7:c1c4:: with SMTP id d4mr19752482edp.301.1629116888636;
        Mon, 16 Aug 2021 05:28:08 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id c8sm3608839ejp.124.2021.08.16.05.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 05:28:08 -0700 (PDT)
Subject: Re: [PATCH regression fix v2] gpiolib: acpi: Make
 set-debounce-timeout failures non fatal
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20210816104119.75019-1-hdegoede@redhat.com>
 <YRpWxnZvM2kzjcX/@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e7c1b41a-4d11-21f4-0add-9b6dd00a8da6@redhat.com>
Date:   Mon, 16 Aug 2021 14:28:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRpWxnZvM2kzjcX/@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 8/16/21 2:15 PM, Andy Shevchenko wrote:
> On Mon, Aug 16, 2021 at 12:41:19PM +0200, Hans de Goede wrote:
>> Commit 8dcb7a15a585 ("gpiolib: acpi: Take into account debounce settings")
>> made the gpiolib-acpi code call gpio_set_debounce_timeout() when requesting
>> GPIOs.
>>
>> This in itself is fine, but it also made gpio_set_debounce_timeout()
>> errors fatal, causing the requesting of the GPIO to fail. This is causing
>> regressions. E.g. on a HP ElitePad 1000 G2 various _AEI specified GPIO
>> ACPI event sources specify a debouncy timeout of 20 ms, but the
>> pinctrl-baytrail.c only supports certain fixed values, the closest
>> ones being 12 or 24 ms and pinctrl-baytrail.c responds with -EINVAL
>> when specified a value which is not one of the fixed values.
>>
>> This is causing the acpi_request_own_gpiod() call to fail for 3
>> ACPI event sources on the HP ElitePad 1000 G2, which in turn is causing
>> e.g. the battery charging vs discharging status to never get updated,
>> even though a charger has been plugged-in or unplugged.
>>
>> Make gpio_set_debounce_timeout() errors non fatal, warning about the
>> failure instead, to fix this regression.
>>
>> Note we should probably also fix various pinctrl drivers to just
>> pick the first bigger discrete value rather then returning -EINVAL but
>> this will need to be done on a per driver basis, where as this fix
>> at least gets us back to where things were before and thus restores
>> functionality on devices where this was lost due to
>> gpio_set_debounce_timeout() errors.
> 
> Yes, I also think that we need to choose upper debounce instead of rejecting
> the settings. And yes, I agree that for now it's not suitable as a fix.
> 
> That said,
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you.

FYI, I've prepared a patch to choose the upper debounce time for
pintctrl-baytrail . I'll test it when I'm back home tonight and
then submit it upstream.

Regards,

Hans




> 
>> Fixes: 8dcb7a15a585 ("gpiolib: acpi: Take into account debounce settings")
>> Depends-on: 2e2b496cebef ("gpiolib: acpi: Extract acpi_request_own_gpiod() helper")
>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> -Fix typo in commit msg
>> -Add Mika's Reviewed-by
>> -Add Depends-on tag
>> ---
>>  drivers/gpio/gpiolib-acpi.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
>> index 411525ac4cc4..47712b6903b5 100644
>> --- a/drivers/gpio/gpiolib-acpi.c
>> +++ b/drivers/gpio/gpiolib-acpi.c
>> @@ -313,9 +313,11 @@ static struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
>>  
>>  	ret = gpio_set_debounce_timeout(desc, agpio->debounce_timeout);
>>  	if (ret)
>> -		gpiochip_free_own_desc(desc);
>> +		dev_warn(chip->parent,
>> +			 "Failed to set debounce-timeout for pin 0x%04X, err %d\n",
>> +			 pin, ret);
>>  
>> -	return ret ? ERR_PTR(ret) : desc;
>> +	return desc;
>>  }
>>  
>>  static bool acpi_gpio_in_ignore_list(const char *controller_in, int pin_in)
>> -- 
>> 2.31.1
>>
> 

