Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF161074F2
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2019 16:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfKVPdS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Nov 2019 10:33:18 -0500
Received: from thoth.sbs.de ([192.35.17.2]:33792 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbfKVPdR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Nov 2019 10:33:17 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id xAMFX7ka032603
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 16:33:07 +0100
Received: from [139.25.68.37] ([139.25.68.37])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id xAMFX64q016437;
        Fri, 22 Nov 2019 16:33:07 +0100
Subject: Re: [PATCH v3 1/2] gpio: sch: Add edge event support
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <cover.1574277614.git.jan.kiszka@siemens.com>
 <42ae6149a14f81fd86c5acb5bd33e987123b6bed.1574277614.git.jan.kiszka@siemens.com>
 <20191122111219.GW32742@smile.fi.intel.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5d7399ce-1776-18ef-3bb5-6e3e8e7e7524@siemens.com>
Date:   Fri, 22 Nov 2019 16:33:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191122111219.GW32742@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 22.11.19 12:12, Andy Shevchenko wrote:
> On Wed, Nov 20, 2019 at 08:20:13PM +0100, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Add the required infrastructure consisting of an irq_chip_generic with
>> its irq_chip_type callbacks to enable and report edge events of the pins
>> to the gpio core. The actual hook-up of the event interrupt will happen
>> separately.
> 
>> +static int sch_irq_type(struct irq_data *d, unsigned int type)
>> +{
>> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
>> +	struct sch_gpio *sch = gc->private;
>> +	unsigned int gpio_num = d->irq - sch->irq_base;
>> +	unsigned long flags;
>> +	int rising = 0;
>> +	int falling = 0;
>> +
>> +	switch (type & IRQ_TYPE_SENSE_MASK) {
>> +	case IRQ_TYPE_EDGE_RISING:
>> +		rising = 1;
>> +		break;
>> +	case IRQ_TYPE_EDGE_FALLING:
>> +		falling = 1;
>> +		break;
>> +	case IRQ_TYPE_EDGE_BOTH:
>> +		rising = 1;
>> +		falling = 1;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	spin_lock_irqsave(&sch->lock, flags);
>> +	sch_gpio_reg_set(sch, gpio_num, GTPE, rising);
>> +	sch_gpio_reg_set(sch, gpio_num, GTNE, falling);
>> +	spin_unlock_irqrestore(&sch->lock, flags);
> 
> Won't we need to set up IRQ handler here and use handle_bad_irq() during
> initialization phase?

Why? This is just defining the edge type, not whether an interrupt could 
be generated or not. Also, we only have edge events here, so no reason 
to switch types.

> 
>> +
>> +	return 0;
>> +}
> 
>> +	irq_base = devm_irq_alloc_descs(&pdev->dev, -1, 0, sch->chip.ngpio,
>> +					NUMA_NO_NODE);
>> +	if (irq_base < 0)
>> +		return irq_base;
>> +	sch->irq_base = irq_base;
>> +
>> +	gc = devm_irq_alloc_generic_chip(&pdev->dev, "sch_gpio", 1, irq_base,
>> +					 NULL, handle_simple_irq);
>> +	if (!gc)
>> +		return -ENOMEM;
>> +
>> +	gc->private = sch;
>> +	ct = gc->chip_types;
>> +
>> +	ct->chip.irq_mask = sch_irq_mask;
>> +	ct->chip.irq_unmask = sch_irq_unmask;
>> +	ct->chip.irq_set_type = sch_irq_type;
>> +
>> +	ret = devm_irq_setup_generic_chip(&pdev->dev, gc,
>> +					  IRQ_MSK(sch->chip.ngpio),
>> +					  0, IRQ_NOREQUEST | IRQ_NOPROBE, 0);
>> +	if (ret)
>> +		return ret;
> 
> Shan't we do this in the (similar) way how it's done in pinctrl-cherryview.c
> driver? (Keep in mind later patches which are going to be v5.5)
> 

Can you be a bit more specific for me? Do you mean the pattern 
gpiochip_irqchip_add / gpiochip_set_chained_irqchip? What would be the 
difference / benefit? And how would I link sch_sci_handler to that pattern?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
