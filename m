Return-Path: <linux-acpi+bounces-16503-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C01CDB497AF
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 19:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F9B1BC19AA
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 17:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3768313288;
	Mon,  8 Sep 2025 17:57:55 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00D623CB;
	Mon,  8 Sep 2025 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757354275; cv=none; b=QxfNf52GnTFvJU0cBrRp9gUuYtnueTmt/jpktYjN5Fb1VBLHnvJMm1+xi9sCdGJNkSet7ywbMjpJZl2NPBVo6pCYJ7voxkGQfPXbsutu/shCYgitpyp9LGdcsKltTnmH2CckQ/y+ieF0pnfXOBCftgLKVR/6XVXaeBJNo3dq+Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757354275; c=relaxed/simple;
	bh=ItqLU7Pn460b+KxCmQPoGVY9rmI6t8mq8g+wvlbxsIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eLDH6rfm1M6Cz9GJ1n73JANDCXmBWeNZVE8AVIKyBpWgWK6HnRqrfpKW77sn+BMXd6NnA5bOWVO6fTVKaoCVApmFUeWkGqJRXRwYOgyeGwhxJo1zPUeyIz0pDIyBKlsAqPFM7XQasD+MlSHOJkRbHMkoSVLToLvS5/GocmaYxKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D36AC1BCA;
	Mon,  8 Sep 2025 10:57:44 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 045BC3F694;
	Mon,  8 Sep 2025 10:57:44 -0700 (PDT)
Message-ID: <ff73df9c-8e77-471d-b0fb-205701b4d6d3@arm.com>
Date: Mon, 8 Sep 2025 18:57:41 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/33] arm_mpam: Add the class and component structures
 for ris firmware described
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Koba Ko <kobak@nvidia.com>,
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
 Danilo Krummrich <dakr@kernel.org>, Ben Horgan <ben.horgan@arm.com>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-13-james.morse@arm.com>
 <aLV++1PELhKBeKR7@e133380.arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <aLV++1PELhKBeKR7@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dave,

On 01/09/2025 12:09, Dave Martin wrote:
>> Subject: arm_mpam: Add the class and component structures for ris firmware described
> 
> Mangled subject line?

order words hard is.


> There is a fair intersection between the commit message and what the
> patch does, but they don't quite seem to match up.
> 
> Some key issues like locking / object lifecycle management
> and DT parsing (a bit of which, it appears, lives here too) are not
> mentioned at all.

I don't think everything needs mentioning - you have the diff for that.This should capture
the motivation, what you have and what you need to find, the grouping etc.


> In lieu of a complete rewrite, it might be best to discard the
> explanation of the various object types.  The comment in the code
> speaks for itself, and looks clearer.

Fair enough,

> [...]
> 
> On Fri, Aug 22, 2025 at 03:29:53PM +0000, James Morse wrote:
>> An MSC is a container of resources, each identified by their RIS index.
>> Some RIS are described by firmware to provide their position in the system.
>> Others are discovered when the driver probes the hardware.
>>
>> To configure a resource it needs to be found by its class, e.g. 'L2'.
>> There are two kinds of grouping, a class is a set of components, which
>> are visible to user-space as there are likely to be multiple instances
>> of the L2 cache. (e.g. one per cluster or package)
>>
>> struct mpam_components are a set of struct mpam_vmsc. A vMSC groups the
>> RIS in an MSC that control the same logical piece of hardware. (e.g. L2).
>> This is to allow hardware implementations where two controls are presented
>> as different RIS. Re-combining these RIS allows their feature bits to
>> be or-ed. This structure is not visible outside mpam_devices.c
>>
>> struct mpam_vmsc are then a set of struct mpam_msc_ris, which are not
>> visible as each L2 cache may be composed of individual slices which need
>> to be configured the same as the hardware is not able to distribute the
>> configuration.
>>
>> Add support for creating and destroying these structures.
>> A gfp is passed as the structures may need creating when a new RIS entry
>> is discovered when probing the MSC.

