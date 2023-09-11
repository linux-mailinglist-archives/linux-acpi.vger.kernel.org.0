Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E83779AD07
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 01:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244177AbjIKVSn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Sep 2023 17:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238009AbjIKNdO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Sep 2023 09:33:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23A4F106
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 06:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694439143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=orwoQQ02NKiRDIoIWUPNEoBqnTACek0bhgnmSB5j9TU=;
        b=CJhFhkj4+TkJ1MgjcWRaW3p6SOgR9WSjMSfvDnuFAiXMA/mO+pByxITWO/Qq5s9Jsd+jUy
        sZswilomBt+FXdR8hs6UOeqHk2k0XEeMbe5SydRXdHakTf7pE8Drhwk1qUsOmp0gYm3jTV
        hevP9s1ytU3rEhsch0upxPAL53gRjvM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107--89L3uC5P2el8wxoDOO9Sw-1; Mon, 11 Sep 2023 09:32:21 -0400
X-MC-Unique: -89L3uC5P2el8wxoDOO9Sw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a2202c0a2bso291478466b.3
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 06:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694439140; x=1695043940;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=orwoQQ02NKiRDIoIWUPNEoBqnTACek0bhgnmSB5j9TU=;
        b=KgEfA7UUTq+n/QOZ1aoR2itwEU+nPCQDslZ5qKutk4eb2/6UGT1M+T1AqyMB+dOaxG
         zsfr4oCLNNmiQsVkt0GXtZwzzKMSTAVqL7n8oPTU2YD51CXnSSNZEJHgyTejXXMqlqrB
         XSkhMYJnpR+SBi63FRU1HWz7pVTetW85yI8etSDCcJTkPvKQCvyPz8UY+EhfMRfPAxkr
         hY8Aaf5z6Pq3au+nYS9L83sx7GraNtB4aMm/xW/2E1kyjiRKakT/PYokdd2qXUd/ZpYT
         9y022Uj6JSzgzYhEGgpRem+2A7frTPnXNtmG98O6SIIl6mR5evJIiYdo5S0HPGP5z5eu
         Rl0A==
X-Gm-Message-State: AOJu0Yyt3WWtNXeX/7lZLt4n4rUi+6w7dPLPbSEHEZfr9aYMRdowIleu
        YoFtgxYJtjrn50QZJUU4g8HWowWW7ozNzL9H7Xu/2bqIPJaMane47hSRwK0QM/qGRiYwX4Kj8ZQ
        NbplyVVPixZkq9LzwT1vvuw==
X-Received: by 2002:a17:906:8a59:b0:9a9:f2fd:2a2b with SMTP id gx25-20020a1709068a5900b009a9f2fd2a2bmr8307841ejc.73.1694439140429;
        Mon, 11 Sep 2023 06:32:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsgf6p4Ks9RJ0CyHdNFHwf/agtk/OlG1wy0yQq0VL8PLRL7G7I4Yd2SpnVhBysAWsViQ0f9w==
X-Received: by 2002:a17:906:8a59:b0:9a9:f2fd:2a2b with SMTP id gx25-20020a1709068a5900b009a9f2fd2a2bmr8307822ejc.73.1694439140115;
        Mon, 11 Sep 2023 06:32:20 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id d16-20020a17090694d000b00982be08a9besm5419058ejy.172.2023.09.11.06.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 06:32:19 -0700 (PDT)
Message-ID: <01a85a3d-c888-11d8-f47e-be2a26d0cb9d@redhat.com>
Date:   Mon, 11 Sep 2023 15:32:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/8] platform/x86: x86-android-tablets: Stop using gpiolib
 private APIs
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20230909141816.58358-1-hdegoede@redhat.com>
 <20230909141816.58358-7-hdegoede@redhat.com>
 <CAMRc=MfeKirks7N7scu+dh+M1Nf0bNxzC7PE2Q7J4bxgpRnECw@mail.gmail.com>
 <0b1e0312-9144-85ed-666e-a84110b26418@redhat.com>
 <CAMRc=MfVZCqc-v+5oMkTkhfLvq1pE66E7GykqT2ymxzS_kw83w@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAMRc=MfVZCqc-v+5oMkTkhfLvq1pE66E7GykqT2ymxzS_kw83w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/11/23 15:18, Bartosz Golaszewski wrote:
