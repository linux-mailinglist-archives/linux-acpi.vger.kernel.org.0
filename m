Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A4532A4D3
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Mar 2021 16:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446543AbhCBLSM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Mar 2021 06:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349576AbhCBKhi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Mar 2021 05:37:38 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0F2C061788;
        Tue,  2 Mar 2021 02:36:53 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o6so1675756pjf.5;
        Tue, 02 Mar 2021 02:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Vqts+Y6tU5JlZtaqTaxYb8shAldX5e9jPaXvyVTlmQ=;
        b=Efjy9B54Nbpl5uaNVzclCnD0PYT9HshjxuF9mE4IZ/YRAKtcW637fOMzI9e6O1GArh
         OPDv0CFnCmHxeGl62gfIleqAL/tiCaz2s/wu8S5MEHFYv1GmZeECu814epFR9ACdW01k
         j0Sv1+r4gj2MX5aBggR39adT+WyUi9S/ab7/pobBBjzcEljIlfFJcWCH01ZKxB9ovhHS
         DqzKXigYAzAf6HoiibBypPPj52NX5kG5kIczxc7nh9XISopagR3DS7ARLLQO7tOMe6+C
         pM8YKqpzc2/O1y8TAbfnnLP/ph/49Knbmd18jiLwPmXjXjLLhp2bFvPSD0K/TbASIXVS
         WBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Vqts+Y6tU5JlZtaqTaxYb8shAldX5e9jPaXvyVTlmQ=;
        b=rHAEhROY4ZuOlrtPYWylYaxjY1jCbHA4FKlEl8FAKTDs1aVICJmK0yAeRe+IfwPRgO
         lzt17tEqfkDcGlfyo6ckOIM0AY7OKDgAfj9TS6p5DK6Im5oZSQzKyms8+1zTJH3Cxgl5
         k3YYWXGa0v1an61s7t1v8R56rmXbOPpbodsJ48FJQ7+T8Ht4tmxBHjXmH8Z9ZNVdP50F
         aPxMitiksodJg+Kp53itf5CDN2zbqDfubh6t/9SRlEbomz3XjYd8zRm13BmUkAZC4pg4
         oxFRayhYekQ6byTo8SGQ0fxG/ssvPcuBdTXS7wWzuRUc5ExOJA5h4IWaYo8pyYKolNRH
         Fvzw==
X-Gm-Message-State: AOAM533oVKxq1QbZrxfJMpJbpel8SA/OlgKc8dvFGMETo7V3bku2VaOW
        GyVYL4kdkBnphUMkCfnwQsBnG3/PyKMSPkUwWEfNPTH6YMs0hQ==
X-Google-Smtp-Source: ABdhPJx6SGdcjo6z1rRg9zSmWlvTX2PAEcXPcx8trpX5wRAmPMLlbOmox9nSaP0oiqJ32xJGM4hJDUboXtPZ5cYV8sk=
X-Received: by 2002:a17:902:d712:b029:e4:951d:a465 with SMTP id
 w18-20020a170902d712b02900e4951da465mr3123883ply.0.1614681413048; Tue, 02 Mar
 2021 02:36:53 -0800 (PST)
MIME-Version: 1.0
References: <20210226033919.8871-1-shawn.guo@linaro.org> <CAHp75Vcb=NO9OWjSpBeVC4c+9=aXE=yiDWVBwLD1DnzwdgFD6Q@mail.gmail.com>
 <20210226093925.GA24428@dragon> <CAHp75Vc6xYv+197SOrSefQHD2h4Xy_N20gQajW4uF2PU=sJfLg@mail.gmail.com>
 <20210227034641.GC24428@dragon> <YDzb5llywkzbGEF+@smile.fi.intel.com> <20210302004446.GF24428@dragon>
