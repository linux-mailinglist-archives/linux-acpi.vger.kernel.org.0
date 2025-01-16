Return-Path: <linux-acpi+bounces-10720-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D36E5A13492
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 09:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A623A4299
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 08:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CED192B95;
	Thu, 16 Jan 2025 08:01:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63AF73451;
	Thu, 16 Jan 2025 08:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014476; cv=none; b=qDBd9louhlxtFUTav2QNSduFIKIhjFGeDKXUwDA//20eK/UMJoMeHS/ch6kY1BYKjfU9va5hVHbnrolpBIyGTQQoGoW0D5Iov8Uvy/LaiPH7ExT3DePvEHQo4FnBly4KNtHXqiDLnwy3OlFIDCRehK2IwtKG9NF4dnTjPaQUIs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014476; c=relaxed/simple;
	bh=CYMTRBhW2WXOjQ1h0QxJE0G54rvHoKIHqFKORo/wqEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TdwVGvu9Jy/9x0g7Ktpn6xhenW3Hu1b3R/S9n1WOWoO3SHPuJs6kiacg/snQIH0WQvC5StsfwMUpogqbSjEX1k4nGctr0lcPNJFZ+z9V1kOGEmDJBZxGjKlquIcexiEAN73rcNXTzY7dYPjfLOC/B8/uhsr0yAWJD5AKwJowDH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YYZvx3VB2zjYBT;
	Thu, 16 Jan 2025 15:57:17 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id B76B7180105;
	Thu, 16 Jan 2025 16:01:09 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 16 Jan
 2025 16:01:08 +0800
Message-ID: <ad254dd8-24f7-4aee-9f68-5d1890e87c81@huawei.com>
Date: Thu, 16 Jan 2025 16:01:08 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] cpufreq: CPPC: Support for autonomous selection in
 cppc_cpufreq
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<viresh.kumar@linaro.org>, <mario.limonciello@amd.com>, <ray.huang@amd.com>,
	<pierre.gondois@arm.com>, <acpica-devel@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <hepeng68@huawei.com>, <fanghao11@huawei.com>
References: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
 <20250113122104.3870673-7-zhenglifeng1@huawei.com>
 <Z4fLXPgMvwGur+pz@BLRRASHENOY1.amd.com>
 <f89fc07a-1c65-4d1e-9ad8-76c6c9a15b25@huawei.com>
 <Z4ijkAFOMtVAOY6u@BLRRASHENOY1.amd.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <Z4ijkAFOMtVAOY6u@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/1/16 14:13, Gautham R. Shenoy wrote:

> On Thu, Jan 16, 2025 at 09:26:37AM +0800, zhenglifeng (A) wrote:
>> On 2025/1/15 22:51, Gautham R. Shenoy wrote:
>>
>>> Hello Lifeng,
>>>
>>>
>>> On Mon, Jan 13, 2025 at 08:21:04PM +0800, Lifeng Zheng wrote:
>>>> Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
>>>> driver.
>>>>
>>>
>>> [..snip..]
>>>
>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>>> index bd8f75accfa0..ea6c6a5bbd8c 100644
>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>> @@ -814,10 +814,119 @@ static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
>>>>  
>>>>  	return cpufreq_show_cpus(cpu_data->shared_cpu_map, buf);
>>>>  }
>>>> +
>>>> +static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
>>>> +{
>>>> +	bool val;
>>>> +	int ret;
>>>> +
>>>> +	ret = cppc_get_auto_sel(policy->cpu, &val);
>>>> +
>>>> +	/* show "<unsupported>" when this register is not supported by cpc */
>>>> +	if (ret == -EOPNOTSUPP)
>>>> +		return sysfs_emit(buf, "%s\n", "<unsupported>");
>>>> +
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	return sysfs_emit(buf, "%d\n", val);
>>>> +}
>>>> +
>>>> +static ssize_t store_auto_select(struct cpufreq_policy *policy,
>>>> +				 const char *buf, size_t count)
>>>> +{
>>>> +	bool val;
>>>> +	int ret;
>>>> +
>>>> +	ret = kstrtobool(buf, &val);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	ret = cppc_set_auto_sel(policy->cpu, val);
>>>
>>> When the auto_select register is not supported, since
>>> cppc_set_reg_val() doesn't have the !CPC_SUPPORTED(reg) check, that
>>> function won't return an error, and thus this store function won't
>>> return an error either. Should there be a !CPC_SUPPORTED(reg) check in
>>> cppc_set_reg_val() as well? Or should the store function call
>>> cppc_get_auto_sel() to figure out if the register is supported or not?
>>
>> In patch 2, I have this check in cppc_set_reg_val():
>>
>> +	/* if a register is writeable, it must be a buffer */
>> +	if ((reg->type != ACPI_TYPE_BUFFER) ||
>> +	    (IS_OPTIONAL_CPC_REG(reg_idx) && IS_NULL_REG(&reg->cpc_entry.reg))) {
>> +		pr_debug("CPC register (reg_idx=%d) is not supported\n", reg_idx);
>> +		return -EOPNOTSUPP;
>> +	}
>>
>> If a register is not a cpc supported one, it must be either an integer type
>> or a null one. So it won't pass this check I think.
> 
> Ah, I see. In that case, you can remove the cppc_get_auto_sel() in
> shmem_init_perf() function in amd_pstate.c (in Patch 5/6) from the
> following snippet. The auto_sel value is nowhere used in the rest of
> the code.
> 
> @@ -399,6 +399,7 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
>  {
>  	struct cppc_perf_caps cppc_perf;
>  	u64 numerator;
> +	bool auto_sel; <--- Not needed.
>  
>  	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>  	if (ret)
> @@ -420,7 +421,7 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
>  	if (cppc_state == AMD_PSTATE_ACTIVE)
>  		return 0;
>  
> -	ret = cppc_get_auto_sel_caps(cpudata->cpu, &cppc_perf);   <--- Not needed.
> +	ret = cppc_get_auto_sel(cpudata->cpu, &auto_sel);         <--- Not needed.
>  	if (ret) {                                                <--- Not needed.
>  		pr_warn("failed to get auto_sel, ret: %d\n", ret); <--- Not needed.
> 

If auto_sel is not supported, this function will return 0 after getting
fail. But after removing cppc_get_auto_sel(), this function will return
-EOPNOTSUPP by setting. Is this alright?

> 
> --
> Thanks and Regards
> gautham.


