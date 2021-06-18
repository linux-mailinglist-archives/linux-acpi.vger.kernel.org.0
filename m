Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E6E3AD0C0
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jun 2021 18:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbhFRQx6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Jun 2021 12:53:58 -0400
Received: from foss.arm.com ([217.140.110.172]:44258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229730AbhFRQx5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Jun 2021 12:53:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A84513A1;
        Fri, 18 Jun 2021 09:51:48 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 344023F70D;
        Fri, 18 Jun 2021 09:51:45 -0700 (PDT)
Subject: Re: [PATCH v5 2/5] ACPI: Move IOMMU setup code out of IORT
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org, mst@redhat.com
Cc:     kevin.tian@intel.com, catalin.marinas@arm.com,
        sudeep.holla@arm.com, virtualization@lists.linux-foundation.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
        sebastien.boeuf@intel.com, guohanjun@huawei.com, will@kernel.org,
        dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org
References: <20210618152059.1194210-1-jean-philippe@linaro.org>
 <20210618152059.1194210-3-jean-philippe@linaro.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f7371f04-0239-5181-5493-2f6ba99f8542@arm.com>
Date:   Fri, 18 Jun 2021 17:51:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210618152059.1194210-3-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021-06-18 16:20, Jean-Philippe Brucker wrote:
> Extract the code that sets up the IOMMU infrastructure from IORT, since
> it can be reused by VIOT. Move it one level up into a new
> acpi_iommu_configure_id() function, which calls the IORT parsing
> function which in turn calls the acpi_iommu_fwspec_init() helper.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>   include/acpi/acpi_bus.h   |  3 ++
>   include/linux/acpi_iort.h |  8 ++---
>   drivers/acpi/arm64/iort.c | 74 +++++----------------------------------
>   drivers/acpi/scan.c       | 73 +++++++++++++++++++++++++++++++++++++-
>   4 files changed, 86 insertions(+), 72 deletions(-)
> 
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 3a82faac5767..41f092a269f6 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -588,6 +588,9 @@ struct acpi_pci_root {
>   
>   bool acpi_dma_supported(struct acpi_device *adev);
>   enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
> +int acpi_iommu_fwspec_init(struct device *dev, u32 id,
> +			   struct fwnode_handle *fwnode,
> +			   const struct iommu_ops *ops);
>   int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
>   		       u64 *size);
>   int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index f7f054833afd..f1f0842a2cb2 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -35,8 +35,7 @@ void acpi_configure_pmsi_domain(struct device *dev);
>   int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
>   /* IOMMU interface */
>   int iort_dma_get_ranges(struct device *dev, u64 *size);
> -const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
> -						const u32 *id_in);
> +int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
>   int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
>   phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
>   #else
> @@ -50,9 +49,8 @@ static inline void acpi_configure_pmsi_domain(struct device *dev) { }
>   /* IOMMU interface */
>   static inline int iort_dma_get_ranges(struct device *dev, u64 *size)
>   { return -ENODEV; }
> -static inline const struct iommu_ops *iort_iommu_configure_id(
> -				      struct device *dev, const u32 *id_in)
> -{ return NULL; }
> +static inline int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
> +{ return -ENODEV; }
>   static inline
>   int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>   { return 0; }
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index a940be1cf2af..487d1095030d 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -806,23 +806,6 @@ static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
>   	return NULL;
>   }
>   
> -static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev)
> -{
> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> -
> -	return (fwspec && fwspec->ops) ? fwspec->ops : NULL;
> -}
> -
> -static inline int iort_add_device_replay(struct device *dev)
> -{
> -	int err = 0;
> -
> -	if (dev->bus && !device_iommu_mapped(dev))
> -		err = iommu_probe_device(dev);
> -
> -	return err;
> -}
> -
>   /**
>    * iort_iommu_msi_get_resv_regions - Reserved region driver helper
>    * @dev: Device from iommu_get_resv_regions()
> @@ -900,18 +883,6 @@ static inline bool iort_iommu_driver_enabled(u8 type)
>   	}
>   }
>   
> -static int arm_smmu_iort_xlate(struct device *dev, u32 streamid,
> -			       struct fwnode_handle *fwnode,
> -			       const struct iommu_ops *ops)
> -{
> -	int ret = iommu_fwspec_init(dev, fwnode, ops);
> -
> -	if (!ret)
> -		ret = iommu_fwspec_add_ids(dev, &streamid, 1);
> -
> -	return ret;
> -}
> -
>   static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
>   {
>   	struct acpi_iort_root_complex *pci_rc;
> @@ -946,7 +917,7 @@ static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
>   		return iort_iommu_driver_enabled(node->type) ?
>   		       -EPROBE_DEFER : -ENODEV;
>   
> -	return arm_smmu_iort_xlate(dev, streamid, iort_fwnode, ops);
> +	return acpi_iommu_fwspec_init(dev, streamid, iort_fwnode, ops);
>   }
>   
>   struct iort_pci_alias_info {
> @@ -1020,24 +991,13 @@ static int iort_nc_iommu_map_id(struct device *dev,
>    * @dev: device to configure
>    * @id_in: optional input id const value pointer
>    *
> - * Returns: iommu_ops pointer on configuration success
> - *          NULL on configuration failure
> + * Returns: 0 on success, <0 on failure
>    */
> -const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
> -						const u32 *id_in)
> +int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
>   {
>   	struct acpi_iort_node *node;
> -	const struct iommu_ops *ops;
>   	int err = -ENODEV;
>   
> -	/*
> -	 * If we already translated the fwspec there
> -	 * is nothing left to do, return the iommu_ops.
> -	 */
> -	ops = iort_fwspec_iommu_ops(dev);
> -	if (ops)
> -		return ops;
> -
>   	if (dev_is_pci(dev)) {
>   		struct iommu_fwspec *fwspec;
>   		struct pci_bus *bus = to_pci_dev(dev)->bus;
> @@ -1046,7 +1006,7 @@ const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
>   		node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
>   				      iort_match_node_callback, &bus->dev);
>   		if (!node)
> -			return NULL;
> +			return -ENODEV;
>   
>   		info.node = node;
>   		err = pci_for_each_dma_alias(to_pci_dev(dev),
> @@ -1059,7 +1019,7 @@ const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
>   		node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
>   				      iort_match_node_callback, dev);
>   		if (!node)
> -			return NULL;
> +			return -ENODEV;
>   
>   		err = id_in ? iort_nc_iommu_map_id(dev, node, id_in) :
>   			      iort_nc_iommu_map(dev, node);
> @@ -1068,32 +1028,14 @@ const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
>   			iort_named_component_init(dev, node);
>   	}
>   
> -	/*
> -	 * If we have reason to believe the IOMMU driver missed the initial
> -	 * add_device callback for dev, replay it to get things in order.
> -	 */
> -	if (!err) {
> -		ops = iort_fwspec_iommu_ops(dev);
> -		err = iort_add_device_replay(dev);
> -	}
> -
> -	/* Ignore all other errors apart from EPROBE_DEFER */
> -	if (err == -EPROBE_DEFER) {
> -		ops = ERR_PTR(err);
> -	} else if (err) {
> -		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
> -		ops = NULL;
> -	}
> -
> -	return ops;
> +	return err;
>   }
>   
>   #else
>   int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>   { return 0; }
> -const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
> -						const u32 *input_id)
> -{ return NULL; }
> +int iort_iommu_configure_id(struct device *dev, const u32 *input_id)
> +{ return -ENODEV; }
>   #endif
>   
>   static int nc_dma_get_range(struct device *dev, u64 *size)
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index ea613df8f913..2a2e690040e9 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -9,6 +9,7 @@
>   #include <linux/kernel.h>
>   #include <linux/acpi.h>
>   #include <linux/acpi_iort.h>
> +#include <linux/iommu.h>
>   #include <linux/signal.h>
>   #include <linux/kthread.h>
>   #include <linux/dmi.h>
> @@ -1520,6 +1521,76 @@ int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
>   	return ret >= 0 ? 0 : ret;
>   }
>   
> +#ifdef CONFIG_IOMMU_API
> +int acpi_iommu_fwspec_init(struct device *dev, u32 id,
> +			   struct fwnode_handle *fwnode,
> +			   const struct iommu_ops *ops)
> +{
> +	int ret = iommu_fwspec_init(dev, fwnode, ops);
> +
> +	if (!ret)
> +		ret = iommu_fwspec_add_ids(dev, &id, 1);
> +
> +	return ret;
> +}
> +
> +static inline const struct iommu_ops *acpi_iommu_fwspec_ops(struct device *dev)
> +{
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +
> +	return fwspec ? fwspec->ops : NULL;
> +}
> +
> +static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
> +						       const u32 *id_in)
> +{
> +	int err;
> +	const struct iommu_ops *ops;
> +
> +	/*
> +	 * If we already translated the fwspec there is nothing left to do,
> +	 * return the iommu_ops.
> +	 */
> +	ops = acpi_iommu_fwspec_ops(dev);
> +	if (ops)
> +		return ops;
> +
> +	err = iort_iommu_configure_id(dev, id_in);
> +
> +	/*
> +	 * If we have reason to believe the IOMMU driver missed the initial
> +	 * iommu_probe_device() call for dev, replay it to get things in order.
> +	 */
> +	if (!err && dev->bus && !device_iommu_mapped(dev))
> +		err = iommu_probe_device(dev);
> +
> +	/* Ignore all other errors apart from EPROBE_DEFER */
> +	if (err == -EPROBE_DEFER) {
> +		return ERR_PTR(err);
> +	} else if (err) {
> +		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
> +		return NULL;
> +	}
> +	return acpi_iommu_fwspec_ops(dev);
> +}
> +
> +#else /* !CONFIG_IOMMU_API */
> +
> +int acpi_iommu_fwspec_init(struct device *dev, u32 id,
> +			   struct fwnode_handle *fwnode,
> +			   const struct iommu_ops *ops)
> +{
> +	return -ENODEV;
> +}
> +
> +static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
> +						       const u32 *id_in)
> +{
> +	return NULL;
> +}
> +
> +#endif /* !CONFIG_IOMMU_API */
> +
>   /**
>    * acpi_dma_configure_id - Set-up DMA configuration for the device.
>    * @dev: The pointer to the device
> @@ -1539,7 +1610,7 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
>   
>   	acpi_arch_dma_setup(dev, &dma_addr, &size);
>   
> -	iommu = iort_iommu_configure_id(dev, input_id);
> +	iommu = acpi_iommu_configure_id(dev, input_id);
>   	if (PTR_ERR(iommu) == -EPROBE_DEFER)
>   		return -EPROBE_DEFER;
>   
> 
