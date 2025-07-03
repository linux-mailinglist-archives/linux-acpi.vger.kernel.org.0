Return-Path: <linux-acpi+bounces-14962-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D19BAF6A33
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 08:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C8F31C24725
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 06:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3712928E61E;
	Thu,  3 Jul 2025 06:23:53 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9014227A904;
	Thu,  3 Jul 2025 06:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751523833; cv=none; b=HMr1fE/MmgC4K/VVjywVru/zWgQnnC5K15vdLvvDw5ooGUMgUqQnftmIPC9p3usv8SQtO6g3jACREw5Ol6kc1uJCWi0Bwwdxj6+ydu91DUba1yh29On96sOYHWt//zDeUJAI70Kc7mY15PXQek8lAaCAoG03IVP2WTsm5xId7RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751523833; c=relaxed/simple;
	bh=VfODPCvId0FnSD2H1u26I86YA5WLls8xlhZgh9zcarA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WpeTApTmoBE/xMRJfBWv1ta+pubXenq7psVZq8O63+t1NSsYczfEC+mzUDKtN/t8ZGodON4Ei88DBZWXWQzXSuOSOEqXOrS6ufLw1t3byiNHwvMvpSEv2mOWHJuPQP4bSF6OpMUT527QUa8fFKOzvUZSdzF6RcQd6XOpXOQu3+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bXmnR3ZfZzWfvW;
	Thu,  3 Jul 2025 14:19:23 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 876B018007F;
	Thu,  3 Jul 2025 14:23:46 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 3 Jul 2025 14:23:46 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 3 Jul
 2025 14:23:45 +0800
Message-ID: <6a35291a-32e8-461e-a0e5-405b7b5d24ce@huawei.com>
Date: Thu, 3 Jul 2025 14:23:44 +0800
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
	<zhenglifeng1@huawei.com>, <yubowen8@huawei.com>, <liuyonglong@huawei.com>
References: <20250619061327.1674384-1-lihuisong@huawei.com>
 <CAJZ5v0gjkZ3a-BwgJxjUJbNwu5E_j9VUUHrR3M=a+KPTA-tZcA@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0gjkZ3a-BwgJxjUJbNwu5E_j9VUUHrR3M=a+KPTA-tZcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemn100009.china.huawei.com (7.202.194.112)

Hi,

Thanks for your review.


在 2025/7/3 1:42, Rafael J. Wysocki 写道:
> On Thu, Jun 19, 2025 at 8:13 AM Huisong Li <lihuisong@huawei.com> wrote:
>> There are two resource rollback issues in acpi_processor_power_init:
>> 1> Do not unregister acpi_idle_driver when do kzalloc failed.
>> 2> Do not free cpuidle device memory when register cpuidle device failed.
>>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   drivers/acpi/processor_idle.c | 24 +++++++++++++++++-------
>>   1 file changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index 2c2dc559e0f8..3548ab9dac9e 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -1392,8 +1392,10 @@ int acpi_processor_power_init(struct acpi_processor *pr)
>>                  }
>>
>>                  dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>> -               if (!dev)
>> -                       return -ENOMEM;
>> +               if (!dev) {
>> +                       retval = -ENOMEM;
>> +                       goto unregister_driver;
> No, unregistering the driver here is pointless.
I don't quite understand why here is pointless. Can you explain it?
>
>> +               }
>>                  per_cpu(acpi_cpuidle_device, pr->id) = dev;
>>
>>                  acpi_processor_setup_cpuidle_dev(pr, dev);
>> @@ -1402,14 +1404,22 @@ int acpi_processor_power_init(struct acpi_processor *pr)
>>                   * must already be registered before registering device
>>                   */
>>                  retval = cpuidle_register_device(dev);
>> -               if (retval) {
>> -                       if (acpi_processor_registered == 0)
>> -                               cpuidle_unregister_driver(&acpi_idle_driver);
> Pretty much the same as here.
>
> It would be good to clean up dev here though.
It is ok if above is pointless.
>
>> -                       return retval;
>> -               }
>> +               if (retval)
>> +                       goto free_cpuidle_device;
>> +
>>                  acpi_processor_registered++;
>>          }
>>          return 0;
>> +
>> +free_cpuidle_device:
>> +       per_cpu(acpi_cpuidle_device, pr->id) = NULL;
>> +       kfree(dev);
>> +
>> +unregister_driver:
>> +       if (acpi_processor_registered == 0)
>> +               cpuidle_unregister_driver(&acpi_idle_driver);
>> +
>> +       return retval;
>>   }
>>
>>   int acpi_processor_power_exit(struct acpi_processor *pr)
>> --
>> 2.33.0
>>

