Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3AE02D051E
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Dec 2020 14:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgLFN2a (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Dec 2020 08:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbgLFN2a (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Dec 2020 08:28:30 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D22C0613D0;
        Sun,  6 Dec 2020 05:27:49 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id c7so10791409edv.6;
        Sun, 06 Dec 2020 05:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TX8ZeShGgHaH7NVBfvlqb8CJDdVpjgpiUwLryWJigPU=;
        b=PxqIxiGf/ZKHE30eBHu+8w0S7+L2mgC/geHtt6JMOksj+HL/aaFI26Jdqmqvb/YVT8
         6LAonUc6PYj6acRY3W193/IY6TZFNlgK5Kc6EfrpjbjHQP/s5rJnJG6r9ruHr/BU9Z4O
         4I7ryU0npF+niCvbO+gXClmeRKcIM/GdQfqI6Jz52mm1WGWM1op4jCJ+RaPLC69LdrME
         7B0oTVplQMxhG2eGLB3meffT8YpcvcsPOYUaZo0TDrNlrZd2ejPpTE79iDy9RBoaxwtG
         9kXdlzmaRQX8IWUeJR1Wi9+7H37+WvSYc8G1HSrVtFk9DXI0gWPOz8I8Ms7Jb4+MHYAi
         TbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TX8ZeShGgHaH7NVBfvlqb8CJDdVpjgpiUwLryWJigPU=;
        b=j4vNRm9Xce9qkpVrxGPVUDKpQ7vX0I7RJwA0Oz9Y0WJgQ8OuykiLCUHK7iSdFduUf/
         CAnhFJVdBHBZz94PDqa5AOCxo2EBXA+xCSTmvSb0VnECOognszAbLOcF9qrLIFbzna/f
         JYTS8wEFgTGrp2RkVsdc4+kTrfPuJESSCb8K7SavLIQwzRPZRupO7i0MR+jQWu/CL/Pj
         gBd/1kBS2Lb9+74pAGzcMi1Aa1got/q8gSA2as1NGHxcQodRBpsNFx77ZQdw/xbZpGrh
         nRmtnytB3imligSEwJWPetvcMhT1hZrMjTLiPAvbsFQBh736OPJwx1qynY57BuhtgZgJ
         YaSw==
X-Gm-Message-State: AOAM531fBW/Tr/Q8QMezTxYyQr/Ym0Wq3kTzT828iAyo92g5l8Je5Hdx
        Y+5HTBcXFUaenfzHEyvqGZfMvn9y+MI=
X-Google-Smtp-Source: ABdhPJy6tqkxhJ6dfhh8bpz8KNfRizOr9CtPRQFLDcIF9yImxjjbJweYDijcX9nT5rOz4csd1Ubrsg==
X-Received: by 2002:aa7:dd17:: with SMTP id i23mr15634031edv.14.1607261267359;
        Sun, 06 Dec 2020 05:27:47 -0800 (PST)
Received: from [192.168.2.202] (pd9e5a241.dip0.t-ipconnect.de. [217.229.162.65])
        by smtp.gmail.com with ESMTPSA id b14sm8597383edm.68.2020.12.06.05.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Dec 2020 05:27:46 -0800 (PST)
Subject: Re: [PATCH v2 0/9] Add support for Microsoft Surface System
 Aggregator Module
To:     Leon Romanovsky <leon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        lkml <linux-kernel@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
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
        Dorian Stoll <dorian.stoll@tmsp.io>,
        platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20201203212640.663931-1-luzmaximilian@gmail.com>
 <20201206070705.GA686270@unreal>
 <052ecf4d-9e08-2c08-8a06-c30ba2b28d82@redhat.com>
 <1b4fe1fd-592d-4a88-b156-fbf6af2df428@www.fastmail.com>
 <20201206090614.GA693271@unreal>
 <a1db4b23-8159-924a-a99b-2fa4b0eb6fff@gmail.com>
 <20201206113047.GC693271@unreal>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <250d58a8-1a10-b66f-7e47-3dbf218de545@gmail.com>
Date:   Sun, 6 Dec 2020 14:27:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201206113047.GC693271@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 12/6/20 12:30 PM, Leon Romanovsky wrote:
> On Sun, Dec 06, 2020 at 11:33:40AM +0100, Maximilian Luz wrote:
>> On 12/6/20 10:06 AM, Leon Romanovsky wrote:> On Sun, Dec 06, 2020 at 05:58:32PM +0900, Blaž Hrastnik wrote:
>>>>>
>>>>>> More on that, the whole purpose of proposed interface is to debug and
>>>>>> not intended to be used by any user space code.
>>>>>
>>>>> The purpose is to provide raw access to the Surface Serial Hub protocol,
>>>>> just like we provide raw access to USB devices and have hidraw devices.
>>>>>
>>>>> So this goes a litle beyond just debugging; and eventually the choice
>>>>> may be made to implement some functionality with userspace drivers,
>>>>> just like we do for some HID and USB devices.
>>>>>
>>>>> Still I agree with you that adding new userspace API is something which
>>>>> needs to be considered carefully. So I will look at this closely when
>>>>> reviewing this set.
>>>>
>>>> To add to that: this was previously a debugfs interface but was moved to misc after review on the initial RFC:
>>>> https://lkml.org/lkml/2020/9/24/96
>>>
>>> There is a huge difference between the suggestion and final implementation.
>>>
>>> Greg suggested to add new debug module to the drivers/misc that will
>>> open char device explicitly after user loaded that module to debug this
>>> hub. However, the author added full blown char device as a first citizen
>>> that has all not-break-user constrains.
>>
>> This module still needs to be loaded explicitly. And (I might be wrong
>> about this) the "not-break-user constraints" hold as soon as I register
>> a misc device at all, no?
> 
> I don't think so, files in drivers/misc/* don't have such strict policy.

Can I get a link to the documentation stating that or someone else
confirming that?

Also I don't think it makes sense to have a platform/surface device in
drivers/misc, after we've explicitly decided to move this code out of
there. IIRC drivers/misc is not a place for misc-devices, but the
directory for devices that don't have any good place elsewhere.

>> than previously discussed with Greg and b) how the uapi header now
>> introduces any not-break-user constraints that would not be there
>> without it.
> 
> There is a huge difference between char device for the debug and
> exposed UAPI header. The first requires from the user to build and
> explicitly run it, while header allows to reliably build on top of
> it various applications that we don't control. The not-break-rule
> talks about the second.

So it's okay to break stuff that's not explicitly in include/uapi/?
Again, can I get someone to confirm that for me?

As already said, I'm okay with moving the definitions from the header to
the module itself (if there is a consensus on that, CC Greg, Hans),
however both allow you to build user-space tools against the API. Case
in point my python scripts, which don't use the header. Or any other
non-C-based tool. So unless there's a rule that anything without a
header in uapi is fair game, I fail to see your point.

>> This interface is intended as a stable interface. That's something that
>> I committed to as soon as I decided to implement this via a misc-device.
>>
>> Sure, I can move the definitions in the uapi header to the module
>> itself, but I don't see any benefit in that. If someone really wants to
>> use this interface, they can just as well copy the definitions from the
>> module source itself. So why not be upfront about it and make life
>> easier for everyone?
> 
> Because you are actually making life harder for everyone who cares about
> UAPIs exposed by the Linux and they definitely different in numbers from
> those who needs debug interface for the Microsoft Surface board.

This point again depends on the interface not being stable. Unless, of
course, you want me to remove the interface completely and just maintain
it out of tree...

I'm happy to be told otherwise by the authorities here, but from past
conversations it seems that basically everything providing some sort of
user-space access falls under the "don't break user-space" rule as soon
as somebody uses it.

Regards,
Max
