Return-Path: <linux-acpi+bounces-8428-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EC7986C43
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 08:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76EF61C21D9D
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 06:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2877C17BB30;
	Thu, 26 Sep 2024 06:07:41 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF771171C;
	Thu, 26 Sep 2024 06:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727330861; cv=none; b=YxJCjdenRy7tmggRSfGNYE031oE9mnDzZJkLWYqZ6gSXER/sd+04dNBLEMvD1t1dOInm30gxUckIukWq/2U4ppbZ+M/iQQ1wt5JPJHwvj71a5qLXjfoxQ/7wdfxGOcZ46qedW+jcW7V0kQqlYwntARojgUdArLKJtH3sYyu/QEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727330861; c=relaxed/simple;
	bh=flE0/SxIw2s1/D3xi1uXsTnhucCGP69VaiwLMl+F8wM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UqEH+RAOZglR5+3XtpSQ3E1zFvK7Jz5MUMd2g2g4w2fcdgexM6LcS0/q41kSTsWd5Z1LxF5F7o4DNVK8wBfnAbbBXfCUYbwAldV/W0/pY+5sFhwnqgn4TbFBF4J9tnFi2U3FHc3hfmIWei5dAiLScNB/Q3QnI7QIZK0UcroVLng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XDjlN5xjnz10MfK;
	Thu, 26 Sep 2024 14:06:08 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 26CEA1402CD;
	Thu, 26 Sep 2024 14:07:35 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 26 Sep
 2024 14:07:34 +0800
Message-ID: <e8fdf684-07ca-fc05-e490-72fca37657e4@huawei.com>
Date: Thu, 26 Sep 2024 14:07:33 +0800
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
 <f888bd45-120a-a045-c35c-52ae40ae8a9a@huawei.com>
 <887a977c-c5b0-10d5-256c-06f278b667f7@hisilicon.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <887a977c-c5b0-10d5-256c-06f278b667f7@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600004.china.huawei.com (7.193.23.242)


在 2024/9/26 10:57, Jie Zhan 写道:
>
> On 25/09/2024 17:28, lihuisong (C) wrote:
>> Hi Jie,
>>
>> LGTM except for some trivial,
>> Reviewed-by: Huisong Li <lihuisong@huawei.com>
> Thanks.
>
>>
>> 在 2024/9/19 16:45, Jie Zhan 写道:
>>> The CPPC performance feedback counters could be 0 or unchanged when the
>>> target cpu is in a low-power idle state, e.g. power-gated or clock-gated.
>>>
>>> When the counters are 0, cppc_cpufreq_get_rate() returns 0 KHz, which makes
>>> cpufreq_online() get a false error and fail to generate a cpufreq policy.
>>>
>>> When the counters are unchanged, the existing cppc_perf_from_fbctrs()
>>> returns a cached desired perf, but some platforms may update the real
>>> frequency back to the desired perf reg.
>>>
>>> For the above cases in cppc_cpufreq_get_rate(), get the latest desired perf
>>> to reflect the frequency; if failed, return the cached desired perf.
>>>
>>> Fixes: 6a4fec4f6d30 ("cpufreq: cppc: cppc_cpufreq_get_rate() returns zero in all error cases.")
>>> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
>>> Reviewed-by: Zeng Heng <zengheng4@huawei.com>
>>> Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
>>> ---
>>>    drivers/cpufreq/cppc_cpufreq.c | 49 +++++++++++++++++++++++++++-------
>>>    1 file changed, 39 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>> index bafa32dd375d..e55192303a9f 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -118,6 +118,9 @@ static void cppc_scale_freq_workfn(struct kthread_work *work)
>>>          perf = cppc_perf_from_fbctrs(cpu_data, &cppc_fi->prev_perf_fb_ctrs,
>>>                         &fb_ctrs);
>>> +    if (!perf)
>>> +        return;
>>> +
>>>        cppc_fi->prev_perf_fb_ctrs = fb_ctrs;
>>>          perf <<= SCHED_CAPACITY_SHIFT;
>>> @@ -726,11 +729,26 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
>>>          /* Check to avoid divide-by zero and invalid delivered_perf */
>> Now this comment can be removed, right?
> Didn't notice this comment, but, having a check, I think it still fits.
> '!delta_reference' avoids divide-by zero, and '!delta_delivered' checks
> invalid delivered_perf.
The comment  "avoid divide-by zero" is just for the below code: 
"(reference_perf * delta_delivered) / delta_reference".
So It is also useful, but I think It's obvious and it doesn't make much 
sense.

The comment "avoid invalid delivered_perf" is for the return value.
Now this func return zero which can't count as a valid delivered_perf, 
right?
>
> So I think we just leave it unchanged.
>
>>>        if (!delta_reference || !delta_delivered)
>>> -        return cpu_data->perf_ctrls.desired_perf;
>>> +        return 0;
>>>          return (reference_perf * delta_delivered) / delta_reference;
>>>    }
>>>    +static int cppc_get_perf_ctrs_sample(int cpu,
>>> +                     struct cppc_perf_fb_ctrs *fb_ctrs_t0,
>>> +                     struct cppc_perf_fb_ctrs *fb_ctrs_t1)
>>> +{
>>> +    int ret;
>>> +
>>> +    ret = cppc_get_perf_ctrs(cpu, fb_ctrs_t0);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    udelay(2); /* 2usec delay between sampling */
>>> +
>>> +    return cppc_get_perf_ctrs(cpu, fb_ctrs_t1);
>>> +}
>>> +
>>>    static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>>>    {
>>>        struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
>>> @@ -746,18 +764,29 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>>>          cpufreq_cpu_put(policy);
>>>    -    ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
>>> -    if (ret)
>>> -        return 0;
>>> -
>>> -    udelay(2); /* 2usec delay between sampling */
>>> -
>>> -    ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>>> -    if (ret)
>>> -        return 0;
>>> +    ret = cppc_get_perf_ctrs_sample(cpu, &fb_ctrs_t0, &fb_ctrs_t1);
>>> +    if (ret) {
>>> +        if (ret == -EFAULT)
>>> +            goto out_invalid_counters;
>> suggest that add some comments for ret == -EFAULT case.
>> Because this error code depands on the implementation of cppc_get_perf_ctrs.
>> If add a new exception case which also return -EFAULT, then this switch is unreasonable.
> Sure. What about adding the following comment:
>
> /* -EFAULT indicates that any of the associated CPPC regs is 0. */
Ack
> .

