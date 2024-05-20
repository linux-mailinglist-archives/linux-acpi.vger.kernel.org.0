Return-Path: <linux-acpi+bounces-5895-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B708C9B2D
	for <lists+linux-acpi@lfdr.de>; Mon, 20 May 2024 12:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD201F21F2D
	for <lists+linux-acpi@lfdr.de>; Mon, 20 May 2024 10:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C2E4F1F9;
	Mon, 20 May 2024 10:26:24 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CDE1CD31;
	Mon, 20 May 2024 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716200784; cv=none; b=SvWXUjh0obr6Nrg3t/O1e2tY/RJQubLSP4hFuZdUuSTcnmgqchUGbuM+bM7+hiQD13uBkgPiPcwe/OzXWFwCcc2yQfuVlVr/F+taleCuaoB2bM6MWxnKrOII2+1JIempwLyba2JdnCDMjOpqO9IKAq7HLpv0nXkx/VnMjoPEWZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716200784; c=relaxed/simple;
	bh=1qB7VBGFkFKCrRZgTuXpSZgFCo9+oaSne3bB3h1ZcpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZI2GFcGJ7pT4YsOE6Prk29QD92gOU5KYtT91sCjBwGHhtDkg4TkBCwV4th60qUy87Kgi7vYQNeXIEKPNXKEuIq7MoabPK58ATyvYJuxhSA4WiiQKvJBhlh4UWDCFZAD7XGW0GGa8Hc50/U5PdKhpdJDMNiHG/K/Fqgt0ciZ+/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1759FEC;
	Mon, 20 May 2024 03:26:45 -0700 (PDT)
Received: from [10.57.37.116] (unknown [10.57.37.116])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C36063F766;
	Mon, 20 May 2024 03:26:11 -0700 (PDT)
Message-ID: <09fef0af-73ab-46cb-af31-9a10c1e90593@arm.com>
Date: Mon, 20 May 2024 11:26:04 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] iommu/dma: Make limit checks self-contained
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Christoph Hellwig <hch@lst.de>, Vineet Gupta <vgupta@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
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
 <981c85f3-6d43-4c2b-a440-88bf81a18e55@arm.com>
 <o7hp34of3rg2fhbzpnbakaxnr24cfdfdrwf6d3hhxdeq4qqisk@6fqlszyvclhs>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <o7hp34of3rg2fhbzpnbakaxnr24cfdfdrwf6d3hhxdeq4qqisk@6fqlszyvclhs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-05-18 7:31 pm, Jerry Snitselaar wrote:
> On Fri, May 17, 2024 at 04:03:57PM GMT, Robin Murphy wrote:
>> On 17/05/2024 3:21 pm, Jon Hunter wrote:
>>>
>>> On 15/05/2024 15:59, Robin Murphy wrote:
>>>> Hi Jon,
>>>>
>>>> On 2024-05-14 2:27 pm, Jon Hunter wrote:
>>>>> Hi Robin,
>>>>>
>>>>> On 19/04/2024 17:54, Robin Murphy wrote:
>>>>>> It's now easy to retrieve the device's DMA limits if we want to check
>>>>>> them against the domain aperture, so do that ourselves instead of
>>>>>> relying on them being passed through the callchain.
>>>>>>
>>>>>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>>>>>> Tested-by: Hanjun Guo <guohanjun@huawei.com>
>>>>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>>>>> ---
>>>>>> ï¿½ drivers/iommu/dma-iommu.c | 21 +++++++++------------
>>>>>> ï¿½ 1 file changed, 9 insertions(+), 12 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>>>>> index a3039005b696..f542eabaefa4 100644
>>>>>> --- a/drivers/iommu/dma-iommu.c
>>>>>> +++ b/drivers/iommu/dma-iommu.c
>>>>>> @@ -660,19 +660,16 @@ static void
>>>>>> iommu_dma_init_options(struct iommu_dma_options *options,
>>>>>> ï¿½ /**
>>>>>> ï¿½ï¿½ * iommu_dma_init_domain - Initialise a DMA mapping domain
>>>>>> ï¿½ï¿½ * @domain: IOMMU domain previously prepared by
>>>>>> iommu_get_dma_cookie()
>>>>>> - * @base: IOVA at which the mappable address space starts
>>>>>> - * @limit: Last address of the IOVA space
>>>>>> ï¿½ï¿½ * @dev: Device the domain is being initialised for
>>>>>> ï¿½ï¿½ *
>>>>>> - * @base and @limit + 1 should be exact multiples of IOMMU
>>>>>> page granularity to
>>>>>> - * avoid rounding surprises. If necessary, we reserve the
>>>>>> page at address 0
>>>>>> + * If the geometry and dma_range_map include address 0, we
>>>>>> reserve that page
>>>>>> ï¿½ï¿½ * to ensure it is an invalid IOVA. It is safe to
>>>>>> reinitialise a domain, but
>>>>>> ï¿½ï¿½ * any change which could make prior IOVAs invalid will fail.
>>>>>> ï¿½ï¿½ */
>>>>>> -static int iommu_dma_init_domain(struct iommu_domain
>>>>>> *domain, dma_addr_t base,
>>>>>> -ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ dma_addr_t limit, struct device *dev)
>>>>>> +static int iommu_dma_init_domain(struct iommu_domain
>>>>>> *domain, struct device *dev)
>>>>>> ï¿½ {
>>>>>> ï¿½ï¿½ï¿½ï¿½ï¿½ struct iommu_dma_cookie *cookie = domain->iova_cookie;
>>>>>> +ï¿½ï¿½ï¿½ const struct bus_dma_region *map = dev->dma_range_map;
>>>>>> ï¿½ï¿½ï¿½ï¿½ï¿½ unsigned long order, base_pfn;
>>>>>> ï¿½ï¿½ï¿½ï¿½ï¿½ struct iova_domain *iovad;
>>>>>> ï¿½ï¿½ï¿½ï¿½ï¿½ int ret;
>>>>>> @@ -684,18 +681,18 @@ static int
>>>>>> iommu_dma_init_domain(struct iommu_domain *domain,
>>>>>> dma_addr_t base,
>>>>>> ï¿½ï¿½ï¿½ï¿½ï¿½ /* Use the smallest supported page size for IOVA granularity */
>>>>>> ï¿½ï¿½ï¿½ï¿½ï¿½ order = __ffs(domain->pgsize_bitmap);
>>>>>> -ï¿½ï¿½ï¿½ base_pfn = max_t(unsigned long, 1, base >> order);
>>>>>> +ï¿½ï¿½ï¿½ base_pfn = 1;
>>>>>> ï¿½ï¿½ï¿½ï¿½ï¿½ /* Check the domain allows at least some access to the
>>>>>> device... */
>>>>>> -ï¿½ï¿½ï¿½ if (domain->geometry.force_aperture) {
>>>>>> +ï¿½ï¿½ï¿½ if (map) {
>>>>>> +ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ dma_addr_t base = dma_range_map_min(map);
>>>>>> ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ if (base > domain->geometry.aperture_end ||
>>>>>> -ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ limit < domain->geometry.aperture_start) {
>>>>>> +ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ dma_range_map_max(map) <
>>>>>> domain->geometry.aperture_start) {
>>>>>> ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ pr_warn("specified DMA range outside IOMMU
>>>>>> capability\n");
>>>>>> ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ return -EFAULT;
>>>>>> ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ }
>>>>>> ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ /* ...then finally give it a kicking to make sure it fits */
>>>>>> -ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ base_pfn = max_t(unsigned long, base_pfn,
>>>>>> -ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ domain->geometry.aperture_start >> order);
>>>>>> +ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ base_pfn = max(base,
>>>>>> domain->geometry.aperture_start) >> order;
>>>>>> ï¿½ï¿½ï¿½ï¿½ï¿½ }
>>>>>> ï¿½ï¿½ï¿½ï¿½ï¿½ /* start_pfn is always nonzero for an
>>>>>> already-initialised domain */
>>>>>> @@ -1760,7 +1757,7 @@ void iommu_setup_dma_ops(struct device
>>>>>> *dev, u64 dma_base, u64 dma_limit)
>>>>>> ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ * underlying IOMMU driver needs to support via the
>>>>>> dma-iommu layer.
>>>>>> ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ */
>>>>>> ï¿½ï¿½ï¿½ï¿½ï¿½ if (iommu_is_dma_domain(domain)) {
>>>>>> -ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ if (iommu_dma_init_domain(domain, dma_base, dma_limit, dev))
>>>>>> +ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ if (iommu_dma_init_domain(domain, dev))
>>>>>> ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ goto out_err;
>>>>>> ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ dev->dma_ops = &iommu_dma_ops;
>>>>>> ï¿½ï¿½ï¿½ï¿½ï¿½ }
>>>>>
>>>>>
>>>>> I have noticed some random test failures on Tegra186 and
>>>>> Tegra194 and bisect is pointing to this commit. Reverting this
>>>>> along with the various dependencies does fix the problem. On
>>>>> Tegra186 CPU hotplug is failing and on Tegra194 suspend is
>>>>> failing. Unfortunately, on neither platform do I see any
>>>>> particular crash but the boards hang somewhere.
>>>>
>>>> That is... thoroughly bemusing :/ Not only is there supposed to be
>>>> no real functional change here - we should merely be recalculating
>>>> the same information from dev->dma_range_map that the callers were
>>>> already doing to generate the base/limit arguments - but the act of
>>>> initially setting up a default domain for a device behind an IOMMU
>>>> should have no connection whatsoever to suspend and especially not
>>>> to CPU hotplug.
>>>
>>>
>>> Yes it does look odd, but this is what bisect reported ...
>>>
>>> git bisect start
>>> # good: [a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6] Linux 6.9
>>> git bisect good a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
>>> # bad: [6ba6c795dc73c22ce2c86006f17c4aa802db2a60] Add linux-next
>>> specific files for 20240513
>>> git bisect bad 6ba6c795dc73c22ce2c86006f17c4aa802db2a60
>>> # good: [29e7f949865a023a21ecdfbd82d68ac697569f34] Merge branch 'main'
>>> of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
>>> git bisect good 29e7f949865a023a21ecdfbd82d68ac697569f34
>>> # skip: [150e6cc14e51f2a07034106a4529cdaafd812c46] Merge branch 'next'
>>> of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
>>> git bisect skip 150e6cc14e51f2a07034106a4529cdaafd812c46
>>> # good: [f5d75327d30af49acf2e4b55f35ce2e6c45d1287] drm/amd/display: Fix
>>> invalid Copyright notice
>>> git bisect good f5d75327d30af49acf2e4b55f35ce2e6c45d1287
>>> # skip: [f1ec9a9ffc526df7c9523006c2abbb8ea554cdd8] Merge branch
>>> 'for-next' of
>>> git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git
>>> git bisect skip f1ec9a9ffc526df7c9523006c2abbb8ea554cdd8
>>> # bad: [f091e93306e0429ebb7589b9874590b6a9705e64] dma-mapping: Simplify
>>> arch_setup_dma_ops()
>>> git bisect bad f091e93306e0429ebb7589b9874590b6a9705e64
>>> # good: [91cfd679f9e8b9a7bf2f26adf66eff99dbe2026b] ACPI/IORT: Handle
>>> memory address size limits as limits
>>> git bisect good 91cfd679f9e8b9a7bf2f26adf66eff99dbe2026b
>>> # bad: [ad4750b07d3462ce29a0c9b1e88b2a1f9795290e] iommu/dma: Make limit
>>> checks self-contained
>>> git bisect bad ad4750b07d3462ce29a0c9b1e88b2a1f9795290e
>>> # good: [fece6530bf4b59b01a476a12851e07751e73d69f] dma-mapping: Add
>>> helpers for dma_range_map bounds
>>> git bisect good fece6530bf4b59b01a476a12851e07751e73d69f
>>> # first bad commit: [ad4750b07d3462ce29a0c9b1e88b2a1f9795290e]
>>> iommu/dma: Make limit checks self-contained
>>>
>>> There is a couple skips in there and so I will try this again.
>>>
>>>>> If you have any ideas on things we can try let me know.
>>>>
>>>> Since the symptom seems inexplicable, I'd throw the usual memory
>>>> debugging stuff like KASAN at it first. I'd also try
>>>> "no_console_suspend" to check whether any late output is being
>>>> missed in the suspend case (and if it's already broken, then any
>>>> additional issues that may be caused by the console itself hopefully
>>>> shouldn't matter).
>>>>
>>>> For more base-covering, do you have the "arm64: Properly clean up
>>>> iommu-dma remnants" fix in there already as well? That bug has
>>>> bisected to patch #6 each time though, so I do still suspect that
>>>> what you're seeing is likely something else. It does seem
>>>> potentially significant that those Tegra platforms are making fairly
>>>> wide use of dma-ranges, but there's no clear idea forming out of
>>>> that observation just yet...
>>>
>>> I was hoping it was the same issue other people had reported,
>>> but the fix provided did not help. I have also tried today's
>>> -next and I am still seeing the issue.
>>>
>>> I should have more time next week to look at this further. Let
>>> me confirm which change is causing this and add more debug.
>>
>> Thanks. From staring at the code I think I've spotted one subtlety which
>> may not be quite as intended - can you see if the diff below helps? It
>> occurs to me that suspend and CPU hotplug may not *cause* the symptom,
>> but they could certainly stall if one or more relevant CPUs is *already*
>> stuck in a loop somewhere...
>>
>> Thanks,
>> Robin.
>>
>> ----->8-----
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 89a53c2f2cf9..85eb1846c637 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -686,6 +686,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, struct device *dev
>>   	/* Check the domain allows at least some access to the device... */
>>   	if (map) {
>>   		dma_addr_t base = dma_range_map_min(map);
>> +		base = max(base, (dma_addr_t)1 << order);
>>   		if (base > domain->geometry.aperture_end ||
>>   		    dma_range_map_max(map) < domain->geometry.aperture_start) {
>>   			pr_warn("specified DMA range outside IOMMU capability\n");
> 
> With this in place I no longer see the mapping fail on the nvidia system.

Cheers Jerry, that's reassuring. I'll write up a proper patch shortly - 
with Monday morning eyes I realise this isn't entirely the right fix for 
how I messed up here - and hope that my guess was right and it's the 
source of Jon's issues as well. From experience I know that the effects 
of the IOVA allocator going wrong can be varied and downright weird...

Thanks,
Robin.

