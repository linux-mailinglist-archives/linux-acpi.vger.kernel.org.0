Return-Path: <linux-acpi+bounces-16684-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32860B537F6
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 17:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17ADA4E25FA
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 15:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647F933EB01;
	Thu, 11 Sep 2025 15:37:55 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A781DBB3A;
	Thu, 11 Sep 2025 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757605075; cv=none; b=nCgFfmIhQQDpLqBlYhuQcg/eYGvsvnTy9ntReVgMbFHMeJ7FJHcCEqqtxdgjBEwWRvl8HTp8ZeuBIZDLEcO3nDXyLX3fGaSbesVkzL29q89iYCs57sNbbZElJXN+Ax60nwNSJ0X1K9e/FYMJyfxEMj7b0bTSo1CbOWPJn6hJWM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757605075; c=relaxed/simple;
	bh=xpWjJY4jsD9WDvdhB99ir+nxRdi42JwdQD/EacCb4k8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u94V8hEoX0GactTEZYNYsYYLn5nKEo+6d9Nwr9f+vxLYxamXFlP3vQUfT+slnLkCVpn/oway+r0yUQnr40Iz0f4UsqAZdsfV3BE3MS1zoQ2vvtXNkG4wzIu0iU+nHCARksNX5msXufEUt/FYedQfrzuWpudWuu8S+lXby3SlPv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69F29153B;
	Thu, 11 Sep 2025 08:37:44 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E3363F63F;
	Thu, 11 Sep 2025 08:37:48 -0700 (PDT)
Message-ID: <8ed9fbe9-1075-4abb-91d0-20203906a4dc@arm.com>
Date: Thu, 11 Sep 2025 16:37:46 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/29] arm_mpam: Probe the hardware features resctrl
 supports
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
 <20250910204309.20751-14-james.morse@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20250910204309.20751-14-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 9/10/25 21:42, James Morse wrote:
> Expand the probing support with the control and monitor types
> we can use with resctrl.
> 
> CC: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>  * added an underscore to a variable name.
> 
> Changes since RFC:
>  * Made mpam_ris_hw_probe_hw_nrdy() more in C.
>  * Added static assert on features bitmap size.
> ---
>  drivers/resctrl/mpam_devices.c  | 151 ++++++++++++++++++++++++++++++++
>  drivers/resctrl/mpam_internal.h |  53 +++++++++++
>  2 files changed, 204 insertions(+)
> 
[snip]
>  
>  	spin_lock(&partid_max_lock);
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 4cc44d4e21c4..5ae5d4eee8ec 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -112,6 +112,55 @@ static inline void mpam_mon_sel_lock_init(struct mpam_msc *msc)
>  	raw_spin_lock_init(&msc->_mon_sel_lock);
>  }
>  
> +/*
> + * When we compact the supported features, we don't care what they are.
> + * Storing them as a bitmap makes life easy.
> + */
> +typedef u16 mpam_features_t;
> +
> +/* Bits for mpam_features_t */
> +enum mpam_device_features {
> +	mpam_feat_ccap_part = 0,
> +	mpam_feat_cpor_part,
> +	mpam_feat_mbw_part,
> +	mpam_feat_mbw_min,
> +	mpam_feat_mbw_max,
> +	mpam_feat_mbw_prop,
> +	mpam_feat_msmon,
> +	mpam_feat_msmon_csu,
> +	mpam_feat_msmon_csu_capture,
> +	mpam_feat_msmon_csu_hw_nrdy,
> +	mpam_feat_msmon_mbwu,
> +	mpam_feat_msmon_mbwu_capture,
> +	mpam_feat_msmon_mbwu_rwbw,
> +	mpam_feat_msmon_mbwu_hw_nrdy,
> +	mpam_feat_msmon_capt,
> +	MPAM_FEATURE_LAST,
> +};

I added a garbled comment about this for v1. What I was trying to say is
that I don't think this quite matches what resctrl supports. For
instance, I don't think mpam_feat_ccap_part matches a resctrl feature.

Thanks,

Ben


