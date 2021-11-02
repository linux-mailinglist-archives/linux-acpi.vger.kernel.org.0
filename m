Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105BE442FF6
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Nov 2021 15:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhKBOPg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Nov 2021 10:15:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25166 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231133AbhKBOPc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Nov 2021 10:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635862377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/iH/2e/wikez8Ul76Vyks6IXMr0Ua0X0rQ4GfdFV+Uc=;
        b=Pc2GwmZdwngCdMpGx1GUeTz+jPwPhPUGU426hXDXbI4nZU+mZpMEvbAUcQNvc2B+MJIz1V
        ndbQ9JHtXcZPrd7TJpFAoB6SQD82As+/mgxydHt7/l45vxyhIl1DnloINuH3u08j642ORP
        wE7qZdI6YUQPAVUrGbl2ADfg+Ydy1zk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-pPXOJd6tNF6CktzwZtS8yQ-1; Tue, 02 Nov 2021 10:12:56 -0400
X-MC-Unique: pPXOJd6tNF6CktzwZtS8yQ-1
Received: by mail-ed1-f69.google.com with SMTP id m8-20020a056402510800b003e29de5badbso3676907edd.18
        for <linux-acpi@vger.kernel.org>; Tue, 02 Nov 2021 07:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/iH/2e/wikez8Ul76Vyks6IXMr0Ua0X0rQ4GfdFV+Uc=;
        b=mG65pBHqFm5fUjz+cwfkkceuV2vIutoFuos/iSrLpGsvq0U8dhfa+viA4w7O6zKhOU
         F75u93vYsU4yMdqUOM9jDPa93L59VB5YlzdUK3Yz+rP41dTaJoyYQAGgqC907v788X9O
         c/jfAOWp6lV4xfK0y8qgLIoWPqAbJ4XDGji+iOGRh6+lRCtJj2YA44aiK8iT+LuiN6vM
         eEOubcX7Yewz0GLMmnm/2abZVuYWIYjYKfnMgkUrorigD3olU6wo86jgUe5NYD0dlCb2
         vyTpTzSpFSIqtjaN+uU71V7sT5SPlWn0kwWLyvKODVw6dwCvCEFg15t8zahSj4wN+yim
         1a6w==
X-Gm-Message-State: AOAM532NXXD0wDjA26bLpcWAa9WupnIQUomtWmhKffBJijzrCXCG1EOb
        NQgwXWZDWZCMx3fZaWMhHOplZ+I79SgY8jGNWt2lj2J38VMdIyfTPTsZJ+uTh9fArkkrEWEJlak
        6iQjkN1kTN/jcgU/B5aXN5A==
X-Received: by 2002:a17:906:c301:: with SMTP id s1mr46124376ejz.409.1635862373615;
        Tue, 02 Nov 2021 07:12:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+ixxnyOcDdQqSVZiYMCwXTPXBclYSYRPD80VvvknhhaT2v3qRnyd1L/2+ts7dxYBhlXa+Ig==
X-Received: by 2002:a17:906:c301:: with SMTP id s1mr46124248ejz.409.1635862372275;
        Tue, 02 Nov 2021 07:12:52 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id bm1sm8220290ejb.38.2021.11.02.07.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 07:12:51 -0700 (PDT)
Message-ID: <e74947c4-74c8-a17e-f4cb-752a79851954@redhat.com>
Date:   Tue, 2 Nov 2021 15:12:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] power: supply: bq27xxx: Fix kernel crash on IRQ
 handler register error
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
References: <20211031152522.3911-1-hdegoede@redhat.com>
 <CAHp75Vc6GO4e0_Qp6HfFtd_kbSakaMXsQN4oEPArdmMrxTFb7A@mail.gmail.com>
 <20211102132352.yqazgy2njnbthujb@earth.universe>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211102132352.yqazgy2njnbthujb@earth.universe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Sebastian,

On 11/2/21 14:23, Sebastian Reichel wrote:
> Hi,
> 
> On Sun, Oct 31, 2021 at 09:34:46PM +0200, Andy Shevchenko wrote:
>> On Sun, Oct 31, 2021 at 5:25 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> When registering the IRQ handler fails, do not just return the error code,
>>> this will free the devm_kzalloc()-ed data struct while leaving the queued
>>> work queued and the registered power_supply registered with both of them
>>> now pointing to free-ed memory, resulting in various kernel crashes
>>> soon afterwards.
>>>
>>> Instead properly tear-down things on IRQ handler register errors.
>>
>> FWIW,
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Thanks, queued.

Thank you, note these 2 patches (for the bq25980 driver) are also
pure bug-fixes, I posted them as part of a larger series, but
in hindsight I should have probably posted them separately:

https://lore.kernel.org/platform-driver-x86/20211030182813.116672-4-hdegoede@redhat.com/
https://lore.kernel.org/platform-driver-x86/20211030182813.116672-5-hdegoede@redhat.com/

It would be good if you can pick these 2 up too
(I'll respin the rest of the series to address various
review comments without them then).

Let me know if you want me to resend these 2 as a stand alone
series.

Regards,

Hans



>>> Fixes: 703df6c09795 ("power: bq27xxx_battery: Reorganize I2C into a module")
>>> Cc: Andrew F. Davis <afd@ti.com>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>> Changes in v2:
>>> - Fix devm_kzalloc()-ed type in the commit message
>>> ---
>>>  drivers/power/supply/bq27xxx_battery_i2c.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
>>> index 46f078350fd3..cf38cbfe13e9 100644
>>> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
>>> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
>>> @@ -187,7 +187,8 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
>>>                         dev_err(&client->dev,
>>>                                 "Unable to register IRQ %d error %d\n",
>>>                                 client->irq, ret);
>>> -                       return ret;
>>> +                       bq27xxx_battery_teardown(di);
>>> +                       goto err_failed;
>>>                 }
>>>         }
>>>
>>> --
>>> 2.31.1
>>>
>>
>>
>> -- 
>> With Best Regards,
>> Andy Shevchenko

