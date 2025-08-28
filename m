Return-Path: <linux-acpi+bounces-16158-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3787DB3A5E6
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 18:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18D51B2164F
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 16:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0392D8391;
	Thu, 28 Aug 2025 16:15:06 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B05263C69;
	Thu, 28 Aug 2025 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756397706; cv=none; b=rUzOvUZvdzcXaZdBoOEdOoknpR69rwEg4TkCd4Oz2deb/SM3EeQ0zetrOlkd6g5qLpVyEze9QRtZTa8M9sUoOj3dfg6vNPKlzY+5krA3XE9PSPSDsnc85T/hS8LIeqs6vxUP+nuc9Kgjqo/kZ3Z3tfE3dP1LB+Sgguvfcct+RKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756397706; c=relaxed/simple;
	bh=O1lrH6pM6YsXnZ1Li2CZXZFGI/v1p6PVAEIz3UrlIoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CpkppFUG5Ez+EKT555NSdro7UswtCPDXz+uAoUCGjZUZKGIgis+zLmWn2QCkmL0LnxAGj7GHjSDcOQTK+3+04XYGCeTN+RrzgzSNA1AKDE1FA4CTltvexStekSZBEUx6mGbAZ6t6NYK4KgPhByUNmCIgaV9b1BWgQaHLU4Jeu74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50A0E1688;
	Thu, 28 Aug 2025 09:14:56 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9F2A3F694;
	Thu, 28 Aug 2025 09:14:58 -0700 (PDT)
Message-ID: <75cdcd36-4bd5-4ad7-a37e-9c2a195c71e5@arm.com>
Date: Thu, 28 Aug 2025 17:14:57 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/33] arm_mpam: Probe for long/lwd mbwu counters
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
 <20250822153048.2287-30-james.morse@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20250822153048.2287-30-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 8/22/25 16:30, James Morse wrote:
> From: Rohit Mathew <rohit.mathew@arm.com>
> 
> mpam v0.1 and versions above v1.0 support optional long counter for
> memory bandwidth monitoring. The MPAMF_MBWUMON_IDR register have fields
> indicating support for long counters. As of now, a 44 bit counter
> represented by HAS_LONG field (bit 30) and a 63 bit counter represented
> by LWD (bit 29) can be optionally integrated. Probe for these counters
> and set corresponding feature bits if any of these counters are present.
> 
> Signed-off-by: Rohit Mathew <rohit.mathew@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/resctrl/mpam_devices.c  | 23 ++++++++++++++++++++++-
>  drivers/resctrl/mpam_internal.h |  8 ++++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 11be34b54643..2ab7f127baaa 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -870,7 +870,7 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
>  				pr_err_once("Counters are not usable because not-ready timeout was not provided by firmware.");
>  		}
>  		if (FIELD_GET(MPAMF_MSMON_IDR_MSMON_MBWU, msmon_features)) {
> -			bool hw_managed;
> +			bool has_long, hw_managed;
>  			u32 mbwumonidr = mpam_read_partsel_reg(msc, MBWUMON_IDR);
nit: the variable name would be more readable with an underscore,
mwumon_idr.
>  
>  			props->num_mbwu_mon = FIELD_GET(MPAMF_MBWUMON_IDR_NUM_MON, mbwumonidr);
> @@ -880,6 +880,27 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
>  			if (FIELD_GET(MPAMF_MBWUMON_IDR_HAS_RWBW, mbwumonidr))
>  				mpam_set_feature(mpam_feat_msmon_mbwu_rwbw, props);
>  
> +			/*
> +			 * Treat long counter and its extension, lwd as mutually
> +			 * exclusive feature bits. Though these are dependent
> +			 * fields at the implementation level, there would never
> +			 * be a need for mpam_feat_msmon_mbwu_44counter (long
> +			 * counter) and mpam_feat_msmon_mbwu_63counter (lwd)
> +			 * bits to be set together.
> +			 *
> +			 * mpam_feat_msmon_mbwu isn't treated as an exclusive
> +			 * bit as this feature bit would be used as the "front
> +			 * facing feature bit" for any checks related to mbwu
> +			 * monitors.
> +			 */
> +			has_long = FIELD_GET(MPAMF_MBWUMON_IDR_HAS_LONG, mbwumonidr);
> +			if (props->num_mbwu_mon && has_long) {
> +				if (FIELD_GET(MPAMF_MBWUMON_IDR_LWD, mbwumonidr))
> +					mpam_set_feature(mpam_feat_msmon_mbwu_63counter, props);
> +				else
> +					mpam_set_feature(mpam_feat_msmon_mbwu_44counter, props);
> +			}
> +
>  			/* Is NRDY hardware managed? */
>  			mpam_mon_sel_outer_lock(msc);
>  			hw_managed = mpam_ris_hw_probe_hw_nrdy(ris, MBWU);
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 9a50a5432f4a..9f627b5f72a1 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -178,7 +178,15 @@ enum mpam_device_features {
>  	mpam_feat_msmon_csu,
>  	mpam_feat_msmon_csu_capture,
>  	mpam_feat_msmon_csu_hw_nrdy,
> +
> +	/*
> +	 * Having mpam_feat_msmon_mbwu set doesn't mean the regular 31 bit MBWU
> +	 * counter would be used. The exact counter used is decided based on the
> +	 * status of mpam_feat_msmon_mbwu_l/mpam_feat_msmon_mbwu_lwd as well.
mpam_feat_msmon_mbwu_44counter/mpam_feat_msmon_mbwu_63counter
> +	 */
>  	mpam_feat_msmon_mbwu,
> +	mpam_feat_msmon_mbwu_44counter,
> +	mpam_feat_msmon_mbwu_63counter,
>  	mpam_feat_msmon_mbwu_capture,
>  	mpam_feat_msmon_mbwu_rwbw,
>  	mpam_feat_msmon_mbwu_hw_nrdy,

Other than the two nits, the change looks good to me.

Reviewed-by: Ben Horgan <ben.horgan@arm.com>

Thanks,

Ben


