Return-Path: <linux-acpi+bounces-5883-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A31C8C88FE
	for <lists+linux-acpi@lfdr.de>; Fri, 17 May 2024 17:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032D51F221F2
	for <lists+linux-acpi@lfdr.de>; Fri, 17 May 2024 15:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3D467A0D;
	Fri, 17 May 2024 15:04:09 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EC464CE1;
	Fri, 17 May 2024 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715958249; cv=none; b=J5LKj+d3FHBQGUvAdF4/LjinAJUzHWKp4vh2BAw7MvcQwaDi23COzfofEPKKWFdK8nCQ0eSUOiY9sS4Vg1QlhFFGUm85G3S4LrQddDyvT6vvSYujv1tbelkr3bCJG0ng7YFG3WBxdkBOgLtxVE0qwJpfvEY6YnsA5YpdpW6tu9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715958249; c=relaxed/simple;
	bh=rmCP6QYgkI9Sl3Ub1SJ2idoZZMhLo/H/14aEl6gI9G4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TTJZ1hv1o4fOvSqIDRVSO7ZGsOlk1WH+TDYX/sKSSr87SuE3Wp+rxKZINuKQbWuNfcLAUmKWybO3ys4WkSBF1Zznig4vhazkwEBNcCiQMrWFkZm7xR+DYC4G480WIvaveXZoHDBuFQ0+rGWX+JsSZbDklu7cKpsdYDBwpc8iw70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2BE01424;
	Fri, 17 May 2024 08:04:27 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85E6D3F762;
	Fri, 17 May 2024 08:03:59 -0700 (PDT)
Message-ID: <981c85f3-6d43-4c2b-a440-88bf81a18e55@arm.com>
Date: Fri, 17 May 2024 16:03:57 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] iommu/dma: Make limit checks self-contained
To: Jon Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <cover.1713523152.git.robin.murphy@arm.com>
 <e28a114243d1e79eb3609aded034f8529521333f.1713523152.git.robin.murphy@arm.com>
 <243d441d-dda8-442a-a495-83bf9725a14c@nvidia.com>
 <48c39306-c226-4e7f-a013-d679ca80157e@arm.com>
 <46fc1b7f-7d10-4233-b089-aa173ad3bbeb@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <46fc1b7f-7d10-4233-b089-aa173ad3bbeb@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/05/2024 3:21 pm, Jon Hunter wrote:
