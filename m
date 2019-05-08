Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4DA180CE
	for <lists+linux-acpi@lfdr.de>; Wed,  8 May 2019 22:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfEHUEM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 May 2019 16:04:12 -0400
Received: from foss.arm.com ([217.140.101.70]:45016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbfEHUEM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 8 May 2019 16:04:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44555374;
        Wed,  8 May 2019 13:04:11 -0700 (PDT)
Received: from [192.168.100.241] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B3CD3F575;
        Wed,  8 May 2019 13:04:10 -0700 (PDT)
Subject: Re: [PATCH v3 4/5] arm_pmu: acpi: spe: Add initial MADT/SPE probing
To:     John Garry <john.garry@huawei.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        sudeep.holla@arm.com, linuxarm@huawei.com
References: <20190503232407.37195-1-jeremy.linton@arm.com>
 <20190503232407.37195-5-jeremy.linton@arm.com>
 <dbb1312e-a2fb-4d75-03dd-bbaabdb647b4@huawei.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <c42e3d8a-51fa-ea0c-6733-0e133050cdfe@arm.com>
Date:   Wed, 8 May 2019 15:04:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <dbb1312e-a2fb-4d75-03dd-bbaabdb647b4@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

Thanks for taking a look at this,

On 5/8/19 6:18 AM, John Garry wrote:
e> On 04/05/2019 00:24, Jeremy Linton wrote:
>> ACPI 6.3 adds additional fields to the MADT GICC
>> structure to describe SPE PPI's. We pick these out
>> of the cached reference to the madt_gicc structure
>> similarly to the core PMU code. We then create a platform
>> device referring to the IRQ and let the user/module loader
>> decide whether to load the SPE driver.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>  arch/arm64/include/asm/acpi.h |  3 ++
>>  drivers/perf/Kconfig          |  5 +++
>>  drivers/perf/arm_pmu_acpi.c   | 76 +++++++++++++++++++++++++++++++++++
>>  include/linux/perf/arm_pmu.h  |  2 +
>>  4 files changed, 86 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/acpi.h 
>> b/arch/arm64/include/asm/acpi.h
>> index 7628efbe6c12..d10399b9f998 100644
>> --- a/arch/arm64/include/asm/acpi.h
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -41,6 +41,9 @@
>>      (!(entry) || (entry)->header.length < ACPI_MADT_GICC_MIN_LENGTH || \
>>      (unsigned long)(entry) + (entry)->header.length > (end))
>>
>> +#define ACPI_MADT_GICC_SPE  (ACPI_OFFSET(struct 
>> acpi_madt_generic_interrupt, \
>> +    spe_interrupt) + sizeof(u16))
>> +
>>  /* Basic configuration for ACPI */
>>  #ifdef    CONFIG_ACPI
>>  pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
>> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
>> index af9bc178495d..bc2647c64c9d 100644
>> --- a/drivers/perf/Kconfig
>> +++ b/drivers/perf/Kconfig
>> @@ -52,6 +52,11 @@ config ARM_PMU_ACPI
>>      depends on ARM_PMU && ACPI
>>      def_bool y
>>
>> +config ARM_SPE_ACPI
> 
> Is it possible to just use this check in arm_pmu_acpi.c instead, to 
> avoid introducing another config here:
> 
> if defined(CONFIG_ARM_SPE_PMU)

I'm sure it works, if this is preferred, sure..


> 
>> +    depends on ARM_PMU_ACPI && ARM_SPE_PMU
>> +    def_bool y
>> +
>> +
> 
> nit: extra line
> 
>>  config ARM_DSU_PMU
>>      tristate "ARM DynamIQ Shared Unit (DSU) PMU"
>>      depends on ARM64
>> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
>> index 0f197516d708..b0244e1e8c91 100644
>> --- a/drivers/perf/arm_pmu_acpi.c
>> +++ b/drivers/perf/arm_pmu_acpi.c
>> @@ -74,6 +74,80 @@ static void arm_pmu_acpi_unregister_irq(int cpu)
>>      acpi_unregister_gsi(gsi);
>>  }
>>
>> +#ifdef CONFIG_ARM_SPE_ACPI
>> +static struct resource spe_resources[] = {
>> +    {
>> +        /* irq */
>> +        .flags          = IORESOURCE_IRQ,
>> +    }
>> +};
>> +
>> +static struct platform_device spe_dev = {
>> +    .name = ARMV8_SPE_PDEV_NAME,
>> +    .id = -1,
>> +    .resource = spe_resources,
>> +    .num_resources = ARRAY_SIZE(spe_resources)
>> +};
>> +
>> +/*
>> + * For lack of a better place, hook the normal PMU MADT walk
>> + * and create a SPE device if we detect a recent MADT with
>> + * a homogeneous PPI mapping.
>> + */
>> +static int arm_spe_acpi_register_device(void)
>> +{
>> +    int cpu, ret, irq;
>> +    int hetid;
>  > nit: not sure why you use multiple lines here

Functional grouping, but I should probably re-arrange them...


> 
>> +    u16 gsi = 0;
>> +    bool first = true;
>> +
> 
> nit: extra line, and gicc could be declared within the loop in which 
> it's used to limit scope.
> 
>> +    struct acpi_madt_generic_interrupt *gicc;
>> +
>> +    /*
>> +     * sanity check all the GICC tables for the same interrupt number
>> +     * for now we only support homogeneous ACPI/SPE machines.
>> +     */
>> +    for_each_possible_cpu(cpu) {
>> +        gicc = acpi_cpu_get_madt_gicc(cpu);
>> +
>> +        if (gicc->header.length < ACPI_MADT_GICC_SPE)
>> +            return -ENODEV;
>> +        if (first) {
>> +            gsi = gicc->spe_interrupt;
>> +            if (!gsi)
>> +                return -ENODEV;
>> +            hetid = find_acpi_cpu_topology_hetero_id(cpu);
>> +            first = false;
>> +        } else if ((gsi != gicc->spe_interrupt) ||
>> +               (hetid != find_acpi_cpu_topology_hetero_id(cpu))) {
>> +            pr_warn("ACPI: SPE must be homogeneous\n");
>> +            return -EINVAL;
>> +        }
>> +    }
>> +
>> +    irq = acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE,
>> +                ACPI_ACTIVE_HIGH);
>> +    if (irq < 0) {
> 
> is irq == 0 a valid Linux IRQ number? From checking 
> irq_create_fw_spec_mapping(), it does not seem to be.

I think this is a bit of a trick question, acpi_register_gsi's 
commented/implementations/etc seem to assume that 0 may be a valid 
interrupt, for example

"
  * Returns: a valid linux IRQ number on success
  *          -EINVAL on failure
"

And various pieces of code have >=0  valid IRQ checks. So... I don't 
think its a problem written this way. It leaves the door open for a 
possible 0 despite that likely not being a valid interrupt.. :)


> 
>> +        pr_warn("ACPI: SPE Unable to register interrupt: %d\n", gsi);
>> +        return irq;
>> +    }
>> +
>> +    spe_resources[0].start = irq;
>> +    ret = platform_device_register(&spe_dev);
>> +    if (ret < 0) {
>> +        pr_warn("ACPI: SPE: Unable to register device\n");
>> +        acpi_unregister_gsi(gsi);
>> +    }
>> +
>> +    return ret;
>> +}
>> +#else
>> +static inline int arm_spe_acpi_register_device(void)
>> +{
>> +    return -ENODEV;
>> +}
>> +#endif /* CONFIG_ARM_SPE_ACPI */
>> +
>>  static int arm_pmu_acpi_parse_irqs(void)
>>  {
>>      int irq, cpu, irq_cpu, err;
>> @@ -279,6 +353,8 @@ static int arm_pmu_acpi_init(void)
>>      if (acpi_disabled)
>>          return 0;
>>
>> +    arm_spe_acpi_register_device(); /* failures are expected */
>> +
>>      ret = arm_pmu_acpi_parse_irqs();
>>      if (ret)
>>          return ret;
>> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
>> index 4641e850b204..784bc58f165a 100644
>> --- a/include/linux/perf/arm_pmu.h
>> +++ b/include/linux/perf/arm_pmu.h
>> @@ -175,4 +175,6 @@ void armpmu_free_irq(int irq, int cpu);
>>
>>  #endif /* CONFIG_ARM_PMU */
>>
>> +#define ARMV8_SPE_PDEV_NAME "arm,spe-v1"
>> +
>>  #endif /* __ARM_PMU_H__ */
>>
> 
> Thanks!
> 
> 
> 

