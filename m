Return-Path: <linux-acpi+bounces-17104-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E19B848F9
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 14:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900241B26A6D
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 12:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4764B2FC899;
	Thu, 18 Sep 2025 12:23:08 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4312F6186;
	Thu, 18 Sep 2025 12:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758198188; cv=none; b=u1huNQ/vHPffXtxwfdRr7T7qtfR27CDkNqe35ubvU+j1oKAhwzepvOwd/OosXxQyrcGGl9VzJ+Igt8F0RACLisLJtmePKV16VKXXghVA11UNt4FKbKJEs83Udmd1OI9vS3IMQCAM5fgmCIddH5V0O2gbZSBJoRqFmh110yeivt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758198188; c=relaxed/simple;
	bh=Xp9eGuC9SjYhOCpvQcov8F5DMsc761Z4duupJEGXW7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PI2/2sL7Br0haOOXo5+NPcKUpb8XvlO+MzfEAAMQFjkVqLDDL23GhADHfDeWXfsj5IsqwwhTPijaObXI+A6LhCOEmPNzpaCT/u5JMemYjgE41SMUi1dyAhOP1lodCQI/Hie+xL7mBAUEh4XwskwMlQpc9K9oo+vo9Frxy7hrFa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cSFC931RZz14Mw8;
	Thu, 18 Sep 2025 20:22:45 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 562A0180486;
	Thu, 18 Sep 2025 20:23:02 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Sep 2025 20:23:02 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 18 Sep
 2025 20:23:01 +0800
Message-ID: <1e55d104-9746-4b37-8663-12714cc00026@huawei.com>
Date: Thu, 18 Sep 2025 20:23:00 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] ACPI: processor: Do not expose the global
 acpi_idle_driver variable
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <yubowen8@huawei.com>
References: <20250911112408.1668431-1-lihuisong@huawei.com>
 <20250911112408.1668431-4-lihuisong@huawei.com>
 <CAJZ5v0hb19Xy8dOP4itU-F5F7OjDXBVNGYiwoxAVc_yGuUv=Aw@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0hb19Xy8dOP4itU-F5F7OjDXBVNGYiwoxAVc_yGuUv=Aw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/9/18 4:01, Rafael J. Wysocki 写道:
> On Thu, Sep 11, 2025 at 1:24 PM Huisong Li <lihuisong@huawei.com> wrote:
>> Currently, processor_driver just use the global acpi_idle_driver variable
>> to check if the cpuidle driver is acpi_idle_driver. Actually, there is no
>> need to expose this global variable defined in processor_idle.c to outside.
>> So move the related logical to acpi_processor_power_init() and do not
>> expose it.
> And it can also be made static, can't it?
ok, will do it in next version. Thanks.
>
> Please do that too.
>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   drivers/acpi/processor_driver.c | 3 +--
>>   drivers/acpi/processor_idle.c   | 5 +++++
>>   include/acpi/processor.h        | 1 -
>>   3 files changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
>> index bc9f58a02c1d..5d824435b26b 100644
>> --- a/drivers/acpi/processor_driver.c
>> +++ b/drivers/acpi/processor_driver.c
>> @@ -166,8 +166,7 @@ static int __acpi_processor_start(struct acpi_device *device)
>>          if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
>>                  dev_dbg(&device->dev, "CPPC data invalid or not present\n");
>>
>> -       if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
>> -               acpi_processor_power_init(pr);
>> +       acpi_processor_power_init(pr);
>>
>>          acpi_pss_perf_init(pr);
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index 5dacf41d7cc0..967fb13f38fa 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -1404,6 +1404,11 @@ int acpi_processor_power_init(struct acpi_processor *pr)
>>   {
>>          int retval;
>>          struct cpuidle_device *dev;
>> +       struct cpuidle_driver *drv;
>> +
>> +       drv = cpuidle_get_driver();
>> +       if (drv && drv != &acpi_idle_driver)
>> +               return 0;
>>
>>          if (disabled_by_idle_boot_param())
>>                  return 0;
>> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
>> index 6ee4a69412de..bd96dde5eef5 100644
>> --- a/include/acpi/processor.h
>> +++ b/include/acpi/processor.h
>> @@ -417,7 +417,6 @@ static inline void acpi_processor_throttling_init(void) {}
>>   #endif /* CONFIG_ACPI_CPU_FREQ_PSS */
>>
>>   /* in processor_idle.c */
>> -extern struct cpuidle_driver acpi_idle_driver;
>>   #ifdef CONFIG_ACPI_PROCESSOR_IDLE
>>   int acpi_processor_power_init(struct acpi_processor *pr);
>>   int acpi_processor_power_exit(struct acpi_processor *pr);
>> --

