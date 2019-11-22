Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6758107097
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2019 12:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfKVLXW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Nov 2019 06:23:22 -0500
Received: from mga09.intel.com ([134.134.136.24]:22241 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728457AbfKVKlV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Nov 2019 05:41:21 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2019 02:41:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,229,1571727600"; 
   d="scan'208";a="216341170"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 22 Nov 2019 02:41:17 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 22 Nov 2019 12:41:16 +0200
Date:   Fri, 22 Nov 2019 12:41:16 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v3 1/2] gpio: sch: Add edge event support
Message-ID: <20191122104116.GB11621@lahna.fi.intel.com>
References: <cover.1574277614.git.jan.kiszka@siemens.com>
 <42ae6149a14f81fd86c5acb5bd33e987123b6bed.1574277614.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42ae6149a14f81fd86c5acb5bd33e987123b6bed.1574277614.git.jan.kiszka@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 20, 2019 at 08:20:13PM +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Add the required infrastructure consisting of an irq_chip_generic with
> its irq_chip_type callbacks to enable and report edge events of the pins
> to the gpio core. The actual hook-up of the event interrupt will happen
> separately.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

One nit below. Regardless of that

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

> ---
>  drivers/gpio/gpio-sch.c | 114 +++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 107 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-sch.c b/drivers/gpio/gpio-sch.c
> index fb143f28c386..6a9c5500800c 100644
> --- a/drivers/gpio/gpio-sch.c
> +++ b/drivers/gpio/gpio-sch.c
> @@ -18,12 +18,17 @@
>  #define GEN	0x00
>  #define GIO	0x04
>  #define GLV	0x08
> +#define GTPE	0x0c
> +#define GTNE	0x10
> +#define GGPE	0x14
> +#define GTS	0x1c
>  
>  struct sch_gpio {
>  	struct gpio_chip chip;
>  	spinlock_t lock;
>  	unsigned short iobase;
>  	unsigned short resume_base;
> +	int irq_base;
>  };
>  
>  static unsigned sch_gpio_offset(struct sch_gpio *sch, unsigned gpio,
> @@ -79,10 +84,11 @@ static void sch_gpio_reg_set(struct sch_gpio *sch, unsigned gpio, unsigned reg,
>  static int sch_gpio_direction_in(struct gpio_chip *gc, unsigned gpio_num)
>  {
>  	struct sch_gpio *sch = gpiochip_get_data(gc);
> +	unsigned long flags;
>  
> -	spin_lock(&sch->lock);
> +	spin_lock_irqsave(&sch->lock, flags);
>  	sch_gpio_reg_set(sch, gpio_num, GIO, 1);
> -	spin_unlock(&sch->lock);
> +	spin_unlock_irqrestore(&sch->lock, flags);
>  	return 0;
>  }
>  
> @@ -95,20 +101,22 @@ static int sch_gpio_get(struct gpio_chip *gc, unsigned gpio_num)
>  static void sch_gpio_set(struct gpio_chip *gc, unsigned gpio_num, int val)
>  {
>  	struct sch_gpio *sch = gpiochip_get_data(gc);
> +	unsigned long flags;
>  
> -	spin_lock(&sch->lock);
> +	spin_lock_irqsave(&sch->lock, flags);
>  	sch_gpio_reg_set(sch, gpio_num, GLV, val);
> -	spin_unlock(&sch->lock);
> +	spin_unlock_irqrestore(&sch->lock, flags);
>  }
>  
>  static int sch_gpio_direction_out(struct gpio_chip *gc, unsigned gpio_num,
>  				  int val)
>  {
>  	struct sch_gpio *sch = gpiochip_get_data(gc);
> +	unsigned long flags;
>  
> -	spin_lock(&sch->lock);
> +	spin_lock_irqsave(&sch->lock, flags);
>  	sch_gpio_reg_set(sch, gpio_num, GIO, 0);
> -	spin_unlock(&sch->lock);
> +	spin_unlock_irqrestore(&sch->lock, flags);
>  
>  	/*
>  	 * according to the datasheet, writing to the level register has no
> @@ -130,6 +138,12 @@ static int sch_gpio_get_direction(struct gpio_chip *gc, unsigned gpio_num)
>  	return sch_gpio_reg_get(sch, gpio_num, GIO);
>  }
>  
> +static int sch_gpio_to_irq(struct gpio_chip *gpio, unsigned int offset)
> +{
> +	struct sch_gpio *sch = gpiochip_get_data(gpio);
> +	return sch->irq_base + offset;
> +}
> +
>  static const struct gpio_chip sch_gpio_chip = {
>  	.label			= "sch_gpio",
>  	.owner			= THIS_MODULE,
> @@ -138,12 +152,70 @@ static const struct gpio_chip sch_gpio_chip = {
>  	.direction_output	= sch_gpio_direction_out,
>  	.set			= sch_gpio_set,
>  	.get_direction		= sch_gpio_get_direction,
> +	.to_irq			= sch_gpio_to_irq,
>  };
>  
> +static int sch_irq_type(struct irq_data *d, unsigned int type)
> +{
> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> +	struct sch_gpio *sch = gc->private;
> +	unsigned int gpio_num = d->irq - sch->irq_base;
> +	unsigned long flags;
> +	int rising = 0;
> +	int falling = 0;
> +
> +	switch (type & IRQ_TYPE_SENSE_MASK) {
> +	case IRQ_TYPE_EDGE_RISING:
> +		rising = 1;
> +		break;
> +	case IRQ_TYPE_EDGE_FALLING:
> +		falling = 1;
> +		break;
> +	case IRQ_TYPE_EDGE_BOTH:
> +		rising = 1;
> +		falling = 1;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	spin_lock_irqsave(&sch->lock, flags);
> +	sch_gpio_reg_set(sch, gpio_num, GTPE, rising);
> +	sch_gpio_reg_set(sch, gpio_num, GTNE, falling);
> +	spin_unlock_irqrestore(&sch->lock, flags);
> +
> +	return 0;
> +}
> +
> +static void sch_irq_set_enable(struct irq_data *d, int val)
> +{
> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> +	struct sch_gpio *sch = gc->private;
> +	unsigned int gpio_num = d->irq - sch->irq_base;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&sch->lock, flags);
> +	sch_gpio_reg_set(sch, gpio_num, GGPE, val);
> +	spin_unlock_irqrestore(&sch->lock, flags);
> +}
> +
> +static void sch_irq_mask(struct irq_data *d)
> +{
> +	sch_irq_set_enable(d, 0);
> +}
> +
> +static void sch_irq_unmask(struct irq_data *d)
> +{
> +	sch_irq_set_enable(d, 1);
> +}
> +
>  static int sch_gpio_probe(struct platform_device *pdev)
>  {
> +	struct irq_chip_generic *gc;
> +	struct irq_chip_type *ct;
>  	struct sch_gpio *sch;
>  	struct resource *res;
> +	int irq_base, ret;
>  
>  	sch = devm_kzalloc(&pdev->dev, sizeof(*sch), GFP_KERNEL);
>  	if (!sch)
> @@ -203,7 +275,35 @@ static int sch_gpio_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, sch);
>  
> -	return devm_gpiochip_add_data(&pdev->dev, &sch->chip, sch);
> +	ret = devm_gpiochip_add_data(&pdev->dev, &sch->chip, sch);
> +	if (ret)
> +		return ret;
> +
> +	irq_base = devm_irq_alloc_descs(&pdev->dev, -1, 0, sch->chip.ngpio,
> +					NUMA_NO_NODE);
> +	if (irq_base < 0)
> +		return irq_base;
> +	sch->irq_base = irq_base;
> +
> +	gc = devm_irq_alloc_generic_chip(&pdev->dev, "sch_gpio", 1, irq_base,
> +					 NULL, handle_simple_irq);
> +	if (!gc)
> +		return -ENOMEM;
> +
> +	gc->private = sch;
> +	ct = gc->chip_types;
> +
> +	ct->chip.irq_mask = sch_irq_mask;
> +	ct->chip.irq_unmask = sch_irq_unmask;
> +	ct->chip.irq_set_type = sch_irq_type;
> +
> +	ret = devm_irq_setup_generic_chip(&pdev->dev, gc,
> +					  IRQ_MSK(sch->chip.ngpio),
> +					  0, IRQ_NOREQUEST | IRQ_NOPROBE, 0);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

Here you can simply do 

	return devm_irq_setup_generic_chip(...);
>  }
>  
>  static struct platform_driver sch_gpio_driver = {
> -- 
> 2.16.4
