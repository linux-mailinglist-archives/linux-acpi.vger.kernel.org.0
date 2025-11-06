Return-Path: <linux-acpi+bounces-18595-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5A1C3C572
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 17:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6193B956D
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Nov 2025 16:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F2834BA21;
	Thu,  6 Nov 2025 16:10:41 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34AF34D900;
	Thu,  6 Nov 2025 16:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445441; cv=none; b=j2xYjpVQxx3MktT8dAlcZ8sA43UsoCRcE03GYObfUXLX7iuP9fefKCmgwNlpb6C22SnYbpBOu+Waw2hwzHCABSkuNHJ9/MWJVUSlsZWEiWp+3TLs5yYGo65qOSbQkRYEIuXOcaGDBbJiQ6ycFv5skBGBwuxyJTOcqchUBEUtBn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445441; c=relaxed/simple;
	bh=0Z5E9gveLmOiBEAsV7z1dBjgZMRUNfMQkHgdXl2stHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UhyjErW8EYQeJEoVplL5tr2HMGhHFNVzboEOez311IvBh7yrh2Olu+k+99lBtf8U73rvbBJKO4SD0wDsVSbL5QtKgmRjK7Edlp6Y/0nCRpGz54+XpBbVknvO/d0iUd1Zw4cuzKOz5vFHp5wm1LioufJjdLnFVlOzbvbVURUrw3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9141215A1;
	Thu,  6 Nov 2025 08:10:31 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C71A93F66E;
	Thu,  6 Nov 2025 08:10:34 -0800 (PST)
Message-ID: <02f008a8-1bd6-4044-99f0-553d441d6d4b@arm.com>
Date: Thu, 6 Nov 2025 16:10:33 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/29] ACPI / PPTT: Stop acpi_count_levels() expecting
 callers to clear levels
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 James Morse <james.morse@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com, Rob Herring <robh@kernel.org>,
 Rohit Mathew <rohit.mathew@arm.com>, Rafael Wysocki <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
 Gavin Shan <gshan@redhat.com>
References: <20251017185645.26604-1-james.morse@arm.com>
 <20251017185645.26604-3-james.morse@arm.com>
 <20251024122921.000004bc@huawei.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20251024122921.000004bc@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 10/24/25 12:29, Jonathan Cameron wrote:
> On Fri, 17 Oct 2025 18:56:18 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> In acpi_count_levels(), the initial value of *levels passed by the
>> caller is really an implementation detail of acpi_count_levels(), so it
>> is unreasonable to expect the callers of this function to know what to
>> pass in for this parameter.  The only sensible initial value is 0,
>> which is what the only upstream caller (acpi_get_cache_info()) passes.
>>
>> Use a local variable for the starting cache level in acpi_count_levels(),
>> and pass the result back to the caller via the function return value.
>>
>> Get rid of the levels parameter, which has no remaining purpose.
>>
>> Fix acpi_get_cache_info() to match.
>>
>> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
>> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> 
> Another meh, the name is confusing type comment. 
> 
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
> Given it's not the starting level at this point... Maybe just call it level or current_level.

Makes sense. I've made this update.

>>  }
>>  
>>  /**
>> @@ -645,7 +649,7 @@ int acpi_get_cache_info(unsigned int cpu, unsigned int *levels,
>>  	if (!cpu_node)
>>  		return -ENOENT;
>>  
>> -	acpi_count_levels(table, cpu_node, levels, split_levels);
>> +	*levels = acpi_count_levels(table, cpu_node, split_levels);
>>  
>>  	pr_debug("Cache Setup: last_level=%d split_levels=%d\n",
>>  		 *levels, split_levels ? *split_levels : -1);
> 
> 

Thanks,

Ben


