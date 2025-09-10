Return-Path: <linux-acpi+bounces-16598-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4515B520C5
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 21:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C54E4E1492
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 19:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E222D5C97;
	Wed, 10 Sep 2025 19:19:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BC72D5935;
	Wed, 10 Sep 2025 19:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757531979; cv=none; b=SGjeZXvp3SpyooiJhNoLzo+xpCXqbjC/8OgeFlHUy7FOVNS/zd1EiyvFd1kenwtHjv70Lw6PKgcR266LScRKsUc3npHyZTkKxuGczVWX1N7SB5ZzJqvVkNtCKAhWKWxxSsgR2J9Z+mVoNAzN1ImhCp5XIRxEDnJZzcWdDy6lMB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757531979; c=relaxed/simple;
	bh=LzOqNO07Y3gYZV2NV3WO0q2Z7c8hpQgmLSoElCrPirU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JiUU5RLNCse2fc/KOJEXqmndr1XluAffyxoaYgEKJW3HEXAWevPR08QyhCviEz+gkvRtrb1uLbuJdLsBITsYzmn5Mk+rwMEzoUFG7Fau2T/C0zhy1zj3YMU+yBwYX909i9YmqKWCb4AD6xBqnbT0Ntl63Z62SP2Tqz17x98Hsug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 833AA16F8;
	Wed, 10 Sep 2025 12:19:28 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 339C63F694;
	Wed, 10 Sep 2025 12:19:31 -0700 (PDT)
Message-ID: <cb99597c-756b-4137-872e-89446ea51c82@arm.com>
Date: Wed, 10 Sep 2025 20:19:29 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/33] arm_mpam: Add probe/remove for mpam msc driver and
 kbuild boiler plate
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
 <20250822153048.2287-11-james.morse@arm.com>
 <aLWBqNMKoTl9VDIS@e133380.arm.com>
 <8265943b-536f-47ce-af05-129edd417863@arm.com>
 <aL71aP3qyyfD+T47@e133380.arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <aL71aP3qyyfD+T47@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dave,

On 08/09/2025 16:25, Dave Martin wrote:
> On Fri, Sep 05, 2025 at 07:49:37PM +0100, James Morse wrote:
>> On 01/09/2025 12:21, Dave Martin wrote:
>>> On Fri, Aug 22, 2025 at 03:29:51PM +0000, James Morse wrote:
>>>> Probing MPAM is convoluted. MSCs that are integrated with a CPU may
>>>> only be accessible from those CPUs, and they may not be online.
>>>> Touching the hardware early is pointless as MPAM can't be used until
>>>> the system-wide common values for num_partid and num_pmg have been
>>>> discovered.
>>>>
>>>> Start with driver probe/remove and mapping the MSC.


>>>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>>>> new file mode 100644
>>>> index 000000000000..a0d9a699a6e7
>>>> --- /dev/null
>>>> +++ b/drivers/resctrl/mpam_devices.c
>>>> @@ -0,0 +1,336 @@

>>> How are accesses to this protected against data races?
>>
>> It's under the list-lock, but after Rob's feedback I've made it an atomic_t and stopped
>> using it as an id for all the print messages.
> 
> Converting to atomic_t reduces the chance of people asking the
> question, but doesn't really answer the question.
> 
> Since mpam_num_msc shadows the contents of the lists and msc data
> structures, it may matter whether the two can be seen out of sync.
> 
> Does it definitely not matter?

v2 uses the firmware-table id as the id. The only thing mpam_num_msc needs to do is spot
which MSC was last to be probed so that the cpuhp calls can be registered.

The amount of skid that happens on the way there doesn't matter.

[..]

>>>> +static int fw_num_msc;
>>>
>>> Does this need to be protected against data races?
>>>
>>> If individual mpam_msc_drv_probe() calls may execute on different CPUs
>>> from mpam_msc_driver_init(), then seem to be potential races here.
>>
>> Incrementing was under the list-lock, but not the last 'are they all done' read. Following
>> Rob's comments I've made this an atomic_t.
> 
> As with mpam_num_msc, this eliminates data races on fw_num_msc, but
> races between this variable and other data structures may remain.
> 
> Can you explain what prevents such races, or why they don't
> matter?

See mpam_msc_driver_init(). The value is set before the driver is registered. It can't
probe before its registered, so all the readers must happen after the writer.

