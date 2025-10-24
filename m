Return-Path: <linux-acpi+bounces-18193-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B9AC073F1
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 18:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EF90584183
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 16:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0C1335BA0;
	Fri, 24 Oct 2025 16:14:02 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875C8335BC0;
	Fri, 24 Oct 2025 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322441; cv=none; b=MGmMhPXV/t2JOaSMSjUw/L5udMUD6k5TVdtLxaM+HrJC63xWNLzF2pqAB3m4Op41lxo8CJKrYG+GLRpWDX3gMLF7cul0alsagcl/qjExcFIpoT0kdvwzMCLV6d8fNKjU6yKQG0M3bLMVQcJ6grJbe1FVNf6mIxVkq+foW3hiTfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322441; c=relaxed/simple;
	bh=5YbsI1AR7IbFi4Ak3fePeoSgYmigwazJk1/z6u8buBo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aF2W7F6nQ90QIyQ3avRcAAARN3KRlu807AJT4qHhX08iEEX8aC+cuWU/XkcnW6ijR3jG15h+gN9SUQRuAGfrWvpnwba6hJkqFJ11a0GrHTDHn/kouzzAmtY1ujFgkh38b6yGC3h7WqhHV9VcZu6LSI1vUjDhPyGb6F2CxiwJE3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ctSbV4C4mz67SWX;
	Sat, 25 Oct 2025 00:12:22 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id CD05314014B;
	Sat, 25 Oct 2025 00:13:53 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 24 Oct
 2025 17:13:52 +0100
Date: Fri, 24 Oct 2025 17:13:50 +0100
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
Subject: Re: [PATCH v3 06/29] ACPI / MPAM: Parse the MPAM table
Message-ID: <20251024171350.00005451@huawei.com>
In-Reply-To: <20251017185645.26604-7-james.morse@arm.com>
References: <20251017185645.26604-1-james.morse@arm.com>
	<20251017185645.26604-7-james.morse@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 17 Oct 2025 18:56:22 +0000
James Morse <james.morse@arm.com> wrote:

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
Hi James,

Various comments inline.  One challenge with this is that a few
very generic things (the acpi table DEFINE_FREE() stuff and the
platform device put equivalent) aren't obvious enough that I'd expect
those concerned to necessarily notice them.  I'd break those out
as precursor patches, or narrow what they do to not be generic.


> diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
> new file mode 100644
> index 000000000000..59712397025d
> --- /dev/null
> +++ b/drivers/acpi/arm64/mpam.c
> @@ -0,0 +1,377 @@
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

This needs to ultimately end up in ACPICA.  Perhaps fine to have it here
for now. Maybe can't happen until this isn't a beta? I'm not sure on
policy around that.

> + */
> +#define ACPI_MPAM_MSC_IRQ_MODE                              BIT(0)
> +#define ACPI_MPAM_MSC_IRQ_TYPE_MASK                         GENMASK(2, 1)
> +#define ACPI_MPAM_MSC_IRQ_TYPE_WIRED                        0
> +#define ACPI_MPAM_MSC_IRQ_AFFINITY_TYPE_MASK                BIT(3)
> +#define ACPI_MPAM_MSC_IRQ_AFFINITY_TYPE_PROCESSOR           0
> +#define ACPI_MPAM_MSC_IRQ_AFFINITY_TYPE_PROCESSOR_CONTAINER 1
> +#define ACPI_MPAM_MSC_IRQ_AFFINITY_VALID                    BIT(4)
> +
> +/*
> + * Encodings for the MSC node body interface type field.
> + * See 2.1 MPAM MSC node, Table 4 of DEN0065B_MPAM_ACPI_3.0-bet.
> + */
> +#define ACPI_MPAM_MSC_IFACE_MMIO   0x00
> +#define ACPI_MPAM_MSC_IFACE_PCC    0x0a
> +

> +static bool acpi_mpam_register_irq(struct platform_device *pdev, int intid,
> +				   u32 flags, int *irq)
Given irq value of 0 is invalid, could just return the irq from this.
Or even return error codes for what went wrong given negative irqs are invalid
as well.

> +{
> +	u32 int_type;
> +	int sense;
> +
> +	if (!intid)
> +		return false;
> +
> +	if (_is_ppi_partition(flags))
> +		return false;
> +
> +	sense = FIELD_GET(ACPI_MPAM_MSC_IRQ_MODE, flags);

Given it's one bit that indicates 1 if edge, I'd call this edge (which
inherently doesn't mean level).  Sense as a term I think can incorporate
this and rising/falling high/low.  It's parse to acpi_register_gsi()
which calls it trigger so that would work as well.

> +	int_type = FIELD_GET(ACPI_MPAM_MSC_IRQ_TYPE_MASK, flags);
> +	if (int_type != ACPI_MPAM_MSC_IRQ_TYPE_WIRED)
> +		return false;
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
> +
> +static void acpi_mpam_parse_irqs(struct platform_device *pdev,
> +				 struct acpi_mpam_msc_node *tbl_msc,
> +				 struct resource *res, int *res_idx)
> +{
> +	u32 flags, intid;
> +	int irq;
> +
> +	intid = tbl_msc->overflow_interrupt;
> +	flags = tbl_msc->overflow_interrupt_flags;
> +	if (acpi_mpam_register_irq(pdev, intid, flags, &irq))
> +		res[(*res_idx)++] = DEFINE_RES_IRQ_NAMED(irq, "overflow");
> +
> +	intid = tbl_msc->error_interrupt;
> +	flags = tbl_msc->error_interrupt_flags;
> +	if (acpi_mpam_register_irq(pdev, intid, flags, &irq))
> +		res[(*res_idx)++] = DEFINE_RES_IRQ_NAMED(irq, "error");
> +}
> +


This function has a bit of a dual use to it. I think it needs some documentation
to explain under what conditions acpi_id is set.

> +static bool __init parse_msc_pm_link(struct acpi_mpam_msc_node *tbl_msc,
> +				     struct platform_device *pdev,
> +				     u32 *acpi_id)
> +{
> +	char hid[sizeof(tbl_msc->hardware_id_linked_device) + 1] = { 0 };
> +	bool acpi_id_valid = false;
> +	struct acpi_device *buddy;
> +	char uid[11];
> +	int err;
> +
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

The err naming is a bit confusing as it's not an error code. Could call it
something like len or just avoid having a local variable at all.

	if (snprintf(uid, sizeof(uid), "%u",
		     tbl_msc->instance_id_linked_device) >= sizeof(uid))
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
> +static struct platform_device * __init acpi_mpam_parse_msc(struct acpi_mpam_msc_node *tbl_msc)
> +{
> +	struct platform_device *pdev __free(platform_device_put) = platform_device_alloc("mpam_msc", tbl_msc->identifier);
That's too long. Format as
	struct platform_device *pdev __free(platform_device_put) =
		platform_device_alloc("mpam_msc", tbl_msc->identifier);

> +	int next_res = 0, next_prop = 0, err;

...

> +
> +static int __init acpi_mpam_parse(void)
> +{
> +	struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_MPAM, 0);
> +	char *table_end, *table_offset = (char *)(table + 1);
> +	struct acpi_mpam_msc_node *tbl_msc;
> +	struct platform_device *pdev;
> +
> +	if (acpi_disabled || !system_supports_mpam() || IS_ERR(table))
Check acpi_disabled || !system_supports_mpam() before

	struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_MPAM, 0);
	
	if (IS_ERR(table))
		return 0;

That way we aren't relying on acpi_get_table_ret() doing the right thing if acpi_disabled == true
which seems gragile even though it is fine today

Declaring stuff using __free() inline is fine (commonly done).

> +		return 0;
> +

...

> +int acpi_mpam_count_msc(void)
> +{
> +	struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_MPAM, 0);
> +	char *table_end, *table_offset = (char *)(table + 1);
> +	struct acpi_mpam_msc_node *tbl_msc;
> +	int count = 0;
> +
> +	if (IS_ERR(table))
Why fewer things to guard on in here than in the parse function?
I guess this may only be called in circumstances where we know those
other reasons not to carry on aren't true, but still seem odd.

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

Bit marginal on how much we protect against garbage, but perhaps
check the length is long enough to get here. Or can you just
do the length checks first?

> +			continue;

Infinite loop?  table_offset isn't updated so this
keeps checking the same value. Similar to funciton above, I'd
do the table_offset update before check this (and modify
the appropriate checks below).

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
I wonder if it's worth instance being a variable.  11 instances of 1, 52 instances of 0
(almost nothing else).  Maybe just about worth it...

Whilst I like the general nature of this I wonder if smoother
to merge acpi_get_table_mpam() that does this first and then
look at generalizing when it's not on the critical path for this
patch set?  If ACPI folk are fine with this I don't mind it being
in here though as generally useful to have.
(I may well be arguing with earlier me on this :)

> +{
> +	struct acpi_table_header *table;
> +	int status = acpi_get_table(signature, instance, &table);
> +
> +	if (ACPI_FAILURE(status))
> +		return ERR_PTR(-ENOENT);
> +	return table;
> +}
> +DEFINE_FREE(acpi_table, struct acpi_table_header *, if (!IS_ERR(_T)) acpi_put_table(_T))

Ben raised earlier comment on checking for NULL as well to let the compiler optimize
things better.

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

...

> +enum mpam_class_types {
> +	MPAM_CLASS_CACHE,       /* Well known caches, e.g. L2 */

Curious comment.  As opposed to the lesser known l5?   I get
what you mean about not including the weird like memory-side caches
but TLBs are also well known caches so I'd just go with
/* Caches, e.g. l2, l3 */
or something like that.

> +	MPAM_CLASS_MEMORY,      /* Main memory */
> +	MPAM_CLASS_UNKNOWN,     /* Everything else, e.g. SMMU */
> +};
> +
> +#ifdef CONFIG_ACPI_MPAM
> +/* Parse the ACPI description of resources entries for this MSC. */

I'd push more detailed documentation down along side the implementation
rather than having it here.  The function name and parameters make this fairly
obvious anyway.

> +int acpi_mpam_parse_resources(struct mpam_msc *msc,
> +			      struct acpi_mpam_msc_node *tbl_msc);
> +
> +int acpi_mpam_count_msc(void);
> +#else

> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index 074754c23d33..23a30ada2d4c 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -232,6 +232,7 @@ extern int platform_device_add_data(struct platform_device *pdev,
>  extern int platform_device_add(struct platform_device *pdev);
>  extern void platform_device_del(struct platform_device *pdev);
>  extern void platform_device_put(struct platform_device *pdev);
> +DEFINE_FREE(platform_device_put, struct platform_device *, if (_T) platform_device_put(_T))

I'd break this out as a separate precursor patch mostly so people notice it.
Likely will get some review from folk who aren't going to spot it down here.
They may well tell you to not have it as a separate patch but at least you'll
be sure it was noticed!

Jonathan

>  
>  struct platform_driver {
>  	int (*probe)(struct platform_device *);


