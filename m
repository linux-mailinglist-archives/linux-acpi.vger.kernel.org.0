Return-Path: <linux-acpi+bounces-18706-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D036BC4498C
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 00:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E47F3B04D2
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Nov 2025 23:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A9F26ED2B;
	Sun,  9 Nov 2025 22:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQlOthai";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cWe/CUBU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705D72594B9
	for <linux-acpi@vger.kernel.org>; Sun,  9 Nov 2025 22:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762729198; cv=none; b=CReggKYtqjnQ61G2BLFm3Ohu+8gNfgUwmtWJMG0NUgz1eSrhS9TbBLf+0SgDdiDqnwXPbIPFy0K53jtnDx5+Po2PbEpA/RCYWPjkzpkgf/8W3E81/oWBhTC8tIw4T+p++CmU8VfUCzoNwAOYzxcIGJmil1S6wZ6y4gv0yB+E9IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762729198; c=relaxed/simple;
	bh=lVXRTPlTxPAijL8xTEEFXxrnxnD5S/Rd3PoPKk/8/3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SYs1mcv51o6fRhiinOZp92G4WMoIVYNL6o9JyEizxmQocL2bmbBkACfye5D5fcs18BTc1lPmtZWr+mDhNglMH0klt1aN20SWUPExK4+4DzI9ho7sd3rztyV+wSmK/Zz3hMPyFWYnVs41q78bJGNAD7eqQ1zY46PLtO50yW/Jnc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OQlOthai; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cWe/CUBU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762729192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sw8CrBV05AO5Nvkk8UzNDcbqjB36gaK/xhWONAU3tk0=;
	b=OQlOthaikoyiz0mVn578otKBumlGLLpLcYdh8f0Wyfoy3IFln7xAOVp1+OKmoP849oyeQd
	TF6zRoGPzMnKtpcP8voFR3ODIh3frL+YIx6w7GxVCXOkcQn1G6viMJ+0s/K+Hq1UkVF6i9
	29S4FYr05+bpq36+zJPMbRSiBdooqg4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-DS-ykwNvOeW3Ngrh1m5brQ-1; Sun, 09 Nov 2025 17:59:50 -0500
X-MC-Unique: DS-ykwNvOeW3Ngrh1m5brQ-1
X-Mimecast-MFC-AGG-ID: DS-ykwNvOeW3Ngrh1m5brQ_1762729190
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-341aec498fdso3731238a91.2
        for <linux-acpi@vger.kernel.org>; Sun, 09 Nov 2025 14:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762729190; x=1763333990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sw8CrBV05AO5Nvkk8UzNDcbqjB36gaK/xhWONAU3tk0=;
        b=cWe/CUBU0FrmbGE6YWBbHP84M9WbfY5jQ23KFyldKY2vqCbglaArYLnY6bk9j7nItH
         h24GxPP0YFZz7Xsz8tBw/qt5cqtsuEQ/Tu4gQZpDpHHRUg55CjivQ9Aq23wpRcw7gMiV
         rco9uvLS8OVefKGpmz8Tu8IClW1ID4i5a9d2/aJxai06ugCCwhJ6v6mS1C4KvdtCUNT4
         mdCycYN0Nwx7n2268GVB82RBwjMWkgKO2WUvoSONGaZJRw9vwCg2lluqaAiaJvTY4Xg4
         ZojYQQ8rH+IVSL4HhG1zTfNIey5Rx/Ja8V/H8R8EoH84FilG8+s/IQWfXUJ771hVHauB
         YM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762729190; x=1763333990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sw8CrBV05AO5Nvkk8UzNDcbqjB36gaK/xhWONAU3tk0=;
        b=ExMlMMF2iJwyBb5yqoplzbsJJ0sRv+6vXYHUJkZVoKOEm6OitEbPDd662MCPqdY4iR
         tToDB4ZxYknFrFD4IqN8JMxPaqeQ5GRd46NrJwQvDHlWKc1PPOQVTHqTZioazmvtOVKG
         WDsouPkUvwOkhWpd8gTBVqYM4rR2/JuX62PcBGaz5LslSTjWdpI6RwRgAp7UnoEaBniF
         eCvhifIpZNEfr7DINkBVLhtqB0kED4osr/NlRLpBBEQ9SSiKyB2FWgU1WVjn0RIf0Q/M
         h7erhxIKW6F4Wf/hm3PCmyVGDG9YU3pSyzRXXQ/NMXzMVYdZlG0jQQorooxZ+avZGHUV
         2eSA==
X-Forwarded-Encrypted: i=1; AJvYcCXZBb6a1C9xx1twRrwA1FvXWCIRSuU6Ep6923wzuuKFROVwnrAMAasSRxz38fD8Ewiszyaavs8E5xOl@vger.kernel.org
X-Gm-Message-State: AOJu0YxKZSgMvVaEW4jQrkvduTQsW1NnTPrYlbHG/2J9/lh0hcBaAVRY
	YanLjPgO3vyEFp1bLDzYmCZycvK/wqoD+V86jINHcbNJClH/BIpA60w9DgwYsqkyJgfd3VYMPXa
	4RAT3ru5AKS0s8v7YF3Ob/q6RkASKLfcyVyON8QgYItrfnVTAxsxSipw+47McHHQ=
X-Gm-Gg: ASbGncvUb9m3zHaR3bQI2lGetXJeX8jBGQZMnSM1A+q2C6xDMDLw7ZG3qgtnykSOuxt
	KkQ9doZdjMeBQ3clImARmTWFh+dZLkxY8M/dC9tb1LDGev87Z1PsaFRiVKHz3DBGh1P4r+6G6oA
	GFV4BsKM/akKeuhRFXnIGmd+W1+neWPFMYjOnHDn9bcod3bDKYRzfJlMC9BloH73F5YiclUJVjo
	47vxD315ntdCU8rX4wuvCl4WBuOW2HCjxYGu+R3+wq+ZY/swqOXz3RXW0dVTAzpQKPXl5GLpztC
	CioftxIWnmc7xZBgue4VGQbAxRd8E6H6/quDcu6s4bvAAm/2lfDkqr19aV0LYoe3w4arr9Dh5SX
	k9izxQFGRtP6k3W4Kalchc17fCF62fytCXKuX+hU=
X-Received: by 2002:a17:90b:4b0e:b0:33b:bed8:891e with SMTP id 98e67ed59e1d1-3436cb91e05mr9074472a91.19.1762729189572;
        Sun, 09 Nov 2025 14:59:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEy1VWfCk2l3lGJLjo1ywotcoYT+aMBtO2f4pshYG3XVzKJ/TOFfY9N9+JauCQiTd0Felft1A==
X-Received: by 2002:a17:90b:4b0e:b0:33b:bed8:891e with SMTP id 98e67ed59e1d1-3436cb91e05mr9074424a91.19.1762729189073;
        Sun, 09 Nov 2025 14:59:49 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f8d7eedcsm10930841a12.2.2025.11.09.14.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 14:59:48 -0800 (PST)
Message-ID: <07acf54a-231f-428d-ac94-f4f9ec95de21@redhat.com>
Date: Mon, 10 Nov 2025 08:59:35 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/33] arm_mpam: Allow configuration to be applied and
 restored during cpu online
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-24-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-24-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> When CPUs come online the MSC's original configuration should be restored.
> 
> Add struct mpam_config to hold the configuration. This has a bitmap of
> features that were modified. Once the maximum partid is known, allocate
> a configuration array for each component, and reprogram each RIS
> configuration from this.
> 
> CC: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Cc: Shaopeng Tan (Fujitsu) tan.shaopeng@fujitsu.com
> Cc: Peter Newman peternewman@google.com
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> Drop tags
> Fix component reset, otherwise cpbm wrong and controls not set.
> Add a cfg_lock to guard configuration of an msc
> ---
>   drivers/resctrl/mpam_devices.c  | 268 ++++++++++++++++++++++++++++++--
>   drivers/resctrl/mpam_internal.h |  27 ++++
>   2 files changed, 280 insertions(+), 15 deletions(-)
> 

With the following comments addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 3a0ad8d93fff..8b0944bdaf28 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -144,6 +144,16 @@ static void mpam_free_garbage(void)
>   	}
>   }
>   
> +/*
> + * Once mpam is enabled, new requestors cannot further reduce the available
> + * partid. Assert that the size is fixed, and new requestors will be turned
> + * away.
> + */
> +static void mpam_assert_partid_sizes_fixed(void)
> +{
> +	WARN_ON_ONCE(!partid_max_published);
> +}
> +

Would be worthy to be a online function.

>   static u32 __mpam_read_reg(struct mpam_msc *msc, u16 reg)
>   {
>   	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
> @@ -343,6 +353,7 @@ mpam_component_alloc(struct mpam_class *class, int id)
>   	return comp;
>   }
>   
> +static void __destroy_component_cfg(struct mpam_component *comp);
>   static void mpam_class_destroy(struct mpam_class *class);
>   
>   static void mpam_component_destroy(struct mpam_component *comp)
> @@ -351,6 +362,8 @@ static void mpam_component_destroy(struct mpam_component *comp)
>   
>   	lockdep_assert_held(&mpam_list_lock);
>   
> +	__destroy_component_cfg(comp);
> +
>   	list_del_rcu(&comp->class_list);
>   	add_to_garbage(comp);
>   
> @@ -820,31 +833,59 @@ static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
>   	__mpam_write_reg(msc, reg, bm);
>   }
>   
> -static void mpam_reset_ris_partid(struct mpam_msc_ris *ris, u16 partid)
> +/* Called via IPI. Call while holding an SRCU reference */
> +static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
> +				      struct mpam_config *cfg)
>   {
>   	struct mpam_msc *msc = ris->vmsc->msc;
>   	struct mpam_props *rprops = &ris->props;
>   
> -	WARN_ON_ONCE(!srcu_read_lock_held((&mpam_srcu)));
> -
>   	mutex_lock(&msc->part_sel_lock);
>   	__mpam_part_sel(ris->ris_idx, partid, msc);
>   
> -	if (mpam_has_feature(mpam_feat_cpor_part, rprops))
> -		mpam_reset_msc_bitmap(msc, MPAMCFG_CPBM, rprops->cpbm_wd);
> +	if (mpam_has_feature(mpam_feat_cpor_part, rprops) &&
> +	    mpam_has_feature(mpam_feat_cpor_part, cfg)) {
> +		if (cfg->reset_cpbm)
> +			mpam_reset_msc_bitmap(msc, MPAMCFG_CPBM,
> +					      rprops->cpbm_wd);
> +		else
> +			mpam_write_partsel_reg(msc, CPBM, cfg->cpbm);
> +	}

{} is needed by 'if (cfg->reset_cpbm)'

>   
> -	if (mpam_has_feature(mpam_feat_mbw_part, rprops))
> -		mpam_reset_msc_bitmap(msc, MPAMCFG_MBW_PBM, rprops->mbw_pbm_bits);
> +	if (mpam_has_feature(mpam_feat_mbw_part, rprops) &&
> +	    mpam_has_feature(mpam_feat_mbw_part, cfg)) {
> +		if (cfg->reset_mbw_pbm)
> +			mpam_reset_msc_bitmap(msc, MPAMCFG_MBW_PBM,
> +					      rprops->mbw_pbm_bits);
> +		else
> +			mpam_write_partsel_reg(msc, MBW_PBM, cfg->mbw_pbm);
> +	}
>   

{ } is need by 'if (cfg->reset_mbw_pbm)'

> -	if (mpam_has_feature(mpam_feat_mbw_min, rprops))
> +	if (mpam_has_feature(mpam_feat_mbw_min, rprops) &&
> +	    mpam_has_feature(mpam_feat_mbw_min, cfg))
>   		mpam_write_partsel_reg(msc, MBW_MIN, 0);
>   
> -	if (mpam_has_feature(mpam_feat_mbw_max, rprops))
> -		mpam_write_partsel_reg(msc, MBW_MAX, MPAMCFG_MBW_MAX_MAX);
> +	if (mpam_has_feature(mpam_feat_mbw_max, rprops) &&
> +	    mpam_has_feature(mpam_feat_mbw_max, cfg)) {
> +		if (cfg->reset_mbw_max)
> +			mpam_write_partsel_reg(msc, MBW_MAX, MPAMCFG_MBW_MAX_MAX);
> +		else
> +			mpam_write_partsel_reg(msc, MBW_MAX, cfg->mbw_max);
> +	}
>   
>   	mutex_unlock(&msc->part_sel_lock);
>   }
>   
> +static void mpam_init_reset_cfg(struct mpam_config *reset_cfg)
> +{
> +	*reset_cfg = (struct mpam_config) {
> +		.reset_cpbm = true,
> +		.reset_mbw_pbm = true,
> +		.reset_mbw_max = true,
> +	};
> +	bitmap_fill(reset_cfg->features, MPAM_FEATURE_LAST);
> +}
> +
>   /*
>    * Called via smp_call_on_cpu() to prevent migration, while still being
>    * pre-emptible. Caller must hold mpam_srcu.
> @@ -852,16 +893,19 @@ static void mpam_reset_ris_partid(struct mpam_msc_ris *ris, u16 partid)
>   static int mpam_reset_ris(void *arg)
>   {
>   	u16 partid, partid_max;
> +	struct mpam_config reset_cfg;
>   	struct mpam_msc_ris *ris = arg;
>   
>   	if (ris->in_reset_state)
>   		return 0;
>   
> +	mpam_init_reset_cfg(&reset_cfg);
> +
>   	spin_lock(&partid_max_lock);
>   	partid_max = mpam_partid_max;
>   	spin_unlock(&partid_max_lock);
>   	for (partid = 0; partid <= partid_max; partid++)
> -		mpam_reset_ris_partid(ris, partid);
> +		mpam_reprogram_ris_partid(ris, partid, &reset_cfg);
>   
>   	return 0;
>   }
> @@ -894,6 +938,7 @@ static void mpam_reset_msc(struct mpam_msc *msc, bool online)
>   {
>   	struct mpam_msc_ris *ris;
>   
> +	mutex_lock(&msc->cfg_lock);
>   	list_for_each_entry_srcu(ris, &msc->ris, msc_list, srcu_read_lock_held(&mpam_srcu)) {
>   		mpam_touch_msc(msc, &mpam_reset_ris, ris);
>   
> @@ -903,6 +948,61 @@ static void mpam_reset_msc(struct mpam_msc *msc, bool online)
>   		 */
>   		ris->in_reset_state = online;
>   	}
> +	mutex_unlock(&msc->cfg_lock);
> +}
> +
> +struct mpam_write_config_arg {
> +	struct mpam_msc_ris *ris;
> +	struct mpam_component *comp;
> +	u16 partid;
> +};
> +
> +static int __write_config(void *arg)
> +{
> +	struct mpam_write_config_arg *c = arg;
> +
> +	mpam_reprogram_ris_partid(c->ris, c->partid, &c->comp->cfg[c->partid]);
> +
> +	return 0;
> +}
> +
> +static void mpam_reprogram_msc(struct mpam_msc *msc)
> +{
> +	u16 partid;
> +	bool reset;
> +	struct mpam_config *cfg;
> +	struct mpam_msc_ris *ris;
> +	struct mpam_write_config_arg arg;
> +
> +	/*
> +	 * No lock for mpam_partid_max as partid_max_published has been
> +	 * set by mpam_enabled(), so the values can no longer change.
> +	 */
> +	mpam_assert_partid_sizes_fixed();
> +
> +	mutex_lock(&msc->cfg_lock);
> +	list_for_each_entry_srcu(ris, &msc->ris, msc_list,
> +				 srcu_read_lock_held(&mpam_srcu)) {
> +		if (!mpam_is_enabled() && !ris->in_reset_state) {
> +			mpam_touch_msc(msc, &mpam_reset_ris, ris);
> +			ris->in_reset_state = true;
> +			continue;
> +		}
> +
> +		arg.comp = ris->vmsc->comp;
> +		arg.ris = ris;
> +		reset = true;
> +		for (partid = 0; partid <= mpam_partid_max; partid++) {
> +			cfg = &ris->vmsc->comp->cfg[partid];
> +			if (!bitmap_empty(cfg->features, MPAM_FEATURE_LAST))
> +				reset = false;
> +

s/!bitmap_empty()/!bitmap_full (?)

> +			arg.partid = partid;
> +			mpam_touch_msc(msc, __write_config, &arg);
> +		}
> +		ris->in_reset_state = reset;
> +	}
> +	mutex_unlock(&msc->cfg_lock);
>   }
>   
>   static void _enable_percpu_irq(void *_irq)
> @@ -926,7 +1026,7 @@ static int mpam_cpu_online(unsigned int cpu)
>   			_enable_percpu_irq(&msc->reenable_error_ppi);
>   
>   		if (atomic_fetch_inc(&msc->online_refs) == 0)
> -			mpam_reset_msc(msc, true);
> +			mpam_reprogram_msc(msc);
>   	}
>   
>   	return 0;
> @@ -1125,6 +1225,9 @@ static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>   	if (err)
>   		return ERR_PTR(err);
>   	err = devm_mutex_init(dev, &msc->error_irq_lock);
> +	if (err)
> +		return ERR_PTR(err);
> +	err = devm_mutex_init(dev, &msc->cfg_lock);
>   	if (err)
>   		return ERR_PTR(err);
>   	mpam_mon_sel_lock_init(msc);
> @@ -1585,6 +1688,70 @@ static void mpam_unregister_irqs(void)
>   	}
>   }
>   
> +static void __destroy_component_cfg(struct mpam_component *comp)
> +{
> +	add_to_garbage(comp->cfg);
> +}
> +
> +static void mpam_reset_component_cfg(struct mpam_component *comp)
> +{
> +	int i;
> +	struct mpam_props *cprops = &comp->class->props;
> +
> +	mpam_assert_partid_sizes_fixed();
> +
> +	if (!comp->cfg)
> +		return;
> +
> +	for (i = 0; i <= mpam_partid_max; i++) {
> +		comp->cfg[i] = (struct mpam_config) {};
> +		bitmap_fill(comp->cfg[i].features, MPAM_FEATURE_LAST);
> +		bitmap_set((unsigned long *)&comp->cfg[i].cpbm, 0, cprops->cpbm_wd);
> +		bitmap_set((unsigned long *)&comp->cfg[i].mbw_pbm, 0, cprops->mbw_pbm_bits);
> +		bitmap_set((unsigned long *)&comp->cfg[i].mbw_max, 16 - cprops->bwa_wd, cprops->bwa_wd);
> +	}
> +}
> +
> +static int __allocate_component_cfg(struct mpam_component *comp)
> +{
> +	mpam_assert_partid_sizes_fixed();
> +
> +	if (comp->cfg)
> +		return 0;
> +
> +	comp->cfg = kcalloc(mpam_partid_max + 1, sizeof(*comp->cfg), GFP_KERNEL);
> +	if (!comp->cfg)
> +		return -ENOMEM;
> +
> +	/*
> +	 * The array is free()d in one go, so only cfg[0]'s structure needs
> +	 * to be initialised.
> +	 */
> +	init_garbage(&comp->cfg[0].garbage);
> +
> +	mpam_reset_component_cfg(comp);
> +
> +	return 0;
> +}
> +
> +static int mpam_allocate_config(void)
> +{
> +	struct mpam_class *class;
> +	struct mpam_component *comp;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_for_each_entry(class, &mpam_classes, classes_list) {
> +		list_for_each_entry(comp, &class->components, class_list) {
> +			int err = __allocate_component_cfg(comp);
> +			if (err)
> +				return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   static void mpam_enable_once(void)
>   {
>   	int err;
> @@ -1604,15 +1771,25 @@ static void mpam_enable_once(void)
>   	 */
>   	cpus_read_lock();
>   	mutex_lock(&mpam_list_lock);
> -	mpam_enable_merge_features(&mpam_classes);
> +	do {
> +		mpam_enable_merge_features(&mpam_classes);
>   
> -	err = mpam_register_irqs();
> +		err = mpam_register_irqs();
> +		if (err) {
> +			pr_warn("Failed to register irqs: %d\n", err);
> +			break;
> +		}
>   
> +		err = mpam_allocate_config();
> +		if (err) {
> +			pr_err("Failed to allocate configuration arrays.\n");
> +			break;
> +		}
> +	} while (0);
>   	mutex_unlock(&mpam_list_lock);
>   	cpus_read_unlock();
>   
>   	if (err) {
> -		pr_warn("Failed to register irqs: %d\n", err);
>   		mpam_disable_reason = "Failed to enable.";
>   		schedule_work(&mpam_broken_work);
>   		return;
> @@ -1632,6 +1809,9 @@ static void mpam_reset_component_locked(struct mpam_component *comp)
>   	struct mpam_vmsc *vmsc;
>   
>   	lockdep_assert_cpus_held();
> +	mpam_assert_partid_sizes_fixed();
> +
> +	mpam_reset_component_cfg(comp);
>   
>   	guard(srcu)(&mpam_srcu);
>   	list_for_each_entry_srcu(vmsc, &comp->vmsc, comp_list,
> @@ -1732,6 +1912,64 @@ void mpam_enable(struct work_struct *work)
>   		mpam_enable_once();
>   }
>   
> +#define maybe_update_config(cfg, feature, newcfg, member, changes) do { \
> +	if (mpam_has_feature(feature, newcfg) &&			\
> +	    (newcfg)->member != (cfg)->member) {			\
> +		(cfg)->member = (newcfg)->member;			\
> +		mpam_set_feature(feature, cfg);				\
> +									\
> +		(changes) = true;					\
> +	}								\
> +} while (0)
> +
> +static bool mpam_update_config(struct mpam_config *cfg,
> +			       const struct mpam_config *newcfg)
> +{
> +	bool has_changes = false;
> +
> +	maybe_update_config(cfg, mpam_feat_cpor_part, newcfg, cpbm, has_changes);
> +	maybe_update_config(cfg, mpam_feat_mbw_part, newcfg, mbw_pbm, has_changes);
> +	maybe_update_config(cfg, mpam_feat_mbw_max, newcfg, mbw_max, has_changes);
> +
> +	return has_changes;
> +}
> +
> +int mpam_apply_config(struct mpam_component *comp, u16 partid,
> +		      struct mpam_config *cfg)
> +{
> +	struct mpam_write_config_arg arg;
> +	struct mpam_msc_ris *ris;
> +	struct mpam_vmsc *vmsc;
> +	struct mpam_msc *msc;
> +
> +	lockdep_assert_cpus_held();
> +
> +	/* Don't pass in the current config! */
> +	WARN_ON_ONCE(&comp->cfg[partid] == cfg);
> +
> +	if (!mpam_update_config(&comp->cfg[partid], cfg))
> +		return 0;
> +
> +	arg.comp = comp;
> +	arg.partid = partid;
> +
> +	guard(srcu)(&mpam_srcu);
> +	list_for_each_entry_srcu(vmsc, &comp->vmsc, comp_list,
> +				 srcu_read_lock_held(&mpam_srcu)) {
> +		msc = vmsc->msc;
> +
> +		mutex_lock(&msc->cfg_lock);
> +		list_for_each_entry_srcu(ris, &vmsc->ris, vmsc_list,
> +					 srcu_read_lock_held(&mpam_srcu)) {
> +			arg.ris = ris;
> +			mpam_touch_msc(msc, __write_config, &arg);
> +		}
> +		mutex_unlock(&msc->cfg_lock);
> +	}
> +
> +	return 0;
> +}
> +
>   static int __init mpam_msc_driver_init(void)
>   {
>   	if (!system_supports_mpam())
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index c6937161877a..842d32f148b5 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -91,6 +91,9 @@ struct mpam_msc {
>   	 */
>   	struct mutex		part_sel_lock;
>   
> +	/* cfg_lock protects the msc configuration. */
> +	struct mutex		cfg_lock;
> +
>   	/*
>   	 * mon_sel_lock protects access to the MSC hardware registers that are
>   	 * affected by MPAMCFG_MON_SEL, and the mbwu_state.
> @@ -180,6 +183,21 @@ struct mpam_class {
>   	struct mpam_garbage	garbage;
>   };
>   
> +struct mpam_config {
> +	/* Which configuration values are valid. */
> +	DECLARE_BITMAP(features, MPAM_FEATURE_LAST);
> +
> +	u32	cpbm;
> +	u32	mbw_pbm;
> +	u16	mbw_max;
> +
> +	bool	reset_cpbm;
> +	bool	reset_mbw_pbm;
> +	bool	reset_mbw_max;
> +
> +	struct mpam_garbage	garbage;
> +};
> +
>   struct mpam_component {
>   	u32			comp_id;
>   
> @@ -188,6 +206,12 @@ struct mpam_component {
>   
>   	cpumask_t		affinity;
>   
> +	/*
> +	 * Array of configuration values, indexed by partid.
> +	 * Read from cpuhp callbacks, hold the cpuhp lock when writing.
> +	 */
> +	struct mpam_config	*cfg;
> +
>   	/* member of mpam_class:components */
>   	struct list_head	class_list;
>   
> @@ -247,6 +271,9 @@ extern u8 mpam_pmg_max;
>   void mpam_enable(struct work_struct *work);
>   void mpam_disable(struct work_struct *work);
>   
> +int mpam_apply_config(struct mpam_component *comp, u16 partid,
> +		      struct mpam_config *cfg);
> +
>   int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
>   				   cpumask_t *affinity);
>   

Thanks,
Gavin


