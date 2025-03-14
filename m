Return-Path: <linux-acpi+bounces-12231-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CAEA60D30
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 10:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6966165FF3
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 09:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A44E1EE7A8;
	Fri, 14 Mar 2025 09:25:22 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA551DF757;
	Fri, 14 Mar 2025 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944322; cv=none; b=jQbmEEdbiWyf+mJb7rWZxcWF4jRa1gLRTZELY3kt7StJqSWRwjh5vqLO0ode/XUzAhlrInuW6qcoC7UeMI8awqH3QgBGwSOfzYtx2Fa1en8jkglPpN0OdvKLPzASdHMdg+g3FK26QZ1TeUoUh3Itvs5hMEBXIF44tcyHgXrkFmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944322; c=relaxed/simple;
	bh=c6/QwBn2efTbMD6aeRlBL2zocEiLWmeXyoucEEuqtfQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=eTMsYp7lD7RdMYKy5nM+4eILBsM4vfaASvK05wG8r6h96UZzxTQ6WuJRN/qUQY9gN5bga5G8jpxe9uH0pMmIcj+9M0z9uSZExsgQ/tDyazrEhhbFyB9vvrnUbtCXF42hrlo3itZRaKKT2MxqJ50TmGk8pQCF3DIglzAuH8VmK1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZDf8x3kTxz1d046;
	Fri, 14 Mar 2025 17:25:05 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 7FB0A140156;
	Fri, 14 Mar 2025 17:25:12 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 14 Mar
 2025 17:25:11 +0800
Message-ID: <4fc77a58-8c77-463c-a50d-06ad19685bfb@huawei.com>
Date: Fri, 14 Mar 2025 17:24:59 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Subject: Re: [PATCH v5 3/8] ACPI: CPPC: Rename cppc_get_perf() to
 cppc_get_reg_val()
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <robert.moore@intel.com>, <viresh.kumar@linaro.org>,
	<mario.limonciello@amd.com>, <gautham.shenoy@amd.com>, <ray.huang@amd.com>,
	<pierre.gondois@arm.com>, <acpica-devel@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linuxarm@huawei.com>, <yumpusamongus@gmail.com>,
	<srinivas.pandruvada@linux.intel.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <hepeng68@huawei.com>,
	<fanghao11@huawei.com>
References: <20250206131428.3261578-1-zhenglifeng1@huawei.com>
 <20250206131428.3261578-4-zhenglifeng1@huawei.com>
 <CAJZ5v0iNzNROkPD4+b=Au8DwdF9unajKivdRQMBFfwzjFxHLcg@mail.gmail.com>
In-Reply-To: <CAJZ5v0iNzNROkPD4+b=Au8DwdF9unajKivdRQMBFfwzjFxHLcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/3/13 3:54, Rafael J. Wysocki wrote:

> On Thu, Feb 6, 2025 at 2:14 PM Lifeng Zheng <zhenglifeng1@huawei.com> wrote:
>>
>> Rename cppc_get_perf() to cppc_get_reg_val() as a generic function to read
>> cppc registers. And extract the operations if register is in pcc out as
>> cppc_get_reg_val_in_pcc(). Without functional change.
> 
> This should be split into two patches IMV.

Yes. That makes sense. Thanks.

