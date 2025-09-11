Return-Path: <linux-acpi+bounces-16669-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC180B53367
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 15:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05FC2189A980
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 13:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918AC2E7192;
	Thu, 11 Sep 2025 13:17:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA812E401;
	Thu, 11 Sep 2025 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757596655; cv=none; b=RViiBCN7/gMeKdKJncqWFzpnLjJH01gZRJ/gO8AKDDLtLVUdIcjf+BrPGnBADC55UTr3SqxVn4HyXWUmEQRWnXf4zdZn2g8UnEHz3/oC0I/G0t2+atRTmb9JaOkHmXt5bJ2KTi3fIqyhcb+jKOeF0SSQTMHjfXicfiLHpMGQYxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757596655; c=relaxed/simple;
	bh=aChratn3kUYwhc1D0/Tg+Tsi3gBpq6/EXv4vATNlq4E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MEwunLZQIZyUvYplvfWhioRkluBj4BxHN18BlDjn9+raFCeaBsFVrsmPEN5DJKMJJpY7/4ygU29efjDZGrjvrjfs5yN47RbTqNeFsfiynXEicloL2CNLbdm2TCrzl7iHn1+JC7dNRLUsnt2SGq69Y4VZXqgpMVogdIPP6ZQTHtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cMyk56VP2z6L59H;
	Thu, 11 Sep 2025 21:16:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 41687140373;
	Thu, 11 Sep 2025 21:17:29 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 11 Sep
 2025 15:17:28 +0200
Date: Thu, 11 Sep 2025 14:17:26 +0100
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
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 06/29] ACPI / MPAM: Parse the MPAM table
Message-ID: <20250911141726.00002f0c@huawei.com>
In-Reply-To: <20250910204309.20751-7-james.morse@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
	<20250910204309.20751-7-james.morse@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 10 Sep 2025 20:42:46 +0000
James Morse <james.morse@arm.com> wrote:

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
Hi James,

A few comments inline.  Note I've more or less completely forgotten
what was discussed in RFC 1 so I might well be repeating stuff that
you replied to then.  Always a problem for me with big complex patch sets!

Jonathan

> diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
> new file mode 100644
> index 000000000000..fd9cfa143676
> --- /dev/null
> +++ b/drivers/acpi/arm64/mpam.c


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

are treated?


> +		return 0;
> +	}
> +}

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

 = {}; above and skip the memset.

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
> +static int __init acpi_mpam_parse(void)
> +{
> +	struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_MPAM, 0);
> +	char *table_end, *table_offset = (char *)(table + 1);
> +	struct property_entry props[4]; /* needs a sentinel */
Perhaps move this and res into the loop and use = {};

> +	struct acpi_mpam_msc_node *tbl_msc;
> +	int next_res, next_prop, err = 0;
> +	struct acpi_device *companion;
> +	struct platform_device *pdev;
> +	enum mpam_msc_iface iface;
> +	struct resource res[3];

Add a comment here or a check later on why this is large enough.

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

That this isn't considered an error is a bit subtle and made me wonder
if there was a use of uninitialized pdev (there isn't because err == 0)
Why not return here?

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

This is decidedly paranoid. I'd normally expect the architecture to be based
on assumption that is fine for old software to ignore new fields.  ACPI itself
has fairly firm rules on this (though it goes wrong sometimes :)
I'm guessing there is something out there that made this necessary though so
keep it if you actually need it.

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

https://lore.kernel.org/all/20241009124120.1124-13-shiju.jose@huawei.com/
was a proposal to add a DEFINE_FREE() to clean these up.  Might be worth a revisit.
Then Greg was against the use it was put to and asking for an example of where
it helped.  Maybe this is that example.

If you do want to do that, I'd factor out a bunch of the stuff here as a helper
so we can have the clean ownership pass of a return_ptr().  
Similar to what Shiju did here (this is the usecase for platform device that
Greg didn't like).
https://lore.kernel.org/all/20241009124120.1124-14-shiju.jose@huawei.com/

Even without that I think factoring some of this out and hence being able to
do returns on errors and put the if (err) into the loop would be a nice
improvement to readability.

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

Why the double increment? Needs a comment if that is right thing to do.

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
Trivial so feel free to ignore.
Perhaps should aim for consistency.  Whilst I prefer pointers for this stuff
PPTT did use unsigned longs.

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

Could reorder to put acpi_mpam_parse and this use of it together?

> +/*
> + * Call after ACPI devices have been created, which happens behind acpi_scan_init()
> + * called from subsys_initcall(). PCC requires the mailbox driver, which is
> + * initialised from postcore_initcall().
> + */
> +subsys_initcall_sync(acpi_mpam_parse);

> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index c5fd92cda487..af449964426b 100644
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

I'd use if (!IS_ERR_OR_NULL(_T)) not because it is functionally necessary but
because it will let the compiler optimize this out if it can tell that in a given
path _T is NULL (I think it was Peter Z who pointed this out in a similar interface
a while back).


I'd like an opinion from Rafael on this in general.



> +
>  int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
>  int __init_or_acpilib acpi_table_parse_entries(char *id,
>  		unsigned long table_size, int entry_id,


