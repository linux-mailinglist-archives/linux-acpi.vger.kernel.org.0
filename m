Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301FF32C433
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 01:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382391AbhCDALo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Mar 2021 19:11:44 -0500
Received: from mga18.intel.com ([134.134.136.126]:57467 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357260AbhCCKtM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Mar 2021 05:49:12 -0500
IronPort-SDR: ITl52kVMyquAggf4WUUYMQpDS3cejhGJHYNBAINoQzq0+HOgoOhwzie/6JLQ0VxLBBLn9MGOJl
 cVFDde6GzP9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="174791953"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="174791953"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 01:35:12 -0800
IronPort-SDR: YBDaTUXqLyRMtmbMNfaclOX5T6CSs+tGX7QJIdiXXZnPQmzKRJWkAuJY/gZ4+xL9g14llWXUk1
 0jeTK56el7Zw==
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="445184452"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 01:35:11 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lHNuO-009bZz-Kp; Wed, 03 Mar 2021 11:35:08 +0200
Date:   Wed, 3 Mar 2021 11:35:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v1 4/4] gpiolib: Reuse device's fwnode to create IRQ
 domain
Message-ID: <YD9YTGnFbmcnJKsR@smile.fi.intel.com>
References: <20210302153451.50593-1-andriy.shevchenko@linux.intel.com>
 <20210302153451.50593-4-andriy.shevchenko@linux.intel.com>
 <CACRpkdYjs7y=YMoQmFc2iXoMEtSAk7S+zYsz1Y=yPYw=97T+Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYjs7y=YMoQmFc2iXoMEtSAk7S+zYsz1Y=yPYw=97T+Nw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 03, 2021 at 10:22:02AM +0100, Linus Walleij wrote:
> On Tue, Mar 2, 2021 at 4:35 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > When IRQ domain is created for an ACPI case, the name of it becomes unknown-%d
> > since for now it utilizes of_node member only and doesn't consider fwnode case.
> > Convert IRQ domain creation code to utilize fwnode instead.
> >
> > Before/After the change on Intel Galileo Gen 2 with two GPIO (IRQ) controllers:
> >
> >   unknown-1     ==>     \_SB.PCI0.GIP0.GPO
> >   unknown-2     ==>     \_SB.NIO3
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> This first part seems to do what you want,

...

> But this:
> 
> > @@ -1504,15 +1497,14 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
> >                         return ret;
> >         } else {
> >                 /* Some drivers provide custom irqdomain ops */
> > -               if (gc->irq.domain_ops)
> > -                       ops = gc->irq.domain_ops;
> > -
> > -               if (!ops)
> > -                       ops = &gpiochip_domain_ops;
> > -               gc->irq.domain = irq_domain_add_simple(np,
> > -                       gc->ngpio,
> > -                       gc->irq.first,
> > -                       ops, gc);
> > +               ops = gc->irq.domain_ops ?: &gpiochip_domain_ops;
> > +               if (gc->irq.first)
> > +                       gc->irq.domain = irq_domain_create_legacy(fwnode, gc->ngpio,
> > +                                                                 gc->irq.first, 0,
> > +                                                                 ops, gc);
> > +               else
> > +                       gc->irq.domain = irq_domain_create_linear(fwnode, gc->ngpio,
> > +                                                                 ops, gc);
> 
> This looks like a refactoring and reimplementation of irq_domain_add_simple()?

If you named it as irq_domain_create_simple(), then yes, but the problem is
that we don't have irq_domain_create_simple() API right now.

> Why, and should it rather be a separate patch?

Nope.

-- 
With Best Regards,
Andy Shevchenko


