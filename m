Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0FF25E125
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 19:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgIDRpF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 13:45:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:26728 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727889AbgIDRpF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Sep 2020 13:45:05 -0400
IronPort-SDR: sGvuGOpV3iziVlrZDoCheFqfq7nH8KqvwnLryIns66ZI5dqGgfDPzr8UIPWI0+bdvdTfcDD7B1
 MidYygI5vboQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="222004049"
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="222004049"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 10:45:00 -0700
IronPort-SDR: fQ8FlLcY7ZqkmjMxM0Sq87baOWYfgiehH2GUJm0GkdPXlPeW3R4kt+MWtC1PC7j5WL9ZwNuij5
 3YXy0PFnDTIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="332242185"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 04 Sep 2020 10:44:58 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kEFlg-00EKz8-Is; Fri, 04 Sep 2020 20:44:56 +0300
Date:   Fri, 4 Sep 2020 20:44:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] pinctrl: cherryview: Preserve
 CHV_PADCTRL1_INVRXTX_TXDATA flag on GPIOs
Message-ID: <20200904174456.GI1891694@smile.fi.intel.com>
References: <20200904172141.180363-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904172141.180363-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 04, 2020 at 07:21:41PM +0200, Hans de Goede wrote:
> One some devices the GPIO should output the inverted value from what
> device-drivers / ACPI code expects. The reason for this is unknown,
> perhaps these systems use an external buffer chip on the GPIO which
> inverts the signal. The BIOS makes this work by setting the
> CHV_PADCTRL1_INVRXTX_TXDATA flag.
> 
> Before this commit we would unconditionally clear all INVRXTX flags,
> including the CHV_PADCTRL1_INVRXTX_TXDATA flag when a GPIO is requested
> by a driver (from chv_gpio_request_enable()).
> 
> This breaks systems using this setup. Specifically it is causing
> problems for systems with a goodix touchscreen, where the BIOS sets the
> INVRXTX_TXDATA flag on the GPIO used for the touchscreen's reset pin.
> 
> The goodix touchscreen driver by defaults configures this pin as input
> (relying on the pull-up to keep it high), but the clearing of the
> INVRXTX_TXDATA flag done by chv_gpio_request_enable() causes it to be
> driven low for a brief time before the GPIO gets set to input mode.
> 
> This causes the touchscreen controller to get reset. On most CHT devs
> with this touchscreen this leads to:
> 
> [   31.596534] Goodix-TS i2c-GDIX1001:00: i2c test failed attempt 1: -121
> 
> The driver retries this though and then everything is fine. But during
> reset the touchscreen uses its interrupt pin as bootstrap to determine
> which i2c address to use and on the Acer One S1003 the spurious reset
> caused by the clearing of the INVRXTX_TXDATA flag causes the controller
> to come back up again on the wrong i2c address, breaking things.
> 
> This commit fixes both the -121 errors, as well as the total breakage
> on the Acer One S1003, by making chv_gpio_clear_triggering() not clear
> the INVRXTX_TXDATA flag if the pin is already configured as a GPIO.
> 
> Note that chv_pinmux_set_mux() does still unconditionally clear the
> flag, so this only affects GPIO usage.

Makes sense!
I'll wait for Mika tag, while pushing to my review and testing queue, thanks!

> Fixes: a7d4b171660c ("Input: goodix - add support for getting IRQ + reset GPIOs on Cherry Trail devices")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/pinctrl/intel/pinctrl-cherryview.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
> index 33862bb1e0e2..41ee77bf893e 100644
> --- a/drivers/pinctrl/intel/pinctrl-cherryview.c
> +++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
> @@ -64,6 +64,7 @@
>  #define CHV_PADCTRL1_CFGLOCK		BIT(31)
>  #define CHV_PADCTRL1_INVRXTX_SHIFT	4
>  #define CHV_PADCTRL1_INVRXTX_MASK	GENMASK(7, 4)
> +#define CHV_PADCTRL1_INVRXTX_TXDATA	BIT(7)
>  #define CHV_PADCTRL1_INVRXTX_RXDATA	BIT(6)
>  #define CHV_PADCTRL1_INVRXTX_TXENABLE	BIT(5)
>  #define CHV_PADCTRL1_ODEN		BIT(3)
> @@ -798,11 +799,22 @@ static int chv_pinmux_set_mux(struct pinctrl_dev *pctldev,
>  static void chv_gpio_clear_triggering(struct chv_pinctrl *pctrl,
>  				      unsigned int offset)
>  {
> +	u32 invrxtx_mask = CHV_PADCTRL1_INVRXTX_MASK;
>  	u32 value;
>  
> +	/*
> +	 * One some devices the GPIO should output the inverted value from what
> +	 * device-drivers / ACPI code expects (inverted external buffer?). The
> +	 * BIOS makes this work by setting the CHV_PADCTRL1_INVRXTX_TXDATA flag,
> +	 * preserve this flag if the pin is already setup as GPIO.
> +	 */
> +	value = chv_readl(pctrl, offset, CHV_PADCTRL0);
> +	if (value & CHV_PADCTRL0_GPIOEN)
> +		invrxtx_mask &= ~CHV_PADCTRL1_INVRXTX_TXDATA;
> +
>  	value = chv_readl(pctrl, offset, CHV_PADCTRL1);
>  	value &= ~CHV_PADCTRL1_INTWAKECFG_MASK;
> -	value &= ~CHV_PADCTRL1_INVRXTX_MASK;
> +	value &= ~invrxtx_mask;
>  	chv_writel(pctrl, offset, CHV_PADCTRL1, value);
>  }
>  
> -- 
> 2.28.0
> 

-- 
With Best Regards,
Andy Shevchenko


