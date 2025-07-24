Return-Path: <linux-acpi+bounces-15311-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE499B10B2D
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Jul 2025 15:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D763BAAD0
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Jul 2025 13:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65089264623;
	Thu, 24 Jul 2025 13:15:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588C44400;
	Thu, 24 Jul 2025 13:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362935; cv=none; b=B0IddJAE7ghP7bERjtawrybsiT7mWHo0xzAvGK7wpLVwTPR2r3c32IFs1uUGpz7ihQ3WtpevBuKPlM42S4k4Zy98Z9DI2GSw9aiPApRqyMOxYHXDqWTHyaXPwwac3WbNBDZ5iqIQ2NdLhCcBIsiUAYZ913zKpt2e0sHWRBD3gG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362935; c=relaxed/simple;
	bh=TF+EvEU97tw/++Aux3bzOk/z4Xx3ED1KKXq5a9vHUuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UsulepBMn49qF2CJ8p753Lt1/Xh12qYyGf8eEsO5zUm66/j9t3qBHsjq4oHbOLAP0jzQ+ZSA0rjrhbpXQIq5jQeoBnWsAPMPVI97jhI1NV4dIYh6SNQqOsFbudaNIJUGQH1hYnK/lp3Kon0gHbQ7uGdKw12pfap7DULONVo3Xto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bnrww5Btcz2Cfw9;
	Thu, 24 Jul 2025 21:11:12 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 6713B140109;
	Thu, 24 Jul 2025 21:15:23 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Jul 2025 21:15:23 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 24 Jul
 2025 21:15:22 +0800
Message-ID: <b5da2c2a-8621-45a8-865f-b6e90089b586@huawei.com>
Date: Thu, 24 Jul 2025 21:15:21 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: processor: idle: Fix resource leak and potential
 concurrent in acpi_processor_power_init()
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <yubowen8@huawei.com>, <liuyonglong@huawei.com>,
	<lihuisong@huawei.com>
References: <20250723121034.3685996-1-lihuisong@huawei.com>
 <CAJZ5v0gOi5kUKVWSwaPW=4Kmjkj1kj=nzaZ0jTa8fAAy32ZytA@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0gOi5kUKVWSwaPW=4Kmjkj1kj=nzaZ0jTa8fAAy32ZytA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/7/23 21:35, Rafael J. Wysocki 写道:
> On Wed, Jul 23, 2025 at 2:10 PM Huisong Li <lihuisong@huawei.com> wrote:
>> There are three kind of issues:
>> 1> There are two resource leak issues in acpi_processor_power_init:
>>     a> Don't unregister acpi_idle_driver when do kzalloc failed.
> This is not a resource leak.  As I said before, the driver need not be
> unregistered on a memory allocation failure.
Ok, will remove it.
>
>>     b> Don't free cpuidle device memory when register cpuidle device failed.
> This is a separate minor issue that needs to be addressed by a separate patch.
Got it.  will add a separate patch in next version.
>
>> 2> There isn't lock to prevent the global acpi_processor_registered, which
>>     may lead to concurrent register cpuidle driver.
> That's not obvious because in principle the code in question is only
> run during initialization which is serialized.
>
> In theory, it could run in parallel CPU online, but that at least is
> not default behavior AFAICS.
Ack.
>
> In any case, if you claim something like this, it is advisable to
> mention a specific scenario in which the race in question can happen.

Yeah.

Anyway, it is ok if the initialization is serialized as you mentioned.


>
>> 3> The cpuidle driver should be registered in advance when all of the CPUs
>>     have been brought up instead of being in a CPU hotplug callback.
> The "in advance" piece above is rather confusing and it can be dropped
> without changing the meaning of the rest of the sentence.
Ack
>
>> To solve these issues, so add a new function to initialize acpi_idle_driver
>> based on the power management information of an available CPU and register
>> cpuidle driver in acpi_processor_driver_init().
> I think that the main problem here is that the cpuidle driver is
> registered from within a CPU hotplug callback, which is questionable
> and confusing.  Usually, however, this doesn't lead to any functional
> issues AFAICS.
Ok, this patch will use this tone in the commit log.
>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   v2: register cpuidle driver in advance when all of the CPUs have been
>>       brought up.
>>       v1 link: https://patchwork.kernel.org/project/linux-acpi/patch/20250619061327.1674384-1-lihuisong@huawei.com/
>> ---
>>   drivers/acpi/processor_driver.c |  5 +++
>>   drivers/acpi/processor_idle.c   | 71 ++++++++++++++++++++++-----------
>>   include/acpi/processor.h        |  9 +++++
>>   3 files changed, 62 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
>> index 65e779be64ff..ff944c93b6ff 100644
>> --- a/drivers/acpi/processor_driver.c
>> +++ b/drivers/acpi/processor_driver.c
>> @@ -263,6 +263,10 @@ static int __init acpi_processor_driver_init(void)
>>          if (result < 0)
>>                  return result;
>>
>> +       result = acpi_processor_register_idle_driver();
>> +       if (result)
>> +               pr_info("register idle driver failed, ret = %d.\n", result);
> This registers the cpuidle driver before registering cpuidle devices
> for all CPUs.
>
> It would be better to make acpi_processor_register_idle_driver() print
> the diagnostic message on failures and then it won't need to return a
> value.
Ack
>
> Note that it may fail if intel_idle is already registered, for
> example, so the message should rather be a debug-level one.
All right.
>> +
>>          result = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
>>                                     "acpi/cpu-drv:online",
>>                                     acpi_soft_cpu_online, NULL);
>> @@ -301,6 +305,7 @@ static void __exit acpi_processor_driver_exit(void)
>>
>>          cpuhp_remove_state_nocalls(hp_online);
>>          cpuhp_remove_state_nocalls(CPUHP_ACPI_CPUDRV_DEAD);
>> +       acpi_processor_unregister_idle_driver();
>>          driver_unregister(&acpi_processor_driver);
>>   }
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index 2c2dc559e0f8..2408f1076631 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -1360,7 +1360,52 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
>>          return 0;
>>   }
>>
>> -static int acpi_processor_registered;
>> +int acpi_processor_register_idle_driver(void)
>> +{
>> +       struct acpi_processor *pr;
>> +       int cpu;
>> +       int ret;
> The ret variable needs to be initialized here or tools will complain,
> and so it may be initialized to -ENODEV:
>
> int ret = -ENODEV;
Ack
>
>> +
>> +       /*
>> +        * Acpi idle driver is used by all possible CPUs.
>> +        * Install the idle handler by the processor power info of one in them.
>> +        * Note that we use previously set idle handler will be used on
>> +        * platforms that only support C1.
>> +        */
>> +       for_each_cpu(cpu, (struct cpumask *)cpu_possible_mask) {
>> +               pr = per_cpu(processors, cpu);
>> +               if (pr == NULL)
> "if (!pr)" please.
Ack
>
>> +                       continue;
>> +
>> +               ret = acpi_processor_get_power_info(pr);
> if (ret)
>          continue;
Please see the following reply.
>
>> +               if (!ret) {
>> +                       pr->flags.power_setup_done = 1;
> I think this is set here to prevent the subsequent
> acpi_processor_setup_cpuidle_states() call from bailing out, but is
> this not too early to set it?
Setting to 1 is necessary here,
otherwise acpi_processor_setup_cpuidle_states would not initialize 
acpi_idle_driver because this flag is false.
>
>> +                       break;
>> +               }
>> +       }
>> +
>> +       if (unlikely(!pr))
>> +               return -ENODEV;
> This is unnecessary if ret is initialized to -ENODEV;
ok
>
>> +
>> +       if (ret) {
>> +               pr_err("%s get power information failed.\n",
>> +                      acpi_idle_driver.name);
> This message is confusing at best.  It should be something like "No
> ACPI power information for any CPUs" and the driver name in it has no
> purpose.
Ack
>
>> +               return ret;
>> +       }
>> +
>> +       acpi_processor_setup_cpuidle_states(pr);
> I'd call this in the loop right before breaking out of it, so the
> scope of pr is clear.
will fix it as you said.
>
>> +       ret = cpuidle_register_driver(&acpi_idle_driver);
>> +       if (ret)
> Print a diagnostic message here and do not return a value (ie. make
> the function void).
All right.
>
>> +               return ret;
>> +
>> +       pr_debug("%s registered with cpuidle\n", acpi_idle_driver.name);
>> +       return 0;
>> +}
>> +
>> +void acpi_processor_unregister_idle_driver(void)
>> +{
>> +       cpuidle_unregister_driver(&acpi_idle_driver);
>> +}
>>
>>   int acpi_processor_power_init(struct acpi_processor *pr)
>>   {
>> @@ -1375,22 +1420,7 @@ int acpi_processor_power_init(struct acpi_processor *pr)
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
>> @@ -1403,11 +1433,10 @@ int acpi_processor_power_init(struct acpi_processor *pr)
>>                   */
>>                  retval = cpuidle_register_device(dev);
>>                  if (retval) {
>> -                       if (acpi_processor_registered == 0)
>> -                               cpuidle_unregister_driver(&acpi_idle_driver);
>> +                       per_cpu(acpi_cpuidle_device, pr->id) = NULL;
>> +                       kfree(dev);
> These two lines should be added in a separate patch.
Ack.
>
>
>>                          return retval;
>>                  }
>> -               acpi_processor_registered++;
>>          }
>>          return 0;
>>   }
>> @@ -1421,10 +1450,6 @@ int acpi_processor_power_exit(struct acpi_processor *pr)
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
>> index d0eccbd920e5..3cb41a3f2d9a 100644
>> --- a/include/acpi/processor.h
>> +++ b/include/acpi/processor.h
>> @@ -423,6 +423,8 @@ int acpi_processor_power_init(struct acpi_processor *pr);
>>   int acpi_processor_power_exit(struct acpi_processor *pr);
>>   int acpi_processor_power_state_has_changed(struct acpi_processor *pr);
>>   int acpi_processor_hotplug(struct acpi_processor *pr);
>> +int acpi_processor_register_idle_driver(void);
>> +void acpi_processor_unregister_idle_driver(void);
>>   #else
>>   static inline int acpi_processor_power_init(struct acpi_processor *pr)
>>   {
>> @@ -443,6 +445,13 @@ static inline int acpi_processor_hotplug(struct acpi_processor *pr)
>>   {
>>          return -ENODEV;
>>   }
>> +static int acpi_processor_register_idle_driver(void)
>> +{
>> +       return -ENODEV;
>> +}
>> +static void acpi_processor_unregister_idle_driver(void)
>> +{
>> +}
>>   #endif /* CONFIG_ACPI_PROCESSOR_IDLE */
>>
>>   /* in processor_thermal.c */
>> --
>> 2.33.0
>>

