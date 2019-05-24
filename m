Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C856629552
	for <lists+linux-acpi@lfdr.de>; Fri, 24 May 2019 12:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390342AbfEXKAP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 May 2019 06:00:15 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38596 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390013AbfEXKAN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 24 May 2019 06:00:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2480415A2;
        Fri, 24 May 2019 03:00:13 -0700 (PDT)
Received: from redmoon (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3429E3F703;
        Fri, 24 May 2019 03:00:11 -0700 (PDT)
Date:   Fri, 24 May 2019 11:00:05 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 1/4] acpi/irq: implement getter for GSI irqdomain
Message-ID: <20190524100005.GB16829@redmoon>
References: <20190429131208.3620-1-ard.biesheuvel@linaro.org>
 <20190429131208.3620-2-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429131208.3620-2-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 29, 2019 at 03:12:05PM +0200, Ard Biesheuvel wrote:
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
> mode, we need a helper that returns the default domain for unqualified
> interrupts.
> 
> This is essentially what the ACPI GSI domain provides, so add a helper
> that returns a reference to this domain.

Or we directly export a function in:

drivers/acpi/irq.c

that creates a hierarchical domain with the default GSI domain as a
parent, instead of exporting a function to get that domain from drivers,
this should cut a bit of boilerplate and keep the default GSI domain
handling in ACPI core.

IIUC, the concept is a bit identical to what we did for MBIgen
except that there IORT sets-up the device->msi_domain pointer and
therefore the MBIgen driver does not have to do anything.

Lorenzo

> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/acpi/irq.c   | 14 ++++++++++----
>  include/linux/acpi.h |  1 +
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
> index c3b2222e2129..d47bbd54d4aa 100644
> --- a/drivers/acpi/irq.c
> +++ b/drivers/acpi/irq.c
> @@ -17,6 +17,14 @@ enum acpi_irq_model_id acpi_irq_model;
>  
>  static struct fwnode_handle *acpi_gsi_domain_id;
>  
> +/**
> + * acpi_get_gsi_irqdomain - Retrieve the irqdomain that owns the GSI space.
> + */
> +struct irq_domain *acpi_get_gsi_irqdomain(void)
> +{
> +	return irq_find_matching_fwnode(acpi_gsi_domain_id, DOMAIN_BUS_ANY);
> +}
> +
>  /**
>   * acpi_gsi_to_irq() - Retrieve the linux irq number for a given GSI
>   * @gsi: GSI IRQ number to map
> @@ -29,8 +37,7 @@ static struct fwnode_handle *acpi_gsi_domain_id;
>   */
>  int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
>  {
> -	struct irq_domain *d = irq_find_matching_fwnode(acpi_gsi_domain_id,
> -							DOMAIN_BUS_ANY);
> +	struct irq_domain *d = acpi_get_gsi_irqdomain();
>  
>  	*irq = irq_find_mapping(d, gsi);
>  	/*
> @@ -76,8 +83,7 @@ EXPORT_SYMBOL_GPL(acpi_register_gsi);
>   */
>  void acpi_unregister_gsi(u32 gsi)
>  {
> -	struct irq_domain *d = irq_find_matching_fwnode(acpi_gsi_domain_id,
> -							DOMAIN_BUS_ANY);
> +	struct irq_domain *d = acpi_get_gsi_irqdomain();
>  	int irq = irq_find_mapping(d, gsi);
>  
>  	irq_dispose_mapping(irq);
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index d5dcebd7aad3..1016027dd626 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -316,6 +316,7 @@ static inline bool acpi_sci_irq_valid(void)
>  extern int sbf_port;
>  extern unsigned long acpi_realmode_flags;
>  
> +struct irq_domain *acpi_get_gsi_irqdomain(void);
>  int acpi_register_gsi (struct device *dev, u32 gsi, int triggering, int polarity);
>  int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
>  int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);
> -- 
> 2.20.1
> 
