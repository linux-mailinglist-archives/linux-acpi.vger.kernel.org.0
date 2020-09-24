Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7E72778D4
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Sep 2020 20:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbgIXS7P (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Sep 2020 14:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgIXS7P (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Sep 2020 14:59:15 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A429EC0613CE;
        Thu, 24 Sep 2020 11:59:14 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id u21so269162eja.2;
        Thu, 24 Sep 2020 11:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lwAddsxqxEQpJ575NEew1KT3RdIFAHC55D7Q/Z0N/RY=;
        b=GNbA+UUYnzYUWnF9AWZ7LbnzKoR2rTvoRCb/5g6P2OZ/vAeIwpeVeSyZVg1Zk5p0YX
         LW26M0TaN6PWk/5eOX15xy7dwp04CN9vCRJeTgWlthrotX6RlpFbyQCm1KZT3FGNaJi2
         /TMkFLssFuCCH4cNU2uItE15fgcD7ZTKxvsY1sT9QVyX9SUMBRBWuZscAckPgonU1aho
         Sa8wpLkoVSbuPz/1UcipwaExcDJZ3edbe9JeUrn708GlY6qT1Z4rL61iuL2MvDQESzNX
         67AJMVb6ktX4n5KklEq1eZV4nl7CEf0eJNF2ikR8G0QpVOabbYLEfH5sudK1f/35aE5q
         UgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lwAddsxqxEQpJ575NEew1KT3RdIFAHC55D7Q/Z0N/RY=;
        b=N6y8DeXEY5sk77S1iUCuVcC40psSziCbgJfMzLUFWH6kc6QfoPvPXPCTrXcVroL8Lm
         Mq1NMumlLlJp+jsWqACopU7K9snmB6cpkbHXoSSp/2xZhgyvyT2gu+cd/DnS/tRj4hB3
         e3+YQCQJI9Sti7lKGXpqaCv/zcEHy7YzEmh5yGmnc3IdsDXFAHIuWZzK1arHLzv28qXo
         FJRrlcY5JeD/QEFfyPS5fyZHrk5NxtOu2IO1S1l2cfN3MUrj2mOZ/eIAlHBxx6vLluj1
         tf+sekiwP9SDhe9k9lA/0HA6zACzqsxO5pCKF6U9CfJFHpSdK6GI8bruAfqZaPbCwd9i
         qnqw==
X-Gm-Message-State: AOAM531MGZ1+7uE2Wqo6OfN5xLxN/v7OHPH3iVL/i59eKbiEQUW+yCMU
        i77JV6nWKYBc0SBTznriPEhWXGqI8qY=
X-Google-Smtp-Source: ABdhPJxp9sqJiNEsPeTmvDrXg1hfXDZVxyTA8NSVZqJqnoM12q+h6hFsKp8vcVS+g/f/0JuHZBL5aA==
X-Received: by 2002:a17:906:9245:: with SMTP id c5mr94400ejx.54.1600973952579;
        Thu, 24 Sep 2020 11:59:12 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a9d2.dip0.t-ipconnect.de. [217.229.169.210])
        by smtp.gmail.com with ESMTPSA id lr14sm219977ejb.0.2020.09.24.11.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 11:59:11 -0700 (PDT)
Subject: Re: [RFC PATCH 0/9] Add support for Microsoft Surface System
 Aggregator Module
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <CAK8P3a3Qie_CP1dA-ERqyDv=EnaQQPnNbFYrGr3ySiY4mO0=Uw@mail.gmail.com>
 <dad42dce-15d0-245a-4d91-4733e54883a0@gmail.com>
 <CAK8P3a2ryzmsrHHApT9O=dvsw+=z18Sjd4ygVxvFrrDetKA+rQ@mail.gmail.com>
 <c4c1d999-9ab7-8988-906a-3cb6a70bc93d@gmail.com>
 <CAK8P3a2XegsP71yvd8Ku08_k6ecQfkU+V+t+QnjQBrJKF2MwCg@mail.gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <d07adfb3-9f79-c00a-cb70-e044aa0b19f8@gmail.com>
Date:   Thu, 24 Sep 2020 20:59:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2XegsP71yvd8Ku08_k6ecQfkU+V+t+QnjQBrJKF2MwCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 9/24/20 10:26 AM, Arnd Bergmann wrote:
> On Thu, Sep 24, 2020 at 1:28 AM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>> On 9/23/20 9:43 PM, Arnd Bergmann wrote:
>>> On Wed, Sep 23, 2020 at 5:43 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>>>
>>>> On 9/23/20 5:30 PM, Arnd Bergmann wrote:
>>>>> On Wed, Sep 23, 2020 at 5:15 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> The Surface System Aggregator Module (we'll refer to it as Surface
>>>>>> Aggregator or SAM below) is an embedded controller (EC) found on various
>>>>>> Microsoft Surface devices. Specifically, all 4th and later generation
>>>>>> Surface devices, i.e. Surface Pro 4, Surface Book 1 and later, with the
>>>>>> exception of the Surface Go series and the Surface Duo. Notably, it
>>>>>> seems like this EC can also be found on the ARM-based Surface Pro X [1].
>>>>>
>>>>> I think this should go to drivers/platform/x86 or drivers/platform/surface/
>>>>> along with other laptop vendor specific code rather than drivers/misc/.
>>>>
>>>> I initially had this under drivers/platform/x86. There are two main
>>>> reasons I changed that: First, I think it's a bit too big for
>>>> platform/x86 given that it basically introduces a new subsystem. At this
>>>> point it's really less of "a couple of odd devices here and there" and
>>>> more of a bus-type thing. Second, with the possibility of future support
>>>> for ARM devices (Pro X, Pro X 2 which is rumored to come out soon), I
>>>> thought that platform/x86 would not be a good fit.
>>>
>>> I don't see that as a strong reason against it. As you write yourself, the
>>> driver won't work on the arm machines without major changes anyway,
>>> and even if it does, it fits much better with the rest of it.
>>
>> Sorry, I should have written that a bit more clearly. I don't see any
>> reason why these drivers would not work on an ARM device such as the Pro
>> X right now, assuming that it boots via ACPI and the serial device it
>> loads against is fully functional.
> 
> As I understand, the dialect of ACPI used on the snapdragon laptops
> is not really compatible with the subset expected by the kernel, so
> you'd be more likely to run those laptops with a device tree description
> of the hardware instead (if at all).
> 
> Making the driver talk to the hardware directly instead of going through
> AML likely requires more refactoring.

Oh, I did not know that! Thanks!

>>>> I'd be happy to move this to platform/surface though, if that's
>>>> considered a better fit and you're okay with me adding that. Would make
>>>> sense given that there's already a platform/chrome, which, as far as I
>>>> can tell, also seems to be mainly focused on EC support.
>>>
>>> Yes, I think the main question is how much overlap you see functionally
>>> between this driver and the others in drivers/platform/x86.
>>
>> I think that the Pro X likely won't be the last ARM Surface device with
>> a SAM EC. Further, the subsystem is going to grow, and platform/x86
>> seems more like a collection of, if at all, loosely connected drivers,
>> which might give off the wrong impression. In my mind, this is just a
>> bit more comparable to platform/chrome than the rest of platform/x86. I
>> don't think I'm really qualified to make the decision on that though,
>> that's just my opinion.
> 
> I would ask the drivers/platform/x86 maintainers for an opinion here,
> they are probably best qualified to make that decision.
> 
> I don't really mind either way, for me this is more about who is
> responsible as a subsystem maintainer than whether these are
> technically x86 or not.

I see, okay. I'll ask them and CC them on the next submission.

>> Here's an overview of other drivers that I hopefully at some point get
>> in good enough shape, which are part of this subsystem/dependent on the
>> EC API introduced here:
>>
>> - A device registry / device hub for devices that are connected to the
>>     EC but can't be detected via ACPI.
>>
>> - A dedicated battery driver for 7th generation devices (where the
>>     battery isn't hanled via the ACPI shim).
>>
>> - A driver properly handling clipboard detachment on the Surface Books.
>>
>> - A driver for HID input/transport on the Surface Laptops and Surface
>>     Book 3.
>>
>> - A driver for allowing users to set the performance/cooling mode via
>>     sysfs.
>>
>> - Possibly a driver improving hot-plug handling of the discrete GPU in
>>     the Surface Book base.
> 
> Note that drivers that connect to the bus typically don't live in the
> same subdirectory as the driver that operates the bus. E.g. the
> battery driver would go into drivers/power/supply and the input
> would go into drivers/input/ or drivers/hid.

Right. I wonder if this also holds for devices that are directly
dependent on a special platform though? It could make sense to have them
under plaform/surface rather than in the individual subsystems as they
are only ever going to be used on this platform. On the other hand, one
could argue that having them in the subsystem directories is better for
maintainability.

Thanks,
Max
