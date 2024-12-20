Return-Path: <linux-acpi+bounces-10210-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DD49F8E61
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 09:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBD47188C755
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 08:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DBA1ACDE7;
	Fri, 20 Dec 2024 08:56:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DD3198845;
	Fri, 20 Dec 2024 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734684975; cv=none; b=kCJRcfKsg+iIpQhJAHWMq+VoT1fLTuvDOZTAdIB7fr567+LkQ9mpSnLUmOU6HO/KjQQT5AIAW0OhgBMdRTZGrbzcICZA7MKGwDDWJpyHVFHlVQAQJy9nBp+7VwDxSCwx0TyQorCdWY0eMkd5tdUK4MGEPUCx9RhVxee/65S7V/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734684975; c=relaxed/simple;
	bh=ehRnhpGN6b3gGcN4Kfvjlx+ROuVhtDfxUpnkBETz3Mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=REVwJYJ72k7/53JzmeHKCobFjYm4IvfHq7v3u+QWlfCUbj6WE5FRfMgxRF7J4obNrePlatHTHdrbOjtVv4FLkUdF4W9NAE1VPyqewu1IyB7zxHT9lhTg5nOhv7O9GWtNHOo/YiuvYuks3vRpr6CCjAi9VVZZdXK6DBtNfT0ZicA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YF1QY0BZgz1V6nN;
	Fri, 20 Dec 2024 16:52:53 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 2CF71140257;
	Fri, 20 Dec 2024 16:56:10 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 20 Dec
 2024 16:56:09 +0800
Message-ID: <b360f76e-de7b-46d6-a108-f88b047aa902@huawei.com>
Date: Fri, 20 Dec 2024 16:56:08 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] ACPI: CPPC: Add autonomous selection ABIs
To: Mario Limonciello <mario.limonciello@amd.com>, Pierre Gondois
	<pierre.gondois@arm.com>, Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>
CC: <acpica-devel@lists.linux.dev>, <lenb@kernel.org>,
	<viresh.kumar@linaro.org>, <robert.moore@intel.com>, <rafael@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linuxarm@huawei.com>, <ionela.voinescu@arm.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <hepeng68@huawei.com>, <fanghao11@huawei.com>
References: <20241216091603.1247644-1-zhenglifeng1@huawei.com>
 <20241216091603.1247644-4-zhenglifeng1@huawei.com>
 <e581fa05-9b4e-46e6-9172-83704bfa8ab2@arm.com>
 <e6650141-85cb-450d-ab62-0c2bea8ff1da@amd.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <e6650141-85cb-450d-ab62-0c2bea8ff1da@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Hello Pierre, Mario, Gautham, Huang

