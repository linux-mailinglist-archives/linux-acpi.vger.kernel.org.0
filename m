Return-Path: <linux-acpi+bounces-2118-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9128F8036DE
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 15:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48BE7281163
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 14:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD8128E07
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 14:35:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87663A8;
	Mon,  4 Dec 2023 04:54:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAD8E1424;
	Mon,  4 Dec 2023 04:55:45 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F8DA3F5A1;
	Mon,  4 Dec 2023 04:54:54 -0800 (PST)
Message-ID: <4c55f016-ae17-4ba1-aa39-3b96f11bdb5a@arm.com>
Date: Mon, 4 Dec 2023 12:54:53 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] dma-mapping: Simplify arch_setup_dma_ops()
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>, Vineet Gupta <vgupta@kernel.org>,
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
 linux-acpi@vger.kernel.org, iommu@lists.linux.dev, devicetree@vger.kernel.org
References: <cover.1701268753.git.robin.murphy@arm.com>
 <590a4a1b7d10fb9bb1c42ca6cd438e98e6cc94a7.1701268753.git.robin.murphy@arm.com>
 <20231204084440.GB919@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231204084440.GB919@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/12/2023 8:44 am, Christoph Hellwig wrote:
> On Wed, Nov 29, 2023 at 05:43:04PM +0000, Robin Murphy wrote:
>> The dma_base, size and iommu arguments are only used by ARM, and can
>> now easily be deduced from the device itself, so there's no need to pass
>> them through the callchain as well.
> 
> This looks even better than the patch form Jason that only removed the
> iommu argument:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> I wonder if it makes sense to also remove the coherent argument
> by setting up dev->dma_coherent in the caller.  That would require
> a pretty careful audit as we're doing a few weird things in that
> area, though.

Yeah, it crossed my mind too, but then I remembered we have at least the 
ARM stuff which may have already set a platform-specific value for 
dev->dma_coherent to take precedence over the firmware value, thus still 
needs to differentiate between the two at this point. Leaving the 
established argument in place seems neater IMO than having to go back to 
arch-specific mechanisms for that and any other similar tricks.

Thanks,
Robin.

