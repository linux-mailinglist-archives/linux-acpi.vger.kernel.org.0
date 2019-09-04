Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A450BA8DBF
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2019 21:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbfIDRdb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Sep 2019 13:33:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:6106 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731376AbfIDRda (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 4 Sep 2019 13:33:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 10:33:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="207565902"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 04 Sep 2019 10:33:28 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i5Z9r-0004co-Ns; Wed, 04 Sep 2019 20:33:27 +0300
Date:   Wed, 4 Sep 2019 20:33:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: make acpi_can_fallback_to_crs() static
Message-ID: <20190904173327.GZ2680@smile.fi.intel.com>
References: <20190904172624.GA76617@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904172624.GA76617@dtor-ws>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 04, 2019 at 10:26:24AM -0700, Dmitry Torokhov wrote:
> It is not used outside gpiolib-acpi.c module, so there is no need to
> export it.
> 

Thank you for a nice clean up!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/gpio/gpiolib-acpi.c | 19 ++++++++++---------
>  drivers/gpio/gpiolib-acpi.h |  8 --------
>  2 files changed, 10 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index fdee8afa5339..2b6fdc9947f7 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -728,6 +728,16 @@ static struct gpio_desc *acpi_get_gpiod_by_index(struct acpi_device *adev,
>  	return ret ? ERR_PTR(ret) : lookup.desc;
>  }
>  
> +static bool acpi_can_fallback_to_crs(struct acpi_device *adev,
> +				     const char *con_id)
> +{
> +	/* Never allow fallback if the device has properties */
> +	if (acpi_dev_has_props(adev) || adev->driver_gpios)
> +		return false;
> +
> +	return con_id == NULL;
> +}
> +
>  struct gpio_desc *acpi_find_gpio(struct device *dev,
>  				 const char *con_id,
>  				 unsigned int idx,
> @@ -1264,15 +1274,6 @@ int acpi_gpio_count(struct device *dev, const char *con_id)
>  	return count ? count : -ENOENT;
>  }
>  
> -bool acpi_can_fallback_to_crs(struct acpi_device *adev, const char *con_id)
> -{
> -	/* Never allow fallback if the device has properties */
> -	if (acpi_dev_has_props(adev) || adev->driver_gpios)
> -		return false;
> -
> -	return con_id == NULL;
> -}
> -
>  /* Run deferred acpi_gpiochip_request_irqs() */
>  static int acpi_gpio_handle_deferred_request_irqs(void)
>  {
> diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
> index d7241b432b8b..1c6d65cf0629 100644
> --- a/drivers/gpio/gpiolib-acpi.h
> +++ b/drivers/gpio/gpiolib-acpi.h
> @@ -52,8 +52,6 @@ struct gpio_desc *acpi_node_get_gpiod(struct fwnode_handle *fwnode,
>  				      struct acpi_gpio_info *info);
>  
>  int acpi_gpio_count(struct device *dev, const char *con_id);
> -
> -bool acpi_can_fallback_to_crs(struct acpi_device *adev, const char *con_id);
>  #else
>  static inline void acpi_gpiochip_add(struct gpio_chip *chip) { }
>  static inline void acpi_gpiochip_remove(struct gpio_chip *chip) { }
> @@ -93,12 +91,6 @@ static inline int acpi_gpio_count(struct device *dev, const char *con_id)
>  {
>  	return -ENODEV;
>  }
> -
> -static inline bool acpi_can_fallback_to_crs(struct acpi_device *adev,
> -					    const char *con_id)
> -{
> -	return false;
> -}
>  #endif
>  
>  #endif /* GPIOLIB_ACPI_H */
> -- 
> 2.23.0.187.g17f5b7556c-goog
> 
> 
> -- 
> Dmitry

-- 
With Best Regards,
Andy Shevchenko


