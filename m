Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 096F5FDAB0
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Nov 2019 11:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfKOKHC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Nov 2019 05:07:02 -0500
Received: from mga17.intel.com ([192.55.52.151]:9703 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbfKOKHC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Nov 2019 05:07:02 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 02:07:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,308,1569308400"; 
   d="scan'208";a="405288075"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 15 Nov 2019 02:06:58 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iVYVF-0002yU-Ob; Fri, 15 Nov 2019 12:06:57 +0200
Date:   Fri, 15 Nov 2019 12:06:57 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 3/3] pinctrl: cherryview: Pass irqchip when adding
 gpiochip
Message-ID: <20191115100657.GM32742@smile.fi.intel.com>
References: <20191114100804.15148-1-hdegoede@redhat.com>
 <20191114100804.15148-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114100804.15148-3-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 14, 2019 at 11:08:04AM +0100, Hans de Goede wrote:
> We need to convert all old gpio irqchips to pass the irqchip
> setup along when adding the gpio_chip. For more info see
> drivers/gpio/TODO.
> 
> For chained irqchips this is a pretty straight-forward conversion.
> 

Pushed all three to my review and testing queue, thanks!
(For v5.6 I suppose due to dependencies)

> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - Add kerneldoc for chv_pinctrl.irq struct member
> 
> Changes in v4:
> - Rebase on latest intel-pinctrl/for-next
> - Fold if (need_valid_mask) ... if (!need_valid_mask) ... into an if-else
> ---
>  drivers/pinctrl/intel/pinctrl-cherryview.c | 45 +++++++++++-----------
>  1 file changed, 22 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
> index b3f6f7726b04..60527b93a711 100644
> --- a/drivers/pinctrl/intel/pinctrl-cherryview.c
> +++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
> @@ -149,6 +149,7 @@ struct chv_pin_context {
>   * @chip: GPIO chip in this pin controller
>   * @irqchip: IRQ chip in this pin controller
>   * @regs: MMIO registers
> + * @irq: Our parent irq
>   * @intr_lines: Stores mapping between 16 HW interrupt wires and GPIO
>   *		offset (in GPIO number space)
>   * @community: Community this pinctrl instance represents
> @@ -165,6 +166,7 @@ struct chv_pinctrl {
>  	struct gpio_chip chip;
>  	struct irq_chip irqchip;
>  	void __iomem *regs;
> +	unsigned int irq;
>  	unsigned int intr_lines[16];
>  	const struct chv_community *community;
>  	u32 saved_intmask;
> @@ -1617,18 +1619,26 @@ static int chv_gpio_probe(struct chv_pinctrl *pctrl, int irq)
>  	chip->add_pin_ranges = chv_gpio_add_pin_ranges;
>  	chip->parent = pctrl->dev;
>  	chip->base = -1;
> -	if (need_valid_mask)
> -		chip->irq.init_valid_mask = chv_init_irq_valid_mask;
> -
> -	ret = devm_gpiochip_add_data(pctrl->dev, chip, pctrl);
> -	if (ret) {
> -		dev_err(pctrl->dev, "Failed to register gpiochip\n");
> -		return ret;
> -	}
>  
> -	chv_gpio_irq_init_hw(chip);
> +	pctrl->irq = irq;
> +	pctrl->irqchip.name = "chv-gpio";
> +	pctrl->irqchip.irq_startup = chv_gpio_irq_startup;
> +	pctrl->irqchip.irq_ack = chv_gpio_irq_ack;
> +	pctrl->irqchip.irq_mask = chv_gpio_irq_mask;
> +	pctrl->irqchip.irq_unmask = chv_gpio_irq_unmask;
> +	pctrl->irqchip.irq_set_type = chv_gpio_irq_type;
> +	pctrl->irqchip.flags = IRQCHIP_SKIP_SET_WAKE;
>  
> -	if (!need_valid_mask) {
> +	chip->irq.chip = &pctrl->irqchip;
> +	chip->irq.init_hw = chv_gpio_irq_init_hw;
> +	chip->irq.parent_handler = chv_gpio_irq_handler;
> +	chip->irq.num_parents = 1;
> +	chip->irq.parents = &pctrl->irq;
> +	chip->irq.default_type = IRQ_TYPE_NONE;
> +	chip->irq.handler = handle_bad_irq;
> +	if (need_valid_mask) {
> +		chip->irq.init_valid_mask = chv_init_irq_valid_mask;
> +	} else {
>  		irq_base = devm_irq_alloc_descs(pctrl->dev, -1, 0,
>  						community->npins, NUMA_NO_NODE);
>  		if (irq_base < 0) {
> @@ -1637,18 +1647,9 @@ static int chv_gpio_probe(struct chv_pinctrl *pctrl, int irq)
>  		}
>  	}
>  
> -	pctrl->irqchip.name = "chv-gpio";
> -	pctrl->irqchip.irq_startup = chv_gpio_irq_startup;
> -	pctrl->irqchip.irq_ack = chv_gpio_irq_ack;
> -	pctrl->irqchip.irq_mask = chv_gpio_irq_mask;
> -	pctrl->irqchip.irq_unmask = chv_gpio_irq_unmask;
> -	pctrl->irqchip.irq_set_type = chv_gpio_irq_type;
> -	pctrl->irqchip.flags = IRQCHIP_SKIP_SET_WAKE;
> -
> -	ret = gpiochip_irqchip_add(chip, &pctrl->irqchip, 0,
> -				   handle_bad_irq, IRQ_TYPE_NONE);
> +	ret = devm_gpiochip_add_data(pctrl->dev, chip, pctrl);
>  	if (ret) {
> -		dev_err(pctrl->dev, "failed to add IRQ chip\n");
> +		dev_err(pctrl->dev, "Failed to register gpiochip\n");
>  		return ret;
>  	}
>  
> @@ -1662,8 +1663,6 @@ static int chv_gpio_probe(struct chv_pinctrl *pctrl, int irq)
>  		}
>  	}
>  
> -	gpiochip_set_chained_irqchip(chip, &pctrl->irqchip, irq,
> -				     chv_gpio_irq_handler);
>  	return 0;
>  }
>  
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko


