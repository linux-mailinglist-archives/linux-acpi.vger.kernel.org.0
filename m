Return-Path: <linux-acpi+bounces-18204-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F07C07BAE
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 20:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07B8189BC05
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 18:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF312638B2;
	Fri, 24 Oct 2025 18:23:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7389B2AE90;
	Fri, 24 Oct 2025 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761330180; cv=none; b=MEUq960d9t0d/C/adFDIj087TfvycElgeHtutAkJDD0HyHqMfhz/yhUmQb00ZPsTi0fl93DlxCEFrwcAXzynBoSXRIyJrYKbedNrHIipMXFoiV0MuhyZ/8lF6BnZrmB0y5ghcPS9B5s9yV/4kkwUTaOmPYaC6I63l0ejBaDaGjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761330180; c=relaxed/simple;
	bh=Ekr0Judc1Jkm4Sk7g1pm8PdYCxH/t7z3P1YVMiHhe7c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1NEsdogoEfuNrSDIaqFYOQgXBBcgs4XMQVzS242g/xXK6azkEJZberK6K0N/CVbcYv3RYr6aoLUKkpqVeqoOEsthe2Ys0LGuHAq5SitqVfq214aeg93ZCzamCDiqy2D81iKS+WHThEaOF0plQ5ZMa51xij7lHLzd4140UhP82s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ctWSN3cJpz6L515;
	Sat, 25 Oct 2025 02:21:24 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A30414010C;
	Sat, 25 Oct 2025 02:22:56 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 24 Oct
 2025 19:22:54 +0100
Date: Fri, 24 Oct 2025 19:22:52 +0100
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
	Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 24/29] arm_mpam: Track bandwidth counter state for
 overflow and power management
Message-ID: <20251024192252.00005168@huawei.com>
In-Reply-To: <20251017185645.26604-25-james.morse@arm.com>
References: <20251017185645.26604-1-james.morse@arm.com>
	<20251017185645.26604-25-james.morse@arm.com>
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

On Fri, 17 Oct 2025 18:56:40 +0000
James Morse <james.morse@arm.com> wrote:

> Bandwidth counters need to run continuously to correctly reflect the
> bandwidth.
> 
> The value read may be lower than the previous value read in the case
> of overflow and when the hardware is reset due to CPU hotplug.
> 
> Add struct mbwu_state to track the bandwidth counter to allow overflow
> and power management to be handled.
> 
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Signed-off-by: James Morse <james.morse@arm.com>
Just one trivial thing from me. I'll take another look once the
questions from others are resolved.

> +/* Call with MSC lock and held */
> +static int mpam_save_mbwu_state(void *arg)
> +{
> +	int i;
> +	u64 val;
> +	struct mon_cfg *cfg;
> +	u32 cur_flt, cur_ctl, mon_sel;
> +	struct mpam_msc_ris *ris = arg;
> +	struct msmon_mbwu_state *mbwu_state;
> +	struct mpam_msc *msc = ris->vmsc->msc;
> +
> +	for (i = 0; i < ris->props.num_mbwu_mon; i++) {
> +		mbwu_state = &ris->mbwu_state[i];
> +		cfg = &mbwu_state->cfg;

Could pull some of the local variable declarations in here to make
their scope clear.

> +
> +		if (WARN_ON_ONCE(!mpam_mon_sel_lock(msc)))
> +			return -EIO;
> +
> +		mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, i) |
> +			  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
> +		mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
> +
> +		cur_flt = mpam_read_monsel_reg(msc, CFG_MBWU_FLT);
> +		cur_ctl = mpam_read_monsel_reg(msc, CFG_MBWU_CTL);
> +		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
> +
> +		val = mpam_read_monsel_reg(msc, MBWU);
> +		mpam_write_monsel_reg(msc, MBWU, 0);
> +
> +		cfg->mon = i;
> +		cfg->pmg = FIELD_GET(MSMON_CFG_x_FLT_PMG, cur_flt);
> +		cfg->match_pmg = FIELD_GET(MSMON_CFG_x_CTL_MATCH_PMG, cur_ctl);
> +		cfg->partid = FIELD_GET(MSMON_CFG_x_FLT_PARTID, cur_flt);
> +		mbwu_state->correction += val;
> +		mbwu_state->enabled = FIELD_GET(MSMON_CFG_x_CTL_EN, cur_ctl);
> +		mpam_mon_sel_unlock(msc);
> +	}
> +
> +	return 0;
> +}



