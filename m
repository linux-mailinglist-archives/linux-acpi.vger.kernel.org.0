Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDD61349A0
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Jan 2020 18:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgAHRnh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Jan 2020 12:43:37 -0500
Received: from mga11.intel.com ([192.55.52.93]:9532 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgAHRnh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 8 Jan 2020 12:43:37 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 09:43:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="223604331"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 08 Jan 2020 09:43:34 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ipFMk-00068O-ST; Wed, 08 Jan 2020 19:43:34 +0200
Date:   Wed, 8 Jan 2020 19:43:34 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Mastykin <mastichi@gmail.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] pinctrl: baytrail: Do not clear IRQ flags on direct-irq
 enabled pins
Message-ID: <20200108174334.GF32742@smile.fi.intel.com>
References: <20191227230447.32458-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191227230447.32458-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Dec 28, 2019 at 12:04:47AM +0100, Hans de Goede wrote:
> Suspending Goodix touchscreens requires changing the interrupt pin to
> output before sending them a power-down command. Followed by wiggling
> the interrupt pin to wake the device up, after which it is put back
> in input mode.
> 
> On Bay Trail devices with a Goodix touchscreen direct-irq mode is used
> in combination with listing the pin as a normal GpioIo resource.
> 
> This works fine, until the goodix driver gets rmmod-ed and then insmod-ed
> again. In this case byt_gpio_disable_free() calls
> byt_gpio_clear_triggering() which clears the IRQ flags and after that the
> (direct) IRQ no longer triggers.
> 
> This commit fixes this by adding a check for the BYT_DIRECT_IRQ_EN flag
> to byt_gpio_clear_triggering().
> 
> Note that byt_gpio_clear_triggering() only gets called from
> byt_gpio_disable_free() for direct-irq enabled pins, as these are excluded
> from the irq_valid mask by byt_init_irq_valid_mask().
> 

Pushed to my review and testing queue, thanks!

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/pinctrl/intel/pinctrl-baytrail.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
> index db55761c90cc..844b89f230d7 100644
> --- a/drivers/pinctrl/intel/pinctrl-baytrail.c
> +++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
> @@ -742,8 +742,13 @@ static void byt_gpio_clear_triggering(struct intel_pinctrl *vg, unsigned int off
>  
>  	raw_spin_lock_irqsave(&byt_lock, flags);
>  	value = readl(reg);
> +	/* Do not clear direct-irq enabled irqs (from gpio_disable_free) */
> +	if (value & BYT_DIRECT_IRQ_EN)
> +		goto out;
> +
>  	value &= ~(BYT_TRIG_POS | BYT_TRIG_NEG | BYT_TRIG_LVL);
>  	writel(value, reg);
> +out:
>  	raw_spin_unlock_irqrestore(&byt_lock, flags);
>  }
>  
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


