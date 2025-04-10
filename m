Return-Path: <linux-acpi+bounces-12938-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE558A83D12
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 10:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BED23A726E
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 08:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15BA202C44;
	Thu, 10 Apr 2025 08:31:24 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ABC20ADFA;
	Thu, 10 Apr 2025 08:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744273884; cv=none; b=UxguqX3zTn1pUnVDBXHoIiQ7BjPpFJLfxRMmH15EaTUz/L/g7ltCJXxm7KcK64bf6usSB0tk9TEBFcsKCWHnAY+sWdmsDb0DmiQjgBN9GLMFDKcCQ5MR10GkDE12xfa/i9ptoeutjNTLru/5lmtiutxPOGiz1HbXu9OQ3NAUkGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744273884; c=relaxed/simple;
	bh=ny08MI6GXAJZbhNBAsXgpdp79SteNccgtW6Om8TnJ0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gF3OOdjJDfRK4HiXGHIQRvoG1K0DcOziO7LUhI2i2Sjazjs3wbentklF7Q+WAeGenKoIOMxCsAJMMgl8uzlXZZ0yGIgG/Ix1G7851iNX7DAH6s+peUWoL2Di2tuDARDnyYG7ZSXYsmEKxRaeLQbZ7qPioUrkkdiwYdI3mgcLkVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZYCcV54RwzHrW8;
	Thu, 10 Apr 2025 16:27:54 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 82E1A14010D;
	Thu, 10 Apr 2025 16:31:18 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 10 Apr
 2025 16:31:17 +0800
Message-ID: <def11daf-585c-43ac-bc0a-c4e257148107@huawei.com>
Date: Thu, 10 Apr 2025 16:31:16 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/8] ACPI: CPPC: Add three functions related to
 autonomous selection
To: Mario Limonciello <mario.limonciello@amd.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <robert.moore@intel.com>, <viresh.kumar@linaro.org>,
	<gautham.shenoy@amd.com>, <ray.huang@amd.com>, <perry.yuan@amd.com>,
	<pierre.gondois@arm.com>
CC: <acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>,
	<cenxinghai@h-partners.com>, <hepeng68@huawei.com>
References: <20250409065703.1461867-1-zhenglifeng1@huawei.com>
 <20250409065703.1461867-9-zhenglifeng1@huawei.com>
 <e5dc4906-2b28-4adc-8e8e-ddd5d7cc985c@amd.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <e5dc4906-2b28-4adc-8e8e-ddd5d7cc985c@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/4/10 2:59, Mario Limonciello wrote:
> On 4/9/2025 1:57 AM, Lifeng Zheng wrote:
>> cppc_set_epp - write energy performance preference register value, based on
>> ACPI 6.5, s8.4.6.1.7
>>
>> cppc_get_auto_act_window - read autonomous activity window register value,
>> based on ACPI 6.5, s8.4.6.1.6
>>
>> cppc_set_auto_act_window - write autonomous activity window register value,
>> based on ACPI 6.5, s8.4.6.1.6
>>
>> Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> ---
>>   drivers/acpi/cppc_acpi.c | 80 ++++++++++++++++++++++++++++++++++++++++
>>   include/acpi/cppc_acpi.h | 24 ++++++++++++
>>   2 files changed, 104 insertions(+)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index ef2394c074e3..3d5eace44af5 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1608,6 +1608,86 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>   }
>>   EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
>>   +/**
>> + * cppc_set_epp() - Write the EPP register.
>> + * @cpu: CPU on which to write register.
>> + * @epp_val: Value to write to the EPP register.
>> + */
>> +int cppc_set_epp(int cpu, u64 epp_val)
> 
> Any reason this is a u64 argument when the biggest value you can support is 0xFF?  Presumably you could drop the the bounds check below if you limited the variable size.

cppc_get_epp_perf() uses u64, so I think it is better to keep the same.

> 
>> +{
>> +    if (epp_val > CPPC_ENERGY_PERF_MAX)
>> +        return -EINVAL;
>> +
>> +    return cppc_set_reg_val(cpu, ENERGY_PERF, epp_val);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_set_epp);
>> +
>> +/**
>> + * cppc_get_auto_act_window() - Read autonomous activity window register.
>> + * @cpu: CPU from which to read register.
>> + * @auto_act_window: Return address.
>> + *
>> + * According to ACPI 6.5, s8.4.6.1.6, the value read from the autonomous
>> + * activity window register consists of two parts: a 7 bits value indicate
>> + * significand and a 3 bits value indicate exponent.
>> + */
>> +int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
>> +{
>> +    unsigned int exp;
>> +    u64 val, sig;
>> +    int ret;
>> +
>> +    ret = cppc_get_reg_val(cpu, AUTO_ACT_WINDOW, &val);
>> +    if (ret)
>> +        return ret;
>> +
>> +    sig = val & CPPC_AUTO_ACT_WINDOW_MAX_SIG;
>> +    exp = (val >> CPPC_AUTO_ACT_WINDOW_SIG_BIT_SIZE) & CPPC_AUTO_ACT_WINDOW_MAX_EXP;
>> +    *auto_act_window = sig * int_pow(10, exp);
>> +
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_get_auto_act_window);
> 
> Since this is exported code, do you perhaps want a check that auto_act_window is not NULL to avoid a possible accidental NULL pointer dereference?

