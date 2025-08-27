Return-Path: <linux-acpi+bounces-16118-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E710AB3884C
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 19:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F663B70F7
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 17:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527AD304966;
	Wed, 27 Aug 2025 17:11:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA1A2FABE9;
	Wed, 27 Aug 2025 17:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756314699; cv=none; b=BxfUwlZrpmmCVUmnG+BpwPyRCvFF2/s9ffZ59ed+r1Nj3uTcncE3hBvTg3RGUagh9rrGSpjXaPS1cVp9dr9s6nEoFqLz113n2YtPZZlD33GuHCiWp6OSXI9YPnI/oNhPsxChDN7QbFlbZQ7RnDwchWvW4al10mPr2wOVn/dfELI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756314699; c=relaxed/simple;
	bh=PhPr6Cz0D9basNtnoVPIicKjK8nEabA5LfzUNHK7BlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9E36sKoZM+qREhBh45TnDUV2/baMmDB27P9NdL/EKdQYo13DxaoteZWsvKFGwVB41LDppuXM+5uNpgcK4sIOCpYo5aTYikfsJDoSN85XbcWsUoHO2Mga3IHtDMisSh+0XjgbDhOUL9KZxBiD6yY7A4dSqWWM2Y/JLsXqi9coOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB08115A1;
	Wed, 27 Aug 2025 10:11:27 -0700 (PDT)
Received: from [10.1.196.42] (eglon.cambridge.arm.com [10.1.196.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FE913F694;
	Wed, 27 Aug 2025 10:11:27 -0700 (PDT)
Message-ID: <17675117-79ef-42e3-9c21-4bc46e73d6b1@arm.com>
Date: Wed, 27 Aug 2025 18:11:25 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/33] cacheinfo: Expose the code to generate a cache-id
 from a device_node
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 shameerali.kolothum.thodi@huawei.com,
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
 <20250822153048.2287-2-james.morse@arm.com>
 <aK7h6seHNWs5rO9Q@e133380.arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <aK7h6seHNWs5rO9Q@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dave,

On 27/08/2025 11:46, Dave Martin wrote:
> On Fri, Aug 22, 2025 at 03:29:42PM +0000, James Morse wrote:
>> The MPAM driver identifies caches by id for use with resctrl. It
>> needs to know the cache-id when probe-ing, but the value isn't set
>> in cacheinfo until device_initcall().
>>
>> Expose the code that generates the cache-id. The parts of the MPAM
>> driver that run early can use this to set up the resctrl structures
>> before cacheinfo is ready in device_initcall().

> Why can't the MPAM driver just consume the precomputed cache-id
> information?

Because it would need to wait until cacheinfo was ready, and it would still
need a way of getting the cache-id for caches where all the CPUs are offline.

The resctrl glue code has a waitqueue to wait for device_initcall_sync(), but that is
asynchronous to driver probing, its triggered by the schedule_work() from the cpuhp
callbacks. This bit is about the driver's use, which just gets probed whenever the core
code feels like it.

I toyed with always using cacheinfo for everything, and just waiting - but the MPAM driver
already has to parse the PPTT to find the information it needs on ACPI platforms, so the
wait would only happen on DT.

It seemed simpler to grab what the value would be, instead of waiting (or probe defer) -
especially as this is also needed for caches where all the CPUs are offline.

(I'll add the offline-cpus angle to the commit message)


> Possible reasons are that the MPAM driver probes too early,

yup,

> or that it
> must parse the PPTT directly (which is true) and needs to label caches
> consistently with the way the kernel does it.

It needs to match what will be exposed to user-space from cacheinfo.
This isn't about the PPTT, its the value that is generated for DT systems.
The driver has to know if its ACPI or DT to call the appropriate thing to get cache-ids
before cacheinfo is ready.


>> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
>> index 613410705a47..f6289d142ba9 100644
>> --- a/drivers/base/cacheinfo.c
>> +++ b/drivers/base/cacheinfo.c
>> @@ -207,11 +207,10 @@ static bool match_cache_node(struct device_node *cpu,
>>  #define arch_compact_of_hwid(_x)	(_x)
>>  #endif
>>  
>> -static void cache_of_set_id(struct cacheinfo *this_leaf,
>> -			    struct device_node *cache_node)
>> +unsigned long cache_of_calculate_id(struct device_node *cache_node)
>>  {
>>  	struct device_node *cpu;
>> -	u32 min_id = ~0;
>> +	unsigned long min_id = ~0UL;

> Why the change of type here?

This is a hang over from Rob's approach of making the cache-id 64 bit.


> This does mean that 0xffffffff can now be generated as a valid cache-id,
> but if that is necessary then this patch is also fixing a bug in the
> code -- but the commit message doesn't say anything about that.
> 
> For a patch that is just exposing an internal result, it may be
> better to keep the original type.  ~(u32)0 is already used as an
> exceptional value.

Yup, I'll fix that.


Thanks!

James

