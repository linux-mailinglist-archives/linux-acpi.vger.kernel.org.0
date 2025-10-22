Return-Path: <linux-acpi+bounces-18077-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA70CBFB18C
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 11:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C3454E9D2C
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 09:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB113126BD;
	Wed, 22 Oct 2025 09:13:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B33623ABA1;
	Wed, 22 Oct 2025 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124381; cv=none; b=mSDZmartfIQV3uXmnrTu/wvHk5sg1u24xPK5eGLRrC5ZC0Ua5DPdpD6O2Bu76ChQrkpetDZJ8bR9Ogel3bAjoZ8BOvbDzdXcXTh0ku8k2Ry3IqOCMt26wLW+TfeIrf2OqBboU4kMDiVT+uVKNQ33LG7YxFoUUV/CpwB55CeTgvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124381; c=relaxed/simple;
	bh=pznKN8dUbII3GpPjqx5PyM5eD2eG/eKsDEZkzbIX6y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJOgJ8Pc7QPPxfeAxAT4Tsv1unH8TpCCuIBU65w1BU6juophDqogSrwxG8Lv8vJGuvFBeIo4t+kN8xvZYX45o3j7bGzQTWJBaL2u4MTutgXEEyAmTwHSS5/GMc8i4OX0RQfXftE+byW+dh2GH78QKb7EpvLS2dxOTKDmHNOVYjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EA3A1063;
	Wed, 22 Oct 2025 02:12:49 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.80.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9CB93F59E;
	Wed, 22 Oct 2025 02:12:56 -0700 (PDT)
Date: Wed, 22 Oct 2025 10:12:55 +0100
From: Ionela Voinescu <ionela.voinescu@arm.com>
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, lenb@kernel.org,
	robert.moore@intel.com, corbet@lwn.net, pierre.gondois@arm.com,
	zhenglifeng1@huawei.com, rdunlap@infradead.org, ray.huang@amd.com,
	gautham.shenoy@amd.com, mario.limonciello@amd.com,
	perry.yuan@amd.com, linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, treding@nvidia.com,
	jonathanh@nvidia.com, vsethi@nvidia.com, ksitaraman@nvidia.com,
	sanjayc@nvidia.com, bbasu@nvidia.com
Subject: Re: [PATCH v3 3/8] ACPI: CPPC: extend APIs to support auto_sel and
 epp
Message-ID: <aPigDd0QTiRjey7K@arm.com>
References: <20251001150104.1275188-1-sumitg@nvidia.com>
 <20251001150104.1275188-4-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001150104.1275188-4-sumitg@nvidia.com>

Hi Sumit,

On Wednesday 01 Oct 2025 at 20:30:59 (+0530), Sumit Gupta wrote:
> - Add auto_sel read support in cppc_get_perf_caps().
> - Add write of both auto_sel and energy_perf in cppc_set_epp_perf().
> - Remove redundant energy_perf field from 'struct cppc_perf_caps' as
>   the same is available in 'struct cppc_perf_ctrls' which is used.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
[..]
> @@ -1555,6 +1559,8 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>  	struct cpc_register_resource *auto_sel_reg;
>  	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>  	struct cppc_pcc_data *pcc_ss_data = NULL;
> +	bool autosel_support_in_ffh_or_sysmem;
> +	bool epp_support_in_ffh_or_sysmem;
>  	int ret;
>  
>  	if (!cpc_desc) {
> @@ -1565,6 +1571,11 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>  	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
>  	epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
>  
> +	epp_support_in_ffh_or_sysmem = CPC_SUPPORTED(epp_set_reg) &&
> +				(CPC_IN_FFH(epp_set_reg) || CPC_IN_SYSTEM_MEMORY(epp_set_reg));
> +	autosel_support_in_ffh_or_sysmem = CPC_SUPPORTED(auto_sel_reg) &&
> +				(CPC_IN_FFH(auto_sel_reg) || CPC_IN_SYSTEM_MEMORY(auto_sel_reg));
> +
>  	if (CPC_IN_PCC(epp_set_reg) || CPC_IN_PCC(auto_sel_reg)) {
>  		if (pcc_ss_id < 0) {
>  			pr_debug("Invalid pcc_ss_id for CPU:%d\n", cpu);
> @@ -1590,8 +1601,19 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>  		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
>  		up_write(&pcc_ss_data->pcc_lock);
>  	} else if (osc_cpc_flexible_adr_space_confirmed &&
> -		   CPC_SUPPORTED(epp_set_reg) && CPC_IN_FFH(epp_set_reg)) {
> +		   epp_support_in_ffh_or_sysmem && autosel_support_in_ffh_or_sysmem) {

Isn't this problematic for when auto-select is an integer set to 1 or it's
not present at all? In those cases the EPP register won't be written and
-ENOTSUPP will be returned.

I suppose for the case when auto-select is not present at all in _CPC
(it's an optional attribute) it's not very clear what one should do
regarding writing the EPP register. The specification mentions that
"Writes to this register only have meaning when Autonomous Selection
is enabled.". From my perspective the OS should not block writes to the
EPP register for this case, as autonomous selection might still be
enabled but not exposed to the OS. 

Thanks,
Ionela.

> +		ret = cpc_write(cpu, auto_sel_reg, enable);
> +		if (ret) {
> +			pr_debug("Failed to write auto_sel=%d for CPU:%d\n", enable, cpu);
> +			return ret;
> +		}
> +
>  		ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
> +		if (ret) {
> +			pr_debug("Failed to write energy_perf=%u for CPU:%d\n",
> +				 perf_ctrls->energy_perf, cpu);
> +			return ret;
> +		}
>  	} else {
>  		ret = -ENOTSUPP;
>  		pr_debug("_CPC in PCC and _CPC in FFH are not supported\n");
[..]

