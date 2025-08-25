Return-Path: <linux-acpi+bounces-16006-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB89B33626
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 08:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8FD2200C30
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 06:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265E926C3BF;
	Mon, 25 Aug 2025 06:05:32 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086D823CEF9;
	Mon, 25 Aug 2025 06:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756101932; cv=none; b=K8KFRBkTYbMBSD64obA+JvLylAWnTcOBI0cmduF+T3iSstq/Lh8j3TbzbBpaCGlQdfasPqSSLSCnW27FGMQLH+G8hcecUgJGmGZAT+B/0UzZOJIXTY43owq0A5EPpcwnm13YFdX/LyJYzti7ashNhzbcpPJi4gub+O50BkmwtFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756101932; c=relaxed/simple;
	bh=5xdimQxy5HTLmsz20FCkxJnH6gBt1kDrqwdbKdoplC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Rt2cTUq/HtV9i9fyblDy6ceU9lu3zY9aPOOQE0fdGu3bpNTx8C9+cUdmBDvk9KlOGLSW/DXJlOmJ69TjXvQ4AOSNZcpxvTqGwKfWv62P5PsmlhVNysfMbbRf+hhrZOlVdAXH34hxy4zEhaZkpwwWQsbsyMfoc0U+v0Wnvd1OYGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4c9L021CFvz27jGv;
	Mon, 25 Aug 2025 14:06:26 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id D78951A0188;
	Mon, 25 Aug 2025 14:05:19 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 25 Aug 2025 14:05:19 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 25 Aug
 2025 14:05:18 +0800
Message-ID: <9fe902df-98a3-47cf-a199-092c9ef90ce2@huawei.com>
Date: Mon, 25 Aug 2025 14:05:02 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ACPI: processor: idle: Optimize acpi idle driver
 registration
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <yubowen8@huawei.com>, <liuyonglong@huawei.com>,
	<lihuisong@huawei.com>
References: <20250728070612.1260859-1-lihuisong@huawei.com>
 <20250728070612.1260859-3-lihuisong@huawei.com>
 <CAJZ5v0jckgZfuh=yAqoftG1Q-1z0ngLXQa4TX-iwuy54UmWMng@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0jckgZfuh=yAqoftG1Q-1z0ngLXQa4TX-iwuy54UmWMng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/8/24 0:13, Rafael J. Wysocki 写道:
> On Mon, Jul 28, 2025 at 9:06 AM Huisong Li <lihuisong@huawei.com> wrote:
>> Currently, the acpi idle driver is registered from within a CPU
>> hotplug callback. Although this didn't cause any functional issues,
>> this is questionable and confusing. And it is better to register
>> the cpuidle driver when all of the CPUs have been brought up.
>>
>> So add a new function to initialize acpi_idle_driver based on the
>> power management information of an available CPU and register cpuidle
>> driver in acpi_processor_driver_init().
>>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   drivers/acpi/processor_driver.c |  3 ++
>>   drivers/acpi/processor_idle.c   | 65 +++++++++++++++++++++------------
>>   include/acpi/processor.h        |  8 ++++
>>   3 files changed, 53 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
>> index 65e779be64ff..bc9f58a02c1d 100644
>> --- a/drivers/acpi/processor_driver.c
>> +++ b/drivers/acpi/processor_driver.c
>> @@ -263,6 +263,8 @@ static int __init acpi_processor_driver_init(void)
>>          if (result < 0)
>>                  return result;
>>
>> +       acpi_processor_register_idle_driver();
>> +
>>          result = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
>>                                     "acpi/cpu-drv:online",
>>                                     acpi_soft_cpu_online, NULL);
>> @@ -301,6 +303,7 @@ static void __exit acpi_processor_driver_exit(void)
>>
>>          cpuhp_remove_state_nocalls(hp_online);
>>          cpuhp_remove_state_nocalls(CPUHP_ACPI_CPUDRV_DEAD);
>> +       acpi_processor_unregister_idle_driver();
>>          driver_unregister(&acpi_processor_driver);
>>   }
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index 031738390f2d..c71802d42e8a 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -1360,7 +1360,48 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
>>          return 0;
>>   }
>>
>> -static int acpi_processor_registered;
>> +void acpi_processor_register_idle_driver(void)
>> +{
>> +       struct acpi_processor *pr;
>> +       int ret = -ENODEV;
>> +       int cpu;
>> +
>> +       /*
>> +        * Acpi idle driver is used by all possible CPUs.
>> +        * Install the idle handler by the processor power info of one in them.
>> +        * Note that we use previously set idle handler will be used on
>> +        * platforms that only support C1.
>> +        */
>> +       for_each_cpu(cpu, (struct cpumask *)cpu_possible_mask) {
>> +               pr = per_cpu(processors, cpu);
>> +               if (!pr)
>> +                       continue;
>> +
>> +               ret = acpi_processor_get_power_info(pr);
>> +               if (!ret) {
>> +                       pr->flags.power_setup_done = 1;
>> +                       acpi_processor_setup_cpuidle_states(pr);
>> +                       break;
>> +               }
>> +       }
>> +
>> +       if (ret) {
>> +               pr_debug("No ACPI power information from any CPUs.\n");
>> +               return;
>> +       }
>> +
>> +       ret = cpuidle_register_driver(&acpi_idle_driver);
>> +       if (ret) {
>> +               pr_debug("register %s failed.\n", acpi_idle_driver.name);
>> +               return;
>> +       }
>> +       pr_debug("%s registered with cpuidle.\n", acpi_idle_driver.name);
>> +}
>> +
>> +void acpi_processor_unregister_idle_driver(void)
>> +{
>> +       cpuidle_unregister_driver(&acpi_idle_driver);
>> +}
>>
>>   int acpi_processor_power_init(struct acpi_processor *pr)
>>   {
>> @@ -1375,22 +1416,7 @@ int acpi_processor_power_init(struct acpi_processor *pr)
>>          if (!acpi_processor_get_power_info(pr))
>>                  pr->flags.power_setup_done = 1;
>>
>> -       /*
>> -        * Install the idle handler if processor power management is supported.
>> -        * Note that we use previously set idle handler will be used on
>> -        * platforms that only support C1.
>> -        */
>>          if (pr->flags.power) {
>> -               /* Register acpi_idle_driver if not already registered */
>> -               if (!acpi_processor_registered) {
>> -                       acpi_processor_setup_cpuidle_states(pr);
>> -                       retval = cpuidle_register_driver(&acpi_idle_driver);
>> -                       if (retval)
>> -                               return retval;
>> -                       pr_debug("%s registered with cpuidle\n",
>> -                                acpi_idle_driver.name);
>> -               }
>> -
>>                  dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>>                  if (!dev)
>>                          return -ENOMEM;
>> @@ -1403,13 +1429,10 @@ int acpi_processor_power_init(struct acpi_processor *pr)
>>                   */
>>                  retval = cpuidle_register_device(dev);
>>                  if (retval) {
>> -                       if (acpi_processor_registered == 0)
>> -                               cpuidle_unregister_driver(&acpi_idle_driver);
>>                          kfree(dev);
>>                          per_cpu(acpi_cpuidle_device, pr->id) = NULL;
>>                          return retval;
>>                  }
>> -               acpi_processor_registered++;
>>          }
>>          return 0;
>>   }
>> @@ -1423,10 +1446,6 @@ int acpi_processor_power_exit(struct acpi_processor *pr)
>>
>>          if (pr->flags.power) {
>>                  cpuidle_unregister_device(dev);
>> -               acpi_processor_registered--;
>> -               if (acpi_processor_registered == 0)
>> -                       cpuidle_unregister_driver(&acpi_idle_driver);
>> -
>>                  kfree(dev);
>>          }
>>
>> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
>> index d0eccbd920e5..1249f5e81d92 100644
>> --- a/include/acpi/processor.h
>> +++ b/include/acpi/processor.h
>> @@ -423,6 +423,8 @@ int acpi_processor_power_init(struct acpi_processor *pr);
>>   int acpi_processor_power_exit(struct acpi_processor *pr);
>>   int acpi_processor_power_state_has_changed(struct acpi_processor *pr);
>>   int acpi_processor_hotplug(struct acpi_processor *pr);
>> +void acpi_processor_register_idle_driver(void);
>> +void acpi_processor_unregister_idle_driver(void);
>>   #else
>>   static inline int acpi_processor_power_init(struct acpi_processor *pr)
>>   {
>> @@ -443,6 +445,12 @@ static inline int acpi_processor_hotplug(struct acpi_processor *pr)
>>   {
>>          return -ENODEV;
>>   }
>> +static void acpi_processor_register_idle_driver(void)
>> +{
>> +}
>> +static void acpi_processor_unregister_idle_driver(void)
>> +{
>> +}
>>   #endif /* CONFIG_ACPI_PROCESSOR_IDLE */
>>
>>   /* in processor_thermal.c */
>> --
> Applied as 6.18 material, thanks!
>
> While at it, in the future, please always spell ACPI in capitals in
> patch subjects, changelogs and code comments.
Get it. Thanks.

>

