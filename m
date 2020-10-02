Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FD32812EC
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Oct 2020 14:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387787AbgJBMke (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Oct 2020 08:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgJBMke (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Oct 2020 08:40:34 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5B6C0613D0;
        Fri,  2 Oct 2020 05:40:32 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o25so717801pgm.0;
        Fri, 02 Oct 2020 05:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hNDtci8LWxqyWzF+Qr4E7pl31hjetSM6HC8+XaPpaC4=;
        b=En3KJozJK5WeYTddVtiDVbAwtndZnCJignJMqdPOoYmeYCoQF5+J9dTLeiQto3e/AV
         Js5C7gz7Kg+WBHQGahVlaITJxmOLQTQhmkj1DWtwf0nzS5pz2qUP8/oKt9JXFBAlN9uC
         NWNXvPj5QRh7D1EDpf8psBekoWrfXiQFfD7SiEVBgRGb0xAbS/9kyJrZh3gYJ5lioPUx
         yVNtsm1jP+9r5MEIglAoYQAmOn4D5JM/jSyo2QRlGnCUZLhQSinYe2miDqzwP5ZEPMAq
         f9Y2Y/1s1pQBHyx/x7CpyBi7/HG7LJMjWniLdRwMMzpFMdea5Tk+MAfmtzxSKYmv0MCJ
         oHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hNDtci8LWxqyWzF+Qr4E7pl31hjetSM6HC8+XaPpaC4=;
        b=N3pqKT4//hImmbQ59FaOW2eqQz773JpQ+GQYCrwoURU5EGY3wHRAiickHSi+1KbTrN
         3AEyqR/d2eUVdwKLYLgCXjAuhpiuYDwU+QJkT+iztoJOlRXoe/jTqYmdfp/nbN3Pvumc
         d1xRBM3FNgnahghdqcdz+WAg6tGHC28P87xbCj0UZcIA4+YGjDvzmh3klp+8uvaOYxxr
         QL5/yilVZgxNYYgXgzN87CY3EhfCCLEUsxW5vBVGB9PO4LMHlz0XEoaSFhR5E4cUYFHP
         Tz4qs50oB4+hFABdVeJC8toXIXyfhqwfybUQCIqIEuWqsTuVqhkuacickG4kj6+Qmsjl
         OQTQ==
X-Gm-Message-State: AOAM533KuWufEYChbelN6No/OGjKOyfMwcowQw23sBejDTyEA5Jusx9j
        tDGeSEcMClnPnH/9HJEPVdDq75wgBlcf2c14SNtPqifds/2l+w==
X-Google-Smtp-Source: ABdhPJwiqmff8IzqVl2cJSJRUm6wkqGVVsYKdSB9wkTX/yV5va5weecZo0bVmtJ6sULVtsTAMuH+j5RORFA+ieoKcfE=
X-Received: by 2002:a63:4c1d:: with SMTP id z29mr2036940pga.203.1601642431884;
 Fri, 02 Oct 2020 05:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <9152bb8be33e4192a7766eb53c6ca9af@asem.it> <CAMRc=McnsSkg-7UMp7pKaGX2wSqsZC2jQZV2zRepxm9UxGg=YA@mail.gmail.com>
 <CAHp75VfgEGydXN1A+Y=wn3iX1MbLhN8F9kYyfQwTZBJydr+0+Q@mail.gmail.com>
 <feb8567c830748c483c8c66dd4717003@asem.it> <CAHp75Vdd2QjvJvLGHa1x=RaSknEG+O+YB4eJA6+2htnZ=Gf52g@mail.gmail.com>
 <22753b53cd7d4dfba4ef3610f71cc462@asem.it> <20200930130113.GQ3956970@smile.fi.intel.com>
 <2c26adae711145639d0b982a354aff3c@asem.it> <CAHp75Vcq1WOcMNoKpOSpCD1mFSyvYsaX-h7KHTaAOPe=6S4e0A@mail.gmail.com>
 <CAHp75Vdm9K7nGxsk8P_iGy4m=vi=95zpH1S4NuJbb7bekwZoXg@mail.gmail.com> <8b6adbc45d134da7b0fd1f9044a37cf6@asem.it>
In-Reply-To: <8b6adbc45d134da7b0fd1f9044a37cf6@asem.it>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Oct 2020 15:40:13 +0300
Message-ID: <CAHp75Vfh7u+va0CVCQxSe7unk8qGiWnNrpKHXVH3fKBYzqEUVA@mail.gmail.com>
Subject: Re: How to use an ACPI declared GPIO in a userspace ...
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 2, 2020 at 1:26 PM Flavio Suligoi <f.suligoi@asem.it> wrote:
> Hi Andy,
>
> with my custom SSDT table:
>
> DefinitionBlock ("gpio_button.aml", "SSDT", 5, "ASEMsp", "GPIO_BTN", 1)
> {
>         External (_SB_.GPO1, DeviceObj)
>         Scope (\_SB.GPO1)
>         {
>                 Device (BTNS)
>                 {
>                         Name (_HID, "ASEM0005")         // _HID: Hardware ID PRP0001
>                         Name (_UID, Zero)             // _UID: Unique ID
>                         Name (_DDN, "DDN - SW Readable Button")  // _DDN: DOS Device Name
>                         Name (_STR, Unicode ("STR - SW Readable Button"))  // _STR: Description String
>
>                         Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
>                         {
>                                 GpioIo (
>                                         Shared,                  // Not shared
>                                         PullNone,                // No need for pulls
>                                         0,                       // Debounce timeout
>                                         0,                       // Drive strength
>                                         IoRestrictionInputOnly,  // Only used as input
>                                         "\\_SB.GPO1",            // GPIO controller
>                                         0, ResourceConsumer, , ) // Must be 0
>                                         {
>                                                 25,                // GPIO number 25
>                                         }
>                         })
>                 }
>         }
> }
>
> I'm able to see the GPIO in:
>
> /sys/bus/platform/devices/ASEM0005:00/firmware_node:
>
> -r--r--r--    1 root     root          4096 Oct  2 12:10 description
> -r--r--r--    1 root     root          4096 Oct  2 12:10 hid
> -r--r--r--    1 root     root          4096 Oct  2 12:10 modalias
> -r--r--r--    1 root     root          4096 Oct  2 12:10 path
> lrwxrwxrwx    1 root     root             0 Oct  2 12:10 physical_node -> ../../../../platform/INT3452:01/ASEM0005:00
> drwxr-xr-x    2 root     root             0 Oct  2 12:10 power
> lrwxrwxrwx    1 root     root             0 Oct  2 12:10 subsystem -> ../../../../../bus/acpi
> -rw-r--r--    1 root     root          4096 Oct  2 12:10 uevent
> -r--r--r--    1 root     root          4096 Oct  2 12:10 uid
>
> and so I can see some useful info:
>
> # cat description
> STR - SW Readable Button
> # cat hid
> ASEM0005
> # cat modalias
> acpi:ASEM0005:
> bmxxxx-x86-64:/sys/bus/platform/devices/ASEM0005:00/firmware_node# cat path
> \_SB_.GPO1.BTNS
>
> So, from userspace, I can discover the GPIO controller /dev/gpiochip1,
> but I don't know how to discover the GPIO number (25 in this case).
> Do you have any suggestion about how to discover this GPIO number?

You don't need this SSDT at all.

-- 
With Best Regards,
Andy Shevchenko
