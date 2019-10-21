Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 489D5DE774
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2019 11:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfJUJL2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Oct 2019 05:11:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:56211 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfJUJL2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 21 Oct 2019 05:11:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 02:11:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,323,1566889200"; 
   d="scan'208";a="209288617"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 21 Oct 2019 02:11:25 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iMTim-0001ci-HS; Mon, 21 Oct 2019 12:11:24 +0300
Date:   Mon, 21 Oct 2019 12:11:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Print pin number on
 acpi_gpiochip_alloc_event errors
Message-ID: <20191021091124.GK32742@smile.fi.intel.com>
References: <20191018195208.94405-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018195208.94405-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 18, 2019 at 09:52:08PM +0200, Hans de Goede wrote:
> Print pin number on acpi_gpiochip_alloc_event errors, to help debugging
> these.

I'm not sure which one is better decimal or hex, perhaps Mika can help me, in any case
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/gpio/gpiolib-acpi.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 609ed16ae933..2911dd6f2625 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -230,19 +230,22 @@ static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
>  	desc = gpiochip_request_own_desc(chip, pin, "ACPI:Event",
>  					 GPIO_ACTIVE_HIGH, GPIOD_IN);
>  	if (IS_ERR(desc)) {
> -		dev_err(chip->parent, "Failed to request GPIO\n");
> +		dev_err(chip->parent,
> +			"Failed to request GPIO for pin 0x%02X\n", pin);
>  		return AE_ERROR;
>  	}
>  
>  	ret = gpiochip_lock_as_irq(chip, pin);
>  	if (ret) {
> -		dev_err(chip->parent, "Failed to lock GPIO as interrupt\n");
> +		dev_err(chip->parent,
> +			"Failed to lock GPIO pin 0x%02X as interrupt\n", pin);
>  		goto fail_free_desc;
>  	}
>  
>  	irq = gpiod_to_irq(desc);
>  	if (irq < 0) {
> -		dev_err(chip->parent, "Failed to translate GPIO to IRQ\n");
> +		dev_err(chip->parent,
> +			"Failed to translate GPIO pin 0x%02X to IRQ\n", pin);
>  		goto fail_unlock_irq;
>  	}
>  
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko


