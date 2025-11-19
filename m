Return-Path: <linux-acpi+bounces-19053-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCE6C6CA1A
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 04:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 911244E3B18
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 03:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B052E7623;
	Wed, 19 Nov 2025 03:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvOT+Jqy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOE38+1I"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28BD25EFAE
	for <linux-acpi@vger.kernel.org>; Wed, 19 Nov 2025 03:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763523324; cv=none; b=gP6WihMDo3TDRFlj2L6lbWWWi+OKU90GOU4rgE2bUkNYbzzTP8T39m1rjf/o+8vGWVL9flpSC4dXc/Dr3f5hexx4gHu6VXspcz0Npa2pFTjbSUMGkU8O1hMiIzXjAz4APIFR0tAXlzhPYoZyHacwOi83aNsS1wBMZqglgRECsnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763523324; c=relaxed/simple;
	bh=FJS/HClEJ1jtK+rxMOC89uUQdfj4wsNu+wSDk1ZBbSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u3somGLmMXI5R5ShxMtFGtFEZvyrcNxOAlVWEEcq6Pdn8otlIci0Y1PRd5EaYCDrSk/8KkSiQKPv40Z29m25Sw1G8xh2zfOp8RVk/GBdnwBJ///P6Nyl3SSCeppOk8BmY8OTYNOw9RBg2FjjeTcxg7d70+ionYqK7V523et6fYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RvOT+Jqy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TOE38+1I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763523320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uvuRIi2ziKsR6xTkpv20Bt95OlEm10rLUXNQns1uoJU=;
	b=RvOT+JqyJ2ZAocy2WlnPSxHwnWkcikq8xKPaMj0bK/4evhmfsshtGCoWJremcb6TcioTGf
	VqMatlVv3t6KnFzWJlH9BgZtqmd1R1g9HzR2t48zI/Aa/BWCUIwPOFLBgvy1JRiWmk2/6M
	kfaIE8f5iFjY3EbB+FGqo6z8XnJiQcw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-w3RtDvr3NK6nvu1r9wZzvw-1; Tue, 18 Nov 2025 22:35:19 -0500
X-MC-Unique: w3RtDvr3NK6nvu1r9wZzvw-1
X-Mimecast-MFC-AGG-ID: w3RtDvr3NK6nvu1r9wZzvw_1763523318
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29809acd049so110184845ad.3
        for <linux-acpi@vger.kernel.org>; Tue, 18 Nov 2025 19:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763523318; x=1764128118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uvuRIi2ziKsR6xTkpv20Bt95OlEm10rLUXNQns1uoJU=;
        b=TOE38+1I/JvwjYlvlL37OcRoGP3ktbHm0NNUYwPwr9+th4fgEeqOqoBDQWxdhPNWcQ
         oY1V6S47BENPO7iGyiCAYQQaSWuvievXNgRGME3/Y6oxWb4pOtNqp7a9Hy2nyq0uu6bZ
         98x1CC+paqCyoBmxBkMwm1bgJutrVXjfA/LlH74SlqJj+VCI/wrX4HK7h88Ui+tyjFiw
         YyXh8nZHVXR1yCgpkOrGw6IbKPFXih+IBTDIfTiedjqa4LfjZiHT9sKRwkCUcyYThvEG
         tdB4EdgV1dLphfvJ4aIyLAvpCr/jIQ0rt8Myk+pEpMYqQhPp6rV5wOOzqzeeaO9tG8X0
         Id3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763523318; x=1764128118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uvuRIi2ziKsR6xTkpv20Bt95OlEm10rLUXNQns1uoJU=;
        b=AozPlVLu63biY0Ttw840GVUAWeDPQm/dXYttfEa0JAYs+8u6mvny15MfM73I+y6hxu
         fDWajaiVNMF+/AzPXzYMTB9//Pk1aYuNJRN8434kWhWzXIxkSGK8RgTof/V5GK3uNJy2
         aqpHU/SZMU3p+go699bEks6Qq2V/1ddV010uXGG9LqvzxU07cpBh52dCdi6QY3BeoW0V
         A+0rL4q8qP9UaaANK8TO1uFM7l+ALdnrzWDwkPMvM+ESlAhf5hZDa3tLmor4FPzIzpsJ
         NOH3BRZ7toA0x9SigWcdTAOClVx+NlfkE1J03vKdMqWffr7RogKcqXWO8I5y7KSx+I1b
         6xYw==
X-Forwarded-Encrypted: i=1; AJvYcCXlFTx5w+DUPo6aNNZyzWR9fJqBqXR06+73V78sIMsS4w99FYMenWdfZgiL/e0GRDPmCArKpDnqcPUK@vger.kernel.org
X-Gm-Message-State: AOJu0YzefqBZKW63CkmYZ+6OtezXaZJ7L7gu7RuXfK2FjIi0TpkR8Usk
	Tt2LA8N2njwYT9XYwScbZBJM3js40ha0lucAWLa/vENjzLwOrKoStZVuFIOHlvpFFWxBqDy1Y4H
	VckusYUpaXosFOZ1SCtuWX7tb+y8gAqhAb3gW716mQaH7p1ZzpOyjDiRW2veagNI=
