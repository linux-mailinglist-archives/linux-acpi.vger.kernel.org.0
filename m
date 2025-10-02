Return-Path: <linux-acpi+bounces-17510-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35631BB4CC5
	for <lists+linux-acpi@lfdr.de>; Thu, 02 Oct 2025 20:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A93E323DEE
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Oct 2025 18:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDAD275871;
	Thu,  2 Oct 2025 18:03:07 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DC5274658;
	Thu,  2 Oct 2025 18:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759428187; cv=none; b=hl1JfKF/emoI4kOhG1OC2+Cw1P8MYvR+oRHYwTH/wfFZr0qomzKi6K8e6xsVbu+jY6CzFL1UdiobEt8nXH1w8UhmJnQl1QetfMUSoG8s5KLHValtQKT1nD8EsVbn2qjVLBEv6rl0KDYFZuJR9mD1tiHr2ecJ8n/83wEjAbah0nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759428187; c=relaxed/simple;
	bh=L54zV7q/sZsrrJ9GCt0k13h+4mjw6GuQZZpN2kyTZs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P20R+v1Vddw/Gth8BaUFoHM0Pkb2g+omjnzZFTgrqaZXXheClH98uZ8fpTOwggQrF7ElNwwCnkDJymuteimLg5LlR673xHuXosFSHwuTiY2t8Emp9Pc3ZIDFgFli2vkZECJEJ1yAIVL1tGu/LXGV9NnIFaKyE0de4VoahMdPgro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9671A1CE0;
	Thu,  2 Oct 2025 11:02:57 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF3863F66E;
	Thu,  2 Oct 2025 11:03:00 -0700 (PDT)
Message-ID: <9d21e5ca-5f35-44de-a11e-194f34dd8ff2@arm.com>
Date: Thu, 2 Oct 2025 19:02:59 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/29] arm_mpam: Register and enable IRQs
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
 <20250910204309.20751-19-james.morse@arm.com>
 <20250912131219.00000938@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250912131219.00000938@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 12/09/2025 13:12, Jonathan Cameron wrote:
> On Wed, 10 Sep 2025 20:42:58 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> Register and enable error IRQs. All the MPAM error interrupts indicate a
>> software bug, e.g. out of range partid. If the error interrupt is ever
>> signalled, attempt to disable MPAM.
>>
>> Only the irq handler accesses the ESR register, so no locking is needed.
>> The work to disable MPAM after an error needs to happen at process
>> context as it takes mutex. It also unregisters the interrupts, meaning
>> it can't be done from the threaded part of a threaded interrupt.
>> Instead, mpam_disable() gets scheduled.
>>
>> Enabling the IRQs in the MSC may involve cross calling to a CPU that
>> can access the MSC.
>>
>> Once the IRQ is requested, the mpam_disable() path can be called
>> asynchronously, which will walk structures sized by max_partid. Ensure
>> this size is fixed before the interrupt is requested.

>> @@ -1318,11 +1405,172 @@ static void mpam_enable_merge_features(struct list_head *all_classes_list)
>>  	}
>>  }
>>  
>> +static char *mpam_errcode_names[16] = {
>> +	[0] = "No error",
> 
> I think you had a bunch of defines for these in an earlier patch.  Can we use
> that to index here instead of [0] etc. 

Sure,


>> +	[1] = "PARTID_SEL_Range",
>> +	[2] = "Req_PARTID_Range",
>> +	[3] = "MSMONCFG_ID_RANGE",
>> +	[4] = "Req_PMG_Range",
>> +	[5] = "Monitor_Range",
>> +	[6] = "intPARTID_Range",
>> +	[7] = "Unexpected_INTERNAL",
>> +	[8] = "Undefined_RIS_PART_SEL",
>> +	[9] = "RIS_No_Control",
>> +	[10] = "Undefined_RIS_MON_SEL",
>> +	[11] = "RIS_No_Monitor",
>> +	[12 ... 15] = "Reserved"
>> +};
> 
> 
>> +static void mpam_unregister_irqs(void)
>> +{
>> +	int irq, idx;
>> +	struct mpam_msc *msc;
>> +
>> +	cpus_read_lock();
> 
> 	guard(cpus_read_lock)();
> 	guard(srcu)(&mpam_srcu);

Sure, looks like I didn't realise there was a cpus_read_lock version of this when I went
looking for places to add this.


>> +	/* take the lock as free_irq() can sleep */

The comment gets dropped as this mattered for an earlier locking scheme. (but free_irq()
can still sleep)


>> +	idx = srcu_read_lock(&mpam_srcu);
>> +	list_for_each_entry_srcu(msc, &mpam_all_msc, all_msc_list,
>> +				 srcu_read_lock_held(&mpam_srcu)) {
>> +		irq = platform_get_irq_byname_optional(msc->pdev, "error");
>> +		if (irq <= 0)
>> +			continue;
>> +
>> +		if (test_and_clear_bit(MPAM_ERROR_IRQ_HW_ENABLED, &msc->error_irq_flags))
>> +			mpam_touch_msc(msc, mpam_disable_msc_ecr, msc);
>> +
>> +		if (test_and_clear_bit(MPAM_ERROR_IRQ_REQUESTED, &msc->error_irq_flags)) {
>> +			if (irq_is_percpu(irq)) {
>> +				msc->reenable_error_ppi = 0;
>> +				free_percpu_irq(irq, msc->error_dev_id);
>> +			} else {
>> +				devm_free_irq(&msc->pdev->dev, irq, msc);
>> +			}
>> +		}
>> +	}
>> +	srcu_read_unlock(&mpam_srcu, idx);
>> +	cpus_read_unlock();
>> +}

>> @@ -1332,6 +1580,27 @@ static void mpam_enable_once(void)
>>  	partid_max_published = true;
>>  	spin_unlock(&partid_max_lock);
>>  
>> +	/*
>> +	 * If all the MSC have been probed, enabling the IRQs happens next.
>> +	 * That involves cross-calling to a CPU that can reach the MSC, and
>> +	 * the locks must be taken in this order:
>> +	 */
>> +	cpus_read_lock();
>> +	mutex_lock(&mpam_list_lock);
>> +	mpam_enable_merge_features(&mpam_classes);
>> +
>> +	err = mpam_register_irqs();
>> +	if (err)
>> +		pr_warn("Failed to register irqs: %d\n", err);
> 
> Perhaps move the print into the if (err) below?

More types of error get later, and its maybe useful to know which of these failed.


>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
>> index 6e047fbd3512..f04a9ef189cf 100644
>> --- a/drivers/resctrl/mpam_internal.h
>> +++ b/drivers/resctrl/mpam_internal.h
>> @@ -32,6 +32,10 @@ struct mpam_garbage {
>>  	struct platform_device	*pdev;
>>  };
>>  
>> +/* Bit positions for error_irq_flags */
>> +#define	MPAM_ERROR_IRQ_REQUESTED  0
>> +#define	MPAM_ERROR_IRQ_HW_ENABLED 1
> 
> If there aren't going to be load more of these (I've not really thought
> about whether there might) then using a bitmap for these seems to add complexity
> that we wouldn't see with 
> bool error_irq_req;
> bool error_irq_hw_enabled;

It's a bitmap so that mpam_unregister_irqs() can use test_and_clear_bit() on them,
because with a real interrupt mpam_unregister_irqs() can run multiple times in parallel
with itself.
Doing this as bools would mean having a mutex to prevent that from happening.

I'll do that as its a slightly simpler.


Thanks,

James

