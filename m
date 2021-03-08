Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3B33316A3
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Mar 2021 19:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhCHSwc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Mar 2021 13:52:32 -0500
Received: from mga03.intel.com ([134.134.136.65]:14730 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231202AbhCHSwG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Mar 2021 13:52:06 -0500
IronPort-SDR: EKFJfgfpgmYiSP2kNmeoZsDPHLo/HnKS7NQDv1Z8zeHoo0FLkqZ2cd1Mm8ttXpzGR3Yf9O07bL
 h6u2OQKab1ng==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="188137490"
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="188137490"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 10:52:05 -0800
IronPort-SDR: saYzE8XzAiPIOo4Iy0T/5YoXHttU6J8tRGgUNkE2jd9QPWaKRODXBD4CJjGgpyKSvDpBm8aL0h
 EcRnkkrxKVww==
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="509019540"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 10:52:02 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lJKz2-00At0a-0a; Mon, 08 Mar 2021 20:52:00 +0200
Date:   Mon, 8 Mar 2021 20:52:00 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 5/5] gpiolib: Reuse device's fwnode to create IRQ
 domain
Message-ID: <YEZyUJcjef5OekkJ@smile.fi.intel.com>
References: <20210304150215.80652-1-andriy.shevchenko@linux.intel.com>
 <20210304150215.80652-6-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0juZyx0f9L6erdNdmhFdJQ=Q9hPGatNEJm9v_oija=oiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0juZyx0f9L6erdNdmhFdJQ=Q9hPGatNEJm9v_oija=oiQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 08, 2021 at 07:32:47PM +0100, Rafael J. Wysocki wrote:
> On Thu, Mar 4, 2021 at 4:02 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > When IRQ domain is created for an ACPI case, the name of it becomes unknown-%d
> > since for now it utilizes of_node member only and doesn't consider fwnode case.
> > Convert IRQ domain creation code to utilize fwnode instead.
> >
> > Before/After the change on Intel Galileo Gen 2 with two GPIO (IRQ) controllers:
> >
> >   unknown-1     ==>     \_SB.PCI0.GIP0.GPO
> >   unknown-2     ==>     \_SB.NIO3

Thanks for review!

I'm wondering why you commented against v2 instead of v3... I assume it's just
a typo while the comments themselves are applicable to v3. Hence my reply
below.

...

> > -       if (WARN(np && type != IRQ_TYPE_NONE,
> > -                "%s: Ignoring %u default trigger\n", np->full_name, type))
> > +       if (WARN(fwnode && type != IRQ_TYPE_NONE,
> > +                "%pfw: Ignoring %u default trigger\n", fwnode, type))
> >                 type = IRQ_TYPE_NONE;
> >
> > -       if (has_acpi_companion(gc->parent) && type != IRQ_TYPE_NONE) {
> > -               acpi_handle_warn(ACPI_HANDLE(gc->parent),
> > -                                "Ignoring %u default trigger\n", type);
> > -               type = IRQ_TYPE_NONE;
> > -       }
> 
> Why is the above message not worth printing any more?  If there is a
> good enough reason, it would be good to mention it in the changelog.

The reason is good enough, we drop duplicated printing since we got fwnode in
either case DT or ACPI. Basically this part is unification and due to nature of
the whole change it can't be done separately.

I will do in v4.

...

> >                 /* Some drivers provide custom irqdomain ops */
> > -               if (gc->irq.domain_ops)
> > -                       ops = gc->irq.domain_ops;
> > -
> > -               if (!ops)
> > -                       ops = &gpiochip_domain_ops;
> 
> I'm guessing that the code above is replaced in order to avoid
> initializing ops to NULL, but IMO that should be a separate patch or
> at least the extra cleanup should be mentioned in the changelog.
> 
> Personally, I would do the essential change first and put all of the
> tangentially related cleanups into a separate follow-up patch.

Okay, I will split it to a separate clean up in v4.

...

While at it, can you then provide an immutable tag / branch that Bart and I may
inject into our repos?

-- 
With Best Regards,
Andy Shevchenko


