Return-Path: <linux-acpi+bounces-17692-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B95BCA6BA
	for <lists+linux-acpi@lfdr.de>; Thu, 09 Oct 2025 19:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4EE188C740
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Oct 2025 17:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78DA244675;
	Thu,  9 Oct 2025 17:49:02 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6234223C4FF;
	Thu,  9 Oct 2025 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032142; cv=none; b=ipGOg0KxCPq2z7Ju/6tPFol0q5ex4HzsKkMwXO8X4knvDBzHHIDkGWtm5Oueb6oiBD78dGHktKhcbYCkIoGrCUREYdkpNXMx+lj+LSi6kKLgf1BP9y9gjtJnNSekqVhpTuOGFclOs9dVjAJPXMoW9fQs4hpyqhEvfQMGQ3lWhhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032142; c=relaxed/simple;
	bh=dH+aT9aM+KVE7aG910RjV/c+jzZF1VIjLTN+OgTyOZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tbLZCWQ2S7kakotM5ZkBbjc9S5vwRFcwK7tsG8+vqrM/DhvR19X6zmPS9aH7UP9N9VUY2W/0kdty+zuKwDRSebGwB17KlYaL+CHaPvII+U1L9pHaHNa4+f2mdHRkTzukRYHC03cYnaBKKVMKieoW5lyjUYDXt2/Q+S8Ks6VNMlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91C3B176A;
	Thu,  9 Oct 2025 10:48:51 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06D573F66E;
	Thu,  9 Oct 2025 10:48:48 -0700 (PDT)
Message-ID: <a96ad1f7-be96-4473-9a4a-1dac8c61c098@arm.com>
Date: Thu, 9 Oct 2025 18:48:45 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/29] arm_mpam: Add mpam_msmon_read() to read monitor
 value
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
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-24-james.morse@arm.com>
 <20250912142104.00006569@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250912142104.00006569@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 12/09/2025 14:21, Jonathan Cameron wrote:
> On Wed, 10 Sep 2025 20:43:03 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> Reading a monitor involves configuring what you want to monitor, and
>> reading the value. Components made up of multiple MSC may need values
>> from each MSC. MSCs may take time to configure, returning 'not ready'.
>> The maximum 'not ready' time should have been provided by firmware.
>>
>> Add mpam_msmon_read() to hide all this. If (one of) the MSC returns
>> not ready, then wait the full timeout value before trying again.
>>
>> CC: Shanker Donthineni <sdonthineni@nvidia.com>
>> Signed-off-by: James Morse <james.morse@arm.com>

>> +static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
>> +				     u32 flt_val)
>> +{
>> +	struct mpam_msc *msc = m->ris->vmsc->msc;
>> +
>> +	/*
>> +	 * Write the ctl_val with the enable bit cleared, reset the counter,
>> +	 * then enable counter.
>> +	 */
>> +	switch (m->type) {
>> +	case mpam_feat_msmon_csu:
>> +		mpam_write_monsel_reg(msc, CFG_CSU_FLT, flt_val);
>> +		mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val);
>> +		mpam_write_monsel_reg(msc, CSU, 0);
>> +		mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
>> +		break;
>> +	case mpam_feat_msmon_mbwu:
>> +		mpam_write_monsel_reg(msc, CFG_MBWU_FLT, flt_val);
>> +		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
>> +		mpam_write_monsel_reg(msc, MBWU, 0);
>> +		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
>> +		break;
> 
> Given nothing to do later, I'd just return at end of each case.
> Entirely up to you though as this is just a personal style preference.

Out of habit I try to avoid functions returning from different places, as it makes it
harder to add locking later. Maybe the fancy cleanup c++ thing changes that.


>> +	default:
>> +		return;

But I'm clearly inconsistent!
I've changes this as you suggest.


>> +	}
>> +}
> 
>> +
>> +static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
>> +{
>> +	int err, idx;
>> +	struct mpam_msc *msc;
>> +	struct mpam_vmsc *vmsc;
>> +	struct mpam_msc_ris *ris;
>> +
>> +	idx = srcu_read_lock(&mpam_srcu);
> 
> 	guard(srcu)(&mpam_srcu);
> 
> Then you can do direct returns on errors which looks like it will simplify
> things somewhat by letting you just return on err.
> 
> 
>> +	list_for_each_entry_rcu(vmsc, &comp->vmsc, comp_list) {
>> +		msc = vmsc->msc;
> I'd bring the declaration down here as well.
> 		struct mpam_msc *msc = vmsc->msc;
> Could bring ris down here as well.
> 
>> +
>> +		list_for_each_entry_rcu(ris, &vmsc->ris, vmsc_list) {
>> +			arg->ris = ris;
>> +
>> +			err = smp_call_function_any(&msc->accessibility,
>> +						    __ris_msmon_read, arg,
>> +						    true);
>> +			if (!err && arg->err)
>> +				err = arg->err;
>> +			if (err)
>> +				break;
>> +		}
>> +		if (err)
>> +			break;
> 
> This won't be needed if you returned on error above.
> 
>> +	}
>> +	srcu_read_unlock(&mpam_srcu, idx);
>> +
>> +	return err;

> And you only reach here with above changes if err == 0 so return 0; appropriate.

I've done all of the above.
(I'd even already worked it out from your earlier feedback)



>> +}
>> +
>> +int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
>> +		    enum mpam_device_features type, u64 *val)
>> +{
>> +	int err;
>> +	struct mon_read arg;
>> +	u64 wait_jiffies = 0;
>> +	struct mpam_props *cprops = &comp->class->props;
>> +
>> +	might_sleep();
>> +
>> +	if (!mpam_is_enabled())
>> +		return -EIO;
>> +
>> +	if (!mpam_has_feature(type, cprops))
>> +		return -EOPNOTSUPP;
>> +
>> +	memset(&arg, 0, sizeof(arg));

> Either use = { }; at declaration or maybe
> 	arg = (struct mon_read) {
> 		.ctx = ctx,
> 		.type = type,
> 		.val = val,
> 	};
> 
> rather than bothering with separate memset.

The memset is because arg gets re-used, but there are fields not touched here that get
modified, like 'err'. But this struct assignment works too...


>> +	arg.ctx = ctx;
>> +	arg.type = type;
>> +	arg.val = val;
>> +	*val = 0;
>> +
>> +	err = _msmon_read(comp, &arg);
>> +	if (err == -EBUSY && comp->class->nrdy_usec)
>> +		wait_jiffies = usecs_to_jiffies(comp->class->nrdy_usec);
>> +
>> +	while (wait_jiffies)
>> +		wait_jiffies = schedule_timeout_uninterruptible(wait_jiffies);
>> +
>> +	if (err == -EBUSY) {
>> +		memset(&arg, 0, sizeof(arg));

> Same as above. 

Yup - its like this so that they look the same.


>> +		arg.ctx = ctx;
>> +		arg.type = type;
>> +		arg.val = val;
>> +		*val = 0;
>> +
>> +		err = _msmon_read(comp, &arg);
>> +	}
>> +
>> +	return err;
>> +}
> 


Thanks,

James

