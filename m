Return-Path: <linux-acpi+bounces-9482-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A5B9C2B49
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 09:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F86E282A58
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 08:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5683142E67;
	Sat,  9 Nov 2024 08:36:51 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5446647;
	Sat,  9 Nov 2024 08:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731141411; cv=none; b=ZyJ5b/gMvuto5M/oPHHMZ2Bev/ZhqJo/Egc9X2YPPKNfLXT94scSEByaDc7zUAW+XMG/4Jb3nqmR+QYmmvwPKwQDRdX0pKDEaLUCZ9R50r5u01uU8K5JE8guNhM5eZsdm9vvCATjUxFC/2TtiCXUYeVZMy6HNSZHAJTOj3EdnoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731141411; c=relaxed/simple;
	bh=eGFnQi8ov8FaGWP9u1rV0kcwVoLUi1BQQadvmUjlQQ4=;
	h=Subject:From:To:CC:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eZrEHpAdJcciBE79NwdS4LwHZ0fwkzFj37yLsWUw1ALZZmQ89dBiCMuW+Szj3PJBh/3vj11xiNS18/k/Gj50aS2HMd8jPTCtQz3tU6UDWu8KKjOqFx1YlYdArIGlySaE1OY7KQqXG35yobhdapI4vI/bllQIfXthVhgkJ77KNrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Xlq132SPbz1ypMb;
	Sat,  9 Nov 2024 16:36:55 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F52314010C;
	Sat,  9 Nov 2024 16:36:44 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 9 Nov 2024 16:36:44 +0800
Subject: Re: [PATCH] acpi/arm64: remove unnecessary cast
From: Hanjun Guo <guohanjun@huawei.com>
To: Min-Hua Chen <minhuadotchen@gmail.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
References: <20240917233827.73167-1-minhuadotchen@gmail.com>
 <e7632dd4-6009-53f3-e61a-ccb15d9f88f3@huawei.com>
Message-ID: <713ce05d-2d14-fe6b-c3f8-791fff4e50f2@huawei.com>
Date: Sat, 9 Nov 2024 16:36:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e7632dd4-6009-53f3-e61a-ccb15d9f88f3@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2024/10/19 14:47, Hanjun Guo wrote:
> On 2024/9/18 7:38, Min-Hua Chen wrote:
>> DEFINE_RES_IRQ returns struct resource type, so it is
>> unnecessary to cast it to struct resource.
>>
>> Remove the unnecessary cast to fix the following sparse warnings:
>>
>> drivers/acpi/arm64/gtdt.c:355:19: sparse: warning: cast to non-scalar
>> drivers/acpi/arm64/gtdt.c:355:19: sparse: warning: cast from non-scalar
>>
>> No functional changes intended.
>>
>> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
>> ---
>>   drivers/acpi/arm64/gtdt.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
>> index c0e77c1c8e09..24bd479de91f 100644
>> --- a/drivers/acpi/arm64/gtdt.c
>> +++ b/drivers/acpi/arm64/gtdt.c
>> @@ -352,7 +352,7 @@ static int __init gtdt_import_sbsa_gwdt(struct 
>> acpi_gtdt_watchdog *wd,
>>       }
>>       irq = map_gt_gsi(wd->timer_interrupt, wd->timer_flags);
>> -    res[2] = (struct resource)DEFINE_RES_IRQ(irq);
>> +    res[2] = DEFINE_RES_IRQ(irq);
>>       if (irq <= 0) {
>>           pr_warn("failed to map the Watchdog interrupt.\n");
>>           nr_res--;
>>
> 
> It's a minor issue, but I think it deserves a patch to make
> the code cleaner,
> 
> Acked-by: Hanjun Guo <guohanjun@huawei.com>

Lorenzo, Sudeep, please take a look at this patch.

Thanks
Hanjun

