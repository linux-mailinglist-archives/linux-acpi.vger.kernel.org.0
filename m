Return-Path: <linux-acpi+bounces-7086-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD6893DD95
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Jul 2024 08:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0751BB20EFA
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Jul 2024 06:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAE01946F;
	Sat, 27 Jul 2024 06:52:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87E41B86F7
	for <linux-acpi@vger.kernel.org>; Sat, 27 Jul 2024 06:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722063130; cv=none; b=kB69gVf8o9cU4D7eUDTvFjBL0Egwk1ZhJ6VHFFfdPCt5m8aeiF/ErUupRDkj0bMOE3N968/7t9ztssEomD/dbLJqZP5NYo7zUks7V69wkwHJfeEZ/YaZFIqTbRBzk2o2xAZchzNN1xoaeUDZ37RWsaadwSN4uXBIXMVbTh2rO9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722063130; c=relaxed/simple;
	bh=V3qJlemTXvwPUqbUJS+K3oUUNd0aQ51wJw67ejNFsdE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tlOOy7zppWtGcTgH6Giy3Ea7t5zzfPuCbjOzPlw/m628bWl6O0US39Xdvm8YjHRhWBy5Hg4U67VlPFu6LfwrHLtg1jsIY5qkfhIjoLEFcUTsOrfN+fDxfdKB8RKpSzKaZnQckXxhEqvh28ll5jACmez0wwDXzfPchHL1V1KHV5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WWFdV05k4znbTc;
	Sat, 27 Jul 2024 14:51:10 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 22BC81800A1;
	Sat, 27 Jul 2024 14:52:03 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 27 Jul 2024 14:52:02 +0800
Subject: Re: [PATCH] ACPI: rename acpi_arm_init to acpi_arch_init
To: Miao Wang <shankerwangmiao@gmail.com>, Sunil V L
	<sunilvl@ventanamicro.com>
CC: Sudeep Holla <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>
References: <446b96d0-4b61-11ef-9239-3f7ac1938848@innull.com>
 <ZqPJLtGZQfxrIxhf@bogus> <DCBB5DD3-C6FD-4CE6-8C21-C4E218BD666E@gmail.com>
 <ZqPjJy5YCuF02XNI@sunil-laptop>
 <1A59AB2E-58A6-4D9F-9976-DABFAA825EE0@gmail.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <cff8c915-2978-085a-dfcd-dc117fd2f909@huawei.com>
Date: Sat, 27 Jul 2024 14:52:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1A59AB2E-58A6-4D9F-9976-DABFAA825EE0@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2024/7/27 2:23, Miao Wang wrote:
> 
>> 2024年7月27日 01:55，Sunil V L <sunilvl@ventanamicro.com> 写道：
>>
>> On Sat, Jul 27, 2024 at 12:39:03AM +0800, Miao Wang wrote:
>>> Hi,
>>>
>>> Thanks for your quick reply.
>>>
>>>> 2024年7月27日 00:05，Sudeep Holla <sudeep.holla@arm.com> 写道：
>>>>
>>>> On Fri, Jul 26, 2024 at 11:03:01PM +0800, Miao Wang via B4 Relay wrote:
[...]
>>>>>
>>>>> -#ifdef CONFIG_ARM64
>>>>> -void acpi_arm_init(void);
>>>>> +#ifdef ACPI_HAVE_ARCH_INIT
>>>>> +void acpi_arch_init(void);
>>>>
>>>> This is bit inconsistent. The Makefile is still conditional on
>>>> CONFIG_ARM64 while here you move to ACPI_HAVE_ARCH_INIT.
>>>> So while not just undefine and redefine acpi_arch_init to acpi_arm_init.
>>>> Something like this must work ?
>>>>
>>>> #define acpi_arch_init() do { }while(0)
>>>>
>>>> #ifdef CONFIG_ARM64
>>>> #undef acpi_arch_init
>>>> #define acpi_arch_init() acpi_arm_init()
>>>> #endif
>>>
>>> It will work. However I can see the pattern in other parts, where
>>> the definition of a macro named HAVE_xxx is checked, and define an
>>> inline static function with empty body if such macro is not defined
>>> or define a function prototype with the same name otherwise, like
>>> acpi_arch_set_root_pointer. I'm just trying to follow this pattern.
>>>
>> I was thinking to make it weak function similar to cpc_read_ffh().
>> Wouldn't it be better than ifdefery?
> 
> I believe there would be performance loss for those arches with a stub
> function definition if a weak function is used (correct me if wrong).
> So the approach with a static inline stub is more common in the kernel
> code.

ACPI init is not in the hot code path, no worries for the performance
loss.

Weak function is my preference too :)

Thanks
Hanjun

