Return-Path: <linux-acpi+bounces-18085-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26CEBFBDDD
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 14:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0BE403B7A
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 12:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FAC340A51;
	Wed, 22 Oct 2025 12:31:54 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC7732E142;
	Wed, 22 Oct 2025 12:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761136314; cv=none; b=dNVdr69rJ+vkpto5YIYTA2k6GpQDPmUt0HcLqMsnnKiggk7GBFQj/QdKLJ7yPBqy1k2miye8QFHWLJqdrxIMIZM6qhqf9doMge2Ku+/P4SeXURdUSsDeOn9Y2Q/4v6Aqp1TaKq2Hh9jfiguhCqqdcM82llb1R1NCHVqmfLcE2UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761136314; c=relaxed/simple;
	bh=MteqNTWmwdipz8GKr3klzBPnQjl/Q+Wgw1Tgv4va9ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HeRhb5fXqDN1lU+iQ1bYQDFLPzImdd5OMM0VdQLOq6RpPuC523QoXzZHbm5txV0IW7em354jjICwuj6XilGuKx543RctXaQvg69SDCIfHjRv+TNJgKObrgRnpmb2AgP9tQ1DlNZIbyhiCLVbQx4jhEXaORv3sp8KMccwvrmRhFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7DA91063;
	Wed, 22 Oct 2025 05:31:42 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0871B3F63F;
	Wed, 22 Oct 2025 05:31:45 -0700 (PDT)
Message-ID: <1a1a3522-313a-46e7-bc13-fcbbd9ccf81f@arm.com>
Date: Wed, 22 Oct 2025 13:31:44 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 26/29] arm_mpam: Use long MBWU counters if supported
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
 <20251017185645.26604-27-james.morse@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20251017185645.26604-27-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 10/17/25 19:56, James Morse wrote:
> From: Rohit Mathew <rohit.mathew@arm.com>
> 
> Now that the larger counter sizes are probed, make use of them.
> 
> Callers of mpam_msmon_read() may not know (or care!) about the different
> counter sizes. Allow them to specify mpam_feat_msmon_mbwu and have the
> driver pick the counter to use.
> 
> Only 32bit accesses to the MSC are required to be supported by the
> spec, but these registers are 64bits. The lower half may overflow
> into the higher half between two 32bit reads. To avoid this, use
> a helper that reads the top half multiple times to check for overflow.
> 
> Signed-off-by: Rohit Mathew <rohit.mathew@arm.com>
> [morse: merged multiple patches from Rohit, added explicit counter selection ]
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> ---
> Changes since v2:
>  * Removed mpam_feat_msmon_mbwu as a top-level bit for explicit 31bit counter
>    selection.
>  * Allow callers of mpam_msmon_read() to specify mpam_feat_msmon_mbwu and have
>    the driver pick a supported counter size.
>  * Rephrased commit message.
> 
> Changes since v1:
>  * Only clear OFLOW_STATUS_L on MBWU counters.
> 
> Changes since RFC:
>  * Commit message wrangling.
>  * Refer to 31 bit counters as opposed to 32 bit (registers).
> ---
>  drivers/resctrl/mpam_devices.c | 134 ++++++++++++++++++++++++++++-----
>  1 file changed, 116 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index f4d07234ce10..c207a6d2832c 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -897,6 +897,48 @@ struct mon_read {
[...]
> +static void mpam_msc_zero_mbwu_l(struct mpam_msc *msc)
> +{
> +	mpam_mon_sel_lock_held(msc);
> +
> +	WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
> +	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
> +
> +	__mpam_write_reg(msc, MSMON_MBWU_L, 0);
> +	__mpam_write_reg(msc, MSMON_MBWU_L + 4, 0);
> +}
> +
[...]
> @@ -978,10 +1027,15 @@ static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
>  		mpam_write_monsel_reg(msc, CSU, 0);
>  		mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
>  		break;
> -	case mpam_feat_msmon_mbwu:
> +	case mpam_feat_msmon_mbwu_44counter:
> +	case mpam_feat_msmon_mbwu_63counter:
> +		mpam_msc_zero_mbwu_l(m->ris->vmsc->msc);
> +		fallthrough;
> +	case mpam_feat_msmon_mbwu_31counter:
>  		mpam_write_monsel_reg(msc, CFG_MBWU_FLT, flt_val);
>  		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
>  		mpam_write_monsel_reg(msc, MBWU, 0);

Already zeroed if it's a long counter.

> +
>  		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
>  
>  		mbwu_state = &m->ris->mbwu_state[m->ctx->mon];
[...]
> +static enum mpam_device_features mpam_msmon_choose_counter(struct mpam_class *class)
> +{
> +	struct mpam_props *cprops = &class->props;
> +
> +	if (mpam_has_feature(mpam_feat_msmon_mbwu_44counter, cprops))
> +		return mpam_feat_msmon_mbwu_44counter;

This should check the longest counter first.

> +	if (mpam_has_feature(mpam_feat_msmon_mbwu_63counter, cprops))
> +		return mpam_feat_msmon_mbwu_63counter;
> +
> +	return mpam_feat_msmon_mbwu_31counter;
> +}
> +
-- 
Thanks,

Ben


