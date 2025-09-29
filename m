Return-Path: <linux-acpi+bounces-17423-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606DEBAA353
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 19:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2198F3C57C0
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 17:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC30B22157E;
	Mon, 29 Sep 2025 17:44:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C83220F2C;
	Mon, 29 Sep 2025 17:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759167875; cv=none; b=qwUKW5NWBa/Co1s2T9hl4FVsXN3bABCkryDsukcUX2JRXvQ2SkrgwVESawB9chdTqc/h81ZQpMovtocpB8/KAa0Zt8flFf1eyL4wKh3Okkrqwu+H1xdLTaRBbVHfSPubahkJvYn11zToiJx1weYJC4KmoolUvK3zs5FHCcvr7wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759167875; c=relaxed/simple;
	bh=bd7QHrtsx8kCGIVX1wp5kMD747210eQWt5uNgI8KWeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pAFHyjEXF1USqrkPIyfOiC9nqFkjWtoUowwqlI3Y+gwRdETlIXxgIHlAz8VqczBo3+eFtU6Xdcxu40lb5Vc8s0KWQCVCFGLkM4dhpuOfTEg8nhblgV41uxQ3l1mTd7ZSdfT8ELrrou0fdnbMYczqAio8WxFNGUMzN+4Mnb+fYZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C286150C;
	Mon, 29 Sep 2025 10:44:23 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2F473F59E;
	Mon, 29 Sep 2025 10:44:25 -0700 (PDT)
Message-ID: <31c1cea8-8265-4d86-b9a7-d8f8955405bf@arm.com>
Date: Mon, 29 Sep 2025 18:44:25 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/29] arm_mpam: Add cpuhp callbacks to probe MSC
 hardware
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
 Danilo Krummrich <dakr@kernel.org>, Lecopzer Chen <lecopzerc@nvidia.com>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-11-james.morse@arm.com>
 <20250911160737.0000492f@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250911160737.0000492f@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 11/09/2025 16:07, Jonathan Cameron wrote:
> On Wed, 10 Sep 2025 20:42:50 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> Because an MSC can only by accessed from the CPUs in its cpu-affinity
>> set we need to be running on one of those CPUs to probe the MSC
>> hardware.
>>
>> Do this work in the cpuhp callback. Probing the hardware will only
>> happen before MPAM is enabled, walk all the MSCs and probe those we can
>> reach that haven't already been probed as each CPU's online call is made.
>>
>> This adds the low-level MSC register accessors.
>>
>> Once all MSCs reported by the firmware have been probed from a CPU in
>> their respective cpu-affinity set, the probe-time cpuhp callbacks are
>> replaced.  The replacement callbacks will ultimately need to handle
>> save/restore of the runtime MSC state across power transitions, but for
>> now there is nothing to do in them: so do nothing.
>>
>> The architecture's context switch code will be enabled by a static-key,
>> this can be set by mpam_enable(), but must be done from process context,
>> not a cpuhp callback because both take the cpuhp lock.
>> Whenever a new MSC has been probed, the mpam_enable() work is scheduled
>> to test if all the MSCs have been probed. If probing fails, mpam_disable()
>> is scheduled to unregister the cpuhp callbacks and free memory.

> Trivial suggestion inline. Either way
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks!


>> +/* Before mpam is enabled, try to probe new MSC */
>> +static int mpam_discovery_cpu_online(unsigned int cpu)
>> +{
>> +	int err = 0;
>> +	struct mpam_msc *msc;
>> +	bool new_device_probed = false;
>> +
>> +	guard(srcu)(&mpam_srcu);
>> +	list_for_each_entry_srcu(msc, &mpam_all_msc, all_msc_list,
>> +				 srcu_read_lock_held(&mpam_srcu)) {
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
>> +			break;

> Unless this going to get more complex why not
> 
> 		if (err)
> 			break;
> 
> 		new_device_probed = true;

Sure - its been both simpler and more complex in the past!


>> +	}
>> +
>> +	if (new_device_probed && !err)
>> +		schedule_work(&mpam_enable_work);
>> +	if (err) {
>> +		mpam_disable_reason = "error during probing";
>> +		schedule_work(&mpam_broken_work);
>> +	}
>> +
>> +	return err;
>> +}
> 
>> +static void mpam_enable_once(void)
>> +{
>> +	mpam_register_cpuhp_callbacks(mpam_cpu_online, mpam_cpu_offline);
>> +
>> +	pr_info("MPAM enabled\n");

> Feels too noisy given it should be easy enough to tell. pr_dbg() perhaps.

I was aiming for the driver to only print one thing - once all the hardware has been
probed. Once the driver is assembled, this prints the number of PARTID/PMG that were
discovered as the system wide limits.

The reason to print something is that if you see this message, but don't have resctrl
appear in /proc/filesystems - its never going to appear because the resctrl glue code
couldn't find anything it could use. As this isn't an error, so nothing gets printed in
this case.
This is the most common complaint I get - "our platform doesn't look like a Xeon - why
doesn't resctrl work with it?"

It also matters for other requesters, like the SMMU. If they probe after this point, they
can't reduce the PARTID/PMG range - and may get an error and have their MPAM abilities
disabled. Having an entry in the boot log makes this easier to debug.


The alternative would be to keep track of what the driver is up to, and expose that
through debugfs - but information that only exists for debug purposes is likely to be
wrong. It also doesn't help work out what order different drivers tried to probe in.


Thanks,

James

