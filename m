Return-Path: <linux-acpi+bounces-16156-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA28CB3A5DB
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 18:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66361581ED9
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 16:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857982D6407;
	Thu, 28 Aug 2025 16:13:22 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB612D23B6;
	Thu, 28 Aug 2025 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756397602; cv=none; b=ef1JcG3SZH7ykuTGzrKBTsZXkOrgm9tZ5UqcHpGdzELX+MuLQylpa0DnXx77gbUXci/4cy4fCXeA6vEP68vTrHKA1f9CjRIaLegE66c94axGOU0rPXe8lWg8CoGgkLMz31kbnOZxUIVlMUONSUdJyWm00o/w8NJMBHXXe0uZ5kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756397602; c=relaxed/simple;
	bh=O2M2ewyT9BTwMaGPRohrg857neoQ+0bApEVjgrSurBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmZUv0pmUMh91LtOTnbWgHoKSSyfYNypCCPCsanimTfesxD+ZYFANFo/9nwdHLx4txX6rddIDxaVZ9WWV+Sb2MCcMUnHh2SAAiwdpfdo3kmE5AsetwYsVn9kzIAulVU5tyP3kxLp0qnR3zq8/d4HegwKFkiypccqroUtKHW9mt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89BC41688;
	Thu, 28 Aug 2025 09:13:11 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 688EE3F694;
	Thu, 28 Aug 2025 09:13:14 -0700 (PDT)
Message-ID: <8635e616-79b7-4d7d-a8b8-aa76ba027bc4@arm.com>
Date: Thu, 28 Aug 2025 17:13:13 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/33] arm_mpam: Add a helper to touch an MSC from any CPU
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 devicetree@vger.kernel.org
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
 <20250822153048.2287-21-james.morse@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20250822153048.2287-21-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 8/22/25 16:30, James Morse wrote:
> Resetting RIS entries from the cpuhp callback is easy as the
> callback occurs on the correct CPU. This won't be true for any other
> caller that wants to reset or configure an MSC.
> 
> Add a helper that schedules the provided function if necessary.
> Prevent the cpuhp callbacks from changing the MSC state by taking the
> cpuhp lock.
At first, I thought this was referring to something done in the patch.
Consider changing to something like:

Callers should take the cpuhp lock to prevent the cpuhp callbacks from
changing the MSC state.

Regardless, this looks good to me.

Reviewed-by: Ben Horgan <ben.horgan@arm.com>

> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/resctrl/mpam_devices.c | 37 +++++++++++++++++++++++++++++++---
>  1 file changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index c1f01dd748ad..759244966736 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -906,20 +906,51 @@ static void mpam_reset_ris_partid(struct mpam_msc_ris *ris, u16 partid)
>  	mutex_unlock(&msc->part_sel_lock);
>  }
>  
> -static void mpam_reset_ris(struct mpam_msc_ris *ris)
> +/*
> + * Called via smp_call_on_cpu() to prevent migration, while still being
> + * pre-emptible.
> + */
> +static int mpam_reset_ris(void *arg)
>  {
>  	u16 partid, partid_max;
> +	struct mpam_msc_ris *ris = arg;
>  
>  	mpam_assert_srcu_read_lock_held();
>  
>  	if (ris->in_reset_state)
> -		return;
> +		return 0;
>  
>  	spin_lock(&partid_max_lock);
>  	partid_max = mpam_partid_max;
>  	spin_unlock(&partid_max_lock);
>  	for (partid = 0; partid < partid_max; partid++)
>  		mpam_reset_ris_partid(ris, partid);
> +
> +	return 0;
> +}
> +
> +/*
> + * Get the preferred CPU for this MSC. If it is accessible from this CPU,
> + * this CPU is preferred. This can be preempted/migrated, it will only result
> + * in more work.
> + */
> +static int mpam_get_msc_preferred_cpu(struct mpam_msc *msc)
> +{
> +	int cpu = raw_smp_processor_id();
> +
> +	if (cpumask_test_cpu(cpu, &msc->accessibility))
> +		return cpu;
> +
> +	return cpumask_first_and(&msc->accessibility, cpu_online_mask);
> +}
> +
> +static int mpam_touch_msc(struct mpam_msc *msc, int (*fn)(void *a), void *arg)
> +{
> +	lockdep_assert_irqs_enabled();
> +	lockdep_assert_cpus_held();
> +	mpam_assert_srcu_read_lock_held();
> +
> +	return smp_call_on_cpu(mpam_get_msc_preferred_cpu(msc), fn, arg, true);
>  }
>  
>  static void mpam_reset_msc(struct mpam_msc *msc, bool online)
> @@ -932,7 +963,7 @@ static void mpam_reset_msc(struct mpam_msc *msc, bool online)
>  	mpam_mon_sel_outer_lock(msc);
>  	idx = srcu_read_lock(&mpam_srcu);
>  	list_for_each_entry_srcu(ris, &msc->ris, msc_list, srcu_read_lock_held(&mpam_srcu)) {
> -		mpam_reset_ris(ris);
> +		mpam_touch_msc(msc, &mpam_reset_ris, ris);
>  
>  		/*
>  		 * Set in_reset_state when coming online. The reset state

Thanks,

Ben


