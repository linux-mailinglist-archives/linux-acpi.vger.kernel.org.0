Return-Path: <linux-acpi+bounces-8419-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9884A986B19
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 04:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3061F22D67
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 02:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA20172BD5;
	Thu, 26 Sep 2024 02:58:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC05F4C91;
	Thu, 26 Sep 2024 02:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727319480; cv=none; b=qFiD/yAn9xXpr7hpZDof5sSW1BHwkRjvTWW8yWkcxr/MT407ZlwvC8reSRhN2IQxw+jFaY2XR0HNcPfMpTVRjIEMeWoVoIkzXLlNJBjOcKHp0UZ/O/dM8jpoLoh03YWQgrAGGtlMs4ASKCmTWWOg+7RoFIlH7pC+G4EvU7iQe7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727319480; c=relaxed/simple;
	bh=nLzQtHIeba8hCfgmHtfd7LWR9caXaIJNdrAhiNoEOas=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=au7MUfS7XLKBLoVupVLkrcN44jbf30lfkt1i4ewHfL3HbgViSwEQ4w40oYcr2p8GIT9IcYEUMo5ucTytDEu3PbwJ5IWVooxMxK5wlsGBz0lvxSRtVK+5VVJTFO0Hs/GYjjmNqBUpLiU3kFpUV2rCOP3Z34pu70XmNzeiuBEG7Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XDdXz71n6zySPF;
	Thu, 26 Sep 2024 10:56:51 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (unknown [7.185.36.137])
	by mail.maildlp.com (Postfix) with ESMTPS id C553D14037E;
	Thu, 26 Sep 2024 10:57:53 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 26 Sep
 2024 10:57:53 +0800
Message-ID: <887a977c-c5b0-10d5-256c-06f278b667f7@hisilicon.com>
Date: Thu, 26 Sep 2024 10:57:53 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v3 1/2] cppc_cpufreq: Use desired perf if feedback ctrs
 are 0 or unchanged
To: "lihuisong (C)" <lihuisong@huawei.com>, <ionela.voinescu@arm.com>,
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
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <f888bd45-120a-a045-c35c-52ae40ae8a9a@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500019.china.huawei.com (7.185.36.137)



On 25/09/2024 17:28, lihuisong (C) wrote:
> Hi Jie,
> 
> LGTM except for some trivial,
> Reviewed-by: Huisong Li <lihuisong@huawei.com>

Thanks.

> 
> 
> 在 2024/9/19 16:45, Jie Zhan 写道:
>> The CPPC performance feedback counters could be 0 or unchanged when the
>> target cpu is in a low-power idle state, e.g. power-gated or clock-gated.
>>
>> When the counters are 0, cppc_cpufreq_get_rate() returns 0 KHz, which makes
>> cpufreq_online() get a false error and fail to generate a cpufreq policy.
>>
>> When the counters are unchanged, the existing cppc_perf_from_fbctrs()
>> returns a cached desired perf, but some platforms may update the real
>> frequency back to the desired perf reg.
>>
>> For the above cases in cppc_cpufreq_get_rate(), get the latest desired perf
>> to reflect the frequency; if failed, return the cached desired perf.
>>
>> Fixes: 6a4fec4f6d30 ("cpufreq: cppc: cppc_cpufreq_get_rate() returns zero in all error cases.")
>> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
>> Reviewed-by: Zeng Heng <zengheng4@huawei.com>
>> Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 49 +++++++++++++++++++++++++++-------
>>   1 file changed, 39 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index bafa32dd375d..e55192303a9f 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -118,6 +118,9 @@ static void cppc_scale_freq_workfn(struct kthread_work *work)
>>         perf = cppc_perf_from_fbctrs(cpu_data, &cppc_fi->prev_perf_fb_ctrs,
>>                        &fb_ctrs);
>> +    if (!perf)
>> +        return;
>> +
>>       cppc_fi->prev_perf_fb_ctrs = fb_ctrs;
>>         perf <<= SCHED_CAPACITY_SHIFT;
>> @@ -726,11 +729,26 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
>>         /* Check to avoid divide-by zero and invalid delivered_perf */
> Now this comment can be removed, right?

Didn't notice this comment, but, having a check, I think it still fits.
'!delta_reference' avoids divide-by zero, and '!delta_delivered' checks
invalid delivered_perf.

So I think we just leave it unchanged.

>>       if (!delta_reference || !delta_delivered)
>> -        return cpu_data->perf_ctrls.desired_perf;
>> +        return 0;
>>         return (reference_perf * delta_delivered) / delta_reference;
>>   }
>>   +static int cppc_get_perf_ctrs_sample(int cpu,
>> +                     struct cppc_perf_fb_ctrs *fb_ctrs_t0,
>> +                     struct cppc_perf_fb_ctrs *fb_ctrs_t1)
>> +{
>> +    int ret;
>> +
>> +    ret = cppc_get_perf_ctrs(cpu, fb_ctrs_t0);
>> +    if (ret)
>> +        return ret;
>> +
>> +    udelay(2); /* 2usec delay between sampling */
>> +
>> +    return cppc_get_perf_ctrs(cpu, fb_ctrs_t1);
>> +}
>> +
>>   static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>>   {
>>       struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
>> @@ -746,18 +764,29 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>>         cpufreq_cpu_put(policy);
>>   -    ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
>> -    if (ret)
>> -        return 0;
>> -
>> -    udelay(2); /* 2usec delay between sampling */
>> -
>> -    ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>> -    if (ret)
>> -        return 0;
>> +    ret = cppc_get_perf_ctrs_sample(cpu, &fb_ctrs_t0, &fb_ctrs_t1);
>> +    if (ret) {
>> +        if (ret == -EFAULT)
>> +            goto out_invalid_counters;
> suggest that add some comments for ret == -EFAULT case.
> Because this error code depands on the implementation of cppc_get_perf_ctrs.
> If add a new exception case which also return -EFAULT, then this switch is unreasonable.

Sure. What about adding the following comment:

/* -EFAULT indicates that any of the associated CPPC regs is 0. */

Thanks,
Jie

