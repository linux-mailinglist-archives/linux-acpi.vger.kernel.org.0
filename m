Return-Path: <linux-acpi+bounces-10119-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F28899EE1A3
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Dec 2024 09:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB1718870FD
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Dec 2024 08:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1999120E008;
	Thu, 12 Dec 2024 08:43:48 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FC120DD48;
	Thu, 12 Dec 2024 08:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733993028; cv=none; b=WTI5h7zGCndL1fEB2TPuH+u2JqEp6nVfmCmgSd3odhT4r+pw6kfoA4clHT3RP+BAAs6UPM3e1GR36HIJM3hom8La7ugfiKDu+9GHjfEDToee/m19syamLjYLw9NGlHxsTXjnoQ6OiwVv4RXTvEVZVNYbijlrVPeVoPrCuoFyjpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733993028; c=relaxed/simple;
	bh=lnDPQ6Whp46KDXJMRtkZBB8R/W4aOE6DAx7he0IMN5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pY+E3c4J9falwpAhbx4cDtV3NO+DXMZfdT/4sSB7i1re4ErhH9GVsLbqrCmBfxaDsILXNr4XX8bEqo8C5TY9ODm/51b1lPhOZPSvSP5R2nKn0iXAR3nSRyd0tBHQxZlK7jqB0qYQNQIMu38CXtugfDstFFnuf+TJaMq+22bfUkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Y85Ww6QDfz11MLY;
	Thu, 12 Dec 2024 16:40:28 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id F20EE1402C1;
	Thu, 12 Dec 2024 16:43:35 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 12 Dec
 2024 16:43:35 +0800
Message-ID: <7f976270-1fce-451b-801b-a593aaec719c@huawei.com>
Date: Thu, 12 Dec 2024 16:43:34 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] ACPI: CPPC: Refactor register get and set ABIs
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <robert.moore@intel.com>, <viresh.kumar@linaro.org>,
	<acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <hepeng68@huawei.com>,
	<fanghao11@huawei.com>
References: <20241122062051.3658577-1-zhenglifeng1@huawei.com>
 <20241122062051.3658577-2-zhenglifeng1@huawei.com>
 <CAJZ5v0jnF82WX_=4KtqwnLd=vcHYt_pbtyvQV74p0ojKr33D=A@mail.gmail.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <CAJZ5v0jnF82WX_=4KtqwnLd=vcHYt_pbtyvQV74p0ojKr33D=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2024/12/11 2:14, Rafael J. Wysocki wrote:
> On Fri, Nov 22, 2024 at 7:21 AM Lifeng Zheng <zhenglifeng1@huawei.com> wrote:
>>
>> Refactor register get and set ABIs using cppc_get_reg() and cppc_set_reg().
> 
> I don't quite like the cppc_get_reg() name.  I think that
> cppc_get_reg_val() would be better.

Indeed, it is better. Will change. Thanks.

> 
>> Rename cppc_get_perf() to cppc_get_reg() as a generic function to read cppc
>> registers, with two changes:
>>
>> 1. Change the error kind to "no such device" when pcc_ss_id < 0, which
>> means that this cpu cannot get a valid pcc_ss_id.
>>
>> 2. Add a check to verify if the register is a cpc supported one before
>> using it.
> 
> So it's not just a rename, but also a change in behavior.  Can this
> change in behavior become user-visible?

The register value get ABIs in this file returned different error numbers
when pcc_ss_id < 0, but should be the same one. So I chose a most suitable
one I thought to be returned here when doing refactoring. This change is
not user-visible as I know.

It is necessary to do the CPC_SUPPORTED() check before using the register.
If it is not a cpc supported one, the rest of the operation is pointless
and may be dangerous. This change might be user-visible but is still
necessary.

> 
>> Add cppc_set_reg() as a generic function for setting cppc registers.
> 
> Again, I would prefer cppc_set_reg_val().
> 
>> Unlike other set reg ABIs, this function checks CPC_SUPPORTED right after getting
>> the register, because the rest of the operations are meaningless if this
>> register is not a cpc supported one.
> 
> And the new function is used to reduce some existing code duplication,
> isn't it?  Which would be good to mention here.

