Return-Path: <linux-acpi+bounces-17362-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EFABA4C94
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 19:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25261BC6899
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 17:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB54430BF7E;
	Fri, 26 Sep 2025 17:52:37 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434091DE4FB;
	Fri, 26 Sep 2025 17:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909157; cv=none; b=a05hIYYiLJVkeg1UuNx1s8AP4wFK7XJGKAXBYuuGGmlRmiHU6gmKTCTBw494buACPuzij2oTxoYWEPRIOT8/BTTRS2gZMMI5FK/GpQzQB7pR1FiK+/Y3XB/SeEeSSbnalFpEyHQ7vJdy3mz/jwkm9CxCWilOK+EEWbrK8+jnyes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909157; c=relaxed/simple;
	bh=EW2i5iK9uF2nMA6QDzUH4ZvJ09rg4Su4lfR/BJ8wMA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HwOVl3XLdYoSgf7tJfgJspVervYF0KfWxo7TOOznOOp2PpmVMHM511Wm+Vpe1AP8QobkYV0dITNth5S7J1Qk3z9iH9U50B8Kwvk76J/kmwoGw7gh2TGbeuYtvoZ7hZBYT0jvGclvGRb8R91N4mWklYR7twRdJVw4ko89udsWp78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21127168F;
	Fri, 26 Sep 2025 10:52:26 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 223233F5A1;
	Fri, 26 Sep 2025 10:52:28 -0700 (PDT)
Message-ID: <9ad4ae7a-2151-4d60-8303-87f38d7695d8@arm.com>
Date: Fri, 26 Sep 2025 18:52:27 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/29] arm_mpam: Add the class and component structures
 for firmware described ris
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
 Danilo Krummrich <dakr@kernel.org>, Ben Horgan <ben.horgan@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-9-james.morse@arm.com>
 <20250911152244.000047db@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250911152244.000047db@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 11/09/2025 15:22, Jonathan Cameron wrote:
> On Wed, 10 Sep 2025 20:42:48 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> An MSC is a container of resources, each identified by their RIS index.
>> Some RIS are described by firmware to provide their position in the system.
>> Others are discovered when the driver probes the hardware.
>>
>> To configure a resource it needs to be found by its class, e.g. 'L2'.
>> There are two kinds of grouping, a class is a set of components, which
>> are visible to user-space as there are likely to be multiple instances
>> of the L2 cache. (e.g. one per cluster or package)
>>
>> Add support for creating and destroying structures to allow a hierarchy
>> of resources to be created.

> Various minor things inline.
> 
> Biggest is I think maybe just moving to explicit reference counts
> rather than using the empty list for that might end up easier to
> read. Mostly because everyone knows what a kref_put() is about.
> 
> Obviously a bit pointless in practice, but I prefer not to think too
> hard.

I've spent a while playing with this - its the wrong shape for what is going on here.

This builds that tree structure during driver probing. (and adds 'unknown' entries to it
when poking the hardware). But by the time mpam_enable() is called - its basically
read-only. After that point the only 'write' that will happen is the error interrupt which
just free's everything. The deferred free from SRCU makes that safe.
(some of this will be clearer when I add the block comment about the 'phases' the driver
 goes through that Dave asked for)

Making it 'reference counted' instead is pointless because callers would be get/put-ing
references - but the structure is basically read-only, and not going to go away while the
SRCU reference is held.
One of the things reference counting breaks is the devm_kzalloc() usage - as an error from
the driver probe function will free all of those regions, regardless of what the reference
count says.

I'll look to rename the existing 'get' functions so folk don't immediatly think of get/put!

('find' doesn't really cut it as it does the allocation if it doesn't 'find' anything)


>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index efc4738e3b4d..c7f4981b3545 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -18,7 +18,6 @@
>>  #include <linux/printk.h>
>>  #include <linux/slab.h>
>>  #include <linux/spinlock.h>
>> -#include <linux/srcu.h>
> 
> Why does this include no longer make sense?

It gets moved to mpam_internal.h because of the srcu_struct declaration that is needed for
callers in the resctrl code to walk the classes list.

I can add it to the mpam_internal.h header from the beginning.


>> @@ -31,7 +30,7 @@
>>  static DEFINE_MUTEX(mpam_list_lock);
>>  static LIST_HEAD(mpam_all_msc);
>>  
>> -static struct srcu_struct mpam_srcu;
>> +struct srcu_struct mpam_srcu;
> 
> ...
> 
>> +/* List of all objects that can be free()d after synchronise_srcu() */
>> +static LLIST_HEAD(mpam_garbage);
>> +
>> +#define init_garbage(x)	init_llist_node(&(x)->garbage.llist)
> 
> Whilst this obviously works, I'd rather pass garbage to init_garbage
> instead of the containing structure (where type varies)

Sure,


