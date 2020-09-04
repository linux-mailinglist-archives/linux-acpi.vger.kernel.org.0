Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E18B25E013
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 18:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIDQpA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 12:45:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:38205 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgIDQo6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Sep 2020 12:44:58 -0400
IronPort-SDR: C0kOaKZJAzfpkUppuJsCOfhyFvUUC7bo254sl40DpHW+D5BsAKEu1E6qG0V/TkK8w+1zCHg+OX
 Ds1sycPYgfKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="157049423"
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="157049423"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 09:44:57 -0700
IronPort-SDR: Oie5QzQ0tzzT+nQnAyakUiCrWWpi6nDRX9O5hX6yfVdrWgR8EUWaK6RXggI7xnmxgPq6M8pW+k
 dttV/muhL2dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="332217655"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 04 Sep 2020 09:44:54 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kEEjE-00EKKi-H8; Fri, 04 Sep 2020 19:38:20 +0300
Date:   Fri, 4 Sep 2020 19:38:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 04/23] gpiolib: generalize devprop_gpiochip_set_names()
 for device properties
Message-ID: <20200904163820.GX1891694@smile.fi.intel.com>
References: <20200904154547.3836-1-brgl@bgdev.pl>
 <20200904154547.3836-5-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904154547.3836-5-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 04, 2020 at 05:45:28PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> devprop_gpiochip_set_names() is overly complicated with taking the
> fwnode argument (which requires using dev_fwnode() & of_fwnode_handle()
> in ACPI and OF GPIO code respectively). Let's just switch to using the
> generic device properties.
> 
> This allows us to pull the code setting line names directly into
> gpiochip_add_data_with_key() instead of handling it separately for
> ACPI and OF.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/gpio/gpiolib-acpi.c    |  3 ---
>  drivers/gpio/gpiolib-devprop.c | 19 ++++++++++---------
>  drivers/gpio/gpiolib-of.c      |  5 -----
>  drivers/gpio/gpiolib.c         |  8 ++++----
>  include/linux/gpio/driver.h    |  3 +--
>  5 files changed, 15 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 54ca3c18b291..834a12f3219e 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -1221,9 +1221,6 @@ void acpi_gpiochip_add(struct gpio_chip *chip)
>  		return;
>  	}
>  
> -	if (!chip->names)
> -		devprop_gpiochip_set_names(chip, dev_fwnode(chip->parent));
> -
>  	acpi_gpiochip_request_regions(acpi_gpio);
>  	acpi_gpiochip_scan_gpios(acpi_gpio);
>  	acpi_walk_dep_device_list(handle);
> diff --git a/drivers/gpio/gpiolib-devprop.c b/drivers/gpio/gpiolib-devprop.c
> index 26741032fa9e..a28659b4f9c9 100644
> --- a/drivers/gpio/gpiolib-devprop.c
> +++ b/drivers/gpio/gpiolib-devprop.c
> @@ -17,25 +17,24 @@
>  /**
>   * devprop_gpiochip_set_names - Set GPIO line names using device properties
>   * @chip: GPIO chip whose lines should be named, if possible
> - * @fwnode: Property Node containing the gpio-line-names property
>   *
>   * Looks for device property "gpio-line-names" and if it exists assigns
>   * GPIO line names for the chip. The memory allocated for the assigned
> - * names belong to the underlying firmware node and should not be released
> + * names belong to the underlying software node and should not be released
>   * by the caller.
>   */
> -void devprop_gpiochip_set_names(struct gpio_chip *chip,
> -				const struct fwnode_handle *fwnode)
> +int devprop_gpiochip_set_names(struct gpio_chip *chip)
>  {
>  	struct gpio_device *gdev = chip->gpiodev;
> +	struct device *dev = chip->parent;
>  	const char **names;
>  	int ret, i;
>  	int count;
>  
> -	count = fwnode_property_read_string_array(fwnode, "gpio-line-names",
> +	count = device_property_read_string_array(dev, "gpio-line-names",
>  						  NULL, 0);
>  	if (count < 0)
> -		return;
> +		return 0;

Can we introduce a followup to 33ee09cd59ce ("device property: Add helpers to
count items in an array") for strings?

>  	if (count > gdev->ngpio) {
>  		dev_warn(&gdev->dev, "gpio-line-names is length %d but should be at most length %d",
> @@ -45,19 +44,21 @@ void devprop_gpiochip_set_names(struct gpio_chip *chip,
>  
>  	names = kcalloc(count, sizeof(*names), GFP_KERNEL);
>  	if (!names)
> -		return;
> +		return -ENOMEM;
>  
> -	ret = fwnode_property_read_string_array(fwnode, "gpio-line-names",
> +	ret = device_property_read_string_array(dev, "gpio-line-names",
>  						names, count);
>  	if (ret < 0) {
>  		dev_warn(&gdev->dev, "failed to read GPIO line names\n");
>  		kfree(names);
> -		return;
> +		return ret;
>  	}
>  
>  	for (i = 0; i < count; i++)
>  		gdev->descs[i].name = names[i];
>  
>  	kfree(names);
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(devprop_gpiochip_set_names);
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index bd31dd3b6a75..2f895a2b8411 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -1026,11 +1026,6 @@ int of_gpiochip_add(struct gpio_chip *chip)
>  	if (ret)
>  		return ret;
>  
> -	/* If the chip defines names itself, these take precedence */
> -	if (!chip->names)
> -		devprop_gpiochip_set_names(chip,
> -					   of_fwnode_handle(chip->of_node));
> -
>  	of_node_get(chip->of_node);
>  
>  	ret = of_gpiochip_scan_gpios(chip);
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 80137c1b3cdc..0d390f0ec32c 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -340,9 +340,6 @@ static int gpiochip_set_desc_names(struct gpio_chip *gc)
>  	struct gpio_device *gdev = gc->gpiodev;
>  	int i;
>  
> -	if (!gc->names)
> -		return 0;
> -
>  	/* First check all names if they are unique */
>  	for (i = 0; i != gc->ngpio; ++i) {
>  		struct gpio_desc *gpio;
> @@ -621,7 +618,10 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>  	INIT_LIST_HEAD(&gdev->pin_ranges);
>  #endif
>  
> -	ret = gpiochip_set_desc_names(gc);
> +	if (gc->names)
> +		ret = gpiochip_set_desc_names(gc);
> +	else
> +		ret = devprop_gpiochip_set_names(gc);
>  	if (ret)
>  		goto err_remove_from_list;
>  
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index d1cef5c2715c..56485a040b82 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -756,8 +756,7 @@ struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
>  					    enum gpiod_flags dflags);
>  void gpiochip_free_own_desc(struct gpio_desc *desc);
>  
> -void devprop_gpiochip_set_names(struct gpio_chip *gc,
> -				const struct fwnode_handle *fwnode);
> +int devprop_gpiochip_set_names(struct gpio_chip *gc);
>  
>  #ifdef CONFIG_GPIOLIB
>  
> -- 
> 2.26.1
> 

-- 
With Best Regards,
Andy Shevchenko


