Return-Path: <linux-acpi+bounces-15269-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6182AB0D7AD
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Jul 2025 13:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004BD3BBD1B
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Jul 2025 11:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EDD2E2651;
	Tue, 22 Jul 2025 11:06:26 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB09242D89;
	Tue, 22 Jul 2025 11:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182386; cv=none; b=SQTP6p6BjicawP96JzYXKj4w9qmTzSXlwSx15C2fMr1XXcFZK1lv0kypfUdNtXA0RcUKoeskhG//1kSzaR/dOElrd+2Cv0Lm+9g1FTmifmqQXmlSzyEyqRtQI9vY47rxCmfqy+o1x2Pkeh8O9pKQkqiZMQnRZIcRFHSIL0AYoTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182386; c=relaxed/simple;
	bh=gYJWcfMA+4JwuKa4pqmCzXGEn9gI6ZQKiZEdFTNaSKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GabaNLjl95Nhy4S/aArTG+jvrf2CSffQEo2WZ4nFhATi/4Kld2FnTZ/2MOewOoCjGRxvvuO50sy5pfhsZ9hps6E4vScbotOwVB+17QN7I/80Rom+hcDVUbN1SGlKeJkFml15bZyG030qnS5JMquSnfhyHY+SN/rGQIk/dErbjGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bmZB14bmqz2RVwG;
	Tue, 22 Jul 2025 19:03:05 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id BDDAB1402C1;
	Tue, 22 Jul 2025 19:05:17 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 22 Jul 2025 19:05:17 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 22 Jul
 2025 19:05:16 +0800
Message-ID: <f60aa4a2-35aa-41f6-b56d-6eb114e10ab2@huawei.com>
Date: Tue, 22 Jul 2025 19:05:16 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: processor: idle: Fix resource rollback in
 acpi_processor_power_init
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <yubowen8@huawei.com>, <liuyonglong@huawei.com>,
	<lihuisong@huawei.com>
References: <20250619061327.1674384-1-lihuisong@huawei.com>
 <CAJZ5v0gjkZ3a-BwgJxjUJbNwu5E_j9VUUHrR3M=a+KPTA-tZcA@mail.gmail.com>
 <6a35291a-32e8-461e-a0e5-405b7b5d24ce@huawei.com>
 <CAJZ5v0hXHgyCKoEOMTtp0c_yu__vGGDcPnqaUML2Xg7hyJWc3g@mail.gmail.com>
 <4c1926ef-f9fa-49d5-8d5f-ed4ee2638d62@huawei.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <4c1926ef-f9fa-49d5-8d5f-ed4ee2638d62@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemn100009.china.huawei.com (7.202.194.112)

Hi Rafael,

Can you take a look at my reply?
If it is ok to you, I will send it later.

/Huisong
在 2025/7/14 9:33, lihuisong (C) 写道:
>
> 在 2025/7/3 19:09, Rafael J. Wysocki 写道:
>> On Thu, Jul 3, 2025 at 8:23 AM lihuisong (C) <lihuisong@huawei.com> 
>> wrote:
>>> Hi,
>>>
>>> Thanks for your review.
>>>
>>>
>>> 在 2025/7/3 1:42, Rafael J. Wysocki 写道:
>>>> On Thu, Jun 19, 2025 at 8:13 AM Huisong Li <lihuisong@huawei.com> 
>>>> wrote:
>>>>> There are two resource rollback issues in acpi_processor_power_init:
>>>>> 1> Do not unregister acpi_idle_driver when do kzalloc failed.
>>>>> 2> Do not free cpuidle device memory when register cpuidle device 
>>>>> failed.
>>>>>
>>>>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>>>>> ---
>>>>>    drivers/acpi/processor_idle.c | 24 +++++++++++++++++-------
>>>>>    1 file changed, 17 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/drivers/acpi/processor_idle.c 
>>>>> b/drivers/acpi/processor_idle.c
>>>>> index 2c2dc559e0f8..3548ab9dac9e 100644
>>>>> --- a/drivers/acpi/processor_idle.c
>>>>> +++ b/drivers/acpi/processor_idle.c
>>>>> @@ -1392,8 +1392,10 @@ int acpi_processor_power_init(struct 
>>>>> acpi_processor *pr)
>>>>>                   }
>>>>>
>>>>>                   dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>>>>> -               if (!dev)
>>>>> -                       return -ENOMEM;
>>>>> +               if (!dev) {
>>>>> +                       retval = -ENOMEM;
>>>>> +                       goto unregister_driver;
>>>> No, unregistering the driver here is pointless.
>>> I don't quite understand why here is pointless. Can you explain it?
>> When this function is run for another CPU, it will attempt to register
>> the driver again if it is unregistered here.
> Yeah, got it.
> So registering cpuidle also has a potential race issue here.
>>
>> Quite frankly, the driver should be registered before running this
>> function because it is a CPU hotplug callback and registering a
>> cpuidle driver from within it is quite questionable.
>>
>> Alternatively, it can be registered when all of the CPUs have been 
>> brought up.
> Agree with you.
> The reason why is that the initialization of acpi_idle_driver depands 
> on the power management information of CPU.
> But the power management information of CPU is obtained in this callback.
> I have an idea.
> Because acpi_idle_driver is applied to all possiable CPUs. And use the 
> power information of the first onlined CPU to initialize and register 
> acpi_idle_driver, currently.
> So I think we can use this logic and dependency to extract a function 
> to initialize and register acpi_idle_driver. And put this function to 
> acpi_processor_driver_init().
> I tested it is ok.
> What do you think about this?
>
> /Huisong
>>
>>>>> +               }
>>>>>                   per_cpu(acpi_cpuidle_device, pr->id) = dev;
>>>>>
>>>>>                   acpi_processor_setup_cpuidle_dev(pr, dev);
>>>>> @@ -1402,14 +1404,22 @@ int acpi_processor_power_init(struct 
>>>>> acpi_processor *pr)
>>>>>                    * must already be registered before registering 
>>>>> device
>>>>>                    */
>>>>>                   retval = cpuidle_register_device(dev);
>>>>> -               if (retval) {
>>>>> -                       if (acpi_processor_registered == 0)
>>>>> - cpuidle_unregister_driver(&acpi_idle_driver);
>>>> Pretty much the same as here.
>>>>
>>>> It would be good to clean up dev here though.
>>> It is ok if above is pointless.
>>>>> -                       return retval;
>>>>> -               }
>>>>> +               if (retval)
>>>>> +                       goto free_cpuidle_device;
>>>>> +
>>>>>                   acpi_processor_registered++;
>>>>>           }
>>>>>           return 0;
>>>>> +
>>>>> +free_cpuidle_device:
>>>>> +       per_cpu(acpi_cpuidle_device, pr->id) = NULL;
>>>>> +       kfree(dev);
>>>>> +
>>>>> +unregister_driver:
>>>>> +       if (acpi_processor_registered == 0)
>>>>> + cpuidle_unregister_driver(&acpi_idle_driver);
>>>>> +
>>>>> +       return retval;
>>>>>    }
>>>>>
>>>>>    int acpi_processor_power_exit(struct acpi_processor *pr)
>>>>> -- 
>>>>> 2.33.0
>>>>>