> 
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> ---
>>  drivers/acpi/cppc_acpi.c | 66 +++++++++++++++++++++-------------------
>>  1 file changed, 35 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index db22f8f107db..3c9c4ce2a0b0 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1189,48 +1189,52 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>>         return ret_val;
>>  }
>>
>> -static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
>> +static int cppc_get_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u64 *val)
>>  {
>> -       struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
>> -       struct cpc_register_resource *reg;
>> +       int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>> +       struct cppc_pcc_data *pcc_ss_data = NULL;
>> +       int ret;
>>
>> -       if (!cpc_desc) {
>> -               pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
>> +       if (pcc_ss_id < 0) {
>> +               pr_debug("Invalid pcc_ss_id\n");
>>                 return -ENODEV;
>>         }
>>
>> -       reg = &cpc_desc->cpc_regs[reg_idx];
>> +       pcc_ss_data = pcc_data[pcc_ss_id];
>>
>> -       if (IS_OPTIONAL_CPC_REG(reg_idx) && !CPC_SUPPORTED(reg)) {
>> -               pr_debug("CPC register (reg_idx=%d) is not supported\n", reg_idx);
>> -               return -EOPNOTSUPP;
>> -       }
> 
> I'm not a big fan of the IS_OPTIONAL_CPC_REG() macro.  I'm not
> convinced at all that it adds any value above (and in the next patch
> for that matter) and the message printing the register index is just
> plain unuseful to anyone who doesn't know how to decode it.

With this index, it is easier to locate problems. This is what a "pr_debug"
for, isn't it?

> 
> If CPC_SUPPORTED(reg) is not true, the register cannot be used AFAICS
> regardless of what IS_OPTIONAL_CPC_REG() has to say about it.

The name "CPC_SUPPORTED" may be a little confused. Actually, in ACPI 6.5,
only optional _CPC package fields that are not supported by the platform
should be encoded as 0 intergers or NULL registers. A mandatory field as a
0 interger is valid. So If I wanted to make this function as a generic one
to read cppc registers, it would have been more reasonable to do this
IS_OPTIONAL_CPC_REG() check before CPC_SUPPORTED().

> 
>> +       down_write(&pcc_ss_data->pcc_lock);
>>
>> -       if (CPC_IN_PCC(reg)) {
>> -               int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
>> -               struct cppc_pcc_data *pcc_ss_data = NULL;
>> -               int ret;
>> +       if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0)
>> +               ret = cpc_read(cpu, reg, val);
>> +       else
>> +               ret = -EIO;
>>
>> -               if (pcc_ss_id < 0) {
>> -                       pr_debug("Invalid pcc_ss_id\n");
>> -                       return -ENODEV;
>> -               }
>> +       up_write(&pcc_ss_data->pcc_lock);
>>
>> -               pcc_ss_data = pcc_data[pcc_ss_id];
>> +       return ret;
>> +}
>>
>> -               down_write(&pcc_ss_data->pcc_lock);
>> +static int cppc_get_reg_val(int cpu, enum cppc_regs reg_idx, u64 *val)
>> +{
>> +       struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>> +       struct cpc_register_resource *reg;
>>
>> -               if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0)
>> -                       ret = cpc_read(cpunum, reg, perf);
>> -               else
>> -                       ret = -EIO;
>> +       if (!cpc_desc) {
>> +               pr_debug("No CPC descriptor for CPU:%d\n", cpu);
>> +               return -ENODEV;
>> +       }
>>
>> -               up_write(&pcc_ss_data->pcc_lock);
>> +       reg = &cpc_desc->cpc_regs[reg_idx];
>>
>> -               return ret;
>> +       if (IS_OPTIONAL_CPC_REG(reg_idx) && !CPC_SUPPORTED(reg)) {
>> +               pr_debug("CPC register (reg_idx=%d) is not supported\n", reg_idx);
>> +               return -EOPNOTSUPP;
>>         }
>>
>> -       return cpc_read(cpunum, reg, perf);
>> +       if (CPC_IN_PCC(reg))
>> +               return cppc_get_reg_val_in_pcc(cpu, reg, val);
>> +
>> +       return cpc_read(cpu, reg, val);
>>  }
>>
>>  /**
>> @@ -1242,7 +1246,7 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
>>   */
>>  int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
>>  {
>> -       return cppc_get_perf(cpunum, DESIRED_PERF, desired_perf);
>> +       return cppc_get_reg_val(cpunum, DESIRED_PERF, desired_perf);
>>  }
>>  EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
>>
>> @@ -1255,7 +1259,7 @@ EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
>>   */
>>  int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
>>  {
>> -       return cppc_get_perf(cpunum, NOMINAL_PERF, nominal_perf);
>> +       return cppc_get_reg_val(cpunum, NOMINAL_PERF, nominal_perf);
>>  }
>>
>>  /**
>> @@ -1267,7 +1271,7 @@ int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
>>   */
>>  int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
>>  {
>> -       return cppc_get_perf(cpunum, HIGHEST_PERF, highest_perf);
>> +       return cppc_get_reg_val(cpunum, HIGHEST_PERF, highest_perf);
>>  }
>>  EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
>>
>> @@ -1280,7 +1284,7 @@ EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
>>   */
>>  int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
>>  {
>> -       return cppc_get_perf(cpunum, ENERGY_PERF, epp_perf);
>> +       return cppc_get_reg_val(cpunum, ENERGY_PERF, epp_perf);
>>  }
>>  EXPORT_SYMBOL_GPL(cppc_get_epp_perf);
>>
>> --
>> 2.33.0
>>
>>
> 