Yes, Will mention it in next version. Thanks.

> 
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> ---
>>  drivers/acpi/cppc_acpi.c | 191 +++++++++++++++------------------------
>>  1 file changed, 72 insertions(+), 119 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index c1f3568d0c50..9aab22d8136a 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1179,10 +1179,13 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>>         return ret_val;
>>  }
>>
>> -static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
>> +static int cppc_get_reg(int cpunum, enum cppc_regs reg_idx, u64 *val)
>>  {
>>         struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
>> +       struct cppc_pcc_data *pcc_ss_data = NULL;
> 
> Why are you moving this here?  This change is not related to the rest
> of the patch, is it?
> 
>>         struct cpc_register_resource *reg;
>> +       int pcc_ss_id;
>> +       int ret = 0;
> 
> And here?

Moving these because I'm used to declare variables at the beginning of a
function. It's really unnecessary. After defining new functions as
cppc_get_reg_val_in_pcc() and cppc_set_reg_val_in_pcc() as you suggest
below, these variables will be moved to the new functions.

> 
>>
>>         if (!cpc_desc) {
>>                 pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
>> @@ -1191,20 +1194,23 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
>>
>>         reg = &cpc_desc->cpc_regs[reg_idx];
>>
>> +       if (!CPC_SUPPORTED(reg)) {
>> +               pr_debug("CPC register (reg_idx=%d) is not supported\n", reg_idx);
>> +               return -EOPNOTSUPP;
>> +       }
>> +
>>         if (CPC_IN_PCC(reg)) {
>> -               int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
>> -               struct cppc_pcc_data *pcc_ss_data = NULL;
>> -               int ret = 0;
>> +               pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
>>
>>                 if (pcc_ss_id < 0)
>> -                       return -EIO;
>> +                       return -ENODEV;
>>
>>                 pcc_ss_data = pcc_data[pcc_ss_id];
>>
>>                 down_write(&pcc_ss_data->pcc_lock);
>>
>>                 if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0)
>> -                       cpc_read(cpunum, reg, perf);
>> +                       cpc_read(cpunum, reg, val);
>>                 else
>>                         ret = -EIO;
>>
>> @@ -1213,21 +1219,65 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
>>                 return ret;
>>         }
>>
>> -       cpc_read(cpunum, reg, perf);
>> +       cpc_read(cpunum, reg, val);
>>
>>         return 0;
>>  }
>>
>> +static int cppc_set_reg(int cpu, enum cppc_regs reg_idx, u64 val)
>> +{
>> +       struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>> +       struct cppc_pcc_data *pcc_ss_data = NULL;
>> +       struct cpc_register_resource *reg;
>> +       int pcc_ss_id;
>> +       int ret;
>> +
>> +       if (!cpc_desc) {
>> +               pr_debug("No CPC descriptor for CPU:%d\n", cpu);
>> +               return -ENODEV;
>> +       }
>> +
>> +       reg = &cpc_desc->cpc_regs[reg_idx];
>> +
>> +       if (!CPC_SUPPORTED(reg)) {
>> +               pr_debug("CPC register (reg_idx=%d) is not supported\n", reg_idx);
>> +               return -EOPNOTSUPP;
>> +       }
>> +
>> +       if (CPC_IN_PCC(reg)) {
>> +               pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> 
> Please declare the variables that are only needed in the PCC case here.
> 
> Also, I think it would be better to define a new function, say
> cppc_set_reg_val_in_pcc() for this code and then have
> 
> if (CPC_IN_PCC(reg))
>         return cppc_set_reg_val_in_pcc(reg, val);

Will define new functions as cppc_get_reg_val_in_pcc() and
cppc_set_reg_val_in_pcc(). Thanks.

> 
>> +
>> +               if (pcc_ss_id < 0) {
>> +                       pr_debug("Invalid pcc_ss_id\n");
>> +                       return -ENODEV;
>> +               }
>> +
>> +               ret = cpc_write(cpu, reg, val);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               pcc_ss_data = pcc_data[pcc_ss_id];
>> +
>> +               down_write(&pcc_ss_data->pcc_lock);
>> +               /* after writing CPC, transfer the ownership of PCC to platform */
>> +               ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
>> +               up_write(&pcc_ss_data->pcc_lock);
>> +               return ret;
>> +       }
>> +
>> +       return cpc_write(cpu, reg, val);
>> +}
>> +
>>  /**
>>   * cppc_get_desired_perf - Get the desired performance register value.
>>   * @cpunum: CPU from which to get desired performance.
>>   * @desired_perf: Return address.
>>   *
>> - * Return: 0 for success, -EIO otherwise.
>> + * Return: 0 for success, -ERRNO otherwise.
>>   */
>>  int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
>>  {
>> -       return cppc_get_perf(cpunum, DESIRED_PERF, desired_perf);
>> +       return cppc_get_reg(cpunum, DESIRED_PERF, desired_perf);
>>  }
>>  EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
>>
>> @@ -1236,11 +1286,11 @@ EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
>>   * @cpunum: CPU from which to get nominal performance.
>>   * @nominal_perf: Return address.
>>   *
>> - * Return: 0 for success, -EIO otherwise.
>> + * Return: 0 for success, -ERRNO otherwise.
> 
> What do you mean by ERRNO?

