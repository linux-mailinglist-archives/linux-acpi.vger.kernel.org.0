Return-Path: <linux-acpi+bounces-7760-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF4A959761
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 11:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFFD282F88
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 09:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CC41CEAAA;
	Wed, 21 Aug 2024 08:27:54 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22781CEAA9;
	Wed, 21 Aug 2024 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228874; cv=none; b=LRBISR3eMHCmzF7GqquDEYMVe8x4VEle8fzaCgrh3Jv21qGQhWtoA9yKJhbTV3eGe6sM5Jwjz6lhAMr5BaCqGO3ZareRIvd/ufFfiqlIrIZxfKC+SYzjLTI1dYZ1+Qj69RBumX7NVIkgok1mSIj9MrOJ71Abx/IaaBL9m4KmYQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228874; c=relaxed/simple;
	bh=Mbl+K9e9r1SELiw4zifA7HO58ZVuZqTcMRNm3f/JQNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LQabYXalsaQc1RSj866OmDaSCKJ/exQON61b/cpyYsvRoe8p7YoQtaZzKbxoYGLXLifL8sXgJxSJrQ6H/Pvr3RzrB8EOqnBTfMqu6cH8YfURM2xEIvrfVyx5q01Rl9lyam8ec+3wdeJ3soHCwR09fLh6bevhtSyskT5V4AYGzjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WpfYD5NYBz1xvMd;
	Wed, 21 Aug 2024 16:25:52 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (unknown [7.185.36.137])
	by mail.maildlp.com (Postfix) with ESMTPS id 3FC051A016C;
	Wed, 21 Aug 2024 16:27:47 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 Aug
 2024 16:27:46 +0800
Message-ID: <d32acf92-b8a3-234a-948f-7ccceea85a45@hisilicon.com>
Date: Wed, 21 Aug 2024 16:27:46 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] cpufreq: CPPC: Return desired perf in ->get() if feedback
 counters are 0
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linuxarm@huawei.com>, <liaochang1@huawei.com>, <wanghuiqiang@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>,
	<jonathan.cameron@huawei.com>, <linux-arm-kernel@lists.infradead.org>, Jie
 Zhan <zhanjie9@hisilicon.com>
References: <20240819035147.2239767-1-zhanjie9@hisilicon.com>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20240819035147.2239767-1-zhanjie9@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500019.china.huawei.com (7.185.36.137)

cc linux-arm-kernel

On 19/08/2024 11:51, Jie Zhan wrote:
> The CPPC performance feedback counters could return 0 when the target cpu
> is in a deep idle state (e.g. powered off) and those counters are not
> powered.  cppc_cpufreq_get_rate() returns 0 in this case, triggering two
> problems:
>
> 1. cpufreq_online() gets a false error and doesn't generate a cpufreq
> policy, which happens in cpufreq_add_dev() when a new cpu device is added.
> 2. 'cpuinfo_cur_freq' shows '<unknown>'
>
> Don't take it as an error and return the frequency corresponding to the
> desired perf when the feedback counters are 0.
>
> Fixes: 6a4fec4f6d30 ("cpufreq: cppc: cppc_cpufreq_get_rate() returns zero in all error cases.")
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
>   drivers/cpufreq/cppc_cpufreq.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index bafa32dd375d..1c5eb12c1a5a 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -748,18 +748,25 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>   
>   	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
>   	if (ret)
> -		return 0;
> +		goto out_err;
>   
>   	udelay(2); /* 2usec delay between sampling */
>   
>   	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>   	if (ret)
> -		return 0;
> +		goto out_err;
>   
>   	delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
>   					       &fb_ctrs_t1);
>   
>   	return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
> +
> +out_err:
> +	if (ret == -EFAULT)
> +		return cppc_perf_to_khz(&cpu_data->perf_caps,
> +					cpu_data->perf_ctrls.desired_perf);
> +
> +	return 0;
>   }
>   
>   static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)


