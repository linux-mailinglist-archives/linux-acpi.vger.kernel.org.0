Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE303ED3C0
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Aug 2021 14:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbhHPMPm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Aug 2021 08:15:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:30375 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229836AbhHPMPm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Aug 2021 08:15:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10077"; a="212728833"
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="212728833"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 05:15:10 -0700
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="422823966"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 05:15:08 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mFbWA-00ANwn-5g; Mon, 16 Aug 2021 15:15:02 +0300
Date:   Mon, 16 Aug 2021 15:15:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH regression fix v2] gpiolib: acpi: Make
 set-debounce-timeout failures non fatal
Message-ID: <YRpWxnZvM2kzjcX/@smile.fi.intel.com>
References: <20210816104119.75019-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816104119.75019-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 16, 2021 at 12:41:19PM +0200, Hans de Goede wrote:
> Commit 8dcb7a15a585 ("gpiolib: acpi: Take into account debounce settings")
> made the gpiolib-acpi code call gpio_set_debounce_timeout() when requesting
> GPIOs.
> 
> This in itself is fine, but it also made gpio_set_debounce_timeout()
> errors fatal, causing the requesting of the GPIO to fail. This is causing
> regressions. E.g. on a HP ElitePad 1000 G2 various _AEI specified GPIO
> ACPI event sources specify a debouncy timeout of 20 ms, but the
> pinctrl-baytrail.c only supports certain fixed values, the closest
> ones being 12 or 24 ms and pinctrl-baytrail.c responds with -EINVAL
> when specified a value which is not one of the fixed values.
> 
> This is causing the acpi_request_own_gpiod() call to fail for 3
> ACPI event sources on the HP ElitePad 1000 G2, which in turn is causing
> e.g. the battery charging vs discharging status to never get updated,
> even though a charger has been plugged-in or unplugged.
> 
> Make gpio_set_debounce_timeout() errors non fatal, warning about the
> failure instead, to fix this regression.
> 
> Note we should probably also fix various pinctrl drivers to just
> pick the first bigger discrete value rather then returning -EINVAL but
> this will need to be done on a per driver basis, where as this fix
> at least gets us back to where things were before and thus restores
> functionality on devices where this was lost due to
> gpio_set_debounce_timeout() errors.

Yes, I also think that we need to choose upper debounce instead of rejecting
the settings. And yes, I agree that for now it's not suitable as a fix.

That said,
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 8dcb7a15a585 ("gpiolib: acpi: Take into account debounce settings")
> Depends-on: 2e2b496cebef ("gpiolib: acpi: Extract acpi_request_own_gpiod() helper")
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Fix typo in commit msg
> -Add Mika's Reviewed-by
> -Add Depends-on tag
> ---
>  drivers/gpio/gpiolib-acpi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 411525ac4cc4..47712b6903b5 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -313,9 +313,11 @@ static struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
>  
>  	ret = gpio_set_debounce_timeout(desc, agpio->debounce_timeout);
>  	if (ret)
> -		gpiochip_free_own_desc(desc);
> +		dev_warn(chip->parent,
> +			 "Failed to set debounce-timeout for pin 0x%04X, err %d\n",
> +			 pin, ret);
>  
> -	return ret ? ERR_PTR(ret) : desc;
> +	return desc;
>  }
>  
>  static bool acpi_gpio_in_ignore_list(const char *controller_in, int pin_in)
> -- 
> 2.31.1
> 

-- 
With Best Regards,
Andy Shevchenko


