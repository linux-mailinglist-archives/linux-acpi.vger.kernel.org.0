Return-Path: <linux-acpi+bounces-16542-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0880B5038A
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 18:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212231C66E19
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 16:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F74635AAA8;
	Tue,  9 Sep 2025 16:56:58 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580D235A296;
	Tue,  9 Sep 2025 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437018; cv=none; b=Ry60g5yW9RHEojfWXhEfjJfKiyLD8ljG/Y/ykq5BY8XwzZ8DqjGgS4c1bC32seGAJCwlaUXLeTvkJI14WOzmgyI3lveLDygBgGT4paOgHe5mYYnUf6L41jvDv+Qeplc4msCwEwLr0bMLnJmJ0QPAOL/3pRdm6zOssu9V8ggM5bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437018; c=relaxed/simple;
	bh=fuZ8S+nV8+7N9fsS4myg8Dcekewy5Laev8LV05+bx1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bt/lHsT/e9I5gwEZWU6mB6et/QQY6gEfExVtdhZL0eQHWdNTVXc+7rPaOW0UXq76XrutgTu5ZKSugt1pzs5PMBLovIQzEUC6o5+vDz9uWqXcmbbyx4fbJthuWFoniOzxtuMKXdliOW/xkRwJKFL8oW5wuX83XPkCIelGJWBTYG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAF2A15A1;
	Tue,  9 Sep 2025 09:56:46 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 022863F694;
	Tue,  9 Sep 2025 09:56:48 -0700 (PDT)
Message-ID: <99a4577f-3d64-4466-a958-864f763bf895@arm.com>
Date: Tue, 9 Sep 2025 17:56:47 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/33] arm_mpam: Add cpuhp callbacks to probe MSC hardware
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
 Danilo Krummrich <dakr@kernel.org>, Lecopzer Chen <lecopzerc@nvidia.com>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-15-james.morse@arm.com>
 <aLsSZWUlbrEzbx6O@e133380.arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <aLsSZWUlbrEzbx6O@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dave,

On 05/09/2025 17:40, Dave Martin wrote:
> On Fri, Aug 22, 2025 at 03:29:55PM +0000, James Morse wrote:
>> Because an MSC can only by accessed from the CPUs in its cpu-affinity
>> set we need to be running on one of those CPUs to probe the MSC
>> hardware.
>>
>> Do this work in the cpuhp callback. Probing the hardware will only
>> happen before MPAM is enabled, walk all the MSCs and probe those we can
>> reach that haven't already been probed.
> 
> It may be worth mentioning that the low-level MSC register accessors
> are added by this patch.

Sure,


>> Later once MPAM is enabled, this cpuhp callback will be replaced by
>> one that avoids the global list.
> 
> I misread this is as meaning "later in the patch series" and got
> confused.
> 
> Perhaps, something like the following? (though this got a bit verbose)
> 
> --8<--
> 
> Once all MSCs reported by the firmware have been probed from a CPU in
> their respective cpu-affinity set, the probe-time cpuhp callbacks are
> replaced.  The replacement callbacks will ultimately need to handle
> save/restore of the runtime MSC state across power transitions, but for
> now there is nothing to do in them: so do nothing.
> 
> -->8--

Done.

>> Enabling a static key will also take the cpuhp lock, so can't be done
> 
> What static key?

The one that enables the architectures context-switch code. That was added by an
earlier patch, but got moved later to reduce the number of trees that this series touches.
(also, there is no point having the context switch code if you can't have different values
until the resctrl code shows up.)

This is trying to describe why mpam_enable() is scheduled, instead of just being called in
cpuhp context. (again - to reduce the churn caused by changing that later).

I'll rephrase it as:
| The architecture's context switch code will be enabled by a static-key, this can be set
| by mpam_enable(), but must be done from process context, not a cpuhp callback because
| both take the cpuhp lock.
| Whenever a new MSC has been probed, the mpam_enable() work is scheduled to test if all
| the MSCs have been probed.



> None in this patch that I can see.
> 
>> from the cpuhp callback. Whenever a new MSC has been probed schedule
>> work to test if all the MSCs have now been probed.


