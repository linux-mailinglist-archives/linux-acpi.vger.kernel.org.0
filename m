Return-Path: <linux-acpi+bounces-20359-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E440D2350C
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 09:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83C193061155
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 08:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B3E340A4C;
	Thu, 15 Jan 2026 08:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="RD71lJTS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578FC32B9B4;
	Thu, 15 Jan 2026 08:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768467492; cv=none; b=a6VDKRT36K256LPkiGtK0Sz9RRKKIbv0+lqwv1Dxxi28dMQ7DdA8KeF44pjh49NlPg6u9G1VC/5bThRnmBbEvy0jAeaxC2aTkO4bUSFrX4n5/DHPXc45qOQhGL+thhFiTKVeAONsiHrHJOAkcoUc04fSvo95Nkyx7msVLfWLl9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768467492; c=relaxed/simple;
	bh=B2ircWOnxIY1pU54fNDLsd4VKwrmRZJntAlog/mRaQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=W/5G9MntMO4O2v57Y7JBKnGFHYdBXcQ5FOPuWtM47H61WXSA18wnKhjktVR7OMsgUrWWZcVWoJBOfy+fOBTYTmZ9cauL6RavWrmmfesIcYv9NvNWvE6okfYdwZqMzTiPXAFe/zIvGAKpns1LO4Bep6DCOMvNbZ7IJ0q5QfZXd6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=RD71lJTS; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=aeiL2R6ODZn3JTHgngaW3ACQLXMC+A3IlTyFLau/KNQ=;
	b=RD71lJTS45cgKDWBa+lYXVvBGHkXoPIHbvfnJuMjjWRhxNfHjD2pU6MQM+IxZ/YMS2s64pTll
	0+iaiNMozD3NaSy7scq9tjyz97s6unuRKbrZ6IEQtNa52MJQZvmWYfTw1ERvB7moSdS6zlX+C4r
	+8lDmj4dhbRAMDw1yvLfcsc=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dsGyB0JWTz1K983;
	Thu, 15 Jan 2026 16:54:42 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 26D5140565;
	Thu, 15 Jan 2026 16:58:00 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 15 Jan
 2026 16:57:59 +0800
Message-ID: <7e5bfa69-96e2-4f54-9446-cc64845b52cd@huawei.com>
Date: Thu, 15 Jan 2026 16:57:58 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/11] cpufreq: CPPC: sync policy limits when toggling
 auto_select
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
 <20251223121307.711773-10-sumitg@nvidia.com>
 <ae4ff90a-d2c4-4c13-9d65-a0f266bb4b4b@huawei.com>
 <fb876f94-f92e-4c8a-9b64-fe9118a15595@nvidia.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <fb876f94-f92e-4c8a-9b64-fe9118a15595@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 2026/1/8 22:21, Sumit Gupta wrote:
