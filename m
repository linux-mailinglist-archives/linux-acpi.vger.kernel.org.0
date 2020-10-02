Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1FF2813F3
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Oct 2020 15:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgJBNXw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Oct 2020 09:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBNXw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Oct 2020 09:23:52 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CE1C0613D0;
        Fri,  2 Oct 2020 06:23:52 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gm14so808643pjb.2;
        Fri, 02 Oct 2020 06:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c9AlsC7mL/22KwPTqU8CIK4fkqeIKoEqnJ8+bBOEjyA=;
        b=u09pnQKouhywNuDS0UC6dl0VIsJOLGCCpoBTQUm7cWFW4ho3CSXDiu9qRPQkYrmWM4
         9vzZgumpNcXwhhWXYARqVry7k6KQVvXpfHFHBvMtgFTmIGkleVAuPO+1HZhTmjP/VKCd
         UbPZPiXkIN7DmdaGiShuflPNXWbaHC5uZ1sGByDXtHG7N4NKtVC/8q6US+LcNT43GBvZ
         b30wHVPqFWCJT4/IxFnwBHZy9F4pfNurIZnMd0LvXeHPxHIS0KMF8VfuASmL1Lp/rEGE
         qN3Me5g+ikJwIYI8WNdGPHuifbWXedMoIYa0qKmSfpubswphTVyIOT9VSu9u1EWxMVBO
         BVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c9AlsC7mL/22KwPTqU8CIK4fkqeIKoEqnJ8+bBOEjyA=;
        b=fcGCksbgojG3K4x1sZlyQOUVjxMdhMTapo+SMxeDd9w2W79MqP8avYyGKOznWVjgn+
         vSUQokBXWAva4Q3G7ee2S9gq9cPOYPea38Lmp+pVhz8eLZl03jOYKRU2yzHR6sa8EfX3
         vTS+uvTQGoTxrCmJu27wGiKKJvY179+4WdAMq1vVf32MXnj7TBk4IIsluBK+fCg834uS
         O90Rbw2F/3YuZnW+TeDK8cIngs9qBXtSuSxe/3czdtxSwiIw/sD7t2NSERQ+azwBVWuI
         w+v1WvQHC5BpgEvJNqCRXTQD1jRkk3f6F7vr1vJfOSaNECJol8729G/q23pxXMaw3PCs
         DLAw==
X-Gm-Message-State: AOAM531bnOSnYMqMqhzBM7MDW9VAIfQdYmsGKiQGSvJvqnTjAK/WWN8D
        VgM0vas6aQ5RXaPjasAOIM+UG1u0kuzM5F0BFbg=
X-Google-Smtp-Source: ABdhPJx+wn9di+53Pd0e6dxrc9vwB2M3BngMOU+8Cr6r6UXKWQ7wvdErC78BEuebbwLHAgD7kx5o7LWZCy0HB7kg8IM=
X-Received: by 2002:a17:90a:be11:: with SMTP id a17mr2680288pjs.181.1601645031583;
 Fri, 02 Oct 2020 06:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <9152bb8be33e4192a7766eb53c6ca9af@asem.it> <CAMRc=McnsSkg-7UMp7pKaGX2wSqsZC2jQZV2zRepxm9UxGg=YA@mail.gmail.com>
 <CAHp75VfgEGydXN1A+Y=wn3iX1MbLhN8F9kYyfQwTZBJydr+0+Q@mail.gmail.com>
 <feb8567c830748c483c8c66dd4717003@asem.it> <CAHp75Vdd2QjvJvLGHa1x=RaSknEG+O+YB4eJA6+2htnZ=Gf52g@mail.gmail.com>
 <22753b53cd7d4dfba4ef3610f71cc462@asem.it> <20200930130113.GQ3956970@smile.fi.intel.com>
 <2c26adae711145639d0b982a354aff3c@asem.it> <CAHp75Vcq1WOcMNoKpOSpCD1mFSyvYsaX-h7KHTaAOPe=6S4e0A@mail.gmail.com>
 <CAHp75Vdm9K7nGxsk8P_iGy4m=vi=95zpH1S4NuJbb7bekwZoXg@mail.gmail.com>
 <757023db21e642a3a4b6d33428c191cc@asem.it> <CAHp75Vf-hJ78LmXF8PqOeF-CfWEYqYzMiGCEGaEfnMqxmtiwiw@mail.gmail.com>
