Return-Path: <linux-acpi+bounces-16116-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F2FB387A6
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 18:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6BD920082E
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 16:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEAB2566D2;
	Wed, 27 Aug 2025 16:19:45 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC98022F177;
	Wed, 27 Aug 2025 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756311585; cv=none; b=J2RQl40JTZyS15c+KqsPycuJKdyOkz/pd7VVHXs+TDu5Yljet/Vpsu1anQ7voAWNfpe0OL+oH+fSaXzU/9P1tS1NyDZgfhnpFuQAAD6E/zPXlG1Nf02rXkA+GbKUz4m+a+EBaeQslhuilx4dCXO7NJ2OrAMw/BY7dLObT1Soi8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756311585; c=relaxed/simple;
	bh=xBM+loesgjbHRQ22XIXRGQwNrGCfWcfwc3CKKmZVUrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=amDHtCCcwpNDFCUPd4i46YKIPDfg8xmfYuCLoSJNswr/7oC4/j7PfHAngsdok6cBSnkg2ySAEsmGg9ebmcMMx5c+L3OWtS1oeDakBGQoUtrGvHAA2sIPKrvIHvhp8lVkGdMLRx0aTS/9+l8V1RMEMJIzxHUeM0LfoJZOzfPX6ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE2E9152B;
	Wed, 27 Aug 2025 09:19:33 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEF773F738;
	Wed, 27 Aug 2025 09:19:36 -0700 (PDT)
Message-ID: <1c20a5b2-2afe-4084-9494-a994e1a275b7@arm.com>
Date: Wed, 27 Aug 2025 17:19:35 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/33] arm_mpam: Reset MSC controls from cpu hp callbacks
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
 <20250822153048.2287-20-james.morse@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20250822153048.2287-20-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 8/22/25 16:30, James Morse wrote:
> When a CPU comes online, it may bring a newly accessible MSC with
> it. Only the default partid has its value reset by hardware, and
> even then the MSC might not have been reset since its config was
> previously dirtyied. e.g. Kexec.
> 
> Any in-use partid must have its configuration restored, or reset.
> In-use partids may be held in caches and evicted later.
> 
> MSC are also reset when CPUs are taken offline to cover cases where
> firmware doesn't reset the MSC over reboot using UEFI, or kexec
> where there is no firmware involvement.
> 
> If the configuration for a RIS has not been touched since it was
> brought online, it does not need resetting again.
> 
> To reset, write the maximum values for all discovered controls.
> 
> CC: Rohit Mathew <Rohit.Mathew@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since RFC:
>  * Last bitmap write will always be non-zero.
>   * Dropped READ_ONCE() - teh value can no longer change.
> ---
>  drivers/resctrl/mpam_devices.c  | 121 ++++++++++++++++++++++++++++++++
>  drivers/resctrl/mpam_internal.h |   8 +++
>  2 files changed, 129 insertions(+)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index bb62de6d3847..c1f01dd748ad 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -7,6 +7,7 @@
>  #include <linux/atomic.h>
>  #include <linux/arm_mpam.h>
>  #include <linux/bitfield.h>
> +#include <linux/bitmap.h>
>  #include <linux/cacheinfo.h>
>  #include <linux/cpu.h>
>  #include <linux/cpumask.h>
> @@ -849,8 +850,115 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>  	return 0;
>  }
>  
> +static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
> +{
> +	u32 num_words, msb;
> +	u32 bm = ~0;
> +	int i;
> +
> +	lockdep_assert_held(&msc->part_sel_lock);
> +
> +	if (wd == 0)
> +		return;
> +
> +	/*
> +	 * Write all ~0 to all but the last 32bit-word, which may
> +	 * have fewer bits...
> +	 */
> +	num_words = DIV_ROUND_UP(wd, 32);
> +	for (i = 0; i < num_words - 1; i++, reg += sizeof(bm))
> +		__mpam_write_reg(msc, reg, bm);
> +
> +	/*
> +	 * ....and then the last (maybe) partial 32bit word. When wd is a
> +	 * multiple of 32, msb should be 31 to write a full 32bit word.
> +	 */
> +	msb = (wd - 1) % 32;
> +	bm = GENMASK(msb, 0);
> +	__mpam_write_reg(msc, reg, bm);
> +}
> +
> +static void mpam_reset_ris_partid(struct mpam_msc_ris *ris, u16 partid)
> +{
> +	u16 bwa_fract = MPAMCFG_MBW_MAX_MAX;
> +	struct mpam_msc *msc = ris->vmsc->msc;
> +	struct mpam_props *rprops = &ris->props;
> +
> +	mpam_assert_srcu_read_lock_held();
> +
> +	mutex_lock(&msc->part_sel_lock);
> +	__mpam_part_sel(ris->ris_idx, partid, msc);
> +
> +	if (mpam_has_feature(mpam_feat_cpor_part, rprops))
> +		mpam_reset_msc_bitmap(msc, MPAMCFG_CPBM, rprops->cpbm_wd);
> +
> +	if (mpam_has_feature(mpam_feat_mbw_part, rprops))
> +		mpam_reset_msc_bitmap(msc, MPAMCFG_MBW_PBM, rprops->mbw_pbm_bits);
> +
> +	if (mpam_has_feature(mpam_feat_mbw_min, rprops))
> +		mpam_write_partsel_reg(msc, MBW_MIN, 0);
> +
> +	if (mpam_has_feature(mpam_feat_mbw_max, rprops))
> +		mpam_write_partsel_reg(msc, MBW_MAX, bwa_fract);
MPAMCFG_MBW_MAX_MAX can be used directly instead of bwa_fract.
> +
> +	if (mpam_has_feature(mpam_feat_mbw_prop, rprops))
> +		mpam_write_partsel_reg(msc, MBW_PROP, bwa_fract);
Shouldn't this reset to 0? STRIDEM1 is a cost.
> +	mutex_unlock(&msc->part_sel_lock);
> +}
> +
> +static void mpam_reset_ris(struct mpam_msc_ris *ris)
> +{
> +	u16 partid, partid_max;
> +
> +	mpam_assert_srcu_read_lock_held();
> +
> +	if (ris->in_reset_state)
> +		return;
> +
> +	spin_lock(&partid_max_lock);
> +	partid_max = mpam_partid_max;
> +	spin_unlock(&partid_max_lock);
> +	for (partid = 0; partid < partid_max; partid++)
> +		mpam_reset_ris_partid(ris, partid);
> +}
> +
> +static void mpam_reset_msc(struct mpam_msc *msc, bool online)
> +{
> +	int idx;
> +	struct mpam_msc_ris *ris;
> +
> +	mpam_assert_srcu_read_lock_held();
> +
> +	mpam_mon_sel_outer_lock(msc);
> +	idx = srcu_read_lock(&mpam_srcu);
> +	list_for_each_entry_srcu(ris, &msc->ris, msc_list, srcu_read_lock_held(&mpam_srcu)) {
> +		mpam_reset_ris(ris);
> +
> +		/*
> +		 * Set in_reset_state when coming online. The reset state
> +		 * for non-zero partid may be lost while the CPUs are offline.
> +		 */
> +		ris->in_reset_state = online;
> +	}
> +	srcu_read_unlock(&mpam_srcu, idx);
> +	mpam_mon_sel_outer_unlock(msc);
> +}
> +
>  static int mpam_cpu_online(unsigned int cpu)
>  {
> +	int idx;
> +	struct mpam_msc *msc;
> +
> +	idx = srcu_read_lock(&mpam_srcu);
> +	list_for_each_entry_srcu(msc, &mpam_all_msc, glbl_list, srcu_read_lock_held(&mpam_srcu)) {
> +		if (!cpumask_test_cpu(cpu, &msc->accessibility))
> +			continue;
> +
> +		if (atomic_fetch_inc(&msc->online_refs) == 0)
> +			mpam_reset_msc(msc, true);
> +	}
> +	srcu_read_unlock(&mpam_srcu, idx);
> +
>  	return 0;
>  }
>  
> @@ -886,6 +994,19 @@ static int mpam_discovery_cpu_online(unsigned int cpu)
>  
>  static int mpam_cpu_offline(unsigned int cpu)
>  {
> +	int idx;
> +	struct mpam_msc *msc;
> +
> +	idx = srcu_read_lock(&mpam_srcu);
> +	list_for_each_entry_srcu(msc, &mpam_all_msc, glbl_list, srcu_read_lock_held(&mpam_srcu)) {
> +		if (!cpumask_test_cpu(cpu, &msc->accessibility))
> +			continue;
> +
> +		if (atomic_dec_and_test(&msc->online_refs))
> +			mpam_reset_msc(msc, false);
> +	}
> +	srcu_read_unlock(&mpam_srcu, idx);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index a2b0ff411138..466d670a01eb 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -5,6 +5,7 @@
>  #define MPAM_INTERNAL_H
>  
>  #include <linux/arm_mpam.h>
> +#include <linux/atomic.h>
>  #include <linux/cpumask.h>
>  #include <linux/io.h>
>  #include <linux/llist.h>
> @@ -43,6 +44,7 @@ struct mpam_msc {
>  	struct pcc_mbox_chan	*pcc_chan;
>  	u32			nrdy_usec;
>  	cpumask_t		accessibility;
> +	atomic_t		online_refs;
>  
>  	/*
>  	 * probe_lock is only take during discovery. After discovery these
> @@ -248,6 +250,7 @@ struct mpam_msc_ris {
>  	u8			ris_idx;
>  	u64			idr;
>  	struct mpam_props	props;
> +	bool			in_reset_state;
>  
>  	cpumask_t		affinity;
>  
> @@ -267,6 +270,11 @@ struct mpam_msc_ris {
>  extern struct srcu_struct mpam_srcu;
>  extern struct list_head mpam_classes;
>  
> +static inline void mpam_assert_srcu_read_lock_held(void)
> +{
> +	WARN_ON_ONCE(!srcu_read_lock_held((&mpam_srcu)));
> +}
> +
>  /* System wide partid/pmg values */
>  extern u16 mpam_partid_max;
>  extern u8 mpam_pmg_max;

Thanks,

Ben


