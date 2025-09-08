Return-Path: <linux-acpi+bounces-16502-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BD7B497AC
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 19:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0B7E18997E3
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 17:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7373431327F;
	Mon,  8 Sep 2025 17:57:48 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7B323CB;
	Mon,  8 Sep 2025 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757354268; cv=none; b=nTFugbKIbH6f5QWga9YgcX02jTMb1aCvxamZEfrAxRPoC7/FGocCbzG9JMO89hcgLsxfHnf3znpUH7AFXl1tuCieeD0U0+btw3svo04W2YJ09H99P5J2m8l+QWOFiYsal860gnDPfPhVOmVB8UGUt1MrGJAcShsvQD4eUc3ec4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757354268; c=relaxed/simple;
	bh=GmmMOUFanv7lquM+zxW4SAKlsJnfeBRTIWZi/NlwPDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jW/orLX9Gr/IfEbSXLS2wX268j6lTvn6wCaL20A2UlxFC2i0q8ShBTnh/05ctGexq1tqO0Gtbwdvq99Jir4rI5XDX7KYAHsWkG/9Ch0nDhFmfPlzsJCdAA8ZDeIOZ76FZ3Q8tB4JGswkUcCAT0bb+YZ9+119BdCPuaKc/IBWeVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F8401692;
	Mon,  8 Sep 2025 10:57:36 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BB863F694;
	Mon,  8 Sep 2025 10:57:38 -0700 (PDT)
Message-ID: <28e24773-9f8b-4701-845a-61a878a8dea5@arm.com>
Date: Mon, 8 Sep 2025 18:57:36 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/33] arm_mpam: Add the class and component structures
 for ris firmware described
To: Fenghua Yu <fenghuay@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, baisheng.gao@unisoc.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Ben Horgan <ben.horgan@arm.com>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-13-james.morse@arm.com>
 <5f2c1bf5-6486-464b-aade-4f55b4c3af9f@nvidia.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <5f2c1bf5-6486-464b-aade-4f55b4c3af9f@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Fenghua,

On 28/08/2025 02:29, Fenghua Yu wrote:
> On 8/22/25 08:29, James Morse wrote:
>> An MSC is a container of resources, each identified by their RIS index.
>> Some RIS are described by firmware to provide their position in the system.
>> Others are discovered when the driver probes the hardware.
>>
>> To configure a resource it needs to be found by its class, e.g. 'L2'.
>> There are two kinds of grouping, a class is a set of components, which
>> are visible to user-space as there are likely to be multiple instances
>> of the L2 cache. (e.g. one per cluster or package)
>>
>> struct mpam_components are a set of struct mpam_vmsc. A vMSC groups the
>> RIS in an MSC that control the same logical piece of hardware. (e.g. L2).
>> This is to allow hardware implementations where two controls are presented
>> as different RIS. Re-combining these RIS allows their feature bits to
>> be or-ed. This structure is not visible outside mpam_devices.c
>>
>> struct mpam_vmsc are then a set of struct mpam_msc_ris, which are not
>> visible as each L2 cache may be composed of individual slices which need
>> to be configured the same as the hardware is not able to distribute the
>> configuration.
>>
>> Add support for creating and destroying these structures.
>>
>> A gfp is passed as the structures may need creating when a new RIS entry
>> is discovered when probing the MSC.

>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index 71a1fb1a9c75..5baf2a8786fb 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
> [SNIP]
>> +static struct mpam_vmsc *
>> +mpam_vmsc_alloc(struct mpam_component *comp, struct mpam_msc *msc, gfp_t gfp)
>> +{
>> +    struct mpam_vmsc *vmsc;
>> +
>> +    lockdep_assert_held(&mpam_list_lock);
>> +
>> +    vmsc = kzalloc(sizeof(*vmsc), gfp);
>> +    if (!comp)
> 
> s/if (!cmp)/if (!vmsc)/
> 
> 
>> +        return ERR_PTR(-ENOMEM);

Yup, that's a copy-and-paste typo. Fixed,


Thanks,

James

