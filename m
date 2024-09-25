Return-Path: <linux-acpi+bounces-8386-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A05B698565B
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 11:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42AD1B22382
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 09:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B29B156257;
	Wed, 25 Sep 2024 09:30:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA8315383F;
	Wed, 25 Sep 2024 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727256620; cv=none; b=bsKaFyNMmX5WxF4krrsQHzFVijIIyOeMDCZ62tMzKtkkOJrySexoPIzYvikAG7sgVDM89V0nMtyTzgVonj4O0KdTtdd5l52uUDWg6qrhpVpivOHYArl2t/4p81nl7lsAj2jd7EfwYHN1kKqw/PLThO1kgmcLhLKHH1YEJ7Z2JVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727256620; c=relaxed/simple;
	bh=6Hh0lBFFpGjJhDhrFB+Bg8Z2YcZJu2K8J8vRcIFANrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SyaDCnoW7zNdPTWpg6cFU9ehJ985OnZB0JFDfvw/iz1viK2plr7Wck2NbHr8e9C3gwDAZRxJPCUao0aHkl1POxj2hiTZ13fP/a9gTYqYTQHYUTu9tihK5Gc9741my9Q1F6y5nKdoEvnc0dHNf4mx4Hz+srDjmlj2S6gscg52/Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XDBJQ37smz1SBrm;
	Wed, 25 Sep 2024 17:29:26 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 48EE31401F0;
	Wed, 25 Sep 2024 17:30:14 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 25 Sep
 2024 17:30:13 +0800
Message-ID: <f888bd45-120a-a045-c35c-52ae40ae8a9a@huawei.com>
Date: Wed, 25 Sep 2024 17:28:40 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 1/2] cppc_cpufreq: Use desired perf if feedback ctrs
 are 0 or unchanged
To: Jie Zhan <zhanjie9@hisilicon.com>, <ionela.voinescu@arm.com>,
	<beata.michalska@arm.com>, <wangxiongfeng2@huawei.com>,
	<viresh.kumar@linaro.org>, <rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <wanghuiqiang@huawei.com>,
	<zhenglifeng1@huawei.com>, <yangyicong@huawei.com>, <liaochang1@huawei.com>,
	<zengheng4@huawei.com>
References: <20240919084552.3591400-1-zhanjie9@hisilicon.com>
 <20240919084552.3591400-2-zhanjie9@hisilicon.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20240919084552.3591400-2-zhanjie9@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600004.china.huawei.com (7.193.23.242)

Hi Jie,

LGTM except for some trivial,
Reviewed-by: Huisong Li <lihuisong@huawei.com>


在 2024/9/19 16:45, Jie Zhan 写道:
> The CPPC performance feedback counters could be 0 or unchanged when the
> target cpu is in a low-power idle state, e.g. power-gated or clock-gated.
>
> When the counters are 0, cppc_cpufreq_get_rate() returns 0 KHz, which makes
> cpufreq_online() get a false error and fail to generate a cpufreq policy.
>
> When the counters are unchanged, the existing cppc_perf_from_fbctrs()
> returns a cached desired perf, but some platforms may update the real
> frequency back to the desired perf reg.
>
> For the above cases in cppc_cpufreq_get_rate(), get the latest desired perf
> to reflect the frequency; if failed, return the cached desired perf.
>
> Fixes: 6a4fec4f6d30 ("cpufreq: cppc: cppc_cpufreq_get_rate() returns zero in all error cases.")
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> Reviewed-by: Zeng Heng <zengheng4@huawei.com>
> Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
> ---
>   drivers/cpufreq/cppc_cpufreq.c | 49 +++++++++++++++++++++++++++-------
>   1 file changed, 39 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index bafa32dd375d..e55192303a9f 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -118,6 +118,9 @@ static void cppc_scale_freq_workfn(struct kthread_work *work)
>   
>   	perf = cppc_perf_from_fbctrs(cpu_data, &cppc_fi->prev_perf_fb_ctrs,
>   				     &fb_ctrs);
> +	if (!perf)
> +		return;
> +
>   	cppc_fi->prev_perf_fb_ctrs = fb_ctrs;
>   
>   	perf <<= SCHED_CAPACITY_SHIFT;
> @@ -726,11 +729,26 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
>   
>   	/* Check to avoid divide-by zero and invalid delivered_perf */
Now this comment can be removed, right?
>   	if (!delta_reference || !delta_delivered)
> -		return cpu_data->perf_ctrls.desired_perf;
> +		return 0;
>   
>   	return (reference_perf * delta_delivered) / delta_reference;
>   }
>   
> +static int cppc_get_perf_ctrs_sample(int cpu,
> +				     struct cppc_perf_fb_ctrs *fb_ctrs_t0,
> +				     struct cppc_perf_fb_ctrs *fb_ctrs_t1)
> +{
> +	int ret;
> +
> +	ret = cppc_get_perf_ctrs(cpu, fb_ctrs_t0);
> +	if (ret)
> +		return ret;
> +
> +	udelay(2); /* 2usec delay between sampling */
> +
> +	return cppc_get_perf_ctrs(cpu, fb_ctrs_t1);
> +}
> +
>   static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>   {
>   	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
> @@ -746,18 +764,29 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>   
>   	cpufreq_cpu_put(policy);
>   
> -	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
> -	if (ret)
> -		return 0;
> -
> -	udelay(2); /* 2usec delay between sampling */
> -
> -	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
> -	if (ret)
> -		return 0;
> +	ret = cppc_get_perf_ctrs_sample(cpu, &fb_ctrs_t0, &fb_ctrs_t1);
> +	if (ret) {
> +		if (ret == -EFAULT)
> +			goto out_invalid_counters;
suggest that add some comments for ret == -EFAULT case.
Because this error code depands on the implementation of cppc_get_perf_ctrs.
If add a new exception case which also return -EFAULT, then this switch 
is unreasonable.
> +		else
> +			return 0;
> +	}
>   
>   	delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
>   					       &fb_ctrs_t1);
> +	if (!delivered_perf)
> +		goto out_invalid_counters;
> +
> +	return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
> +
> +out_invalid_counters:
> +	/*
> +	 * Feedback counters could be unchanged or 0 when a cpu enters a
> +	 * low-power idle state, e.g. clock-gated or power-gated.
> +	 * Get the lastest or cached desired perf for reflecting frequency.
> +	 */
> +	if (cppc_get_desired_perf(cpu, &delivered_perf))
> +		delivered_perf = cpu_data->perf_ctrls.desired_perf;
>   
>   	return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
>   }

