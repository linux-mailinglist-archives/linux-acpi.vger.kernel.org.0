Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189AC2D0268
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Dec 2020 11:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgLFKFn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Dec 2020 05:05:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27150 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726243AbgLFKFm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Dec 2020 05:05:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607249055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iZUvuw9wdUKpFCqyWrSv5KZab8oRwCsopkZ8K/bOOq4=;
        b=VoDJlQxEMfkBNPZMWqfcrCaUEy96tyOSfnE774hqnbz1Pvzu6BXrZgH0NC9tCY5HDAPL9k
        OCBMt1VbCkN8FSLal5cMxpL4O+Z7xu0t6lnTIg7Z/uLeSE9aQ66N2yMEpJU2be6czkEzhD
        BFCPeBiVxiG4bcMNwbbCgMSwKRugKJQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-UlWxqCXwN3OTJP1eyzvc1w-1; Sun, 06 Dec 2020 05:04:10 -0500
X-MC-Unique: UlWxqCXwN3OTJP1eyzvc1w-1
Received: by mail-ed1-f69.google.com with SMTP id cq17so902132edb.17
        for <linux-acpi@vger.kernel.org>; Sun, 06 Dec 2020 02:04:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iZUvuw9wdUKpFCqyWrSv5KZab8oRwCsopkZ8K/bOOq4=;
        b=cr6N4SMhfVsuTAPfsya6deCMEMz3JVr7YsoCFsQ6v1JguEMIPm14QuZxmjANX0hoDh
         Ns+QzEwNxK7cA/KpKlOaC2ZpTBcgRxvM3B/ezgmME8Ud/8KArVrjM0YFhXOXwaYy1aU7
         Y4w9nYxo/U2NchyJoX3oYmjCvT5CLcD2h5/WRtjGRuEGnK1663JpojlAVyk5D8+bXcP1
         cQURBvjqmvPK2YVJEB76QzJyyC2+gZP6t3c/+mAkjdNegefy+1ZitRLvO2hIZFDCAT0R
         T3c94GrD8v8ruhOWER0PlYo9cCARrefXo3+EPQ3ETTeefjxi7X72rp8Dzkd0zGPPVb5h
         740A==
X-Gm-Message-State: AOAM532Z/P0XQFXpJLtaic0Us97yMVGLwXkL8MuPRi9hdgxjEWQQ6Md4
        2ARSBIABhfXlLVIcW8hAdjzwf8mZRCBFXdLDsUlRRR55/MCJZjxOeImVVgbHIftbf+YLMF42pBx
        n47lIWOUO5eBidJLSI/tyvA==
X-Received: by 2002:a50:e00b:: with SMTP id e11mr15267230edl.303.1607249049043;
        Sun, 06 Dec 2020 02:04:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygu6IhusvRnnhWQQ/QZWEnpmWN8jUqFSqOOdm8TQKHPkg2Sg2kNjIW+cbXKa7G2LdkYMZgwA==
X-Received: by 2002:a50:e00b:: with SMTP id e11mr15267180edl.303.1607249048668;
        Sun, 06 Dec 2020 02:04:08 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id t12sm4625245edy.49.2020.12.06.02.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Dec 2020 02:04:07 -0800 (PST)
Subject: Re: [PATCH v2 0/9] Add support for Microsoft Surface System
 Aggregator Module
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20201203212640.663931-1-luzmaximilian@gmail.com>
 <20201206070705.GA686270@unreal>
 <052ecf4d-9e08-2c08-8a06-c30ba2b28d82@redhat.com>
 <20201206085631.GE210929@unreal>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f76b329a-b6f5-486d-b06a-452ec4c51979@redhat.com>
Date:   Sun, 6 Dec 2020 11:04:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201206085631.GE210929@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 12/6/20 9:56 AM, Leon Romanovsky wrote:
> On Sun, Dec 06, 2020 at 09:41:21AM +0100, Hans de Goede wrote:
>> Hi Leon,
>>
>> On 12/6/20 8:07 AM, Leon Romanovsky wrote:
>>> On Thu, Dec 03, 2020 at 10:26:31PM +0100, Maximilian Luz wrote:
>>>> Hello,
>>>>
>>>> Here is version two of the Surface System Aggregator Module (SAM/SSAM)
>>>> driver series, adding initial support for the embedded controller on 5th
>>>> and later generation Microsoft Surface devices. Initial support includes
>>>> the ACPI interface to the controller, via which battery and thermal
>>>> information is provided on some of these devices.
>>>>
>>>> The previous version and cover letter detailing what this series is
>>>> about can be found at
>>>>
>>>>   https://lore.kernel.org/platform-driver-x86/20201115192143.21571-1-luzmaximilian@gmail.com/
>>>>
>>>> This patch-set can also be found at the following repository and
>>>> reference, if you prefer to look at a kernel tree instead of these
>>>> emails:
>>>>
>>>>   https://github.com/linux-surface/kernel tags/s/surface-aggregator/v2
>>>>
>>>> Thank you all for the feedback to v1, I hope I have addressed all
>>>> comments.
>>>
>>>
>>> I think that it is too far fetched to attempt and expose UAPI headers
>>> for some obscure char device that we are all know won't be around in
>>> a couple of years from now due to the nature of how this embedded world
>>> works.
>>
>> This is not for an embedded device, but for the popular line of
>> Microsoft Surface laptops / 2-in-1s...
> 
> It is the naming, we don't have char device for every "laptop" vendor.
> Why is Microsoft different here?

