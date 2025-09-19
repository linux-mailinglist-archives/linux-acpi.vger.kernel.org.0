Return-Path: <linux-acpi+bounces-17143-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA207B8A865
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Sep 2025 18:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E89E7E4B08
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Sep 2025 16:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C1F31E106;
	Fri, 19 Sep 2025 16:12:07 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F2531D753;
	Fri, 19 Sep 2025 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758298327; cv=none; b=sPYdhBy87GtMd4laoxmdKZCY1MVPysa7+hQyZ0cj9p6TyzsOZhxGSJW0/0y/357RfWQ7itGoC2bsLXy2DQqiISnDydsRy576M8HmfcFWKiTNqU1eddvHanMX7waKrxjcMEJxv8/7BL+7IXQ1kDpPW2dIxJ8yP/p6LF/6BUYayH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758298327; c=relaxed/simple;
	bh=7OSqyTCuHkftfQ6GxbZGqdX1pGzdGqFE4tY+P7yGpU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XfiBG8KA6HPbqrsAOspPfuHh7fvCSqZTb0QZ/LANFdp6ZA6n2qScikpoZfhT0Yt+ZqrvQED4qGHT9Clsa9BDimCrnZKoGk4PhXB1mKDpQQ8fmDooe9COSqO8h+jLSDZ1XkhZ8O4QBxiy85Y/O3oydMAH5kCNdWnXV+DP+npZUS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F180B1C01;
	Fri, 19 Sep 2025 09:11:56 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 583B23F66E;
	Fri, 19 Sep 2025 09:11:58 -0700 (PDT)
Message-ID: <fd6f4975-166e-4e4b-9499-e93791cbf262@arm.com>
Date: Fri, 19 Sep 2025 17:11:55 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/29] ACPI / MPAM: Parse the MPAM table
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
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
 fenghuay@nvidia.com, baisheng.gao@unisoc.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-7-james.morse@arm.com> <aMLjKzGsGE7rlpKn@lpieralisi>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <aMLjKzGsGE7rlpKn@lpieralisi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Lorenzo,

On 11/09/2025 15:56, Lorenzo Pieralisi wrote:
> On Wed, Sep 10, 2025 at 08:42:46PM +0000, James Morse wrote:
>> Add code to parse the arm64 specific MPAM table, looking up the cache
>> level from the PPTT and feeding the end result into the MPAM driver.
>>
>> For now the MPAM hook mpam_ris_create() is stubbed out, but will update
>> the MPAM driver with optional discovered data.

>> diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
>> new file mode 100644
>> index 000000000000..fd9cfa143676
>> --- /dev/null
>> +++ b/drivers/acpi/arm64/mpam.c
>> @@ -0,0 +1,361 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (C) 2025 Arm Ltd.
>> +
>> +/* Parse the MPAM ACPI table feeding the discovered nodes into the driver */
>> +
>> +#define pr_fmt(fmt) "ACPI MPAM: " fmt
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/arm_mpam.h>
>> +#include <linux/bits.h>
>> +#include <linux/cpu.h>
>> +#include <linux/cpumask.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include <acpi/processor.h>
>> +
>> +/*
>> + * Flags for acpi_table_mpam_msc.*_interrupt_flags.
>> + * See 2.1.1 Interrupt Flags, Table 5, of DEN0065B_MPAM_ACPI_3.0-bet.
>> + */
>> +#define ACPI_MPAM_MSC_IRQ_MODE_MASK                    BIT(0)
>> +#define ACPI_MPAM_MSC_IRQ_TYPE_MASK                    GENMASK(2, 1)
>> +#define ACPI_MPAM_MSC_IRQ_TYPE_WIRED                   0
>> +#define ACPI_MPAM_MSC_IRQ_AFFINITY_PROCESSOR_CONTAINER BIT(3)

> Nit: For consistency, not sure why MODE/TYPE_MASK and
> AFFINITY_{TYPE/VALID} aren't but that's not a big deal.

The missing word is giving me trouble working out what this should be...

