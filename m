Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962FB4A48B1
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Jan 2022 14:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbiAaNwE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 31 Jan 2022 08:52:04 -0500
Received: from mga09.intel.com ([134.134.136.24]:54984 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232774AbiAaNwD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 31 Jan 2022 08:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643637123; x=1675173123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LzyCJqb+jFU4TxzrgAz6FANTqaGe8JD5vzXZiFsubP0=;
  b=As+M4f8kTHWOrCdGf5BVQuPGH+Al7TJMboJFF7W0Po6CJBExeNwyspUW
   fjbozwHm3YBLeHS4UXlQMoQLnzWBaUZyXYBwKHchz4zxwryBcu3Cbaxor
   f3+9fFkrTlR3T6vasfXspWEYlztDCUrx83RdoZbXLWVS2eX8rVRX96Q9u
   Cou/+tCSUZacIg0lJFz8QYLWgnrOlNwxNbpkGbQPJk7NkHa+PoqQClF7u
   CEWAaEzkH2b5rvs+HvrGyOjgO19urBRyB+VKnFoOvjOe7Z2ef9SSC2/6v
   PuM3BQromqUrUAMNmrP95hk2JdJFbaFzhzJO0PoTUnYkOUpH0xVtVm4Bd
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="247232881"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="247232881"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 05:52:03 -0800
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="630024290"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 05:51:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nEX55-00Gt6K-5X;
        Mon, 31 Jan 2022 15:50:55 +0200
Date:   Mon, 31 Jan 2022 15:50:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 15/20] i2c: cht-wc: Make charger i2c-client
 instantiation board/device-model specific
Message-ID: <YffpPufu5xut7vI3@smile.fi.intel.com>
References: <20220130204557.15662-1-hdegoede@redhat.com>
 <20220130204557.15662-16-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130204557.15662-16-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Jan 30, 2022 at 09:45:52PM +0100, Hans de Goede wrote:
