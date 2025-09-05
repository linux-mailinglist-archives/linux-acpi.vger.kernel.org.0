Return-Path: <linux-acpi+bounces-16386-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093FDB44DED
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 08:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEB055411BE
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 06:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA22290DBB;
	Fri,  5 Sep 2025 06:27:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1788F163;
	Fri,  5 Sep 2025 06:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757053636; cv=none; b=KiBQqVCACYHR1l3hkncRAKOpUzC4tBzIEdSIpry7I5RZoq9Um5AEFgzgTz0on+oSVA68J6gS3nxSvxVjAKP0759XmNVRn7Q0JAGgskpxGSJsYcHresHZx1WWLK8MC32axJax0Ms9eSuAngsfY8LbGETbzNX2hx12GcBUhpv+uAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757053636; c=relaxed/simple;
	bh=7w1Yet6hnKBxdNwWochFne/nzXMHR8jZPRWb11jtOME=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NReXcAgzmn2VXaNDU/Wbc5gRUzX5Iu7OWftUflBVii24AZoeOulVIoJF+Wew3rk8Mmxn90k7BU1nVsdyIiH2KCI6pYw4vzf8Mqn/TWUFruHkr+EsUvkhYcmB06D//K7SCUkPLz95pGHf6bnRloKasZCDsUP2tbkFUTmTJz0p38w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cJ5qg6Ck4zPtNb;
	Fri,  5 Sep 2025 14:22:39 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 0509818049F;
	Fri,  5 Sep 2025 14:27:10 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Sep 2025 14:27:02 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 5 Sep
 2025 14:27:02 +0800
Message-ID: <6b384169-9ad5-4689-8533-f6196d39cf4b@huawei.com>
Date: Fri, 5 Sep 2025 14:27:01 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: processor: Fix function defined but not used
 warning
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <yubowen8@huawei.com>
References: <20250904121131.2610989-1-lihuisong@huawei.com>
 <CAJZ5v0jewY9X5rTQmgsgbpjzy=2bzMPTSV60g9kMkXOcKcS_Ng@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0jewY9X5rTQmgsgbpjzy=2bzMPTSV60g9kMkXOcKcS_Ng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/9/4 23:23, Rafael J. Wysocki 写道:
> On Thu, Sep 4, 2025 at 2:11 PM Huisong Li <lihuisong@huawei.com> wrote:
>> If CONFIG_ACPI_PROCESSOR=n and CONFIG_ACPI_PROCESSOR_IDLE=n, we may
>> encounter some compling warnings as the following link said.
>> So remove these empty function definition because they are just used
>> in processor_driver.c and if CONFIG_ACPI_PROCESSOR is selected and
>> CONFIG_ACPI_PROCESSOR_IDLE also be selected automatically.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202508300519.tZQHY6HA-lkp@intel.com/
>>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   include/acpi/processor.h | 34 +++-------------------------------
>>   1 file changed, 3 insertions(+), 31 deletions(-)
>>
>> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
>> index 360b673f05e5..a4e1081fd0da 100644
>> --- a/include/acpi/processor.h
>> +++ b/include/acpi/processor.h
>> @@ -417,40 +417,17 @@ static inline void acpi_processor_throttling_init(void) {}
>>   #endif /* CONFIG_ACPI_CPU_FREQ_PSS */
>>
>>   /* in processor_idle.c */
>> -extern struct cpuidle_driver acpi_idle_driver;
>>   #ifdef CONFIG_ACPI_PROCESSOR_IDLE
>> +extern struct cpuidle_driver acpi_idle_driver;
> Are the changes above related to the warning?  If not, maybe move them
> to a separate patch?
Ok, will do it in a separate patch.
>
>>   int acpi_processor_power_init(struct acpi_processor *pr);
>>   int acpi_processor_power_exit(struct acpi_processor *pr);
>>   int acpi_processor_power_state_has_changed(struct acpi_processor *pr);
>>   int acpi_processor_hotplug(struct acpi_processor *pr);
>>   void acpi_processor_register_idle_driver(void);
>>   void acpi_processor_unregister_idle_driver(void);
>> -#else
>> -static inline int acpi_processor_power_init(struct acpi_processor *pr)
>> -{
>> -       return -ENODEV;
>> -}
>> -
>> -static inline int acpi_processor_power_exit(struct acpi_processor *pr)
>> -{
>> -       return -ENODEV;
>> -}
>> -
>> -static inline int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
>> -{
>> -       return -ENODEV;
>> -}
>>
>> -static inline int acpi_processor_hotplug(struct acpi_processor *pr)
>> -{
>> -       return -ENODEV;
>> -}
>> -static inline void acpi_processor_register_idle_driver(void)
>> -{
>> -}
>> -static inline void acpi_processor_unregister_idle_driver(void)
>> -{
>> -}
>> +extern int acpi_processor_ffh_lpi_probe(unsigned int cpu);
>> +extern int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi);
> Please remove the "extern" from these declarations.
Ack
>
>>   #endif /* CONFIG_ACPI_PROCESSOR_IDLE */
>>
>>   /* in processor_thermal.c */
>> @@ -473,11 +450,6 @@ static inline void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy)
>>   }
>>   #endif /* CONFIG_CPU_FREQ */
>>
>> -#ifdef CONFIG_ACPI_PROCESSOR_IDLE
>> -extern int acpi_processor_ffh_lpi_probe(unsigned int cpu);
>> -extern int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi);
>> -#endif
>> -
>>   void acpi_processor_init_invariance_cppc(void);
>>
>>   #endif
>> --

