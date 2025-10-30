Return-Path: <linux-acpi+bounces-18362-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C6CC1F641
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 10:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36BF3A8250
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 09:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FB034D90C;
	Thu, 30 Oct 2025 09:52:15 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB44345CDE;
	Thu, 30 Oct 2025 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817935; cv=none; b=i1t9dYnesUJ4sK40o1srwh+vRy/ycP9PV43iphhtd4LLGjVq619ubbegMUcZpuWI0SBhDS6c9mYeeVn0JWrB/V1hW986+Xqqw4byDIU7uNSGnVQoCXgT55/gyh98gapC5PdjzPlVPLxkcv2rIy9LKNLzJhh0DUqwXdA/YRWgO60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817935; c=relaxed/simple;
	bh=pN3hOFIXroAR6CNCJvl1O8GGA3nog7ikdyVo9EX3BkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ACZrTRIBX5xKOhZlc0e8waXNT1YmNg11O5vujWbhIMSV1p/eP6CX7TFu+NEWwiFBHhSaM/nGmHBjhsAQ7tPFUazt2mW0EGQJeebveBEm8v5FmtGRROKvJhQTjnCgj0KXsbsUyRa3OBSu/Wq2fnHIYXwcFj4iHGfqdjP2aNHGQvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BB05152B;
	Thu, 30 Oct 2025 02:52:05 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5958E3F66E;
	Thu, 30 Oct 2025 02:52:08 -0700 (PDT)
Message-ID: <b0ea1879-9e77-4eb3-8312-ce27d73cc1f4@arm.com>
Date: Thu, 30 Oct 2025 09:52:06 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64/mpam: Clean MBWU monitor overflow bit
To: Zeng Heng <zengheng4@huawei.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, carl@os.amperecomputing.com,
 catalin.marinas@arm.com, dakr@kernel.org, dave.martin@arm.com,
 david@redhat.com, dfustini@baylibre.com, fenghuay@nvidia.com,
 gregkh@linuxfoundation.org, gshan@redhat.com, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 wangkefeng.wang@huawei.com, sunnanyong@huawei.com
References: <20251017185645.26604-25-james.morse@arm.com>
 <20251029075655.3284280-1-zengheng4@huawei.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20251029075655.3284280-1-zengheng4@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Zeng,

On 10/29/25 07:56, Zeng Heng wrote:
> The MSMON_MBWU register accumulates counts monotonically forward and
> would not automatically cleared to zero on overflow. The overflow portion
> is exactly what mpam_msmon_overflow_val() computes, there is no need to
> additionally subtract mbwu_state->prev_val.
> 
> Before invoking write_msmon_ctl_flt_vals(), the overflow bit of the
> MSMON_MBWU register must first be read to prevent it from being
> inadvertently cleared by the write operation.
> 
> Finally, use the overflow bit instead of relying on counter wrap-around
> to determine whether an overflow has occurred, that avoids the case where
> a wrap-around (now > prev_val) is overlooked. So with this, prev_val no
> longer has any use and remove it.
> 
> CC: Ben Horgan <ben.horgan@arm.com>
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> ---
>  drivers/resctrl/mpam_devices.c  | 22 +++++++++++++++++-----
>  drivers/resctrl/mpam_internal.h |  3 ---
>  2 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 0dd048279e02..db4cec710091 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -1039,7 +1039,6 @@ static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
>  		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
> 
>  		mbwu_state = &m->ris->mbwu_state[m->ctx->mon];
> -		mbwu_state->prev_val = 0;
> 
>  		break;
>  	default:
> @@ -1062,6 +1061,16 @@ static u64 mpam_msmon_overflow_val(enum mpam_device_features type)
>  	}
>  }
> 
> +static bool read_msmon_mbwu_is_overflow(struct mpam_msc *msc)
> +{
> +	u32 ctl;
> +
> +	ctl = mpam_read_monsel_reg(msc, CFG_MBWU_CTL);
> +	return ctl & (MSMON_CFG_x_CTL_OFLOW_STATUS |
> +		      MSMON_CFG_MBWU_CTL_OFLOW_STATUS_L) ?
> +		      true : false;
> +}
> +
>  /* Call with MSC lock held */
>  static void __ris_msmon_read(void *arg)
>  {
> @@ -1069,6 +1078,7 @@ static void __ris_msmon_read(void *arg)
>  	bool config_mismatch;
>  	struct mon_read *m = arg;
>  	u64 now, overflow_val = 0;
> +	bool mbwu_overflow = false;
>  	struct mon_cfg *ctx = m->ctx;
>  	bool reset_on_next_read = false;
>  	struct mpam_msc_ris *ris = m->ris;
> @@ -1091,6 +1101,7 @@ static void __ris_msmon_read(void *arg)
>  			reset_on_next_read = mbwu_state->reset_on_next_read;
>  			mbwu_state->reset_on_next_read = false;
>  		}
> +		mbwu_overflow = read_msmon_mbwu_is_overflow(msc);
>  	}
> 
>  	/*
> @@ -1103,8 +1114,10 @@ static void __ris_msmon_read(void *arg)
>  	config_mismatch = cur_flt != flt_val ||
>  			  cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN);
> 
> -	if (config_mismatch || reset_on_next_read)
> +	if (config_mismatch || reset_on_next_read) {
>  		write_msmon_ctl_flt_vals(m, ctl_val, flt_val);
> +		mbwu_overflow = false;
> +	}
> 
>  	switch (m->type) {
>  	case mpam_feat_msmon_csu:
> @@ -1138,10 +1151,9 @@ static void __ris_msmon_read(void *arg)
>  		mbwu_state = &ris->mbwu_state[ctx->mon];
> 
>  		/* Add any pre-overflow value to the mbwu_state->val */
> -		if (mbwu_state->prev_val > now)
> -			overflow_val = mpam_msmon_overflow_val(m->type) - mbwu_state->prev_val;

This all looks fine for overflow, but what we've been forgetting about
is the power management. As James mentioned in his commit message, the
prev_val is after now check is doing double duty. If an msc is powered
down and reset then we lose the count. Hence, to keep an accurate count,
we should be considering this case too.

> +		if (mbwu_overflow)
> +			overflow_val = mpam_msmon_overflow_val(m->type);
> 
> -		mbwu_state->prev_val = now;
>  		mbwu_state->correction += overflow_val;
> 
>  		/* Include bandwidth consumed before the last hardware reset */
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 4f25681b56ab..8837c0cd7b0c 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -226,9 +226,6 @@ struct msmon_mbwu_state {
>  	bool		reset_on_next_read;
>  	struct mon_cfg	cfg;
> 
> -	/* The value last read from the hardware. Used to detect overflow. */
> -	u64		prev_val;
> -
>  	/*
>  	 * The value to add to the new reading to account for power management,
>  	 * and shifts to trigger the overflow interrupt.
> --
> 2.25.1
> 
> 
> 

-- 
Thanks,

Ben


