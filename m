Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A507532D462
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 14:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241437AbhCDNmn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Mar 2021 08:42:43 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:33947 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241435AbhCDNmQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Mar 2021 08:42:16 -0500
Received: by mail-ot1-f51.google.com with SMTP id h10so16586563otm.1;
        Thu, 04 Mar 2021 05:42:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=adr2A02C2ODe/GaRHmNeDmesx1atf5kI628+vx2QNc8=;
        b=iMORlcUzsARoighOCNzGW5kOTDFZYb7xB7Iio4Ep9J785RHZR/47trW/7L2gdTYYEy
         AYzFQP24HK4Hx7oH+3hZYla3GU9mYIfrWgpbiAkvONNTf/5TlQcZSZL9fZi1wzOoCzPx
         GscIhH5nrHcTihUrM0I/XqSls9BmFyU+duJfshT5M7hYhIpDBSOZLrYjIA0VuEOPt7Pd
         MjOCfn1m+jEyNJx/LPRvl5E3e9f+K5EhLowHIkKDFt7vGJKPi39P8vea4Q9GM/ceguWu
         +FLfu1PluX9a43hq9Va+xGvPMMkDHqik48mTvIdizCofGFXfQMRevQLSC4K84VUmK/Rs
         HpTA==
X-Gm-Message-State: AOAM532+kquAB9+ww1wgG8ViZUkgnUdQR/r1mh7VCTgGV6JJsPbt0+nW
        AU1CpcXbtBNyfbhCO0C/aGa4UGfMCU1C2qQI8Wg=
X-Google-Smtp-Source: ABdhPJzCEF2ArS3PqCCa18MbS8XtkgKjz5QmaIw6cP6KDzoL/C7t/bm9s4LxiIJSjxuMcKyQC8kHbSGAoPdTRkyXPoI=
X-Received: by 2002:a9d:4d17:: with SMTP id n23mr3027661otf.321.1614865295136;
 Thu, 04 Mar 2021 05:41:35 -0800 (PST)
MIME-Version: 1.0
References: <20210302153451.50593-1-andriy.shevchenko@linux.intel.com>
 <20210302153451.50593-4-andriy.shevchenko@linux.intel.com>
 <CACRpkdYjs7y=YMoQmFc2iXoMEtSAk7S+zYsz1Y=yPYw=97T+Nw@mail.gmail.com>
 <YD9YTGnFbmcnJKsR@smile.fi.intel.com> <CACRpkdYEd+zv36Ghet2WxNavV=1-RkR06c3OxBEoxCqXoAY3Zg@mail.gmail.com>
 <YEDROJcQLDlYkatS@smile.fi.intel.com>
In-Reply-To: <YEDROJcQLDlYkatS@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Mar 2021 14:41:24 +0100
Message-ID: <CAJZ5v0jdF7Ro47kbWh2Hz1HH0781pv==OTNAxzkJWuEzbJyMew@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] gpiolib: Reuse device's fwnode to create IRQ domain
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 4, 2021 at 1:25 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Mar 04, 2021 at 09:06:08AM +0100, Linus Walleij wrote:
> > On Wed, Mar 3, 2021 at 10:35 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Wed, Mar 03, 2021 at 10:22:02AM +0100, Linus Walleij wrote:
> >
> > > > But this:
> > > >
> > > > > @@ -1504,15 +1497,14 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
> > > > >                         return ret;
> > > > >         } else {
> > > > >                 /* Some drivers provide custom irqdomain ops */
> > > > > -               if (gc->irq.domain_ops)
> > > > > -                       ops = gc->irq.domain_ops;
> > > > > -
> > > > > -               if (!ops)
> > > > > -                       ops = &gpiochip_domain_ops;
> > > > > -               gc->irq.domain = irq_domain_add_simple(np,
> > > > > -                       gc->ngpio,
> > > > > -                       gc->irq.first,
> > > > > -                       ops, gc);
> > > > > +               ops = gc->irq.domain_ops ?: &gpiochip_domain_ops;
> > > > > +               if (gc->irq.first)
> > > > > +                       gc->irq.domain = irq_domain_create_legacy(fwnode, gc->ngpio,
> > > > > +                                                                 gc->irq.first, 0,
> > > > > +                                                                 ops, gc);
> > > > > +               else
> > > > > +                       gc->irq.domain = irq_domain_create_linear(fwnode, gc->ngpio,
> > > > > +                                                                 ops, gc);
> > > >
> > > > This looks like a refactoring and reimplementation of irq_domain_add_simple()?
> > >
> > > If you named it as irq_domain_create_simple(), then yes, but the problem is
> > > that we don't have irq_domain_create_simple() API right now.
> > >
> > > > Why, and should it rather be a separate patch?
> > >
> > > Nope.
> >
> > OK I looked closer at irq_domain_add_simple(), and what it does different
> > is to call irq_alloc_descs() for all lines if using sparse IRQs and then
> > associate them. irq_domain_create_linear|legacy() does not allocate IRQ
> > descriptors because it assumes something like DT or ACPI will do that
> > on-demand when drivers request IRQs.
> >
> > This may be dangerous because some old platforms do not resolve IRQs
> > at runtime and you will get NULL pointer exceptions.
> >
> > We then need to make sure all callers do what is done in e.g.
> > drivers/gpio/gpio-omap.c in the #ifdef CONFIG_ARCH_OMAP1 clause:
> > they need to be augmented to call irq_alloc_descs() explicitly,
> > and I don't think all of them do it as nicely for us as OMAP1.
> >
> > I might be overly cautious though, however that is why this code
> > uses irq_domain_add_simple(), came in commit
> > commit 2854d167cc545d0642277bf8b77f972a91146fc6
>
> Ah, thanks! I was puzzled how and why the approach above had been extended like
> now. This explains it. Okay, I will introduce irq_domain_create_simple().

OK

So please resend the series with that done and with the R-bys from
Linus added.  I'll apply it from Patchwork.

Thanks!
