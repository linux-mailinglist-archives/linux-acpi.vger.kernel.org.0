Return-Path: <linux-acpi+bounces-16248-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9681B3E162
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Sep 2025 13:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE223AE9AB
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Sep 2025 11:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6AC311C35;
	Mon,  1 Sep 2025 11:21:23 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99EA3595D;
	Mon,  1 Sep 2025 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756725683; cv=none; b=ctbXQ5aTGDjixj3moSodWBUHnCQ7U8y7CXT073MincdMq0K2Yxl1NCINs4ocbIUf8vOoJ8MNRkqzgacKSv2dVTdFAY7D++tcUn2eLK+NBhPXT8A0m0FyFH0YkyCd2z2KJcULLubHAsqC/UVljYvK/xNNzKXtn8Ro72GeOabBt+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756725683; c=relaxed/simple;
	bh=jGdAz412GkPYDNDBzOot9YLlz5jht+cdFHwZ45LUr14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsBcoQh0b0bZCtEnykBsf0ogFjZkXKbvqym+J3CoWUAU7/wTjjdlIjmNCE5YJ5d+HE4XQftb55eVsGMqNPIAXPWkhc/1HJI2DTppLmeK9PenPmQnbW0AaxxHMwEb3OXry9nn+q/9UIZNy51lVS4wS+AX0ugmnstWuG0cW63CSyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D8F01A00;
	Mon,  1 Sep 2025 04:21:12 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2198E3F6A8;
	Mon,  1 Sep 2025 04:21:14 -0700 (PDT)
Date: Mon, 1 Sep 2025 12:21:12 +0100
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
Subject: Re: [PATCH 10/33] arm_mpam: Add probe/remove for mpam msc driver and
 kbuild boiler plate
Message-ID: <aLWBqNMKoTl9VDIS@e133380.arm.com>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-11-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822153048.2287-11-james.morse@arm.com>

Hi James,

On Fri, Aug 22, 2025 at 03:29:51PM +0000, James Morse wrote:
> Probing MPAM is convoluted. MSCs that are integrated with a CPU may
> only be accessible from those CPUs, and they may not be online.
> Touching the hardware early is pointless as MPAM can't be used until
> the system-wide common values for num_partid and num_pmg have been
> discovered.
> 
> Start with driver probe/remove and mapping the MSC.
> 
> CC: Carl Worth <carl@os.amperecomputing.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since RFC:
>  * Check for status=broken DT devices.
>  * Moved all the files around.
>  * Made Kconfig symbols depend on EXPERT
> ---

[...]

> diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
> new file mode 100644
> index 000000000000..dff7b87280ab
> --- /dev/null
> +++ b/drivers/resctrl/Kconfig
> @@ -0,0 +1,11 @@
> +# Confusingly, this is everything but the CPU bits of MPAM. CPU here means
> +# CPU resources, not containers or cgroups etc.

Drop confusing comment?

CPUs are not mentioned other than in the comment -- I think the
descriptions are sufficiently self-explanatory that they don't read
onto CPUs.

> +config ARM64_MPAM_DRIVER
> +	bool "MPAM driver for System IP, e,g. caches and memory controllers"
> +	depends on ARM64_MPAM && EXPERT
> +
> +config ARM64_MPAM_DRIVER_DEBUG
> +	bool "Enable debug messages from the MPAM driver."

Nit: spurious full stop.

(i.e., people don't add one in these one-line descriptions.
They are title-like and self-delimiting, even when the text is a valid
sentence.)

> +	depends on ARM64_MPAM_DRIVER
> +	help
> +	  Say yes here to enable debug messages from the MPAM driver.
> diff --git a/drivers/resctrl/Makefile b/drivers/resctrl/Makefile
> new file mode 100644
> index 000000000000..92b48fa20108
> --- /dev/null
> +++ b/drivers/resctrl/Makefile
> @@ -0,0 +1,4 @@
> +obj-$(CONFIG_ARM64_MPAM_DRIVER)			+= mpam.o
> +mpam-y						+= mpam_devices.o
> +
> +cflags-$(CONFIG_ARM64_MPAM_DRIVER_DEBUG)	+= -DDEBUG
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> new file mode 100644
> index 000000000000..a0d9a699a6e7
> --- /dev/null
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -0,0 +1,336 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2025 Arm Ltd.
> +
> +#define pr_fmt(fmt) "%s:%s: " fmt, KBUILD_MODNAME, __func__
> +
> +#include <linux/acpi.h>
> +#include <linux/arm_mpam.h>
> +#include <linux/cacheinfo.h>
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/gfp.h>
> +#include <linux/list.h>
> +#include <linux/lockdep.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/printk.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/srcu.h>
> +#include <linux/types.h>
> +
> +#include <acpi/pcc.h>
> +
> +#include "mpam_internal.h"
> +
> +/*
> + * mpam_list_lock protects the SRCU lists when writing. Once the
> + * mpam_enabled key is enabled these lists are read-only,
> + * unless the error interrupt disables the driver.
> + */
> +static DEFINE_MUTEX(mpam_list_lock);
> +static LIST_HEAD(mpam_all_msc);
> +
> +static struct srcu_struct mpam_srcu;
> +
> +/* MPAM isn't available until all the MSC have been probed. */

