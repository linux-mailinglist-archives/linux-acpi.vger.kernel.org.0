Return-Path: <linux-acpi+bounces-20358-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F28D230F9
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 09:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1ED3E301C368
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 08:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE17330676;
	Thu, 15 Jan 2026 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="crw+iAFP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562A332E13B;
	Thu, 15 Jan 2026 08:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465256; cv=none; b=bqYeX0Zn94ArMCyIFzw5g47VZ0hi8cQnhBOM6llsSsc6d02Wvc7pMbQg/1DjXqA0XaQfMHQH8uKSXiI0nR1n4UMaE9a61JdN8+Mr2Mszi0yHKIlWLQHi5QpMntBdnLhG1k9YBvU7EGmJ+Snl6a8KKLbKF+As18f87znI4jUNu3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465256; c=relaxed/simple;
	bh=jNIFovNVIGhlItKX0qGOBm3AOqzFkWf5UcB9Gb1ODGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e2s7LLEJtHrAbpTWdrbXGcztZ+ARMyl/axkypAa4Gx9lldMNzIDMQAIv5uUdHe4IZ7wOvq5IOpco2LWIsGe/g/m0i3HtJKRidTqaFIKFU/i+lYkdAxFi0inXo1XJimjdLK5GH47JcJ+RYPKgnQP3p0ecwHK0dBst1GmXizCMBEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=crw+iAFP; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tPJnyjjzBtAbdEvoWrXmQFCJkcMAShhpYesGC/5vtSc=;
	b=crw+iAFPcFtuUoDavH3ipN9sTep3cdG0djrDylZjNCZoR91Hb7UQpLa6WJ+r+tgElyGvudz2i
	TWFCd0YyInx1BIJKVm7lUEu9GrOEZ6JR7hao1f5VASKVHxWxWAa3f6FV7TIuWNmqzRZSQwp9Q75
	ci3XHV2W+X7MAHRpvNTa3tg=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dsG7J74zkz1K9Vh;
	Thu, 15 Jan 2026 16:17:32 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 133A74055B;
	Thu, 15 Jan 2026 16:20:51 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 15 Jan
 2026 16:20:49 +0800
Message-ID: <9e5d9733-10da-47c1-b265-07c6ac820ea6@huawei.com>
Date: Thu, 15 Jan 2026 16:20:49 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/11] cpufreq: CPPC: sync policy limits when updating
 min/max_perf
To: Sumit Gupta <sumitg@nvidia.com>
CC: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <corbet@lwn.net>, <pierre.gondois@arm.com>,
	<rdunlap@infradead.org>, <ray.huang@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>, <ionela.voinescu@arm.com>,
	<zhanjie9@hisilicon.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
	<vsethi@nvidia.com>, <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>,
	<nhartman@nvidia.com>, <bbasu@nvidia.com>
References: <20251223121307.711773-1-sumitg@nvidia.com>
 <20251223121307.711773-9-sumitg@nvidia.com>
 <9ea62a14-46a1-4238-97ed-aeabf9f3ab77@huawei.com>
 <2e0e7b5d-e424-4a45-9783-178a1af24ccc@nvidia.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <2e0e7b5d-e424-4a45-9783-178a1af24ccc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 2026/1/8 21:53, Sumit Gupta wrote:
