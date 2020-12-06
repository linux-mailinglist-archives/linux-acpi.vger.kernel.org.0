Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3A72D0301
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Dec 2020 11:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgLFKwr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Dec 2020 05:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLFKwn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Dec 2020 05:52:43 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82D4C0613D0;
        Sun,  6 Dec 2020 02:52:02 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id ga15so15249858ejb.4;
        Sun, 06 Dec 2020 02:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o31sfvLdxoTxKc9tLsivm1CWmNB9IYeLMFE1r35WQ7k=;
        b=lOvYidc1VYxHcj576IC4fDH54S1aiSxAAdMo729KxVHdUebUEPZf5gX+mbm7EGrJEu
         sFpz+hHrPUgjcMQTqx1Yrni6f39BP/7bQWMO7CY4RqoR/7ZHi31319Nc+wsOA8D+RGwp
         W2uXHFyypTS3kKCZQidMtHpWqPoogMCEsuaPUHaUcokO23iOnhQpqBqCC35KX8IEZERC
         0cO4o7A8dEijLOqLhI1VDNlxJqmis0hzrmTkq6Tt8eB/sCV2/aYEAQNlXDezzkl14FPy
         VQjV4+LouL+9GrnGHrzbFYxhIAnFEpMy2jAoMl7DbJ4EPnLX3kLb3mlctT8q/cOnBNcI
         NpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o31sfvLdxoTxKc9tLsivm1CWmNB9IYeLMFE1r35WQ7k=;
        b=EG9ZIIcTLIvlwXZJOUKNyF0+9NVUe+Yd06G2YohkdTdGpFt69GVuliERusiwxxBiIu
         wPLvxc61zQgUXw604NNKO2oX1PvHQxi0i73hkxlGs8E/w78cVYYVmoTvqDbF5x9s5feU
         1LIx08yrHEi/dgzHuCBJbLNM1Ulkq50WXlBvMvyxVgBZ/3HeZd4sO/8sOrD6vn5u2NI3
         c3DaShFO6W0DOPkEMJNkLeypZC7EUuHp5GXRcTXpvq82FCu1BmYm6EUGdcWOgX6QaLAI
         BZslvyxAgCYm5pR7peJKir/9A8ATmRZhYB9GXbmjGEN29tck5RfZP6Tvdb+tPGpIJr5Q
         k8nQ==
X-Gm-Message-State: AOAM533CFzDGqv61o3e8z9JTJhBnesJojW3p8uCfXDrEx+A/rjzKHLuB
        0hDIFSGOXJe7NWf5t4gcuIWUvFJUiOM=
X-Google-Smtp-Source: ABdhPJxXNV4vEog6akNTSoYLJovFGKqwSrshNk8NwxtzmZcO8vETupb7hbAQ0snDfYryQ184qNRqNA==
X-Received: by 2002:a17:906:fa8b:: with SMTP id lt11mr14593444ejb.94.1607251920901;
        Sun, 06 Dec 2020 02:52:00 -0800 (PST)
Received: from [192.168.2.202] (pd9e5a241.dip0.t-ipconnect.de. [217.229.162.65])
        by smtp.gmail.com with ESMTPSA id u19sm7907366ejg.16.2020.12.06.02.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Dec 2020 02:52:00 -0800 (PST)
Subject: Re: [PATCH v2 0/9] Add support for Microsoft Surface System
 Aggregator Module
