Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C77E2D0C13
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Dec 2020 09:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgLGIuh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Dec 2020 03:50:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28616 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726302AbgLGIuh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Dec 2020 03:50:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607330949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X3wdCpTgRUkDIYVLD33ro8dZlfwUwre4wBOVohMV86s=;
        b=ZOx0sZfvoKKQc3HUCs/j16vIvuxc3vBt7A1zCiPqmlXL4tTrIHLB1xLSVNrlDgAC9IWBss
        5Kz+VuHuRzHjY4gCQN0RtBj0kH4VbzGjgtBdlPEld1jOP5DlXAvf0TIHavdP0BobUHZafz
        YR5MNbHr4Z2HHfQSmYb7+v+0BCwiSJY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-cqvrcOxGPLG862emIcceHg-1; Mon, 07 Dec 2020 03:49:06 -0500
X-MC-Unique: cqvrcOxGPLG862emIcceHg-1
Received: by mail-ed1-f72.google.com with SMTP id cq17so1973871edb.17
        for <linux-acpi@vger.kernel.org>; Mon, 07 Dec 2020 00:49:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X3wdCpTgRUkDIYVLD33ro8dZlfwUwre4wBOVohMV86s=;
        b=LSMs3tYX+gQ3d147skzjLFkwiIkYJBg1dbqmnYO1Gd7XpezHgGImL4cjwnC72yKN2w
         of/oPgX6rVd1MhfH8Ku/+wn9ZxGBycW3Eh9eM6vvwwMPOB+nZEnjL8d0IYYznDlrUypU
         IlIbNEbM14PIJpuv4sRW4dCgAN5jrBADGTPiK58jxoFbwJSTpBHOlj/fzImVMc5BHTv5
         uTG80vtHokMQva7FaMlLou99FWmvwCtIhSIZkfmEb3oamtlLnecIPLl6eAJbywksv53b
         09BaBMEw1Oq2m9S7IHpJzLYnjadw9tkTaJg7x42gt4tgYoUFeurRGUvPYRnTm6ruVvpk
         tzxA==
X-Gm-Message-State: AOAM531H/TlA0MxMuxOFI32fqggi97A28KgOaGKZ0uOkcSsuHoMI0tH7
        LjzXs+hRclVU8BrUNy1cs7dEPQxu+AHZ7hu8MLTLO8DTyreBBg9eBeUWl/i3zgCl9jfpXEFdhSX
        8cz+uqo7kqd3FxKgfbSvaKA==
X-Received: by 2002:a17:906:c289:: with SMTP id r9mr17566981ejz.311.1607330945661;
        Mon, 07 Dec 2020 00:49:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx7dMUPoIIGyMcvD3MMLoLCJqUEo3cztVy7OeJS1gxHi3m4bYHYP+yrZ+koOe2IP3vetO5zeA==
X-Received: by 2002:a17:906:c289:: with SMTP id r9mr17566958ejz.311.1607330945387;
        Mon, 07 Dec 2020 00:49:05 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id t26sm11317376eji.22.2020.12.07.00.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 00:49:04 -0800 (PST)
Subject: Re: [PATCH v2 0/9] Add support for Microsoft Surface System
 Aggregator Module
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Gross <mgross@linux.intel.com>,
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
 <9dd05a66-efb7-74d2-4f5b-347655b710be@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <aecfdbf2-32bf-1ee5-fe72-0c0923773507@redhat.com>
Date:   Mon, 7 Dec 2020 09:49:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <9dd05a66-efb7-74d2-4f5b-347655b710be@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 12/6/20 4:58 PM, Maximilian Luz wrote:
> On 12/6/20 8:07 AM, Leon Romanovsky wrote:
>> On Thu, Dec 03, 2020 at 10:26:31PM +0100, Maximilian Luz wrote:
>>> Hello,
>>>
>>> Here is version two of the Surface System Aggregator Module (SAM/SSAM)
>>> driver series, adding initial support for the embedded controller on 5th
>>> and later generation Microsoft Surface devices. Initial support includes
>>> the ACPI interface to the controller, via which battery and thermal
>>> information is provided on some of these devices.
>>>
>>> The previous version and cover letter detailing what this series is
>>> about can be found at
>>>
>>>    https://lore.kernel.org/platform-driver-x86/20201115192143.21571-1-luzmaximilian@gmail.com/
>>>
>>> This patch-set can also be found at the following repository and
>>> reference, if you prefer to look at a kernel tree instead of these
>>> emails:
>>>
>>>    https://github.com/linux-surface/kernel tags/s/surface-aggregator/v2
>>>
>>> Thank you all for the feedback to v1, I hope I have addressed all
>>> comments.
>>
>>
>> I think that it is too far fetched to attempt and expose UAPI headers
>> for some obscure char device that we are all know won't be around in
>> a couple of years from now due to the nature of how this embedded world
>> works.
>>
>> More on that, the whole purpose of proposed interface is to debug and
>> not intended to be used by any user space code.
> 
> I believe this has already been extensively discussed. I want to focus
> more on the part below in this response:
> 
>> Also the idea that you are creating new bus just for this device doesn't
>> really sound right. I recommend you to take a look on auxiliary bus and
>> use it or come with very strong justifications why it is not fit yet.
> 
> I tend to agree that this is a valid concern to bring up, and adding a
> new bus is not something that should be done lightly.
> 
> Let's ignore that this has been merged into -next after I've submitted
> this (and that I only recently became aware of this) for the time being.
> If I would see a clear benefit, I would not hesitate to switch the
> driver and subsystem over to this.
> 
> What does concern me most, is the device/driver matching by string.
> Right now, this subsystem matches those via a device UID. This UID is
> directly tied to the EC functionality provided by the device. A bit of
> background to this:
> 
> Requests sent to the EC contain an address, so to say. This consists of
> 
>  - Target category (TC): Broad group of functionality, e.g. battery/AC,
>    thermal, HID input, ..., i.e. a subsystem of sorts.
> 
>  - Target ID (TID): Some major device, e.g. the dual batteries on the
>    Surface Book 3 are addressed by target ID 1 and 2, some functionality
>    is only available at 2 and some only at 1. May be related to physical
>    parts of/locations on the device.
> 
>  - Instance ID (IID): A device instance, e.g. for thermal sensors each
>    sensor is at TC=0x03 (thermal) and has a different instance ID.
> 
> Those can be used to pretty much uniquely identify a sub-device on the
> EC.

