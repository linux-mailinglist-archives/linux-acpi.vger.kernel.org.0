Return-Path: <linux-acpi+bounces-7922-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1A09623D4
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 11:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE9C1F2502E
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 09:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CD4166F03;
	Wed, 28 Aug 2024 09:45:18 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165E1158DC2;
	Wed, 28 Aug 2024 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724838318; cv=none; b=gATvmWLb0+giFuRNv/tNQ+45C1OkcQbx1BWo2dhkb0tEbaZXTf7yTWaFK0gB4lZU1REtUX6d+s7YdxZ+UFyTpGWeQej0GJArWJ3lO4q+rgquLVVpSiDGxCmwnmLSfquMoO4eXXBEJ+5q615zQmXbLYGsNhVlZsDmqoYRiSrjGv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724838318; c=relaxed/simple;
	bh=UFCheuUnEjanJzFNYuMmgX4QSaijg7tKgWgBm+39LUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r/6plvTPfsLsJwn6wb4tmc8QQMvzJE5PR7S6t0ZltrZjcfmMnNtOnBjYSte3XqKXVYGFhzjNUW3ThPHZdIj/aM64vONo9i98Y4gB/KNH/8uwA6TMihQpmHxG9SH/uKMfZtzb238EehoNreH3tbWDUDf8e/9qcZ7QZpA6X3Slvkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wtzyv6nFVzyRCx;
	Wed, 28 Aug 2024 17:44:39 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (unknown [7.185.36.137])
	by mail.maildlp.com (Postfix) with ESMTPS id 3FC78180AE8;
	Wed, 28 Aug 2024 17:45:10 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 17:45:09 +0800
Message-ID: <a2746b02-f6ad-edd6-09fe-9df0c40a6995@hisilicon.com>
Date: Wed, 28 Aug 2024 17:45:09 +0800
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
To: Ionela Voinescu <ionela.voinescu@arm.com>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: Beata Michalska <beata.michalska@arm.com>, <rafael@kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linuxarm@huawei.com>, <liaochang1@huawei.com>, <wanghuiqiang@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>,
	<jonathan.cameron@huawei.com>
References: <20240819035147.2239767-1-zhanjie9@hisilicon.com>
 <20240828065041.xf4csybut3csl5mn@vireshk-i7> <Zs7dHdj6xaR1cpSN@arm.com>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <Zs7dHdj6xaR1cpSN@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500019.china.huawei.com (7.185.36.137)



On 28/08/2024 16:17, Ionela Voinescu wrote:
> Hi,
>
> On Wednesday 28 Aug 2024 at 12:20:41 (+0530), Viresh Kumar wrote:
>> Cc'd few developers.
>>
>> On 19-08-24, 11:51, Jie Zhan wrote:
>>> The CPPC performance feedback counters could return 0 when the target cpu
>>> is in a deep idle state (e.g. powered off) and those counters are not
>>> powered.  cppc_cpufreq_get_rate() returns 0 in this case, triggering two
>>> problems:
>>>
>>> 1. cpufreq_online() gets a false error and doesn't generate a cpufreq
>>> policy, which happens in cpufreq_add_dev() when a new cpu device is added.
>>> 2. 'cpuinfo_cur_freq' shows '<unknown>'
Hi Ionela,
> I suppose 2. is not necessarily a problem as the current (hardware)
> frequency is indeed unknown.
>
> But there's not clean way to fix 1. while keeping 2. as is, or at least
> not one I could identify.
Yeah. 1 is the main thing to deal with.
>>> Don't take it as an error and return the frequency corresponding to the
>>> desired perf when the feedback counters are 0.
>>>
>>> Fixes: 6a4fec4f6d30 ("cpufreq: cppc: cppc_cpufreq_get_rate() returns zero in all error cases.")
>>> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
>>> ---
>>>   drivers/cpufreq/cppc_cpufreq.c | 11 +++++++++--
>>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>> index bafa32dd375d..1c5eb12c1a5a 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -748,18 +748,25 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>>>   
>>>   	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
>>>   	if (ret)
>>> -		return 0;
>>> +		goto out_err;
>>>   
>>>   	udelay(2); /* 2usec delay between sampling */
>>>   
>>>   	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>>>   	if (ret)
>>> -		return 0;
>>> +		goto out_err;
>>>   
>>>   	delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
>>>   					       &fb_ctrs_t1);
>>>   
>>>   	return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
>>> +
>>> +out_err:
>>> +	if (ret == -EFAULT)
>>> +		return cppc_perf_to_khz(&cpu_data->perf_caps,
>>> +					cpu_data->perf_ctrls.desired_perf);
>>> +
> A better way might be to cppc_get_desired_perf(cpu, &desired_perf) first
> and return the khz equivalent of the result, as currently done in
> hisi_cppc_cpufreq_get_rate(). Even a merge of the two functions might be
> suitable, but I'm not familiar with the specifics of the hisilicon platforms
> involved. This might be better as some platforms can provide performance
> feedback through the desired performance register so a read of it would
> be better than using the cached desired_perf value.
>
> Hope it helps,
> Ionela.
Sure, understood.
Getting the latest desired perf would be more compatible across platforms.

Merging hisi_cppc_cpufreq_get_rate() can be risky but worth a try. The
workaround also disables the FIE. I'll figure out whether it's feasible 
to do.

I'll send a V2 if no objection to the error handling.

Thanks,
Jie
>
>>> +	return 0;
>>>   }
>>>   
>>>   static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
>>> -- 
>>> 2.33.0
>>>
>> -- 
>> viresh


