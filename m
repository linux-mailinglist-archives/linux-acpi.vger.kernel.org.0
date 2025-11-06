Return-Path: <linux-acpi+bounces-18594-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA58C3C523
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 17:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5BA842389A
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Nov 2025 16:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFE534D904;
	Thu,  6 Nov 2025 16:09:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4234030275E;
	Thu,  6 Nov 2025 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445378; cv=none; b=qLKXsQPZxJZ+fn3udyDnToSDit1Vtph4RNizV7l+M9usOKpH89naxmaRbB9KDALJJ90AhyqiPvx4wUxuBM6ADnlZBS2vFf6D1Z46aY7KAp0zIjU1+Vkq7ymROr2GdiPpH8NafX3+UVbQiKLkiewgcrUTMoQuebjKJQ9ru+Kofek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445378; c=relaxed/simple;
	bh=S6zbEzuNomUsyGRKAiNQkGjQeQzON+IIIZT3AMgJhFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQI+6cky1PbCbqqDkEOwQHW0slM1wgubv7YRMS7dXLDTP5dIzT/peiISMl1kTK6d+CFdV8kDnsnM5WXrvnh+Iu8f4RsSJooqVAdIH8hiHL1OiULhUUruxarbD/jKdUmFGERNfOrQifMMFY1jeX74qKq9H7g+E6joQpki3p+mxuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A750812FC;
	Thu,  6 Nov 2025 08:09:27 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA2FC3F66E;
	Thu,  6 Nov 2025 08:09:30 -0800 (PST)
Message-ID: <40b19590-d97c-472b-a577-0b637f6507ef@arm.com>
Date: Thu, 6 Nov 2025 16:09:29 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/29] ACPI / PPTT: Add a helper to fill a cpumask from
 a processor container
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
 <20251017185645.26604-2-james.morse@arm.com>
 <20251024122650.00001d00@huawei.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20251024122650.00001d00@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

Replying for James as he's busy and I've been tasked with posting the
next version of this series.

On 10/24/25 12:26, Jonathan Cameron wrote:
> On Fri, 17 Oct 2025 18:56:17 +0000
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
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
>> Signed-off-by: James Morse <james.morse@arm.com>
> Hi James,
> 
> V2 has dropped out of my memory more or less so to get this back in
> I'll do a fresh review (even of ones I've already given an RB on).
> Nothing here to change that tag. Just some naming / comment suggestions
> that I think would help a little with readability.
> 
> Some of these comments come from me forgetting how the spec named
> things and so going to take a look.  The spec isn't consistent with the
> naming (e.g. ACPI PROCESSOR ID is not necessarily a processor
> ID) but I think keeping closer to spec names will help readers. 
> 
> Note this may all be in the category of perfect being the enemy of
> good + upstream so I don't mind if you ignore.
> 
>> ---
>> Changes since v2:
>>  * Grouped two nested if clauses differently to reduce scope of cpu_node.
>>  * Removed stale comment refering to the return value.
>>
>> Changes since v1:
>>  * Replaced commit message with wording from Dave.
>>  * Fixed a stray plural.
>>  * Moved further down in the file to make use of get_pptt() helper.
>>  * Added a break to exit the loop early.
>>
>> Changes since RFC:
>>  * Removed leaf_flag local variable from acpi_pptt_get_cpus_from_container()
>>
>> Changes since RFC:
>>  * Dropped has_leaf_flag dodging of acpi_pptt_leaf_node()
>>  * Added missing : in kernel-doc
>>  * Made helper return void as this never actually returns an error.
>> ---
>>  drivers/acpi/pptt.c  | 82 ++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/acpi.h |  3 ++
>>  2 files changed, 85 insertions(+)
>>
>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index 54676e3d82dd..58cfa3916a13 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -817,3 +817,85 @@ int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>>  	return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
>>  					  ACPI_PPTT_ACPI_IDENTICAL);
>>  }
>> +
>> +/**
>> + * acpi_pptt_get_child_cpus() - Find all the CPUs below a PPTT processor node
> 
> The spec calls these Processor Hierarchy Node Structures. I think the
> addition of the Hierarchy word will help people understand this isn't
> finding things below a node specific to a processor but to some higher
> level hierarchy structure.

I've taken your suggestions around adding hierarchy in the comments but
for the variable and function names I've kept them as they are as adding
hierarchy in made them more unwieldy.

> 
>> + * @table_hdr:		A reference to the PPTT table.
>> + * @parent_node:	A pointer to the processor node in the @table_hdr.
> 
> Likewise, calling this a "processor hierarchy node" would make things
> clearer.
> 
>> + * @cpus:		A cpumask to fill with the CPUs below @parent_node.
>> + *
>> + * Walks up the PPTT from every possible CPU to find if the provided
>> + * @parent_node is a parent of this CPU.
>> + */
>> +static void acpi_pptt_get_child_cpus(struct acpi_table_header *table_hdr,
>> +				     struct acpi_pptt_processor *parent_node,
>> +				     cpumask_t *cpus)
>> +{
>> +	struct acpi_pptt_processor *cpu_node;
> 
> This is definitely a processor hierarchy node.  To my mind
> cpu_node doesn't convey this.  See below for more, but perhaps just renaming
> it to include hierarchy in the name would help.
> 
>> +	u32 acpi_id;
>> +	int cpu;
>> +
>> +	cpumask_clear(cpus);
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		acpi_id = get_acpi_id_for_cpu(cpu);
>> +		cpu_node = acpi_find_processor_node(table_hdr, acpi_id);
> 
> Here it is indeed a CPU.
> 
>> +
>> +		while (cpu_node) {
>> +			if (cpu_node == parent_node) {
>> +				cpumask_set_cpu(cpu, cpus);
>> +				break;
>> +			}
>> +			cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);
> 
> But here it is a processor container or a private node.  So
> cpu_hieriarchy_node or something along those lines would be more appropriate.
> 
>> +		}
>> +	}
>> +}
>> +
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
> 
> I'd go with 'Processor Hierarchy' here
>  
>> + * Container, they may exist purely to describe a Private resource. CPUs
>> + * have to be leaves, so a Processor Container is a non-leaf that has the
>> + * 'ACPI Processor ID valid' flag set.
>> + */
>> +void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus)
>> +{
>> +	struct acpi_table_header *table_hdr;
>> +	struct acpi_subtable_header *entry;
>> +	unsigned long table_end;
>> +	u32 proc_sz;
>> +
>> +	cpumask_clear(cpus);
>> +
>> +	table_hdr = acpi_get_pptt();
>> +	if (!table_hdr)
>> +		return;
>> +
>> +	table_end = (unsigned long)table_hdr + table_hdr->length;
>> +	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
>> +			     sizeof(struct acpi_table_pptt));
>> +	proc_sz = sizeof(struct acpi_pptt_processor);
>> +	while ((unsigned long)entry + proc_sz <= table_end) {
>> +
>> +		if (entry->type == ACPI_PPTT_TYPE_PROCESSOR) {
>> +			struct acpi_pptt_processor *cpu_node;
> similar naming thing here. 
>> +
>> +			cpu_node = (struct acpi_pptt_processor *)entry;
>> +			if (cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID &&
>> +			    !acpi_pptt_leaf_node(table_hdr, cpu_node) &&
>> +			    cpu_node->acpi_processor_id == acpi_cpu_id) {
>> +					acpi_pptt_get_child_cpus(table_hdr, cpu_node, cpus);
> The double tab indent here is odd.
> 			if (cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID &&
> 			    !acpi_pptt_leaf_node(table_hdr, cpu_node) &&
> 			    cpu_node->acpi_processor_id == acpi_cpu_id) {
> 				acpi_pptt_get_child_cpus(table_hdr, cpu_node, cpus);
> 
> Isn't find I think for readability.  I could understand the bonus tab if it was
> close to aligning with the line above but it isn't.

Indent fixed.

> 
>> +					break;
>> +			}
>> +		}
>> +		entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry,
>> +				     entry->length);
>> +	}
>> +}
> 
> 
> 

Thanks,

Ben


