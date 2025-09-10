Return-Path: <linux-acpi+bounces-16597-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F619B520C1
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 21:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ECC9583794
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 19:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267C62D663F;
	Wed, 10 Sep 2025 19:19:24 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D23829E115;
	Wed, 10 Sep 2025 19:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757531964; cv=none; b=YCNIVZn/ePNgkIVGyioO/xelEwjajvbLnrtePJ7jE3JvO6gbe6r/zbWjuJpBrES/mJwQnVMg+QI84jel7Bw2nKyzrxrtA3z09IbM0hyuZGp59mbitOMKWyKagcntMSNgmCWaKwVMyaI/XsUXan+M+IbcXMh/t02Ud0hnKA24cV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757531964; c=relaxed/simple;
	bh=ttSZ07iZtF+pmCh8kOXH67NxYYGGhHvYVT01WqKM+2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rSlg1TY4lR5ZGOFPoLXUQtW7pS9GDWE6pVpDP0fpprUkZFtSBqR3LChVy/o4JGnDFEoWaCG3UpEkXXfF+/haKisgaedG8xBgjhx2+62u0r0q/bNHuaDRFn7cvVVKEluC63cEy7pP8N1op/KLilw0dj9GhlXfdfmaPjgUmumz8cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3455416F8;
	Wed, 10 Sep 2025 12:19:12 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECA1E3F694;
	Wed, 10 Sep 2025 12:19:14 -0700 (PDT)
Message-ID: <59cd9aa1-2151-42d1-bff2-e56f6dc0bb82@arm.com>
Date: Wed, 10 Sep 2025 20:19:12 +0100
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
 <ff73df9c-8e77-471d-b0fb-205701b4d6d3@arm.com>
 <aMAPTVqb7fLfFH6R@e133380.arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <aMAPTVqb7fLfFH6R@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dave,

On 09/09/2025 12:28, Dave Martin wrote:
> On Mon, Sep 08, 2025 at 06:57:41PM +0100, James Morse wrote:
>> On 01/09/2025 12:09, Dave Martin wrote:
>>>> Subject: arm_mpam: Add the class and component structures for ris firmware described

>>>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>>>> index 71a1fb1a9c75..5baf2a8786fb 100644
>>>> --- a/drivers/resctrl/mpam_devices.c
>>>> +++ b/drivers/resctrl/mpam_devices.c
>>>> @@ -20,7 +20,6 @@
>>>
>>> [...]
>>>
>>>> @@ -35,11 +34,483 @@
>>>>  static DEFINE_MUTEX(mpam_list_lock);
>>>>  static LIST_HEAD(mpam_all_msc);
>>>>  
>>>> -static struct srcu_struct mpam_srcu;
>>>> +struct srcu_struct mpam_srcu;
>>
>>> Why expose this here?  This patch makes no use of the exposed symbol.
>>
>> The mpam_resctrl code needs to take it when it walks these lists. I don't want to change
>> it then because its just additional churn.
> 
> I guess this is harmless, but it's no help to the kernel, or to
> reviewers...

A trade-off has to be made here. The series is too big to post in one go. driver/resctrl
is the obvious split - but until both arrive then there is no need for mpam_internal.h, or
really any of the driver as it doesn't have a user-space interface.
I can barf the other series on the list as an illustration - but I think that would just
frustrate people.


[...]

>>>> +static void mpam_ris_destroy(struct mpam_msc_ris *ris)
>>>> +{
>>>> +	struct mpam_vmsc *vmsc = ris->vmsc;
>>>> +	struct mpam_msc *msc = vmsc->msc;
>>>> +	struct platform_device *pdev = msc->pdev;
>>>> +	struct mpam_component *comp = vmsc->comp;
>>>> +	struct mpam_class *class = comp->class;
>>>> +
>>>> +	lockdep_assert_held(&mpam_list_lock);
>>>> +
>>>> +	cpumask_andnot(&comp->affinity, &comp->affinity, &ris->affinity);
>>>> +	cpumask_andnot(&class->affinity, &class->affinity, &ris->affinity);
>>>
>>> This is not the inverse of the cpumask_or()s in mpam_ris_create_locked(),
>>> unless the the ris associated with each class and each component have
>>> strictly disjoint affinity masks.  Is that checked anywhere, or should
>>> it be impossible by construction?
>>
>> They should be disjoint. These bitmaps are built from firmware description of the cache
>> hierarchy. I don't think its possible to describe a situation where there are overlaps.
>>
>> You can build a nonsense cache hierarchy, e.g. where CPU-0's L3 is CPU-6's L2, but if you
>> do the scheduler is going to complain when it tries to chose the scheduler domains. I
>> think this should be filed under "you've got bigger problems".  There is a check that
>> catches this in mpam_resctrl_pick_caches(), to see that all the CPUs are accounted for,
>> which is to avoid tasks that get lucky with task-placement managing to escape their
>> resource limit.
> 
> I guess that makes sense.
> 
> If the firmware description is formally a tree structure then it should
> be impossible to end up with overlapping affinity masks.
> 
> Since this doesn't bite us until teardown-time in any case, I think
> this probably doesn't need to be checked explicitly, unless we observe
> actual problems.
> 
> A comment documenting this assumption may be worth having.

Sure,


>>> But, thinking about it:
>>>
>>> I wonder why we ever really need to do the teardown.  If we get an
>>> error interrupt then we can just go into a sulk, spam dmesg a bit, put
>>> the hardware into the most vanilla state that we can, and refuse to
>>> manipulate it further.  But this only happens in the case of a software
>>> or hardware *bug* (or, in a future world where we might implement
>>> virtualisation, an uncontainable MPAM error triggered by a guest -- for
>>> which tearing down the host MPAM would be an overreaction).
>>
>> The good news is guests can't escape the PARTID virtualisation that the CPU does, so any
>> mess a guest manages to make is confined to that guest's PARTID range.
>>
>>
>>> Trying to cleanly tear the MPAM driver down after such an error seems a
>>> bit futile.
>>>
>>> The MPAM resctrl glue could eventually be made into a module (though
>>> not needed from day 1) -- which would allow for unloading resctrlfs if
>>> that is eventually module-ised.  I think this wouldn't require the MPAM
>>> devices backend to be torn down at any point, though (?)
>>
>> It would certainly be optional. kernfs->resctrl->mpam is the reason all this has to be
>> built-in. If that changes I'd aim for this to be a module.
>>
>> All this free()ing was added so that the driver doesn't end up sitting on memory when it
>> isn't providing any usable feature. I have seen a platform where the error interrupt goes
> 
> I guess that's reasonable, but this is only applies to hardware that
> has MPAM but where it is either broken, or where it is unsuitable for
> running Linux but Linux has been deployed on it anyway while still
> leaving the ACPI tables intact.  This does not violate any
> specification, but it seems of marginal benefit to introduce a load of
> complexity just to safe a few K in this situation.  (Or do we get stuck,
> unable to free the config and mbwu_state arrays?  Those don't count as
> large on a server-class system, but they are about the "a few K"
> magnitude.)
> 
> (Not that I'm not saying that teardown is something we shouldn't do --
> rather, my point is: do we really need to do it now if it is subtle and
> complex to make it work, or can this be a later addition?)

Equally, can't someone say this memory has been leaked once the MPAM driver has given up.
As alloc/free were done together it seems to odd to do them at separate times - that will
certainly make it more subtle.


>> off during boot, (I suspect firmware configures an out-of-range PARTID). On such a
>> platform any memory that isn't free()d is a waste.
>>
>> But I agree its a small amount of memory.
>>
>>
>>> If we can simplify or eliminate the teardown, does it simplify the
>>> locking at all?  The garbage collection logic can also be dispensed
>>> with if there is never any garbage.
>>
>> It wouldn't simplify the locking, only remove that deferred free()ing which is needed
>> because of SRCU.
> 
> My point was that there is no need to defend against concurrent removal
> if list entries if list entries are never removed.

You can eyeball the writers are recognise the pattern as srcu. If it's an "oh that list is
read only" - then its much more of a driver specific hack.
I'd prefer to keep close to the srcu pattern - even if it is a bit complex.


>>> Since MSCs etc. never disappear from the hardware, it feels like it
>>> ought not to be necessary ever to remove items from any of these lists
>>> except when trying to do a teardown (?)
>>
>> Unbinding the driver from an MSC is another case where this may be triggered via
>> mpam_msc_drv_remove(). If you look at the whole thing, mpam_ris_destroy() pokes
>> mpam_resctrl_teardown_class() to see if resctrl needs to be torn down.
>>
>> I don't anticipate folk actually needing to do that. One Reasons is for VFIO - but this
>> kind of stuff has a performance impact on the hypervisor, so its unlikely to ever allow a
>> guest direct access to this kind of thing. Another reason is to load a more specific
>> driver, which sounds unlikely.
>>
>>
>> Ultimately this memory free-ing code is here because its the right thing to do.
>> I'd prefer to keep it as making this a loadable module would mean we have to do this.
> 
> I don't disagree with that: it is messy to retrofit teardown if it was
> never considered in the initial design.
> 
> I guess that this all comes from my uncertainty about the object
> lifecycles and locking behaviour.
> 
> I would still prefer to see this documented.  If the the documentation
> would be too unwieldy or infrasible to write, this would suggest that
> the code would benefit from simplification...

Right - nothing describes the 'phases' the driver has, they just emerge.
I'll try and add that, but it won't be in time for v2.


> For the probe phase, or for teardown, I'm really not sure why it would
> break anything to have a single Big MPAM Lock (however inelegant).

That is broadly what mpam_list_lock is doing before the cpuhp calls are registered.


> For the run phase (when resctrl and other clients of the driver are
> able to use the driver), the discovered system properties and the
> mappings onto resctrl resources are all static, and we don't seem to
> need all this RCU stuff.

Iff we say "driver specific hack - read only list" - I think that is worse.
Making it srcu makes it recognisable, and lets us free the memory instead of leaking it.


Thanks,

James

