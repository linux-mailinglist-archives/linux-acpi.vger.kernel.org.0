Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE61E1CF145
	for <lists+linux-acpi@lfdr.de>; Tue, 12 May 2020 11:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgELJOB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 May 2020 05:14:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:53375 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgELJOB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 May 2020 05:14:01 -0400
IronPort-SDR: WD0xvb3T1pBxw9nb3eSbtFCpr3Tr/ILH5PJ6K+OV981yRyA6NceKJ5CGLiWQYMMIXGldyUTCkG
 edDoHQZAFN5Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 02:14:00 -0700
IronPort-SDR: wd8IOn4t+apgChWUjcfgQzon80S8n3ZpbGKAe9Qg3DCX5NrPGAppV3VHYSbsE5XVLWRnVd0ooN
 d38iHxZjJyQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,383,1583222400"; 
   d="scan'208";a="306432070"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 12 May 2020 02:13:59 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jYQzC-00696z-LV; Tue, 12 May 2020 12:14:02 +0300
Date:   Tue, 12 May 2020 12:14:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/2] ACPI / PMIC: Add i2c address for thermal control
Message-ID: <20200512091402.GS185537@smile.fi.intel.com>
References: <cover.1589262490.git.mchehab+huawei@kernel.org>
 <4ea6a89bcde8c72427e69a87551bdfca8bf1af11.1589262490.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ea6a89bcde8c72427e69a87551bdfca8bf1af11.1589262490.git.mchehab+huawei@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 12, 2020 at 07:51:56AM +0200, Mauro Carvalho Chehab wrote:
> On Asus T101HA, we keep receiving those error messages:
> 
> 	i915 0000:00:02.0: [drm] *ERROR* mipi_exec_pmic failed, error: -95
> 	intel_soc_pmic_exec_mipi_pmic_seq_element: Not implemented
> 	intel_soc_pmic_exec_mipi_pmic_seq_element: i2c-addr: 0x5e reg-addr 0x4b value 0x59 mask 0xff
> 
> Because the opregion is missing the I2C address.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> index 7ccd7d9660bc..a5101b07611a 100644
> --- a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> +++ b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> @@ -102,6 +102,7 @@ static struct intel_pmic_opregion_data chtdc_ti_pmic_opregion_data = {
>  	.power_table_count = ARRAY_SIZE(chtdc_ti_power_table),
>  	.thermal_table = chtdc_ti_thermal_table,
>  	.thermal_table_count = ARRAY_SIZE(chtdc_ti_thermal_table),
> +	.pmic_i2c_address = 0x5e,
>  };
>  
>  static int chtdc_ti_pmic_opregion_probe(struct platform_device *pdev)
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


