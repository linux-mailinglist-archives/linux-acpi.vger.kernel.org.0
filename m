Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F35825E032
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 18:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgIDQtX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 12:49:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:23851 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgIDQtX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Sep 2020 12:49:23 -0400
IronPort-SDR: 2aJQAxuZF+nQ0kD/8DqziKMwXakc6B+csttTSYTwUjhvvhZ4uF7tTN5vbDWvCCsRRiKjdRa2m2
 r2H8vHID8hIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="155290168"
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="155290168"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 09:49:22 -0700
IronPort-SDR: 6NMaScHpBzrAv4GHHTNx0/JStaZi28jYqd4g8bgcibCmLyhCGJAt4Jv/kUJ31YqA4ewxpIHzq8
 Oxv/AJskggkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="332218742"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 04 Sep 2020 09:49:20 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kEEtp-00EKRq-I2; Fri, 04 Sep 2020 19:49:17 +0300
Date:   Fri, 4 Sep 2020 19:49:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 15/23] gpio: mockup: use dynamic device IDs
Message-ID: <20200904164917.GC1891694@smile.fi.intel.com>
References: <20200904154547.3836-1-brgl@bgdev.pl>
 <20200904154547.3836-16-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904154547.3836-16-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 04, 2020 at 05:45:39PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We're currently creating chips at module init time only so using a
> static index for dummy devices is fine. We want to support dynamically
> created chips however so we need to switch to dynamic device IDs.

It misses ida_destroy().

What about XArray API?

> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/gpio/gpio-mockup.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
> index 96976ba66598..995e37fef9c5 100644
> --- a/drivers/gpio/gpio-mockup.c
> +++ b/drivers/gpio/gpio-mockup.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/debugfs.h>
>  #include <linux/gpio/driver.h>
> +#include <linux/idr.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/irq_sim.h>
> @@ -70,6 +71,8 @@ module_param_named(gpio_mockup_named_lines,
>  
>  static struct dentry *gpio_mockup_dbg_dir;
>  
> +static DEFINE_IDA(gpio_mockup_ida);
> +
>  static int gpio_mockup_range_base(unsigned int index)
>  {
>  	return gpio_mockup_ranges[index * 2];
> @@ -480,8 +483,12 @@ static LIST_HEAD(gpio_mockup_devices);
>  
>  static void gpio_mockup_unregister_one_device(struct gpio_mockup_device *dev)
>  {
> +	int id;
> +
>  	list_del(&dev->list);
> +	id = dev->pdev->id;
>  	platform_device_unregister(dev->pdev);
> +	ida_free(&gpio_mockup_ida, id);
>  	kfree(dev);
>  }
>  
> @@ -587,12 +594,19 @@ static int __init gpio_mockup_init(void)
>  		}
>  
>  		pdevinfo.name = "gpio-mockup";
> -		pdevinfo.id = i;
>  		pdevinfo.properties = properties;
>  
> +		pdevinfo.id = ida_alloc(&gpio_mockup_ida, GFP_KERNEL);
> +		if (pdevinfo.id < 0) {
> +			kfree_strarray(line_names, ngpio);
> +			err = pdevinfo.id;
> +			goto err_out;
> +		}
> +
>  		mockup_dev = kzalloc(sizeof(*mockup_dev), GFP_KERNEL);
>  		if (!mockup_dev) {
>  			kfree_strarray(line_names, ngpio);
> +			ida_free(&gpio_mockup_ida, pdevinfo.id);
>  			err = -ENOMEM;
>  			goto err_out;
>  		}
> @@ -601,6 +615,7 @@ static int __init gpio_mockup_init(void)
>  		kfree_strarray(line_names, ngpio);
>  		if (IS_ERR(mockup_dev->pdev)) {
>  			pr_err("error registering device");
> +			ida_free(&gpio_mockup_ida, pdevinfo.id);
>  			kfree(mockup_dev);
>  			err = PTR_ERR(mockup_dev->pdev);
>  			goto err_out;
> -- 
> 2.26.1
> 

-- 
With Best Regards,
Andy Shevchenko