On 2024/12/18 4:38, Mario Limonciello wrote:
> On 12/17/2024 07:48, Pierre Gondois wrote:
>> Hello Lifeng, Huang, Gautham, Mario,
>>
>> On 12/16/24 10:16, Lifeng Zheng wrote:
>>> cppc_set_epp - write energy performance preference register
>>>
>>> cppc_get_auto_act_window - read autonomous activity window register
>>>
>>> cppc_set_auto_act_window - write autonomous activity window register
>>>
>>> cppc_get_auto_sel - read autonomous selection enable register
>>>
>>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>>> ---
>>>   drivers/acpi/cppc_acpi.c | 44 ++++++++++++++++++++++++++++++++++++++++
>>>   include/acpi/cppc_acpi.h | 20 ++++++++++++++++++
>>>   2 files changed, 64 insertions(+)
>>>
>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>> index 83c7fcad74ad..645f2366c888 100644
>>> --- a/drivers/acpi/cppc_acpi.c
>>> +++ b/drivers/acpi/cppc_acpi.c
>>> @@ -1595,6 +1595,50 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>>   }
>>>   EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
>>> +/**
>>> + * cppc_set_epp() - Write the EPP register.
>>> + * @cpu: CPU on which to write register.
>>> + * @epp_val: Value to write to the EPP register.
>>> + */
>>> +int cppc_set_epp(int cpu, u64 epp_val)
>>> +{
>>> +    return cppc_set_reg_val(cpu, ENERGY_PERF, epp_val);
>>> +}
>>> +EXPORT_SYMBOL_GPL(cppc_set_epp);
>>> +
>>> +/**
>>> + * cppc_get_auto_act_window() - Read autonomous activity window register.
>>> + * @cpu: CPU from which to read register.
>>> + * @auto_act_window: Return address.
>>> + */
>>> +int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
>>
>> As there is only one way to interpret the value of the
>> 'Autonomous Activity Window Register', maybe the logic to convert
>> from/to the register value to a value in us should be placed here
>> rather than in the cppc_cpufreq driver.
>> Meaning, maybe the prototype should be:
>>
>> int cppc_get_auto_act_window(int cpu, unsigned int *auto_act_window);
>>
>> Similar remark for cppc_set_epp() and other functions.
>>
>>> +{
>>> +    return cppc_get_reg_val(cpu, AUTO_ACT_WINDOW, auto_act_window);
>>> +}
>>> +EXPORT_SYMBOL_GPL(cppc_get_auto_act_window);
>>> +
>>> +/**
>>> + * cppc_set_auto_act_window() - Write autonomous activity window register.
>>> + * @cpu: CPU on which to write register.
>>> + * @auto_act_window: Value to write to the autonomous activity window register.
>>> + */
>>> +int cppc_set_auto_act_window(int cpu, u64 auto_act_window)
>>> +{
>>> +    return cppc_set_reg_val(cpu, AUTO_ACT_WINDOW, auto_act_window);
>>> +}
>>> +EXPORT_SYMBOL_GPL(cppc_set_auto_act_window);
>>> +
>>> +/**
>>> + * cppc_get_auto_sel() - Read autonomous selection register.
>>> + * @cpu: CPU from which to read register.
>>> + * @auto_sel: Return address.
>>> + */
>>> +int cppc_get_auto_sel(int cpu, u64 *auto_sel)
>>
>> Similarly, maybe it would be better to use:
>> int cppc_get_auto_sel(int cpu, bool *auto_sel);
>>
>>> +{
>>> +    return cppc_get_reg_val(cpu, AUTO_SEL_ENABLE, auto_sel);
>>> +}
>>> +EXPORT_SYMBOL_GPL(cppc_get_auto_sel);
>>> +
>>>   /**
>>>    * cppc_get_auto_sel_caps - Read autonomous selection register.
>>>    * @cpunum : CPU from which to read register.
>>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>>> index 62d368bcd9ec..134931b081a0 100644
>>> --- a/include/acpi/cppc_acpi.h
>>> +++ b/include/acpi/cppc_acpi.h
>>> @@ -159,6 +159,10 @@ extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
>>>   extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
>>>   extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
>>>   extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
>>> +extern int cppc_set_epp(int cpu, u64 epp_val);
>>> +extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
>>> +extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
>>> +extern int cppc_get_auto_sel(int cpu, u64 *auto_sel);
>>>   extern int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps);
>>
>> This is a bit annoying, but maybe only one function between:
>> - cppc_get_auto_sel_caps()
>> - cppc_get_auto_sel()
>> is necessary.
>>
>> I added the owners of the amd-pstate driver to ask if this would
>> be ok to replace cppc_get_auto_sel_caps() by cppc_get_auto_sel().
> 
> Yeah I have no concerns with this if that's the direction this patch series goes.  Feel free to change amd-pstate in the patch that introduces cppc_get_auto_sel().
> 
> I'll be out around the US holiday, so I might not be able to review it for a while, but CC Gautham on the series and he may be able to.

After checking, it turns out that the only place uses
cppc_get_auto_sel_caps() only check the ret but never uses the value of
perf_caps. I believe cppc_get_auto_sel() will meet the requirements.

> 
>>
>>>   extern int cppc_set_auto_sel(int cpu, bool enable);
>>>   extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
>>> @@ -225,6 +229,22 @@ static inline int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls,
>>>   {
>>>       return -EOPNOTSUPP;
>>>   }
>>> +static inline int cppc_set_epp(int cpu, u64 epp_val)
>>> +{
>>> +    return -EOPNOTSUPP;
>>> +}
>>> +static inline int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
>>> +{
>>> +    return -EOPNOTSUPP;
>>> +}
>>> +static inline int cppc_set_auto_act_window(int cpu, u64 auto_act_window)
>>> +{
>>> +    return -EOPNOTSUPP;
>>> +}
>>> +static inline int cppc_get_auto_sel(int cpu, u64 *auto_sel)
>>> +{
>>> +    return -EOPNOTSUPP;
>>> +}
>>>   static inline int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
>>>   {
>>>       return -EOPNOTSUPP;
> 