Error number. I see this expression elsewhere in this file so I use it too.

> 
>>   */
>>  int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
>>  {
>> -       return cppc_get_perf(cpunum, NOMINAL_PERF, nominal_perf);
>> +       return cppc_get_reg(cpunum, NOMINAL_PERF, nominal_perf);
>>  }
>>
>>  /**
>> @@ -1248,11 +1298,11 @@ int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
>>   * @cpunum: CPU from which to get highest performance.
>>   * @highest_perf: Return address.
>>   *
>> - * Return: 0 for success, -EIO otherwise.
>> + * Return: 0 for success, -ERRNO otherwise.
>>   */
>>  int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
>>  {
>> -       return cppc_get_perf(cpunum, HIGHEST_PERF, highest_perf);
>> +       return cppc_get_reg(cpunum, HIGHEST_PERF, highest_perf);
>>  }
>>  EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
>>
>> @@ -1261,11 +1311,11 @@ EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
>>   * @cpunum: CPU from which to get epp preference value.
>>   * @epp_perf: Return address.
>>   *
>> - * Return: 0 for success, -EIO otherwise.
>> + * Return: 0 for success, -ERRNO otherwise.
> 
> Same here?
> 
>>   */
>>  int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
>>  {
>> -       return cppc_get_perf(cpunum, ENERGY_PERF, epp_perf);
>> +       return cppc_get_reg(cpunum, ENERGY_PERF, epp_perf);
>>  }
>>  EXPORT_SYMBOL_GPL(cppc_get_epp_perf);
> 
> It would be cleaner to do the changes below in a separate patch IMV.

Will separate it. Thanks.

