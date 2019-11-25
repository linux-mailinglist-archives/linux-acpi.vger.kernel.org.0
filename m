Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82563108AC6
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Nov 2019 10:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfKYJZo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Nov 2019 04:25:44 -0500
Received: from mga06.intel.com ([134.134.136.31]:39370 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbfKYJZo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Nov 2019 04:25:44 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Nov 2019 01:25:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,241,1571727600"; 
   d="scan'208";a="291323914"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 25 Nov 2019 01:25:40 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iZAcl-0007hU-Dz; Mon, 25 Nov 2019 11:25:39 +0200
Date:   Mon, 25 Nov 2019 11:25:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/2] gpiolib: acpi: Add honor_wakeup module-option +
 quirk mechanism
Message-ID: <20191125092539.GX32742@smile.fi.intel.com>
References: <20191122192334.61490-1-hdegoede@redhat.com>
 <20191122192334.61490-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122192334.61490-3-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 22, 2019 at 08:23:34PM +0100, Hans de Goede wrote:
> On some laptops enabling wakeup on the GPIO interrupts used for ACPI _AEI
> event handling causes spurious wakeups.
> 
> This commit adds a new honor_wakeup option, defaulting to true (our current
> behavior), which can be used to disable wakeup on troublesome hardware
> to avoid these spurious wakeups.
> 
> This is a workaround for an architectural problem with s2idle under Linux
> where we do not have any mechanism to immediately go back to sleep after
> wakeup events, other then for embedded-controller events using the standard
> ACPI EC interface, for details see:
> https://lore.kernel.org/linux-acpi/61450f9b-cbc6-0c09-8b3a-aff6bf9a0b3c@redhat.com/
> 
> One series of laptops which is not able to suspend without this workaround
> is the HP x2 10 Cherry Trail models, this commit adds a DMI based quirk
> which makes sets honor_wakeup to false on these models.

I'm not against this approach (yeah, it seems we will always have a stream of
quirks for BIOS enabled platforms, especially cheapest ones), though last word
is by Rafael.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

One nit below, though.

> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/gpio/gpiolib-acpi.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 2b47d906d536..9ce9b449ac4b 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -22,12 +22,18 @@
>  #include "gpiolib-acpi.h"
>  
>  #define QUIRK_NO_EDGE_EVENTS_ON_BOOT		0x01l
> +#define QUIRK_NO_WAKEUP				0x02l
>  
>  static int run_edge_events_on_boot = -1;
>  module_param(run_edge_events_on_boot, int, 0444);
>  MODULE_PARM_DESC(run_edge_events_on_boot,
>  		 "Run edge _AEI event-handlers at boot: 0=no, 1=yes, -1=auto");
>  
> +static int honor_wakeup = -1;
> +module_param(honor_wakeup, int, 0444);
> +MODULE_PARM_DESC(honor_wakeup,
> +		 "Honor the ACPI wake-capable flag: 0=no, 1=yes, -1=auto");
> +
>  /**
>   * struct acpi_gpio_event - ACPI GPIO event handler data
>   *
> @@ -283,7 +289,8 @@ static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
>  	event->handle = evt_handle;
>  	event->handler = handler;
>  	event->irq = irq;
> -	event->irq_is_wake = agpio->wake_capable == ACPI_WAKE_CAPABLE;

> +	if (honor_wakeup)
> +		event->irq_is_wake = agpio->wake_capable == ACPI_WAKE_CAPABLE;

Perhaps:

	event->irq_is_wake = honor_wakeup && agpio->wake_capable == ACPI_WAKE_CAPABLE;

?

(I don't care about 80 limit here)

>  	event->pin = pin;
>  	event->desc = desc;
>  
> @@ -1337,6 +1344,23 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] = {
>  		},
>  		.driver_data = (void *)QUIRK_NO_EDGE_EVENTS_ON_BOOT,
>  	},
> +	{
> +		/*
> +		 * Various HP X2 10 Cherry Trail models use external
> +		 * embedded-controller connected via I2C + a ACPI GPIO
> +		 * event handler. The embedded controller generates various
> +		 * spurious wakeup events when suspended. So disable wakeup
> +		 * for its handler (it used the only ACPI GPIO event handler).
> +		 * This breaks wakeup when opening the lid, the user needs
> +		 * to press the power-button to wakeup the system. The
> +		 * alternative is suspend simply not working, which is worse.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "HP x2 Detachable 10-p0XX"),
> +		},
> +		.driver_data = (void *)QUIRK_NO_WAKEUP,
> +	},
>  	{} /* Terminating entry */
>  };
>  
> @@ -1356,6 +1380,13 @@ static int acpi_gpio_setup_params(void)
>  			run_edge_events_on_boot = 1;
>  	}
>  
> +	if (honor_wakeup < 0) {
> +		if (quirks & QUIRK_NO_WAKEUP)
> +			honor_wakeup = 0;
> +		else
> +			honor_wakeup = 1;
> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko


