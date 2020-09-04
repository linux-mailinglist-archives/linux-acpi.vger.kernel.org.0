Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7065C25DFEF
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 18:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgIDQlg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 12:41:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:57038 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgIDQlf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Sep 2020 12:41:35 -0400
IronPort-SDR: dkVhQnmRYwxcctqI9frPbjqxGXJKQ+FOv0xYFA2lzRr471a7DOj7aKVpSqaZmdgrO2NBb5U0jD
 5TdX6uPNG0Ng==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="157789072"
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="157789072"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 09:41:34 -0700
IronPort-SDR: jOnaDEq7/s6HtzL0/sF8gBkc6FFxhv5V0ORsq9GD1cg0wncpNhhz5vjbuVYXX1hvBDQXBEGHjV
 KGpPnI57Y17A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="332217046"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 04 Sep 2020 09:41:32 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kEEbj-00EKGC-Cn; Fri, 04 Sep 2020 19:30:35 +0300
Date:   Fri, 4 Sep 2020 19:30:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 09/23] gpio: mockup: use KBUILD_MODNAME
Message-ID: <20200904163035.GU1891694@smile.fi.intel.com>
References: <20200904154547.3836-1-brgl@bgdev.pl>
 <20200904154547.3836-10-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904154547.3836-10-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 04, 2020 at 05:45:33PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Drop the definition for the driver name. Let's use KBUILD_MODNAME for
> the log format and use the "gpio-mockup" value directly in the only
> place where it's relevant: in the name of the device.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/gpio/gpio-mockup.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
> index 73cd51459c2a..78c97f7b6893 100644
> --- a/drivers/gpio/gpio-mockup.c
> +++ b/drivers/gpio/gpio-mockup.c
> @@ -22,9 +22,8 @@
>  #include "gpiolib.h"

>  #undef pr_fmt
> -#define pr_fmt(fmt)		GPIO_MOCKUP_NAME ": " fmt
> +#define pr_fmt(fmt)		KBUILD_MODNAME ": " fmt

This should be part of previous patch with something like "this is equivalent
right now".

> -#define GPIO_MOCKUP_NAME	"gpio-mockup"
>  #define GPIO_MOCKUP_MAX_GC	10
>  /*
>   * We're storing two values per chip: the GPIO base and the number
> @@ -501,7 +500,7 @@ static int gpio_mockup_probe(struct platform_device *pdev)
>  
>  static struct platform_driver gpio_mockup_driver = {
>  	.driver = {
> -		.name = GPIO_MOCKUP_NAME,
> +		.name = "gpio-mockup",
>  	},
>  	.probe = gpio_mockup_probe,
>  };
> @@ -572,7 +571,7 @@ static int __init gpio_mockup_init(void)
>  			properties[prop++] = PROPERTY_ENTRY_BOOL(
>  						"named-gpio-lines");
>  
> -		pdevinfo.name = GPIO_MOCKUP_NAME;
> +		pdevinfo.name = "gpio-mockup";
>  		pdevinfo.id = i;
>  		pdevinfo.properties = properties;
>  
> -- 
> 2.26.1
> 

-- 
With Best Regards,
Andy Shevchenko


