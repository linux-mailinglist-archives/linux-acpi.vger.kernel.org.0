Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7904C25DFF9
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 18:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgIDQmz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 12:42:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:31602 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgIDQmz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Sep 2020 12:42:55 -0400
IronPort-SDR: vc3iZkitfcnB934+apVa/Rrpg57K149hZbxAnu1RGG8BVPha1VK8uZcRBDdSswgmrdSH0maY5u
 ZgCDAI2mECYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="219337142"
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="219337142"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 09:42:54 -0700
IronPort-SDR: tpi1BOHeyc/3bUdy1tLlVqxhknbQM6rWuITrHIw0cYx/ddFawv/kCVr0vngQSnYvIW4DfaPBrx
 cUNAWhEBhrRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="332217258"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 04 Sep 2020 09:42:52 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kEEat-00EKFU-4B; Fri, 04 Sep 2020 19:29:43 +0300
Date:   Fri, 4 Sep 2020 19:29:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 08/23] gpio: mockup: use pr_fmt()
Message-ID: <20200904162943.GT1891694@smile.fi.intel.com>
References: <20200904154547.3836-1-brgl@bgdev.pl>
 <20200904154547.3836-9-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904154547.3836-9-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 04, 2020 at 05:45:32PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We don't need a custom logging helper. Let's use the standard pr_fmt()
> macro which allows us to use all pr_*() routines with custom format.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/gpio/gpio-mockup.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
> index 349782cdb4d7..73cd51459c2a 100644
> --- a/drivers/gpio/gpio-mockup.c
> +++ b/drivers/gpio/gpio-mockup.c
> @@ -21,6 +21,9 @@
>  
>  #include "gpiolib.h"

> +#undef pr_fmt
> +#define pr_fmt(fmt)		GPIO_MOCKUP_NAME ": " fmt
> +

Just put definition to be first line of code before other inclusions and drop
unnecessary #undef.

>  #define GPIO_MOCKUP_NAME	"gpio-mockup"
>  #define GPIO_MOCKUP_MAX_GC	10
>  /*
> @@ -31,8 +34,6 @@
>  /* Maximum of three properties + the sentinel. */
>  #define GPIO_MOCKUP_MAX_PROP	4
>  
> -#define gpio_mockup_err(...)	pr_err(GPIO_MOCKUP_NAME ": " __VA_ARGS__)
> -
>  /*
>   * struct gpio_pin_status - structure describing a GPIO status
>   * @dir:       Configures direction of gpio as "in" or "out"
> @@ -549,7 +550,7 @@ static int __init gpio_mockup_init(void)
>  
>  	err = platform_driver_register(&gpio_mockup_driver);
>  	if (err) {
> -		gpio_mockup_err("error registering platform driver\n");
> +		pr_err("error registering platform driver\n");
>  		return err;
>  	}
>  
> @@ -577,7 +578,7 @@ static int __init gpio_mockup_init(void)
>  
>  		pdev = platform_device_register_full(&pdevinfo);
>  		if (IS_ERR(pdev)) {
> -			gpio_mockup_err("error registering device");
> +			pr_err("error registering device");
>  			platform_driver_unregister(&gpio_mockup_driver);
>  			gpio_mockup_unregister_pdevs();
>  			return PTR_ERR(pdev);
> -- 
> 2.26.1
> 

-- 
With Best Regards,
Andy Shevchenko


