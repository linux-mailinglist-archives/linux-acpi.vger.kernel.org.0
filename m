Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB1A2FB91C
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Jan 2021 15:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403837AbhASOTM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Jan 2021 09:19:12 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2374 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391271AbhASLYL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Jan 2021 06:24:11 -0500
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DKmQ14h6wz67dHr;
        Tue, 19 Jan 2021 19:19:21 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 19 Jan 2021 12:23:28 +0100
Received: from localhost (10.47.77.36) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 19 Jan
 2021 11:23:27 +0000
Date:   Tue, 19 Jan 2021 11:22:47 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
CC:     <joro@8bytes.org>, <will@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <robh+dt@kernel.org>, <guohanjun@huawei.com>,
        <sudeep.holla@arm.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <robin.murphy@arm.com>, <eric.auger@redhat.com>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-accelerators@lists.ozlabs.org>, <baolu.lu@linux.intel.com>,
        <vdumpa@nvidia.com>, <zhangfei.gao@linaro.org>,
        <shameerali.kolothum.thodi@huawei.com>, <vivek.gautam@arm.com>
Subject: Re: [PATCH v9 02/10] iommu/arm-smmu-v3: Use device properties for
 pasid-num-bits
Message-ID: <20210119112247.00003846@Huawei.com>
In-Reply-To: <20210108145217.2254447-3-jean-philippe@linaro.org>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
        <20210108145217.2254447-3-jean-philippe@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.77.36]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 8 Jan 2021 15:52:10 +0100
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> The pasid-num-bits property shouldn't need a dedicated fwspec field,
> it's a job for device properties. Add properties for IORT, and access
> the number of PASID bits using device_property_read_u32().
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Nice

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Looks like we are fine not checking for missing properties because
ssid_bits == 0 corresponds to pasid off anyway.


> ---
>  include/linux/iommu.h                       |  2 --
>  drivers/acpi/arm64/iort.c                   | 13 +++++++------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  3 ++-
>  drivers/iommu/of_iommu.c                    |  5 -----
>  4 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 26bcde5e7746..583c734b2e87 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -570,7 +570,6 @@ struct iommu_group *fsl_mc_device_group(struct device *dev);
>   * struct iommu_fwspec - per-device IOMMU instance data
>   * @ops: ops for this device's IOMMU
>   * @iommu_fwnode: firmware handle for this device's IOMMU
> - * @num_pasid_bits: number of PASID bits supported by this device
>   * @num_ids: number of associated device IDs
>   * @ids: IDs which this device may present to the IOMMU
>   */
> @@ -578,7 +577,6 @@ struct iommu_fwspec {
>  	const struct iommu_ops	*ops;
>  	struct fwnode_handle	*iommu_fwnode;
>  	u32			flags;
> -	u32			num_pasid_bits;
>  	unsigned int		num_ids;
>  	u32			ids[];
>  };
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index d4eac6d7e9fb..c9a8bbb74b09 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -968,15 +968,16 @@ static int iort_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
>  static void iort_named_component_init(struct device *dev,
>  				      struct acpi_iort_node *node)
>  {
> +	struct property_entry props[2] = {};
>  	struct acpi_iort_named_component *nc;
> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> -
> -	if (!fwspec)
> -		return;
>  
>  	nc = (struct acpi_iort_named_component *)node->node_data;
> -	fwspec->num_pasid_bits = FIELD_GET(ACPI_IORT_NC_PASID_BITS,
> -					   nc->node_flags);
> +	props[0] = PROPERTY_ENTRY_U32("pasid-num-bits",
> +				      FIELD_GET(ACPI_IORT_NC_PASID_BITS,
> +						nc->node_flags));
> +
> +	if (device_add_properties(dev, props))
> +		dev_warn(dev, "Could not add device properties\n");
>  }
>  
>  static int iort_nc_iommu_map(struct device *dev, struct acpi_iort_node *node)
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 8ca7415d785d..6a53b4edf054 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2366,7 +2366,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>  		}
>  	}
>  
> -	master->ssid_bits = min(smmu->ssid_bits, fwspec->num_pasid_bits);
> +	device_property_read_u32(dev, "pasid-num-bits", &master->ssid_bits);
> +	master->ssid_bits = min(smmu->ssid_bits, master->ssid_bits);
>  
>  	/*
>  	 * Note that PASID must be enabled before, and disabled after ATS:
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index e505b9130a1c..a9d2df001149 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -210,11 +210,6 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>  					     of_pci_iommu_init, &info);
>  	} else {
>  		err = of_iommu_configure_device(master_np, dev, id);
> -
> -		fwspec = dev_iommu_fwspec_get(dev);
> -		if (!err && fwspec)
> -			of_property_read_u32(master_np, "pasid-num-bits",
> -					     &fwspec->num_pasid_bits);
>  	}
>  
>  	/*

