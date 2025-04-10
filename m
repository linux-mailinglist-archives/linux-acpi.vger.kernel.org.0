Return-Path: <linux-acpi+bounces-12937-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B166AA83CDA
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 10:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E5587A46EC
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 08:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1643720D4E1;
	Thu, 10 Apr 2025 08:23:31 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AF320B1F4;
	Thu, 10 Apr 2025 08:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744273411; cv=none; b=M1+Q13Kfn+Lu+qXSOqIkVwJ2HpDS5Go6ssXeoclh4l45zYyzRBSyxLuXGodN9FCqZaVVKVrQT0nO1nrsmAbmoUIqzMarsi5wHWSOhSxf55DQRHrIqmZ/mhzN0n4uf1as3MVGh+QHWUHxxS1RYPsEyiCYesm66zCDdPwjoUfMqP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744273411; c=relaxed/simple;
	bh=4TBFV6UWuVn7xSu86v7NyPudL9ojUWjHJK54DU8DbvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PYDKBHAnGwxB7dXhM2MLLV1YwM42HRYSojN8jGLUycPJDSOPdvJBGynqhSQuWp9/scusQ77EQSMO49XmG2lWQldUZFNFOfFjEzygaaGZxCfZWeAuTaNvzkTGi5h1cXZFx6gXfEW2kaXkFYxHaYqUlnLXgIT5w7iM7l1B2xyIPq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZYCT73cNDz1R7gn;
	Thu, 10 Apr 2025 16:21:31 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 6AE2A1A0188;
	Thu, 10 Apr 2025 16:23:25 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 10 Apr
 2025 16:23:24 +0800
Message-ID: <4154812c-dfe0-4973-bb78-f7af9163933c@huawei.com>
Date: Thu, 10 Apr 2025 16:23:23 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/8] ACPI: CPPC: Optimize cppc_get_perf()
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <robert.moore@intel.com>, <viresh.kumar@linaro.org>,
	<mario.limonciello@amd.com>, <gautham.shenoy@amd.com>, <ray.huang@amd.com>,
	<perry.yuan@amd.com>, <pierre.gondois@arm.com>,
	<acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>,
	<cenxinghai@h-partners.com>, <hepeng68@huawei.com>
References: <20250409065703.1461867-1-zhenglifeng1@huawei.com>
 <20250409065703.1461867-3-zhenglifeng1@huawei.com>
 <CAJZ5v0is5YXxqHDAC4Ki44U9mwDH3KvW0=JmFYS-25QwKYDR1A@mail.gmail.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <CAJZ5v0is5YXxqHDAC4Ki44U9mwDH3KvW0=JmFYS-25QwKYDR1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/4/10 1:10, Rafael J. Wysocki wrote:
> On Wed, Apr 9, 2025 at 8:57 AM Lifeng Zheng <zhenglifeng1@huawei.com> wrote:
>>
>> Optimize cppc_get_perf() with three changes:
>>
>> 1. Change the error kind to "no such device" when pcc_ss_id < 0, as other
>> register value getting functions.
>>
>> 2. Add a check to verify if the register is supported to be read before
>> using it. The logic is:
>>
>> (1) If the register is of the integer type, check whether the register is
>> optional and its value is 0. If yes, the register is not supported.
>>
>> (2) If the register is of other types, a null one is not supported.
>>
>> 3. Return the result of cpc_read() instead of 0.
>>
>> Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> ---
>>  drivers/acpi/cppc_acpi.c | 21 ++++++++++++++-------
>>  1 file changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 39f019e265da..2f789d3b3cad 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1201,20 +1201,29 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
>>
>>         reg = &cpc_desc->cpc_regs[reg_idx];
>>
>> +       if (reg->type == ACPI_TYPE_INTEGER ?
>> +           (IS_OPTIONAL_CPC_REG(reg_idx) && !reg->cpc_entry.int_value) :
>> +           IS_NULL_REG(&reg->cpc_entry.reg)) {
> 
> Please avoid using the ternary operator in any new kernel code.
> 
> Why not write it this way
> 
> if ((reg->type == ACPI_TYPE_INTEGER && IS_OPTIONAL_CPC_REG(reg_idx)
>     && !reg->cpc_entry.int_value) || (reg->type != ACPI_TYPE_INTEGER &&
>     IS_NULL_REG(&reg->cpc_entry.reg)) {

OK. Will replace it. Thanks!

> 
>> +               pr_debug("CPC register is not supported\n");
>> +               return -EOPNOTSUPP;
>> +       }
>> +
>>         if (CPC_IN_PCC(reg)) {
>>                 int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
>>                 struct cppc_pcc_data *pcc_ss_data = NULL;
>> -               int ret = 0;
>> +               int ret;
>>
>> -               if (pcc_ss_id < 0)
>> -                       return -EIO;
>> +               if (pcc_ss_id < 0) {
>> +                       pr_debug("Invalid pcc_ss_id\n");
>> +                       return -ENODEV;
>> +               }
>>
>>                 pcc_ss_data = pcc_data[pcc_ss_id];
>>
>>                 down_write(&pcc_ss_data->pcc_lock);
>>
>>                 if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0)
>> -                       cpc_read(cpunum, reg, perf);
>> +                       ret = cpc_read(cpunum, reg, perf);
>>                 else
>>                         ret = -EIO;
>>
>> @@ -1223,9 +1232,7 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
>>                 return ret;
>>         }
>>
>> -       cpc_read(cpunum, reg, perf);
>> -
>> -       return 0;
>> +       return cpc_read(cpunum, reg, perf);
>>  }
>>
>>  /**
>> --
> 
> 


