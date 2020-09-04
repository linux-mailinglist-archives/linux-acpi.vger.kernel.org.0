Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37BE25DFF1
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 18:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgIDQmd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 12:42:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:35198 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgIDQmd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Sep 2020 12:42:33 -0400
IronPort-SDR: zsHWpTHw76YhwTHIcTjrwD9t+M50yx/Ln3nl9fmidxTK4a8pPSrlTV62pP1Q8TpB+rjyfo112R
 UGKE9BKVgZ0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="158761369"
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="158761369"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 09:42:32 -0700
IronPort-SDR: PvX4LY7Nkb09b4U463u7BemUvFEmv3hgydh7vZ0e5/a+jfSg+tQKogm1YsrGJYUS6hJX0ql4/H
 Zld0GyZTSX/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="332217227"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 04 Sep 2020 09:42:29 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kEEl5-00EKLZ-Tu; Fri, 04 Sep 2020 19:40:15 +0300
Date:   Fri, 4 Sep 2020 19:40:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 05/23] gpiolib: unexport devprop_gpiochip_set_names()
Message-ID: <20200904164015.GY1891694@smile.fi.intel.com>
References: <20200904154547.3836-1-brgl@bgdev.pl>
 <20200904154547.3836-6-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904154547.3836-6-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 04, 2020 at 05:45:29PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Now that devprop_gpiochip_set_names() is only used in a single place
> inside drivers/gpio/gpiolib.c, there's no need anymore for it to be
> exported or to even live in its own source file. Pull this function into
> the core source file for gpiolib.

I have mixed feelings about this. We may simply unexport and attach object file
to gpiolib.o. Would it be expected to see more functions in this file in the
future?

> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/gpio/Makefile          |  1 -
>  drivers/gpio/gpiolib-devprop.c | 64 ----------------------------------
>  drivers/gpio/gpiolib.c         | 48 +++++++++++++++++++++++++
>  include/linux/gpio/driver.h    |  2 --
>  4 files changed, 48 insertions(+), 67 deletions(-)
>  delete mode 100644 drivers/gpio/gpiolib-devprop.c
> 
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 4f9abff4f2dc..639275eb4e4d 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -6,7 +6,6 @@ ccflags-$(CONFIG_DEBUG_GPIO)	+= -DDEBUG
>  obj-$(CONFIG_GPIOLIB)		+= gpiolib.o
>  obj-$(CONFIG_GPIOLIB)		+= gpiolib-devres.o
>  obj-$(CONFIG_GPIOLIB)		+= gpiolib-legacy.o
> -obj-$(CONFIG_GPIOLIB)		+= gpiolib-devprop.o
>  obj-$(CONFIG_GPIOLIB)		+= gpiolib-cdev.o
>  obj-$(CONFIG_OF_GPIO)		+= gpiolib-of.o
>  obj-$(CONFIG_GPIO_SYSFS)	+= gpiolib-sysfs.o
> diff --git a/drivers/gpio/gpiolib-devprop.c b/drivers/gpio/gpiolib-devprop.c
> deleted file mode 100644
> index a28659b4f9c9..000000000000
> --- a/drivers/gpio/gpiolib-devprop.c
> +++ /dev/null
> @@ -1,64 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Device property helpers for GPIO chips.
> - *
> - * Copyright (C) 2016, Intel Corporation
> - * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
> - */
> -
> -#include <linux/property.h>
> -#include <linux/slab.h>
> -#include <linux/gpio/consumer.h>
> -#include <linux/gpio/driver.h>
> -#include <linux/export.h>
> -
> -#include "gpiolib.h"
> -
> -/**
> - * devprop_gpiochip_set_names - Set GPIO line names using device properties
> - * @chip: GPIO chip whose lines should be named, if possible
> - *
> - * Looks for device property "gpio-line-names" and if it exists assigns
> - * GPIO line names for the chip. The memory allocated for the assigned
> - * names belong to the underlying software node and should not be released
> - * by the caller.
> - */
> -int devprop_gpiochip_set_names(struct gpio_chip *chip)
> -{
> -	struct gpio_device *gdev = chip->gpiodev;
> -	struct device *dev = chip->parent;
> -	const char **names;
> -	int ret, i;
> -	int count;
> -
> -	count = device_property_read_string_array(dev, "gpio-line-names",
> -						  NULL, 0);
> -	if (count < 0)
> -		return 0;
> -
> -	if (count > gdev->ngpio) {
> -		dev_warn(&gdev->dev, "gpio-line-names is length %d but should be at most length %d",
> -			 count, gdev->ngpio);
> -		count = gdev->ngpio;
> -	}
> -
> -	names = kcalloc(count, sizeof(*names), GFP_KERNEL);
> -	if (!names)
> -		return -ENOMEM;
> -
> -	ret = device_property_read_string_array(dev, "gpio-line-names",
> -						names, count);
> -	if (ret < 0) {
> -		dev_warn(&gdev->dev, "failed to read GPIO line names\n");
> -		kfree(names);
> -		return ret;
> -	}
> -
> -	for (i = 0; i < count; i++)
> -		gdev->descs[i].name = names[i];
> -
> -	kfree(names);
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(devprop_gpiochip_set_names);
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 0d390f0ec32c..15c99cf560ee 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -358,6 +358,54 @@ static int gpiochip_set_desc_names(struct gpio_chip *gc)
>  	return 0;
>  }
>  
> +/*
> + * devprop_gpiochip_set_names - Set GPIO line names using device properties
> + * @chip: GPIO chip whose lines should be named, if possible
> + *
> + * Looks for device property "gpio-line-names" and if it exists assigns
> + * GPIO line names for the chip. The memory allocated for the assigned
> + * names belong to the underlying software node and should not be released
> + * by the caller.
> + */
> +static int devprop_gpiochip_set_names(struct gpio_chip *chip)
> +{
> +	struct gpio_device *gdev = chip->gpiodev;
> +	struct device *dev = chip->parent;
> +	const char **names;
> +	int ret, i;
> +	int count;
> +
> +	count = device_property_read_string_array(dev, "gpio-line-names",
> +						  NULL, 0);
> +	if (count < 0)
> +		return 0;
> +
> +	if (count > gdev->ngpio) {
> +		dev_warn(&gdev->dev, "gpio-line-names is length %d but should be at most length %d",
> +			 count, gdev->ngpio);
> +		count = gdev->ngpio;
> +	}
> +
> +	names = kcalloc(count, sizeof(*names), GFP_KERNEL);
> +	if (!names)
> +		return -ENOMEM;
> +
> +	ret = device_property_read_string_array(dev, "gpio-line-names",
> +						names, count);
> +	if (ret < 0) {
> +		dev_warn(&gdev->dev, "failed to read GPIO line names\n");
> +		kfree(names);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < count; i++)
> +		gdev->descs[i].name = names[i];
> +
> +	kfree(names);
> +
> +	return 0;
> +}
> +
>  static unsigned long *gpiochip_allocate_mask(struct gpio_chip *gc)
>  {
>  	unsigned long *p;
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index 56485a040b82..4a7e295c3640 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -756,8 +756,6 @@ struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
>  					    enum gpiod_flags dflags);
>  void gpiochip_free_own_desc(struct gpio_desc *desc);
>  
> -int devprop_gpiochip_set_names(struct gpio_chip *gc);
> -
>  #ifdef CONFIG_GPIOLIB
>  
>  /* lock/unlock as IRQ */
> -- 
> 2.26.1
> 

-- 
With Best Regards,
Andy Shevchenko


