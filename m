Return-Path: <linux-acpi+bounces-16550-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8312CB503BE
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 19:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C2D11899FB4
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 17:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B2B37428C;
	Tue,  9 Sep 2025 16:58:13 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B58334717;
	Tue,  9 Sep 2025 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437093; cv=none; b=EUF3JmP3c+7GG1XcIay0zFovg32qXg7Pwp4OrHshl2rjmBDF0N6HA7Ltm+XhEqHdzWRc1BfNICPDgEp6e0elf5tBK2QNtjoNNz6QUSsoE/YVjZfIRimr+OI2xCYqErL5GSGjUmbLDsuOHSZhmrPXwmrX7C+e8g4A/NPTAlrkfBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437093; c=relaxed/simple;
	bh=3JmhVAZRsXTM2WZcr1yliDd8RJH423+zScrAFtIK9+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGCCnTktrk6omCJNDpGC2GIydqWWcy8mUC6zpcM03SnqIfwkqJs5nSbQdY56vgaguZV4KTnUDMOaNm7ZLBUQI6Q5vksF0jmECW+VFiz97PrC+0uPiWJB40NeWDgB8JcYO2qIMJ2Cy3Y+t+ebzxqkiKrNZktBNzUCahcvAUvqArI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33B1715A1;
	Tue,  9 Sep 2025 09:58:03 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75FF03F694;
	Tue,  9 Sep 2025 09:58:05 -0700 (PDT)
Message-ID: <fb2f66b4-89ea-4b1f-b5d5-30bf0be8d822@arm.com>
Date: Tue, 9 Sep 2025 17:58:05 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/33] arm_mpam: Extend reset logic to allow devices to be
 reset any time
To: Ben Horgan <ben.horgan@arm.com>, linux-kernel@vger.kernel.org,
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
 Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-22-james.morse@arm.com>
 <c2a814d6-e235-4589-bdb0-63d08d4ca008@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <c2a814d6-e235-4589-bdb0-63d08d4ca008@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ben,

On 29/08/2025 15:30, Ben Horgan wrote:
> On 8/22/25 16:30, James Morse wrote:
>> cpuhp callbacks aren't the only time the MSC configuration may need to
>> be reset. Resctrl has an API call to reset a class.
>> If an MPAM error interrupt arrives it indicates the driver has
>> misprogrammed an MSC. The safest thing to do is reset all the MSCs
>> and disable MPAM.
>>
>> Add a helper to reset RIS via their class. Call this from mpam_disable(),
>> which can be scheduled from the error interrupt handler.

>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index 759244966736..3516cbe8623e 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -1569,6 +1567,66 @@ static void mpam_enable_once(void)

>> +/*
>> + * Called in response to an error IRQ.
>> + * All of MPAMs errors indicate a software bug, restore any modified
>> + * controls to their reset values.
>> + */
>> +void mpam_disable(void)
>> +{
>> +	int idx;
>> +	struct mpam_class *class;
>> +
>> +	idx = srcu_read_lock(&mpam_srcu);
>> +	list_for_each_entry_srcu(class, &mpam_classes, classes_list,
>> +				 srcu_read_lock_held(&mpam_srcu))
> 
> Why do you use list_for_each_entry_srcu() here when in other places you
> use list_for_each_entry_rcu()?

It's a mistake. I was part way making this use RCU when someone 'invented' the
firmware interface meaning readl() needs to be able to sleep...
Those were added in a later patch than I thought, and I missed fixing them up.

I think the srcu version provides extra checking - and is the correct one to use.
I'll fix those -- thanks for spotting it!


Thanks,

James

>> +		mpam_reset_class(class);
>> +	srcu_read_unlock(&mpam_srcu, idx);
>> +}



