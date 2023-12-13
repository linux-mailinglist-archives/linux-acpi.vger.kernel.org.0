Return-Path: <linux-acpi+bounces-2287-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D7280D0B7
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 17:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE0F1F21971
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 16:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6A44C601;
	Mon, 11 Dec 2023 16:13:48 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FBA98E;
	Mon, 11 Dec 2023 08:13:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44658FEC;
	Mon, 11 Dec 2023 08:14:31 -0800 (PST)
Received: from [10.57.85.194] (unknown [10.57.85.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7959B3F738;
	Mon, 11 Dec 2023 08:13:39 -0800 (PST)
Message-ID: <ae904525-66e7-4702-925d-0d42481cd354@arm.com>
Date: Mon, 11 Dec 2023 16:13:38 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] ACPI/IORT: Handle memory address size limits as
 limits
Content-Language: en-GB
To: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
 Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
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
 linux-acpi@vger.kernel.org, iommu@lists.linux.dev, devicetree@vger.kernel.org
References: <cover.1701268753.git.robin.murphy@arm.com>
 <2ae6199a9cf035c1defd42e48675b827f41cdc95.1701268753.git.robin.murphy@arm.com>
 <20231211132757.GE25681@willie-the-truck>
 <91b22090-485f-49c9-a536-849fd7f92f8e@arm.com>
 <20231211153023.GA26048@willie-the-truck>
 <ZXctTJ-q9e1FPBhH@FVFF77S0Q05N.cambridge.arm.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZXctTJ-q9e1FPBhH@FVFF77S0Q05N.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-12-11 3:39 pm, Mark Rutland wrote:
> On Mon, Dec 11, 2023 at 03:30:24PM +0000, Will Deacon wrote:
>> On Mon, Dec 11, 2023 at 03:01:27PM +0000, Robin Murphy wrote:
>>> On 2023-12-11 1:27 pm, Will Deacon wrote:
>>>> On Wed, Nov 29, 2023 at 05:43:00PM +0000, Robin Murphy wrote:
>>>>> Return the Root Complex/Named Component memory address size limit as an
>>>>> inclusive limit value, rather than an exclusive size.  This saves us
>>>>> having to special-case 64-bit overflow, and simplifies our caller too.
>>>>>
>>>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>>>> ---
>>>>>    drivers/acpi/arm64/dma.c  |  9 +++------
>>>>>    drivers/acpi/arm64/iort.c | 18 ++++++++----------
>>>>>    include/linux/acpi_iort.h |  4 ++--
>>>>>    3 files changed, 13 insertions(+), 18 deletions(-)
>>>>
>>>> [...]
>>>>
>>>>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>>>>> index 6496ff5a6ba2..eb64d8e17dd1 100644
>>>>> --- a/drivers/acpi/arm64/iort.c
>>>>> +++ b/drivers/acpi/arm64/iort.c
>>>>> @@ -1367,7 +1367,7 @@ int iort_iommu_configure_id(struct device *dev, const u32 *input_id)
>>>>>    { return -ENODEV; }
>>>>>    #endif
>>>>> -static int nc_dma_get_range(struct device *dev, u64 *size)
>>>>> +static int nc_dma_get_range(struct device *dev, u64 *limit)
>>>>>    {
>>>>>    	struct acpi_iort_node *node;
>>>>>    	struct acpi_iort_named_component *ncomp;
>>>>> @@ -1384,13 +1384,12 @@ static int nc_dma_get_range(struct device *dev, u64 *size)
>>>>>    		return -EINVAL;
>>>>>    	}
>>>>> -	*size = ncomp->memory_address_limit >= 64 ? U64_MAX :
>>>>> -			1ULL<<ncomp->memory_address_limit;
>>>>> +	*limit = (1ULL << ncomp->memory_address_limit) - 1;
>>>>
>>>> The old code handled 'ncomp->memory_address_limit >= 64' -- why is it safe
>>>> to drop that? You mention it in the cover letter, so clearly I'm missing
>>>> something!
>>>
>>> Because an unsigned shift by 64 or more generates 0 (modulo 2^64), thus
>>> subtracting 1 results in the correct all-bits-set value for an inclusive
>>> 64-bit limit.
>>
>> Oh, I'd have thought you'd have gotten one of those "left shift count >=
>> width of type" warnings if you did that.
> 
> I think you'll get a UBSAN splat, but here the compiler doesn't know what
> 'ncomp->memory_address_limit' will be and so doesn't produce a compile-time
> warning.
> 
> Regardless, it's undefined behaviour.

Urgh, you're right... I double-checked 6.5.7.4 in the standard but 
managed to miss 6.5.7.3. So yeah, even though "4 << 62" or "2 << 63" are 
well-defined here, "1  << 64" isn't, dang. Thanks, funky old ISAs which 
did weird things for crazy large shifts and have no relevance to this 
code :(

Cheers,
Robin.

