Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19312231335
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jul 2020 21:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgG1Tz3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jul 2020 15:55:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48901 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728708AbgG1Tz2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jul 2020 15:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595966126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SH5q26piEln6+brQgUs5QwIsRcXrNMf3SmQsNLqi3Vo=;
        b=Zy5jz9t3Llpk0Zfi+WWNhchPHJcNcinpsDPC2StDHf0Vh7B3l7ks8tD3jhgpsMx6Wuoa/T
        927JihyqRn/mAbgTEyAXT2RzcrpowQHlsw4EryXEJnb4Aqvs94VxX/2oCQLDyoqSQuLX3Y
        /jUrGuIWsu3eUVZYXdGfrGo3YbW9XvA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-zcILQa8SMDWjVk3_mMveqw-1; Tue, 28 Jul 2020 15:55:25 -0400
X-MC-Unique: zcILQa8SMDWjVk3_mMveqw-1
Received: by mail-ej1-f72.google.com with SMTP id gt10so928645ejb.13
        for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2020 12:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SH5q26piEln6+brQgUs5QwIsRcXrNMf3SmQsNLqi3Vo=;
        b=eyF953tPPEY3r+7ouHuBdT8jC06cJFb4IaIotwN/57MJTsoi0L6aTM4BHeafAV3f+N
         grG+V8BvfXvdA0adQ9kdos+ZSGkjVIMVIGwA7uG0WbLyAJcXfDsBslwwHbLeOrZervdW
         s21t69vXmwplCQc7scRixIQ0mrQ/8YTZH0syzQ8ol6KfN0CbfCDCdLyOCFTE6PMnyUcp
         rQkEC/9fHfjuT2R+SzhejXgkXbrowUqsiif4xRVpDw+/IuiSMeNfkYTGxlbpUMmXGx5O
         QM6UXO04vq5Y/9cVa0mzdBcpjzr9MU9fNSYjNPCkLhfJdnWcINzoYFb4UBVMhlyuK2XA
         ecJA==
X-Gm-Message-State: AOAM532e85IIqj0QMQ6kQEMCzdBHqVY5Q1k/kXg14xyIisUMafFR1v/Z
        S1yME7T61hKwHN4uCkZfqdT5uiM6iOymvZultm5c8O9nkiFPimvOnzls7SkLAzb9CU+1k7pn9HI
        s1x1NJRNJXaoajFc9eO+28Q==
X-Received: by 2002:aa7:c655:: with SMTP id z21mr27771978edr.330.1595966123728;
        Tue, 28 Jul 2020 12:55:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwya90PeANkl56GbLL/sAAQgT++JcBuCdnZPXxsUt2lGBGTS4oefB9O+jlvr2TwUYPoNeYaw==
X-Received: by 2002:aa7:c655:: with SMTP id z21mr27771962edr.330.1595966123458;
        Tue, 28 Jul 2020 12:55:23 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id gh25sm4295031ejb.109.2020.07.28.12.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 12:55:22 -0700 (PDT)
Subject: Re: [PATCH v5 06/16] pwm: lpss: Use pwm_lpss_apply() when restoring
 state on resume
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
References: <20200717133753.127282-1-hdegoede@redhat.com>
 <20200717133753.127282-7-hdegoede@redhat.com>
 <20200728185703.GA3703480@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1e19e31f-cf68-5607-3027-3b963ce53c39@redhat.com>
