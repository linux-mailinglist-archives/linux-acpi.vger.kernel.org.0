Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB5F276472
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Sep 2020 01:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgIWX2W (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Sep 2020 19:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgIWX2V (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Sep 2020 19:28:21 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852CCC0613CE;
        Wed, 23 Sep 2020 16:28:21 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id e23so1941449eja.3;
        Wed, 23 Sep 2020 16:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jeYWQDJXV8H5QuyuDkRkggiTufUAIH25mJb6k8QmhrU=;
        b=DBfH9ngGuFIRR3QB4z8OpgxF7di3bS/WA/WEHAaQRNOa6f2ZOTSnlklpYfYfZEtcD0
         AhvyqmDJW3pEqJ7Htc4xfcx1cQtIXcd3QSz07iR+Y6w6rEs9M/ktbIhbmtI64E8FwDSG
         PO0RHR2IRXqX0zJopFI5ZI7Sb+Icam8I4LUh3TXzH+3lxQl/fxjEnJjq6DROhN8Ka5MW
         syBD570Ar/DltRRD4Wvk4e8CHz/CcbMMxKw4waO56NNAGq5lkEBidLUL99C6ibP9mDVr
         qIfyTdVhDS9zdh1aZYqa69weLRnR5Ykrqo8JiQ+2PIs48TRsXskg0g5XevS0WbF0aOJ2
         00bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jeYWQDJXV8H5QuyuDkRkggiTufUAIH25mJb6k8QmhrU=;
        b=qDvDoGIpUH1UigKx6JEdcfBQVjI4H4u8RvmY9iphkR7+voxC1Myg48D0NSf/JJIANe
         sNOvHcwxB0eph+0GgUPFns6ByUY28JitgGyGBNhBqOs8mHfNznfaFk393QZ0O9gEzjG3
         f6fJNVRhS27EODVbbbBlg2YR+EixU+DPhePo1jJ8vUDA8ZCBTACibgL1YLkrIF9jLSIK
         y7EsXvHHX5/HO81vLcXqWXr7JO7sOOcHWPYtOQmHN72HdXmSMt/jHPNKbwxUmusF7BT8
         FA1B1mHiKzgTjzfwySj2JMQh3NqDeLswPtA01EvNoi5HoVKb9c0sjWwdIqmhX7VuD6fX
         jkqQ==
X-Gm-Message-State: AOAM532iErubpKkI0CMG3xZ+TeUOZhER9uI0webtoAEiQOHMRCOZyqZG
        0cYzXMpIlYso+TJeQfpcpEEz3AoCqnE=
X-Google-Smtp-Source: ABdhPJxgL/hVL4iUTg+GnmszuYpgI6Cyjpjt9j/S0fScufHmDcEyQ0KmKly/dStO5STNySBM5kDzWQ==
X-Received: by 2002:a17:906:4685:: with SMTP id a5mr1954011ejr.446.1600903699957;
        Wed, 23 Sep 2020 16:28:19 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a9df.dip0.t-ipconnect.de. [217.229.169.223])
        by smtp.gmail.com with ESMTPSA id w8sm923947ejo.117.2020.09.23.16.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 16:28:19 -0700 (PDT)
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
        Dorian Stoll <dorian.stoll@tmsp.io>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <CAK8P3a3Qie_CP1dA-ERqyDv=EnaQQPnNbFYrGr3ySiY4mO0=Uw@mail.gmail.com>
 <dad42dce-15d0-245a-4d91-4733e54883a0@gmail.com>
 <CAK8P3a2ryzmsrHHApT9O=dvsw+=z18Sjd4ygVxvFrrDetKA+rQ@mail.gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <c4c1d999-9ab7-8988-906a-3cb6a70bc93d@gmail.com>
Date:   Thu, 24 Sep 2020 01:28:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2ryzmsrHHApT9O=dvsw+=z18Sjd4ygVxvFrrDetKA+rQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 9/23/20 9:43 PM, Arnd Bergmann wrote:
> On Wed, Sep 23, 2020 at 5:43 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>
>> On 9/23/20 5:30 PM, Arnd Bergmann wrote:
>>> On Wed, Sep 23, 2020 at 5:15 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>>>
>>>> Hello,
>>>>
>>>> The Surface System Aggregator Module (we'll refer to it as Surface
>>>> Aggregator or SAM below) is an embedded controller (EC) found on various
>>>> Microsoft Surface devices. Specifically, all 4th and later generation
>>>> Surface devices, i.e. Surface Pro 4, Surface Book 1 and later, with the
>>>> exception of the Surface Go series and the Surface Duo. Notably, it
>>>> seems like this EC can also be found on the ARM-based Surface Pro X [1].
>>>
>>> I think this should go to drivers/platform/x86 or drivers/platform/surface/
>>> along with other laptop vendor specific code rather than drivers/misc/.
>>
>> I initially had this under drivers/platform/x86. There are two main
>> reasons I changed that: First, I think it's a bit too big for
>> platform/x86 given that it basically introduces a new subsystem. At this
>> point it's really less of "a couple of odd devices here and there" and
>> more of a bus-type thing. Second, with the possibility of future support
>> for ARM devices (Pro X, Pro X 2 which is rumored to come out soon), I
>> thought that platform/x86 would not be a good fit.
> 
> I don't see that as a strong reason against it. As you write yourself, the
> driver won't work on the arm machines without major changes anyway,
> and even if it does, it fits much better with the rest of it.

Sorry, I should have written that a bit more clearly. I don't see any
reason why these drivers would not work on an ARM device such as the Pro
X right now, assuming that it boots via ACPI and the serial device it
loads against is fully functional.

The reason (at least as far as I know) it currently hasn't been tested
is that a) there aren't a lot of people around attempting to run Linux
on the currently only ARM device with that and b) it's currently blocked
by a reason unrelated to this driver itself, specifically that the
serial controller isn't being set up and thus the core driver doesn't
have a device it can attach to. My information may be outdated though
and is pretty much exclusively based on
https://github.com/Sonicadvance1/linux/issues/7.

