Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4019879C071
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 02:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244449AbjIKVTX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Sep 2023 17:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239144AbjIKOM6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Sep 2023 10:12:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A39DCF0
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 07:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694441527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A91u6VkBY8rSmCiAClu6h7dzekaFyYH062J2b3f72D8=;
        b=CrO+IL1H9X3c3DuiqXQ86cxVBFwlSwJWPTp9+cZt+4VSxzCqABnSeGmkaVrt2ADblNLZQ7
        09d9S2jwAlyLrdba77653RQzU0xUpkTPuP7RJPBUCGhvbECOUMl+BhyHxvE0v4kJFlmR9G
        p9LHMmfpsdwW/SYAkgqlAeT4Ne+4pts=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-E3sJwOuINSiwOMh51eCa9A-1; Mon, 11 Sep 2023 10:12:04 -0400
X-MC-Unique: E3sJwOuINSiwOMh51eCa9A-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2bbc1d8011dso51049561fa.1
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 07:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694441522; x=1695046322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A91u6VkBY8rSmCiAClu6h7dzekaFyYH062J2b3f72D8=;
        b=ZT0HdB8rDw/30pCzFAN06fXzjwljZJIZ+D7VRg/tlOOcWCXUsJH4rWG0ZJo7fjqm/5
         h+XQLY9p+Q6LCpWea1C7CAaeUEDk41nLR9Y7rX41ad6LTKEO/loJ3mNMevi07CP2ORVy
         fWsk8XGkxKvl2/wRLwHLA16A4QcPGWRDOyLgi3Fq9mtfs1Lz3sI4k604QCaMRiLnfaKP
         QA2rzKQXOJ5MJA+IJH9PDGCgJD6RwBvvQMuF+gMlZwTNvk71Th9NzDLD7oabtxhUQ17f
         1qAPyrbB9+cWrDCwVdPQRyyZFhDLakv52+YpudQ7VIKON27JB4xDt4eoR3CuR8JHSGTX
         FWBg==
X-Gm-Message-State: AOJu0Yz1Fi1lGt84hm0FBTXYKVklj3zOzsmD3JnagAImmhqJeNRlSkoi
        jmQgn8Pcbcwbwr6dcsSxz+TKcC3+2BJYG0VFL5rKANXvZaVT+kcY1kuhTnslAq0bepBwac1IP2G
        DLc0eYqjwwQIIeCGBokiJYg==
X-Received: by 2002:a05:6512:555:b0:4ff:9efd:8a9c with SMTP id h21-20020a056512055500b004ff9efd8a9cmr7336267lfl.5.1694441522635;
        Mon, 11 Sep 2023 07:12:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8MVztv7slrYQUdZEMnp7uHwmJkTtvnGxUWy2kKF5/04fqALEBj6t2sXZsXS5HZdQ+XgBi0w==
X-Received: by 2002:a05:6512:555:b0:4ff:9efd:8a9c with SMTP id h21-20020a056512055500b004ff9efd8a9cmr7336234lfl.5.1694441522191;
        Mon, 11 Sep 2023 07:12:02 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id c12-20020aa7c74c000000b0052e2472f884sm4688504eds.21.2023.09.11.07.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 07:12:01 -0700 (PDT)
Message-ID: <22698b72-b293-9ad8-908f-f6aee85430d7@redhat.com>
Date:   Mon, 11 Sep 2023 16:12:00 +0200
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
 <01a85a3d-c888-11d8-f47e-be2a26d0cb9d@redhat.com>
 <CAMRc=MeGRreVVz=tCnEWtvixV+ZNEXXvG5SVRRmmnWG_sawMcg@mail.gmail.com>
 <bf866db7-1231-2fd6-eedf-b287ca4fa1b8@redhat.com>
 <CAMRc=MdXLBnjFPE8Ac9tFQj6BXEyV6kRyDFNytsdQa++Yk6suw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAMRc=MdXLBnjFPE8Ac9tFQj6BXEyV6kRyDFNytsdQa++Yk6suw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/11/23 16:04, Bartosz Golaszewski wrote:
