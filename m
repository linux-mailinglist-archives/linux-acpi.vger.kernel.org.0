Return-Path: <linux-acpi+bounces-18803-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE01CC519EA
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 11:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854BD3A480D
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 10:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463812FFDC4;
	Wed, 12 Nov 2025 10:14:14 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6D2280025;
	Wed, 12 Nov 2025 10:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942454; cv=none; b=Oj4ZK/8IiNQyXX/8MHbszy0vLZiyJ8+yfK7Kv3MJxJWB33R8puU1m+EDj54A/XMFhY/OXMd8XZ7WM4bX4h9UqR5IOYDnnhyrGy2NnM6L6N9OYpj9Q8Z6f7E65OQMcg6YQbiHlmaBfDsZHjkJ8RmiPvY0nEAwgsZk5vumP3UoJUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942454; c=relaxed/simple;
	bh=OhqdizDqUMSv1sLBX1ZxZKWQ0KFBOMmKlbnG45xQFpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u740aD3Zs72jwsaDBdxIgI9yadDkSosdnuNMpgU+UZCuGMyDgWfckdHZhX2MJZzLp7JG6yREUuZzAvmF960Ip8oOrea2yBh1glX0EvudIfhjNnz/+KjFE4vvbG/OBb8O5SbdzqGBCuqpq0WYauLRHtzq2+znKg7yErfkX4u4MEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10E9C1515;
	Wed, 12 Nov 2025 02:14:03 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C5DC3F5A1;
	Wed, 12 Nov 2025 02:14:05 -0800 (PST)
Message-ID: <ba2d4852-dd38-4d98-96fe-2716875ff199@arm.com>
Date: Wed, 12 Nov 2025 10:14:04 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/33] ACPI / PPTT: Add a helper to fill a cpumask from a
 processor container
To: Gavin Shan <gshan@redhat.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-2-ben.horgan@arm.com>
 <11f80800-2e0b-4f41-a022-a88ad9792da8@redhat.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <11f80800-2e0b-4f41-a022-a88ad9792da8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Gavin,

On 11/8/25 04:31, Gavin Shan wrote:
> Hi Ben,
> 
> On 11/7/25 10:34 PM, Ben Horgan wrote:
>> From: James Morse <james.morse@arm.com>
>>
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
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
>> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
>> Tested-by: Peter Newman <peternewman@google.com>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
>> ---
>> Changes since v3:
>> Refer to processor hierarchy in comments (Jonathan)
>> Fix indent (Jonathan)
>> ---
>>   drivers/acpi/pptt.c  | 85 ++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/acpi.h |  3 ++
>>   2 files changed, 88 insertions(+)
>>
> 
> Two nitpicks below...
> 
>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index 54676e3d82dd..69917cc6bd2f 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -817,3 +817,88 @@ int find_acpi_cpu_topology_hetero_id(unsigned int
>> cpu)
>>       return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
>>                         ACPI_PPTT_ACPI_IDENTICAL);
>>   }
>> +
>> +/**
>> + * acpi_pptt_get_child_cpus() - Find all the CPUs below a PPTT
>> + * processor hierarchy node
>> + *
>> + * @table_hdr:        A reference to the PPTT table
>> + * @parent_node:    A pointer to the processor hierarchy node in the
>> + *            table_hdr
>> + * @cpus:        A cpumask to fill with the CPUs below @parent_node
>> + *
>> + * Walks up the PPTT from every possible CPU to find if the provided
>> + * @parent_node is a parent of this CPU.
>> + */
>> +static void acpi_pptt_get_child_cpus(struct acpi_table_header
>> *table_hdr,
>> +                     struct acpi_pptt_processor *parent_node,
>> +                     cpumask_t *cpus)
>> +{
>> +    struct acpi_pptt_processor *cpu_node;
>> +    u32 acpi_id;
>> +    int cpu;
>> +
>> +    cpumask_clear(cpus);
>> +
>> +    for_each_possible_cpu(cpu) {
>> +        acpi_id = get_acpi_id_for_cpu(cpu);
>> +        cpu_node = acpi_find_processor_node(table_hdr, acpi_id);
>> +
>> +        while (cpu_node) {
>> +            if (cpu_node == parent_node) {
>> +                cpumask_set_cpu(cpu, cpus);
>> +                break;
>> +            }
>> +            cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);
>> +        }
>> +    }
>> +}
>> +
>> +/**
>> + * acpi_pptt_get_cpus_from_container() - Populate a cpumask with all
>> CPUs in a
>> + *                                       processor container
>> + * @acpi_cpu_id:    The UID of the processor container
>> + * @cpus:        The resulting CPU mask
>> + *
>> + * Find the specified Processor Container, and fill @cpus with all
>> the cpus
>> + * below it.
>> + *
>> + * Not all 'Processor Hierarchy' entries in the PPTT are either a CPU
>> + * or a Processor Container, they may exist purely to describe a
>> + * Private resource. CPUs have to be leaves, so a Processor Container
>> + * is a non-leaf that has the 'ACPI Processor ID valid' flag set.
>> + */
>> +void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus)
>> +{
>> +    struct acpi_table_header *table_hdr;
>> +    struct acpi_subtable_header *entry;
>> +    unsigned long table_end;
>> +    u32 proc_sz;
>> +
>> +    cpumask_clear(cpus);
>> +
>> +    table_hdr = acpi_get_pptt();
>> +    if (!table_hdr)
>> +        return;
>> +
>> +    table_end = (unsigned long)table_hdr + table_hdr->length;
>> +    entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
>> +                 sizeof(struct acpi_table_pptt));
>> +    proc_sz = sizeof(struct acpi_pptt_processor);
>> +    while ((unsigned long)entry + proc_sz <= table_end) {
>> +
> 
> Unnecessary blank line here.

Ack

> 
>> +        if (entry->type == ACPI_PPTT_TYPE_PROCESSOR) {
>> +            struct acpi_pptt_processor *cpu_node;
>> +
>> +            cpu_node = (struct acpi_pptt_processor *)entry;
>> +            if (cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID &&
>> +                !acpi_pptt_leaf_node(table_hdr, cpu_node) &&
>> +                cpu_node->acpi_processor_id == acpi_cpu_id) {
>> +                acpi_pptt_get_child_cpus(table_hdr, cpu_node, cpus);
>> +                break;
>> +            }
>> +        }
>> +        entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry,
>> +                     entry->length);
> 
> Need we to check if @cpu_node does crosses the boundary (@table_end), as
> what's
> doing in acpi_find_processor_node()? Actually, the similar hunk of code
> from
> the function can be reused here.

