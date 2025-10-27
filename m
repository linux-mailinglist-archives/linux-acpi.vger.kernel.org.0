Return-Path: <linux-acpi+bounces-18239-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BC7C0BB8F
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Oct 2025 04:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471A03ACB72
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Oct 2025 03:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA79153598;
	Mon, 27 Oct 2025 03:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="YMLO6AAk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9594126ACB;
	Mon, 27 Oct 2025 03:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761534095; cv=none; b=KJSWAYT47Gt8wlIvmzxTvhVMtBCNeyHeeulyEUBvQK1Dpo5ZhCgS2z0F68U2bSp+kaCG3/LfAI15feqjvRHIG7KPluU2z5oLRRWWVkJVm0gb8oWF/nOAdtK9ITcuT2vrg6Qsr5myp4ngA4at328+NZHqKI6ZU4oCKbhVbTcZEPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761534095; c=relaxed/simple;
	bh=dt62QxfoVcCfUEWcExjNknKuLr2ooHpOBIUQIjjHA4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gKLXJNP65N++RsgcFObetyETh6IcRVD67XHTrECzmWxVtIhNc0IVlICsnEbXIekvgYMXpQp+3qRSjYwsD8H7PR0i1MH9JXNa8i1FEpQxbBoW69Zf+uL/ikXTFMHcIl8MZWK0MnHsRqVNaENnVYvF5JxrLhVfP3y3hWElWp50zac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=YMLO6AAk; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wGGj2Xbnf/KJ+AicjY3f8n/PBiq49kjQ+SBvrDCHTWw=;
	b=YMLO6AAknM64lTu+Hk9tq2HHHUt2cMdB8+GBdQIQbnrO2SFMKtEtDvyy/kjYFY0V8X8OMtjK3
	rKp85qRTOdn15I8S4ZC4TzQYLGBeapidWFwpjRxOXIPWUBDA5H2MlH+CcxJlp0XB7dM/y/rkBCj
	orQmHMIDs6U5x0YJ5Qq+f1k=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4cvytw2Tj5zRhVK;
	Mon, 27 Oct 2025 11:00:56 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 191031800B1;
	Mon, 27 Oct 2025 11:01:24 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 Oct 2025 11:01:23 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 27 Oct
 2025 11:01:23 +0800
Message-ID: <dfd9a4a0-f74a-4359-b028-e8e3276769fd@huawei.com>
Date: Mon, 27 Oct 2025 11:01:22 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/9] ACPI: processor: idle: Do not change power states
 if get power info failed
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Sudeep.Holla@arm.com>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>
References: <20250929093754.3998136-1-lihuisong@huawei.com>
 <20250929093754.3998136-7-lihuisong@huawei.com>
 <CAJZ5v0jBqPLjK2v7A-8Qd6ERhwz47jP3YCiTHJhD8vAgRHVjcQ@mail.gmail.com>
 <e1d440bd-23c0-434c-a771-5c0907c5d3ab@huawei.com>
 <CAJZ5v0h64UoWY=Zkpc4g2UH+ii8K6APDSV2qLp==yHuRQz+fsQ@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0h64UoWY=Zkpc4g2UH+ii8K6APDSV2qLp==yHuRQz+fsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/10/26 20:34, Rafael J. Wysocki 写道:
> On Fri, Oct 24, 2025 at 11:10 AM lihuisong (C) <lihuisong@huawei.com> wrote:
>>
>> 在 2025/10/22 3:49, Rafael J. Wysocki 写道:
>>> On Mon, Sep 29, 2025 at 11:38 AM Huisong Li <lihuisong@huawei.com> wrote:
>>>> Driver will update power states when processor power states have been
>>>> changed. To prevent any other abnormal issues, here add the verification
>>>> for the result of getting power information, don't change power states
>>>> and one error log when get power information failed.
>>> But the old states may not be usable any more in that case.
>> Yes
>>> If you want to check the acpi_processor_get_power_info(), it should
>>> disable ACPi idle entirely on failures.
>>   From the modification of this patch, this cpuidle device will be
>> disabled if the acpi_processor_get_power_info(）fails to get on this device.
>> And the cpuidle of the device will be disabled according to the
>> definition of cpuidle_not_available().
>> We should not call disable_cpuidle() to disable cpuidle of all CPUs.
> Since the same idle state data is used for all CPUs, I'd say cpuidle
Yes.
 From the current implementation perspective, the idle state is 
initialized by the first available CPU.
If there is one CPU get power management information failed later, the 
ACPI idle driver doesn't disable cpuidle of all CPUs and
just doesn't register cpudile_device and enable cpuidle_device.
> should be disabled for all of them in that case.
I can understand this. I think it is reasonable.
What do you think how to disable cpuidle of all CPUs here?
How about call disable_cpuidle() and disable all cpuidle devices?
>
> Alternatively, check if it works for any of them and apply the data
> from the CPU where it works to all of them.  If it doesn't work for
> any of them, there's nothing to apply.

How should we check if the idle states can work to all of CPUs?

>
>> So the modification in this patch is enough, right?
>>>> Fixes: f427e5f1cf75 ("ACPI / processor: Get power info before updating the C-states")
>>>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>>>> ---
>>>>    drivers/acpi/processor_idle.c | 15 ++++++++++-----
>>>>    1 file changed, 10 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>>>> index b0d6b51ee363..92b231f5d514 100644
>>>> --- a/drivers/acpi/processor_idle.c
>>>> +++ b/drivers/acpi/processor_idle.c
>>>> @@ -1315,6 +1315,7 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
>>>>           int cpu;
>>>>           struct acpi_processor *_pr;
>>>>           struct cpuidle_device *dev;
>>>> +       int ret = 0;
>>>>
>>>>           if (disabled_by_idle_boot_param())
>>>>                   return 0;
>>>> @@ -1344,16 +1345,20 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
>>>>                   }
>>>>
>>>>                   /* Populate Updated C-state information */
>>>> -               acpi_processor_get_power_info(pr);
>>>> -               acpi_processor_setup_cpuidle_states(pr);
>>>> +               ret = acpi_processor_get_power_info(pr);
>>>> +               if (ret)
>>>> +                       pr_err("Get processor-%u power information failed.\n",
>>>> +                              pr->id);
>>>> +               else
>>>> +                       acpi_processor_setup_cpuidle_states(pr);
>>>>
>>>>                   /* Enable all cpuidle devices */
>>>>                   for_each_online_cpu(cpu) {
>>>>                           _pr = per_cpu(processors, cpu);
>>>>                           if (!_pr || !_pr->flags.power_setup_done)
>>>>                                   continue;
>>>> -                       acpi_processor_get_power_info(_pr);
>>>> -                       if (_pr->flags.power) {
>>>> +                       ret = acpi_processor_get_power_info(_pr);
>>>> +                       if (!ret && _pr->flags.power) {
>>>>                                   dev = per_cpu(acpi_cpuidle_device, cpu);
>>>>                                   acpi_processor_setup_cpuidle_dev(_pr, dev);
>>>>                                   cpuidle_enable_device(dev);
>>>> @@ -1363,7 +1368,7 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
>>>>                   cpus_read_unlock();
>>>>           }
>>>>
>>>> -       return 0;
>>>> +       return ret;
>>>>    }
>>>>
>>>>    void acpi_processor_register_idle_driver(void)
>>>> --
>>>> 2.33.0
>>>>

