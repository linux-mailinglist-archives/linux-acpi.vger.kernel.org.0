Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BEA27D39A
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Sep 2020 18:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgI2Q1r (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Sep 2020 12:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbgI2Q1q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Sep 2020 12:27:46 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EF1C061755;
        Tue, 29 Sep 2020 09:27:46 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n14so5052497pff.6;
        Tue, 29 Sep 2020 09:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oaRTr4r771JWjjoDIpUuKiWXTOXHRHBkmXXfAxrPMlQ=;
        b=vV6BgnA+TmH0IZFrSENdnRXu2K5m4budlqJvYiO70mUxDkgx6uEzD12BXenaoFAjso
         1Fh53SK+vrjJcCg4W4VdeY9nWRICn6IaRMHefLxPsnI5SFMmJRO1A2ZMkn5WOpr+kO5f
         JR+c1SQ63CgFh2VpiGZj+C5x6v0Y/P80nCt/ja67546KajwqLAlR+vBLtXH7i5LtFwYh
         eH8Mwt0F0MowOXTEFGHsWmmjFZNQFdFtrL1UrZniqTQL0DuWvzDb9spIHha4vms5BOWZ
         QY3PaqRTbj8W4L7XdR09D27ul04slDfiiSZoNLJI0aeDxNzahK2r7Nv3yvevOJsAcvG/
         /oIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oaRTr4r771JWjjoDIpUuKiWXTOXHRHBkmXXfAxrPMlQ=;
        b=pINztfjeGA92MmBLiU/gDQMqvS5UyzM6k+iKUtwWcnzBAp97ksOle2V+bDTMGOunD9
         Gjpy3+XGR1x/TxjWtlJeDiPLKTuvKmFfpcNaH2FlzHZIeZZYg3wiD+KlJvfT9ZhTYdIb
         zDb+zX6icfK/hu3lJZM1h4/JdGx/WB7mw2KQAFcoBTFxAhgSjBXQ3RX/4f1pMQ7BIjS/
         qUiqeP/5SsCVhPFPqHzyZb/gJHfyKjstksYTYqNr4CgCS96q6phbRHpaANmd179fukdo
         0f5BDzpK8ME0N1+fzoPqzFvxfVjxP1Nn5lOoipOR/sECrr510kxPmCJwa0onuUH9nYpU
         MjBg==
X-Gm-Message-State: AOAM531LfuDEIF5oeHRgWQgbAxpwo3/Xcmq+gDcMgh+2fnn+usI0NXbh
        GNv7MFok/3be5KGYw0fEzzuDolC3iFa2VZvxl8FSzd+Ag5Xq9A==
X-Google-Smtp-Source: ABdhPJzT8xE2c8y3+Wg2grWhe4In/xKroYpFgjJjpQ2LW2Tt5Z5zNkkImaccSh88eNEfzPMcUHtsMq/UzEiHPy5Chh8=
X-Received: by 2002:a17:902:ea8c:b029:d2:8abd:c8de with SMTP id
 x12-20020a170902ea8cb02900d28abdc8demr5590642plb.21.1601396866094; Tue, 29
 Sep 2020 09:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <9152bb8be33e4192a7766eb53c6ca9af@asem.it> <CAMRc=McnsSkg-7UMp7pKaGX2wSqsZC2jQZV2zRepxm9UxGg=YA@mail.gmail.com>
 <CAHp75VfgEGydXN1A+Y=wn3iX1MbLhN8F9kYyfQwTZBJydr+0+Q@mail.gmail.com> <feb8567c830748c483c8c66dd4717003@asem.it>
In-Reply-To: <feb8567c830748c483c8c66dd4717003@asem.it>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 29 Sep 2020 19:27:26 +0300
Message-ID: <CAHp75Vdd2QjvJvLGHa1x=RaSknEG+O+YB4eJA6+2htnZ=Gf52g@mail.gmail.com>
Subject: Re: How to use an ACPI declared GPIO in a userspace ...
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 29, 2020 at 7:21 PM Flavio Suligoi <f.suligoi@asem.it> wrote:
> > > > I need to expose to the userspace a GPIO, physically connected to a
> > board
> > > > push-button. This GPIO must expose a pre-defined name, such as
> > > > "user-push-button", so that the userspace applications can use it
> > without
> > > > know any physical GPIO details.
> > > >
> > > > I can customize the board BIOS and so my goal is to add an ACPI tab=
le
> > with
> > > > a content like this:
> > > >
> > > > ...
> > > > Scope (\_SB.GPO1)
> > > >         {
> > > >                 Device (BTNS)
> > > >                 {
> > > >                         Name (_HID, "PRP0001")
> > > >                         Name (_DDN, "GPIO buttons device")
> > > >
> > > >                         Name (_CRS, ResourceTemplate ()
> > > >                         {
> > > >                                 GpioIo (
> > > >                                 Exclusive,               // Not sha=
red
> > > >                                 PullNone,                // No need
> > for pulls
> > > >                                 0,                       // Debounc=
e
> > timeout
> > > >                                 0,                       // Drive
> > strength
> > > >                                 IoRestrictionInputOnly,  // Only us=
ed
> > as input
> > > >                                 "\\_SB.GPO1",            // GPIO
> > controller
> > > >                                 0, ResourceConsumer, , ) // Must be=
 0
> > > >                                 {
> > > >                                         25,              // GPIO
> > number
> > > >                                 }
> > > > ...
> > > >
> > > > I know that this GPIO can be used from other drivers.
> > > > For example I successfully tested it using the "gpio-keys" device
> > driver,
> > > > giving to my GPIO a key-code and emulating in this way a keyboard k=
ey.
> > > > This could be a possible solution.
> > > >
> > > > But I prefer to expose my GPIO as a classic GPIO, not as a keyboard
> > key.
> > > >
> > > > I was wondering if there is a generic GPIO driver that I can use to
> > expose
> > > > this GPIO with its pre-defined name (caming from the ACPI table
> > declaration),
> > > > to the userspace...
> >
> > Unfortunately what you are describing in the second part is rather
> > property of the controller which can hog the line, but this is not
> > what you want in the first part.
> > The Linux kernel, in many ways, is designed that you need a driver
> > (I=C2=B2C user space device node is rather a mistake, but compromise fo=
r
> > that time when most of the devices have access from user space
> > drivers). So, the proper way is to define this as gpio-keys (either
> > interrupt version or polling one) and connect a listener to the event.
> >
> > Summarize: you need to describe pin(s) via "gpio-line-names" property
> > of the controller (it's not so easy task if ACPI tables already have
> > parts of it, but I think your case should be feasible). And either
> > provide a gpio-keys device, or use line directly by name as (libgpiod
> > example):
> >  gpiodetect
> >  gpioinfo gpiochipX
> >  gpiofind $GPIO_LINE_NAME
> >  gpiomon gpiochipX $(gpiofind $GPIO_LINE_NAME) &
> >
> > Examples of ACPI are here [1] for controller part (look at the name
> > list) and for device part [2]. You may look into other folders as
> > well, though they are not so reach of examples.
> >
> > [1]: https://github.com/westeri/meta-acpi/blob/master/recipes-bsp/acpi-
> > tables/samples/edison/arduino.asli
> > [2]: https://github.com/westeri/meta-acpi/blob/master/recipes-bsp/acpi-
> > tables/samples/edison/buttons.asli
>
> I have already written and ACPI table, not in the BIOS but as separate
> SSDT, loaded manually at runtime, using the gpio-keys (with interrupt)
> and in this way all works good. So I have already tested this solution.
>
> But I prefer obtain this result in the classic way, with GPIO...
>
> So I think I'll write a device driver for it. A device driver which
> reads the ACPI table and publishes the GPIO, with its name, in sysfs...

Maybe I was not so clear, but as Bart mentioned the least you can do
is simply define line name via "gpio-line-names" property. The problem
here is when and how you would like to have them incorporated.
When: if ACPI tables are being provided by firmware which you may not
alter, then you must use initramfs type of solution (no configfs,
don't know about EFI var though). How: In that case you might have a
chance to incorporate _DSD() method into *existing* _CRS() one.
Possible impediments: if ACPI table from firmware already has a _DSD()
defined or above is not working for some reason. In such a case you
must upgrade entire DSDT via initramfs.

> > > Adding Andy who knows ACPI GPIO well.
> >
> > Thanks.
> >
> > > In general, the "gpio-line-names" property is used for that and it's
> > > supported both for device tree as well as ACPI, although I have only
> > > ever used the former.
> >
> > Right. ACPI supports properties via _DSD() method.

--=20
With Best Regards,
Andy Shevchenko
