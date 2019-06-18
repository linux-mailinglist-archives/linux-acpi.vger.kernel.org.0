Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0203A4A7D4
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2019 19:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbfFRRFZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 Jun 2019 13:05:25 -0400
Received: from foss.arm.com ([217.140.110.172]:50702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729541AbfFRRFY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Jun 2019 13:05:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3905344;
        Tue, 18 Jun 2019 10:05:23 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83A243F246;
        Tue, 18 Jun 2019 10:05:22 -0700 (PDT)
Date:   Tue, 18 Jun 2019 18:05:20 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 3/4] arm_pmu: acpi: spe: Add initial MADT/SPE probing
Message-ID: <20190618170520.GB1360@e107155-lin>
References: <20190615010910.33921-1-jeremy.linton@arm.com>
 <20190615010910.33921-4-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615010910.33921-4-jeremy.linton@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 14, 2019 at 08:09:09PM -0500, Jeremy Linton wrote:
> ACPI 6.3 adds additional fields to the MADT GICC
> structure to describe SPE PPI's. We pick these out
> of the cached reference to the madt_gicc structure
> similarly to the core PMU code. We then create a platform
> device referring to the IRQ and let the user/module loader
> decide whether to load the SPE driver.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/include/asm/acpi.h |  3 ++
>  drivers/perf/arm_pmu_acpi.c   | 75 +++++++++++++++++++++++++++++++++++
>  include/linux/perf/arm_pmu.h  |  2 +
>  3 files changed, 80 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 7628efbe6c12..d10399b9f998 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -41,6 +41,9 @@
>  	(!(entry) || (entry)->header.length < ACPI_MADT_GICC_MIN_LENGTH || \
>  	(unsigned long)(entry) + (entry)->header.length > (end))
>  
> +#define ACPI_MADT_GICC_SPE  (ACPI_OFFSET(struct acpi_madt_generic_interrupt, \
> +	spe_interrupt) + sizeof(u16))
> +
>  /* Basic configuration for ACPI */
>  #ifdef	CONFIG_ACPI
>  pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
> index 0f197516d708..f5df100bc4f4 100644
> --- a/drivers/perf/arm_pmu_acpi.c
> +++ b/drivers/perf/arm_pmu_acpi.c
> @@ -74,6 +74,79 @@ static void arm_pmu_acpi_unregister_irq(int cpu)
>  	acpi_unregister_gsi(gsi);
>  }
>  
> +#if IS_ENABLED(CONFIG_ARM_SPE_PMU)
> +static struct resource spe_resources[] = {
> +	{
> +		/* irq */
> +		.flags          = IORESOURCE_IRQ,
> +	}
> +};
> +
> +static struct platform_device spe_dev = {
> +	.name = ARMV8_SPE_PDEV_NAME,
> +	.id = -1,
> +	.resource = spe_resources,
> +	.num_resources = ARRAY_SIZE(spe_resources)
> +};
> +
> +/*
> + * For lack of a better place, hook the normal PMU MADT walk
> + * and create a SPE device if we detect a recent MADT with
> + * a homogeneous PPI mapping.
> + */
> +static int arm_spe_acpi_register_device(void)
> +{
> +	int cpu, hetid, irq, ret;
> +	bool first = true;
> +	u16 gsi = 0;
> +
> +	/*
> +	 * sanity check all the GICC tables for the same interrupt number
> +	 * for now we only support homogeneous ACPI/SPE machines.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		struct acpi_madt_generic_interrupt *gicc;
> +
> +		gicc = acpi_cpu_get_madt_gicc(cpu);
> +		if (gicc->header.length < ACPI_MADT_GICC_SPE)
> +			return -ENODEV;
> +
> +		if (first) {
> +			gsi = gicc->spe_interrupt;
> +			if (!gsi)
> +				return -ENODEV;
> +			hetid = find_acpi_cpu_topology_hetero_id(cpu);
> +			first = false;
> +		} else if ((gsi != gicc->spe_interrupt) ||
> +			   (hetid != find_acpi_cpu_topology_hetero_id(cpu))) {

OK, after checking ACPI specification again and checking with people
involved in dynamic ACPI table generation, I think my earlier concerns
can be addressed by having a root node in any system(including
multi-socket ones) with IDENTICAL flag set in that root node.

With that note for archiving reasons so that we can refer people to
in future,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
