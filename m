Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2A427D35A
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Sep 2020 18:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgI2QKl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Sep 2020 12:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgI2QKl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Sep 2020 12:10:41 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AA2C061755;
        Tue, 29 Sep 2020 09:10:40 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z19so4997347pfn.8;
        Tue, 29 Sep 2020 09:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UuTGkML+V/bG8c9WQuENVdIwmVUvpfepi1FHI1A2IVs=;
        b=LyGFuuzNN6b5MXt91Coi57plYltGjWT1itn9m8mAcbENHf7D0yJsumf+96wEJfdMbc
         1oRgG0G2FaEATvZpdUolQAjXASHsYoNSIh6UX4I2pVD2KpKpfkZLtyQMh/FdVDtqVOUF
         WyI3Ahq11tOjVTY0jktOy6MmuhTO4mSSqEwSR7x6IbixaKkn5G6wzgpzpgscAuC9mWKX
         OjTJPYlJzbTHxmeqMFWVt0rEtzQbhmkVI7p3dY8HHKinHhnW16V+jPa9/haDt2qx1Er6
         gJdZZvBVGeM+NmExKi+FwGAgBUVMO0oWFqY7gbUsjESKDmN17Jga+0HYbpogZDXZetUc
         oU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UuTGkML+V/bG8c9WQuENVdIwmVUvpfepi1FHI1A2IVs=;
        b=fQpHugreDnoEUD15adpA5J/SrspzU3E8BaAVWgMugb45qLm1yNX0e/ilpSybw2tbyZ
         Y1WCiJuzsh8O2FKq4EEnYK317lr9B1ZlR4zsosgoJRmA+okBkgSgt2oC30hMZJuGkUia
         8pmn04hGj4wrhZSCr+obd2qMV76mxvocE/4O7FMmKl3tw94HJrDjEtGH8/MDWm7iusPH
         RX74arflqKhwAcRYamOWi97QE9lq2CD7V1NDjTZjoh3Lzr3NSPJMyqW4EHmx/Xu3Rz2K
         KMvinuNbHjqgKVp9kUmSMO+nWoGaMYT3G+ajoy2xCg8iBmfIVX1ZKLUQvLxhndaxI8u1
         ZEnw==
X-Gm-Message-State: AOAM532D0I+BoB3B56mg2VPdvPuvN8H6xj5fBvYu0wQ8GPRXo9iNZy2k
        8gO1rqxL/AIIzRr5fg2aplmFC+R2O0MLFJkN9I3galaIGK9dhgW3
X-Google-Smtp-Source: ABdhPJyHFMKtDIjvWFjykUPPhhpMk/KZL/JZ/pN55uKC8FaSUBfAmJjrLojj9wqAIDdzDAseK7TduVoxe6Yb/XZiwBI=
X-Received: by 2002:aa7:81d5:0:b029:142:2501:39fa with SMTP id
 c21-20020aa781d50000b0290142250139famr4930845pfn.73.1601395840312; Tue, 29
 Sep 2020 09:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <9152bb8be33e4192a7766eb53c6ca9af@asem.it> <CAMRc=McnsSkg-7UMp7pKaGX2wSqsZC2jQZV2zRepxm9UxGg=YA@mail.gmail.com>
In-Reply-To: <CAMRc=McnsSkg-7UMp7pKaGX2wSqsZC2jQZV2zRepxm9UxGg=YA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 29 Sep 2020 19:10:21 +0300
Message-ID: <CAHp75VfgEGydXN1A+Y=wn3iX1MbLhN8F9kYyfQwTZBJydr+0+Q@mail.gmail.com>
Subject: Re: How to use an ACPI declared GPIO in a userspace ...
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Flavio Suligoi <f.suligoi@asem.it>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 29, 2020 at 6:48 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Tue, Sep 29, 2020 at 5:43 PM Flavio Suligoi <f.suligoi@asem.it> wrote:
> >
> > Hi all,
> >
> > I need to expose to the userspace a GPIO, physically connected to a boa=
rd
> > push-button. This GPIO must expose a pre-defined name, such as
> > "user-push-button", so that the userspace applications can use it witho=
ut
> > know any physical GPIO details.
> >
> > I can customize the board BIOS and so my goal is to add an ACPI table w=
ith
> > a content like this:
> >
> > ...
> > Scope (\_SB.GPO1)
> >         {
> >                 Device (BTNS)
> >                 {
> >                         Name (_HID, "PRP0001")
> >                         Name (_DDN, "GPIO buttons device")
> >
> >                         Name (_CRS, ResourceTemplate ()
> >                         {
> >                                 GpioIo (
> >                                 Exclusive,               // Not shared
> >                                 PullNone,                // No need for=
 pulls
> >                                 0,                       // Debounce ti=
meout
> >                                 0,                       // Drive stren=
gth
> >                                 IoRestrictionInputOnly,  // Only used a=
s input
> >                                 "\\_SB.GPO1",            // GPIO contro=
ller
> >                                 0, ResourceConsumer, , ) // Must be 0
> >                                 {
> >                                         25,              // GPIO number
> >                                 }
> > ...
> >
> > I know that this GPIO can be used from other drivers.
> > For example I successfully tested it using the "gpio-keys" device drive=
r,
> > giving to my GPIO a key-code and emulating in this way a keyboard key.
> > This could be a possible solution.
> >
> > But I prefer to expose my GPIO as a classic GPIO, not as a keyboard key=
.
> >
> > I was wondering if there is a generic GPIO driver that I can use to exp=
ose
> > this GPIO with its pre-defined name (caming from the ACPI table declara=
tion),
> > to the userspace...

Unfortunately what you are describing in the second part is rather
property of the controller which can hog the line, but this is not
what you want in the first part.
The Linux kernel, in many ways, is designed that you need a driver
(I=C2=B2C user space device node is rather a mistake, but compromise for
that time when most of the devices have access from user space
drivers). So, the proper way is to define this as gpio-keys (either
interrupt version or polling one) and connect a listener to the event.

Summarize: you need to describe pin(s) via "gpio-line-names" property
of the controller (it's not so easy task if ACPI tables already have
parts of it, but I think your case should be feasible). And either
provide a gpio-keys device, or use line directly by name as (libgpiod
example):
 gpiodetect
 gpioinfo gpiochipX
 gpiofind $GPIO_LINE_NAME
 gpiomon gpiochipX $(gpiofind $GPIO_LINE_NAME) &

Examples of ACPI are here [1] for controller part (look at the name
list) and for device part [2]. You may look into other folders as
well, though they are not so reach of examples.

[1]: https://github.com/westeri/meta-acpi/blob/master/recipes-bsp/acpi-tabl=
es/samples/edison/arduino.asli
[2]: https://github.com/westeri/meta-acpi/blob/master/recipes-bsp/acpi-tabl=
es/samples/edison/buttons.asli

> Adding Andy who knows ACPI GPIO well.

Thanks.

> In general, the "gpio-line-names" property is used for that and it's
> supported both for device tree as well as ACPI, although I have only
> ever used the former.

Right. ACPI supports properties via _DSD() method.

--=20
With Best Regards,
Andy Shevchenko
