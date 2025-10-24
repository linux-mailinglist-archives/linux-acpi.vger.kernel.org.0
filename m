Return-Path: <linux-acpi+bounces-18201-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C71CC07A41
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 20:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 384101C83C19
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 18:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79DF348894;
	Fri, 24 Oct 2025 18:03:31 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80AE348881;
	Fri, 24 Oct 2025 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329011; cv=none; b=o4ldHyoiFILNgNkUf0Wt3VskasJaM8SZB0UKEGWdSr8TNsxn4DyzT7xpAPWf5Y3xUq1HTJwxtZ2/y/+wmFpkL94kNE+nMKllwZbskCv1rIHxA71+1KOnx0ljPF5DHGwg7eQhMQpxTZfHFVWStS4PfkkEr7X3BQQgvOVqU3gyd1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329011; c=relaxed/simple;
	bh=cDm7wfr/4bJW6Jm2Vn5dxt6Ad7Oj0cMcUzYP7ciZUR0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/DshKCdML9YbDKSL+iv8HD87MwpVxGods4TIoaTzCejqsLQyzt7YMNGrbRDru6sb0fzmZTfqhJaWSqjuO901rlWFBH9HWqd8r5Y/H78DBajmYeaWaavtRVHu5g5ScozhPIozq4NYBAAqtIIkBPOaOupOUSlTRc2Uiu5dIHcAkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ctVzL6WlJz6M4gJ;
	Sat, 25 Oct 2025 01:59:42 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 4DB8B140417;
	Sat, 25 Oct 2025 02:03:26 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 24 Oct
 2025 19:03:24 +0100
Date: Fri, 24 Oct 2025 19:03:23 +0100
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
	Danilo Krummrich <dakr@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
	Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 18/29] arm_mpam: Register and enable IRQs
Message-ID: <20251024190323.0000328d@huawei.com>
In-Reply-To: <20251017185645.26604-19-james.morse@arm.com>
References: <20251017185645.26604-1-james.morse@arm.com>
	<20251017185645.26604-19-james.morse@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 17 Oct 2025 18:56:34 +0000
James Morse <james.morse@arm.com> wrote:

> Register and enable error IRQs. All the MPAM error interrupts indicate a
> software bug, e.g. out of range partid. If the error interrupt is ever
> signalled, attempt to disable MPAM.
> 
> Only the irq handler accesses the MPAMF_ESR register, so no locking is
> needed. The work to disable MPAM after an error needs to happen at process
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
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Signed-off-by: James Morse <james.morse@arm.com>
One trivial thing inline to reduce the patch churn a tiny bit.
May not be worth the hassle.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 545482e112b7..f18a22f825a0 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -14,6 +14,9 @@



>  static void mpam_enable_once(void)
>  {
> -	mutex_lock(&mpam_list_lock);
> -	mpam_enable_merge_features(&mpam_classes);
> -	mutex_unlock(&mpam_list_lock);

Can you shift this later in the earlier patch (ordering clearly doesn't matter)
so as to reduce churn here?

> +	int err;
>  
>  	/*
>  	 * Once the cpuhp callbacks have been changed, mpam_partid_max can no
> @@ -1318,6 +1572,27 @@ static void mpam_enable_once(void)
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
> +
> +	mutex_unlock(&mpam_list_lock);
> +	cpus_read_unlock();
> +
> +	if (err) {
> +		pr_warn("Failed to register irqs: %d\n", err);
> +		mpam_disable_reason = "Failed to enable.";
> +		schedule_work(&mpam_broken_work);
> +		return;
> +	}
> +
>  	mpam_register_cpuhp_callbacks(mpam_cpu_online, mpam_cpu_offline,
>  				      "mpam:online");
>  
> @@ -1385,6 +1660,8 @@ void mpam_disable(struct work_struct *ignored)
>  	}
>  	mutex_unlock(&mpam_cpuhp_state_lock);
>  
> +	mpam_unregister_irqs();
> +
>  	idx = srcu_read_lock(&mpam_srcu);
>  	list_for_each_entry_srcu(class, &mpam_classes, classes_list,
>  				 srcu_read_lock_held(&mpam_srcu))