[..]


>>>> +}
>>>> +
>>>> +static void mpam_msc_drv_remove(struct platform_device *pdev)
>>>> +{
>>>
>>> The MPAM driver cannot currently be built as a module.
>>>
>>> Is it possible to exercise the driver remove paths, today?
>> Yes, through the sysfs unbind interface.
>>
>> It doesn't make a lot of sense for MPAM as the moment you unbind the driver from one MSC
>> it has to work out if it needs to teardown resctrl...
> 
> Has to, but doesn't?  Have I missed something?

Has to, and does:
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/tree/drivers/resctrl/mpam_devices.c?h=mpam/snapshot%2bextras/v6.17-rc2&id=41c768c1705d3fa0814bb1cb92c83280c872cb3e#n474

It's probably not what the user wants, but it is what they're asking for if they do this.


> Are we supposed to put the MSC back into a sane state, for e.g. the
> kexec path?

kdump on panic() means you couldn't trust it to do this.
The driver reset all the configurations during probing. It will initially run with
whatever configuration was left in partid-0, there is very little we can do about this.


> For resctrl, one option would be to stub out the backend -- i.e.,
> we don't tell resctrl that the affected resources disappeared, but
> attempts to manipulate the affected MSC(s) are stubbed out (similarly
> to what happens to an open tty after a hangup).
> 
> (Something along these lines may be done somewhere, but I'm not
> currently aware of it.)

On teardown the cpuhp callbacks are unregistered, which makes all the CPUs and
resctrl:domains appear offline, and the static key behind mpam_enabled() is disabled,
which makes a bunch of paths return an error.

The result is no more access to the hardware after an error has occured. The aim
is to prevent accidentally muddling important/unimportant tasks due to PARTID truncation.


> Is there an outstanding get on the device that prevents us from getting
> here until resctrl is shut down?  Thanks to the wisdom and restraint of
> systemd I'd expect resctrl to tangled up in some rat's nest of
> unremovable mounts by the time we try to shut down, but I hope I'm
> being pessimistic.  (Arguably that's not our bug, if so.)

The resctrl_exit() path removes the kernfs internals from the mount point. Systemd is able
to keep zombie mount points, but they end up being empty. (to reproduce this, put resctrl
in fstab!)


>>>> +	struct mpam_msc *msc = platform_get_drvdata(pdev);
>>>> +
>>>> +	if (!msc)
>>>> +		return;
>>>> +
>>>> +	mutex_lock(&mpam_list_lock);
>>>> +	mpam_num_msc--;
>>>> +	platform_set_drvdata(pdev, NULL);
>>>> +	list_del_rcu(&msc->glbl_list);
>>>> +	synchronize_srcu(&mpam_srcu);
>>>> +	devm_kfree(&pdev->dev, msc);
>>>> +	mutex_unlock(&mpam_list_lock);
>>>> +}
>>>> +
>>>> +static int mpam_msc_drv_probe(struct platform_device *pdev)
>>>> +{
>>>> +	int err;
>>>> +	struct mpam_msc *msc;
>>>> +	struct resource *msc_res;
>>>> +	void *plat_data = pdev->dev.platform_data;
>>>> +
>>>> +	mutex_lock(&mpam_list_lock);
>>>> +	do {
>>>> +		msc = devm_kzalloc(&pdev->dev, sizeof(*msc), GFP_KERNEL);
>>>> +		if (!msc) {
>>>> +			err = -ENOMEM;
>>>> +			break;
>>>> +		}
>>>> +
>>>> +		mutex_init(&msc->probe_lock);
>>>> +		mutex_init(&msc->part_sel_lock);
>>>> +		mutex_init(&msc->outer_mon_sel_lock);
>>>> +		raw_spin_lock_init(&msc->inner_mon_sel_lock);
>>>> +		msc->id = mpam_num_msc++;
>>>> +		msc->pdev = pdev;
>>>> +		INIT_LIST_HEAD_RCU(&msc->glbl_list);

> msc->glbl_list is not a list head?  Does it need to be initialised at all?
> list_add_rcu() will just splat it, by the looks of it.

It's the member of the global list, hence the comment above it in the struct.
I've never known if the member 'list head' needs to be initialised or not, better safe
than sorry.



>>>> +		INIT_LIST_HEAD_RCU(&msc->ris);
> 
> Maybe INIT_LIST_HEAD_RCU() isn't needed here.  Do we ever access this
> list without holding one of the MSC locks?
> 
> This list is not used until a cpuhp hook comes in to probe the MSC, and
> then mpam_discovery_cpu_online() obtains a pointer via
> list_for_each_entry() -- but this is not RCU-protected.  The MSC probe
> lock is taken, there...

mpam_reprogram_msc(), mpam_msmon_reset_all_mbwu() and mpam_reset_msc() all do this
under (s)rcu.

The aim is to not take a lock on the read side. Once the cpuhp callbacks are registered
the only thing that writes to these lists is the error interrupt teardown.


>>>> +
>>>> +		err = update_msc_accessibility(msc);
>>>> +		if (err)
>>>> +			break;
>>>> +		if (cpumask_empty(&msc->accessibility)) {
>>>> +			pr_err_once("msc:%u is not accessible from any CPU!",
>>>> +				    msc->id);
>>>> +			err = -EINVAL;
>>>> +			break;
>>>> +		}
>>>> +
>>>> +		if (device_property_read_u32(&pdev->dev, "pcc-channel",
>>>> +					     &msc->pcc_subspace_id))
>>>> +			msc->iface = MPAM_IFACE_MMIO;
>>>> +		else
>>>> +			msc->iface = MPAM_IFACE_PCC;
>>>> +
>>>> +		if (msc->iface == MPAM_IFACE_MMIO) {
>>>> +			void __iomem *io;
>>>> +
>>>> +			io = devm_platform_get_and_ioremap_resource(pdev, 0,
>>>> +								    &msc_res);
>>>> +			if (IS_ERR(io)) {
>>>> +				pr_err("Failed to map MSC base address\n");
>>>> +				err = PTR_ERR(io);
>>>> +				break;
>>>> +			}
>>>> +			msc->mapped_hwpage_sz = msc_res->end - msc_res->start;
>>>> +			msc->mapped_hwpage = io;
>>>> +		} else if (msc->iface == MPAM_IFACE_PCC) {
>>>> +			msc->pcc_cl.dev = &pdev->dev;
>>>> +			msc->pcc_cl.rx_callback = mpam_pcc_rx_callback;
>>>> +			msc->pcc_cl.tx_block = false;
>>>> +			msc->pcc_cl.tx_tout = 1000; /* 1s */
>>>> +			msc->pcc_cl.knows_txdone = false;
> 
> ... so, it feels like we may need to hold the probe lock, or ensure
> that all iterations over the msc list are RCU-protected (see below for
> counterexamples), or both.

In here, the msc hasn't yet been added to the global list, so it can't be found by anyone.
Anyone that does find it, found it by taking the list_lock and walking the global list.


>>>> +
>>>> +			msc->pcc_chan = pcc_mbox_request_channel(&msc->pcc_cl,
>>>> +								 msc->pcc_subspace_id);
>>>> +			if (IS_ERR(msc->pcc_chan)) {
>>>> +				pr_err("Failed to request MSC PCC channel\n");
>>>> +				err = PTR_ERR(msc->pcc_chan);
>>>> +				break;
>>>> +			}
>>>> +		}
>>
>>> Should the lock be held across initialisation of the msc fields?
>>
>> The msc isn't visible until its added to the list, so provided all that inialisation is
>> done 'before' its added to the list, it doesn't matter.

> Is it possible for other code to get a pointer to the new msc after
> this, other than by dereferencing the list?

While MSC are still being created - nothing walks the list. There are no interrupts or
hotplug callabacks.
Once all the MSC have been found, hardware probing starts.
During hardware probing, the cpuhp callback walks the global list under srcu.
Once all the hardware has been probed, the cpuhp callbacks are swapped out, and
mpam_enable_once() does things with static_keys and registering interrupts.
After this point, the mpam_class list/tree is used under srcu, and yes interrupts know
which MSC they are for.


> (The obvious case is the interrupt handlers, but it looks like the msc
> pointers used for registering the interrupts are indeed obtained
> through an RCU-protected iteration over mpam_all_msc.)
> 
> Note, there seem to be non-RCU-protected iterations over mpam_all_msc
> in the mpam_discovery_cpu_online() (patch 14) and

That was taking the write side lock unecessarily. I've fixed it to walk the list under srcu.


> mpam_enable_merge_features() paths (patch 18). 

Holds the write side lock.


> The lack of symmetry
> between list maintenance and consumption look a little suspect for
> those -- is safety ensured in some other way?

Readers must use the RCU primitives to be safe against a concurrent writer.
Writers must take some write side lock to be safe against each other - they don't need to
use the RCU list-walking primitives.


>>> list_add_rcu() might imply sufficient barriers to ensure that the
>>> initialisations are visible to other threads that obtain the msc
>>> pointer by iterating over mpam_all_msc.
>>>
>>> It's probably cleaner to hold the lock explicitly, though.
>>
>> The list lock? We do.
>> But the readers don't need to take the list lock, its only there to prevent concurrent
>> writers.
> 
> I meant whatever lock is supposed to protect the fields of the specific
> msc.  The list lock is not that lock.

We could bundle that under the probe_lock - but there would be no need to hold that here,
the struct mpam_msc isn't reachable.

[..]

>>>> +		mpam_discovery_complete();
>>>> +
>>>> +	if (err && msc)
>>>> +		mpam_msc_drv_remove(pdev);
>>>> +
>>>> +	return err;
>>>> +}
>>>> +/*
>>>> + * MSC that are hidden under caches are not created as platform devices
>>>> + * as there is no cache driver. Caches are also special-cased in
>>>> + * update_msc_accessibility().
>>>> + */
>>>
>>> Can you elaborate?  I don't understand quite what this is doing.
>>
>> / {
>>     my_thing {
>>         compatible = "my_thing";
>>         msc {
>>            compatible = "arm,mpam-msc";
>>         };
>>     };
>>
>>     other_thing {
>>         compatible = "other_thing";
>>     };
>>
>>     msc {
>>        compatible = "arm,mpam-msc";
>>        arm,mpam-device = <&other_thing>;
>>     };
>>
>>
>>     l2-cache {
>>       compatible = "cache";
>>         msc {
>>            compatible = "arm,mpam-msc";
>>         };
>>     };
>> };
>>
>> my_thing and other_thing's MSC will have devices created - but the cache will not, because
>> it's a cache not a device, and anything below it is ignored.
> 
> OK.  Maybe reword as something like:
> 
> --8<--
> 
> MSCs that are declared by the firmware as being part of a cache may not
> be created automatically as platform devices, since there is no
> dedicated cache driver.
> 
> Deal with those MSCs here.
> 
> -->8--
> 
> Maybe add a comment at update_msc_accessibility() that references this
> comment, instead of a reader of that function just needing to know that
> this comment is here?

I'll just drop the bit about update_msc_accessibility(), its less relevant once the next
patch adds the memory node in a similar way. (and even less relevant once I rip out DT
support)


>>>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
>>>> new file mode 100644
>>>> index 000000000000..07e0f240eaca
>>>> --- /dev/null
>>>> +++ b/drivers/resctrl/mpam_internal.h
>>>> @@ -0,0 +1,62 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +// Copyright (C) 2024 Arm Ltd.
>>>> +
>>>> +#ifndef MPAM_INTERNAL_H
>>>> +#define MPAM_INTERNAL_H
>>>> +
>>>> +#include <linux/arm_mpam.h>
>>>> +#include <linux/cpumask.h>
>>>> +#include <linux/io.h>
>>>> +#include <linux/mailbox_client.h>
>>>> +#include <linux/mutex.h>
>>>> +#include <linux/resctrl.h>
>>>> +#include <linux/sizes.h>
>>>> +
>>>> +struct mpam_msc {
>>>> +	/* member of mpam_all_msc */
>>>> +	struct list_head        glbl_list;
>>
>>> It is worth making these names less mismatched?
>>
>> all_msc_list ?
>>
>> It's because its global. The pattern otherwise is parent has a list foo, and all the
>> children have a member 'foo_list'.
> 
> "all_msc", then?
> 
> I'm not sure that it's essential for the list head's name to have
> "list" in it: that's clear from the type and from how it is used.
> "all" seems sufficient to imply that this is a list (?)
> 
> It doesn't get much more global than "all".
> 
> (This is purely cosmetic, of course.)

Ending in _list is part of a pattern with the class->component -->
component->component_list relationship. We can discuss whatever suffix is best on v2 - as
long as they all follow the same pattern!


Thanks,

James

