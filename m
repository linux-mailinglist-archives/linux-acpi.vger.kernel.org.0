Return-Path: <linux-acpi+bounces-17972-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 727F9BF1380
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 14:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E1A422E6C
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 12:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E084C3054FB;
	Mon, 20 Oct 2025 12:29:18 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8222ED16B;
	Mon, 20 Oct 2025 12:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963358; cv=none; b=WFo08vuBC4r0+IIW0Do2Ro6xy32+PPN8b5KKzBl0ZQwBSFuSO53Wq8UJUuorZT3IypdI5sffOueFvUeuJeS21nUgGe/xX5voAhVwE+p48M/u38RhOflVKR8h4dOuhCGB0/UABGRvLfzTYYBQmq+iKdE1Hw+tB1+wYhh3IGWlNzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963358; c=relaxed/simple;
	bh=Of4rlV32zj+QFPPASCk3lKgL4l+mocSZNTzS1jezpVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VebHp4OsGxSEMfsoWKEhXEkmjjzL2q5MXeKuWyIcDY0dQRjWnLdvFEDMKMweVCvVID9hLdsOxfAYSGzwRF3+16Pp8a0mpsRO6gyEtkDXdq9c5ennMAd5uzn/u52MS+/FlG1wVp2BJr3YL9cXRFSRV2BoZ5ZRR1oWinAXpkbXtP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24B991007;
	Mon, 20 Oct 2025 05:29:08 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 711553F63F;
	Mon, 20 Oct 2025 05:29:11 -0700 (PDT)
Message-ID: <b0369cf6-229d-458b-9f42-a78e4cf3be94@arm.com>
Date: Mon, 20 Oct 2025 13:29:10 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/29] ACPI / MPAM: Parse the MPAM table
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
 Danilo Krummrich <dakr@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
 Gavin Shan <gshan@redhat.com>
References: <20251017185645.26604-1-james.morse@arm.com>
 <20251017185645.26604-7-james.morse@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20251017185645.26604-7-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 10/17/25 19:56, James Morse wrote:
> Add code to parse the arm64 specific MPAM table, looking up the cache
> level from the PPTT and feeding the end result into the MPAM driver.
> 
> This happens in two stages. Platform devices are created first for the
> MSC devices. Once the driver probes it calls acpi_mpam_parse_resources()
> to discover the RIS entries the MSC contains.
> 
> For now the MPAM hook mpam_ris_create() is stubbed out, but will update
> the MPAM driver with optional discovered data about the RIS entries.
> 
> CC: Carl Worth <carl@os.amperecomputing.com>
> Link: https://developer.arm.com/documentation/den0065/3-0bet/?lang=en
> Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> ---
> Changes since v2:
>  * Expanded commit message.
>  * Moved explicit memset() to array initialisation.
>  * Added comments on the sizing of arrays.
>  * Moved MSC table entry parsing to a helper to allow use of a platform-device
>    cleanup rune, result int more returns and fewer breaks.
>  * Changed pre-processor macros for table bits.
>  * Discover unsupported PPI partitions purely from the table to make gicv5
>    easier, which also simplifies acpi_mpam_parse_irqs()
>  * Gave interface type numbers pre-processor names.
>  * Clarified some comments.
>  * Fixed the WARN_ON comparison in acpi_mpam_parse_msc().
>  * Made buffer over-run noisier.
>  * Print an error condition as %d not %u.
>  * Print a debug message when bad NUMA nodes are found.
> 
[...]
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index a9dbacabdf89..9d66421f68ff 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -8,6 +8,7 @@
>  #ifndef _LINUX_ACPI_H
>  #define _LINUX_ACPI_H
>  
> +#include <linux/cleanup.h>
>  #include <linux/errno.h>
>  #include <linux/ioport.h>	/* for struct resource */
>  #include <linux/resource_ext.h>
> @@ -221,6 +222,17 @@ void acpi_reserve_initial_tables (void);
>  void acpi_table_init_complete (void);
>  int acpi_table_init (void);
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

Any reason to not change this to !IS_ERR_OR_NULL(_T) as Jonathan
suggested in his v2 review.

> +
>  int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
>  int __init_or_acpilib acpi_table_parse_entries(char *id,
>  		unsigned long table_size, int entry_id,
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
> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index 074754c23d33..23a30ada2d4c 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -232,6 +232,7 @@ extern int platform_device_add_data(struct platform_device *pdev,
>  extern int platform_device_add(struct platform_device *pdev);
>  extern void platform_device_del(struct platform_device *pdev);
>  extern void platform_device_put(struct platform_device *pdev);
> +DEFINE_FREE(platform_device_put, struct platform_device *, if (_T) platform_device_put(_T))

Significant enough to be mentioned in the commit message?

This DEFINE_FREE is named after the free-ing function,
platform_device_put, whereas the previous DEFINE_FREE in this patch is
named after the struct, acpi_table. On grepping I see both naming
schemes - not sure if there is a recommendation for new code.

>  
>  struct platform_driver {
>  	int (*probe)(struct platform_device *);

Thanks,

Ben


