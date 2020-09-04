Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFA925E063
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 18:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgIDQ5I (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 12:57:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:10414 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbgIDQ5H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Sep 2020 12:57:07 -0400
IronPort-SDR: KiLgfb1wFS7EY2aeKZeOpRzLVNUqm93dHivFhDrnj8FN121Cxz2qlajlm3zs8RspUv3hFzbCXU
 VoRcz99khcJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="145514800"
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="145514800"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 09:57:06 -0700
IronPort-SDR: IYzrMYKM62qe2OW8mZh10Fs38tO5C4TSyjOGaie3lZHeFhF7+1B7wZbxExhs9PkUH8jT2iiCyt
 7dVSzPUB0UYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="332220987"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 04 Sep 2020 09:57:03 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kEEuz-00EKSO-P7; Fri, 04 Sep 2020 19:50:29 +0300
Date:   Fri, 4 Sep 2020 19:50:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 16/23] gpio: mockup: refactor the module init function
Message-ID: <20200904165029.GD1891694@smile.fi.intel.com>
References: <20200904154547.3836-1-brgl@bgdev.pl>
 <20200904154547.3836-17-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904154547.3836-17-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 04, 2020 at 05:45:40PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This is in preparation for dynamically created chips.
> 
> Let's split out the code that can be reused when creating chips at
> run-time. Let's also move the code preparing the device properties into
> a separate routine. This has the advantage of simplifying the error
> handling.

Almost all contents of this patch should go to proposed helper as I mentioned
before. Will make this patch quite small and understandable.

> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/gpio/gpio-mockup.c | 165 ++++++++++++++++++++-----------------
>  1 file changed, 90 insertions(+), 75 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
> index 995e37fef9c5..eb94ddac5fee 100644
> --- a/drivers/gpio/gpio-mockup.c
> +++ b/drivers/gpio/gpio-mockup.c
> @@ -524,16 +524,78 @@ static __init char **gpio_mockup_make_line_names(const char *label,
>  	return names;
>  }
>  
> -static int __init gpio_mockup_init(void)
> +static int __init gpio_mockup_register_device(struct property_entry *properties)
>  {
> -	struct property_entry properties[GPIO_MOCKUP_MAX_PROP];
> -	char chip_label[GPIO_MOCKUP_LABEL_SIZE];
>  	struct gpio_mockup_device *mockup_dev;
> -	int i, prop, num_chips, err = 0, base;
>  	struct platform_device_info pdevinfo;
> -	char **line_names;
> +
> +	memset(&pdevinfo, 0, sizeof(pdevinfo));
> +
> +	mockup_dev = kzalloc(sizeof(*mockup_dev), GFP_KERNEL);
> +	if (!mockup_dev)
> +		return -ENOMEM;
> +
> +	pdevinfo.name = "gpio-mockup";
> +	pdevinfo.properties = properties;
> +
> +	pdevinfo.id = ida_alloc(&gpio_mockup_ida, GFP_KERNEL);
> +	if (pdevinfo.id < 0) {
> +		kfree(mockup_dev);
> +		return pdevinfo.id;
> +	}
> +
> +	mockup_dev->pdev = platform_device_register_full(&pdevinfo);
> +	if (IS_ERR(mockup_dev->pdev)) {
> +		ida_free(&gpio_mockup_ida, pdevinfo.id);
> +		kfree(mockup_dev);
> +		return PTR_ERR(mockup_dev->pdev);
> +	}
> +
> +	list_add(&mockup_dev->list, &gpio_mockup_devices);
> +
> +	return 0;
> +}
> +
> +static int __init gpio_mockup_register_one_chip_from_params(int idx)
> +{
> +	char chip_label[GPIO_MOCKUP_LABEL_SIZE], **line_names = NULL;
> +	struct property_entry properties[GPIO_MOCKUP_MAX_PROP];
> +	int prop = 0, base, ret;
>  	u16 ngpio;
>  
> +	memset(properties, 0, sizeof(properties));
> +
> +	snprintf(chip_label, sizeof(chip_label), "gpio-mockup-%c", idx + 'A');
> +	properties[prop++] = PROPERTY_ENTRY_STRING("chip-label",
> +						   chip_label);
> +
> +	base = gpio_mockup_range_base(idx);
> +	if (base >= 0)
> +		properties[prop++] = PROPERTY_ENTRY_U32("gpio-base",
> +							base);
> +
> +	ngpio = base < 0 ? gpio_mockup_range_ngpio(idx)
> +			 : gpio_mockup_range_ngpio(idx) - base;
> +	properties[prop++] = PROPERTY_ENTRY_U16("nr-gpios", ngpio);
> +
> +	if (gpio_mockup_named_lines) {
> +		line_names = gpio_mockup_make_line_names(chip_label, ngpio);
> +		if (!line_names)
> +			return -ENOMEM;
> +
> +		properties[prop++] = PROPERTY_ENTRY_STRING_ARRAY_LEN(
> +					"gpio-line-names", line_names, ngpio);
> +	}
> +
> +	ret = gpio_mockup_register_device(properties);
> +	kfree_strarray(line_names, ngpio);
> +	return ret;
> +}
> +
> +static int __init gpio_mockup_register_chips_from_params(void)
> +{
> +	int num_chips, i, ret;
> +
>  	if ((gpio_mockup_num_ranges < 2) ||
>  	    (gpio_mockup_num_ranges % 2) ||
>  	    (gpio_mockup_num_ranges > GPIO_MOCKUP_MAX_RANGES))
> @@ -551,86 +613,39 @@ static int __init gpio_mockup_init(void)
>  			return -EINVAL;
>  	}
>  
> -	gpio_mockup_dbg_dir = debugfs_create_dir("gpio-mockup", NULL);
> -
> -	err = platform_driver_register(&gpio_mockup_driver);
> -	if (err) {
> -		pr_err("error registering platform driver\n");
> -		debugfs_remove_recursive(gpio_mockup_dbg_dir);
> -		return err;
> -	}
> -
>  	for (i = 0; i < num_chips; i++) {
> -		memset(properties, 0, sizeof(properties));
> -		memset(&pdevinfo, 0, sizeof(pdevinfo));
> -		prop = 0;
> -		line_names = NULL;
> -
> -		snprintf(chip_label, sizeof(chip_label),
> -			 "gpio-mockup-%c", i + 'A');
> -		properties[prop++] = PROPERTY_ENTRY_STRING("chip-label",
> -							   chip_label);
> -
> -		base = gpio_mockup_range_base(i);
> -		if (base >= 0)
> -			properties[prop++] = PROPERTY_ENTRY_U32("gpio-base",
> -								base);
> -
> -		ngpio = base < 0 ? gpio_mockup_range_ngpio(i)
> -				 : gpio_mockup_range_ngpio(i) - base;
> -		properties[prop++] = PROPERTY_ENTRY_U16("nr-gpios", ngpio);
> -
> -		if (gpio_mockup_named_lines) {
> -			line_names = gpio_mockup_make_line_names(chip_label,
> -								 ngpio);
> -			if (!line_names) {
> -				err = -ENOMEM;
> -				goto err_out;
> -			}
> -
> -			properties[prop++] = PROPERTY_ENTRY_STRING_ARRAY_LEN(
> -						"gpio-line-names",
> -						line_names, ngpio);
> +		ret = gpio_mockup_register_one_chip_from_params(i);
> +		if (ret) {
> +			gpio_mockup_unregister_devices();
> +			return ret;
>  		}
> +	}
>  
> -		pdevinfo.name = "gpio-mockup";
> -		pdevinfo.properties = properties;
> +	return 0;
> +}
>  
> -		pdevinfo.id = ida_alloc(&gpio_mockup_ida, GFP_KERNEL);
> -		if (pdevinfo.id < 0) {
> -			kfree_strarray(line_names, ngpio);
> -			err = pdevinfo.id;
> -			goto err_out;
> -		}
> +static int __init gpio_mockup_init(void)
> +{
> +	int ret;
>  
> -		mockup_dev = kzalloc(sizeof(*mockup_dev), GFP_KERNEL);
> -		if (!mockup_dev) {
> -			kfree_strarray(line_names, ngpio);
> -			ida_free(&gpio_mockup_ida, pdevinfo.id);
> -			err = -ENOMEM;
> -			goto err_out;
> -		}
> +	gpio_mockup_dbg_dir = debugfs_create_dir("gpio-mockup", NULL);
>  
> -		mockup_dev->pdev = platform_device_register_full(&pdevinfo);
> -		kfree_strarray(line_names, ngpio);
> -		if (IS_ERR(mockup_dev->pdev)) {
> -			pr_err("error registering device");
> -			ida_free(&gpio_mockup_ida, pdevinfo.id);
> -			kfree(mockup_dev);
> -			err = PTR_ERR(mockup_dev->pdev);
> -			goto err_out;
> -		}
> +	ret = platform_driver_register(&gpio_mockup_driver);
> +	if (ret) {
> +		pr_err("error registering platform driver\n");
> +		debugfs_remove_recursive(gpio_mockup_dbg_dir);
> +		return ret;
> +	}
>  
> -		list_add(&mockup_dev->list, &gpio_mockup_devices);
> +	ret = gpio_mockup_register_chips_from_params();
> +	if (ret) {
> +		pr_err("error registering device");
> +		debugfs_remove_recursive(gpio_mockup_dbg_dir);
> +		platform_driver_unregister(&gpio_mockup_driver);
> +		return ret;
>  	}
>  
>  	return 0;
> -
> -err_out:
> -	platform_driver_unregister(&gpio_mockup_driver);
> -	gpio_mockup_unregister_devices();
> -	debugfs_remove_recursive(gpio_mockup_dbg_dir);
> -	return err;
>  }
>  
>  static void __exit gpio_mockup_exit(void)
> -- 
> 2.26.1
> 

-- 
With Best Regards,
Andy Shevchenko


