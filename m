Return-Path: <linux-acpi+bounces-16103-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EA2B38040
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 12:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 968804E413D
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 10:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185093451CB;
	Wed, 27 Aug 2025 10:48:34 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A88C1C5496;
	Wed, 27 Aug 2025 10:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756291714; cv=none; b=AGO3iwC0Fc4jMnYkljAdJLlHiS0rouHAv/iGy+W5qwsEDEva1ajHcVjhkx6DMYgRDwlGJXqLJFaAGRmxw6g/soiU7Km1zLQUL8HA+ObIkIyjLjwFodxUN4X/I6epnWQV4NrRbk0YltX/mGDg0PvLvO/86A2laQcpzkF2yf5s2Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756291714; c=relaxed/simple;
	bh=/e1fvlVDPE+Xh6RjHgYEJrH51rA/hDJ7BqKp5gDX4u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B67g+QE2q3sp2aCGeqDw1CJ2f5oAkn+b82oaeAtKqOxqucB++cWPYuZHEqmOx+aJQdZyxuoBFnXk/x/mPdFGnVLVm0z+W58dXCveRA91pxZLJUjXVGCtilc4TaaGOyNvsCgZdaspFHeX4pt7dtJks3C4oP0LDzMtGCFD/YwDdp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6194C1688;
	Wed, 27 Aug 2025 03:48:23 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE6B23F738;
	Wed, 27 Aug 2025 03:48:25 -0700 (PDT)
Date: Wed, 27 Aug 2025 11:48:23 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: James Morse <james.morse@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>, Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
	baisheng.gao@unisoc.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
	Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 03/33] ACPI / PPTT: Add a helper to fill a cpumask from a
 processor container
Message-ID: <aK7id14+Spr2VIqR@e133380.arm.com>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-4-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822153048.2287-4-james.morse@arm.com>

Hi,

On Fri, Aug 22, 2025 at 03:29:44PM +0000, James Morse wrote:
> The PPTT describes CPUs and caches, as well as processor containers.
> The ACPI table for MPAM describes the set of CPUs that can access an MSC
> with the UID of a processor container.
> 
> Add a helper to find the processor container by its id, then walk
> the possible CPUs to fill a cpumask with the CPUs that have this
> processor container as a parent.

Nit: The motivation for the change is not clear here.

I guess this boils down to the need to map the MSC topology information
in the the ACPI MPAM table to a cpumask for each MSC.

If so, a possible rearrangement and rewording might be, say:

--8<--

The ACPI MPAM table uses the UID of a processor container specified in
the PPTT, to indicate the subset of CPUs and upstream cache topology
that can access each MPAM Memory System Component (MSC).

This information is not directly useful to the kernel.  The equivalent
cpumask is needed instead.

Add a helper to find the processor container by its id, then [...]

-->8--


