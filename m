Return-Path: <linux-acpi+bounces-16372-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3925B4444D
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 19:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC45C1CC18E9
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 17:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E5030ACFD;
	Thu,  4 Sep 2025 17:28:32 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDA91FBEBE;
	Thu,  4 Sep 2025 17:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757006912; cv=none; b=I0YwyI+VE3vGG+DFmWVXGD3l964/eoVHJ8KyrqE20kQ7M/xg6qKeCu4KahMMdRX+brZIYEf9CcVoCKaEhXIaf/wLqyxXIHLfcabFF9YgC8rKkGXU/pFDhA99s3PE1kDZ8KI3RUv3DMCEzM0Ji4VikPbM9tBx8ebTjRoR188w158=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757006912; c=relaxed/simple;
	bh=bb6T7lC3HiOTg+i9dbA6Lxu612i9hsWMILH58btsAYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbZsBSA040aFd2qoZQtHaXdl1r2G92dYZJy9IZBqXh8Nexf7pADyAJVa3TxVqzw0CHNZVix5FrtmZ3c6iN2SpiNT/tK74bdFgX2PdwoMGdADx6ndmTpWb7Z+o3VHh5gR0LhrX726/263E5LzOGk6kL5mhrIs39qHim3Lsr5Gi1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0AA516F8;
	Thu,  4 Sep 2025 10:28:20 -0700 (PDT)
