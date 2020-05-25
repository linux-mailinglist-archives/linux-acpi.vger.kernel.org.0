Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC541E13BB
	for <lists+linux-acpi@lfdr.de>; Mon, 25 May 2020 19:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389089AbgEYR6S (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 May 2020 13:58:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:1962 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388621AbgEYR6S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 May 2020 13:58:18 -0400
IronPort-SDR: 1bLnnjYspA/HiSrxC9nRy4BZBqO2w7i44M5a7SZsA94t3a+1NWxOji2sybPGzA/SUN76CRBQKn
 Bhf3Y2HDcjdg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 10:58:17 -0700
IronPort-SDR: dAW2DDab8oCauVF6/XP8YptLHsfq5RctMgjObr8XInrBa9OO/3UJmVqKGIWSS9ttndHfTM+fJS
 8h8/gQttPQ0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,434,1583222400"; 
   d="scan'208";a="441796163"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 25 May 2020 10:58:16 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jdHMh-008pwC-Cg; Mon, 25 May 2020 20:58:19 +0300
Date:   Mon, 25 May 2020 20:58:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 3/5] gpio: pca953x: Drop unneeded ACPI_PTR()
Message-ID: <20200525175819.GH1634618@smile.fi.intel.com>
References: <20200520211916.25727-1-andriy.shevchenko@linux.intel.com>
 <20200520211916.25727-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520211916.25727-3-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, May 21, 2020 at 12:19:14AM +0300, Andy Shevchenko wrote:
> ACPI_PTR() becomes a no-op when !CONFIG_ACPI. This is not needed since
> we always have ID table enabled. Moreover, in the mentioned case compiler
> will complain about defined but not used variable.

Bart, are you going to apply this one, or should I resend it as a part of v2?

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-pca953x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index 4bb3d3524bc7..1fca8dd7824f 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -1176,7 +1176,7 @@ static struct i2c_driver pca953x_driver = {
>  		.name	= "pca953x",
>  		.pm	= &pca953x_pm_ops,
>  		.of_match_table = pca953x_dt_ids,
> -		.acpi_match_table = ACPI_PTR(pca953x_acpi_ids),
> +		.acpi_match_table = pca953x_acpi_ids,
>  	},
>  	.probe		= pca953x_probe,
>  	.remove		= pca953x_remove,
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


