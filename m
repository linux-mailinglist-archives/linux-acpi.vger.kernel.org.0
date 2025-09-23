Return-Path: <linux-acpi+bounces-17216-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2903B940E7
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 05:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D96447E61
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 03:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3154B1C861D;
	Tue, 23 Sep 2025 03:04:02 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC47946C;
	Tue, 23 Sep 2025 03:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758596642; cv=none; b=AYTRlXtJ1AXcfgthNs307lMoD51QSmh8J2lWDpe29hNUVyJGA85DAQB5iNy0Ea9Mm6v+5z0eWkj8+idzbMcQjkAhOfpoMlDwL4c1fu2E9WxxVH0ZKjnGxdHyzOOlAZ27gmmeMJoa1bqtexZVFm1lLyXh5Pus/O1Faogl0Besaj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758596642; c=relaxed/simple;
	bh=s9kJKV3lmvuUjLB7N+06mN/PEnM2bOSM0WGRy17yOIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LSv15gBZK1u5nIBTSR3suqD+eXXL1V++7nyN2SWJGZOhAnibRBHbAoxD8C9vqEd9MnCX65Hvyt4Is3VVanc1yznOm4Sm8U8BVP98xiYioARGmSW051uaHo3rvi7x4bcMSnbyAs3/ej1tJaftqOX2m6GYEhT4u8gZRE5L1bbynj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cW4Xx2kKsztTKX;
	Tue, 23 Sep 2025 11:02:57 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D5EF180B63;
	Tue, 23 Sep 2025 11:03:50 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Sep 2025 11:03:50 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 23 Sep
 2025 11:03:49 +0800
Message-ID: <da422ab9-363d-4266-a964-aea2e181691e@huawei.com>
Date: Tue, 23 Sep 2025 11:03:48 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] ACPI: processor: Do not expose the global
 acpi_idle_driver variable
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <yubowen8@huawei.com>
References: <20250922070354.485296-1-lihuisong@huawei.com>
 <20250922070354.485296-2-lihuisong@huawei.com>
 <CAJZ5v0gWSRE1WX0GTVqHhpDZW8ZaWpviuQ+zEyS4E6ne4rutLQ@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0gWSRE1WX0GTVqHhpDZW8ZaWpviuQ+zEyS4E6ne4rutLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/9/23 1:38, Rafael J. Wysocki 写道:
> On Mon, Sep 22, 2025 at 9:04 AM Huisong Li <lihuisong@huawei.com> wrote:
>> Currently, processor_driver just use the global acpi_idle_driver variable
>> to check if the cpuidle driver is acpi_idle_driver. Actually, there is no
>> need to expose this global variable defined in processor_idle.c to outside.
>> So move the related check to acpi_processor_power_init() and limit the
>> global variable to a static one.
>>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   drivers/acpi/processor_driver.c |  3 +--
>>   drivers/acpi/processor_idle.c   | 12 +++++++++++-
>>   include/acpi/processor.h        |  1 -
>>   3 files changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
>> index de17c1412678..5d824435b26b 100644
>> --- a/drivers/acpi/processor_driver.c
>> +++ b/drivers/acpi/processor_driver.c
>> @@ -166,8 +166,7 @@ static int __acpi_processor_start(struct acpi_device *device)
>>          if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
>>                  dev_dbg(&device->dev, "CPPC data invalid or not present\n");
>>
>> -       if (cpuidle_get_driver() == &acpi_idle_driver)
>> -               acpi_processor_power_init(pr);
>> +       acpi_processor_power_init(pr);
>>
>>          acpi_pss_perf_init(pr);
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index 698d14c19587..42948495f4f1 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -51,7 +51,7 @@ module_param(latency_factor, uint, 0644);
>>
>>   static DEFINE_PER_CPU(struct cpuidle_device *, acpi_cpuidle_device);
>>
>> -struct cpuidle_driver acpi_idle_driver = {
>> +static struct cpuidle_driver acpi_idle_driver = {
>>          .name =         "acpi_idle",
>>          .owner =        THIS_MODULE,
>>   };
>> @@ -1402,8 +1402,18 @@ void acpi_processor_unregister_idle_driver(void)
>>
>>   void acpi_processor_power_init(struct acpi_processor *pr)
>>   {
>> +       struct cpuidle_driver *drv = cpuidle_get_driver();
> This variable is not needed any more.
Ack
>
>>          struct cpuidle_device *dev;
>>
>> +       /*
>> +        * Normally, the ACPI idle driver has already been registered before
>> +        * CPU online. But the 'drv' may be NULL if register idle driver failed.
>> +        * So do not anything if the idle driver isn't acpi_idle_driver or the
>> +        * 'drv' is NULL.
> And this comment can be much shorter, maybe something like "The code
> below only works if acpi_idle_driver is the current cpuidle driver."
will fix it.
>
>> +        */
>> +       if (drv != &acpi_idle_driver)
>> +               return;
>> +
>>          if (disabled_by_idle_boot_param())
>>                  return;
>>
>> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
>> index 24fdaa3c2899..7146a8e9e9c2 100644
>> --- a/include/acpi/processor.h
>> +++ b/include/acpi/processor.h
>> @@ -417,7 +417,6 @@ static inline void acpi_processor_throttling_init(void) {}
>>   #endif /* CONFIG_ACPI_CPU_FREQ_PSS */
>>
>>   /* in processor_idle.c */
>> -extern struct cpuidle_driver acpi_idle_driver;
>>   #ifdef CONFIG_ACPI_PROCESSOR_IDLE
>>   void acpi_processor_power_init(struct acpi_processor *pr);
>>   void acpi_processor_power_exit(struct acpi_processor *pr);
>> --
>> 2.33.0
>>

