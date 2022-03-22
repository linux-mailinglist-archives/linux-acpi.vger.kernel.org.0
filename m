Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670564E4683
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Mar 2022 20:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiCVTOe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Mar 2022 15:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiCVTOd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Mar 2022 15:14:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86F70BF74
        for <linux-acpi@vger.kernel.org>; Tue, 22 Mar 2022 12:13:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2582A152B;
        Tue, 22 Mar 2022 12:13:05 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A77613F66F;
        Tue, 22 Mar 2022 12:13:02 -0700 (PDT)
Message-ID: <485b20e0-595c-bc8c-8fbe-119f19e1a8e0@arm.com>
Date:   Tue, 22 Mar 2022 19:12:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v8 10/11] iommu/arm-smmu-v3: Reserve any RMR regions
 associated with a dev
Content-Language: en-GB
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     linuxarm@huawei.com, lorenzo.pieralisi@arm.com, joro@8bytes.org,
        will@kernel.org, wanghuiqiang@huawei.com, guohanjun@huawei.com,
        steven.price@arm.com, Sami.Mujawar@arm.com, jon@solid-run.com,
        eric.auger@redhat.com, yangyicong@huawei.com
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
 <20220221154344.2126-11-shameerali.kolothum.thodi@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220221154344.2126-11-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2022-02-21 15:43, Shameer Kolothum wrote:
> Get ACPI IORT RMR regions associated with a dev reserved
> so that there is a unity mapping for them in SMMU.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index dee3197474b7..ef2972483fd7 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2759,6 +2759,7 @@ static void arm_smmu_get_resv_regions(struct device *dev,
>   {
>   	struct iommu_resv_region *region;
>   	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>   
>   	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
>   					 prot, IOMMU_RESV_SW_MSI);
> @@ -2768,6 +2769,16 @@ static void arm_smmu_get_resv_regions(struct device *dev,
>   	list_add_tail(&region->list, head);
>   
>   	iommu_dma_get_resv_regions(dev, head);
> +	iommu_dma_get_rmrs(fwspec->iommu_fwnode, dev, head);
> +}
> +
> +static void arm_smmu_put_resv_regions(struct device *dev,
> +				      struct list_head *head)
> +{
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +
> +	iommu_dma_put_rmrs(fwspec->iommu_fwnode, head);
> +	generic_iommu_put_resv_regions(dev, head);
>   }

Tying in with my comment on patch #5, this should be a common 
iommu_dma_put_resv_regions() helper.

Thanks,
Robin.

>   static bool arm_smmu_dev_has_feature(struct device *dev,
> @@ -2865,7 +2876,7 @@ static struct iommu_ops arm_smmu_ops = {
>   	.enable_nesting		= arm_smmu_enable_nesting,
>   	.of_xlate		= arm_smmu_of_xlate,
>   	.get_resv_regions	= arm_smmu_get_resv_regions,
> -	.put_resv_regions	= generic_iommu_put_resv_regions,
> +	.put_resv_regions	= arm_smmu_put_resv_regions,
>   	.dev_has_feat		= arm_smmu_dev_has_feature,
>   	.dev_feat_enabled	= arm_smmu_dev_feature_enabled,
>   	.dev_enable_feat	= arm_smmu_dev_enable_feature,
