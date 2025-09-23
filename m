Return-Path: <linux-acpi+bounces-17234-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8818BB96DBB
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 18:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7369718A65B8
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 16:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF4632340F;
	Tue, 23 Sep 2025 16:41:57 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5020522AE65;
	Tue, 23 Sep 2025 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758645717; cv=none; b=P7PNVJR8PMZvfPSz4dEJB9dufoW5S1WdLSNcmSg4PQewzMvBdSRFWkcru0knyeQA9h2srviKYs7kIWEKR7nq+IogejbT5/1EWxocxDZvRirHpnI0f7v4lp51JVbngpk9hunTcBQw03XuzwDsurvvlbSI32pwGUM0ZOlFircALtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758645717; c=relaxed/simple;
	bh=gZe5FiFZ7M0StdCKYyKXJNR7TGjrDotB7KodsnR+9k4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KUm/+YAUzKoe7Vf69JBBuEgv9BgvDF0wMIRdFlHFDygPnOwZFEPF3PVLSBH3dUwYYGrruanTnEbEuseNyliviItuQLbtODPpObmLpgi3PLn41HK9beC5aC5z5ycVO1MSnHJFsmTKZgnr8tS0c4o+FQ8KZ96ke5IkI8hjL9Jmcp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F13A497;
	Tue, 23 Sep 2025 09:41:46 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8973B3F694;
	Tue, 23 Sep 2025 09:41:49 -0700 (PDT)
Message-ID: <9982847d-2878-4748-8c65-2d98a2e47396@arm.com>
Date: Tue, 23 Sep 2025 17:41:47 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/29] arm_mpam: Add probe/remove for mpam msc driver
 and kbuild boiler plate
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
 <20250910204309.20751-8-james.morse@arm.com>
 <20250911143544.000026aa@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250911143544.000026aa@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 11/09/2025 14:35, Jonathan Cameron wrote:
> On Wed, 10 Sep 2025 20:42:47 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> Probing MPAM is convoluted. MSCs that are integrated with a CPU may
>> only be accessible from those CPUs, and they may not be online.
>> Touching the hardware early is pointless as MPAM can't be used until
>> the system-wide common values for num_partid and num_pmg have been
>> discovered.
>>
>> Start with driver probe/remove and mapping the MSC.

> Hi James,
> 
> Various comments inline.  You can ignore the do/while(0)
> one but I'll probably forget and send more grumpy comments about it ;)

I got exposed to this quite a lot in some other project - its better than a goto.
Due to the heavy exposure, I don't think its odd - I'm just used to seeing it.
(not sure its quite Stockholm syndrome yet)


>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 6487c511bdc6..93e563e1cce4 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -2062,6 +2062,7 @@ config ARM64_TLB_RANGE
>>  
>>  config ARM64_MPAM
>>  	bool "Enable support for MPAM"
>> +	select ARM64_MPAM_DRIVER if EXPERT
> 
> To me that wants a comment as it's unusual.

Sure - "# does nothing yet".
This is to stop it being enabled in distros as it can't be used until the resctrl part is
added.


>> diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
>> new file mode 100644
>> index 000000000000..c30532a3a3a4
>> --- /dev/null
>> +++ b/drivers/resctrl/Kconfig
>> @@ -0,0 +1,14 @@
>> +menuconfig ARM64_MPAM_DRIVER
>> +	bool "MPAM driver"
>> +	depends on ARM64 && ARM64_MPAM && EXPERT
>> +	help
>> +	  MPAM driver for System IP, e,g. caches and memory controllers.
>> +
>> +if ARM64_MPAM_DRIVER
>> +config ARM64_MPAM_DRIVER_DEBUG
>> +	bool "Enable debug messages from the MPAM driver"
>> +	depends on ARM64_MPAM_DRIVER
> 
> The depends on should make the if unnecessary.

Yup, that was a recent change and I didn't spot the duplication.


