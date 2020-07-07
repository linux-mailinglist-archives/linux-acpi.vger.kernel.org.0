Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537952167FF
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jul 2020 10:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgGGIFR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Jul 2020 04:05:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24488 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727003AbgGGIFR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Jul 2020 04:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594109115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GB1QNbctl/Mx/SFUPpl4ypLqVQ62zsSb8czTF+T7RVk=;
        b=aTCK3GdR2Ytxhcta/lpnyKU/DUJVpMfr1p691BF2DXQwVZ+WldbZ8M919sMSj56RbmyjvI
        BiuMpQ/y3hAV+YAy0dZp9+tpLO5Ig8i/cVnyt7jUGS/8xjjcoAJr458CD+BRJYf/wYuNRY
        sSoX5DoDuvgFE0tUJE4iqbzMjqGI9aQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-oLDZu4guPv6emiJX8rSQlg-1; Tue, 07 Jul 2020 04:05:01 -0400
X-MC-Unique: oLDZu4guPv6emiJX8rSQlg-1
Received: by mail-ed1-f71.google.com with SMTP id g18so52672319edu.22
        for <linux-acpi@vger.kernel.org>; Tue, 07 Jul 2020 01:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GB1QNbctl/Mx/SFUPpl4ypLqVQ62zsSb8czTF+T7RVk=;
        b=Nwbdgj+GHCB0XXeSMsXouxfM5FkfJH3L6qtH/6FHUCaJf7VCKBIwjBXLBnIA8fsWa7
         iPiPZ4v6hLx0iDpmAImHrlFpesATT4IhKBj7Tg23h4udH+GeLzYdVPPcq/zD5Z2g36t6
         KyivaForB4RHG0Xb2iY8mS2ahq2oWlIgoJR2obuyD16mnlZ5ZP0ZzGEHQyk8/AX+2xh6
         OSBTibRxECChDfvY+VnxBJhOk+DR5/qtYzYdAIR9YTcniPSZkEpH+Kwlxi/yY2htU9S7
         uSyRAhgB2uLaGDE2rHIQuZ4ltOT39NVkalSzw2ahmgNvDJjvHBzCHJQY59xIXYevyKZV
         At9A==
X-Gm-Message-State: AOAM532NItYxMGv+c8I1lqpgkf1DwqeCLaBv1sS/V3kHpMgwuqy3nuBf
        93LP/w/7YeFUMk+/4Xoztwpyw1Siryd/pqGTuoPSCXjMscSf2/w0BgpQXlwdV/GIEqj75Q1OHeL
        yqNOS9puiGRfib7TUix6HQw==
X-Received: by 2002:a17:906:eb93:: with SMTP id mh19mr45243085ejb.552.1594109100174;
        Tue, 07 Jul 2020 01:05:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/cLO+WZhKB2j89clcfZyc+ByS2W7nYLObC2VeM2LUr6Hq2CXhfOpetmvPhCaQwzvlD2NYng==
X-Received: by 2002:a17:906:eb93:: with SMTP id mh19mr45243060ejb.552.1594109099889;
        Tue, 07 Jul 2020 01:04:59 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id s18sm18303668ejm.16.2020.07.07.01.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 01:04:59 -0700 (PDT)
Subject: Re: [PATCH v3 04/15] pwm: lpss: Add range limit check for the
 base_unit register value
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
References: <20200620121758.14836-1-hdegoede@redhat.com>
 <20200620121758.14836-5-hdegoede@redhat.com>
 <20200622073554.wf3smq3tvnr6t2xy@taurus.defre.kleine-koenig.org>
 <e07a7dd6-c361-32b8-c4e7-91e022f9c21d@redhat.com>
 <20200707073424.w6vd6e4bhl56kosd@pengutronix.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c2143daa-cdc0-0a72-196f-f27d1677278f@redhat.com>
Date:   Tue, 7 Jul 2020 10:04:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707073424.w6vd6e4bhl56kosd@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 7/7/20 9:34 AM, Uwe Kleine-König wrote:
> On Mon, Jul 06, 2020 at 10:53:08PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> Thank you for your review and sorry for the slow reply.
> 
> No problem for me, I didn't hold my breath :-)
>   
>>>> diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
>>>> index 43b1fc634af1..80d0f9c64f9d 100644
>>>> --- a/drivers/pwm/pwm-lpss.c
>>>> +++ b/drivers/pwm/pwm-lpss.c
>>>> @@ -97,6 +97,9 @@ static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
>>>>    	freq *= base_unit_range;
>>>>    	base_unit = DIV_ROUND_CLOSEST_ULL(freq, c);
>>>
>>> DIV_ROUND_CLOSEST_ULL is most probably wrong, too. But I didn't spend
>>> the time to actually confirm that.
>>
>> Yes I saw your comment elsewhere that the PWM API defines rounding
>> in a certain direction, but fixing that falls outside of this patch.
> 
> Yeah, sure.
> 
>> [...]
>> I hope this helps to explain what is going on a bit.
> 
> I will try to make sense of that and reply to the patch directly when I
> succeeded.

In case it helps here is the datasheet for the LPSS PWM controller
(somewhat hard to find if you don't know what you are looking for):

https://cdrdv2.intel.com/v1/dl/getcontent/332065
https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/atom-z8000-datasheet-vol-2.pdf

The first link contains a description about how the PWM controller works in
section 17.5  "SIO - Pulse Width Modulation (PWM)", the second link contains
all register definitions for the SoC and is not all that interesting other
then for verifying the existing register bits defines.

Regards,

Hans



> 
>> ###
>>
>> As for the behavior on base_unit==0 in the get_state method,
>> as mentioned above I wrote that when I did not fully understood
>> how the controller works.
>>
>> We really should never encounter this.
>>
>> But if we do then I think closest to the truth would be:
>>
>> state->period     = UINT_MAX;
>> state->duty_cycle = 0;
> 
> I'd say state->period = 1 & state->duty_cycle = 0 is a better
> representation.
> 
> Best regards
> Uwe
> 

