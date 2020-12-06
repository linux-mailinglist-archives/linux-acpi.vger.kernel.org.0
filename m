Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD3B2D01FC
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Dec 2020 09:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgLFIm5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Dec 2020 03:42:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26756 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725943AbgLFIm4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Dec 2020 03:42:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607244089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pt/exw+3S5ZyzEST0cjvyC3sUqljuEntKsZZoPU58rg=;
        b=gvjMbqVjatyyJUlONx6oyA7rndN/ABUAb9hWSs+okgbXoc7UQYoIxJHG3DtoBPkc6894tH
        /sfXaobUjXOpgyG1QeBZV8w6oqip4gaCgH8AY9RW/bFqags1Dyy7DDD1sZaOTR+bSOMXhw
        82DqRg54Bmi7KXYWmKL3AzpfwDLJP8Q=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93--b3lTRqNNfGRyU5d7pq_XQ-1; Sun, 06 Dec 2020 03:41:25 -0500
X-MC-Unique: -b3lTRqNNfGRyU5d7pq_XQ-1
Received: by mail-ej1-f71.google.com with SMTP id q11so3098940ejd.0
        for <linux-acpi@vger.kernel.org>; Sun, 06 Dec 2020 00:41:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pt/exw+3S5ZyzEST0cjvyC3sUqljuEntKsZZoPU58rg=;
        b=WC1HPatrTEFWkmw4PFCTvgmZWfiPTa5oKwO8yIJoKgLBechyo2EA8dm4rCI/O7eBiq
         pY59N+5eybo3uZJFTtjSZ7dHEaG0mKGHDqHFIeJbV9NyDtZcSdHH24J8D/7udYFVzMay
         6Z/pVON1Z9eaJAe3ZiEpIaLdd+yXChw/fueCP5bUEXAyFjc8I85m+eCtQh/QpxgyG/Oy
         vwBmeOhnmHSnWqpIj9Pk6eEXx0ypyYBlQoGj+gz87/5WWSal5bqElZmPIVgVVyvMsmLN
         EnChajvcfqF3g9s4O85/ZBA6S/F6QThdJ7DSZ0o36AQ3mOL0eqX4oURIILIlqg7kJE9b
         aqTg==
X-Gm-Message-State: AOAM530qddlu58EhezLa4ITE9QwjTXFX5Z6s3/x0zQ5e0ptY+Ou6sA5l
        wIfj4my8JNcCzwcsi2eAxVsXF4V4/z3zQh0Sb1v8e8OevQUf1NhKbD5OROmAQbk8lBoVnmVe4HM
        ++A4z7bg1qrhfOaXzMK64LA==
X-Received: by 2002:a17:906:edb2:: with SMTP id sa18mr13787026ejb.264.1607244083817;
        Sun, 06 Dec 2020 00:41:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/j7PBcbT+T3d61P6fNlm0M49cnuN7hHm34UlngJ8xYi1eeYlwFU8x8PCEYP+KyNk9alziKQ==
X-Received: by 2002:a17:906:edb2:: with SMTP id sa18mr13787003ejb.264.1607244083549;
        Sun, 06 Dec 2020 00:41:23 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id k15sm7483099ejc.79.2020.12.06.00.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Dec 2020 00:41:22 -0800 (PST)
Subject: Re: [PATCH v2 0/9] Add support for Microsoft Surface System
 Aggregator Module
To:     Leon Romanovsky <leon@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <052ecf4d-9e08-2c08-8a06-c30ba2b28d82@redhat.com>
Date:   Sun, 6 Dec 2020 09:41:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201206070705.GA686270@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Leon,

On 12/6/20 8:07 AM, Leon Romanovsky wrote:
> On Thu, Dec 03, 2020 at 10:26:31PM +0100, Maximilian Luz wrote:
>> Hello,
>>
>> Here is version two of the Surface System Aggregator Module (SAM/SSAM)
>> driver series, adding initial support for the embedded controller on 5th
>> and later generation Microsoft Surface devices. Initial support includes
>> the ACPI interface to the controller, via which battery and thermal
>> information is provided on some of these devices.
>>
>> The previous version and cover letter detailing what this series is
>> about can be found at
>>
>>   https://lore.kernel.org/platform-driver-x86/20201115192143.21571-1-luzmaximilian@gmail.com/
>>
>> This patch-set can also be found at the following repository and
>> reference, if you prefer to look at a kernel tree instead of these
>> emails:
>>
>>   https://github.com/linux-surface/kernel tags/s/surface-aggregator/v2
>>
>> Thank you all for the feedback to v1, I hope I have addressed all
>> comments.
> 
> 
> I think that it is too far fetched to attempt and expose UAPI headers
> for some obscure char device that we are all know won't be around in
> a couple of years from now due to the nature of how this embedded world
> works.

This is not for an embedded device, but for the popular line of
Microsoft Surface laptops / 2-in-1s...

> More on that, the whole purpose of proposed interface is to debug and
> not intended to be used by any user space code.

The purpose is to provide raw access to the Surface Serial Hub protocol,
just like we provide raw access to USB devices and have hidraw devices.

So this goes a litle beyond just debugging; and eventually the choice
may be made to implement some functionality with userspace drivers,
just like we do for some HID and USB devices.

Still I agree with you that adding new userspace API is something which
needs to be considered carefully. So I will look at this closely when
reviewing this set.

> Also the idea that you are creating new bus just for this device doesn't
> really sound right. I recommend you to take a look on auxiliary bus and
> use it or come with very strong justifications why it is not fit yet.

AFAIK the auxiliary bus is for sharing a single device between multiple
drivers, while the main device-driver also still offers functionality
(beyond the providing of access) itself.

This is more akin to how the WMI driver also models different WMI
functions as a bus + devices on the bus.

Or how the SDIO driver multiplex a single SDIO device into its
functions by again using a bus + devices on the bus model.

Also this has been in the works for quite a while now, the Linux on
Microsoft Surface devices community has been working on this out of
tree for a long time, see:
https://github.com/linux-surface/

And an RFC and a v1 have been posted a while ago, while auxiliary
bus support is not even in the mainline kernel yet. I would agree
with you that this should switch to auxiliary bus, despite the timing,
if that would lead to much better code. But ATM I don't really see
switching to auxiliary bus offering much benefits here.

> I'm sorry to say, but this series is not ready to be merged yet.
> 
> NAK: Leon Romanovsky <leon@kernel.org>

See above, I believe that this all is a bit harsh and I have not
really heard convincing arguments for not merging this.

Moreover such a quick nack does not really promote working upstream,
where as we actually want people to work upstream as much as possible.
I know this is not a reason for taking bad code, but I'm not
convinced that this is bad code.

I have not reviewed this myself yet, but once I have reviewed
this and any review remarks have been addressed I do expect to
merge this series through the platform-drivers-x86 tree.

Regards,

Hans de Goede
(drivers/platform/x86 and drivers/platform/surface subsys maintainer)