> 
> On 25/12/25 19:26, zhenglifeng (A) wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 2025/12/23 20:13, Sumit Gupta wrote:
>>> When min_perf or max_perf is updated via sysfs in autonomous mode, the
>>> policy frequency limits should also be updated to reflect the new
>>> performance bounds.
>>>
>>> Add @update_policy parameter to cppc_cpufreq_set_mperf_limit() to
>>> control whether policy constraints are synced with HW registers.
>>> The policy is updated only when autonomous selection is enabled to
>>> keep SW limits in sync with HW.
>>>
>>> This ensures that scaling_min_freq and scaling_max_freq values remain
>>> consistent with the actual min/max_perf register values when operating
>>> in autonomous mode.
>>>
>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>> ---
>>>   drivers/cpufreq/cppc_cpufreq.c | 35 ++++++++++++++++++++++++++--------
>>>   1 file changed, 27 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>> index 1f8825006940..0202c7b823e6 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -544,14 +544,20 @@ static void populate_efficiency_class(void)
>>>    * cppc_cpufreq_set_mperf_limit - Set min/max performance limit
>>>    * @policy: cpufreq policy
>>>    * @val: performance value to set
>>> + * @update_policy: whether to update policy constraints
>>>    * @is_min: true for min_perf, false for max_perf
>>> + *
>>> + * When @update_policy is true, updates cpufreq policy frequency limits.
>>> + * @update_policy is false during cpu_init when policy isn't fully set up.
>>>    */
>>>   static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy *policy, u64 val,
>>> -                                     bool is_min)
>>> +                                     bool update_policy, bool is_min)
>>>   {
>>>        struct cppc_cpudata *cpu_data = policy->driver_data;
>>>        struct cppc_perf_caps *caps = &cpu_data->perf_caps;
>>>        unsigned int cpu = policy->cpu;
>>> +     struct freq_qos_request *req;
>>> +     unsigned int freq;
>>>        u32 perf;
>>>        int ret;
>>>
>>> @@ -571,15 +577,26 @@ static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy *policy, u64 val,
>>>        else
>>>                cpu_data->perf_ctrls.max_perf = perf;
>>>
>>> +     if (update_policy) {
>>> +             freq = cppc_perf_to_khz(caps, perf);
>>> +             req = is_min ? policy->min_freq_req : policy->max_freq_req;
>>> +
>>> +             ret = freq_qos_update_request(req, freq);
>>> +             if (ret < 0) {
>>> +                     pr_warn("Failed to update %s_freq constraint for CPU%d: %d\n",
>>> +                             is_min ? "min" : "max", cpu, ret);
>>> +                     return ret;
>>> +             }
>>> +     }
>>> +
>> OK. Now I see the necessity of extracting this function. But why not use
>> freq_khz as a input parameter and convert it to perf in this funciton,
>> since you need the freq here?
> 
> That will still need cppc_perf_to_khz to be called so that policy
> has what HW actually delivers. Otherwise, there could be some
> asymmetry.
> Also the clamping is done on perf values. So, if user provides a
> very high freq value then that will get passed to freq_qos and the
> HW register will have actual perf value which doesn't match with qos.
> 
> Either way the conversion chain is:
>   freq_to_perf -> clamp perf -> set perf -> perf_to_freq -> set qos
> It's just a matter of where we place the logic.

Yes, you are right. I missed the clamping. Thanks for the explanation.

> 
> Thank you,
> Sumit Gupta
> 
>>>        return 0;
>>>   }
>>>
>>> -#define cppc_cpufreq_set_min_perf(policy, val) \
>>> -     cppc_cpufreq_set_mperf_limit(policy, val, true)
>>> -
>>> -#define cppc_cpufreq_set_max_perf(policy, val) \
>>> -     cppc_cpufreq_set_mperf_limit(policy, val, false)
>>> +#define cppc_cpufreq_set_min_perf(policy, val, update_policy) \
>>> +     cppc_cpufreq_set_mperf_limit(policy, val, update_policy, true)
>>>
>>> +#define cppc_cpufreq_set_max_perf(policy, val, update_policy) \
>>> +     cppc_cpufreq_set_mperf_limit(policy, val, update_policy, false)
>>>   static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>>>   {
>>>        struct cppc_cpudata *cpu_data;
>>> @@ -988,7 +1005,8 @@ static ssize_t store_min_perf(struct cpufreq_policy *policy, const char *buf,
>>>        perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
>>>
>>>        guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
>>> -     ret = cppc_cpufreq_set_min_perf(policy, perf);
>>> +     ret = cppc_cpufreq_set_min_perf(policy, perf,
>>> +                                     cpu_data->perf_ctrls.auto_sel);
>>>        if (ret)
>>>                return ret;
>>>
>>> @@ -1045,7 +1063,8 @@ static ssize_t store_max_perf(struct cpufreq_policy *policy, const char *buf,
>>>        perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
>>>
>>>        guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
>>> -     ret = cppc_cpufreq_set_max_perf(policy, perf);
>>> +     ret = cppc_cpufreq_set_max_perf(policy, perf,
>>> +                                     cpu_data->perf_ctrls.auto_sel);
>>>        if (ret)
>>>                return ret;
>>>
> 