In-Reply-To: <CAHp75Vf-hJ78LmXF8PqOeF-CfWEYqYzMiGCEGaEfnMqxmtiwiw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Oct 2020 16:23:32 +0300
Message-ID: <CAHp75VdBJEbm0=eNZMdc2ZWMh4qwP2S7jRECWWWvh2EfA-NykA@mail.gmail.com>
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

On Fri, Oct 2, 2020 at 3:48 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Oct 2, 2020 at 1:02 PM Flavio Suligoi <f.suligoi@asem.it> wrote:
>
> > > > > My SSDT table is:
> > > >
> > > > ^^^^ See the difference? I can't help here.
> >
> > This is the DSDT table related to the GPIO controller of my board:
> >
> > Device (GPO1)
> >         {
> >             Name (_ADR, Zero)  // _ADR: Address
> >             Name (_HID, "INT3452")  // _HID: Hardware ID
> >             Name (_CID, "INT3452")  // _CID: Compatible ID
> >             Name (_DDN, "General Purpose Input/Output (GPIO) Controller - Northwest")  // _DDN: DOS Device Name
> >             Name (_UID, 0x02)  // _UID: Unique ID
> >             Name (RBUF, ResourceTemplate ()
> >             {
> >                 Memory32Fixed (ReadWrite,
> >                     0x00000000,         // Address Base
> >                     0x00004000,         // Address Length
> >                     _Y08)
> >                 Interrupt (ResourceConsumer, Level, ActiveLow, Shared, ,, )
> >                 {
> >                     0x0000000E,
> >                 }
> >             })
> >             Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
> >             {
> >                 CreateDWordField (RBUF, \_SB.GPO1._Y08._BAS, B0BA)  // _BAS: Base Address
> >                 CreateDWordField (RBUF, \_SB.GPO1._Y08._LEN, B0LN)  // _LEN: Length
> >                 B0BA = GP1A /* \GP1A */
> >                 B0LN = GP1L /* \GP1L */
> >                 Return (RBUF) /* \_SB_.GPO1.RBUF */
> >             }
> >
> >             Method (_STA, 0, NotSerialized)  // _STA: Status
> >             {
> >                 If ((OSYS < 0x07DC))
> >                 {
> >                     Return (Zero)
> >                 }
> >
> >                 Return (0x0F)
> >             }
> >         }
>
> So, what about adding the following
>
> DefinitionBlock ("linename.aml", "SSDT", 5, "", "LINENAME", 1)
> {
>   External (_SB_.GPO1, DeviceObj)
>   Scope (\_SB.GPO1)
>   {
>       Name (_DSD, Package () {
>           ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>           Package () {
>               Package () {
>                   "gpio-line-names",
>                   Package () {
>                       "Line0",
>                       "Line1",
>                       "Line2",
>                       ...
>                   }
>               },
>           }
>       })
>   }
> }
>
> ?
>
> (Replace '...' with meaningful line names or drop for now, but in any
> case you need to provide as much names as lines of such GPIO
> controller)

I have checked the code, so it allows you to define from 0 up to all
lines, but no gaps.
Thus, I have dropped '...' line in above excerpt, added the compiled
AML to initramfs (initrd method) and voila!

% gpioinfo gpiochip1
gpiochip1 - 77 lines:
       line   0:      "Line0"       unused   input  active-high
       line   1:      "Line1"       unused   input  active-high
       line   2:      "Line2"       unused   input  active-high
       line   3:      unnamed       unused   input  active-high


% gpiofind Line2
gpiochip1 2

Of course you may convert _DSD to be a Method and fill the line names
dynamically with help of ASL.

-- 
With Best Regards,
Andy Shevchenko