Yes. Make sense. Thanks!

> 
>> +
>> +/**
>> + * cppc_set_auto_act_window() - Write autonomous activity window register.
>> + * @cpu: CPU on which to write register.
>> + * @auto_act_window: usec value to write to the autonomous activity window register.
>> + *
>> + * According to ACPI 6.5, s8.4.6.1.6, the value to write to the autonomous
>> + * activity window register consists of two parts: a 7 bits value indicate
>> + * significand and a 3 bits value indicate exponent.
>> + */
>> +int cppc_set_auto_act_window(int cpu, u64 auto_act_window)
>> +{
>> +    /* The max value to stroe is 1270000000 */
> 
> store

Thanks!

> 
>> +    u64 max_val = CPPC_AUTO_ACT_WINDOW_MAX_SIG * int_pow(10, CPPC_AUTO_ACT_WINDOW_MAX_EXP);
>> +    int exp = 0;
>> +    u64 val;
>> +
>> +    if (auto_act_window > max_val)
>> +        return -EINVAL;
>> +
>> +    /*
>> +     * The max significand is 127, when auto_act_window is larger than
>> +     * 129, discard the precision of the last digit and increase the
>> +     * exponent by 1.
>> +     */
>> +    while (auto_act_window > CPPC_AUTO_ACT_WINDOW_SIG_CARRY_THRESH) {
>> +        auto_act_window /= 10;
>> +        exp += 1;
>> +    }
>> +
>> +    /* For 128 and 129, cut it to 127. */
>> +    if (auto_act_window > CPPC_AUTO_ACT_WINDOW_MAX_SIG)
>> +        auto_act_window = CPPC_AUTO_ACT_WINDOW_MAX_SIG;
>> +
>> +    val = (exp << CPPC_AUTO_ACT_WINDOW_SIG_BIT_SIZE) + auto_act_window;
>> +
>> +    return cppc_set_reg_val(cpu, AUTO_ACT_WINDOW, val);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_set_auto_act_window);
>> +
>>   /**
>>    * cppc_get_auto_sel() - Read autonomous selection register.
>>    * @cpu: CPU from which to read register.
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index 31767c65be20..325e9543e08f 100644
>> --- a/include/acpi/cppc_acpi.h
>> +++ b/include/acpi/cppc_acpi.h
>> @@ -32,6 +32,15 @@
>>   #define    CMD_READ 0
>>   #define    CMD_WRITE 1
>>   +#define CPPC_AUTO_ACT_WINDOW_SIG_BIT_SIZE    (7)
>> +#define CPPC_AUTO_ACT_WINDOW_EXP_BIT_SIZE    (3)
>> +#define CPPC_AUTO_ACT_WINDOW_MAX_SIG    ((1 << CPPC_AUTO_ACT_WINDOW_SIG_BIT_SIZE) - 1)
>> +#define CPPC_AUTO_ACT_WINDOW_MAX_EXP    ((1 << CPPC_AUTO_ACT_WINDOW_EXP_BIT_SIZE) - 1)
>> +/* CPPC_AUTO_ACT_WINDOW_MAX_SIG is 127, so 128 and 129 will decay to 127 when writing */
>> +#define CPPC_AUTO_ACT_WINDOW_SIG_CARRY_THRESH 129
>> +
>> +#define CPPC_ENERGY_PERF_MAX    (0xFF)
>> +
>>   /* Each register has the folowing format. */
>>   struct cpc_reg {
>>       u8 descriptor;
>> @@ -159,6 +168,9 @@ extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
>>   extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
>>   extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
>>   extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
>> +extern int cppc_set_epp(int cpu, u64 epp_val);
>> +extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
>> +extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
>>   extern int cppc_get_auto_sel(int cpu, bool *enable);
>>   extern int cppc_set_auto_sel(int cpu, bool enable);
>>   extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
>> @@ -229,6 +241,18 @@ static inline int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
>>   {
>>       return -EOPNOTSUPP;
>>   }
>> +static inline int cppc_set_epp(int cpu, u64 epp_val)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
>> +static inline int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
>> +static inline int cppc_set_auto_act_window(int cpu, u64 auto_act_window)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
>>   static inline int cppc_get_auto_sel(int cpu, bool *enable)
>>   {
>>       return -EOPNOTSUPP;
> 


