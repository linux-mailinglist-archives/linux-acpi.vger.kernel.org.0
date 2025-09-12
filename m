Return-Path: <linux-acpi+bounces-16735-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46180B551F7
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 16:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F5F1A03717
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 14:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7FC30EF65;
	Fri, 12 Sep 2025 14:40:52 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061F53101BF;
	Fri, 12 Sep 2025 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688052; cv=none; b=WdIAQ/vTwAnKNiyf7/z5v4RE2NmmJ2OoPs4k/5Ej5Z8qMWgwAMg7WQz5M3yrXqhvAtDbJwfubaB5V+/D4/QXtk/VdNJEQfz0H5S3ZnX5PsDD+meWhSJ7DnNjft6mx5RjNralQFiVuLG15MC5aEmwAAPfe1iY6ioiETV9eVjhnU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688052; c=relaxed/simple;
	bh=I4eox496C7TyAM2nK02Fq1X3ENvtNmXcNg9fnjHEYvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gsO2uIUcLudGvcovMWjpfcTa47tbuJvUh54/7TLLmMDXEEy+nCFkKHOq8qUAf850Tpna0nnSPYOl0vAs8tm6QQ7Ykqp3iPRp1h1EbMJtUYtaQH9VDddXPqU6cFi/f/X3mjEOVOGZ3I+4RQVodreAyob7GUz5is/U+vuKWIKHyBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E357716A3;
	Fri, 12 Sep 2025 07:40:39 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6CDF3F66E;
	Fri, 12 Sep 2025 07:40:42 -0700 (PDT)
Message-ID: <487a736c-27c8-427c-97d5-31fd2d97e919@arm.com>
Date: Fri, 12 Sep 2025 15:40:41 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/29] arm_mpam: Register and enable IRQs
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-19-james.morse@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20250910204309.20751-19-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 9/10/25 21:42, James Morse wrote:
> Register and enable error IRQs. All the MPAM error interrupts indicate a
> software bug, e.g. out of range partid. If the error interrupt is ever
> signalled, attempt to disable MPAM.
> 
> Only the irq handler accesses the ESR register, so no locking is needed.
> The work to disable MPAM after an error needs to happen at process
> context as it takes mutex. It also unregisters the interrupts, meaning
> it can't be done from the threaded part of a threaded interrupt.
> Instead, mpam_disable() gets scheduled.
> 
> Enabling the IRQs in the MSC may involve cross calling to a CPU that
> can access the MSC.
> 
> Once the IRQ is requested, the mpam_disable() path can be called
> asynchronously, which will walk structures sized by max_partid. Ensure
> this size is fixed before the interrupt is requested.
> 
> CC: Rohit Mathew <rohit.mathew@arm.com>
> Tested-by: Rohit Mathew <rohit.mathew@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>  * Made mpam_unregister_irqs() safe to race with itself.
>  * Removed threaded interrupts.
>  * Schedule mpam_disable() from cpuhp callback in the case of an error.
>  * Added mpam_disable_reason.
>  * Use alloc_percpu()
> 
> Changes since RFC:
>  * Use guard marco when walking srcu list.
>  * Use INTEN macro for enabling interrupts.
>  * Move partid_max_published up earlier in mpam_enable_once().
> ---
>  drivers/resctrl/mpam_devices.c  | 277 +++++++++++++++++++++++++++++++-
>  drivers/resctrl/mpam_internal.h |  10 ++
>  2 files changed, 284 insertions(+), 3 deletions(-)
> 

>  
> +static int __setup_ppi(struct mpam_msc *msc)
> +{
> +	int cpu;
> +	struct device *dev = &msc->pdev->dev;
> +
> +	msc->error_dev_id = alloc_percpu(struct mpam_msc *);
> +	if (!msc->error_dev_id)
> +		return -ENOMEM;
> +
> +	for_each_cpu(cpu, &msc->accessibility) {
> +		struct mpam_msc *empty = *per_cpu_ptr(msc->error_dev_id, cpu);
> +
> +		if (empty) {

I'm confused about how this if conditioned can be satisfied. Isn't the
alloc clearing msc->error_dev_id for each cpu and then it's only getting
set for each cpu later in the iteration.

> +			dev_err_once(dev, "MSC shares PPI with %s!\n",
> +				     dev_name(&empty->pdev->dev));
> +			return -EBUSY;
> +		}
> +		*per_cpu_ptr(msc->error_dev_id, cpu) = msc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mpam_msc_setup_error_irq(struct mpam_msc *msc)
> +{
> +	int irq;
> +
> +	irq = platform_get_irq_byname_optional(msc->pdev, "error");
> +	if (irq <= 0)
> +		return 0;
> +
> +	/* Allocate and initialise the percpu device pointer for PPI */
> +	if (irq_is_percpu(irq))
> +		return __setup_ppi(msc);
> +
> +	/* sanity check: shared interrupts can be routed anywhere? */
> +	if (!cpumask_equal(&msc->accessibility, cpu_possible_mask)) {
> +		pr_err_once("msc:%u is a private resource with a shared error interrupt",
> +			    msc->id);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * An MSC can control traffic from a set of CPUs, but may only be accessible
>   * from a (hopefully wider) set of CPUs. The common reason for this is power
> @@ -1060,6 +1143,10 @@ static int mpam_msc_drv_probe(struct platform_device *pdev)
>  			break;
>  		}
>  
> +		err = mpam_msc_setup_error_irq(msc);
> +		if (err)
> +			break;
> +
>  		if (device_property_read_u32(&pdev->dev, "pcc-channel",
>  					     &msc->pcc_subspace_id))
>  			msc->iface = MPAM_IFACE_MMIO;
> @@ -1318,11 +1405,172 @@ static void mpam_enable_merge_features(struct list_head *all_classes_list)
>  	}
>  }
>  
> +static char *mpam_errcode_names[16] = {
> +	[0] = "No error",
> +	[1] = "PARTID_SEL_Range",
> +	[2] = "Req_PARTID_Range",
> +	[3] = "MSMONCFG_ID_RANGE",
> +	[4] = "Req_PMG_Range",
> +	[5] = "Monitor_Range",
> +	[6] = "intPARTID_Range",
> +	[7] = "Unexpected_INTERNAL",
> +	[8] = "Undefined_RIS_PART_SEL",
> +	[9] = "RIS_No_Control",
> +	[10] = "Undefined_RIS_MON_SEL",
> +	[11] = "RIS_No_Monitor",
> +	[12 ... 15] = "Reserved"
> +};
> +
> +static int mpam_enable_msc_ecr(void *_msc)
> +{
> +	struct mpam_msc *msc = _msc;
> +
> +	__mpam_write_reg(msc, MPAMF_ECR, MPAMF_ECR_INTEN);
> +
> +	return 0;
> +}
> +
> +/* This can run in mpam_disable(), and the interrupt handler on the same CPU */
> +static int mpam_disable_msc_ecr(void *_msc)
> +{
> +	struct mpam_msc *msc = _msc;
> +
> +	__mpam_write_reg(msc, MPAMF_ECR, 0);
> +
> +	return 0;
> +}
> +
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
> +	pr_err_ratelimited("error irq from msc:%u '%s', partid:%u, pmg: %u, ris: %u\n",
> +			   msc->id, mpam_errcode_names[errcode], partid, pmg,
> +			   ris);
> +
> +	/* Disable this interrupt. */
> +	mpam_disable_msc_ecr(msc);
> +
> +	/*
> +	 * Schedule the teardown work. Don't use a threaded IRQ as we can't
> +	 * unregister the interrupt from the threaded part of the handler.
> +	 */
> +	mpam_disable_reason = "hardware error interrupt";
> +	schedule_work(&mpam_broken_work);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t mpam_ppi_handler(int irq, void *dev_id)
> +{
> +	struct mpam_msc *msc = *(struct mpam_msc **)dev_id;
> +
> +	return __mpam_irq_handler(irq, msc);
> +}
> +
> +static irqreturn_t mpam_spi_handler(int irq, void *dev_id)
> +{
> +	struct mpam_msc *msc = dev_id;
> +
> +	return __mpam_irq_handler(irq, msc);
> +}
> +
> +static int mpam_register_irqs(void)
> +{
> +	int err, irq;
> +	struct mpam_msc *msc;
> +
> +	lockdep_assert_cpus_held();
> +
> +	guard(srcu)(&mpam_srcu);
> +	list_for_each_entry_srcu(msc, &mpam_all_msc, all_msc_list,
> +				 srcu_read_lock_held(&mpam_srcu)) {
> +		irq = platform_get_irq_byname_optional(msc->pdev, "error");
> +		if (irq <= 0)
> +			continue;
> +
> +		/* The MPAM spec says the interrupt can be SPI, PPI or LPI */
> +		/* We anticipate sharing the interrupt with other MSCs */
> +		if (irq_is_percpu(irq)) {
> +			err = request_percpu_irq(irq, &mpam_ppi_handler,
> +						 "mpam:msc:error",
> +						 msc->error_dev_id);
> +			if (err)
> +				return err;
> +
> +			msc->reenable_error_ppi = irq;
> +			smp_call_function_many(&msc->accessibility,
> +					       &_enable_percpu_irq, &irq,
> +					       true);
> +		} else {
> +			err = devm_request_irq(&msc->pdev->dev,irq,
> +					       &mpam_spi_handler, IRQF_SHARED,
> +					       "mpam:msc:error", msc);
> +			if (err)
> +				return err;
> +		}
> +
> +		set_bit(MPAM_ERROR_IRQ_REQUESTED, &msc->error_irq_flags);
> +		mpam_touch_msc(msc, mpam_enable_msc_ecr, msc);
> +		set_bit(MPAM_ERROR_IRQ_HW_ENABLED, &msc->error_irq_flags);
> +	}
> +
> +	return 0;
> +}
> +
> +static void mpam_unregister_irqs(void)
> +{
> +	int irq, idx;
> +	struct mpam_msc *msc;
> +
> +	cpus_read_lock();
> +	/* take the lock as free_irq() can sleep */
> +	idx = srcu_read_lock(&mpam_srcu);
> +	list_for_each_entry_srcu(msc, &mpam_all_msc, all_msc_list,
> +				 srcu_read_lock_held(&mpam_srcu)) {
> +		irq = platform_get_irq_byname_optional(msc->pdev, "error");
> +		if (irq <= 0)
> +			continue;
> +
> +		if (test_and_clear_bit(MPAM_ERROR_IRQ_HW_ENABLED, &msc->error_irq_flags))
> +			mpam_touch_msc(msc, mpam_disable_msc_ecr, msc);
> +
> +		if (test_and_clear_bit(MPAM_ERROR_IRQ_REQUESTED, &msc->error_irq_flags)) {
> +			if (irq_is_percpu(irq)) {
> +				msc->reenable_error_ppi = 0;
> +				free_percpu_irq(irq, msc->error_dev_id);
> +			} else {
> +				devm_free_irq(&msc->pdev->dev, irq, msc);
> +			}
> +		}
> +	}
> +	srcu_read_unlock(&mpam_srcu, idx);
> +	cpus_read_unlock();
> +}
> +
>  static void mpam_enable_once(void)
>  {
> -	mutex_lock(&mpam_list_lock);
> -	mpam_enable_merge_features(&mpam_classes);
> -	mutex_unlock(&mpam_list_lock);
> +	int err;
>  
>  	/*
>  	 * Once the cpuhp callbacks have been changed, mpam_partid_max can no
> @@ -1332,6 +1580,27 @@ static void mpam_enable_once(void)
>  	partid_max_published = true;
>  	spin_unlock(&partid_max_lock);
>  
> +	/*
> +	 * If all the MSC have been probed, enabling the IRQs happens next.
> +	 * That involves cross-calling to a CPU that can reach the MSC, and
> +	 * the locks must be taken in this order:
> +	 */
> +	cpus_read_lock();
> +	mutex_lock(&mpam_list_lock);
> +	mpam_enable_merge_features(&mpam_classes);
> +
> +	err = mpam_register_irqs();
> +	if (err)
> +		pr_warn("Failed to register irqs: %d\n", err);
> +
> +	mutex_unlock(&mpam_list_lock);
> +	cpus_read_unlock();
> +
> +	if (err) {
> +		schedule_work(&mpam_broken_work);
> +		return;
> +	}
> +
>  	mpam_register_cpuhp_callbacks(mpam_cpu_online, mpam_cpu_offline);
>  
>  	printk(KERN_INFO "MPAM enabled with %u PARTIDs and %u PMGs\n",
> @@ -1397,6 +1666,8 @@ void mpam_disable(struct work_struct *ignored)
>  	}
>  	mutex_unlock(&mpam_cpuhp_state_lock);
>  
> +	mpam_unregister_irqs();
> +
>  	idx = srcu_read_lock(&mpam_srcu);
>  	list_for_each_entry_srcu(class, &mpam_classes, classes_list,
>  				 srcu_read_lock_held(&mpam_srcu))
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 6e047fbd3512..f04a9ef189cf 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -32,6 +32,10 @@ struct mpam_garbage {
>  	struct platform_device	*pdev;
>  };
>  
> +/* Bit positions for error_irq_flags */
> +#define	MPAM_ERROR_IRQ_REQUESTED  0
> +#define	MPAM_ERROR_IRQ_HW_ENABLED 1
> +
>  struct mpam_msc {
>  	/* member of mpam_all_msc */
>  	struct list_head        all_msc_list;
> @@ -46,6 +50,11 @@ struct mpam_msc {
>  	struct pcc_mbox_chan	*pcc_chan;
>  	u32			nrdy_usec;
>  	cpumask_t		accessibility;
> +	bool			has_extd_esr;
> +
> +	int				reenable_error_ppi;
> +	struct mpam_msc * __percpu	*error_dev_id;
> +
>  	atomic_t		online_refs;
>  
>  	/*
> @@ -54,6 +63,7 @@ struct mpam_msc {
>  	 */
>  	struct mutex		probe_lock;
>  	bool			probed;
> +	unsigned long		error_irq_flags;
>  	u16			partid_max;
>  	u8			pmg_max;
>  	unsigned long		ris_idxs;


Thanks,

Ben


