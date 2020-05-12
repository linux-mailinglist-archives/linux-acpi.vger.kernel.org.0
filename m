Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D6E1CFF94
	for <lists+linux-acpi@lfdr.de>; Tue, 12 May 2020 22:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731107AbgELUjS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 May 2020 16:39:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36277 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731206AbgELUjS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 May 2020 16:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589315955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tJ4CzMcj7kPytMmHh2xDynyGWXnqvMBKo+bYVaOC3mc=;
        b=hNPPWWRjc9RYsJAmognDChtoSiC6Y2wgHS1cJvDEM50i4bM8bRanSDYXSHRvGARGEy+30z
        /nbmN8hBZbP3bSV9FJEk564/I8hkUzKx/C1HGi1jeYsGTPFntqJ14M7WbmtvJAvWRk7qES
        554RacZefTXwo8r8CUJjgVE7GjQBF8o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-7vOC86m5N1eAXg3uyoP3Mw-1; Tue, 12 May 2020 16:39:13 -0400
X-MC-Unique: 7vOC86m5N1eAXg3uyoP3Mw-1
Received: by mail-wr1-f72.google.com with SMTP id e14so7442869wrv.11
        for <linux-acpi@vger.kernel.org>; Tue, 12 May 2020 13:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tJ4CzMcj7kPytMmHh2xDynyGWXnqvMBKo+bYVaOC3mc=;
        b=P/5Qyb38RzAnzGZJbv1qDi4qqbfE2vhiw5ZpIXtTwqD0MeMDZthliDIaTtRwPWQWS7
         1Uj3hj/Gu//gE1cCheNvgy25OjVLsabIWL/rPwqb7kzuH/t8Ss6jGzKwYnSdNzVicCtg
         4IyR0E/T/3U/tc3jEvc3gV7AGv4iPSYl7M5+8oKctkcVs/quyfkbcJ2mZzPni3G32ttI
         G5Sppy/ve6uKJra1YVXKtFMFUhUn3TWJVVZRPnHCU36EqsSlL293VsUUT9P5coWfpPfQ
         F80Blq9M/VGdsiKZr4eeBHWdO24v0B09TsWzUtV4WEALPIcTWyxEMku25e/6xCICGAD7
         2b+g==
X-Gm-Message-State: AGi0PuYXS5mmbXox3hT1c77zQK3cYcGXUrYKevMi9E55JTj0Z2lKXXFO
        I7dcdL4kqtjSUMp3tKa4H1pHKQTbT/WPsFYTHKaSnrqdP52AAFbNq7rVh2JkLK0fbgbxAbkFSEN
        3Ylu6OPgk/CZsRtNjVC5yUA==
X-Received: by 2002:a1c:f416:: with SMTP id z22mr39270754wma.32.1589315952286;
        Tue, 12 May 2020 13:39:12 -0700 (PDT)
X-Google-Smtp-Source: APiQypIyQ90UenVDbmKhZjTeBaYLoLs531oux0Vh9tjzCmBcWKsb4+HnTwGNdTmx5kWy5ymmk0HX0g==
X-Received: by 2002:a1c:f416:: with SMTP id z22mr39270729wma.32.1589315951952;
        Tue, 12 May 2020 13:39:11 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id w15sm23346843wrl.73.2020.05.12.13.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 13:39:11 -0700 (PDT)
Subject: Re: [PATCH] pwm: lpss: Fix get_state runtime-pm reference handling
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org,
        stable@vger.kernel.org
References: <20200512110044.95984-1-hdegoede@redhat.com>
 <20200512190101.GF185537@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5f15f6bc-8650-d86e-893f-0d41557c57c7@redhat.com>
