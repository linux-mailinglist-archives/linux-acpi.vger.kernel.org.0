Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068CA3AA1F9
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 19:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhFPRE7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 13:04:59 -0400
Received: from foss.arm.com ([217.140.110.172]:42244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229602AbhFPRE6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 13:04:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0690C1042;
        Wed, 16 Jun 2021 10:02:52 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1516F3F70D;
        Wed, 16 Jun 2021 10:02:44 -0700 (PDT)
Subject: Re: [PATCH v4 5/6] iommu/dma: Simplify calls to iommu_setup_dma_ops()
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
References: <20210610075130.67517-1-jean-philippe@linaro.org>
 <20210610075130.67517-6-jean-philippe@linaro.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6ce5fecb-fc81-5bf1-3577-6a09437b243e@arm.com>
Date:   Wed, 16 Jun 2021 18:02:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210610075130.67517-6-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021-06-10 08:51, Jean-Philippe Brucker wrote:
> dma-iommu uses the address bounds described in domain->geometry during
> IOVA allocation. The address size parameters of iommu_setup_dma_ops()
> are useful for describing additional limits set by the platform
> firmware, but aren't needed for drivers that call this function from
> probe_finalize(). The base parameter can be zero because dma-iommu
> already removes the first IOVA page, and the limit parameter can be
> U64_MAX because it's only checked against the domain geometry. Simplify
> calls to iommu_setup_dma_ops().
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>   drivers/iommu/amd/iommu.c   |  9 +--------
>   drivers/iommu/dma-iommu.c   |  4 +++-
>   drivers/iommu/intel/iommu.c | 10 +---------
>   3 files changed, 5 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 94b96d81fcfd..d3123bc05c08 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1708,14 +1708,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
>   
>   static void amd_iommu_probe_finalize(struct device *dev)
>   {
> -	struct iommu_domain *domain;
> -
> -	/* Domains are initialized for this device - have a look what we ended up with */
> -	domain = iommu_get_domain_for_dev(dev);
> -	if (domain->type == IOMMU_DOMAIN_DMA)
> -		iommu_setup_dma_ops(dev, IOVA_START_PFN << PAGE_SHIFT, U64_MAX);
> -	else
> -		set_dma_ops(dev, NULL);
> +	iommu_setup_dma_ops(dev, 0, U64_MAX);
>   }
>   
>   static void amd_iommu_release_device(struct device *dev)
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index c62e19bed302..175f8eaeb5b3 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1322,7 +1322,9 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
>   	if (domain->type == IOMMU_DOMAIN_DMA) {
>   		if (iommu_dma_init_domain(domain, dma_base, dma_limit, dev))
>   			goto out_err;
> -		dev->dma_ops = &iommu_dma_ops;
> +		set_dma_ops(dev, &iommu_dma_ops);
> +	} else {
> +		set_dma_ops(dev, NULL);

I'm not keen on moving this here, since iommu-dma only knows that its 
own ops are right for devices it *is* managing; it can't assume any 
particular ops are appropriate for devices it isn't. The idea here is 
that arch_setup_dma_ops() may have already set the appropriate ops for 
the non-IOMMU case, so if the default domain type is passthrough then we 
leave those in place.

For example, I do still plan to revisit my conversion of arch/arm 
someday, at which point I'd have to undo this for that reason.

Simplifying the base and size arguments is of course fine, but TBH I'd 
say rip the whole bloody lot out of the arch_setup_dma_ops() flow now. 
It's a considerable faff passing them around for nothing but a tenuous 
sanity check in iommu_dma_init_domain(), and now that dev->dma_range_map 
is a common thing we should expect that to give us any relevant 
limitations if we even still care.

That said, those are all things which can be fixed up later if the 
series is otherwise ready to go and there's still a chance of landing it 
for 5.14. If you do have any other reason to respin, then I think the 
x86 probe_finalize functions simply want an unconditional 
set_dma_ops(dev, NULL) before the iommu_setup_dma_ops() call.

Cheers,
Robin.

>   	}
>   
>   	return;
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 85f18342603c..8d866940692a 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5165,15 +5165,7 @@ static void intel_iommu_release_device(struct device *dev)
>   
>   static void intel_iommu_probe_finalize(struct device *dev)
>   {
> -	dma_addr_t base = IOVA_START_PFN << VTD_PAGE_SHIFT;
> -	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> -	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> -
> -	if (domain && domain->type == IOMMU_DOMAIN_DMA)
> -		iommu_setup_dma_ops(dev, base,
> -				    __DOMAIN_MAX_ADDR(dmar_domain->gaw));
> -	else
> -		set_dma_ops(dev, NULL);
> +	iommu_setup_dma_ops(dev, 0, U64_MAX);
>   }
>   
>   static void intel_iommu_get_resv_regions(struct device *device,
> 
