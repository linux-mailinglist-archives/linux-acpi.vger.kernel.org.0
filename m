Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E0764B59B
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Dec 2022 14:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbiLMNEh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Dec 2022 08:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbiLMNEe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Dec 2022 08:04:34 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBC01E3DF
        for <linux-acpi@vger.kernel.org>; Tue, 13 Dec 2022 05:04:28 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="380327364"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="380327364"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 05:04:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="977447371"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="977447371"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 13 Dec 2022 05:04:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1p54xM-009EXP-1G;
        Tue, 13 Dec 2022 15:04:24 +0200
Date:   Tue, 13 Dec 2022 15:04:24 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI / PMIC: Add pmic_i2c_address to BYT Crystal Cove
 support
Message-ID: <Y5h4WKg/npjIl10y@smile.fi.intel.com>
References: <20221213123454.11404-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213123454.11404-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 13, 2022 at 01:34:54PM +0100, Hans de Goede wrote:
> Add a pmic_i2c_address entry to intel_pmic_bytcrc.c, so that
> intel_soc_pmic_exec_mipi_pmic_seq_element() can be used on
> devices with a Bay Trail Crystal Cove PMIC OpRegion driver.

OK!
Reviewed-by: Andy Shevchenko <andy@kernel.org>

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/pmic/intel_pmic_bytcrc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/pmic/intel_pmic_bytcrc.c b/drivers/acpi/pmic/intel_pmic_bytcrc.c
> index 9ea79f210965..2b09f8da5400 100644
> --- a/drivers/acpi/pmic/intel_pmic_bytcrc.c
> +++ b/drivers/acpi/pmic/intel_pmic_bytcrc.c
> @@ -283,6 +283,7 @@ static const struct intel_pmic_opregion_data intel_crc_pmic_opregion_data = {
>  	.power_table_count= ARRAY_SIZE(power_table),
>  	.thermal_table	= thermal_table,
>  	.thermal_table_count = ARRAY_SIZE(thermal_table),
> +	.pmic_i2c_address = 0x6e,
>  };
>  
>  static int intel_crc_pmic_opregion_probe(struct platform_device *pdev)
> -- 
> 2.38.1
> 

-- 
With Best Regards,
Andy Shevchenko


