Return-Path: <linux-acpi+bounces-17523-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 675FBBB5A88
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 02:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 394984E17AF
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Oct 2025 00:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4121EA6F;
	Fri,  3 Oct 2025 00:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFKXl0t4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732D41E515
	for <linux-acpi@vger.kernel.org>; Fri,  3 Oct 2025 00:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759450525; cv=none; b=LLFBhUpzzZg+qj2k3MGCNLmlSuS1Dz4A9KMa0/qpBEAsFvSIFtaSSaSVFRn418lCQ9WlLV1gS/IALzBtrwORUG0uAkrkzm7yN/ETvU5l0os6voDfY0TOd8gSexQ6VCoH460JED9eSKTA8/4RKxsOjyluGxyC5CDKo8iIVq6MKjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759450525; c=relaxed/simple;
	bh=k7DXWVilqzn4Gw7VQmfBRIWQr3TA4Ok/nE/ndBfJL/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctBMPkKRMP5el6fQvj87b9CvyVC+jkFPK9GjE6ej9Q81Hk3321KgtDvX+fV9rA76LGWqi+XwbxinmgLtT3qTCDbUIwznjzzRZSDsfIcMMUUMHSuWwgpjf74xA16QPf2dbWairXkO+NUgRTY0zLDDyIbP1tK9eqEtlO0Gs3erxJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HFKXl0t4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759450522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XbG34W5wLU8kMo+w26HTYJSkVYz8ACAbrUj0TVdxCOs=;
	b=HFKXl0t4HD0iIiG8WaA0+dQjsLP9sq20+UGYgiaSL6rrPzpxbDLScOX1b+kFMAWKN0fEs5
	FnDa30KUl9mYwWbdFmCz0H/oCwxbhoa+oWdSyPT9Cmd5wn7j9Svl2FTKV8m6XvN9QE7Baa
	He6qq0854NCqwvhPYtePslNnOT/D+5Y=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-B6faHWJwPoWUGV4tLMzhZw-1; Thu, 02 Oct 2025 20:15:21 -0400
X-MC-Unique: B6faHWJwPoWUGV4tLMzhZw-1
X-Mimecast-MFC-AGG-ID: B6faHWJwPoWUGV4tLMzhZw_1759450520
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b551338c2c9so1082012a12.1
        for <linux-acpi@vger.kernel.org>; Thu, 02 Oct 2025 17:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759450520; x=1760055320;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XbG34W5wLU8kMo+w26HTYJSkVYz8ACAbrUj0TVdxCOs=;
        b=VYhA4hWvS8W4GtXNaPtvsJa3U5M1x90ZLqzcnFgTDKpSvJSKMAobmcnRG+/COjCVF4
         ZdtnV4n2MIW6PLRIFADWQIy66LAMYtlsxTuIF08LoEFkXlJzXpAnkfjODw24Jb4MM5hT
         S6rqAphRM5BORYtZYPE2S/YkicPolGU/MSy7M0QLctOeXUc6zRBQN90zIvtLwvR42DUu
         msoJIYEjb1QFGJ9phAiEr2/3XJYlufC78DjWfBmBehMZNnRUmb0bFxPzcGAsFDdR1hrX
         AxCpeoA5b9bEiJHfJMuB8qbVOr7hrH5p58lKfC+iv1+X5S3bfyr12y1qmexhvt5czStN
         qbmw==
X-Forwarded-Encrypted: i=1; AJvYcCXCc1KeNuYT5zP0CKleG1RsOytnmE7Ot+bEd1wYQ9y1g+thTPKFQ5T1jtsiZJnIwS1kV81oE6hIwxMx@vger.kernel.org
X-Gm-Message-State: AOJu0YyMzyNeE9dS12aiYqvYXafK6p5BX41bs2sqnGd2U6a/nT4mJO/8
	vCiOMCv/4z2Jybo2hbqLNfyRlnPEfrf8GBNEtRQ8+bAofsU+k+XD3DZYBFEcrs7t7fbBvcQRNW1
	yt2orwNrYJsciiiwkh6sqNUbhaBzRs/pWiJ0BtoFmWrflorDp/8QyZcBx2uD3UHM=