> The i2c-controller on the Cherry Trail - Whiskey Cove PMIC is special
> in that it is always connected to the I2C charger IC of the board on
> which the PMIC is used; and the charger IC is not described in ACPI,
> so the i2c-cht-wc code needs to instantiate an i2c-client for it itself.
> 
> So far this was hardcoded to instantiate an i2c-client for the
> bq24292i, with all properties, etc. set to match how this charger
> is used on the GPD win and GPD pocket devices.
> 
> There is a rudimentary check to make sure the ACPI tables are at least
> somewhat as expected, but this is far from accurate, leading to
> a wrong i2c-client being instantiated for the charger on some boards.
> 
> Switch to the new DMI based intel_cht_wc_get_model() helper which is
> exported by the MFD driver for the CHT Whiskey Cove PMIC to help PMIC
> cell drivers like the i2c-cht-wc code reliably detect which board
> they are running on.
> 
> And add board_info for the charger ICs as found on the other 2 known
> boards with a Whisky Cove PMIC.
> 
> This has been tested on all 3 known boards.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Acked-by: Wolfram Sang <wsa@kernel.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> - Add Wolfram's Ack for taking this upstream through another tree
>   then the i2c tree
> - Some minor tweaks / spelling fixes based on Andy's review
> ---
>  drivers/i2c/busses/i2c-cht-wc.c | 120 +++++++++++++++++++++++++++-----
>  1 file changed, 102 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht-wc.c
> index 1cf68f85b2e1..54e909f9eab6 100644
> --- a/drivers/i2c/busses/i2c-cht-wc.c
> +++ b/drivers/i2c/busses/i2c-cht-wc.c
> @@ -18,6 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/power/bq24190_charger.h>
> +#include <linux/power/bq25890_charger.h>
>  #include <linux/slab.h>
>  
>  #define CHT_WC_I2C_CTRL			0x5e24
> @@ -270,6 +271,7 @@ static const struct irq_chip cht_wc_i2c_irq_chip = {
>  	.name			= "cht_wc_ext_chrg_irq_chip",
>  };
>  
> +/********** GPD Win / Pocket charger IC settings **********/
>  static const char * const bq24190_suppliers[] = {
>  	"tcpm-source-psy-i2c-fusb302" };
>  
> @@ -304,17 +306,92 @@ static struct bq24190_platform_data bq24190_pdata = {
>  	.regulator_init_data = &bq24190_vbus_init_data,
>  };
>  
> +static struct i2c_board_info gpd_win_board_info = {
> +	.type = "bq24190",
> +	.addr = 0x6b,
> +	.dev_name = "bq24190",
> +	.swnode = &bq24190_node,
> +	.platform_data = &bq24190_pdata,
> +};
> +
> +/********** Xiaomi Mi Pad 2 charger IC settings  **********/
> +static struct regulator_consumer_supply bq2589x_vbus_consumer = {
> +	.supply = "vbus",
> +	.dev_name = "cht_wcove_pwrsrc",
> +};
> +
> +static const struct regulator_init_data bq2589x_vbus_init_data = {
> +	.constraints = {
> +		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
> +	},
> +	.consumer_supplies = &bq2589x_vbus_consumer,
> +	.num_consumer_supplies = 1,
> +};
> +
> +static struct bq25890_platform_data bq2589x_pdata = {
> +	.regulator_init_data = &bq2589x_vbus_init_data,
> +};
> +
> +static const struct property_entry xiaomi_mipad2_props[] = {
> +	PROPERTY_ENTRY_BOOL("linux,skip-reset"),
> +	PROPERTY_ENTRY_BOOL("linux,read-back-settings"),
> +	{ }
> +};
> +
> +static const struct software_node xiaomi_mipad2_node = {
> +	.properties = xiaomi_mipad2_props,
> +};
> +
> +static struct i2c_board_info xiaomi_mipad2_board_info = {
> +	.type = "bq25890",
> +	.addr = 0x6a,
> +	.dev_name = "bq25890",
> +	.swnode = &xiaomi_mipad2_node,
> +	.platform_data = &bq2589x_pdata,
> +};
> +
> +/********** Lenovo Yogabook YB1-X90F/-X91F/-X91L charger settings **********/
> +static const char * const lenovo_yb1_bq25892_suppliers[] = { "cht_wcove_pwrsrc" };
> +
> +static const struct property_entry lenovo_yb1_bq25892_props[] = {
> +	PROPERTY_ENTRY_STRING_ARRAY("supplied-from",
> +				    lenovo_yb1_bq25892_suppliers),
> +	PROPERTY_ENTRY_U32("linux,pump-express-vbus-max", 12000000),
> +	PROPERTY_ENTRY_BOOL("linux,skip-reset"),
> +	/*
> +	 * The firmware sets everything to the defaults, which leads to a
> +	 * somewhat low charge-current of 2048mA and worse to a battery-voltage
> +	 * of 4.2V instead of 4.35V (when booted without a charger connected).
> +	 * Use our own values instead of "linux,read-back-settings" to fix this.
> +	 */
> +	PROPERTY_ENTRY_U32("ti,charge-current", 4224000),
> +	PROPERTY_ENTRY_U32("ti,battery-regulation-voltage", 4352000),
> +	PROPERTY_ENTRY_U32("ti,termination-current", 256000),
> +	PROPERTY_ENTRY_U32("ti,precharge-current", 128000),
> +	PROPERTY_ENTRY_U32("ti,minimum-sys-voltage", 3500000),
> +	PROPERTY_ENTRY_U32("ti,boost-voltage", 4998000),
> +	PROPERTY_ENTRY_U32("ti,boost-max-current", 1400000),
> +	PROPERTY_ENTRY_BOOL("ti,use-ilim-pin"),
> +	{ }
> +};
> +
> +static const struct software_node lenovo_yb1_bq25892_node = {
> +	.properties = lenovo_yb1_bq25892_props,
> +};
> +
> +static struct i2c_board_info lenovo_yogabook1_board_info = {
> +	.type = "bq25892",
> +	.addr = 0x6b,
> +	.dev_name = "bq25892",
> +	.swnode = &lenovo_yb1_bq25892_node,
> +	.platform_data = &bq2589x_pdata,
> +};
> +
>  static int cht_wc_i2c_adap_i2c_probe(struct platform_device *pdev)
>  {
>  	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
> +	struct i2c_board_info *board_info = NULL;
>  	struct cht_wc_i2c_adap *adap;
> -	struct i2c_board_info board_info = {
> -		.type = "bq24190",
> -		.addr = 0x6b,
> -		.dev_name = "bq24190",
> -		.swnode = &bq24190_node,
> -		.platform_data = &bq24190_pdata,
> -	};
>  	int ret, reg, irq;
>  
>  	irq = platform_get_irq(pdev, 0);
> @@ -379,17 +456,24 @@ static int cht_wc_i2c_adap_i2c_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto remove_irq_domain;
>  
> -	/*
> -	 * Normally the Whiskey Cove PMIC is paired with a TI bq24292i charger,
> -	 * connected to this i2c bus, and a max17047 fuel-gauge and a fusb302
> -	 * USB Type-C controller connected to another i2c bus. In this setup
> -	 * the max17047 and fusb302 devices are enumerated through an INT33FE
> -	 * ACPI device. If this device is present register an i2c-client for
> -	 * the TI bq24292i charger.
> -	 */
> -	if (acpi_dev_present("INT33FE", NULL, -1)) {
> -		board_info.irq = adap->client_irq;
> -		adap->client = i2c_new_client_device(&adap->adapter, &board_info);
> +	switch (pmic->cht_wc_model) {
> +	case INTEL_CHT_WC_GPD_WIN_POCKET:
> +		board_info = &gpd_win_board_info;
> +		break;
> +	case INTEL_CHT_WC_XIAOMI_MIPAD2:
> +		board_info = &xiaomi_mipad2_board_info;
> +		break;
> +	case INTEL_CHT_WC_LENOVO_YOGABOOK1:
> +		board_info = &lenovo_yogabook1_board_info;
> +		break;
> +	default:
> +		dev_warn(&pdev->dev, "Unknown model, not instantiating charger device\n");
> +		break;
> +	}
> +
> +	if (board_info) {
> +		board_info->irq = adap->client_irq;
> +		adap->client = i2c_new_client_device(&adap->adapter, board_info);
>  		if (IS_ERR(adap->client)) {
>  			ret = PTR_ERR(adap->client);
>  			goto del_adapter;
> -- 
> 2.33.1
> 

-- 
With Best Regards,
Andy Shevchenko