Thank you for this explanation, that is going to be useful to know
when I get around to reviewing this set (although I guess that you
probably also have written this down in one of the commit msgs /
docs I did not check).

> 
> Note the "pretty much". To truly make them unique we can add a function
> ID (FN). With that, we can for example match for TC=0x03, TID=*, IID=*,
> FN=0x00 to load a driver against all thermal sensors. And this is
> basically the device UID that the subsystem uses for matching (modulo
> domain for virtual devices, i.e. device hubs). Sure, we can use some
> string, but that then leads to having to come up with creative names
> once we need some driver specific data, e.g. in the battery driver [1]:
> 
>     const struct auxiliary_device_id my_auxiliary_id_table[] = {
>         { .name = "surface_aggregator_registry.battery", .driver_data = x },
>         { .name = "surface_aggregator_registry.battery_sb3", .driver_data = y },
>         { },
>     }
> 
> Arguably, not _that_ big of a deal.
> 
> What worries me more is that this will block any path of auto-detecting
> devices on a more general/global level. Right now, we hard-code devices
> because we haven't found any way to detect them via some EC query yet
> [2] (FYI the node groups contain all devices that will eventually be
> added to the bus, which are already 11 devices on the Surface Book 3
> without taking missing thermal sensors into account; also they are
> spread across a bunch of subsystems, so not just platform). That's of
> course not an ideal solution and one that I hope we can eventually fix.
> If we can auto-detect devices, it's very likely that we know or can
> easily get to the device UID. A meaningful string is somewhat more
> difficult.
> 
> This registry, which is loaded against a platform device that, from what
> we can tell differentiates the models for some driver bindings by
> Windows (that's speculation), is also the reason why we don't register
> client devices directly under the main module, so instead of a nice
> "surface_aggregator.<devicename>", you'll get
> "surface_aggregator_registry.<devicename>". And it may not end there.
> 
> Something that's currently not implemented is support for thermal
> sensors on 7th generation devices. With thermal sensors, we can already
> detect which sensors, i.e. which IIDs, are present. Naturally, that's
> part of the EC-API for thermal devices (TC=0x03), so would warrant a
> master driver that registers the individual sensor drivers (that's a
> place where I'd argue that in a normal situation, the auxiliary bus
> makes sense). So with the auxiliary bus we'd now end up with devices
> with "surface_thermal.sensor" for the sensors as well as
> "surface_aggregator_registry.<devicename>", both of type ssam_device
> (which then would be a wrapper around auxiliary_device with UID stored
> in that wrapper). Note that they need to be of type ssam_device (or
> another wrapper around that) as they again need the reference to the
> controller device, their UID for access, etc. With a proper bus, device,
> and the UID for matching, we can just add the sensor devices to the bus
> again, as they will have a meaningful and guaranteed unique UID.
> 
> From some reports I've seen it looks like thermal sensors may also be
> available separately on TID=0x01 as well as TID=0x02 on some devices,
> at which point I believe you'd need to introduce some IDA for ID
> allocation to not cause a clash with IDs. At least if you separate the
> base drivers for each TC, which I guess should be preferred due to
> code-reuse. Then again they might use different event registries so you
> may end up needing "surface_thermal.sensor_tc1" and
> "surface_thermal.sensor_tc2" as device names to differentiate those
> for driver loading. Or store the registry in software node properties
> when registering the device.
> 
> I'm repeating myself here, but to me it looks cleaner to have a single
> bus type as opposed to spreading the same base auxiliary device type
> over several namespaces.
> 
> Which then leads me to the question of how a function like
> "is_ssam_device()", i.e. a function testing if the device is of a given
> type, would be implemented without enforcing and testing against some
> part of the device name. Something that, again, doesn't look clean to
> me. Although the use of such a function could probably avoided, but that
> then feels like working around the auxiliary bus.
> 
> Unfortunately, there are a couple more hypotheticals at play than I'd
> like to have (making this not an easy decision), but it's a reverse
> engineered driver so I guess that comes with the territory. All in all,


> I believe it's possible to do this (i.e. use the auxiliary bus), but, to
> me at least, the implementation using a discrete bus feels tidier and
> more true to the hardware (or virtual hardware anyway) behind this. I'm
> happy to hear any arguments against this though.

I agree, the whole setup with the TC + TID + IID feels like the functionality
is nicely (and cleanly) split into separate functions and as with other
busses using a bus + 1 device per function for this is a perfectly clean
way to handle this.

Note if in the future you do see benefit in switching the auxiliary bus
I have no problems with that. But atm I don't really see any benefits of
doing so, so then we would just be switching over for the sake of switching
over which does not seem productive.

Regards,

Hans

