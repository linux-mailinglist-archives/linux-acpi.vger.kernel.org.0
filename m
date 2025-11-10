Return-Path: <linux-acpi+bounces-18727-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93939C47044
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 14:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E53D188F123
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 13:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468763043CB;
	Mon, 10 Nov 2025 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="Vt7rxr9y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C8122D780;
	Mon, 10 Nov 2025 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762782614; cv=none; b=GuBypmOFQ1RUirNhcRPbHSUpBYu1c5ZMwPrLgEvgMTMUOo2OLJFY9ncBF4ErziDIVwrL97X5VRBmET2GEcG/25OygxBNu0w6al0LMakOuP39JiBNCcSyIIfPK4U94qPjNqhJIBAB2L3yWV/gQkxXa7b6CUyp55ZrkoKFTBeMDwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762782614; c=relaxed/simple;
	bh=Q1vfMEWT+/80joba6qHktsyG/cY+VJpox6T5VrT9i7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f/6w3XA3uZu7GbshQCiKe+gE9hqPzxRHYm0R/pkv0rlXy2dGRFBH8CNLzrHs96FhxoMRmaNQhy3Bw4mpiIutGmh/ws2JkYwcSZnM3lhUI36Vgx3CVtVexHHQMpVvH789YzlamAlZwrc4VGUZQzJLEKoQ2dY1/HQi3k5IRI3Psa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=Vt7rxr9y; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JTcllefIDFbLHCSJNKSkBkO445PdDjgPicwZz27z1iQ=;
	b=Vt7rxr9yOpYt9SpAUvhOrcwZ75y5/B3/F1X/ujAadSjXaVvVUNJ1SXo5FpEnYDnrVLFcDAtJR
	NvohO846M89UdKiu9boC0JYpEARv2130NHTnXlkec9FNQR0iGIi0gAD0MKXCal26wWkbksRKYd8
	pgM4yoPzBGrWdARMN8VK+KU=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4d4rbS59HFzRhRK;
	Mon, 10 Nov 2025 21:48:20 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 96DBE140146;
	Mon, 10 Nov 2025 21:49:58 +0800 (CST)
Received: from [10.174.178.24] (10.174.178.24) by
 kwepemf100008.china.huawei.com (7.202.181.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Nov 2025 21:49:56 +0800
Message-ID: <b6046b29-580e-a75b-1fe7-4d76127d7829@huawei.com>
Date: Mon, 10 Nov 2025 21:49:56 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 27/33] arm_mpam: Track bandwidth counter state for power
 management
Content-Language: en-US
To: Ben Horgan <ben.horgan@arm.com>, <james.morse@arm.com>
CC: <amitsinght@marvell.com>, <baisheng.gao@unisoc.com>,
	<baolin.wang@linux.alibaba.com>, <bobo.shaobowang@huawei.com>,
	<carl@os.amperecomputing.com>, <catalin.marinas@arm.com>, <dakr@kernel.org>,
	<dave.martin@arm.com>, <david@redhat.com>, <dfustini@baylibre.com>,
	<fenghuay@nvidia.com>, <gregkh@linuxfoundation.org>, <gshan@redhat.com>,
	<guohanjun@huawei.com>, <jeremy.linton@arm.com>,
	<jonathan.cameron@huawei.com>, <kobak@nvidia.com>, <lcherian@marvell.com>,
	<lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lpieralisi@kernel.org>, <peternewman@google.com>, <quic_jiles@quicinc.com>,
	<rafael@kernel.org>, <robh@kernel.org>, <rohit.mathew@arm.com>,
	<scott@os.amperecomputing.com>, <sdonthineni@nvidia.com>,
	<sudeep.holla@arm.com>, <tan.shaopeng@fujitsu.com>, <will@kernel.org>,
	<xhao@linux.alibaba.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-28-ben.horgan@arm.com>
From: Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <20251107123450.664001-28-ben.horgan@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100008.china.huawei.com (7.202.181.222)