> 
> On 26/12/25 08:25, zhenglifeng (A) wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 2025/12/23 20:13, Sumit Gupta wrote:
>>> When CPPC autonomous selection (auto_select) is enabled or disabled,
>>> the policy min/max frequency limits should be updated appropriately to
>>> reflect the new operating mode.
>>>
>>> Currently, toggling auto_select only changes the hardware register but
>>> doesn't update the cpufreq policy constraints, which can lead to
>>> inconsistent behavior between the hardware state and the policy limits
>>> visible to userspace.
>>>
>>> Add cppc_cpufreq_update_autosel_config() function to handle the
>>> auto_select toggle by syncing min/max_perf values with policy
>>> constraints. When enabling auto_sel, restore preserved min/max_perf
>>> values to policy limits. When disabling, reset policy to defaults
>>> while preserving hardware register values for later use.
>>>
>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>> ---
>>>   drivers/cpufreq/cppc_cpufreq.c | 112 +++++++++++++++++++++++++++------
>>>   1 file changed, 92 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>> index 0202c7b823e6..b1f570d6de34 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -544,14 +544,20 @@ static void populate_efficiency_class(void)
>>>    * cppc_cpufreq_set_mperf_limit - Set min/max performance limit
>>>    * @policy: cpufreq policy
>>>    * @val: performance value to set
>>> + * @update_reg: whether to update hardware register
>>>    * @update_policy: whether to update policy constraints
>>>    * @is_min: true for min_perf, false for max_perf
>>>    *
>>> + * When @update_reg is true, writes to HW registers and preserves values.
>>>    * When @update_policy is true, updates cpufreq policy frequency limits.
>>> + *
>>> + * @update_reg is false when disabling auto_sel to preserve HW values.
>>> + * The preserved value is used on next enabling of the autonomous mode.
>>>    * @update_policy is false during cpu_init when policy isn't fully set up.
>>>    */
>>>   static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy *policy, u64 val,
>>> -                                     bool update_policy, bool is_min)
>>> +                                     bool update_reg, bool update_policy,
>>> +                                     bool is_min)
>>>   {
>>>        struct cppc_cpudata *cpu_data = policy->driver_data;
>>>        struct cppc_perf_caps *caps = &cpu_data->perf_caps;
>>> @@ -563,19 +569,22 @@ static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy *policy, u64 val,
>>>
>>>        perf = clamp(val, caps->lowest_perf, caps->highest_perf);
>>>
>>> -     ret = is_min ? cppc_set_min_perf(cpu, perf) :
>>> -                    cppc_set_max_perf(cpu, perf);
>>> -     if (ret) {
>>> -             if (ret != -EOPNOTSUPP)
>>> -                     pr_warn("Failed to set %s_perf (%llu) on CPU%d (%d)\n",
>>> -                             is_min ? "min" : "max", (u64)perf, cpu, ret);
>>> -             return ret;
>>> -     }
>>> +     if (update_reg) {
>>> +             ret = is_min ? cppc_set_min_perf(cpu, perf) :
>>> +                            cppc_set_max_perf(cpu, perf);
>>> +             if (ret) {
>>> +                     if (ret != -EOPNOTSUPP)
>>> +                             pr_warn("CPU%d: set %s_perf=%llu failed (%d)\n",
>>> +                                     cpu, is_min ? "min" : "max",
>>> +                                     (u64)perf, ret);
>>> +                     return ret;
>>> +             }
>>>
>>> -     if (is_min)
>>> -             cpu_data->perf_ctrls.min_perf = perf;
>>> -     else
>>> -             cpu_data->perf_ctrls.max_perf = perf;
>>> +             if (is_min)
>>> +                     cpu_data->perf_ctrls.min_perf = perf;
>>> +             else
>>> +                     cpu_data->perf_ctrls.max_perf = perf;
>>> +     }
>>>
>>>        if (update_policy) {
>>>                freq = cppc_perf_to_khz(caps, perf);
>>> @@ -592,11 +601,74 @@ static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy *policy, u64 val,
>>>        return 0;
>>>   }
>>>
>>> -#define cppc_cpufreq_set_min_perf(policy, val, update_policy) \
>>> -     cppc_cpufreq_set_mperf_limit(policy, val, update_policy, true)
>>> +#define cppc_cpufreq_set_min_perf(policy, val, update_reg, update_policy)     \
>>> +     cppc_cpufreq_set_mperf_limit(policy, val, update_reg, update_policy,  \
>>> +                                  true)
>>> +
>>> +#define cppc_cpufreq_set_max_perf(policy, val, update_reg, update_policy)     \
>>> +     cppc_cpufreq_set_mperf_limit(policy, val, update_reg, update_policy,  \
>>> +                                  false)
>>> +
>>> +/**
>>> + * cppc_cpufreq_update_autosel_config - Update autonomous selection config
>>> + * @policy: cpufreq policy
>>> + * @is_auto_sel: enable/disable autonomous selection
>>> + *
>>> + * Return: 0 on success, negative error code on failure
>>> + */
>>> +static int cppc_cpufreq_update_autosel_config(struct cpufreq_policy *policy,
>>> +                                           bool is_auto_sel)
>>> +{
>>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>>> +     struct cppc_perf_caps *caps = &cpu_data->perf_caps;
>>> +     u64 min_perf = caps->lowest_nonlinear_perf;
>>> +     u64 max_perf = caps->nominal_perf;
>>> +     unsigned int cpu = policy->cpu;
>>> +     bool update_reg = is_auto_sel;
>>> +     bool update_policy = true;
>>> +     int ret;
>>> +
>>> +     guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
>>> +
>>> +     if (is_auto_sel) {
>>> +             /* Use preserved values if available, else use defaults */
>>> +             if (cpu_data->perf_ctrls.min_perf)
>>> +                     min_perf = cpu_data->perf_ctrls.min_perf;
>>> +             if (cpu_data->perf_ctrls.max_perf)
>>> +                     max_perf = cpu_data->perf_ctrls.max_perf;
>>> +     }
>> So if !is_auto_sel, min_perf and max_perf reg will be set to
>> lowest_nonlinear_perf and nominal_perf, but perf_ctrls.min_perf and
>> perf_ctrls.max_perf remain the old value. A little bit strange I think. And
>> when this happen, min_freq_req and max_freq_req will retain the value last
>> set by the users through min_perf and max_perf. It's that alright?
> 
> When disabling: Reset policy to defaults for normal governor control,
> but preserve HW min/max_perf values and cached values for when
> auto_sel is re-enabled.
> When enabling: Restore policy to preserved min/max_perf values.

It's easy to assume that the values store in reg and in
cpu_data->perf_ctrls should be consistent. Perhaps adding some comments
would be better.

> 
>>> +
>>> +     /*
>>> +      * Set min/max performance and update policy constraints.
>>> +      *   When enabling: update both HW registers and policy.
>>> +      *   When disabling: update policy only, preserve HW registers.
>>> +      * Continue even if min/max are not supported, as EPP and autosel
>>> +      * might still be supported.
>>> +      */
>>> +     ret = cppc_cpufreq_set_min_perf(policy, min_perf, update_reg,
>>> +                                     update_policy);
>>> +     if (ret && ret != -EOPNOTSUPP)
>>> +             return ret;
>>> +
>>> +     ret = cppc_cpufreq_set_max_perf(policy, max_perf, update_reg,
>>> +                                     update_policy);
>>> +     if (ret && ret != -EOPNOTSUPP)
>>> +             return ret;
>>> +
>>> +     /* Update auto_sel register */
>>> +     ret = cppc_set_auto_sel(cpu, is_auto_sel);
>>> +     if (ret && ret != -EOPNOTSUPP) {
>>> +             pr_warn("Failed to set auto_sel=%d for CPU%d (%d)\n",
>>> +                     is_auto_sel, cpu, ret);
>>> +             return ret;
>>> +     }
>>> +     if (!ret)
>>> +             cpu_data->perf_ctrls.auto_sel = is_auto_sel;
>>> +
>>> +     return 0;
>> Better to return ret.
> 
> Here, return 0 is intentional.
> If cppc_set_auto_sel() returns -EOPNOTSUPP, we still consider the
> function successful since auto_sel is an optional register.

Why consider it successful?

> 
>>> +}
>>> +
>>>
>>> -#define cppc_cpufreq_set_max_perf(policy, val, update_policy) \
>>> -     cppc_cpufreq_set_mperf_limit(policy, val, update_policy, false)
>>>   static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>>>   {
>>>        struct cppc_cpudata *cpu_data;
>>> @@ -889,7 +961,7 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
>>>        if (ret)
>>>                return ret;
>> Since you already store auto_sel value in perf_ctrls, We can compare the
>> new value with perf_ctrls.auto_sel here, and just return if they are the
>> same.
> 
> Will add in v6.
> 
> Thank you,
> Sumit Gupta
> 
> ....
> 
> 
> 


