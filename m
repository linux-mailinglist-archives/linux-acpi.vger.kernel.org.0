Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F34130A2B8
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Feb 2021 08:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbhBAHcL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Feb 2021 02:32:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47675 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232169AbhBAHcE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2021 02:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612164637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GxejYmvqxAVe79rsjXK+9gKzCLOQZ1mJGritX/MZYCc=;
        b=Cy0qsFOnLkOwi2OSOUz+YbIwkH8Qs6vvlYdiK4IgWk9kDVvTmY7udH+nAkpNaaLxXJwdZU
        5AG3ZeGwRi0kgHEXtFy3rn1VDoZkSFF3fMLHUIKtcmJeJu3v8hheNsSmZnE2aLNVt+Sz5r
        Y69J5uYZGNB1VLn+vtwCrFiP7cEWF7Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-kxmqfPUGMjO-V6Eu84qfgA-1; Mon, 01 Feb 2021 02:30:32 -0500
X-MC-Unique: kxmqfPUGMjO-V6Eu84qfgA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1ABD107ACE8;
        Mon,  1 Feb 2021 07:30:29 +0000 (UTC)
Received: from [10.36.113.43] (ovpn-113-43.ams2.redhat.com [10.36.113.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E835779CF;
        Mon,  1 Feb 2021 07:30:22 +0000 (UTC)
Subject: Re: [PATCH v12 02/10] iommu/arm-smmu-v3: Use device properties for
 pasid-num-bits
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
        will@kernel.org
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, Jonathan.Cameron@huawei.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-accelerators@lists.ozlabs.org, baolu.lu@linux.intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        vdumpa@nvidia.com, zhangfei.gao@linaro.org,
        shameerali.kolothum.thodi@huawei.com, vivek.gautam@arm.com
References: <20210127154322.3959196-1-jean-philippe@linaro.org>
 <20210127154322.3959196-3-jean-philippe@linaro.org>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <ce05e0e7-8ccc-0a9e-0762-64a41d05b33c@redhat.com>
Date:   Mon, 1 Feb 2021 08:30:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210127154322.3959196-3-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/27/21 4:43 PM, Jean-Philippe Brucker wrote:
> The pasid-num-bits property shouldn't need a dedicated fwspec field,
> it's a job for device properties. Add properties for IORT, and access
> the number of PASID bits using device_property_read_u32().
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

> ---
>  include/linux/iommu.h                       |  2 --
>  drivers/acpi/arm64/iort.c                   | 13 +++++++------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  3 ++-
>  drivers/iommu/of_iommu.c                    |  5 -----
>  4 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index bdf3f34a4457..b7ea11fc1a93 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -571,7 +571,6 @@ struct iommu_group *fsl_mc_device_group(struct device *dev);
>   * @ops: ops for this device's IOMMU
>   * @iommu_fwnode: firmware handle for this device's IOMMU
>   * @flags: IOMMU_FWSPEC_* flags
> - * @num_pasid_bits: number of PASID bits supported by this device
>   * @num_ids: number of associated device IDs
>   * @ids: IDs which this device may present to the IOMMU
>   */
> @@ -579,7 +578,6 @@ struct iommu_fwspec {
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
> index baebaac34a83..88dd9feb32f4 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2392,7 +2392,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
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
> 

