Return-Path: <linux-acpi+bounces-16428-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125D7B462DF
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 20:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F492174815
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 18:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E358E288C2B;
	Fri,  5 Sep 2025 18:52:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6250D28725D;
	Fri,  5 Sep 2025 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098339; cv=none; b=jCA1BBqlxHiU8CzNI2/DFctS/+3MOmcLRp/CuXJeJUSQgAgzg1YBL8HE2t6TaZyS3DS64dAVeWCp4/VQCYymcA2SObALXSRt26tTpbz/GKWOEneirMrLdj6Y0sxAw+Pz/irp0OzoJNcT12l2K/mId0xFotWwHdTDs0JAzEQiywI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098339; c=relaxed/simple;
	bh=8Uzns22OfU+DBCcL90KJRu1ulT0ZuTWyxXnwRelryJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFSJVVqUu7tmAAeij+sn3V27zsNPVuEluD+S2jGtkP6vj212zcXemKDBwyfA0Y/cPZ12N51y7Yg2rGLLFe6976yk6s7rsIzPZgk+Hri80yipnwZ+Ci7CXZeKYHkMfHLS8se4emYPT5tyskc16KnQjoQEY/B2gdOym+iCL8XMOCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A091C1424;
	Fri,  5 Sep 2025 11:52:08 -0700 (PDT)
