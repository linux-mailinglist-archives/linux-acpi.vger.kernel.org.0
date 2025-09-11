Return-Path: <linux-acpi+bounces-16659-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E14A3B52ED9
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 12:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC92DA00FB1
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 10:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448F630F554;
	Thu, 11 Sep 2025 10:43:46 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E7130F54E;
	Thu, 11 Sep 2025 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757587426; cv=none; b=EZwwlGlOvUNo8wNMrr9ExeeTWz22bIwFuVF37Kv7GdLgeZnuY2Zw8Sq+tfEwYYPcjp7V23uo/rC41zJXYlduLQEQ/Exe/tVrsfP8uR0jVGqA9p80Gnx9KrILtaCtcu4ZiNOmcpsPSgZvV/m7Aa98X1U0IYBKr3GdmXd8KfPGuR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757587426; c=relaxed/simple;
	bh=4cjYNEq/0tkKAtFt1DgMEOaNIksXO5aYo797muokHU8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mksG5JozSiR32p+g8Ft7eLQ26D/RJYAIw8m17ebWyfJlXPxtjK4tvN88Ic9GA4rrHK5lcB04zLB2McQNckjIoy0vqn57/DIhb7FMRAmlXMr3yZzSH1f1ld/klznKOisen5sUb+agnjhY9R4nSi4VWO2b8MOT7mQfE1HhkI/pcrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cMvJc3Dk8z6L56v;
	Thu, 11 Sep 2025 18:42:24 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7BFCE1400D3;
	Thu, 11 Sep 2025 18:43:39 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 11 Sep
 2025 12:43:38 +0200
Date: Thu, 11 Sep 2025 11:43:37 +0100
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
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 01/29] ACPI / PPTT: Add a helper to fill a cpumask
 from a processor container
Message-ID: <20250911114337.0000487e@huawei.com>
In-Reply-To: <20250910204309.20751-2-james.morse@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
	<20250910204309.20751-2-james.morse@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 10 Sep 2025 20:42:41 +0000
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
> Signed-off-by: James Morse <james.morse@arm.com>

Hi James,

Sorry I missed v1.  Busy few weeks.

I think one resource leak plus a few suggested changes that
I'm not that bothered about.

Jonathan


> ---
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
>  drivers/acpi/pptt.c  | 83 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h |  3 ++
>  2 files changed, 86 insertions(+)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 54676e3d82dd..1728545d90b2 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -817,3 +817,86 @@ int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>  	return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
>  					  ACPI_PPTT_ACPI_IDENTICAL);
>  }

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
> + * Container, they may exist purely to describe a Private resource. CPUs
> + * have to be leaves, so a Processor Container is a non-leaf that has the
> + * 'ACPI Processor ID valid' flag set.
> + *
> + * Return: 0 for a complete walk, or an error if the mask is incomplete.
> + */
> +void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus)
> +{
> +	struct acpi_pptt_processor *cpu_node;
> +	struct acpi_table_header *table_hdr;
> +	struct acpi_subtable_header *entry;
> +	unsigned long table_end;
> +	u32 proc_sz;
> +
> +	cpumask_clear(cpus);
> +
> +	table_hdr = acpi_get_pptt();

This calls acpi_get_table() so you need to put it again or every call
to this leaks a reference count.  I messed around with DEFINE_FREE() for this
but it doesn't fit that well as the underlying call doesn't return the table.
This one does though so you could do a pptt specific one.  

Or just acpi_put_table(table_hdr); at exit path from this function.


> +	if (!table_hdr)
> +		return;
> +
> +	table_end = (unsigned long)table_hdr + table_hdr->length;
> +	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
> +			     sizeof(struct acpi_table_pptt));
Hmm. Not related to this patch but I have no idea why acpi_get_pptt()
doesn't return a struct acpi_table_pptt as if it did this would be a simple
+ 1 and not require those who only sometimes deal with ACPI code to go
check what that macro actually does!


> +	proc_sz = sizeof(struct acpi_pptt_processor);
Maybe sizeof (*cpu_node) is more helpful to reader.
Also shorter so you could do
	while ((unsigned long)entry + sizeof(*cpu_node) <= table_end)

> +	while ((unsigned long)entry + proc_sz <= table_end) {
> +		cpu_node = (struct acpi_pptt_processor *)entry;

For me, assigning this before checking the type is inelegant.
but the nesting does get deep without it so I guess this is ok maybe, though
I wonder if better reorganized to combine a different bunch of conditions.
I think this is functionally identival.

		if (entry->type == ACPI_PTT_TYPE_PROCESSOR) {
			struct acpi_pptt_processor *cpu_node = 
				(struct acpi_pptt_processor *)entry;
			if ((cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID) &&
			    (!acpi_pptt_leaf_node(table_hdr, cpu_node) &&
			    (cpu_node->acpi_processor_id == acpi_cpu_id)) {
				acpi_pptt_get_child_cpus(table_hdr, cpu_node, cpus);
				break;
		
			}
		}
		entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry,
				     entry->length);

More generally I wonder if it is worth adding a for_each_acpi_pptt_entry() macro.
There is some precedence in drivers acpi such as for_each_nhlt_endpoint()

That's probably material for another day though unless you think it brings
enough benefits to do it here.


> +		if (entry->type == ACPI_PPTT_TYPE_PROCESSOR &&
> +		    cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID) {
> +			if (!acpi_pptt_leaf_node(table_hdr, cpu_node)) {
> +				if (cpu_node->acpi_processor_id == acpi_cpu_id) {
> +					acpi_pptt_get_child_cpus(table_hdr, cpu_node, cpus);
> +					break;
> +				}
> +			}
> +		}
> +		entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry,
> +				     entry->length);
> +	}
> +}
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 1c5bb1e887cd..f97a9ff678cc 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1541,6 +1541,7 @@ int find_acpi_cpu_topology(unsigned int cpu, int level);
>  int find_acpi_cpu_topology_cluster(unsigned int cpu);
>  int find_acpi_cpu_topology_package(unsigned int cpu);
>  int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
> +void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus);
>  #else
>  static inline int acpi_pptt_cpu_is_thread(unsigned int cpu)
>  {
> @@ -1562,6 +1563,8 @@ static inline int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>  {
>  	return -EINVAL;
>  }
> +static inline void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id,
> +						     cpumask_t *cpus) { }
>  #endif
>  
>  void acpi_arch_init(void);