> 
>> @@ -1545,44 +1595,14 @@ EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
>>   */
>>  int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>>  {
>> -       struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
>> -       struct cpc_register_resource *auto_sel_reg;
>> -       u64  auto_sel;
>> -
>> -       if (!cpc_desc) {
>> -               pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
>> -               return -ENODEV;
>> -       }
>> -
>> -       auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
>> -
>> -       if (!CPC_SUPPORTED(auto_sel_reg))
>> -               pr_warn_once("Autonomous mode is not unsupported!\n");
>> -
>> -       if (CPC_IN_PCC(auto_sel_reg)) {
>> -               int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
>> -               struct cppc_pcc_data *pcc_ss_data = NULL;
>> -               int ret = 0;
>> -
>> -               if (pcc_ss_id < 0)
>> -                       return -ENODEV;
>> -
>> -               pcc_ss_data = pcc_data[pcc_ss_id];
>> -
>> -               down_write(&pcc_ss_data->pcc_lock);
>> -
>> -               if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0) {
>> -                       cpc_read(cpunum, auto_sel_reg, &auto_sel);
>> -                       perf_caps->auto_sel = (bool)auto_sel;
>> -               } else {
>> -                       ret = -EIO;
>> -               }
>> -
>> -               up_write(&pcc_ss_data->pcc_lock);
>> +       u64 auto_sel;
>> +       int ret;
>>
>> +       ret = cppc_get_reg(cpunum, AUTO_SEL_ENABLE, &auto_sel);
>> +       if (ret)
>>                 return ret;
>> -       }
>>
>> +       perf_caps->auto_sel = (bool)auto_sel;
>>         return 0;
>>  }
>>  EXPORT_SYMBOL_GPL(cppc_get_auto_sel_caps);
>> @@ -1594,43 +1614,7 @@ EXPORT_SYMBOL_GPL(cppc_get_auto_sel_caps);
>>   */
>>  int cppc_set_auto_sel(int cpu, bool enable)
>>  {
>> -       int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>> -       struct cpc_register_resource *auto_sel_reg;
>> -       struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>> -       struct cppc_pcc_data *pcc_ss_data = NULL;
>> -       int ret = -EINVAL;
>> -
>> -       if (!cpc_desc) {
>> -               pr_debug("No CPC descriptor for CPU:%d\n", cpu);
>> -               return -ENODEV;
>> -       }
>> -
>> -       auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
>> -
>> -       if (CPC_IN_PCC(auto_sel_reg)) {
>> -               if (pcc_ss_id < 0) {
>> -                       pr_debug("Invalid pcc_ss_id\n");
>> -                       return -ENODEV;
>> -               }
>> -
>> -               if (CPC_SUPPORTED(auto_sel_reg)) {
>> -                       ret = cpc_write(cpu, auto_sel_reg, enable);
>> -                       if (ret)
>> -                               return ret;
>> -               }
>> -
>> -               pcc_ss_data = pcc_data[pcc_ss_id];
>> -
>> -               down_write(&pcc_ss_data->pcc_lock);
>> -               /* after writing CPC, transfer the ownership of PCC to platform */
>> -               ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
>> -               up_write(&pcc_ss_data->pcc_lock);
>> -       } else {
>> -               ret = -ENOTSUPP;
>> -               pr_debug("_CPC in PCC is not supported\n");
>> -       }
>> -
>> -       return ret;
>> +       return cppc_set_reg(cpu, AUTO_SEL_ENABLE, enable);
>>  }
>>  EXPORT_SYMBOL_GPL(cppc_set_auto_sel);
>>
>> @@ -1644,38 +1628,7 @@ EXPORT_SYMBOL_GPL(cppc_set_auto_sel);
>>   */
>>  int cppc_set_enable(int cpu, bool enable)
>>  {
>> -       int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>> -       struct cpc_register_resource *enable_reg;
>> -       struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>> -       struct cppc_pcc_data *pcc_ss_data = NULL;
>> -       int ret = -EINVAL;
>> -
>> -       if (!cpc_desc) {
>> -               pr_debug("No CPC descriptor for CPU:%d\n", cpu);
>> -               return -EINVAL;
>> -       }
>> -
>> -       enable_reg = &cpc_desc->cpc_regs[ENABLE];
>> -
>> -       if (CPC_IN_PCC(enable_reg)) {
>> -
>> -               if (pcc_ss_id < 0)
>> -                       return -EIO;
>> -
>> -               ret = cpc_write(cpu, enable_reg, enable);
>> -               if (ret)
>> -                       return ret;
>> -
>> -               pcc_ss_data = pcc_data[pcc_ss_id];
>> -
>> -               down_write(&pcc_ss_data->pcc_lock);
>> -               /* after writing CPC, transfer the ownership of PCC to platfrom */
>> -               ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
>> -               up_write(&pcc_ss_data->pcc_lock);
>> -               return ret;
>> -       }
>> -
>> -       return cpc_write(cpu, enable_reg, enable);
>> +       return cppc_set_reg(cpu, ENABLE, enable);
>>  }
>>  EXPORT_SYMBOL_GPL(cppc_set_enable);
>>
>> --
> 


