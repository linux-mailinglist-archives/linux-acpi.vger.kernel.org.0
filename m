Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E380025E01D
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 18:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgIDQqc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 12:46:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:38323 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgIDQqa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Sep 2020 12:46:30 -0400
IronPort-SDR: RmDoBhPz3+AOg4i4rw7fU//aOpnyAT09P+PnbucYNnvmf1+Ub7c8J6SoP5bJPrI5WhqYEAsIlv
 MddELV633yJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="157049925"
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="157049925"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 09:46:29 -0700
IronPort-SDR: 5nfdZh0odi1GPWvmHT8qDp4N/HZ4vZ/mKiF4aFzd77Hoieka0M6bTzZJKB8O0mkDnX2STpgcMH
 L0DUX+UiMfJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="332217966"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 04 Sep 2020 09:46:27 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kEEr2-00EKPX-Gx; Fri, 04 Sep 2020 19:46:24 +0300
Date:   Fri, 4 Sep 2020 19:46:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 14/23] gpio: mockup: use the generic 'gpio-line-names'
 property
Message-ID: <20200904164624.GA1891694@smile.fi.intel.com>
References: <20200904154547.3836-1-brgl@bgdev.pl>
 <20200904154547.3836-15-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904154547.3836-15-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 04, 2020 at 05:45:38PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> GPIO line names are currently created by the driver from the chip label.
> We'll want to support custom formats for line names (for instance: to
> name all lines the same) for user-space tests so create them in the
> module init function and pass them to the driver using the standard
> 'gpio-line-names' property.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/gpio/gpio-mockup.c | 70 +++++++++++++++++++++-----------------
>  1 file changed, 38 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
> index ce83f1df1933..96976ba66598 100644
> --- a/drivers/gpio/gpio-mockup.c
> +++ b/drivers/gpio/gpio-mockup.c
> @@ -18,6 +18,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
>  #include <linux/slab.h>
> +#include <linux/string_helpers.h>
>  #include <linux/uaccess.h>
>  
>  #include "gpiolib.h"
> @@ -378,29 +379,6 @@ static void gpio_mockup_debugfs_setup(struct device *dev,
>  	return;
>  }
>  
> -static int gpio_mockup_name_lines(struct device *dev,
> -				  struct gpio_mockup_chip *chip)
> -{
> -	struct gpio_chip *gc = &chip->gc;
> -	char **names;
> -	int i;
> -
> -	names = devm_kcalloc(dev, gc->ngpio, sizeof(char *), GFP_KERNEL);
> -	if (!names)
> -		return -ENOMEM;
> -
> -	for (i = 0; i < gc->ngpio; i++) {
> -		names[i] = devm_kasprintf(dev, GFP_KERNEL,
> -					  "%s-%d", gc->label, i);
> -		if (!names[i])
> -			return -ENOMEM;
> -	}
> -
> -	gc->names = (const char *const *)names;
> -
> -	return 0;
> -}
> -
>  static void gpio_mockup_dispose_mappings(void *data)
>  {
>  	struct gpio_mockup_chip *chip = data;
> @@ -468,12 +446,6 @@ static int gpio_mockup_probe(struct platform_device *pdev)
>  	for (i = 0; i < gc->ngpio; i++)
>  		chip->lines[i].dir = GPIO_LINE_DIRECTION_IN;
>  
> -	if (device_property_read_bool(dev, "named-gpio-lines")) {
> -		rv = gpio_mockup_name_lines(dev, chip);
> -		if (rv)
> -			return rv;
> -	}
> -
>  	chip->irq_sim_domain = devm_irq_domain_create_sim(dev, NULL,
>  							  gc->ngpio);
>  	if (IS_ERR(chip->irq_sim_domain))
> @@ -524,6 +496,27 @@ static void gpio_mockup_unregister_devices(void)
>  	}
>  }
>  
> +static __init char **gpio_mockup_make_line_names(const char *label,
> +						 unsigned int num_lines)
> +{
> +	unsigned int i;
> +	char **names;
> +
> +	names = kcalloc(num_lines + 1, sizeof(char *), GFP_KERNEL);
> +	if (!names)
> +		return NULL;
> +
> +	for (i = 0; i < num_lines; i++) {
> +		names[i] = kasprintf(GFP_KERNEL, "%s-%u", label, i);
> +		if (!names[i]) {
> +			kfree_strarray(names, i);
> +			return NULL;
> +		}
> +	}
> +
> +	return names;
> +}
> +
>  static int __init gpio_mockup_init(void)
>  {
>  	struct property_entry properties[GPIO_MOCKUP_MAX_PROP];
> @@ -531,6 +524,7 @@ static int __init gpio_mockup_init(void)
>  	struct gpio_mockup_device *mockup_dev;
>  	int i, prop, num_chips, err = 0, base;
>  	struct platform_device_info pdevinfo;
> +	char **line_names;
>  	u16 ngpio;
>  
>  	if ((gpio_mockup_num_ranges < 2) ||
> @@ -563,6 +557,7 @@ static int __init gpio_mockup_init(void)
>  		memset(properties, 0, sizeof(properties));
>  		memset(&pdevinfo, 0, sizeof(pdevinfo));
>  		prop = 0;
> +		line_names = NULL;
>  
>  		snprintf(chip_label, sizeof(chip_label),
>  			 "gpio-mockup-%c", i + 'A');
> @@ -578,9 +573,18 @@ static int __init gpio_mockup_init(void)
>  				 : gpio_mockup_range_ngpio(i) - base;
>  		properties[prop++] = PROPERTY_ENTRY_U16("nr-gpios", ngpio);
>  
> -		if (gpio_mockup_named_lines)
> -			properties[prop++] = PROPERTY_ENTRY_BOOL(
> -						"named-gpio-lines");
> +		if (gpio_mockup_named_lines) {
> +			line_names = gpio_mockup_make_line_names(chip_label,
> +								 ngpio);
> +			if (!line_names) {
> +				err = -ENOMEM;
> +				goto err_out;
> +			}
> +
> +			properties[prop++] = PROPERTY_ENTRY_STRING_ARRAY_LEN(
> +						"gpio-line-names",
> +						line_names, ngpio);
> +		}

Indentation here looks quite deep. Maybe introduce a helper in between where
you assign properties?

>  		pdevinfo.name = "gpio-mockup";
>  		pdevinfo.id = i;
> @@ -588,11 +592,13 @@ static int __init gpio_mockup_init(void)
>  
>  		mockup_dev = kzalloc(sizeof(*mockup_dev), GFP_KERNEL);
>  		if (!mockup_dev) {
> +			kfree_strarray(line_names, ngpio);
>  			err = -ENOMEM;
>  			goto err_out;
>  		}
>  
>  		mockup_dev->pdev = platform_device_register_full(&pdevinfo);
> +		kfree_strarray(line_names, ngpio);
>  		if (IS_ERR(mockup_dev->pdev)) {
>  			pr_err("error registering device");
>  			kfree(mockup_dev);
> -- 
> 2.26.1
> 

-- 
With Best Regards,
Andy Shevchenko


