Return-Path: <linux-acpi+bounces-16602-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFE7B520EE
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 21:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244EC1C85129
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 19:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F072D593C;
	Wed, 10 Sep 2025 19:29:26 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92CE270553;
	Wed, 10 Sep 2025 19:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532566; cv=none; b=kfj0RkdUfKTB5q4JPSrzYG5wLJEvjEoTTfFwXUZDe2A/0ePz79Pg7S1TZ8VdaL/XhnlHsbIhbOfn/UfpFb7sBwUqF6YuspHjqZ+IKrEd+l31Nt1mjS3D7qRZce93VyEEsSaocPYpi8KTzbwRFcFBldVZFyr37qP8mMk61bc19Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532566; c=relaxed/simple;
	bh=WMWEAkkDalb+8QdbfQFU5N2F0M0vF3Pgf+eeCWx8UL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AipOawa84J9GwrAnvuo+3pAkEOES/n7aU5auxZKb2aU8lN4uzVEL75EGuMTrOjDM1woeWQS3UKTeno7h5x16nq9mqvmLbcqlJ+J1JPZwEATJZSAxNbWi0nWgpZ0T+AQP8XvHXeQlUmrNmEJ7u8ig3yFlsr9jRevwsjuOiEIxGRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8771D16F2;
	Wed, 10 Sep 2025 12:29:15 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5EC03F694;
	Wed, 10 Sep 2025 12:29:17 -0700 (PDT)
Message-ID: <7353f490-2cac-4b97-9f48-c612b9034561@arm.com>
Date: Wed, 10 Sep 2025 20:29:17 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/33] ACPI / PPTT: Add a helper to fill a cpumask from a
 cache_id
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-7-james.morse@arm.com>
 <aK7ju2caTjqf1+VN@e133380.arm.com>
 <2e4c3c00-b248-421e-8ff1-d24b7b03be1a@arm.com>
 <aL/9/KSH35ou8Mgj@e133380.arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <aL/9/KSH35ou8Mgj@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dave,

On 09/09/2025 11:14, Dave Martin wrote:
> On Thu, Aug 28, 2025 at 04:58:16PM +0100, James Morse wrote:
>> On 27/08/2025 11:53, Dave Martin wrote:
>>> On Fri, Aug 22, 2025 at 03:29:47PM +0000, James Morse wrote:
>>>> MPAM identifies CPUs by the cache_id in the PPTT cache structure.
>>>>
>>>> The driver needs to know which CPUs are associated with the cache,
>>>> the CPUs may not all be online, so cacheinfo does not have the
>>>> information.

>>>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>>>> index 660457644a5b..cb93a9a7f9b6 100644
>>>> --- a/drivers/acpi/pptt.c
>>>> +++ b/drivers/acpi/pptt.c
>>>> @@ -971,3 +971,65 @@ int find_acpi_cache_level_from_id(u32 cache_id)
> 
> [...]
> 
>>>> + * acpi_pptt_get_cpumask_from_cache_id() - Get the cpus associated with the
>>>> + *					   specified cache
>>>> + * @cache_id: The id field of the unified cache
>>>> + * @cpus: Where to build the cpumask
>>>> + *
>>>> + * Determine which CPUs are below this cache in the PPTT. This allows the property
>>>> + * to be found even if the CPUs are offline.
>>>> + *
>>>> + * The PPTT table must be rev 3 or later,
>>>> + *
>>>> + * Return: -ENOENT if the PPTT doesn't exist, or the cache cannot be found.
>>>> + * Otherwise returns 0 and sets the cpus in the provided cpumask.
>>>> + */
>>>> +int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id, cpumask_t *cpus)
>>>> +{
> 
> [...]
> 
>>>> +	/*
>>>> +	 * If we found the cache first, we'd still need to walk from each cpu.
>>>> +	 */
>>>> +	for_each_possible_cpu(cpu) {
> 
> [...]
> 
>>> Again, it feels like we are repeating the same walk multiple times to
>>> determine how deep the table is (on which point the table is self-
>>> describing anyway), and then again to derive some static property, and
>>> then we are then doing all of that work multiple times to derive
>>> different static properties, etc.
>>>
>>> Can we not just walk over the tables once and stash the derived
>>> properties somewhere?
>>
>> That is possible - but its a more invasive change to the PPTT parsing code.
>> Before the introduction of the leaf flag, the search for a processor also included a
>> search to check if the discovered node was a leaf.
>>
>> I think this is trading time - walking over the table multiple times, against the memory
>> you'd need to de-serialise the tree to find the necessary properties quickly. I think the
>> reason Jeremy L went this way was because there may never be another request into this
>> code, so being ready with a quick answer was a waste of memory.
>>
>> MPAM doesn't change this - all these things are done up front during driver probing, and
>> the values are cached by the driver.
> 
> I guess that's true.
> 
>>> I'm still getting my head around this parsing code, so I'm not saying
>>> that the approach is incorrect here -- just wondering whether there is
>>> a way to make it simpler.
>>
>> It's walked at boot, and on cpu-hotplug. Neither are particularly performance critical.

> Do we do this only for unknown late secondaries (e.g., that haven't
> previously come online?) 

No, each time a CPU comes online.


> I haven't gone to track this down but, if not,
> this cuts across the assertion that "there may never be another request
> into this code".

CPU hotplug is optional - you don't have to bounce CPUs. It's very common on mobile parts
for power saving. I think its fairly unusual on server parts, once CPUs are online they
stay online.

The cacheinfo code doesn't cache this, it re-reads it every time. That turns out to be
because of PowerPC where some of these properties can be changed while a CPU is offline.
Sure, we could have a Kconfig thing to say ARCH_STATIC_TABLES_ARE_STATIC, but that would
be a different piece of work.
(I've had a couple of stabs at this, but cacheinfo is the shape it needs to be)


> cpu hotlug is slow in practice, but gratuitous cost on this path should
> still be avoided where feasible.
> 
>> I agree that as platforms get bigger, there will be a tipping point ... I don't think
>> anyone has complained yet!
> 
> Ack -- when in ACPI, do as the ACPI folks do, I guess.


Thanks,

James

