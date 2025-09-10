Return-Path: <linux-acpi+bounces-16600-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A52B520D0
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 21:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF57483404
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 19:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F142D6611;
	Wed, 10 Sep 2025 19:20:04 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F8F2D46C9;
	Wed, 10 Sep 2025 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532004; cv=none; b=B8Zw8p7KO1v1jwuo762aO3OfnYhr9H3u61hyDJVPPtWGPfKrG2Zw1NOGomAy7i/qXHDlmOZwFBDH7QRT8uDnyFLvGyvTqM8+0GeknCXu94bRtJ9RM3VWhtiffLmkQzdBp0pG7Xsw1LAfPfGZH7WSRWBP2WI+PfIzdVUaoFmMIoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532004; c=relaxed/simple;
	bh=ygwwTqieSKf+WhuMkqi1rzq5rUWvDTqmHg2rCFTMSE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIkDTUJaGZtXGodgyqXIWT7dEU6NAp5YBzAlQYXncHouom/rRGVLwX3oNIhNK4td6dJBgnlLgoSqSV0iBulKeFf6C5Q2Q7MdBbYHd2/Ch1/W0lVY4iFTrq8Br8cTe5Og0fgkyxdNg4LCDCjjdstHLvrXRxaOwxRRuj1mElLaQL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39E9916F2;
	Wed, 10 Sep 2025 12:19:53 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C8793F694;
	Wed, 10 Sep 2025 12:19:55 -0700 (PDT)
Message-ID: <0835f7e4-a6d3-47be-9f33-3073889d4b01@arm.com>
Date: Wed, 10 Sep 2025 20:19:53 +0100
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
 <38177077-53d9-4cb8-99ed-f6e637d72e5e@arm.com>
 <aLsSE3IFh9xaaMJM@e133380.arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <aLsSE3IFh9xaaMJM@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dave,

On 05/09/2025 17:38, Dave Martin wrote:
> On Thu, Sep 04, 2025 at 06:28:17PM +0100, James Morse wrote:
>> On 27/08/2025 17:05, Dave Martin wrote:
>>> On Fri, Aug 22, 2025 at 03:29:49PM +0000, James Morse wrote:
>>>> Add code to parse the arm64 specific MPAM table, looking up the cache
>>>> level from the PPTT and feeding the end result into the MPAM driver.
>>>
>>> Might be worth mentioning that the hook for feeding the parsed factoids
>>> into the driver (mpam_ris_create()) is not implemented for now.
>>
>> Sure,
>>
>>>> diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
> 
> [...]
> 
>>>> +static bool frob_irq(struct platform_device *pdev, int intid, u32 flags,
>>>> +		     int *irq, u32 processor_container_uid)
>>>
>>> Can this have a name, please?
>>
>> parse_irq()? (but not all of it - only the bits that are duplicated)
>> How about parse_irq_common().
> 
> That is inoffensive, but since this is where the interrupt is validated
> as usable and an attempt is made to reqister it -- and this is
> basically all the function seems to do right now, would
> 
> 	acpi_mpam_register_irq()
> 
> or similar make sense, here?

Sure,


