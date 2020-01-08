Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF1F1349B8
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Jan 2020 18:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgAHRr4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Jan 2020 12:47:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:26917 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728991AbgAHRr4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 8 Jan 2020 12:47:56 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 09:47:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="421514650"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jan 2020 09:47:43 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ipFQn-0006BT-2O; Wed, 08 Jan 2020 19:47:45 +0200
Date:   Wed, 8 Jan 2020 19:47:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Mastykin <mastichi@gmail.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3] pinctrl: baytrail: Replace WARN with dev_info_once
 when setting direct-irq pin to output
Message-ID: <20200108174745.GG32742@smile.fi.intel.com>
References: <20200101145243.15912-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200101145243.15912-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jan 01, 2020 at 03:52:43PM +0100, Hans de Goede wrote:
> Suspending Goodix touchscreens requires changing the interrupt pin to
> output before sending them a power-down command. Followed by wiggling
> the interrupt pin to wake the device up, after which it is put back
> in input mode.
> 
> On Cherry Trail device the interrupt pin is listed as a GpioInt ACPI
> resource so we can do this without problems as long as we release the
> irq before changing the pin to output mode.
> 
> On Bay Trail devices with a Goodix touchscreen direct-irq mode is used
> in combination with listing the pin as a normal GpioIo resource. This
> works fine, but this triggers the WARN in byt_gpio_set_direction-s output
> path because direct-irq support is enabled on the pin.
> 
> This commit replaces the WARN call with a dev_info_once call, fixing a
> bunch of WARN splats in dmesg on each suspend/resume cycle.

Hmm...

> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> - Replace WARN with a dev_info_once call, instead of dropping it
> 
> Changes in v2:
> - Drop now unused conf_ref local variable
> ---
>  drivers/pinctrl/intel/pinctrl-baytrail.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
> index c6f53ed626c9..17e6740a36c5 100644
> --- a/drivers/pinctrl/intel/pinctrl-baytrail.c
> +++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
> @@ -811,15 +811,15 @@ static int byt_gpio_set_direction(struct pinctrl_dev *pctl_dev,
>  	value &= ~BYT_DIR_MASK;
>  	if (input)
>  		value |= BYT_OUTPUT_EN;
> -	else
> +	else if (readl(conf_reg) & BYT_DIRECT_IRQ_EN)
>  		/*
>  		 * Before making any direction modifications, do a check if gpio
>  		 * is set for direct IRQ.  On baytrail, setting GPIO to output
>  		 * does not make sense, so let's at least warn the caller before

...if it's a warning, perhaps do a warning instead of info?
Otherwise, we probably need to change a comment here.

>  		 * they shoot themselves in the foot.
>  		 */
> -		WARN(readl(conf_reg) & BYT_DIRECT_IRQ_EN,
> -		     "Potential Error: Setting GPIO with direct_irq_en to output");
> +		dev_info_once(vg->dev, "Potential Error: Setting GPIO with direct_irq_en to output");
> +
>  	writel(value, val_reg);
>  
>  	raw_spin_unlock_irqrestore(&byt_lock, flags);

P.S. I have applied it for bots to play with, but will wait for answer to the
above.

> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


