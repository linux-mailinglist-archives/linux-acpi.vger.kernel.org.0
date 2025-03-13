Return-Path: <linux-acpi+bounces-12191-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410F0A5F568
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 14:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 147FB7A4C8B
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 13:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B128E2676F9;
	Thu, 13 Mar 2025 13:07:09 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2E1267701;
	Thu, 13 Mar 2025 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871229; cv=none; b=URLBvAtyUqRz4z6hs/RxDx0fX6tG4gGWkCx5zFjkgaLCb2JaSLxYASce7ZqyfJhte5RnVvl+G0ewh0H+LGnE4Wzf7lCYNLruKnt3zUOVNbcALdaePEyeChcZuoLmW69I6kwX3KY2XjGksNBEAI/77/VMGFnyU/IjAoAP9M4HnI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871229; c=relaxed/simple;
	bh=IZFUBqt/PcENGjFiftwrfryoSFoDuDYzzj7uu2pIxSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EB8vt2lx9bLbjFB4y/K5GaNAgi3xmqyO5BcsH2k1EPxqZFpRXz8/SOWPtWjyQAdaGFDaZXss1V7zqKcjxVFDGzSRo8cmYenKdzG7Z/riVpwoYA5L4uPP+4TMydpwhuRxYZ+xOTClDqG2PSkx1h4Ec7tVASdBhC7rJxOVLLaXppM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE6571C00;
	Thu, 13 Mar 2025 06:07:15 -0700 (PDT)
Received: from [10.57.40.246] (unknown [10.57.40.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA07C3F673;
	Thu, 13 Mar 2025 06:07:01 -0700 (PDT)
Message-ID: <016bb7ca-f0d3-464e-ac74-46e6f78e90d7@arm.com>
Date: Thu, 13 Mar 2025 13:06:59 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 Charan Teja Kalla <quic_charante@quicinc.com>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
 <CGME20250313095633eucas1p29cb55f2504b4bcf67c16b3bd3fa9b8cd@eucas1p2.samsung.com>
 <9b358d68-332e-404e-9a75-740297f7b28d@samsung.com>
 <417d6f59-0d78-4e81-ad0b-e06846f786b0@arm.com>
 <bf2adf5d-1432-4bb7-846c-e1bcfa84858b@samsung.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <bf2adf5d-1432-4bb7-846c-e1bcfa84858b@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-03-13 12:23 pm, Marek Szyprowski wrote:
> On 13.03.2025 12:01, Robin Murphy wrote:
>> On 2025-03-13 9:56 am, Marek Szyprowski wrote:
>> [...]
>>> This patch landed in yesterday's linux-next as commit bcb81ac6ae3c
>>> ("iommu: Get DT/ACPI parsing into the proper probe path"). In my tests I
>>> found it breaks booting of ARM64 RK3568-based Odroid-M1 board
>>> (arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts). Here is the
>>> relevant kernel log:
>>
>> ...and the bug-flushing-out begins!
>>
>>> Unable to handle kernel NULL pointer dereference at virtual address
>>> 00000000000003e8
>>> Mem abort info:
>>>      ESR = 0x0000000096000004
>>>      EC = 0x25: DABT (current EL), IL = 32 bits
>>>      SET = 0, FnV = 0
>>>      EA = 0, S1PTW = 0
>>>      FSC = 0x04: level 0 translation fault
>>> Data abort info:
>>>      ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>>>      CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>>>      GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>>> [00000000000003e8] user address but active_mm is swapper
>>> Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
>>> Modules linked in:
>>> CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc3+ #15533
>>> Hardware name: Hardkernel ODROID-M1 (DT)
>>> pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> pc : devm_kmalloc+0x2c/0x114
>>> lr : rk_iommu_of_xlate+0x30/0x90
>>> ...
>>> Call trace:
>>>     devm_kmalloc+0x2c/0x114 (P)
>>>     rk_iommu_of_xlate+0x30/0x90
>>
>> Yeah, looks like this is doing something a bit questionable which can't
>> work properly. TBH the whole dma_dev thing could probably be cleaned up
>> now that we have proper instances, but for now does this work?
> 
> Yes, this patch fixes the problem I've observed.
> 
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> BTW, this dma_dev idea has been borrowed from my exynos_iommu driver and
> I doubt it can be cleaned up.

On the contrary I suspect they both can - it all dates back to when we 
had the single global platform bus iommu_ops and the SoC drivers were 
forced to bodge their own notion of multiple instances, but with the 
modern core code, ops are always called via a valid IOMMU instance or 
domain, so in principle it should always be possible to get at an 
appropriate IOMMU device now. IIRC it was mostly about allocating and 
DMA-mapping the pagetables in domain_alloc, where the private notion of 
instances didn't have enough information, but domain_alloc_paging solves 
that.

Cheers,
Robin.

