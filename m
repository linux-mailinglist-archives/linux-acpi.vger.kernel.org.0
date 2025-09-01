Return-Path: <linux-acpi+bounces-16244-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8A1B3DDBC
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Sep 2025 11:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663C3172EEE
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Sep 2025 09:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C7C308F0D;
	Mon,  1 Sep 2025 09:11:40 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DEA3054CA;
	Mon,  1 Sep 2025 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756717900; cv=none; b=dKIPH5j1jO8KybsHCDYf6j2XSOT74jwCw5wG70OANekbUuSuDJCEd6qNDQlClvlElKpFGp9oHcHM18LXjxTQe8xANHGdR0/jI3MZCofFalY0aQzVvnJwv/CJWfNhNsfEzEgoUARDV5yUAiOT1PYWzOV8/h5RmRs/RtTkwffD5xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756717900; c=relaxed/simple;
	bh=E5Lalbcg4v2zCi2EiEUCXwPTHYCLtDY2UGfJyj3pW94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ORctstrM75iNuFsVbnEBmcY8kHUg3K+xs4ZI93lU+0ETiOOXXgT3kPNyVpx7zy5w8VBeoyMs4IOSHHDv/7HG8zL4PQDWnIpmwfPaXREzcV45PNfmEu4xr/md58zNpF20xHAnwYg1w7tRrQXcXZiL+OFikIgvgmvDt6Yv0ICBkl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA0011A25;
	Mon,  1 Sep 2025 02:11:28 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B12733F694;
	Mon,  1 Sep 2025 02:11:31 -0700 (PDT)
