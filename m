Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42C4630A86
	for <lists+linux-acpi@lfdr.de>; Fri, 31 May 2019 10:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfEaIqA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 May 2019 04:46:00 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:62478 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaIqA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 31 May 2019 04:46:00 -0400
Received: from 79.184.255.225.ipv4.supernova.orange.pl (79.184.255.225) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id f191c577164177af; Fri, 31 May 2019 10:45:58 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v4 1/4] acpi/irq: implement helper to create hierachical domains
Date:   Fri, 31 May 2019 10:45:57 +0200
Message-ID: <1909675.6iIoxqmsXk@kreacher>
In-Reply-To: <20190528133647.3362-2-ard.biesheuvel@linaro.org>
References: <20190528133647.3362-1-ard.biesheuvel@linaro.org> <20190528133647.3362-2-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, May 28, 2019 3:36:44 PM CEST Ard Biesheuvel wrote:
> ACPI permits arbitrary producer->consumer interrupt links to be
> described in AML, which means a topology such as the following
> is perfectly legal:
> 
>   Device (EXIU) {
>     Name (_HID, "SCX0008")
>     Name (_UID, Zero)
>     Name (_CRS, ResourceTemplate () {
>       ...
>     })
>   }
> 
>   Device (GPIO) {
>     Name (_HID, "SCX0007")
>     Name (_UID, Zero)
>     Name (_CRS, ResourceTemplate () {
>       Memory32Fixed (ReadWrite, SYNQUACER_GPIO_BASE, SYNQUACER_GPIO_SIZE)
>       Interrupt (ResourceConsumer, Edge, ActiveHigh, ExclusiveAndWake, 0, "\\_SB.EXIU") {
>         7,
>       }
>     })
>     ...
>   }
> 
> The EXIU in this example is the external interrupt unit as can be found
> on Socionext SynQuacer based platforms, which converts a block of 32 SPIs
> from arbitrary polarity/trigger into level-high, with a separate set
> of config/mask/unmask/clear controls.
> 
> The existing DT based driver in drivers/irqchip/irq-sni-exiu.c models
> this as a hierarchical domain stacked on top of the GIC's irqdomain.
> Since the GIC is modeled as a DT node as well, obtaining a reference
> to this irqdomain is easily done by going through the parent link.
> 
> On ACPI systems, however, the GIC is not modeled as an object in the
> namespace, and so device objects cannot refer to it directly. So in
> order to obtain the irqdomain reference when driving the EXIU in ACPI
> mode, we need a helper that implicitly grabs the default domain as the
> parent of the hierarchy for interrupts allocated out of the global GSI
> pool.
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

if that matters.

> ---
>  drivers/acpi/irq.c   | 26 ++++++++++++++++++++
>  include/linux/acpi.h |  7 ++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
> index c3b2222e2129..ce6b25a3b7a7 100644
> --- a/drivers/acpi/irq.c
> +++ b/drivers/acpi/irq.c
> @@ -295,3 +295,29 @@ void __init acpi_set_irq_model(enum acpi_irq_model_id model,
>  	acpi_irq_model = model;
>  	acpi_gsi_domain_id = fwnode;
>  }
> +
> +/**
> + * acpi_irq_create_hierarchy - Create a hierarchical IRQ domain with the default
> + *                             GSI domain as its parent.
> + * @flags:      Irq domain flags associated with the domain
> + * @size:       Size of the domain.
> + * @fwnode:     Optional fwnode of the interrupt controller
> + * @ops:        Pointer to the interrupt domain callbacks
> + * @host_data:  Controller private data pointer
> + */
> +struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
> +					     unsigned int size,
> +					     struct fwnode_handle *fwnode,
> +					     const struct irq_domain_ops *ops,
> +					     void *host_data)
> +{
> +	struct irq_domain *d = irq_find_matching_fwnode(acpi_gsi_domain_id,
> +							DOMAIN_BUS_ANY);
> +
> +	if (!d)
> +		return NULL;
> +
> +	return irq_domain_create_hierarchy(d, flags, size, fwnode, ops,
> +					   host_data);
> +}
> +EXPORT_SYMBOL_GPL(acpi_irq_create_hierarchy);
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 98440df7fe42..70de4bc30cea 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -23,6 +23,7 @@
>  
>  #include <linux/errno.h>
>  #include <linux/ioport.h>	/* for struct resource */
> +#include <linux/irqdomain.h>
>  #include <linux/resource_ext.h>
>  #include <linux/device.h>
>  #include <linux/property.h>
> @@ -327,6 +328,12 @@ int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);
>  void acpi_set_irq_model(enum acpi_irq_model_id model,
>  			struct fwnode_handle *fwnode);
>  
> +struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
> +					     unsigned int size,
> +					     struct fwnode_handle *fwnode,
> +					     const struct irq_domain_ops *ops,
> +					     void *host_data);
> +
>  #ifdef CONFIG_X86_IO_APIC
>  extern int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity);
>  #else
> 




