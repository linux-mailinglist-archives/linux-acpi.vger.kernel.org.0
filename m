Return-Path: <linux-acpi+bounces-10015-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CC49E8C94
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Dec 2024 08:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 777EA160EA1
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Dec 2024 07:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE3021504E;
	Mon,  9 Dec 2024 07:49:44 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D539214A64;
	Mon,  9 Dec 2024 07:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733730584; cv=none; b=ca6rORfab8RrKMkKJoZo9euXHOWiYqu/Z9P5Zl6+XS0mDSPZuk/57ThCHMWi4vyypPQVON/lNn2laQJsl+Qj62tBM/060DgBfB4vuUwnGVPtpXCJh2xqSq9nUziIJdSjjRbtfR9uhBWVXRmUvVP96SRG0mp2cW3Ea+IQ876DV80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733730584; c=relaxed/simple;
	bh=R8kCdwKbk8Fy59TANbitmY9vXQFcRjYWd5ShkaVdGAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YcXCDDhwY4gHg1ZQ3oZ+bkTP0zOx6DbnHjLwHCivLVAUxxAbV4nWfVguDDqM3IVnxu3CMHV8uDQIVDBC8jeIlr9KYmNbBlqM6se5TbSKSjN4ranrAs086Z7yWoK0R8TEKueRuxTHo00BvBzmtXVKTzQyDXYpv0w9HpurIOIsmJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Y6DT75Q7Bz11MCC;
	Mon,  9 Dec 2024 15:46:35 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id DCAF6180357;
	Mon,  9 Dec 2024 15:49:38 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Dec
 2024 15:49:38 +0800
Message-ID: <57e94a65-d9df-4114-bcee-998addb6e60f@huawei.com>
Date: Mon, 9 Dec 2024 15:49:37 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ACPI: CPPC: Refactor register get and set ABIs
To: Pierre Gondois <pierre.gondois@arm.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <robert.moore@intel.com>, <viresh.kumar@linaro.org>
CC: <acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <fanghao11@huawei.com>,
	"zhenglifeng (A)" <zhenglifeng1@huawei.com>
References: <20241114084816.1128647-1-zhenglifeng1@huawei.com>
 <20241114084816.1128647-2-zhenglifeng1@huawei.com>
 <0f113d9d-faac-420a-9c75-9b620bf5c3f6@arm.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <0f113d9d-faac-420a-9c75-9b620bf5c3f6@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Hello Pierre，

On 2024/12/6 22:23, Pierre Gondois wrote:
> Hello Lifeng,
> 
> On 11/14/24 09:48, Lifeng Zheng wrote:
>> Refactor register get and set ABIs using cppc_get_reg() and cppc_set_reg().
>>
>> Rename cppc_get_perf() to cppc_get_reg() as a generic function to read cppc
>> registers, with two changes:
>>
>> 1. Change the error kind to "no such device" when pcc_ss_id < 0, which
>> means that this cpu cannot get a valid pcc_ss_id.
>>
>> 2. Add a check to verify if the register is a cpc supported one before
>> using it.
>>
>> Add cppc_set_reg() as a generic function for setting cppc registers. Unlike
>> other set reg ABIs, this function checks CPC_SUPPORTED right after getting
>> the register, because the rest of the operations are meaningless if this
>> register is not a cpc supported one.
>>
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> ---
>>   drivers/acpi/cppc_acpi.c | 191 +++++++++++++++------------------------
>>   1 file changed, 72 insertions(+), 119 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index c1f3568d0c50..306ced9c3376 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1179,10 +1179,13 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>>       return ret_val;
>>   }
>>   -static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
>> +static int cppc_get_reg(int cpunum, enum cppc_regs reg_idx, u64 *val)
>>   {
>>       struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
>> +    struct cppc_pcc_data *pcc_ss_data = NULL;
>>       struct cpc_register_resource *reg;
>> +    int pcc_ss_id;
>> +    int ret = 0;
> 
> NIT: Might not be necessary if we save the value returned by cpc_read(),
> cf. other comment below.
> 
>>         if (!cpc_desc) {
>>           pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
>> @@ -1191,20 +1194,23 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
>>         reg = &cpc_desc->cpc_regs[reg_idx];
>>   +    if (!CPC_SUPPORTED(reg)) {
>> +        pr_debug("CPC register (reg_idx=%u) is not supported\n", reg_idx);
>> +        return -EOPNOTSUPP;
>> +    }
>> +
>>       if (CPC_IN_PCC(reg)) {
>> -        int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
>> -        struct cppc_pcc_data *pcc_ss_data = NULL;
>> -        int ret = 0;
>> +        pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
>>             if (pcc_ss_id < 0)
>> -            return -EIO;
>> +            return -ENODEV;
> 
> NIT: Could add here:
>   pr_debug("Invalid pcc_ss_id\n");
> just as you did in cppc_set_reg()

Will add it in next version, Thanks.

> 
>>             pcc_ss_data = pcc_data[pcc_ss_id];
>>             down_write(&pcc_ss_data->pcc_lock);
>>             if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0)
>> -            cpc_read(cpunum, reg, perf);
>> +            cpc_read(cpunum, reg, val);
> 
> This was not introduced by your patch, but cpc_read() return a value.
> Shouldn't we return it instead of 0 ?

Indeed. Will optimize it, Thanks.

> 
>>           else
>>               ret = -EIO;
>>   @@ -1213,21 +1219,65 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
>>           return ret;
>>       }
>>   -    cpc_read(cpunum, reg, perf);
>> +    cpc_read(cpunum, reg, val);
> 
> Same comment as above
> 
>>         return 0;
>>   }
>>   +static int cppc_set_reg(int cpu, enum cppc_regs reg_idx, u64 val)
> 
> Just to have similar functions, maybe 'cpu' should be renamed to 'cpunum' ?
> Or the other way around.

I prefer 'cpu', 'cpunum' looks like the number of cpus to me.
Will rename 'cpunum' to 'cpu' in cppc_get_reg(). Thanks.

> 
>> +{
>> +    struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>> +    struct cppc_pcc_data *pcc_ss_data = NULL;
>> +    struct cpc_register_resource *reg;
>> +    int pcc_ss_id;
>> +    int ret;
>> +
>> +    if (!cpc_desc) {
>> +        pr_debug("No CPC descriptor for CPU:%d\n", cpu);
>> +        return -ENODEV;
>> +    }
>> +
>> +    reg = &cpc_desc->cpc_regs[reg_idx];
>> +
>> +    if (!CPC_SUPPORTED(reg)) {
>> +        pr_debug("CPC register (reg_idx=%u) is not supported\n", reg_idx);
>> +        return -EOPNOTSUPP;
>> +    }
>> +
>> +    if (CPC_IN_PCC(reg)) {
>> +        pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>> +
>> +        if (pcc_ss_id < 0) {
>> +            pr_debug("Invalid pcc_ss_id\n");
>> +            return -ENODEV;
>> +        }
>> +
>> +        ret = cpc_write(cpu, reg, val);
>> +        if (ret)
>> +            return ret;
>> +
>> +        pcc_ss_data = pcc_data[pcc_ss_id];
>> +
>> +        down_write(&pcc_ss_data->pcc_lock);
>> +        /* after writing CPC, transfer the ownership of PCC to platform */
>> +        ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
>> +        up_write(&pcc_ss_data->pcc_lock);
>> +        return ret;
>> +    }
>> +
>> +    return cpc_write(cpu, reg, val);
>> +}
>> +
> 
> [snip]
> 


