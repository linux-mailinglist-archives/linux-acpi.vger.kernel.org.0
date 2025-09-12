Return-Path: <linux-acpi+bounces-16750-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E1BB55431
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 17:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234FB1C25900
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 15:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF164302755;
	Fri, 12 Sep 2025 15:55:24 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CF5266560;
	Fri, 12 Sep 2025 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692524; cv=none; b=oz6rblZWT+n2PKigy7i9INVZukJ2zL2QAD+26sRSTr7aMLYmRYDsaVjdF/oEs5PqEBfLFKwcRUvaJoAciaPA42B2Kjhzd7G6ynusGTBvSv9saHx+YVitLGAjf810PdLxHQ/qhPsCZpdcgvpPlEedDwlzcyUBrtf2/6qwhGtbCYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692524; c=relaxed/simple;
	bh=5q8RUlkeA6pyHgeVhdpx3JeIpyv4wzgt8AxLFO5mZng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lNZTaSGFvWCDsL+/38BAYc3JzPblm4laO4seqo4QQQnbJSOduO2OCCJWWrtLXs1hrPcWb2N/0sqIoQH4rrRJH3KviMF6hHiAawyy14C2IOneDMEsdhsL+N5eI9JdO6Blt90hSpd1W+n8oogYPWEzB9J/1FsikgpFLwWcyfVw9MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F0591515;
	Fri, 12 Sep 2025 08:55:13 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CEAE3F66E;
	Fri, 12 Sep 2025 08:55:17 -0700 (PDT)
Message-ID: <53eddf53-a610-4420-9021-658fdf31aebe@arm.com>
Date: Fri, 12 Sep 2025 16:55:16 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/29] arm_mpam: Track bandwidth counter state for
 overflow and power management
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
 <20250910204309.20751-25-james.morse@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20250910204309.20751-25-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 9/10/25 21:43, James Morse wrote:
> Bandwidth counters need to run continuously to correctly reflect the
> bandwidth.
> 
> The value read may be lower than the previous value read in the case
> of overflow and when the hardware is reset due to CPU hotplug.
> 
> Add struct mbwu_state to track the bandwidth counter to allow overflow
> and power management to be handled.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>  * Fixed lock/unlock typo.
> ---
>  drivers/resctrl/mpam_devices.c  | 154 +++++++++++++++++++++++++++++++-
>  drivers/resctrl/mpam_internal.h |  23 +++++
>  2 files changed, 175 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 1543c33c5d6a..eeb62ed94520 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -918,6 +918,7 @@ static void gen_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
>  	*ctl_val |= MSMON_CFG_x_CTL_MATCH_PARTID;
>  
>  	*flt_val = FIELD_PREP(MSMON_CFG_x_FLT_PARTID, ctx->partid);
> +
>  	if (m->ctx->match_pmg) {
>  		*ctl_val |= MSMON_CFG_x_CTL_MATCH_PMG;
>  		*flt_val |= FIELD_PREP(MSMON_CFG_x_FLT_PMG, ctx->pmg);
> @@ -972,6 +973,7 @@ static void clean_msmon_ctl_val(u32 *cur_ctl)
>  static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
>  				     u32 flt_val)
>  {
> +	struct msmon_mbwu_state *mbwu_state;
>  	struct mpam_msc *msc = m->ris->vmsc->msc;
>  
>  	/*
> @@ -990,20 +992,32 @@ static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
>  		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
>  		mpam_write_monsel_reg(msc, MBWU, 0);
>  		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
> +
> +		mbwu_state = &m->ris->mbwu_state[m->ctx->mon];
> +		if (mbwu_state)
> +			mbwu_state->prev_val = 0;

What's the if condition doing here?

The below could make more sense but I don't think you can get here if
the allocation fails.

if (m->ris->mbwu_state)

> +
>  		break;
>  	default:
>  		return;
>  	}
>  }
>  
> +static u64 mpam_msmon_overflow_val(struct mpam_msc_ris *ris)
> +{
> +	/* TODO: scaling, and long counters */
> +	return GENMASK_ULL(30, 0);
> +}
> +
>  /* Call with MSC lock held */
>  static void __ris_msmon_read(void *arg)
>  {
> -	u64 now;
>  	bool nrdy = false;
>  	struct mon_read *m = arg;
> +	u64 now, overflow_val = 0;
>  	struct mon_cfg *ctx = m->ctx;
>  	struct mpam_msc_ris *ris = m->ris;
> +	struct msmon_mbwu_state *mbwu_state;
>  	struct mpam_props *rprops = &ris->props;
>  	struct mpam_msc *msc = m->ris->vmsc->msc;
>  	u32 mon_sel, ctl_val, flt_val, cur_ctl, cur_flt;
> @@ -1031,11 +1045,30 @@ static void __ris_msmon_read(void *arg)
>  		now = mpam_read_monsel_reg(msc, CSU);
>  		if (mpam_has_feature(mpam_feat_msmon_csu_hw_nrdy, rprops))
>  			nrdy = now & MSMON___NRDY;
> +		now = FIELD_GET(MSMON___VALUE, now);
>  		break;
>  	case mpam_feat_msmon_mbwu:
>  		now = mpam_read_monsel_reg(msc, MBWU);
>  		if (mpam_has_feature(mpam_feat_msmon_mbwu_hw_nrdy, rprops))
>  			nrdy = now & MSMON___NRDY;
> +		now = FIELD_GET(MSMON___VALUE, now);
> +
> +		if (nrdy)
> +			break;
> +
> +		mbwu_state = &ris->mbwu_state[ctx->mon];
> +		if (!mbwu_state)
> +			break;
> +
> +		/* Add any pre-overflow value to the mbwu_state->val */
> +		if (mbwu_state->prev_val > now)
> +			overflow_val = mpam_msmon_overflow_val(ris) - mbwu_state->prev_val;
> +
> +		mbwu_state->prev_val = now;
> +		mbwu_state->correction += overflow_val;
> +
> +		/* Include bandwidth consumed before the last hardware reset */
> +		now += mbwu_state->correction;
>  		break;
>  	default:
>  		m->err = -EINVAL;
> @@ -1048,7 +1081,6 @@ static void __ris_msmon_read(void *arg)
>  		return;
>  	}
>  
> -	now = FIELD_GET(MSMON___VALUE, now);
>  	*m->val += now;
>  }
>  
> @@ -1261,6 +1293,67 @@ static int mpam_reprogram_ris(void *_arg)
>  	return 0;
>  }
>  
> +/* Call with MSC lock held */
> +static int mpam_restore_mbwu_state(void *_ris)
> +{
> +	int i;
> +	struct mon_read mwbu_arg;
> +	struct mpam_msc_ris *ris = _ris;
> +
> +	for (i = 0; i < ris->props.num_mbwu_mon; i++) {
> +		if (ris->mbwu_state[i].enabled) {
> +			mwbu_arg.ris = ris;
> +			mwbu_arg.ctx = &ris->mbwu_state[i].cfg;
> +			mwbu_arg.type = mpam_feat_msmon_mbwu;
> +
> +			__ris_msmon_read(&mwbu_arg);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/* Call with MSC lock and held */
> +static int mpam_save_mbwu_state(void *arg)
> +{
> +	int i;
> +	u64 val;
> +	struct mon_cfg *cfg;
> +	u32 cur_flt, cur_ctl, mon_sel;
> +	struct mpam_msc_ris *ris = arg;
> +	struct msmon_mbwu_state *mbwu_state;
> +	struct mpam_msc *msc = ris->vmsc->msc;
> +
> +	for (i = 0; i < ris->props.num_mbwu_mon; i++) {
> +		mbwu_state = &ris->mbwu_state[i];
> +		cfg = &mbwu_state->cfg;
> +
> +		if (WARN_ON_ONCE(!mpam_mon_sel_lock(msc)))
> +			return -EIO;
> +
> +		mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, i) |
> +			  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
> +		mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
> +
> +		cur_flt = mpam_read_monsel_reg(msc, CFG_MBWU_FLT);
> +		cur_ctl = mpam_read_monsel_reg(msc, CFG_MBWU_CTL);
> +		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
> +
> +		val = mpam_read_monsel_reg(msc, MBWU);
> +		mpam_write_monsel_reg(msc, MBWU, 0);
> +
> +		cfg->mon = i;
> +		cfg->pmg = FIELD_GET(MSMON_CFG_x_FLT_PMG, cur_flt);
> +		cfg->match_pmg = FIELD_GET(MSMON_CFG_x_CTL_MATCH_PMG, cur_ctl);
> +		cfg->partid = FIELD_GET(MSMON_CFG_x_FLT_PARTID, cur_flt);
> +		mbwu_state->correction += val;
> +		mbwu_state->enabled = FIELD_GET(MSMON_CFG_x_CTL_EN, cur_ctl);
> +		mpam_mon_sel_unlock(msc);
> +	}
> +
> +	return 0;
> +}
> +
>  static void mpam_init_reset_cfg(struct mpam_config *reset_cfg)
>  {
>  	memset(reset_cfg, 0, sizeof(*reset_cfg));
> @@ -1335,6 +1428,9 @@ static void mpam_reset_msc(struct mpam_msc *msc, bool online)
>  		 * for non-zero partid may be lost while the CPUs are offline.
>  		 */
>  		ris->in_reset_state = online;
> +
> +		if (mpam_is_enabled() && !online)
> +			mpam_touch_msc(msc, &mpam_save_mbwu_state, ris);
>  	}
>  }
>  
> @@ -1369,6 +1465,9 @@ static void mpam_reprogram_msc(struct mpam_msc *msc)
>  			mpam_reprogram_ris_partid(ris, partid, cfg);
>  		}
>  		ris->in_reset_state = reset;
> +
> +		if (mpam_has_feature(mpam_feat_msmon_mbwu, &ris->props))
> +			mpam_touch_msc(msc, &mpam_restore_mbwu_state, ris);
>  	}
>  }
>  
> @@ -2091,11 +2190,33 @@ static void mpam_unregister_irqs(void)
>  
>  static void __destroy_component_cfg(struct mpam_component *comp)
>  {
> +	struct mpam_msc *msc;
> +	struct mpam_vmsc *vmsc;
> +	struct mpam_msc_ris *ris;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
>  	add_to_garbage(comp->cfg);
> +	list_for_each_entry(vmsc, &comp->vmsc, comp_list) {
> +		msc = vmsc->msc;
> +
> +		if (mpam_mon_sel_lock(msc)) {
> +			list_for_each_entry(ris, &vmsc->ris, vmsc_list)
> +				add_to_garbage(ris->mbwu_state);
> +			mpam_mon_sel_unlock(msc);
> +		}
> +	}
>  }
>  
>  static int __allocate_component_cfg(struct mpam_component *comp)
>  {
> +	int err = 0;
> +	struct mpam_msc *msc;
> +	struct mpam_vmsc *vmsc;
> +	struct mpam_msc_ris *ris;
> +	struct msmon_mbwu_state *mbwu_state;
> +
> +	lockdep_assert_held(&mpam_list_lock);
>  	mpam_assert_partid_sizes_fixed();
>  
>  	if (comp->cfg)
> @@ -2106,6 +2227,35 @@ static int __allocate_component_cfg(struct mpam_component *comp)
>  		return -ENOMEM;
>  	init_garbage(comp->cfg);
>  
> +	list_for_each_entry(vmsc, &comp->vmsc, comp_list) {
> +		if (!vmsc->props.num_mbwu_mon)
> +			continue;
> +
> +		msc = vmsc->msc;
> +		list_for_each_entry(ris, &vmsc->ris, vmsc_list) {
> +			if (!ris->props.num_mbwu_mon)
> +				continue;
> +
> +			mbwu_state = kcalloc(ris->props.num_mbwu_mon,
> +					     sizeof(*ris->mbwu_state),
> +					     GFP_KERNEL);
> +			if (!mbwu_state) {
> +				__destroy_component_cfg(comp);
> +				err = -ENOMEM;
> +				break;
> +			}
> +
> +			if (mpam_mon_sel_lock(msc)) {
> +				init_garbage(mbwu_state);
> +				ris->mbwu_state = mbwu_state;
> +				mpam_mon_sel_unlock(msc);
> +			}

The if statement is confusing now that mpam_mon_sel_lock()
unconditionally returns true.

> +		}
> +
> +		if (err)
> +			break;
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index bb01e7dbde40..725c2aefa8a2 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -212,6 +212,26 @@ struct mon_cfg {
>  	enum mon_filter_options opts;
>  };
>  
> +/*
> + * Changes to enabled and cfg are protected by the msc->lock.
> + * Changes to prev_val and correction are protected by the msc's mon_sel_lock.
> + */
> +struct msmon_mbwu_state {
> +	bool		enabled;
> +	struct mon_cfg	cfg;
> +
> +	/* The value last read from the hardware. Used to detect overflow. */
> +	u64		prev_val;
> +
> +	/*
> +	 * The value to add to the new reading to account for power management,
> +	 * and shifts to trigger the overflow interrupt.
> +	 */
> +	u64		correction;
> +
> +	struct mpam_garbage	garbage;
> +};
> +
>  struct mpam_class {
>  	/* mpam_components in this class */
>  	struct list_head	components;
> @@ -304,6 +324,9 @@ struct mpam_msc_ris {
>  	/* parent: */
>  	struct mpam_vmsc	*vmsc;
>  
> +	/* msmon mbwu configuration is preserved over reset */
> +	struct msmon_mbwu_state	*mbwu_state;
> +
>  	struct mpam_garbage	garbage;
>  };
>  

Thanks,

Ben


