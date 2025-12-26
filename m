Return-Path: <linux-acpi+bounces-19853-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA63CDE40A
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Dec 2025 03:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8D2F3007EE2
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Dec 2025 02:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9641F4174;
	Fri, 26 Dec 2025 02:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="BaCFn/mu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97C61A7264;
	Fri, 26 Dec 2025 02:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766717759; cv=none; b=iMuGcWSNIUYWPIXNAfz2gGTwhvgCU7li0XCNcdc9lx1IcDjbBXTPH5TTzCDHq0tSbRENMYPQWrF9I/K0/ZTyjZNfIc0wLaK9z3ZDBZeqfaM5EKKoAKGxRpoa4gQt0kGNEp+rP8/gZLg5ys1hS0roAF0uu8BsCcBaRr7oFa1rXg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766717759; c=relaxed/simple;
	bh=NDVC20or6vbM5v7zfCOELIkvuAf/hPZSNFlMyHD9xSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q1Qdu0ZZjDP70dl4P8Igq33El5sKaZ6hbWlHJe4+hUtsASFNzGNxQDhFQYNEsDVnDqeDf9f/9Wq5gXZ7P7oZ2iHemuidmQv4iHCeTFnYABZRs1TInzxz2MrJS9MMq0yQfafDpjwVETSaopISwyfFJDvLcUIMuAhZrRCo3+arjVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=BaCFn/mu; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Cmh4XqQkEkjzKjqus+Vwf6F7A0kN8cGTEmwXX0cJbS0=;
	b=BaCFn/muyiypuU6FUvWU6ynBF6seDr9F7uVDeYcZ4N5rYKedBtzr+wK7RNeXLBetpKrmZnOaH
	nXwIlQR+qyWqTVtSyMlXoYrLbvgGxYnt4viRaxT5xjGYxK7G7MYPX8vo0ZHIhBON8SCzIPUGsxE
	PEFf28cMlsPCdqn88P8Bmq4=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dcqsp0Y4rzRhQm;
	Fri, 26 Dec 2025 10:52:46 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 62D1740562;
	Fri, 26 Dec 2025 10:55:54 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 26 Dec
 2025 10:55:53 +0800
Message-ID: <ae4ff90a-d2c4-4c13-9d65-a0f266bb4b4b@huawei.com>
Date: Fri, 26 Dec 2025 10:55:53 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/11] cpufreq: CPPC: sync policy limits when toggling
 auto_select
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
 <20251223121307.711773-10-sumitg@nvidia.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20251223121307.711773-10-sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 2025/12/23 20:13, Sumit Gupta wrote:
> When CPPC autonomous selection (auto_select) is enabled or disabled,
> the policy min/max frequency limits should be updated appropriately to
> reflect the new operating mode.
> 
> Currently, toggling auto_select only changes the hardware register but
> doesn't update the cpufreq policy constraints, which can lead to
> inconsistent behavior between the hardware state and the policy limits
> visible to userspace.
> 
> Add cppc_cpufreq_update_autosel_config() function to handle the
> auto_select toggle by syncing min/max_perf values with policy
> constraints. When enabling auto_sel, restore preserved min/max_perf
> values to policy limits. When disabling, reset policy to defaults
> while preserving hardware register values for later use.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 112 +++++++++++++++++++++++++++------
>  1 file changed, 92 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 0202c7b823e6..b1f570d6de34 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -544,14 +544,20 @@ static void populate_efficiency_class(void)
>   * cppc_cpufreq_set_mperf_limit - Set min/max performance limit
>   * @policy: cpufreq policy
>   * @val: performance value to set
> + * @update_reg: whether to update hardware register
>   * @update_policy: whether to update policy constraints
>   * @is_min: true for min_perf, false for max_perf
>   *
> + * When @update_reg is true, writes to HW registers and preserves values.
>   * When @update_policy is true, updates cpufreq policy frequency limits.
> + *
> + * @update_reg is false when disabling auto_sel to preserve HW values.
> + * The preserved value is used on next enabling of the autonomous mode.
>   * @update_policy is false during cpu_init when policy isn't fully set up.
>   */
>  static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy *policy, u64 val,
> -					bool update_policy, bool is_min)
> +					bool update_reg, bool update_policy,
> +					bool is_min)
>  {
>  	struct cppc_cpudata *cpu_data = policy->driver_data;
>  	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
> @@ -563,19 +569,22 @@ static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy *policy, u64 val,
>  
>  	perf = clamp(val, caps->lowest_perf, caps->highest_perf);
>  
> -	ret = is_min ? cppc_set_min_perf(cpu, perf) :
> -		       cppc_set_max_perf(cpu, perf);
> -	if (ret) {
> -		if (ret != -EOPNOTSUPP)
> -			pr_warn("Failed to set %s_perf (%llu) on CPU%d (%d)\n",
> -				is_min ? "min" : "max", (u64)perf, cpu, ret);
> -		return ret;
> -	}
> +	if (update_reg) {
> +		ret = is_min ? cppc_set_min_perf(cpu, perf) :
> +			       cppc_set_max_perf(cpu, perf);
> +		if (ret) {
> +			if (ret != -EOPNOTSUPP)
> +				pr_warn("CPU%d: set %s_perf=%llu failed (%d)\n",
> +					cpu, is_min ? "min" : "max",
> +					(u64)perf, ret);
> +			return ret;
> +		}
>  
> -	if (is_min)
> -		cpu_data->perf_ctrls.min_perf = perf;
> -	else
> -		cpu_data->perf_ctrls.max_perf = perf;
> +		if (is_min)
> +			cpu_data->perf_ctrls.min_perf = perf;
> +		else
> +			cpu_data->perf_ctrls.max_perf = perf;
> +	}
>  
>  	if (update_policy) {
>  		freq = cppc_perf_to_khz(caps, perf);
> @@ -592,11 +601,74 @@ static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy *policy, u64 val,
>  	return 0;
>  }
>  
> -#define cppc_cpufreq_set_min_perf(policy, val, update_policy) \
> -	cppc_cpufreq_set_mperf_limit(policy, val, update_policy, true)
> +#define cppc_cpufreq_set_min_perf(policy, val, update_reg, update_policy)     \
> +	cppc_cpufreq_set_mperf_limit(policy, val, update_reg, update_policy,  \
> +				     true)
> +
> +#define cppc_cpufreq_set_max_perf(policy, val, update_reg, update_policy)     \
> +	cppc_cpufreq_set_mperf_limit(policy, val, update_reg, update_policy,  \
> +				     false)
> +
> +/**
> + * cppc_cpufreq_update_autosel_config - Update autonomous selection config
> + * @policy: cpufreq policy
> + * @is_auto_sel: enable/disable autonomous selection
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int cppc_cpufreq_update_autosel_config(struct cpufreq_policy *policy,
> +					      bool is_auto_sel)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
> +	u64 min_perf = caps->lowest_nonlinear_perf;
> +	u64 max_perf = caps->nominal_perf;
> +	unsigned int cpu = policy->cpu;
> +	bool update_reg = is_auto_sel;
> +	bool update_policy = true;
> +	int ret;
> +
> +	guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
> +
> +	if (is_auto_sel) {
> +		/* Use preserved values if available, else use defaults */
> +		if (cpu_data->perf_ctrls.min_perf)
> +			min_perf = cpu_data->perf_ctrls.min_perf;
> +		if (cpu_data->perf_ctrls.max_perf)
> +			max_perf = cpu_data->perf_ctrls.max_perf;
> +	}

So if !is_auto_sel, min_perf and max_perf reg will be set to
lowest_nonlinear_perf and nominal_perf, but perf_ctrls.min_perf and
perf_ctrls.max_perf remain the old value. A little bit strange I think. And
when this happen, min_freq_req and max_freq_req will retain the value last
set by the users through min_perf and max_perf. It's that alright?

> +
> +	/*
> +	 * Set min/max performance and update policy constraints.
> +	 *   When enabling: update both HW registers and policy.
> +	 *   When disabling: update policy only, preserve HW registers.
> +	 * Continue even if min/max are not supported, as EPP and autosel
> +	 * might still be supported.
> +	 */
> +	ret = cppc_cpufreq_set_min_perf(policy, min_perf, update_reg,
> +					update_policy);
> +	if (ret && ret != -EOPNOTSUPP)
> +		return ret;
> +
> +	ret = cppc_cpufreq_set_max_perf(policy, max_perf, update_reg,
> +					update_policy);
> +	if (ret && ret != -EOPNOTSUPP)
> +		return ret;
> +
> +	/* Update auto_sel register */
> +	ret = cppc_set_auto_sel(cpu, is_auto_sel);
> +	if (ret && ret != -EOPNOTSUPP) {
> +		pr_warn("Failed to set auto_sel=%d for CPU%d (%d)\n",
> +			is_auto_sel, cpu, ret);
> +		return ret;
> +	}
> +	if (!ret)
> +		cpu_data->perf_ctrls.auto_sel = is_auto_sel;
> +
> +	return 0;

Better to return ret.

> +}
> +
>  
> -#define cppc_cpufreq_set_max_perf(policy, val, update_policy) \
> -	cppc_cpufreq_set_mperf_limit(policy, val, update_policy, false)
>  static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>  {
>  	struct cppc_cpudata *cpu_data;
> @@ -889,7 +961,7 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
>  	if (ret)
>  		return ret;

Since you already store auto_sel value in perf_ctrls, We can compare the
new value with perf_ctrls.auto_sel here, and just return if they are the
same.

>  
> -	ret = cppc_set_auto_sel(policy->cpu, val);
> +	ret = cppc_cpufreq_update_autosel_config(policy, val);
>  	if (ret)
>  		return ret;
>  
> @@ -1005,7 +1077,7 @@ static ssize_t store_min_perf(struct cpufreq_policy *policy, const char *buf,
>  	perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
>  
>  	guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
> -	ret = cppc_cpufreq_set_min_perf(policy, perf,
> +	ret = cppc_cpufreq_set_min_perf(policy, perf, true,
>  					cpu_data->perf_ctrls.auto_sel);
>  	if (ret)
>  		return ret;
> @@ -1063,7 +1135,7 @@ static ssize_t store_max_perf(struct cpufreq_policy *policy, const char *buf,
>  	perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
>  
>  	guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
> -	ret = cppc_cpufreq_set_max_perf(policy, perf,
> +	ret = cppc_cpufreq_set_max_perf(policy, perf, true,
>  					cpu_data->perf_ctrls.auto_sel);
>  	if (ret)
>  		return ret;


