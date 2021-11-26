Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FB645F130
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Nov 2021 16:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347256AbhKZQCQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Nov 2021 11:02:16 -0500
Received: from mga04.intel.com ([192.55.52.120]:58719 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354484AbhKZQAQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 26 Nov 2021 11:00:16 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="234412908"
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="234412908"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 07:57:03 -0800
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="458229221"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 07:57:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1mqdat-00ApOm-A8;
        Fri, 26 Nov 2021 17:56:59 +0200
Date:   Fri, 26 Nov 2021 17:56:59 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 3/3] ACPI: PMIC: xpower: Fix _TMP ACPI errors
Message-ID: <YaEDy+5ffLeQRe1D@smile.fi.intel.com>
References: <20211126152109.230986-1-hdegoede@redhat.com>
 <20211126152109.230986-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211126152109.230986-3-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 26, 2021 at 04:21:09PM +0100, Hans de Goede wrote:
> On some devices with a X-Powers AXP288 PMIC the LPAT tables in the ACPI
> node for the AXP288 PMIC for some reason only describe a small temperature
> range, e.g. 27° - 37° Celcius (assuming the entries are in millidegrees).
> 
> When the tablet is idle in a room at 21° degrees this is causing values
> outside the LPAT table to be read, causing e.g. the following 2 errors
> to get spammed to the logs every 4 seconds! :
> 
> [ 7512.791316] ACPI Error: AE_ERROR, Returned by Handler for [UserDefinedRegion] (20210930/evregion-281)
> [ 7512.791611] ACPI Error: Aborting method \_SB.SXP1._TMP due to previous error (AE_ERROR) (20210930/psparse-529)
> 
> Fix this by clamping the raw value to the LPAT table range before
> passing it to acpi_lpat_raw_to_temp().
> 
> Note clamping has been chosen rather then extrapolating because it is
> unknown how other parts of the ACPI tables will respond to temperature
> values outside of the LPAT range.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

One nit-pick below.

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/pmic/intel_pmic_xpower.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
> index e844bc1f3df5..61bbe4c24d87 100644
> --- a/drivers/acpi/pmic/intel_pmic_xpower.c
> +++ b/drivers/acpi/pmic/intel_pmic_xpower.c
> @@ -293,12 +293,33 @@ static int intel_xpower_exec_mipi_pmic_seq_element(struct regmap *regmap,
>  	return ret;
>  }
>  
> +static int intel_xpower_lpat_raw_to_temp(struct acpi_lpat_conversion_table *lpat_table,
> +					 int raw)
> +{
> +	struct acpi_lpat first = lpat_table->lpat[0];
> +	struct acpi_lpat last = lpat_table->lpat[lpat_table->lpat_count - 1];
> +
> +	/*
> +	 * Some LPAT tables in the ACPI Device for the AXP288 PMIC for some
> +	 * reason only describe a small temperature range, e.g. 27° - 37°
> +	 * Celcius. Resulting in errors when the tablet is idle in a cool room.
> +	 *
> +	 * To avoid these errors clamp the raw value to be inside the LPAT.
> +	 */

> +	if (first.raw < last.raw)

Wondering what that would mean if this condition is false.

> +		raw = clamp(raw, first.raw, last.raw);
> +	else
> +		raw = clamp(raw, last.raw, first.raw);

clamp_value() slightly better due to type checking.

> +
> +	return acpi_lpat_raw_to_temp(lpat_table, raw);
> +}
> +
>  static const struct intel_pmic_opregion_data intel_xpower_pmic_opregion_data = {
>  	.get_power = intel_xpower_pmic_get_power,
>  	.update_power = intel_xpower_pmic_update_power,
>  	.get_raw_temp = intel_xpower_pmic_get_raw_temp,
>  	.exec_mipi_pmic_seq_element = intel_xpower_exec_mipi_pmic_seq_element,
> -	.lpat_raw_to_temp = acpi_lpat_raw_to_temp,
> +	.lpat_raw_to_temp = intel_xpower_lpat_raw_to_temp,
>  	.power_table = power_table,
>  	.power_table_count = ARRAY_SIZE(power_table),
>  	.thermal_table = thermal_table,
> -- 
> 2.33.1
> 

-- 
With Best Regards,
Andy Shevchenko


