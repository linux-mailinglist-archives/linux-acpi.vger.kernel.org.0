Return-Path: <linux-acpi+bounces-14701-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D98E0AEA42C
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 19:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C39D1C44DB3
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 17:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049E72ED84F;
	Thu, 26 Jun 2025 17:11:04 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3512E175E
	for <linux-acpi@vger.kernel.org>; Thu, 26 Jun 2025 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750957863; cv=none; b=jh0nelOE88ubYGGDRcfZbUj0tFOXusJCmUZbk7ovh+FMIiEpIkufxxCrJvRI3ZLjSfkIQheQzzQGrzx3fcaUwyPoo6bUaj4mK51uOQ7IoBqjB5mP7DNJ7u/Ii2iAAernRMEhUt0WIzSYUFe0M2a27crXfAveVPqLkYxVpcwkJ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750957863; c=relaxed/simple;
	bh=GTHCDg10NkCrXnbYrkMEXqEPFTmHMkSB5GlKM6np4iE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CL/qTAgzvd11PWqgQdYZlQCc3Mci+QRoJLGDUbnW7abr6k8qHFz+jR5kkVlRAXwL4WkOsD8kI0YlWMz3n/7MLAbWe+XedvhPSrkN03kNL0N0suifsLpuLpvUEkEHy0FMNqINmsYVXY502eHTf/jVBugDHI/UUklMQE6HOqXiY5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 996571758;
	Thu, 26 Jun 2025 10:10:43 -0700 (PDT)
Received: from [10.1.197.43] (eglon.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4325F3F762;
	Thu, 26 Jun 2025 10:11:00 -0700 (PDT)
Message-ID: <e53ee224-1a95-4217-b2dc-8281b12063a4@arm.com>
Date: Thu, 26 Jun 2025 18:10:58 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ACPI / PPTT: Add a helper to fill a cpumask from a
 processor container
To: linux-acpi@vger.kernel.org
Cc: Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 sudeep.holla@arm.com, jeremy.linton@arm.com,
 Dave P Martin <Dave.Martin@arm.com>
References: <20250612171336.4858-1-james.morse@arm.com>
 <20250612171336.4858-2-james.morse@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250612171336.4858-2-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello!

(CC: +Dave Martin)

On 12/06/2025 18:13, James Morse wrote:
> The PPTT describes CPUs and caches, as well as processor containers.
> The ACPI table for MPAM describes the set of CPUs that can access an MSC
> with the UID of a processor container.
> 
> Add a helper to find the processor container by its id, then walk
> the possible CPUs to fill a cpumask with the CPUs that have this
> processor container as a parent.

> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 54676e3d82dd..aaf9b5a26d07 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -298,6 +298,97 @@ static struct acpi_pptt_processor *acpi_find_processor_node(struct acpi_table_he

> +/**
> + * acpi_pptt_get_cpus_from_container() - Populate a cpumask with all CPUs in a
> + *                                       processor containers
> + * @acpi_cpu_id:	The UID of the processor container.
> + * @cpus		The resulting CPU mask.
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
> +int acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus)
> +{
> +	struct acpi_pptt_processor *cpu_node;
> +	struct acpi_table_header *table_hdr;
> +	struct acpi_subtable_header *entry;
> +	bool leaf_flag, has_leaf_flag = false;
> +	unsigned long table_end;
> +	acpi_status status;
> +	u32 proc_sz;
> +	int ret = 0;
> +
> +	cpumask_clear(cpus);
> +
> +	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table_hdr);
> +	if (ACPI_FAILURE(status))
> +		return 0;
> +
> +	if (table_hdr->revision > 1)
> +		has_leaf_flag = true;
> +
> +	table_end = (unsigned long)table_hdr + table_hdr->length;
> +	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
> +			     sizeof(struct acpi_table_pptt));
> +	proc_sz = sizeof(struct acpi_pptt_processor);


> +	while ((unsigned long)entry + proc_sz < table_end) {

Dave Martin picked out an off-by-one here - this pattern was copied from other functions,
then fixed while I was still lugging this around out of tree. Should be:
|       while ((unsigned long)entry + proc_sz <= table_end) {

See adfab6b39202481bb43286fff94def4953793fdb.

I've fixed this locally.


> +		cpu_node = (struct acpi_pptt_processor *)entry;
> +		if (entry->type == ACPI_PPTT_TYPE_PROCESSOR &&
> +		    cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID) {
> +			leaf_flag = cpu_node->flags & ACPI_PPTT_ACPI_LEAF_NODE;
> +			if ((has_leaf_flag && !leaf_flag) ||
> +			    (!has_leaf_flag && !acpi_pptt_leaf_node(table_hdr, cpu_node))) {
> +				if (cpu_node->acpi_processor_id == acpi_cpu_id)
> +					acpi_pptt_get_child_cpus(table_hdr, cpu_node, cpus);
> +			}
> +		}
> +		entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry,
> +				     entry->length);
> +	}
> +
> +	acpi_put_table(table_hdr);
> +
> +	return ret;
> +}


Thanks,

James

