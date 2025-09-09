Return-Path: <linux-acpi+bounces-16532-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 370A7B4ABDD
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 13:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C344F34012E
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 11:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7848B3218B9;
	Tue,  9 Sep 2025 11:28:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476FD321451;
	Tue,  9 Sep 2025 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417305; cv=none; b=RdlqHUfa56qi1Soe1+1zus+O2HeSIRslh9B5nTy89xgsZrtyPurZWtQO4wLGCSVLZtZd0xic+4O1ApbAbUzWOVRtcjsZfdf1X/fKqARd+m5nY6w5EDewbQkHYdMunzczXwn7V71AeLg2iPtfAtyjF3BHNBzV6vOver/say33cHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417305; c=relaxed/simple;
	bh=MQtrL/WDOT0WLzpfj3x32II2tAb8KVwAoJTkQ47pHdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcbtgMkGj2WK9Fe1XS7kthGbvuXDYVZG++Hpwq7Hpi30fcd8ihkfO7w7v6bKn/LqDv+LFSyl79xYK/uYoWm9L86IQmp38zirDzvrcSxU0pLFsv/cMwj9angTPK+K8hgl8A9lGY08+TOao9erZhCkW3E24vMlGfJNsrR9lSP7L1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19BAC1424;
	Tue,  9 Sep 2025 04:28:14 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF5683F694;
	Tue,  9 Sep 2025 04:28:16 -0700 (PDT)
Date: Tue, 9 Sep 2025 12:28:13 +0100
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
	David Hildenbrand <david@redhat.com>, Koba Ko <kobak@nvidia.com>,
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
	Danilo Krummrich <dakr@kernel.org>, Ben Horgan <ben.horgan@arm.com>
Subject: Re: [PATCH 12/33] arm_mpam: Add the class and component structures
 for ris firmware described
Message-ID: <aMAPTVqb7fLfFH6R@e133380.arm.com>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-13-james.morse@arm.com>
 <aLV++1PELhKBeKR7@e133380.arm.com>
 <ff73df9c-8e77-471d-b0fb-205701b4d6d3@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff73df9c-8e77-471d-b0fb-205701b4d6d3@arm.com>

Hi,

On Mon, Sep 08, 2025 at 06:57:41PM +0100, James Morse wrote:
> Hi Dave,
> 
> On 01/09/2025 12:09, Dave Martin wrote:
> >> Subject: arm_mpam: Add the class and component structures for ris firmware described
> > 
> > Mangled subject line?
> 
> order words hard is.
> 
> 
> > There is a fair intersection between the commit message and what the
> > patch does, but they don't quite seem to match up.
> > 
> > Some key issues like locking / object lifecycle management
> > and DT parsing (a bit of which, it appears, lives here too) are not
> > mentioned at all.
> 
> I don't think everything needs mentioning - you have the diff for that.This should capture
> the motivation, what you have and what you need to find, the grouping etc.
> 
> 
> > In lieu of a complete rewrite, it might be best to discard the
> > explanation of the various object types.  The comment in the code
> > speaks for itself, and looks clearer.
> 
> Fair enough,

OK

[...]

> >> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> >> index 71a1fb1a9c75..5baf2a8786fb 100644
> >> --- a/drivers/resctrl/mpam_devices.c
> >> +++ b/drivers/resctrl/mpam_devices.c
> >> @@ -20,7 +20,6 @@
> > 
> > [...]
> > 
> >> @@ -35,11 +34,483 @@
> >>  static DEFINE_MUTEX(mpam_list_lock);
> >>  static LIST_HEAD(mpam_all_msc);
> >>  
> >> -static struct srcu_struct mpam_srcu;
> >> +struct srcu_struct mpam_srcu;
> 
> > Why expose this here?  This patch makes no use of the exposed symbol.
> 
> The mpam_resctrl code needs to take it when it walks these lists. I don't want to change
> it then because its just additional churn.

I guess this is harmless, but it's no help to the kernel, or to
reviewers...

[...]

