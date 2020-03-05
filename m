Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB8C17A7EB
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2020 15:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgCEOjQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Mar 2020 09:39:16 -0500
Received: from mga17.intel.com ([192.55.52.151]:3111 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgCEOjP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 5 Mar 2020 09:39:15 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 06:39:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="352370974"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 05 Mar 2020 06:39:13 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j9red-0077m0-9i; Thu, 05 Mar 2020 16:39:15 +0200
Date:   Thu, 5 Mar 2020 16:39:15 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Lehmann <schmorp@schmorp.de>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 2/4] gpiolib: acpi: Rework honor_wakeup option into an
 ignore_wake option
Message-ID: <20200305143915.GN1224808@smile.fi.intel.com>
References: <20200302111225.6641-1-hdegoede@redhat.com>
 <20200302111225.6641-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302111225.6641-2-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 02, 2020 at 12:12:23PM +0100, Hans de Goede wrote:
> Commit aa23ca3d98f7 ("gpiolib: acpi: Add honor_wakeup module-option +
> quirk mechanism") was added to deal with spurious wakeups on one specific
> model of the HP x2 10 series.
> 
> The approach taken there was to add a bool controlling wakeup support for
> all ACPI GPIO events. This was sufficient for the specific HP x2 10 model
> the commit was trying to fix, but in the mean time other models have
> turned up which need a similar workaround to avoid spurious wakeups from
> suspend, but only for one of the pins on which the ACPI tables request
> ACPI GPIO events.
> 
> Since the honor_wakeup option was added to be able to ignore wake events,
> the name was perhaps not the best, this commit renames it to ignore_wake
> and changes it to a string with the following format:
> gpiolib_acpi.ignore_wake=controller@pin[,controller@pin[,...]]
> 
> This allows working around spurious wakeup issues on a per pin basis.
> 
> This commit also reworks the existing quirk for the HP x2 10 so that
> it functions as before.
> 
> Note:
> -This removes the honor_wakeup parameter. This has only been upstream for
>  a short time and to the best of my knowledge there are no users using
>  this module parameter.
> 
> -The controller@pin[,controller@pin[,...]] syntax is based on an existing
>  kernel module parameter using the same controller@pin format. That version
>  uses ';' as separator, but in practice that is problematic because grub2
>  cannot handle this without taking special care to escape the ';', so here
>  we are using a ',' as separator instead which does not have this issue.
> 

All are fine to me.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: aa23ca3d98f7 ("gpiolib: acpi: Add honor_wakeup module-option + quirk mechanism")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Rewrite to use a much more generic string based format to describe
>  the controller@pin combination(s) on which to ignore wakeups
> ---
>  drivers/gpio/gpiolib-acpi.c | 96 +++++++++++++++++++++++++++++--------
>  1 file changed, 76 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index a77edd31dd60..87bb0d3c69da 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -21,18 +21,21 @@
>  #include "gpiolib.h"
>  #include "gpiolib-acpi.h"
>  
> -#define QUIRK_NO_EDGE_EVENTS_ON_BOOT		0x01l
> -#define QUIRK_NO_WAKEUP				0x02l
> -
>  static int run_edge_events_on_boot = -1;
>  module_param(run_edge_events_on_boot, int, 0444);
>  MODULE_PARM_DESC(run_edge_events_on_boot,
>  		 "Run edge _AEI event-handlers at boot: 0=no, 1=yes, -1=auto");
>  
> -static int honor_wakeup = -1;
> -module_param(honor_wakeup, int, 0444);
> -MODULE_PARM_DESC(honor_wakeup,
> -		 "Honor the ACPI wake-capable flag: 0=no, 1=yes, -1=auto");
> +static char *ignore_wake;
> +module_param(ignore_wake, charp, 0444);
> +MODULE_PARM_DESC(ignore_wake,
> +		 "controller@pin combos on which to ignore the ACPI wake flag "
> +		 "ignore_wake=controller@pin[,controller@pin[,...]]");
> +
> +struct acpi_gpiolib_dmi_quirk {
> +	bool no_edge_events_on_boot;
> +	char *ignore_wake;
> +};
>  
>  /**
>   * struct acpi_gpio_event - ACPI GPIO event handler data
> @@ -202,6 +205,57 @@ static void acpi_gpiochip_request_irqs(struct acpi_gpio_chip *acpi_gpio)
>  		acpi_gpiochip_request_irq(acpi_gpio, event);
>  }
>  
> +static bool acpi_gpio_in_ignore_list(const char *controller_in, int pin_in)
> +{
> +	const char *controller, *pin_str;
> +	int len, pin;
> +	char *endp;
> +
> +	controller = ignore_wake;
> +	while (controller) {
> +		pin_str = strchr(controller, '@');
> +		if (!pin_str)
> +			goto err;
> +
> +		len = pin_str - controller;
> +		if (len == strlen(controller_in) &&
> +		    strncmp(controller, controller_in, len) == 0) {
> +			pin = simple_strtoul(pin_str + 1, &endp, 10);
> +			if (*endp != 0 && *endp != ',')
> +				goto err;
> +
> +			if (pin == pin_in)
> +				return true;
> +		}
> +
> +		controller = strchr(controller, ',');
> +		if (controller)
> +			controller++;
> +	}
> +
> +	return false;
> +err:
> +	pr_err_once("Error invalid value for gpiolib_acpi.ignore_wake: %s\n",
> +		    ignore_wake);
> +	return false;
> +}
> +
> +static bool acpi_gpio_irq_is_wake(struct device *parent,
> +				  struct acpi_resource_gpio *agpio)
> +{
> +	int pin = agpio->pin_table[0];
> +
> +	if (agpio->wake_capable != ACPI_WAKE_CAPABLE)
> +		return false;
> +
> +	if (acpi_gpio_in_ignore_list(dev_name(parent), pin)) {
> +		dev_info(parent, "Ignoring wakeup on pin %d\n", pin);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>  /* Always returns AE_OK so that we keep looping over the resources */
>  static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
>  					     void *context)
> @@ -289,7 +343,7 @@ static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
>  	event->handle = evt_handle;
>  	event->handler = handler;
>  	event->irq = irq;
> -	event->irq_is_wake = honor_wakeup && agpio->wake_capable == ACPI_WAKE_CAPABLE;
> +	event->irq_is_wake = acpi_gpio_irq_is_wake(chip->parent, agpio);
>  	event->pin = pin;
>  	event->desc = desc;
>  
> @@ -1328,7 +1382,9 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "MINIX"),
>  			DMI_MATCH(DMI_PRODUCT_NAME, "Z83-4"),
>  		},
> -		.driver_data = (void *)QUIRK_NO_EDGE_EVENTS_ON_BOOT,
> +		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
> +			.no_edge_events_on_boot = true,
> +		},
>  	},
>  	{
>  		/*
> @@ -1341,7 +1397,9 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "Wortmann_AG"),
>  			DMI_MATCH(DMI_PRODUCT_NAME, "TERRA_PAD_1061"),
>  		},
> -		.driver_data = (void *)QUIRK_NO_EDGE_EVENTS_ON_BOOT,
> +		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
> +			.no_edge_events_on_boot = true,
> +		},
>  	},
>  	{
>  		/*
> @@ -1360,33 +1418,31 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
>  			DMI_MATCH(DMI_PRODUCT_NAME, "HP x2 Detachable 10-p0XX"),
>  		},
> -		.driver_data = (void *)QUIRK_NO_WAKEUP,
> +		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
> +			.ignore_wake = "INT33FF:01@0,INT0002:00@2",
> +		},
>  	},
>  	{} /* Terminating entry */
>  };
>  
>  static int acpi_gpio_setup_params(void)
>  {
> +	const struct acpi_gpiolib_dmi_quirk *quirk = NULL;
>  	const struct dmi_system_id *id;
> -	long quirks = 0;
>  
>  	id = dmi_first_match(gpiolib_acpi_quirks);
>  	if (id)
> -		quirks = (long)id->driver_data;
> +		quirk = id->driver_data;
>  
>  	if (run_edge_events_on_boot < 0) {
> -		if (quirks & QUIRK_NO_EDGE_EVENTS_ON_BOOT)
> +		if (quirk && quirk->no_edge_events_on_boot)
>  			run_edge_events_on_boot = 0;
>  		else
>  			run_edge_events_on_boot = 1;
>  	}
>  
> -	if (honor_wakeup < 0) {
> -		if (quirks & QUIRK_NO_WAKEUP)
> -			honor_wakeup = 0;
> -		else
> -			honor_wakeup = 1;
> -	}
> +	if (ignore_wake == NULL && quirk && quirk->ignore_wake)
> +		ignore_wake = quirk->ignore_wake;
>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


