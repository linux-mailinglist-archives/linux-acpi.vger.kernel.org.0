Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F325459F5E
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 10:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhKWJjZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 04:39:25 -0500
Received: from mga05.intel.com ([192.55.52.43]:44213 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhKWJjY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Nov 2021 04:39:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="321222651"
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="321222651"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 01:36:17 -0800
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="674402889"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 01:36:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1mpSDj-009jTL-2g;
        Tue, 23 Nov 2021 11:36:11 +0200
Date:   Tue, 23 Nov 2021 11:36:10 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Do not set the IRQ type if the IRQ is
 already in use
Message-ID: <YZy2CiOrEJc+6TRz@smile.fi.intel.com>
References: <20211122220416.11241-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122220416.11241-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 22, 2021 at 11:04:16PM +0100, Hans de Goede wrote:
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

I'm fine with the change, one comment below, though.

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/gpio/gpiolib-acpi.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 985e8589c58b..24cd86bf2c4c 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -1056,8 +1056,12 @@ int acpi_dev_gpio_irq_get_by(struct acpi_device *adev, const char *name, int ind
>  			irq_flags = acpi_dev_get_irq_type(info.triggering,
>  							  info.polarity);
>  
> -			/* Set type if specified and different than the current one */
> -			if (irq_flags != IRQ_TYPE_NONE &&
> +			/*
> +			 * If the IRQ is not already in use then set type
> +			 * if specified and different than the current one.
> +			 */
> +			if (can_request_irq(irq, irq_flags) &&
> +			    irq_flags != IRQ_TYPE_NONE &&
>  			    irq_flags != irq_get_trigger_type(irq))
>  				irq_set_irq_type(irq, irq_flags);

What about issuing a debug (?) message

			if (can_request_irq(irq, irq_flags) {
				if (irq_flags != IRQ_TYPE_NONE &&
				    irq_flags != irq_get_trigger_type(irq))
					irq_set_irq_type(irq, irq_flags);
			} else {
				dev_dbg(..., FW_BUG "IRQ %d already in use\n", irq);
			}

?

-- 
With Best Regards,
Andy Shevchenko


