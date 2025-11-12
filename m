Return-Path: <linux-acpi+bounces-18810-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFB2C53657
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 17:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6D26219B9
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 15:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3803B3101DB;
	Wed, 12 Nov 2025 15:33:08 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFE22BE03D;
	Wed, 12 Nov 2025 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961588; cv=none; b=C84un0nlXY5XMSiAByfB0lJV6D/SiMAzoe97LPErrmVkgrzvJW58b/4Oy/anZLN1TOwiIkemu9aLiOoQ41cgNMX66Y9HBu0Tbc3X0TCL0aUt+M69cN49mNs2NIqFOEz3DNEoOIdKFD1YlennsXcGRVFosJveAqu5lmtqnQivR2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961588; c=relaxed/simple;
	bh=hJG4mORyBX4EkyEoNAxykxgfA/y6DRF79lt33YV3ch4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VwSyt3H9RFSNjOdcEInpzIsfzVwZjVDa+r2KjSGFqkOJe7ZNCtLfQpNcGchuZxFFt9Sppwq8WdOEPEQ8rHUqZ6TbjKBMgENxXEmiMVUIZFoigcEpTv8bSy76A0Mp7iIwJfM1yHLOflTMGpPERyxvAGOpuMR2Dwg5i84uvbelilM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B0681515;
	Wed, 12 Nov 2025 07:32:56 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 261973F66E;
	Wed, 12 Nov 2025 07:32:59 -0800 (PST)
Message-ID: <85ce2f10-d174-472d-b74c-a3e34dc4a40f@arm.com>
Date: Wed, 12 Nov 2025 15:32:57 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/33] arm_mpam: Add probe/remove for mpam msc driver and
 kbuild boiler plate
To: Gavin Shan <gshan@redhat.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-11-ben.horgan@arm.com>
 <5b9136d6-b6c0-4f24-a8d2-05d7700140a8@redhat.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <5b9136d6-b6c0-4f24-a8d2-05d7700140a8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Gavin,

On 11/8/25 09:28, Gavin Shan wrote:
> Hi Ben,
> 
> On 11/7/25 10:34 PM, Ben Horgan wrote:
>> From: James Morse <james.morse@arm.com>
>>
>> Probing MPAM is convoluted. MSCs that are integrated with a CPU may
>> only be accessible from those CPUs, and they may not be online.
>> Touching the hardware early is pointless as MPAM can't be used until
>> the system-wide common values for num_partid and num_pmg have been
>> discovered.
>>
> 
> I'm not sure if below commit log is more clearer as I'm not a English
> native speaker:

Thanks for the detailed review of the messages and comments. I've
skipped the ones that I think don't improve the clarity. (I see Jonathan
has a detailed reply which matches my understanding of English.)