Comment doesn't really explain the variable.

Maybe something like "Number of MSCs that need to be probed for MPAM
to be usable" ?

> +static u32 mpam_num_msc;

Any particular reason this is u32 and not unsigned int?

How are accesses to this protected against data races?

If there are supposed to be locks to protect globals in the MPAM driver,
is it worth wrapping them in access functions with a lockdep assert?
Otherwise, it feels rather easy to get this wrong -- I think I've found
at least one bug (see mpam_msc_drv_probe().)

> +
> +static void mpam_discovery_complete(void)
> +{
> +	pr_err("Discovered all MSC\n");
> +}

As others have commented, if this is non-functional code that gets
removed later on, it's probably best to drop this up-front?


[...]

> +static int mpam_dt_parse_resource(struct mpam_msc *msc, struct device_node *np,
> +				  u32 ris_idx)
> +{
> +	int err = 0;
> +	u32 level = 0;
> +	unsigned long cache_id;
> +	struct device_node *cache;
> +
> +	do {
> +		if (of_device_is_compatible(np, "arm,mpam-cache")) {
> +			cache = of_parse_phandle(np, "arm,mpam-device", 0);
> +			if (!cache) {
> +				pr_err("Failed to read phandle\n");
> +				break;
> +			}
> +		} else if (of_device_is_compatible(np->parent, "cache")) {
> +			cache = of_node_get(np->parent);
> +		} else {
> +			/* For now, only caches are supported */
> +			cache = NULL;
> +			break;
> +		}
> +
> +		err = of_property_read_u32(cache, "cache-level", &level);
> +		if (err) {
> +			pr_err("Failed to read cache-level\n");
> +			break;
> +		}
> +
> +		cache_id = cache_of_calculate_id(cache);
> +		if (cache_id == ~0UL) {

The type of cache_id may change if the return type of
cache_of_calculate_id() changes (see comments on patch 1).

Possible #define for the exceptional value.

> +			err = -ENOENT;
> +			break;

The lack of a diagnostic here is inconsistent with the level of
diagnostics in the rest of the loop.

> +		}
> +
> +		err = mpam_ris_create(msc, ris_idx, MPAM_CLASS_CACHE, level,
> +				      cache_id);
> +	} while (0);

Abuse of do ... while () here?

There is no loop.  The breaks are stealth "goto"s to this statement:

> +	of_node_put(cache);

(It works either way, but maybe gotos to an explicit label would be
more readable, as well as avoiding an unnecessary level of indentation.)

> +
> +	return err;
> +}

[...]

> +/*
> + * An MSC can control traffic from a set of CPUs, but may only be accessible
> + * from a (hopefully wider) set of CPUs. The common reason for this is power
> + * management. If all the CPUs in a cluster are in PSCI:CPU_SUSPEND, the
> + * the corresponding cache may also be powered off. By making accesses from

Nit: the the

> + * one of those CPUs, we ensure this isn't the case.
> + */
> +static int update_msc_accessibility(struct mpam_msc *msc)
> +{
> +	struct device_node *parent;
> +	u32 affinity_id;
> +	int err;
> +
> +	if (!acpi_disabled) {
> +		err = device_property_read_u32(&msc->pdev->dev, "cpu_affinity",
> +					       &affinity_id);
> +		if (err)
> +			cpumask_copy(&msc->accessibility, cpu_possible_mask);
> +		else
> +			acpi_pptt_get_cpus_from_container(affinity_id,
> +							  &msc->accessibility);
> +
> +		return 0;
> +	}
> +
> +	/* This depends on the path to of_node */
> +	parent = of_get_parent(msc->pdev->dev.of_node);
> +	if (parent == of_root) {
> +		cpumask_copy(&msc->accessibility, cpu_possible_mask);
> +		err = 0;
> +	} else {
> +		err = -EINVAL;
> +		pr_err("Cannot determine accessibility of MSC: %s\n",
> +		       dev_name(&msc->pdev->dev));
> +	}
> +	of_node_put(parent);
> +
> +	return err;
> +}
> +
> +static int fw_num_msc;

