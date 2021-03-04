Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01E932CE1E
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 09:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbhCDIHZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Mar 2021 03:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235970AbhCDIHN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Mar 2021 03:07:13 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF180C061762
        for <linux-acpi@vger.kernel.org>; Thu,  4 Mar 2021 00:06:20 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b1so30909972lfb.7
        for <linux-acpi@vger.kernel.org>; Thu, 04 Mar 2021 00:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xhWBUgqe/0B8aWSBIXErOIoObcIFR5qF3dYFs5KNKag=;
        b=Q/8FIlfJhpDigw0JCabQmUyD6otiO8c7tobvJhzbqIC7XhhCO898BD1IiN835UivRn
         ko+MaLdDs6Uq4NM0VF6kiKuN4SMdplo+Z4slOU6pqvgMMxxWlPyhrSLDE9cAjv+gx2XE
         mT8Q1h2bQiUAE389ft+aW/FRvsSk3yOcbMyK75XWRgxDQoWphDPJbeBNyD74J29TJSQT
         VC8UI+eWZNiHUiqOPjrYb33OZd3wZYRIygzN6yvAwUNufEweF54jEQXARFyui69bkGxg
         T+Yo4Fsm/4RP0J/a5q3VggDhnmgT4F8HEo8EEo9BSIg4NgCcxTQ18oDJm5keAf/eFJDQ
         XL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xhWBUgqe/0B8aWSBIXErOIoObcIFR5qF3dYFs5KNKag=;
        b=oCZDAinntMm6Q9UsCfThxi/6T1gpQWf08BR6c7PZX250xP6Q5RyS3LyMG4CaR4xjXC
         bjUSjiYubT3rfYnWl3r6O59C5QIj8rHjHgAPbRhSNT/m0+ToBOFG+WjHdtRTK0yw9+KB
         2EsajzhCHNRsKgxzpmlvxqmVaLmxPuC3HKv8j1xMdxSVQGP0SEJnDYWAWunzoCJMtMRg
         GtlJlHgiF2eA2ws5Fn9++5Xq4NKSKuaUuL4/vaB8o2YPLTE4HcuybFkNMBlnODnn85xO
         D/hu8oEB4QnOzIq2oK2auAiyhQfpntyeI0mK/6j++3W4jOkj4QVnURTcjb2aFVj8kVai
         +Ujw==
X-Gm-Message-State: AOAM533Y6xiMRuyy1irpsd8FgG9YmK13wR8I9Mpo4u7Q3ADYj4URJIkW
        xNPBjcsk5iZshZoozI1R9t2RlsS/1nDaH6CWwVxQTINnAoNuH9zH
X-Google-Smtp-Source: ABdhPJzLTVA9gdRENm5ldKEbbb30Qq4mQjQpTBWVD6msTYk9Yb3g81iBN/tBzprb/oLKQXiHSMAMOa8AXyzr9kWiIyo=
X-Received: by 2002:ac2:4d95:: with SMTP id g21mr1693734lfe.29.1614845179473;
 Thu, 04 Mar 2021 00:06:19 -0800 (PST)
MIME-Version: 1.0
References: <20210302153451.50593-1-andriy.shevchenko@linux.intel.com>
 <20210302153451.50593-4-andriy.shevchenko@linux.intel.com>
 <CACRpkdYjs7y=YMoQmFc2iXoMEtSAk7S+zYsz1Y=yPYw=97T+Nw@mail.gmail.com> <YD9YTGnFbmcnJKsR@smile.fi.intel.com>
In-Reply-To: <YD9YTGnFbmcnJKsR@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Mar 2021 09:06:08 +0100
Message-ID: <CACRpkdYEd+zv36Ghet2WxNavV=1-RkR06c3OxBEoxCqXoAY3Zg@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] gpiolib: Reuse device's fwnode to create IRQ domain
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 3, 2021 at 10:35 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Wed, Mar 03, 2021 at 10:22:02AM +0100, Linus Walleij wrote:

> > But this:
> >
> > > @@ -1504,15 +1497,14 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
> > >                         return ret;
> > >         } else {
> > >                 /* Some drivers provide custom irqdomain ops */
> > > -               if (gc->irq.domain_ops)
> > > -                       ops = gc->irq.domain_ops;
> > > -
> > > -               if (!ops)
> > > -                       ops = &gpiochip_domain_ops;
> > > -               gc->irq.domain = irq_domain_add_simple(np,
> > > -                       gc->ngpio,
> > > -                       gc->irq.first,
> > > -                       ops, gc);
> > > +               ops = gc->irq.domain_ops ?: &gpiochip_domain_ops;
> > > +               if (gc->irq.first)
> > > +                       gc->irq.domain = irq_domain_create_legacy(fwnode, gc->ngpio,
> > > +                                                                 gc->irq.first, 0,
> > > +                                                                 ops, gc);
> > > +               else
> > > +                       gc->irq.domain = irq_domain_create_linear(fwnode, gc->ngpio,
> > > +                                                                 ops, gc);
> >
> > This looks like a refactoring and reimplementation of irq_domain_add_simple()?
>
> If you named it as irq_domain_create_simple(), then yes, but the problem is
> that we don't have irq_domain_create_simple() API right now.
>
> > Why, and should it rather be a separate patch?
>
> Nope.

OK I looked closer at irq_domain_add_simple(), and what it does different
is to call irq_alloc_descs() for all lines if using sparse IRQs and then
associate them. irq_domain_create_linear|legacy() does not allocate IRQ
descriptors because it assumes something like DT or ACPI will do that
on-demand when drivers request IRQs.

This may be dangerous because some old platforms do not resolve IRQs
at runtime and you will get NULL pointer exceptions.

We then need to make sure all callers do what is done in e.g.
drivers/gpio/gpio-omap.c in the #ifdef CONFIG_ARCH_OMAP1 clause:
they need to be augmented to call irq_alloc_descs() explicitly,
and I don't think all of them do it as nicely for us as OMAP1.

I might be overly cautious though, however that is why this code
uses irq_domain_add_simple(), came in commit
commit 2854d167cc545d0642277bf8b77f972a91146fc6

Yours,
Linus Walleij