There used to be definitions for MODE_LEVEL and MODE_EDGE, hence the MODE_MASK to extract
the bit - but Jonathan pointed out the polarity values were pretty standard, and ocul be
fed to acpi_register_gsi() directly without mapping 0->0 and 1->1.


> BIT(3) to be consistent with the table should be (?)
> 
> #define ACPI_MPAM_MSC_AFFINITY_TYPE_MASK	BIT(3)
> 
> to match the Table 5 (and then add defines for possible values).

Fixed as:
| #define ACPI_MPAM_MSC_IRQ_AFFINITY_TYPE_MASK                BIT(3)
| #define ACPI_MPAM_MSC_IRQ_AFFINITY_TYPE_PROCESSOR           0
| #define ACPI_MPAM_MSC_IRQ_AFFINITY_TYPE_PROCESSOR_CONTAINER 1


>> +#define ACPI_MPAM_MSC_IRQ_AFFINITY_VALID               BIT(4)
> 
> ACPI_MPAM_MSC_AFFINITY_VALID_MASK ? (or remove _MASK from IRQ_{MODE/TYPE) ?
> 
> Just noticed - feel free to ignore this altogether.

I think the _MASK stuff encourages use of FIELD_GET(), which in turn encourages
local variables with meaningful names.

But I don't think I need a mask and values defined for the valid bit - which is readable
enough already, or the mode as the bits are passed through directly.


> 
>> +static bool acpi_mpam_register_irq(struct platform_device *pdev, int intid,
>> +				   u32 flags, int *irq,
>> +				   u32 processor_container_uid)
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
>> +
>> +	if (16 <= intid && intid < 32 && processor_container_uid != GLOBAL_AFFINITY) {
>> +		pr_err_once("Partitioned interrupts not supported\n");
>> +		return false;
>> +	}
> 
> Please add a comment to explain what you mean here (ie PPIs partitioning
> isn't supported).

The error message isn't enough?


> I will have to change this code anyway to cater for the  GICv5 interrupt model given the
> hardcoded intid values.

Ah. I can probably detect PPIs from the table description instead. It's done like this
just because this was where the handling logic used to be, but if that's a nuisance for
the GICv5 handling, I'll do it purely from the table.

I have the code to support ppi-paritions, but its not worth it unless someone builds this.


> Is the condition allowed by the MPAM architecture so the MPAM table are
> legitimate (but not supported in Linux) ?

Yeah, the architecture says the interrupt can be PPI. Global PPI are supported, but not
partitions on ACPI platforms. Because its valid/easy for DT, its hard to say no-one will
ever do this with ACPI. Describing the affinity in the table lets the OS decide whether to
support it.

This ends up as as helper:
| static bool _is_ppi_partition(u32 flags)
| {
| 	u32 aff_type, is_ppi;
| 	bool ret;
|
| 	is_ppi = FIELD_GET(ACPI_MPAM_MSC_IRQ_AFFINITY_VALID, flags);
| 	if (!is_ppi)
| 		return false;
|
| 	aff_type = FIELD_GET(ACPI_MPAM_MSC_IRQ_AFFINITY_TYPE_MASK, flags);
| 	ret = (aff_type == ACPI_MPAM_MSC_IRQ_AFFINITY_TYPE_PROCESSOR_CONTAINER);
| 	if (ret)
| 		pr_err_once("Partitioned interrupts not supported\n");
|
| 	return ret;
| }

and a call in acpi_mpam_register_irq() to return false for ppi-partitions.
This also allows some simplification in acpi_mpam_parse_irqs().


>> +
>> +	*irq = acpi_register_gsi(&pdev->dev, intid, sense, ACPI_ACTIVE_HIGH);
>> +	if (*irq <= 0) {
>> +		pr_err_once("Failed to register interrupt 0x%x with ACPI\n",
>> +			    intid);
>> +		return false;
>> +	}
>> +
>> +	return true;
>> +}

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
> Jonathan already commented on this.

Yup, its gone.


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

> Is !buddy a FW error to be logged ?

I'm pretty sure that field is optional, its for platform specific power management.
The spec has "This field must be set to zero if there is no linked device for this MSC".
This is where I expect a search for "\0\0\0\0" to fail, hence its silent.

I think this thing is for the power management of the parent device, whereas the MSC
namespace object is for the power management of the MSC itself. I've no idea why they need
to be separate...


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
> 
> Worth giving those constants 0x0,0xa a name ?

Sure, added earlier in the file:
| /*
|  * Encodings for the MSC node body interface type field.
|  * See 2.1 MPAM MSC node, Table 4 of DEN0065B_MPAM_ACPI_3.0-bet.
|  */
| #define ACPI_MPAM_MSC_IFACE_MMIO   0x00
| #define ACPI_MPAM_MSC_IFACE_PCC    0x0a


> 
>> +		*iface = MPAM_IFACE_PCC;
>> +		return 0;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int __init acpi_mpam_parse(void)
>> +{
>> +	struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_MPAM, 0);
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
>> +		if (tbl_msc->reserved || tbl_msc->reserved1 || tbl_msc->reserved2) {
>> +			pr_err_once("Unrecognised MSC, MPAM not usable\n");
>> +			pr_debug("MSC.%u: reserved field set\n", tbl_msc->identifier);
>> +			continue;
>> +		}


> This is a bit obscure - the comment too requires some explanation
> ("This MSC will still be counted", not very clear what that means).

I'll expand it - counted by acpi_mpam_count_msc(). It's trying to explain why its
perfectly safe to just skip MSC here - that prevents the driver from ever touching the
hardware.


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
> 
> Here you are linking the platform device to a namespace companion.
> That's what will make sure that a) the ACPI namespace scan won't add an
> additional platform device for ARMHAA5C and b) MSIs works -> through
> the related IORT named component.
> 
> Correct ?

