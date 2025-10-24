Return-Path: <linux-acpi+bounces-18180-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80678C0607F
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 13:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4309740043B
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 11:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC40310645;
	Fri, 24 Oct 2025 11:27:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8BB311C15;
	Fri, 24 Oct 2025 11:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761305220; cv=none; b=YNOpzoGKmzEzzvo+5PmoxAutIoeL8sxihv8uB3etKKJ0P5OI67NUU+9/98W2TWV8rmFn9zN+5scsMaQFwRX+mfmVYG/g0vA4azphndb7j1kmaq99w1Sd2X7CPwSCe7xSXCEDkqrWvCvvq66FNsLnO8eYzTEhKHQDu9OBeq1PS6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761305220; c=relaxed/simple;
	bh=FozJRigAt9GNgDf3wCedx0N7bhzM+DJ3Sw/23sM5948=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nUHCkI+MZprbgOsCPTpWpH4pb4w2b8Nc6VhGgZx/Tu6rUBFPazd1RdeyTLdAQ023uVcThiID0ezMqI2AGrxlP2Lfx+zdIHLYZCb3dW0a0f9Lz15RnR+nqLrMJ18k3HFlIGgR73u3GlNWoTuOmfxma17FYB2hvTUgWfLsBwZLwt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ctL9p53H7z6M4Zy;
	Fri, 24 Oct 2025 19:23:10 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id A885A14020C;
	Fri, 24 Oct 2025 19:26:53 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 24 Oct
 2025 12:26:52 +0100
Date: Fri, 24 Oct 2025 12:26:50 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: James Morse <james.morse@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>, Koba
 Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
	<fenghuay@nvidia.com>, <baisheng.gao@unisoc.com>, Rob Herring
	<robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>, "Rafael Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla
	<sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
	Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 01/29] ACPI / PPTT: Add a helper to fill a cpumask
 from a processor container
Message-ID: <20251024122650.00001d00@huawei.com>
In-Reply-To: <20251017185645.26604-2-james.morse@arm.com>
References: <20251017185645.26604-1-james.morse@arm.com>
	<20251017185645.26604-2-james.morse@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 17 Oct 2025 18:56:17 +0000
James Morse <james.morse@arm.com> wrote:

> The ACPI MPAM table uses the UID of a processor container specified in
> the PPTT to indicate the subset of CPUs and cache topology that can
> access each MPAM System Component (MSC).
> 
> This information is not directly useful to the kernel. The equivalent
> cpumask is needed instead.
> 
> Add a helper to find the processor container by its id, then walk
> the possible CPUs to fill a cpumask with the CPUs that have this
> processor container as a parent.
> 
> CC: Dave Martin <dave.martin@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Signed-off-by: James Morse <james.morse@arm.com>
Hi James,

V2 has dropped out of my memory more or less so to get this back in
I'll do a fresh review (even of ones I've already given an RB on).
Nothing here to change that tag. Just some naming / comment suggestions
that I think would help a little with readability.

Some of these comments come from me forgetting how the spec named
things and so going to take a look.  The spec isn't consistent with the
naming (e.g. ACPI PROCESSOR ID is not necessarily a processor
ID) but I think keeping closer to spec names will help readers. 

Note this may all be in the category of perfect being the enemy of
good + upstream so I don't mind if you ignore.

