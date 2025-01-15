Return-Path: <linux-acpi+bounces-10678-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D390A11D2F
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 10:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5213E3A951F
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 09:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BED1EEA45;
	Wed, 15 Jan 2025 09:16:51 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F403F246A0A;
	Wed, 15 Jan 2025 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932611; cv=none; b=nByN4yhm6ejVbI8AtsL1P1ya5yb3Ngow3+LIDVEtEdqEPPVFRFdqrnlpWDmOkVEmOUyvgJIWZem4iHm+EM8sXcrKF02Me+Rmkop3/nEo7wnkElsqk/faMsxlE4PpJQfhxf9lHsUxTfnVbuDelN3DjbN74KJSvHEIDCY25McR7Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932611; c=relaxed/simple;
	bh=mn330r5buxbnIyzzcqAXkfMOP76wg1Y403B1yovkHfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YtyGgN3lJEN7JDQOovWjxVLD+DVZwpQl9BzgLWY/xla2/xBW4izjuD9r9yFMOQCl0GiJmzsXSosxaHAPi05sXE3G8qsg0BTYqpJkXsJktq02+B4bTJhxv1s72qlN5qGckFI2Cn6chMHCTx0vQWh4JWNONiNvSVZNCLLG/DB4KT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YY0fP3ZJMz2Djg7;
	Wed, 15 Jan 2025 17:13:33 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id B45CE1A016C;
	Wed, 15 Jan 2025 17:16:43 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 15 Jan
 2025 17:16:42 +0800
Message-ID: <e29f1d7e-943d-4286-a92c-3db04f9e60ae@huawei.com>
Date: Wed, 15 Jan 2025 17:16:42 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] ACPI: CPPC: Add autonomous selection ABIs
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <robert.moore@intel.com>, <viresh.kumar@linaro.org>,
	<mario.limonciello@amd.com>, <gautham.shenoy@amd.com>, <ray.huang@amd.com>,
	<pierre.gondois@arm.com>, <acpica-devel@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <hepeng68@huawei.com>, <fanghao11@huawei.com>
References: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
 <20250113122104.3870673-6-zhenglifeng1@huawei.com>
 <CAJZ5v0go8y7E2kCDbPYKcwppp0iGzZb3WiKAMhcMRMf_wrUVGA@mail.gmail.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <CAJZ5v0go8y7E2kCDbPYKcwppp0iGzZb3WiKAMhcMRMf_wrUVGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/1/15 2:24, Rafael J. Wysocki wrote:

> On Mon, Jan 13, 2025 at 1:21 PM Lifeng Zheng <zhenglifeng1@huawei.com> wrote:
> 
> This should mention the specification revision and section number(s)
> for the specification material the code is based on.

Will mention it. Thanks.

> 
>> cppc_set_epp - write energy performance preference register value
>>
>> cppc_get_auto_act_window - read autonomous activity window register value
>>
>> cppc_set_auto_act_window - write autonomous activity window register value
>>
>> cppc_get_auto_sel - read autonomous selection enable register value,
>> modified from cppc_get_auto_sel_caps()
> 
> It would be better to move the modification part into a separate patch.

Yes, good point. Thanks.

