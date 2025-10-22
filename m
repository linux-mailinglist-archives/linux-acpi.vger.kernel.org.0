Return-Path: <linux-acpi+bounces-18082-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0DDBFBA0C
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 13:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33AFD405DA9
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 11:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAFF337B94;
	Wed, 22 Oct 2025 11:23:53 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2278337B95;
	Wed, 22 Oct 2025 11:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761132233; cv=none; b=KqeFg+KJh1AwHkedqsGbpqW8LOUI6+ayYSHsA4jeFPlf8Y3/o3erW25Wg0MY6wWAX+P7ZP/ZGUfzfKiDANkkxVQbxJEztmUxdVZFfCmDWtm0jOatj2IW0OtGcwgH9/jAC6ECjwvdsv+tx1QrO5SoF9bCgykb4HDtJqjMp3g55a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761132233; c=relaxed/simple;
	bh=P/hblqrg65X4+cuC2R8wwGJRpYAVTBbZbf4uxX3yocc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JrQ33lirBJiGgXjDgcUL83Ne+W+E80/+IOpyO50Rq6DQxh6Sjw9FtVNW3IQ6e9Wr2v0OTcy8KvUE8f8dvgbpTPJ1kf15SxefOcS0+GNIbJEjoYkxCqVvEimBSotUiP+zDjCZpuMT08ul4d/+Zzjf58jw6Pj0BPl6ZAtmJBIgMRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E740A1063;
	Wed, 22 Oct 2025 04:23:42 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B05A3F59E;
	Wed, 22 Oct 2025 04:23:46 -0700 (PDT)
Message-ID: <c33c16dc-a955-41f9-9fb2-1397f056cb00@arm.com>
Date: Wed, 22 Oct 2025 12:23:15 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 25/29] arm_mpam: Probe for long/lwd mbwu counters
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
 Gavin Shan <gshan@redhat.com>
References: <20251017185645.26604-1-james.morse@arm.com>
 <20251017185645.26604-26-james.morse@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20251017185645.26604-26-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 10/17/25 19:56, James Morse wrote:
> From: Rohit Mathew <rohit.mathew@arm.com>
> 
> mpam v0.1 and versions above v1.0 support optional long counter for
> memory bandwidth monitoring. The MPAMF_MBWUMON_IDR register has fields
> indicating support for long counters.
> 
> Probe these feature bits.
> 
> The mpam_feat_msmon_mbwu feature is used to indicate that bandwidth
> monitors are supported, instead of muddling this with which size of
> bandwidth monitors, add an explicit 31 bit counter feature.
> 
> Signed-off-by: Rohit Mathew <rohit.mathew@arm.com>
> [ morse: Added 31bit counter feature to simplify later logic ]
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> ---
> Changes since v2:
>  * Added 31 bit counter type feature.
>  * Altered commit message.
> ---
>  drivers/resctrl/mpam_devices.c  | 13 +++++++++++--
>  drivers/resctrl/mpam_internal.h |  3 +++
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index deb1dcc6f6b1..f4d07234ce10 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -777,16 +777,25 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
>  				dev_err_once(dev, "Counters are not usable because not-ready timeout was not provided by firmware.");
>  		}
>  		if (FIELD_GET(MPAMF_MSMON_IDR_MSMON_MBWU, msmon_features)) {
> -			bool hw_managed;
> +			bool has_long, hw_managed;
>  			u32 mbwumon_idr = mpam_read_partsel_reg(msc, MBWUMON_IDR);
>  
>  			props->num_mbwu_mon = FIELD_GET(MPAMF_MBWUMON_IDR_NUM_MON, mbwumon_idr);
> -			if (props->num_mbwu_mon)
> +			if (props->num_mbwu_mon) {
>  				mpam_set_feature(mpam_feat_msmon_mbwu, props);
> +				mpam_set_feature(mpam_feat_msmon_mbwu_31counter, props);
> +			}
>  
>  			if (FIELD_GET(MPAMF_MBWUMON_IDR_HAS_RWBW, mbwumon_idr))
>  				mpam_set_feature(mpam_feat_msmon_mbwu_rwbw, props);
>  
> +			has_long = FIELD_GET(MPAMF_MBWUMON_IDR_HAS_LONG, mbwumon_idr);
> +			if (props->num_mbwu_mon && has_long) {
> +				mpam_set_feature(mpam_feat_msmon_mbwu_44counter, props);
> +				if (FIELD_GET(MPAMF_MBWUMON_IDR_LWD, mbwumon_idr))
> +					mpam_set_feature(mpam_feat_msmon_mbwu_63counter, props);
> +			}
> +

I think it's clearer to set each mpam_feat_msmon_mbwu_XXcounter for just
the size of counter the hardware supports rather than all XX up to that
size.

>  			/* Is NRDY hardware managed? */
>  			hw_managed = mpam_ris_hw_probe_hw_nrdy(ris, MBWU);
>  			if (hw_managed)
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 28c475d18d86..ff38b4bbfc2b 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -158,6 +158,9 @@ enum mpam_device_features {
>  	mpam_feat_msmon_csu_xcl,
>  	mpam_feat_msmon_csu_hw_nrdy,
>  	mpam_feat_msmon_mbwu,
> +	mpam_feat_msmon_mbwu_31counter,
> +	mpam_feat_msmon_mbwu_44counter,
> +	mpam_feat_msmon_mbwu_63counter,
>  	mpam_feat_msmon_mbwu_capture,
>  	mpam_feat_msmon_mbwu_rwbw,
>  	mpam_feat_msmon_mbwu_hw_nrdy,

-- 
Thanks,

Ben


