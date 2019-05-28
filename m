Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 249F82C40E
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2019 12:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfE1KMv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 May 2019 06:12:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:32146 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfE1KMv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 May 2019 06:12:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 03:12:51 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 28 May 2019 03:12:47 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 28 May 2019 13:12:46 +0300
Date:   Tue, 28 May 2019 13:12:46 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v3 3/4] irqchip/exiu: implement ACPI support
Message-ID: <20190528101246.GX2781@lahna.fi.intel.com>
References: <20190527112720.2266-1-ard.biesheuvel@linaro.org>
 <20190527112720.2266-4-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527112720.2266-4-ard.biesheuvel@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 27, 2019 at 01:27:19PM +0200, Ard Biesheuvel wrote:
> Expose the existing EXIU hierarchical irqchip domain code to permit
> the interrupt controller to be used as the irqchip component of a
> GPIO controller on ACPI systems, or as the target of ordinary
> interrupt resources.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/irqchip/irq-sni-exiu.c | 76 +++++++++++++++++---
>  1 file changed, 68 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-sni-exiu.c b/drivers/irqchip/irq-sni-exiu.c
> index fef7c2437dfb..30a323a2b332 100644
> --- a/drivers/irqchip/irq-sni-exiu.c
> +++ b/drivers/irqchip/irq-sni-exiu.c
> @@ -20,6 +20,7 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> +#include <linux/platform_device.h>
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  
> @@ -134,9 +135,13 @@ static int exiu_domain_translate(struct irq_domain *domain,
>  
>  		*hwirq = fwspec->param[1] - info->spi_base;
>  		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
> -		return 0;
> +	} else {
> +		if (fwspec->param_count != 2)
> +			return -EINVAL;
> +		*hwirq = fwspec->param[0];
> +		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
>  	}
> -	return -EINVAL;
> +	return 0;
>  }
>  
>  static int exiu_domain_alloc(struct irq_domain *dom, unsigned int virq,
> @@ -147,16 +152,21 @@ static int exiu_domain_alloc(struct irq_domain *dom, unsigned int virq,
>  	struct exiu_irq_data *info = dom->host_data;
>  	irq_hw_number_t hwirq;
>  
> -	if (fwspec->param_count != 3)
> -		return -EINVAL;	/* Not GIC compliant */
> -	if (fwspec->param[0] != GIC_SPI)
> -		return -EINVAL;	/* No PPI should point to this domain */
> +	parent_fwspec = *fwspec;
> +	if (is_of_node(dom->parent->fwnode)) {
> +		if (fwspec->param_count != 3)
> +			return -EINVAL;	/* Not GIC compliant */
> +		if (fwspec->param[0] != GIC_SPI)
> +			return -EINVAL;	/* No PPI should point to this domain */
>  
> +		hwirq = fwspec->param[1] - info->spi_base;
> +	} else {
> +		hwirq = fwspec->param[0];
> +		parent_fwspec.param[0] = hwirq + info->spi_base + 32;
> +	}
>  	WARN_ON(nr_irqs != 1);
> -	hwirq = fwspec->param[1] - info->spi_base;
>  	irq_domain_set_hwirq_and_chip(dom, virq, hwirq, &exiu_irq_chip, info);
>  
> -	parent_fwspec = *fwspec;
>  	parent_fwspec.fwnode = dom->parent->fwnode;
>  	return irq_domain_alloc_irqs_parent(dom, virq, nr_irqs, &parent_fwspec);
>  }
> @@ -245,3 +255,53 @@ static int __init exiu_dt_init(struct device_node *node,
>  	return -ENOMEM;
>  }
>  IRQCHIP_DECLARE(exiu, "socionext,synquacer-exiu", exiu_dt_init);
> +
> +#ifdef CONFIG_ACPI
> +static int exiu_acpi_probe(struct platform_device *pdev)
> +{
> +	struct irq_domain *domain;
> +	struct exiu_irq_data *data;
> +	struct resource *res;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "failed to parse memory resource\n");
> +		return -ENXIO;
> +	}
> +
> +	data = exiu_init(dev_fwnode(&pdev->dev), res);
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	domain = acpi_irq_create_hierarchy(0, NUM_IRQS, dev_fwnode(&pdev->dev),
> +					   &exiu_domain_ops, data);
> +	if (!domain) {
> +		dev_err(&pdev->dev, "failed to create IRQ domain\n");
> +		goto out_unmap;
> +	}
> +
> +	dev_info(&pdev->dev, "%d interrupts forwarded\n", NUM_IRQS);

Not sure how useful this message is for the end user. Maybe dev_dbg()
instead.

Regardless,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