>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> 
> [...]
> 
>> @@ -511,9 +539,84 @@ int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
> 
> [...]
> 
>> +static int mpam_cpu_online(unsigned int cpu)
>>  {
>> -	pr_err("Discovered all MSC\n");
> 
> I guess this disappears later?
> 
> If we print anything, it feels like it should be in the
> mpam_enable_once() path, otherwise it looks like dmesg is going to get
> spammed on every hotplug.  I might have missed something, here.

Yes - there is a print that happens on the mpam_enable_once() path that shows the number
of PARTID/PMG discovered. That "Discovered all MSC" message was so that probing had this
shape from the very beginning - it is unfortunately not as simple as probing a stand-alone
driver.



>> +	return 0;
>> +}
>> +
>> +/* Before mpam is enabled, try to probe new MSC */
>> +static int mpam_discovery_cpu_online(unsigned int cpu)
>> +{
>> +	int err = 0;
>> +	struct mpam_msc *msc;
>> +	bool new_device_probed = false;
>> +
>> +	mutex_lock(&mpam_list_lock);

> I take it nothing breaks if we sleep here?

From memory, callbacks registered at CPUHP_AP_ONLINE_DYN are allowed to sleep. There is
some point in the state machine where you can't. I can't find where this comes from right
now...
e.g. resctrl does this in x86's resctrl_arch_online_cpu() and friends.


> Pending cpuhp callbacks for this CPU look to be blocked while we sleep,
> at the very least.
> Since this only happens during the probing phase, maybe that's not such
> a big deal.


> Is it likely that some late CPUs might be left offline indefinitely?

Offlined and never come back is certainly something that can happen.


> If so, we might end up doing futile work here forever.

It may never probe all the MSC? Yes, that can certainly happen.
But the work only happens when CPUs come online, which is already a major serialising
event. There is no cost to run in this 'not done yet' state forever. It's not retrying on
a timer or something like that.


>> +	list_for_each_entry(msc, &mpam_all_msc, glbl_list) {
>> +		if (!cpumask_test_cpu(cpu, &msc->accessibility))
>> +			continue;
>> +
>> +		mutex_lock(&msc->probe_lock);
>> +		if (!msc->probed)
>> +			err = mpam_msc_hw_probe(msc);
>> +		mutex_unlock(&msc->probe_lock);
>> +
>> +		if (!err)
>> +			new_device_probed = true;
>> +		else
>> +			break; // mpam_broken

> What's the effect of returning a non-zero value to the CPU hotplug
> callback dispatcher here?

I think the dynamically allocated ones can fail without any ill effects, it'll print a
message but nothing else will happen. In this case the callbacks are synchronous with the
attempt to register them, so it propagates the error back there.


> Do we want to tear anything down if MPAM is unusable?

It will keep trying, whereas it could pack up shop completely.

Looks like that '// mpam_broken' is where I intended to schedule the work, but the code
doesn't exist this early in the series. I'll pull bits of that earlier.


>> +	}
>> +	mutex_unlock(&mpam_list_lock);
>> +
>> +	if (new_device_probed && !err)
>> +		schedule_work(&mpam_enable_work);
>> +
>> +	return err;
>> +}
>> +
>> +static int mpam_cpu_offline(unsigned int cpu)
>> +{
>> +	return 0;
>> +}
>> +
>> +static void mpam_register_cpuhp_callbacks(int (*online)(unsigned int online),
>> +					  int (*offline)(unsigned int offline))
>> +{
>> +	mutex_lock(&mpam_cpuhp_state_lock);
>> +	if (mpam_cpuhp_state) {
>> +		cpuhp_remove_state(mpam_cpuhp_state);
>> +		mpam_cpuhp_state = 0;
>> +	}
>> +
>> +	mpam_cpuhp_state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mpam:online",
>> +					     online, offline);
>> +	if (mpam_cpuhp_state <= 0) {
>> +		pr_err("Failed to register cpuhp callbacks");

> Should an error code be returned to the caller if this fails?

It can fail asynchronously - so any error handling for this is only solves part of the
problem, a failure here means at least one of the callbacks ran and returned an error.
If we schedule the disable call in the callback then that will take care of tearing the
whole thing down.
The cpuhp callbacks don't get registered until all the driver has found all the MSC that
firmware described, so there is no race with driver:probing an MSC after the disable call
got scheduled which tears the whole thing down.


>> +		mpam_cpuhp_state = 0;
>> +	}
>> +	mutex_unlock(&mpam_cpuhp_state_lock);
>>  }
>>  
>>  static int mpam_dt_count_msc(void)
>> @@ -772,7 +875,7 @@ static int mpam_msc_drv_probe(struct platform_device *pdev)
>>  	}
>>  
>>  	if (!err && fw_num_msc == mpam_num_msc)
>> -		mpam_discovery_complete();
>> +		mpam_register_cpuhp_callbacks(&mpam_discovery_cpu_online, NULL);
> 
> Abandon probing the MSC if this fails?

Any error returned here is most likely to be from mpam_discovery_cpu_online(), but that
can also happen asynchronously. Scheduling mpam_disable() is a better approach as it
covers the asynchronous case too.


> (However, the next phase of probing hangs off CPU hotplug, so it just
> won't happen if the callbacks can't be registered -- but it looks like
> MPAM may be left in a half-probed state.  I'm not entirely convinced
> that this matters if the MPAM driver is not unloadable anyway...)

I'm not at all worried about failing to register the cpuhp callbacks. The space needed for
that is pre-allocated, if there isn't enough space, you get a splat from the cpuhp core -
and the callbacks never run. No additional/unnecessary work happens - sure the memory
didn't get free'd, but the WARN() from cpuhp_reserve_state() should be enough to debug this.


> Nit: redundant &
> 
> (You don't have it in the similar call in mpam_enable_once().)

Done,


>>  	if (err && msc)
>>  		mpam_msc_drv_remove(pdev);
>> @@ -795,6 +898,41 @@ static struct platform_driver mpam_msc_driver = {
>>  	.remove = mpam_msc_drv_remove,
>>  };
>>  
>> +static void mpam_enable_once(void)
>> +{
>> +	mpam_register_cpuhp_callbacks(mpam_cpu_online, mpam_cpu_offline);
> 
> Should it be fatal if this fails?

As above. Once case doesn't matter - and any handling here is incomplete.


>> +
>> +	pr_info("MPAM enabled\n");
>> +}
>> +
>> +/*
>> + * Enable mpam once all devices have been probed.
>> + * Scheduled by mpam_discovery_cpu_online() once all devices have been created.
>> + * Also scheduled when new devices are probed when new CPUs come online.
>> + */
>> +void mpam_enable(struct work_struct *work)
>> +{
>> +	static atomic_t once;
> 
> Nit: possibly unnecessary atomic_t?  This is slow-path code, and we
> already have to take mpam_list_lock.  Harmless, though.

mpam_enable_once() can't be called under the lock because of the ordering with cpuhp. This
just ended up being cleaner. Too much is stuffed under that lock already!


>> +	struct mpam_msc *msc;
>> +	bool all_devices_probed = true;
>> +
>> +	/* Have we probed all the hw devices? */
>> +	mutex_lock(&mpam_list_lock);
>> +	list_for_each_entry(msc, &mpam_all_msc, glbl_list) {
>> +		mutex_lock(&msc->probe_lock);
>> +		if (!msc->probed)
>> +			all_devices_probed = false;
>> +		mutex_unlock(&msc->probe_lock);
>> +
>> +		if (!all_devices_probed)
>> +			break;
> 
> WARN()?

Expected condition...


> We counted the MSCs in via the mpam_discovery_cpu_online(), so I think
> we shouldn't get in here if some failed to probe?

No we didn't!
We counted them in mpam_msc_drv_probe() before registering the cpuhp callbacks.
The cpuhp callbacks run asynchronously, each one schedules mpam_enable() iff it probed a
new device. mpam_enable() then has to check if all the devices had been probed.

This is done so that mpam_discovery_cpu_online() only has to take the msc->probe_lock for
MSC that it can access - instead of all of them. That was to avoid having something that
serialises CPUs coming online ... but mpam_discovery_cpu_online() is taking the list_lock
due to an incomplete switch to SRCU. I'll fix that.


>> +	}
>> +	mutex_unlock(&mpam_list_lock);
>> +
>> +	if (all_devices_probed && !atomic_fetch_inc(&once))
>> +		mpam_enable_once();
>> +}


Thanks,

James

