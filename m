Return-Path: <linux-acpi+bounces-17527-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 67375BB5B1A
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 02:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC9AF342BB6
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Oct 2025 00:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A1A1D5CE0;
	Fri,  3 Oct 2025 00:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bEqfIyFK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5593BBF2
	for <linux-acpi@vger.kernel.org>; Fri,  3 Oct 2025 00:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759453144; cv=none; b=g21Xn7JpCv6LLefXPChuSA0Yigwk15+4bsv0EWn2smaXl0bknj6g6vCgz6kQ5pDpH2gaaTx5h1bblDDxR9V8L8mHsUFxldNRbo3/lPbYqNIOHuu5E6Z85qYUml11Rr7AAz9Xpk3ao1HAbqAsIoyF4xy3sLy+lHjkduCfENJAqS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759453144; c=relaxed/simple;
	bh=M4Z2whpCy7ejVYdr43N3DBsACwFJCUfvRnnM7EMipEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6uiJctWWs445UjO7vnXBKIoaJHrDvPhTeDIk7FU8b2VEAST562pTXj3RqUyOOpNjs5OiWoVNdrtZHgq9MZ1lTzcrD82EDou3ecH3FgkrIwWbv9K3wlaY9+H5qgHrxU5JfIHJ4FHfUtUQWBcX/M23QypPV/nDRhJeacAvkyKYxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bEqfIyFK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759453136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AIluKvUIeE/qbH8NmvnsgQ/Z6TBiua3Vl8s1i99/pgU=;
	b=bEqfIyFKl2v990Aw75j7FGHxyjM1yXs334ndKzrYk7EIO+NpLZFm8kBgbpDoqUAtFswzMx
	s0PXd2BQpX4yhyoL+cgQRbqh/3g8RPc3SCIpSUO5+sYRrmoFQOjnjU3RgepkGfbOdiaMrP
	3t3qr98UpZYR56TzSBrF9bJ5dWGQa3A=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-gpnh7WTeOPCK_ALTgHfGTg-1; Thu, 02 Oct 2025 20:58:55 -0400
X-MC-Unique: gpnh7WTeOPCK_ALTgHfGTg-1
X-Mimecast-MFC-AGG-ID: gpnh7WTeOPCK_ALTgHfGTg_1759453134
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-28e8112143fso22958835ad.2
        for <linux-acpi@vger.kernel.org>; Thu, 02 Oct 2025 17:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759453134; x=1760057934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AIluKvUIeE/qbH8NmvnsgQ/Z6TBiua3Vl8s1i99/pgU=;
        b=G/MhtxxmSFohtpgZJAILXINCNQ185oPB0UzJauKW0yDag4np9+4OdTR80WObjaqyvw
         WSuplVK3ZkzySlBDm+CJVN2Ndy/O9xzqiv/wn52s3tXODwXvV+wKpLb6wJeJHS74ueX3
         /rG0LB+Akk0jjaaFNaN9NtmPbSXcZoDHOsh5hm18SMLHPS1ZJf0UvS6DmOiZFCrdQp0/
         rj06GVtpfKJ72j+yZUW6juVvjDNXovMInmnvAh3VyR3RJ50ro6kidrCqELX+JJKR8zMF
         +ma2A956ULYLPLUdHD65dKGXfOP9n192mDW81vmLgdb686DElv6Oew3kmuu0DR1cd5EI
         9uMg==
X-Forwarded-Encrypted: i=1; AJvYcCXh85x0V9z5EVydXJtL7rHUqkFaaUl/qoCnBrf2WKeXBD0JAHpNvQbp95qd+rGCzDX/RXjnjzuC+1ZB@vger.kernel.org
X-Gm-Message-State: AOJu0YzSIxk57hbjxY6sYMMANgiZ7u6XnBGqNjSsVQ34vd9ybC5f5B6/
	7UQq0xvJD1pM9oRazcHD8ij3zzHXxCKVmQXj7MM1Y8BFwDQXSFt6t3M+X2Xzo7LH05KcehMDe9i
	PcWzJEihBA4j3NT5P8wFma9cT38cNJ707dNpYjknzYzzsdQ/JZkvs9Io0itUZqtg=
X-Gm-Gg: ASbGncsrBiLkLN75qol4R/wAsIHE+tsyzP9V6M0DhfHzPuzzZ/qao0Y6gsHz5xPh974
	XZJZqNz2AiVmEZf5+fRoUYPZvY7KHb7RHEaxdB8Hlg/TNr87D0SVNF0LhRTBDQfG5LOjDj9ZqSO
	yA7csxMn/B0VQKwNJGjdhAGPHfGN2h6vl8fY3nTkWvs+PU2H9PNfudHPnzo8SfYYFM8fESo8yUM
	ft1mlvKl2jS1PuhqxnVoVZZS2iAlWXe+A4KCEQl9sRPSXM8gtvffpdgDBQx7DupiPOGA6nZWdya
	OVTaIYJWUytFN3CernuochqSWiY2wao5QOgAb64pPh65yk4x8AC00ChZdg3vegwfN4aCldlthqg
	ZjxnED5sKLQ==
X-Received: by 2002:a17:903:230a:b0:282:ee0e:5991 with SMTP id d9443c01a7336-28e9a5f7222mr12696995ad.30.1759453134214;
        Thu, 02 Oct 2025 17:58:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaTEg5vD3QN8t3LUlZUTp2tkCic8On/odh9gyv30BwyKNn3A3xfpDioQ3VMbjbnGLOYln37A==
X-Received: by 2002:a17:903:230a:b0:282:ee0e:5991 with SMTP id d9443c01a7336-28e9a5f7222mr12696725ad.30.1759453133677;
        Thu, 02 Oct 2025 17:58:53 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b845bsm32909455ad.79.2025.10.02.17.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 17:58:53 -0700 (PDT)
Message-ID: <64105db5-01e3-44ba-bfb0-6524de471ccb@redhat.com>
Date: Fri, 3 Oct 2025 10:58:40 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/29] ACPI / MPAM: Parse the MPAM table
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
 <20250910204309.20751-7-james.morse@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250910204309.20751-7-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/25 6:42 AM, James Morse wrote:
> Add code to parse the arm64 specific MPAM table, looking up the cache
> level from the PPTT and feeding the end result into the MPAM driver.
> 
> For now the MPAM hook mpam_ris_create() is stubbed out, but will update
> the MPAM driver with optional discovered data.
> 
> CC: Carl Worth <carl@os.amperecomputing.com>
> Link: https://developer.arm.com/documentation/den0065/3-0bet/?lang=en
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> ---
> Changes since v1:
>   * Whitespace.
>   * Gave GLOBAL_AFFINITY a pre-processor'd name.
>   * Fixed assumption that there are zero functional dependencies.
>   * Bounds check walking of the MSC RIS.
>   * More bounds checking in the main table walk.
>   * Check for nonsense numbers of function dependencies.
>   * Smattering of pr_debug() to help folk feeding line-noise to the parser.
>   * Changed the comment flavour on the SPDX string.
>   * Removed additional table check.
>   * More comment wrangling.
> 
> Changes since RFC:
>   * Used DEFINE_RES_IRQ_NAMED() and friends macros.
>   * Additional error handling.
>   * Check for zero sized MSC.
>   * Allow table revisions greater than 1. (no spec for revision 0!)
>   * Use cleanup helpers to retrive ACPI tables, which allows some functions
>     to be folded together.
> ---
>   arch/arm64/Kconfig          |   1 +
>   drivers/acpi/arm64/Kconfig  |   3 +
>   drivers/acpi/arm64/Makefile |   1 +
>   drivers/acpi/arm64/mpam.c   | 361 ++++++++++++++++++++++++++++++++++++
>   drivers/acpi/tables.c       |   2 +-
>   include/linux/acpi.h        |  12 ++
>   include/linux/arm_mpam.h    |  48 +++++
>   7 files changed, 427 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/acpi/arm64/mpam.c
>   create mode 100644 include/linux/arm_mpam.h
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 4be8a13505bf..6487c511bdc6 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2062,6 +2062,7 @@ config ARM64_TLB_RANGE
>   
>   config ARM64_MPAM
>   	bool "Enable support for MPAM"
> +	select ACPI_MPAM if ACPI
>   	help
>   	  Memory System Resource Partitioning and Monitoring (MPAM) is an
>   	  optional extension to the Arm architecture that allows each
> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
> index b3ed6212244c..f2fd79f22e7d 100644
> --- a/drivers/acpi/arm64/Kconfig
> +++ b/drivers/acpi/arm64/Kconfig
> @@ -21,3 +21,6 @@ config ACPI_AGDI
>   
>   config ACPI_APMT
>   	bool
> +
> +config ACPI_MPAM
> +	bool
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index 05ecde9eaabe..9390b57cb564 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_ACPI_APMT) 	+= apmt.o
>   obj-$(CONFIG_ACPI_FFH)		+= ffh.o
>   obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
>   obj-$(CONFIG_ACPI_IORT) 	+= iort.o
> +obj-$(CONFIG_ACPI_MPAM) 	+= mpam.o
>   obj-$(CONFIG_ACPI_PROCESSOR_IDLE) += cpuidle.o
>   obj-$(CONFIG_ARM_AMBA)		+= amba.o
>   obj-y				+= dma.o init.o
> diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
> new file mode 100644
> index 000000000000..fd9cfa143676
> --- /dev/null
> +++ b/drivers/acpi/arm64/mpam.c
> @@ -0,0 +1,361 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2025 Arm Ltd.
> +
> +/* Parse the MPAM ACPI table feeding the discovered nodes into the driver */
> +
> +#define pr_fmt(fmt) "ACPI MPAM: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/arm_mpam.h>
> +#include <linux/bits.h>
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/platform_device.h>
> +
> +#include <acpi/processor.h>
> +
> +/*
> + * Flags for acpi_table_mpam_msc.*_interrupt_flags.
> + * See 2.1.1 Interrupt Flags, Table 5, of DEN0065B_MPAM_ACPI_3.0-bet.
> + */
> +#define ACPI_MPAM_MSC_IRQ_MODE_MASK                    BIT(0)
> +#define ACPI_MPAM_MSC_IRQ_TYPE_MASK                    GENMASK(2, 1)
> +#define ACPI_MPAM_MSC_IRQ_TYPE_WIRED                   0
> +#define ACPI_MPAM_MSC_IRQ_AFFINITY_PROCESSOR_CONTAINER BIT(3)
> +#define ACPI_MPAM_MSC_IRQ_AFFINITY_VALID               BIT(4)
> +
> +static bool acpi_mpam_register_irq(struct platform_device *pdev, int intid,
> +				   u32 flags, int *irq,
> +				   u32 processor_container_uid)
> +{
> +	int sense;
> +
> +	if (!intid)
> +		return false;
> +
> +	if (FIELD_GET(ACPI_MPAM_MSC_IRQ_TYPE_MASK, flags) !=
> +	    ACPI_MPAM_MSC_IRQ_TYPE_WIRED)
> +		return false;
> +
> +	sense = FIELD_GET(ACPI_MPAM_MSC_IRQ_MODE_MASK, flags);
> +
> +	if (16 <= intid && intid < 32 && processor_container_uid != GLOBAL_AFFINITY) {
> +		pr_err_once("Partitioned interrupts not supported\n");
> +		return false;
> +	}
> +
> +	*irq = acpi_register_gsi(&pdev->dev, intid, sense, ACPI_ACTIVE_HIGH);
> +	if (*irq <= 0) {
> +		pr_err_once("Failed to register interrupt 0x%x with ACPI\n",
> +			    intid);
> +		return false;
> +	}
> +
> +	return true;
> +}

0 is allowed by acpi_register_gsi().

	if (*irq < 0) {
		pr_err_once(...);
		return false;
	}

> +
> +static void acpi_mpam_parse_irqs(struct platform_device *pdev,
> +				 struct acpi_mpam_msc_node *tbl_msc,
> +				 struct resource *res, int *res_idx)
> +{
> +	u32 flags, aff;
> +	int irq;
> +
> +	flags = tbl_msc->overflow_interrupt_flags;
> +	if (flags & ACPI_MPAM_MSC_IRQ_AFFINITY_VALID &&
> +	    flags & ACPI_MPAM_MSC_IRQ_AFFINITY_PROCESSOR_CONTAINER)
> +		aff = tbl_msc->overflow_interrupt_affinity;
> +	else
> +		aff = GLOBAL_AFFINITY;
> +	if (acpi_mpam_register_irq(pdev, tbl_msc->overflow_interrupt, flags, &irq, aff))
> +		res[(*res_idx)++] = DEFINE_RES_IRQ_NAMED(irq, "overflow");
> +
> +	flags = tbl_msc->error_interrupt_flags;
> +	if (flags & ACPI_MPAM_MSC_IRQ_AFFINITY_VALID &&
> +	    flags & ACPI_MPAM_MSC_IRQ_AFFINITY_PROCESSOR_CONTAINER)
> +		aff = tbl_msc->error_interrupt_affinity;
> +	else
> +		aff = GLOBAL_AFFINITY;
> +	if (acpi_mpam_register_irq(pdev, tbl_msc->error_interrupt, flags, &irq, aff))
> +		res[(*res_idx)++] = DEFINE_RES_IRQ_NAMED(irq, "error");
> +}
> +
> +static int acpi_mpam_parse_resource(struct mpam_msc *msc,
> +				    struct acpi_mpam_resource_node *res)
> +{
> +	int level, nid;
> +	u32 cache_id;
> +
> +	switch (res->locator_type) {
> +	case ACPI_MPAM_LOCATION_TYPE_PROCESSOR_CACHE:
> +		cache_id = res->locator.cache_locator.cache_reference;
> +		level = find_acpi_cache_level_from_id(cache_id);
> +		if (level <= 0) {
> +			pr_err_once("Bad level (%u) for cache with id %u\n", level, cache_id);
> +			return -EINVAL;
> +		}
> +		return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_CACHE,
> +				       level, cache_id);
> +	case ACPI_MPAM_LOCATION_TYPE_MEMORY:
> +		nid = pxm_to_node(res->locator.memory_locator.proximity_domain);
> +		if (nid == NUMA_NO_NODE)
> +			nid = 0;
> +		return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_MEMORY,
> +				       255, nid);

It's perhaps worthy a warning message when @nid is explicitly set to zero due to
the bad proximity domain, something like below.

		if (nid == NUMA_NO_NODE) {
			nid = 0;
			if (num_possible_nodes() > 1) {
				pr_warn("Bad proximity domain %d, mapped to node 0\n",
					res->locator.memory_locator.proximity_domain);
			}
		}
		

