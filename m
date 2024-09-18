Return-Path: <linux-acpi+bounces-8325-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA6597B6AF
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Sep 2024 04:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CCCF1F23404
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Sep 2024 02:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8043F137764;
	Wed, 18 Sep 2024 02:05:57 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ACB136327;
	Wed, 18 Sep 2024 02:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726625157; cv=none; b=QyfkNXltW9qmlHlnj2YBnsZPOE40e7l7EgLQ0adgLGt3yszeB4aaISVQKeUF8GHT6cQraK37ABFEywfcutObfyR9nDECLdpaKb2zOU9sw9yJ76l5LHTW+FUy8SKZ73Mk57c8Y0MwrTt1pZpuYMHTCNxDzisk3el7g9JIH4sIBJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726625157; c=relaxed/simple;
	bh=KrOXD7A/FkKn0wwCwj6Sz7Ilamj4RI10vkzdupgq/aQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qGwQujjOc/j/+1i09XN/YMhJ6InIFgwn9vujYz9nnNFov913VeHFxO7SfMqiyHFzPd5s4i4acoNW1srRgm0kPgK/KFkLLOw8VwAG6McYyLhvrPiOodGwzTyePYO/ktLY3tOhQZ0zxnDbtR6jt0CVufHq/qEGcJIyG8VwnAWaD3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4X7hmr71hDzFqmn;
	Wed, 18 Sep 2024 10:05:00 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (unknown [7.185.36.137])
	by mail.maildlp.com (Postfix) with ESMTPS id 737661402E0;
	Wed, 18 Sep 2024 10:05:14 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 18 Sep
 2024 10:05:14 +0800
Message-ID: <30147eff-6e2f-1651-3875-52c9401273fb@hisilicon.com>
Date: Wed, 18 Sep 2024 10:05:13 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 1/3] cppc_cpufreq: Return desired perf in ->get() if
 feedback counters are 0
To: Ionela Voinescu <ionela.voinescu@arm.com>
CC: <beata.michalska@arm.com>, <wangxiongfeng2@huawei.com>,
	<viresh.kumar@linaro.org>, <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<wanghuiqiang@huawei.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>,
	<yangyicong@huawei.com>, <liaochang1@huawei.com>, <zengheng4@huawei.com>
References: <20240912072231.439332-1-zhanjie9@hisilicon.com>
 <20240912072231.439332-2-zhanjie9@hisilicon.com> <ZuK3sfcKf2gHssKa@arm.com>
 <79353a26-7304-9d6a-9237-cfa8e7794601@hisilicon.com>
 <ZulbtT8joKPXlFCL@arm.com>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <ZulbtT8joKPXlFCL@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500019.china.huawei.com (7.185.36.137)



On 17/09/2024 18:36, Ionela Voinescu wrote:

...

>>> @@ -747,19 +750,22 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>>>         cpufreq_cpu_put(policy);
>>>
>>>         ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
>>> -       if (ret)
>>> -               return 0;
>>> -
>>> -       udelay(2); /* 2usec delay between sampling */
>>> -
>>> -       ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>>> -       if (ret)
>>> -               return 0;
>>> +       if (!ret) {
>>> +               udelay(2); /* 2usec delay between sampling */
>>> +               ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>>> +       }
>>> +       if (!ret)
>>> +               delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
>>> +                                                      &fb_ctrs_t1);
>>
>> TBH, 'if (!ret)' style looks very strange to me.
>> We haven't done so anywhere in cppc_cpufreq, so let's keep consistency and make
>> it easier for people to read and maintain?
> 
> I agree it's a bit of a difficult read, that's why I only sent my code
> as a suggestion. I did like the benefit of not having to have two
> different calls to cppc_perf_to_khz() and making the code below common
> for the error and non-error paths. But it's up to you. 

Yeah understood. I did try minimizing duplicate code, but ended up with either
duplicate 'get desired perf' stuff or duplicate cppc_perf_to_khz().

...
>>
>>           delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
>>                                                  &fb_ctrs_t1);
> 
> You need a check here for !delivered_perf (when at least one of the
> deltas is 0) in which case it would be good to take the same error path
> below. Something like:
> 
>             if(delivered_perf)
> 	            return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
> 	    else
> 		ret = -EFAULT;
> 
> That's why I did the tricky if/else dance above as we need to take the
> error path below for multiple cases.
> 
> Thanks,
> Ionela.
> 

Sure, thanks for reminding this.

...

How does this look? I think this should have the least duplicate code except for
two cppc_perf_to_khz() calls, while keeping the logic easy to follow.

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index bafa32dd375d..6070444ed098 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -118,6 +118,9 @@ static void cppc_scale_freq_workfn(struct kthread_work *work)
 
        perf = cppc_perf_from_fbctrs(cpu_data, &cppc_fi->prev_perf_fb_ctrs,
                                     &fb_ctrs);
+       if (!perf)
+               return;
+
        cppc_fi->prev_perf_fb_ctrs = fb_ctrs;
 
        perf <<= SCHED_CAPACITY_SHIFT;
@@ -726,11 +729,27 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
 
        /* Check to avoid divide-by zero and invalid delivered_perf */
        if (!delta_reference || !delta_delivered)
-               return cpu_data->perf_ctrls.desired_perf;
+               return 0;
 
        return (reference_perf * delta_delivered) / delta_reference;
 }
 
+static int cppc_get_perf_ctrs_sample(int cpu,
+                                    struct cppc_perf_fb_ctrs *fb_ctrs_t0,
+                                    struct cppc_perf_fb_ctrs *fb_ctrs_t1)
+{
+       int ret;
+
+       ret = cppc_get_perf_ctrs(cpu, fb_ctrs_t0);
+       if (ret)
+               return ret;
+
+       udelay(2); /* 2usec delay between sampling */
+
+       ret = cppc_get_perf_ctrs(cpu, fb_ctrs_t1);
+       return ret;
+}
+
 static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 {
        struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
@@ -746,20 +765,30 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 
        cpufreq_cpu_put(policy);
 
-       ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
-       if (ret)
-               return 0;
-
-       udelay(2); /* 2usec delay between sampling */
-
-       ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
-       if (ret)
-               return 0;
+       ret = cppc_get_perf_ctrs_sample(cpu, &fb_ctrs_t0, &fb_ctrs_t1);
+       if (ret) {
+               if (ret == -EFAULT)
+                       goto out_invalid_counters;
+               else
+                       return 0;
+       }
 
        delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
                                               &fb_ctrs_t1);
+       if (!delivered_perf)
+               goto out_invalid_counters;
 
        return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
+
+out_invalid_counters:
+       /*
+        * Feedback counters could be unchanged or 0 when a cpu enters a
+        * low-power idle state, e.g. clock-gated or power-gated.
+        * Get the lastest or cached desired perf for reflecting frequency.
+        */
+       if (cppc_get_desired_perf(cpu, &delivered_perf))
+               delivered_perf = cpu_data->perf_ctrls.desired_perf;
+       return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
 }
 
 static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)


Thanks!
Jie

