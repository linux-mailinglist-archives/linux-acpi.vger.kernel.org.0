Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F5B3F47D9
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Aug 2021 11:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbhHWJmh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Aug 2021 05:42:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:43601 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235745AbhHWJmg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 23 Aug 2021 05:42:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10084"; a="239204043"
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="239204043"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 02:41:53 -0700
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="473029481"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 02:41:51 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mI6Sf-00CjTe-QX; Mon, 23 Aug 2021 12:41:45 +0300
Date:   Mon, 23 Aug 2021 12:41:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH regression fix v2] gpiolib: acpi: Make
 set-debounce-timeout failures non fatal
Message-ID: <YSNtWe6oEpULLMg7@smile.fi.intel.com>
References: <20210816104119.75019-1-hdegoede@redhat.com>
 <YRpWxnZvM2kzjcX/@smile.fi.intel.com>
 <e7c1b41a-4d11-21f4-0add-9b6dd00a8da6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7c1b41a-4d11-21f4-0add-9b6dd00a8da6@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 16, 2021 at 02:28:07PM +0200, Hans de Goede wrote:
> On 8/16/21 2:15 PM, Andy Shevchenko wrote:
> > On Mon, Aug 16, 2021 at 12:41:19PM +0200, Hans de Goede wrote:
> >> Commit 8dcb7a15a585 ("gpiolib: acpi: Take into account debounce settings")
> >> made the gpiolib-acpi code call gpio_set_debounce_timeout() when requesting
> >> GPIOs.
> >>
> >> This in itself is fine, but it also made gpio_set_debounce_timeout()
> >> errors fatal, causing the requesting of the GPIO to fail. This is causing
> >> regressions. E.g. on a HP ElitePad 1000 G2 various _AEI specified GPIO
> >> ACPI event sources specify a debouncy timeout of 20 ms, but the
> >> pinctrl-baytrail.c only supports certain fixed values, the closest
> >> ones being 12 or 24 ms and pinctrl-baytrail.c responds with -EINVAL
> >> when specified a value which is not one of the fixed values.
> >>
> >> This is causing the acpi_request_own_gpiod() call to fail for 3
> >> ACPI event sources on the HP ElitePad 1000 G2, which in turn is causing
> >> e.g. the battery charging vs discharging status to never get updated,
> >> even though a charger has been plugged-in or unplugged.
> >>
> >> Make gpio_set_debounce_timeout() errors non fatal, warning about the
> >> failure instead, to fix this regression.
> >>
> >> Note we should probably also fix various pinctrl drivers to just
> >> pick the first bigger discrete value rather then returning -EINVAL but
> >> this will need to be done on a per driver basis, where as this fix
> >> at least gets us back to where things were before and thus restores
> >> functionality on devices where this was lost due to
> >> gpio_set_debounce_timeout() errors.
> > 
> > Yes, I also think that we need to choose upper debounce instead of rejecting
> > the settings. And yes, I agree that for now it's not suitable as a fix.
> > 
> > That said,
> > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Thank you.
> 
> FYI, I've prepared a patch to choose the upper debounce time for
> pintctrl-baytrail . I'll test it when I'm back home tonight and
> then submit it upstream.

Bart, can you pick this up? Or do you expect me to send a PR with this one?

-- 
With Best Regards,
Andy Shevchenko


