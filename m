Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49EA0F1AFB
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2019 17:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfKFQR5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Nov 2019 11:17:57 -0500
Received: from mga04.intel.com ([192.55.52.120]:7547 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727244AbfKFQR5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 6 Nov 2019 11:17:57 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 08:17:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="205377635"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 06 Nov 2019 08:17:54 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iSO0H-0005rh-K9; Wed, 06 Nov 2019 18:17:53 +0200
Date:   Wed, 6 Nov 2019 18:17:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 3/3] pinctrl: cherryview: Pass irqchip when adding
 gpiochip
Message-ID: <20191106161753.GN32742@smile.fi.intel.com>
References: <20191106154715.155596-1-hdegoede@redhat.com>
 <20191106154715.155596-4-hdegoede@redhat.com>
 <20191106161622.GM32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106161622.GM32742@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 06, 2019 at 06:16:22PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 06, 2019 at 04:47:15PM +0100, Hans de Goede wrote:
> > We need to convert all old gpio irqchips to pass the irqchip
> > setup along when adding the gpio_chip. For more info see
> > drivers/gpio/TODO.
> > 
> > For chained irqchips this is a pretty straight-forward conversion.
> 
> > +	chip->irq.chip = &pctrl->irqchip;
> 
> > +	if (pctrl->need_valid_mask)
> > +		chip->irq.init_valid_mask = chv_init_irq_valid_mask;
> 
> I just realize we probably may assign here unconditionally

Continuing...

> 
> > +	chip->irq.init_hw = chv_gpio_irq_init_hw;
> > +	chip->irq.parent_handler = chv_gpio_irq_handler;
> > +	chip->irq.num_parents = 1;
> > +	chip->irq.parents = &pctrl->irq;
> > +	chip->irq.default_type = IRQ_TYPE_NONE;
> > +	chip->irq.handler = handle_bad_irq;
> >  
> >  	if (!pctrl->need_valid_mask) {

And here turn it back to NULL and check the pointer against NULL instead of
additional variable.

What do you think?

-- 
With Best Regards,
Andy Shevchenko


