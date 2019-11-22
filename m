Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB509106EEE
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2019 12:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbfKVLM2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Nov 2019 06:12:28 -0500
Received: from mga09.intel.com ([134.134.136.24]:24547 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728618AbfKVLMX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Nov 2019 06:12:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2019 03:12:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,229,1571727600"; 
   d="scan'208";a="210220363"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 22 Nov 2019 03:12:20 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iY6rL-0000bl-Jr; Fri, 22 Nov 2019 13:12:19 +0200
Date:   Fri, 22 Nov 2019 13:12:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v3 1/2] gpio: sch: Add edge event support
Message-ID: <20191122111219.GW32742@smile.fi.intel.com>
References: <cover.1574277614.git.jan.kiszka@siemens.com>
 <42ae6149a14f81fd86c5acb5bd33e987123b6bed.1574277614.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42ae6149a14f81fd86c5acb5bd33e987123b6bed.1574277614.git.jan.kiszka@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
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

Won't we need to set up IRQ handler here and use handle_bad_irq() during
initialization phase?

> +
> +	return 0;
> +}

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

Shan't we do this in the (similar) way how it's done in pinctrl-cherryview.c
driver? (Keep in mind later patches which are going to be v5.5)

-- 
With Best Regards,
Andy Shevchenko


