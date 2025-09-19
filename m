Return-Path: <linux-acpi+bounces-17141-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEA7B8A859
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Sep 2025 18:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A86B628428
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Sep 2025 16:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5C9320CAD;
	Fri, 19 Sep 2025 16:11:14 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3E0320CA3;
	Fri, 19 Sep 2025 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758298274; cv=none; b=qYQXiadnPtnjThUG/QvS5HJxLDBJumm4uYCakMLdCEVfwktyuojkL/lRBiRtw64NB4QaCeefjCcwv4Xw3ixoqHt9YksAAE9vqFg9Vpz8VKnYybGU+oiYw0NteMIB5eqaRpIeTyad+lwCZK9uOkXV9qA4szumy8wFGKjY9NCG9VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758298274; c=relaxed/simple;
	bh=QM55JGt32VBvX7JQ1SzRF/QRg0WsTEETvdDiuvMMysk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sVg5zgQgNONRqL8m+u9rbA8+Lg5il/9IDbc/5i6nIVETlwPCj1MQldXPc62pGnfs0CZFJOKueg5PkiUSzaGhJyFE/Nh60FdmNCi9Ot1yl+0Wd1vCWacG3/GXUSfmVbJtvZDTkaBRq3GSy/NJi1mzBObe0lo4mQkgPcpLMrvFCoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 482A91C01;
	Fri, 19 Sep 2025 09:11:03 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A6B63F66E;
	Fri, 19 Sep 2025 09:11:06 -0700 (PDT)
Message-ID: <334e0e8b-3f30-48b7-896f-0b31111d2b41@arm.com>
Date: Fri, 19 Sep 2025 17:11:03 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/29] ACPI / MPAM: Parse the MPAM table
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com, Rob Herring <robh@kernel.org>,
 Rohit Mathew <rohit.mathew@arm.com>, Rafael Wysocki <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-7-james.morse@arm.com>
 <20250911141726.00002f0c@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250911141726.00002f0c@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 11/09/2025 14:17, Jonathan Cameron wrote:
> On Wed, 10 Sep 2025 20:42:46 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> Add code to parse the arm64 specific MPAM table, looking up the cache
>> level from the PPTT and feeding the end result into the MPAM driver.
>>
>> For now the MPAM hook mpam_ris_create() is stubbed out, but will update
>> the MPAM driver with optional discovered data.

> A few comments inline.  Note I've more or less completely forgotten
> what was discussed in RFC 1 so I might well be repeating stuff that
> you replied to then.  Always a problem for me with big complex patch sets!

No worries - I'll have forgotten too. If we can't work it out, it should have had a comment.


>> diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
>> new file mode 100644
>> index 000000000000..fd9cfa143676
>> --- /dev/null
>> +++ b/drivers/acpi/arm64/mpam.c
> 
> 
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
> 
> are treated?

Sure,


>> +		return 0;
>> +	}
>> +}
> 
>> +static bool __init parse_msc_pm_link(struct acpi_mpam_msc_node *tbl_msc,
>> +				     struct platform_device *pdev,
>> +				     u32 *acpi_id)
>> +{
>> +	char hid[sizeof(tbl_msc->hardware_id_linked_device) + 1];
>> +	bool acpi_id_valid = false;
>> +	struct acpi_device *buddy;
>> +	char uid[11];
>> +	int err;
>> +
>> +	memset(&hid, 0, sizeof(hid));
> 
>  = {}; above and skip the memset.

Sure,


>> +	memcpy(hid, &tbl_msc->hardware_id_linked_device,
>> +	       sizeof(tbl_msc->hardware_id_linked_device));
>> +
>> +	if (!strcmp(hid, ACPI_PROCESSOR_CONTAINER_HID)) {
>> +		*acpi_id = tbl_msc->instance_id_linked_device;
>> +		acpi_id_valid = true;
>> +	}
>> +
>> +	err = snprintf(uid, sizeof(uid), "%u",
>> +		       tbl_msc->instance_id_linked_device);
>> +	if (err >= sizeof(uid)) {
>> +		pr_debug("Failed to convert uid of device for power management.");
>> +		return acpi_id_valid;
>> +	}
>> +
>> +	buddy = acpi_dev_get_first_match_dev(hid, uid, -1);
>> +	if (buddy)
>> +		device_link_add(&pdev->dev, &buddy->dev, DL_FLAG_STATELESS);
>> +
>> +	return acpi_id_valid;
>> +}
> 
>> +
>> +static int __init acpi_mpam_parse(void)
>> +{
>> +	struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_MPAM, 0);
>> +	char *table_end, *table_offset = (char *)(table + 1);
>> +	struct property_entry props[4]; /* needs a sentinel */

