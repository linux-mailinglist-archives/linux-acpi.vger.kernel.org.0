Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8C3BA35E2
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Aug 2019 13:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfH3Lmb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Aug 2019 07:42:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:59451 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbfH3Lma (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Aug 2019 07:42:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 04:42:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,447,1559545200"; 
   d="scan'208";a="181183877"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 30 Aug 2019 04:42:27 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i3fIQ-00071d-4V; Fri, 30 Aug 2019 14:42:26 +0300
Date:   Fri, 30 Aug 2019 14:42:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Peter Cai <peter@typeblog.net>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 1/2] gpio: acpi: add quirk to override GpioInt polarity
Message-ID: <20190830114226.GW2680@smile.fi.intel.com>
References: <20190830000024.20384-1-peter@typeblog.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830000024.20384-1-peter@typeblog.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 30, 2019 at 08:00:23AM +0800, Peter Cai wrote:
> On GPD P2 Max, the firmware could not reset the touch panel correctly.
> The kernel needs to take on the job instead, but the GpioInt definition
> in DSDT specifies ActiveHigh while the GPIO pin should actually be
> ActiveLow.
> 
> We need to override the polarity defined by DSDT. The GPIO driver
> already allows defining polarity in acpi_gpio_params, but the option is
> not applied to GpioInt.
> 
> This patch adds a new quirk that enables the polarity specified in
> acpi_gpio_params to also be applied to GpioInt.

In general if it's really the case, I'm not objecting to have another quirk.
So, I would wait for the comments on the second patch to see how it's going.

>  include/linux/acpi.h        |  6 ++++++

The GPIO part of the header had been moved to the drivers/gpio/gpiolib-acpi.h.
Please, base your series on top of the gpio/for-next.

>  			lookup->info.flags = GPIOD_IN;
> -			lookup->info.polarity = agpio->polarity;

> +			if (lookup->info.quirks &
> +					ACPI_GPIO_QUIRK_OVERRIDE_POLARITY) {

Disregard checkpatch I would leave this on one line.

> +				dev_warn(&lookup->info.adev->dev, FW_BUG "Incorrect polarity specified by GpioInt, overriding.\n");
> +				lookup->info.polarity = lookup->active_low;
> +			} else {
> +				lookup->info.polarity = agpio->polarity;
> +			}
>  			lookup->info.triggering = agpio->triggering;

Since the quirk makes sense only for GpioInt and basically no-op for GpioIo,
I would move the check out of if (gpioint) {} else {} conditional:

	if (gpioint) {
		...
	} else {
		...
	}

	if (quirk) {
		dev_warn();
		polarity = ...;
	}

-- 
With Best Regards,
Andy Shevchenko


