Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAEFAE44C3
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2019 09:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732484AbfJYHpY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Oct 2019 03:45:24 -0400
Received: from mga04.intel.com ([192.55.52.120]:42171 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731944AbfJYHpX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 25 Oct 2019 03:45:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 00:45:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,227,1569308400"; 
   d="scan'208";a="210326410"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 25 Oct 2019 00:45:20 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iNuHe-0001bB-WE; Fri, 25 Oct 2019 10:45:19 +0300
Date:   Fri, 25 Oct 2019 10:45:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] ACPI / PMIC: Add Cherry Trail Crystal Cove PMIC
 OpRegion driver
Message-ID: <20191025074518.GZ32742@smile.fi.intel.com>
References: <20191024213827.144974-1-hdegoede@redhat.com>
 <20191024213827.144974-4-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024213827.144974-4-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 24, 2019 at 11:38:26PM +0200, Hans de Goede wrote:
> We have no docs for the CHT Crystal Cove PMIC. The Asus Zenfone-2 kernel
> code has 2 Crystal Cove regulator drivers, one calls the PMIC a "Crystal
> Cove Plus" PMIC and talks about Cherry Trail, so presuambly that one
> could be used to get register info for the regulators if we need to
> implement regulator support in the future.
> 
> For now the sole purpose of this driver is to make
> intel_soc_pmic_exec_mipi_pmic_seq_element work on devices with a
> CHT Crystal Cove PMIC.
> 
> Specifically this fixes the following MIPI PMIC sequence related errors
> on e.g. an Asus T100HA:
> 
> [  178.211801] intel_soc_pmic_exec_mipi_pmic_seq_element: No PMIC registered
> [  178.211897] [drm:intel_dsi_dcs_init_backlight_funcs [i915]] *ERROR* mipi_exec_pmic failed, error: -6
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

as long as name pattern uses "chtcc".


> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/Kconfig                  |  7 +++++
>  drivers/acpi/Makefile                 |  1 +
>  drivers/acpi/pmic/intel_pmic_chtcrc.c | 44 +++++++++++++++++++++++++++
>  3 files changed, 52 insertions(+)
>  create mode 100644 drivers/acpi/pmic/intel_pmic_chtcrc.c
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 089f7f8e1be7..0f23d8b22c42 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -520,6 +520,13 @@ config BYTCRC_PMIC_OPREGION
>  	  This config adds ACPI operation region support for the Bay Trail
>  	  version of the Crystal Cove PMIC.
>  
> +config CHTCRC_PMIC_OPREGION
> +	bool "ACPI operation region support for Cherry Trail Crystal Cove PMIC"
> +	depends on INTEL_SOC_PMIC
> +	help
> +	  This config adds ACPI operation region support for the Cherry Trail
> +	  version of the Crystal Cove PMIC.
> +
>  config XPOWER_PMIC_OPREGION
>  	bool "ACPI operation region support for XPower AXP288 PMIC"
>  	depends on MFD_AXP20X_I2C && IOSF_MBI=y
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index ee59b1db69a1..68853f23e901 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -110,6 +110,7 @@ obj-$(CONFIG_ACPI_EXTLOG)	+= acpi_extlog.o
>  
>  obj-$(CONFIG_PMIC_OPREGION)	+= pmic/intel_pmic.o
>  obj-$(CONFIG_BYTCRC_PMIC_OPREGION) += pmic/intel_pmic_bytcrc.o
> +obj-$(CONFIG_CHTCRC_PMIC_OPREGION) += pmic/intel_pmic_chtcrc.o
>  obj-$(CONFIG_XPOWER_PMIC_OPREGION) += pmic/intel_pmic_xpower.o
>  obj-$(CONFIG_BXT_WC_PMIC_OPREGION) += pmic/intel_pmic_bxtwc.o
>  obj-$(CONFIG_CHT_WC_PMIC_OPREGION) += pmic/intel_pmic_chtwc.o
> diff --git a/drivers/acpi/pmic/intel_pmic_chtcrc.c b/drivers/acpi/pmic/intel_pmic_chtcrc.c
> new file mode 100644
> index 000000000000..ebf8d3187df1
> --- /dev/null
> +++ b/drivers/acpi/pmic/intel_pmic_chtcrc.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Intel Cherry Trail Crystal Cove PMIC operation region driver
> + *
> + * Copyright (C) 2019 Hans de Goede <hdegoede@redhat.com>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/init.h>
> +#include <linux/mfd/intel_soc_pmic.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include "intel_pmic.h"
> +
> +/*
> + * We have no docs for the CHT Crystal Cove PMIC. The Asus Zenfone-2 kernel
> + * code has 2 Crystal Cove regulator drivers, one calls the PMIC a "Crystal
> + * Cove Plus" PMIC and talks about Cherry Trail, so presuambly that one
> + * could be used to get register info for the regulators if we need to
> + * implement regulator support in the future.
> + *
> + * For now the sole purpose of this driver is to make
> + * intel_soc_pmic_exec_mipi_pmic_seq_element work on devices with a
> + * CHT Crystal Cove PMIC.
> + */
> +static struct intel_pmic_opregion_data intel_chtcrc_pmic_opregion_data = {
> +	.pmic_i2c_address = 0x6e,
> +};
> +
> +static int intel_chtcrc_pmic_opregion_probe(struct platform_device *pdev)
> +{
> +	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
> +	return intel_pmic_install_opregion_handler(&pdev->dev,
> +			ACPI_HANDLE(pdev->dev.parent), pmic->regmap,
> +			&intel_chtcrc_pmic_opregion_data);
> +}
> +
> +static struct platform_driver intel_chtcrc_pmic_opregion_driver = {
> +	.probe = intel_chtcrc_pmic_opregion_probe,
> +	.driver = {
> +		.name = "cht_crystal_cove_pmic",
> +	},
> +};
> +builtin_platform_driver(intel_chtcrc_pmic_opregion_driver);
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko


