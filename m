Return-Path: <linux-acpi+bounces-18206-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE16C07C1C
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 20:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03CFB4FF4A0
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 18:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E0B348460;
	Fri, 24 Oct 2025 18:30:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320FA348462;
	Fri, 24 Oct 2025 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761330605; cv=none; b=Y8FXwn/HohMx3nJUvGFwvImnZPiMPo+mLGEIXHpTXUrW/9d11VN9QLbAZfZYg3s2CCusen2U0VSXH0P7tL8y27EZl8/Cr4GgQPz5BBBy9XpcKS05r2za2NYFLgZ18EeGo+prPS1xpYUXUBuCMCu2kWyHBVINAt6FcrUHzRea/JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761330605; c=relaxed/simple;
	bh=av/b2te/q4OBW2LR5TauUIdTvqkEEX5hfLP93XzRfd8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbzZ29wd8ZEefKNB8e4jt5jjeASKRdzXk3G/jIYrkmSR4ruH962y9qA8CMfTKlHCMY4nPxAKkwD+3lYRWIrUIcluREbanVRhiQYtBHt8ObH7rpPMY0nPtB1HkbPzwW0JA4v1kW/O9HGI2hqaz/16JvlvXrVP+acmANcwbqlSefI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ctWZT4jLXz6GD6Y;
	Sat, 25 Oct 2025 02:26:41 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 982EB140276;
	Sat, 25 Oct 2025 02:30:00 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 24 Oct
 2025 19:29:59 +0100
Date: Fri, 24 Oct 2025 19:29:57 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: James Morse <james.morse@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>, Koba
 Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
	<fenghuay@nvidia.com>, <baisheng.gao@unisoc.com>, Rob Herring
	<robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>, "Rafael Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla
	<sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
	Gavin Shan <gshan@redhat.com>, Ben Horgan <ben.horgan@arm.com>
Subject: Re: [PATCH v3 26/29] arm_mpam: Use long MBWU counters if supported
Message-ID: <20251024192957.00000d55@huawei.com>
In-Reply-To: <20251017185645.26604-27-james.morse@arm.com>
References: <20251017185645.26604-1-james.morse@arm.com>
	<20251017185645.26604-27-james.morse@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 17 Oct 2025 18:56:42 +0000
James Morse <james.morse@arm.com> wrote:

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

A few tiny things on a fresh look.

> +static u64 mpam_msc_read_mbwu_l(struct mpam_msc *msc)
> +{
> +	int retry = 3;
> +	u32 mbwu_l_low;
> +	u64 mbwu_l_high1, mbwu_l_high2;
> +
> +	mpam_mon_sel_lock_held(msc);
> +
> +	WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
> +	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
> +
> +	mbwu_l_high2 = __mpam_read_reg(msc, MSMON_MBWU_L + 4);
> +	do {
> +		mbwu_l_high1 = mbwu_l_high2;
> +		mbwu_l_low = __mpam_read_reg(msc, MSMON_MBWU_L);
> +		mbwu_l_high2 = __mpam_read_reg(msc, MSMON_MBWU_L + 4);
> +
> +		retry--;
> +	} while (mbwu_l_high1 != mbwu_l_high2 && retry > 0);

Just carrying on if it tore repeatedly without screaming seems unwise...
I can't see it actually happening more than once but still seems like
we'd want to know if it did.

> +
> +	if (mbwu_l_high1 == mbwu_l_high2)
> +		return (mbwu_l_high1 << 32) | mbwu_l_low;
> +	return MSMON___NRDY_L;
> +}

>  static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
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
> +
Stray change to clean up (push to original patch).
>  		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
>  
>  		mbwu_state = &m->ris->mbwu_state[m->ctx->mon];
> @@ -993,10 +1047,19 @@ static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
>  	}
>  }


