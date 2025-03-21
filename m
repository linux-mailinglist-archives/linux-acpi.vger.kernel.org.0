Return-Path: <linux-acpi+bounces-12389-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2119A6B2B5
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Mar 2025 02:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E09485FDD
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Mar 2025 01:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7271C84BF;
	Fri, 21 Mar 2025 01:45:52 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3CC1C1ADB;
	Fri, 21 Mar 2025 01:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742521552; cv=none; b=beR3GUZNVUQpMCDdQ9Dcrza8kHhLP8W6SKXj1D9I/mVGW069U/86nNyWOoxZq5rlrE0ABnCCglaAePkQ+iUcr8BmkyYLD0S6PvlJfF/JvxXbQjukAYNV4zvTpV7v7k3IrIvJblqDLh9Ktj7aRorZpBD2iXjdWLMPUo5QTfBc3+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742521552; c=relaxed/simple;
	bh=cPi2rLqMVZVMrpf6kVXEz5Xc035JMvkZO475SzT1E6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RCqGduKl8xM0p5LeJaV3K/eDKy9yNWlN0ijelhnxCbZB7t6/NKu6TTLSJ5HSLyLcV2Qvt1yCfiMsDKvFHydZ0s8ZIXg/C1aYW7Gjc/jahe4kpPrSD5rEEs6rvgKckPNdEIUwLXRyXLnoSSAbLHbClFwzUlvsspv6QVowvxZyBmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZJldS2dxjz1d0cp;
	Fri, 21 Mar 2025 09:45:32 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 023261402CC;
	Fri, 21 Mar 2025 09:45:48 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 21 Mar
 2025 09:45:47 +0800
Message-ID: <67031906-5b7e-4f4d-86c8-d534b6d61f2c@huawei.com>
Date: Fri, 21 Mar 2025 09:45:46 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
 <4fc77a58-8c77-463c-a50d-06ad19685bfb@huawei.com>
 <CAJZ5v0gmGx-9QsTTdbKi6EMQm2tePfhBdYMry_88gbybLUY6WA@mail.gmail.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <CAJZ5v0gmGx-9QsTTdbKi6EMQm2tePfhBdYMry_88gbybLUY6WA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/3/14 18:32, Rafael J. Wysocki wrote:

> On Fri, Mar 14, 2025 at 10:25 AM zhenglifeng (A)
> <zhenglifeng1@huawei.com> wrote:
>>
>> On 2025/3/13 3:54, Rafael J. Wysocki wrote:
>>
>>> On Thu, Feb 6, 2025 at 2:14 PM Lifeng Zheng <zhenglifeng1@huawei.com> wrote:
>>>>
>>>> Rename cppc_get_perf() to cppc_get_reg_val() as a generic function to read
>>>> cppc registers. And extract the operations if register is in pcc out as
>>>> cppc_get_reg_val_in_pcc(). Without functional change.
>>>
>>> This should be split into two patches IMV.
>>
>> Yes. That makes sense. Thanks.
>>
>>>
>>>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>>>> ---
>>>>  drivers/acpi/cppc_acpi.c | 66 +++++++++++++++++++++-------------------
>>>>  1 file changed, 35 insertions(+), 31 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>>> index db22f8f107db..3c9c4ce2a0b0 100644
>>>> --- a/drivers/acpi/cppc_acpi.c
>>>> +++ b/drivers/acpi/cppc_acpi.c
>>>> @@ -1189,48 +1189,52 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>>>>         return ret_val;
>>>>  }
>>>>
>>>> -static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
>>>> +static int cppc_get_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u64 *val)
>>>>  {
>>>> -       struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
>>>> -       struct cpc_register_resource *reg;
>>>> +       int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>>>> +       struct cppc_pcc_data *pcc_ss_data = NULL;
>>>> +       int ret;
>>>>
>>>> -       if (!cpc_desc) {
>>>> -               pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
>>>> +       if (pcc_ss_id < 0) {
>>>> +               pr_debug("Invalid pcc_ss_id\n");
>>>>                 return -ENODEV;
>>>>         }
>>>>
>>>> -       reg = &cpc_desc->cpc_regs[reg_idx];
>>>> +       pcc_ss_data = pcc_data[pcc_ss_id];
>>>>
>>>> -       if (IS_OPTIONAL_CPC_REG(reg_idx) && !CPC_SUPPORTED(reg)) {
>>>> -               pr_debug("CPC register (reg_idx=%d) is not supported\n", reg_idx);
>>>> -               return -EOPNOTSUPP;
>>>> -       }
>>>
>>> I'm not a big fan of the IS_OPTIONAL_CPC_REG() macro.  I'm not
>>> convinced at all that it adds any value above (and in the next patch
>>> for that matter) and the message printing the register index is just
>>> plain unuseful to anyone who doesn't know how to decode it.
>>
>> With this index, it is easier to locate problems. This is what a "pr_debug"
>> for, isn't it?
> 
> For those who know how to decode it, yes.  For others, not really.

At least it means something. But if you think this index is confusing for
those who don't know how to decode it, I'll remove it in the next version.

> 
>>>
>>> If CPC_SUPPORTED(reg) is not true, the register cannot be used AFAICS
>>> regardless of what IS_OPTIONAL_CPC_REG() has to say about it.
>>
>> The name "CPC_SUPPORTED" may be a little confused. Actually, in ACPI 6.5,
>> only optional _CPC package fields that are not supported by the platform
>> should be encoded as 0 intergers or NULL registers. A mandatory field as a
>> 0 interger is valid. So If I wanted to make this function as a generic one
>> to read cppc registers, it would have been more reasonable to do this
>> IS_OPTIONAL_CPC_REG() check before CPC_SUPPORTED().
> 
> I see, so you need to explain this in the changelog.

OK.

> 
> And IMV the code logic should be:
> 
> (1) If this is a NULL register, don't use it.
> (2) If it is integer 0, check if it is optional.
>     (a) If it is optional, don't use it.
>     (b) Otherwise, use 0 as the value.
> 
> Of course, there is a problem for platforms that may want to pass 0 as
> an optional field value, but this is a spec issue.

I'll change the logic in next version. Thanks!