Because their hardware department has invented a whole new way of dealing
with a bunch of things at the hardware level (for some reason).

Also almost all laptop vendors have a whole bunch of laptop vendor
specific userspace API in the form of sysfs files exported by
drivers/platform/x86/laptop-vendor.c drivers. E.g. do:

ls /sys/bus/platform/devices/thinkpad_acpi/

An any IBM/Lenovo Thinkpad (and only on a Thinkpad) to see a bunch
of laptop vendor specific UAPI.

Since I've become the pdx86 subsys maintainer I've actually been
pushing back against adding more of this, instead trying to
either use existing UAPIs, or defining new common UAPIs which can
be shared between vendors.

So I agree very much with you that we need to be careful about
needlessly introducing new UAPI.

But there is a difference between being careful and just nacking
it because no new UAPI may be added at all (also see GKH's response).

>>> More on that, the whole purpose of proposed interface is to debug and
>>> not intended to be used by any user space code.
>>
>> The purpose is to provide raw access to the Surface Serial Hub protocol,
>> just like we provide raw access to USB devices and have hidraw devices.
> 
> USB devices implement standard protocol, this surface hub is nothing
> even close to that.

The USB protocol just defines a transport layer, outside of the USB classes
there are plenty of proprietary protocols on top of that transport.

And this chardev just offers access to the Surface Serial Hub transport
protocol. And if you want something even closer the i2cdev module offers
raw I2C transfer access and I2C defines no protocol other then
how to read or write a number of bytes.

I do a lot of hw enablement work and being able to poke HID / USB / I2C
devices directly from userspace is very useful for this.

>> So this goes a litle beyond just debugging; and eventually the choice
>> may be made to implement some functionality with userspace drivers,
>> just like we do for some HID and USB devices.
> 
> I don't know how it goes in device/platform area, but in other large
> subsystems, UAPI should be presented with working user-space part.
> 
>>
>> Still I agree with you that adding new userspace API is something which
>> needs to be considered carefully. So I will look at this closely when
>> reviewing this set.

So this ^^^ still stands, I agree with you that adding new UAPI needs
to be considered carefully and when I get around to reviewing this
that is exactly what I will do.

Maximilian, can you perhaps explain a bit more of what you want / expect
to use the chardev for, and maybe provide pointers to the matching
userspace utilities (which I presume you have) ?

>>> Also the idea that you are creating new bus just for this device doesn't
>>> really sound right. I recommend you to take a look on auxiliary bus and
>>> use it or come with very strong justifications why it is not fit yet.
>>
>> AFAIK the auxiliary bus is for sharing a single device between multiple
>> drivers, while the main device-driver also still offers functionality
>> (beyond the providing of access) itself.
> 
> The idea behind auxiliary bus is to slice various functionalities into
> different sub-drivers, see it as a way to create subsystem inside one
> driver.

AFAIK the idea is to be able to combine multiple physical devices, e.g.
a PCI device + an ACPI enumerated platform device and then slice the
combination of those 2 up in new devices which may use parts of both
parent devices, quoting from:

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/tree/Documentation/driver-api/auxiliary_bus.rst?h=driver-core-next&id=7de3697e9cbd4bd3d62bafa249d57990e1b8f294

"multiple devices might implement a common intersection of functionality"

IOW this is for cases where the simpler bus + devices model does not
work well. AFAICT in this case the simpler bus + devices does work
well, so there is no need to use the auxiliary bus.

>> This is more akin to how the WMI driver also models different WMI
>> functions as a bus + devices on the bus.
>>
>> Or how the SDIO driver multiplex a single SDIO device into its
>> functions by again using a bus + devices on the bus model.
>>
>> Also this has been in the works for quite a while now, the Linux on
>> Microsoft Surface devices community has been working on this out of
>> tree for a long time, see:
>> https://github.com/linux-surface/
> 
> It is not relevant, the code is merged than it is ready.

It is relevant, you cannot expect drivers which were written during
the last 6 months to use functionality which is not even in the
mainline kernel yet (yes it is in -next, but not in mainline).

Now if that new functionality where to provide major benefits to
the code making it much cleaner / better then yes asking to rewrite
it to use that new functionality would make sense.

I need to take a closer look at the code but ATM I'm not convinced
that rewriting it to use the new auxiliary bus stuff will make it
better at all, let alone enough to warrant the effort of the rewrite.

<snip>

Regards,

Hans


p.s.

For the record I do not own any Microsoft Surface devices myself, so
I have no interests here other then to make sure that the Linux
kernel is welcoming to new new contributors and does not needlessly
scare them away.

