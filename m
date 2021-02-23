Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892633229D6
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Feb 2021 13:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhBWLzs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Feb 2021 06:55:48 -0500
Received: from mga05.intel.com ([192.55.52.43]:65336 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232486AbhBWLxr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Feb 2021 06:53:47 -0500
IronPort-SDR: 8tSXin3+bco3R6WqXZmtAAelM+UCHjqQWHo6Sd/7fkZcYySpA2glvdZnB+MJbQSEZlSoLAOVF4
 E6BIPzR8dFjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="269731710"
X-IronPort-AV: E=Sophos;i="5.81,199,1610438400"; 
   d="scan'208";a="269731710"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 03:51:57 -0800
IronPort-SDR: Z70yGT6vdj9FcaJm+eGuAEr7cnH9rluhBMbEuaRkYtkcqDy20YufmC+J7K+6Vv6pANkx+Nkgc8
 h9AgGEW+84DQ==
X-IronPort-AV: E=Sophos;i="5.81,199,1610438400"; 
   d="scan'208";a="380457690"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 03:51:55 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lEWEL-007Ndn-9s; Tue, 23 Feb 2021 13:51:53 +0200
Date:   Tue, 23 Feb 2021 13:51:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add missing IRQF_ONESHOT
Message-ID: <YDTsWR/kXhd96ICI@smile.fi.intel.com>
References: <1614069358-50943-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614069358-50943-1-git-send-email-yang.lee@linux.alibaba.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 23, 2021 at 04:35:58PM +0800, Yang Li wrote:
> fixed the following coccicheck:
> ./drivers/gpio/gpiolib-acpi.c:176:7-27: ERROR: Threaded IRQ with no
> primary handler requested without IRQF_ONESHOT
> 
> Make sure threaded IRQs without a primary handler are always request
> with IRQF_ONESHOT

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpio/gpiolib-acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index e37a57d..86efa2d 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -174,7 +174,7 @@ static void acpi_gpiochip_request_irq(struct acpi_gpio_chip *acpi_gpio,
>  	int ret, value;
>  
>  	ret = request_threaded_irq(event->irq, NULL, event->handler,
> -				   event->irqflags, "ACPI:Event", event);
> +				   event->irqflags | IRQF_ONESHOT, "ACPI:Event", event);
>  	if (ret) {
>  		dev_err(acpi_gpio->chip->parent,
>  			"Failed to setup interrupt handler for %d\n",
> -- 
> 1.8.3.1
> 

-- 
With Best Regards,
Andy Shevchenko