Received: from [10.1.196.42] (eglon.cambridge.arm.com [10.1.196.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 128403F6A8;
	Thu,  4 Sep 2025 10:28:20 -0700 (PDT)
Message-ID: <38177077-53d9-4cb8-99ed-f6e637d72e5e@arm.com>
Date: Thu, 4 Sep 2025 18:28:17 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/33] ACPI / MPAM: Parse the MPAM table
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-9-james.morse@arm.com>
 <aK8sxLITHD9KeZyl@e133380.arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <aK8sxLITHD9KeZyl@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dave,

On 27/08/2025 17:05, Dave Martin wrote:
> On Fri, Aug 22, 2025 at 03:29:49PM +0000, James Morse wrote:
>> Add code to parse the arm64 specific MPAM table, looking up the cache
>> level from the PPTT and feeding the end result into the MPAM driver.
> 
> Might be worth mentioning that the hook for feeding the parsed factoids
> into the driver (mpam_ris_create()) is not implemented for now.

Sure,

>> diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
>> new file mode 100644
>> index 000000000000..e55fc2729ac5
>> --- /dev/null
>> +++ b/drivers/acpi/arm64/mpam.c
>> @@ -0,0 +1,331 @@

>> +#define ACPI_MPAM_MSC_IRQ_MODE_MASK                    BIT(0)
>> +#define ACPI_MPAM_MSC_IRQ_TYPE_MASK                    GENMASK(2, 1)
>> +#define ACPI_MPAM_MSC_IRQ_TYPE_WIRED                   0
>> +#define ACPI_MPAM_MSC_IRQ_AFFINITY_PROCESSOR_CONTAINER BIT(3)
>> +#define ACPI_MPAM_MSC_IRQ_AFFINITY_VALID               BIT(4)
>> +
>> +static bool frob_irq(struct platform_device *pdev, int intid, u32 flags,
>> +		     int *irq, u32 processor_container_uid)
> 
> Can this have a name, please?

parse_irq()? (but not all of it - only the bits that are duplicated)

How about parse_irq_common().


>> +{
>> +	int sense;
>> +
>> +	if (!intid)
>> +		return false;
>> +
>> +	if (FIELD_GET(ACPI_MPAM_MSC_IRQ_TYPE_MASK, flags) !=
>> +	    ACPI_MPAM_MSC_IRQ_TYPE_WIRED)
>> +		return false;
>> +
>> +	sense = FIELD_GET(ACPI_MPAM_MSC_IRQ_MODE_MASK, flags);

> Do we handle cross-endian ACPI tables?

ACPI depends on UEFI, which is little endian only.


> ACPI defers to the relevant specification regarding the endianness of
> externally defined tables, but as of v3.0 (beta) of for MPAM ACPI
> spec [1], no statement is made about this.
> 
> Following the spirit of the ACPI core specs, I suspect that the
> "correct" answer is that MPAM tables are always little-endian, even if
> it not written down anywhere.
> 
> If the kernel is big-endian, we lose.
> 
> Maybe it is sufficient to make CONFIG_ACPI_MPAM depend on
> !CONFIG_CPU_BIG_ENDIAN for now.
> 
> 
> I haven't tried to understand how this is handled for other tables.

There is no way to hand the tables to the OS. I don't think this needs explict handling,
it all just falls out in the wash.


>> +
>> +	/*
>> +	 * If the GSI is in the GIC's PPI range, try and create a partitioned
>> +	 * percpu interrupt.
> 
> But actually we don't even try?  Or did I miss something?

Ah - I ripped that out on the assumption no-one was using it. I'll drop the comment.
No-one has squealed yet!

It's works out the box on DT systems, and can be described in the MPAM ACPI table - but
without a platform, there is no need for the irqchip juggling to make it work. Hence the
pr_err_once().


>> +	 */
>> +	if (16 <= intid && intid < 32 && processor_container_uid != ~0) {
> 
> checkpatch.pl says:
> 
>  | WARNING: Comparisons should place the constant on the right side of the test
>  | #108: FILE: drivers/acpi/arm64/mpam.c:45:
>  | +       if (16 <= intid && intid < 32 && processor_container_uid != ~0) {
> 
> (Dubious whether this is "wrong" IMHO, but still probably best avoided
> since it is not what people are used to seeing.)

If it were a single comparison I'd agree, but as its two, I find this a lot easier to read
as 'intid is between 16 and 32' than the alternative.


>> +		pr_err_once("Partitioned interrupts not supported\n");
>> +		return false;
>> +	}
>> +
>> +	*irq = acpi_register_gsi(&pdev->dev, intid, sense, ACPI_ACTIVE_HIGH);
>> +	if (*irq <= 0) {
>> +		pr_err_once("Failed to register interrupt 0x%x with ACPI\n",
>> +			    intid);
> 
> Are we going to get a lot of duplicate error messages with the same
> interrupt?  If not, perhaps make this a pr_err() so that all the
> affected interrupts are notified?
> 
> (Either way, hopefully the user will take the hint that they messed
> something up though.)

The hardware people figured they could get the OS to distribute the configuration to all
the nodes in the mesh, so there are platforms with hundreds of MSC. They also like to
share the interrupts, so if you mess the interrupt description up - you get hundreds of
messages.
To avoid spamming the log for what is likely to be a frequently repeated mistake, these
are all 'once'.


>> +		return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>> +static void acpi_mpam_parse_irqs(struct platform_device *pdev,
>> +				 struct acpi_mpam_msc_node *tbl_msc,
>> +				 struct resource *res, int *res_idx)
>> +{
>> +	u32 flags, aff;
>> +	int irq;

> We may still get in here if MPAMF_IDR.HAS_ERR_MSI and/or
> MPAMF_MSMON_IDR.HAS_OFLW_MSI is set.

(this code can't know that)


> If so, there is no wired
> interrupt.  Does it matter if we still parse and allocate the wired
> interrupts here?

I don't think we do - frob_irq() will return false if the 'wired' flag is not set in the
table, so the 'res[(*res_idx)++]' step will be skipped, and the callers array is left
unmodified. The struct property_entry array is null-terminated, and gets copied anyway.


>> +	flags = tbl_msc->overflow_interrupt_flags;
>> +	if (flags & ACPI_MPAM_MSC_IRQ_AFFINITY_VALID &&
>> +	    flags & ACPI_MPAM_MSC_IRQ_AFFINITY_PROCESSOR_CONTAINER)
>> +		aff = tbl_msc->overflow_interrupt_affinity;
>> +	else
>> +		aff = ~0;
> 
> (u32)~0 is used as an exceptional UID all over the place.  If this is
> not a pre-existing convention, it could be worth having a #define for
> this.  (grep '~0' drivers/acpi/ suggests that this is new.)

It's not normal to describe the affinity of an interrupt in tables like this...
The MPAM ACPI spec allows you to describe the PPI affinity because the MSC can be local to
a CPU, (e.g. the L2 cache), and the MPAM architecture spec says it can be a PPI.
We have support for this on DT systems, so it wasn't possible to argue "no one would ever
do that"!



>> +	if (frob_irq(pdev, tbl_msc->overflow_interrupt, flags, &irq, aff))
>> +		res[(*res_idx)++] = DEFINE_RES_IRQ_NAMED(irq, "overflow");
> 
> I couldn't find a statement in the spec of how the table can specify
> that there is no interrupt.

With zero in the GSI field, from the spec:
| If this MSC does not support overflow interrupts or monitors, this field must be set
| to 0.

Which is detected in frob_irq() as:
|	if (!intid)
|		return false;


> Are the interrupts always required for ACPI-based MPAM systems?

In practice they're optional.


> overflow_interrupt and error_interrupt are GSIVs, which seems to be an
> ACPI thing.

It's a flat space of interrupt IDs - no need to shift the values around for the
SGI/PPI/SPI range. (aka IPI, percpu interrupt or plain old wired interrupt)


> The examples in the ACPI spec suggest that 0 can be a valid value.

Pretty sure its not - it would be a secure SGI. The MPAM spec uses it as 'invalid'.


> No exceptional value seems to be defined.
> 
> The flags fields have some invalid encodings, but no explicit "no
> interrupt" encoding that I can see.

I think you missed it hidden as 'and another thing' in the description of the field.


>> +
>> +	flags = tbl_msc->error_interrupt_flags;
>> +	if (flags & ACPI_MPAM_MSC_IRQ_AFFINITY_VALID &&
>> +	    flags & ACPI_MPAM_MSC_IRQ_AFFINITY_PROCESSOR_CONTAINER)
>> +		aff = tbl_msc->error_interrupt_affinity;
>> +	else
>> +		aff = ~0;
>> +	if (frob_irq(pdev, tbl_msc->error_interrupt, flags, &irq, aff))
>> +		res[(*res_idx)++] = DEFINE_RES_IRQ_NAMED(irq, "error");
>> +}
>> +
>> +static int acpi_mpam_parse_resource(struct mpam_msc *msc,
>> +				    struct acpi_mpam_resource_node *res)
>> +{
>> +	int level, nid;
>> +	u32 cache_id;
>> +
>> +	switch (res->locator_type) {
>> +	case ACPI_MPAM_LOCATION_TYPE_PROCESSOR_CACHE:
>> +		cache_id = res->locator.cache_locator.cache_reference;
>> +		level = find_acpi_cache_level_from_id(cache_id);
>> +		if (level <= 0) {
>> +			pr_err_once("Bad level (%u) for cache with id %u\n", level, cache_id);
>> +			return -EINVAL;
>> +		}
>> +		return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_CACHE,
>> +				       level, cache_id);
>> +	case ACPI_MPAM_LOCATION_TYPE_MEMORY:
>> +		nid = pxm_to_node(res->locator.memory_locator.proximity_domain);
>> +		if (nid == NUMA_NO_NODE)
>> +			nid = 0;
>> +		return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_MEMORY,
>> +				       255, nid);
>> +	default:
>> +		/* These get discovered later and treated as unknown */
>> +		return 0;
>> +	}
>> +}
>> +
>> +int acpi_mpam_parse_resources(struct mpam_msc *msc,
>> +			      struct acpi_mpam_msc_node *tbl_msc)
>> +{
>> +	int i, err;
>> +	struct acpi_mpam_resource_node *resources;
>> +
>> +	resources = (struct acpi_mpam_resource_node *)(tbl_msc + 1);

> Should we check that we don't go out of the bounds of the MSC node
> (or, at the very least, of the MPAM table)?
> 
> If tbl_msc->length was already validated, that can be used for the
> bounds check.

I'm not a fan of trying to validate the APCI tables - its extra work for something that
just has to be right. e.g. we can't check the base-address, we just have to trust its correct.

I didn't want to pass the table in here, and grabbing another reference means I'd have to
work out if its the same mapping...

But as tbl_msc->length is to hand...



>> +	for (i = 0; i < tbl_msc->num_resource_nodes; i++) {
>> +		err = acpi_mpam_parse_resource(msc, &resources[i]);
> 
> Isn't the length of each resource node variable?  According to [2],
> the length depends on the num_functional_deps field.  It looks like the
> functional dependency descriptors (if any) are appended contiguously to
> the resource node, unless I've misunderstood something.

No - it proably is that broken. They forgot to include a length field, painting themselves
into a corner if they ever want to modify this!

I was ignoring the 'functional dependencies' until someone comes up with a platform that
needs it. But yes, this assumes that field is zero.

I'm not entirely clear what the MPAM driver is supposed to do with functional
dependencies: 'make up a configuration' ... but when the controls formats are different,
its going to get exciting.

I'ved fixed that up:
| int acpi_mpam_parse_resources(struct mpam_msc *msc,
| 			      struct acpi_mpam_msc_node *tbl_msc)
| {
| 	int i, err;
|	char *ptr, *last_byte;
| 	struct acpi_mpam_resource_node *resource;
|
| 	ptr = (char *)(tbl_msc + 1);
| 	last_byte = ptr + tbl_msc->length;
| 	for (i = 0; i < tbl_msc->num_resource_nodes; i++) {
| 		if (ptr + sizeof(*resource) > last_byte)
| 			return -EINVAL;
|
| 		resource = (struct acpi_mpam_resource_node *)ptr;
| 		err = acpi_mpam_parse_resource(msc, resource);
| 		if (err)
| 			return err;
|
| 		ptr += sizeof(*resource);
| 		ptr += resource->num_functional_deps * sizeof(struct acpi_mpam_func_deps);
| 	}
|
| 	return 0;
| }





>> +		if (err)
>> +			return err;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static bool __init parse_msc_pm_link(struct acpi_mpam_msc_node *tbl_msc,
>> +				     struct platform_device *pdev,
>> +				     u32 *acpi_id)
>> +{
>> +	bool acpi_id_valid = false;
>> +	struct acpi_device *buddy;
>> +	char hid[16], uid[16];
>> +	int err;
>> +
>> +	memset(&hid, 0, sizeof(hid));
>> +	memcpy(hid, &tbl_msc->hardware_id_linked_device,
>> +	       sizeof(tbl_msc->hardware_id_linked_device));
> 
> This is safe by semi-accident, since 16 > 8.
> 
> It might be cleaner to declare
> 
> 	char hid[sizeof(tbl_msc->hardware_id_linked_device)];
> 
> which can never be wrong.

But can be too precise!


> memset()+memcpy() might be better replaced with strscpy() (or just use
> snprintf again, since this avoids having to think about multiple
> different ways of avoiding buffer overflows at the same time.  This is
> not a fast path.)

snprintf() demands space for a NULL byte - but these APCI tables fields are fixed width,
so don't have them.

The array sizes picked are the next larger power of 2, and the memset is ensure there is a
NULL byte after the fixed size region is copied in.

Where snprintf() is being used - its to convert from integer to string. For the hid, what
we really want is a fixed size memcpy() ... its possible to cook up a format string that
will do that, but its going to be an eye sore.

I can change this to;
| char hid[sizeof(tbl_msc->hardware_id_linked_device) + 1];

But I don't think this is better... How about a comment?!
|	/*
|	 * tbl_msc->hardware_id_linked_device is an 8 byte fixed width string.
|	 * hid[] is the next larger power of 2, and is zero'd to give us a
|	 * null terminated string for acpi_dev_get_first_match_dev().
|	 */


This is all because the MPAM stuff was forced into a static table, even though it needs to
refer to stuff in the namespace.


>> +
>> +	if (!strcmp(hid, ACPI_PROCESSOR_CONTAINER_HID)) {
>> +		*acpi_id = tbl_msc->instance_id_linked_device;
>> +		acpi_id_valid = true;
>> +	}
>> +
>> +	err = snprintf(uid, sizeof(uid), "%u",
> 
> char uid[11]; would be sufficient, here.  The instance ID is strictly
> 32-bit.  Adding a safety margin is worthless here, since snprintf()
> checks the bounds -- either the size is sufficient for all possible u32
> values, or it isn't.

I just plumped for the next largest power of 2.


>> +		       tbl_msc->instance_id_linked_device);
> 
> Can snprintf() return < 0 on error?

Documented as returning a positive number.


> I don't know, but elsewhere you do check for this.  I tend to the view
> that is cleaner to assume that the kernel's snprintf() is just as
> hostile as C's version (if not more so).
> 
> (-1 >= sizeof(foo) is always true thanks to the C arithmetic conversion
> rules, but it's probably best not to rely on it.)
> 
>> +	if (err >= sizeof(uid))
>> +		return acpi_id_valid;
> 
> Possibly return true on error?  Why?

(this is an error case that will never happen - but error handling is important!)

The acpi_id was parsed out of the table and returned to the caller. Hence true is
returned. This gets used to find the CPU-affinity, which is how the driver avoids
accessing caches that might not be on. There are sanity checks around this value. It can't
be present for some caches and not others.

Due to this error, the link to the buddy device was not added - which is silently ignored.
If it matters, it will show up as an access to a device that didn't get turned on by the
power-management code, because of that missing link.

Because I don't think this can happpen, I didn't try to handle it explicitly - just carry
on like nothing is wrong.


>> +	buddy = acpi_dev_get_first_match_dev(hid, uid, -1);
>> +	if (buddy)
>> +		device_link_add(&pdev->dev, &buddy->dev, DL_FLAG_STATELESS);
>> +
>> +	return acpi_id_valid;
>> +}
>> +
>> +static int decode_interface_type(struct acpi_mpam_msc_node *tbl_msc,
>> +				 enum mpam_msc_iface *iface)
>> +{
>> +	switch (tbl_msc->interface_type) {
>> +	case 0:
>> +		*iface = MPAM_IFACE_MMIO;
>> +		return 0;
>> +	case 0xa:
>> +		*iface = MPAM_IFACE_PCC;
>> +		return 0;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int __init acpi_mpam_parse(void)
>> +{
>> +        struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_MPAM, 0);
> 
> checkpatch.pl says:
> 
>  | ERROR: code indent should use tabs where possible
>  | #240: FILE: drivers/acpi/arm64/mpam.c:177:
>  | +        struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_MPAM, 0);$
>  | 
>  | WARNING: please, no spaces at the start of a line
>  | #240: FILE: drivers/acpi/arm64/mpam.c:177:
>  | +        struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_MPAM, 0);$

Pff, I copied that from Jonathan's email because of its rune like nature.


>> +	char *table_end, *table_offset = (char *)(table + 1);
>> +	struct property_entry props[4]; /* needs a sentinel */
>> +	struct acpi_mpam_msc_node *tbl_msc;
>> +	int next_res, next_prop, err = 0;
>> +	struct acpi_device *companion;
>> +	struct platform_device *pdev;
>> +	enum mpam_msc_iface iface;
>> +	struct resource res[3];
>> +	char uid[16];
>> +	u32 acpi_id;
>> +
>> +	if (acpi_disabled || !system_supports_mpam() || IS_ERR(table))
>> +		return 0;
>> +
>> +	if (IS_ERR(table))
>> +		return 0;
>> +
>> +	if (table->revision < 1)
>> +		return 0;
>> +
>> +	table_end = (char *)table + table->length;
>> +
>> +	while (table_offset < table_end) {
>> +		tbl_msc = (struct acpi_mpam_msc_node *)table_offset;
>> +		table_offset += tbl_msc->length;
>> +
>> +		/*
>> +		 * If any of the reserved fields are set, make no attempt to
>> +		 * parse the msc structure. This will prevent the driver from
>> +		 * probing all the MSC, meaning it can't discover the system
>> +		 * wide supported partid and pmg ranges. This avoids whatever
>> +		 * this MSC is truncating the partids and creating a screaming
> 
> Mangled sentence?

just hard to parse:
"whatever this MSC is" "truncating the parids..."

Fixed as
| This avoids this MSC truncating the partids and creating a screaming error interrupt.

(although its not strictly the MSC that does that)


> I have not so far found any reference in [2] to the reset value of the
> MPAMF_ECR.INTEN bit.  Do we rely on the error interrupt(s) for all MSCs
> to be disabled at the interrupt controller?  If the same interrupt may
> be shared by multiple MSCs, that's bad.

They are anticipated as shared because the ESR register lets us know if this MSC triggered
the error.

The interrupt won't be delivered until the driver requests it - it'll just stay pending.

Yes - if some firwmare component used an out-of-range PARTID then linux will believe that
this was caused by linux and disable MPAM. Not much we can do about that.

(I've even seen a platform where this happens!)


>> +		 * error interrupt.
>> +		 */
>> +		if (tbl_msc->reserved || tbl_msc->reserved1 || tbl_msc->reserved2)
>> +			continue;

> The specs are not clear about how backwards compatibility is supposed
> to work.

How about that!

The spec people thought this would allow them to add things that aren't MSC in, re-using
one of these reserved fields as a type.
But - the architecture spec mandates the OS run around the MSC and collect the minimum
PARTID/PMG values (so people don't have to build an SoC where everything fits together
nicely). Because of that, the OS needs to know how many MSC there are, so that it knows it
has probed them all.


> I would feel a bit uneasy about silently throwing away MSCs based on
> critera that may not indicate incompatibility, and without even a
> diagnostic.

Yes the MSC gets thrown away - but it was still counted by acpi_mpam_count_msc(). The MPAM
driver will never probe all the MSC, so it will never call mpam_enable().

(you used to be able to see which cpuhp callback was registeered, to know it was stuck in
discovery, but now a helper does that which always uses the same name. I may fix that)


I think its fine for MPAM to silently fail to probe like this. The system still works, all
the known hardware gets probed and none of the unknown hardware is touched. (so it can't
blow us up). You don't get resctrl - but we can't know if the unknown hardware was going
to be important to supporting MPAM. e.g. it lowers the minimum usable PARTID/PMG.

It's between a rock and a hard place - I think this  behaviour is the best we can do.


Regarding it being silent - whatever happens it needs a kernel upgrade to learn about the
newly described hardware. I don't think its worth printing anything out in this case.


>> +
>> +		if (!tbl_msc->mmio_size)
>> +			continue;
>> +
>> +		if (decode_interface_type(tbl_msc, &iface))
>> +			continue;
> 
> Ditto regarding diagnostics.

A third interface type will result in those MSC being untouched, and MPAM unavailable.
I don't think printing "maybe upgrade your kernel?" is going to help anyone.

I'll chuck some pr_debug() in here so someone could find out which of these it is.


>> +
>> +		next_res = 0;
>> +		next_prop = 0;
>> +		memset(res, 0, sizeof(res));
>> +		memset(props, 0, sizeof(props));
>> +
>> +		pdev = platform_device_alloc("mpam_msc", tbl_msc->identifier);
> 
> If the tbl_msc->identifier values contain duplicates, we will get a
> platform device with a duplicate name here.  I don't know whether it
> matters.

The identifiers must be unique. I don't think this is the sort of table validation we need
to do for the firmware vendor.


>> +		if (!pdev) {
>> +			err = -ENOMEM;
>> +			break;
>> +		}
>> +
>> +		if (tbl_msc->length < sizeof(*tbl_msc)) {
>> +			err = -EINVAL;
>> +			break;
>> +		}

> No check for oversized tbl_msc->length?

You want it to parse the whole thing to check if firmware got the length field right?
I don't think we can know that. If its wrong, firmware may just have easily got the number
of RIS, or some other field wrong.

Historically x86 using to rummage around in memory to see if it could find something that
looked like ACPI tables. I'd imagine it was important to parse those carefully, as they
may never have been APCI table. We don't have this problem on arm64 - the ACPI tables were
handed over from UEFI. If the value is wrong - the firmware vendor meant it to be wrong.


> (See also acpi_mpam_count_msc().)
> 
>> +
>> +		/* Some power management is described in the namespace: */
>> +		err = snprintf(uid, sizeof(uid), "%u", tbl_msc->identifier);
>> +		if (err > 0 && err < sizeof(uid)) {
>> +			companion = acpi_dev_get_first_match_dev("ARMHAA5C", uid, -1);
> 
> Diagnostic?
> 
>> +			if (companion)
>> +				ACPI_COMPANION_SET(&pdev->dev, companion);
>> +		}
>> +
>> +		if (iface == MPAM_IFACE_MMIO) {
>> +			res[next_res++] = DEFINE_RES_MEM_NAMED(tbl_msc->base_address,
>> +							       tbl_msc->mmio_size,
>> +							       "MPAM:MSC");
>> +		} else if (iface == MPAM_IFACE_PCC) {
>> +			props[next_prop++] = PROPERTY_ENTRY_U32("pcc-channel",
>> +								tbl_msc->base_address);
>> +			next_prop++;
>> +		}
>> +
>> +		acpi_mpam_parse_irqs(pdev, tbl_msc, res, &next_res);
>> +		err = platform_device_add_resources(pdev, res, next_res);
>> +		if (err)
>> +			break;
>> +
>> +		props[next_prop++] = PROPERTY_ENTRY_U32("arm,not-ready-us",
>> +							tbl_msc->max_nrdy_usec);
>> +
>> +		/*
>> +		 * The MSC's CPU affinity is described via its linked power
>> +		 * management device, but only if it points at a Processor or
>> +		 * Processor Container.
>> +		 */
>> +		if (parse_msc_pm_link(tbl_msc, pdev, &acpi_id)) {
>> +			props[next_prop++] = PROPERTY_ENTRY_U32("cpu_affinity",
>> +								acpi_id);
>> +		}
>> +
>> +		err = device_create_managed_software_node(&pdev->dev, props,
>> +							  NULL);
>> +		if (err)
>> +			break;
>> +
>> +		/* Come back later if you want the RIS too */
>> +		err = platform_device_add_data(pdev, tbl_msc, tbl_msc->length);
>> +		if (err)
>> +			break;
>> +
>> +		err = platform_device_add(pdev);
>> +		if (err)
>> +			break;
>> +	}
>> +
>> +	if (err)
>> +		platform_device_put(pdev);
>> +
>> +	return err;
>> +}
>> +
>> +int acpi_mpam_count_msc(void)
>> +{
>> +        struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_MPAM, 0);
> 
> checkpatch.pl says:
> 
>  | ERROR: code indent should use tabs where possible
>  | #359: FILE: drivers/acpi/arm64/mpam.c:296:
>  | +        struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_MPAM, 0);$
>  | 
>  | WARNING: please, no spaces at the start of a line
>  | #359: FILE: drivers/acpi/arm64/mpam.c:296:
>  | +        struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_MPAM, 0);$
> 

Yup, runes copied from Jonathan's email.


>> +	char *table_end, *table_offset = (char *)(table + 1);
>> +	struct acpi_mpam_msc_node *tbl_msc;
>> +	int count = 0;
>> +
>> +	if (IS_ERR(table))
>> +		return 0;
>> +
>> +	if (table->revision < 1)
>> +		return 0;
>> +
>> +	tbl_msc = (struct acpi_mpam_msc_node *)table_offset;
> 
> Can this be moved into the loop?  It looks like it just duplicates the
> update to tbl_msc at the end of the loop; the loop termination
> condition does not depend on this variable.

Yup - looks like this used to be a do {} while () ; loop.


>> +	table_end = (char *)table + table->length;
>> +
>> +	while (table_offset < table_end) {
>> +		if (!tbl_msc->mmio_size)
>> +			continue;
> 
> This is 0 for non-usable PCC-based MSCs, right?
> 
> (Why explicitly unusable MSCs are listed in the table at all is a
> mystery to me, but that's what the spec says.  I guess there must be a
> reason.)

Some firmwware stacks have pre-built ACPI tables, then go knock out the enabled bits based
on what the platform actually has. This is easier than rebuilding the table...


>> +
>> +		if (tbl_msc->length < sizeof(*tbl_msc))
>> +			return -EINVAL;
> 
> Should we also have something like (not tested):
> 
> if (tbl_msc->length > table_end - table_offset)
> 	return -EINVAL;

Sure,


> Also, is it an error if a length is not a multiple of four bytes?

Hmmm, because all the subtables in the sepc are multiples of four bytes?
I think this falls in the bucket of 'table validation the OS shouldn't have to do'.
If the ACPI tables are that wrong, we're going to have bigger problems.


> (I'm guessing that the core ACPI code doesn't try to understand the
> contents of the MPAM table and so doesn't check this.)

It doesn't.


>> +
>> +		count++;
>> +
>> +		table_offset += tbl_msc->length;
>> +		tbl_msc = (struct acpi_mpam_msc_node *)table_offset;
>> +	}
>> +
>> +	return count;
>> +}

>> diff --git a/include/linux/arm_mpam.h b/include/linux/arm_mpam.h
>> new file mode 100644
>> index 000000000000..0edefa6ba019
>> --- /dev/null
>> +++ b/include/linux/arm_mpam.h
>> @@ -0,0 +1,46 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (C) 2025 Arm Ltd. */
> 
> checkpatch.pl says:
> 
>  | WARNING: Improper SPDX comment style for 'include/linux/arm_mpam.h', please use '/*' instead
>  | #414: FILE: include/linux/arm_mpam.h:1:
>  | +// SPDX-License-Identifier: GPL-2.0
>  | 
>  | WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
>  | #414: FILE: include/linux/arm_mpam.h:1:
>  | +// SPDX-License-Identifier: GPL-2.0
> 
> (That's probably the same error twice.)
> 
> (I never understood why the SPDX folks couldn't have allowed either
> type of comment -- or at least, the same style in .c and .h files.
> But I'm sure they had a reason that they believed was good.)

Fixed,


Thanks,

James