>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> new file mode 100644
>> index 000000000000..efc4738e3b4d
>> --- /dev/null
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -0,0 +1,180 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (C) 2025 Arm Ltd.
>> +
>> +#define pr_fmt(fmt) "%s:%s: " fmt, KBUILD_MODNAME, __func__
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/arm_mpam.h>
>> +#include <linux/cacheinfo.h>
>> +#include <linux/cpu.h>
>> +#include <linux/cpumask.h>
>> +#include <linux/device.h>
>> +#include <linux/errno.h>
>> +#include <linux/gfp.h>
>> +#include <linux/list.h>
>> +#include <linux/lockdep.h>
>> +#include <linux/mutex.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/printk.h>
>> +#include <linux/slab.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/srcu.h>
>> +#include <linux/types.h>
> 
>> +/*
>> + * An MSC can control traffic from a set of CPUs, but may only be accessible
>> + * from a (hopefully wider) set of CPUs. The common reason for this is power
>> + * management. If all the CPUs in a cluster are in PSCI:CPU_SUSPEND, the
>> + * corresponding cache may also be powered off. By making accesses from
>> + * one of those CPUs, we ensure this isn't the case.
>> + */
>> +static int update_msc_accessibility(struct mpam_msc *msc)
>> +{
>> +	u32 affinity_id;
>> +	int err;
>> +
>> +	err = device_property_read_u32(&msc->pdev->dev, "cpu_affinity",
>> +				       &affinity_id);
>> +	if (err)
>> +		cpumask_copy(&msc->accessibility, cpu_possible_mask);
>> +	else
>> +		acpi_pptt_get_cpus_from_container(affinity_id,
>> +						  &msc->accessibility);
>> +
>> +	return 0;
>> +
>> +	return err;
> 
> Curious. I'd do a build test after each patch before v3. A couple of
> places would have failed or given helpful warnings so far.

Oddly - the compiler is quite happy with this. Not sure why.
I've fixed it to return err.

This was due to the last second rip-out of the DT support.


>> +}
> 
>> +
>> +static int mpam_msc_drv_probe(struct platform_device *pdev)
>> +{
>> +	int err;
>> +	struct mpam_msc *msc;
>> +	struct resource *msc_res;
>> +	struct device *dev = &pdev->dev;
>> +	void *plat_data = pdev->dev.platform_data;
>> +
>> +	mutex_lock(&mpam_list_lock);
>> +	do {
> 
> I might well have moaned about this before, but I really dislike a do while(0)
> if it doesn't fit on my screen (and my eyesight is poor so that's not this
> many lines).  To me a non trivial case of this is almost always a place
> where a '_do' function would have made it more readable. 

I guess I'm very used to seeing this pattern, so I don't notice it.

I've change this to a do_ thing with all this shoved in another function.


> I'm also not a fan of scoped_guard() plus breaks because it feels like
> it is dependent on an implementation detail but maybe it's clearer than this.

(i.e. the cleanup stuff? I'd always prefer to see the free/unlock call)


>> +		msc = devm_kzalloc(&pdev->dev, sizeof(*msc), GFP_KERNEL);
>> +		if (!msc) {
>> +			err = -ENOMEM;
>> +			break;
>> +		}
>> +
>> +		mutex_init(&msc->probe_lock);
>> +		mutex_init(&msc->part_sel_lock);
>> +		mutex_init(&msc->outer_mon_sel_lock);
>> +		raw_spin_lock_init(&msc->inner_mon_sel_lock);
>> +		msc->id = pdev->id;
>> +		msc->pdev = pdev;
>> +		INIT_LIST_HEAD_RCU(&msc->all_msc_list);
>> +		INIT_LIST_HEAD_RCU(&msc->ris);
>> +
>> +		err = update_msc_accessibility(msc);
>> +		if (err)
>> +			break;
>> +		if (cpumask_empty(&msc->accessibility)) {
>> +			dev_err_once(dev, "MSC is not accessible from any CPU!");
>> +			err = -EINVAL;
>> +			break;
>> +		}
>> +
>> +		if (device_property_read_u32(&pdev->dev, "pcc-channel",
>> +					     &msc->pcc_subspace_id))
>> +			msc->iface = MPAM_IFACE_MMIO;
>> +		else
>> +			msc->iface = MPAM_IFACE_PCC;
>> +
>> +		if (msc->iface == MPAM_IFACE_MMIO) {
>> +			void __iomem *io;
>> +
>> +			io = devm_platform_get_and_ioremap_resource(pdev, 0,
>> +								    &msc_res);
>> +			if (IS_ERR(io)) {
>> +				dev_err_once(dev, "Failed to map MSC base address\n");
>> +				err = PTR_ERR(io);
>> +				break;
>> +			}
>> +			msc->mapped_hwpage_sz = msc_res->end - msc_res->start;
>> +			msc->mapped_hwpage = io;
>> +		}
>> +
>> +		list_add_rcu(&msc->all_msc_list, &mpam_all_msc);
>> +		platform_set_drvdata(pdev, msc);
>> +	} while (0);
>> +	mutex_unlock(&mpam_list_lock);
>> +
>> +	if (!err) {
>> +		/* Create RIS entries described by firmware */
>> +		err = acpi_mpam_parse_resources(msc, plat_data);
>> +	}
>> +
>> +	if (err && msc)
>> +		mpam_msc_drv_remove(pdev);
> 
> Is it worth bothering to remove?  We failed probe anyway if we got here
> and it's not expected to happen on real systems so I'd just leave it around
> so that you can exit early above.

Symmetry and the principle of least surprise.
Ideally the probing code wouldn't need to unwind what it did, it can rely on the remove
code to do the necessary. It was a patch from Carl Worth that did this as the
unwind/remove code was duplication.

I agree there is no error that requires it here, but later patches add things like debugfs
entries that need removing before the struct mpam_msc memory can be free'd - potentially
by the devm stuff if the probe function returns an error due to the firmware tables 'RIS'
description being wonky.


> I'm also not following why the msc check is relevant if you do want to do
> this. Can only get here without msc if the allocation failed. Why would
> we leave the driver loaded in only that case?

Simply because the remove/destroy code goes dereferencing msc, so that is the one case
that mustn't get in there. With your do_ version of the above this got simplified.


>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
>> new file mode 100644
>> index 000000000000..7c63d590fc98
>> --- /dev/null
>> +++ b/drivers/resctrl/mpam_internal.h
>> @@ -0,0 +1,65 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +// Copyright (C) 2025 Arm Ltd.
>> +
>> +#ifndef MPAM_INTERNAL_H
>> +#define MPAM_INTERNAL_H
>> +
>> +#include <linux/arm_mpam.h>
>> +#include <linux/cpumask.h>
>> +#include <linux/io.h>
>> +#include <linux/mailbox_client.h>
>> +#include <linux/mutex.h>
> 
> spinlock.h

Fixed,


>> +#include <linux/resctrl.h>
> 
> Not spotting anything rsctl yet.  So maybe this belongs later.

There shouldn't be anything that depends on resctrl in this series - looks like
this is a 2018 era bug in the way I carved this up!


>> +#include <linux/sizes.h>
>> +
>> +struct mpam_msc {
>> +	/* member of mpam_all_msc */
>> +	struct list_head        all_msc_list;
>> +
>> +	int			id;
> 
> I'd follow (approx) include what you use principles to make later header
> shuffling easier. So a forward def for this.

-ENOPARSE

I'm sure I'll work this out from your later comments.


>> +	struct platform_device *pdev;
>> +
>> +	/* Not modified after mpam_is_enabled() becomes true */
>> +	enum mpam_msc_iface	iface;
>> +	u32			pcc_subspace_id;
>> +	struct mbox_client	pcc_cl;
>> +	struct pcc_mbox_chan	*pcc_chan;
> 
> Forward def or include acpi/pcc.h

The PCC code got pulled later, and out of this series. I missed these bits.


>> +	u32			nrdy_usec;
>> +	cpumask_t		accessibility;
>> +
>> +	/*
>> +	 * probe_lock is only taken during discovery. After discovery these
>> +	 * properties become read-only and the lists are protected by SRCU.
>> +	 */
>> +	struct mutex		probe_lock;
>> +	unsigned long		ris_idxs;
>> +	u32			ris_max;
>> +
>> +	/* mpam_msc_ris of this component */
>> +	struct list_head	ris;
>> +
>> +	/*
>> +	 * part_sel_lock protects access to the MSC hardware registers that are
>> +	 * affected by MPAMCFG_PART_SEL. (including the ID registers that vary
>> +	 * by RIS).
>> +	 * If needed, take msc->probe_lock first.
>> +	 */
>> +	struct mutex		part_sel_lock;
>> +
>> +	/*
>> +	 * mon_sel_lock protects access to the MSC hardware registers that are
>> +	 * affected by MPAMCFG_MON_SEL.
>> +	 * If needed, take msc->probe_lock first.
>> +	 */
>> +	struct mutex		outer_mon_sel_lock;
>> +	raw_spinlock_t		inner_mon_sel_lock;
>> +	unsigned long		inner_mon_sel_flags;
>> +
>> +	void __iomem		*mapped_hwpage;
>> +	size_t			mapped_hwpage_sz;
>> +};
>> +
>> +int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
>> +				   cpumask_t *affinity);
> 
> Where is this?

Ugh, more bits of DT - this one is non-obvious because of the name.


Thanks,

James