>>>> +{
>>>> +	int sense;
>>>> +
>>>> +	if (!intid)
>>>> +		return false;
>>>> +
>>>> +	if (FIELD_GET(ACPI_MPAM_MSC_IRQ_TYPE_MASK, flags) !=
>>>> +	    ACPI_MPAM_MSC_IRQ_TYPE_WIRED)
>>>> +		return false;
>>>> +
>>>> +	sense = FIELD_GET(ACPI_MPAM_MSC_IRQ_MODE_MASK, flags);
>>
>>> Do we handle cross-endian ACPI tables?
>>
>> ACPI depends on UEFI, which is little endian only.
>>
>>
>>> ACPI defers to the relevant specification regarding the endianness of
>>> externally defined tables, but as of v3.0 (beta) of for MPAM ACPI
>>> spec [1], no statement is made about this.
>>>
>>> Following the spirit of the ACPI core specs, I suspect that the
>>> "correct" answer is that MPAM tables are always little-endian, even if
>>> it not written down anywhere.
>>>
>>> If the kernel is big-endian, we lose.
>>>
>>> Maybe it is sufficient to make CONFIG_ACPI_MPAM depend on
>>> !CONFIG_CPU_BIG_ENDIAN for now.
>>>
>>>
>>> I haven't tried to understand how this is handled for other tables.
>>
>> There is no way to hand the tables to the OS. I don't think this needs explict handling,
>> it all just falls out in the wash.
> 
> (I'm not sure what you mean by not being able to hand tables to the OS.
> How did Linux get them?)

Your hypothetical cross-endian machine would have to be a big-endian kernel running with
little-endian ACPI tables. UEFI is little-endian, UEFI is the only mechanism for handing
ACPI tables to the kernel ... there is no mechanism for a big-endian kernel to get hold of
ACPI tables.


> But in any case, if the BE case is not handled by the Linux ACPI code
> in general then it almost certainly doesn't make sense to handle it
> here.
> 
> (There are a lot of BE-handling macros in the imported ACPICA headers
> in the kernel tree, which made me wonder whether this was a thing.)

Nothing defines ACPI_BIG_ENDIAN ... I don't know why acpica supports it, but linux doesn't
use it.

[...]

>>>> +		return false;
>>>> +	}
>>>> +
>>>> +	return true;
>>>> +}
>>>> +
>>>> +static void acpi_mpam_parse_irqs(struct platform_device *pdev,
>>>> +				 struct acpi_mpam_msc_node *tbl_msc,
>>>> +				 struct resource *res, int *res_idx)
>>>> +{
>>>> +	u32 flags, aff;
>>>> +	int irq;
>>
>>> We may still get in here if MPAMF_IDR.HAS_ERR_MSI and/or
>>> MPAMF_MSMON_IDR.HAS_OFLW_MSI is set.
>>
>> (this code can't know that)
>>
>>
>>> If so, there is no wired
>>> interrupt.  Does it matter if we still parse and allocate the wired
>>> interrupts here?
>>
>> I don't think we do - frob_irq() will return false if the 'wired' flag is not set in the
>> table, so the 'res[(*res_idx)++]' step will be skipped, and the callers array is left
>> unmodified. The struct property_entry array is null-terminated, and gets copied anyway.
>>
>>
>>>> +	flags = tbl_msc->overflow_interrupt_flags;
>>>> +	if (flags & ACPI_MPAM_MSC_IRQ_AFFINITY_VALID &&
>>>> +	    flags & ACPI_MPAM_MSC_IRQ_AFFINITY_PROCESSOR_CONTAINER)
>>>> +		aff = tbl_msc->overflow_interrupt_affinity;
>>>> +	else
>>>> +		aff = ~0;
>>>
>>> (u32)~0 is used as an exceptional UID all over the place.  If this is
>>> not a pre-existing convention, it could be worth having a #define for
>>> this.  (grep '~0' drivers/acpi/ suggests that this is new.)
>>
>> It's not normal to describe the affinity of an interrupt in tables like this...
>> The MPAM ACPI spec allows you to describe the PPI affinity because the MSC can be local to
>> a CPU, (e.g. the L2 cache), and the MPAM architecture spec says it can be a PPI.
>> We have support for this on DT systems, so it wasn't possible to argue "no one would ever
>> do that"!
> 
> I guess this is OK.
> 
> (My misgivings about ~0 are partly due to the way C evaluates expressions.
> The conversion to the destination type occus only after the ~ is evaulated,
> so if the affected type is changed to a 64-bit type during maintenance
> (or by copy-pasting into another context), then it's easy to end up with
> with wrong values in the high bits.  The definition
> 
> 	u64 x = ~0;
> 
> does indeed set x to all ones, but I find the reason _why_ this works
> counterintuitive, and superficially similar expressions can go wrong.
> Having a #define only requires this to be got right in one place.)

Thanks for the background.


>>>> +	if (frob_irq(pdev, tbl_msc->overflow_interrupt, flags, &irq, aff))
>>>> +		res[(*res_idx)++] = DEFINE_RES_IRQ_NAMED(irq, "overflow");
>>>
>>> I couldn't find a statement in the spec of how the table can specify
>>> that there is no interrupt.
>>
>> With zero in the GSI field, from the spec:
>> | If this MSC does not support overflow interrupts or monitors, this field must be set
>> | to 0.
>>
>> Which is detected in frob_irq() as:
>> |	if (!intid)
>> |		return false;
>>
>>
>>> Are the interrupts always required for ACPI-based MPAM systems?
>>
>> In practice they're optional.
>>
>>
>>> overflow_interrupt and error_interrupt are GSIVs, which seems to be an
>>> ACPI thing.
>>
>> It's a flat space of interrupt IDs - no need to shift the values around for the
>> SGI/PPI/SPI range. (aka IPI, percpu interrupt or plain old wired interrupt)
>>
>>
>>> The examples in the ACPI spec suggest that 0 can be a valid value.
>>> No exceptional value seems to be defined.
>>>
>>> The flags fields have some invalid encodings, but no explicit "no
>>> interrupt" encoding that I can see.
>>
>> I think you missed it hidden as 'and another thing' in the description of the field.
> 
> I was being diplomatic.  I meant: "explicitly uses this as an example
> of a valid value."

I can ask the spec people to clarify things - but I'm not entirely sure what the request
is. An example entry in the appendix for a system with no interrupts?


>> Pretty sure its not - it would be a secure SGI. The MPAM spec uses it as 'invalid'.
> 
> I guess that's is a Arm-ism, then.  So long as this is standard for
> ACPI on Arm systems, then I guess there is no problem -- and anyway,
> the ACPI MPAM spec would take precedence for interpreting this field.
> 
> Now I look more closely, you're right: the ACPI MPAM spec says, e.g.:
> "If the MSC supports MSI, as indicated by the
> MPAMF_MSMON_IDR.HAS_OFLW_MSI bit, then this field must be set to 0 and
> ignored by the OS.  If this MSC does not support overflow interrupts or
> monitors, this field must be set to 0".
> 
> This does not say that the value 0 means there is no wired interrupt,
> but that seems to be the intention.
> 
> It could be better worded, but the intention does seem to be that 0
> means "no (wired) interrupt", here...

I'll copy you on the thread to the spec people.


>>>> +
>>>> +	flags = tbl_msc->error_interrupt_flags;
>>>> +	if (flags & ACPI_MPAM_MSC_IRQ_AFFINITY_VALID &&
>>>> +	    flags & ACPI_MPAM_MSC_IRQ_AFFINITY_PROCESSOR_CONTAINER)
>>>> +		aff = tbl_msc->error_interrupt_affinity;
>>>> +	else
>>>> +		aff = ~0;
>>>> +	if (frob_irq(pdev, tbl_msc->error_interrupt, flags, &irq, aff))
>>>> +		res[(*res_idx)++] = DEFINE_RES_IRQ_NAMED(irq, "error");
> 
> intid 0 gets ignored by frob_irq(), so I guess we are OK in the MSI
> case (the spec says we must ignore it, but also says that it must be
> zero).
> 
> It would be onerous to have to map the MSC and examine its ID regs
> here assuming that the intid really is 0 in the MSI case seems
> reasonable.

Registering+Requesting MSI would be up to the driver to do, there is no reason for this
ACPI parsing code to get involved with that.


>>>> +static int acpi_mpam_parse_resource(struct mpam_msc *msc,
>>>> +				    struct acpi_mpam_resource_node *res)
>>>> +{
>>>> +	int level, nid;
>>>> +	u32 cache_id;
>>>> +
>>>> +	switch (res->locator_type) {
>>>> +	case ACPI_MPAM_LOCATION_TYPE_PROCESSOR_CACHE:
>>>> +		cache_id = res->locator.cache_locator.cache_reference;
>>>> +		level = find_acpi_cache_level_from_id(cache_id);
>>>> +		if (level <= 0) {
>>>> +			pr_err_once("Bad level (%u) for cache with id %u\n", level, cache_id);
>>>> +			return -EINVAL;
>>>> +		}
>>>> +		return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_CACHE,
>>>> +				       level, cache_id);
>>>> +	case ACPI_MPAM_LOCATION_TYPE_MEMORY:
>>>> +		nid = pxm_to_node(res->locator.memory_locator.proximity_domain);
>>>> +		if (nid == NUMA_NO_NODE)
>>>> +			nid = 0;
>>>> +		return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_MEMORY,
>>>> +				       255, nid);
>>>> +	default:
>>>> +		/* These get discovered later and treated as unknown */
>>>> +		return 0;
>>>> +	}
>>>> +}
>>>> +
>>>> +int acpi_mpam_parse_resources(struct mpam_msc *msc,
>>>> +			      struct acpi_mpam_msc_node *tbl_msc)
>>>> +{
>>>> +	int i, err;
>>>> +	struct acpi_mpam_resource_node *resources;
>>>> +
>>>> +	resources = (struct acpi_mpam_resource_node *)(tbl_msc + 1);
>>
>>> Should we check that we don't go out of the bounds of the MSC node
>>> (or, at the very least, of the MPAM table)?
>>>
>>> If tbl_msc->length was already validated, that can be used for the
>>> bounds check.
>>
>> I'm not a fan of trying to validate the APCI tables - its extra work for something that
>> just has to be right. e.g. we can't check the base-address, we just have to trust its correct.
>>
>> I didn't want to pass the table in here, and grabbing another reference means I'd have to
>> work out if its the same mapping...
>>
>> But as tbl_msc->length is to hand...
> 
> That gets my vote, except that it would be trivial to validate length
> in length in acpi_mpam_parse().  Checking against length without first
> validating length woule be completely pointless.

I've added something to do that...


> I agree that there are things that we can't validate and things that it
> is redundant or pointless to check.  But it feels a bit lazy not to
> care whether the parser wanders out of the table while trying to parse
> it.
> 
> If the rest of the ACPI code takes a similarly relaxed attitude (I've
> not checked) then I guess it is pointless to be more careful here.
> 
> But otherwise, I would prefer to see all the bounds checks done.
> This is not hard, and there are not many things to check.  (In my
> experience, it requires far fewer brain cycles to just make these things
> correct by construction than to try to figure out the situations in
> which the corner-cutting might or might not matter.)
> 
>>>> +	for (i = 0; i < tbl_msc->num_resource_nodes; i++) {
>>>> +		err = acpi_mpam_parse_resource(msc, &resources[i]);
>>>
>>> Isn't the length of each resource node variable?  According to [2],
>>> the length depends on the num_functional_deps field.  It looks like the
>>> functional dependency descriptors (if any) are appended contiguously to
>>> the resource node, unless I've misunderstood something.
>>
>> No - it proably is that broken. They forgot to include a length field, painting themselves
>> into a corner if they ever want to modify this!
> 
> The spec doesn't look particularly broken -- i.e., it can be compatibly
> extended, albeit in a more awkward way that would be ideal.  The main
> impact is that the list of resources has to be parsed sequentially, but
> that's all code is ever likely to do with the table anyway.
> 
>> I was ignoring the 'functional dependencies' until someone comes up with a platform that
>> needs it. But yes, this assumes that field is zero.
>>
>> I'm not entirely clear what the MPAM driver is supposed to do with functional
>> dependencies: 'make up a configuration' ... but when the controls formats are different,
>> its going to get exciting.
>>
>> I'ved fixed that up:
>> | int acpi_mpam_parse_resources(struct mpam_msc *msc,
>> | 			      struct acpi_mpam_msc_node *tbl_msc)
>> | {
>> | 	int i, err;
>> |	char *ptr, *last_byte;
>> | 	struct acpi_mpam_resource_node *resource;
>> |
>> | 	ptr = (char *)(tbl_msc + 1);
>> | 	last_byte = ptr + tbl_msc->length;
> 
> Nit: misnomer.  This is not the address of the last byte.
> 
> (I tend to call similar pointers something like "limit".)

It's called table_end elsewhere - I've gone with that.


>> | 	for (i = 0; i < tbl_msc->num_resource_nodes; i++) {
>> | 		if (ptr + sizeof(*resource) > last_byte)
>> | 			return -EINVAL;
>> |
>> | 		resource = (struct acpi_mpam_resource_node *)ptr;
>> | 		err = acpi_mpam_parse_resource(msc, resource);
>> | 		if (err)
>> | 			return err;
>> |
>> | 		ptr += sizeof(*resource);
>> | 		ptr += resource->num_functional_deps * sizeof(struct acpi_mpam_func_deps);
> 
> This mostly looks sane.
> 
> But unless ptr is guaranteed to be less than 0xffffffff00000002 (?),
> then the bounds check at the start of the loop may bogusly pass.
> 
> Would a check like this before advancing ptr across the functional deps
> be reasonable? (untested)
> 
> 	if (resource->num_functional_deps >
> 	    (last_byte - ptr) / sizeof(struct acpi_mpam_func_deps)
> 		return -EINVAL;
> 
> (Why the table allows more functional dependencies to be declared than
> could possibly fit in an MSC node is a mystery.)

Giving bits of that names made it easier for me to read. (and fit on one line)
|	remaining_table = table_end - ptr;
|	max_deps = remaining_table / sizeof(struct acpi_mpam_func_deps);
|	if (resource->num_functional_deps > max_deps) {
|		pr_debug("MSC has impossible number of functional dependencies\n");
|		return -EINVAL;
|	}



>>>> +		if (err)
>>>> +			return err;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static bool __init parse_msc_pm_link(struct acpi_mpam_msc_node *tbl_msc,
>>>> +				     struct platform_device *pdev,
>>>> +				     u32 *acpi_id)
>>>> +{
>>>> +	bool acpi_id_valid = false;
>>>> +	struct acpi_device *buddy;
>>>> +	char hid[16], uid[16];
>>>> +	int err;
>>>> +
>>>> +	memset(&hid, 0, sizeof(hid));
>>>> +	memcpy(hid, &tbl_msc->hardware_id_linked_device,
>>>> +	       sizeof(tbl_msc->hardware_id_linked_device));
>>>
>>> This is safe by semi-accident, since 16 > 8.
>>>
>>> It might be cleaner to declare
>>>
>>> 	char hid[sizeof(tbl_msc->hardware_id_linked_device)];
>>>
>>> which can never be wrong.
>>
>> But can be too precise!
> 
> But only when the correct length was unknown.  So you are saying that
> this can only be correct when it is not known to be correct? ;)
> 
> Sometimes an oversized array has useful defensive value against future
> mis-maintenance, but since the ACPI fields are all fixed-size, I don't
> see any benefit here.

The field in the table is eight bytes, but the string on the stack must be nine because
the table isn't null terminated. I went for the next power of two.


>>> memset()+memcpy() might be better replaced with strscpy() (or just use
>>> snprintf again, since this avoids having to think about multiple
>>> different ways of avoiding buffer overflows at the same time.  This is
>>> not a fast path.)
>>
>> snprintf() demands space for a NULL byte - but these APCI tables fields are fixed width,
>> so don't have them.
>>
>> The array sizes picked are the next larger power of 2, and the memset is ensure there is a
>> NULL byte after the fixed size region is copied in.
>>
>> Where snprintf() is being used - its to convert from integer to string. For the hid, what
>> we really want is a fixed size memcpy() ... its possible to cook up a format string that
>> will do that, but its going to be an eye sore.
> 
> Well, it's a matter of style.
> 
>>
>> I can change this to;
>> | char hid[sizeof(tbl_msc->hardware_id_linked_device) + 1];
> 
> Can do (and this would probably have shut me up), but:

fine, lets do that.


>>
>> But I don't think this is better... How about a comment?!
>> |	/*
>> |	 * tbl_msc->hardware_id_linked_device is an 8 byte fixed width string.
>> |	 * hid[] is the next larger power of 2, and is zero'd to give us a
>> |	 * null terminated string for acpi_dev_get_first_match_dev().
>> |	 */
> 
> this doesn't explain why the size needs to be a power of two, or what
> the wasted bytes are for.
> 
> (Either way, this is obviously no big deal...)
> 
>>
>>
>> This is all because the MPAM stuff was forced into a static table, even though it needs to
>> refer to stuff in the namespace.
>>
>>
>>>> +
>>>> +	if (!strcmp(hid, ACPI_PROCESSOR_CONTAINER_HID)) {
>>>> +		*acpi_id = tbl_msc->instance_id_linked_device;
>>>> +		acpi_id_valid = true;
>>>> +	}
>>>> +
>>>> +	err = snprintf(uid, sizeof(uid), "%u",
>>>
>>> char uid[11]; would be sufficient, here.  The instance ID is strictly
>>> 32-bit.  Adding a safety margin is worthless here, since snprintf()
>>> checks the bounds -- either the size is sufficient for all possible u32
>>> values, or it isn't.
>>
>> I just plumped for the next largest power of 2.
> 
> This is harmless, but since the only way to know that this is
> sufficient is to know what the correct value would have been, it seems
> pointless (as above) to lie to the compiler about how much space can
> be used.

It's on the stack, the compiler is almost certain to align to register size anyway. Making
it obviously big enough saves any time thinking about whether it should be 11 or 12.

I've changed it to 11. (I'll take your word for it!)


>>>> +		       tbl_msc->instance_id_linked_device);
>>>
>>> Can snprintf() return < 0 on error?
>>
>> Documented as returning a positive number.
> 
> Not in C23, and never standard for the printf() family in general.  But
> it does appear that this is true for the kernel's snprintf(), and this
> assmuption is widely relied upon in the kernel.  So, a check here would
> be pointless compilexity after all.
> 
> (The only documented error condition in C23 seems the case of a
> multibyte encoding error, which is not relevant here although it does
> not rule out other error conditions -- the wording is
> characteristically ambiguous.)
> 
> [...]
> 
>>>> +	if (err >= sizeof(uid))
>>>> +		return acpi_id_valid;
>>>
>>> Possibly return true on error?  Why?
>>
>> (this is an error case that will never happen - but error handling is important!)
>>
>> The acpi_id was parsed out of the table and returned to the caller. Hence true is
>> returned. This gets used to find the CPU-affinity, which is how the driver avoids
>> accessing caches that might not be on. There are sanity checks around this value. It can't
>> be present for some caches and not others.
>>
>> Due to this error, the link to the buddy device was not added - which is silently ignored.
>> If it matters, it will show up as an access to a device that didn't get turned on by the
>> power-management code, because of that missing link.
>>
>> Because I don't think this can happpen, I didn't try to handle it explicitly - just carry
>> on like nothing is wrong.

> What I meant was, if the MPAM table contains garbage, why not just flag
> this and give up?  That feels semantically simpler than trying to limp on,
> with possibly undiagnosed invalid results.

Not junk in the table - but the kernel was unable to convert a known-size integer to a
string in a correctly sized array.

I've added a debug statement for it:
|	pr_debug("Failed to convert uid of device for power management.");


>>>> +	while (table_offset < table_end) {
>>>> +		tbl_msc = (struct acpi_mpam_msc_node *)table_offset;
>>>> +		table_offset += tbl_msc->length;
>>>> +
>>>> +		/*
>>>> +		 * If any of the reserved fields are set, make no attempt to
>>>> +		 * parse the msc structure. This will prevent the driver from
>>>> +		 * probing all the MSC, meaning it can't discover the system
>>>> +		 * wide supported partid and pmg ranges. This avoids whatever
>>>> +		 * this MSC is truncating the partids and creating a screaming
>>>
>>> Mangled sentence?
>>
>> just hard to parse:
>> "whatever this MSC is" "truncating the parids..."
>>
>> Fixed as
>> | This avoids this MSC truncating the partids and creating a screaming error interrupt.
>>
>> (although its not strictly the MSC that does that)
> 
> The critical thing here seems to be that we prevent the driver from
> ever being enabled.  The comment doesn't seem to say that we are
> actually disabling the MPAM driver by giving up here (it only explains
> why).
> 
> For the benefit of people who are less familiar with the code, Would
> something like this be better: [*]
> 
> --8<--
> 
> If the reserved fields are set then the meaning of the rest of the
> entry is unknown,

I'm not sure that is true - use of the reserved fields should be backward compatible, and
there is no top level type because this thing isn't a subtable, so it isn't possible to
add other kinds of MSC - which is where you need the other fields to change meaning.

> so leave the MSC marked as unprobed and give up.

It skips creating the platform devices, so there is nothing for the driver to probe against.



> This means that the MPAM driver will never be enabled.  There is no way
> to enable it safely, because we cannot determine safe system-wide
> partid and pmg ranges in this situation.
> 
> -->8--

Combined as:
| * If any of the reserved fields are set, make no attempt to
| * parse the MSC structure. This MSC will still be counted,
| * meaning the MPAM driver can't probe against all MSC, and
| * will never be enabled. There is no way to enable it safely,
| * because we cannot determine safe system-wide partid and pmg
| * ranges in this situation.



>>> I have not so far found any reference in [2] to the reset value of the
>>> MPAMF_ECR.INTEN bit.  Do we rely on the error interrupt(s) for all MSCs
>>> to be disabled at the interrupt controller?  If the same interrupt may
>>> be shared by multiple MSCs, that's bad.
>>
>> They are anticipated as shared because the ESR register lets us know if this MSC triggered
>> the error.
>>
>> The interrupt won't be delivered until the driver requests it - it'll just stay pending.
>>
>> Yes - if some firwmare component used an out-of-range PARTID then linux will believe that
>> this was caused by linux and disable MPAM. Not much we can do about that.
>>
>> (I've even seen a platform where this happens!)
> 
> Ah, right -- I'd missed the ESR.
> 
> This is inherently racy even without interrupt sharing, so I guess
> sharing the interrupt doesn't make things worse (except for having to
> poll multiple ESRs on interrupt -- but if that hardware vendor made us
> do that, it's on them.)

The irqchip core will call every handler for a shared interrupt because of that race.


>>>> +		 * error interrupt.
>>>> +		 */
>>>> +		if (tbl_msc->reserved || tbl_msc->reserved1 || tbl_msc->reserved2)
>>>> +			continue;
>>
>>> The specs are not clear about how backwards compatibility is supposed
>>> to work.
>>
>> How about that!
>>
>> The spec people thought this would allow them to add things that aren't MSC in, re-using
>> one of these reserved fields as a type.
>> But - the architecture spec mandates the OS run around the MSC and collect the minimum
>> PARTID/PMG values (so people don't have to build an SoC where everything fits together
>> nicely). Because of that, the OS needs to know how many MSC there are, so that it knows it
>> has probed them all.
> 
> See my suggestion at [*], above.
> 
> The reader doesn't need to understand about future architecture
> directions, here.  The only thing that matters is that the kernel does
> not make any assumptions about the meaning of the MSC entry if these
> fields are set.  I'm not sure that we need to justify this position --
> simply stating it is probably enough.
> 
>>> I would feel a bit uneasy about silently throwing away MSCs based on
>>> critera that may not indicate incompatibility, and without even a
>>> diagnostic.
>>
>> Yes the MSC gets thrown away - but it was still counted by acpi_mpam_count_msc(). The MPAM
>> driver will never probe all the MSC, so it will never call mpam_enable().
>>
>> (you used to be able to see which cpuhp callback was registeered, to know it was stuck in
>> discovery, but now a helper does that which always uses the same name. I may fix that)
>>
>>
>> I think its fine for MPAM to silently fail to probe like this. The system still works, all
>> the known hardware gets probed and none of the unknown hardware is touched. (so it can't
>> blow us up). You don't get resctrl - but we can't know if the unknown hardware was going
>> to be important to supporting MPAM. e.g. it lowers the minimum usable PARTID/PMG.
>>
>> It's between a rock and a hard place - I think this  behaviour is the best we can do.
>>
>>
>> Regarding it being silent - whatever happens it needs a kernel upgrade to learn about the
>> newly described hardware. I don't think its worth printing anything out in this case.
> 
> I would still vote for a basic
> 
> 	"Unrecognised MSC, MPAM not usable"
> 
> message or similar.  This costs us nothing, and at least gives a clue
> that missing kernel support or a corrupt ACPI table are likely causes
> for resctrl not showing up.
> 
> It partly depends on how likely we think this scenario os -- or how
> likely it is that people will insist on using an old kernel with a
> botched stack of backports on new hardware.  I don't have a strong
> sense on this.
> 
>>>> +
>>>> +		if (!tbl_msc->mmio_size)
>>>> +			continue;
>>>> +
>>>> +		if (decode_interface_type(tbl_msc, &iface))
>>>> +			continue;
>>>
>>> Ditto regarding diagnostics.
>>
>> A third interface type will result in those MSC being untouched, and MPAM unavailable.
>> I don't think printing "maybe upgrade your kernel?" is going to help anyone.
>> I'll chuck some pr_debug() in here so someone could find out which of these it is.
>>
> 
> pr_debug() for sub-diagnosing the error may be helpful, but these feel
> like an addition to the basic "MPAM unusable" error rather than as a
> replacement for it...

Sure, printing multiple levels of error message looks strange to me. But whatever.


>>>> +
>>>> +		next_res = 0;
>>>> +		next_prop = 0;
>>>> +		memset(res, 0, sizeof(res));
>>>> +		memset(props, 0, sizeof(props));
>>>> +
>>>> +		pdev = platform_device_alloc("mpam_msc", tbl_msc->identifier);
>>>
>>> If the tbl_msc->identifier values contain duplicates, we will get a
>>> platform device with a duplicate name here.  I don't know whether it
>>> matters.
>>
>> The identifiers must be unique. I don't think this is the sort of table validation we need
>> to do for the firmware vendor.
> 
> My question was really: "what goes wrong?"  I suppose that if
> platform_device_alloc() doesn't like this then

True - you'd get an error from the plafrom device allocation code about the duplicate id.


>>
>>>> +		if (!pdev) {
>>>> +			err = -ENOMEM;
>>>> +			break;
>>>> +		}
> 
> we call the caller we ran out of memory.  While not exactly helpful,
> this is better than blowing up.  If this is the only consequence of
> duplicate IDs here (and this anyway Should Not Happen), then I guess
> this is adequate.
> 
> If platform_device_alloc() doesn't care about duplicate names, then I
> guess we can just trust it to have done something sensible.

I'm pretty sure it cares because the names have to be unique under sysfs.

[..]

>>>> +
>>>> +		/* Some power management is described in the namespace: */
>>>> +		err = snprintf(uid, sizeof(uid), "%u", tbl_msc->identifier);
>>>> +		if (err > 0 && err < sizeof(uid)) {
>>>> +			companion = acpi_dev_get_first_match_dev("ARMHAA5C", uid, -1);
>>>
>>> Diagnostic?
>>>
> 
> Ping

In line with what I did for the previous ones, I shoved something here.

[...]

>>>> +	table_end = (char *)table + table->length;
>>>> +
>>>> +	while (table_offset < table_end) {
>>>> +		if (!tbl_msc->mmio_size)
>>>> +			continue;
>>>
>>> This is 0 for non-usable PCC-based MSCs, right?
>>>
>>> (Why explicitly unusable MSCs are listed in the table at all is a
>>> mystery to me, but that's what the spec says.  I guess there must be a
>>> reason.)
> 
> (I guess PCC was added after the size field was named.  I suppose we
> don't really need a comment for that -- it's fairly clear why this bit
> of code is here.  We could rename the field in our struct, but this

(its imported from acpica - it would take quite a long time to change)


> would probably just move confusion around rather than solving it.)

[...]

>>> Also, is it an error if a length is not a multiple of four bytes?
>>
>> Hmmm, because all the subtables in the sepc are multiples of four bytes?
>> I think this falls in the bucket of 'table validation the OS shouldn't have to do'.
>> If the ACPI tables are that wrong, we're going to have bigger problems.
> 
> So long as we don't fault on unaligned access in the kernel (which I'm
> pretty sure we don't do), then nothing goes wrong in the unaligned case
> -- so, fine.  Otherwise we'll get a clean Oops, which would at least be
> a decent place to start debugging.

UEFI gets to choose the attibutes, but if it choses Device, things will blow up
well before we get in here.



Thanks,

James

