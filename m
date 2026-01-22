Return-Path: <linux-acpi+bounces-20503-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJ/ZFxrhcWk+MgAAu9opvQ
	(envelope-from <linux-acpi+bounces-20503-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 09:34:34 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 010FD6323A
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 09:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8429D5E1AB5
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 08:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752ED3382E1;
	Thu, 22 Jan 2026 08:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="NTGLDLbG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FE917BEBF;
	Thu, 22 Jan 2026 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070437; cv=none; b=JIuaCgOin5zYwCBQqTO6LtdIFnq59t7Qs3T/hEJVLJ1IT69AKRAx+j9vuA+cnA5cfItbL/8c/UJupqQvpU19d4djsbsz8Zu00uquNQJ51Yk2gaoHOlym+pkAE5NJZ15SRfRSEusZKIx21gq8pNhMl3EEhLwdK+yfKSxRqCIm42o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070437; c=relaxed/simple;
	bh=4oCdp3L5Oc/h2mFCOwl6AVhYMe9ODqCGXT1MIJG4fOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qeOapHjCpE2DEQvA6WvHcoKHs7NLCrD5JHF5N09uRWDnTO21cRjSs3TOh7AkqgpZsTiiKCVSTLgNZ7dI5k3+3BXvIQV3r/tXh6QY9EZQEfA9B0w3Xi5FPoobhCve1rbz0K7wxfatDJ+UBGuwAtjvdd48NQ5BXtxOttZCvo0Y5uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=NTGLDLbG; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ycLwncsvVdmKPKvuy/F0Ic9J+vzT0coN7yOMb+BhP/s=;
	b=NTGLDLbGBDs91hKTlNr7BOJSTW+kA+asoDQUhtlHfpC8gc/6VKkuSoqWoOJug2bPvIF8+FvN3
	EXR8ZbmPASVRJO7yiJxvKQe2h6MiKWfNUFzCPgFelwvWWKDc7/Au/SQkj41uKgIG7dES6Ai4Zw6
	6q9fFyzbUsEPiQ5qRDS7q7U=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dxYxH3Cd0zLlZK;
	Thu, 22 Jan 2026 16:23:47 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 27A6E40565;
	Thu, 22 Jan 2026 16:27:11 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 16:27:10 +0800
Message-ID: <bd194325-784d-4b9d-b4ca-aaab16a2c596@huawei.com>
Date: Thu, 22 Jan 2026 16:27:09 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/9] cpufreq: CPPC: Add generic helpers for sysfs
 show/store
To: Sumit Gupta <sumitg@nvidia.com>
CC: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<ionela.voinescu@arm.com>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<corbet@lwn.net>, <rdunlap@infradead.org>, <ray.huang@amd.com>,
	<gautham.shenoy@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<zhanjie9@hisilicon.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
	<vsethi@nvidia.com>, <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>,
	<nhartman@nvidia.com>, <bbasu@nvidia.com>
References: <20260120145623.2959636-1-sumitg@nvidia.com>
 <20260120145623.2959636-2-sumitg@nvidia.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20260120145623.2959636-2-sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf200001.china.huawei.com (7.202.181.227)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20503-lists,linux-acpi=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[huawei.com,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhenglifeng1@huawei.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,huawei.com:email,huawei.com:dkim,huawei.com:mid,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 010FD6323A
X-Rspamd-Action: no action

On 2026/1/20 22:56, Sumit Gupta wrote:
> Add generic helper functions for u64 sysfs attributes that follow the
> common pattern of calling CPPC get/set APIs:
> - cppc_cpufreq_sysfs_show_u64(): reads value and handles -EOPNOTSUPP
> - cppc_cpufreq_sysfs_store_u64(): parses input and calls set function
> 
> Add CPPC_CPUFREQ_ATTR_RW_U64() macro to generate show/store functions
> using these helpers, reducing boilerplate for simple attributes.
> 
> Convert auto_act_window and energy_performance_preference_val to use
> the new macro.
> 
> No functional changes.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 69 ++++++++++++----------------------
>  1 file changed, 25 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 36e8a75a37f1..c95dcd7719c3 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -863,73 +863,54 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
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

I think it is better to keep this blank line. Apart from this

Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>

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
> -{
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
> +#define CPPC_CPUFREQ_ATTR_RW_U64(_name, _get_func, _set_func)		\
> +static ssize_t show_##_name(struct cpufreq_policy *policy, char *buf)	\
> +{									\
> +	return cppc_cpufreq_sysfs_show_u64(policy->cpu, _get_func, buf);\
> +}									\
> +static ssize_t store_##_name(struct cpufreq_policy *policy,		\
> +			     const char *buf, size_t count)		\
> +{									\
> +	return cppc_cpufreq_sysfs_store_u64(policy->cpu, _set_func,	\
> +					    buf, count);		\
>  }
>  
> -static ssize_t store_energy_performance_preference_val(struct cpufreq_policy *policy,
> -						       const char *buf, size_t count)
> -{
> -	u64 val;
> -	int ret;
> +CPPC_CPUFREQ_ATTR_RW_U64(auto_act_window, cppc_get_auto_act_window,
> +			 cppc_set_auto_act_window)
>  
> -	ret = kstrtou64(buf, 0, &val);
> -	if (ret)
> -		return ret;
> -
> -	ret = cppc_set_epp(policy->cpu, val);
> -	if (ret)
> -		return ret;
> -
> -	return count;
> -}
> +CPPC_CPUFREQ_ATTR_RW_U64(energy_performance_preference_val,
> +			 cppc_get_epp_perf, cppc_set_epp)
>  
>  cpufreq_freq_attr_ro(freqdomain_cpus);
>  cpufreq_freq_attr_rw(auto_select);