I don't think anyone would put an MSC behind an IOMMU, so hopefully this is not needed for
MSI. I've not touched the MSI support yet.

2.6 of the spec says this is for power management ... I've hooked it up here because its
there. I assumed the power-management core needed to know about it. It's the same device,
hence calling it the companion, (which is how the spec people referred to it verbally).

I do see a the namespace platform device get created, is that not supposed to happen?
I'm testing this with the FVP, so don't have a way of actually triggering a power
management flow.


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
> 
> Do we _really_ have to resolve IRQs here or we can postpone them at
> driver probe time like RIS resources (if I understand correctly how
> it is done - by copying table data into platform data) ?

Simply because that is the order that DT does it too. We'd probably get away with it, but
the interrupts are a property of the MSC, not the description of the resource it controls...
I'm not sure what doing this would buy us.


> GICv5 hat in mind - good as it is for GICv3.

What changes here for GICv5? I certainly want it to work with whatever irqchip is in use.


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
> 
> I read this as: copy table data to the device so that RIS resources can
> be parsed later.
> 
> Right ? I think it is worth updating the comment to clarify it.

Sure,
	/*
	 * Stash the table entry for acpi_mpam_parse_resources() to discover
	 * what this MSC controls.
	 */


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
> 
> I won't comment on the clean-up here as Jonathan did it already.
> 
>> +
>> +	return err;
>> +}

>> +
>> +/*
>> + * Call after ACPI devices have been created, which happens behind acpi_scan_init()
>> + * called from subsys_initcall(). PCC requires the mailbox driver, which is
>> + * initialised from postcore_initcall().

> I think we will end up setting in stone init ordering for these
> components created out of static tables (I mean sequencing them in a
> centralized way) but if that works for the current driver that's fine
> for the time being.

That'd be better - I've noted the dependencies on each one of these.



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
> 
> Jonathan commented on this already - worth getting Rafael's opinion,
> I am fine either way.
> 
> I have not found anything that should block this code (other than code
> that I know I will have to rework when GICv5 ACPI support gets in) so:

I've factored that out.


> Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

From your comments I assume you're happy with Jonathan's suggested changes too - which
I've picked up.


Thanks!

James


