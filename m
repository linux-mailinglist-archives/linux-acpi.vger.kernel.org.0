Return-Path: <linux-acpi+bounces-18297-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67264C1639A
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Oct 2025 18:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075453A8FD4
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Oct 2025 17:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D0534C83D;
	Tue, 28 Oct 2025 17:37:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB5E3314B8;
	Tue, 28 Oct 2025 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673032; cv=none; b=tDx3NEZYB92yUVlip78wZutb3cjEq0cdmOnKoV6xs9wlsRIoIYCD3fdoMNGkd5ARIaT74cW7VCSYGFrypc96/Th+bJxuiJzsbD54QC/j4AAqsGeumez2DJprDxFbPB9bF341EgfL7b6Sbzj4D5qIKSNAInP8Wv/3GoyUJEVb+rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673032; c=relaxed/simple;
	bh=G3TLd8Hl1Ec17sjc6IMx64ueGdYu5PtD8M1IERWgHdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQx0PeRosK6QBZUT1G2kWIsT4cFzNX8is1ZKpuu2HvP4TFT11KYmYnv9bF/z8M/Sj71JKGZRVYozwLUa/b7AyWpezzLMOFHOulDL5V4SOuTFntjEzYnSS99711sOTT0i4B7nLn2yIg8BYu8Nbhhdp5gyUtOl/uIDoQ9inivcs2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA05C168F;
	Tue, 28 Oct 2025 10:37:01 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D3223F673;
	Tue, 28 Oct 2025 10:37:03 -0700 (PDT)
Message-ID: <d91f65fb-900f-4d21-ad5e-0cbe146bbb65@arm.com>
Date: Tue, 28 Oct 2025 17:37:02 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mpam: Clean MBWU monitor overflow bit
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
 sunnanyong@huawei.com, tan.shaopeng@fujitsu.com, wangkefeng.wang@huawei.com,
 will@kernel.org, xhao@linux.alibaba.com
References: <a3e95937-b0c7-020e-d52d-7189d2540f8f@huawei.com>
 <20251025093428.1379218-1-zengheng4@huawei.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20251025093428.1379218-1-zengheng4@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Zeng,

On 10/25/25 10:34, Zeng Heng wrote:
> The MSMON_MBWU register accumulates counts monotonically forward and
> would not automatically cleared to zero on overflow. The overflow portion
> is exactly what mpam_msmon_overflow_val() computes, there is no need to
> additionally subtract mbwu_state->prev_val.
> 
> Before invoking write_msmon_ctl_flt_vals(), the overflow bit of the
> MSMON_MBWU register must first be read to prevent it from being
> inadvertently cleared by the write operation. Then, before updating the
> monitor configuration, the overflow bit should be cleared to zero.
> 
> Finally, use the overflow bit instead of relying on counter wrap-around
> to determine whether an overflow has occurred, that avoids the case where
> a wrap-around (now > prev_val) is overlooked.
> 
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> ---
>  drivers/resctrl/mpam_devices.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 0dd048279e02..575980e3a366 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -1062,6 +1062,21 @@ static u64 mpam_msmon_overflow_val(enum mpam_device_features type)
>  	}
>  }
>  
> +static bool read_msmon_mbwu_is_overflow(struct mpam_msc *msc)
> +{
> +	u32 ctl;
> +	bool overflow;
> +
> +	ctl = mpam_read_monsel_reg(msc, CFG_MBWU_CTL);
> +	overflow = ctl & MSMON_CFG_x_CTL_OFLOW_STATUS ? true : false;
> +
> +	if (overflow)
> +		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl &
> +				     ~MSMON_CFG_x_CTL_OFLOW_STATUS);


Seems sensible. It's best to consider the overflow status bit for long
counters as well. Although, that's introduced later in the series so
depends on patch ordering. (Sorry, was considering patches on top of the
full series when I commented on counter length before.)

> +
> +	return overflow;
> +}
> +
>  /* Call with MSC lock held */
>  static void __ris_msmon_read(void *arg)
>  {
> @@ -1069,6 +1084,7 @@ static void __ris_msmon_read(void *arg)
>  	bool config_mismatch;
>  	struct mon_read *m = arg;
>  	u64 now, overflow_val = 0;
> +	bool mbwu_overflow = false;
>  	struct mon_cfg *ctx = m->ctx;
>  	bool reset_on_next_read = false;
>  	struct mpam_msc_ris *ris = m->ris;
> @@ -1091,6 +1107,7 @@ static void __ris_msmon_read(void *arg)
>  			reset_on_next_read = mbwu_state->reset_on_next_read;
>  			mbwu_state->reset_on_next_read = false;
>  		}
> +		mbwu_overflow = read_msmon_mbwu_is_overflow(msc);

If the config is then found to mismatch, then mbwu_overflow can be
subsequently set to false.

>  	}
>  
>  	/*
> @@ -1138,8 +1155,8 @@ static void __ris_msmon_read(void *arg)
>  		mbwu_state = &ris->mbwu_state[ctx->mon];
>  
>  		/* Add any pre-overflow value to the mbwu_state->val */
> -		if (mbwu_state->prev_val > now)
> -			overflow_val = mpam_msmon_overflow_val(m->type) - mbwu_state->prev_val;
> +		if (mbwu_overflow)
> +			overflow_val = mpam_msmon_overflow_val(m->type);

Yep, makes sense.

>  
>  		mbwu_state->prev_val = now;

With this prev_val no longer has any use.

>  		mbwu_state->correction += overflow_val;
Thanks,

Ben


