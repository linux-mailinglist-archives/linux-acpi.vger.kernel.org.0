Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7263317A9
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Mar 2021 20:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhCHTr3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Mar 2021 14:47:29 -0500
Received: from mga03.intel.com ([134.134.136.65]:19430 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231359AbhCHTrB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Mar 2021 14:47:01 -0500
IronPort-SDR: 8a6Gy817vVGdqtLyaA93YG0tib4ikmY87sLdBKAmAU47A0jMj70PjI8oIM3qKy49z1Zw1jahok
 CsEg6DmpOrGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="188146707"
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="188146707"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 11:46:58 -0800
IronPort-SDR: WFHMVjICJe1SO4Iujnl4wSVfn3+Q4R+wvhAg4Xte7WtqXBdwNZ/S/yfwA5CnMAxVc2JYLjW6j8
 wW5cr/noiAbg==
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="402942724"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 11:46:55 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lJLq8-00Atlp-NQ; Mon, 08 Mar 2021 21:46:52 +0200
Date:   Mon, 8 Mar 2021 21:46:52 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 2/2] gpiolib: Fold conditionals into simple ternary
 operator
Message-ID: <YEZ/LFwFkh3+zyjY@smile.fi.intel.com>
References: <20210308193146.65585-1-andriy.shevchenko@linux.intel.com>
 <20210308193146.65585-2-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gpNzyBDKfBXoBYskUXs15GrZAe-E2vzhSEu2Nrj7wa7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gpNzyBDKfBXoBYskUXs15GrZAe-E2vzhSEu2Nrj7wa7g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 08, 2021 at 08:43:19PM +0100, Rafael J. Wysocki wrote:
> On Mon, Mar 8, 2021 at 8:33 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> It looks like the ops local var is redundant.
> 
> >         unsigned int type;
> >         unsigned int i;
> >
> > @@ -1496,11 +1496,7 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
> >                         return ret;
> >         } else {
> >                 /* Some drivers provide custom irqdomain ops */
> > -               if (gc->irq.domain_ops)
> > -                       ops = gc->irq.domain_ops;
> > -
> > -               if (!ops)
> > -                       ops = &gpiochip_domain_ops;
> > +               ops = gc->irq.domain_ops ?: &gpiochip_domain_ops;
> >                 gc->irq.domain = irq_domain_create_simple(fwnode,
> >                         gc->ngpio,
> >                         gc->irq.first,
> 
> Because this can be
> 
> gc->irq.domain = irq_domain_add_simple(np,
>                         gc->ngpio,
>                         gc->irq.first,
>                         gc->irq.domain_ops ?: &gpiochip_domain_ops,
>                         gc);
> 
> (modulo white space / formatting) and this is the only place where ops
> is used in this function.

I just sent v5 without this, sorry :-)

-- 
With Best Regards,
Andy Shevchenko


