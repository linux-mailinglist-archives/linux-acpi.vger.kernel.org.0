Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DB079B0FA
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 01:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237564AbjIKVSv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Sep 2023 17:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237604AbjIKNAY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Sep 2023 09:00:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91F62CF0
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 05:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694437173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fLJlaWuhDVThUjdsKNhZE9FBGgOcB1eXtorgqabDS60=;
        b=FWQn6fEwQfeAaNFHi2rT9xRjSh9ZDp2lej0d9bxWGIMhvvpOTigqI367rOj3HhfF3lrUhI
        rEjqZU34sK8IFtQQVFXU2SSqsxiGBya2GpvDcANokgU27ykk1seRrw0CTE5UzHzotZtPVf
        Xwu5xaRcLvKtI2m2YVSjRBb9yeKwuV0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-tReJRIRaNkeTi3wAvORuAQ-1; Mon, 11 Sep 2023 08:59:32 -0400
X-MC-Unique: tReJRIRaNkeTi3wAvORuAQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99c8bbc902eso305375866b.1
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 05:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694437170; x=1695041970;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLJlaWuhDVThUjdsKNhZE9FBGgOcB1eXtorgqabDS60=;
        b=ahq8LcjtZyllXM0oP6U16662BglS6BGtsA8Yl9lfM5m3pXdCCcLhL6e6ZNjFTupW7/
         Fsg62fxGwfAng5gnVADYY1R9tVowDKCzZ2XjAxHKkSr64g7Luyemha73TBYrCUg8ah9s
         pzQNtw4t/fTdqVuDizNyXhyEMoetirKVIQaC75cQG/wgTR+KYlV7qXPL8nyPFPm5BkS0
         du00w1o+ZEETR4SlzaXN/dJHJAnRbtrAIcS1QHjxCYIADMdYPcRNQWRWM1EjW52kM3A9
         NG27jnndTL4aHy7DamdGVT9KESepC0r0mB5+Qc492hVx84ZzjdIzqS46XzXZa9ecN6tx
         +H8A==
X-Gm-Message-State: AOJu0Yw/Z2B0NEgELbMxCvOvUwb18g6uHP4E7EwlALNmxosZLwprICTm
        5bJVr+IA53ZdZk8xFWc0jWGzr41gOCCyDqKb5BAXPydtmBvtgNwz23Ip+ZYtYPVGg8uNi9lHOUy
        RKh4ntfnIQd9nkXJ/5y3FSfFsCKOvnA==
X-Received: by 2002:a17:906:25b:b0:9aa:2b9:4559 with SMTP id 27-20020a170906025b00b009aa02b94559mr6847609ejl.41.1694437170406;
        Mon, 11 Sep 2023 05:59:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAJ3vBN5EImzM8ykAMY9iqMcBiknS3+lG2SPtItZjJ2lKtiLerDWHYPfQZO2GMQ7Iet+Je7Q==
X-Received: by 2002:a17:906:25b:b0:9aa:2b9:4559 with SMTP id 27-20020a170906025b00b009aa02b94559mr6847598ejl.41.1694437170031;
        Mon, 11 Sep 2023 05:59:30 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id op5-20020a170906bce500b0098de7d28c34sm5359593ejb.193.2023.09.11.05.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 05:59:29 -0700 (PDT)
Message-ID: <7c02ca96-9da0-6881-aa25-7863627baa14@redhat.com>
Date:   Mon, 11 Sep 2023 14:59:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/8] platform/x86: x86-android-tablets: Stop using gpiolib
 private APIs
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20230909141816.58358-1-hdegoede@redhat.com>
 <20230909141816.58358-7-hdegoede@redhat.com>
 <CAHp75Ve888X7xJ0VrQfswaStL8C3SHXjnJV35O2ajZVq6=KfMQ@mail.gmail.com>
 <afda7862-3c36-98d8-43a3-dd67538de923@redhat.com>
 <CAMRc=MdmzPWeZ7CtFe2b6xZFAges2cD-ckq4vn-+52CG=tVRSA@mail.gmail.com>
 <ZP8OiuhvgLxAzmVE@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZP8OiuhvgLxAzmVE@smile.fi.intel.com>
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

On 9/11/23 14:56, Andy Shevchenko wrote:
> On Mon, Sep 11, 2023 at 02:49:44PM +0200, Bartosz Golaszewski wrote:
>> On Sun, Sep 10, 2023 at 1:26 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>> On 9/10/23 10:24, Andy Shevchenko wrote:
>>>> On Sat, Sep 9, 2023 at 5:18 PM Hans de Goede <hdegoede@redhat.com> wrote:
> 
> ...
> 
>>>>> +       gpiod = devm_gpiod_get(&x86_android_tablet_device->dev, con_id, dflags);
> 
> ^^^
> 
>>>>> -       *desc = gpiod;
>>>>> +       if (desc)
>>>>> +               *desc = gpiod;
>>>>
>>>> Are we expecting that callers may not want the GPIO descriptor out of
>>>> this function?
>>>> Sounds a bit weird if so.
>>>
>>> Yes specifically the Charge-enable and OTG (Vboost enable) pins on the
>>> bq25892 charger on the Lenovo Yoga Tab 3 just need to be set to a fixed
>>> value, so we request the pins with GPIOD_OUT_LOW / _HIGH and then
>>> leave them at that value.
>>
>> You mean you leak the descriptor? It would warrant either a comment or
>> storing the descriptor somewhere and cleaning it up if the device can
>> be unbound (I guess it can since the driver can be built as module).
> 
> Note devm_*() above.

Right, the GPIOs will be free-ed on unbound through the devm framework.

Regards,

Hans

