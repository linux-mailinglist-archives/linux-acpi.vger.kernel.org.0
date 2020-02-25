Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A276016BF8D
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2020 12:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbgBYL0P (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Feb 2020 06:26:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30886 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728981AbgBYL0P (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Feb 2020 06:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582629973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Df4EJmWVFOP/G7mowARS8zSWcuNOKoxZdEcNhRowUSo=;
        b=IcDlgd03ANF7QfvUEIYmSAWtaZPSNjuLnX2iY3HfZE+6PPgOGkT3cfPS3ubYEbFigdUJeY
        NZHa2KLD/Vtw7GBY3ZfQ+kQdh3g7M0J6VNRwk2qvYOF+j14ieEAF8GdxVESEY0oNUWIzjX
        smYKhWVdiOa+hB9xRpjADUCznDQaFo0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-U0xGxVzROS2BAVPoYImYew-1; Tue, 25 Feb 2020 06:26:07 -0500
X-MC-Unique: U0xGxVzROS2BAVPoYImYew-1
Received: by mail-wr1-f71.google.com with SMTP id d15so7162342wru.1
        for <linux-acpi@vger.kernel.org>; Tue, 25 Feb 2020 03:26:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Df4EJmWVFOP/G7mowARS8zSWcuNOKoxZdEcNhRowUSo=;
        b=W9txZUBwlYGvOZs8qlbeZOFrI02gnbtIAiJVmrJ82/dWlnEvNUVyKU+Oei4I2xVTQz
         xejje3f1Lkzl+OeBqdoUpA8q1vMcon6Tr7sYGgsoap9l6S3Z9aZf4/Ri+zrCNd0aYEcz
         HK0uPhEfaYvcl07Q1ssXyvmc9HBcr+Ol9GL+bQ30P83oujkExNfEpGf0h7yCgHRkqsSG
         MGVl/zGiHfUkGncIFzoGj83jCX93fVxMtOVLjZVfywdgYi/tBAYpPFdU8xzdQvxL6YAR
         Zsmzco6MeN0M56ND8csObEcayPFSyFEPx7tVA3nV3i7k/h3oSHo4cR27WPG6APPHkEd5
         3cLg==
X-Gm-Message-State: APjAAAXIIVLKFat07h3OYTV1hIcyYQV7MNn9Gk4yxRpEgurRgyjzip/F
        JEGoDwzXKGeisZamjC2pwNoTjYJq+zfgjBgjk52dQi0enPsExeukz/unjYZjeO86iO0rzd6uy20
        nbFTXuBpo1YsXWPW3DvA+KQ==
X-Received: by 2002:adf:c54e:: with SMTP id s14mr70055423wrf.385.1582629965940;
        Tue, 25 Feb 2020 03:26:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqwmkj53ewZ1n0+qCVvFa/um4DkZoI3da4lo0MRmGQeWsUJJFri2qgBtfUaBiWZYuQ9rKGgBtg==
X-Received: by 2002:adf:c54e:: with SMTP id s14mr70055393wrf.385.1582629965651;
        Tue, 25 Feb 2020 03:26:05 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-7a91-34f6-66f7-d87c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7a91:34f6:66f7:d87c])
        by smtp.gmail.com with ESMTPSA id u185sm1910134wmg.6.2020.02.25.03.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 03:26:05 -0800 (PST)
Subject: Re: [PATCH resend 2/3] gpiolib: acpi: Rename honor_wakeup option to
 ignore_wake, add extra quirk
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Lehmann <schmorp@schmorp.de>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20200225102753.8351-1-hdegoede@redhat.com>
 <20200225102753.8351-3-hdegoede@redhat.com>
 <20200225105437.GG10400@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e0c39a89-bcac-4315-d764-5853eb77537d@redhat.com>
Date:   Tue, 25 Feb 2020 12:26:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200225105437.GG10400@smile.fi.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

Thank you for looking at this.