Date:   Tue, 28 Jul 2020 21:55:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200728185703.GA3703480@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 7/28/20 8:57 PM, Andy Shevchenko wrote:
> On Fri, Jul 17, 2020 at 03:37:43PM +0200, Hans de Goede wrote:
>> Before this commit a suspend + resume of the LPSS PWM controller
>> would result in the controller being reset to its defaults of
>> output-freq = clock/256, duty-cycle=100%, until someone changes
>> to the output-freq and/or duty-cycle are made.
>>
>> This problem has been masked so far because the main consumer
>> (the i915 driver) was always making duty-cycle changes on resume.
>> With the conversion of the i915 driver to the atomic PWM API the
>> driver now only disables/enables the PWM on suspend/resume leaving
>> the output-freq and duty as is, triggering this problem.
>>
>> The LPSS PWM controller has a mechanism where the ctrl register value
>> and the actual base-unit and on-time-div values used are latched. When
>> software sets the SW_UPDATE bit then at the end of the current PWM cycle,
>> the new values from the ctrl-register will be latched into the actual
>> registers, and the SW_UPDATE bit will be cleared.
>>
>> The problem is that before this commit our suspend/resume handling
>> consisted of simply saving the PWM ctrl register on suspend and
>> restoring it on resume, without setting the PWM_SW_UPDATE bit.
>> When the controller has lost its state over a suspend/resume and thus
>> has been reset to the defaults, just restoring the register is not
>> enough. We must also set the SW_UPDATE bit to tell the controller to
>> latch the restored values into the actual registers.
>>
>> Fixing this problem is not as simple as just or-ing in the value which
>> is being restored with SW_UPDATE. If the PWM was enabled before we must
>> write the new settings + PWM_SW_UPDATE before setting PWM_ENABLE.
>> We must also wait for PWM_SW_UPDATE to become 0 again and depending on the
>> model we must do this either before or after the setting of PWM_ENABLE.
>>
>> All the necessary logic for doing this is already present inside
>> pwm_lpss_apply(), so instead of duplicating this inside the resume
>> handler, this commit makes the resume handler use pwm_lpss_apply() to
>> restore the settings when necessary. This fixes the output-freq and
>> duty-cycle being reset to their defaults on resume.
> 
> ...
> 
>> -static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>> -			  const struct pwm_state *state)
>> +static int __pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			    const struct pwm_state *state, bool from_resume)
>>   {
>>   	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
>>   	int ret = 0;
>>   
>>   	if (state->enabled) {
>>   		if (!pwm_is_enabled(pwm)) {
>> -			pm_runtime_get_sync(chip->dev);
>> +			if (!from_resume)
>> +				pm_runtime_get_sync(chip->dev);
>> +
>>   			ret = pwm_lpss_prepare_enable(lpwm, pwm, state, true);
>> -			if (ret)
>> +			if (ret && !from_resume)
>>   				pm_runtime_put(chip->dev);
>>   		} else {
>>   			ret = pwm_lpss_prepare_enable(lpwm, pwm, state, false);
>>   		}
>>   	} else if (pwm_is_enabled(pwm)) {
>>   		pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
>> -		pm_runtime_put(chip->dev);
>> +
>> +		if (!from_resume)
>> +			pm_runtime_put(chip->dev);
>>   	}
>>   
>>   	return ret;
>>   }
> 
> Maybe I'm too picky, but I would go even further and split apply to two versions
> 
> static int pwm_lpss_apply_on_resume(struct pwm_chip *chip, struct pwm_device *pwm,
> 			  const struct pwm_state *state)
>>   {
>>   	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
>>   
>>   	if (state->enabled)
>>   		return pwm_lpss_prepare_enable(lpwm, pwm, state, !pwm_is_enabled(pwm));
>>   	if (pwm_is_enabled(pwm)) {
>>   		pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
>>   	return 0;
>>   }
> 
> and another one for !from_resume.

It is a bit picky :) But that is actually not a bad idea, although I would write
it like this for more symmetry with the normal (not on_resume) apply version,
while at it I also renamed the function:

/*
  * This is a mirror of pwm_lpss_apply() without pm_runtime reference handling
  * for restoring the PWM state on resume.
  */
static int pwm_lpss_restore_state(struct pwm_chip *chip, struct pwm_device *pwm,
                                   const struct pwm_state *state)
{
    	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
	int ret = 0;

    	if (state->enabled)
    		ret = pwm_lpss_prepare_enable(lpwm, pwm, state, !pwm_is_enabled(pwm));
    	else if (pwm_is_enabled(pwm))
    		pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);

    	return ret;
}

Would that work for you?

>> +static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			  const struct pwm_state *state)
>> +{
>> +	return __pwm_lpss_apply(chip, pwm, state, false);
>> +}
> 
> ...
> 
>> +		ret = __pwm_lpss_apply(&lpwm->chip, pwm, &saved_state, true);
>> +		if (ret)
>> +			dev_err(dev, "Error restoring state on resume\n");
> 
> I'm wondering if it's a real error why we do not bail out?
> Otherwise dev_warn() ?

It is a real error, but a single PWM chip might have multiple controllers
and bailing out early would mean not even trying to restore the state on
the other controllers.  As for propagating the error, AFAIK the pm framework
does not do anything with resume errors other then log an extra error.

Regards,

Hans