> 
> On 15/05/2024 15:59, Robin Murphy wrote:
>> Hi Jon,
>>
>> On 2024-05-14 2:27 pm, Jon Hunter wrote:
>>> Hi Robin,
>>>
>>> On 19/04/2024 17:54, Robin Murphy wrote:
>>>> It's now easy to retrieve the device's DMA limits if we want to check
>>>> them against the domain aperture, so do that ourselves instead of
>>>> relying on them being passed through the callchain.
>>>>
>>>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>>>> Tested-by: Hanjun Guo <guohanjun@huawei.com>
>>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>>> ---
>>>>   drivers/iommu/dma-iommu.c | 21 +++++++++------------
>>>>   1 file changed, 9 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>>> index a3039005b696..f542eabaefa4 100644
>>>> --- a/drivers/iommu/dma-iommu.c
>>>> +++ b/drivers/iommu/dma-iommu.c
>>>> @@ -660,19 +660,16 @@ static void iommu_dma_init_options(struct 
>>>> iommu_dma_options *options,
>>>>   /**
>>>>    * iommu_dma_init_domain - Initialise a DMA mapping domain
>>>>    * @domain: IOMMU domain previously prepared by 
>>>> iommu_get_dma_cookie()
>>>> - * @base: IOVA at which the mappable address space starts
>>>> - * @limit: Last address of the IOVA space
>>>>    * @dev: Device the domain is being initialised for
>>>>    *
>>>> - * @base and @limit + 1 should be exact multiples of IOMMU page 
>>>> granularity to
>>>> - * avoid rounding surprises. If necessary, we reserve the page at 
>>>> address 0
>>>> + * If the geometry and dma_range_map include address 0, we reserve 
>>>> that page
>>>>    * to ensure it is an invalid IOVA. It is safe to reinitialise a 
>>>> domain, but
>>>>    * any change which could make prior IOVAs invalid will fail.
>>>>    */
>>>> -static int iommu_dma_init_domain(struct iommu_domain *domain, 
>>>> dma_addr_t base,
>>>> -                 dma_addr_t limit, struct device *dev)
>>>> +static int iommu_dma_init_domain(struct iommu_domain *domain, 
>>>> struct device *dev)
>>>>   {
>>>>       struct iommu_dma_cookie *cookie = domain->iova_cookie;
>>>> +    const struct bus_dma_region *map = dev->dma_range_map;
>>>>       unsigned long order, base_pfn;
>>>>       struct iova_domain *iovad;
>>>>       int ret;
>>>> @@ -684,18 +681,18 @@ static int iommu_dma_init_domain(struct 
>>>> iommu_domain *domain, dma_addr_t base,
>>>>       /* Use the smallest supported page size for IOVA granularity */
>>>>       order = __ffs(domain->pgsize_bitmap);
>>>> -    base_pfn = max_t(unsigned long, 1, base >> order);
>>>> +    base_pfn = 1;
>>>>       /* Check the domain allows at least some access to the 
>>>> device... */
>>>> -    if (domain->geometry.force_aperture) {
>>>> +    if (map) {
>>>> +        dma_addr_t base = dma_range_map_min(map);
>>>>           if (base > domain->geometry.aperture_end ||
>>>> -            limit < domain->geometry.aperture_start) {
>>>> +            dma_range_map_max(map) < 
>>>> domain->geometry.aperture_start) {
>>>>               pr_warn("specified DMA range outside IOMMU 
>>>> capability\n");
>>>>               return -EFAULT;
>>>>           }
>>>>           /* ...then finally give it a kicking to make sure it fits */
>>>> -        base_pfn = max_t(unsigned long, base_pfn,
>>>> -                domain->geometry.aperture_start >> order);
>>>> +        base_pfn = max(base, domain->geometry.aperture_start) >> 
>>>> order;
>>>>       }
>>>>       /* start_pfn is always nonzero for an already-initialised 
>>>> domain */
>>>> @@ -1760,7 +1757,7 @@ void iommu_setup_dma_ops(struct device *dev, 
>>>> u64 dma_base, u64 dma_limit)
>>>>        * underlying IOMMU driver needs to support via the dma-iommu 
>>>> layer.
>>>>        */
>>>>       if (iommu_is_dma_domain(domain)) {
>>>> -        if (iommu_dma_init_domain(domain, dma_base, dma_limit, dev))
>>>> +        if (iommu_dma_init_domain(domain, dev))
>>>>               goto out_err;
>>>>           dev->dma_ops = &iommu_dma_ops;
>>>>       }
>>>
>>>
>>> I have noticed some random test failures on Tegra186 and Tegra194 and 
>>> bisect is pointing to this commit. Reverting this along with the 
>>> various dependencies does fix the problem. On Tegra186 CPU hotplug is 
>>> failing and on Tegra194 suspend is failing. Unfortunately, on neither 
>>> platform do I see any particular crash but the boards hang somewhere.
>>
>> That is... thoroughly bemusing :/ Not only is there supposed to be no 
>> real functional change here - we should merely be recalculating the 
>> same information from dev->dma_range_map that the callers were already 
>> doing to generate the base/limit arguments - but the act of initially 
>> setting up a default domain for a device behind an IOMMU should have 
>> no connection whatsoever to suspend and especially not to CPU hotplug.
> 
> 
> Yes it does look odd, but this is what bisect reported ...
> 
> git bisect start
> # good: [a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6] Linux 6.9
> git bisect good a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
> # bad: [6ba6c795dc73c22ce2c86006f17c4aa802db2a60] Add linux-next 
> specific files for 20240513
> git bisect bad 6ba6c795dc73c22ce2c86006f17c4aa802db2a60
> # good: [29e7f949865a023a21ecdfbd82d68ac697569f34] Merge branch 'main' 
> of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
> git bisect good 29e7f949865a023a21ecdfbd82d68ac697569f34
> # skip: [150e6cc14e51f2a07034106a4529cdaafd812c46] Merge branch 'next' 
> of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
> git bisect skip 150e6cc14e51f2a07034106a4529cdaafd812c46
> # good: [f5d75327d30af49acf2e4b55f35ce2e6c45d1287] drm/amd/display: Fix 
> invalid Copyright notice
> git bisect good f5d75327d30af49acf2e4b55f35ce2e6c45d1287
> # skip: [f1ec9a9ffc526df7c9523006c2abbb8ea554cdd8] Merge branch 
> 'for-next' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git
> git bisect skip f1ec9a9ffc526df7c9523006c2abbb8ea554cdd8
> # bad: [f091e93306e0429ebb7589b9874590b6a9705e64] dma-mapping: Simplify 
> arch_setup_dma_ops()
> git bisect bad f091e93306e0429ebb7589b9874590b6a9705e64
> # good: [91cfd679f9e8b9a7bf2f26adf66eff99dbe2026b] ACPI/IORT: Handle 
> memory address size limits as limits
> git bisect good 91cfd679f9e8b9a7bf2f26adf66eff99dbe2026b
> # bad: [ad4750b07d3462ce29a0c9b1e88b2a1f9795290e] iommu/dma: Make limit 
> checks self-contained
> git bisect bad ad4750b07d3462ce29a0c9b1e88b2a1f9795290e
> # good: [fece6530bf4b59b01a476a12851e07751e73d69f] dma-mapping: Add 
> helpers for dma_range_map bounds
> git bisect good fece6530bf4b59b01a476a12851e07751e73d69f
> # first bad commit: [ad4750b07d3462ce29a0c9b1e88b2a1f9795290e] 
> iommu/dma: Make limit checks self-contained
> 
> There is a couple skips in there and so I will try this again.
> 
>>> If you have any ideas on things we can try let me know.
>>
>> Since the symptom seems inexplicable, I'd throw the usual memory 
>> debugging stuff like KASAN at it first. I'd also try 
>> "no_console_suspend" to check whether any late output is being missed 
>> in the suspend case (and if it's already broken, then any additional 
>> issues that may be caused by the console itself hopefully shouldn't 
>> matter).
>>
>> For more base-covering, do you have the "arm64: Properly clean up 
>> iommu-dma remnants" fix in there already as well? That bug has 
>> bisected to patch #6 each time though, so I do still suspect that what 
>> you're seeing is likely something else. It does seem potentially 
>> significant that those Tegra platforms are making fairly wide use of 
>> dma-ranges, but there's no clear idea forming out of that observation 
>> just yet...
> 
> I was hoping it was the same issue other people had reported,
> but the fix provided did not help. I have also tried today's
> -next and I am still seeing the issue.
> 
> I should have more time next week to look at this further. Let
> me confirm which change is causing this and add more debug.

Thanks. From staring at the code I think I've spotted one subtlety which
may not be quite as intended - can you see if the diff below helps? It
occurs to me that suspend and CPU hotplug may not *cause* the symptom,
but they could certainly stall if one or more relevant CPUs is *already*
stuck in a loop somewhere...

Thanks,
Robin.

----->8-----
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 89a53c2f2cf9..85eb1846c637 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -686,6 +686,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, struct device *dev
  	/* Check the domain allows at least some access to the device... */
  	if (map) {
  		dma_addr_t base = dma_range_map_min(map);
+		base = max(base, (dma_addr_t)1 << order);
  		if (base > domain->geometry.aperture_end ||
  		    dma_range_map_max(map) < domain->geometry.aperture_start) {
  			pr_warn("specified DMA range outside IOMMU capability\n");

