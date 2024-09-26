Return-Path: <linux-acpi+bounces-8434-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46515987107
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 12:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D24B2B22250
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 10:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CD31AAE29;
	Thu, 26 Sep 2024 10:08:45 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E829F1A4E97;
	Thu, 26 Sep 2024 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727345325; cv=none; b=DkZnzDfmStiLOO/so11HbsLIX7NFS3Pj/xiipj9rEJaQfD42b2DhumpS9sDcD6hI2flfKcLX1obw4TIswSYr2ceJwZ8rkH6yfeqCeO9fz2VM7aLfcMWHt55IbaiVh2lvfgGYMrq9KD3GkMyxVKQRLx7iIY0VmzHTx6PXFYxWuH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727345325; c=relaxed/simple;
	bh=EGrH+x5GWIXszGGQ2IkFU3XWnO7K8/FafZ1yKMNWDqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ISBjcYDTs6J8U9fcKxr+o2jv9UoQrGG4FFX0aaU5qZOkSxRack29BVT0LHU853VjDnXARhHKAZuUHpLX8tEqVZCWnb4Yu+KhXYxTKd8bb1mF9UXxbLQdrbLK7eDteoaegomhxVy6Nc0jtioeljZvwTs+cuSF7h8cl7fGtOtyeZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XDq7D5Czjz1ymKS;
	Thu, 26 Sep 2024 18:08:40 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id DBA891402C6;
	Thu, 26 Sep 2024 18:08:38 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 26 Sep
 2024 18:08:38 +0800
Message-ID: <1741806e-c6a9-a365-bd59-de9b27c7275b@huawei.com>
Date: Thu, 26 Sep 2024 18:08:37 +0800
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
 <e8fdf684-07ca-fc05-e490-72fca37657e4@huawei.com>
 <08f5f2fa-7bce-2374-f58b-a1df9f481255@hisilicon.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <08f5f2fa-7bce-2374-f58b-a1df9f481255@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600004.china.huawei.com (7.193.23.242)


在 2024/9/26 16:44, Jie Zhan 写道:
>
> On 26/09/2024 14:07, lihuisong (C) wrote:
>> 在 2024/9/26 10:57, Jie Zhan 写道:
>>> On 25/09/2024 17:28, lihuisong (C) wrote:
>>>> Hi Jie,
>>>>
>>>> LGTM except for some trivial,
>>>> Reviewed-by: Huisong Li <lihuisong@huawei.com>
>>> Thanks.
>>>
>>>> 在 2024/9/19 16:45, Jie Zhan 写道:
>>>>> The CPPC performance feedback counters could be 0 or unchanged when the
>>>>> target cpu is in a low-power idle state, e.g. power-gated or clock-gated.
>>>>>
>>>>> When the counters are 0, cppc_cpufreq_get_rate() returns 0 KHz, which makes
>>>>> cpufreq_online() get a false error and fail to generate a cpufreq policy.
>>>>>
>>>>> When the counters are unchanged, the existing cppc_perf_from_fbctrs()
>>>>> returns a cached desired perf, but some platforms may update the real
>>>>> frequency back to the desired perf reg.
>>>>>
>>>>> For the above cases in cppc_cpufreq_get_rate(), get the latest desired perf
>>>>> to reflect the frequency; if failed, return the cached desired perf.
>>>>>
>>>>> Fixes: 6a4fec4f6d30 ("cpufreq: cppc: cppc_cpufreq_get_rate() returns zero in all error cases.")
>>>>> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
>>>>> Reviewed-by: Zeng Heng <zengheng4@huawei.com>
>>>>> Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
>>>>> ---
>>>>>     drivers/cpufreq/cppc_cpufreq.c | 49 +++++++++++++++++++++++++++-------
>>>>>     1 file changed, 39 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>>>> index bafa32dd375d..e55192303a9f 100644
>>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>>> @@ -118,6 +118,9 @@ static void cppc_scale_freq_workfn(struct kthread_work *work)
>>>>>           perf = cppc_perf_from_fbctrs(cpu_data, &cppc_fi->prev_perf_fb_ctrs,
>>>>>                          &fb_ctrs);
>>>>> +    if (!perf)
>>>>> +        return;
>>>>> +
>>>>>         cppc_fi->prev_perf_fb_ctrs = fb_ctrs;
>>>>>           perf <<= SCHED_CAPACITY_SHIFT;
>>>>> @@ -726,11 +729,26 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
>>>>>           /* Check to avoid divide-by zero and invalid delivered_perf */
>>>> Now this comment can be removed, right?
>>> Didn't notice this comment, but, having a check, I think it still fits.
>>> '!delta_reference' avoids divide-by zero, and '!delta_delivered' checks
>>> invalid delivered_perf.
>> The comment  "avoid divide-by zero" is just for the below code: "(reference_perf * delta_delivered) / delta_reference".
>> So It is also useful, but I think It's obvious and it doesn't make much sense.
>>
>> The comment "avoid invalid delivered_perf" is for the return value.
>> Now this func return zero which can't count as a valid delivered_perf, right?
> so, what about this?
>
> /*
>   * Avoid divide-by zero and unchanged feedback counters.
>   * Leave it for callers to handle.
>   */
good.
>>> So I think we just leave it unchanged.
>>>
> ...
> .

