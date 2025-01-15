Return-Path: <linux-acpi+bounces-10670-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB291A11B97
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 09:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC3F43A3C71
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 08:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A728236EB4;
	Wed, 15 Jan 2025 08:10:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDD4236A6E;
	Wed, 15 Jan 2025 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736928635; cv=none; b=SKx3JQezJoh81dHXY4RMiyBAPRBWSSxnvZ/0hJiheClZuL2Uw9F6iyNCkUECZFo523VT5dA4CumFsBRVHk0lVe2fsL0NrBUugprJjQxqVst/1vT/VWyzbx40iDLoSqxorgyr/EoIsTtcv7QIKXifg9fIwpAF/++H/o1mQmppQoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736928635; c=relaxed/simple;
	bh=hI+RvpuYlgKt9ZThOVuHcl5qPRXYAYBwH1XGnFbHmw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J+PI9XX33cNaXAcRmAXCaEucUqiP8HVn+1Gr26eH27h0wpYzN0YUhZMDdFtoEy95WEu7A0oZOADPuiPbvur+MrMqT/JgDLvmtPw2fCFI3lLpWraw59MonJjlx4MnCubUu4JNOUsN3N10ipPCUGiPzoH05v0fMz1/XbOOeM/DLTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YXzDV1FtPz1xmfP;
	Wed, 15 Jan 2025 16:09:30 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id DFB1D140119;
	Wed, 15 Jan 2025 16:10:22 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 15 Jan
 2025 16:10:21 +0800
Message-ID: <82831405-4d81-4090-831c-92d841723b81@huawei.com>
Date: Wed, 15 Jan 2025 16:10:21 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] ACPI: CPPC: Add cppc_get_reg_val and
 cppc_set_reg_val function
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <robert.moore@intel.com>, <viresh.kumar@linaro.org>,
	<mario.limonciello@amd.com>, <gautham.shenoy@amd.com>, <ray.huang@amd.com>,
	<pierre.gondois@arm.com>, <acpica-devel@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <hepeng68@huawei.com>, <fanghao11@huawei.com>
References: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
 <20250113122104.3870673-3-zhenglifeng1@huawei.com>
 <CAJZ5v0g5vuO9jHD+vRUyCeNE7V6zaW6okAVep3V=TLRosk1NAQ@mail.gmail.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <CAJZ5v0g5vuO9jHD+vRUyCeNE7V6zaW6okAVep3V=TLRosk1NAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/1/15 1:41, Rafael J. Wysocki wrote:

> The word "function" at the end of the subject is redundant IMV.

Yes, you are right. Will delete it. Thanks.

> 
> On Mon, Jan 13, 2025 at 1:21 PM Lifeng Zheng <zhenglifeng1@huawei.com> wrote:
>>
>> Rename cppc_get_perf() to cppc_get_reg_val() as a generic function to read
>> cppc registers, with four changes:
>>
>> 1. Change the error kind to "no such device" when pcc_ss_id < 0, which
>> means that this cpu cannot get a valid pcc_ss_id.
>>
>> 2. Add a check to verify if the register is a mandatory or cpc supported
>> one before using it.
>>
>> 3. Extract the operations if register is in pcc out as
>> cppc_get_reg_val_in_pcc().
>>
>> 4. Return the result of cpc_read() instead of 0.
>>
>> Add cppc_set_reg_val() as a generic function for setting cppc registers
>> value, with this features:
>>
>> 1. Check register type. If a register is writeable, it must be a buffer.
>>
>> 2. Check if the register is a optional and null one right after getting the
>> register.  Because if so, the rest of the operations are meaningless.
>>
>> 3. Extract the operations if register is in pcc out as
>> cppc_set_reg_val_in_pcc().
>>
>> These functions can be used to reduce some existing code duplication.
> 
> This mixes functional changes with function renames and code
> refactoring while it is better to do all of these things separately.
> 
> Why don't you split the patch into a few smaller patches doing each
> one thing at a time?  Like rename the existing function and refactor
> it in one patch (if this makes sense), make functional changes to it
> in another patch, then add new functions in a third one?
> 
> This would help to review the changes and explain why each of them is made.

It does make more sense. Will split it. Thanks.

