Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E79F6A5386
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2019 12:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbfIBKBr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 06:01:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:10307 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729808AbfIBKBr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Sep 2019 06:01:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 03:01:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,457,1559545200"; 
   d="scan'208";a="211644503"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 02 Sep 2019 03:01:42 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i4j9Z-0008GD-87; Mon, 02 Sep 2019 13:01:41 +0300
Date:   Mon, 2 Sep 2019 13:01:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Peter Cai <peter@typeblog.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 1/2] gpio: acpi: add quirk to override GpioInt polarity
Message-ID: <20190902100141.GW2680@smile.fi.intel.com>
References: <20190831030916.13172-1-peter@typeblog.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190831030916.13172-1-peter@typeblog.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Aug 31, 2019 at 11:09:14AM +0800, Peter Cai wrote:
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

Thank you for an update!

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

on the condition that Dmitry and other input / Goodix developers are okay with
the approach in general.

> 
> Signed-off-by: Peter Cai <peter@typeblog.net>
> ---
> 
> v2: rebased to gpio/for-next, moved quirk out of the gpioint
> conditional.
> ---
>  drivers/gpio/gpiolib-acpi.c   | 9 +++++++++
>  include/linux/gpio/consumer.h | 6 ++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index fdee8afa5339..ab16ea61a8fa 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -603,6 +603,15 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
>  			lookup->info.flags = acpi_gpio_to_gpiod_flags(agpio);
>  			lookup->info.polarity = lookup->active_low;
>  		}
> +
> +		/*
> +		 * Override the polarity specified by GpioInt if
> +		 * ACPI_GPIO_QUIRK_OVERRIDE_POLARITY is set.
> +		 */
> +		if (lookup->info.quirks & ACPI_GPIO_QUIRK_OVERRIDE_POLARITY) {
> +			dev_warn(&lookup->info.adev->dev, FW_BUG "Incorrect polarity specified by GpioInt, overriding.\n");
> +			lookup->info.polarity = lookup->active_low;
> +		}
>  	}
>  
>  	return 1;
> diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
> index b70af921c614..7e9f24ebb085 100644
> --- a/include/linux/gpio/consumer.h
> +++ b/include/linux/gpio/consumer.h
> @@ -622,6 +622,12 @@ struct acpi_gpio_mapping {
>   * get GpioIo type explicitly, this quirk may be used.
>   */
>  #define ACPI_GPIO_QUIRK_ONLY_GPIOIO		BIT(1)
> +/*
> + * Use the GPIO polarity (ActiveHigh / ActiveLow) from acpi_gpio_params
> + * for GpioInt as well. The default behavior is to use the one specified
> + * by GpioInt, which can be incorrect on some devices.
> + */
> +#define ACPI_GPIO_QUIRK_OVERRIDE_POLARITY	BIT(2)
>  
>  	unsigned int quirks;
>  };
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko


