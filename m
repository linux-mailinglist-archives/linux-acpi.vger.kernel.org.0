Return-Path: <linux-acpi+bounces-16544-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 020A4B50387
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 18:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36D807B762C
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 16:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BCB340DB3;
	Tue,  9 Sep 2025 16:57:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B00035CECD;
	Tue,  9 Sep 2025 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437031; cv=none; b=Z6vWsNweOJNhB12i3ELWIZ3LorApDN70MrOlE016kK/rBLfUSMj2pGT+oc3+CXdHb9R04nd2SdmfxQSmHm9xtYTz3ZGI6tKxOgfFJah+7SIrBr4fymXr0f4M+csCigR2VTEVOApmPenO4aCa9wXYYvrRSn/saOwRd15VP/kJZM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437031; c=relaxed/simple;
	bh=tPvbnpcUl8Wz1MKPATE2vTJMVgl7EM8M8uNW7pXJ1NQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uacKovmKRv9f7ruZr6JfmXC/ZtBw+qa9YlMcCHmYh/OfpumspMASx0dM/hIu33EOFHDe/D/0Ae0a3in8LGq/EZv/CWk0KZfSzalw4JOmh0jnqsei2dhqELVSbX1scZMzO28kpOHh0BbTjUNObOHKo8rPrMUXHB8neI1zF0eyq04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7029F20E3;
	Tue,  9 Sep 2025 09:57:00 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DE5E3F694;
	Tue,  9 Sep 2025 09:57:02 -0700 (PDT)
Message-ID: <c11df9c9-eca6-491f-aad3-1dff954b4d13@arm.com>
Date: Tue, 9 Sep 2025 17:57:00 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/33] arm_mpam: Probe MSCs to find the supported
 partid/pmg values
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
 <20250822153048.2287-16-james.morse@arm.com>
 <aL8Eb3EDhJaalPc5@e133380.arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <aL8Eb3EDhJaalPc5@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dave,

On 08/09/2025 17:29, Dave Martin wrote:
> On Fri, Aug 22, 2025 at 03:29:56PM +0000, James Morse wrote:
>> Subject: Re: [PATCH 15/33] arm_mpam: Probe MSCs to find the supported partid/pmg values
> 
> Summary line does not describe the patch (i.e., the requestor
> registration interface is something different... and the probing of RIS
> properties has nothing architecturally to do with determining the max
> PARTID and PMG values.)

The values are allowed to vary by 'instance' of the id register - which someone is going
to read as per-RIS. (it should really have said per security state). Doing this makes its
robust against that, and we're going to have to walk the list of RIS anyway.

The CPU requestor probing isn't part of the MSC, I'll rephrase it 'probe hardware'.


> Even regarding the MSC probing, there is considerably more in this
> patch than just the determination of the ID limits.

The only real exta bit is creating the UNKNOWN MSC as they've now been discovered.
I don't think that's worth a patch on its own, there are too many as it is.


>> CPUs can generate traffic with a range of PARTID and PMG values,
>> but each MSC may have its own maximum size for these fields.
>> Before MPAM can be used, the driver needs to probe each RIS on
>> each MSC, to find the system-wide smallest value that can be used.
>>
>> While doing this, RIS entries that firmware didn't describe are create
> 
> Nit: created

Fixed,

>> under MPAM_CLASS_UNKNOWN.
> 
> What are the effects / implications of this?

They're accounted for, reset, exposed to debugfs. But unused.


>> While we're here, implement the mpam_register_requestor() call
>> for the arch code to register the CPU limits. Future callers of this
>> will tell us about the SMMU and ITS.
> 
> This function seems to be dead in this series; registration of CPUs is
> "future" too. Does it make sense to boot this into the next series?

>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index 9d6516f98acf..012e09e80300 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -44,6 +45,15 @@ static u32 mpam_num_msc;
>>  static int mpam_cpuhp_state;
>>  static DEFINE_MUTEX(mpam_cpuhp_state_lock);
>>  
>> +/*
>> + * The smallest common values for any CPU or MSC in the system.
>> + * Generating traffic outside this range will result in screaming interrupts.
>> + */
>> +u16 mpam_partid_max;
>> +u8 mpam_pmg_max;
>> +static bool partid_max_init, partid_max_published;
>> +static DEFINE_SPINLOCK(partid_max_lock);

> Can partid_max and pmg_max simply be statically initialised with the
> max value of the respective type instead? -1 or ~0 would be adequate
> initialisers.

How do we know ~0 isn't the final value?


> This would allow us to get rid of partid_max_init and the associated
> logic.

This is what causes the driver to report 0 PARTID and 0 PMG if no requestors turn up.

I think initialising as ~0 would result in more handing of ~0 as a special case, and
wouldn't be self contained. As it is, 0 doesn't need handling as its safe to use when
there are no requestors.


> This assumes that we don't enable MPAM (and start using nonzero values
> in MPAM[10]_EL1) unless at least one usable MSC was found, so that the
> initialiser is not left behing.
> 
> I think that's true by construction -- if the firmware reports no MSCs,
> we probe nothing.  Otherwise, we require every MSC reported by the
> firmware to probe before enabling MPAM.

But we can't know how many requestors there are - only which ones showed up.
It's not just about the MSC.


>> @@ -106,6 +116,74 @@ static inline u32 _mpam_read_partsel_reg(struct mpam_msc *msc, u16 reg)
>> +int mpam_register_requestor(u16 partid_max, u8 pmg_max)
>> +{
>> +	int err = 0;
>> +
>> +	lockdep_assert_irqs_enabled();
> 
> This is just because we don't use spin_lock_irqsave(), right?

raw_spinlock_t is (now) needed from irq-masked contexts like IPI - but wasn't at the time
I wrote this. It can go now as mainline checks this.


> (Just checking my understanding.)

>> +
>> +	spin_lock(&partid_max_lock);
>> +	if (!partid_max_init) {
>> +		mpam_partid_max = partid_max;
>> +		mpam_pmg_max = pmg_max;
>> +		partid_max_init = true;
>> +	} else if (!partid_max_published) {
>> +		mpam_partid_max = min(mpam_partid_max, partid_max);
>> +		mpam_pmg_max = min(mpam_pmg_max, pmg_max);
>> +	} else {
>> +		/* New requestors can't lower the values */
>> +		if (partid_max < mpam_partid_max || pmg_max < mpam_pmg_max)
>> +			err = -EBUSY;
> 
> What will actually happen here?  Will the arch code reject the
> offending late secondary?

its not meant for the CPUs as these get registers way before anything else happpens.

This is for things like the SMMU or ITS, where if they probe too late, they need to be
told they can't use their MPAM features. See:
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?h=mpam/snapshot%2bextras/v6.17-rc2&id=41c768c1705d3fa0814bb1cb92c83280c872cb3e


> It feels a bit like we're reinventing part of cpufeatures here --

yes, but for system-ip, hence the new wheel.


> though I suppose the split between early and late CPUs is not the same
> as for the kernel proper: the "MPAM early CPUs" are those that have
> appeared by the time the last MSC probes, which can be a different
> set than the kernel's early CPUs.  So I guess there is no choice but
> to have some special logic here.

Late online-ing CPUs are cpufeature's problem to deal with, yes it has similar logic for
MPAMIDR_EL1.


>> +	}
>> +	spin_unlock(&partid_max_lock);
>> +
>> +	return err;
>> +}
>> +EXPORT_SYMBOL(mpam_register_requestor);
> 
> As noted above, dead function (in this series)?

Yes, its a chicken and egg problem. The caller was in the arm64 patches at the begining,
but got moved later, and then out of this series to reduce the number of trees this series
touches. Its too big to post the whole thing in one go, and however you break it up its
always possible the throw the whole lot away as being unusable until its all present. I'm
damned whatever I do here. I plan to post the arm64 patches as RFC along side the v2.


> Also, would it be better to split out the common core shared by this and
> the last stanza of mpam_msc_hw_probe()?
> 
> (This common core would make sense in this series even if
> mpam_register_requestor() is deferred.)

It's not common because of the extra flags that requestors need to pay attention to, which
can't happen by construction for the hardware probing. The he hardware probing version
can't fail. I'd like to keep the requestor logic separate - its maybe two lines in common.


>> @@ -539,10 +618,37 @@ int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
>>  	return err;
>>  }
>>  
>> +static struct mpam_msc_ris *mpam_get_or_create_ris(struct mpam_msc *msc,
>> +						   u8 ris_idx)
>> +{
>> +	int err;
>> +	struct mpam_msc_ris *ris, *found = ERR_PTR(-ENOENT);
>> +
>> +	lockdep_assert_held(&mpam_list_lock);
>> +
>> +	if (!test_bit(ris_idx, msc->ris_idxs)) {
> 
> I was a bit puzzled by this.
> 
> A comment somewhere might help: if ris_idx wasn't already seen while
> parsing firmware tables, then there is nothing to tell us what it
> controls in the hardware: mark it as MPAM_CLASS_UNKNOWN.
> 
> (If I understood correctly, that is.)

Spot on.

Taken your comment with some word order changes.


>> +		err = mpam_ris_create_locked(msc, ris_idx, MPAM_CLASS_UNKNOWN,
>> +					     0, 0, GFP_ATOMIC);
> 
> It's mildly unfortunate that these allocations are from the GFP_ATOMIC pool.
> I think we were in regular thread context until we started taking MPAM
> locks?
> 
> But it's a finite amount of memory and not under userspace control, so
> not a huge deal.
> 
> This could possibly be improved later; it doesn't feel critical right
> now.

I've fixed that up - its from when msc->lock was a spin lock that was taken for any
hardware access. Now that there is a separate probe_lock which is a mutex, all of these
can always sleep.


>> +		if (err)
>> +			return ERR_PTR(err);
>> +	}
>> +
>> +	list_for_each_entry(ris, &msc->ris, msc_list) {
>> +		if (ris->ris_idx == ris_idx) {
>> +			found = ris;
> 
> return ris; (?)
> 
> (You could then also delete all the curlies.)

I'll keep the outer ones as its easier to parse lines that expressions as you skim this.


>> +			break;
>> +		}
>> +	}
>> +
>> +	return found;
>> +}
>> +
>>  static int mpam_msc_hw_probe(struct mpam_msc *msc)
>>  {
>>  	u64 idr;
>> -	int err;
> 
> Churn?  (See patch 14.)

I'll try and come up with a version that doesn't do that,


>> +	u16 partid_max;
>> +	u8 ris_idx, pmg_max;
>> +	struct mpam_msc_ris *ris;
>>  
>>  	lockdep_assert_held(&msc->probe_lock);
>>  
>> @@ -551,14 +657,42 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>>  	if ((idr & MPAMF_AIDR_ARCH_MAJOR_REV) != MPAM_ARCHITECTURE_V1) {
>>  		pr_err_once("%s does not match MPAM architecture v1.x\n",
>>  			    dev_name(&msc->pdev->dev));
>> -		err = -EIO;
>> -	} else {
>> -		msc->probed = true;
>> -		err = 0;
>> +		mutex_unlock(&msc->part_sel_lock);
>> +		return -EIO;
>>  	}
>> +
>> +	idr = mpam_msc_read_idr(msc);
>>  	mutex_unlock(&msc->part_sel_lock);
>> +	msc->ris_max = FIELD_GET(MPAMF_IDR_RIS_MAX, idr);
>> +
>> +	/* Use these values so partid/pmg always starts with a valid value */
>> +	msc->partid_max = FIELD_GET(MPAMF_IDR_PARTID_MAX, idr);
>> +	msc->pmg_max = FIELD_GET(MPAMF_IDR_PMG_MAX, idr);
>> +
>> +	for (ris_idx = 0; ris_idx <= msc->ris_max; ris_idx++) {
>> +		mutex_lock(&msc->part_sel_lock);
>> +		__mpam_part_sel(ris_idx, 0, msc);
>> +		idr = mpam_msc_read_idr(msc);
>> +		mutex_unlock(&msc->part_sel_lock);
>> +
>> +		partid_max = FIELD_GET(MPAMF_IDR_PARTID_MAX, idr);
>> +		pmg_max = FIELD_GET(MPAMF_IDR_PMG_MAX, idr);
>> +		msc->partid_max = min(msc->partid_max, partid_max);
>> +		msc->pmg_max = min(msc->pmg_max, pmg_max);
>> +
>> +		ris = mpam_get_or_create_ris(msc, ris_idx);
>> +		if (IS_ERR(ris))
>> +			return PTR_ERR(ris);
>> +	}
>>  
>> -	return err;
>> +	spin_lock(&partid_max_lock);
> 
> Can we get in here with partid_max_init = false?

Today, yes - because the arch code has been ripped out to reduce the number of trees this
touches.


> Do we need to check /
> set it?  Or, maybe get rid of it; see mpam_partid_max etc.

Nope - it causes the 0 PARTID value to get consumed as a minimum (no special casing!),
meaning you get 0 PARTID 0 PMG reported after probing because there are no requestors.
Once a requestor shows up, the right thing happens.

This relies on the arch_initcall() running to register the CPUs before the driver probes.


>> +	mpam_partid_max = min(mpam_partid_max, msc->partid_max);
>> +	mpam_pmg_max = min(mpam_pmg_max, msc->pmg_max);
>> +	spin_unlock(&partid_max_lock);
>> +
>> +	msc->probed = true;
>> +
>> +	return 0;
>>  }

>> @@ -900,9 +1034,18 @@ static struct platform_driver mpam_msc_driver = {
>>  
>>  static void mpam_enable_once(void)
>>  {
>> +	/*
>> +	 * Once the cpuhp callbacks have been changed, mpam_partid_max can no
>> +	 * longer change.
>> +	 */
>> +	spin_lock(&partid_max_lock);
>> +	partid_max_published = true;
>> +	spin_unlock(&partid_max_lock);
>> +
>>  	mpam_register_cpuhp_callbacks(mpam_cpu_online, mpam_cpu_offline);
>>  
>> -	pr_info("MPAM enabled\n");
>> +	printk(KERN_INFO "MPAM enabled with %u partid and %u pmg\n",
>> +	       mpam_partid_max + 1, mpam_pmg_max + 1);
> 
> Nit: Since this is the main advertisement in dmesg that MPAM has been
> successfully probed, maybe use the formal architectural terms here,
> e.g.:
> 
> 	printk(KERN_INFO "MPAM enabled with %u PARTIDs and %u PMGs\n",
> 
> (Largely cosmetic, though.)

Done,


>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
>> index a98cca08a2ef..a623f405ddd8 100644
>> --- a/drivers/resctrl/mpam_internal.h
>> +++ b/drivers/resctrl/mpam_internal.h
>> @@ -50,6 +50,8 @@ struct mpam_msc {
>>  	 */
>>  	struct mutex		probe_lock;
>>  	bool			probed;
>> +	u16			partid_max;
>> +	u8			pmg_max;

> Are these actually used for anything?

There are a few things kept around to expose to debugfs to answer the question "why
doesn't this hardware do what I wanted". In this case - finding which MSC is causing
the PARTID/PMG values to be lower than expected.


> mpam_msc_hw_probe() already merges these into mpam_partid_max etc., so
> we just leave the hardware-reported values here -- which we can't ever
> use, for fear of triggering error interrupts.
> 
> (Keeping them would make it easier to migrate to merging these max
> values through the mpam_enable_merge_features() logic introduced in
> patch 18.  That's a possibly simplification, but it inessential to do
> that right now.


Thanks,

James