On 2025/11/7 20:34, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> Bandwidth counters need to run continuously to correctly reflect the
> bandwidth.
> 
> Save the counter state when the hardware is reset due to CPU hotplug.
> Add struct mbwu_state to track the bandwidth counter. Support for
> tracking overflow with the same structure will be added in a
> subsequent commit.
> 
> Cc: Zeng Heng <zengheng4@huawei.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> Drop tags
> Fix correction accounting
> Split out overflow checking
> ---
>   drivers/resctrl/mpam_devices.c  | 126 +++++++++++++++++++++++++++++++-
>   drivers/resctrl/mpam_internal.h |  21 +++++-
>   2 files changed, 145 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 86abbac5e1ad..2d1cef824b8e 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -994,6 +994,7 @@ static void __ris_msmon_read(void *arg)
>   	struct mon_read *m = arg;
>   	struct mon_cfg *ctx = m->ctx;
>   	struct mpam_msc_ris *ris = m->ris;
> +	struct msmon_mbwu_state *mbwu_state;
>   	struct mpam_props *rprops = &ris->props;
>   	struct mpam_msc *msc = m->ris->vmsc->msc;
>   	u32 mon_sel, ctl_val, flt_val, cur_ctl, cur_flt;
> @@ -1024,11 +1025,21 @@ static void __ris_msmon_read(void *arg)
>   		now = mpam_read_monsel_reg(msc, CSU);
>   		if (mpam_has_feature(mpam_feat_msmon_csu_hw_nrdy, rprops))
>   			nrdy = now & MSMON___NRDY;
> +		now = FIELD_GET(MSMON___VALUE, now);
>   		break;
>   	case mpam_feat_msmon_mbwu:
>   		now = mpam_read_monsel_reg(msc, MBWU);
>   		if (mpam_has_feature(mpam_feat_msmon_mbwu_hw_nrdy, rprops))
>   			nrdy = now & MSMON___NRDY;
> +		now = FIELD_GET(MSMON___VALUE, now);
> +
> +		if (nrdy)
> +			break;
> +
> +		mbwu_state = &ris->mbwu_state[ctx->mon];
> +
> +		/* Include bandwidth consumed before the last hardware reset */
> +		now += mbwu_state->correction;
>   		break;
>   	default:
>   		m->err = -EINVAL;
> @@ -1041,7 +1052,6 @@ static void __ris_msmon_read(void *arg)
>   		return;
>   	}
>   
> -	now = FIELD_GET(MSMON___VALUE, now);
>   	*m->val += now;
>   }
>   
> @@ -1239,6 +1249,67 @@ static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
>   	mutex_unlock(&msc->part_sel_lock);
>   }
>   
> +/* Call with msc cfg_lock held */
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
> +/* Call with MSC cfg_lock held */
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
>   static void mpam_init_reset_cfg(struct mpam_config *reset_cfg)
>   {
>   	*reset_cfg = (struct mpam_config) {
> @@ -1310,6 +1381,9 @@ static void mpam_reset_msc(struct mpam_msc *msc, bool online)
>   		 * for non-zero partid may be lost while the CPUs are offline.
>   		 */
>   		ris->in_reset_state = online;
> +
> +		if (mpam_is_enabled() && !online)
> +			mpam_touch_msc(msc, &mpam_save_mbwu_state, ris);
>   	}
>   	mutex_unlock(&msc->cfg_lock);
>   }
> @@ -1364,6 +1438,9 @@ static void mpam_reprogram_msc(struct mpam_msc *msc)
>   			mpam_touch_msc(msc, __write_config, &arg);
>   		}
>   		ris->in_reset_state = reset;
> +
> +		if (mpam_has_feature(mpam_feat_msmon_mbwu, &ris->props))
> +			mpam_touch_msc(msc, &mpam_restore_mbwu_state, ris);
>   	}
>   	mutex_unlock(&msc->cfg_lock);
>   }
> @@ -2117,7 +2194,22 @@ static void mpam_unregister_irqs(void)
>   
>   static void __destroy_component_cfg(struct mpam_component *comp)
>   {
> +	struct mpam_msc *msc;
> +	struct mpam_vmsc *vmsc;
> +	struct mpam_msc_ris *ris;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
>   	add_to_garbage(comp->cfg);
> +	list_for_each_entry(vmsc, &comp->vmsc, comp_list) {
> +		msc = vmsc->msc;
> +
> +		if (mpam_mon_sel_lock(msc)) {
> +			list_for_each_entry(ris, &vmsc->ris, vmsc_list)
> +				add_to_garbage(ris->mbwu_state);
> +			mpam_mon_sel_unlock(msc);
> +		}
> +	}
>   }
>   
>   static void mpam_reset_component_cfg(struct mpam_component *comp)
> @@ -2141,6 +2233,8 @@ static void mpam_reset_component_cfg(struct mpam_component *comp)
>   
>   static int __allocate_component_cfg(struct mpam_component *comp)
>   {
> +	struct mpam_vmsc *vmsc;
> +
>   	mpam_assert_partid_sizes_fixed();
>   
>   	if (comp->cfg)
> @@ -2158,6 +2252,36 @@ static int __allocate_component_cfg(struct mpam_component *comp)
>   
>   	mpam_reset_component_cfg(comp);
>   
> +	list_for_each_entry(vmsc, &comp->vmsc, comp_list) {
> +		struct mpam_msc *msc;
> +		struct mpam_msc_ris *ris;
> +		struct msmon_mbwu_state *mbwu_state;
> +
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
> +				return -ENOMEM;
> +			}
> +
> +			init_garbage(&mbwu_state[0].garbage);
> +
> +			if (mpam_mon_sel_lock(msc)) {
> +				ris->mbwu_state = mbwu_state;
> +				mpam_mon_sel_unlock(msc);
> +			}
> +		}
> +	}
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index d8f8e29987e0..1f2b04b7703e 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -91,7 +91,10 @@ struct mpam_msc {
>   	 */
>   	struct mutex		part_sel_lock;
>   
> -	/* cfg_lock protects the msc configuration. */
> +	/*
> +	 * cfg_lock protects the msc configuration and guards against mbwu_state
> +	 * and save and restore racing.
> +	 */
>   	struct mutex		cfg_lock;
>   
>   	/*
> @@ -200,6 +203,19 @@ struct mon_cfg {
>   	enum mon_filter_options opts;
>   };
>   
> +/* Changes to msmon_mbwu_state are protected by the msc's mon_sel_lock. */
> +struct msmon_mbwu_state {
> +	bool		enabled;
> +	struct mon_cfg	cfg;
> +
> +	/*
> +	 * The value to add to the new reading to account for power management.
> +	 */
> +	u64		correction;
> +
> +	struct mpam_garbage	garbage;
> +};
> +
>   struct mpam_class {
>   	/* mpam_components in this class */
>   	struct list_head	components;
> @@ -293,6 +309,9 @@ struct mpam_msc_ris {
>   	/* parent: */
>   	struct mpam_vmsc	*vmsc;
>   
> +	/* msmon mbwu configuration is preserved over reset */
> +	struct msmon_mbwu_state	*mbwu_state;
> +
>   	struct mpam_garbage	garbage;
>   };
>   

Reviewed-by: Zeng Heng <zengheng4@huawei.com>

