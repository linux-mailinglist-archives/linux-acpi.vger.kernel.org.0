Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930813AC9AD
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jun 2021 13:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhFRLVW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Jun 2021 07:21:22 -0400
Received: from foss.arm.com ([217.140.110.172]:39232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231697AbhFRLVW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Jun 2021 07:21:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF4DF13A1;
        Fri, 18 Jun 2021 04:19:12 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05C003F719;
        Fri, 18 Jun 2021 04:19:09 -0700 (PDT)
Subject: Re: [PATCH v4 5/6] iommu/dma: Simplify calls to iommu_setup_dma_ops()
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org,
        mst@redhat.com, will@kernel.org, catalin.marinas@arm.com,
        baolu.lu@linux.intel.com, dwmw2@infradead.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, eric.auger@redhat.com,
        sebastien.boeuf@intel.com, kevin.tian@intel.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com
References: <20210610075130.67517-1-jean-philippe@linaro.org>
 <20210610075130.67517-6-jean-philippe@linaro.org>
 <6ce5fecb-fc81-5bf1-3577-6a09437b243e@arm.com> <YMx6Z8aWBOrFiEcV@myrica>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f72b9fcd-b839-fac1-f35a-6907a9c66aed@arm.com>
Date:   Fri, 18 Jun 2021 12:19:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YMx6Z8aWBOrFiEcV@myrica>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021-06-18 11:50, Jean-Philippe Brucker wrote:
> On Wed, Jun 16, 2021 at 06:02:39PM +0100, Robin Murphy wrote:
>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>> index c62e19bed302..175f8eaeb5b3 100644
>>> --- a/drivers/iommu/dma-iommu.c
>>> +++ b/drivers/iommu/dma-iommu.c
>>> @@ -1322,7 +1322,9 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
>>>    	if (domain->type == IOMMU_DOMAIN_DMA) {
>>>    		if (iommu_dma_init_domain(domain, dma_base, dma_limit, dev))
>>>    			goto out_err;
>>> -		dev->dma_ops = &iommu_dma_ops;
>>> +		set_dma_ops(dev, &iommu_dma_ops);
>>> +	} else {
>>> +		set_dma_ops(dev, NULL);
>>
>> I'm not keen on moving this here, since iommu-dma only knows that its own
>> ops are right for devices it *is* managing; it can't assume any particular
>> ops are appropriate for devices it isn't. The idea here is that
>> arch_setup_dma_ops() may have already set the appropriate ops for the
>> non-IOMMU case, so if the default domain type is passthrough then we leave
>> those in place.
>>
>> For example, I do still plan to revisit my conversion of arch/arm someday,
>> at which point I'd have to undo this for that reason.
> 
> Makes sense, I'll remove this bit.
> 
>> Simplifying the base and size arguments is of course fine, but TBH I'd say
>> rip the whole bloody lot out of the arch_setup_dma_ops() flow now. It's a
>> considerable faff passing them around for nothing but a tenuous sanity check
>> in iommu_dma_init_domain(), and now that dev->dma_range_map is a common
>> thing we should expect that to give us any relevant limitations if we even
>> still care.
> 
> So I started working on this but it gets too bulky for a preparatory
> patch. Dropping the parameters from arch_setup_dma_ops() seems especially
> complicated because arm32 does need the size parameter for IOMMU mappings
> and that value falls back to the bus DMA mask or U32_MAX in the absence of
> dma-ranges. I could try to dig into this for a separate series.
> 
> Even only dropping the parameters from iommu_setup_dma_ops() isn't
> completely trivial (8 files changed, 55 insertions(+), 36 deletions(-)
> because we still need the lower IOVA limit from dma_range_map), so I'd
> rather send it separately and have it sit in -next for a while.

Oh, sure, I didn't mean to imply that the whole cleanup should be within 
the scope of this series, just that we can shave off as much as we *do* 
need to touch here (which TBH is pretty much what you're doing already), 
and mainly to start taking the attitude that these arguments are now 
superseded and increasingly vestigial.

I expected the cross-arch cleanup to be a bit fiddly, but I'd forgotten 
that arch/arm was still actively using these values, so maybe I can 
revisit this when I pick up my iommu-dma conversion again (I swear it's 
not dead, just resting!)

Cheers,
Robin.