> >> +/*
> >> + * An MSC is a physical container for controls and monitors, each identified by

[...]

> >> + * The same MSC may exist under different class->component->vmsc paths, but the
> >> + * RIS index will be unique.
> >> + */
> > 
> > This description of the structures and how they relate to each other
> > seems OK (bearing in mind that I am already familiar with this stuff --
> > I can't speak for other people).
> 
> Great!

OK

[...]

> >> +static void mpam_ris_destroy(struct mpam_msc_ris *ris)
> >> +{
> >> +	struct mpam_vmsc *vmsc = ris->vmsc;
> >> +	struct mpam_msc *msc = vmsc->msc;
> >> +	struct platform_device *pdev = msc->pdev;
> >> +	struct mpam_component *comp = vmsc->comp;
> >> +	struct mpam_class *class = comp->class;
> >> +
> >> +	lockdep_assert_held(&mpam_list_lock);
> >> +
> >> +	cpumask_andnot(&comp->affinity, &comp->affinity, &ris->affinity);
> >> +	cpumask_andnot(&class->affinity, &class->affinity, &ris->affinity);
> > 
> > This is not the inverse of the cpumask_or()s in mpam_ris_create_locked(),
> > unless the the ris associated with each class and each component have
> > strictly disjoint affinity masks.  Is that checked anywhere, or should
> > it be impossible by construction?
> 
> They should be disjoint. These bitmaps are built from firmware description of the cache
> hierarchy. I don't think its possible to describe a situation where there are overlaps.
> 
> You can build a nonsense cache hierarchy, e.g. where CPU-0's L3 is CPU-6's L2, but if you
> do the scheduler is going to complain when it tries to chose the scheduler domains. I
> think this should be filed under "you've got bigger problems".  There is a check that
> catches this in mpam_resctrl_pick_caches(), to see that all the CPUs are accounted for,
> which is to avoid tasks that get lucky with task-placement managing to escape their
> resource limit.

I guess that makes sense.

If the firmware description is formally a tree structure then it should
be impossible to end up with overlapping affinity masks.

Since this doesn't bite us until teardown-time in any case, I think
this probably doesn't need to be checked explicitly, unless we observe
actual problems.

A comment documenting this assumption may be worth having.


> > But, thinking about it:
> > 
> > I wonder why we ever really need to do the teardown.  If we get an
> > error interrupt then we can just go into a sulk, spam dmesg a bit, put
> > the hardware into the most vanilla state that we can, and refuse to
> > manipulate it further.  But this only happens in the case of a software
> > or hardware *bug* (or, in a future world where we might implement
> > virtualisation, an uncontainable MPAM error triggered by a guest -- for
> > which tearing down the host MPAM would be an overreaction).
> 
> The good news is guests can't escape the PARTID virtualisation that the CPU does, so any
> mess a guest manages to make is confined to that guest's PARTID range.
> 
> 
> > Trying to cleanly tear the MPAM driver down after such an error seems a
> > bit futile.
> > 
> > The MPAM resctrl glue could eventually be made into a module (though
> > not needed from day 1) -- which would allow for unloading resctrlfs if
> > that is eventually module-ised.  I think this wouldn't require the MPAM
> > devices backend to be torn down at any point, though (?)
> 
> It would certainly be optional. kernfs->resctrl->mpam is the reason all this has to be
> built-in. If that changes I'd aim for this to be a module.
> 
> All this free()ing was added so that the driver doesn't end up sitting on memory when it
> isn't providing any usable feature. I have seen a platform where the error interrupt goes

I guess that's reasonable, but this is only applies to hardware that
has MPAM but where it is either broken, or where it is unsuitable for
running Linux but Linux has been deployed on it anyway while still
leaving the ACPI tables intact.  This does not violate any
specification, but it seems of marginal benefit to introduce a load of
complexity just to safe a few K in this situation.  (Or do we get stuck,
unable to free the config and mbwu_state arrays?  Those don't count as
large on a server-class system, but they are about the "a few K"
magnitude.)

(Not that I'm not saying that teardown is something we shouldn't do --
rather, my point is: do we really need to do it now if it is subtle and
complex to make it work, or can this be a later addition?)

> off during boot, (I suspect firmware configures an out-of-range PARTID). On such a
> platform any memory that isn't free()d is a waste.
> 
> But I agree its a small amount of memory.
> 
> 
> > If we can simplify or eliminate the teardown, does it simplify the
> > locking at all?  The garbage collection logic can also be dispensed
> > with if there is never any garbage.
> 
> It wouldn't simplify the locking, only remove that deferred free()ing which is needed
> because of SRCU.

My point was that there is no need to defend against concurrent removal
if list entries if list entries are never removed.

> > Since MSCs etc. never disappear from the hardware, it feels like it
> > ought not to be necessary ever to remove items from any of these lists
> > except when trying to do a teardown (?)
> 
> Unbinding the driver from an MSC is another case where this may be triggered via
> mpam_msc_drv_remove(). If you look at the whole thing, mpam_ris_destroy() pokes
> mpam_resctrl_teardown_class() to see if resctrl needs to be torn down.
> 
> I don't anticipate folk actually needing to do that. One Reasons is for VFIO - but this
> kind of stuff has a performance impact on the hypervisor, so its unlikely to ever allow a
> guest direct access to this kind of thing. Another reason is to load a more specific
> driver, which sounds unlikely.
> 
> 
> Ultimately this memory free-ing code is here because its the right thing to do.
> I'd prefer to keep it as making this a loadable module would mean we have to do this.

I don't disagree with that: it is messy to retrofit teardown if it was
never considered in the initial design.

I guess that this all comes from my uncertainty about the object
lifecycles and locking behaviour.

I would still prefer to see this documented.  If the the documentation
would be too unwieldy or infrasible to write, this would suggest that
the code would benefit from simplification...


For the probe phase, or for teardown, I'm really not sure why it would
break anything to have a single Big MPAM Lock (however inelegant).

For the run phase (when resctrl and other clients of the driver are
able to use the driver), the discovered system properties and the
mappings onto resctrl resources are all static, and we don't seem to
need all this RCU stuff.

> > (Putting the hardware into a quiecent state is not the same thing as
> > tearing down the data structures -- we do want to quiesce MPAM when
> > shutting down the kernel, as least for the kexec scenario.)
> 
> > [...]
> > 
> >> +static int mpam_ris_create_locked(struct mpam_msc *msc, u8 ris_idx,
> >> +				  enum mpam_class_types type, u8 class_id,
> >> +				  int component_id, gfp_t gfp)
> >> +{
> >> +	int err;
> >> +	struct mpam_vmsc *vmsc;
> >> +	struct mpam_msc_ris *ris;
> >> +	struct mpam_class *class;
> >> +	struct mpam_component *comp;
> >> +.
> >> +	lockdep_assert_held(&mpam_list_lock);
> >> +
> >> +	if (test_and_set_bit(ris_idx, msc->ris_idxs))
> >> +		return -EBUSY;
> > 
> > Is it impossible by construction to get in here with an out-of-range
> > ris_idx?
> > 
> > To avoid the callers (i.e., ACPI) needing to understand the internal
> > limitations of this code, maybe it is worth having a check here (even
> > if technically redundant).
> 
> It's possible - but only if you mess up the firmware tables.
> I'll add a check for this as its easy enough.

OK, suits me.

Cheers
---Dave

