Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3240799DE0
	for <lists+linux-acpi@lfdr.de>; Sun, 10 Sep 2023 13:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346647AbjIJL1l (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 10 Sep 2023 07:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbjIJL1l (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 10 Sep 2023 07:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32202CCA
        for <linux-acpi@vger.kernel.org>; Sun, 10 Sep 2023 04:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694345210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W3PYjqjeq7yM7eSNtgd7nOml/jYAzHDUEZD1jbwxSyA=;
        b=XjIl+spaIn2aUu4fZgsTciTXNdDRSLh4gSmna0VOTETEoFzNPw/hNTb68bah84oaGtx5Gf
        CZPBt9MqoPtAHHmCXYkBXzAQCr9E8WEzqVlxdqGdrxrxVox3QOsWAbdBeOGxEaax3mA49Q
        d+ysIWZeRQrJoswHPhm+lsAzRP7fXKg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-A3puufeqP6uv-gWQQtKfUw-1; Sun, 10 Sep 2023 07:26:49 -0400
X-MC-Unique: A3puufeqP6uv-gWQQtKfUw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b710c5677eso39210961fa.0
        for <linux-acpi@vger.kernel.org>; Sun, 10 Sep 2023 04:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694345207; x=1694950007;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W3PYjqjeq7yM7eSNtgd7nOml/jYAzHDUEZD1jbwxSyA=;
        b=HJ1QIDugZCbKyjGxCrcBKpcNJwNhTHxtFjyP+r81g8ptTbF2HRTKEMi26t/pbjIijR
         fN4uH8SyhIHqb7iVbp6+naoJqJTIskVvT+tfTmNAG+/d/07+qulJuN+p5TnaPJdVsJ/Q
         F9xqmPuAMYFmjhbjC/ihlPnpNoZAlMJTtAhvfOlAZZka8JYfZHOy2JiOP2DSIiqVok8J
         1wpqZTA1Z4oRNWz/s7657qOSjBOK1o6Vm6c9uZMAsWWuCcjj4FUXpo2VFhYK5HCHfo+I
         YUBBzy29gKPqTE1iJcvPq4wbVIY8udoYVsOyxHClX9yEliNa6S7ztuHjFohI7mCbQpDg
         ev5w==
X-Gm-Message-State: AOJu0YzRoweb5N2AaF9zSZzwdrIR1gbh/caZztx30UlwaOqalER1nznw
        koHAe3Zi7VYaWTMtJEa4MryWi7p3uFNLo0+xTM1aKsFQ2dhjKt9CChQt6KTEdh2DCI2mwn1arcp
        tNVvjRdqfVSxeJdz16cmyX+6LfmKFrw==
X-Received: by 2002:a2e:8506:0:b0:2bc:f41a:d9c6 with SMTP id j6-20020a2e8506000000b002bcf41ad9c6mr5491273lji.0.1694345207303;
        Sun, 10 Sep 2023 04:26:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnkeY+10UH5lZFbC3lKJLy0rGcFWZC43Cdj2IGF5GLaD3a5BLkpvMlANk1OI6Fj1fzHPt/Fg==
X-Received: by 2002:a2e:8506:0:b0:2bc:f41a:d9c6 with SMTP id j6-20020a2e8506000000b002bcf41ad9c6mr5491261lji.0.1694345206968;
        Sun, 10 Sep 2023 04:26:46 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id d12-20020a170906344c00b009a5c98fd82asm3641842ejb.81.2023.09.10.04.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 04:26:46 -0700 (PDT)
Message-ID: <afda7862-3c36-98d8-43a3-dd67538de923@redhat.com>
Date:   Sun, 10 Sep 2023 13:26:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/8] platform/x86: x86-android-tablets: Stop using gpiolib
 private APIs
Content-Language: en-US, nl
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20230909141816.58358-1-hdegoede@redhat.com>
 <20230909141816.58358-7-hdegoede@redhat.com>
 <CAHp75Ve888X7xJ0VrQfswaStL8C3SHXjnJV35O2ajZVq6=KfMQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75Ve888X7xJ0VrQfswaStL8C3SHXjnJV35O2ajZVq6=KfMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/10/23 10:24, Andy Shevchenko wrote:
> On Sat, Sep 9, 2023 at 5:18 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Refactor x86_android_tablet_get_gpiod() to no longer use
>> gpiolib private functions like gpiochip_find().
>>
>> As a bonus this allows specifying that the GPIO is active-low,
>> like the /CE (charge enable) pin on the bq25892 charger on
>> the Lenovo Yoga Tablet 3.
> 
> The best patch in the series!
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> See below a couple of questions.
> 
> ...
> 
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
>> -       gpiod = gpiochip_get_desc(chip, pin);
>>         if (IS_ERR(gpiod)) {
>> -               pr_err("error %ld getting GPIO %s %d\n", PTR_ERR(gpiod), label, pin);
>> +               pr_err("error %ld getting GPIO %s %d\n", PTR_ERR(gpiod), chip, pin);
>>                 return PTR_ERR(gpiod);
>>         }
> 
>> -       *desc = gpiod;
>> +       if (desc)
>> +               *desc = gpiod;
> 
> Are we expecting that callers may not want the GPIO descriptor out of
> this function?
> Sounds a bit weird if so.

Yes specifically the Charge-enable and OTG (Vboost enable) pins on the
bq25892 charger on the Lenovo Yoga Tab 3 just need to be set to a fixed
value, so we request the pins with GPIOD_OUT_LOW / _HIGH and then
leave them at that value.

I think similar stuff may come up later, so it seems nice to be able
to not have to pass an otherwise unused gpio_desc pointer.


> 
>>         return 0;
>>  }
> 
> ...
> 
>>          * The bq25890_charger driver controls these through I2C, but this only
>>          * works if not overridden by the pins. Set these pins here:
>> -        * 1. Set /CE to 0 to allow charging.
> 
>> +        * 1. Set /CE to 1 to allow charging.
>>          * 2. Set OTG to 0 disable V5 boost output since the 5V boost output of
>>          *    the main "bq25892_1" charger is used when necessary.
> 
> Shouldn't we use terminology "active"/"non-active" instead of plain 0
> and 1 in the above?

Well the flags are called GPIOD_OUT_HIGH / GPIOD_OUT_LOW and
with gpiod_set_value 0/1 is used. I'm not in favor of adding
"active"/"non-active" into the mix. That just adds a 3th way to
say 0/low or 1/high.

Regards,

Hans




> 
>>          */
> 
> ...
> 
>> -       ret = x86_android_tablet_get_gpiod("INT33FF:02", 22, &gpiod);
>> +       ret = x86_android_tablet_get_gpiod("INT33FF:02", 22, "bq25892_0_ce",
>> +                                          true, GPIOD_OUT_HIGH, NULL);
>>         if (ret < 0)
>>                 return ret;
> 
> Hmm... Maybe better this function to return an error pointer or valid
> pointer, and in the code you choose what to do with that?
> 
> ...
> 
>>         /* OTG pin */
>> -       ret = x86_android_tablet_get_gpiod("INT33FF:03", 19, &gpiod);
>> +       ret = x86_android_tablet_get_gpiod("INT33FF:03", 19, "bq25892_0_otg",
>> +                                          false, GPIOD_OUT_LOW, NULL);
> 
> Ditto.
> 
>>         if (ret < 0)
>>                 return ret;
> 

