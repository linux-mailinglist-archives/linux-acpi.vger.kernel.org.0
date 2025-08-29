Return-Path: <linux-acpi+bounces-16186-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03003B3BDCC
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 16:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9394681958
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 14:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4062931CA76;
	Fri, 29 Aug 2025 14:30:29 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2469205AA1;
	Fri, 29 Aug 2025 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477829; cv=none; b=papLHrHuKkPqXQIA7Oe+6EyZIBgm718fH70c2kcgmx5CFzWk6ZZD1GRrgmgGYlmheHS2dG2fJkL/vwhumE/0VpIaM7A5X1sEkVLVExXKwK/L8ZK8EzXP3W/IKbRhqbiFahaFQSfMn/3AVcV1w06KDC9f4WZA+hBAiTQyRxVm1no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477829; c=relaxed/simple;
	bh=qubuGzVfMaLFSQG/gjHJt9Hipl9/9FCZ0mhroHks2Qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=loPRN74sBGEIBILkkCuKJKGl34ZSWA3UZXT8/gj2dqgx6F3Ifd3GUVc8OoCQj5aBvRJkgCXCCT3a+Jy9/AP4sOGmYQD1xnVppbSoLrm1PuidmIM3QqFbi2pZAzoG9OGmB32zVj+UxoKxPuQrd8Rcvxg295BD65ahKlB1lwRirz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE48B19F0;
	Fri, 29 Aug 2025 07:30:17 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CD023F694;
	Fri, 29 Aug 2025 07:30:20 -0700 (PDT)
Message-ID: <c2a814d6-e235-4589-bdb0-63d08d4ca008@arm.com>
Date: Fri, 29 Aug 2025 15:30:19 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/33] arm_mpam: Extend reset logic to allow devices to be
 reset any time
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
 <20250822153048.2287-22-james.morse@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20250822153048.2287-22-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 8/22/25 16:30, James Morse wrote:
> cpuhp callbacks aren't the only time the MSC configuration may need to
> be reset. Resctrl has an API call to reset a class.
> If an MPAM error interrupt arrives it indicates the driver has
> misprogrammed an MSC. The safest thing to do is reset all the MSCs
> and disable MPAM.
> 
> Add a helper to reset RIS via their class. Call this from mpam_disable(),
> which can be scheduled from the error interrupt handler.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/resctrl/mpam_devices.c  | 62 +++++++++++++++++++++++++++++++--
>  drivers/resctrl/mpam_internal.h |  1 +
>  2 files changed, 61 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 759244966736..3516cbe8623e 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -915,8 +915,6 @@ static int mpam_reset_ris(void *arg)
>  	u16 partid, partid_max;
>  	struct mpam_msc_ris *ris = arg;
>  
> -	mpam_assert_srcu_read_lock_held();
> -
>  	if (ris->in_reset_state)
>  		return 0;
>  
> @@ -1569,6 +1567,66 @@ static void mpam_enable_once(void)
>  	       mpam_partid_max + 1, mpam_pmg_max + 1);
>  }
>  
> +static void mpam_reset_component_locked(struct mpam_component *comp)
> +{
> +	int idx;
> +	struct mpam_msc *msc;
> +	struct mpam_vmsc *vmsc;
> +	struct mpam_msc_ris *ris;
> +
> +	might_sleep();
> +	lockdep_assert_cpus_held();
> +
> +	idx = srcu_read_lock(&mpam_srcu);
> +	list_for_each_entry_rcu(vmsc, &comp->vmsc, comp_list) {
> +		msc = vmsc->msc;
> +
> +		list_for_each_entry_rcu(ris, &vmsc->ris, vmsc_list) {
> +			if (!ris->in_reset_state)
> +				mpam_touch_msc(msc, mpam_reset_ris, ris);
> +			ris->in_reset_state = true;
> +		}
> +	}
> +	srcu_read_unlock(&mpam_srcu, idx);
> +}
> +
> +static void mpam_reset_class_locked(struct mpam_class *class)
> +{
> +	int idx;
> +	struct mpam_component *comp;
> +
> +	lockdep_assert_cpus_held();
> +
> +	idx = srcu_read_lock(&mpam_srcu);
> +	list_for_each_entry_rcu(comp, &class->components, class_list)
> +		mpam_reset_component_locked(comp);
> +	srcu_read_unlock(&mpam_srcu, idx);
> +}
> +
> +static void mpam_reset_class(struct mpam_class *class)
> +{
> +	cpus_read_lock();
> +	mpam_reset_class_locked(class);
> +	cpus_read_unlock();
> +}
> +
> +/*
> + * Called in response to an error IRQ.
> + * All of MPAMs errors indicate a software bug, restore any modified
> + * controls to their reset values.
> + */
> +void mpam_disable(void)
> +{
> +	int idx;
> +	struct mpam_class *class;
> +
> +	idx = srcu_read_lock(&mpam_srcu);
> +	list_for_each_entry_srcu(class, &mpam_classes, classes_list,
> +				 srcu_read_lock_held(&mpam_srcu))

Why do you use list_for_each_entry_srcu() here when in other places you
use list_for_each_entry_rcu()?

> +		mpam_reset_class(class);
> +	srcu_read_unlock(&mpam_srcu, idx);
> +}
> +
>  /*
>   * Enable mpam once all devices have been probed.
>   * Scheduled by mpam_discovery_cpu_online() once all devices have been created.
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 466d670a01eb..b30fee2b7674 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -281,6 +281,7 @@ extern u8 mpam_pmg_max;
>  
>  /* Scheduled work callback to enable mpam once all MSC have been probed */
>  void mpam_enable(struct work_struct *work);
> +void mpam_disable(void);
>  
>  int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
>  				   cpumask_t *affinity);

Thanks,

Ben