Message-ID: <e5b2fa8d-c77e-49ac-a328-1363e472cc42@arm.com>
Date: Mon, 1 Sep 2025 10:11:30 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/33] arm_mpam: Add probe/remove for mpam msc driver and
 kbuild boiler plate
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-11-james.morse@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20250822153048.2287-11-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 8/22/25 16:29, James Morse wrote:
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
>  arch/arm64/Kconfig              |   1 +
>  drivers/Kconfig                 |   2 +
>  drivers/Makefile                |   1 +
>  drivers/resctrl/Kconfig         |  11 ++
>  drivers/resctrl/Makefile        |   4 +
>  drivers/resctrl/mpam_devices.c  | 336 ++++++++++++++++++++++++++++++++
>  drivers/resctrl/mpam_internal.h |  62 ++++++
>  7 files changed, 417 insertions(+)
>  create mode 100644 drivers/resctrl/Kconfig
>  create mode 100644 drivers/resctrl/Makefile
>  create mode 100644 drivers/resctrl/mpam_devices.c
>  create mode 100644 drivers/resctrl/mpam_internal.h
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index e51ccf1da102..ea3c54e04275 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2062,6 +2062,7 @@ config ARM64_TLB_RANGE
>  
>  config ARM64_MPAM
>  	bool "Enable support for MPAM"
> +	select ARM64_MPAM_DRIVER
>  	select ACPI_MPAM if ACPI
>  	help
>  	  Memory Partitioning and Monitoring is an optional extension
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 4915a63866b0..3054b50a2f4c 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -251,4 +251,6 @@ source "drivers/hte/Kconfig"
>  
>  source "drivers/cdx/Kconfig"
>  
> +source "drivers/resctrl/Kconfig"
> +
>  endmenu
> diff --git a/drivers/Makefile b/drivers/Makefile
> index b5749cf67044..f41cf4eddeba 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -194,5 +194,6 @@ obj-$(CONFIG_HTE)		+= hte/
>  obj-$(CONFIG_DRM_ACCEL)		+= accel/
>  obj-$(CONFIG_CDX_BUS)		+= cdx/
>  obj-$(CONFIG_DPLL)		+= dpll/
> +obj-y				+= resctrl/
>  
>  obj-$(CONFIG_S390)		+= s390/
> diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
> new file mode 100644
> index 000000000000..dff7b87280ab
> --- /dev/null
> +++ b/drivers/resctrl/Kconfig
> @@ -0,0 +1,11 @@
> +# Confusingly, this is everything but the CPU bits of MPAM. CPU here means
> +# CPU resources, not containers or cgroups etc.
> +config ARM64_MPAM_DRIVER
> +	bool "MPAM driver for System IP, e,g. caches and memory controllers"
> +	depends on ARM64_MPAM && EXPERT
> +
> +config ARM64_MPAM_DRIVER_DEBUG
> +	bool "Enable debug messages from the MPAM driver."
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
> +static u32 mpam_num_msc;
> +
> +static void mpam_discovery_complete(void)
> +{
> +	pr_err("Discovered all MSC\n");
> +}
> +
> +static int mpam_dt_count_msc(void)
> +{
> +	int count = 0;
> +	struct device_node *np;
> +
> +	for_each_compatible_node(np, NULL, "arm,mpam-msc") {
> +		if (of_device_is_available(np))
> +			count++;
> +	}
> +
> +	return count;
> +}
> +
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
> +			err = -ENOENT;
> +			break;
> +		}
> +
> +		err = mpam_ris_create(msc, ris_idx, MPAM_CLASS_CACHE, level,
> +				      cache_id);
> +	} while (0);
> +	of_node_put(cache);
> +
> +	return err;
> +}
> +
> +static int mpam_dt_parse_resources(struct mpam_msc *msc, void *ignored)
> +{
> +	int err, num_ris = 0;
> +	const u32 *ris_idx_p;
> +	struct device_node *iter, *np;
> +
> +	np = msc->pdev->dev.of_node;
> +	for_each_child_of_node(np, iter) {
> +		ris_idx_p = of_get_property(iter, "reg", NULL);
> +		if (ris_idx_p) {
> +			num_ris++;
> +			err = mpam_dt_parse_resource(msc, iter, *ris_idx_p);
> +			if (err) {
> +				of_node_put(iter);
> +				return err;
> +			}
> +		}
> +	}
> +
> +	if (!num_ris)
> +		mpam_dt_parse_resource(msc, np, 0);
> +
> +	return err;
> +}
> +
> +/*
> + * An MSC can control traffic from a set of CPUs, but may only be accessible
> + * from a (hopefully wider) set of CPUs. The common reason for this is power
> + * management. If all the CPUs in a cluster are in PSCI:CPU_SUSPEND, the
> + * the corresponding cache may also be powered off. By making accesses from
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
> +
> +static void mpam_pcc_rx_callback(struct mbox_client *cl, void *msg)
> +{
> +	/* TODO: wake up tasks blocked on this MSC's PCC channel */
> +}
> +
> +static void mpam_msc_drv_remove(struct platform_device *pdev)
> +{
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
> +
> +static int __init mpam_msc_driver_init(void)
> +{
> +	if (!system_supports_mpam())
> +		return -EOPNOTSUPP;
> +
> +	init_srcu_struct(&mpam_srcu);
> +
> +	if (!acpi_disabled)
> +		fw_num_msc = acpi_mpam_count_msc();
> +	else
> +		fw_num_msc = mpam_dt_count_msc();
> +
> +	if (fw_num_msc <= 0) {
> +		pr_err("No MSC devices found in firmware\n");
> +		return -EINVAL;
> +	}
> +
> +	if (acpi_disabled)
> +		mpam_dt_create_foundling_msc();
> +
> +	return platform_driver_register(&mpam_msc_driver);
> +}
> +subsys_initcall(mpam_msc_driver_init);
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
> +	unsigned long		ris_idxs[128 / BITS_PER_LONG];

Why is this sized this way? RIS_MAX is 4 bits and so there are at most
16 RIS per msc.

> +	u32			ris_max;
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
> +	struct mutex		part_sel_lock;
> +
> +	/*
> +	 * mon_sel_lock protects access to the MSC hardware registers that are
> +	 * affeted by MPAMCFG_MON_SEL.
> +	 * If needed, take msc->lock first.
> +	 */
> +	struct mutex		outer_mon_sel_lock;
> +	raw_spinlock_t		inner_mon_sel_lock;
> +	unsigned long		inner_mon_sel_flags;
> +
> +	void __iomem		*mapped_hwpage;
> +	size_t			mapped_hwpage_sz;
> +};
> +
> +#endif /* MPAM_INTERNAL_H */

Thanks,

Ben


