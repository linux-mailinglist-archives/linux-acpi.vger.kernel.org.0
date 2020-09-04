Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095D425E02B
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 18:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgIDQs0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 12:48:26 -0400
Received: from mga09.intel.com ([134.134.136.24]:35664 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgIDQs0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Sep 2020 12:48:26 -0400
IronPort-SDR: k6yseJJAqCH9wlmQClYNd0HNIXUnubvlVM2Jq6DFLLGrA7Vm3wYnESz/kIyBZT46HRS8SthWkB
 7vsNPd0FsHXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="158763009"
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="158763009"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 09:48:25 -0700
IronPort-SDR: KJSw+4xnH4Ykzd6zyCRjHWRbqk0LScUMmuTF9EpxuQu+XZ/EAe4ldX7jDAI9X4wx+pu7A9Ob0S
 OY3uDBuSrc3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="332218383"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 04 Sep 2020 09:48:22 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kEEsu-00EKR9-0z; Fri, 04 Sep 2020 19:48:20 +0300
Date:   Fri, 4 Sep 2020 19:48:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 13/23] gpio: mockup: pass the chip label as device
 property
Message-ID: <20200904164820.GB1891694@smile.fi.intel.com>
References: <20200904154547.3836-1-brgl@bgdev.pl>
 <20200904154547.3836-14-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904154547.3836-14-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 04, 2020 at 05:45:37PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> While we do check the "chip-name" property in probe(), we never actually
> use it. Let's pass the chip label to the driver using device properties
> as we'll want to allow users to define their own once dynamically
> created chips are supported.
> 
> The property is renamed to "chip-label" to not cause any confusion with
> the actual chip name which is of the form: "gpiochipX".
> 
> If the "chip-label" property is missing, let's do what most devices in
> drivers/gpio/ do and use dev_name().

Just wondering if we have a documentation in kernel how this mockup mechanism
works and what kind of properties it uses.

Side note: moving to software nodes would make some advantages in future such
as visibility properties and their values (not yet implemented, but there is an
idea to move forward).

> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/gpio/gpio-mockup.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
> index e8a19a28ed13..ce83f1df1933 100644
> --- a/drivers/gpio/gpio-mockup.c
> +++ b/drivers/gpio/gpio-mockup.c
> @@ -433,21 +433,14 @@ static int gpio_mockup_probe(struct platform_device *pdev)
>  	if (rv)
>  		return rv;
>  
> -	rv = device_property_read_string(dev, "chip-name", &name);
> +	rv = device_property_read_string(dev, "chip-label", &name);
>  	if (rv)
> -		name = NULL;
> +		name = dev_name(dev);
>  
>  	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
>  	if (!chip)
>  		return -ENOMEM;
>  
> -	if (!name) {
> -		name = devm_kasprintf(dev, GFP_KERNEL,
> -				      "%s-%c", pdev->name, pdev->id + 'A');
> -		if (!name)
> -			return -ENOMEM;
> -	}
> -
>  	mutex_init(&chip->lock);
>  
>  	gc = &chip->gc;
> @@ -534,6 +527,7 @@ static void gpio_mockup_unregister_devices(void)
>  static int __init gpio_mockup_init(void)
>  {
>  	struct property_entry properties[GPIO_MOCKUP_MAX_PROP];
> +	char chip_label[GPIO_MOCKUP_LABEL_SIZE];
>  	struct gpio_mockup_device *mockup_dev;
>  	int i, prop, num_chips, err = 0, base;
>  	struct platform_device_info pdevinfo;
> @@ -570,6 +564,11 @@ static int __init gpio_mockup_init(void)
>  		memset(&pdevinfo, 0, sizeof(pdevinfo));
>  		prop = 0;
>  
> +		snprintf(chip_label, sizeof(chip_label),
> +			 "gpio-mockup-%c", i + 'A');
> +		properties[prop++] = PROPERTY_ENTRY_STRING("chip-label",
> +							   chip_label);
> +
>  		base = gpio_mockup_range_base(i);
>  		if (base >= 0)
>  			properties[prop++] = PROPERTY_ENTRY_U32("gpio-base",
> -- 
> 2.26.1
> 

-- 
With Best Regards,
Andy Shevchenko


