Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BCA37633F
	for <lists+linux-acpi@lfdr.de>; Fri,  7 May 2021 12:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhEGKDD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 May 2021 06:03:03 -0400
Received: from foss.arm.com ([217.140.110.172]:53296 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235423AbhEGKCr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 7 May 2021 06:02:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4E0D113E;
        Fri,  7 May 2021 03:01:39 -0700 (PDT)
Received: from [10.57.59.124] (unknown [10.57.59.124])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B0163F718;
        Fri,  7 May 2021 03:01:37 -0700 (PDT)
Subject: Re: [PATCH v3 08/10] iommu/arm-smmu-v3: Reserve any RMR regions
 associated with a dev
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     linuxarm@huawei.com, lorenzo.pieralisi@arm.com, joro@8bytes.org,
        wanghuiqiang@huawei.com, guohanjun@huawei.com,
        steven.price@arm.com, Sami.Mujawar@arm.com, jon@solid-run.com,
        eric.auger@redhat.com
References: <20210420082751.1829-1-shameerali.kolothum.thodi@huawei.com>
 <20210420082751.1829-9-shameerali.kolothum.thodi@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <7ec85477-9c02-17de-9620-f0b153adcc82@arm.com>
Date:   Fri, 7 May 2021 11:01:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210420082751.1829-9-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021-04-20 09:27, Shameer Kolothum wrote:
> Get RMR regions associated with a dev reserved so that there is
> a unity mapping for them in SMMU.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 29 +++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 14e9c7034c04..8bacedf7bb34 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2531,6 +2531,34 @@ static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
>   	return iommu_fwspec_add_ids(dev, args->args, 1);
>   }
>   
> +static bool arm_smmu_dev_has_rmr(struct arm_smmu_master *master,
> +				 struct iommu_rmr *e)
> +{
> +	int i;
> +
> +	for (i = 0; i < master->num_sids; i++) {
> +		if (e->sid == master->sids[i])
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void arm_smmu_rmr_get_resv_regions(struct device *dev,
> +					  struct list_head *head)
> +{
> +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> +	struct arm_smmu_device *smmu = master->smmu;
> +	struct iommu_rmr *rmr;
> +
> +	list_for_each_entry(rmr, &smmu->rmr_list, list) {
> +		if (!arm_smmu_dev_has_rmr(master, rmr))
> +			continue;
> +
> +		iommu_dma_get_rmr_resv_regions(dev, rmr, head);
> +	}
> +}
> +

TBH I wouldn't have thought we need a driver-specific hook for this, or 
is it too painful to correlate fwspec->iommu_fwnode back to the relevant 
IORT node generically?

Robin.

>   static void arm_smmu_get_resv_regions(struct device *dev,
>   				      struct list_head *head)
>   {
> @@ -2545,6 +2573,7 @@ static void arm_smmu_get_resv_regions(struct device *dev,
>   	list_add_tail(&region->list, head);
>   
>   	iommu_dma_get_resv_regions(dev, head);
> +	arm_smmu_rmr_get_resv_regions(dev, head);
>   }
>   
>   static bool arm_smmu_dev_has_feature(struct device *dev,
> 
