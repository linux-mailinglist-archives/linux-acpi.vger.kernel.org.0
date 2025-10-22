Return-Path: <linux-acpi+bounces-18108-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE02BFD3E3
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 18:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4ACB1357C25
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 16:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446E03126A4;
	Wed, 22 Oct 2025 16:17:47 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601E435B15E;
	Wed, 22 Oct 2025 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149867; cv=none; b=bpNGtBKuZpe4x4TabekLX5LrzsCKRAy95ljOsial659h+sDbxzORFJ7JcAj9kEeUJA/462Obl+UmHbrXPGniqlgakjvhOc/PVx+iZcRP+OBfStDSRBSr4DnHblrQpBOU891Z8RAdWJVBtiuUuBVE6UYuSydGX/AGgMaGp+UVmss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149867; c=relaxed/simple;
	bh=A0NSOXadnXGbPZ8tzYksPKVYU/3wJz0SBeLSIsy2rJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oiijY44FWFpCjd7yzKdtrmuJD4ENwxpWridQM11u2liriAYOWz72zQFuCRwJsGsMLEZBUmkp0PWQtAynvie5Zpq9SON050CJhXrHDz0cuEVttOXJHsJq3i/SZCWMpc+LIuCaYQ09ObdEsGg0lcpUbnIwT5qgX/c+fY7CdNJsqCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A6AA1655;
	Wed, 22 Oct 2025 09:17:31 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FAEC3F59E;
	Wed, 22 Oct 2025 09:17:34 -0700 (PDT)
Message-ID: <8e22c81e-5e78-41e0-a81e-0f9826e5edf0@arm.com>
Date: Wed, 22 Oct 2025 17:17:32 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mpam mpam/snapshot/v6.14-rc1] arm64/mpam: Fix MBWU monitor
 overflow handling
To: Zeng Heng <zengheng4@huawei.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, gshan@redhat.com,
 guohanjun@huawei.com, jeremy.linton@arm.com, jonathan.cameron@huawei.com,
 kobak@nvidia.com, lcherian@marvell.com, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, lpieralisi@kernel.org, peternewman@google.com,
 quic_jiles@quicinc.com, rafael@kernel.org, robh@kernel.org,
 rohit.mathew@arm.com, scott@os.amperecomputing.com, sdonthineni@nvidia.com,
 sudeep.holla@arm.com, tan.shaopeng@fujitsu.com, will@kernel.org,
 xhao@linux.alibaba.com, wangkefeng.wang@huawei.com
References: <20251017185645.26604-25-james.morse@arm.com>
 <20251022133913.629859-1-zengheng4@huawei.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20251022133913.629859-1-zengheng4@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Zeng,

On 10/22/25 14:39, Zeng Heng wrote:
> Bandwidth counters need to run continuously to correctly reflect the
> bandwidth. When reading the previously configured MSMON_CFG_MBWU_CTL,
> software must recognize that the MSMON_CFG_x_CTL_OFLOW_STATUS bit may
> have been set by hardware because of the counter overflow.
> 
> The existing logic incorrectly treats this bit as an indication that the
> monitor configuration has been changed and consequently zeros the MBWU
> statistics by mistake.

By zero-ing when the overflow bit is set we miss out on the counts after
the overflow and before the zero-ing. Do I understand correctly, that
this what this patch is aiming to fix?

> 
> Also fix the handling of overflow amount calculation. There's no need to
> subtract mbwu_state->prev_val when calculating overflow_val.

Why not? Isn't this the pre-overflow part that we are missing from the
running count?

> 
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> ---
>  drivers/resctrl/mpam_devices.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 0dd048279e02..06f3ec9887d2 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -1101,7 +1101,8 @@ static void __ris_msmon_read(void *arg)
>  	clean_msmon_ctl_val(&cur_ctl);
>  	gen_msmon_ctl_flt_vals(m, &ctl_val, &flt_val);
>  	config_mismatch = cur_flt != flt_val ||
> -			  cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN);
> +			 (cur_ctl & ~MSMON_CFG_x_CTL_OFLOW_STATUS) !=
> +			 (ctl_val | MSMON_CFG_x_CTL_EN);

This only considers 31 bit counters. I would expect any change here to
consider all lengths of counter. Also, as the overflow bit is no longer
reset due to the config mismatch it needs to be reset somewhere else.

>  
>  	if (config_mismatch || reset_on_next_read)
>  		write_msmon_ctl_flt_vals(m, ctl_val, flt_val);
> @@ -1138,8 +1139,9 @@ static void __ris_msmon_read(void *arg)
>  		mbwu_state = &ris->mbwu_state[ctx->mon];
>  
>  		/* Add any pre-overflow value to the mbwu_state->val */
> -		if (mbwu_state->prev_val > now)
> -			overflow_val = mpam_msmon_overflow_val(m->type) - mbwu_state->prev_val;
> +		if (mbwu_state->prev_val > now &&
> +		   (cur_ctl & MSMON_CFG_x_CTL_OFLOW_STATUS))
> +			overflow_val = mpam_msmon_overflow_val(ris);
>  
>  		mbwu_state->prev_val = now;
>  		mbwu_state->correction += overflow_val;


Thanks,

Ben


