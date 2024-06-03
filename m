Return-Path: <linux-acpi+bounces-6144-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822238D8A6A
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Jun 2024 21:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6FFD1C22AE0
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Jun 2024 19:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFC1137C39;
	Mon,  3 Jun 2024 19:47:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F01320ED;
	Mon,  3 Jun 2024 19:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717444020; cv=none; b=Ego+edtw53PTFSQO6wO9D92Wm76RRuLBR2SwrhDFgTob4SzgACjMCxaHWkwlAOBO7MVDbh4cvphaEGtOxsGNuKEQFjcqGq/7Ka4O7PWge0VJNbGcfMh9pOp3uOmRer1knPIeKzVjKC8ybZB2MwuMWtCF2pb8b+PRDhjVuxWNpYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717444020; c=relaxed/simple;
	bh=D8qS2P6s0c2Xb/N2Iq0bMwfDy0LCuH+Ng0vJhxlUKmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Irz0LuMOh+JSIUsIl9RGZVsHZk37IKLTUm+Z/GHhTL6PZpZV4LcsLURcRkg8SaHc7aonUhEfgUwYISjFWH6ZG6tE/0FyrwBfnk15FqN7+TVvskuzvm89w2s9JobCXK4VLfqrVPUSvmsH8TYIkg2yjzvFPpypQV+X6hmT1TKNTh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A99C11042;
	Mon,  3 Jun 2024 12:47:20 -0700 (PDT)
Received: from [10.57.71.49] (unknown [10.57.71.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB91F3F64C;
	Mon,  3 Jun 2024 12:46:49 -0700 (PDT)
Message-ID: <a4105d70-bec5-4fff-b9bf-04d0b03f81d6@arm.com>
Date: Mon, 3 Jun 2024 20:46:48 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] iommu/dma: Make limit checks self-contained
To: Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
 Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>
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
 devicetree@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1713523152.git.robin.murphy@arm.com>
 <e28a114243d1e79eb3609aded034f8529521333f.1713523152.git.robin.murphy@arm.com>
 <aeb13631-7504-4c3c-ba7b-812bf121a60f@oldschoolsolutions.biz>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <aeb13631-7504-4c3c-ba7b-812bf121a60f@oldschoolsolutions.biz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jens,

On 2024-06-03 8:37 pm, Jens Glathe wrote:
> Hi Robin,
> 
> an observation from 6.10-rc1: On sc8280xp (Lenovo X13s, Windows Dev Kit
> 2023), when booted to EL2 with the arm-smmuv3 under control of Linux, it
> fails to set up DMA transfers to nvme. My box boots from nvme, so I only
> got a black screen. @craftyguy booted from USB, and got this:

Indeed, I see there's a dma-ranges property with a base of 0 in that DT, 
so all manner of hilarity may ensue. The fix is here, just waiting to be 
picked up:

https://lore.kernel.org/linux-iommu/159193e80b6a7701c61b32d6119ac68989d457bd.1716997607.git.robin.murphy@arm.com/

Thanks,
Robin.

