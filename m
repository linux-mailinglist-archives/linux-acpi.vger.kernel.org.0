Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C88C94AA08
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2019 20:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbfFRShy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 Jun 2019 14:37:54 -0400
Received: from foss.arm.com ([217.140.110.172]:54480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729900AbfFRShy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Jun 2019 14:37:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 820DB344;
        Tue, 18 Jun 2019 11:37:53 -0700 (PDT)
Received: from [192.168.122.164] (u201426.austin.arm.com [10.118.28.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F6E23F738;
        Tue, 18 Jun 2019 11:37:53 -0700 (PDT)
Subject: Re: [PATCH 3/4] arm_pmu: acpi: spe: Add initial MADT/SPE probing
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        mark.rutland@arm.com, sudeep.holla@arm.com
References: <20190615010910.33921-1-jeremy.linton@arm.com>
 <20190615010910.33921-4-jeremy.linton@arm.com>
 <20190618173607.GA22558@e121166-lin.cambridge.arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <57c18944-1cf4-ec2d-cc37-8187d25dcaa0@arm.com>
Date:   Tue, 18 Jun 2019 13:37:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190618173607.GA22558@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

Thanks for taking a look at this.

On 6/18/19 12:36 PM, Lorenzo Pieralisi wrote:
> On Fri, Jun 14, 2019 at 08:09:09PM -0500, Jeremy Linton wrote:
>> ACPI 6.3 adds additional fields to the MADT GICC
>> structure to describe SPE PPI's. We pick these out
>> of the cached reference to the madt_gicc structure
>> similarly to the core PMU code. We then create a platform
>> device referring to the IRQ and let the user/module loader
>> decide whether to load the SPE driver.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   arch/arm64/include/asm/acpi.h |  3 ++
>>   drivers/perf/arm_pmu_acpi.c   | 75 +++++++++++++++++++++++++++++++++++
>>   include/linux/perf/arm_pmu.h  |  2 +
>>   3 files changed, 80 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
>> index 7628efbe6c12..d10399b9f998 100644
>> --- a/arch/arm64/include/asm/acpi.h
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -41,6 +41,9 @@
>>   	(!(entry) || (entry)->header.length < ACPI_MADT_GICC_MIN_LENGTH || \
>>   	(unsigned long)(entry) + (entry)->header.length > (end))
>>   
>> +#define ACPI_MADT_GICC_SPE  (ACPI_OFFSET(struct acpi_madt_generic_interrupt, \
>> +	spe_interrupt) + sizeof(u16))
>> +
> 
> Nit: Do we really need this to be in a header file ?

Probably not, but its potentially useful as a MADT "version" check. It 
made sense to me to keep it close to ACPI_MADT_GICC_MIN_LENGTH for that 
purpose.


> 
>>   /* Basic configuration for ACPI */
>>   #ifdef	CONFIG_ACPI
>>   pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
>> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
>> index 0f197516d708..f5df100bc4f4 100644
>> --- a/drivers/perf/arm_pmu_acpi.c
>> +++ b/drivers/perf/arm_pmu_acpi.c
>> @@ -74,6 +74,79 @@ static void arm_pmu_acpi_unregister_irq(int cpu)
>>   	acpi_unregister_gsi(gsi);
>>   }
>>   
>> +#if IS_ENABLED(CONFIG_ARM_SPE_PMU)
>> +static struct resource spe_resources[] = {
>> +	{
>> +		/* irq */
>> +		.flags          = IORESOURCE_IRQ,
>> +	}
>> +};
>> +
>> +static struct platform_device spe_dev = {
>> +	.name = ARMV8_SPE_PDEV_NAME,
>> +	.id = -1,
>> +	.resource = spe_resources,
>> +	.num_resources = ARRAY_SIZE(spe_resources)
>> +};
>> +
>> +/*
>> + * For lack of a better place, hook the normal PMU MADT walk
>> + * and create a SPE device if we detect a recent MADT with
>> + * a homogeneous PPI mapping.
>> + */
>> +static int arm_spe_acpi_register_device(void)
>> +{
>> +	int cpu, hetid, irq, ret;
>> +	bool first = true;
>> +	u16 gsi = 0;
>> +
>> +	/*
>> +	 * sanity check all the GICC tables for the same interrupt number
>> +	 * for now we only support homogeneous ACPI/SPE machines.
>> +	 */
>> +	for_each_possible_cpu(cpu) {
>> +		struct acpi_madt_generic_interrupt *gicc;
>> +
>> +		gicc = acpi_cpu_get_madt_gicc(cpu);
>> +		if (gicc->header.length < ACPI_MADT_GICC_SPE)
>> +			return -ENODEV;
>> +
>> +		if (first) {
>> +			gsi = gicc->spe_interrupt;
>> +			if (!gsi)
>> +				return -ENODEV;
>> +			hetid = find_acpi_cpu_topology_hetero_id(cpu);
>> +			first = false;
>> +		} else if ((gsi != gicc->spe_interrupt) ||
>> +			   (hetid != find_acpi_cpu_topology_hetero_id(cpu))) {
>> +			pr_warn("ACPI: SPE must be homogeneous\n");
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	irq = acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE,
>> +				ACPI_ACTIVE_HIGH);
>> +	if (irq < 0) {
>> +		pr_warn("ACPI: SPE Unable to register interrupt: %d\n", gsi);
>> +		return irq;
>> +	}
>> +
>> +	spe_resources[0].start = irq;
>> +	ret = platform_device_register(&spe_dev);
>> +	if (ret < 0) {
>> +		pr_warn("ACPI: SPE: Unable to register device\n");
>> +		acpi_unregister_gsi(gsi);
>> +	}
>> +
>> +	return ret;
>> +}
>> +#else
>> +static inline int arm_spe_acpi_register_device(void)
>> +{
>> +	return -ENODEV;
>> +}
>> +#endif /* CONFIG_ARM_SPE_PMU */
>> +
>>   static int arm_pmu_acpi_parse_irqs(void)
>>   {
>>   	int irq, cpu, irq_cpu, err;
>> @@ -279,6 +352,8 @@ static int arm_pmu_acpi_init(void)
>>   	if (acpi_disabled)
>>   		return 0;
>>   
>> +	arm_spe_acpi_register_device(); /* failures are expected */
> 
> Sounds ominous and it is false, ACPI never fails :)
> 
> Nit: if we don't check the return value what's the point of
> returning it.

Dead code? It seems like we should be returning those errors, but what 
to do with them isn't clear. Making it hard to justify why its not just 
void.

OTOH, if SPE were common on arm64/ACPI machines tossing a messages along 
the lines of "Platform doesn't support SPE" could be useful depending on 
how worried one is about cluttering the boot log.


> 
> Nothing problematic, if you manage to update the code before
> merging it is a plus.
> 
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
>>   	ret = arm_pmu_acpi_parse_irqs();
>>   	if (ret)
>>   		return ret;
>> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
>> index 4641e850b204..784bc58f165a 100644
>> --- a/include/linux/perf/arm_pmu.h
>> +++ b/include/linux/perf/arm_pmu.h
>> @@ -175,4 +175,6 @@ void armpmu_free_irq(int irq, int cpu);
>>   
>>   #endif /* CONFIG_ARM_PMU */
>>   
>> +#define ARMV8_SPE_PDEV_NAME "arm,spe-v1"
>> +
>>   #endif /* __ARM_PMU_H__ */
>> -- 
>> 2.21.0
>>

