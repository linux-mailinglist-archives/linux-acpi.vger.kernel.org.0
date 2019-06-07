Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3732438BC3
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2019 15:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfFGNhW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Jun 2019 09:37:22 -0400
Received: from foss.arm.com ([217.140.110.172]:40260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727606AbfFGNhW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 7 Jun 2019 09:37:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64EDC346;
        Fri,  7 Jun 2019 06:37:21 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8AA63F96A;
        Fri,  7 Jun 2019 06:37:19 -0700 (PDT)
Date:   Fri, 7 Jun 2019 14:37:14 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        linuxarm@huawei.com, john.garry@huawei.com
Subject: Re: [PATCH v3 4/5] arm_pmu: acpi: spe: Add initial MADT/SPE probing
Message-ID: <20190607133714.GA15577@e107155-lin>
References: <20190503232407.37195-1-jeremy.linton@arm.com>
 <20190503232407.37195-5-jeremy.linton@arm.com>
 <20190607095729.GD2429@e107155-lin>
 <b4d7d954-5667-c32d-80ae-c45678d3f0e3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4d7d954-5667-c32d-80ae-c45678d3f0e3@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 07, 2019 at 08:28:04AM -0500, Jeremy Linton wrote:
> Hi,
> 
> On 6/7/19 4:57 AM, Sudeep Holla wrote:
> > On Fri, May 03, 2019 at 06:24:06PM -0500, Jeremy Linton wrote:
> > > ACPI 6.3 adds additional fields to the MADT GICC
> > > structure to describe SPE PPI's. We pick these out
> > > of the cached reference to the madt_gicc structure
> > > similarly to the core PMU code. We then create a platform
> > > device referring to the IRQ and let the user/module loader
> > > decide whether to load the SPE driver.
> > > 
> > > Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> > > ---
> > >   arch/arm64/include/asm/acpi.h |  3 ++
> > >   drivers/perf/Kconfig          |  5 +++
> > >   drivers/perf/arm_pmu_acpi.c   | 76 +++++++++++++++++++++++++++++++++++
> > >   include/linux/perf/arm_pmu.h  |  2 +
> > >   4 files changed, 86 insertions(+)
> > > 
> > > diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> > > index 7628efbe6c12..d10399b9f998 100644
> > > --- a/arch/arm64/include/asm/acpi.h
> > > +++ b/arch/arm64/include/asm/acpi.h
> > > @@ -41,6 +41,9 @@
> > >   	(!(entry) || (entry)->header.length < ACPI_MADT_GICC_MIN_LENGTH || \
> > >   	(unsigned long)(entry) + (entry)->header.length > (end))
> > > +#define ACPI_MADT_GICC_SPE  (ACPI_OFFSET(struct acpi_madt_generic_interrupt, \
> > > +	spe_interrupt) + sizeof(u16))
> > > +
> > >   /* Basic configuration for ACPI */
> > >   #ifdef	CONFIG_ACPI
> > >   pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
> > > diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> > > index af9bc178495d..bc2647c64c9d 100644
> > > --- a/drivers/perf/Kconfig
> > > +++ b/drivers/perf/Kconfig
> > > @@ -52,6 +52,11 @@ config ARM_PMU_ACPI
> > >   	depends on ARM_PMU && ACPI
> > >   	def_bool y
> > > +config ARM_SPE_ACPI
> > > +	depends on ARM_PMU_ACPI && ARM_SPE_PMU
> > > +	def_bool y
> > > +
> > > +
> > >   config ARM_DSU_PMU
> > >   	tristate "ARM DynamIQ Shared Unit (DSU) PMU"
> > >   	depends on ARM64
> > > diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
> > > index 0f197516d708..b0244e1e8c91 100644
> > > --- a/drivers/perf/arm_pmu_acpi.c
> > > +++ b/drivers/perf/arm_pmu_acpi.c
> > > @@ -74,6 +74,80 @@ static void arm_pmu_acpi_unregister_irq(int cpu)
> > >   	acpi_unregister_gsi(gsi);
> > >   }
> > > +#ifdef CONFIG_ARM_SPE_ACPI
> > > +static struct resource spe_resources[] = {
> > > +	{
> > > +		/* irq */
> > > +		.flags          = IORESOURCE_IRQ,
> > > +	}
> > > +};
> > > +
> > > +static struct platform_device spe_dev = {
> > > +	.name = ARMV8_SPE_PDEV_NAME,
> > > +	.id = -1,
> > > +	.resource = spe_resources,
> > > +	.num_resources = ARRAY_SIZE(spe_resources)
> > > +};
> > > +
> > > +/*
> > > + * For lack of a better place, hook the normal PMU MADT walk
> > > + * and create a SPE device if we detect a recent MADT with
> > > + * a homogeneous PPI mapping.
> > > + */
> > > +static int arm_spe_acpi_register_device(void)
> > > +{
> > > +	int cpu, ret, irq;
> > > +	int hetid;
> > > +	u16 gsi = 0;
> > > +	bool first = true;
> > > +
> > > +	struct acpi_madt_generic_interrupt *gicc;
> > > +
> > > +	/*
> > > +	 * sanity check all the GICC tables for the same interrupt number
> > > +	 * for now we only support homogeneous ACPI/SPE machines.
> > > +	 */
> > > +	for_each_possible_cpu(cpu) {
> > > +		gicc = acpi_cpu_get_madt_gicc(cpu);
> > > +
> > > +		if (gicc->header.length < ACPI_MADT_GICC_SPE)
> > > +			return -ENODEV;
> > > +		if (first) {
> > > +			gsi = gicc->spe_interrupt;
> > > +			if (!gsi)
> > > +				return -ENODEV;
> > > +			hetid = find_acpi_cpu_topology_hetero_id(cpu);
> > > +			first = false;
> > > +		} else if ((gsi != gicc->spe_interrupt) ||
> > > +			   (hetid != find_acpi_cpu_topology_hetero_id(cpu))) {
> > 
> > Sorry, I should have noticed this in patch 2 itself. Won't this break for
> > multi-socket system ? The hetid in that case will be package id, no ?
> 
> Your assuming a PPTT with multiple trees, one for each socket? Yes it breaks
> in that case, and is what I was complaining about in the cover letter
> because there won't be a common node with the IDENTICAL flag set. OTOH, I
> think it works fine for multi-socket given a single tree where the root has
> IDENTICAL set (I did some very light testing on such a machine).
>

Ah OK, so you are saying such system must have root with IDENTICAL flag
set. Sounds fine, but is there any way to check that ? It's not mandated
right. At least, I didn't have when I hacked up PPTT for Juno and no one
complains(iasl/uefi/linux). But yes that's a different problem, at-least
we know how to fix such PPTT topology.

> I don't think there is a solution to this problem that won't break in the
> case of a heterogeneous machine with multiple sockets populated with
> differing cores.
>

Agreed, I was worried about only about case, but having root node is
feasible solution.

--
Regards,
Sudeep
