Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59236F1AF2
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2019 17:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfKFQQ2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Nov 2019 11:16:28 -0500
Received: from mga09.intel.com ([134.134.136.24]:12094 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbfKFQQ2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 6 Nov 2019 11:16:28 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 08:16:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="353523137"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 06 Nov 2019 08:16:23 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iSNyo-0005px-Dm; Wed, 06 Nov 2019 18:16:22 +0200
Date:   Wed, 6 Nov 2019 18:16:22 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 3/3] pinctrl: cherryview: Pass irqchip when adding
 gpiochip
Message-ID: <20191106161622.GM32742@smile.fi.intel.com>
References: <20191106154715.155596-1-hdegoede@redhat.com>
 <20191106154715.155596-4-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106154715.155596-4-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 06, 2019 at 04:47:15PM +0100, Hans de Goede wrote:
> We need to convert all old gpio irqchips to pass the irqchip
> setup along when adding the gpio_chip. For more info see
> drivers/gpio/TODO.
> 
> For chained irqchips this is a pretty straight-forward conversion.

> +	chip->irq.chip = &pctrl->irqchip;

> +	if (pctrl->need_valid_mask)
> +		chip->irq.init_valid_mask = chv_init_irq_valid_mask;

I just realize we probably may assign here unconditionally

> +	chip->irq.init_hw = chv_gpio_irq_init_hw;
> +	chip->irq.parent_handler = chv_gpio_irq_handler;
> +	chip->irq.num_parents = 1;
> +	chip->irq.parents = &pctrl->irq;
> +	chip->irq.default_type = IRQ_TYPE_NONE;
> +	chip->irq.handler = handle_bad_irq;
>  
>  	if (!pctrl->need_valid_mask) {
>  		irq_base = devm_irq_alloc_descs(pctrl->dev, -1, 0,
> @@ -1640,18 +1651,9 @@ static int chv_gpio_probe(struct chv_pinctrl *pctrl, int irq)
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
> @@ -1665,8 +1667,6 @@ static int chv_gpio_probe(struct chv_pinctrl *pctrl, int irq)
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


