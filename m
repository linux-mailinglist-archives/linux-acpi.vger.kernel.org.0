Return-Path: <linux-acpi+bounces-16371-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30651B4444B
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 19:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB4C3B7705
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 17:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2063090FE;
	Thu,  4 Sep 2025 17:28:24 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9001E1FBEBE;
	Thu,  4 Sep 2025 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757006904; cv=none; b=Z6/r1HmoZIOecYabxQZPqcfbS/8GW/YUPBIBcjLQUSTfTLvrOtFrIhURc9ZsYSo7ZBi0tOJglzxWODIb9YvFS+ZCryX1/iZv16LefLG0EnCcE2pD0hyjkoairsPlzro5C6K3VGnF9gZVgMwexg7ssPFa57j9lc0P4836wW8tnzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757006904; c=relaxed/simple;
	bh=HN14euKfkVhQmT8KiwBCsp/m8jVFK/gjhj67dT4V8Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RL1oSuTMY0Jb2ymeMWgLxsI/p4HsEpdQk/opvumq1BnJWckfd+2aSbStei2Qz8mcZJ6nO32Mm9zcHuJzCXrCjFhgdN4AEPQiuR19TWuJ7adE+upyX7YHjUgD1oIXEj22nn668yIDvonyDWj+PTXfKgEdK2phVcjtK+iEGtXtalk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F2651596;
	Thu,  4 Sep 2025 10:28:12 -0700 (PDT)
Received: from [10.1.196.42] (eglon.cambridge.arm.com [10.1.196.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14AF53F6A8;
	Thu,  4 Sep 2025 10:28:15 -0700 (PDT)
Message-ID: <978cf822-4d7c-4301-bbc4-752f184c93d6@arm.com>
Date: Thu, 4 Sep 2025 18:28:14 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/33] arm64: kconfig: Add Kconfig entry for MPAM
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
 <20250822153048.2287-8-james.morse@arm.com>
 <aK7llvNbXZKWhtoo@e133380.arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <aK7llvNbXZKWhtoo@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dave,

On 27/08/2025 12:01, Dave Martin wrote:
> <super-pedantic mode enabled>

Uh oh!

> (Since this likely be people's go-to patch for understanding what MPAM
> is, it is probably worth going the extra mile.)
> 
> On Fri, Aug 22, 2025 at 03:29:48PM +0000, James Morse wrote:
>> The bulk of the MPAM driver lives outside the arch code because it
>> largely manages MMIO devices that generate interrupts. The driver
>> needs a Kconfig symbol to enable it, as MPAM is only found on arm64
> 
> Prefer -> "[...] to enable it. As MPAM is only [...]"
> 
>> platforms, that is where the Kconfig option makes the most sense.
> 
> It could be clearer what "where" refers to, here.

Sure,


> Maybe reword from ", that is [...]" -> ", the arm64 tree is the most
> natural home for the Kconfig option."
> 
> (Or something like that.)

Sure,


>> This Kconfig option will later be used by the arch code to enable
>> or disable the MPAM context-switch code, and registering the CPUs
> 
> Nit: "registering" -> "to register"
> 
>> properties with the MPAM driver.
> 
> Nit: "CPUs properties" -> "properties of CPUs" ?
> 
> (Maybe there was just a missed apostrophe, but it may be more readable
> here if written out longhand.)

Done, it just takes one person to think its clearer!


>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index e9bbfacc35a6..658e47fc0c5a 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -2060,6 +2060,23 @@ config ARM64_TLB_RANGE
>>  	  ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
>>  	  range of input addresses.
>>  
>> +config ARM64_MPAM
>> +	bool "Enable support for MPAM"
>> +	help
> 
> <pedantic mode on>
> 
>> +	  Memory Partitioning and Monitoring is an optional extension
>> +	  that allows the CPUs to mark load and store transactions with
> 
> Nit: "memory transactions" ?

Sure,

> (I'm wondering whether there are some transactions such as atomic
> exchanges that are not neatly characterised as "load" or "store".
> Possibly MPAM labels some transactions that really are neither.)

Equally instruction fetch and possibly even CMOs get these labels.
I wanted something other than 'transactions' so it wasn't confused with
transactional memory - and traffic seemed to vauge.

I don't think anyone expects a formal definition in the Kconfig text...


>> +	  labels for partition-id and performance-monitoring-group.
> 
> Nit: the hyphenation suggests that these are known terms (in this
> specific, hyphenated, form) with specific definitions somewhere.
> I don't think that this is the case?  At least, I have not seen the
> terms presented in this way anywhere else.
> 
> Also, the partition ID is itself a label, so "label for partition-id"
> is a tautology.
> 
> How about:
> 
> --8<--
> 
> 	  Memory System Resource Partitioning and Monitoring (MPAM) is an
> 	  optional extension to the Arm architecture that allows each
> 	  transaction issued to the memory system to be labelled with a
> 	  Partition identifier (PARTID) and Performance Monitoring Group
> 	  identifier (PMG).
> 
> -->8--

Done,


> (Yes, that really seems to be what MPAM stands for in the published
> specs.  That's quite a mounthful, and news to me...  I can't say I paid
> much attention to the document titles beyond "MPAM"!)
> 
>> +	  System components, such as the caches, can use the partition-id
>> +	  to apply a performance policy. MPAM monitors can use the
> 
> What is a "performance policy"?

A bunch of controls, the value of which reflect some kind of policy.


> The MPAM specs talk about resource controls; it's probably best to
> stick to the same terminology.
> 
>> +	  partition-id and performance-monitoring-group to measure the
>> +	  cache occupancy or data throughput.
> 
> So, how about something like:
> 
> --8<--
> 
> 	  Memory system components, such as the caches, can be configured with
> 	  policies to control how much of various physical resources (such as
> 	  memory bandwidth or cache memory) the transactions labelled with each
> 	  PARTID can consume.  Depending on the capabilities of the hardware,
> 	  the PARTID and PMG can also be used as filtering criteria to measure
> 	  the memory system resource consumption of different parts of a
> 	  workload.
> 
> -->8--

Done,


> (Where "Memory system components" is used in a generic sense and so not
> capitalised.)

(I can't wait for the Memory System Component on the Memory Side Cache!)


>> +
>> +	  Use of this extension requires CPU support, support in the
>> +	  memory system components (MSC), and a description from firmware
> 
> But here, we are explicitly using an architectural term now, so
> 
> 	"Memory System Components" (MSC)
> 
> makes sense.
> 
>> +	  of where the MSC are in the address space.
> 
> Prefer "MSCs" ?  (Not everyone agrees about whether TLAs are
> pluralisable but it is easier on the reader if "are" has an obviously
> plural noun to bind to.)

Sure,


Thanks,

James

