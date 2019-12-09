Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64DC11171E7
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Dec 2019 17:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfLIQhB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Dec 2019 11:37:01 -0500
Received: from mga12.intel.com ([192.55.52.136]:65260 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfLIQhB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 9 Dec 2019 11:37:01 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 08:37:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,296,1571727600"; 
   d="scan'208";a="244511160"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 09 Dec 2019 08:36:59 -0800
Received: from andy by smile with local (Exim 4.93-RC5)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ieM1q-00011F-Qo; Mon, 09 Dec 2019 18:36:58 +0200
Date:   Mon, 9 Dec 2019 18:36:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v3 1/2] gpio: sch: Add edge event support
Message-ID: <20191209163658.GL32742@smile.fi.intel.com>
References: <cover.1574277614.git.jan.kiszka@siemens.com>
 <42ae6149a14f81fd86c5acb5bd33e987123b6bed.1574277614.git.jan.kiszka@siemens.com>
 <20191122111219.GW32742@smile.fi.intel.com>
 <5d7399ce-1776-18ef-3bb5-6e3e8e7e7524@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d7399ce-1776-18ef-3bb5-6e3e8e7e7524@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 22, 2019 at 04:33:05PM +0100, Jan Kiszka wrote:
> On 22.11.19 12:12, Andy Shevchenko wrote:
> > On Wed, Nov 20, 2019 at 08:20:13PM +0100, Jan Kiszka wrote:

> > > +	switch (type & IRQ_TYPE_SENSE_MASK) {
> > > +	case IRQ_TYPE_EDGE_RISING:
> > > +		rising = 1;
> > > +		break;
> > > +	case IRQ_TYPE_EDGE_FALLING:
> > > +		falling = 1;
> > > +		break;
> > > +	case IRQ_TYPE_EDGE_BOTH:
> > > +		rising = 1;
> > > +		falling = 1;
> > > +		break;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}

> > Won't we need to set up IRQ handler here and use handle_bad_irq() during
> > initialization phase?
> 
> Why? This is just defining the edge type, not whether an interrupt could be
> generated or not. Also, we only have edge events here, so no reason to
> switch types.

OK.

> > > +	irq_base = devm_irq_alloc_descs(&pdev->dev, -1, 0, sch->chip.ngpio,
> > > +					NUMA_NO_NODE);
> > > +	if (irq_base < 0)
> > > +		return irq_base;
> > > +	sch->irq_base = irq_base;
> > > +
> > > +	gc = devm_irq_alloc_generic_chip(&pdev->dev, "sch_gpio", 1, irq_base,
> > > +					 NULL, handle_simple_irq);
> > > +	if (!gc)
> > > +		return -ENOMEM;
> > > +
> > > +	gc->private = sch;
> > > +	ct = gc->chip_types;
> > > +
> > > +	ct->chip.irq_mask = sch_irq_mask;
> > > +	ct->chip.irq_unmask = sch_irq_unmask;
> > > +	ct->chip.irq_set_type = sch_irq_type;
> > > +
> > > +	ret = devm_irq_setup_generic_chip(&pdev->dev, gc,
> > > +					  IRQ_MSK(sch->chip.ngpio),
> > > +					  0, IRQ_NOREQUEST | IRQ_NOPROBE, 0);
> > > +	if (ret)
> > > +		return ret;
> > 
> > Shan't we do this in the (similar) way how it's done in pinctrl-cherryview.c
> > driver? (Keep in mind later patches which are going to be v5.5)
> > 
> 
> Can you be a bit more specific for me? Do you mean the pattern
> gpiochip_irqchip_add / gpiochip_set_chained_irqchip? What would be the
> difference / benefit? And how would I link sch_sci_handler to that pattern?

Now we have struct irq_chip is part of GPIO chip, so, we may use it and supply
needed callbacks and settings before calling gpiochip_add_data().

Will it work in this case?

-- 
With Best Regards,
Andy Shevchenko


