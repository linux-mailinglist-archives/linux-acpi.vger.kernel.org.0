Return-Path: <linux-acpi+bounces-18809-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E799BC5374B
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 17:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780B26200FC
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 15:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9B1340274;
	Wed, 12 Nov 2025 15:02:17 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD47F33F8C5;
	Wed, 12 Nov 2025 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959737; cv=none; b=fKQIJA/NlFanNF5M9cNmcGEt+gpp7NTTYycHEjqkn+v72JC1Am6R7XCv+Tq05rgNOPPx29bQXYE7hbZI1pIZDPijMEfN88q3BYDpRAqLifjZ7ko0QkqRnw1v4UcJO+t51dcHTPMdgLuzXaQQA0RVz5N5X89ax3UHzgHl0UCeT1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959737; c=relaxed/simple;
	bh=i2E+NvWCFKrgbyZBUGpLcyxl/p485cSfs6HDgAEg+iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMgrXr+sCRa6k1zZq2ep7UMYCBj1PTshwIG37oKASHesGnOWYZ/xaPIMDXXhwNQEOlEVXO0NU7mIe2LQDRqqdvqHqLsKg9E32Lyo1XORqABUdCmdBwwKp5llpuj/fldU7CI4qO0xcv+p2whH/mzgEV7O8Yp/HRT0Fu1t7wgmFJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8ED001515;
	Wed, 12 Nov 2025 07:02:07 -0800 (PST)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.80.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCAAE3F66E;
	Wed, 12 Nov 2025 07:02:14 -0800 (PST)
Date: Wed, 12 Nov 2025 15:02:13 +0000
From: Ionela Voinescu <ionela.voinescu@arm.com>
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, lenb@kernel.org,
	robert.moore@intel.com, corbet@lwn.net, pierre.gondois@arm.com,
	zhenglifeng1@huawei.com, rdunlap@infradead.org, ray.huang@amd.com,
	gautham.shenoy@amd.com, mario.limonciello@amd.com,
	perry.yuan@amd.com, zhanjie9@hisilicon.com,
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
	ksitaraman@nvidia.com, sanjayc@nvidia.com, nhartman@nvidia.com,
	bbasu@nvidia.com
Subject: Re: [PATCH v4 3/8] ACPI: CPPC: extend APIs to support auto_sel and
 epp
Message-ID: <aRShdY+QNQZdRewN@arm.com>
References: <20251105113844.4086250-1-sumitg@nvidia.com>
 <20251105113844.4086250-4-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105113844.4086250-4-sumitg@nvidia.com>

Hi,

A small nit that applies to multiple places: let's keep the line length
under 80 characters - the lines seem easy to split.

On Wednesday 05 Nov 2025 at 17:08:39 (+0530), Sumit Gupta wrote:
> - Add auto_sel read support in cppc_get_perf_caps().
> - Add write of both auto_sel and energy_perf in cppc_set_epp_perf().
> - Remove redundant energy_perf field from 'struct cppc_perf_caps' as
>   the same is available in 'struct cppc_perf_ctrls' which is used.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/acpi/cppc_acpi.c | 42 ++++++++++++++++++++++++++++++++--------
>  include/acpi/cppc_acpi.h |  1 -
>  2 files changed, 34 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 05672c30187c..757e8ce87e9b 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1344,8 +1344,8 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>  	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
>  	struct cpc_register_resource *highest_reg, *lowest_reg,
>  		*lowest_non_linear_reg, *nominal_reg, *guaranteed_reg,
> -		*low_freq_reg = NULL, *nom_freq_reg = NULL;
> -	u64 high, low, guaranteed, nom, min_nonlinear, low_f = 0, nom_f = 0;
> +		*low_freq_reg = NULL, *nom_freq_reg = NULL, *auto_sel_reg = NULL;
> +	u64 high, low, guaranteed, nom, min_nonlinear, low_f = 0, nom_f = 0, auto_sel = 0;
>  	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
>  	struct cppc_pcc_data *pcc_ss_data = NULL;
>  	int ret = 0, regs_in_pcc = 0;
> @@ -1362,11 +1362,12 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>  	low_freq_reg = &cpc_desc->cpc_regs[LOWEST_FREQ];
>  	nom_freq_reg = &cpc_desc->cpc_regs[NOMINAL_FREQ];
>  	guaranteed_reg = &cpc_desc->cpc_regs[GUARANTEED_PERF];
> +	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
>  
>  	/* Are any of the regs PCC ?*/
>  	if (CPC_IN_PCC(highest_reg) || CPC_IN_PCC(lowest_reg) ||
>  		CPC_IN_PCC(lowest_non_linear_reg) || CPC_IN_PCC(nominal_reg) ||
> -		CPC_IN_PCC(low_freq_reg) || CPC_IN_PCC(nom_freq_reg)) {
> +		CPC_IN_PCC(low_freq_reg) || CPC_IN_PCC(nom_freq_reg) || CPC_IN_PCC(auto_sel_reg)) {
>  		if (pcc_ss_id < 0) {
>  			pr_debug("Invalid pcc_ss_id\n");
>  			return -ENODEV;
> @@ -1414,6 +1415,9 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>  	perf_caps->lowest_freq = low_f;
>  	perf_caps->nominal_freq = nom_f;
>  
> +	if (CPC_SUPPORTED(auto_sel_reg))
> +		cpc_read(cpunum, auto_sel_reg, &auto_sel);
> +	perf_caps->auto_sel = (bool)auto_sel;
>  
>  out_err:
>  	if (regs_in_pcc)
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
> @@ -1589,14 +1600,29 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>  		/* after writing CPC, transfer the ownership of PCC to platform */
>  		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
>  		up_write(&pcc_ss_data->pcc_lock);
> -	} else if (osc_cpc_flexible_adr_space_confirmed &&
> -		   CPC_SUPPORTED(epp_set_reg) && CPC_IN_FFH(epp_set_reg)) {
> -		ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
> +	} else if (osc_cpc_flexible_adr_space_confirmed) {
> +		if (!epp_support_in_ffh_or_sysmem && !autosel_support_in_ffh_or_sysmem) {
> +			ret = -EOPNOTSUPP;
> +		} else {
> +			if (autosel_support_in_ffh_or_sysmem) {
> +				ret = cpc_write(cpu, auto_sel_reg, enable);
> +				if (ret)
> +					return ret;
> +			}
> +
> +			if (epp_support_in_ffh_or_sysmem) {
> +				ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
> +				if (ret)
> +					return ret;
> +			}

Wouldn't it be more clear to have separate functions for setting auto-sel
and EPP? I think this is functionally correct, but somewhat unclear, given
the signature of the function. But I do acknowledge that the function was
like this to begin with.

> +		}
>  	} else {
> -		ret = -ENOTSUPP;
> -		pr_debug("_CPC in PCC and _CPC in FFH are not supported\n");
> +		ret = -EOPNOTSUPP;
>  	}
>  
> +	if (ret == -EOPNOTSUPP)
> +		pr_debug("_CPC in PCC and _CPC in FFH are not supported\n");

This message needs updating.

Thank you,
Ionela.
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 7190afeead8b..42e37a84cac9 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -119,7 +119,6 @@ struct cppc_perf_caps {
>  	u32 lowest_nonlinear_perf;
>  	u32 lowest_freq;
>  	u32 nominal_freq;
> -	u32 energy_perf;
>  	bool auto_sel;
>  };
>  
> -- 
> 2.34.1
> 

