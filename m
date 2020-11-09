Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028F52AC6EC
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Nov 2020 22:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbgKIVTQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Nov 2020 16:19:16 -0500
Received: from mga12.intel.com ([192.55.52.136]:36683 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730902AbgKIVTP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 9 Nov 2020 16:19:15 -0500
IronPort-SDR: 32BWqyAfq9NvJhEYKIgKY6JAX+ap190LxHT6a/hqF+Wj8fQhL4JF04lnd5Qdm8SQ1Cl5A5RPMG
 xliGMOkygwKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="149153800"
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="scan'208";a="149153800"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 13:19:14 -0800
IronPort-SDR: 7ZE/xk+pL6sDX8Z7U8m1ioz1eTOhBAKlEP8/Q0D/uDPaccZv2R+03Pzx3FC4cu5oBziJKQTkhh
 DvjIbSUm3mog==
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="scan'208";a="529505748"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 13:19:11 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kcEaD-005Ilt-FZ; Mon, 09 Nov 2020 23:20:13 +0200
Date:   Mon, 9 Nov 2020 23:20:13 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lukasz Stelmach <l.stelmach@samsung.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v8 3/6] software node: implement reference properties
Message-ID: <20201109212013.GN4077@smile.fi.intel.com>
References: <20201109190245.GL4077@smile.fi.intel.com>
 <CGME20201109194725eucas1p2cc9357486879a14b2ad2f6ef968ff4b2@eucas1p2.samsung.com>
 <dleftjv9eenwhp.fsf%l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dleftjv9eenwhp.fsf%l.stelmach@samsung.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 09, 2020 at 08:47:14PM +0100, Lukasz Stelmach wrote:
> It was <2020-11-09 pon 21:02>, when Andy Shevchenko wrote:
> > On Mon, Nov 09, 2020 at 07:18:37PM +0100, Lukasz Stelmach wrote:
> >> It was <2020-11-09 pon 19:24>, when Andy Shevchenko wrote:
> >> > On Mon, Nov 09, 2020 at 06:02:29PM +0100, Lukasz Stelmach wrote:
> >> >> It was <2019-11-07 czw 20:22>, when Dmitry Torokhov wrote:

...

> > Create GPIO lookup table.
> >
> >> I could use platform_data to pass structures from configfs but
> >> software nodes would let me save some code in the device driver and use
> >> the same paths for both static (DT) and dynamic (configfs)
> >> configuration.
> >> 
> >> Probably I have missed something and I will be greatful, if you tell me
> >> where I can find more information about software nodes. There are few
> >> users in the kernel and it isn't obvious for me how to use software
> >> nodes properly.
> >
> > gpiod_add_lookup_table().
> >
> 
> Yes, that is exactly what my POC code does now. But having a lookup
> table together with the rest of the device structures has several
> advantages.
> 
> 1) The device may be hotpluggable and there is no
>    gpiod_remove_lookup_table().

	% git grep -n -w gpiod_remove_lookup_table

Or I did get it wrong? Did you mean that the removal is not being called?

> 2) Having the lookup table allocated and managed together with the rest
>    of the device seems like a better way to go than on gpio_lookup_list.

Nice, what are you going to do with the rest of lookup tables
(PWM, regulators, etc)? If you convert, convert them all at least.

> 3) As of now I've got a minor issue with device naming. I need to set
>    dev_id of the table before the device is ready and only after it is
>    ready, its name is set (in the hotpluggable use case).

Hotpluggable devices are very much supported by ACPI assistance. DT I have
heard has overlays. What's the issue?

> 4) Because no other devices would use this lookup table "publishing" it
>    rather than keeping together with the device seems at least slightly
>    odd.
> 
> When the lookup table is attached to the devices and can be passed
> around  the final lookup can be done with a function like
> 
> static struct gpio_desc *gpiod_find_from_table(struct device *dev,
>                              const char *con_id, unsigned int idx,
>                  unsigned long *flags, struct gpiod_lookup *table)

Something sounds fishy about your case. Why do you need to have board code /
platform data in the first place? Sorry, but I didn't get why you should
reconstruct DT (or ACPI) at run-time without using proper framework / feature
(overlays)?

> >>>> At the moment the driver gets the list from fwnode/of_node. The list
> >>>> contain references to phandles which get resolved and and the driver
> >>>> ends up with a bunch of gpio descriptors. Great.
> >>>> 
> >>>> This example looks nice but does the code that reads the reference from
> >>>> the gpios property and returns a gpiod actually exist? If it doesn't, I
> >>>> am willing to write it.
> >>>> 
> >>>> At first glance it makes more sense to me to pass (struct gpiod_lookup
> >>>> *) instead of (struct software_node *) and make gpiolib's gpiod_find()
> >>>> accept lookup tables as parameter instead of searching the
> >>>> gpio_lookup_list? Or do you think such temporary table should be
> >>>> assembled from the above structure and then used in gpiod_find()?
> >>>> 
> >>>> Any other suggestions on how to get a bunch of gpios (the description
> >>>> for gpios is available in the devicetree) for a device described with a
> >>>> software nodes?

-- 
With Best Regards,
Andy Shevchenko


