Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7111F1734
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Jun 2020 13:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgFHLHV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Jun 2020 07:07:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39138 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729342AbgFHLHU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Jun 2020 07:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591614438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e8PAvNJwl8CVvzuQhQrqiLIXXDJ1qmAQ7ddNr8veIRE=;
        b=D+3yOyA0QOiB8otD8X6++S89FLHDDEdf1ZaY3ucrYMHs/C8UZGb4Os4Tq2LxNSyD6Zp9Fe
        RueguPBudXyUsp00QFuaHtcdo48QOaMUwr4gA7Ewl9pBxm6m5Ec7WR2hv/XEtRZjpauIgi
        yy0vUa/jPV9AyCi/b4382ubWC5XWzEs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-U5Mw8n7CPhOfm5dG9vHtsQ-1; Mon, 08 Jun 2020 07:07:17 -0400
X-MC-Unique: U5Mw8n7CPhOfm5dG9vHtsQ-1
Received: by mail-wm1-f70.google.com with SMTP id g84so5125112wmf.4
        for <linux-acpi@vger.kernel.org>; Mon, 08 Jun 2020 04:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e8PAvNJwl8CVvzuQhQrqiLIXXDJ1qmAQ7ddNr8veIRE=;
        b=mUBqWLUHePf/nGqwsbTnT9LNTmWU5JFXbh816TokyoGwMs5MaTm+XbipCA5bjOTqnI
         vUiBrE4P6NXe9sQLYtyTozUMcDhA13xB2okrx7+Zwf5PgYxuVh8xQyPrqu0ypnbkD/yP
         jl+CJJXGhe6AQUJRVfVNjBC5NNBy4ii3nmBcrUBypNwzguoEvgeRIx/wgvctTElO0Zqn
         0q8i4EhFXJEu9Kr1xQa/DSlC3XWuN4ZVBH7QW+nBaA47RObMidKthoMTEpf4QYXi27cw
         o70YhJcwhV8mL6TjQndhGg98bANDvCIYTRhulNh8cCkWxDD3UDUkY87lYGWeDbd1rz3R
         6t1w==
X-Gm-Message-State: AOAM530VSrEeKw0JIKx3OWiT8QPbD64MPB4g0A2CMcsU5u6y8WdzmWve
        tB8iPzzZ3+BkMNxJ/asCK5kmB/K1c/GQBX5QwQhbvxPVYZr/9XDRSl8s53pkmWjqp6hTu59edBL
        RiFm1w29O+Hehe3K7/wNWbg==
X-Received: by 2002:a7b:c041:: with SMTP id u1mr3779531wmc.56.1591614434798;
        Mon, 08 Jun 2020 04:07:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdmXNioeILy0TwT3HF2mT0/SxnOtWw0UuEKWxJARe1kqkMmGS1C96ubFrpAE8YjhmMf7MKIQ==
X-Received: by 2002:a7b:c041:: with SMTP id u1mr3779498wmc.56.1591614434473;
        Mon, 08 Jun 2020 04:07:14 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id h15sm22301292wrt.73.2020.06.08.04.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 04:07:13 -0700 (PDT)
Subject: Re: [PATCH v2 03/15] pwm: lpss: Add range limit check for the
 base_unit register value
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
References: <20200607181840.13536-1-hdegoede@redhat.com>
 <20200607181840.13536-4-hdegoede@redhat.com>
 <20200608035023.GZ2428291@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <90769dc0-3174-195b-34e0-ef4bb9d9b982@redhat.com>
Date:   Mon, 8 Jun 2020 13:07:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200608035023.GZ2428291@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/8/20 5:50 AM, Andy Shevchenko wrote:
> On Sun, Jun 07, 2020 at 08:18:28PM +0200, Hans de Goede wrote:
>> When the user requests a high enough period ns value, then the
>> calculations in pwm_lpss_prepare() might result in a base_unit value of 0.
>>
>> But according to the data-sheet the way the PWM controller works is that
>> each input clock-cycle the base_unit gets added to a N bit counter and
>> that counter overflowing determines the PWM output frequency. Adding 0
>> to the counter is a no-op. The data-sheet even explicitly states that
>> writing 0 to the base_unit bits will result in the PWM outputting a
>> continuous 0 signal.
> 
> So, and why it's a problem?

Lets sya the user requests a PWM output frequency of 100Hz on Cherry Trail
which has a 19200000 Hz clock this will result in 100 * 65536 / 19200000 =
0.3 -> 0 as base-unit value. So instead of getting 100 Hz the user will
now get a pin which is always outputting low.

OTOH if we clamp to 1 as lowest value, the user will get 192000000 / 65536
= 292 Hz as output frequency which is as close to the requested value as
we can get while actually still working as a PWM controller.

>> base_unit values > (base_unit_range / 256), or iow base_unit values using
>> the 8 most significant bits, cause loss of resolution of the duty-cycle.
>> E.g. assuming a base_unit_range of 65536 steps, then a base_unit value of
>> 768 (256 * 3), limits the duty-cycle resolution to 65536 / 768 = 85 steps.
>> Clamp the max base_unit value to base_unit_range / 32 to ensure a
>> duty-cycle resolution of at least 32 steps. This limits the maximum
>> output frequency to 600 KHz / 780 KHz depending on the base clock.
> 
> This part I don't understand. Why we limiting base unit? I seems like a
> deliberate regression.

The way the PWM controller works is that the base-unit gets added to
say a 16 bit (on CHT) counter each input clock and then the highest 8
bits of that counter get compared to the value programmed into the
ON_TIME_DIV bits.

Lets say we do not clamp and allow any value and lets say the user
selects an output frequency of half the input clock, so base-unit
value is 32768, then the counter will only have 2 values:
0 and 32768 after that it will wrap around again. So any on time-div
value < 128 will result in the output being always high and any
value > 128 will result in the output being high/low 50% of the time
and a value of 255 will make the output always low.

So in essence we now only have 3 duty cycle levels, which seems like
a bad idea to me / not what a pwm controller is supposed to do.

So I decided to put a cut of at having at least 32 steps.

The mean reason I wrote this patch though is to avoid a base-unit
value of 0 which really results in a completely non working PWM
output. I personally believe clamping on the high side is a good
idea too. But if you are against that I can drop that part.

Note that the clamping on the high side will not affect the
primary user of the LPSS-pwm driver which is the i915 backlight
code, that never asks for such high frequencies.  But it could
help to avoid an user shooting themselves in the foot when using
the PWM on a dev board through the sysfs interface.

Regards,

Hans


