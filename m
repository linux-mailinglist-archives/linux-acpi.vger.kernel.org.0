Return-Path: <linux-acpi+bounces-18014-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BB2BF2AA3
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 19:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 257604EEE16
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 17:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9A1331A44;
	Mon, 20 Oct 2025 17:17:09 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DEF32B9A8;
	Mon, 20 Oct 2025 17:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980628; cv=none; b=rls9EGvqYyeSKIlH4W8qyBlTjqn0v0FZpggqUMjfjDuOy+AHvprQySB0MTyVKMwhXc/SoMqh2FUltlIEu8LryLiQONqvupKlEuMYrIf1Coj5Re5JspoDG6u/6bY1SKC2qHDL+L5U8srQI0FTBUhxscfDoo5EPrK20SQ4mfAsUnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980628; c=relaxed/simple;
	bh=0VoFGjnlTHJuqpTw8sfUR9EblSqVyJE5FXGGjhHo1IE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V3G7WTH4OrLMW35YAS7UBWpwGw1JFaKFfB2IP/dKQ34EHsxCuZjMv7ZgSmKC6x6KVn15zaeiIzrphYPemLww91DHIZxPLvR+SCwCdKVmn/fBq7vE1Wn14hZpSFC2O+rdCGgSGdOiPPoWWeqGeZEnSkKS0t7TtBSpJNZjK6Lvpto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E254F1007;
	Mon, 20 Oct 2025 10:16:57 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 564BC3F66E;
	Mon, 20 Oct 2025 10:17:00 -0700 (PDT)
Message-ID: <1e48c5ac-d409-47ba-ab59-78a8710d2d15@arm.com>
Date: Mon, 20 Oct 2025 18:16:58 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/29] arm_mpam: Probe and reset the rest of the
 features
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
 Danilo Krummrich <dakr@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
 Gavin Shan <gshan@redhat.com>, Zeng Heng <zengheng4@huawei.com>
References: <20251017185645.26604-1-james.morse@arm.com>
 <20251017185645.26604-22-james.morse@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20251017185645.26604-22-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 10/17/25 19:56, James Morse wrote:
> MPAM supports more features than are going to be exposed to resctrl.
> For partid other than 0, the reset values of these controls isn't
> known.
> 
> Discover the rest of the features so they can be reset to avoid any
> side effects when resctrl is in use.
> 
> PARTID narrowing allows MSC/RIS to support less configuration space than
> is usable. If this feature is found on a class of device we are likely
> to use, then reduce the partid_max to make it usable. This allows us
> to map a PARTID to itself.
> 
> CC: Rohit Mathew <Rohit.Mathew@arm.com>
> CC: Zeng Heng <zengheng4@huawei.com>
> CC: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> ---
> Changes since v2:
>  * Moved some enum definitions in here.
>  * Whitespace.
> 
[...]
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 2f2a7369107b..00edee9ebc6c 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -139,16 +139,30 @@ static inline void mpam_mon_sel_lock_init(struct mpam_msc *msc)
>  
>  /* Bits for mpam features bitmaps */
>  enum mpam_device_features {
> -	mpam_feat_cpor_part = 0,

Any reason this one doesn't stay first?

> +	mpam_feat_cmax_softlim,
> +	mpam_feat_cmax_cmax,
> +	mpam_feat_cmax_cmin,
> +	mpam_feat_cmax_cassoc,
> +	mpam_feat_cpor_part,
>  	mpam_feat_mbw_part,
>  	mpam_feat_mbw_min,
>  	mpam_feat_mbw_max,
> +	mpam_feat_mbw_prop,
> +	mpam_feat_intpri_part,
> +	mpam_feat_intpri_part_0_low,
> +	mpam_feat_dspri_part,
> +	mpam_feat_dspri_part_0_low,
>  	mpam_feat_msmon,
>  	mpam_feat_msmon_csu,
> +	mpam_feat_msmon_csu_capture,
> +	mpam_feat_msmon_csu_xcl,
>  	mpam_feat_msmon_csu_hw_nrdy,
>  	mpam_feat_msmon_mbwu,
> +	mpam_feat_msmon_mbwu_capture,
> +	mpam_feat_msmon_mbwu_rwbw,
>  	mpam_feat_msmon_mbwu_hw_nrdy,
> -	MPAM_FEATURE_LAST
> +	mpam_feat_partid_nrw,
> +	MPAM_FEATURE_LAST,

nit: drop the trailing , from MPAM_FEATURE_LAST. It confuses the diff.

>  };
>  


-- 
Thanks,

Ben


