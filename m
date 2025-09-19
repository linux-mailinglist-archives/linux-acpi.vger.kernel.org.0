Return-Path: <linux-acpi+bounces-17135-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA56CB8A829
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Sep 2025 18:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F0C166D83
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Sep 2025 16:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E0A31D37A;
	Fri, 19 Sep 2025 16:10:37 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCDF23C4F3;
	Fri, 19 Sep 2025 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758298237; cv=none; b=lME7bk5gcJEdSb3sLKfQcdTnx6kdWJbSZEFSzKtC/m+17iMcreQrbIhHUYBsSI97U8vYWE/SdvqnsVpxE0k3fV4zFVZY5nXJHM6+G1364u6Kq7+XWJ22T9b9j3hGMRtFNYwNp14+SF2776f0dBCRTZhCMDB38eW3f1YDwF8A/I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758298237; c=relaxed/simple;
	bh=sd6TB+nVjeIrvFsDkzOC+ASaFSRx3idy26nLorE2dPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ik+4xdLn1qJiNrFxh+5/9en5YgnaLtL5AfcJMKRttu6yj5f0u75SGYa5ITRhBKY0N2NLL9o/f/2N5wTRuBp5S0z2YYhivcCwdFXwnW10b9yjfjCp32KmyRQ5unQg798y6ZK2RRuj6zDACBUO0bwQYTFqM6fysxwAC2eyKZFePHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AE5E169C;
	Fri, 19 Sep 2025 09:10:24 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 570503F66E;
	Fri, 19 Sep 2025 09:10:27 -0700 (PDT)
Message-ID: <4f523696-54ab-427d-974a-3c5ffb865fed@arm.com>
Date: Fri, 19 Sep 2025 17:10:25 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/29] ACPI / PPTT: Add a helper to fill a cpumask from
 a processor container
To: Jonathan Cameron <jonathan.cameron@huawei.com>
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
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-2-james.morse@arm.com>
 <20250911114337.0000487e@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250911114337.0000487e@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 11/09/2025 11:43, Jonathan Cameron wrote:
> On Wed, 10 Sep 2025 20:42:41 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> The ACPI MPAM table uses the UID of a processor container specified in
>> the PPTT to indicate the subset of CPUs and cache topology that can
>> access each MPAM System Component (MSC).
>>
>> This information is not directly useful to the kernel. The equivalent
>> cpumask is needed instead.
>>
>> Add a helper to find the processor container by its id, then walk
>> the possible CPUs to fill a cpumask with the CPUs that have this
>> processor container as a parent.
>>
>> CC: Dave Martin <dave.martin@arm.com>
>> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>> Signed-off-by: James Morse <james.morse@arm.com>
> 
> Hi James,
> 
> Sorry I missed v1.  Busy few weeks.
> 
> I think one resource leak plus a few suggested changes that
> I'm not that bothered about.



>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index 54676e3d82dd..1728545d90b2 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -817,3 +817,86 @@ int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>>  	return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
>>  					  ACPI_PPTT_ACPI_IDENTICAL);
>>  }
> 
>> +/**
>> + * acpi_pptt_get_cpus_from_container() - Populate a cpumask with all CPUs in a
>> + *                                       processor container
>> + * @acpi_cpu_id:	The UID of the processor container.
>> + * @cpus:		The resulting CPU mask.
>> + *
>> + * Find the specified Processor Container, and fill @cpus with all the cpus
>> + * below it.
>> + *
>> + * Not all 'Processor' entries in the PPTT are either a CPU or a Processor
>> + * Container, they may exist purely to describe a Private resource. CPUs
>> + * have to be leaves, so a Processor Container is a non-leaf that has the
>> + * 'ACPI Processor ID valid' flag set.
>> + *
>> + * Return: 0 for a complete walk, or an error if the mask is incomplete.
>> + */
>> +void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus)
>> +{
>> +	struct acpi_pptt_processor *cpu_node;
>> +	struct acpi_table_header *table_hdr;
>> +	struct acpi_subtable_header *entry;
>> +	unsigned long table_end;
>> +	u32 proc_sz;
>> +
>> +	cpumask_clear(cpus);
>> +
>> +	table_hdr = acpi_get_pptt();
> 
> This calls acpi_get_table() so you need to put it again or every call
> to this leaks a reference count.  I messed around with DEFINE_FREE() for this
> but it doesn't fit that well as the underlying call doesn't return the table.
> This one does though so you could do a pptt specific one.  
> 
> Or just acpi_put_table(table_hdr); at exit path from this function.

This is a strange one - you spotted it on your follow up email.


>> +	if (!table_hdr)
>> +		return;
>> +
>> +	table_end = (unsigned long)table_hdr + table_hdr->length;
>> +	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
>> +			     sizeof(struct acpi_table_pptt));