> 
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> ---
>>  drivers/acpi/cppc_acpi.c     | 82 ++++++++++++++++++++++++++++++++----
>>  drivers/cpufreq/amd-pstate.c |  3 +-
>>  include/acpi/cppc_acpi.h     | 30 +++++++++++--
>>  3 files changed, 103 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 03134613311d..7bfe30f7b40f 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1568,23 +1568,89 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>  EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
>>
>>  /**
>> - * cppc_get_auto_sel_caps - Read autonomous selection register.
>> - * @cpunum : CPU from which to read register.
>> - * @perf_caps : struct where autonomous selection register value is updated.
>> + * cppc_set_epp() - Write the EPP register.
>> + * @cpu: CPU on which to write register.
>> + * @epp_val: Value to write to the EPP register.
>>   */
>> -int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>> +int cppc_set_epp(int cpu, u64 epp_val)
>>  {
>> -       u64 auto_sel;
>> +       if (epp_val > CPPC_ENERGY_PERF_MAX)
>> +               return -EINVAL;
>> +
>> +       return cppc_set_reg_val(cpu, ENERGY_PERF, epp_val);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_set_epp);
>> +
>> +/**
>> + * cppc_get_auto_act_window() - Read autonomous activity window register.
>> + * @cpu: CPU from which to read register.
>> + * @auto_act_window: Return address.
> 
> It would be good to describe the autonomous activity window encoding.

Will add. Thanks.

> 
>> + */
>> +int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
>> +{
>> +       unsigned int exp;
>> +       u64 val, sig;
>> +       int ret;
>> +
>> +       ret = cppc_get_reg_val(cpu, AUTO_ACT_WINDOW, &val);
>> +       if (ret)
>> +               return ret;
>> +
>> +       sig = val & CPPC_AUTO_ACT_WINDOW_MAX_SIG;
>> +       exp = (val >> CPPC_AUTO_ACT_WINDOW_SIG_BIT_SIZE) & CPPC_AUTO_ACT_WINDOW_MAX_EXP;
>> +       *auto_act_window = sig * int_pow(10, exp);
>> +
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_get_auto_act_window);
>> +
>> +/**
>> + * cppc_set_auto_act_window() - Write autonomous activity window register.
>> + * @cpu: CPU on which to write register.
>> + * @auto_act_window: usec value to write to the autonomous activity window register.
>> + */
>> +int cppc_set_auto_act_window(int cpu, u64 auto_act_window)
>> +{
>> +       u64 max_val = CPPC_AUTO_ACT_WINDOW_MAX_SIG * int_pow(10, CPPC_AUTO_ACT_WINDOW_MAX_EXP);
>> +       int digits = 0;
>> +       u64 val;
>> +
>> +       if (auto_act_window > max_val)
>> +               return -EINVAL;
>> +
>> +       while (auto_act_window > CPPC_AUTO_ACT_WINDOW_SIG_CARRY_THRESH) {
>> +               auto_act_window /= 10;
>> +               digits += 1;
>> +       }
>> +
>> +       if (auto_act_window > CPPC_AUTO_ACT_WINDOW_MAX_SIG)
>> +               auto_act_window = CPPC_AUTO_ACT_WINDOW_MAX_SIG;
> 
> It looks like this may clobber the most significant bit, or am I mistaken?

Actually, after the while loop above, auto_act_window is not larger than
CPPC_AUTO_ACT_WINDOW_SIG_CARRY_THRESH, which is 129. So this if condition
is valid only when auto_act_window is 128 or 129. Since we only have 7 bits
to store this value, 128 and 129 can only be cut to 127.

> 
>> +
>> +       val = (digits << CPPC_AUTO_ACT_WINDOW_SIG_BIT_SIZE) + auto_act_window;
>> +
>> +       return cppc_set_reg_val(cpu, AUTO_ACT_WINDOW, val);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_set_auto_act_window);
>> +
>> +/**
>> + * cppc_get_auto_sel() - Read autonomous selection register.
>> + * @cpu: CPU from which to read register.
>> + * @enable: Return address.
>> + */
>> +int cppc_get_auto_sel(int cpu, bool *enable)
>> +{
>> +       u64 val;
>>         int ret;
>>
>> -       ret = cppc_get_reg_val(cpunum, AUTO_SEL_ENABLE, &auto_sel);
>> +       ret = cppc_get_reg_val(cpu, AUTO_SEL_ENABLE, &val);
>>         if (ret)
>>                 return ret;
>>
>> -       perf_caps->auto_sel = (bool)auto_sel;
>> +       *enable = (bool)val;
>> +
>>         return 0;
>>  }
>> -EXPORT_SYMBOL_GPL(cppc_get_auto_sel_caps);
>> +EXPORT_SYMBOL_GPL(cppc_get_auto_sel);
>>
>>  /**
>>   * cppc_set_auto_sel - Write autonomous selection register.
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 66e5dfc711c0..8bc11d0618f8 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -399,6 +399,7 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
>>  {
>>         struct cppc_perf_caps cppc_perf;
>>         u64 numerator;
>> +       bool auto_sel;
>>
>>         int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>>         if (ret)
>> @@ -420,7 +421,7 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
>>         if (cppc_state == AMD_PSTATE_ACTIVE)
>>                 return 0;
>>
>> -       ret = cppc_get_auto_sel_caps(cpudata->cpu, &cppc_perf);
>> +       ret = cppc_get_auto_sel(cpudata->cpu, &auto_sel);
>>         if (ret) {
>>                 pr_warn("failed to get auto_sel, ret: %d\n", ret);
>>                 return 0;
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index 62d368bcd9ec..325e9543e08f 100644
>> --- a/include/acpi/cppc_acpi.h
>> +++ b/include/acpi/cppc_acpi.h
>> @@ -32,6 +32,15 @@
>>  #define        CMD_READ 0
>>  #define        CMD_WRITE 1
>>
>> +#define CPPC_AUTO_ACT_WINDOW_SIG_BIT_SIZE      (7)
>> +#define CPPC_AUTO_ACT_WINDOW_EXP_BIT_SIZE      (3)
>> +#define CPPC_AUTO_ACT_WINDOW_MAX_SIG   ((1 << CPPC_AUTO_ACT_WINDOW_SIG_BIT_SIZE) - 1)
>> +#define CPPC_AUTO_ACT_WINDOW_MAX_EXP   ((1 << CPPC_AUTO_ACT_WINDOW_EXP_BIT_SIZE) - 1)
>> +/* CPPC_AUTO_ACT_WINDOW_MAX_SIG is 127, so 128 and 129 will decay to 127 when writing */
>> +#define CPPC_AUTO_ACT_WINDOW_SIG_CARRY_THRESH 129
>> +
>> +#define CPPC_ENERGY_PERF_MAX   (0xFF)
>> +
>>  /* Each register has the folowing format. */
>>  struct cpc_reg {
>>         u8 descriptor;
>> @@ -159,7 +168,10 @@ extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
>>  extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
>>  extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
>>  extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
>> -extern int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps);
>> +extern int cppc_set_epp(int cpu, u64 epp_val);
>> +extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
>> +extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
>> +extern int cppc_get_auto_sel(int cpu, bool *enable);
>>  extern int cppc_set_auto_sel(int cpu, bool enable);
>>  extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
>>  extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
>> @@ -229,11 +241,23 @@ static inline int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
>>  {
>>         return -EOPNOTSUPP;
>>  }
>> -static inline int cppc_set_auto_sel(int cpu, bool enable)
>> +static inline int cppc_set_epp(int cpu, u64 epp_val)
>>  {
>>         return -EOPNOTSUPP;
>>  }
>> -static inline int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>> +static inline int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
>> +{
>> +       return -EOPNOTSUPP;
>> +}
>> +static inline int cppc_set_auto_act_window(int cpu, u64 auto_act_window)
>> +{
>> +       return -EOPNOTSUPP;
>> +}
>> +static inline int cppc_get_auto_sel(int cpu, bool *enable)
>> +{
>> +       return -EOPNOTSUPP;
>> +}
>> +static inline int cppc_set_auto_sel(int cpu, bool enable)
>>  {
>>         return -EOPNOTSUPP;
>>  }
>> --
>> 2.33.0
>>
>>
> 