> 
> CC: Dave Martin <dave.martin@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since RFC:
>  * Dropped has_leaf_flag dodging of acpi_pptt_leaf_node()
>  * Added missing : in kernel-doc
>  * Made helper return void as this never actually returns an error.
> ---
>  drivers/acpi/pptt.c  | 86 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h |  3 ++
>  2 files changed, 89 insertions(+)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 54676e3d82dd..4791ca2bdfac 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -298,6 +298,92 @@ static struct acpi_pptt_processor *acpi_find_processor_node(struct acpi_table_he
>  	return NULL;
>  }
>  
> +/**
> + * acpi_pptt_get_child_cpus() - Find all the CPUs below a PPTT processor node
> + * @table_hdr:		A reference to the PPTT table.
> + * @parent_node:	A pointer to the processor node in the @table_hdr.
> + * @cpus:		A cpumask to fill with the CPUs below @parent_node.
> + *
> + * Walks up the PPTT from every possible CPU to find if the provided
> + * @parent_node is a parent of this CPU.
> + */
> +static void acpi_pptt_get_child_cpus(struct acpi_table_header *table_hdr,
> +				     struct acpi_pptt_processor *parent_node,
> +				     cpumask_t *cpus)
> +{
> +	struct acpi_pptt_processor *cpu_node;
> +	u32 acpi_id;
> +	int cpu;
> +
> +	cpumask_clear(cpus);
> +
> +	for_each_possible_cpu(cpu) {
> +		acpi_id = get_acpi_id_for_cpu(cpu);

^ Presumably this can't fail?

> +		cpu_node = acpi_find_processor_node(table_hdr, acpi_id);
> +
> +		while (cpu_node) {
> +			if (cpu_node == parent_node) {
> +				cpumask_set_cpu(cpu, cpus);
> +				break;
> +			}
> +			cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);
> +		}
> +	}
> +}
> +
> +/**
> + * acpi_pptt_get_cpus_from_container() - Populate a cpumask with all CPUs in a
> + *                                       processor containers

Nit: "containers" -> "container" ?

> + * @acpi_cpu_id:	The UID of the processor container.
> + * @cpus:		The resulting CPU mask.
> + *
> + * Find the specified Processor Container, and fill @cpus with all the cpus
> + * below it.
> + *
> + * Not all 'Processor' entries in the PPTT are either a CPU or a Processor
> + * Container, they may exist purely to describe a Private resource. CPUs
> + * have to be leaves, so a Processor Container is a non-leaf that has the
> + * 'ACPI Processor ID valid' flag set.

(Revise this if dropping the leaf/non-leaf distinction -- see below.)

> + *
> + * Return: 0 for a complete walk, or an error if the mask is incomplete.
> + */
> +void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus)
> +{
> +	struct acpi_pptt_processor *cpu_node;
> +	struct acpi_table_header *table_hdr;
> +	struct acpi_subtable_header *entry;
> +	unsigned long table_end;
> +	acpi_status status;
> +	bool leaf_flag;
> +	u32 proc_sz;
> +
> +	cpumask_clear(cpus);
> +
> +	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table_hdr);
> +	if (ACPI_FAILURE(status))
> +		return;

Is acpi_get_pptt() applicable here?

(That function is not thread-safe, but then, perhaps most/all of these
functions are not thread safe.  If we are still on the boot CPU at this
point (?) then this wouldn't be a concern.)

> +
> +	table_end = (unsigned long)table_hdr + table_hdr->length;
> +	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
> +			     sizeof(struct acpi_table_pptt));
> +	proc_sz = sizeof(struct acpi_pptt_processor);
> +	while ((unsigned long)entry + proc_sz <= table_end) {

Ack that this matches the bounds check in functions that are already
present.

> +		cpu_node = (struct acpi_pptt_processor *)entry;
> +		if (entry->type == ACPI_PPTT_TYPE_PROCESSOR &&
> +		    cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID) {
> +			leaf_flag = acpi_pptt_leaf_node(table_hdr, cpu_node);
> +			if (!leaf_flag) {
> +				if (cpu_node->acpi_processor_id == acpi_cpu_id)

Is there any need to distinguish processor containers from (leaf) CPU
nodes, here?  If not, dropping the distinction might simplify the code
here (even if callers do not care).

Otherwise, maybe eliminate leaf_flag and collapse these into a single
if(), as suggested by Ben [1].

> +					acpi_pptt_get_child_cpus(table_hdr, cpu_node, cpus);

Can there ever be multiple matches?

The possibility of duplicate processor IDs in the PPTT sounds weird to
me, but then I'm not an ACPI expert.

If there can only be a single match, though, then we may as well break
out of the loop here, unless we want to be paranoid and report
duplicates as an error -- but that would require extra implementation,
so I'm not sure that would be worth it.

> +			}
> +		}
> +		entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry,
> +				     entry->length);
> +	}
> +
> +	acpi_put_table(table_hdr);
> +}

[...]


[1] Ben Horgan, Re: [PATCH 03/33] ACPI / PPTT: Add a helper to fill a cpumask from a processor container
https://lore.kernel.org/lkml/b032775e-1729-441a-8ec4-dd85f70055e8@arm.com/

Cheers
---Dave