Received: from [10.1.197.69] (unknown [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 411963F6A8;
	Fri,  5 Sep 2025 11:52:09 -0700 (PDT)
Message-ID: <dc431877-b3c7-4682-a264-9b235934ab1d@arm.com>
Date: Fri, 5 Sep 2025 19:52:07 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/33] arm_mpam: Add probe/remove for mpam msc driver and
 kbuild boiler plate
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 shameerali.kolothum.thodi@huawei.com,
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
 Rohit Mathew <rohit.mathew@arm.com>, Rafael Wysocki <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-11-james.morse@arm.com>
 <CAL_JsqKUSJjmyj-E6eduZt3S=x6v7VUR5JEJV_Ow6O-O49TgEg@mail.gmail.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <CAL_JsqKUSJjmyj-E6eduZt3S=x6v7VUR5JEJV_Ow6O-O49TgEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Rob,

On 27/08/2025 16:39, Rob Herring wrote:
> On Fri, Aug 22, 2025 at 10:32 AM James Morse <james.morse@arm.com> wrote:
>>
>> Probing MPAM is convoluted. MSCs that are integrated with a CPU may
>> only be accessible from those CPUs, and they may not be online.
>> Touching the hardware early is pointless as MPAM can't be used until
>> the system-wide common values for num_partid and num_pmg have been
>> discovered.
>>
>> Start with driver probe/remove and mapping the MSC.


>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> new file mode 100644
>> index 000000000000..a0d9a699a6e7
>> --- /dev/null
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -0,0 +1,336 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (C) 2025 Arm Ltd.
>
> Given the 2024 below, should this be 2024-2025?

I've never known what this year is really for. People clearly expect it to be this year
... I've evidently missed one somewhere. I'll fix that. ... I wrote some of this code in
2018, so there are a range of options on what it 'should' be ...


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
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/printk.h>
>> +#include <linux/slab.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/srcu.h>
>> +#include <linux/types.h>
>> +
>> +#include <acpi/pcc.h>
>> +
>> +#include "mpam_internal.h"
>> +
>> +/*
>> + * mpam_list_lock protects the SRCU lists when writing. Once the
>> + * mpam_enabled key is enabled these lists are read-only,
>> + * unless the error interrupt disables the driver.
>> + */
>> +static DEFINE_MUTEX(mpam_list_lock);
>> +static LIST_HEAD(mpam_all_msc);
>> +
>> +static struct srcu_struct mpam_srcu;
>> +
>> +/* MPAM isn't available until all the MSC have been probed. */
>> +static u32 mpam_num_msc;
>> +
>> +static void mpam_discovery_complete(void)
>> +{
>> +       pr_err("Discovered all MSC\n");

> Perhaps print out how many MSCs.
Once the whole thing is assembled the mpam_enable() call prints the number of PARTID/PMG,
which is something user-space can do something with. I don't think the number of MSC is
useful to anyone as some of them are grouped together and can't be configured independently.


>> +}

>> +static int mpam_dt_parse_resource(struct mpam_msc *msc, struct device_node *np,
>> +                                 u32 ris_idx)
>> +{
>> +       int err = 0;
>> +       u32 level = 0;
>> +       unsigned long cache_id;
>> +       struct device_node *cache;
>> +
>> +       do {
>> +               if (of_device_is_compatible(np, "arm,mpam-cache")) {
>> +                       cache = of_parse_phandle(np, "arm,mpam-device", 0);
>> +                       if (!cache) {
>> +                               pr_err("Failed to read phandle\n");
>> +                               break;
>> +                       }
>> +               } else if (of_device_is_compatible(np->parent, "cache")) {
>
> Don't access device_node members. I'm trying to make it opaque. And
> technically it can be racy to access parent ptr when/if nodes are
> dynamic. I think this should suffice:
>
> else {
>   cache = of_get_parent(np);
>   if (!of_device_is_compatible(cache, "cache")) {
>     cache = NULL;
>     break;
>   }
> }

Thanks!

The if/else-if ladder needs to stay, I've grabbed the parent earlier, and added a
of_node_put() of it after the do/while.


>> +                       cache = of_node_get(np->parent);
>> +               } else {
>> +                       /* For now, only caches are supported */
>> +                       cache = NULL;
>> +                       break;
>> +               }
>> +
>> +               err = of_property_read_u32(cache, "cache-level", &level);
>> +               if (err) {
>> +                       pr_err("Failed to read cache-level\n");
>> +                       break;
>> +               }
>> +
>> +               cache_id = cache_of_calculate_id(cache);
>> +               if (cache_id == ~0UL) {
>> +                       err = -ENOENT;
>> +                       break;
>> +               }
>> +
>> +               err = mpam_ris_create(msc, ris_idx, MPAM_CLASS_CACHE, level,
>> +                                     cache_id);
>> +       } while (0);
>> +       of_node_put(cache);
>> +
>> +       return err;
>> +}
>> +
>> +static int mpam_dt_parse_resources(struct mpam_msc *msc, void *ignored)
>> +{
>> +       int err, num_ris = 0;
>> +       const u32 *ris_idx_p;
>> +       struct device_node *iter, *np;
>> +
>> +       np = msc->pdev->dev.of_node;
>> +       for_each_child_of_node(np, iter) {
>
> Use for_each_available_child_of_node_scoped()

Sure,


>> +               ris_idx_p = of_get_property(iter, "reg", NULL);
>
> This is broken on big endian and new users of of_get_property() are
> discouraged. Use of_property_read_reg().

Done,


>> +               if (ris_idx_p) {
>> +                       num_ris++;
>> +                       err = mpam_dt_parse_resource(msc, iter, *ris_idx_p);
>> +                       if (err) {
>> +                               of_node_put(iter);
>
> And then drop the put.
>
>> +                               return err;
>> +                       }
>> +               }
>> +       }
>> +
>> +       if (!num_ris)
>> +               mpam_dt_parse_resource(msc, np, 0);
>> +
>> +       return err;
>> +}


>> +/*
>> + * An MSC can control traffic from a set of CPUs, but may only be accessible
>> + * from a (hopefully wider) set of CPUs. The common reason for this is power
>> + * management. If all the CPUs in a cluster are in PSCI:CPU_SUSPEND, the
>> + * the corresponding cache may also be powered off. By making accesses from
>> + * one of those CPUs, we ensure this isn't the case.
>> + */
>> +static int update_msc_accessibility(struct mpam_msc *msc)
>> +{
>> +       struct device_node *parent;
>> +       u32 affinity_id;
>> +       int err;
>> +
>> +       if (!acpi_disabled) {
>> +               err = device_property_read_u32(&msc->pdev->dev, "cpu_affinity",
>> +                                              &affinity_id);
>> +               if (err)
>> +                       cpumask_copy(&msc->accessibility, cpu_possible_mask);
>> +               else
>> +                       acpi_pptt_get_cpus_from_container(affinity_id,
>> +                                                         &msc->accessibility);
>> +
>> +               return 0;
>> +       }
>> +
>> +       /* This depends on the path to of_node */

> I'm failing to understand what has to be at the root node?

The accessibility bitmap. If the MSC is at the root of the tree - its assumed to be
global. If its buried in a device, its assumed to be in the same power domain as that
device. Practically this only matters for caches where PSCI's CPU_SUSPEND can turn the
cache off, so the cache MSC can only be accessed from the CPU's local to it, that way we
know its not about to be turned off by PSCI.

I'll rephrase the comment - its trying to explain why its not explicitly encoded.
| /* Where an MSC can be accessed from depends on the path to of_node. */


>> +       parent = of_get_parent(msc->pdev->dev.of_node);
>> +       if (parent == of_root) {
>> +               cpumask_copy(&msc->accessibility, cpu_possible_mask);
>> +               err = 0;
>> +       } else {
>> +               err = -EINVAL;
>> +               pr_err("Cannot determine accessibility of MSC: %s\n",
>> +                      dev_name(&msc->pdev->dev));
>> +       }
>> +       of_node_put(parent);
>> +
>> +       return err;
>> +}
>> +static void mpam_msc_drv_remove(struct platform_device *pdev)
>> +{
>> +       struct mpam_msc *msc = platform_get_drvdata(pdev);
>> +
>> +       if (!msc)
>> +               return;
>> +
>> +       mutex_lock(&mpam_list_lock);
>> +       mpam_num_msc--;
>> +       platform_set_drvdata(pdev, NULL);
>> +       list_del_rcu(&msc->glbl_list);
>> +       synchronize_srcu(&mpam_srcu);
>> +       devm_kfree(&pdev->dev, msc);
>
> This should happen automagically.
>
>> +       mutex_unlock(&mpam_list_lock);
>> +}
>> +
>> +static int mpam_msc_drv_probe(struct platform_device *pdev)
>> +{
>> +       int err;
>> +       struct mpam_msc *msc;
>> +       struct resource *msc_res;
>> +       void *plat_data = pdev->dev.platform_data;
>> +
>> +       mutex_lock(&mpam_list_lock);
>> +       do {
>> +               msc = devm_kzalloc(&pdev->dev, sizeof(*msc), GFP_KERNEL);
>> +               if (!msc) {
>> +                       err = -ENOMEM;
>> +                       break;
>> +               }
>> +
>> +               mutex_init(&msc->probe_lock);
>> +               mutex_init(&msc->part_sel_lock);
>> +               mutex_init(&msc->outer_mon_sel_lock);
>> +               raw_spin_lock_init(&msc->inner_mon_sel_lock);
>> +               msc->id = mpam_num_msc++;
>
> Multiple probe functions can run in parallel, so this needs to be
> atomic. Maybe it is with mpam_list_lock, but then the name of the
> mutex is misleading given this is not the list. It's not really clear
> to me what all needs the mutex here. Certainly a lot of it doesn't.
> Like everything else above here except the increment.

It's more about the class/component/device lists that get added later - but more on this
mpam_num_msc thing below...


>> +               msc->pdev = pdev;
>> +               INIT_LIST_HEAD_RCU(&msc->glbl_list);
>> +               INIT_LIST_HEAD_RCU(&msc->ris);
>> +
>> +               err = update_msc_accessibility(msc);
>> +               if (err)
>> +                       break;
>> +               if (cpumask_empty(&msc->accessibility)) {
>> +                       pr_err_once("msc:%u is not accessible from any CPU!",
>> +                                   msc->id);
>> +                       err = -EINVAL;
>> +                       break;
>> +               }
>> +
>> +               if (device_property_read_u32(&pdev->dev, "pcc-channel",

> Does this property apply to DT? It would as the code is written. It is
> not documented though.

I don't think so - on DT PCC is going to be spelled SCMI which somes with some kind of
discovery instead. This property is added by the ACPI table 'driver'.


>> +                                            &msc->pcc_subspace_id))
>> +                       msc->iface = MPAM_IFACE_MMIO;
>> +               else
>> +                       msc->iface = MPAM_IFACE_PCC;
>> +
>> +               if (msc->iface == MPAM_IFACE_MMIO) {
>> +                       void __iomem *io;
>> +
>> +                       io = devm_platform_get_and_ioremap_resource(pdev, 0,
>> +                                                                   &msc_res);
>> +                       if (IS_ERR(io)) {
>> +                               pr_err("Failed to map MSC base address\n");
>> +                               err = PTR_ERR(io);
>> +                               break;
>> +                       }
>> +                       msc->mapped_hwpage_sz = msc_res->end - msc_res->start;
>> +                       msc->mapped_hwpage = io;
>> +               } else if (msc->iface == MPAM_IFACE_PCC) {
>> +                       msc->pcc_cl.dev = &pdev->dev;
>> +                       msc->pcc_cl.rx_callback = mpam_pcc_rx_callback;
>> +                       msc->pcc_cl.tx_block = false;
>> +                       msc->pcc_cl.tx_tout = 1000; /* 1s */
>> +                       msc->pcc_cl.knows_txdone = false;
>> +
>> +                       msc->pcc_chan = pcc_mbox_request_channel(&msc->pcc_cl,
>> +                                                                msc->pcc_subspace_id);
>> +                       if (IS_ERR(msc->pcc_chan)) {
>> +                               pr_err("Failed to request MSC PCC channel\n");
>> +                               err = PTR_ERR(msc->pcc_chan);
>> +                               break;
>> +                       }
>> +               }
>> +
>> +               list_add_rcu(&msc->glbl_list, &mpam_all_msc);
>> +               platform_set_drvdata(pdev, msc);
>> +       } while (0);
>> +       mutex_unlock(&mpam_list_lock);
>> +
>> +       if (!err) {
>> +               /* Create RIS entries described by firmware */
>> +               if (!acpi_disabled)
>> +                       err = acpi_mpam_parse_resources(msc, plat_data);
>> +               else
>> +                       err = mpam_dt_parse_resources(msc, plat_data);
>
> Isn't there a race here if an error occurs since you already added the
> MSC to the list? Something like this sequence with 2 MSCs:
>
> device 1 probe
> device 1 added
>     device 2 probe
>     device 2 added
> device 1 calls mpam_discovery_complete()
>     device 2 error on parse_resources
>     device 2 removed

By the time the whole thing is assembled the 'discovery complete' work is scheduled by a
cpuhp callback and has better protection against this. That discovery-complete call is
just to help illustrate that there is stuff that happens once all the MSC have been
discovered, as that code gets much more complicated later in teh series.

Combined with your comment about the msc_id increment above - I'll stop using that as both
a count and an id, re-using the pdev->id as its more likely to be stable from boot to
boot. mpam_num_msc can then become an atomic_t that is incremented once we know we're not
going to remove the MSC from the list.



>> +       }
>> +
>> +       if (!err && fw_num_msc == mpam_num_msc)
>> +               mpam_discovery_complete();
>> +
>> +       if (err && msc)
>> +               mpam_msc_drv_remove(pdev);
>> +
>> +       return err;
>> +}
>> +/*
>> + * MSC that are hidden under caches are not created as platform devices
>> + * as there is no cache driver. Caches are also special-cased in
>> + * update_msc_accessibility().
>> + */
>> +static void mpam_dt_create_foundling_msc(void)
>> +{
>> +       int err;
>> +       struct device_node *cache;
>> +
>> +       for_each_compatible_node(cache, NULL, "cache") {
>> +               err = of_platform_populate(cache, mpam_of_match, NULL, NULL);
>
> This is going to create platform devices for all caches (except L1)
> regardless of whether they support MPAM or not. Isn't it likely or
> possible that only L3 or SLC caches support MPAM?

Likely - but all things are possible. You could put an MPAM MSC in your L1-I cache.
(or even in the CPU - but lets not go there)

I'll attempt to fix that up, what I have doesn't quite work, but I'll keep picking at it:
|        for_each_compatible_node(cache, NULL, "cache") {
|               struct device_node *cache_device;
|
|               if (of_node_check_flag(cache, OF_POPULATED))
|                       continue;
|
|               cache_device = of_find_matching_node_and_match(cache, mpam_of_match, NULL);
|               if (!cache_device)
|                       continue;
|               of_node_put(cache_device);
|
|               pdev = of_platform_device_create(cache, "cache", NULL);
|               if (!pdev)
|                       pr_err_once("Failed to create MSC devices under caches\n");
|          }


>> +               if (err)
>> +                       pr_err("Failed to create MSC devices under caches\n");
>> +       }
>> +}
>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
>> new file mode 100644
>> index 000000000000..07e0f240eaca
>> --- /dev/null
>> +++ b/drivers/resctrl/mpam_internal.h
>> @@ -0,0 +1,62 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +// Copyright (C) 2024 Arm Ltd.
>
> It's 2025.
... and I wrote this in 2018, but missed the annual update. I'll fix it.


>> +
>> +struct mpam_msc {
>> +       /* member of mpam_all_msc */
>> +       struct list_head        glbl_list;
>> +
>> +       int                     id;
>> +       struct platform_device *pdev;
>> +
>> +       /* Not modified after mpam_is_enabled() becomes true */
>> +       enum mpam_msc_iface     iface;
>> +       u32                     pcc_subspace_id;
>> +       struct mbox_client      pcc_cl;
>> +       struct pcc_mbox_chan    *pcc_chan;
>> +       u32                     nrdy_usec;
>> +       cpumask_t               accessibility;
>> +
>> +       /*
>> +        * probe_lock is only take during discovery. After discovery these

> s/take/taken/

Fixed,


>> +        * properties become read-only and the lists are protected by SRCU.
>> +        */
>> +       struct mutex            probe_lock;
>> +       unsigned long           ris_idxs[128 / BITS_PER_LONG];
>> +       u32                     ris_max;
>> +
>> +       /* mpam_msc_ris of this component */
>> +       struct list_head        ris;
>> +
>> +       /*
>> +        * part_sel_lock protects access to the MSC hardware registers that are
>> +        * affected by MPAMCFG_PART_SEL. (including the ID registers that vary
>> +        * by RIS).
>> +        * If needed, take msc->lock first.

> Stale comment? I don't see any 'lock' member.

Yes, it should say probe_lock .. renamed after more locks got added in here, and the
comment got fixed up in the wrong patch. Fixed.


>> +        */
>> +       struct mutex            part_sel_lock;
>> +
>> +       /*
>> +        * mon_sel_lock protects access to the MSC hardware registers that are
>> +        * affeted by MPAMCFG_MON_SEL.
>> +        * If needed, take msc->lock first.
>> +        */
>> +       struct mutex            outer_mon_sel_lock;
>> +       raw_spinlock_t          inner_mon_sel_lock;
>> +       unsigned long           inner_mon_sel_flags;
>> +
>> +       void __iomem            *mapped_hwpage;
>> +       size_t                  mapped_hwpage_sz;
>> +};
>> +
>> +#endif /* MPAM_INTERNAL_H */
>> --
>> 2.20.1
>>

Thanks,

James

