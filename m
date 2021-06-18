Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34433AD090
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jun 2021 18:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbhFRQiO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Jun 2021 12:38:14 -0400
Received: from foss.arm.com ([217.140.110.172]:44056 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233526AbhFRQiN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Jun 2021 12:38:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FC7813A1;
        Fri, 18 Jun 2021 09:36:04 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 411503F70D;
        Fri, 18 Jun 2021 09:36:01 -0700 (PDT)
Subject: Re: [PATCH v5 1/5] ACPI: arm64: Move DMA setup operations out of IORT
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org, mst@redhat.com
Cc:     will@kernel.org, catalin.marinas@arm.com, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, eric.auger@redhat.com,
        sebastien.boeuf@intel.com, kevin.tian@intel.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com
References: <20210618152059.1194210-1-jean-philippe@linaro.org>
 <20210618152059.1194210-2-jean-philippe@linaro.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ca1668fa-7aec-fba1-9adb-ed9f932253fd@arm.com>
Date:   Fri, 18 Jun 2021 17:35:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210618152059.1194210-2-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021-06-18 16:20, Jean-Philippe Brucker wrote:
> Extract generic DMA setup code out of IORT, so it can be reused by VIOT.
> Keep it in drivers/acpi/arm64 for now, since it could break x86
> platforms that haven't run this code so far, if they have invalid
> tables.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>   drivers/acpi/arm64/Makefile |  1 +
>   include/linux/acpi.h        |  3 +++
>   include/linux/acpi_iort.h   |  6 ++---
>   drivers/acpi/arm64/dma.c    | 50 ++++++++++++++++++++++++++++++++++
>   drivers/acpi/arm64/iort.c   | 54 ++++++-------------------------------
>   drivers/acpi/scan.c         |  2 +-
>   6 files changed, 66 insertions(+), 50 deletions(-)
>   create mode 100644 drivers/acpi/arm64/dma.c
> 
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index 6ff50f4ed947..66acbe77f46e 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -1,3 +1,4 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   obj-$(CONFIG_ACPI_IORT) 	+= iort.o
>   obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
> +obj-y				+= dma.o
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index c60745f657e9..7aaa9559cc19 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -259,9 +259,12 @@ void acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa);
>   
>   #ifdef CONFIG_ARM64
>   void acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa);
> +void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size);
>   #else
>   static inline void
>   acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa) { }
> +static inline void
> +acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size) { }
>   #endif
>   
>   int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index 1a12baa58e40..f7f054833afd 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -34,7 +34,7 @@ struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
>   void acpi_configure_pmsi_domain(struct device *dev);
>   int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
>   /* IOMMU interface */
> -void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *size);
> +int iort_dma_get_ranges(struct device *dev, u64 *size);
>   const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
>   						const u32 *id_in);
>   int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
> @@ -48,8 +48,8 @@ static inline struct irq_domain *iort_get_device_domain(
>   { return NULL; }
>   static inline void acpi_configure_pmsi_domain(struct device *dev) { }
>   /* IOMMU interface */
> -static inline void iort_dma_setup(struct device *dev, u64 *dma_addr,
> -				  u64 *size) { }
> +static inline int iort_dma_get_ranges(struct device *dev, u64 *size)
> +{ return -ENODEV; }
>   static inline const struct iommu_ops *iort_iommu_configure_id(
>   				      struct device *dev, const u32 *id_in)
>   { return NULL; }
> diff --git a/drivers/acpi/arm64/dma.c b/drivers/acpi/arm64/dma.c
> new file mode 100644
> index 000000000000..f16739ad3cc0
> --- /dev/null
> +++ b/drivers/acpi/arm64/dma.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/acpi.h>
> +#include <linux/acpi_iort.h>
> +#include <linux/device.h>
> +#include <linux/dma-direct.h>
> +
> +void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
> +{
> +	int ret;
> +	u64 end, mask;
> +	u64 dmaaddr = 0, size = 0, offset = 0;
> +
> +	/*
> +	 * If @dev is expected to be DMA-capable then the bus code that created
> +	 * it should have initialised its dma_mask pointer by this point. For
> +	 * now, we'll continue the legacy behaviour of coercing it to the
> +	 * coherent mask if not, but we'll no longer do so quietly.
> +	 */
> +	if (!dev->dma_mask) {
> +		dev_warn(dev, "DMA mask not set\n");
> +		dev->dma_mask = &dev->coherent_dma_mask;
> +	}
> +
> +	if (dev->coherent_dma_mask)
> +		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
> +	else
> +		size = 1ULL << 32;
> +
> +	ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
> +	if (ret == -ENODEV)
> +		ret = iort_dma_get_ranges(dev, &size);
> +	if (!ret) {
> +		/*
> +		 * Limit coherent and dma mask based on size retrieved from
> +		 * firmware.
> +		 */
> +		end = dmaaddr + size - 1;
> +		mask = DMA_BIT_MASK(ilog2(end) + 1);
> +		dev->bus_dma_limit = end;
> +		dev->coherent_dma_mask = min(dev->coherent_dma_mask, mask);
> +		*dev->dma_mask = min(*dev->dma_mask, mask);
> +	}
> +
> +	*dma_addr = dmaaddr;
> +	*dma_size = size;
> +
> +	ret = dma_direct_set_offset(dev, dmaaddr + offset, dmaaddr, size);
> +
> +	dev_dbg(dev, "dma_offset(%#08llx)%s\n", offset, ret ? " failed!" : "");
> +}
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 3912a1f6058e..a940be1cf2af 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1144,56 +1144,18 @@ static int rc_dma_get_range(struct device *dev, u64 *size)
>   }
>   
>   /**
> - * iort_dma_setup() - Set-up device DMA parameters.
> + * iort_dma_get_ranges() - Look up DMA addressing limit for the device
> + * @dev: device to lookup
> + * @size: DMA range size result pointer
>    *
> - * @dev: device to configure
> - * @dma_addr: device DMA address result pointer
> - * @dma_size: DMA range size result pointer
> + * Return: 0 on success, an error otherwise.
>    */
> -void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
> +int iort_dma_get_ranges(struct device *dev, u64 *size)
>   {
> -	u64 end, mask, dmaaddr = 0, size = 0, offset = 0;
> -	int ret;
> -
> -	/*
> -	 * If @dev is expected to be DMA-capable then the bus code that created
> -	 * it should have initialised its dma_mask pointer by this point. For
> -	 * now, we'll continue the legacy behaviour of coercing it to the
> -	 * coherent mask if not, but we'll no longer do so quietly.
> -	 */
> -	if (!dev->dma_mask) {
> -		dev_warn(dev, "DMA mask not set\n");
> -		dev->dma_mask = &dev->coherent_dma_mask;
> -	}
> -
> -	if (dev->coherent_dma_mask)
> -		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
> +	if (dev_is_pci(dev))
> +		return rc_dma_get_range(dev, size);
>   	else
> -		size = 1ULL << 32;
> -
> -	ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
> -	if (ret == -ENODEV)
> -		ret = dev_is_pci(dev) ? rc_dma_get_range(dev, &size)
> -				      : nc_dma_get_range(dev, &size);
> -
> -	if (!ret) {
> -		/*
> -		 * Limit coherent and dma mask based on size retrieved from
> -		 * firmware.
> -		 */
> -		end = dmaaddr + size - 1;
> -		mask = DMA_BIT_MASK(ilog2(end) + 1);
> -		dev->bus_dma_limit = end;
> -		dev->coherent_dma_mask = min(dev->coherent_dma_mask, mask);
> -		*dev->dma_mask = min(*dev->dma_mask, mask);
> -	}
> -
> -	*dma_addr = dmaaddr;
> -	*dma_size = size;
> -
> -	ret = dma_direct_set_offset(dev, dmaaddr + offset, dmaaddr, size);
> -
> -	dev_dbg(dev, "dma_offset(%#08llx)%s\n", offset, ret ? " failed!" : "");
> +		return nc_dma_get_range(dev, size);
>   }
>   
>   static void __init acpi_iort_register_irq(int hwirq, const char *name,
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index e10d38ac7cf2..ea613df8f913 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1537,7 +1537,7 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
>   		return 0;
>   	}
>   
> -	iort_dma_setup(dev, &dma_addr, &size);
> +	acpi_arch_dma_setup(dev, &dma_addr, &size);
>   
>   	iommu = iort_iommu_configure_id(dev, input_id);
>   	if (PTR_ERR(iommu) == -EPROBE_DEFER)
> 
