Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769A8352F02
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Apr 2021 20:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhDBSQ1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Apr 2021 14:16:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:56090 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231406AbhDBSQ1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 2 Apr 2021 14:16:27 -0400
IronPort-SDR: /UY3rCDSU1TIPpds8WUOnlzCb+6pcY/Y1px0igz/RIzPl8YXRGty3M902VPhkuhjj6tz2dHwh6
 +2j1ZICKN14w==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="180043120"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="180043120"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 11:16:25 -0700
IronPort-SDR: E9D5nghHO25Ra5z1Y/MYY9/N+2Q4ocRMDq321Gc8m5yW1sD3guQ9oXCN/1+UKMTZI4mNZBYU/f
 0IJ36XMHqKJw==
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="596821250"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 11:16:23 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lSOLE-000cL9-Ow; Fri, 02 Apr 2021 21:16:20 +0300
Date:   Fri, 2 Apr 2021 21:16:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add quirk to ignore EC wakeups on Dell
 Venue 10 Pro 5055
Message-ID: <YGdfdPn7FMfHXYOC@smile.fi.intel.com>
References: <20210401162740.4602-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401162740.4602-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 01, 2021 at 06:27:40PM +0200, Hans de Goede wrote:
> Like some other Bay and Cherry Trail SoC based devices the Dell Venue
> 10 Pro 5055 has an embedded-controller which uses ACPI GPIO events to
> report events instead of using the standard ACPI EC interface for this.
> 
> The EC interrupt is only used to report battery-level changes and
> it keeps doing this while the system is suspended, causing the system
> to not stay suspended.
> 
> Add an ignore-wake quirk for the GPIO pin used by the EC to fix the
> spurious wakeups from suspend.

Pushed to my review and testing queue, thanks!

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/gpio/gpiolib-acpi.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 1aacd2a5a1fd..174839f3772f 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -1438,6 +1438,20 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
>  			.no_edge_events_on_boot = true,
>  		},
>  	},
> +	{
> +		/*
> +		 * The Dell Venue 10 Pro 5055, with Bay Trail SoC + TI PMIC uses an
> +		 * external embedded-controller connected via I2C + an ACPI GPIO
> +		 * event handler on INT33FFC:02 pin 12, causing spurious wakeups.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Venue 10 Pro 5055"),
> +		},
> +		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
> +			.ignore_wake = "INT33FC:02@12",
> +		},
> +	},
>  	{
>  		/*
>  		 * HP X2 10 models with Cherry Trail SoC + TI PMIC use an
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


