Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221205BEE98
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Sep 2022 22:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiITUe1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 20 Sep 2022 16:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiITUe0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Sep 2022 16:34:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3683C7548F
        for <linux-acpi@vger.kernel.org>; Tue, 20 Sep 2022 13:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663706064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AW/dBlE2AQIyAJdoiRe+IiNWCzn2tZIwTsT8MkCs6dw=;
        b=Y0h6V1dvuzXbSYT2kozfZe/n8tkrub1U0YmE25i94DYcRrIYUI8Dp/5wRnRAoWLqxHAFrl
        crVFlXY78MdCKZTX/SH/ZcmEIhODb2fU1S2/ss/Ubl/ZgDlI3QOpvckCgzjickBlBCNNgd
        6nSeFtRMctdPYWj//5iZdah5h4PlTvI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-574-jkVSQnVmM5-XYgBrshd0lw-1; Tue, 20 Sep 2022 16:34:22 -0400
X-MC-Unique: jkVSQnVmM5-XYgBrshd0lw-1
Received: by mail-ed1-f72.google.com with SMTP id b16-20020a056402279000b0044f1102e6e2so2745165ede.20
        for <linux-acpi@vger.kernel.org>; Tue, 20 Sep 2022 13:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=AW/dBlE2AQIyAJdoiRe+IiNWCzn2tZIwTsT8MkCs6dw=;
        b=d0o7dKLREMbjjqcmHPj5ym4RCJlvJwqcQYZvXqhlUnb1dW+/m8aXDkO74TGNmVbgAd
         9y8Hpl02cYxfPNlM707PMjehv5DG5pNYKeE37rBFBSfuzQpDnKDK15wiAtlVQXxZcsky
         bXzoVRGAZ5lscop7sFoj93G4EEyoCIIsR4WD31C344AFHVzQPjN/Vm9bce+hZs1mdpnm
         LRSlCZD/7emog3g3mo6uQj38M/YQnOIehyBL3FoF3vaJtcC4S/vk3qZvWY6HDSCgJC/B
         LqaZCW1qPoBBcVHP2i4BrptqzwGwRlzPf8rjBQ4fAQSkuCQYuMPy06RPNPtzhcEuUWmO
         lPuw==
X-Gm-Message-State: ACrzQf2F0N0PF+O495xcQLPRz1+1v8EnE+SYhJxGv8FKqEJRqcvCnlVu
        LBHlNVHZWen9uQO5ohd290cqN/Spyi7iZ610OgZYDLOTtX+ywVQsC/nwQvRtKb9AR4hPYCdjuxV
        aLFWEteRJA3+bRd1Bdv+aEQ==
X-Received: by 2002:a05:6402:148e:b0:44e:aa8c:abc5 with SMTP id e14-20020a056402148e00b0044eaa8cabc5mr21854666edv.145.1663706060859;
        Tue, 20 Sep 2022 13:34:20 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5FchS9e4VFCieS+jJqLY+dTOU/Tx49Du5MG0zdHE5Otei40J9KDFt3Sdcf4z5v6zK+N5MWgw==
X-Received: by 2002:a05:6402:148e:b0:44e:aa8c:abc5 with SMTP id e14-20020a056402148e00b0044eaa8cabc5mr21854652edv.145.1663706060620;
        Tue, 20 Sep 2022 13:34:20 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id n26-20020aa7c45a000000b00452ff2c203asm415245edr.92.2022.09.20.13.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 13:34:20 -0700 (PDT)
Message-ID: <0df56807-f8d3-e284-3c4d-f510b2c5604a@redhat.com>
Date:   Tue, 20 Sep 2022 22:34:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH RFC 1/2] staging: quickstart: Add ACPI quickstart button
 (PNP0C32) driver
To:     Arvid Norlander <lkml@vorpal.se>,
        platform-driver-x86@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-input@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>
References: <20220911194934.558019-1-lkml@vorpal.se>
 <20220911194934.558019-2-lkml@vorpal.se>
 <0e88f032-5f29-8842-401e-48a573319ecf@redhat.com>
 <484b5248-ebf2-74c9-0629-08daa538a5c0@vorpal.se>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <484b5248-ebf2-74c9-0629-08daa538a5c0@vorpal.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Arvid,

On 9/20/22 11:48, Arvid Norlander wrote:
> On 2022-09-19 11:27, Hans de Goede wrote:
>> Hi,
>>
>> On 9/11/22 20:49, Arvid Norlander wrote:
>>> This is loosly based on a previous staging driver that was removed. See
>>> links below for more info on that driver. The original commit ID was
>>> 0be013e3dc2ee79ffab8a438bbb4e216837e3d52.
>>>
>>> However, here a completely different approach is taken to the user space
>>> API (which should solve the issues the original driver had). Each PNP0C32
>>> device is a button, and each such button gets a separate input device
>>> associated with it (instead of a shared platform input device).
>>>
>>> The button ID (as read from ACPI method GHID) is provided via a sysfs file
>>> "button_id".
>>>
>>> If the button caused a wakeup it will "latch" the "wakeup_cause" sysfs file
>>> to true. This can be reset by a user space process.
>>>
>>> Link: https://marc.info/?l=linux-acpi&m=120550727131007
>>> Link: https://lkml.org/lkml/2010/5/28/327
>>> Signed-off-by: Arvid Norlander <lkml@vorpal.se>
>>
>> 2 high level remarks here:
>>
>> 1. I believe we should strive for having all issues with this driver fixed
>> before merging it, at which point it should not sit under drivers/staging
>> but rather under drivers/platform/x86 (as an added bonus this can also make
>> toshiba_apci's Kconfig bit select it automatically). So for the next version
>> please move this to drivers/platform/x86
> 
> Makes sense, will do. However, there is nothing x86 specific in theory with
> this driver. Would it not make more sense to put it under drivers/acpi?

Since the spec is from Microsoft I expect it to be a x86 only thing
(AFAIK this predates there couple of ARM attempts). Also since this has
some tie-in with toshiba-acpi (at least for the laptops you are actually
testing this on) keeping it in the same dir as toshiba-acpi seems to
make the most sense to me.

A lot of ACPI drivers actually live under drivers/platform/x86 for
similar reasons.

>> 2. This is using struct acpi_driver, but as Rafael (ACPI maintainer) always
>> said that is really only for very special cases. The ACPI subsystem should
>> instantiate standard platform devices for each PNP0C32 device, you can
>> check this under: /sys/bus/devices/platform.  And this driver should then
>> be convered to a standard platform_driver binding to the platform devices
>> instead of being a struct acpi_driver.
> 
> I had a look at this, and it seems like a much more complicated a approach,
> for example, there is no dedicated .ops.notify, which means I need to use
> acpi_install_notify_handler, and there is no devm_ version of that either.
> A lot of other things seem to be ever so slightly more complicated as well. 
> 
> What is the motivation behind this being preferred? And are most of the
> existing drivers using acpi_driver legacy (e.g. toshiba_acpi)?

I'm mostly just parroting (repeating) the party-line here. Not making
new drivers an acpi_driver is typically requested by Rafael, the ACPI
maintainer. Rafael can you explain why?

From my own view point I guess this has to do with ACPI having changed
over time from mostly offering firmware interfaces which mostly talk
to the EC, to actually also describing the hw.

Now a days of lot of ACPI devices are actually describing real hardware
devices, e.g. PCI cards, I2C devices, SPI decices and UART attached devices
including things like IO / MMIO addresses, I2C slave addresses, SPI chip
selects, GPIOs, IRQs, etc.

So the kernel now a days instantiates actual SPI / I2C / UART / PCI /
other(platform) devices for all the devices in ACPI, with all the physicial
resources attached to the struct platform_device / struct i2c_client / etc.
using the kernels standard resource mechanisms.

The struct platform_device / struct i2c_client / etc. devices then have
a firmware_node pointer (aka companion device) pointing to the ACPI
device in case the driver also needs to make some actual ACPI calls on
either to query some extra information stored in ACPI, or sometimes
to enable / disable special features driven through ACPI methods.

The instantiation of these struct platform_device / struct i2c_client / etc.
devices is done through a special default/fallback acpi_driver. If you
attach your own acpi_driver to an acpi_device then this will not happen.

So for any devices which also have some physical part (and not just pure
firmware interface) using an acpi_driver is not what you want. At which
point I guess we simply just want to avoid it even for pure virtual/fw
devices like the PNP0C32 case for consistency.

Note this is just my view on this, perhaps Rafael can explain this better?

Regards,

Hans