> On Mon, Sep 11, 2023 at 3:53 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Bart,
>>
>> On 9/11/23 15:37, Bartosz Golaszewski wrote:
>>> On Mon, Sep 11, 2023 at 3:32 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 9/11/23 15:18, Bartosz Golaszewski wrote:
>>>>> On Mon, Sep 11, 2023 at 3:08 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On 9/11/23 14:50, Bartosz Golaszewski wrote:
>>>>>>> On Sat, Sep 9, 2023 at 4:18 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>>>>
>>>>>>>> Refactor x86_android_tablet_get_gpiod() to no longer use
>>>>>>>> gpiolib private functions like gpiochip_find().
>>>>>>>>
>>>>>>>> As a bonus this allows specifying that the GPIO is active-low,
>>>>>>>> like the /CE (charge enable) pin on the bq25892 charger on
>>>>>>>> the Lenovo Yoga Tablet 3.
>>>>>>>>
>>>>>>>> Reported-by: Bartosz Golaszewski <brgl@bgdev.pl>
>>>>>>>> Closes: https://lore.kernel.org/platform-driver-x86/20230905185309.131295-12-brgl@bgdev.pl/
>>>>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>>>>> ---
>>>>>>>>  .../platform/x86/x86-android-tablets/asus.c   |  1 +
>>>>>>>>  .../platform/x86/x86-android-tablets/core.c   | 51 +++++++++++--------
>>>>>>>>  .../platform/x86/x86-android-tablets/lenovo.c | 28 +++++-----
>>>>>>>>  .../platform/x86/x86-android-tablets/other.c  |  6 +++
>>>>>>>>  .../x86-android-tablets/x86-android-tablets.h |  6 ++-
>>>>>>>>  5 files changed, 55 insertions(+), 37 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/platform/x86/x86-android-tablets/asus.c b/drivers/platform/x86/x86-android-tablets/asus.c
>>>>>>>> index f9c4083be86d..227afbb51078 100644
>>>>>>>> --- a/drivers/platform/x86/x86-android-tablets/asus.c
>>>>>>>> +++ b/drivers/platform/x86/x86-android-tablets/asus.c
>>>>>>>> @@ -303,6 +303,7 @@ static const struct x86_i2c_client_info asus_tf103c_i2c_clients[] __initconst =
>>>>>>>>                         .index = 28,
>>>>>>>>                         .trigger = ACPI_EDGE_SENSITIVE,
>>>>>>>>                         .polarity = ACPI_ACTIVE_LOW,
>>>>>>>> +                       .con_id = "atmel_mxt_ts_irq",
>>>>>>>>                 },
>>>>>>>>         },
>>>>>>>>  };
>>>>>>>> diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
>>>>>>>> index 3d3101b2848f..673f3a14941b 100644
>>>>>>>> --- a/drivers/platform/x86/x86-android-tablets/core.c
>>>>>>>> +++ b/drivers/platform/x86/x86-android-tablets/core.c
>>>>>>>> @@ -12,7 +12,7 @@
>>>>>>>>
>>>>>>>>  #include <linux/acpi.h>
>>>>>>>>  #include <linux/dmi.h>
>>>>>>>> -#include <linux/gpio/driver.h>
>>>>>>>> +#include <linux/gpio/consumer.h>
>>>>>>>>  #include <linux/gpio/machine.h>
>>>>>>>>  #include <linux/irq.h>
>>>>>>>>  #include <linux/module.h>
>>>>>>>> @@ -21,35 +21,39 @@
>>>>>>>>  #include <linux/string.h>
>>>>>>>>
>>>>>>>>  #include "x86-android-tablets.h"
>>>>>>>> -/* For gpiochip_get_desc() which is EXPORT_SYMBOL_GPL() */
>>>>>>>> -#include "../../../gpio/gpiolib.h"
>>>>>>>> -#include "../../../gpio/gpiolib-acpi.h"
>>>>>>>>
>>>>>>>>  static struct platform_device *x86_android_tablet_device;
>>>>>>>>
>>>>>>>> -static int gpiochip_find_match_label(struct gpio_chip *gc, void *data)
>>>>>>>> -{
>>>>>>>> -       return gc->label && !strcmp(gc->label, data);
>>>>>>>> -}
>>>>>>>> -
>>>>>>>> -int x86_android_tablet_get_gpiod(const char *label, int pin, struct gpio_desc **desc)
>>>>>>>> +int x86_android_tablet_get_gpiod(const char *chip, int pin, const char *con_id,
>>>>>>>> +                                bool active_low, enum gpiod_flags dflags,
>>>>>>>> +                                struct gpio_desc **desc)
>>>>>>>>  {
>>>>>>>> +       struct gpiod_lookup_table *lookup;
>>>>>>>>         struct gpio_desc *gpiod;
>>>>>>>> -       struct gpio_chip *chip;
>>>>>>>>
>>>>>>>> -       chip = gpiochip_find((void *)label, gpiochip_find_match_label);
>>>>>>>> -       if (!chip) {
>>>>>>>> -               pr_err("error cannot find GPIO chip %s\n", label);
>>>>>>>> -               return -ENODEV;
>>>>>>>> -       }
>>>>>>>> +       lookup = kzalloc(struct_size(lookup, table, 2), GFP_KERNEL);
>>>>>>>> +       if (!lookup)
>>>>>>>> +               return -ENOMEM;
>>>>>>>> +
>>>>>>>> +       lookup->dev_id = KBUILD_MODNAME;
>>>>>>>> +       lookup->table[0].key = chip;
>>>>>>>> +       lookup->table[0].chip_hwnum = pin;
>>>>>>>> +       lookup->table[0].con_id = con_id;
>>>>>>>> +       lookup->table[0].flags = active_low ? GPIO_ACTIVE_LOW : GPIO_ACTIVE_HIGH;
>>>>>>>> +
>>>>>>>> +       gpiod_add_lookup_table(lookup);
>>>>>>>> +       gpiod = devm_gpiod_get(&x86_android_tablet_device->dev, con_id, dflags);
>>>>>>>> +       gpiod_remove_lookup_table(lookup);
>>>>>>>> +       kfree(lookup);
>>>>>>>>
>>>>>>>
>>>>>>> Any reason for not creating static lookup tables for GPIOs here?
>>>>>>
>>>>>> Not sure what you mean with static?
>>>>>>
>>>>>> I guess you mean using global or stack memory instead of kmalloc() ?
>>>>>>
>>>>>> gcc did not like me putting a struct with a variable length array
>>>>>> at the end on the stack, so I went with a kzalloc using the
>>>>>> struct_size() helper for structs with variable length arrays instead.
>>>>>>
>>>>>> Note this only runs once at boot, so the small extra cost of
>>>>>> the malloc + free is not really a big deal here.
>>>>>>
>>>>>> I did not try making it global data as that would make the function
>>>>>> non re-entrant. Not that it is used in a re-entrant way anywhere,
>>>>>> but generally I try to avoid creating code which is not re-entrant.
>>>>>>
>>>>>
>>>>> I meant static-per-compilation-unit.
>>>>
>>>> I see.
>>>>
>>>>> It doesn't have to be a variable
>>>>> length array either. Typically GPIO lookups are static arrays that are
>>>>> added once and never removed.
>>>>
>>>> Right.
>>>>
>>>>> The SPI example I posted elsewhere is
>>>>> different as it addresses a device quirk and cannot be generalized
>>>>> like this. How many GPIOs would you need to describe for this
>>>>> use-case? If it's just a few, then I'd go with static lookup tables.
>>>>> If it's way more than disregard this comment.
>>>>
>>>> ATM x86_android_tablet_get_gpiod() gets called for 24 GPIOs,
>>>> so more the just a few.
>>>
>>> For different devices? As in: dev_id would differ? If not then I'd go
>>> with a static table, you can use GPIO_LOOKUP() macro and have one line
>>> per GPIO.
>>
>> I know GPIO_LOOKUP() is already used for normal GPIO lookup cases
>> like e.g. a reset pin where the gpiod_get() is done by the i2c_driver
>> for the i2c_client.
>>
>>> If there are more devices, then I agree - let's keep dynamic
>>> allocation.
>>
>> These are used to lookup GPIOs which the code needs access to *before*
>> instantiating the actual device consuming the GPIO.
>>
>> Specifically these GPIOS either become i2c_board_info.irq which is
>> passed to i2c_client_new() to instantiate i2c_client-s; or
>> desc_to_gpio() is called on them for old fashioned platform-data
>> which still uses old style GPIO numbers (gpio_keys platform data).
>>
>> Needing these GPIOs before instantiating their actual consumer
>> devices is the whole reason why the code used to call gpiolib
>> private APIs in the first place.
>>
>> Note since the consuming device is not instantiated yet there really
>> is no dev_id. Instead the newly added x86_android_tablets
>> platform_device gets used as dev_id so that the code has a device
>> to do the lookups on to remove the gpiolib private API use.
>>
>> This trick with using the x86_android_tablets pdev is why the whole
>> lookup is done dynamically.
>>
>>> Just please: add a comment why you're doing it this way so that people
>>> don't just copy and paste it elsewhere.
>>
>> Ok, I can do a follow-up patch adding a comment above
>> x86_android_tablet_get_gpiod() explaining that it should only
>> be used for GPIOs which are needed before their consumer
>> device has been instantiated.
>>
> 
> I'd just fold it into the existing patch but do as you prefer.

After your Acked-by for the first 2 patches this morning I assumed
you were fine with the entire set, so I've already created a signed tag
for it.

Therefor I don't want to / cannot change the hashes of the commits,
so a follow-up patch it is.

I'll prep a patch adding the comment tomorrow.

Note the original signed-tag + pull-req is still fine for coordination
between the pdx86 code and the GPIO tree. Please let me know if you want
an updated pull-req which includes the follow-up patch adding the comment.

Regards,

Hans

