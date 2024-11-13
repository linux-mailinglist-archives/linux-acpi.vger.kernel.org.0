Return-Path: <linux-acpi+bounces-9533-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D689C69CA
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 08:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D6C0282033
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 07:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0465217B4E9;
	Wed, 13 Nov 2024 07:23:26 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B52230987;
	Wed, 13 Nov 2024 07:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731482605; cv=none; b=UWBVb1nlrZFa27i6ocE4otHe7MNV/mcDCcG/lwdu0JZJzKDLQAem+bblNUsZTktNMX2acqvp7SI88MbZrVRCOAAc9iJENXp5Jjq1V3D3EkJ1eH7NFRrX/VWLD78UahmzvIc5ISi9T2Hptt0mq04rH+pbMCfmfj4BsO/OlrwpdBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731482605; c=relaxed/simple;
	bh=F0+Jlt97pUkHoEEibR8wMNxG7oRS5mCf9icrpgkxRiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NBLMQdE6ZoLuDkHlTXH5PGjVE2ZeKTlBf74vLd7+e9z411A1Rpc2bf3TOke9nOhiB7OVCRUmpNL23a69Zgm599b8pZY4eEuSjlr3bO/oypcbJ0W9UjkBlwkAT4Soy+oycb6q5+MzSx78X4IJyBSxc+jt9h2rSE0CYBvfW/XJq0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XpF881V3sz1SFmy;
	Wed, 13 Nov 2024 15:21:28 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 99D62140203;
	Wed, 13 Nov 2024 15:23:18 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 13 Nov
 2024 15:23:17 +0800
Message-ID: <c5654255-5708-4c04-8311-ccd52f771277@huawei.com>
Date: Wed, 13 Nov 2024 15:23:16 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: CPPC: fix bug that causes the value written in cpc
 register to be wrong.
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
	<rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <fanghao11@huawei.com>
References: <20241113024933.2100519-1-zhenglifeng1@huawei.com>
 <dfe6ca13-7c4b-4204-b3fb-7390eca3b18b@rivosinc.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <dfe6ca13-7c4b-4204-b3fb-7390eca3b18b@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh100008.china.huawei.com (7.202.181.93)



On 2024/11/13 15:05, Clément Léger wrote:
> 
> 
> On 13/11/2024 03:49, Lifeng Zheng wrote:
>> With these codes, the value written in cpc register will be the result of
>> the OR operatiion on input value and prev_val. This will causes the value
>> to be wrong.
>>
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> ---
>>  drivers/acpi/cppc_acpi.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 01192fd047a6..f69ef7cc0caf 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1146,7 +1146,6 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>>  			return -EFAULT;
>>  		}
>>  		val = MASK_VAL_WRITE(reg, prev_val, val);
>> -		val |= prev_val;
> 
> Hi Lifeng,
> 
> Indeed, MASK_VAL_WRITE() already takes care of ORing prev_val with the
> register mask. You can also add a Fixes:
> 
> Fixes: 60949b7b8054 ("ACPI: CPPC: Fix MASK_VAL() usage")
> 
> Thanks,
> 
> Clément
> 
>>  	}
>>  
>>  	switch (size) {
> 

Thanks for reminder. I'll add this Fixes and resend this patch.

