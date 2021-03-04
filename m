Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1B832D70F
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 16:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbhCDPtI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Mar 2021 10:49:08 -0500
Received: from mga14.intel.com ([192.55.52.115]:61411 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235695AbhCDPtC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 Mar 2021 10:49:02 -0500
IronPort-SDR: jJK0lEtaoYWn2MoUZV0VF13gb82XR9fh/LSdvwQK9mzm0/CwYjctkkpOFu65txd4B4iG5dvBFb
 L4SEAPaJrMuQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="186788651"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="186788651"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 07:47:15 -0800
IronPort-SDR: whiMkD1NDk/EqYJPptXrY65A9zjM5g/zeMb96t7JR7H+L+BO8xkagioL5cmHxzBVUZA1guw42K
 OALd1Cbm9B0A==
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="384512697"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 07:47:10 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lHqBv-009uT3-N2; Thu, 04 Mar 2021 17:47:07 +0200
Date:   Thu, 4 Mar 2021 17:47:07 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 2/5] gpiolib: Unify the checks on fwnode type
Message-ID: <YEEA+0rXE3FoftpP@smile.fi.intel.com>
References: <20210304150215.80652-1-andriy.shevchenko@linux.intel.com>
 <20210304150215.80652-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304150215.80652-3-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 04, 2021 at 05:02:12PM +0200, Andy Shevchenko wrote:
> We have (historically) different approaches how we identify the type
> of a given fwnode. Let's standardize them across the library code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/gpio/gpiolib.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index adf55db080d8..484ac92903ab 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -3678,11 +3678,12 @@ EXPORT_SYMBOL_GPL(fwnode_gpiod_get_index);
>   */
>  int gpiod_count(struct device *dev, const char *con_id)
>  {
> +	const struct fwnode_handle *fwnode = dev_fwnode(dev);

Oy vey, missed to fold the fix to this line. :-(

Should be

	const struct fwnode_handle *fwnode = dev ? dev_fwnode(dev) : NULL;


>  	int count = -ENOENT;
>  
> -	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
> +	if (is_of_node(fwnode))
>  		count = of_gpio_get_count(dev, con_id);
> -	else if (IS_ENABLED(CONFIG_ACPI) && dev && ACPI_HANDLE(dev))
> +	else if (is_acpi_node(fwnode))
>  		count = acpi_gpio_count(dev, con_id);
>  
>  	if (count < 0)
> @@ -3820,18 +3821,17 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
>  	int ret;
>  	/* Maybe we have a device name, maybe not */
>  	const char *devname = dev ? dev_name(dev) : "?";
> +	const struct fwnode_handle *fwnode = dev ? dev_fwnode(dev) : NULL;
>  
>  	dev_dbg(dev, "GPIO lookup for consumer %s\n", con_id);
>  
> -	if (dev) {
> -		/* Using device tree? */
> -		if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
> -			dev_dbg(dev, "using device tree for GPIO lookup\n");
> -			desc = of_find_gpio(dev, con_id, idx, &lookupflags);
> -		} else if (ACPI_COMPANION(dev)) {
> -			dev_dbg(dev, "using ACPI for GPIO lookup\n");
> -			desc = acpi_find_gpio(dev, con_id, idx, &flags, &lookupflags);
> -		}
> +	/* Using device tree? */
> +	if (is_of_node(fwnode)) {
> +		dev_dbg(dev, "using device tree for GPIO lookup\n");
> +		desc = of_find_gpio(dev, con_id, idx, &lookupflags);
> +	} else if (is_acpi_node(fwnode)) {
> +		dev_dbg(dev, "using ACPI for GPIO lookup\n");
> +		desc = acpi_find_gpio(dev, con_id, idx, &flags, &lookupflags);
>  	}
>  
>  	/*
> @@ -3915,9 +3915,6 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
>  	struct gpio_desc *desc = ERR_PTR(-ENODEV);
>  	int ret;
>  
> -	if (!fwnode)
> -		return ERR_PTR(-EINVAL);
> -
>  	if (is_of_node(fwnode)) {
>  		desc = gpiod_get_from_of_node(to_of_node(fwnode),
>  					      propname, index,
> @@ -3933,7 +3930,8 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
>  
>  		acpi_gpio_update_gpiod_flags(&dflags, &info);
>  		acpi_gpio_update_gpiod_lookup_flags(&lflags, &info);
> -	}
> +	} else
> +		return ERR_PTR(-EINVAL);
>  
>  	/* Currently only ACPI takes this path */
>  	ret = gpiod_request(desc, label);
> -- 
> 2.30.1
> 

-- 
With Best Regards,
Andy Shevchenko


