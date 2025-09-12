Return-Path: <linux-acpi+bounces-16719-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7315EB54D69
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 14:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDF7B5A7CF0
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 12:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88C230E848;
	Fri, 12 Sep 2025 12:12:28 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB37C3043C3;
	Fri, 12 Sep 2025 12:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679148; cv=none; b=eFy/1sAceaiQIw0UlqlbjOpjjQeow18QaTnaqE/6QzS29+0HmRgcFdNuS0NqoqnxipDlzsT31UqloNWLoEIdeOSfMlNzxXIRuJtZea123PMYj4mWxoeR34vkdzmgqQcX084nS4JNYNwnHOR2BUJk9zSovbGKCWP4vjFKGp29/dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679148; c=relaxed/simple;
	bh=w9zzgq+7Cuxu5JSgH1TY5NHegQHnUejKAdDFtRLDyD0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQmoo6Eg4nmGgvWgxSbaCu3teuspN+kRZN2YTphX4HGhOEMy8cFU/Muqng76XEItsRj5OUfq6ra76uLbh8/Zf0pYyvDjKvMUNkOoCse272zlT3hHEUteHQVkilwCw1tlAaIeDd8Sn4e2BSYdBTwaNLHtzJMvPBZI5H6uZHugvgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cNY916FLFz6L5pF;
	Fri, 12 Sep 2025 20:08:05 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A59B1402EA;
	Fri, 12 Sep 2025 20:12:22 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 12 Sep
 2025 14:12:21 +0200
Date: Fri, 12 Sep 2025 13:12:19 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: James Morse <james.morse@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>, Koba
 Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
	<fenghuay@nvidia.com>, <baisheng.gao@unisoc.com>, Rob Herring
	<robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>, "Rafael Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla
	<sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 18/29] arm_mpam: Register and enable IRQs
Message-ID: <20250912131219.00000938@huawei.com>
In-Reply-To: <20250910204309.20751-19-james.morse@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
	<20250910204309.20751-19-james.morse@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 10 Sep 2025 20:42:58 +0000
James Morse <james.morse@arm.com> wrote:

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
A few comments inline.


> @@ -1318,11 +1405,172 @@ static void mpam_enable_merge_features(struct list_head *all_classes_list)
>  	}
>  }
>  
> +static char *mpam_errcode_names[16] = {
> +	[0] = "No error",

I think you had a bunch of defines for these in an earlier patch.  Can we use
that to index here instead of [0] etc. 

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


> +static void mpam_unregister_irqs(void)
> +{
> +	int irq, idx;
> +	struct mpam_msc *msc;
> +
> +	cpus_read_lock();

	guard(cpus_read_lock)();
	guard(srcu)(&mpam_srcu);

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

Perhaps move the print into the if (err) below?

> +
> +	mutex_unlock(&mpam_list_lock);
> +	cpus_read_unlock();
> +
> +	if (err) {
> +		schedule_work(&mpam_broken_work);
> +		return;
> +	}

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

If there aren't going to be load more of these (I've not really thought
about whether there might) then using a bitmap for these seems to add complexity
that we wouldn't see with 
bool error_irq_req;
bool error_irq_hw_enabled;


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