>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index 71a1fb1a9c75..5baf2a8786fb 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -20,7 +20,6 @@
> 
> [...]
> 
>> @@ -35,11 +34,483 @@
>>  static DEFINE_MUTEX(mpam_list_lock);
>>  static LIST_HEAD(mpam_all_msc);
>>  
>> -static struct srcu_struct mpam_srcu;
>> +struct srcu_struct mpam_srcu;

> Why expose this here?  This patch makes no use of the exposed symbol.

The mpam_resctrl code needs to take it when it walks these lists. I don't want to change
it then because its just additional churn.


>>  /* MPAM isn't available until all the MSC have been probed. */
>>  static u32 mpam_num_msc;
>>  
>> +/*
>> + * An MSC is a physical container for controls and monitors, each identified by
>> + * their RIS index. These share a base-address, interrupts and some MMIO
>> + * registers. A vMSC is a virtual container for RIS in an MSC that control or
>> + * monitor the same thing. Members of a vMSC are all RIS in the same MSC, but
>> + * not all RIS in an MSC share a vMSC.
>> + * Components are a group of vMSC that control or monitor the same thing but
>> + * are from different MSC, so have different base-address, interrupts etc.
>> + * Classes are the set components of the same type.
>> + *
>> + * The features of a vMSC is the union of the RIS it contains.
>> + * The features of a Class and Component are the common subset of the vMSC
>> + * they contain.
>> + *
>> + * e.g. The system cache may have bandwidth controls on multiple interfaces,
>> + * for regulating traffic from devices independently of traffic from CPUs.
>> + * If these are two RIS in one MSC, they will be treated as controlling
>> + * different things, and will not share a vMSC/component/class.
>> + *
>> + * e.g. The L2 may have one MSC and two RIS, one for cache-controls another
>> + * for bandwidth. These two RIS are members of the same vMSC.
>> + *
>> + * e.g. The set of RIS that make up the L2 are grouped as a component. These
>> + * are sometimes termed slices. They should be configured the same, as if there
>> + * were only one.
>> + *
>> + * e.g. The SoC probably has more than one L2, each attached to a distinct set
>> + * of CPUs. All the L2 components are grouped as a class.
>> + *
>> + * When creating an MSC, struct mpam_msc is added to the all mpam_all_msc list,
>> + * then linked via struct mpam_ris to a vmsc, component and class.
>> + * The same MSC may exist under different class->component->vmsc paths, but the
>> + * RIS index will be unique.
>> + */
> 
> This description of the structures and how they relate to each other
> seems OK (bearing in mind that I am already familiar with this stuff --
> I can't speak for other people).

Great!


> [...]
> 
>> +#define add_to_garbage(x)				\
>> +do {							\
>> +	__typeof__(x) _x = x;				\
> 
> Nit:
> 
> = (x)
> 
> (for the paranoid)

Fixed,


>> +	(_x)->garbage.to_free = (_x);			\
> 
> _x->garbage.to_free = _x;
> 
> (_x is an identifier, not a macro argument.  It can't get re-parsed as
> something else -- assuming that there is not a #define for _x, but then
> all bets would be off anyway.)

>> +	llist_add(&(_x)->garbage.llist, &mpam_garbage);	\
> 
> &_x->...

Fixed,


> [...]
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
>> +	cpumask_andnot(&comp->affinity, &comp->affinity, &ris->affinity);
>> +	cpumask_andnot(&class->affinity, &class->affinity, &ris->affinity);
> 
> This is not the inverse of the cpumask_or()s in mpam_ris_create_locked(),
> unless the the ris associated with each class and each component have
> strictly disjoint affinity masks.  Is that checked anywhere, or should
> it be impossible by construction?

They should be disjoint. These bitmaps are built from firmware description of the cache
hierarchy. I don't think its possible to describe a situation where there are overlaps.

You can build a nonsense cache hierarchy, e.g. where CPU-0's L3 is CPU-6's L2, but if you
do the scheduler is going to complain when it tries to chose the scheduler domains. I
think this should be filed under "you've got bigger problems".  There is a check that
catches this in mpam_resctrl_pick_caches(), to see that all the CPUs are accounted for,
which is to avoid tasks that get lucky with task-placement managing to escape their
resource limit.


> But, thinking about it:
> 
> I wonder why we ever really need to do the teardown.  If we get an
> error interrupt then we can just go into a sulk, spam dmesg a bit, put
> the hardware into the most vanilla state that we can, and refuse to
> manipulate it further.  But this only happens in the case of a software
> or hardware *bug* (or, in a future world where we might implement
> virtualisation, an uncontainable MPAM error triggered by a guest -- for
> which tearing down the host MPAM would be an overreaction).

The good news is guests can't escape the PARTID virtualisation that the CPU does, so any
mess a guest manages to make is confined to that guest's PARTID range.


> Trying to cleanly tear the MPAM driver down after such an error seems a
> bit futile.
> 
> The MPAM resctrl glue could eventually be made into a module (though
> not needed from day 1) -- which would allow for unloading resctrlfs if
> that is eventually module-ised.  I think this wouldn't require the MPAM
> devices backend to be torn down at any point, though (?)

It would certainly be optional. kernfs->resctrl->mpam is the reason all this has to be
built-in. If that changes I'd aim for this to be a module.

All this free()ing was added so that the driver doesn't end up sitting on memory when it
isn't providing any usable feature. I have seen a platform where the error interrupt goes
off during boot, (I suspect firmware configures an out-of-range PARTID). On such a
platform any memory that isn't free()d is a waste.

But I agree its a small amount of memory.


> If we can simplify or eliminate the teardown, does it simplify the
> locking at all?  The garbage collection logic can also be dispensed
> with if there is never any garbage.

It wouldn't simplify the locking, only remove that deferred free()ing which is needed
because of SRCU.


> Since MSCs etc. never disappear from the hardware, it feels like it
> ought not to be necessary ever to remove items from any of these lists
> except when trying to do a teardown (?)

Unbinding the driver from an MSC is another case where this may be triggered via
mpam_msc_drv_remove(). If you look at the whole thing, mpam_ris_destroy() pokes
mpam_resctrl_teardown_class() to see if resctrl needs to be torn down.

I don't anticipate folk actually needing to do that. One Reasons is for VFIO - but this
kind of stuff has a performance impact on the hypervisor, so its unlikely to ever allow a
guest direct access to this kind of thing. Another reason is to load a more specific
driver, which sounds unlikely.


Ultimately this memory free-ing code is here because its the right thing to do.
I'd prefer to keep it as making this a loadable module would mean we have to do this.


> (Putting the hardware into a quiecent state is not the same thing as
> tearing down the data structures -- we do want to quiesce MPAM when
> shutting down the kernel, as least for the kexec scenario.)

> [...]
> 
>> +static int mpam_ris_create_locked(struct mpam_msc *msc, u8 ris_idx,
>> +				  enum mpam_class_types type, u8 class_id,
>> +				  int component_id, gfp_t gfp)
>> +{
>> +	int err;
>> +	struct mpam_vmsc *vmsc;
>> +	struct mpam_msc_ris *ris;
>> +	struct mpam_class *class;
>> +	struct mpam_component *comp;
>> +
>> +	lockdep_assert_held(&mpam_list_lock);
>> +
>> +	if (test_and_set_bit(ris_idx, msc->ris_idxs))
>> +		return -EBUSY;
> 
> Is it impossible by construction to get in here with an out-of-range
> ris_idx?
> 
> To avoid the callers (i.e., ACPI) needing to understand the internal
> limitations of this code, maybe it is worth having a check here (even
> if technically redundant).

It's possible - but only if you mess up the firmware tables.
I'll add a check for this as its easy enough.


Thanks,

James

