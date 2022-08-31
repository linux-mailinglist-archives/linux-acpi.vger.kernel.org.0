Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CDD5A810C
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Aug 2022 17:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbiHaPTK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 31 Aug 2022 11:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbiHaPTI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Aug 2022 11:19:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933F4D86FE
        for <linux-acpi@vger.kernel.org>; Wed, 31 Aug 2022 08:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661959144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Ujg0LqL4Zf7QSMNntgyL7zhBHA2KE0VEhGl9dm9Aa8=;
        b=e8G3+XfObMLlbixQE9WG7buL5K5FL+tdzU029ovwh0vSDsh4IBoOQBNhdg5g0u2lwLg88a
        kyoI6Oj4WlxK5XxdlxrOA3QY5PNUvmNxM8+4+ZpdVlzGCfXywAf3GijAk3yHAH22HT1q4s
        lHTh0a2BmzpIk3y1XjmdDmG5orHx6kA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-48-aye9l33fNzSZkTGliWiIhw-1; Wed, 31 Aug 2022 11:19:02 -0400
X-MC-Unique: aye9l33fNzSZkTGliWiIhw-1
Received: by mail-ej1-f70.google.com with SMTP id sh44-20020a1709076eac00b00741a01e2aafso4211493ejc.22
        for <linux-acpi@vger.kernel.org>; Wed, 31 Aug 2022 08:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=4Ujg0LqL4Zf7QSMNntgyL7zhBHA2KE0VEhGl9dm9Aa8=;
        b=N/pJx9urMSjdDAjYBW5zmeGetPQeCGv2WuDzq7sKQVegddd01CHnhmtjlWTz4i9iVo
         15FpXqpUJhq4vYdNXogjxPQ+to8tawEaRlyeiFryTIEBINWyyyT3XADa0jVk0IrRui/Z
         IWBf3j4XjRvgti3bSJ8qG3Z6ElvSELRqWzN4Xl4HXzCrSuYKnP0OTXwI3DGwM2/rCPFO
         WYhS088BOIlIkdRyqYEQxyrqSJPuiqhAeGlA33jwP5CeY4t4H5kzjPmfWP5gjj2alucW
         oiwWuq+Rju0ak1/b+4qYz19nPkj6wxqE4VY0JEO2MPuQKkAo4BbMKLIgsX6C57g32l3H
         fMwA==
X-Gm-Message-State: ACgBeo1ETePfD5YoIvU2036pt2UmLsutyYZ87K9BkcuaR6ypToCgdSxb
        XuaqJqPKKgQN/u/dvk37oFwPeWYH9vFrQwqKEx3O8ArxOIiUQCveA0MejJiyIFg44O+p8/6uQ2S
        8UQWFnU13SPtCFXoMsbkOaw==
X-Received: by 2002:a05:6402:1013:b0:448:dc53:752e with SMTP id c19-20020a056402101300b00448dc53752emr6030293edu.30.1661959141258;
        Wed, 31 Aug 2022 08:19:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6FlKsO4zgVlNGD3cI2hGVtIC9Q8ir2eq28ILAW4L6wdIHEW/bWr5ocfIhSZ2PI7kbJ+ZZKOA==
X-Received: by 2002:a05:6402:1013:b0:448:dc53:752e with SMTP id c19-20020a056402101300b00448dc53752emr6030275edu.30.1661959140988;
        Wed, 31 Aug 2022 08:19:00 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id u16-20020a170906125000b0073d6093ac93sm7359153eja.16.2022.08.31.08.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 08:19:00 -0700 (PDT)
Message-ID: <8aa159a1-f7e0-e54a-6a03-b76c563c62a6@redhat.com>
Date:   Wed, 31 Aug 2022 17:18:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/8] acpi: i2c: Use SharedAndWake and ExclusiveAndWake to
 enable wake irq
Content-Language: en-US
To:     Raul Rangel <rrangel@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        Tim Van Patten <timvp@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alistair Francis <alistair@alistair23.me>,
        Angela Czubak <acz@semihalf.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, Len Brown <lenb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Yang Li <yang.lee@linux.alibaba.com>,
        "jingle.wu" <jingle.wu@emc.com.tw>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20220830231541.1135813-1-rrangel@chromium.org>
 <Yw9LdxWQMpnzgFe/@smile.fi.intel.com>
 <CAHQZ30BemtpHiZHOh+Wvh3N9wz5SSD9VdoQHNbArKhZUmudkwQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHQZ30BemtpHiZHOh+Wvh3N9wz5SSD9VdoQHNbArKhZUmudkwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 8/31/22 16:37, Raul Rangel wrote:
> Interesting... The patch series is here:
> https://patchwork.kernel.org/project/linux-input/cover/20220830231541.1135813-1-rrangel@chromium.org/
> 
> I'll look into why you only got added to 2 of the emails.

FWIW I also received the full series without problems.

I'll try to reply to this soon-ish, but I have a bit of
a patch backlog to process and I'm trying to process
the backlog in FIFO order and this is one of the last
series in the backlog ...

Regards,

Hans


> 
> On Wed, Aug 31, 2022 at 5:52 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>>
>> On Tue, Aug 30, 2022 at 05:15:33PM -0600, Raul E Rangel wrote:
>>> Today, i2c drivers are making the assumption that their IRQs can also
>>> be used as wake IRQs. This isn't always the case and it can lead to
>>> spurious wakes. This has recently started to affect AMD Chromebooks.
>>> With the introduction of
>>> d62bd5ce12d7 ("pinctrl: amd: Implement irq_set_wake"), the AMD GPIO
>>> controller gained the capability to set the wake bit on each GPIO. The
>>> ACPI specification defines two ways to inform the system if a device is
>>> wake capable:
>>> 1) The _PRW object defines the GPE that can be used to wake the system.
>>> 2) Setting ExclusiveAndWake or SharedAndWake in the _CRS GpioInt.
>>>
>>> Currently only the first method is supported. The i2c drivers don't have
>>> any indication that the IRQ is wake capable, so they guess. This causes
>>> spurious interrupts, for example:
>>> * We have an ACPI HID device that has `_PR0` and `_PR3`. It doesn't have
>>>   `_PRW` or `ExclusiveAndWake` so that means the device can't wake the
>>>   system.
>>> * The IRQ line is active level low for this device and is pulled up by
>>>   the power resource defined in `_PR0`/`_PR3`.
>>> * The i2c driver will (incorrectly) arm the GPIO for wake by calling
>>>   `enable_irq_wake` as part of its suspend hook.
>>> * ACPI will power down the device since it doesn't have a wake GPE
>>>   associated with it.
>>> * When the device is powered down, the IRQ line will drop, and it will
>>>   trigger a wake event.
>>>
>>> See the following debug log:
>>> [   42.335804] PM: Suspending system (s2idle)
>>> [   42.340186] amd_gpio AMD0030:00: RX: Setting wake for pin 89 to enable
>>> [   42.467736]     power-0416 __acpi_power_off      : Power resource [PR00] turned off
>>> [   42.467739] device_pm-0280 device_set_power      : Device [H05D] transitioned to D3cold
>>> [   42.475210] PM: pm_system_irq_wakeup: 11 triggered pinctrl_amd
>>> [   42.535293] PM: Wakeup unrelated to ACPI SCI
>>> [   42.535294] PM: resume from suspend-to-idle
>>>
>>> In order to fix this, we need to take into account the wake capable bit
>>> defined on the GpioInt. This is accomplished by:
>>> * Migrating some of the i2c drivers over to using the PM subsystem to
>>>   manage the wake IRQ. max8925-i2c, elants_i2c, and raydium_i2c_ts still
>>>   need to be migrated, I can do that depending on the feedback to this
>>>   patch series.
>>> * Expose the wake_capable bit from the ACPI GpioInt resource to the
>>>   i2c core.
>>> * Use the wake_capable bit in the i2c core to call
>>>   `dev_pm_set_wake_irq`. This reuses the existing device tree flow.
>>> * Make the i2c drivers stop calling `dev_pm_set_wake_irq` since it's now
>>>   handled by the i2c core.
>>> * Make the ACPI device PM system aware of the wake_irq. This is
>>>   necessary so the device doesn't incorrectly get powered down when a
>>>   wake_irq is enabled.
>>>
>>> I've tested this code with various combinations of having _PRW,
>>> ExclusiveAndWake and power resources all defined or not defined, but it
>>> would be great if others could test this out on their hardware.
>>
>> I have got only cover letter and a single patch (#3). What's going on?
>>
>> Note: I'm also reviewer of I涎 DesignWare driver, you really have to
>> fix your tools / submission process and try again. No review for this
>> series.
>>
>> --
>> With Best Regards,
>> Andy Shevchenko
>>
>>
> 