> On Mon, Sep 11, 2023 at 3:08 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 9/11/23 14:50, Bartosz Golaszewski wrote:
>>> On Sat, Sep 9, 2023 at 4:18 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Refactor x86_android_tablet_get_gpiod() to no longer use
>>>> gpiolib private functions like gpiochip_find().
>>>>
>>>> As a bonus this allows specifying that the GPIO is active-low,
>>>> like the /CE (charge enable) pin on the bq25892 charger on
>>>> the Lenovo Yoga Tablet 3.
>>>>
>>>> Reported-by: Bartosz Golaszewski <brgl@bgdev.pl>
>>>> Closes: https://lore.kernel.org/platform-driver-x86/20230905185309.131295-12-brgl@bgdev.pl/
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>>  .../platform/x86/x86-android-tablets/asus.c   |  1 +
>>>>  .../platform/x86/x86-android-tablets/core.c   | 51 +++++++++++--------
>>>>  .../platform/x86/x86-android-tablets/lenovo.c | 28 +++++-----
>>>>  .../platform/x86/x86-android-tablets/other.c  |  6 +++
>>>>  .../x86-android-tablets/x86-android-tablets.h |  6 ++-
>>>>  5 files changed, 55 insertions(+), 37 deletions(-)
>>>>
>>>> diff --git a/drivers/platform/x86/x86-android-tablets/asus.c b/drivers/platform/x86/x86-android-tablets/asus.c
>>>> index f9c4083be86d..227afbb51078 100644
>>>> --- a/drivers/platform/x86/x86-android-tablets/asus.c
>>>> +++ b/drivers/platform/x86/x86-android-tablets/asus.c
>>>> @@ -303,6 +303,7 @@ static const struct x86_i2c_client_info asus_tf103c_i2c_clients[] __initconst =
>>>>                         .index = 28,
>>>>                         .trigger = ACPI_EDGE_SENSITIVE,
>>>>                         .polarity = ACPI_ACTIVE_LOW,
>>>> +                       .con_id = "atmel_mxt_ts_irq",
>>>>                 },
>>>>         },
>>>>  };
>>>> diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
>>>> index 3d3101b2848f..673f3a14941b 100644
>>>> --- a/drivers/platform/x86/x86-android-tablets/core.c
>>>> +++ b/drivers/platform/x86/x86-android-tablets/core.c
>>>> @@ -12,7 +12,7 @@
>>>>
>>>>  #include <linux/acpi.h>
>>>>  #include <linux/dmi.h>
>>>> -#include <linux/gpio/driver.h>
>>>> +#include <linux/gpio/consumer.h>
>>>>  #include <linux/gpio/machine.h>
>>>>  #include <linux/irq.h>
>>>>  #include <linux/module.h>
>>>> @@ -21,35 +21,39 @@
>>>>  #include <linux/string.h>
>>>>
>>>>  #include "x86-android-tablets.h"
>>>> -/* For gpiochip_get_desc() which is EXPORT_SYMBOL_GPL() */
>>>> -#include "../../../gpio/gpiolib.h"
>>>> -#include "../../../gpio/gpiolib-acpi.h"
>>>>
>>>>  static struct platform_device *x86_android_tablet_device;
>>>>
>>>> -static int gpiochip_find_match_label(struct gpio_chip *gc, void *data)
>>>> -{
>>>> -       return gc->label && !strcmp(gc->label, data);
>>>> -}
>>>> -
>>>> -int x86_android_tablet_get_gpiod(const char *label, int pin, struct gpio_desc **desc)
>>>> +int x86_android_tablet_get_gpiod(const char *chip, int pin, const char *con_id,
>>>> +                                bool active_low, enum gpiod_flags dflags,
>>>> +                                struct gpio_desc **desc)
>>>>  {
>>>> +       struct gpiod_lookup_table *lookup;
>>>>         struct gpio_desc *gpiod;
>>>> -       struct gpio_chip *chip;
>>>>
>>>> -       chip = gpiochip_find((void *)label, gpiochip_find_match_label);
>>>> -       if (!chip) {
>>>> -               pr_err("error cannot find GPIO chip %s\n", label);
>>>> -               return -ENODEV;
>>>> -       }
>>>> +       lookup = kzalloc(struct_size(lookup, table, 2), GFP_KERNEL);
>>>> +       if (!lookup)
>>>> +               return -ENOMEM;
>>>> +
>>>> +       lookup->dev_id = KBUILD_MODNAME;
>>>> +       lookup->table[0].key = chip;
>>>> +       lookup->table[0].chip_hwnum = pin;
>>>> +       lookup->table[0].con_id = con_id;
>>>> +       lookup->table[0].flags = active_low ? GPIO_ACTIVE_LOW : GPIO_ACTIVE_HIGH;
>>>> +
>>>> +       gpiod_add_lookup_table(lookup);
>>>> +       gpiod = devm_gpiod_get(&x86_android_tablet_device->dev, con_id, dflags);
>>>> +       gpiod_remove_lookup_table(lookup);
>>>> +       kfree(lookup);
>>>>
>>>
>>> Any reason for not creating static lookup tables for GPIOs here?
>>
>> Not sure what you mean with static?
>>
>> I guess you mean using global or stack memory instead of kmalloc() ?
>>
>> gcc did not like me putting a struct with a variable length array
>> at the end on the stack, so I went with a kzalloc using the
>> struct_size() helper for structs with variable length arrays instead.
>>
>> Note this only runs once at boot, so the small extra cost of
>> the malloc + free is not really a big deal here.
>>
>> I did not try making it global data as that would make the function
>> non re-entrant. Not that it is used in a re-entrant way anywhere,
>> but generally I try to avoid creating code which is not re-entrant.
>>
> 
> I meant static-per-compilation-unit.

I see.

> It doesn't have to be a variable
> length array either. Typically GPIO lookups are static arrays that are
> added once and never removed.

Right.

> The SPI example I posted elsewhere is
> different as it addresses a device quirk and cannot be generalized
> like this. How many GPIOs would you need to describe for this
> use-case? If it's just a few, then I'd go with static lookup tables.
> If it's way more than disregard this comment.

ATM x86_android_tablet_get_gpiod() gets called for 24 GPIOs,
so more the just a few.

Regards,

Hans