> Perhaps move this and res into the loop and use = {};

>> +	struct acpi_mpam_msc_node *tbl_msc;
>> +	int next_res, next_prop, err = 0;
>> +	struct acpi_device *companion;
>> +	struct platform_device *pdev;
>> +	enum mpam_msc_iface iface;
>> +	struct resource res[3];
> 
> Add a comment here or a check later on why this is large enough.

These two are now in the loop and look like this:
| 		/* pcc, nrdy, affinity and a sentinel */
| 		struct property_entry props[4] = { 0 };
| 		/* mmio, 2xirq, no sentinel. */
|		struct resource res[3] = { 0 };


>> +	char uid[16];
>> +	u32 acpi_id;
>> +
>> +	if (acpi_disabled || !system_supports_mpam() || IS_ERR(table))
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
>> +		if (table_offset > table_end) {
>> +			pr_debug("MSC entry overlaps end of ACPI table\n");
>> +			break;

> That this isn't considered an error is a bit subtle and made me wonder
> if there was a use of uninitialized pdev (there isn't because err == 0)

Its somewhat a philosophical arguement. I don't expect the kernel to have to validate
these tables, they're not provided by the user and there quickly becomes a point where
you have to trust them, and they have to be correct.
At the other extreme is the asusmption the table is line-noise and we should check
everything to avoid out of bounds accesses. Dave wanted the diagnostic messages on these.

As this is called from an initcall, the best you get is an inexplicable print message.
(what should we say - update your firmware?)


Silently failing in this code is always safe as the driver has a count of the number of
MSC, and doesn't start accessing the hardware until its found them all.
(this is because to find the system wide minimum value - and its not worth starting if
 its not possible to finish).


> Why not return here?

Just because there was no other return in the loop, and I hate surprise returns.

I'll change it if it avoids thinking about how that platform_device_put() gets skipped!


> 
>> +		}
>> +
>> +		/*
>> +		 * If any of the reserved fields are set, make no attempt to
>> +		 * parse the MSC structure. This MSC will still be counted,
>> +		 * meaning the MPAM driver can't probe against all MSC, and
>> +		 * will never be enabled. There is no way to enable it safely,
>> +		 * because we cannot determine safe system-wide partid and pmg
>> +		 * ranges in this situation.
>> +		 */

> This is decidedly paranoid. I'd normally expect the architecture to be based
> on assumption that is fine for old software to ignore new fields.  ACPI itself
> has fairly firm rules on this (though it goes wrong sometimes :)

Yeah - the MPAM table isn't properly structured as subtables. I don't see how they are
going to extend it if they need to.

The paranoia is that anything set in these reserved fields probably indicates something
the driver needs to know about: a case in point is the way PCC was added.

I'd much prefer we skip creation of MSC devices that have properties we don't understand.
acpi_mpam_count_msc() still counts them - which means the driver never finds all the MSC,
and never touches the hardware.

MPAM isn't a critical feature, its better that it be disabled than make things worse.
(the same attitude holds with the response to the MPAM error interrupt - reset everything
 and pack up shop. This is bettern than accidentally combining important/unimportant
 tasks)


> I'm guessing there is something out there that made this necessary though so
> keep it if you actually need it.

It's a paranoid/violent reaction to the way PCC was added - without something like this,
that would have led to the OS trying to map the 0 page and poking around in it - never
likely to go well.

Doing this does let them pull another PCC without stable kernels going wrong.
Ultimately I think they'll need to replace the table with one that is properly structured.
For now - this is working with what we have.


>> +		if (tbl_msc->reserved || tbl_msc->reserved1 || tbl_msc->reserved2) {
>> +			pr_err_once("Unrecognised MSC, MPAM not usable\n");
>> +			pr_debug("MSC.%u: reserved field set\n", tbl_msc->identifier);
>> +			continue;
>> +		}
>> +
>> +		if (!tbl_msc->mmio_size) {
>> +			pr_debug("MSC.%u: marked as disabled\n", tbl_msc->identifier);
>> +			continue;
>> +		}
>> +
>> +		if (decode_interface_type(tbl_msc, &iface)) {
>> +			pr_debug("MSC.%u: unknown interface type\n", tbl_msc->identifier);
>> +			continue;
>> +		}
>> +
>> +		next_res = 0;
>> +		next_prop = 0;
>> +		memset(res, 0, sizeof(res));
>> +		memset(props, 0, sizeof(props));
>> +
>> +		pdev = platform_device_alloc("mpam_msc", tbl_msc->identifier);
> 
> https://lore.kernel.org/all/20241009124120.1124-13-shiju.jose@huawei.com/
> was a proposal to add a DEFINE_FREE() to clean these up.  Might be worth a revisit.
> Then Greg was against the use it was put to and asking for an example of where
> it helped.  Maybe this is that example.
> 
> If you do want to do that, I'd factor out a bunch of the stuff here as a helper
> so we can have the clean ownership pass of a return_ptr().  
> Similar to what Shiju did here (this is the usecase for platform device that
> Greg didn't like).
> https://lore.kernel.org/all/20241009124120.1124-14-shiju.jose@huawei.com/
> 
> Even without that I think factoring some of this out and hence being able to
> do returns on errors and put the if (err) into the loop would be a nice
> improvement to readability.

If you think its more readable I'll structure it like that.


>> +		if (!pdev) {
>> +			err = -ENOMEM;
>> +			break;
>> +		}
>> +
>> +		if (tbl_msc->length < sizeof(*tbl_msc)) {
>> +			err = -EINVAL;
>> +			break;
>> +		}
>> +
>> +		/* Some power management is described in the namespace: */
>> +		err = snprintf(uid, sizeof(uid), "%u", tbl_msc->identifier);
>> +		if (err > 0 && err < sizeof(uid)) {
>> +			companion = acpi_dev_get_first_match_dev("ARMHAA5C", uid, -1);
>> +			if (companion)
>> +				ACPI_COMPANION_SET(&pdev->dev, companion);
>> +			else
>> +				pr_debug("MSC.%u: missing namespace entry\n", tbl_msc->identifier);
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
> 
> Why the double increment? Needs a comment if that is right thing to do.

That's a bug.
I'll add some WARN_ON() when these are consumed as per your earlier suggestion.


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
>> +	struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_MPAM, 0);
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
>> +	table_end = (char *)table + table->length;

> Trivial so feel free to ignore.
> Perhaps should aim for consistency.  Whilst I prefer pointers for this stuff
> PPTT did use unsigned longs.

I prefer the pointers, and as it's a separate file, I don't think it needs to be
concistent with PPTT.


>> +
>> +	while (table_offset < table_end) {
>> +		tbl_msc = (struct acpi_mpam_msc_node *)table_offset;
>> +		if (!tbl_msc->mmio_size)
>> +			continue;
>> +
>> +		if (tbl_msc->length < sizeof(*tbl_msc))
>> +			return -EINVAL;
>> +		if (tbl_msc->length > table_end - table_offset)
>> +			return -EINVAL;
>> +		table_offset += tbl_msc->length;
>> +
>> +		count++;
>> +	}
>> +
>> +	return count;
>> +}
>> +

> Could reorder to put acpi_mpam_parse and this use of it together?

mpam_msc_driver_init() calls this from subsys_initcall() to know whether its worth
registering the driver at all. Even with that fixed, its still potentially racy: once the
first MSC has been platform_device_add()ed, I figure the driver can probe against that,
and needs to know if this first MSC was the last one.
acpi_mpam_count_msc() needs to be safe to race with acpi_mpam_parse().

This could be forced far enough away in time by only registering the driver after
subsys_initcall_sync() has completed - but the list of dependencies on those is ugly
enough as it is.

I'll add a comment:
/**
 * acpi_mpam_count_msc() - Count the number of MSC described by firmware.
 *
 * Returns the number of of MSC, or zero for an error.
 *
 * This can be called before or in parallel with acpi_mpam_parse().
 */


>> +/*
>> + * Call after ACPI devices have been created, which happens behind acpi_scan_init()
>> + * called from subsys_initcall(). PCC requires the mailbox driver, which is
>> + * initialised from postcore_initcall().
>> + */
>> +subsys_initcall_sync(acpi_mpam_parse);

>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index c5fd92cda487..af449964426b 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -221,6 +222,17 @@ void acpi_reserve_initial_tables (void);
>>  void acpi_table_init_complete (void);
>>  int acpi_table_init (void);
>>  
>> +static inline struct acpi_table_header *acpi_get_table_ret(char *signature, u32 instance)
>> +{
>> +	struct acpi_table_header *table;
>> +	int status = acpi_get_table(signature, instance, &table);
>> +
>> +	if (ACPI_FAILURE(status))
>> +		return ERR_PTR(-ENOENT);
>> +	return table;
>> +}
>> +DEFINE_FREE(acpi_table, struct acpi_table_header *, if (!IS_ERR(_T)) acpi_put_table(_T))

> I'd use if (!IS_ERR_OR_NULL(_T)) not because it is functionally necessary but
> because it will let the compiler optimize this out if it can tell that in a given
> path _T is NULL (I think it was Peter Z who pointed this out in a similar interface
> a while back).

Makes sense,

> I'd like an opinion from Rafael on this in general.



Thanks,

James

