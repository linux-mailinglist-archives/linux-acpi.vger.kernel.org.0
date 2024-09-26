Return-Path: <linux-acpi+bounces-8430-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E162D986F24
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 10:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC501C21909
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 08:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5F41A4F16;
	Thu, 26 Sep 2024 08:44:43 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBDA18F2F2;
	Thu, 26 Sep 2024 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340283; cv=none; b=ChLYz+YkNCEVNVUABd1Z4R6dLxb1gRgzzkTzNOOSpckIazX0pXWh2WLWXEJuQqkUbtrZQD5lLYslOfHqppi2W9t7kdQsQsac8oE1zEnzhPv4HIl/IuSv6J+2l10DRZsWyV36ZtY6cnRobjpyJUKl/HLMhAOVLTuFdh7asood5H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340283; c=relaxed/simple;
	bh=TgZ8xbjk0U5zw0mCJp1SNqt6tvdaH2wLHC49mMUW9EU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ewMAQRMcTa4M5iB9XovXclKLJX2Tx2hx8yE1aY73m2jVwWZBd1l8VwbzFXTsdv8lW2HtuJItDuU0sx43Am1EPKNIMAAlvJ2OADH734Du/9CfY/2+6qLxvSfnh92MMlj8xDb/UcdreCcQY2lf9AYQYvRd3RXPyd5d4ndN1TpIgMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XDnFH6Nk0z1SBqF;
	Thu, 26 Sep 2024 16:43:47 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (unknown [7.185.36.137])
	by mail.maildlp.com (Postfix) with ESMTPS id 05DA9180043;
	Thu, 26 Sep 2024 16:44:37 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 26 Sep
 2024 16:44:36 +0800
Message-ID: <08f5f2fa-7bce-2374-f58b-a1df9f481255@hisilicon.com>
Date: Thu, 26 Sep 2024 16:44:36 +0800
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
 <887a977c-c5b0-10d5-256c-06f278b667f7@hisilicon.com>
 <e8fdf684-07ca-fc05-e490-72fca37657e4@huawei.com>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <e8fdf684-07ca-fc05-e490-72fca37657e4@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500019.china.huawei.com (7.185.36.137)



On 26/09/2024 14:07, lihuisong (C) wrote:
> 
> 在 2024/9/26 10:57, Jie Zhan 写道:
>>
>> On 25/09/2024 17:28, lihuisong (C) wrote:
>>> Hi Jie,
>>>
>>> LGTM except for some trivial,
>>> Reviewed-by: Huisong Li <lihuisong@huawei.com>
>> Thanks.
>>
>>>
>>> 在 2024/9/19 16:45, Jie Zhan 写道:
>>>> The CPPC performance feedback counters could be 0 or unchanged when the
>>>> target cpu is in a low-power idle state, e.g. power-gated or clock-gated.
>>>>
>>>> When the counters are 0, cppc_cpufreq_get_rate() returns 0 KHz, which makes
>>>> cpufreq_online() get a false error and fail to generate a cpufreq policy.
>>>>
>>>> When the counters are unchanged, the existing cppc_perf_from_fbctrs()
>>>> returns a cached desired perf, but some platforms may update the real
>>>> frequency back to the desired perf reg.
>>>>
>>>> For the above cases in cppc_cpufreq_get_rate(), get the latest desired perf
>>>> to reflect the frequency; if failed, return the cached desired perf.
>>>>
>>>> Fixes: 6a4fec4f6d30 ("cpufreq: cppc: cppc_cpufreq_get_rate() returns zero in all error cases.")
>>>> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
>>>> Reviewed-by: Zeng Heng <zengheng4@huawei.com>
>>>> Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
>>>> ---
>>>>    drivers/cpufreq/cppc_cpufreq.c | 49 +++++++++++++++++++++++++++-------
>>>>    1 file changed, 39 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>>> index bafa32dd375d..e55192303a9f 100644
>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>> @@ -118,6 +118,9 @@ static void cppc_scale_freq_workfn(struct kthread_work *work)
>>>>          perf = cppc_perf_from_fbctrs(cpu_data, &cppc_fi->prev_perf_fb_ctrs,
>>>>                         &fb_ctrs);
>>>> +    if (!perf)
>>>> +        return;
>>>> +
>>>>        cppc_fi->prev_perf_fb_ctrs = fb_ctrs;
>>>>          perf <<= SCHED_CAPACITY_SHIFT;
>>>> @@ -726,11 +729,26 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
>>>>          /* Check to avoid divide-by zero and invalid delivered_perf */
>>> Now this comment can be removed, right?
>> Didn't notice this comment, but, having a check, I think it still fits.
>> '!delta_reference' avoids divide-by zero, and '!delta_delivered' checks
>> invalid delivered_perf.
> The comment  "avoid divide-by zero" is just for the below code: "(reference_perf * delta_delivered) / delta_reference".
> So It is also useful, but I think It's obvious and it doesn't make much sense.
> 
> The comment "avoid invalid delivered_perf" is for the return value.
> Now this func return zero which can't count as a valid delivered_perf, right?

so, what about this?

/*
 * Avoid divide-by zero and unchanged feedback counters.
 * Leave it for callers to handle.
 */

>>
>> So I think we just leave it unchanged.
>>

...

