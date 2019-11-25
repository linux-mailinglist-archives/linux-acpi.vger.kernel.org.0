Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34900108ACB
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Nov 2019 10:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfKYJ0W (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Nov 2019 04:26:22 -0500
Received: from mga04.intel.com ([192.55.52.120]:20309 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbfKYJ0W (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Nov 2019 04:26:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Nov 2019 01:26:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,241,1571727600"; 
   d="scan'208";a="206076426"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 25 Nov 2019 01:26:17 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iZAdM-0007hw-GV; Mon, 25 Nov 2019 11:26:16 +0200
Date:   Mon, 25 Nov 2019 11:26:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/2] gpiolib: acpi: Turn dmi_system_id table into a
 generic quirk table
Message-ID: <20191125092616.GY32742@smile.fi.intel.com>
References: <20191122192334.61490-1-hdegoede@redhat.com>
 <20191122192334.61490-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122192334.61490-2-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 22, 2019 at 08:23:33PM +0100, Hans de Goede wrote:
> Turn the existing run_edge_events_on_boot_blacklist dmi_system_id table
> into a generic quirk table, storing the quirks in the driver_data ptr.
> 
> This is a preparation patch for adding other types of (DMI based) quirks.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/gpio/gpiolib-acpi.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index d30e57dc755c..2b47d906d536 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -21,6 +21,8 @@
>  #include "gpiolib.h"
>  #include "gpiolib-acpi.h"
>  
> +#define QUIRK_NO_EDGE_EVENTS_ON_BOOT		0x01l
> +
>  static int run_edge_events_on_boot = -1;
>  module_param(run_edge_events_on_boot, int, 0444);
>  MODULE_PARM_DESC(run_edge_events_on_boot,
> @@ -1309,7 +1311,7 @@ static int acpi_gpio_handle_deferred_request_irqs(void)
>  /* We must use _sync so that this runs after the first deferred_probe run */
>  late_initcall_sync(acpi_gpio_handle_deferred_request_irqs);
>  
> -static const struct dmi_system_id run_edge_events_on_boot_blacklist[] = {
> +static const struct dmi_system_id gpiolib_acpi_quirks[] = {
>  	{
>  		/*
>  		 * The Minix Neo Z83-4 has a micro-USB-B id-pin handler for
> @@ -1319,7 +1321,8 @@ static const struct dmi_system_id run_edge_events_on_boot_blacklist[] = {
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "MINIX"),
>  			DMI_MATCH(DMI_PRODUCT_NAME, "Z83-4"),
> -		}
> +		},
> +		.driver_data = (void *)QUIRK_NO_EDGE_EVENTS_ON_BOOT,
>  	},
>  	{
>  		/*
> @@ -1331,15 +1334,23 @@ static const struct dmi_system_id run_edge_events_on_boot_blacklist[] = {
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "Wortmann_AG"),
>  			DMI_MATCH(DMI_PRODUCT_NAME, "TERRA_PAD_1061"),
> -		}
> +		},
> +		.driver_data = (void *)QUIRK_NO_EDGE_EVENTS_ON_BOOT,
>  	},
>  	{} /* Terminating entry */
>  };
>  
>  static int acpi_gpio_setup_params(void)
>  {
> +	const struct dmi_system_id *id;
> +	long quirks = 0;
> +
> +	id = dmi_first_match(gpiolib_acpi_quirks);
> +	if (id)
> +		quirks = (long)id->driver_data;
> +
>  	if (run_edge_events_on_boot < 0) {
> -		if (dmi_check_system(run_edge_events_on_boot_blacklist))
> +		if (quirks & QUIRK_NO_EDGE_EVENTS_ON_BOOT)
>  			run_edge_events_on_boot = 0;
>  		else
>  			run_edge_events_on_boot = 1;
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko


