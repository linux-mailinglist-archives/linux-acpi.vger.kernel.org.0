Return-Path: <linux-acpi+bounces-19483-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E51E3CAC008
	for <lists+linux-acpi@lfdr.de>; Mon, 08 Dec 2025 05:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB667300DA72
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Dec 2025 04:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2E92F60B6;
	Mon,  8 Dec 2025 04:02:26 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6384C21CFF6;
	Mon,  8 Dec 2025 04:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765166546; cv=none; b=qEPFwryOd9j13i5CS5M08YlG5eM+1cEq/QEV3fDq25Ezrk2QK4roECU+5arntyGKTkYh+5nG2zx0aZgmpl1jzOULt98j99uwIlXqem0bi0il/X7txGNBp5B1lxSkLf84lYeqXCjKz5BIF4BmAH6U969+r+HlG6Rd/aRhw10ifsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765166546; c=relaxed/simple;
	bh=nUHg6a3gECAE+NIBQcPZ3nLPe1vCJ1oy3E4bhE1dcc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pzpYAOlc3MkFhawx8MZYjcS4HAt+NhmCX8BoZ99AAcRZ7UZav8JHkGS2E6k87VAubqAFk4hXgsb828zn84YM7N/PspSqeOEXKGt9/aYjYC5vpACB25N4assZD4+b/12aDt/PwKXbNCU7py3hoVYJcHMQXJnaqgvNK1vc8utlrgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dPpD56YczzKm4s;
	Mon,  8 Dec 2025 12:00:21 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 968C01A016C;
	Mon,  8 Dec 2025 12:02:17 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 8 Dec
 2025 12:02:16 +0800
Message-ID: <adeb19a3-da4a-41e9-948c-dac7002d034a@hisilicon.com>
Date: Mon, 8 Dec 2025 12:02:16 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] ACPI: CPPC: Factor out and export per-cpu
 cppc_perf_ctrs_in_pcc_cpu()
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <viresh.kumar@linaro.org>, <ionela.voinescu@arm.com>,
	<beata.michalska@arm.com>, <pierre.gondois@arm.com>,
	<zhenglifeng1@huawei.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<prime.zeng@hisilicon.com>, <yubowen8@huawei.com>, <lihuisong@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>
References: <20251203032422.3232957-1-zhanjie9@hisilicon.com>
 <20251203032422.3232957-2-zhanjie9@hisilicon.com>
 <CAJZ5v0jvk+gs+h+76__LLZDa=OGzLxQQsWEMDHXzeV8aV6UYsA@mail.gmail.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <CAJZ5v0jvk+gs+h+76__LLZDa=OGzLxQQsWEMDHXzeV8aV6UYsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 12/5/2025 11:13 PM, Rafael J. Wysocki wrote:
> On Wed, Dec 3, 2025 at 4:25 AM Jie Zhan <zhanjie9@hisilicon.com> wrote:
>>
>> Factor out cppc_perf_ctrs_in_pcc_cpu() for checking whether per-cpu CPC
>> regs are defined in PCC channels, and export it out for further use.
>>
>> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
>> ---
>>  drivers/acpi/cppc_acpi.c | 45 +++++++++++++++++++++-------------------
>>  include/acpi/cppc_acpi.h |  5 +++++
>>  2 files changed, 29 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 3bdeeee3414e..aa80dbcf42c0 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1422,6 +1422,29 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>>  }
>>  EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
>>
>> +bool cppc_perf_ctrs_in_pcc_cpu(unsigned int cpu)
>> +{
>> +       struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>> +       struct cpc_register_resource *ref_perf_reg;
>> +
>> +       /*
>> +        * If reference perf register is not supported then we should use the
>> +        * nominal perf value
>> +        */
>> +       ref_perf_reg = &cpc_desc->cpc_regs[REFERENCE_PERF];
>> +       if (!CPC_SUPPORTED(ref_perf_reg))
>> +               ref_perf_reg = &cpc_desc->cpc_regs[NOMINAL_PERF];
>> +
>> +       if (CPC_IN_PCC(&cpc_desc->cpc_regs[DELIVERED_CTR]) ||
>> +           CPC_IN_PCC(&cpc_desc->cpc_regs[REFERENCE_CTR]) ||
>> +           CPC_IN_PCC(&cpc_desc->cpc_regs[CTR_WRAP_TIME]) ||
>> +           CPC_IN_PCC(ref_perf_reg))
>> +               return true;
>> +
>> +       return false;
> 
> Why not
> 
> return CPC_IN_PCC(&cpc_desc->cpc_regs[DELIVERED_CTR]) ||
>           CPC_IN_PCC(&cpc_desc->cpc_regs[REFERENCE_CTR]) ||
>           CPC_IN_PCC(&cpc_desc->cpc_regs[CTR_WRAP_TIME]) ||
>           CPC_IN_PCC(ref_perf_reg);
> 
Yes, that would save a few more lines.
Thanks!