> 
> MPAM probing is convoluted. MSCs that are integrated to a set of CPUs
> may only be accessible from those CPUs, ...
> 
>> Start with driver probe/remove and mapping the MSC.
>>
>> CC: Carl Worth <carl@os.amperecomputing.com>
>> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
>> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
>> Tested-by: Peter Newman <peternewman@google.com>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
>> ---
>> Changes since v3:
>>  From Jonathan:
>> Include cleanup
>> Use devm_mutex_init()
>> Add an ERR_CAST()
>> Fenghua:
>> Return zero from update_msc_accessibility()
>> Additional:
>> Fail probe if MSC doesn't have an MMIO interface
>> ---
>>   arch/arm64/Kconfig              |   1 +
>>   drivers/Kconfig                 |   2 +
>>   drivers/Makefile                |   1 +
>>   drivers/resctrl/Kconfig         |  15 +++
>>   drivers/resctrl/Makefile        |   4 +
>>   drivers/resctrl/mpam_devices.c  | 194 ++++++++++++++++++++++++++++++++
>>   drivers/resctrl/mpam_internal.h |  49 ++++++++
>>   7 files changed, 266 insertions(+)
>>   create mode 100644 drivers/resctrl/Kconfig
>>   create mode 100644 drivers/resctrl/Makefile
>>   create mode 100644 drivers/resctrl/mpam_devices.c
>>   create mode 100644 drivers/resctrl/mpam_internal.h
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index c5e66d5d72cd..004d58cfbff8 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -2025,6 +2025,7 @@ config ARM64_TLB_RANGE
>>     config ARM64_MPAM
>>       bool "Enable support for MPAM"
>> +    select ARM64_MPAM_DRIVER if EXPERT    # does nothing yet
>>       select ACPI_MPAM if ACPI
>>       help
>>         Memory System Resource Partitioning and Monitoring (MPAM) is an
>> diff --git a/drivers/Kconfig b/drivers/Kconfig
>> index 4915a63866b0..3054b50a2f4c 100644
>> --- a/drivers/Kconfig
>> +++ b/drivers/Kconfig
>> @@ -251,4 +251,6 @@ source "drivers/hte/Kconfig"
>>     source "drivers/cdx/Kconfig"
>>   +source "drivers/resctrl/Kconfig"
>> +
>>   endmenu
>> diff --git a/drivers/Makefile b/drivers/Makefile
>> index 8e1ffa4358d5..20eb17596b89 100644
>> --- a/drivers/Makefile
>> +++ b/drivers/Makefile
>> @@ -194,6 +194,7 @@ obj-$(CONFIG_HTE)        += hte/
>>   obj-$(CONFIG_DRM_ACCEL)        += accel/
>>   obj-$(CONFIG_CDX_BUS)        += cdx/
>>   obj-$(CONFIG_DPLL)        += dpll/
>> +obj-y                += resctrl/
>>     obj-$(CONFIG_DIBS)        += dibs/
>>   obj-$(CONFIG_S390)        += s390/
>> diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
>> new file mode 100644
>> index 000000000000..ef2f3adf64a9
>> --- /dev/null
>> +++ b/drivers/resctrl/Kconfig
>> @@ -0,0 +1,15 @@
>> +menuconfig ARM64_MPAM_DRIVER
>> +    bool "MPAM driver"
>> +    depends on ARM64 && ARM64_MPAM && EXPERT
>> +    help
>> +      Memory System Resource Partitioning and Monitoring (MPAM)
>> driver for
>> +      System IP, e,g. caches and memory controllers.
>> +
>> +if ARM64_MPAM_DRIVER
>> +
>> +config ARM64_MPAM_DRIVER_DEBUG
>> +    bool "Enable debug messages from the MPAM driver"
>> +    help
>> +      Say yes here to enable debug messages from the MPAM driver.
>> +
>> +endif
> 
> I am asking myself why "depends on ARM64_MPAM_DRIVER" can't be used
> here? :-)
> 
>> diff --git a/drivers/resctrl/Makefile b/drivers/resctrl/Makefile
>> new file mode 100644
>> index 000000000000..898199dcf80d
>> --- /dev/null
>> +++ b/drivers/resctrl/Makefile
>> @@ -0,0 +1,4 @@
>> +obj-$(CONFIG_ARM64_MPAM_DRIVER)            += mpam.o
>> +mpam-y                        += mpam_devices.o
>> +
>> +ccflags-$(CONFIG_ARM64_MPAM_DRIVER_DEBUG)    += -DDEBUG
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/
>> mpam_devices.c
>> new file mode 100644
>> index 000000000000..6c6be133d73a
>> --- /dev/null
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -0,0 +1,194 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (C) 2025 Arm Ltd.
>> +
>> +#define pr_fmt(fmt) "%s:%s: " fmt, KBUILD_MODNAME, __func__
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/arm_mpam.h>
>> +#include <linux/cacheinfo.h>
>> +#include <linux/cpumask.h>
>> +#include <linux/device.h>
>> +#include <linux/errno.h>
>> +#include <linux/gfp.h>
>> +#include <linux/list.h>
>> +#include <linux/lockdep.h>
>> +#include <linux/mutex.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/printk.h>
>> +#include <linux/srcu.h>
>> +#include <linux/types.h>
>> +
>> +#include "mpam_internal.h"
>> +
>> +/*
>> + * mpam_list_lock protects the SRCU lists when writing. Once the
>> + * mpam_enabled key is enabled these lists are read-only,
>> + * unless the error interrupt disables the driver.
>> + */
> 
> s/when writing/for writing
> s/are read-only/become read-only
> 
>> +static DEFINE_MUTEX(mpam_list_lock);
>> +static LIST_HEAD(mpam_all_msc);
>> +
>> +struct srcu_struct mpam_srcu;
>> +
>> +/*
>> + * Number of MSCs that have been probed. Once all MSC have been
>> probed MPAM
>> + * can be enabled.
>> + */
> 
> s/all MSC/all MSCs  (?)
Changed.
> 
>> +static atomic_t mpam_num_msc;
>> +
>> +/*
>> + * An MSC can control traffic from a set of CPUs, but may only be
>> accessible
>> + * from a (hopefully wider) set of CPUs. The common reason for this
>> is power
>> + * management. If all the CPUs in a cluster are in PSCI:CPU_SUSPEND, the
>> + * corresponding cache may also be powered off. By making accesses from
>> + * one of those CPUs, we ensure this isn't the case.
>> + */
> 
> s/An MSC/A MSC (?)
> s/from a/from the
> s/isn't the case/is the case (?)
Updated this last one to be:

By making accesses from one of those CPUs, we ensure we don't access a
cache that's powered off.

> 
>> +static int update_msc_accessibility(struct mpam_msc *msc)
>> +{
>> +    u32 affinity_id;
>> +    int err;
>> +
>> +    err = device_property_read_u32(&msc->pdev->dev, "cpu_affinity",
>> +                       &affinity_id);
>> +    if (err)
>> +        cpumask_copy(&msc->accessibility, cpu_possible_mask);
>> +    else
>> +        acpi_pptt_get_cpus_from_container(affinity_id,
>> +                          &msc->accessibility);
>> +    return 0;
>> +}
>> +
> 
> {} is needed for the block spanning multiple lines.

Made it one line.

> 
> I would validate msc->accessibility here instead of its caller
> (do_mpam_msc_drv_probe()).
> 
>         if (cpumask_empty(&msc->accessibility))
>             return {-EINVAL, -ENOENT};
> 
>> +static int fw_num_msc;
>> +
>> +static void mpam_msc_destroy(struct mpam_msc *msc)
>> +{
>> +    struct platform_device *pdev = msc->pdev;
>> +
>> +    lockdep_assert_held(&mpam_list_lock);
>> +
>> +    list_del_rcu(&msc->all_msc_list);
>> +    platform_set_drvdata(pdev, NULL);
>> +}
>> +
>> +static void mpam_msc_drv_remove(struct platform_device *pdev)
>> +{
>> +    struct mpam_msc *msc = platform_get_drvdata(pdev);
>> +
>> +    if (!msc)
>> +        return;
> 
> 'msc' is unlikely to be NULL here, so the check could be droped.

Dropped.

> 
>> +
>> +    mutex_lock(&mpam_list_lock);
>> +    mpam_msc_destroy(msc);
>> +    mutex_unlock(&mpam_list_lock);
>> +
>> +    synchronize_srcu(&mpam_srcu);
>> +}
>> +
>> +static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device
>> *pdev)
>> +{
>> +    int err;
>> +    u32 tmp;
>> +    struct mpam_msc *msc;
>> +    struct resource *msc_res;
>> +    struct device *dev = &pdev->dev;
>> +
>> +    lockdep_assert_held(&mpam_list_lock);
>> +
>> +    msc = devm_kzalloc(&pdev->dev, sizeof(*msc), GFP_KERNEL);
>> +    if (!msc)
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    err = devm_mutex_init(dev, &msc->probe_lock);
>> +    if (err)
>> +        return ERR_PTR(err);
>> +    err = devm_mutex_init(dev, &msc->part_sel_lock);
>> +    if (err)
>> +        return ERR_PTR(err);
>> +    msc->id = pdev->id;
>> +    msc->pdev = pdev;
>> +    INIT_LIST_HEAD_RCU(&msc->all_msc_list);
>> +    INIT_LIST_HEAD_RCU(&msc->ris);
>> +
>> +    err = update_msc_accessibility(msc);
>> +    if (err)
>> +        return ERR_PTR(err);
>> +    if (cpumask_empty(&msc->accessibility)) {
>> +        dev_err_once(dev, "MSC is not accessible from any CPU!");
>> +        return ERR_PTR(-EINVAL);
>> +    }
>> +
> 
> As suggested above, this check would be done inside
> update_msc_accessibility().

Unless you object I'll keep this as is and make void
update_msc_accessibility() a void function. I think this works better
with the naming.

> 
>> +    if (device_property_read_u32(&pdev->dev, "pcc-channel", &tmp))
>> +        msc->iface = MPAM_IFACE_MMIO;
>> +    else
>> +        msc->iface = MPAM_IFACE_PCC;
>> +
>> +    if (msc->iface == MPAM_IFACE_MMIO) {
>> +        void __iomem *io;
>> +
>> +        io = devm_platform_get_and_ioremap_resource(pdev, 0,
>> +                                &msc_res);
>> +        if (IS_ERR(io)) {
>> +            dev_err_once(dev, "Failed to map MSC base address\n");
>> +            return ERR_CAST(io);
>> +        }
>> +        msc->mapped_hwpage_sz = msc_res->end - msc_res->start;
>> +        msc->mapped_hwpage = io;
>> +    } else {
>> +        return ERR_PTR(-ENOENT);
> 
> Would be:
>         return ERR_PTR(-EINVAL);

Sure.

> 
>> +    }
>> +
>> +    list_add_rcu(&msc->all_msc_list, &mpam_all_msc);
>> +    platform_set_drvdata(pdev, msc);
>> +
>> +    return msc;
>> +}
>> +
>> +static int mpam_msc_drv_probe(struct platform_device *pdev)
>> +{
>> +    int err;
>> +    struct mpam_msc *msc = NULL;
>> +    void *plat_data = pdev->dev.platform_data;
>> +
>> +    mutex_lock(&mpam_list_lock);
>> +    msc = do_mpam_msc_drv_probe(pdev);
>> +    mutex_unlock(&mpam_list_lock);
>> +    if (!IS_ERR(msc)) {
>> +        /* Create RIS entries described by firmware */
>> +        err = acpi_mpam_parse_resources(msc, plat_data);
>> +        if (err)
>> +            mpam_msc_drv_remove(pdev);
>> +    } else {
>> +        err = PTR_ERR(msc);
>> +    }
>> +
>> +    if (!err && atomic_add_return(1, &mpam_num_msc) == fw_num_msc)
>> +        pr_info("Discovered all MSC\n");
> 
> s/all MSC/all MSCs
> 
>> +
>> +    return err;
>> +}
>> +
>> +static struct platform_driver mpam_msc_driver = {
>> +    .driver = {
>> +        .name = "mpam_msc",
>> +    },
>> +    .probe = mpam_msc_drv_probe,
>> +    .remove = mpam_msc_drv_remove,
>> +};
>> +
>> +static int __init mpam_msc_driver_init(void)
>> +{
>> +    if (!system_supports_mpam())
>> +        return -EOPNOTSUPP;
>> +
>> +    init_srcu_struct(&mpam_srcu);
>> +
>> +    fw_num_msc = acpi_mpam_count_msc();
>> +
>> +    if (fw_num_msc <= 0) {
>> +        pr_err("No MSC devices found in firmware\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    return platform_driver_register(&mpam_msc_driver);
>> +}
>> +subsys_initcall(mpam_msc_driver_init);
>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/
>> mpam_internal.h
>> new file mode 100644
>> index 000000000000..540066903eca
>> --- /dev/null
>> +++ b/drivers/resctrl/mpam_internal.h
>> @@ -0,0 +1,49 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +// Copyright (C) 2025 Arm Ltd.
>> +
>> +#ifndef MPAM_INTERNAL_H
>> +#define MPAM_INTERNAL_H
>> +
>> +#include <linux/arm_mpam.h>
>> +#include <linux/cpumask.h>
>> +#include <linux/io.h>
>> +#include <linux/mutex.h>
>> +#include <linux/types.h>
>> +
>> +struct platform_device;
>> +
>> +struct mpam_msc {
>> +    /* member of mpam_all_msc */
>> +    struct list_head    all_msc_list;
>> +
>> +    int            id;
>> +    struct platform_device    *pdev;
>> +
>> +    /* Not modified after mpam_is_enabled() becomes true */
>> +    enum mpam_msc_iface    iface;
>> +    u32            nrdy_usec;
>> +    cpumask_t        accessibility;
>> +
>> +    /*
>> +     * probe_lock is only taken during discovery. After discovery these
>> +     * properties become read-only and the lists are protected by SRCU.
>> +     */
>> +    struct mutex        probe_lock;
>> +    unsigned long        ris_idxs;
>> +    u32            ris_max;
>> +
>> +    /* mpam_msc_ris of this component */
>> +    struct list_head    ris;
>> +
>> +    /*
>> +     * part_sel_lock protects access to the MSC hardware registers
>> that are
>> +     * affected by MPAMCFG_PART_SEL. (including the ID registers that
>> vary
>> +     * by RIS).
>> +     * If needed, take msc->probe_lock first.
>> +     */
>> +    struct mutex        part_sel_lock;
>> +
>> +    void __iomem        *mapped_hwpage;
>> +    size_t            mapped_hwpage_sz;
>> +};
>> +#endif /* MPAM_INTERNAL_H */
> 
> Thanks,
> Gavin
> 

Thanks,

Ben


