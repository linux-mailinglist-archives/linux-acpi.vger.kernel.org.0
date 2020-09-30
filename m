Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AD827EDF8
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Sep 2020 17:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgI3PzZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Sep 2020 11:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3PzM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Sep 2020 11:55:12 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB01C061755;
        Wed, 30 Sep 2020 08:55:12 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id jw11so23046pjb.0;
        Wed, 30 Sep 2020 08:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ws3BUjIflBOEGN9PJVX1rB9emMu/Hx6C/guR3YZ88CY=;
        b=Zks96xaPFZmHbqmxTF0GDKFvkfBtvLHdI5FABA79eTZbxdNO4F1ht1tNahih6FMrXs
         +pyHjGypPZoKKQcvjTOLn95w+Xf+Q2JcFQEIrRUAmAtqbyI2w4ZbEI0Gq6W4vpxv4YDe
         Ncg/kowU8axpbXaNlDSJ3kx/dmMLy2YSRpw572nb1ohrdXFgK7CGAWOKXBEMrfTgXxAH
         teQy5uOUXiFBzD/MslU4OklmjOx9rO9r1HUtIl0kLc5e/eKfdsp0pmojKV5GQkd5X0ol
         nY7hZKjQu2IDxXsK3WSiTlOESqGvbto002soYKJWM3rUqqK9AZpjMLF4YFxZf6T7Oeue
         b1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ws3BUjIflBOEGN9PJVX1rB9emMu/Hx6C/guR3YZ88CY=;
        b=MwpOpDfV/4hQeBsJKCZbwqyOVq8ymUMpPkdShsuoAun6aFAnV16QhBRIpopbvq+ubx
         APFua86JOm9nkaW+0C3FoqFBpwnLGcHmcj27TCWHmKQwZDP7DGawxXaR/usqUtZjDKDg
         gT5hJqxn0TZSOTuhlG0ucIQk8VWqworKsv0kc3HOA2mda9dNC14jd4qIZQwqiMY6LkOL
         AegNReWxcWMaqoTfme9IfrwYL2haQ6Sc4AK1or11oYNA/Mms4tnI/gL/owPGuz3R6ZTs
         41It3xx+WpvL9wbKw1Z+wl3Ssx6J5nbhE1pg2OaZbNQTP+fEoPirRZQcpZ3vE1DkwOPa
         W4Hg==
X-Gm-Message-State: AOAM531SJ6vtVi3prOHtsFsbpiJTcQQV+SZJLyJjY18spJZaWlBVRsdQ
        Cp/SBXlw35+wg96AdGFWxGLRifiFkmM2tfPkAejVBx7UiKb78w==
X-Google-Smtp-Source: ABdhPJx91tz07/lJJUkJ9gkskwlzt+DZ6u2vwkcw2EcJkEa7C7XeX0UfIJUfYpXxvFL46JAraFGjf8GzxRArcSpwXak=
X-Received: by 2002:a17:90b:fc4:: with SMTP id gd4mr3203582pjb.129.1601481312342;
 Wed, 30 Sep 2020 08:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <9152bb8be33e4192a7766eb53c6ca9af@asem.it> <CAMRc=McnsSkg-7UMp7pKaGX2wSqsZC2jQZV2zRepxm9UxGg=YA@mail.gmail.com>
 <CAHp75VfgEGydXN1A+Y=wn3iX1MbLhN8F9kYyfQwTZBJydr+0+Q@mail.gmail.com>
 <feb8567c830748c483c8c66dd4717003@asem.it> <CAHp75Vdd2QjvJvLGHa1x=RaSknEG+O+YB4eJA6+2htnZ=Gf52g@mail.gmail.com>
 <22753b53cd7d4dfba4ef3610f71cc462@asem.it> <20200930130113.GQ3956970@smile.fi.intel.com>
 <2c26adae711145639d0b982a354aff3c@asem.it>
In-Reply-To: <2c26adae711145639d0b982a354aff3c@asem.it>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 30 Sep 2020 18:54:50 +0300
Message-ID: <CAHp75Vcq1WOcMNoKpOSpCD1mFSyvYsaX-h7KHTaAOPe=6S4e0A@mail.gmail.com>
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

On Wed, Sep 30, 2020 at 6:39 PM Flavio Suligoi <f.suligoi@asem.it> wrote:
> > I guess you simply didn't get. The "gpio-line-names" property of GPIO
> > *controller* (provider!) and you are trying to do something with the
> > *consumer*
> > if I got it right.
> >
> > And of course GPIO line, which has name, has no difference in use from
> > another
> > w/o name assigned. You will need to request it by *consumer* either in
> > kernel
> > or in user space.
> >
> > To be more precise we have to look at your DSDT.

^^^^^^^ **DSDT**.

> My SSDT table is:

^^^^ See the difference? I can't help here.

> DefinitionBlock ("gpio_button.aml", "SSDT", 5, "ASEMsp", "GPIO_BTN", 1)
> {
>         External (_SB_.GPO1, DeviceObj)
>
>         Scope (\_SB.GPO1)
>         {
>                 Device (BTNS)
>                 {
>                         Name (_HID, "PRP0001")
>                         Name (_DDN, "GPIO buttons device")
>
>                         Name (_CRS, ResourceTemplate ()
>                         {
>                                 GpioIo (
>                                 Exclusive,               // Not shared
>                                 PullNone,                // No need for pulls
>                                 0,                       // Debounce timeout
>                                 0,                       // Drive strength
>                                 IoRestrictionInputOnly,  // Only used as input
>                                 "\\_SB.GPO1",            // GPIO controller
>                                 0, ResourceConsumer, , ) // Must be 0
>                                 {
>                                         1,              // GPIO number
>                                 }
>                         })
>
>                         Name (_DSD, Package () {
>                                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                                 Package () {
>                                         Package () {
>                                                 "gpio-line-names",
>                                                 Package () {
>                                                         "USER_PUSH_BUTTON",
>                                                 }
>                                         },
>                                 }
>                         })
>                 }
>         }
> }
>
> And the kernel messages, after loading the table, are:
>
> ACPI: Host-directed Dynamic ACPI Table Load:
> ACPI: SSDT 0xFFFF908274285200 0000E8 (v05 ASEMsp GPIO_BTN 00000001 INTL 20200717)
> ACPI: \_SB_.GPO1.BTNS: PRP0001 requires 'compatible' property
>
> So I need a "consumer", but I don't want to export the GPIO using its number...
> If you have any suggestion ...

Define "gpio-line-names" property in the *provider* (controller)
device node _DSD().

-- 
With Best Regards,
Andy Shevchenko
