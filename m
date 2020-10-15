Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD4628F4AB
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Oct 2020 16:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388099AbgJOO0a (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Oct 2020 10:26:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15221 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387776AbgJOO0a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Oct 2020 10:26:30 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B13A6E19BE4EE9CE4DA9;
        Thu, 15 Oct 2020 22:26:24 +0800 (CST)
Received: from [10.174.179.182] (10.174.179.182) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 15 Oct 2020 22:26:19 +0800
Subject: Re: [PATCH v3 7/8] arm64: mm: Set ZONE_DMA size based on early IORT
 scan
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        <robh+dt@kernel.org>, <catalin.marinas@arm.com>, <hch@lst.de>,
        <ardb@kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     <robin.murphy@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>, <jeremy.linton@arm.com>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
 <20201014191211.27029-8-nsaenzjulienne@suse.de>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <1a3df60a-4568-cb72-db62-36127d0ffb7e@huawei.com>
Date:   Thu, 15 Oct 2020 22:26:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201014191211.27029-8-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.182]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020/10/15 3:12, Nicolas Saenz Julienne wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> We recently introduced a 1 GB sized ZONE_DMA to cater for platforms
> incorporating masters that can address less than 32 bits of DMA, in
> particular the Raspberry Pi 4, which has 4 or 8 GB of DRAM, but has
> peripherals that can only address up to 1 GB (and its PCIe host
> bridge can only access the bottom 3 GB)
> 
> Instructing the DMA layer about these limitations is straight-forward,
> even though we had to fix some issues regarding memory limits set in
> the IORT for named components, and regarding the handling of ACPI _DMA
> methods. However, the DMA layer also needs to be able to allocate
> memory that is guaranteed to meet those DMA constraints, for bounce
> buffering as well as allocating the backing for consistent mappings.
> 
> This is why the 1 GB ZONE_DMA was introduced recently. Unfortunately,
> it turns out the having a 1 GB ZONE_DMA as well as a ZONE_DMA32 causes
> problems with kdump, and potentially in other places where allocations
> cannot cross zone boundaries. Therefore, we should avoid having two
> separate DMA zones when possible.
> 
> So let's do an early scan of the IORT, and only create the ZONE_DMA
> if we encounter any devices that need it. This puts the burden on
> the firmware to describe such limitations in the IORT, which may be
> redundant (and less precise) if _DMA methods are also being provided.
> However, it should be noted that this situation is highly unusual for
> arm64 ACPI machines. Also, the DMA subsystem still gives precedence to
> the _DMA method if implemented, and so we will not lose the ability to
> perform streaming DMA outside the ZONE_DMA if the _DMA method permits
> it.

Sorry, I'm still a little bit confused. With this patch, if we have
a device which set the right _DMA method (DMA size >= 32), but with the
wrong DMA size in IORT, we still have the ZONE_DMA created which
is actually not needed?

> 
> Cc: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> [nsaenz: Rebased, removed documentation change, warnings and add
> declaration in acpi_iort.h]
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>   arch/arm64/mm/init.c      |  6 +++++
>   drivers/acpi/arm64/iort.c | 51 +++++++++++++++++++++++++++++++++++++++
>   include/linux/acpi_iort.h |  4 +++
>   3 files changed, 61 insertions(+)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 97b0d2768349..f321761eedb2 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -29,6 +29,7 @@
>   #include <linux/kexec.h>
>   #include <linux/crash_dump.h>
>   #include <linux/hugetlb.h>
> +#include <linux/acpi_iort.h>
>   
>   #include <asm/boot.h>
>   #include <asm/fixmap.h>
> @@ -196,6 +197,11 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>   #ifdef CONFIG_ZONE_DMA
>   	zone_dma_bits = min(zone_dma_bits,
>   			    (unsigned int)ilog2(of_dma_get_max_cpu_address(NULL)));
> +
> +	if (IS_ENABLED(CONFIG_ACPI))
> +		zone_dma_bits = min(zone_dma_bits,
> +				    acpi_iort_get_zone_dma_size());
> +
>   	arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
>   	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
>   #endif
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 9929ff50c0c0..8f530bf3c03b 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1718,3 +1718,54 @@ void __init acpi_iort_init(void)
>   
>   	iort_init_platform_devices();
>   }
> +
> +#ifdef CONFIG_ZONE_DMA
> +/*
> + * Check the IORT whether any devices exist whose DMA mask is < 32 bits.
> + * If so, return the smallest value encountered, or 32 otherwise.
> + */
> +unsigned int __init acpi_iort_get_zone_dma_size(void)
> +{
> +	struct acpi_table_iort *iort;
> +	struct acpi_iort_node *node, *end;
> +	acpi_status status;
> +	u8 limit = 32;
> +	int i;
> +
> +	if (acpi_disabled)
> +		return limit;
> +
> +	status = acpi_get_table(ACPI_SIG_IORT, 0,
> +				(struct acpi_table_header **)&iort);
> +	if (ACPI_FAILURE(status))
> +		return limit;
> +
> +	node = ACPI_ADD_PTR(struct acpi_iort_node, iort, iort->node_offset);
> +	end = ACPI_ADD_PTR(struct acpi_iort_node, iort, iort->header.length);
> +
> +	for (i = 0; i < iort->node_count; i++) {
> +		if (node >= end)
> +			break;
> +
> +		switch (node->type) {
> +			struct acpi_iort_named_component *ncomp;
> +			struct acpi_iort_root_complex *rc;
> +
> +		case ACPI_IORT_NODE_NAMED_COMPONENT:
> +			ncomp = (struct acpi_iort_named_component *)node->node_data;
> +			if (ncomp->memory_address_limit)
> +				limit = min(limit, ncomp->memory_address_limit);
> +			break;
> +
> +		case ACPI_IORT_NODE_PCI_ROOT_COMPLEX:
> +			rc = (struct acpi_iort_root_complex *)node->node_data;
> +			if (rc->memory_address_limit)
> +				limit = min(limit, rc->memory_address_limit);

There is no "Memory address size limit" field in revision 0 table, so as
Lorenzo reminded, please add a revision check here.

Thanks
Hanjun


> +			break;
> +		}
> +		node = ACPI_ADD_PTR(struct acpi_iort_node, node, node->length);
> +	}
> +	acpi_put_table(&iort->header);
> +	return limit;
> +}
> +#endif
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index 20a32120bb88..7d2e184f0d4d 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -38,6 +38,7 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *size);
>   const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
>   						const u32 *id_in);
>   int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
> +unsigned int acpi_iort_get_zone_dma_size(void);
>   #else
>   static inline void acpi_iort_init(void) { }
>   static inline u32 iort_msi_map_id(struct device *dev, u32 id)
> @@ -55,6 +56,9 @@ static inline const struct iommu_ops *iort_iommu_configure_id(
>   static inline
>   int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>   { return 0; }
> +
> +static inline unsigned int acpi_iort_get_zone_dma_size(void)
> +{ return 32; }
>   #endif
>   
>   #endif /* __ACPI_IORT_H__ */
> 
