Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31052D030D
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Dec 2020 11:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgLFK5L (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Dec 2020 05:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgLFK5K (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Dec 2020 05:57:10 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652B3C0613D0;
        Sun,  6 Dec 2020 02:56:30 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id c7so10549459edv.6;
        Sun, 06 Dec 2020 02:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VELJr/NXssUvymRpU41z6schgWDjiLoMIujp5PzNYgI=;
        b=AM3Xzq6+hFoIMXw5jqHDV/aK4fIVFIUT+gYZkPKMO6b3BMn+5Z3egpuPe7EGFYm9/8
         gABWnZDGF9uTkxFKMIKBU84O105kpKx9dmPSJ+hCIxRNP8q4GHtGfMB7UdWDzNIAUyI4
         7gTfafti6On+2jBTq+598x5NApHw6WHqxk1sQR/xEEQLCgUvWvkfbKUwedZSENgXQvPA
         wfnNngXyHXqTKfi4gSJBTUDk41eZKF357FgFcvXtDjdjDL0V2y5MTdZuNxcEx5kUQhlt
         PUc3EXFZ1FbsuFeCOS4vBFX/J5Yaqmb7yBEa4sOl1qZsXJoD63UWQJgui5wOcsu6kiXZ
         tUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VELJr/NXssUvymRpU41z6schgWDjiLoMIujp5PzNYgI=;
        b=P3p8D+X82kBsaaUOBGnc9gWVOlBKriRV9htCUmH6YtgppKU2w69daTojbwq0EAAa1I
         xgsycjLulMk19+z0btj6BLpO3yF+l8VMHZIB2tF+iYVjbmpLlhcK0/rBn/O2j05BcbO9
         2IbBhCiQMIss1MBkvSoYhGmE7GXcvv2b7dIUCAHp7HSlBT7cpnDt6YIy4Ga3Ma9oteo4
         bFqY8QNQpES/QPagCJYM0LYYJ9EXJL899WEQqsN9ibQAa8B42mhf3ZLb0jHx3oe8w2xF
         QW0Fg86IV0pz4MYa3oh06c5VTVpkdcKpuDjIQjD9b7pTgf3ZhxGru62rn+prRId/biRa
         RN3Q==
X-Gm-Message-State: AOAM53216fmhzuc3P17AbQ6LcaH+LZo3bhsFjCQOX5Jyzl1vn2fFfbyG
        zdkQEdG55715Dp6vuwkCxX/XTyQ+/3Q=
X-Google-Smtp-Source: ABdhPJyfn9tQ0SbTHXlHVreFPNrD0NC+wdf1y4eq/ep9Mt3EpJ18KaU3fRNrlj2DrkQi8Dv6n3Hh2Q==
X-Received: by 2002:a05:6402:149a:: with SMTP id e26mr15325734edv.232.1607252188637;
        Sun, 06 Dec 2020 02:56:28 -0800 (PST)
Received: from [192.168.2.202] (pd9e5a241.dip0.t-ipconnect.de. [217.229.162.65])
        by smtp.gmail.com with ESMTPSA id v2sm724847ejq.109.2020.12.06.02.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Dec 2020 02:56:27 -0800 (PST)
Subject: Re: [PATCH v2 0/9] Add support for Microsoft Surface System
 Aggregator Module
To:     Hans de Goede <hdegoede@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 <8c6f7234-fc7e-66c2-948c-1232eb5ff813@redhat.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <f1317cd3-368e-838b-cf9b-74b8b079a62e@gmail.com>
Date:   Sun, 6 Dec 2020 11:56:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <8c6f7234-fc7e-66c2-948c-1232eb5ff813@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 12/6/20 11:43 AM, Hans de Goede wrote:
> Hi,
> 
> On 12/6/20 11:33 AM, Maximilian Luz wrote:
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
>> This module still needs to be loaded explicitly.
> 
> Good then I really do not see a problem with this.
> 
>> And (I might be wrong
>> about this) the "not-break-user constraints" hold as soon as I register
>> a misc device at all, no?
> 
> Correct.
> 
>> So I don't see how this is a) any different
>> than previously discussed with Greg and b) how the uapi header now
>> introduces any not-break-user constraints that would not be there
>> without it.
>>
>> This interface is intended as a stable interface. That's something that
>> I committed to as soon as I decided to implement this via a misc-device.
>>
>> Sure, I can move the definitions in the uapi header to the module
>> itself, but I don't see any benefit in that.
> 
> Right, if we are going to use a misc chardev for this, then the
> correct thing to do is to put the API bits for that chardev under
> include/uapi.
> 
> It would still be good if you can provide a pointer to some userspace
> tools using this new API; and for the next version maybe add that
> pointer to the commit message

Right, I will add that to the commit message. I just linked you the
scripts in my other response, but here again for completeness:

   https://github.com/linux-surface/surface-aggregator-module/tree/master/scripts/ssam

While I'm not using the header directly (the scripts are written in
python) I still think uapi is the right place to put this (please
correct me if I'm wrong). Not putting them there seems to be needless
obfuscating to me.

Regards,
Max