X-Gm-Gg: ASbGnctVaFld/sEzyAV7uoNaizBX5MCw97TvOL73B4qXiY7z8Et3Hzof4sfvhwxmBcE
	2VHw2dQxuPvMXgEL5txb7Q6KQJr7MTPn2lQ4e/8rBk6ZL+LY4aMfqd0LYCQXBbqQ8GexTMJ/kDj
	ihH1WrAFQCNYAZu2mf0VeluLh3dyFDKptHuSNNyAXvIop/C3K/aSB5c90OAYDdaNxp2Hwe8bUeA
	cqEybJ7COr34lweTq450R9+QnKa3KFakZHYc9bo9DCHqyRVuusR9TdEt2jCBGh/Noz0UneNYOUk
	Wia7v7qvwwxwe8gRVNuzDs40DXKGnxAt8Od0VbTCxTKSqn0RvM4QphezSi15A8EZSXRiDqno6Rv
	eWH6dE940tBOVk2V7t/Po7CIW8vBGBFSlQyFZoYTcUuc0gHoMoQ==
X-Received: by 2002:a17:902:ebd2:b0:294:fc1d:9d0 with SMTP id d9443c01a7336-2986a750101mr236282225ad.40.1763523318236;
        Tue, 18 Nov 2025 19:35:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3FthsHiIYHA1hbqE2+ofewwVDvuKvv9vofOfVLsaX5rxLiZRjK5scHiZUaUDJ/yZF94bAvA==
X-Received: by 2002:a17:902:ebd2:b0:294:fc1d:9d0 with SMTP id d9443c01a7336-2986a750101mr236281645ad.40.1763523317726;
        Tue, 18 Nov 2025 19:35:17 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346b8sm189887835ad.16.2025.11.18.19.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 19:35:17 -0800 (PST)
Message-ID: <455c577a-2c6b-4d57-9547-8f55bfe1c126@redhat.com>
Date: Wed, 19 Nov 2025 13:35:03 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/34] ACPI / PPTT: Add a helper to fill a cpumask from
 a processor container
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
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
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Zeng Heng <zengheng4@huawei.com>
References: <20251117170014.4113754-1-ben.horgan@arm.com>
 <20251117170014.4113754-2-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251117170014.4113754-2-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben,

On 11/18/25 2:59 AM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
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
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com>
> Tested-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Zeng Heng <zengheng4@huawei.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v4:
> Remove blank line
> 
> Changes since v3:
> Refer to processor hierarchy in comments (Jonathan)
> Fix indent (Jonathan)
> ---
>   drivers/acpi/pptt.c  | 84 ++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/acpi.h |  3 ++
>   2 files changed, 87 insertions(+)
> 

Since this series may need another respin, a nitpick below...

> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 54676e3d82dd..b8248c0092fe 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -817,3 +817,87 @@ int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>   	return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
>   					  ACPI_PPTT_ACPI_IDENTICAL);
>   }
> +
> +/**
> + * acpi_pptt_get_child_cpus() - Find all the CPUs below a PPTT
> + * processor hierarchy node
> + *
> + * @table_hdr:		A reference to the PPTT table
> + * @parent_node:	A pointer to the processor hierarchy node in the
> + *			table_hdr
> + * @cpus:		A cpumask to fill with the CPUs below @parent_node
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

The CPU mask has been cleared in its only caller acpi_pptt_get_cpus_from_container(),
no need to clear it again.

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
> + * @acpi_cpu_id:	The UID of the processor container
> + * @cpus:		The resulting CPU mask
> + *
> + * Find the specified Processor Container, and fill @cpus with all the cpus
> + * below it.
> + *
> + * Not all 'Processor Hierarchy' entries in the PPTT are either a CPU
> + * or a Processor Container, they may exist purely to describe a
> + * Private resource. CPUs have to be leaves, so a Processor Container
> + * is a non-leaf that has the 'ACPI Processor ID valid' flag set.
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
> +		if (entry->type == ACPI_PPTT_TYPE_PROCESSOR) {
> +			struct acpi_pptt_processor *cpu_node;
> +
> +			cpu_node = (struct acpi_pptt_processor *)entry;
> +			if (cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID &&
> +			    !acpi_pptt_leaf_node(table_hdr, cpu_node) &&
> +			    cpu_node->acpi_processor_id == acpi_cpu_id) {
> +				acpi_pptt_get_child_cpus(table_hdr, cpu_node, cpus);
> +				break;
> +			}
> +		}
> +		entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry,
> +				     entry->length);
> +	}
> +}
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 5ff5d99f6ead..4752ebd48132 100644
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

Thanks,
Gavin


