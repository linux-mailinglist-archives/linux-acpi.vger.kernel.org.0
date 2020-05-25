Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDC61E109B
	for <lists+linux-acpi@lfdr.de>; Mon, 25 May 2020 16:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgEYOef (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 May 2020 10:34:35 -0400
Received: from mga17.intel.com ([192.55.52.151]:55421 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgEYOef (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 May 2020 10:34:35 -0400
IronPort-SDR: Szch+oLlLoMO1xcbw96Mu/R3ir6sMuhssyljNAgDXeBsvY9EFpFWo7FsLgSbH5i82xjfxg2bwf
 OCGK4zkZ/KJA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 07:34:34 -0700
IronPort-SDR: ahrCTI2fIpaKzytzviFWG8vietHpCJ3tWjxswDTDhOTp5oni3MZLwMiRWrxU0sK/lDHWoHvjsV
 sdzNkYpaSvPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,433,1583222400"; 
   d="scan'208";a="310017290"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 25 May 2020 07:34:33 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jdEBY-008ntX-GK; Mon, 25 May 2020 17:34:36 +0300
Date:   Mon, 25 May 2020 17:34:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 5/5] gpio: pca953x: Override GpioInt() pin for Intel
 Galileo Gen 2
Message-ID: <20200525143436.GC1634618@smile.fi.intel.com>
References: <20200520211916.25727-5-andriy.shevchenko@linux.intel.com>
 <20200525092028.GQ247495@lahna.fi.intel.com>
 <20200525093150.GL1634618@smile.fi.intel.com>
 <20200525094553.GR247495@lahna.fi.intel.com>
 <20200525101335.GN1634618@smile.fi.intel.com>
 <20200525110556.GT247495@lahna.fi.intel.com>
 <20200525113551.GR1634618@smile.fi.intel.com>
 <20200525122136.GV247495@lahna.fi.intel.com>
 <20200525130108.GU1634618@smile.fi.intel.com>
 <20200525134748.GW247495@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525134748.GW247495@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 25, 2020 at 04:47:48PM +0300, Mika Westerberg wrote:
> On Mon, May 25, 2020 at 04:01:08PM +0300, Andy Shevchenko wrote:
> > On Mon, May 25, 2020 at 03:21:36PM +0300, Mika Westerberg wrote:
> > > On Mon, May 25, 2020 at 02:35:51PM +0300, Andy Shevchenko wrote:
> > > > On Mon, May 25, 2020 at 02:05:56PM +0300, Mika Westerberg wrote:
> > > > > On Mon, May 25, 2020 at 01:13:35PM +0300, Andy Shevchenko wrote:
> > > > > > Due to parsing of ACPI tables. I don't want to copy'n'paste 25% of
> > > > > > gpiolib-acpi.c in here. I think provided solution is cleaner and (more)
> > > > > > flexible in terms of maintenance.
> > > > > 
> > > > > Hmm, you seem to pass a hard-coded pin number (1) to the core that then
> > > > > passes it back to the driver. Why you can't simple use that number here
> > > > > directly? You don't need to parse anything. What I'm missing? :-)
> > > > 
> > > > Okay, so, AFAIU you are proposing something like this:
> > > > 
> > > > 1) find a GPIO controller by the ACPI path (somehow, I guess by finding a
> > > >    handle followed by physical device behind it); 2) somehow to request a
> > > >    pin from that device by number;
> > > > 3) convert to IRQ and use.
> > > > 
> > > > Is it correct?
> > > 
> > > Well, no. In the first patch you do this:
> > > 
> > >   pin = lookup->info.quirks_data;
> > > 
> > > and this essentially becomes 1 so you know the pin number upfront in the
> > > driver. Why not simply get GPIO number 1 in the driver and use it as an
> > > interrupt? You know already that this particular board with the matching
> > > DMI identifier always uses the this number anyway.
> > 
> > But GPIO (relative!) number is not enough. We need to understand more, i.e.:
> > 1) from which GPIO controller it comes from (okay, for this particular platform I know it);
> > 2) which expander does have this resource (they all have same ACPI HID).
> > 
> > So, second one means to count GpioInt() resources (I don't remember if we have
> > helper for that, probably we can add one). For the first we need to get a GPIO
> > controller something (gpiochip?) And this first one I have no idea how we can
> > perform without talking to the core.
> > 
> > Basically, it may be done by reimplementing acpi_dev_gpio_irq_get(), followed
> > by acpi_get_gpiod_by_index(), followed by acpi_gpio_resource_lookup(), followed
> > by acpi_populate_gpio_lookup(), where at last this quirk should be applied.
> > 
> > It seems for me like an over duplicated solution.
> > 
> > I really don't understand how we can shortcut all these. What am I missing?
> 
> Why for example following would not work? If it is using global GPIO numbers
> anyway.

Because GPIO 1 above and below is not global?
Okay, what we have in the table seems global.
Let me see if this will fly.

> static int pca953x_acpi_interrupt_get_irq(struct device *dev)
> {
>         struct gpio_desc *desc;
>  
>         desc = gpio_to_desc(1);
>         if (!desc)

Okay, this seems have no deferred probe support, but I think it's fine,
it will be unlikely we will have for the certain platform the SoC's GPIO
controller enumerated after the IO expander one.

>                 return -ENODEV;
> 
>         return gpiod_to_irq(desc);
> }

-- 
With Best Regards,
Andy Shevchenko