On 2/25/20 11:54 AM, Andy Shevchenko wrote:
> On Tue, Feb 25, 2020 at 11:27:52AM +0100, Hans de Goede wrote:
>> Commit aa23ca3d98f7 ("gpiolib: acpi: Add honor_wakeup module-option +
>> quirk mechanism") was added to deal with spurious wakeups on one specific
>> model of the HP x2 10 series. In the mean time I have learned that there
>> are at least 3 variants of the HP x2 10 models:
>>
>> Bay Trail SoC + AXP288 PMIC
>> Cherry Trail SoC + AXP288 PMIC
>> Cherry Trail SoC + TI PMIC
>>
>> It turns out that the need to ignore wakeup on *all* ACPI GPIO event
>> handlers is unique to the Cherry Trail SoC + TI PMIC variant for which
>> the first quirk was added.
>>
>> The 2 variants with the AXP288 PMIC only need to have wakeup disabled on
>> the embedded-controller event handler. We want to e.g. keep wakeup on the
>> event handler connected to the GPIO for the lid open/closed sensor.
>>
>> Since the honor_wakeup option was added to be able to ignore wake events,
>> the name was perhaps not the best, this commit renames it to ignore_wake,
>> this version of the option has te following possible values:
>>
>> values >= 0: a pin number on which to ignore wakeups, the ACPI wake flag
>> will still be honored on all other pins
>> value -1: auto: check for DMI quirk, otherwise honor the flag on all pins
>> value -2: all:  ignore the flag on all pins
>> value -3: none: honor wakeups on all pins
>>
>> Note that it is possible for an ACPI table to request events on the same
>> pin-number on multiple GPIO controllers, in that case if such a pin-number
>> is used as ignore_wake value then wakeups will be ignored for that pin on
>> all GPIO controllers.
>>
>> The existing quirk for the Cherry Trail + TI PMIC models is changed to
>> IGNORE_WAKE_ALL, keeping the current behavior; and a new quirk is added
>> for the Bay Trail + AXP288 model, ignoring wakeups on the EC GPIO pin only.
> 
> In general I'm fine with this, but looking to the history of your changes I'm
> afraid that in future it will require more than one pin to be listed or
> something like this.

The only models which need this so far are the weird HP X2 models which
use an external embedded controller with the tablet version of BYT / CHT
which is just al sorts of hacked together. Also see:

https://lore.kernel.org/stable/20200223153208.312005-1-hdegoede@redhat.com/T/#u

For other parts of the same device which also rather "hacked together"
HP made these models really really interesting...

With that said I cannot guarantee that we won't need something similar
for some other botched-up device.

> ...
> 
>> +static int ignore_wake = IGNORE_WAKE_AUTO;
>> +module_param(ignore_wake, int, 0444);
>> +MODULE_PARM_DESC(ignore_wake,
>> +	"Ignore ACPI wake flag: x=ignore-for-pin-x, -1=auto, -2=all, -3=none");
> 
> Perhaps we may take list of pins or a bitmap (see bitmap list parsers API).

I guess you mean bitmap_parse_user / bitmap_print_to_pagebuf, the problem
is that for a more generic solution we need a wat to specify the
GPIO controller + the pin, so we would get a list of <name>,<pin> pairs
and then need to parse that, e.g. :

	gpiolib_acpi.ignore_wake=INT33FC:00,0x1c;INT33FC:01;0x12

I agree that if we really want to future proof this that then this is
the way we should go. This does mean adding a bunch of extra code for
parsing this, but I guess that would be better then my current hack.

Please let me know if you prefer going this route then I will respin
the patches to work this way.

> ...
> 
>> -static int honor_wakeup = -1;
>> -module_param(honor_wakeup, int, 0444);
>> -MODULE_PARM_DESC(honor_wakeup,
>> -		 "Honor the ACPI wake-capable flag: 0=no, 1=yes, -1=auto");
> 
> Isn't it now a part of ABI? I don't think we may remove it, though we may ignore it.
> Or do something else.
> 
> (One of the reasons why I hate module parameters)

I personally do not subscribe to the module parameters are part of the kernel ABI
crowd. I do not think Linus has ever stated something like that ?  For long existing
often used module parameters treating them as such makes a ton of sense, but this
one is quite new and AFAIK almost nobody is using it. So my vote would be to just
drop it. If we get push back we can easily restore it in some form.

> 
>> +			ignore_wake = (s16)(quirks & QUIRK_IGNORE_WAKE_MASK);
> 
> It's casted to signed because ..?

The high 32 bits of the quirk field is used for flags, and ignore_wake can
have a special negative value, so we need to sign extend the value stored
in the lower 16 bits of the quirk in case it is a negative value such as
IGNORE_WAKE_ALL.

Note this ugliness would go away if we switch to the string format for
the module param. Then the driver_data in the dmi matches would point
to a struct with a separate unsigned long flags field and a const char
*ignore_wake field...

Regards,

Hans

