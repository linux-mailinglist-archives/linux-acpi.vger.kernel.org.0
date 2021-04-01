Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2BC351C8A
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Apr 2021 20:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236469AbhDASSm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Apr 2021 14:18:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:47208 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238578AbhDASJi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 1 Apr 2021 14:09:38 -0400
IronPort-SDR: offd/N88rhCbvf/9fmdqvQ6Rf3DeJzh0Ms2aTAnkFEdlGYjSS5dlPQWlC0Tt5MnxvMYNS038ts
 Nvx03cojV+0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="212564704"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="212564704"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 11:01:23 -0700
IronPort-SDR: IDBDKz+I8V6htBKuc+Do0PO0b9eaBU67Dz/wppZo6sdncBWX8vwnIH5Ut5bFjv9Ee3ZaEHgfdE
 bZZCsJ8K8+uQ==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="456086447"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 11:01:20 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lS1d7-000Jzm-VO; Thu, 01 Apr 2021 21:01:17 +0300
Date:   Thu, 1 Apr 2021 21:01:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add quirk to ignore EC wakeups on Dell
 Venue 10 Pro 5055
Message-ID: <YGYKbXDu1QlYCXew@smile.fi.intel.com>
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

Fine by me,
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I have sent my PR to Bart few days ago and today he applied it.
So, since I'm not expecting much going on in this cycle, I assume
it's okay to go directly to Bart's tree.

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