> If you are worried about the size of the directory,
> drivers/platform/x86/surface/
> would also work.

This was the alternative I'd have considered without ARM devices.

>> I'd be happy to move this to platform/surface though, if that's
>> considered a better fit and you're okay with me adding that. Would make
>> sense given that there's already a platform/chrome, which, as far as I
>> can tell, also seems to be mainly focused on EC support.
> 
> Yes, I think the main question is how much overlap you see functionally
> between this driver and the others in drivers/platform/x86.

I think that the Pro X likely won't be the last ARM Surface device with
a SAM EC. Further, the subsystem is going to grow, and platform/x86
seems more like a collection of, if at all, loosely connected drivers,
which might give off the wrong impression. In my mind, this is just a
bit more comparable to platform/chrome than the rest of platform/x86. I
don't think I'm really qualified to make the decision on that though,
that's just my opinion.

Here's an overview of other drivers that I hopefully at some point get
in good enough shape, which are part of this subsystem/dependent on the
EC API introduced here:

- A device registry / device hub for devices that are connected to the
   EC but can't be detected via ACPI.

- A dedicated battery driver for 7th generation devices (where the
   battery isn't hanled via the ACPI shim).

- A driver properly handling clipboard detachment on the Surface Books.

- A driver for HID input/transport on the Surface Laptops and Surface
   Book 3.

- A driver for allowing users to set the performance/cooling mode via
   sysfs.

- Possibly a driver improving hot-plug handling of the discrete GPU in
   the Surface Book base.

And also some stuff that hasn't been written yet:

- A dedicated driver for temperature sensors handled via the EC on 7th
   generation devices (also handled via the ACPI shim on previous
   generations).

- Possibly a driver for real-time-clock access on 7th generation
   devices (it has yet to be tested if that interface is still
   around/required on those devices; that's also a thing handled via
   the ACPI shim on previous generations).

I doubt that those client drivers will be exclusive to x86, and I could
see (current and future) ARM devices using SAM based battery,
keyboard/HID, and performance mode drivers (which will likely also
require the device registry, because for some reason MS doesn't want to
describe those devices in ACPI on the newer generations any more...).
All of those should work as-is on ARM (or at least after the
corresponding device entries have been added to the device registry),
modulo bugs of course.

I hope this all gives a better overview of the form this may eventually
take on and helps you in your decision. I'd be completely happy to move
it to either, platform/surface or platform/x86/surface, whatever the
consensus is. I'd very much like to keep the client drivers all
contained to one sub-directory, though, and not scattered all over
platform/x86/surface_*.c. Again that's more of a personal preference
though :)

Thanks,
Max
