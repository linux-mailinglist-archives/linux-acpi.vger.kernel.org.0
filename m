Return-Path: <linux-acpi+bounces-19854-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCF6CDE490
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Dec 2025 04:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 505763008FB1
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Dec 2025 03:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784CF2E92BA;
	Fri, 26 Dec 2025 03:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ymcKDWEO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3393822578A;
	Fri, 26 Dec 2025 03:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766719615; cv=none; b=ELTfsI+9QTTGD4eY50OsKgDc/1DI9FUev0JC2S6FGeJUWN3GsEkje1u7MDFsUEEng+RhY54Ia0MY3J8bSUTJaDdWw0FJP9kURsTqSKIGP1cUxgZbd3ClTK9nNEB8lUzt10iiX/9d9Lyu3MV/24uuwVhp/2qAICBXXHSa4SxuF4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766719615; c=relaxed/simple;
	bh=bdESPG6kYwFVKxwuQPFl2ZPm+AZZfjNUnusgyG1k2/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kmQVzEZMPWxBouMuboNWwqNOGpCaOm6/bC0DqnVrZuJ6gNhlR5Xt2P4ZwBIufluheuJw8ljVqq0AE1wFhRwEIG+vNJIGgyJgyEXfCNBvpJLfp6SMgq4cFaqB0UQu0Pwe6FelMvUbkfxlfVOUJRQiUgVkxyadOk7AgQK0eIjarcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ymcKDWEO; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=f+F/viYca39p1Scw4ETy7gaIKOd1WZNZftpY5CnhqVg=;
	b=ymcKDWEOIMxcv87/Wz8mhawN6Kjdv6c882ip2Q/iw9Rnzewqxu9Wvx42ENaNaxurflXF8Ntwj
	hb+83MxjCMkXgAn+rf0zIeuTcd9N05GIqsq8pZr8hkOabCqnvUO5yTzBSGmOUBvJZPpJ7ixcw18
	lqamx2bSaEx9r9QhKW7ITbE=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dcrYK6g7nzmV6d;
	Fri, 26 Dec 2025 11:23:33 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BBB740563;
	Fri, 26 Dec 2025 11:26:42 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 26 Dec
 2025 11:26:41 +0800
Message-ID: <66e5ccea-9cc2-429e-856d-e3f420a8b2b2@huawei.com>
Date: Fri, 26 Dec 2025 11:26:41 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/11] cpufreq: CPPC: make scaling_min/max_freq
 read-only when auto_sel enabled
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
 <20251223121307.711773-11-sumitg@nvidia.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20251223121307.711773-11-sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 2025/12/23 20:13, Sumit Gupta wrote:
> When autonomous selection (auto_sel) is enabled, the hardware controls
> performance within min_perf/max_perf register bounds making the
> scaling_min/max_freq effectively read-only.
> 
> Enforce this by setting policy limits to min/max_perf bounds in
> cppc_verify_policy(). Users must use min_perf/max_perf sysfs interfaces
> to change performance limits in autonomous mode.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index b1f570d6de34..b3da263c18b0 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -305,7 +305,37 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
>  
>  static int cppc_verify_policy(struct cpufreq_policy_data *policy)
>  {
> -	cpufreq_verify_within_cpu_limits(policy);
> +	unsigned int min_freq = policy->cpuinfo.min_freq;
> +	unsigned int max_freq = policy->cpuinfo.max_freq;
> +	struct cpufreq_policy *cpu_policy;
> +	struct cppc_cpudata *cpu_data;
> +	struct cppc_perf_caps *caps;
> +
> +	cpu_policy = cpufreq_cpu_get(policy->cpu);

Better to use:

	struct cpufreq_policy *cpu_policy __free(put_cpufreq_policy) = cpufreq_cpu_get(policy->cpu);

> +	if (!cpu_policy)
> +		return -ENODEV;
> +
> +	cpu_data = cpu_policy->driver_data;
> +	caps = &cpu_data->perf_caps;

cpu_policy, cpu_data and cpas are only used in the if branch. Just put them
in it.

> +
> +	if (cpu_data->perf_ctrls.auto_sel) {
> +		u32 min_perf, max_perf;
> +
> +		/*
> +		 * Set policy limits to HW min/max_perf bounds. In autonomous
> +		 * mode, scaling_min/max_freq is effectively read-only.
> +		 */
> +		min_perf = cpu_data->perf_ctrls.min_perf ?:
> +			   caps->lowest_nonlinear_perf;
> +		max_perf = cpu_data->perf_ctrls.max_perf ?: caps->nominal_perf;
> +
> +		policy->min = cppc_perf_to_khz(caps, min_perf);
> +		policy->max = cppc_perf_to_khz(caps, max_perf);
> +	} else {
> +		cpufreq_verify_within_limits(policy, min_freq, max_freq);

Why not still using cpufreq_verify_within_cpu_limits()?

> +	}
> +
> +	cpufreq_cpu_put(cpu_policy);
>  	return 0;
>  }
>  


