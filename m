Return-Path: <linux-acpi+bounces-16551-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BF1B503C7
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 19:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8801C802A6
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 17:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D592369331;
	Tue,  9 Sep 2025 16:58:34 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6428368081;
	Tue,  9 Sep 2025 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437114; cv=none; b=tRSfpcqwQyabXPvK2DDOI5u8ViZoHBF6nI3k77WeHGnLTqucW24h4MP99BBDX84dmi8fgui3Wt2rUp7uukze+x+VJX4VwInO32uPrddlAq8d8mwgkPKaWYF9UJT7qul2rlDk/2fEjsqzUomLo37uCfSqbFd+XfdJ9FsYPr3cnlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437114; c=relaxed/simple;
	bh=IqljfTNr5/AjfJedD9vYce/uXEQHCRJ0qupJ1vCHB+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RpOLNdXLxLgosHzpBvUQbwiT6rnI50wl/R544Vh2H0fkab7llqsNlk0kft7GLXBLfB8jomJC/LaNCISD7GyNcEM9a9VcsS6W7eYzImsMuasydZKHUX2q4i7HZ6LxX9J+bQxHBofx1ZzTb8zbG6j/wAu12eOTs4k1llzqHXejSA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A50C915A1;
	Tue,  9 Sep 2025 09:58:23 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67EE63F694;
	Tue,  9 Sep 2025 09:58:21 -0700 (PDT)
Message-ID: <6844fbe7-5b23-431d-879f-ec03ad78b190@arm.com>
Date: Tue, 9 Sep 2025 17:58:19 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/33] arm_mpam: Register and enable IRQs
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
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
 Danilo Krummrich <dakr@kernel.org>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-23-james.morse@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250822153048.2287-23-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James, (:p)

On 22/08/2025 16:30, James Morse wrote:
> Register and enable error IRQs. All the MPAM error interrupts indicate a
> software bug, e.g. out of range partid. If the error interrupt is ever
> signalled, attempt to disable MPAM.
> 
> Only the irq handler accesses the ESR register, so no locking is needed.
> The work to disable MPAM after an error needs to happen at process
> context, use a threaded interrupt.
> 
> There is no support for percpu threaded interrupts, for now schedule
> the work to be done from the irq handler.
> 
> Enabling the IRQs in the MSC may involve cross calling to a CPU that
> can access the MSC.
> 
> Once the IRQ is requested, the mpam_disable() path can be called
> asynchronously, which will walk structures sized by max_partid. Ensure
> this size is fixed before the interrupt is requested.

> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 3516cbe8623e..210d64fad0b1 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c

> @@ -1547,11 +1640,171 @@ static void mpam_enable_merge_features(struct list_head *all_classes_list)

> +static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
> +{
> +	u64 reg;
> +	u16 partid;
> +	u8 errcode, pmg, ris;
> +
> +	if (WARN_ON_ONCE(!msc) ||
> +	    WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(),
> +					   &msc->accessibility)))
> +		return IRQ_NONE;
> +
> +	reg = mpam_msc_read_esr(msc);
> +
> +	errcode = FIELD_GET(MPAMF_ESR_ERRCODE, reg);
> +	if (!errcode)
> +		return IRQ_NONE;
> +
> +	/* Clear level triggered irq */
> +	mpam_msc_zero_esr(msc);
> +
> +	partid = FIELD_GET(MPAMF_ESR_PARTID_MON, reg);
> +	pmg = FIELD_GET(MPAMF_ESR_PMG, reg);
> +	ris = FIELD_GET(MPAMF_ESR_RIS, reg);
> +
> +	pr_err("error irq from msc:%u '%s', partid:%u, pmg: %u, ris: %u\n",
> +	       msc->id, mpam_errcode_names[errcode], partid, pmg, ris);
> +
> +	if (irq_is_percpu(irq)) {
> +		mpam_disable_msc_ecr(msc);
> +		schedule_work(&mpam_broken_work);
> +		return IRQ_HANDLED;
> +	}
> +
> +	return IRQ_WAKE_THREAD;
> +}

> +static void mpam_unregister_irqs(void)
> +{
> +	int irq, idx;
> +	struct mpam_msc *msc;
> +
> +	cpus_read_lock();
> +	/* take the lock as free_irq() can sleep */
> +	idx = srcu_read_lock(&mpam_srcu);
> +	list_for_each_entry_srcu(msc, &mpam_all_msc, glbl_list, srcu_read_lock_held(&mpam_srcu)) {
> +		irq = platform_get_irq_byname_optional(msc->pdev, "error");
> +		if (irq <= 0)
> +			continue;
> +
> +		if (msc->error_irq_hw_enabled) {
> +			mpam_touch_msc(msc, mpam_disable_msc_ecr, msc);
> +			msc->error_irq_hw_enabled = false;
> +		}
> +
> +		if (msc->error_irq_requested) {
> +			if (irq_is_percpu(irq)) {
> +				msc->reenable_error_ppi = 0;
> +				free_percpu_irq(irq, msc->error_dev_id);
> +			} else {
> +				devm_free_irq(&msc->pdev->dev, irq, msc);
> +			}
> +			msc->error_irq_requested = false;
> +		}
> +	}
> +	srcu_read_unlock(&mpam_srcu, idx);
> +	cpus_read_unlock();
> +}


> @@ -1615,16 +1889,39 @@ static void mpam_reset_class(struct mpam_class *class)
>   * All of MPAMs errors indicate a software bug, restore any modified
>   * controls to their reset values.
>   */
> -void mpam_disable(void)
> +static irqreturn_t mpam_disable_thread(int irq, void *dev_id)
>  {
>  	int idx;
>  	struct mpam_class *class;
> +	struct mpam_msc *msc, *tmp;
> +
> +	mutex_lock(&mpam_cpuhp_state_lock);
> +	if (mpam_cpuhp_state) {
> +		cpuhp_remove_state(mpam_cpuhp_state);
> +		mpam_cpuhp_state = 0;
> +	}
> +	mutex_unlock(&mpam_cpuhp_state_lock);


> +	mpam_unregister_irqs();

When out-of-range PARTID get used, all the MSC go off at once - which means the interrupts
can be delivered to multiple CPUs at the same time. This unregister call is outside any
lock, and the msc->error_irq_* flags aren't atomic - leading to hilarity as this races
with itself.

Also turns out you can't devm_free_irq() from a threaded irq as it blocks forever in
syncrhonise_irq().

Naturally I didn't hit either of these issues when scheduling the thread from debugfs.

I've made the flags atomic, and thrown the threaded-irq away - instead the work always
gets scheduled.


Thanks,

James

>  	idx = srcu_read_lock(&mpam_srcu);
>  	list_for_each_entry_srcu(class, &mpam_classes, classes_list,
>  				 srcu_read_lock_held(&mpam_srcu))
>  		mpam_reset_class(class);
>  	srcu_read_unlock(&mpam_srcu, idx);
> +
> +	mutex_lock(&mpam_list_lock);
> +	list_for_each_entry_safe(msc, tmp, &mpam_all_msc, glbl_list)
> +		mpam_msc_destroy(msc);
> +	mutex_unlock(&mpam_list_lock);
> +	mpam_free_garbage();
> +
> +	return IRQ_HANDLED;
> +}
/*error_irq_requested

