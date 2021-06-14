Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1F03A5FCE
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jun 2021 12:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbhFNKRX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Jun 2021 06:17:23 -0400
Received: from foss.arm.com ([217.140.110.172]:59584 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232691AbhFNKRX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 14 Jun 2021 06:17:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C8EF1FB;
        Mon, 14 Jun 2021 03:15:20 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A89943F694;
        Mon, 14 Jun 2021 03:15:18 -0700 (PDT)
Subject: Re: [PATCH v5 6/8] iommu/arm-smmu-v3: Get associated RMR info and
 install
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
        guohanjun@huawei.com, yangyicong@huawei.com, Sami.Mujawar@arm.com,
        wanghuiqiang@huawei.com
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-7-shameerali.kolothum.thodi@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <02fba77a-6180-e8dc-8d62-d95987d536f9@arm.com>
Date:   Mon, 14 Jun 2021 11:15:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210524110222.2212-7-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021-05-24 12:02, Shameer Kolothum wrote:
> Check if there is any RMR info associated with the devices behind
> the SMMUv3 and if any, install bypass STEs for them. This is to
> keep any ongoing traffic associated with these devices alive
> when we enable/reset SMMUv3 during probe().
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 36 +++++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index f9195b740f48..be1563e06732 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3574,6 +3574,39 @@ static void __iomem *arm_smmu_ioremap(struct device *dev, resource_size_t start,
>   	return devm_ioremap_resource(dev, &res);
>   }
>   
> +static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
> +{
> +	struct list_head rmr_list;
> +	struct iommu_resv_region *e;
> +	int ret;
> +
> +	INIT_LIST_HEAD(&rmr_list);
> +	if (iommu_dma_get_rmrs(dev_fwnode(smmu->dev), &rmr_list))
> +		return;
> +
> +	/*
> +	 * Since, we don't have a mechanism to differentiate the RMR
> +	 * SIDs that has an ongoing live stream, install bypass STEs
> +	 * for all the reported ones.
> +	 */

I don't really follow that comment. The point of being reserved is that 
we don't know how and why the device is using them, and we have little 
need to care - we are simply required to preserve an effective unity 
mapping at all times. I don't see any value in trying to second-guess 
things beyond that, as this appears to suggest.

Robin.

> +	list_for_each_entry(e, &rmr_list, list) {
> +		__le64 *step;
> +		u32 sid = e->fw_data.rmr.sid;
> +
> +		ret = arm_smmu_init_sid_strtab(smmu, sid);
> +		if (ret) {
> +			dev_err(smmu->dev, "RMR bypass(0x%x) failed\n",
> +				sid);
> +			continue;
> +		}
> +
> +		step = arm_smmu_get_step_for_sid(smmu, sid);
> +		arm_smmu_write_strtab_ent(NULL, sid, step, true);
> +	}
> +
> +	iommu_dma_put_rmrs(dev_fwnode(smmu->dev), &rmr_list);
> +}
> +
>   static int arm_smmu_device_probe(struct platform_device *pdev)
>   {
>   	int irq, ret;
> @@ -3657,6 +3690,9 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   	/* Record our private device structure */
>   	platform_set_drvdata(pdev, smmu);
>   
> +	/* Check for RMRs and install bypass STEs if any */
> +	arm_smmu_rmr_install_bypass_ste(smmu);
> +
>   	/* Reset the device */
>   	ret = arm_smmu_device_reset(smmu, bypass);
>   	if (ret)
> 
