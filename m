Return-Path: <linux-acpi+bounces-16150-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB12B3A506
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 17:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FACF7AFE07
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 15:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E4F254B1B;
	Thu, 28 Aug 2025 15:57:30 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049CD253F39;
	Thu, 28 Aug 2025 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756396650; cv=none; b=BYspithx90Z5BmYPPeYRF2COwRYqDtD9nCUuaYQRMiDwu0lGA9bo0iGrsrVDTGz7qWdTgh7U2rb+tancrr6aeS0w0FbU3SBAlMNVI2ZHpIC0aa0EmkzOwYzESakudz3Go/Q9vdzcJ7XU4ZPv6e85O6kUdoto4zIMMuJzKkFZKPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756396650; c=relaxed/simple;
	bh=dHh9lp8FKXkKfqDw889UrwbOTIWWsRqQJu7VRqj7lJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4V4nQva6Sa1L4ZaHMrIqKbxa1tUe3CiyUKJVjL2MbscWNaej6pd9XuHqfjU1nBLoZfC1PeZIPZnxszHf/gyaNEAoFy0rzFuV6cAgZWWZlchshG0LG6QsT/p4s/YWoS6wU1EW71ilNKA0SX5oBQ7RJJVdsOPdh7CLTrAdS0xwGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0783A1A32;
	Thu, 28 Aug 2025 08:57:20 -0700 (PDT)
Received: from [10.1.196.42] (eglon.cambridge.arm.com [10.1.196.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADBC03F694;
	Thu, 28 Aug 2025 08:57:17 -0700 (PDT)
Message-ID: <1914b7f0-10e6-4cf4-ad53-5ae03c69964d@arm.com>
Date: Thu, 28 Aug 2025 16:57:15 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/33] ACPI / PPTT: Stop acpi_count_levels() expecting
 callers to clear levels
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
 <20250822153048.2287-5-james.morse@arm.com>
 <aK7iyf/6iVOuVhTr@e133380.arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <aK7iyf/6iVOuVhTr@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dave,

On 27/08/2025 11:49, Dave Martin wrote:
> On Fri, Aug 22, 2025 at 03:29:45PM +0000, James Morse wrote:
>> acpi_count_levels() passes the number of levels back via a pointer argument.
>> It also passes this to acpi_find_cache_level() as the starting_level, and
>> preserves this value as it walks up the cpu_node tree counting the levels.
>>
>> This means the caller must initialise 'levels' due to acpi_count_levels()
>> internals. The only caller acpi_get_cache_info() happens to have already
>> initialised levels to zero, which acpi_count_levels() depends on to get the
>> correct result.
>>
>> Two results are passed back from acpi_count_levels(), unlike split_levels,
>> levels is not optional.
>>
>> Split these two results up. The mandatory 'levels' is always returned,
>> which hides the internal details from the caller, and avoids having
>> duplicated initialisation in all callers. split_levels remains an
>> optional argument passed back.
> 
> Nit: I found all this a bit hard to follow.
> 
> This seems to boil down to:
> 
> --8<--
> 
> In acpi_count_levels(), the initial value of *levels passed by the
> caller is really an implementation detail of acpi_count_levels(), so it
> is unreasonable to expect the callers of this function to know what to
> pass in for this parameter.  The only sensible initial value is 0,
> which is what the only upstream caller (acpi_get_cache_info()) passes.
> 
> Use a local variable for the starting cache level in acpi_count_levels(),
> and pass the result back to the caller via the function return value.
> 
> Gid rid of the levels parameter, which has no remaining purpose.
> 
> Fix acpi_get_cache_info() to match.
> 
> -->8--

I've taken this instead,


> split_levels is orthogonal to this refactoring (as evinced by the diff).
> I think mentioning it in the commit message at all may just add to the
> confusion...

>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index 4791ca2bdfac..8f9b9508acba 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -181,10 +181,10 @@ acpi_find_cache_level(struct acpi_table_header *table_hdr,
>>   * levels and split cache levels (data/instruction).
>>   * @table_hdr: Pointer to the head of the PPTT table
>>   * @cpu_node: processor node we wish to count caches for
>> - * @levels: Number of levels if success.
>>   * @split_levels:	Number of split cache levels (data/instruction) if
>> - *			success. Can by NULL.
>> + *			success. Can be NULL.
>>   *
>> + * Returns number of levels.
> 
> Nit: the prevailing convention in this file would be
> 
> 	Return: number of levels
> 
> (I don't know whether kerneldoc cares.)
> 
> Maybe also say "total number of levels" in place of "level", to make it
> clearer that the split levels (if any) are included in this count.

Sure,


>> @@ -731,7 +735,7 @@ int acpi_get_cache_info(unsigned int cpu, unsigned int *levels,
>>  	if (!cpu_node)
>>  		return -ENOENT;
>>  
>> -	acpi_count_levels(table, cpu_node, levels, split_levels);
>> +	*levels = acpi_count_levels(table, cpu_node, split_levels);
>>  
>>  	pr_debug("Cache Setup: last_level=%d split_levels=%d\n",
>>  		 *levels, split_levels ? *split_levels : -1);
> 
> Otherwise, looks reasonable to me.
> 
> (But see my comments on the next patches re whether we really need this.)

It was enough fun to debug that I'd like to save anyone else the trouble!



Thanks,

James

