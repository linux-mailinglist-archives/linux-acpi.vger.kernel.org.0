Return-Path: <linux-acpi+bounces-19844-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0030CDD7DC
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Dec 2025 09:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF7A0302BD21
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Dec 2025 08:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4D930AAC0;
	Thu, 25 Dec 2025 08:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="E/xVngxb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB503093C0;
	Thu, 25 Dec 2025 08:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766650930; cv=none; b=lLjgPrDvlLbDGVRFCJLG+NFqS3oGocJZ6KTv/anvRNdSPUEnd9xkEAmbZwQSekstPVn6akGIr4yMMxezxtSkQqRS8AOe4RsvQAKaPFKAi/+JlJKr8ojBT0Pek7d5EqWkf05TArzZT9XbV8Glb734GWWBNLQplJnWu8sIKV1RkIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766650930; c=relaxed/simple;
	bh=X2l5lOuNHuPWUfjU6YQXnnSXDCwcmxn6xUyYrfTh9+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eyzFQRlLeEFkLDyTqplcbv+pzi+65cBi4/89w8e9CbllQf6EvcrkPCwFqc0vGb/VIivx9b80k71ENLtg/k8jHtfeOJIecunVjZL2J4z1St92Stpp+wcVATgv8SMxGqMWnIxxNMuXoSby/XGzEwqJxt5T7HbyTeiCl1B6f2BXKUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=E/xVngxb; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qV9c0cAuQBFG5vHxyodBDru6tAcw75rGhJjJFCuTdLg=;
	b=E/xVngxbpq+/240pqexo6OzMXmiriq+qx/kVoVgF+DFLT5AoOdPr1148j/tgZploHfqaRprSx
	ZWW8DtiBq9nHpt0LUifGwiaDHJf8MG8asx7hyzVlCxPYDXX5Ko97Ev3E7TjiERPzJsL5C2iPCwW
	/Pi6UoBcc6xUjxJbx+KL3II=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dcM8R25spz12LJG;
	Thu, 25 Dec 2025 16:18:47 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 1FC534056C;
	Thu, 25 Dec 2025 16:21:59 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 25 Dec
 2025 16:21:58 +0800
Message-ID: <e484ce68-1fb1-4732-8577-19a2b7141c40@huawei.com>
Date: Thu, 25 Dec 2025 16:21:57 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/11] ACPI: CPPC: Add cppc_get_perf() API to read
 performance controls
To: Sumit Gupta <sumitg@nvidia.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<corbet@lwn.net>, <pierre.gondois@arm.com>, <rdunlap@infradead.org>,
	<ray.huang@amd.com>, <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <ionela.voinescu@arm.com>, <zhanjie9@hisilicon.com>,
	<linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <nhartman@nvidia.com>, <bbasu@nvidia.com>
References: <20251223121307.711773-1-sumitg@nvidia.com>
 <20251223121307.711773-4-sumitg@nvidia.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20251223121307.711773-4-sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 2025/12/23 20:12, Sumit Gupta wrote:
> Add cppc_get_perf() function to read values of performance control
> registers including desired_perf, min_perf, max_perf, energy_perf,
> and auto_sel.
> 
> This provides a read interface to complement the existing
> cppc_set_perf() write interface for performance control registers.
> 
> Note that auto_sel is read by cppc_get_perf() but not written by
> cppc_set_perf() to avoid unintended mode changes during performance
> updates. It can be updated with existing dedicated cppc_set_auto_sel()
> API.
> 
> Also call cppc_get_perf() in cppc_cpufreq_get_cpu_data() to initialize
> perf_ctrls with current hardware register values during cpufreq
> initialization for each CPU policy.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/acpi/cppc_acpi.c       | 79 ++++++++++++++++++++++++++++++++++
>  drivers/cpufreq/cppc_cpufreq.c |  6 +++
>  include/acpi/cppc_acpi.h       |  5 +++
>  3 files changed, 90 insertions(+)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index e66e20d1f31b..a4e89fe6aab5 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1732,6 +1732,85 @@ int cppc_set_enable(int cpu, bool enable)
>  	return cppc_set_reg_val(cpu, ENABLE, enable);
>  }
>  EXPORT_SYMBOL_GPL(cppc_set_enable);
> +/**
> + * cppc_get_perf - Get a CPU's performance controls.
> + * @cpu: CPU for which to get performance controls.
> + * @perf_ctrls: ptr to cppc_perf_ctrls. See cppc_acpi.h
> + *
> + * Return: 0 for success with perf_ctrls, -ERRNO otherwise.
> + */
> +int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
> +{
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +	struct cpc_register_resource *desired_perf_reg,
> +				     *min_perf_reg, *max_perf_reg,
> +				     *energy_perf_reg, *auto_sel_reg;
> +	u64 desired_perf = 0, min = 0, max = 0, energy_perf = 0, auto_sel = 0;
> +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> +	struct cppc_pcc_data *pcc_ss_data = NULL;
> +	int ret = 0, regs_in_pcc = 0;
> +
> +	if (!cpc_desc) {
> +		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
> +		return -ENODEV;
> +	}
> +
> +	if (!perf_ctrls) {
> +		pr_debug("Invalid perf_ctrls pointer\n");
> +		return -EINVAL;
> +	}
> +
> +	desired_perf_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
> +	min_perf_reg = &cpc_desc->cpc_regs[MIN_PERF];
> +	max_perf_reg = &cpc_desc->cpc_regs[MAX_PERF];
> +	energy_perf_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
> +	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
> +
> +	/* Are any of the regs PCC ?*/
> +	if (CPC_IN_PCC(desired_perf_reg) || CPC_IN_PCC(min_perf_reg) ||
> +	    CPC_IN_PCC(max_perf_reg) || CPC_IN_PCC(energy_perf_reg) ||
> +	    CPC_IN_PCC(auto_sel_reg)) {
> +		if (pcc_ss_id < 0) {
> +			pr_debug("Invalid pcc_ss_id for CPU:%d\n", cpu);
> +			return -ENODEV;
> +		}
> +		pcc_ss_data = pcc_data[pcc_ss_id];
> +		regs_in_pcc = 1;
> +		down_write(&pcc_ss_data->pcc_lock);
> +		/* Ring doorbell once to update PCC subspace */
> +		if (send_pcc_cmd(pcc_ss_id, CMD_READ) < 0) {
> +			ret = -EIO;
> +			goto out_err;
> +		}
> +	}
> +
> +	/* Read optional elements if present */
> +	if (CPC_SUPPORTED(max_perf_reg))
> +		cpc_read(cpu, max_perf_reg, &max);
> +	perf_ctrls->max_perf = max;
> +
> +	if (CPC_SUPPORTED(min_perf_reg))
> +		cpc_read(cpu, min_perf_reg, &min);
> +	perf_ctrls->min_perf = min;
> +
> +	if (CPC_SUPPORTED(desired_perf_reg))
> +		cpc_read(cpu, desired_perf_reg, &desired_perf);
> +	perf_ctrls->desired_perf = desired_perf;
> +
> +	if (CPC_SUPPORTED(energy_perf_reg))
> +		cpc_read(cpu, energy_perf_reg, &energy_perf);
> +	perf_ctrls->energy_perf = energy_perf;
> +
> +	if (CPC_SUPPORTED(auto_sel_reg))
> +		cpc_read(cpu, auto_sel_reg, &auto_sel);
> +	perf_ctrls->auto_sel = (bool)auto_sel;
> +
> +out_err:
> +	if (regs_in_pcc)
> +		up_write(&pcc_ss_data->pcc_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_perf);
>  
>  /**
>   * cppc_set_perf - Set a CPU's performance controls.
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 7c26ce554e29..a87e7bb2e2f1 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -562,6 +562,12 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>  		goto free_mask;
>  	}
>  
> +	ret = cppc_get_perf(cpu, &cpu_data->perf_ctrls);
> +	if (ret) {
> +		pr_debug("Err reading CPU%d perf ctrls: ret:%d\n", cpu, ret);
> +		goto free_mask;
> +	}
> +

If you really need energy_perf and auto_sel in cpu_data->perf_ctrls, they
should be updated whenever they are set, i.e., in store_auto_select() and
store_energy_performance_preference_val().

>  	return cpu_data;
>  
>  free_mask:
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index a090b010f5f1..12a1dc31bf2a 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -150,6 +150,7 @@ extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
>  extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
>  extern int cppc_get_highest_perf(int cpunum, u64 *highest_perf);
>  extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
> +extern int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
>  extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
>  extern int cppc_set_enable(int cpu, bool enable);
>  extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
> @@ -191,6 +192,10 @@ static inline int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_
>  {
>  	return -EOPNOTSUPP;
>  }
> +static inline int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
> +{
> +	return -EOPNOTSUPP;
> +}
>  static inline int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>  {
>  	return -EOPNOTSUPP;


