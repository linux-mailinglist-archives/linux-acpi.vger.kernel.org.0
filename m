Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462A03F2C00
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Aug 2021 14:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbhHTMZW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Aug 2021 08:25:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:60042 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237882AbhHTMZV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 20 Aug 2021 08:25:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="302353186"
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="302353186"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 05:24:42 -0700
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="512536758"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 05:24:41 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mH3Zb-00Boj7-LX; Fri, 20 Aug 2021 15:24:35 +0300
Date:   Fri, 20 Aug 2021 15:24:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org
Subject: Re: [RFC 3/3] gpio-tps68470: Add modalias
Message-ID: <YR+fAxqx5m0g+V8X@smile.fi.intel.com>
References: <20210819201936.7390-1-sakari.ailus@linux.intel.com>
 <20210819201936.7390-4-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819201936.7390-4-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 19, 2021 at 11:19:36PM +0300, Sakari Ailus wrote:
> Add modalias for this driver, so that it is loaded automatically once the
> devices pop up.

Not sure if it should be a separate patch, nevertheless
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/gpio/gpio-tps68470.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpio/gpio-tps68470.c b/drivers/gpio/gpio-tps68470.c
> index 0ab88ef241de..8afcd31f4ea3 100644
> --- a/drivers/gpio/gpio-tps68470.c
> +++ b/drivers/gpio/gpio-tps68470.c
> @@ -158,3 +158,4 @@ static struct platform_driver tps68470_gpio_driver = {
>  module_platform_driver(tps68470_gpio_driver);
>  
>  MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:tps68470-gpio");
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


