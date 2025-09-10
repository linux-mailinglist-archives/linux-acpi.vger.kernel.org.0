Return-Path: <linux-acpi+bounces-16596-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9557B520BE
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 21:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E6D189CA88
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 19:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B66F2D542B;
	Wed, 10 Sep 2025 19:19:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6037429E115;
	Wed, 10 Sep 2025 19:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757531959; cv=none; b=EQ6iZLcnn2BAcHf7EqP87CsCP+AyHg4lrfDAKsirKPXqozO4GCZQiOLuxa/CDATNa+nVhnGRpG9oCOVLQ/O2MpW3Ra8EXrmdmIb/zALcplz7+m0zwfD/6ZbkmrrviPzKFIT0GwGwkdTzWGAQvttnP4fGfrzUKsGYb9RgAKHxK+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757531959; c=relaxed/simple;
	bh=jwJZhRU/w/h0cEDUI5UN11bGGLmn04QK/RkqMeyWD2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UfkqakLkPwYZPyNla6qZ5EH8e+X0m6JJ0r2BfHFwop0i8HOsj43AHrG4OI21upHNNd3pGo3AvLPPP5+o1eXMyXzeeNhCh21mv0lr23D0eZofc7T7LgHWckt+slSTcsiBq3Oa+g1wMiKhs0gVQfK8Wgi4mLpTyFQzUYCl32ws7xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 428E516F2;
	Wed, 10 Sep 2025 12:19:06 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8755E3F694;
	Wed, 10 Sep 2025 12:19:08 -0700 (PDT)
Message-ID: <e12dce47-77a3-4993-98e7-c1eba683b4d0@arm.com>
Date: Wed, 10 Sep 2025 20:19:06 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/33] arm_mpam: Add helpers for managing the locking
 around the mon_sel registers
To: Dave Martin <Dave.Martin@arm.com>
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
 <20250822153048.2287-17-james.morse@arm.com>
 <aMBKQCmlj0Ne56/M@e133380.arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <aMBKQCmlj0Ne56/M@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dave,

On 09/09/2025 16:39, Dave Martin wrote:
> On Fri, Aug 22, 2025 at 03:29:57PM +0000, James Morse wrote:
>> The MSC MON_SEL register needs to be accessed from hardirq context by the
>> PMU drivers, making an irqsave spinlock the obvious lock to protect these
> 
> What PMU drivers?  MPAM itself doesn't define its monitors as PMUs, and
> (as of this series) there is no intergration with perf.

I can redraw this as the IPI that is needed on platforms with cache:MSC and PSCI:CPU_SUSPEND.

The PMU driver got dragged further out in time as ABMC may be a viable alternative
for platforms with insufficient monitors. (but there are also platforms which don't
look enough like a Xeon for this to work)


>> registers. On systems with SCMI mailboxes it must be able to sleep, meaning
>> a mutex must be used.
>>
>> Clearly these two can't exist at the same time.
> 
> The locks obvisouly do exist at the same time.  Do you mean that an
> individual MSC must be either MMIO or SCMI/PCC?

Yes, I've reworded that as 'for one MSC at the same time'.

> (I don't think anything prevents both kinds of MSC from existing in the
> same system?)
> 
> Above, you seem to imply that each kind of MSC interface requires a
> different kind of lock, but below, you imply that the locks must be
> used together, with holding the outer lock being a precondition for
> taking the inner lock. 
> 
> Because these functions are introduced with no user, the code doesn't
> offer much in the way of clues.  In particular, there is no indication
> of what the outer lock is supposed to protect.

It's a structure to you do the right things in the right context.
You have to try to take both locks - all the inner lock does on a system that
needs to sleep is check the context, so the outer lock does all the 'protecting'.
On 'normal' systems, the inner lock takes an irqsave spinlock which makes does
all the work, and makes it safe for the overflow interrupt.



>> Add helpers for the MON_SEL locking. The outer lock must be taken in a
>> pre-emptible context before the inner lock can be taken. On systems with
>> SCMI mailboxes where the MON_SEL accesses must sleep - the inner lock
>> will fail to be 'taken' if the caller is unable to sleep. This will allow
>> the PMU driver to fail without having to check the interface type of
> 
> Why is it acceptable to fail (i.e., don't the counts need to be read on
> non-MMIO MSCs?)

They can't from contexts that need to sleep. If you've got this firmware thing
you also need to have a platform that doesn't need IPI to reach the mailbox (why
would it), overflow interrupts, or a PMU driver.
Instead of having two drivers, or type checks all over the place - this structure
lets such a platform get through as much of the driver as possible, before failing
at the point that would deadlock. (need to wait for an interrupt in interrupt context).

I think this is the most maintainable approach as it has the most in common. I don't like
the two drivers alternative.


>> each MSC.



