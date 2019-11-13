Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16277FB8C7
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2019 20:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfKMT11 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Nov 2019 14:27:27 -0500
Received: from mga06.intel.com ([134.134.136.31]:57823 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfKMT11 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 13 Nov 2019 14:27:27 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 11:27:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,301,1569308400"; 
   d="scan'208";a="406071628"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 13 Nov 2019 11:27:23 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iUyIU-0000L0-U9; Wed, 13 Nov 2019 21:27:22 +0200
Date:   Wed, 13 Nov 2019 21:27:22 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 3/3] pinctrl: cherryview: Pass irqchip when adding
 gpiochip
Message-ID: <20191113192722.GK32742@smile.fi.intel.com>
References: <20191113190520.305410-1-hdegoede@redhat.com>
 <20191113190520.305410-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113190520.305410-3-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 13, 2019 at 08:05:20PM +0100, Hans de Goede wrote:
> We need to convert all old gpio irqchips to pass the irqchip
> setup along when adding the gpio_chip. For more info see
> drivers/gpio/TODO.
> 
> For chained irqchips this is a pretty straight-forward conversion.
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

>  	struct irq_chip irqchip;
>  	void __iomem *regs;
> +	unsigned int irq;
>  	unsigned intr_lines[16];

This will conflict with our for-next.

> +	if (need_valid_mask)
> +		chip->irq.init_valid_mask = chv_init_irq_valid_mask;
> +	chip->irq.init_hw = chv_gpio_irq_init_hw;
> +	chip->irq.parent_handler = chv_gpio_irq_handler;
> +	chip->irq.num_parents = 1;
> +	chip->irq.parents = &pctrl->irq;
> +	chip->irq.default_type = IRQ_TYPE_NONE;
> +	chip->irq.handler = handle_bad_irq;
>  
>  	if (!need_valid_mask) {
>  		irq_base = devm_irq_alloc_descs(pctrl->dev, -1, 0,


Perhaps now it makes sense to

	if (need_valid_mask) {
		chip->irq.init_valid_mask = chv_init_irq_valid_mask;
	} else {
		irq_base = devm_irq_alloc_descs(pctrl->dev, -1, 0,
		...
	}

?

-- 
With Best Regards,
Andy Shevchenko


