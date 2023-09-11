Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE4179B049
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 01:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238795AbjIKVTa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Sep 2023 17:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237686AbjIKNIz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Sep 2023 09:08:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0ACDE6
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 06:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694437682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UbMds+5lzjL/Ue2qSrRd4FXnj9bvG2pM9g941GZzOeA=;
        b=fu8rC2X6pg3dZDqBOxaFjmxEwX6i8v6jbfV6NuAhvwXoTZmcNOE2Dg+ONhHyix4tWR+4u9
        gxXgbstgdKdF7nBBwu4Ca5fnIrhNrWlrXHvhNFmmJ/UZi9e4Z4jVS4LZgSAHCk2lcXwSjd
        ghA/vlDbr5HuSrv1/0y1Ka0y/b5RdEg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-rULcod2gORK7_CWBzdXX7Q-1; Mon, 11 Sep 2023 09:08:00 -0400
X-MC-Unique: rULcod2gORK7_CWBzdXX7Q-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50091a3fd87so4707936e87.2
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 06:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694437679; x=1695042479;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UbMds+5lzjL/Ue2qSrRd4FXnj9bvG2pM9g941GZzOeA=;
        b=T4P/4UZ6DTTVLj2zkXiZUcMLhDZPmcVUDEeerpI4I0FW7toAPdKxh6fVomJSCeRYpm
         J3K/+609VJXZWqzDmLpRs+m8vwNTjoRU+/3iFFfv4GL84duB9+PZHF/tx/e5hqEojzmc
         beAzxeeP/XzYFvGNzDB9XX6DOmiw9Hmm3WvQvs4hLnGaYw/1D+IyKFJ2fKyNRE3aGa7e
         +HzlIfpZg01Mr4YRVvTSowS17YBo7IGgs+R4O3Q3kRqiTY3q0SF4k1ocdmuJNOFr0pQC
         y2Qi9gdo5ClLs9l912VJCR0cFjGdlEBNIScVxSKTxSydHl5yCnVdItaUdqma3s9V4Y0m
         MIEg==
X-Gm-Message-State: AOJu0Yw4juJ4qq24LFJIbAlJ60tePvAwXlWphtm6sVKlDwaZe0Bpgxf6
        TdGtaQmfue82MpOiu2x7UkXEkluW6R7rD5UUQMK+BgXj85OD+EedJWz/F2lDnM8smfRdKmsCHed
        yWFQ5yYYm5j4zzsQpNmB9cg==
X-Received: by 2002:a05:6512:3602:b0:502:9fce:b6da with SMTP id f2-20020a056512360200b005029fceb6damr6086155lfs.21.1694437678915;
        Mon, 11 Sep 2023 06:07:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+n8pYGwuCVSaxiJuH557qRvJDQVa5pqopYogmdd0mnu1QYbL9nqZmcnJOVSyusFnaVtsBvQ==
X-Received: by 2002:a05:6512:3602:b0:502:9fce:b6da with SMTP id f2-20020a056512360200b005029fceb6damr6086134lfs.21.1694437678516;
        Mon, 11 Sep 2023 06:07:58 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id oy26-20020a170907105a00b0099d45ed589csm5315860ejb.125.2023.09.11.06.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 06:07:57 -0700 (PDT)
Message-ID: <0b1e0312-9144-85ed-666e-a84110b26418@redhat.com>
Date:   Mon, 11 Sep 2023 15:07:57 +0200
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
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAMRc=MfeKirks7N7scu+dh+M1Nf0bNxzC7PE2Q7J4bxgpRnECw@mail.gmail.com>
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

