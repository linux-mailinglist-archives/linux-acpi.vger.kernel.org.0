Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFE42AC479
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Nov 2020 20:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbgKITBs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Nov 2020 14:01:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:32867 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbgKITBr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 9 Nov 2020 14:01:47 -0500
IronPort-SDR: C5BHEpvy+eVQUntqxm3LXxBEJQyuTgInrcafQFIoRT/GSKSHlf5TEZvYwEDMStTSiBnGcQPAcz
 AUt4ukrqrzeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="149703977"
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="scan'208";a="149703977"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 11:01:46 -0800
IronPort-SDR: mVqj0b7salhhAY1TlsagMbJd5HSsuyoA7wn9fxUgtGzkpn5v5qG+nYzSQlS1sCGAX+2AZAdtSd
 27XxX9IojKhw==
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="scan'208";a="322550834"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 11:01:43 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kcCRB-005Gnb-7p; Mon, 09 Nov 2020 21:02:45 +0200
Date:   Mon, 9 Nov 2020 21:02:45 +0200
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
Message-ID: <20201109190245.GL4077@smile.fi.intel.com>
References: <20201109172435.GJ4077@smile.fi.intel.com>
 <CGME20201109181851eucas1p241de8938e399c0b603c764593b057c41@eucas1p2.samsung.com>
 <dleftj4klypf5u.fsf%l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dleftj4klypf5u.fsf%l.stelmach@samsung.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 09, 2020 at 07:18:37PM +0100, Lukasz Stelmach wrote:
> It was <2020-11-09 pon 19:24>, when Andy Shevchenko wrote:
> > On Mon, Nov 09, 2020 at 06:02:29PM +0100, Lukasz Stelmach wrote:
> >> It was <2019-11-07 czw 20:22>, when Dmitry Torokhov wrote:

...

> >> I am writing a piece that needs to provide a list of gpios to a
> >> diriver. The above example looks like what I need.
> >
> > Nope.
> >
> > It mustn't be used for GPIOs or PWMs or whatever that either should come via
> > lookup tables or corresponding firmware interface.
> 
> May I ask why? I've read commit descriptions for drivers/base/swnode.c
> and the discussion on lkml and I understand software nodes as a way to
> provide (synthesize) a description for a device that is missing a
> description in the firmware. Another use case seems to be to replace (in
> the long run) platform data. That is what I am trying to use it for.

Yes. Both are correct. They are simply not applicable for everything
(it's not a silver bullet).

> I want my device to be configured with either DT or software_nodes
> created at run time with configfs.

Okay.

> My device is going to use GPIOs
> described in the DT and it is going to be configured via configfs at run
> time.

How is this related to swnodes?
Create GPIO lookup table.

> I could use platform_data to pass structures from configfs but
> software nodes would let me save some code in the device driver and use
> the same paths for both static (DT) and dynamic (configfs)
> configuration.
> 
> Probably I have missed something and I will be greatful, if you tell me
> where I can find more information about software nodes. There are few
> users in the kernel and it isn't obvious for me how to use software
> nodes properly.

gpiod_add_lookup_table().

> >> At the moment the driver gets the list from fwnode/of_node. The list
> >> contain references to phandles which get resolved and and the driver
> >> ends up with a bunch of gpio descriptors. Great.
> >> 
> >> This example looks nice but does the code that reads the reference from
> >> the gpios property and returns a gpiod actually exist? If it doesn't, I
> >> am willing to write it.
> >> 
> >> At first glance it makes more sense to me to pass (struct gpiod_lookup
> >> *) instead of (struct software_node *) and make gpiolib's gpiod_find()
> >> accept lookup tables as parameter instead of searching the
> >> gpio_lookup_list? Or do you think such temporary table should be
> >> assembled from the above structure and then used in gpiod_find()?
> >> 
> >> Any other suggestions on how to get a bunch of gpios (the description
> >> for gpios is available in the devicetree) for a device described with a
> >> software nodes?


-- 
With Best Regards,
Andy Shevchenko


