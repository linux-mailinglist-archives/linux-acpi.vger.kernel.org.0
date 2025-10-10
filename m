Return-Path: <linux-acpi+bounces-17703-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EA8BCB80B
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 05:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E47B44E2ED5
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 03:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA64923D7E8;
	Fri, 10 Oct 2025 03:24:18 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DC61E500C;
	Fri, 10 Oct 2025 03:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760066658; cv=none; b=fLGr67b90jdvlyy/NbBqsO+QEP+4crRvavI92U2OjmhROiMbGvAIEjGHL2izwHINPivlFC8b5LZVD0ergbTuHrbgZHUhq29WFkAZUhqSRGRuDz7K7JxQqO0Cbqq/G4Qob51altFKkkQ4iZKsIZbWwFC3ot8cb87eAROCQ5Ne2ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760066658; c=relaxed/simple;
	bh=3WF4tIRUtvQA2j4EjIaI7q0oYeLt55Dandq5aU/vbhU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=UfumN3kca8YOCfND/bvRvE/OCSUh1l4LGD78YsiqFtGXYW2OBR/DW8EaJIAa1sgqn2S9Zhy1g/SnchxrUhFsOgolSgO/Vzok78hy99Rc/pQiXAeVAA2A1tU037kFitxPxJDusgnzqVmV0/FYQlTItv+nMHAG4C5wNpRl1HZWwLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4cjXCB3FGMz1K9Bc;
	Fri, 10 Oct 2025 11:23:50 +0800 (CST)
Received: from kwepemr500004.china.huawei.com (unknown [7.202.195.141])
	by mail.maildlp.com (Postfix) with ESMTPS id CB73F1A0188;
	Fri, 10 Oct 2025 11:24:06 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemr500004.china.huawei.com
 (7.202.195.141) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 10 Oct
 2025 11:24:05 +0800
Message-ID: <bdd0aa7b-d239-420e-8741-b33d73959412@hisilicon.com>
Date: Fri, 10 Oct 2025 11:24:05 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jie Zhan <zhanjie9@hisilicon.com>
Subject: Re: [PATCH v3 1/8] cpufreq: CPPC: Add generic helpers for sysfs
 show/store
To: Sumit Gupta <sumitg@nvidia.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<corbet@lwn.net>, <pierre.gondois@arm.com>, <zhenglifeng1@huawei.com>,
	<rdunlap@infradead.org>, <ray.huang@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <bbasu@nvidia.com>
References: <20251001150104.1275188-1-sumitg@nvidia.com>
 <20251001150104.1275188-2-sumitg@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251001150104.1275188-2-sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500004.china.huawei.com (7.202.195.141)


Hi Sumit,

On 10/1/2025 11:00 PM, Sumit Gupta wrote:
> Add generic show/store helper functions for u64 sysfs attributes:
> - cppc_cpufreq_sysfs_show_u64()
> - cppc_cpufreq_sysfs_store_u64()
> 
> Refactor auto_act_window and energy_performance_preference_val
> attributes to use these helpers, eliminating code duplication.
> 
> No functional changes.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Nice cleanup in general.  Some minor bits inline.
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 87 ++++++++++++++--------------------
>  1 file changed, 35 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 12de0ac7bbaf..732f35096991 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -781,6 +781,36 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
>  	return 0;
>  }
>  
> +static ssize_t cppc_cpufreq_sysfs_show_u64(unsigned int cpu, int (*get_func)(int, u64 *), char *buf)
Wrap a bit into 80 chars?

BTW, trivial but I would prefer a symmetric param order, like:
show(buf, get_func, cpu)
store(buf, count, set_func, cpu)
> +{
> +	u64 val;
> +	int ret = get_func(cpu, &val);
> +
> +	if (ret == -EOPNOTSUPP)
> +		return sysfs_emit(buf, "<unsupported>\n");
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%llu\n", val);
> +}
> +
> +static ssize_t cppc_cpufreq_sysfs_store_u64(const char *buf, size_t count,
> +					    int (*set_func)(int, u64), unsigned int cpu)
> +{
> +	u64 val;
> +	int ret;
> +
> +	if (!buf || !set_func)
> +		return -EINVAL;
No need.
> +
> +	ret = kstrtou64(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	ret = set_func((int)cpu, val);
> +	return ret ? ret : count;
I suppose it's preferred to avoid using ternary operators like this.
> +}
> +
Would be nicer to move cppc_cpufreq_sysfs_show/store_u64() to just above
where they are used, i.e. just before show_auto_act_window().
>  static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
>  {
>  	struct cppc_cpudata *cpu_data = policy->driver_data;
> @@ -824,70 +854,23 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
>  
>  static ssize_t show_auto_act_window(struct cpufreq_policy *policy, char *buf)
>  {
> -	u64 val;
> -	int ret;
> -
> -	ret = cppc_get_auto_act_window(policy->cpu, &val);
> -
> -	/* show "<unsupported>" when this register is not supported by cpc */
> -	if (ret == -EOPNOTSUPP)
> -		return sysfs_emit(buf, "<unsupported>\n");
> -
> -	if (ret)
> -		return ret;
> -
> -	return sysfs_emit(buf, "%llu\n", val);
> +	return cppc_cpufreq_sysfs_show_u64(policy->cpu, cppc_get_auto_act_window, buf);
>  }
>  
> -static ssize_t store_auto_act_window(struct cpufreq_policy *policy,
> -				     const char *buf, size_t count)
> +static ssize_t store_auto_act_window(struct cpufreq_policy *policy, const char *buf, size_t count)
>  {
> -	u64 usec;
> -	int ret;
> -
> -	ret = kstrtou64(buf, 0, &usec);
> -	if (ret)
> -		return ret;
> -
> -	ret = cppc_set_auto_act_window(policy->cpu, usec);
> -	if (ret)
> -		return ret;
> -
> -	return count;
> +	return cppc_cpufreq_sysfs_store_u64(buf, count, cppc_set_auto_act_window, policy->cpu);
>  }
>  
>  static ssize_t show_energy_performance_preference_val(struct cpufreq_policy *policy, char *buf)
>  {
> -	u64 val;
> -	int ret;
> -
> -	ret = cppc_get_epp_perf(policy->cpu, &val);
> -
> -	/* show "<unsupported>" when this register is not supported by cpc */
> -	if (ret == -EOPNOTSUPP)
> -		return sysfs_emit(buf, "<unsupported>\n");
> -
> -	if (ret)
> -		return ret;
> -
> -	return sysfs_emit(buf, "%llu\n", val);
> +	return cppc_cpufreq_sysfs_show_u64(policy->cpu, cppc_get_epp_perf, buf);
>  }
>  
>  static ssize_t store_energy_performance_preference_val(struct cpufreq_policy *policy,
>  						       const char *buf, size_t count)
>  {
> -	u64 val;
> -	int ret;
> -
> -	ret = kstrtou64(buf, 0, &val);
> -	if (ret)
> -		return ret;
> -
> -	ret = cppc_set_epp(policy->cpu, val);
> -	if (ret)
> -		return ret;
> -
> -	return count;
> +	return cppc_cpufreq_sysfs_store_u64(buf, count, cppc_set_epp, policy->cpu);
>  }
>  
>  cpufreq_freq_attr_ro(freqdomain_cpus);

