Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA543F2BF8
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Aug 2021 14:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240298AbhHTMXU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Aug 2021 08:23:20 -0400
Received: from mga09.intel.com ([134.134.136.24]:50438 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240189AbhHTMXP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 20 Aug 2021 08:23:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="216763420"
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="216763420"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 05:22:34 -0700
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="490443885"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 05:22:33 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mH3XX-00BohG-EU; Fri, 20 Aug 2021 15:22:27 +0300
Date:   Fri, 20 Aug 2021 15:22:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org
Subject: Re: [RFC 2/3] gpio-tps68470: Allow building as module
Message-ID: <YR+eg7zh7NKAA8pY@smile.fi.intel.com>
References: <20210819201936.7390-1-sakari.ailus@linux.intel.com>
 <20210819201936.7390-3-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819201936.7390-3-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 19, 2021 at 11:19:35PM +0300, Sakari Ailus wrote:
> Allow building gpio-tps68470 driver as a module. The intel_skl_int3472 is
> a module anyway, so making this a builtin does not really help setting up
> this one before a dependent module probes.

Fine with me,
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/gpio/Kconfig         | 2 +-
>  drivers/gpio/gpio-tps68470.c | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index fab571016adf..8911c2df97d1 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1378,7 +1378,7 @@ config GPIO_TPS65912
>  	  This driver supports TPS65912 gpio chip
>  
>  config GPIO_TPS68470
> -	bool "TPS68470 GPIO"
> +	tristate "TPS68470 GPIO"
>  	depends on INTEL_SKL_INT3472
>  	help
>  	  Select this option to enable GPIO driver for the TPS68470
> diff --git a/drivers/gpio/gpio-tps68470.c b/drivers/gpio/gpio-tps68470.c
> index 423b7bc30ae8..0ab88ef241de 100644
> --- a/drivers/gpio/gpio-tps68470.c
> +++ b/drivers/gpio/gpio-tps68470.c
> @@ -155,4 +155,6 @@ static struct platform_driver tps68470_gpio_driver = {
>  	.probe = tps68470_gpio_probe,
>  };
>  
> -builtin_platform_driver(tps68470_gpio_driver)
> +module_platform_driver(tps68470_gpio_driver);
> +
> +MODULE_LICENSE("GPL");
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


