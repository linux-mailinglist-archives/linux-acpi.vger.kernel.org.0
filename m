Return-Path: <linux-acpi+bounces-15119-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8753B0342F
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 03:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82CB17A25DC
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 01:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F7F17B50F;
	Mon, 14 Jul 2025 01:34:07 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E90153BED;
	Mon, 14 Jul 2025 01:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752456846; cv=none; b=UMenoUHJwjHr2sx5HC+oaJGczmZ6ihXv5w+bIlbq0/TbHaI3O3PbMRadleRhMEZ4Ft2q9V38AFxgELVB6SgRZ2giGAbVPp+g1k8/UDia8ygcMqNzOPaOHRhanmt0ecKKVQDHjU6Tvsiiw6c9mXShZ4JC8jtSD42rF2ydz0r/CsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752456846; c=relaxed/simple;
	bh=yRSpgC7Rr4aHCZ7Ox1XCum5rSxpCLsdCyTsF1z5mcpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RohKCo+lXo/EobA1OkGUwPX8t5OTUc8usTg3+Brt2cx7cLj7A0JN7eM/n3qUdJfGENpsE+ieoA5jQfw+riEI+NZ6pKfXEVH23fTCWQ03J6/VFctFOjLfsXvGFNtEED6lM+QRxztOqSPRsz4/1xUq+3c6Sma+ZJBDgMU9Y3+A7RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bgPtm5k7rz2FbPT;
	Mon, 14 Jul 2025 09:32:00 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 9CAFE1A0174;
	Mon, 14 Jul 2025 09:34:01 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Jul 2025 09:33:52 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Jul
 2025 09:33:52 +0800
Message-ID: <4c1926ef-f9fa-49d5-8d5f-ed4ee2638d62@huawei.com>
Date: Mon, 14 Jul 2025 09:33:51 +0800
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
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0hXHgyCKoEOMTtp0c_yu__vGGDcPnqaUML2Xg7hyJWc3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/7/3 19:09, Rafael J. Wysocki 写道:
> On Thu, Jul 3, 2025 at 8:23 AM lihuisong (C) <lihuisong@huawei.com> wrote:
>> Hi,
>>
>> Thanks for your review.
>>
>>
>> 在 2025/7/3 1:42, Rafael J. Wysocki 写道:
>>> On Thu, Jun 19, 2025 at 8:13 AM Huisong Li <lihuisong@huawei.com> wrote:
>>>> There are two resource rollback issues in acpi_processor_power_init:
>>>> 1> Do not unregister acpi_idle_driver when do kzalloc failed.
>>>> 2> Do not free cpuidle device memory when register cpuidle device failed.
>>>>
>>>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>>>> ---
>>>>    drivers/acpi/processor_idle.c | 24 +++++++++++++++++-------
>>>>    1 file changed, 17 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>>>> index 2c2dc559e0f8..3548ab9dac9e 100644
>>>> --- a/drivers/acpi/processor_idle.c
>>>> +++ b/drivers/acpi/processor_idle.c
>>>> @@ -1392,8 +1392,10 @@ int acpi_processor_power_init(struct acpi_processor *pr)
>>>>                   }
>>>>
>>>>                   dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>>>> -               if (!dev)
>>>> -                       return -ENOMEM;
>>>> +               if (!dev) {
>>>> +                       retval = -ENOMEM;
>>>> +                       goto unregister_driver;
>>> No, unregistering the driver here is pointless.
>> I don't quite understand why here is pointless. Can you explain it?
> When this function is run for another CPU, it will attempt to register
> the driver again if it is unregistered here.
Yeah, got it.
So registering cpuidle also has a potential race issue here.
>
> Quite frankly, the driver should be registered before running this
> function because it is a CPU hotplug callback and registering a
> cpuidle driver from within it is quite questionable.
>
> Alternatively, it can be registered when all of the CPUs have been brought up.
Agree with you.
The reason why is that the initialization of acpi_idle_driver depands on 
the power management information of CPU.
But the power management information of CPU is obtained in this callback.
I have an idea.
Because acpi_idle_driver is applied to all possiable CPUs. And use the 
power information of the first onlined CPU to initialize and register 
acpi_idle_driver, currently.
So I think we can use this logic and dependency to extract a function to 
initialize and register acpi_idle_driver. And put this function to 
acpi_processor_driver_init().
I tested it is ok.
What do you think about this?

/Huisong
>
>>>> +               }
>>>>                   per_cpu(acpi_cpuidle_device, pr->id) = dev;
>>>>
>>>>                   acpi_processor_setup_cpuidle_dev(pr, dev);
>>>> @@ -1402,14 +1404,22 @@ int acpi_processor_power_init(struct acpi_processor *pr)
>>>>                    * must already be registered before registering device
>>>>                    */
>>>>                   retval = cpuidle_register_device(dev);
>>>> -               if (retval) {
>>>> -                       if (acpi_processor_registered == 0)
>>>> -                               cpuidle_unregister_driver(&acpi_idle_driver);
>>> Pretty much the same as here.
>>>
>>> It would be good to clean up dev here though.
>> It is ok if above is pointless.
>>>> -                       return retval;
>>>> -               }
>>>> +               if (retval)
>>>> +                       goto free_cpuidle_device;
>>>> +
>>>>                   acpi_processor_registered++;
>>>>           }
>>>>           return 0;
>>>> +
>>>> +free_cpuidle_device:
>>>> +       per_cpu(acpi_cpuidle_device, pr->id) = NULL;
>>>> +       kfree(dev);
>>>> +
>>>> +unregister_driver:
>>>> +       if (acpi_processor_registered == 0)
>>>> +               cpuidle_unregister_driver(&acpi_idle_driver);
>>>> +
>>>> +       return retval;
>>>>    }
>>>>
>>>>    int acpi_processor_power_exit(struct acpi_processor *pr)
>>>> --
>>>> 2.33.0
>>>>