> Hmm. Not related to this patch but I have no idea why acpi_get_pptt()
> doesn't return a struct acpi_table_pptt as if it did this would be a simple
> + 1 and not require those who only sometimes deal with ACPI code to go
> check what that macro actually does!

Looks like that would have a knock on effect for the types in:
| topology_get_acpi_cpu_tag()
| acpi_find_processor_node()
| cache_setup_acpi_cpu()
| fetch_pptt_node()

... basically everywhere this file uses struct acpi_table_header...

It's simpler to cast it here if you're keen on the '+1' approach, but this pattern is how
this file does this. This is the same as acpi_pptt_leaf_node().


>> +	proc_sz = sizeof(struct acpi_pptt_processor);


> Maybe sizeof (*cpu_node) is more helpful to reader.

(again, same as acpi_pptt_leaf_node())


> Also shorter so you could do
> 	while ((unsigned long)entry + sizeof(*cpu_node) <= table_end)
> 
>> +	while ((unsigned long)entry + proc_sz <= table_end) {
>> +		cpu_node = (struct acpi_pptt_processor *)entry;
> 
> For me, assigning this before checking the type is inelegant.

I agree, but when in pptt.c ...


> but the nesting does get deep without it so I guess this is ok maybe, though
> I wonder if better reorganized to combine a different bunch of conditions.
> I think this is functionally identival.
> 
> 		if (entry->type == ACPI_PTT_TYPE_PROCESSOR) {
> 			struct acpi_pptt_processor *cpu_node = 
> 				(struct acpi_pptt_processor *)entry;
> 			if ((cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID) &&
> 			    (!acpi_pptt_leaf_node(table_hdr, cpu_node) &&
> 			    (cpu_node->acpi_processor_id == acpi_cpu_id)) {
> 				acpi_pptt_get_child_cpus(table_hdr, cpu_node, cpus);
> 				break;
> 		
> 			}
> 		}
> 		entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry,
> 				     entry->length);

It is the same - I think this is better as it reduces the scope of cpu_node.


> More generally I wonder if it is worth adding a for_each_acpi_pptt_entry() macro.
> There is some precedence in drivers acpi such as for_each_nhlt_endpoint()

When this series had support for ACPI PPI-Partitions there were more PPTT helpers and I
had a function pointer based call_on_every_entry() kind of thing. Jeremy L though it
obscured the flow. A custom for_each_ is probably better.

I may float it as an RFC after these are done. I don't want to make this series any
bigger. It certainly makes the users easier on the eye.
| drivers/acpi/pptt.c | 43 +++++++++++++++----------------------------
| 1 file changed, 15 insertions(+), 28 deletions(-)

Stashed here for posterity:
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?h=pptt/for_each_pptt_entry/v0&id=353ceeba3d39c6b6a10eeb1a59c49649cdf719d8


> That's probably material for another day though unless you think it brings
> enough benefits to do it here.
> 
> 
>> +		if (entry->type == ACPI_PPTT_TYPE_PROCESSOR &&
>> +		    cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID) {
>> +			if (!acpi_pptt_leaf_node(table_hdr, cpu_node)) {
>> +				if (cpu_node->acpi_processor_id == acpi_cpu_id) {
>> +					acpi_pptt_get_child_cpus(table_hdr, cpu_node, cpus);
>> +					break;
>> +				}
>> +			}
>> +		}
>> +		entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry,
>> +				     entry->length);
>> +	}
>> +}
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 1c5bb1e887cd..f97a9ff678cc 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -1541,6 +1541,7 @@ int find_acpi_cpu_topology(unsigned int cpu, int level);
>>  int find_acpi_cpu_topology_cluster(unsigned int cpu);
>>  int find_acpi_cpu_topology_package(unsigned int cpu);
>>  int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
>> +void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus);
>>  #else
>>  static inline int acpi_pptt_cpu_is_thread(unsigned int cpu)
>>  {
>> @@ -1562,6 +1563,8 @@ static inline int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>>  {
>>  	return -EINVAL;
>>  }
>> +static inline void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id,
>> +						     cpumask_t *cpus) { }
>>  #endif
>>  
>>  void acpi_arch_init(void);
> 


