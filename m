Return-Path: <linux-acpi+bounces-10502-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC980A08548
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2025 03:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E1A3A7340
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2025 02:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8801AF0B6;
	Fri, 10 Jan 2025 02:23:08 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34543FB31;
	Fri, 10 Jan 2025 02:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736475788; cv=none; b=Mb8ApWg/zW9lcl3iTwKuo+flF37W+tsLswBVJ37fRcHW/Cj3544p1e2Z5uGCp/aOUOjzpQZA5uKHUDf/D33uFg0KZw0AuHnLpDk3SRjsyBmEU2WUMkZgBds5f+RvKtfca1GWyjrzXTeX2SZtyMtPMdAYPzD8eCLnBVvBe2ftftY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736475788; c=relaxed/simple;
	bh=aiLymV2UWSp3zEcSt82qm9KqxXmYjgxcUtLPnMJOwI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rYN8VpESN4coU8Ux5zntPlbHtryhse8fhrVQZQotsNL/+Uh/IEC3WK1jBV7aAIR7sX8zQzDHP8krKrEh+JYcwy3tZvr70eii6VyqxyoYirExz8qJ3M+jHLjYwN/6kefJ/iP9tDBuI6HWD8GNscRYY3TdFNw0ldhNBVq1j4wQWDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YTlhk1d8Rz1W3hc;
	Fri, 10 Jan 2025 10:19:18 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 25DCA18007C;
	Fri, 10 Jan 2025 10:23:02 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 10 Jan
 2025 10:23:01 +0800
Message-ID: <49bd9db5-b05d-4bed-8f9d-10ec087323b5@huawei.com>
Date: Fri, 10 Jan 2025 10:23:00 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] ACPI: CPPC: Add cppc_get_reg_val and
 cppc_set_reg_val function
To: Pierre Gondois <pierre.gondois@arm.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <robert.moore@intel.com>, <viresh.kumar@linaro.org>
CC: <acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <ionela.voinescu@arm.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <hepeng68@huawei.com>, <fanghao11@huawei.com>
References: <20241216091603.1247644-1-zhenglifeng1@huawei.com>
 <20241216091603.1247644-2-zhenglifeng1@huawei.com>
 <8e9c1ede-3277-458b-bd44-ca0c7615a4ab@arm.com>
 <74be38cf-8e18-44fc-995c-a5b734d9df29@huawei.com>
 <a9574bab-3b85-4a33-b465-204687dabc98@arm.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <a9574bab-3b85-4a33-b465-204687dabc98@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Hello Pierre,

On 2025/1/8 0:54, Pierre Gondois wrote:
> Hello Lifeng,
> 
> On 12/20/24 09:30, zhenglifeng (A) wrote:
>> On 2024/12/17 21:48, Pierre Gondois wrote:
>>> Hello Lifeng,
>>>
>>> On 12/16/24 10:16, Lifeng Zheng wrote:
>>>> Rename cppc_get_perf() to cppc_get_reg_val() as a generic function to read
>>>> cppc registers, with four changes:
>>>>
>>>> 1. Change the error kind to "no such device" when pcc_ss_id < 0, which
>>>> means that this cpu cannot get a valid pcc_ss_id.
>>>>
>>>> 2. Add a check to verify if the register is a cpc supported one before
>>>> using it.
>>>>
>>>> 3. Extract the operations if register is in pcc out as
>>>> cppc_get_reg_val_in_pcc().
>>>>
>>>> 4. Return the result of cpc_read() instead of 0.
>>>>
>>>> Add cppc_set_reg_val_in_pcc() and cppc_set_reg_val() as generic functions
>>>> for setting cppc registers value. Unlike other set reg ABIs,
>>>> cppc_set_reg_val() checks CPC_SUPPORTED right after getting the register,
>>>> because the rest of the operations are meaningless if this register is not
>>>> a cpc supported one.
>>>>
>>>> These functions can be used to reduce some existing code duplication.
>>>>
>>>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>>>> ---
>>>>    drivers/acpi/cppc_acpi.c | 111 +++++++++++++++++++++++++++++----------
>>>>    1 file changed, 84 insertions(+), 27 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>>> index c1f3568d0c50..bb5333a503a2 100644
>>>> --- a/drivers/acpi/cppc_acpi.c
>>>> +++ b/drivers/acpi/cppc_acpi.c
>>>> @@ -1179,43 +1179,100 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>>>>        return ret_val;
>>>>    }
>>>>    -static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
>>>> +static int cppc_get_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u64 *val)
>>>>    {
>>>> -    struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
>>>> +    int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>>>> +    struct cppc_pcc_data *pcc_ss_data = NULL;
>>>> +    int ret;
>>>> +
>>>> +    if (pcc_ss_id < 0) {
>>>> +        pr_debug("Invalid pcc_ss_id\n");
>>>> +        return -ENODEV;
>>>> +    }
>>>> +
>>>> +    pcc_ss_data = pcc_data[pcc_ss_id];
>>>> +
>>>> +    down_write(&pcc_ss_data->pcc_lock);
>>>> +
>>>> +    if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0)
>>>> +        ret = cpc_read(cpu, reg, val);
>>>> +    else
>>>> +        ret = -EIO;
>>>> +
>>>> +    up_write(&pcc_ss_data->pcc_lock);
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static int cppc_get_reg_val(int cpu, enum cppc_regs reg_idx, u64 *val)
>>>> +{
>>>> +    struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>>>>        struct cpc_register_resource *reg;
>>>>          if (!cpc_desc) {
>>>> -        pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
>>>> +        pr_debug("No CPC descriptor for CPU:%d\n", cpu);
>>>>            return -ENODEV;
>>>>        }
>>>>          reg = &cpc_desc->cpc_regs[reg_idx];
>>>>    -    if (CPC_IN_PCC(reg)) {
>>>> -        int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
>>>> -        struct cppc_pcc_data *pcc_ss_data = NULL;
>>>> -        int ret = 0;
>>>> -
>>>> -        if (pcc_ss_id < 0)
>>>> -            return -EIO;
>>>> +    if (!CPC_SUPPORTED(reg)) {
>>>> +        pr_debug("CPC register (reg_idx=%d) is not supported\n", reg_idx);
>>>> +        return -EOPNOTSUPP;
>>>> +    }
>>>
>>> I think this is only valid for optional fields. Meaning that:
>>> - if the function is used one day for the mandatory 'Lowest Performance'
>>> field, an integer value of 0 would be valid.
>>> - if the function is used for a mandatory field containing a NULL Buffer,
>>> it seems we would return -EFAULT currently, through cpc_read(). -EOPNOTSUPP
>>> doesn't seem appropriate as the field would be mandatory.
>>>
>>> Maybe the function needs an additional 'bool optional' input parameter
>>> to do these check conditionally.
>>
>> Indeed, I should have judged the type before doing this check. But adding a
>> input parameter is not a really nice way to me. How about adding a bool
>> list of length MAX_CPC_REG_ENT in cppc_acpi.h to indicate wheter it is
>> optional?
> 
> Actually all these functions:
> - cppc_get_desired_perf
> - cppc_get_highest_perf
> - cppc_get_epp_perf
> - cppc_set_epp
> - cppc_get_auto_act_window
> - cppc_set_auto_act_window

As you suggest in another patch, the logic should be placed in
cppc_get_auto_act_window() and some other functions. I'm afraid these
functions couldn't be implemented with the macros you suggest.

> - cppc_get_auto_sel
> - cppc_get_nominal_perf
> 
> and in general all the functions getting / setting one value at a time could
> be implemented by macros similars to show_cppc_data(). From what I see the
> input parameters required are:
> - name of the field
> - if the field is mandatory to have or not

If with this parameter, we should put all the cppc_get_reg_val() and
cppc_set_reg_val() in the macro. This wouldn't look really nice. I
prefer to use a macro to judge mandatory / optional. I'll show you in
v4.

> - if the field is writeable

I think we can define a READ macro, a WRITE macro and a RW macro. For
the registers which are not writeable, only use the READ macro to
implement getting function.

> - if the field is implemented as an integer, register, or can be both

I don't think this parameter is necessary. The field type can be got
from cpc_desc->cpc_regs[reg_idx].type.

> 
> This would avoid having numerous function definitions doing approximately the
> same thing.

So from what I see the input parameters required are name of the field
and reg_idx. Thanks for your advice!

> 
>>
>>>
>>>>    -        pcc_ss_data = pcc_data[pcc_ss_id];
>>>> +    if (CPC_IN_PCC(reg))
>>>> +        return cppc_get_reg_val_in_pcc(cpu, reg, val);
>>>>    -        down_write(&pcc_ss_data->pcc_lock);
>>>> +    return cpc_read(cpu, reg, val);
>>>> +}
>>>>    -        if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0)
>>>> -            cpc_read(cpunum, reg, perf);
>>>> -        else
>>>> -            ret = -EIO;
>>>> +static int cppc_set_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u64 val)
>>>> +{
>>>> +    int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>>>> +    struct cppc_pcc_data *pcc_ss_data = NULL;
>>>> +    int ret;
>>>>    -        up_write(&pcc_ss_data->pcc_lock);
>>>> +    if (pcc_ss_id < 0) {
>>>> +        pr_debug("Invalid pcc_ss_id\n");
>>>> +        return -ENODEV;
>>>> +    }
>>>>    +    ret = cpc_write(cpu, reg, val);
>>>> +    if (ret)
>>>>            return ret;
>>>> +
>>>> +    pcc_ss_data = pcc_data[pcc_ss_id];
>>>> +
>>>> +    down_write(&pcc_ss_data->pcc_lock);
>>>> +    /* after writing CPC, transfer the ownership of PCC to platform */
>>>> +    ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
>>>> +    up_write(&pcc_ss_data->pcc_lock);
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
>>>> +{
>>>> +    struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>>>> +    struct cpc_register_resource *reg;
>>>> +
>>>> +    if (!cpc_desc) {
>>>> +        pr_debug("No CPC descriptor for CPU:%d\n", cpu);
>>>> +        return -ENODEV;
>>>>        }
>>>>    -    cpc_read(cpunum, reg, perf);
>>>> +    reg = &cpc_desc->cpc_regs[reg_idx];
>>>>    -    return 0;
>>>> +    if (!CPC_SUPPORTED(reg)) {
>>>> +        pr_debug("CPC register (reg_idx=%d) is not supported\n", reg_idx);
>>>> +        return -EOPNOTSUPP;
>>>> +    }
>>>
>>> Similarly to cppc_get_reg_val(), if a field is:
>>> - mandatory + integer: currently doesn't exist. Not sure we should
>>> try to detect that, but might be safer.
>>> - mandatory + buffer: should not return -EOPNOTSUPP I think
>>> - optional + integer: e.g.: 'Autonomous Selection Enable Register',
>>> we should return -EOPNOTSUPP. It seems that currently, if the integer
>>> value is 1, I get a 'write error: Bad address'
>>> - optional + buffer:
>>> should effectively return -EOPNOTSUPP if the buffer is NULL.
>>
>> Actually, cpc_write() doesn't check field type and treats the field as a
>> buffer. That's why you get 'Bad address' error when the integer value is 1.
>> I think the existing code needs to be improved, otherwise there may be
>> unexpected problems.
>>
>> Do you mean we should return -EOPNOTSUPP no matter what to be written if
>> this field is a optional + integer one?
> 
> Yes exact
> 
>> And what about a mandatory +
>> integer one. Should we directly write the int_value?
> 
> I don't think it is possible to have this. Indeed, if a value is writeable,
> it must be a register, so mandatory + integer should not exist. I suggested
> a check in case someone made a mistake, but it is not sure the check is actually
> necessary.

Yeah, I think it's better to have this check, too.

Regards,
Lifeng

> 
> Regards,
> Pierre
> 