X-Gm-Gg: ASbGncsK1a7Ds+5O68K+zuEuDHHYi/iXBdfKcFokxJwo7Jz64c+CixxL0omvq31YKyZ
	idiW/rpgMo0otwX4SRt3rSvNAqoN2PEUQ/4jaeoEqjvXN4q7DohnvuobttKjgMlflxN/kc2oodO
	r/ajZ4pGNJmWT0y9NIU8JzwU8h9pLIKn0cAwavUI4AUptzY/sS5qZFJbuMwxY2JJ2Gf63c1SFVY
	I8/cxHvVObFkNzNjUD6Y3QUoWKMjaj1iUELo2CFZgdyM5X/QL0rMIaVynXLEPatm2n4L3NYQLne
	P8nMt04aoFNrhvejVvi5HNfwaC3eCy+k1UyfSI8uKYStfs9oiH264U/Rwx9LRD94lkdGDP7GBms
	ll5P9HRNhIg==
X-Received: by 2002:a05:6a20:7291:b0:251:a106:d96c with SMTP id adf61e73a8af0-32b61dff63fmr1543826637.10.1759450519872;
        Thu, 02 Oct 2025 17:15:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0md3EjClymeLVNxoCZz4Jj91+vv+JPhX5FV8arUGQC8pDP1Ea2wN2DR0g85Dqyra6o57e1w==
X-Received: by 2002:a05:6a20:7291:b0:251:a106:d96c with SMTP id adf61e73a8af0-32b61dff63fmr1543784637.10.1759450519408;
        Thu, 02 Oct 2025 17:15:19 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9daccsm3112663b3a.16.2025.10.02.17.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 17:15:18 -0700 (PDT)
Message-ID: <3a2f6807-9a49-4976-a4d7-7577756c3c26@redhat.com>
Date: Fri, 3 Oct 2025 10:15:04 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/29] ACPI / PPTT: Add a helper to fill a cpumask from
 a processor container
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-2-james.morse@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250910204309.20751-2-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/25 6:42 AM, James Morse wrote:
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
> ---
> Changes since v1:
>   * Replaced commit message with wording from Dave.
>   * Fixed a stray plural.
>   * Moved further down in the file to make use of get_pptt() helper.
>   * Added a break to exit the loop early.
> 
> Changes since RFC:
>   * Removed leaf_flag local variable from acpi_pptt_get_cpus_from_container()
> 
> Changes since RFC:
>   * Dropped has_leaf_flag dodging of acpi_pptt_leaf_node()
>   * Added missing : in kernel-doc
>   * Made helper return void as this never actually returns an error.
> ---
>   drivers/acpi/pptt.c  | 83 ++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/acpi.h |  3 ++
>   2 files changed, 86 insertions(+)
> 

With the description for the return value of acpi_pptt_get_cpus_from_container()
is dropped since that function doesn't have a return value, as mentioned by
Stanimir Varbanov.

Reviewed-by: Gavin Shan <gshan@redhat.com>

Thanks,
Gavin


> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 54676e3d82dd..1728545d90b2 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -817,3 +817,86 @@ int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>   	return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
>   					  ACPI_PPTT_ACPI_IDENTICAL);
>   }
> +
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
> +	if (!table_hdr)
> +		return;
> +
> +	table_end = (unsigned long)table_hdr + table_hdr->length;
> +	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
> +			     sizeof(struct acpi_table_pptt));
> +	proc_sz = sizeof(struct acpi_pptt_processor);
> +	while ((unsigned long)entry + proc_sz <= table_end) {
> +		cpu_node = (struct acpi_pptt_processor *)entry;
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
>   int find_acpi_cpu_topology_cluster(unsigned int cpu);
>   int find_acpi_cpu_topology_package(unsigned int cpu);
>   int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
> +void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus);
>   #else
>   static inline int acpi_pptt_cpu_is_thread(unsigned int cpu)
>   {
> @@ -1562,6 +1563,8 @@ static inline int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>   {
>   	return -EINVAL;
>   }
> +static inline void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id,
> +						     cpumask_t *cpus) { }
>   #endif
>   
>   void acpi_arch_init(void);


