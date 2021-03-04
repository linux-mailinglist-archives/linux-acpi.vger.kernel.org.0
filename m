Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487D932D6E0
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 16:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbhCDPmo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Mar 2021 10:42:44 -0500
Received: from mga17.intel.com ([192.55.52.151]:36184 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234547AbhCDPmP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 Mar 2021 10:42:15 -0500
IronPort-SDR: I0o75xxug6qz307Guf3oiwrbMrajXB1puf70auznAXtmPYafnxmJfh/BKxVvyFMA33jHD7jSpS
 uou8uW5vOL8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="167337101"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="167337101"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 07:40:30 -0800
IronPort-SDR: X2MxVutCeghJa3BAybKcnhWMBilxXYSGrizYLC4ZGPGkBV1pCHoyNmPr6JMtf54hPbJOlezw58
 3OuZFSq2OkDw==
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="384510284"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 07:40:28 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lHq5R-009uMc-Ao; Thu, 04 Mar 2021 17:40:25 +0200
Date:   Thu, 4 Mar 2021 17:40:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v1 4/4] gpiolib: Reuse device's fwnode to create IRQ
 domain
Message-ID: <YED/aRaxCgz15It/@smile.fi.intel.com>
References: <20210302153451.50593-1-andriy.shevchenko@linux.intel.com>
 <20210302153451.50593-4-andriy.shevchenko@linux.intel.com>
 <CACRpkdYjs7y=YMoQmFc2iXoMEtSAk7S+zYsz1Y=yPYw=97T+Nw@mail.gmail.com>
 <YD9YTGnFbmcnJKsR@smile.fi.intel.com>
 <CACRpkdYEd+zv36Ghet2WxNavV=1-RkR06c3OxBEoxCqXoAY3Zg@mail.gmail.com>
 <YEDROJcQLDlYkatS@smile.fi.intel.com>
 <CAJZ5v0jdF7Ro47kbWh2Hz1HH0781pv==OTNAxzkJWuEzbJyMew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jdF7Ro47kbWh2Hz1HH0781pv==OTNAxzkJWuEzbJyMew@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 04, 2021 at 02:41:24PM +0100, Rafael J. Wysocki wrote:
> On Thu, Mar 4, 2021 at 1:25 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Thu, Mar 04, 2021 at 09:06:08AM +0100, Linus Walleij wrote:
> > > On Wed, Mar 3, 2021 at 10:35 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Wed, Mar 03, 2021 at 10:22:02AM +0100, Linus Walleij wrote:
> > >
> > > > > But this:
> > > > >
> > > > > > @@ -1504,15 +1497,14 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
> > > > > >                         return ret;
> > > > > >         } else {
> > > > > >                 /* Some drivers provide custom irqdomain ops */
> > > > > > -               if (gc->irq.domain_ops)
> > > > > > -                       ops = gc->irq.domain_ops;
> > > > > > -
> > > > > > -               if (!ops)
> > > > > > -                       ops = &gpiochip_domain_ops;
> > > > > > -               gc->irq.domain = irq_domain_add_simple(np,
> > > > > > -                       gc->ngpio,
> > > > > > -                       gc->irq.first,
> > > > > > -                       ops, gc);
> > > > > > +               ops = gc->irq.domain_ops ?: &gpiochip_domain_ops;
> > > > > > +               if (gc->irq.first)
> > > > > > +                       gc->irq.domain = irq_domain_create_legacy(fwnode, gc->ngpio,
> > > > > > +                                                                 gc->irq.first, 0,
> > > > > > +                                                                 ops, gc);
> > > > > > +               else
> > > > > > +                       gc->irq.domain = irq_domain_create_linear(fwnode, gc->ngpio,
> > > > > > +                                                                 ops, gc);
> > > > >
> > > > > This looks like a refactoring and reimplementation of irq_domain_add_simple()?
> > > >
> > > > If you named it as irq_domain_create_simple(), then yes, but the problem is
> > > > that we don't have irq_domain_create_simple() API right now.
> > > >
> > > > > Why, and should it rather be a separate patch?
> > > >
> > > > Nope.
> > >
> > > OK I looked closer at irq_domain_add_simple(), and what it does different
> > > is to call irq_alloc_descs() for all lines if using sparse IRQs and then
> > > associate them. irq_domain_create_linear|legacy() does not allocate IRQ
> > > descriptors because it assumes something like DT or ACPI will do that
> > > on-demand when drivers request IRQs.
> > >
> > > This may be dangerous because some old platforms do not resolve IRQs
> > > at runtime and you will get NULL pointer exceptions.
> > >
> > > We then need to make sure all callers do what is done in e.g.
> > > drivers/gpio/gpio-omap.c in the #ifdef CONFIG_ARCH_OMAP1 clause:
> > > they need to be augmented to call irq_alloc_descs() explicitly,
> > > and I don't think all of them do it as nicely for us as OMAP1.
> > >
> > > I might be overly cautious though, however that is why this code
> > > uses irq_domain_add_simple(), came in commit
> > > commit 2854d167cc545d0642277bf8b77f972a91146fc6
> >
> > Ah, thanks! I was puzzled how and why the approach above had been extended like
> > now. This explains it. Okay, I will introduce irq_domain_create_simple().
> 
> OK
> 
> So please resend the series with that done and with the R-bys from
> Linus added.  I'll apply it from Patchwork.

Done!

https://lore.kernel.org/linux-gpio/20210304150215.80652-1-andriy.shevchenko@linux.intel.com/T/#u

P.S. you seems haven't switched yet to b4 :-)

-- 
With Best Regards,
Andy Shevchenko


