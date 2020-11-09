Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D850A2AC217
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Nov 2020 18:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbgKIRXh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Nov 2020 12:23:37 -0500
Received: from mga02.intel.com ([134.134.136.20]:43094 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730315AbgKIRXh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 9 Nov 2020 12:23:37 -0500
IronPort-SDR: xxlME6wkNqhOqBF4UxtsSs4VFuysoUXgxnCqAne18ZzkNtnC8rr7IaOm8rUlHUucsF09DIA7JX
 mSWpy6rVyLNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="156845543"
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="156845543"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 09:23:36 -0800
IronPort-SDR: 8onsfZOFzt4e0C2bbif6I2wUeGTYo+Lq+K3T8j9WoPRkkUACsHwlLWexCCK0F66sxp7bq950hV
 deZvTmVWgoGg==
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="327337190"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 09:23:33 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kcAuB-005F9X-8Q; Mon, 09 Nov 2020 19:24:35 +0200
Date:   Mon, 9 Nov 2020 19:24:35 +0200
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
Message-ID: <20201109172435.GJ4077@smile.fi.intel.com>
References: <20191108042225.45391-1-dmitry.torokhov@gmail.com>
 <20191108042225.45391-4-dmitry.torokhov@gmail.com>
 <CGME20201109170241eucas1p14c2156334d8c6ef15d52664fa4776f41@eucas1p1.samsung.com>
 <dleftjeel2pioq.fsf%l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dleftjeel2pioq.fsf%l.stelmach@samsung.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 09, 2020 at 06:02:29PM +0100, Lukasz Stelmach wrote:
> It was <2019-11-07 czw 20:22>, when Dmitry Torokhov wrote:
> > It is possible to store references to software nodes in the same fashion as
> > other static properties, so that users do not need to define separate
> > structures:
> >
> > static const struct software_node gpio_bank_b_node = {
> > 	.name = "B",
> > };
> >
> > static const struct property_entry simone_key_enter_props[] = {
> > 	PROPERTY_ENTRY_U32("linux,code", KEY_ENTER),
> > 	PROPERTY_ENTRY_STRING("label", "enter"),
> > 	PROPERTY_ENTRY_REF("gpios", &gpio_bank_b_node, 123, GPIO_ACTIVE_LOW),
> > 	{ }
> > };
> >
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> 
> I am writing a piece that needs to provide a list of gpios to a
> diriver. The above example looks like what I need.

Nope.

It mustn't be used for GPIOs or PWMs or whatever that either should come via
lookup tables or corresponding firmware interface.

> At the moment the driver gets the list from fwnode/of_node. The list
> contain references to phandles which get resolved and and the driver
> ends up with a bunch of gpio descriptors. Great.
> 
> This example looks nice but does the code that reads the reference from
> the gpios property and returns a gpiod actually exist? If it doesn't, I
> am willing to write it.
> 
> At first glance it makes more sense to me to pass (struct gpiod_lookup
> *) instead of (struct software_node *) and make gpiolib's gpiod_find()
> accept lookup tables as parameter instead of searching the
> gpio_lookup_list? Or do you think such temporary table should be
> assembled from the above structure and then used in gpiod_find()?
> 
> Any other suggestions on how to get a bunch of gpios (the description
> for gpios is available in the devicetree) for a device described with a
> software nodes?



-- 
With Best Regards,
Andy Shevchenko