Date:   Tue, 12 May 2020 22:39:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200512190101.GF185537@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 5/12/20 9:01 PM, Andy Shevchenko wrote:
> On Tue, May 12, 2020 at 01:00:44PM +0200, Hans de Goede wrote:
>> Before commit cfc4c189bc70 ("pwm: Read initial hardware state at request
>> time"), a driver's get_state callback would get called once per PWM from
>> pwmchip_add().
>>
>> pwm-lpss' runtime-pm code was relying on this, getting a runtime-pm ref for
>> PWMs which are enabled at probe time from within its get_state callback,
>> before enabling runtime-pm.
>>
>> The change to calling get_state at request time causes a number of
>> problems:
>>
>> 1. PWMs enabled at probe time may get runtime suspended before they are
>> requested, causing e.g. a LCD backlight controlled by the PWM to turn off.
>>
>> 2. When the request happens when the PWM has been runtime suspended, the
>> ctrl register will read all 1 / 0xffffffff, causing get_state to store
>> bogus values in the pwm_state.
>>
>> 3. get_state was using an async pm_runtime_get() call, because it assumed
>> that runtime-pm has not been enabled yet. If shortly after the request an
>> apply call is made, then the pwm_lpss_is_updating() check may trigger
>> because the resume triggered by the pm_runtime_get() call is not complete
>> yet, so the ctrl register still reads all 1 / 0xffffffff.
>>
>> This commit fixes these issues by moving the initial pm_runtime_get() call
>> for PWMs which are enabled at probe time to the pwm_lpss_probe() function;
>> and by making get_state take a runtime-pm ref before reading the ctrl reg.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you.

> One thing to consider below.
> 
>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1828927
>> Fixes: cfc4c189bc70 ("pwm: Read initial hardware state at request time")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/pwm/pwm-lpss.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
>> index 75bbfe5f3bc2..9d965ffe66d1 100644
>> --- a/drivers/pwm/pwm-lpss.c
>> +++ b/drivers/pwm/pwm-lpss.c
>> @@ -158,7 +158,6 @@ static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>   	return 0;
>>   }
>>   
>> -/* This function gets called once from pwmchip_add to get the initial state */
>>   static void pwm_lpss_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>>   			       struct pwm_state *state)
>>   {
>> @@ -167,6 +166,8 @@ static void pwm_lpss_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>>   	unsigned long long base_unit, freq, on_time_div;
>>   	u32 ctrl;
>>   
>> +	pm_runtime_get_sync(chip->dev);
>> +
>>   	base_unit_range = BIT(lpwm->info->base_unit_bits);
>>   
>>   	ctrl = pwm_lpss_read(pwm);
>> @@ -187,8 +188,7 @@ static void pwm_lpss_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>>   	state->polarity = PWM_POLARITY_NORMAL;
>>   	state->enabled = !!(ctrl & PWM_ENABLE);
>>   
>> -	if (state->enabled)
>> -		pm_runtime_get(chip->dev);
>> +	pm_runtime_put(chip->dev);
>>   }
>>   
>>   static const struct pwm_ops pwm_lpss_ops = {
>> @@ -202,7 +202,8 @@ struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
>>   {
>>   	struct pwm_lpss_chip *lpwm;
>>   	unsigned long c;
>> -	int ret;
>> +	int i, ret;
>> +	u32 ctrl;
>>   
>>   	if (WARN_ON(info->npwm > MAX_PWMS))
>>   		return ERR_PTR(-ENODEV);
>> @@ -232,6 +233,12 @@ struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
>>   		return ERR_PTR(ret);
>>   	}
>>   
>> +	for (i = 0; i < lpwm->info->npwm; i++) {
> 
>> +		ctrl = pwm_lpss_read(&lpwm->chip.pwms[i]);
>> +		if (ctrl & PWM_ENABLE)
> 
> I would create a helper for this as opposite to pwm_lpss_cond_enable(),
> something like pwm_lpss_is_enabled().

pwm_lpss_cond_enable() is used in multiple places, this check
we only need once, so I would prefer to just keep it as is.

Regards,

Hans




> 
>> +			pm_runtime_get(dev);
>> +	}
>> +
>>   	return lpwm;
>>   }
>>   EXPORT_SYMBOL_GPL(pwm_lpss_probe);
>> -- 
>> 2.26.0
>>
> 

