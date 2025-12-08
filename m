Return-Path: <linux-acpi+bounces-19491-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BE6CADBA1
	for <lists+linux-acpi@lfdr.de>; Mon, 08 Dec 2025 17:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4CD7304C9ED
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Dec 2025 16:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E39243964;
	Mon,  8 Dec 2025 16:17:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1351E49F;
	Mon,  8 Dec 2025 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765210658; cv=none; b=G0nIzuy4i2f/YRScx8XM5Kr/1AleZ64I8j/mSq5/qlrr9KYfMjU7Q1CBbFwiEJ8jnf7WfSLpQAgv/icDMuQGsZwgFydjtDAFKleBMKg97xudRRf/UcN9mLIj7KurH+tqcA8D3axm2iutyE366yWQeAGk3B0phsvn+CmoFnLFf08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765210658; c=relaxed/simple;
	bh=t77iVpZAIeON6xw9l3th3ob/pJZ4A8In3x1rp7BkoVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8wnjEfbmUXFbLqwBZYAxMIEiYc5Bjf7kDttoyFyarYab3oH+mj/6ZL8oOl6qkaHvUQ7OPzUYjvXh9uG4ZXaLK2l5DTezA313J1zRICFWcYp7F+lUAQeZmncXbUoAMIJIQtqxbLP7H5JThUqtFfoEWes8RGUauQgDuRNFjyTNJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0FD41691;
	Mon,  8 Dec 2025 08:17:28 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80E0D3F740;
	Mon,  8 Dec 2025 08:17:32 -0800 (PST)
Date: Mon, 8 Dec 2025 17:17:30 +0100
From: Beata Michalska <beata.michalska@arm.com>
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: viresh.kumar@linaro.org, rafael@kernel.org, ionela.voinescu@arm.com,
	pierre.gondois@arm.com, zhenglifeng1@huawei.com,
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, prime.zeng@hisilicon.com,
	yubowen8@huawei.com, lihuisong@huawei.com, zhangpengjie2@huawei.com,
	wangzhi12@huawei.com
Subject: Re: [PATCH v4 1/3] ACPI: CPPC: Factor out and export per-cpu
 cppc_perf_ctrs_in_pcc_cpu()
Message-ID: <aTb6Gvzvc9C7vnVP@arm.com>
References: <20251203032422.3232957-1-zhanjie9@hisilicon.com>
 <20251203032422.3232957-2-zhanjie9@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203032422.3232957-2-zhanjie9@hisilicon.com>

On Wed, Dec 03, 2025 at 11:24:20AM +0800, Jie Zhan wrote:
> Factor out cppc_perf_ctrs_in_pcc_cpu() for checking whether per-cpu CPC
> regs are defined in PCC channels, and export it out for further use.
> 
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
>  drivers/acpi/cppc_acpi.c | 45 +++++++++++++++++++++-------------------
>  include/acpi/cppc_acpi.h |  5 +++++
>  2 files changed, 29 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 3bdeeee3414e..aa80dbcf42c0 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1422,6 +1422,29 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>  }
>  EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
>  
> +bool cppc_perf_ctrs_in_pcc_cpu(unsigned int cpu)
> +{
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +	struct cpc_register_resource *ref_perf_reg;
> +
> +	/*
> +	 * If reference perf register is not supported then we should use the
> +	 * nominal perf value
> +	 */
> +	ref_perf_reg = &cpc_desc->cpc_regs[REFERENCE_PERF];
> +	if (!CPC_SUPPORTED(ref_perf_reg))
> +		ref_perf_reg = &cpc_desc->cpc_regs[NOMINAL_PERF];
> +
> +	if (CPC_IN_PCC(&cpc_desc->cpc_regs[DELIVERED_CTR]) ||
> +	    CPC_IN_PCC(&cpc_desc->cpc_regs[REFERENCE_CTR]) ||
> +	    CPC_IN_PCC(&cpc_desc->cpc_regs[CTR_WRAP_TIME]) ||
> +	    CPC_IN_PCC(ref_perf_reg))
> +		return true;
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc_cpu);
It is minor, but I would prefer the earlier version when we grab the reference
performance reg only when none of the other regs is in the PCC.

---
BR
Beata
> +
>  /**
>   * cppc_perf_ctrs_in_pcc - Check if any perf counters are in a PCC region.
>   *
> @@ -1436,27 +1459,7 @@ bool cppc_perf_ctrs_in_pcc(void)
>  	int cpu;
>  
>  	for_each_online_cpu(cpu) {
> -		struct cpc_register_resource *ref_perf_reg;
> -		struct cpc_desc *cpc_desc;
> -
> -		cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> -
> -		if (CPC_IN_PCC(&cpc_desc->cpc_regs[DELIVERED_CTR]) ||
> -		    CPC_IN_PCC(&cpc_desc->cpc_regs[REFERENCE_CTR]) ||
> -		    CPC_IN_PCC(&cpc_desc->cpc_regs[CTR_WRAP_TIME]))
> -			return true;
> -
> -
> -		ref_perf_reg = &cpc_desc->cpc_regs[REFERENCE_PERF];
> -
> -		/*
> -		 * If reference perf register is not supported then we should
> -		 * use the nominal perf value
> -		 */
> -		if (!CPC_SUPPORTED(ref_perf_reg))
> -			ref_perf_reg = &cpc_desc->cpc_regs[NOMINAL_PERF];
> -
> -		if (CPC_IN_PCC(ref_perf_reg))
> +		if (cppc_perf_ctrs_in_pcc_cpu(cpu))
>  			return true;
>  	}
>  
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 13fa81504844..4bcdcaf8bf2c 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -154,6 +154,7 @@ extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
>  extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
>  extern int cppc_set_enable(int cpu, bool enable);
>  extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
> +extern bool cppc_perf_ctrs_in_pcc_cpu(unsigned int cpu);
>  extern bool cppc_perf_ctrs_in_pcc(void);
>  extern unsigned int cppc_perf_to_khz(struct cppc_perf_caps *caps, unsigned int perf);
>  extern unsigned int cppc_khz_to_perf(struct cppc_perf_caps *caps, unsigned int freq);
> @@ -204,6 +205,10 @@ static inline int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps)
>  {
>  	return -EOPNOTSUPP;
>  }
> +static inline bool cppc_perf_ctrs_in_pcc_cpu(unsigned int cpu)
> +{
> +	return false;
> +}
>  static inline bool cppc_perf_ctrs_in_pcc(void)
>  {
>  	return false;
> -- 
> 2.33.0
> 

