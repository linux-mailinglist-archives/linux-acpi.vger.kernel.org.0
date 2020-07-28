Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FF6231359
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jul 2020 22:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgG1UAb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jul 2020 16:00:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28614 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729088AbgG1UAa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jul 2020 16:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595966428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hSzFFDyUfAnXvkkVJ84iprpsx2ZHjX86onKI2woEOHU=;
        b=JT+cQAp16ySm64D8+q0dpumTjO0h7krXE/2E/P5htJcdl+3980qiHyc2HVuWDFX1gWTvPs
        r9aXIzD2jvanJ4fb7q1LvqhL9Nr3Vhxhbx2ZWZBrhnyo0Qt1TO7L8CFmO6II666vbrUl/p
        +KJezjLygeuHnUC1QU5LtH9xGaWri8M=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-3hf_LDtpM7ek8fozFkb4Tw-1; Tue, 28 Jul 2020 16:00:26 -0400
X-MC-Unique: 3hf_LDtpM7ek8fozFkb4Tw-1
Received: by mail-ed1-f70.google.com with SMTP id t9so5970781edw.22
        for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2020 13:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hSzFFDyUfAnXvkkVJ84iprpsx2ZHjX86onKI2woEOHU=;
        b=YNKvITCcrd9bKTKpIKLDVMrjpBmIEL5KD4iAzjdPSkBL1fcjBfbDlNMEGS3ZhR6THA
         JgnrjtVt/Ldc8BNCCZzseCtvXxsaCDM6Q4r0wjJIDYOZ5Mujp7odOpwyzNg8OCEAn5OC
         KkbcCaDID7hIksXkdL27LZ2/dJH2Vo4QQ0OFUnMKyGiAvd6jxTLkmMNwJ9oPoOZfgGC5
         D9jKrh+I4EKJLckvuFtNElOA25txTSKSsDneBAAH3/NqBGyGqmalCcCc2olKhX0iasGh
         4dv+BpKzBBg+QTFW+5KXAG8E7fCGWuAZrVFnue2y98EHPX7n4c/EChVqksjh6Ja0bW6c
         ugYg==
X-Gm-Message-State: AOAM530L5ELcIbgq0WNgDxrd5+YK0/J9kLZ5JJx78cg8YYNIFY2tGO3A
        8MvDIxg45a9M+uSocK3fktdiXBZiErfYgHLryxu447DGrYL+EtZpkpemJ6NbApgYFvEEMDCf9Sv
        Ueg/2SjVjQ1g4l1NvGO+UEQ==
X-Received: by 2002:a17:906:e46:: with SMTP id q6mr25991248eji.234.1595966425332;
        Tue, 28 Jul 2020 13:00:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzV14O9arRYB6XE8+8IFKAQO6S/91DQBaJNDTc1IjVEOlhbwsAm5kcJXeUo4rgsWkPdUP3wYw==
X-Received: by 2002:a17:906:e46:: with SMTP id q6mr25991222eji.234.1595966425063;
        Tue, 28 Jul 2020 13:00:25 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id y22sm9846217ejf.108.2020.07.28.13.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 13:00:24 -0700 (PDT)
Subject: Re: [PATCH v5 07/16] pwm: crc: Fix period / duty_cycle times being
 off by a factor of 256
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
 <20200717133753.127282-8-hdegoede@redhat.com>
 <20200728193634.GD3703480@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a05f24ec-3be5-42c7-38b8-69e8a3a2b330@redhat.com>
Date:   Tue, 28 Jul 2020 22:00:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200728193634.GD3703480@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 7/28/20 9:36 PM, Andy Shevchenko wrote:
> On Fri, Jul 17, 2020 at 03:37:44PM +0200, Hans de Goede wrote:
>> While looking into adding atomic-pwm support to the pwm-crc driver I
>> noticed something odd, there is a PWM_BASE_CLK define of 6 MHz and
>> there is a clock-divider which divides this with a value between 1-128,
>> and there are 256 duty-cycle steps.
>>
>> The pwm-crc code before this commit assumed that a clock-divider
>> setting of 1 means that the PWM output is running at 6 MHZ, if that
>> is true, where do these 256 duty-cycle steps come from?
>>
>> This would require an internal frequency of 256 * 6 MHz = 1.5 GHz, that
>> seems unlikely for a PMIC which is using a silicon process optimized for
>> power-switching transistors. It is way more likely that there is an 8
>> bit counter for the duty cycle which acts as an extra fixed divider
>> wrt the PWM output frequency.
>>
>> The main user of the pwm-crc driver is the i915 GPU driver which uses it
>> for backlight control. Lets compare the PWM register values set by the
>> video-BIOS (the GOP), assuming the extra fixed divider is present versus
>> the PWM frequency specified in the Video-BIOS-Tables:
>>
>> Device:		PWM Hz set by BIOS	PWM Hz specified in VBT
>> Asus T100TA 	200			200
>> Asus T100HA 	200			200
>> Lenovo Miix 2 8	23437			20000
>> Toshiba WT8-A	23437			20000
>>
>> So as we can see if we assume the extra division by 256 then the register
>> values set by the GOP are an exact match for the VBT values, where as
>> otherwise the values would be of by a factor of 256.
>>
>> This commit fixes the period / duty_cycle calculations to take the
>> extra division by 256 into account.
> 
> So, base clock is 6MHz, then 7 bit divisor. That's what original values
> were for. On top of that there is 8-bit duty cycle control ("divide by 256"
> whatever it means) with the output range 23.437kHz..183Hz.

Right, so that range matches with a clock div of 1*256 (6 MHz/256 = 23437.5KHz)
to 128*256 (6 MHz/(128*256) = 183.1Hz) IOW this patch is correct.

Before this patch the code assumed a clkdiv of 1-128 (*), which leads to a
very different output frequency range.

Regards,

Hans


*) 0-127 really, that is fixed in a followup patch



> 
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v3:
>> - Use NSEC_PER_USEC instead of adding a new (non-sensical) NSEC_PER_MHZ define
>> ---
>>   drivers/pwm/pwm-crc.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
>> index 272eeb071147..c056eb9b858c 100644
>> --- a/drivers/pwm/pwm-crc.c
>> +++ b/drivers/pwm/pwm-crc.c
>> @@ -21,8 +21,8 @@
>>   
>>   #define PWM_MAX_LEVEL		0xFF
>>   
>> -#define PWM_BASE_CLK		6000000  /* 6 MHz */
>> -#define PWM_MAX_PERIOD_NS	21333    /* 46.875KHz */
>> +#define PWM_BASE_CLK_MHZ	6	/* 6 MHz */
>> +#define PWM_MAX_PERIOD_NS	5461333	/* 183 Hz */
>>   
>>   /**
>>    * struct crystalcove_pwm - Crystal Cove PWM controller
>> @@ -72,7 +72,7 @@ static int crc_pwm_config(struct pwm_chip *c, struct pwm_device *pwm,
>>   
>>   		/* changing the clk divisor, need to disable fisrt */
>>   		crc_pwm_disable(c, pwm);
>> -		clk_div = PWM_BASE_CLK * period_ns / NSEC_PER_SEC;
>> +		clk_div = PWM_BASE_CLK_MHZ * period_ns / (256 * NSEC_PER_USEC);
>>   
>>   		regmap_write(crc_pwm->regmap, PWM0_CLK_DIV,
>>   					clk_div | PWM_OUTPUT_ENABLE);
>> -- 
>> 2.26.2
>>
> 

