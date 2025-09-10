Return-Path: <linux-acpi+bounces-16599-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 040D9B520CB
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 21:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DA271889CC9
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 19:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86B42D7DE3;
	Wed, 10 Sep 2025 19:19:49 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B642D5940;
	Wed, 10 Sep 2025 19:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757531989; cv=none; b=LrG64DqikG0sX1u83b/l0Asbona3gpJxFWGfl9Ab4KJV7oPuQzIRz7j4tjsdgtKX1pucCQqKgfwokgs1QMKonEa2ooG72rWH16Ku9gy8VVRwDZd7OCOuNMvT17kcluFAo213JnJrxwdLH1YC4JcGgezH9tN2G0VF6dKBb6JoG+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757531989; c=relaxed/simple;
	bh=WX9HDPTynEUG3jAUp9RlpgfokE8e6KfyzC5oTnFW1hM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U48OflSYHfdT/KUNN5MYoU5De5Aqac3mCUnuZpXX5ch3wnhS3gSabMPx07YACGnCHkzKyWrTsU0WTvmqd1ocYu/BD4O23S+XDGwOyJGToaJZDpVD7eI2eu4KnEFMsZUpgq4CrWswSvHQcNLevYq3vF9LqKaIDKy/Jzgcxe+rwvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBEDE16F2;
	Wed, 10 Sep 2025 12:19:38 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99F3B3F694;
	Wed, 10 Sep 2025 12:19:41 -0700 (PDT)
Message-ID: <e7853d6a-59f4-4d12-b290-c194258eda2d@arm.com>
Date: Wed, 10 Sep 2025 20:19:41 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/33] ACPI / PPTT: Stop acpi_count_levels() expecting
 callers to clear levels
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
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
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-39-james.morse@arm.com> <aMGAw4+/IAWBPiqn@lpieralisi>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <aMGAw4+/IAWBPiqn@lpieralisi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Lorenzo,

On 10/09/2025 14:44, Lorenzo Pieralisi wrote:
> On Fri, Aug 22, 2025 at 03:30:19PM +0000, James Morse wrote:
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
> 
> Nit: tempting but this change does not belong here.

Clearly a much loved typo!


>> @@ -192,14 +192,18 @@ acpi_find_cache_level(struct acpi_table_header *table_hdr,
>>   * split cache levels (data/instruction) that exist at each level on the way
>>   * up.
>>   */
>> -static void acpi_count_levels(struct acpi_table_header *table_hdr,
>> -			      struct acpi_pptt_processor *cpu_node,
>> -			      unsigned int *levels, unsigned int *split_levels)
>> +static int acpi_count_levels(struct acpi_table_header *table_hdr,
>> +			     struct acpi_pptt_processor *cpu_node,
>> +			     unsigned int *split_levels)
>>  {
>> +	int starting_level = 0;
>> +
>>  	do {
>> -		acpi_find_cache_level(table_hdr, cpu_node, levels, split_levels, 0, 0);
>> +		acpi_find_cache_level(table_hdr, cpu_node, &starting_level, split_levels, 0, 0);
>>  		cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);
>>  	} while (cpu_node);
>> +
>> +	return starting_level;
>>  }
>>  
>>  /**
>> @@ -731,7 +735,7 @@ int acpi_get_cache_info(unsigned int cpu, unsigned int *levels,
>>  	if (!cpu_node)
>>  		return -ENOENT;
>>  
>> -	acpi_count_levels(table, cpu_node, levels, split_levels);
>> +	*levels = acpi_count_levels(table, cpu_node, split_levels);

> Looks fine to me - though initializing
> 
> *levels = 0
> 
> upper in the function now becomes superfluous (?) (well, it initializes
> *levels to 0 if an error path is hit but on that case the caller should
> not expect *levels to be initialized to anything IIUC).

Maybe, but its the least surprising thing to do - hence the existing early clobber.


> Apart from these (very) minor things:
> 
> Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>


Thanks!

James