> 
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> ---
>>  drivers/acpi/cppc_acpi.c | 105 ++++++++++++++++++++++++++++++---------
>>  1 file changed, 82 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 6454b469338f..571f94855dce 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1181,43 +1181,102 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>>         return ret_val;
>>  }
>>
>> -static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
>> +static int cppc_get_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u64 *val)
>>  {
>> -       struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
>> +       int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>> +       struct cppc_pcc_data *pcc_ss_data = NULL;
>> +       int ret;
>> +
>> +       if (pcc_ss_id < 0) {
>> +               pr_debug("Invalid pcc_ss_id\n");
>> +               return -ENODEV;
>> +       }
>> +
>> +       pcc_ss_data = pcc_data[pcc_ss_id];
>> +
>> +       down_write(&pcc_ss_data->pcc_lock);
>> +
>> +       if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0)
>> +               ret = cpc_read(cpu, reg, val);
>> +       else
>> +               ret = -EIO;
>> +
>> +       up_write(&pcc_ss_data->pcc_lock);
>> +
>> +       return ret;
>> +}
>> +
>> +static int cppc_get_reg_val(int cpu, enum cppc_regs reg_idx, u64 *val)
>> +{
>> +       struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>>         struct cpc_register_resource *reg;
>>
>>         if (!cpc_desc) {
>> -               pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
>> +               pr_debug("No CPC descriptor for CPU:%d\n", cpu);
>>                 return -ENODEV;
>>         }
>>
>>         reg = &cpc_desc->cpc_regs[reg_idx];
>>
>> -       if (CPC_IN_PCC(reg)) {
>> -               int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
>> -               struct cppc_pcc_data *pcc_ss_data = NULL;
>> -               int ret = 0;
>> -
>> -               if (pcc_ss_id < 0)
>> -                       return -EIO;
>> +       if (IS_OPTIONAL_CPC_REG(reg_idx) && !CPC_SUPPORTED(reg)) {
>> +               pr_debug("CPC register (reg_idx=%d) is not supported\n", reg_idx);
>> +               return -EOPNOTSUPP;
>> +       }
>>
>> -               pcc_ss_data = pcc_data[pcc_ss_id];
>> +       if (CPC_IN_PCC(reg))
>> +               return cppc_get_reg_val_in_pcc(cpu, reg, val);
>>
>> -               down_write(&pcc_ss_data->pcc_lock);
>> +       return cpc_read(cpu, reg, val);
>> +}
>>
>> -               if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0)
>> -                       cpc_read(cpunum, reg, perf);
>> -               else
>> -                       ret = -EIO;
>> +static int cppc_set_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u64 val)
>> +{
>> +       int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>> +       struct cppc_pcc_data *pcc_ss_data = NULL;
>> +       int ret;
>>
>> -               up_write(&pcc_ss_data->pcc_lock);
>> +       if (pcc_ss_id < 0) {
>> +               pr_debug("Invalid pcc_ss_id\n");
>> +               return -ENODEV;
>> +       }
>>
>> +       ret = cpc_write(cpu, reg, val);
>> +       if (ret)
>>                 return ret;
>> +
>> +       pcc_ss_data = pcc_data[pcc_ss_id];
>> +
>> +       down_write(&pcc_ss_data->pcc_lock);
>> +       /* after writing CPC, transfer the ownership of PCC to platform */
>> +       ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
>> +       up_write(&pcc_ss_data->pcc_lock);
>> +
>> +       return ret;
>> +}
>> +
>> +static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
>> +{
>> +       struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>> +       struct cpc_register_resource *reg;
>> +
>> +       if (!cpc_desc) {
>> +               pr_debug("No CPC descriptor for CPU:%d\n", cpu);
>> +               return -ENODEV;
>>         }
>>
>> -       cpc_read(cpunum, reg, perf);
>> +       reg = &cpc_desc->cpc_regs[reg_idx];
>>
>> -       return 0;
>> +       /* if a register is writeable, it must be a buffer */
>> +       if ((reg->type != ACPI_TYPE_BUFFER) ||
>> +           (IS_OPTIONAL_CPC_REG(reg_idx) && IS_NULL_REG(&reg->cpc_entry.reg))) {
>> +               pr_debug("CPC register (reg_idx=%d) is not supported\n", reg_idx);
>> +               return -EOPNOTSUPP;
>> +       }
>> +
>> +       if (CPC_IN_PCC(reg))
>> +               return cppc_set_reg_val_in_pcc(cpu, reg, val);
>> +
>> +       return cpc_write(cpu, reg, val);
>>  }
>>
>>  /**
>> @@ -1229,7 +1288,7 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
>>   */
>>  int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
>>  {
>> -       return cppc_get_perf(cpunum, DESIRED_PERF, desired_perf);
>> +       return cppc_get_reg_val(cpunum, DESIRED_PERF, desired_perf);
>>  }
>>  EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
>>
>> @@ -1242,7 +1301,7 @@ EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
>>   */
>>  int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
>>  {
>> -       return cppc_get_perf(cpunum, NOMINAL_PERF, nominal_perf);
>> +       return cppc_get_reg_val(cpunum, NOMINAL_PERF, nominal_perf);
>>  }
>>
>>  /**
>> @@ -1254,7 +1313,7 @@ int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
>>   */
>>  int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
>>  {
>> -       return cppc_get_perf(cpunum, HIGHEST_PERF, highest_perf);
>> +       return cppc_get_reg_val(cpunum, HIGHEST_PERF, highest_perf);
>>  }
>>  EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
>>
>> @@ -1267,7 +1326,7 @@ EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
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