To:     Hans de Goede <hdegoede@redhat.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 <f76b329a-b6f5-486d-b06a-452ec4c51979@redhat.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <f422cd34-ea82-9ff9-e7d7-8725d0d0eba5@gmail.com>
Date:   Sun, 6 Dec 2020 11:51:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <f76b329a-b6f5-486d-b06a-452ec4c51979@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 12/6/20 11:04 AM, Hans de Goede wrote:
> Hi,
> 
> On 12/6/20 9:56 AM, Leon Romanovsky wrote:
>> On Sun, Dec 06, 2020 at 09:41:21AM +0100, Hans de Goede wrote:
>>> Hi Leon,
>>>
>>> On 12/6/20 8:07 AM, Leon Romanovsky wrote:
>>>> On Thu, Dec 03, 2020 at 10:26:31PM +0100, Maximilian Luz wrote:
>>>>> Hello,
>>>>>
>>>>> Here is version two of the Surface System Aggregator Module (SAM/SSAM)
>>>>> driver series, adding initial support for the embedded controller on 5th
>>>>> and later generation Microsoft Surface devices. Initial support includes
>>>>> the ACPI interface to the controller, via which battery and thermal
>>>>> information is provided on some of these devices.
>>>>>
>>>>> The previous version and cover letter detailing what this series is
>>>>> about can be found at
>>>>>
>>>>>    https://lore.kernel.org/platform-driver-x86/20201115192143.21571-1-luzmaximilian@gmail.com/
>>>>>
>>>>> This patch-set can also be found at the following repository and
>>>>> reference, if you prefer to look at a kernel tree instead of these
>>>>> emails:
>>>>>
>>>>>    https://github.com/linux-surface/kernel tags/s/surface-aggregator/v2
>>>>>
>>>>> Thank you all for the feedback to v1, I hope I have addressed all
>>>>> comments.
>>>>
>>>>
>>>> I think that it is too far fetched to attempt and expose UAPI headers
>>>> for some obscure char device that we are all know won't be around in
>>>> a couple of years from now due to the nature of how this embedded world
>>>> works.
>>>
>>> This is not for an embedded device, but for the popular line of
>>> Microsoft Surface laptops / 2-in-1s...
>>
>> It is the naming, we don't have char device for every "laptop" vendor.
>> Why is Microsoft different here?
> 
> Because their hardware department has invented a whole new way of dealing
> with a bunch of things at the hardware level (for some reason).
> 
> Also almost all laptop vendors have a whole bunch of laptop vendor
> specific userspace API in the form of sysfs files exported by
> drivers/platform/x86/laptop-vendor.c drivers. E.g. do:
> 
> ls /sys/bus/platform/devices/thinkpad_acpi/
> 
> An any IBM/Lenovo Thinkpad (and only on a Thinkpad) to see a bunch
> of laptop vendor specific UAPI.
> 
> Since I've become the pdx86 subsys maintainer I've actually been
> pushing back against adding more of this, instead trying to
> either use existing UAPIs, or defining new common UAPIs which can
> be shared between vendors.
> 
> So I agree very much with you that we need to be careful about
> needlessly introducing new UAPI.
> 
> But there is a difference between being careful and just nacking
> it because no new UAPI may be added at all (also see GKH's response).
> 
>>>> More on that, the whole purpose of proposed interface is to debug and
>>>> not intended to be used by any user space code.
>>>
>>> The purpose is to provide raw access to the Surface Serial Hub protocol,
>>> just like we provide raw access to USB devices and have hidraw devices.
>>
>> USB devices implement standard protocol, this surface hub is nothing
>> even close to that.
> 
> The USB protocol just defines a transport layer, outside of the USB classes
> there are plenty of proprietary protocols on top of that transport.
> 
> And this chardev just offers access to the Surface Serial Hub transport
> protocol. And if you want something even closer the i2cdev module offers
> raw I2C transfer access and I2C defines no protocol other then
> how to read or write a number of bytes.
> 
> I do a lot of hw enablement work and being able to poke HID / USB / I2C
> devices directly from userspace is very useful for this.

This is pretty much the whole reason for this module. Surface devices
vary from generation to generation, and I can't expect some random user
to write some kernel module (or repeatedly pull 10 different versions
of it)to test if some EC command does x or y. I can tell them to run a
script with some arguments though. The main reason for this is
development, debugging is secondary and IMHO part of development.

So, IOW this interface provides direct access to the EC that would,
without it, require you to write a kernel driver.

The whole "this is intended for development and debugging" shtick is to
deter people from using it to implement user-space based drivers. While
this may be possible at some point, at the moment there is no good way
to (reliably) detect which client devices are present from user-space.
So any attempts at that will likely be unstable and should be
implemented in the kernel anyway. It is a way of prototyping drivers
though.

>>> So this goes a litle beyond just debugging; and eventually the choice
>>> may be made to implement some functionality with userspace drivers,
>>> just like we do for some HID and USB devices.
>>
>> I don't know how it goes in device/platform area, but in other large
>> subsystems, UAPI should be presented with working user-space part.
>>
>>>
>>> Still I agree with you that adding new userspace API is something which
>>> needs to be considered carefully. So I will look at this closely when
>>> reviewing this set.
> 
> So this ^^^ still stands, I agree with you that adding new UAPI needs
> to be considered carefully and when I get around to reviewing this
> that is exactly what I will do.
> 
> Maximilian, can you perhaps explain a bit more of what you want / expect
> to use the chardev for, and maybe provide pointers to the matching
> userspace utilities (which I presume you have) ?

Sure. There's a bunch of scripts at

   https://github.com/linux-surface/surface-aggregator-module/tree/master/scripts/ssam

As described above, the main idea behind this simplifying development
for devices that I can't test myself. See e.g. the "ctrl.py" script
which can be used to send a basic command to the EC. The "hid.py" script
is one that was successfully used to test commands for the Keyboard
driver on the Surface Laptop 1 and 2.

At some point my plan is to maybe split that out into its own repo and
improve usability for all that, but I haven't gotten to that yet.

[...]

Regards,
Max