> +	default:
> +		/* These get discovered later and treated as unknown */
> +		return 0;
> +	}
> +}
> +
> +int acpi_mpam_parse_resources(struct mpam_msc *msc,
> +			      struct acpi_mpam_msc_node *tbl_msc)
> +{
> +	int i, err;
> +	char *ptr, *table_end;
> +	struct acpi_mpam_resource_node *resource;
> +
> +	ptr = (char *)(tbl_msc + 1);
> +	table_end = ptr + tbl_msc->length;
> +	for (i = 0; i < tbl_msc->num_resource_nodes; i++) {
> +		u64 max_deps, remaining_table;
> +
> +		if (ptr + sizeof(*resource) > table_end)
> +			return -EINVAL;
> +
> +		resource = (struct acpi_mpam_resource_node *)ptr;
> +
> +		remaining_table = table_end - ptr;
> +		max_deps = remaining_table / sizeof(struct acpi_mpam_func_deps);
> +		if (resource->num_functional_deps > max_deps) {
> +			pr_debug("MSC has impossible number of functional dependencies\n");
> +			return -EINVAL;
> +		}
> +
> +		err = acpi_mpam_parse_resource(msc, resource);
> +		if (err)
> +			return err;
> +
> +		ptr += sizeof(*resource);
> +		ptr += resource->num_functional_deps * sizeof(struct acpi_mpam_func_deps);
> +	}
> +
> +	return 0;
> +}
> +
> +static bool __init parse_msc_pm_link(struct acpi_mpam_msc_node *tbl_msc,
> +				     struct platform_device *pdev,
> +				     u32 *acpi_id)
> +{
> +	char hid[sizeof(tbl_msc->hardware_id_linked_device) + 1];
> +	bool acpi_id_valid = false;
> +	struct acpi_device *buddy;
> +	char uid[11];
> +	int err;
> +
> +	memset(&hid, 0, sizeof(hid));
> +	memcpy(hid, &tbl_msc->hardware_id_linked_device,
> +	       sizeof(tbl_msc->hardware_id_linked_device));
> +
> +	if (!strcmp(hid, ACPI_PROCESSOR_CONTAINER_HID)) {
> +		*acpi_id = tbl_msc->instance_id_linked_device;
> +		acpi_id_valid = true;
> +	}
> +
> +	err = snprintf(uid, sizeof(uid), "%u",
> +		       tbl_msc->instance_id_linked_device);
> +	if (err >= sizeof(uid)) {
> +		pr_debug("Failed to convert uid of device for power management.");
> +		return acpi_id_valid;
> +	}
> +
> +	buddy = acpi_dev_get_first_match_dev(hid, uid, -1);
> +	if (buddy)
> +		device_link_add(&pdev->dev, &buddy->dev, DL_FLAG_STATELESS);
> +
> +	return acpi_id_valid;
> +}
> +
> +static int decode_interface_type(struct acpi_mpam_msc_node *tbl_msc,
> +				 enum mpam_msc_iface *iface)
> +{
> +	switch (tbl_msc->interface_type) {
> +	case 0:
> +		*iface = MPAM_IFACE_MMIO;
> +		return 0;
> +	case 0xa:
> +		*iface = MPAM_IFACE_PCC;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int __init acpi_mpam_parse(void)
> +{
> +	struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_MPAM, 0);
> +	char *table_end, *table_offset = (char *)(table + 1);
> +	struct property_entry props[4]; /* needs a sentinel */
> +	struct acpi_mpam_msc_node *tbl_msc;
> +	int next_res, next_prop, err = 0;
> +	struct acpi_device *companion;
> +	struct platform_device *pdev;
> +	enum mpam_msc_iface iface;
> +	struct resource res[3];
> +	char uid[16];
> +	u32 acpi_id;
> +
> +	if (acpi_disabled || !system_supports_mpam() || IS_ERR(table))
> +		return 0;
> +
> +	if (table->revision < 1)
> +		return 0;
> +
> +	table_end = (char *)table + table->length;
> +
> +	while (table_offset < table_end) {
> +		tbl_msc = (struct acpi_mpam_msc_node *)table_offset;
> +		table_offset += tbl_msc->length;
> +
> +		if (table_offset > table_end) {
> +			pr_debug("MSC entry overlaps end of ACPI table\n");
> +			break;
> +		}
> +
> +		/*
> +		 * If any of the reserved fields are set, make no attempt to
> +		 * parse the MSC structure. This MSC will still be counted,
> +		 * meaning the MPAM driver can't probe against all MSC, and
> +		 * will never be enabled. There is no way to enable it safely,
> +		 * because we cannot determine safe system-wide partid and pmg
> +		 * ranges in this situation.
> +		 */
> +		if (tbl_msc->reserved || tbl_msc->reserved1 || tbl_msc->reserved2) {
> +			pr_err_once("Unrecognised MSC, MPAM not usable\n");
> +			pr_debug("MSC.%u: reserved field set\n", tbl_msc->identifier);
> +			continue;
> +		}
> +
> +		if (!tbl_msc->mmio_size) {
> +			pr_debug("MSC.%u: marked as disabled\n", tbl_msc->identifier);
> +			continue;
> +		}
> +
> +		if (decode_interface_type(tbl_msc, &iface)) {
> +			pr_debug("MSC.%u: unknown interface type\n", tbl_msc->identifier);
> +			continue;
> +		}
> +
> +		next_res = 0;
> +		next_prop = 0;
> +		memset(res, 0, sizeof(res));
> +		memset(props, 0, sizeof(props));
> +
> +		pdev = platform_device_alloc("mpam_msc", tbl_msc->identifier);
> +		if (!pdev) {
> +			err = -ENOMEM;
> +			break;
> +		}
> +
> +		if (tbl_msc->length < sizeof(*tbl_msc)) {
> +			err = -EINVAL;
> +			break;
> +		}
> +
> +		/* Some power management is described in the namespace: */
> +		err = snprintf(uid, sizeof(uid), "%u", tbl_msc->identifier);
> +		if (err > 0 && err < sizeof(uid)) {
> +			companion = acpi_dev_get_first_match_dev("ARMHAA5C", uid, -1);
> +			if (companion)
> +				ACPI_COMPANION_SET(&pdev->dev, companion);
> +			else
> +				pr_debug("MSC.%u: missing namespace entry\n", tbl_msc->identifier);
> +		}
> +
> +		if (iface == MPAM_IFACE_MMIO) {
> +			res[next_res++] = DEFINE_RES_MEM_NAMED(tbl_msc->base_address,
> +							       tbl_msc->mmio_size,
> +							       "MPAM:MSC");
> +		} else if (iface == MPAM_IFACE_PCC) {
> +			props[next_prop++] = PROPERTY_ENTRY_U32("pcc-channel",
> +								tbl_msc->base_address);
> +			next_prop++;
> +		}
> +
> +		acpi_mpam_parse_irqs(pdev, tbl_msc, res, &next_res);
> +		err = platform_device_add_resources(pdev, res, next_res);
> +		if (err)
> +			break;
> +
> +		props[next_prop++] = PROPERTY_ENTRY_U32("arm,not-ready-us",
> +							tbl_msc->max_nrdy_usec);
> +
> +		/*
> +		 * The MSC's CPU affinity is described via its linked power
> +		 * management device, but only if it points at a Processor or
> +		 * Processor Container.
> +		 */
> +		if (parse_msc_pm_link(tbl_msc, pdev, &acpi_id)) {
> +			props[next_prop++] = PROPERTY_ENTRY_U32("cpu_affinity",
> +								acpi_id);
> +		}
> +
> +		err = device_create_managed_software_node(&pdev->dev, props,
> +							  NULL);
> +		if (err)
> +			break;
> +
> +		/* Come back later if you want the RIS too */
> +		err = platform_device_add_data(pdev, tbl_msc, tbl_msc->length);
> +		if (err)
> +			break;
> +
> +		err = platform_device_add(pdev);
> +		if (err)
> +			break;
> +	}
> +
> +	if (err)
> +		platform_device_put(pdev);
> +
> +	return err;
> +}
> +
> +int acpi_mpam_count_msc(void)
> +{
> +	struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_MPAM, 0);
> +	char *table_end, *table_offset = (char *)(table + 1);
> +	struct acpi_mpam_msc_node *tbl_msc;
> +	int count = 0;
> +
> +	if (IS_ERR(table))
> +		return 0;
> +
> +	if (table->revision < 1)
> +		return 0;
> +
> +	table_end = (char *)table + table->length;
> +
> +	while (table_offset < table_end) {
> +		tbl_msc = (struct acpi_mpam_msc_node *)table_offset;
> +		if (!tbl_msc->mmio_size)
> +			continue;
> +
> +		if (tbl_msc->length < sizeof(*tbl_msc))
> +			return -EINVAL;
> +		if (tbl_msc->length > table_end - table_offset)
> +			return -EINVAL;
> +		table_offset += tbl_msc->length;
> +
> +		count++;
> +	}
> +
> +	return count;
> +}
> +

