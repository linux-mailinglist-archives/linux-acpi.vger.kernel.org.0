Return-Path: <linux-acpi+bounces-16444-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37A7B484D2
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 09:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635DB3A7EEC
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 07:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4992E3AF1;
	Mon,  8 Sep 2025 07:11:08 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A62747F;
	Mon,  8 Sep 2025 07:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757315468; cv=none; b=ZcVvlu1tg0yJ6K5D/RqCQu1+OzP4NCOR+cqt5Mhge1pyyQ1u2fKy/9ROu0lCQD2Xgw60PFX9yzM2ESAOgGiVyrNYPYkONiLNGmhqvY6oKo9foUzjLsEQTQacMn3oLlsGYZk8ZxORwRUI/rqvW5E0RHJcWQkVeS8X5CLpNL4sxPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757315468; c=relaxed/simple;
	bh=TGoui9RAoubTvCWH9fH5QwtY15RPHNhiYd9ViviTrec=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d67DDrNCnx5m9ZzpCgwbeD94kJxvgKZnku87WyId9GZ31OqX8JJKgQGblpRP5Dmg1txTurJD5DSR7ssmC9Ou07qTdLWKUkBzLImIp7n7G87DEHP1eABuouck/rVsYySzpVD4mfL+rWbAislzjHzIFLvyFd7LVRe7ja/6DSAtBjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cKyDc673jzWvDY;
	Mon,  8 Sep 2025 14:47:12 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 85433180483;
	Mon,  8 Sep 2025 14:51:10 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Sep 2025 14:51:10 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 8 Sep
 2025 14:51:09 +0800
Message-ID: <445b25ea-3fa9-4273-9dcc-f6f6bda4164c@huawei.com>
Date: Mon, 8 Sep 2025 14:51:08 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ACPI: processor: Remove unused empty function
 definition for processor_idle.c
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <yubowen8@huawei.com>
References: <20250905081900.663869-1-lihuisong@huawei.com>
 <20250905081900.663869-3-lihuisong@huawei.com>
 <CAJZ5v0jF=1QdHMVY1=Cp_iOEPA2sMOsqQC3vK4uYJMWnpXethw@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0jF=1QdHMVY1=Cp_iOEPA2sMOsqQC3vK4uYJMWnpXethw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemn100009.china.huawei.com (7.202.194.112)

Hi Rafael,

Thanks for you fast reply.


在 2025/9/6 3:50, Rafael J. Wysocki 写道:
> On Fri, Sep 5, 2025 at 10:19 AM Huisong Li <lihuisong@huawei.com> wrote:
>> If CONFIG_ACPI_PROCESSOR=n and CONFIG_ACPI_PROCESSOR_IDLE=n, we may encounter
>> some warnings about function defined but not used.
>> All external functions of processor_idle.c are just used in processor_driver.c.
>> And if CONFIG_ACPI_PROCESSOR is selected and CONFIG_ACPI_PROCESSOR_IDLE also
>> be selected automatically. So remove these empty function definitions.
>>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   include/acpi/processor.h | 22 +---------------------
>>   1 file changed, 1 insertion(+), 21 deletions(-)
>>
>> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
>> index ff864c1cee3a..d6a87dc42a9a 100644
>> --- a/include/acpi/processor.h
>> +++ b/include/acpi/processor.h
>> @@ -417,34 +417,14 @@ static inline void acpi_processor_throttling_init(void) {}
>>   #endif /* CONFIG_ACPI_CPU_FREQ_PSS */
>>
>>   /* in processor_idle.c */
>> -extern struct cpuidle_driver acpi_idle_driver;
>>   #ifdef CONFIG_ACPI_PROCESSOR_IDLE
>> +extern struct cpuidle_driver acpi_idle_driver;
> The changes above don't belong to this patch IMV or at least I don't
> see why they belong to it.

Yes, I just do it by the way.

Ok, I will fix it like the folloing way in a separate patch.

How do you think?

-->

diff --git a/drivers/acpi/processor_driver.c 
b/drivers/acpi/processor_driver.c
index bc9f58a02c1d..5d824435b26b 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -166,8 +166,7 @@ static int __acpi_processor_start(struct acpi_device 
*device)
         if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
                 dev_dbg(&device->dev, "CPPC data invalid or not 
present\n");

-       if (!cpuidle_get_driver() || cpuidle_get_driver() == 
&acpi_idle_driver)
-               acpi_processor_power_init(pr);
+       acpi_processor_power_init(pr);

         acpi_pss_perf_init(pr);

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 5dacf41d7cc0..967fb13f38fa 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1404,6 +1404,11 @@ int acpi_processor_power_init(struct 
acpi_processor *pr)
  {
         int retval;
         struct cpuidle_device *dev;
+       struct cpuidle_driver *drv;
+
+       drv = cpuidle_get_driver();
+       if (drv && drv != &acpi_idle_driver)
+               return 0;

         if (disabled_by_idle_boot_param())
                 return 0;
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index ff864c1cee3a..dcc500bdd5cd 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -417,7 +417,6 @@ static inline void 
acpi_processor_throttling_init(void) {}
  #endif /* CONFIG_ACPI_CPU_FREQ_PSS */

  /* in processor_idle.c */
-extern struct cpuidle_driver acpi_idle_driver;
  #ifdef CONFIG_ACPI_PROCESSOR_IDLE
  int acpi_processor_power_init(struct acpi_processor *pr);
  int acpi_processor_power_exit(struct acpi_processor *pr);

>
>>   int acpi_processor_power_init(struct acpi_processor *pr);
>>   int acpi_processor_power_exit(struct acpi_processor *pr);
>>   int acpi_processor_power_state_has_changed(struct acpi_processor *pr);
>>   int acpi_processor_hotplug(struct acpi_processor *pr);
<...>