Does this need to be protected against data races?

If individual mpam_msc_drv_probe() calls may execute on different CPUs
from mpam_msc_driver_init(), then seem to be potential races here.

> +
> +static void mpam_pcc_rx_callback(struct mbox_client *cl, void *msg)
> +{
> +	/* TODO: wake up tasks blocked on this MSC's PCC channel */

So, is this broken in this commit?

(If the series does not get broken up or applied piecemail, that's not
such a concern, though.)

> +}
> +
> +static void mpam_msc_drv_remove(struct platform_device *pdev)
> +{

The MPAM driver cannot currently be built as a module.

Is it possible to exercise the driver remove paths, today?

> +	struct mpam_msc *msc = platform_get_drvdata(pdev);
> +
> +	if (!msc)
> +		return;
> +
> +	mutex_lock(&mpam_list_lock);
> +	mpam_num_msc--;
> +	platform_set_drvdata(pdev, NULL);
> +	list_del_rcu(&msc->glbl_list);
> +	synchronize_srcu(&mpam_srcu);
> +	devm_kfree(&pdev->dev, msc);
> +	mutex_unlock(&mpam_list_lock);
> +}
> +
> +static int mpam_msc_drv_probe(struct platform_device *pdev)
> +{
> +	int err;
> +	struct mpam_msc *msc;
> +	struct resource *msc_res;
> +	void *plat_data = pdev->dev.platform_data;
> +
> +	mutex_lock(&mpam_list_lock);
> +	do {
> +		msc = devm_kzalloc(&pdev->dev, sizeof(*msc), GFP_KERNEL);
> +		if (!msc) {
> +			err = -ENOMEM;
> +			break;
> +		}
> +
> +		mutex_init(&msc->probe_lock);
> +		mutex_init(&msc->part_sel_lock);
> +		mutex_init(&msc->outer_mon_sel_lock);
> +		raw_spin_lock_init(&msc->inner_mon_sel_lock);
> +		msc->id = mpam_num_msc++;
> +		msc->pdev = pdev;
> +		INIT_LIST_HEAD_RCU(&msc->glbl_list);
> +		INIT_LIST_HEAD_RCU(&msc->ris);
> +
> +		err = update_msc_accessibility(msc);
> +		if (err)
> +			break;
> +		if (cpumask_empty(&msc->accessibility)) {
> +			pr_err_once("msc:%u is not accessible from any CPU!",
> +				    msc->id);
> +			err = -EINVAL;
> +			break;
> +		}
> +
> +		if (device_property_read_u32(&pdev->dev, "pcc-channel",
> +					     &msc->pcc_subspace_id))
> +			msc->iface = MPAM_IFACE_MMIO;
> +		else
> +			msc->iface = MPAM_IFACE_PCC;
> +
> +		if (msc->iface == MPAM_IFACE_MMIO) {
> +			void __iomem *io;
> +
> +			io = devm_platform_get_and_ioremap_resource(pdev, 0,
> +								    &msc_res);
> +			if (IS_ERR(io)) {
> +				pr_err("Failed to map MSC base address\n");
> +				err = PTR_ERR(io);
> +				break;
> +			}
> +			msc->mapped_hwpage_sz = msc_res->end - msc_res->start;
> +			msc->mapped_hwpage = io;
> +		} else if (msc->iface == MPAM_IFACE_PCC) {
> +			msc->pcc_cl.dev = &pdev->dev;
> +			msc->pcc_cl.rx_callback = mpam_pcc_rx_callback;
> +			msc->pcc_cl.tx_block = false;
> +			msc->pcc_cl.tx_tout = 1000; /* 1s */
> +			msc->pcc_cl.knows_txdone = false;
> +
> +			msc->pcc_chan = pcc_mbox_request_channel(&msc->pcc_cl,
> +								 msc->pcc_subspace_id);
> +			if (IS_ERR(msc->pcc_chan)) {
> +				pr_err("Failed to request MSC PCC channel\n");
> +				err = PTR_ERR(msc->pcc_chan);
> +				break;
> +			}
> +		}

Should the lock be held across initialisation of the msc fields?

list_add_rcu() might imply sufficient barriers to ensure that the
initialisations are visible to other threads that obtain the msc
pointer by iterating over mpam_all_msc.

It's probably cleaner to hold the lock explicitly, though.

What other ways of obtaining the msc pointer exist?


> +
> +		list_add_rcu(&msc->glbl_list, &mpam_all_msc);
> +		platform_set_drvdata(pdev, msc);
> +	} while (0);
> +	mutex_unlock(&mpam_list_lock);
> +
> +	if (!err) {
> +		/* Create RIS entries described by firmware */
> +		if (!acpi_disabled)
> +			err = acpi_mpam_parse_resources(msc, plat_data);
> +		else
> +			err = mpam_dt_parse_resources(msc, plat_data);
> +	}
> +
> +	if (!err && fw_num_msc == mpam_num_msc)

Unlocked read of mpam_num_msc?

> +		mpam_discovery_complete();
> +
> +	if (err && msc)
> +		mpam_msc_drv_remove(pdev);
> +
> +	return err;
> +}
> +
> +static const struct of_device_id mpam_of_match[] = {
> +	{ .compatible = "arm,mpam-msc", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mpam_of_match);
> +
> +static struct platform_driver mpam_msc_driver = {
> +	.driver = {
> +		.name = "mpam_msc",
> +		.of_match_table = of_match_ptr(mpam_of_match),
> +	},
> +	.probe = mpam_msc_drv_probe,
> +	.remove = mpam_msc_drv_remove,
> +};
> +
> +/*
> + * MSC that are hidden under caches are not created as platform devices
> + * as there is no cache driver. Caches are also special-cased in
> + * update_msc_accessibility().
> + */

Can you elaborate?  I don't understand quite what this is doing.

> +static void mpam_dt_create_foundling_msc(void)
> +{
> +	int err;
> +	struct device_node *cache;
> +
> +	for_each_compatible_node(cache, NULL, "cache") {
> +		err = of_platform_populate(cache, mpam_of_match, NULL, NULL);
> +		if (err)
> +			pr_err("Failed to create MSC devices under caches\n");
> +	}
> +}

[...]

> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> new file mode 100644
> index 000000000000..07e0f240eaca
> --- /dev/null
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +// Copyright (C) 2024 Arm Ltd.
> +
> +#ifndef MPAM_INTERNAL_H
> +#define MPAM_INTERNAL_H
> +
> +#include <linux/arm_mpam.h>
> +#include <linux/cpumask.h>
> +#include <linux/io.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mutex.h>
> +#include <linux/resctrl.h>
> +#include <linux/sizes.h>
> +
> +struct mpam_msc {
> +	/* member of mpam_all_msc */
> +	struct list_head        glbl_list;

It is worth making these names less mismatched?

> +
> +	int			id;
> +	struct platform_device *pdev;
> +
> +	/* Not modified after mpam_is_enabled() becomes true */
> +	enum mpam_msc_iface	iface;
> +	u32			pcc_subspace_id;
> +	struct mbox_client	pcc_cl;
> +	struct pcc_mbox_chan	*pcc_chan;
> +	u32			nrdy_usec;
> +	cpumask_t		accessibility;
> +
> +	/*
> +	 * probe_lock is only take during discovery. After discovery these
> +	 * properties become read-only and the lists are protected by SRCU.
> +	 */
> +	struct mutex		probe_lock;

Can we have more clarify about the locking strategy, including details
of which things each lock is supposed to apply to and when, and how (if
at all) the locks are intended to nest?

(Similarly for the global locks.)

> +	unsigned long		ris_idxs[128 / BITS_PER_LONG];
> +	u32			ris_max;

nrdy_usec, ris_idxs and ris_max appear unused in this patch (though I
suppose they get initialised by virtue of kzalloc()).  Is this
intentional?

> +
> +	/* mpam_msc_ris of this component */
> +	struct list_head	ris;
> +
> +	/*
> +	 * part_sel_lock protects access to the MSC hardware registers that are
> +	 * affected by MPAMCFG_PART_SEL. (including the ID registers that vary
> +	 * by RIS).
> +	 * If needed, take msc->lock first.
> +	 */

What's msc->lock ?

> +	struct mutex		part_sel_lock;
> +
> +	/*
> +	 * mon_sel_lock protects access to the MSC hardware registers that are
> +	 * affeted by MPAMCFG_MON_SEL.
> +	 * If needed, take msc->lock first.
> +	 */

Same here.

> +	struct mutex		outer_mon_sel_lock;
> +	raw_spinlock_t		inner_mon_sel_lock;
> +	unsigned long		inner_mon_sel_flags;
> +
> +	void __iomem		*mapped_hwpage;
> +	size_t			mapped_hwpage_sz;
> +};
> +
> +#endif /* MPAM_INTERNAL_H */

[...]

Cheers
---Dave

