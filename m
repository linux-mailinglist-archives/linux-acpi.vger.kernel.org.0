Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE22F189B
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2019 15:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfKFO07 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Nov 2019 09:26:59 -0500
Received: from mga04.intel.com ([192.55.52.120]:62136 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726945AbfKFO07 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 6 Nov 2019 09:26:59 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 06:26:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="377062806"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 06 Nov 2019 06:26:56 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iSMGt-0004JY-LA; Wed, 06 Nov 2019 16:26:55 +0200
Date:   Wed, 6 Nov 2019 16:26:55 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add Terra Pad 1061 to the
 run_edge_events_on_boot_blacklist
Message-ID: <20191106142655.GD32742@smile.fi.intel.com>
References: <20191106115109.119346-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106115109.119346-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 06, 2019 at 12:51:09PM +0100, Hans de Goede wrote:
> The Terra Pad 1061 has the usual micro-USB-B id-pin handler, but instead
> of controlling the actual micro-USB-B it turns the 5V boost for the
> tablet's USB-A connector and its keyboard-cover connector off.
> 
> The actual micro-USB-B connector on the tablet is wired for charging only,
> and its id pin is *not* connected to the GPIO which is used for the
> (broken) id-pin event handler in the DSDT.
> 
> While at it not only add a comment why the Terra Pad 1061 is on the
> blacklist, but also fix the missing comment for the Minix Neo Z83-4 entry.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

> 
> Fixes: 61f7f7c8f978 ("gpiolib: acpi: Add gpiolib_acpi_run_edge_events_on_boot option and blacklist")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/gpio/gpiolib-acpi.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 2911dd6f2625..5372652c38eb 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -1307,11 +1307,28 @@ late_initcall_sync(acpi_gpio_handle_deferred_request_irqs);
>  
>  static const struct dmi_system_id run_edge_events_on_boot_blacklist[] = {
>  	{
> +		/*
> +		 * The Minix Neo Z83-4 has a micro-USB-B id-pin handler for
> +		 * a non existing micro-USB-B connector which puts the HDMI
> +		 * DDC pins in GPIO mode, breaking HDMI support.
> +		 */
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "MINIX"),
>  			DMI_MATCH(DMI_PRODUCT_NAME, "Z83-4"),
>  		}
>  	},
> +	{
> +		/*
> +		 * The Terra Pad 1061 has a micro-USB-B id-pin handler, which
> +		 * instead of controlling the actual micro-USB-B turns the 5V
> +		 * boost for its USB-A connector off. The actual micro-USB-B
> +		 * connector is wired for charging only.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Wortmann_AG"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "TERRA_PAD_1061"),
> +		}
> +	},
>  	{} /* Terminating entry */
>  };
>  
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko


