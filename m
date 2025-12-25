Return-Path: <linux-acpi+bounces-19841-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AED07CDD411
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Dec 2025 04:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80A32301636E
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Dec 2025 03:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5D22405E7;
	Thu, 25 Dec 2025 03:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="OAdW/ENO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0EB2222D0;
	Thu, 25 Dec 2025 03:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766634092; cv=none; b=Bn2F4Fe5+Be1o/ACQlZmXsQGFS4RXzsybNH+CYPRd4gnK4hfdnRTiFemsvnAMWzaB1yOyP9TQrh9Z3VswzHLCT36gmw6FTDMbJAMrioUYhgX7LfWGLBF9bUqdkmUSQH4Rwfmauyua5mw7/lyTsI4XkHcFLBHv3WUttmVlxwkfLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766634092; c=relaxed/simple;
	bh=Y9pSm1QTUljDixzcSPO/g0vu3P5ppyFYlz1NyQ7ADdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LjmDLxUmij5tMq+gyLLh8tvLLCagYv3fSjWmV6AAWvvS36GhY5UOZGF7x0LTqB67UKSn5lC9EvmJLJgHbq9NX/6XcYRqlQRLDV7Me42GC6ispV+/ates/i95yNkYnPynDTNiKnWj6s39kPjrKvrJhjXdfMMhnVs6g3jy23lA1m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=OAdW/ENO; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=leYsuE4PvGv6H0V8qlZLwlvieFIQikOrVdK2+4JnbSw=;
	b=OAdW/ENOcl1HFPdEFVgd1gzz+B42BREjt5vMEcYOTVGoh6PjY06lxBTPKEum1SzLxA5ybMcwO
	Rl0a/gvQpXRfU0TNOGXBobw4bCbOqYDIH3VhvMshYeYkzTo2sVpCGeKxNxMTSv4oxeiohkdHfBF
	g3Ks+2o9l06JjAEtJpWeRww=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dcDwj0217zKm5B;
	Thu, 25 Dec 2025 11:38:13 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 15738402AB;
	Thu, 25 Dec 2025 11:41:21 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 25 Dec
 2025 11:41:19 +0800
Message-ID: <dbbbdb83-24d4-465e-99bb-689cd6e37460@huawei.com>
Date: Thu, 25 Dec 2025 11:41:19 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/11] cpufreq: CPPC: Add generic helpers for sysfs
 show/store
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
 <20251223121307.711773-2-sumitg@nvidia.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20251223121307.711773-2-sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 2025/12/23 20:12, Sumit Gupta wrote:
> Add generic show/store helper functions for u64 sysfs attributes:
> - cppc_cpufreq_sysfs_show_u64()
> - cppc_cpufreq_sysfs_store_u64()
> 
> Refactor auto_act_window and energy_performance_preference_val
> attributes to use these helpers, eliminating code duplication.

How about adding a macro to generate show_xxx and store_xxx in one line?

Just a suggestion.

> 
> No functional changes.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 71 +++++++++++++++-------------------
>  1 file changed, 31 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 9eac77c4f294..7c26ce554e29 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -831,72 +831,63 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
>  	return count;
>  }
>  
> -static ssize_t show_auto_act_window(struct cpufreq_policy *policy, char *buf)
> +static ssize_t cppc_cpufreq_sysfs_show_u64(unsigned int cpu,
> +					   int (*get_func)(int, u64 *),
> +					   char *buf)
>  {
>  	u64 val;
> -	int ret;
> -
> -	ret = cppc_get_auto_act_window(policy->cpu, &val);
> +	int ret = get_func((int)cpu, &val);
>  
> -	/* show "<unsupported>" when this register is not supported by cpc */
>  	if (ret == -EOPNOTSUPP)
>  		return sysfs_emit(buf, "<unsupported>\n");
> -
>  	if (ret)
>  		return ret;
>  
>  	return sysfs_emit(buf, "%llu\n", val);
>  }
>  
> -static ssize_t store_auto_act_window(struct cpufreq_policy *policy,
> -				     const char *buf, size_t count)
> +static ssize_t cppc_cpufreq_sysfs_store_u64(unsigned int cpu,
> +					    int (*set_func)(int, u64),
> +					    const char *buf, size_t count)
>  {
> -	u64 usec;
> +	u64 val;
>  	int ret;
>  
> -	ret = kstrtou64(buf, 0, &usec);
> +	ret = kstrtou64(buf, 0, &val);
>  	if (ret)
>  		return ret;
>  
> -	ret = cppc_set_auto_act_window(policy->cpu, usec);
> -	if (ret)
> -		return ret;
> +	ret = set_func((int)cpu, val);
>  
> -	return count;
> +	return ret ? ret : count;
>  }
>  
> -static ssize_t show_energy_performance_preference_val(struct cpufreq_policy *policy, char *buf)
> +static ssize_t show_auto_act_window(struct cpufreq_policy *policy, char *buf)
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
> +	return cppc_cpufreq_sysfs_show_u64(policy->cpu,
> +					   cppc_get_auto_act_window, buf);
>  }
>  
> -static ssize_t store_energy_performance_preference_val(struct cpufreq_policy *policy,
> -						       const char *buf, size_t count)
> +static ssize_t store_auto_act_window(struct cpufreq_policy *policy,
> +				     const char *buf, size_t count)
>  {
> -	u64 val;
> -	int ret;
> -
> -	ret = kstrtou64(buf, 0, &val);
> -	if (ret)
> -		return ret;
> +	return cppc_cpufreq_sysfs_store_u64(policy->cpu,
> +					    cppc_set_auto_act_window,
> +					    buf, count);
> +}
>  
> -	ret = cppc_set_epp(policy->cpu, val);
> -	if (ret)
> -		return ret;
> +static ssize_t
> +show_energy_performance_preference_val(struct cpufreq_policy *policy, char *buf)
> +{
> +	return cppc_cpufreq_sysfs_show_u64(policy->cpu, cppc_get_epp_perf, buf);
> +}
>  
> -	return count;
> +static ssize_t
> +store_energy_performance_preference_val(struct cpufreq_policy *policy,
> +					const char *buf, size_t count)
> +{
> +	return cppc_cpufreq_sysfs_store_u64(policy->cpu, cppc_set_epp,
> +					    buf, count);
>  }
>  
>  cpufreq_freq_attr_ro(freqdomain_cpus);


