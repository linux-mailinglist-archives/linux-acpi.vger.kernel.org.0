Return-Path: <linux-acpi+bounces-8725-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4191C99B205
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Oct 2024 10:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93A072833A3
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Oct 2024 08:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF7A145B27;
	Sat, 12 Oct 2024 08:15:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBF11448F2;
	Sat, 12 Oct 2024 08:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728720905; cv=none; b=XwgyMMCAKe+keBhpXmt/tkVbP2yz8swfK9MXy/wDheF+mnf27dP9z72kUSC68SCnEs3b0avmUz/f1UritGJ/Ril/zNqU4N2IvraCvm5fRoCGXrHMHZKrEJjWbpjV8RGnmcM/l/lwHMQBbMy9qPnqEES5+Hteixc0eivWjyt5LJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728720905; c=relaxed/simple;
	bh=bpNv0iJvLQ5D2EzIqQeV7BvM+NsuRN6sSDSjAjWKbkU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CEO7Z5No58BjXlo1U/6NL2J9YbajhHf4pirFcbyK7knCZJgY7I64bUd3Ff4DrUbNb/FPw4Prktl7qpho/JimbXPrgUBwvyxhSEzYPGwq+9OI7GdLI0yugB82Up55X63dGwAsMjKwb0rJKDy2XqST4HAaaKZknDZWhmIEZUVLvkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XQbln69fVz1HKmw;
	Sat, 12 Oct 2024 16:10:45 +0800 (CST)
Received: from kwepemd200010.china.huawei.com (unknown [7.221.188.124])
	by mail.maildlp.com (Postfix) with ESMTPS id B62091A0188;
	Sat, 12 Oct 2024 16:14:54 +0800 (CST)
Received: from [10.174.162.134] (10.174.162.134) by
 kwepemd200010.china.huawei.com (7.221.188.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sat, 12 Oct 2024 16:14:53 +0800
Subject: Re: [PATCH] ACPI: GTDT: Tighten the check for the first platform
 timer entry
To: Marc Zyngier <maz@kernel.org>
CC: <lpieralisi@kernel.org>, <guohanjun@huawei.com>, <sudeep.holla@arm.com>,
	<mark.rutland@arm.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20241010144703.113728-1-zhengzengkai@huawei.com>
 <86ldyw5520.wl-maz@kernel.org>
From: Zheng Zengkai <zhengzengkai@huawei.com>
Message-ID: <6bd1b974-1393-5087-b1de-e0d87db023f4@huawei.com>
Date: Sat, 12 Oct 2024 16:14:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <86ldyw5520.wl-maz@kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200010.china.huawei.com (7.221.188.124)


ÔÚ 2024/10/10 23:52, Marc Zyngier Ð´µÀ:
> On Thu, 10 Oct 2024 15:47:03 +0100,
> Zheng Zengkai <zhengzengkai@huawei.com> wrote:
>> As suggested by Marc and Lorenzo, first we need to check whether
>> the platform_timer pointer is within gtdt bounds (< gtdt_end) before
>> de-referencing what it points at to detect the (first) platform
>> timer entry length and check that next platform_timer pointer is
>> within gtdt_end too. Now we do that only in next_platform_timer()
>> for subsequent platform timers.
>>
>> So add check against table length (gtdt_end) for the first platform
>> timer entry.
>>
>> Suggested-by: Marc Zyngier <maz@kernel.org>
>> Suggested-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
>> ---
>>   drivers/acpi/arm64/gtdt.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
>> index c0e77c1c8e09..f249af1ed1cd 100644
>> --- a/drivers/acpi/arm64/gtdt.c
>> +++ b/drivers/acpi/arm64/gtdt.c
>> @@ -177,7 +177,8 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
>>   	}
>>   
>>   	platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
>> -	if (platform_timer < (void *)table + sizeof(struct acpi_table_gtdt)) {
>> +	if (platform_timer < (void *)table + sizeof(struct acpi_table_gtdt) ||
>> +			platform_timer >= acpi_gtdt_desc.gtdt_end) {
>>   		pr_err(FW_BUG "invalid timer data.\n");
>>   		return -EINVAL;
>>   	}
> You  are  only  checking  the  base  pointer  for  the  platform_timer
> array. This doesn't say anything about the *size* of that array (or at
> least its first element), and whether that actually fits in the table.
>
> 	M.


Yes, I will send v2 to check against gtdt_end for both entry and length

of each array element.

Thanks!



