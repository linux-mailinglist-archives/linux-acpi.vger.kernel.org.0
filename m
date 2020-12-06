Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF002D02D8
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Dec 2020 11:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgLFKe0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Dec 2020 05:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgLFKeZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Dec 2020 05:34:25 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2705EC0613D0;
        Sun,  6 Dec 2020 02:33:45 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id d17so15180001ejy.9;
        Sun, 06 Dec 2020 02:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vk6HBckdSboz7RYLoG/ecoSXN1J59n5K4n7Y+kNkQLo=;
        b=ZDvI6gPmFDmtjc02cr7ablSYlYKJeBVjQFTosf5EG1qUoiXEzQp63IwyZI6peJfrw3
         EP18kGd7Q4MHB11Zbuqfx46xSbNK9rqx7i9ZinrH3Qz3lAhMHM2TE+f1Dpivks1PkOMJ
         b8eLUzwpmOh/dSlzs3RFVuOgwsRnlYzQHaYWD9qOZA6DE4IWcTK+kdtMaCIAsckEXpdB
         opUHf6c/wV6f4rTrpw74npxYD679/77nz0UwllgL2ix1YqhiVZMX62DX9VEdXeuBESou
         xZ8r7k+QtwgIszie7Iy8bc1GgKSBiceorxk4mTqnA+fT+mvtvb4Uiccl7o971vpFR7K9
         YYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vk6HBckdSboz7RYLoG/ecoSXN1J59n5K4n7Y+kNkQLo=;
        b=n5KdAcPRrKkOQa+vjOXjh26oVZGs2/3JcJWYTa9deeyZt7+ccYw5uHZ0jIDVjemFPG
         U9GJZZP6hlkK05LqyMZmRDCH09E+4mGyKmahDcCd/Cr/ChFPjBA1DSM4NhomUAHeFYZ3
         1rs3WT3xtL4kvCKaWNTVhyVK40MhXJiR2OMHeB2L5qe4aqcRAp4PfLqNYHVMvii1XO+i
         MkO+JSlqzSuPcm+Ku41i3Xaiph2TKL7E0NO/g5NGizsF4m7e8aw1+6ZWjmeX91DGhIQ6
         TXxzxiNG/FeEdvA0ggPIcEKM83GE2FhSftHL4xpBOFpKvSb+GycJG5IrSAiGgTFwwOtC
         wR2w==
X-Gm-Message-State: AOAM5331bZhuheu4vKEF9R6Njim7ej8JMMnEUUWBnESbXlIPIAc2JdoV
        p2JoMUziEsLj61ftU3lAu5rC7o4qkEg=
X-Google-Smtp-Source: ABdhPJxf8y7kdMo+Z9nzNcsHb/5UBhzewgZRy0/IIib00PxKvOAcHu4S6sblBUl0OYAmx1CFdMc9+w==
X-Received: by 2002:a17:906:578e:: with SMTP id k14mr9265757ejq.90.1607250823489;
        Sun, 06 Dec 2020 02:33:43 -0800 (PST)
Received: from [192.168.2.202] (pd9e5a241.dip0.t-ipconnect.de. [217.229.162.65])
        by smtp.gmail.com with ESMTPSA id z9sm7875241eju.123.2020.12.06.02.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Dec 2020 02:33:42 -0800 (PST)
Subject: Re: [PATCH v2 0/9] Add support for Microsoft Surface System
 Aggregator Module
To:     Leon Romanovsky <leon@kernel.org>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <a1db4b23-8159-924a-a99b-2fa4b0eb6fff@gmail.com>
Date:   Sun, 6 Dec 2020 11:33:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201206090614.GA693271@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 12/6/20 10:06 AM, Leon Romanovsky wrote:> On Sun, Dec 06, 2020 at 05:58:32PM +0900, Blaž Hrastnik wrote:
>>>
>>>> More on that, the whole purpose of proposed interface is to debug and
>>>> not intended to be used by any user space code.
>>>
>>> The purpose is to provide raw access to the Surface Serial Hub protocol,
>>> just like we provide raw access to USB devices and have hidraw devices.
>>>
>>> So this goes a litle beyond just debugging; and eventually the choice
>>> may be made to implement some functionality with userspace drivers,
>>> just like we do for some HID and USB devices.
>>>
>>> Still I agree with you that adding new userspace API is something which
>>> needs to be considered carefully. So I will look at this closely when
>>> reviewing this set.
>>
>> To add to that: this was previously a debugfs interface but was moved to misc after review on the initial RFC:
>> https://lkml.org/lkml/2020/9/24/96
> 
> There is a huge difference between the suggestion and final implementation.
> 
> Greg suggested to add new debug module to the drivers/misc that will
> open char device explicitly after user loaded that module to debug this
> hub. However, the author added full blown char device as a first citizen
> that has all not-break-user constrains.

This module still needs to be loaded explicitly. And (I might be wrong
about this) the "not-break-user constraints" hold as soon as I register
a misc device at all, no? So I don't see how this is a) any different
than previously discussed with Greg and b) how the uapi header now
introduces any not-break-user constraints that would not be there
without it.

This interface is intended as a stable interface. That's something that
I committed to as soon as I decided to implement this via a misc-device.

Sure, I can move the definitions in the uapi header to the module
itself, but I don't see any benefit in that. If someone really wants to
use this interface, they can just as well copy the definitions from the
module source itself. So why not be upfront about it and make life
easier for everyone?

Regards,
Max

