Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650A845F12B
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Nov 2021 16:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350867AbhKZQAM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Nov 2021 11:00:12 -0500
Received: from mga07.intel.com ([134.134.136.100]:56874 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378364AbhKZP6M (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 26 Nov 2021 10:58:12 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="299083648"
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="299083648"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 07:47:02 -0800
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="742382016"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 07:47:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1mqdRC-00ApHb-To;
        Fri, 26 Nov 2021 17:46:58 +0200
Date:   Fri, 26 Nov 2021 17:46:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/3] ACPI: PMIC: allow drivers to provide a custom
 lpat_raw_to_temp() function
Message-ID: <YaEBcuFw+W8LNtMW@smile.fi.intel.com>
References: <20211126152109.230986-1-hdegoede@redhat.com>
 <20211126152109.230986-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126152109.230986-2-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 26, 2021 at 04:21:08PM +0100, Hans de Goede wrote:
> The LPAT tables used in the DSDT for some PMICs require special handling,
> allow the PMIC OpRegion drivers to provide an alternative implementation
> by adding a lpat_raw_to_temp function pointer to struct pmic_table;
> and initialize this to the default acpi_lpat_raw_to_temp function

acpi_lpat_raw_to_temp()

> for all PMICs.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

(see one nit-pick below)

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/pmic/intel_pmic.c          | 2 +-
>  drivers/acpi/pmic/intel_pmic.h          | 4 ++++
>  drivers/acpi/pmic/intel_pmic_bxtwc.c    | 1 +
>  drivers/acpi/pmic/intel_pmic_bytcrc.c   | 1 +
>  drivers/acpi/pmic/intel_pmic_chtcrc.c   | 1 +
>  drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 1 +
>  drivers/acpi/pmic/intel_pmic_chtwc.c    | 1 +
>  drivers/acpi/pmic/intel_pmic_xpower.c   | 1 +
>  8 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmic.c
> index 98bbfd99c709..f20dbda1a831 100644
> --- a/drivers/acpi/pmic/intel_pmic.c
> +++ b/drivers/acpi/pmic/intel_pmic.c
> @@ -95,7 +95,7 @@ static int pmic_read_temp(struct intel_pmic_opregion *opregion,
>  		return 0;
>  	}
>  
> -	temp = acpi_lpat_raw_to_temp(opregion->lpat_table, raw_temp);
> +	temp = opregion->data->lpat_raw_to_temp(opregion->lpat_table, raw_temp);
>  	if (temp < 0)
>  		return temp;
>  
> diff --git a/drivers/acpi/pmic/intel_pmic.h b/drivers/acpi/pmic/intel_pmic.h
> index 467a39966dc8..d956b03a6ca0 100644
> --- a/drivers/acpi/pmic/intel_pmic.h
> +++ b/drivers/acpi/pmic/intel_pmic.h
> @@ -2,6 +2,8 @@
>  #ifndef __INTEL_PMIC_H
>  #define __INTEL_PMIC_H
>  
> +#include <acpi/acpi_lpat.h>
> +
>  struct pmic_table {
>  	int address;	/* operation region address */
>  	int reg;	/* corresponding thermal register */
> @@ -17,6 +19,8 @@ struct intel_pmic_opregion_data {
>  	int (*update_policy)(struct regmap *r, int reg, int bit, int enable);
>  	int (*exec_mipi_pmic_seq_element)(struct regmap *r, u16 i2c_address,
>  					  u32 reg_address, u32 value, u32 mask);

> +	int (*lpat_raw_to_temp)(struct acpi_lpat_conversion_table *lpat_table,
> +				int raw);

Can be on one line.

>  	struct pmic_table *power_table;
>  	int power_table_count;
>  	struct pmic_table *thermal_table;
> diff --git a/drivers/acpi/pmic/intel_pmic_bxtwc.c b/drivers/acpi/pmic/intel_pmic_bxtwc.c
> index 6620ce0833f6..e247615189fa 100644
> --- a/drivers/acpi/pmic/intel_pmic_bxtwc.c
> +++ b/drivers/acpi/pmic/intel_pmic_bxtwc.c
> @@ -376,6 +376,7 @@ static const struct intel_pmic_opregion_data intel_bxtwc_pmic_opregion_data = {
>  	.update_aux     = intel_bxtwc_pmic_update_aux,
>  	.get_policy     = intel_bxtwc_pmic_get_policy,
>  	.update_policy  = intel_bxtwc_pmic_update_policy,
> +	.lpat_raw_to_temp = acpi_lpat_raw_to_temp,
>  	.power_table      = power_table,
>  	.power_table_count = ARRAY_SIZE(power_table),
>  	.thermal_table     = thermal_table,
> diff --git a/drivers/acpi/pmic/intel_pmic_bytcrc.c b/drivers/acpi/pmic/intel_pmic_bytcrc.c
> index 8a1d895ed689..9ea79f210965 100644
> --- a/drivers/acpi/pmic/intel_pmic_bytcrc.c
> +++ b/drivers/acpi/pmic/intel_pmic_bytcrc.c
> @@ -278,6 +278,7 @@ static const struct intel_pmic_opregion_data intel_crc_pmic_opregion_data = {
>  	.update_aux	= intel_crc_pmic_update_aux,
>  	.get_policy	= intel_crc_pmic_get_policy,
>  	.update_policy	= intel_crc_pmic_update_policy,
> +	.lpat_raw_to_temp = acpi_lpat_raw_to_temp,
>  	.power_table	= power_table,
>  	.power_table_count= ARRAY_SIZE(power_table),
>  	.thermal_table	= thermal_table,
> diff --git a/drivers/acpi/pmic/intel_pmic_chtcrc.c b/drivers/acpi/pmic/intel_pmic_chtcrc.c
> index d8266d22cd8e..f9301c6f098e 100644
> --- a/drivers/acpi/pmic/intel_pmic_chtcrc.c
> +++ b/drivers/acpi/pmic/intel_pmic_chtcrc.c
> @@ -24,6 +24,7 @@
>   * CHT Crystal Cove PMIC.
>   */
>  static const struct intel_pmic_opregion_data intel_chtcrc_pmic_opregion_data = {
> +	.lpat_raw_to_temp = acpi_lpat_raw_to_temp,
>  	.pmic_i2c_address = 0x6e,
>  };
>  
> diff --git a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> index cb444ddec5a0..418eec523025 100644
> --- a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> +++ b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> @@ -98,6 +98,7 @@ static const struct intel_pmic_opregion_data chtdc_ti_pmic_opregion_data = {
>  	.get_power = chtdc_ti_pmic_get_power,
>  	.update_power = chtdc_ti_pmic_update_power,
>  	.get_raw_temp = chtdc_ti_pmic_get_raw_temp,
> +	.lpat_raw_to_temp = acpi_lpat_raw_to_temp,
>  	.power_table = chtdc_ti_power_table,
>  	.power_table_count = ARRAY_SIZE(chtdc_ti_power_table),
>  	.thermal_table = chtdc_ti_thermal_table,
> diff --git a/drivers/acpi/pmic/intel_pmic_chtwc.c b/drivers/acpi/pmic/intel_pmic_chtwc.c
> index 59385a9a05e5..f2c42f4c79ca 100644
> --- a/drivers/acpi/pmic/intel_pmic_chtwc.c
> +++ b/drivers/acpi/pmic/intel_pmic_chtwc.c
> @@ -257,6 +257,7 @@ static const struct intel_pmic_opregion_data intel_cht_wc_pmic_opregion_data = {
>  	.get_power		= intel_cht_wc_pmic_get_power,
>  	.update_power		= intel_cht_wc_pmic_update_power,
>  	.exec_mipi_pmic_seq_element = intel_cht_wc_exec_mipi_pmic_seq_element,
> +	.lpat_raw_to_temp	= acpi_lpat_raw_to_temp,
>  	.power_table		= power_table,
>  	.power_table_count	= ARRAY_SIZE(power_table),
>  };
> diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
> index b5f4d81c621f..e844bc1f3df5 100644
> --- a/drivers/acpi/pmic/intel_pmic_xpower.c
> +++ b/drivers/acpi/pmic/intel_pmic_xpower.c
> @@ -298,6 +298,7 @@ static const struct intel_pmic_opregion_data intel_xpower_pmic_opregion_data = {
>  	.update_power = intel_xpower_pmic_update_power,
>  	.get_raw_temp = intel_xpower_pmic_get_raw_temp,
>  	.exec_mipi_pmic_seq_element = intel_xpower_exec_mipi_pmic_seq_element,
> +	.lpat_raw_to_temp = acpi_lpat_raw_to_temp,
>  	.power_table = power_table,
>  	.power_table_count = ARRAY_SIZE(power_table),
>  	.thermal_table = thermal_table,
> -- 
> 2.33.1
> 

-- 
With Best Regards,
Andy Shevchenko


