Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0118F45E2A8
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Nov 2021 22:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhKYVpC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Nov 2021 16:45:02 -0500
Received: from mga07.intel.com ([134.134.136.100]:64459 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234325AbhKYVnB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Nov 2021 16:43:01 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="298976516"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="298976516"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 13:39:49 -0800
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="457973408"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 13:39:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1mqMT3-00AbEy-9V;
        Thu, 25 Nov 2021 23:39:45 +0200
Date:   Thu, 25 Nov 2021 23:39:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Do not set the IRQ type if the IRQ is
 already in use
Message-ID: <YaACofzJO2/bckS3@smile.fi.intel.com>
References: <20211125203010.825442-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125203010.825442-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 25, 2021 at 09:30:10PM +0100, Hans de Goede wrote:
> If the IRQ is already in use, then acpi_dev_gpio_irq_get_by() really
> should not change the type underneath the current owner.
> 
> I specifically hit an issue with this an a Chuwi Hi8 Super (CWI509) Bay
> Trail tablet, when the Boot OS selection in the BIOS is set to Android.
> In this case _STA for a MAX17047 ACPI I2C device wrongly returns 0xf and
> the _CRS resources for this device include a GpioInt pointing to a GPIO
> already in use by an _AEI handler, with a different type then specified
> in the _CRS for the MAX17047 device. Leading to the acpi_dev_gpio_irq_get()
> call done by the i2c-core-acpi.c code changing the type breaking the
> _AEI handler.
> 
> Now this clearly is a bug in the DSDT of this tablet (in Android mode),
> but in general calling irq_set_irq_type() on an IRQ which already is
> in use seems like a bad idea.

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - Emit a dev_dbg when the IRQ is already in use. Note while making this
>   change I realized that i2c-multi-instantiate.c actually uses
>   acpi_dev_gpio_irq_get_by() with shared interrupts, so I decided to
>   go with a dev_dbg instead of a dev_warn after all

Okay, this explains drop of FW_BUG macro, I suppose.

Pushed to my review and testing queue, thanks!

> ---
>  drivers/gpio/gpiolib-acpi.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 985e8589c58b..feb8157d2d67 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -1056,10 +1056,17 @@ int acpi_dev_gpio_irq_get_by(struct acpi_device *adev, const char *name, int ind
>  			irq_flags = acpi_dev_get_irq_type(info.triggering,
>  							  info.polarity);
>  
> -			/* Set type if specified and different than the current one */
> -			if (irq_flags != IRQ_TYPE_NONE &&
> -			    irq_flags != irq_get_trigger_type(irq))
> -				irq_set_irq_type(irq, irq_flags);
> +			/*
> +			 * If the IRQ is not already in use then set type
> +			 * if specified and different than the current one.
> +			 */
> +			if (can_request_irq(irq, irq_flags)) {
> +				if (irq_flags != IRQ_TYPE_NONE &&
> +				    irq_flags != irq_get_trigger_type(irq))
> +					irq_set_irq_type(irq, irq_flags);
> +			} else {
> +				dev_dbg(&adev->dev, "IRQ %d already in use\n", irq);
> +			}
>  
>  			return irq;
>  		}
> -- 
> 2.33.1
> 

-- 
With Best Regards,
Andy Shevchenko


