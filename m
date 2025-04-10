Return-Path: <linux-acpi+bounces-12936-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E848AA83CC8
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 10:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A70D4A2B0F
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 08:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6564720ADDC;
	Thu, 10 Apr 2025 08:22:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02B71FDE31;
	Thu, 10 Apr 2025 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744273325; cv=none; b=sZDKzYtU276etr5Ts0KzsLMpS3ymuwOKdNE6ceFwIKJxFmL+lqFG/KCa2BF9qcRTnmesKzmGR+55wLqIv8EzB8FdqTStW8290sLUhkEUHA1knbEQWsNB/koSmsYjFs4SOC8xqu8Wu48Ag9L4kBYIVPzIt80cdoHl5nD9A7Zv5R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744273325; c=relaxed/simple;
	bh=QEHUf3cjjUvT3Mem8QZVL3tzuLM/jVQlVCaqrc3lP7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SCRojV775/auOxjXu7V7nnKiHhgpW7R9DjOvvCRCGVPXxSooPa+It1Qte1rV5a0EF2HET9vscUCwOfkaeXrQULC0OW9WVxhWTqsOSek7auMk/L03fy8aIKoX6Ezv+886V8pXXaxJ3fEGiyCrun3KJg19XiWIlh109rzHiHXMCPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZYCP03VHxzvWsm;
	Thu, 10 Apr 2025 16:17:56 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id D5744180087;
	Thu, 10 Apr 2025 16:21:59 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 10 Apr
 2025 16:21:58 +0800
Message-ID: <4e67b8db-1bc8-48b7-b3c2-956b717cbf84@huawei.com>
Date: Thu, 10 Apr 2025 16:21:58 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/8] ACPI: CPPC: Add IS_OPTIONAL_CPC_REG macro to judge
 if a cpc_reg is optional
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
 <20250409065703.1461867-2-zhenglifeng1@huawei.com>
 <7a3bda35-05a0-49ad-b014-1834a176a906@amd.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <7a3bda35-05a0-49ad-b014-1834a176a906@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/4/10 2:53, Mario Limonciello wrote:
> On 4/9/2025 1:56 AM, Lifeng Zheng wrote:
>> In ACPI 6.5, s8.4.6.1 _CPC (Continuous Performance Control), whether each
>> of the per-cpu cpc_regs[] is mendatory or optional is defined. Since the
> mandatory

Thanks！

>> CPC_SUPPORTED() check is only for optional cpc field, another macro to
>> check if the field is optional is needed.
>>
>> Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> ---
>>   drivers/acpi/cppc_acpi.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index f193e713825a..39f019e265da 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -129,6 +129,20 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
>>   #define CPC_SUPPORTED(cpc) ((cpc)->type == ACPI_TYPE_INTEGER ?        \
>>                   !!(cpc)->cpc_entry.int_value :        \
>>                   !IS_NULL_REG(&(cpc)->cpc_entry.reg))
>> +
>> +/*
>> + * Each bit indicates the optionality of the register in per-cpu
>> + * cpc_regs[] with the corresponding index. 0 means mandatory and 1
>> + * means optional.
>> + */
>> +#define REG_OPTIONAL (0x1FC7D0)
>> +
>> +/*
>> + * Use the index of the register in per-cpu cpc_regs[] to check if
>> + * it's an optional one.
>> + */
>> +#define IS_OPTIONAL_CPC_REG(reg_idx) (REG_OPTIONAL & (1U << (reg_idx)))
>> +
>>   /*
>>    * Arbitrary Retries in case the remote processor is slow to respond
>>    * to PCC commands. Keeping it high enough to cover emulators where
> 