>> +static struct mpam_component *
>> +mpam_component_get(struct mpam_class *class, int id)
>> +{
>> +	struct mpam_component *comp;
>> +
>> +	lockdep_assert_held(&mpam_list_lock);
>> +
>> +	list_for_each_entry(comp, &class->components, class_list) {
>> +		if (comp->comp_id == id)
>> +			return comp;
>> +	}
>> +
>> +	return mpam_component_alloc(class, id);
>> +}
> 
>> +static struct mpam_class *
>> +mpam_class_get(u8 level_idx, enum mpam_class_types type)
>> +{
>> +	bool found = false;
>> +	struct mpam_class *class;
>> +
>> +	lockdep_assert_held(&mpam_list_lock);
>> +
>> +	list_for_each_entry(class, &mpam_classes, classes_list) {
>> +		if (class->type == type && class->level == level_idx) {
>> +			found = true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (found)
>> +		return class;
> 
> Maybe this gets more complex later, but if it doesn't, just return class where you set
> found above.  Matches with pattern used in mpam_component_get() above.

Yup, this is a relic of more complex locking.


>> +
>> +	return mpam_class_alloc(level_idx, type);
>> +}
> 
> 
>> +static void mpam_ris_destroy(struct mpam_msc_ris *ris)
>> +{
>> +	struct mpam_vmsc *vmsc = ris->vmsc;
>> +	struct mpam_msc *msc = vmsc->msc;
>> +	struct platform_device *pdev = msc->pdev;
>> +	struct mpam_component *comp = vmsc->comp;
>> +	struct mpam_class *class = comp->class;
>> +
>> +	lockdep_assert_held(&mpam_list_lock);
>> +
>> +	/*
>> +	 * It is assumed affinities don't overlap. If they do the class becomes
>> +	 * unusable immediately.
>> +	 */
>> +	cpumask_andnot(&comp->affinity, &comp->affinity, &ris->affinity);
>> +	cpumask_andnot(&class->affinity, &class->affinity, &ris->affinity);
>> +	clear_bit(ris->ris_idx, &msc->ris_idxs);
>> +	list_del_rcu(&ris->vmsc_list);
>> +	list_del_rcu(&ris->msc_list);
>> +	add_to_garbage(ris);
>> +	ris->garbage.pdev = pdev;
>> +
>> +	if (list_empty(&vmsc->ris))

> See below. I think it is worth using an explicit reference count even
> though that will only reach zero when the list is empty.

By the time eveything is probed, its an almost entirely read-only structure. The only
writer will free absolutely everything. Changing this to structure-by-structure reference
counting will cause busy-work for readers, who are already protected by SRCU.


>> +		mpam_vmsc_destroy(vmsc);
>> +}
> 
> 
>> +static int mpam_ris_create_locked(struct mpam_msc *msc, u8 ris_idx,
>> +				  enum mpam_class_types type, u8 class_id,
>> +				  int component_id)
>> +{
>> +	int err;
>> +	struct mpam_vmsc *vmsc;
>> +	struct mpam_msc_ris *ris;
>> +	struct mpam_class *class;
>> +	struct mpam_component *comp;
>> +
>> +	lockdep_assert_held(&mpam_list_lock);
>> +
>> +	if (ris_idx > MPAM_MSC_MAX_NUM_RIS)
>> +		return -EINVAL;
>> +
>> +	if (test_and_set_bit(ris_idx, &msc->ris_idxs))
>> +		return -EBUSY;
>> +
>> +	ris = devm_kzalloc(&msc->pdev->dev, sizeof(*ris), GFP_KERNEL);
>> +	if (!ris)
>> +		return -ENOMEM;
>> +	init_garbage(ris);
>> +
>> +	class = mpam_class_get(class_id, type);
>> +	if (IS_ERR(class))
>> +		return PTR_ERR(class);
>> +
>> +	comp = mpam_component_get(class, component_id);
>> +	if (IS_ERR(comp)) {
>> +		if (list_empty(&class->components))
>> +			mpam_class_destroy(class);
> 
> Maybe just reference count the classes with a kref and do a put here?
> 
>> +		return PTR_ERR(comp);
>> +	}
>> +
>> +	vmsc = mpam_vmsc_get(comp, msc);
>> +	if (IS_ERR(vmsc)) {
>> +		if (list_empty(&comp->vmsc))
>> +			mpam_comp_destroy(comp);

> Similar to classes I wonder if simple reference counting is cleaner.

(I spent a few days on it - its prettier, but more work for things like the resctrl code
 to get/put references when SRCU already has the write side covered)


>> +		return PTR_ERR(vmsc);
>> +	}
>> +
>> +	err = mpam_ris_get_affinity(msc, &ris->affinity, type, class, comp);
>> +	if (err) {
>> +		if (list_empty(&vmsc->ris))
> 
> and here as well.
> 
>> +			mpam_vmsc_destroy(vmsc);
>> +		return err;
>> +	}
>> +
>> +	ris->ris_idx = ris_idx;
>> +	INIT_LIST_HEAD_RCU(&ris->vmsc_list);
>> +	ris->vmsc = vmsc;
>> +
>> +	cpumask_or(&comp->affinity, &comp->affinity, &ris->affinity);
>> +	cpumask_or(&class->affinity, &class->affinity, &ris->affinity);
>> +	list_add_rcu(&ris->vmsc_list, &vmsc->ris);
>> +
>> +	return 0;
>> +}
> 
>>  /*
>>   * An MSC can control traffic from a set of CPUs, but may only be accessible
>>   * from a (hopefully wider) set of CPUs. The common reason for this is power
>> @@ -74,10 +469,10 @@ static void mpam_msc_drv_remove(struct platform_device *pdev)
>>  		return;
>>  
>>  	mutex_lock(&mpam_list_lock);
>> -	platform_set_drvdata(pdev, NULL);
>> -	list_del_rcu(&msc->all_msc_list);
>> -	synchronize_srcu(&mpam_srcu);
>> +	mpam_msc_destroy(msc);
> 
> I'd suggest introducing mpam_msc_destroy() in the earlier patch. Doesn't make a huge
> difference but 2 out of 3 things removed here would be untouched if you do that.

Sure. This is remnant of a patch from Carl that moved all this around.


Thanks,

James