acpi_mpam_count_msc() iterates the existing MSC node, which is part of acpi_mpam_parse().
So the question is why we can't drop acpi_mpam_count_msc() and maintain a variable to
count the existing MSC nodes in acpi_mpam_parse() ?

> +/*
> + * Call after ACPI devices have been created, which happens behind acpi_scan_init()
> + * called from subsys_initcall(). PCC requires the mailbox driver, which is
> + * initialised from postcore_initcall().
> + */
> +subsys_initcall_sync(acpi_mpam_parse);
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index fa9bb8c8ce95..835e3795ede3 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -408,7 +408,7 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE] __nonstring_array __initconst
>   	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
>   	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
>   	ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI,
> -	ACPI_SIG_NBFT };
> +	ACPI_SIG_NBFT, ACPI_SIG_MPAM };
>   
>   #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
>   
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index c5fd92cda487..af449964426b 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -8,6 +8,7 @@
>   #ifndef _LINUX_ACPI_H
>   #define _LINUX_ACPI_H
>   
> +#include <linux/cleanup.h>
>   #include <linux/errno.h>
>   #include <linux/ioport.h>	/* for struct resource */
>   #include <linux/resource_ext.h>
> @@ -221,6 +222,17 @@ void acpi_reserve_initial_tables (void);
>   void acpi_table_init_complete (void);
>   int acpi_table_init (void);
>   
> +static inline struct acpi_table_header *acpi_get_table_ret(char *signature, u32 instance)
> +{
> +	struct acpi_table_header *table;
> +	int status = acpi_get_table(signature, instance, &table);
> +
> +	if (ACPI_FAILURE(status))
> +		return ERR_PTR(-ENOENT);
> +	return table;
> +}
> +DEFINE_FREE(acpi_table, struct acpi_table_header *, if (!IS_ERR(_T)) acpi_put_table(_T))
> +
>   int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
>   int __init_or_acpilib acpi_table_parse_entries(char *id,
>   		unsigned long table_size, int entry_id,
> diff --git a/include/linux/arm_mpam.h b/include/linux/arm_mpam.h
> new file mode 100644
> index 000000000000..3d6c39c667c3
> --- /dev/null
> +++ b/include/linux/arm_mpam.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2025 Arm Ltd. */
> +
> +#ifndef __LINUX_ARM_MPAM_H
> +#define __LINUX_ARM_MPAM_H
> +
> +#include <linux/acpi.h>
> +#include <linux/types.h>
> +
> +#define GLOBAL_AFFINITY		~0
> +
> +struct mpam_msc;
> +
> +enum mpam_msc_iface {
> +	MPAM_IFACE_MMIO,	/* a real MPAM MSC */
> +	MPAM_IFACE_PCC,		/* a fake MPAM MSC */
> +};
> +
> +enum mpam_class_types {
> +	MPAM_CLASS_CACHE,       /* Well known caches, e.g. L2 */
> +	MPAM_CLASS_MEMORY,      /* Main memory */
> +	MPAM_CLASS_UNKNOWN,     /* Everything else, e.g. SMMU */
> +};
> +
> +#ifdef CONFIG_ACPI_MPAM
> +/* Parse the ACPI description of resources entries for this MSC. */
> +int acpi_mpam_parse_resources(struct mpam_msc *msc,
> +			      struct acpi_mpam_msc_node *tbl_msc);
> +
> +int acpi_mpam_count_msc(void);
> +#else
> +static inline int acpi_mpam_parse_resources(struct mpam_msc *msc,
> +					    struct acpi_mpam_msc_node *tbl_msc)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int acpi_mpam_count_msc(void) { return -EINVAL; }
> +#endif
> +
> +static inline int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
> +				  enum mpam_class_types type, u8 class_id,
> +				  int component_id)
> +{
> +	return -EINVAL;
> +}
> +
> +#endif /* __LINUX_ARM_MPAM_H */

Thanks,
Gavin


