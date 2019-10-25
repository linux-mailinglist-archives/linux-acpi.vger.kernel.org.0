Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C975E44B8
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2019 09:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407338AbfJYHmX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Oct 2019 03:42:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:28741 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406055AbfJYHmX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 25 Oct 2019 03:42:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 00:42:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,227,1569308400"; 
   d="scan'208";a="400030018"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 25 Oct 2019 00:42:20 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iNuEm-0001Yu-1v; Fri, 25 Oct 2019 10:42:20 +0300
Date:   Fri, 25 Oct 2019 10:42:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ACPI / PMIC: Do not register handlers for unhandled
 OpRegions
Message-ID: <20191025074220.GY32742@smile.fi.intel.com>
References: <20191024213827.144974-1-hdegoede@redhat.com>
 <20191024213827.144974-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024213827.144974-2-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 24, 2019 at 11:38:24PM +0200, Hans de Goede wrote:
> For some model PMIC's used on Intel boards we do not know how to
> handle the power or thermal opregions because we have no documentation.
> 
> For example in the intel_pmic_chtwc.c driver thermal_table_count is 0,
> which means that our PMIC_THERMAL_OPREGION_ID handler will always fail
> with AE_BAD_PARAMETER, in this case it is better to simply not register
> the handler at all.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/pmic/intel_pmic.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmic.c
> index 452041398b34..a371f273f99d 100644
> --- a/drivers/acpi/pmic/intel_pmic.c
> +++ b/drivers/acpi/pmic/intel_pmic.c
> @@ -252,7 +252,7 @@ int intel_pmic_install_opregion_handler(struct device *dev, acpi_handle handle,
>  					struct regmap *regmap,
>  					struct intel_pmic_opregion_data *d)
>  {
> -	acpi_status status;
> +	acpi_status status = AE_OK;
>  	struct intel_pmic_opregion *opregion;
>  	int ret;
>  
> @@ -270,7 +270,8 @@ int intel_pmic_install_opregion_handler(struct device *dev, acpi_handle handle,
>  	opregion->regmap = regmap;
>  	opregion->lpat_table = acpi_lpat_get_conversion_table(handle);
>  
> -	status = acpi_install_address_space_handler(handle,
> +	if (d->power_table_count)
> +		status = acpi_install_address_space_handler(handle,
>  						    PMIC_POWER_OPREGION_ID,
>  						    intel_pmic_power_handler,
>  						    NULL, opregion);
> @@ -279,7 +280,8 @@ int intel_pmic_install_opregion_handler(struct device *dev, acpi_handle handle,
>  		goto out_error;
>  	}
>  
> -	status = acpi_install_address_space_handler(handle,
> +	if (d->thermal_table_count)
> +		status = acpi_install_address_space_handler(handle,
>  						    PMIC_THERMAL_OPREGION_ID,
>  						    intel_pmic_thermal_handler,
>  						    NULL, opregion);
> @@ -301,12 +303,16 @@ int intel_pmic_install_opregion_handler(struct device *dev, acpi_handle handle,
>  	return 0;
>  
>  out_remove_thermal_handler:
> -	acpi_remove_address_space_handler(handle, PMIC_THERMAL_OPREGION_ID,
> -					  intel_pmic_thermal_handler);
> +	if (d->thermal_table_count)
> +		acpi_remove_address_space_handler(handle,
> +						  PMIC_THERMAL_OPREGION_ID,
> +						  intel_pmic_thermal_handler);
>  
>  out_remove_power_handler:
> -	acpi_remove_address_space_handler(handle, PMIC_POWER_OPREGION_ID,
> -					  intel_pmic_power_handler);
> +	if (d->power_table_count)
> +		acpi_remove_address_space_handler(handle,
> +						  PMIC_POWER_OPREGION_ID,
> +						  intel_pmic_power_handler);
>  
>  out_error:
>  	acpi_lpat_free_conversion_table(opregion->lpat_table);
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko


