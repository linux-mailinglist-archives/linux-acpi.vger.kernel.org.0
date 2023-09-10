Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1A3799DDC
	for <lists+linux-acpi@lfdr.de>; Sun, 10 Sep 2023 13:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346645AbjIJLU5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 10 Sep 2023 07:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346644AbjIJLU4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 10 Sep 2023 07:20:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D080CD3
        for <linux-acpi@vger.kernel.org>; Sun, 10 Sep 2023 04:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694344803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YZmzTAu+YkENFgAcTjcm87NSv+hGmQ7BjJdcULk7tNM=;
        b=JZ2pVL2YZZHaJiwKo49+WlHquOlaHaj0+8LHqNO1M1KCjeuoxeDNuY0XQ57tj3yGqZa3YT
        Z6WmYJRJlsdY9wh5nocUO3OV/qd+A+l0H0ZxaD2urRPttPb+HF0CMje41aWzdWiUjjsLRN
        mlduFc7yFZq8KamNzrO4qJxudNEfvog=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637--8X9fagyNIWPrypngAwP-w-1; Sun, 10 Sep 2023 07:20:02 -0400
X-MC-Unique: -8X9fagyNIWPrypngAwP-w-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a681c3470fso220803766b.1
        for <linux-acpi@vger.kernel.org>; Sun, 10 Sep 2023 04:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694344801; x=1694949601;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZmzTAu+YkENFgAcTjcm87NSv+hGmQ7BjJdcULk7tNM=;
        b=DFNFmUm9DuhfgKBH4TwmLI/F4X4nTWITdOIW7jE14IlRg0SLqrqM0sgcjrt7gAxvN7
         BX2s7FeFC/17L/HNWe657LtIp5vKDRAlR6FyOrSm/J0+xwGHMY2wmoeylyXNX5zCwNBD
         48c6o7ccJYdo0kaEhNmJcjcbEedQqLftRJ91L+wxwPqY0RolIDD3nEVuR9BpaCkTaTrJ
         5KQvqH/znP8wyDmkHOIvhSZr2P+22IPtL9XzcDze5NVeNFXExuLg1uq/1aDN9nx21J6H
         v5dM1MxZRbd0zxd/iCzkeh78BWcqH62IaPtMIMu9gU//fyrCqQhDLVGlkCYk6Ss0QzHF
         WY5A==
X-Gm-Message-State: AOJu0YxI4jvdkTg7dNi9YvQntXdUeQJlY5KLepoqQDgs9tU9lV9dAtyp
        fGXFU1QNK9GBAD+mKkKXYcbOkALuBkppNYvXFEAxZuPOQsOUbkoqj/mfev2qNaIV5H4GpxfmWYo
        YTpkRP23R5mW5I/1bS0OzNw==
X-Received: by 2002:a17:907:78d1:b0:9a1:f96c:4bb2 with SMTP id kv17-20020a17090778d100b009a1f96c4bb2mr6076896ejc.50.1694344801429;
        Sun, 10 Sep 2023 04:20:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwDIhGpbjzKE9Z6a032W/6kyY7c75m+YxJtY/cerZXgwxqR69KfBVG8LSnWvtTcpsAoqP7Vg==
X-Received: by 2002:a17:907:78d1:b0:9a1:f96c:4bb2 with SMTP id kv17-20020a17090778d100b009a1f96c4bb2mr6076885ejc.50.1694344801083;
        Sun, 10 Sep 2023 04:20:01 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id c4-20020a170906340400b00991d54db2acsm3657806ejb.44.2023.09.10.04.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 04:19:59 -0700 (PDT)
Message-ID: <32206240-a06a-2c4f-c520-4243ad9ddca5@redhat.com>
Date:   Sun, 10 Sep 2023 13:19:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/8] platform/x86: x86-android-tablets: Create a
 platform_device from module_init()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20230909141816.58358-1-hdegoede@redhat.com>
 <20230909141816.58358-6-hdegoede@redhat.com>
 <CAHp75Vf0HC-PUZWLniUPZSYVbeVW33sT9yOQxgeftXi+GmQppw@mail.gmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75Vf0HC-PUZWLniUPZSYVbeVW33sT9yOQxgeftXi+GmQppw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/10/23 10:07, Andy Shevchenko wrote:
> On Sat, Sep 9, 2023 at 5:18 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Create a platform_device from module_init() and change
>> x86_android_tablet_init() / cleanup() into platform_device
>> probe() and remove() functions.
>>
>> This is a preparation patch for refactoring x86_android_tablet_get_gpiod()
>> to no longer use gpiolib private functions like gpiochip_find().
> 
> ...
> 
>> +static int __init x86_android_tablet_init(void)
>> +{
> 
>> +       if (!dmi_first_match(x86_android_tablet_ids)) {
> 
> Why do we need this? Module alias is based on DMI matching, is it
> against manual loading?

Yes I added this to protect against manual loading.

> 
>> +               pr_err("error loaded on unknown tablet model\n");
>> +               return -ENODEV;
>> +       }
>> +
>> +       x86_android_tablet_device = platform_create_bundle(&x86_android_tablet_driver,
>> +                                                  x86_android_tablet_probe,
>> +                                                  NULL, 0, NULL, 0);
> 
> So, in case of manual loading, would it be harmful for non-listed platforms?

No this will not be harmful, x86_android_tablet_probe() also
checks the DMI table and it will return -ENODEV when there is
no match.

So we just end up with an unused x86_android_tablets platform-device
and otherwise no harm is done.

I guess my main reason here is to not change manual loading
behavior, before the entire insmod would fail since
module_init() would return -ENODEV, this preserves this
behavior.

But you are right that this check can be dropped without
any bad side-effects.

I'll drop the check before merging this.

> 
>> +       return PTR_ERR_OR_ZERO(x86_android_tablet_device);
>> +}
>> +
>> +static void __exit x86_android_tablet_exit(void)
>> +{
>> +       platform_device_unregister(x86_android_tablet_device);
>> +       platform_driver_unregister(&x86_android_tablet_driver);
>> +}
> 
>> +
> 
> Instead of adding this blank line you can move
> module_init()/module_exit() closer to the respective callbacks.

Ack, I'll fix this before merging this.

Regards,

Hans



> 
>>  module_init(x86_android_tablet_init);
>> -module_exit(x86_android_tablet_cleanup);
>> +module_exit(x86_android_tablet_exit);
> 