As acpi_find_processor_node() is called from acpi_pptt_get_child_cpus()
I don't think we need to duplicate the checking here.

> 
> static struct acpi_pptt_processor *acpi_find_processor_node(struct
> acpi_table_header *table_hdr,
>                                                             u32
> acpi_cpu_id)
> {
>         :
>     while ((unsigned long)entry + proc_sz <= table_end) {
>                 cpu_node = (struct acpi_pptt_processor *)entry;
> 
>                 if (entry->length == 0) {
>                         pr_warn("Invalid zero length subtable\n");
>                         break;
>                 }
> 
>                 /* entry->length may not equal proc_sz, revalidate the
> processor structure length */
>                 if (entry->type == ACPI_PPTT_TYPE_PROCESSOR &&
>                     acpi_cpu_id == cpu_node->acpi_processor_id &&
>                     (unsigned long)entry + entry->length <= table_end &&
>                     entry->length == proc_sz + cpu_node-
>>number_of_priv_resources * sizeof(u32) &&
>                      acpi_pptt_leaf_node(table_hdr, cpu_node)) {
>                         return (struct acpi_pptt_processor *)entry;
>                 }
> 
>                 entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry,
>                                      entry->length);
>     }
> 
>         :
> }
> 
> 
>> +    }
>> +}
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 5ff5d99f6ead..4752ebd48132 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -1541,6 +1541,7 @@ int find_acpi_cpu_topology(unsigned int cpu, int
>> level);
>>   int find_acpi_cpu_topology_cluster(unsigned int cpu);
>>   int find_acpi_cpu_topology_package(unsigned int cpu);
>>   int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
>> +void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t
>> *cpus);
>>   #else
>>   static inline int acpi_pptt_cpu_is_thread(unsigned int cpu)
>>   {
>> @@ -1562,6 +1563,8 @@ static inline int
>> find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>>   {
>>       return -EINVAL;
>>   }
>> +static inline void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id,
>> +                             cpumask_t *cpus) { }
>>   #endif
>>     void acpi_arch_init(void);
> 
> Thanks,
> Gavin
> 

Thanks,

Ben