> ---
> Changes since v2:
>  * Grouped two nested if clauses differently to reduce scope of cpu_node.
>  * Removed stale comment refering to the return value.
> 
> Changes since v1:
>  * Replaced commit message with wording from Dave.
>  * Fixed a stray plural.
>  * Moved further down in the file to make use of get_pptt() helper.
>  * Added a break to exit the loop early.
> 
> Changes since RFC:
>  * Removed leaf_flag local variable from acpi_pptt_get_cpus_from_container()
> 
> Changes since RFC:
>  * Dropped has_leaf_flag dodging of acpi_pptt_leaf_node()
>  * Added missing : in kernel-doc
>  * Made helper return void as this never actually returns an error.
> ---
>  drivers/acpi/pptt.c  | 82 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h |  3 ++
>  2 files changed, 85 insertions(+)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 54676e3d82dd..58cfa3916a13 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -817,3 +817,85 @@ int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>  	return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
>  					  ACPI_PPTT_ACPI_IDENTICAL);
>  }
> +
> +/**
> + * acpi_pptt_get_child_cpus() - Find all the CPUs below a PPTT processor node

The spec calls these Processor Hierarchy Node Structures. I think the
addition of the Hierarchy word will help people understand this isn't
finding things below a node specific to a processor but to some higher
level hierarchy structure.

> + * @table_hdr:		A reference to the PPTT table.
> + * @parent_node:	A pointer to the processor node in the @table_hdr.

Likewise, calling this a "processor hierarchy node" would make things
clearer.

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

This is definitely a processor hierarchy node.  To my mind
cpu_node doesn't convey this.  See below for more, but perhaps just renaming
it to include hierarchy in the name would help.

> +	u32 acpi_id;
> +	int cpu;
> +
> +	cpumask_clear(cpus);
> +
> +	for_each_possible_cpu(cpu) {
> +		acpi_id = get_acpi_id_for_cpu(cpu);
> +		cpu_node = acpi_find_processor_node(table_hdr, acpi_id);

Here it is indeed a CPU.

> +
> +		while (cpu_node) {
> +			if (cpu_node == parent_node) {
> +				cpumask_set_cpu(cpu, cpus);
> +				break;
> +			}
> +			cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);

But here it is a processor container or a private node.  So
cpu_hieriarchy_node or something along those lines would be more appropriate.

> +		}
> +	}
> +}
> +
> +/**
> + * acpi_pptt_get_cpus_from_container() - Populate a cpumask with all CPUs in a
> + *                                       processor container
> + * @acpi_cpu_id:	The UID of the processor container.
> + * @cpus:		The resulting CPU mask.
> + *
> + * Find the specified Processor Container, and fill @cpus with all the cpus
> + * below it.
> + *
> + * Not all 'Processor' entries in the PPTT are either a CPU or a Processor

I'd go with 'Processor Hierarchy' here
 
> + * Container, they may exist purely to describe a Private resource. CPUs
> + * have to be leaves, so a Processor Container is a non-leaf that has the
> + * 'ACPI Processor ID valid' flag set.
> + */
> +void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus)
> +{
> +	struct acpi_table_header *table_hdr;
> +	struct acpi_subtable_header *entry;
> +	unsigned long table_end;
> +	u32 proc_sz;
> +
> +	cpumask_clear(cpus);
> +
> +	table_hdr = acpi_get_pptt();
> +	if (!table_hdr)
> +		return;
> +
> +	table_end = (unsigned long)table_hdr + table_hdr->length;
> +	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
> +			     sizeof(struct acpi_table_pptt));
> +	proc_sz = sizeof(struct acpi_pptt_processor);
> +	while ((unsigned long)entry + proc_sz <= table_end) {
> +
> +		if (entry->type == ACPI_PPTT_TYPE_PROCESSOR) {
> +			struct acpi_pptt_processor *cpu_node;
similar naming thing here. 
> +
> +			cpu_node = (struct acpi_pptt_processor *)entry;
> +			if (cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID &&
> +			    !acpi_pptt_leaf_node(table_hdr, cpu_node) &&
> +			    cpu_node->acpi_processor_id == acpi_cpu_id) {
> +					acpi_pptt_get_child_cpus(table_hdr, cpu_node, cpus);
The double tab indent here is odd.
			if (cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID &&
			    !acpi_pptt_leaf_node(table_hdr, cpu_node) &&
			    cpu_node->acpi_processor_id == acpi_cpu_id) {
				acpi_pptt_get_child_cpus(table_hdr, cpu_node, cpus);

Isn't find I think for readability.  I could understand the bonus tab if it was
close to aligning with the line above but it isn't.

> +					break;
> +			}
> +		}
> +		entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry,
> +				     entry->length);
> +	}
> +}