>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
>> index a623f405ddd8..c6f087f9fa7d 100644
>> --- a/drivers/resctrl/mpam_internal.h
>> +++ b/drivers/resctrl/mpam_internal.h
>> @@ -68,10 +68,19 @@ struct mpam_msc {
>>  
>>  	/*
>>  	 * mon_sel_lock protects access to the MSC hardware registers that are
>> -	 * affeted by MPAMCFG_MON_SEL.
>> +	 * affected by MPAMCFG_MON_SEL, and the mbwu_state.
>> +	 * Both the 'inner' and 'outer' must be taken.
>> +	 * For real MMIO MSC, the outer lock is unnecessary - but keeps the
>> +	 * code common with:
>> +	 * Firmware backed MSC need to sleep when accessing the MSC, which
>> +	 * means some code-paths will always fail. For these MSC the outer
>> +	 * lock is providing the protection, and the inner lock fails to
>> +	 * be taken if the task is unable to sleep.
>> +	 *
>>  	 * If needed, take msc->probe_lock first.
>>  	 */
>>  	struct mutex		outer_mon_sel_lock;
>> +	bool			outer_lock_held;
> 
> Why not use mutex_is_locked()?

That works. I've had a bad experience with the lockdep version of that checking who
owns the mutex, and getting confused when there is an IPI involved.


>>  	raw_spinlock_t		inner_mon_sel_lock;
> 
> Why raw?  The commit message makes no mention of it.
> 
> (We really to need to sit on a specific CPU while holding this lock, so
> "raw" makes sense.  But we're always doing this in a cross-call,
> presumably with the hotplug lock held -- so I think we can't be
> migrated anyway?)

Nothing to do with hotplug. (my recollection as to why this got changed - ) is because an
IPI results in the kind of context where you can't sleep - and regular spinlocks can end
up sleeping. This is the trick RT pulls. Without raw here - the atomic sleep check starts
complaining about taking a spinlock  behind and IPI.


>>  	unsigned long		inner_mon_sel_flags;
>>  
>> @@ -81,6 +90,52 @@ struct mpam_msc {
>>  	struct mpam_garbage	garbage;
>>  };
>>  
>> +static inline bool __must_check mpam_mon_sel_inner_lock(struct mpam_msc *msc)
>> +{
>> +	/*
>> +	 * The outer lock may be taken by a CPU that then issues an IPI to run
>> +	 * a helper that takes the inner lock. lockdep can't help us here.
>> +	 */
>> +	WARN_ON_ONCE(!msc->outer_lock_held);
>> +
>> +	if (msc->iface == MPAM_IFACE_MMIO) {
>> +		raw_spin_lock_irqsave(&msc->inner_mon_sel_lock, msc->inner_mon_sel_flags);
>> +		return true;
>> +	}
>> +
>> +	/* Accesses must fail if we are not pre-emptible */
>> +	return !!preemptible();
> 
> What accesses?

To the mon_sel register.



> In the MPAM_IFACE_MMIO case, this returns true even though non-
> preemptible (because of getting the lock).
> 
> So, what is the semantics of the return value?
> 
> A comment would probably help.

/* Returning false here means accesses to mon_sel must fail and report an error. */


>> +}
>> +
>> +static inline void mpam_mon_sel_inner_unlock(struct mpam_msc *msc)
>> +{
>> +	WARN_ON_ONCE(!msc->outer_lock_held);
>> +
>> +	if (msc->iface == MPAM_IFACE_MMIO)
>> +		raw_spin_unlock_irqrestore(&msc->inner_mon_sel_lock, msc->inner_mon_sel_flags);
>> +}
>> +
>> +static inline void mpam_mon_sel_outer_lock(struct mpam_msc *msc)
>> +{
>> +	mutex_lock(&msc->outer_mon_sel_lock);
>> +	msc->outer_lock_held = true;
>> +}
>> +
> 
>> +static inline void mpam_mon_sel_outer_unlock(struct mpam_msc *msc)
>> +{
>> +	msc->outer_lock_held = false;
>> +	mutex_unlock(&msc->outer_mon_sel_lock);
>> +}
>> +
>> +static inline void mpam_mon_sel_lock_held(struct mpam_msc *msc)
>> +{
>> +	WARN_ON_ONCE(!msc->outer_lock_held);
>> +	if (msc->iface == MPAM_IFACE_MMIO)
>> +		lockdep_assert_held_once(&msc->inner_mon_sel_lock);
>> +	else
>> +		lockdep_assert_preemption_enabled();
>> +}
>> +
> 
> Except that monitors may need to be accessed in interrupt context,
> I don't see an obvious difference between controls and monitors that
> motivates this locking model.

Controls don't have an overflow interrupt, and would never be accessed by perf in nasty
contexts.


> Is the outer lock ever needfully held for extended periods of time,
> making a (raw) spinlock unsuitable?

It's held before sending the IPI - but only because the firmware platforms should never
need to send that IPI.

I can drop the outer lock for now as the firmware platforms haven't properly materialised,
(promised ~three years ago - also promised in December this year). But some kind of
abstraction is needed here to keep the code common, and these mon_sel accesses need to be
something that can fail.


Thanks,

James