On 9/11/23 14:50, Bartosz Golaszewski wrote:
> On Sat, Sep 9, 2023 at 4:18 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Refactor x86_android_tablet_get_gpiod() to no longer use
>> gpiolib private functions like gpiochip_find().
>>
>> As a bonus this allows specifying that the GPIO is active-low,
>> like the /CE (charge enable) pin on the bq25892 charger on
>> the Lenovo Yoga Tablet 3.
>>
>> Reported-by: Bartosz Golaszewski <brgl@bgdev.pl>
>> Closes: https://lore.kernel.org/platform-driver-x86/20230905185309.131295-12-brgl@bgdev.pl/
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  .../platform/x86/x86-android-tablets/asus.c   |  1 +
>>  .../platform/x86/x86-android-tablets/core.c   | 51 +++++++++++--------
>>  .../platform/x86/x86-android-tablets/lenovo.c | 28 +++++-----
>>  .../platform/x86/x86-android-tablets/other.c  |  6 +++
>>  .../x86-android-tablets/x86-android-tablets.h |  6 ++-
>>  5 files changed, 55 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/platform/x86/x86-android-tablets/asus.c b/drivers/platform/x86/x86-android-tablets/asus.c
>> index f9c4083be86d..227afbb51078 100644
>> --- a/drivers/platform/x86/x86-android-tablets/asus.c
>> +++ b/drivers/platform/x86/x86-android-tablets/asus.c
>> @@ -303,6 +303,7 @@ static const struct x86_i2c_client_info asus_tf103c_i2c_clients[] __initconst =
>>                         .index = 28,
>>                         .trigger = ACPI_EDGE_SENSITIVE,
>>                         .polarity = ACPI_ACTIVE_LOW,
>> +                       .con_id = "atmel_mxt_ts_irq",
>>                 },
>>         },
>>  };
>> diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
>> index 3d3101b2848f..673f3a14941b 100644
>> --- a/drivers/platform/x86/x86-android-tablets/core.c
>> +++ b/drivers/platform/x86/x86-android-tablets/core.c
>> @@ -12,7 +12,7 @@
>>
>>  #include <linux/acpi.h>
>>  #include <linux/dmi.h>
>> -#include <linux/gpio/driver.h>
>> +#include <linux/gpio/consumer.h>
>>  #include <linux/gpio/machine.h>
>>  #include <linux/irq.h>
>>  #include <linux/module.h>
>> @@ -21,35 +21,39 @@
>>  #include <linux/string.h>
>>
>>  #include "x86-android-tablets.h"
>> -/* For gpiochip_get_desc() which is EXPORT_SYMBOL_GPL() */
>> -#include "../../../gpio/gpiolib.h"
>> -#include "../../../gpio/gpiolib-acpi.h"
>>
>>  static struct platform_device *x86_android_tablet_device;
>>
>> -static int gpiochip_find_match_label(struct gpio_chip *gc, void *data)
>> -{
>> -       return gc->label && !strcmp(gc->label, data);
>> -}
>> -
>> -int x86_android_tablet_get_gpiod(const char *label, int pin, struct gpio_desc **desc)
>> +int x86_android_tablet_get_gpiod(const char *chip, int pin, const char *con_id,
>> +                                bool active_low, enum gpiod_flags dflags,
>> +                                struct gpio_desc **desc)
>>  {
>> +       struct gpiod_lookup_table *lookup;
>>         struct gpio_desc *gpiod;
>> -       struct gpio_chip *chip;
>>
>> -       chip = gpiochip_find((void *)label, gpiochip_find_match_label);
>> -       if (!chip) {
>> -               pr_err("error cannot find GPIO chip %s\n", label);
>> -               return -ENODEV;
>> -       }
>> +       lookup = kzalloc(struct_size(lookup, table, 2), GFP_KERNEL);
>> +       if (!lookup)
>> +               return -ENOMEM;
>> +
>> +       lookup->dev_id = KBUILD_MODNAME;
>> +       lookup->table[0].key = chip;
>> +       lookup->table[0].chip_hwnum = pin;
>> +       lookup->table[0].con_id = con_id;
>> +       lookup->table[0].flags = active_low ? GPIO_ACTIVE_LOW : GPIO_ACTIVE_HIGH;
>> +
>> +       gpiod_add_lookup_table(lookup);
>> +       gpiod = devm_gpiod_get(&x86_android_tablet_device->dev, con_id, dflags);
>> +       gpiod_remove_lookup_table(lookup);
>> +       kfree(lookup);
>>
> 
> Any reason for not creating static lookup tables for GPIOs here?

Not sure what you mean with static?

I guess you mean using global or stack memory instead of kmalloc() ?

gcc did not like me putting a struct with a variable length array
at the end on the stack, so I went with a kzalloc using the
struct_size() helper for structs with variable length arrays instead.

Note this only runs once at boot, so the small extra cost of
the malloc + free is not really a big deal here.

I did not try making it global data as that would make the function
non re-entrant. Not that it is used in a re-entrant way anywhere,
but generally I try to avoid creating code which is not re-entrant.

Regards,

Hans




>> -       gpiod = gpiochip_get_desc(chip, pin);
>>         if (IS_ERR(gpiod)) {
>> -               pr_err("error %ld getting GPIO %s %d\n", PTR_ERR(gpiod), label, pin);
>> +               pr_err("error %ld getting GPIO %s %d\n", PTR_ERR(gpiod), chip, pin);
>>                 return PTR_ERR(gpiod);
>>         }
>>
> 