In-Reply-To: <20210302004446.GF24428@dragon>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 2 Mar 2021 12:36:36 +0200
Message-ID: <CAHp75Vek7PmFDgCv+d_N9C5gX0QDh7GTAO8wyu=EAur77xg_Zw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: support override broken GPIO number in
 ACPI table
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 2, 2021 at 2:44 AM Shawn Guo <shawn.guo@linaro.org> wrote:
> On Mon, Mar 01, 2021 at 02:19:50PM +0200, Andy Shevchenko wrote:
> > On Sat, Feb 27, 2021 at 11:46:42AM +0800, Shawn Guo wrote:
> > > On Fri, Feb 26, 2021 at 12:57:37PM +0200, Andy Shevchenko wrote:
> > > > On Fri, Feb 26, 2021 at 11:39 AM Shawn Guo <shawn.guo@linaro.org> wrote:
> > > > > On Fri, Feb 26, 2021 at 11:12:07AM +0200, Andy Shevchenko wrote:
> > > > > > On Fri, Feb 26, 2021 at 5:42 AM Shawn Guo <shawn.guo@linaro.org> wrote:
> > > > > > >
> > > > > > > Running kernel with ACPI on Lenovo Flex 5G laptop, touchpad is just
> > > > > > > not working.  That's because the GpioInt number of TSC2 node in ACPI
> > > > > > > table is simply wrong, and the number even exceeds the maximum GPIO
> > > > > > > lines.  As the touchpad works fine with Windows on the same machine,
> > > > > > > presumably this is something Windows-ism.  Although it's obviously
> > > > > > > a specification violation, believe of that Microsoft will fix this in
> > > > > > > the near future is not really realistic.
> > > > > > >
> > > > > > > It adds the support of overriding broken GPIO number in ACPI table
> > > > > > > on particular machines, which are matched using DMI info.  Such
> > > > > > > mechanism for fixing up broken firmware and ACPI table is not uncommon
> > > > > > > in kernel.  And hopefully it can be useful for other machines that get
> > > > > > > broken GPIO number coded in ACPI table.
> > > > > >
> > > > > > Thanks for the report and patch.
> > > > > >
> > > > > > First of all, have you reported the issue to Lenovo? At least they
> > > > > > will know that they did wrong.
> > > > >
> > > > > Yes, we are reporting this to Lenovo, but to be honest, we are not sure
> > > > > how much they will care about it, as they are shipping the laptop with
> > > > > Windows only.
> > > > >
> > > > > > Second, is it possible to have somewhere output of `acpidump -o
> > > > > > flex5g.dat` (the flex5g.dat file)?
> > > > >
> > > > > https://raw.githubusercontent.com/aarch64-laptops/build/master/misc/lenovo-flex-5g/dsdt.dsl
> > > > >
> > > > > > And as Mika said once to one of mine patches "since you know the
> > > > > > number ahead there is no need to pollute GPIO ACPI library core with
> > > > > > this quirk". But in any case I would like to see the ACPI tables
> > > > > > first.
> > > > >
> > > > > Oh, so you had something similar already?  Could you point me to the
> > > > > patch and discussion?
> > > >
> > > > Similar, but might be not the same:
> > > >  - patches in the upstream [1] (v3 applied), discussion [2]
> > > >  - new version with some additional fixes [3]
> > >
> > > Thanks for all the pointers.  It looks to me that it's the same problem
> > > - the GPIO number in ACPI table is broken and needs an override from
> > > kernel.
> >
> > Not exactly. On Galileo Gen 2 platform it's broken in understandable way.
> > In your case it's different and I'm not sure at all that's considered "broken"
> > in the MS' eyes.
>
> At least, I was told by Jeffrey that MS admits this is something needs
> to be fixed in the future.

Yes, but as far as I understand we have already this firmware in the
wild, so we will have users stuck with it...

> > > So I think what we need is a generic solution to a problem
> > > not uncommon.  Rather than asking all different drivers to resolve the
> > > same problem all over the kernel, I believe GPIO ACPI library is just
> > > the right place.
> > >
> > > Looking at your platform and problem, I realise that to be a generic
> > > solution, my patch needs an additional device identification matching,
> > > as one GPIO number that is broken for one device could be correct for
> > > another.  I will improve it, so that your problem can be resolved by
> > > simply adding a new entry to acpi_gpio_pin_override_table[].
> >
> > Before any steps further I really want to see more information about that IP
> > and how firmware applied the numbering scheme.
>
> Deduced by those working GPIO numbers in ACPI table and how Linux kernel
> is working, I think the GPIO is numbered without any bank thing.  All
> available pins are just numbered linearly, and every pin can be
> configured in GPIO mode.

Can you be absolutely sure? If you have banks (MS core code since the
laptop runs Windows uses what is described on their site for GPIOs)
linear and then you test pins at the beginning of the region, you
won't have issues, you need to find a pin in each tile wishfully at
the end of it and test.

Better and easier way of course to ask MS to provide an insight on this.

> > If it's confidential, you may sent any insights privately.
>
> Unfortunately, all those documents are confidential to me as well.

Okay, since we have no solid proof of what's going on there, I prefer
for now not to touch GPIO ACPI core and do this quirk in the driver
(using standard methods: DMI strings / ACPI IDs / etc).

Otherwise I'm not convinced that we need a global quirk for that and
it might be needed in the future.

-- 
With Best Regards,
Andy Shevchenko
