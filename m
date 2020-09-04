Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E4425DFF0
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 18:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgIDQle (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 12:41:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:57038 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgIDQle (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Sep 2020 12:41:34 -0400
IronPort-SDR: 0Uv+5BFSaBLVs9QSJi/RDfiPJopuWWiKPJXHfDz1Nl9lbNoW6U0RbRsOKueWgHJMjXYRbA2Jy1
 DU+glLjXTjeQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="157789071"
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="157789071"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 09:41:33 -0700
IronPort-SDR: J+a8HPv+zl+rkbGgEhumMoGYktnR2HCWMbhCrcqoP0mPKDecJ6pjxwkhoTZgVIyy7Fj5EuX16w
 C/ZzPbOvsFEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="332217042"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 04 Sep 2020 09:41:31 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kEEmG-00EKMC-JN; Fri, 04 Sep 2020 19:41:28 +0300
Date:   Fri, 4 Sep 2020 19:41:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 06/23] gpiolib: switch to simpler IDA interface
Message-ID: <20200904164128.GZ1891694@smile.fi.intel.com>
References: <20200904154547.3836-1-brgl@bgdev.pl>
 <20200904154547.3836-7-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904154547.3836-7-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 04, 2020 at 05:45:30PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We don't need to specify any ranges when allocating IDs so we can switch
> to ida_alloc() and ida_free() instead of the ida_simple_ counterparts.
> 
> ida_simple_get(ida, 0, 0, gfp) is equivalent to
> ida_alloc_range(ida, 0, UINT_MAX, gfp) which is equivalent to
> ida_alloc(ida, gfp). Note: IDR will never actually allocate an ID
> larger than INT_MAX.

Have you considered switching to XArray API?

> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/gpio/gpiolib.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 15c99cf560ee..591777bc2285 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -471,7 +471,7 @@ static void gpiodevice_release(struct device *dev)
>  	struct gpio_device *gdev = dev_get_drvdata(dev);
>  
>  	list_del(&gdev->list);
> -	ida_simple_remove(&gpio_ida, gdev->id);
> +	ida_free(&gpio_ida, gdev->id);
>  	kfree_const(gdev->label);
>  	kfree(gdev->descs);
>  	kfree(gdev);
> @@ -582,7 +582,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>  		gc->of_node = gdev->dev.of_node;
>  #endif
>  
> -	gdev->id = ida_simple_get(&gpio_ida, 0, 0, GFP_KERNEL);
> +	gdev->id = ida_alloc(&gpio_ida, GFP_KERNEL);
>  	if (gdev->id < 0) {
>  		ret = gdev->id;
>  		goto err_free_gdev;
> @@ -753,7 +753,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>  err_free_descs:
>  	kfree(gdev->descs);
>  err_free_ida:
> -	ida_simple_remove(&gpio_ida, gdev->id);
> +	ida_free(&gpio_ida, gdev->id);
>  err_free_gdev:
>  	/* failures here can mean systems won't boot... */
>  	pr_err("%s: GPIOs %d..%d (%s) failed to register, %d\n", __func__,
> -- 
> 2.26.1
> 

-- 
With Best Regards,
Andy Shevchenko


