Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1573A538B
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2019 12:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbfIBKEV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 06:04:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:21331 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729560AbfIBKEU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Sep 2019 06:04:20 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 03:04:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,457,1559545200"; 
   d="scan'208";a="382753520"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 02 Sep 2019 03:04:17 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i4jC3-0008Hw-IJ; Mon, 02 Sep 2019 13:04:15 +0300
Date:   Mon, 2 Sep 2019 13:04:15 +0300
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
Subject: Re: [PATCH v2 2/2] touchscreen: goodix: define GPIO mapping for GPD
 P2 Max
Message-ID: <20190902100415.GX2680@smile.fi.intel.com>
References: <20190831030916.13172-1-peter@typeblog.net>
 <20190831030916.13172-2-peter@typeblog.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190831030916.13172-2-peter@typeblog.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Aug 31, 2019 at 11:09:15AM +0800, Peter Cai wrote:
> The firmware of GPD P2 Max could not handle panel resets although code
> is present in DSDT. The kernel needs to take on this job instead, but
> the DSDT does not provide _DSD, rendering kernel helpless when trying to
> find the respective GPIO pins.
> 
> Fortunately, this time GPD has proper DMI vendor / product strings that
> we could match against. We simply apply an acpi_gpio_mapping table when
> GPD P2 Max is matched.
> 
> Additionally, the DSDT definition of the irq pin specifies a wrong
> polarity. The new quirk introduced in the previous patch
> (ACPI_GPIO_QUIRK_OVERRIDE_POLARITY) is applied to correct this.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

though one comment below.

> 
> Signed-off-by: Peter Cai <peter@typeblog.net>
> ---
> 
> v2: removed '#ifdef CONFIG_ACPI' as per suggestion. The #ifdef guards
> for CONFIG_DMI is kept for consistency with the other dmi_system_id
> definition in the same file.
> ---
>  drivers/input/touchscreen/goodix.c | 31 ++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index 5178ea8b5f30..df476f7dcd95 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -144,6 +144,31 @@ static const struct dmi_system_id rotated_screen[] = {
>  	{}
>  };
>  
> +static const struct acpi_gpio_params irq_gpios_default = { 0, 0, false };
> +static const struct acpi_gpio_params reset_gpios_default = { 1, 0, false };
> +static const struct acpi_gpio_mapping gpio_mapping_force_irq_active_high[] = {
> +	{ "irq-gpios", &irq_gpios_default, 1, ACPI_GPIO_QUIRK_OVERRIDE_POLARITY },
> +	{ "reset-gpios", &reset_gpios_default, 1 },
> +	{}
> +};
> +
> +/*
> + * Devices that need acpi_gpio_mapping to function correctly
> + */
> +static const struct dmi_system_id need_gpio_mapping[] = {
> +#if defined(CONFIG_DMI) && defined(CONFIG_X86)
> +	{
> +		.ident = "GPD P2 Max",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "P2 MAX")
> +		},
> +		.driver_data = &gpio_mapping_force_irq_active_high
> +	},
> +#endif
> +	{}
> +};
> +
>  /**
>   * goodix_i2c_read - read data from a register of the i2c slave device.
>   *
> @@ -795,6 +820,12 @@ static int goodix_ts_probe(struct i2c_client *client,
>  {
>  	struct goodix_ts_data *ts;
>  	int error;

> +	struct dmi_system_id *dmi_match;

I guess it should be const as kbuild bot complained on v1.

And perhaps you want to keep reverse xmas tree order in definition block:

	const struct dmi_system_id *dmi_match;
	struct goodix_ts_data *ts;
	int error;

> +
> +	dmi_match = dmi_first_match(need_gpio_mapping);
> +	if (dmi_match)
> +		devm_acpi_dev_add_driver_gpios(&client->dev,
> +					       dmi_match->driver_data);
>  
>  	dev_dbg(&client->dev, "I2C Address: 0x%02x\n", client->addr);
>  
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko


