Return-Path: <linux-acpi+bounces-18172-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EA0C05433
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 11:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C16C1B82B2E
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 09:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01397308F2A;
	Fri, 24 Oct 2025 09:10:21 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2259E2FA0CC;
	Fri, 24 Oct 2025 09:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297020; cv=none; b=S08GRQST/qtaZvnQe+4qgNIpXB1UGdUU1IZFKUvOATpanHY324k63Wx32XgFiMS4Me67hF/kX8IS+uzNcv56PAVtHa5SrQHMfRYqsjkWalxOeHEDHTeWHlQwtEGEMwNqQcWlXQcToWsrXAf+wfDCIycbnlnINpbBzfFivQ56s2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297020; c=relaxed/simple;
	bh=wjF2RxGPPD5WQjfzijEJkTv2SShQyxnXYGmHOj1sukM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qe9WgAZl191vdd2XvkWeL5sHxD8SuLz2yuikNQhUIOhFwaCYqazbR1o1YC/WwLN5Rdwly52wx89KfFE5/z+Q2qZ3Kvs26CffkKtD28FVgXVJKXpCaUsH4Ojxjt8RKD9B1skf4qq61NB1G1Fur6tdtl+RRlnZyQ88m2taMKUvNXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ctH6q5xC7z2Cgpb;
	Fri, 24 Oct 2025 17:05:23 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 0ABFD1800CE;
	Fri, 24 Oct 2025 17:10:16 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 24 Oct 2025 17:10:15 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 24 Oct
 2025 17:10:15 +0800
Message-ID: <e1d440bd-23c0-434c-a771-5c0907c5d3ab@huawei.com>
Date: Fri, 24 Oct 2025 17:10:14 +0800
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
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0jBqPLjK2v7A-8Qd6ERhwz47jP3YCiTHJhD8vAgRHVjcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/10/22 3:49, Rafael J. Wysocki 写道:
> On Mon, Sep 29, 2025 at 11:38 AM Huisong Li <lihuisong@huawei.com> wrote:
>> Driver will update power states when processor power states have been
>> changed. To prevent any other abnormal issues, here add the verification
>> for the result of getting power information, don't change power states
>> and one error log when get power information failed.
> But the old states may not be usable any more in that case.
Yes
>
> If you want to check the acpi_processor_get_power_info(), it should
> disable ACPi idle entirely on failures.
 From the modification of this patch, this cpuidle device will be 
disabled if the acpi_processor_get_power_info(）fails to get on this device.
And the cpuidle of the device will be disabled according to the 
definition of cpuidle_not_available().
We should not call disable_cpuidle() to disable cpuidle of all CPUs.
So the modification in this patch is enough, right?
>
>> Fixes: f427e5f1cf75 ("ACPI / processor: Get power info before updating the C-states")
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   drivers/acpi/processor_idle.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index b0d6b51ee363..92b231f5d514 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -1315,6 +1315,7 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
>>          int cpu;
>>          struct acpi_processor *_pr;
>>          struct cpuidle_device *dev;
>> +       int ret = 0;
>>
>>          if (disabled_by_idle_boot_param())
>>                  return 0;
>> @@ -1344,16 +1345,20 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
>>                  }
>>
>>                  /* Populate Updated C-state information */
>> -               acpi_processor_get_power_info(pr);
>> -               acpi_processor_setup_cpuidle_states(pr);
>> +               ret = acpi_processor_get_power_info(pr);
>> +               if (ret)
>> +                       pr_err("Get processor-%u power information failed.\n",
>> +                              pr->id);
>> +               else
>> +                       acpi_processor_setup_cpuidle_states(pr);
>>
>>                  /* Enable all cpuidle devices */
>>                  for_each_online_cpu(cpu) {
>>                          _pr = per_cpu(processors, cpu);
>>                          if (!_pr || !_pr->flags.power_setup_done)
>>                                  continue;
>> -                       acpi_processor_get_power_info(_pr);
>> -                       if (_pr->flags.power) {
>> +                       ret = acpi_processor_get_power_info(_pr);
>> +                       if (!ret && _pr->flags.power) {
>>                                  dev = per_cpu(acpi_cpuidle_device, cpu);
>>                                  acpi_processor_setup_cpuidle_dev(_pr, dev);
>>                                  cpuidle_enable_device(dev);
>> @@ -1363,7 +1368,7 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
>>                  cpus_read_unlock();
>>          }
>>
>> -       return 0;
>> +       return ret;
>>   }
>>
>>   void acpi_processor_register_idle_driver(void)
>> --
>> 2.33.0
>>

