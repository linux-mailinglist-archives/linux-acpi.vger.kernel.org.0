Return-Path: <linux-acpi+bounces-16113-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B16B3874D
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 18:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E1C3B5315
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 16:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E9930AD1E;
	Wed, 27 Aug 2025 16:05:37 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371DB288505;
	Wed, 27 Aug 2025 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310736; cv=none; b=RJD/NqWqI261WRaWWPo8mIrB2VZsUjHnhwEGxLCnKQ9U7sqQ19tUFI+pEeQ5fkEx91mfCxUMtO3yz8jwS8llB/kKWeb3RVCmd4unjYAtwS4vV3BD53Md9IeqAYN6cqqFsV10FcAknf4FW/rxapd9Th7MjsVl0jzM/LcFVrRLsGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310736; c=relaxed/simple;
	bh=gOR3YC57pobA/d10DYYKCDvXTMGEypklvpRYhSa8BAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ecgz6oLS0Cf5Wkam/fTXUYFO0jbXpwT7chB/xPkmYl7v3nZcovAJVB8sNxwiEK6+Pg2SDxArbnUwrWR0MarYiJnazKN8GePO0EE4LGB4pEK820vDQ0DwnnVMSjJ+WxC+FEHPTX+1x0xuegbt0cbG5iebZ+bsPrn34HZMl32brDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA6041688;
	Wed, 27 Aug 2025 09:05:24 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C5263F738;
	Wed, 27 Aug 2025 09:05:27 -0700 (PDT)
Date: Wed, 27 Aug 2025 17:05:24 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: James Morse <james.morse@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
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
Subject: Re: [PATCH 08/33] ACPI / MPAM: Parse the MPAM table
Message-ID: <aK8sxLITHD9KeZyl@e133380.arm.com>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-9-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822153048.2287-9-james.morse@arm.com>

Hi,

[Note, looks like I crossed over with Rob here -- apologies for any
duplicate or conflicting comments.]

On Fri, Aug 22, 2025 at 03:29:49PM +0000, James Morse wrote:
> Add code to parse the arm64 specific MPAM table, looking up the cache
> level from the PPTT and feeding the end result into the MPAM driver.

Might be worth mentioning that the hook for feeding the parsed factoids
into the driver (mpam_ris_create()) is not implemented for now.

> CC: Carl Worth <carl@os.amperecomputing.com>
> Link: https://developer.arm.com/documentation/den0065/3-0bet/?lang=en
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> ---
> Changes since RFC:
>  * Used DEFINE_RES_IRQ_NAMED() and friends macros.
>  * Additional error handling.
>  * Check for zero sized MSC.
>  * Allow table revisions greater than 1. (no spec for revision 0!)
>  * Use cleanup helpers to retrive ACPI tables, which allows some functions
>    to be folded together.
> ---
>  arch/arm64/Kconfig          |   1 +
>  drivers/acpi/arm64/Kconfig  |   3 +
>  drivers/acpi/arm64/Makefile |   1 +
>  drivers/acpi/arm64/mpam.c   | 331 ++++++++++++++++++++++++++++++++++++
>  drivers/acpi/tables.c       |   2 +-
>  include/linux/arm_mpam.h    |  46 +++++
>  6 files changed, 383 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/acpi/arm64/mpam.c
>  create mode 100644 include/linux/arm_mpam.h
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 658e47fc0c5a..e51ccf1da102 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2062,6 +2062,7 @@ config ARM64_TLB_RANGE
>  
>  config ARM64_MPAM
>  	bool "Enable support for MPAM"
> +	select ACPI_MPAM if ACPI
>  	help
>  	  Memory Partitioning and Monitoring is an optional extension
>  	  that allows the CPUs to mark load and store transactions with
> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
> index b3ed6212244c..f2fd79f22e7d 100644
> --- a/drivers/acpi/arm64/Kconfig
> +++ b/drivers/acpi/arm64/Kconfig
> @@ -21,3 +21,6 @@ config ACPI_AGDI
>  
>  config ACPI_APMT
>  	bool
> +
> +config ACPI_MPAM
> +	bool
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index 05ecde9eaabe..9390b57cb564 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_ACPI_APMT) 	+= apmt.o
>  obj-$(CONFIG_ACPI_FFH)		+= ffh.o
>  obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
>  obj-$(CONFIG_ACPI_IORT) 	+= iort.o
> +obj-$(CONFIG_ACPI_MPAM) 	+= mpam.o
>  obj-$(CONFIG_ACPI_PROCESSOR_IDLE) += cpuidle.o
>  obj-$(CONFIG_ARM_AMBA)		+= amba.o
>  obj-y				+= dma.o init.o
> diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
> new file mode 100644
> index 000000000000..e55fc2729ac5
> --- /dev/null
> +++ b/drivers/acpi/arm64/mpam.c
> @@ -0,0 +1,331 @@
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
> +static bool frob_irq(struct platform_device *pdev, int intid, u32 flags,
> +		     int *irq, u32 processor_container_uid)

Can this have a name, please?

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

Do we handle cross-endian ACPI tables?

ACPI defers to the relevant specification regarding the endianness of
externally defined tables, but as of v3.0 (beta) of for MPAM ACPI
spec [1], no statement is made about this.

Following the spirit of the ACPI core specs, I suspect that the
"correct" answer is that MPAM tables are always little-endian, even if
it not written down anywhere.

If the kernel is big-endian, we lose.

Maybe it is sufficient to make CONFIG_ACPI_MPAM depend on
!CONFIG_CPU_BIG_ENDIAN for now.


I haven't tried to understand how this is handled for other tables.

> +
> +	/*
> +	 * If the GSI is in the GIC's PPI range, try and create a partitioned
> +	 * percpu interrupt.

But actually we don't even try?  Or did I miss something?

> +	 */
> +	if (16 <= intid && intid < 32 && processor_container_uid != ~0) {

checkpatch.pl says:

 | WARNING: Comparisons should place the constant on the right side of the test
 | #108: FILE: drivers/acpi/arm64/mpam.c:45:
 | +       if (16 <= intid && intid < 32 && processor_container_uid != ~0) {

(Dubious whether this is "wrong" IMHO, but still probably best avoided
since it is not what people are used to seeing.)

> +		pr_err_once("Partitioned interrupts not supported\n");
> +		return false;
> +	}
> +
> +	*irq = acpi_register_gsi(&pdev->dev, intid, sense, ACPI_ACTIVE_HIGH);
> +	if (*irq <= 0) {
> +		pr_err_once("Failed to register interrupt 0x%x with ACPI\n",
> +			    intid);

Are we going to get a lot of duplicate error messages with the same
interrupt?  If not, perhaps make this a pr_err() so that all the
affected interrupts are notified?

(Either way, hopefully the user will take the hint that they messed
something up though.)

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
> +	u32 flags, aff;
> +	int irq;

We may still get in here if MPAMF_IDR.HAS_ERR_MSI and/or
MPAMF_MSMON_IDR.HAS_OFLW_MSI is set.  If so, there is no wired
interrupt.  Does it matter if we still parse and allocate the wired
interrupts here?
> +
> +	flags = tbl_msc->overflow_interrupt_flags;
> +	if (flags & ACPI_MPAM_MSC_IRQ_AFFINITY_VALID &&
> +	    flags & ACPI_MPAM_MSC_IRQ_AFFINITY_PROCESSOR_CONTAINER)
> +		aff = tbl_msc->overflow_interrupt_affinity;
> +	else
> +		aff = ~0;

(u32)~0 is used as an exceptional UID all over the place.  If this is
not a pre-existing convention, it could be worth having a #define for
this.  (grep '~0' drivers/acpi/ suggests that this is new.)

> +	if (frob_irq(pdev, tbl_msc->overflow_interrupt, flags, &irq, aff))
> +		res[(*res_idx)++] = DEFINE_RES_IRQ_NAMED(irq, "overflow");

I couldn't find a statement in the spec of how the table can specify
that there is no interrupt.

Are the interrupts always required for ACPI-based MPAM systems?

overflow_interrupt and error_interrupt are GSIVs, which seems to be an
ACPI thing.  The examples in the ACPI spec suggest that 0 can be a
valid value.  No exceptional value seems to be defined.

The flags fields have some invalid encodings, but no explicit "no
interrupt" encoding that I can see.

> +
> +	flags = tbl_msc->error_interrupt_flags;
> +	if (flags & ACPI_MPAM_MSC_IRQ_AFFINITY_VALID &&
> +	    flags & ACPI_MPAM_MSC_IRQ_AFFINITY_PROCESSOR_CONTAINER)
> +		aff = tbl_msc->error_interrupt_affinity;
> +	else
> +		aff = ~0;
> +	if (frob_irq(pdev, tbl_msc->error_interrupt, flags, &irq, aff))
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
> +	struct acpi_mpam_resource_node *resources;
> +
> +	resources = (struct acpi_mpam_resource_node *)(tbl_msc + 1);

Should we check that we don't go out of the bounds of the MSC node
(or, at the very least, of the MPAM table)?

If tbl_msc->length was already validated, that can be used for the
bounds check.

> +	for (i = 0; i < tbl_msc->num_resource_nodes; i++) {
> +		err = acpi_mpam_parse_resource(msc, &resources[i]);

Isn't the length of each resource node variable?  According to [2],
the length depends on the num_functional_deps field.  It looks like the
functional dependency descriptors (if any) are appended contiguously to
the resource node, unless I've misunderstood something.

> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool __init parse_msc_pm_link(struct acpi_mpam_msc_node *tbl_msc,
> +				     struct platform_device *pdev,
> +				     u32 *acpi_id)
> +{
> +	bool acpi_id_valid = false;
> +	struct acpi_device *buddy;
> +	char hid[16], uid[16];
> +	int err;
> +
> +	memset(&hid, 0, sizeof(hid));
> +	memcpy(hid, &tbl_msc->hardware_id_linked_device,
> +	       sizeof(tbl_msc->hardware_id_linked_device));

This is safe by semi-accident, since 16 > 8.

It might be cleaner to declare

	char hid[sizeof(tbl_msc->hardware_id_linked_device)];

which can never be wrong.

memset()+memcpy() might be better replaced with strscpy() (or just use
snprintf again, since this avoids having to think about multiple
different ways of avoiding buffer overflows at the same time.  This is
not a fast path.)

> +
> +	if (!strcmp(hid, ACPI_PROCESSOR_CONTAINER_HID)) {
> +		*acpi_id = tbl_msc->instance_id_linked_device;
> +		acpi_id_valid = true;
> +	}
> +
> +	err = snprintf(uid, sizeof(uid), "%u",

char uid[11]; would be sufficient, here.  The instance ID is strictly
32-bit.  Adding a safety margin is worthless here, since snprintf()
checks the bounds -- either the size is sufficient for all possible u32
values, or it isn't.

> +		       tbl_msc->instance_id_linked_device);

Can snprintf() return < 0 on error?

I don't know, but elsewhere you do check for this.  I tend to the view
that is cleaner to assume that the kernel's snprintf() is just as
hostile as C's version (if not more so).

(-1 >= sizeof(foo) is always true thanks to the C arithmetic conversion
rules, but it's probably best not to rely on it.)

> +	if (err >= sizeof(uid))
> +		return acpi_id_valid;

Possibly return true on error?  Why?

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
> +        struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_MPAM, 0);

checkpatch.pl says:

 | ERROR: code indent should use tabs where possible
 | #240: FILE: drivers/acpi/arm64/mpam.c:177:
 | +        struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_MPAM, 0);$
 | 
 | WARNING: please, no spaces at the start of a line
 | #240: FILE: drivers/acpi/arm64/mpam.c:177:
 | +        struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_MPAM, 0);$

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
> +		table_offset += tbl_msc->length;
> +
> +		/*
> +		 * If any of the reserved fields are set, make no attempt to
> +		 * parse the msc structure. This will prevent the driver from
> +		 * probing all the MSC, meaning it can't discover the system
> +		 * wide supported partid and pmg ranges. This avoids whatever
> +		 * this MSC is truncating the partids and creating a screaming

Mangled sentence?

I have not so far found any reference in [2] to the reset value of the
MPAMF_ECR.INTEN bit.  Do we rely on the error interrupt(s) for all MSCs
to be disabled at the interrupt controller?  If the same interrupt may
be shared by multiple MSCs, that's bad.

> +		 * error interrupt.
> +		 */
> +		if (tbl_msc->reserved || tbl_msc->reserved1 || tbl_msc->reserved2)
> +			continue;

The specs are not clear about how backwards compatibility is supposed
to work.

I would feel a bit uneasy about silently throwing away MSCs based on
critera that may not indicate incompatibility, and without even a
diagnostic.

> +
> +		if (!tbl_msc->mmio_size)
> +			continue;
> +
> +		if (decode_interface_type(tbl_msc, &iface))
> +			continue;

Ditto regarding diagnostics.

> +
> +		next_res = 0;
> +		next_prop = 0;
> +		memset(res, 0, sizeof(res));
> +		memset(props, 0, sizeof(props));
> +
> +		pdev = platform_device_alloc("mpam_msc", tbl_msc->identifier);

If the tbl_msc->identifier values contain duplicates, we will get a
platform device with a duplicate name here.  I don't know whether it
matters.

> +		if (!pdev) {
> +			err = -ENOMEM;
> +			break;
> +		}
> +
> +		if (tbl_msc->length < sizeof(*tbl_msc)) {
> +			err = -EINVAL;
> +			break;
> +		}

No check for oversized tbl_msc->length?  (See also
acpi_mpam_count_msc().)

> +
> +		/* Some power management is described in the namespace: */
> +		err = snprintf(uid, sizeof(uid), "%u", tbl_msc->identifier);
> +		if (err > 0 && err < sizeof(uid)) {
> +			companion = acpi_dev_get_first_match_dev("ARMHAA5C", uid, -1);

Diagnostic?

> +			if (companion)
> +				ACPI_COMPANION_SET(&pdev->dev, companion);
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
> +        struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_MPAM, 0);

checkpatch.pl says:

 | ERROR: code indent should use tabs where possible
 | #359: FILE: drivers/acpi/arm64/mpam.c:296:
 | +        struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_MPAM, 0);$
 | 
 | WARNING: please, no spaces at the start of a line
 | #359: FILE: drivers/acpi/arm64/mpam.c:296:
 | +        struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_MPAM, 0);$

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
> +	tbl_msc = (struct acpi_mpam_msc_node *)table_offset;

Can this be moved into the loop?  It looks like it just duplicates the
update to tbl_msc at the end of the loop; the loop termination
condition does not depend on this variable.

> +	table_end = (char *)table + table->length;
> +
> +	while (table_offset < table_end) {
> +		if (!tbl_msc->mmio_size)
> +			continue;

This is 0 for non-usable PCC-based MSCs, right?

(Why explicitly unusable MSCs are listed in the table at all is a
mystery to me, but that's what the spec says.  I guess there must be a
reason.)

> +
> +		if (tbl_msc->length < sizeof(*tbl_msc))
> +			return -EINVAL;

Should we also have something like (not tested):

if (tbl_msc->length > table_end - table_offset)
	return -EINVAL;

Also, is it an error if a length is not a multiple of four bytes?

(I'm guessing that the core ACPI code doesn't try to understand the
contents of the MPAM table and so doesn't check this.)

> +
> +		count++;
> +
> +		table_offset += tbl_msc->length;
> +		tbl_msc = (struct acpi_mpam_msc_node *)table_offset;
> +	}
> +
> +	return count;
> +}
> +
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
>  	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
>  	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
>  	ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI,
> -	ACPI_SIG_NBFT };
> +	ACPI_SIG_NBFT, ACPI_SIG_MPAM };
>  
>  #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
>  
> diff --git a/include/linux/arm_mpam.h b/include/linux/arm_mpam.h
> new file mode 100644
> index 000000000000..0edefa6ba019
> --- /dev/null
> +++ b/include/linux/arm_mpam.h
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2025 Arm Ltd. */

checkpatch.pl says:

 | WARNING: Improper SPDX comment style for 'include/linux/arm_mpam.h', please use '/*' instead
 | #414: FILE: include/linux/arm_mpam.h:1:
 | +// SPDX-License-Identifier: GPL-2.0
 | 
 | WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
 | #414: FILE: include/linux/arm_mpam.h:1:
 | +// SPDX-License-Identifier: GPL-2.0

(That's probably the same error twice.)

(I never understood why the SPDX folks couldn't have allowed either
type of comment -- or at least, the same style in .c and .h files.
But I'm sure they had a reason that they believed was good.)

[...]

Cheers
---Dave


[1] ACPI for Memory System Resource Partitioning and Monitoring, 3.0 beta
https://developer.arm.com/documentation/den0065/3-0bet/?lang=en

[2] Arm Memory System Resource Partitioning and Monitoring (MPAM)
System Component Specification, ARM IHI 0099A.a

