Return-Path: <linux-acpi+bounces-10279-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 431919FABFA
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2024 10:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB61F1885DA3
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2024 09:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC6E1925A3;
	Mon, 23 Dec 2024 09:31:14 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25AB27735;
	Mon, 23 Dec 2024 09:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734946274; cv=none; b=lhJ+cawpPESayKdTWO2Zrtw8eIs3pXXT3rlivvUSDtD1bHt0lGX9yQ2ka7Axkw09LLZcqVKHR/C4a0s/TA/50VJmH3fjHCO4Qo0R86Bww0D03FJEGY9JAB92BpRbQEriiNlWK7Yia4/86293rVJIPSghHfuKb7HnVFOJNiXJwHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734946274; c=relaxed/simple;
	bh=lbfHXijI9GqNcVWD9sh+H6H2dufK3msi15jf6VdTm5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T0f8PtCWK3X4QJ8mHzA7r+MAHQph/NAboPda3nqda01SPxYe9Tucq7NsXPkdCnpCF6gFow6JRDvUmyKj38gZvu4TxE8/TtEg62Y2KSSfcxVQiwdxAiQBuA6GtjCRuKRNQA+CV+s9NM87XT+aJoxrJSZVNwPRsBOBL6rt31W4t5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YGt3S1f2Kz1V73x;
	Mon, 23 Dec 2024 17:27:48 +0800 (CST)
Received: from dggpemf200009.china.huawei.com (unknown [7.185.36.246])
	by mail.maildlp.com (Postfix) with ESMTPS id 4BB1714035F;
	Mon, 23 Dec 2024 17:31:09 +0800 (CST)
Received: from [10.67.121.188] (10.67.121.188) by
 dggpemf200009.china.huawei.com (7.185.36.246) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Dec 2024 17:31:09 +0800
Message-ID: <dfa67fab-e9c1-baec-dd86-6c6ba79eabeb@huawei.com>
Date: Mon, 23 Dec 2024 17:31:08 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] acpi: Fix hed module initialization order when it is
 built-in
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jonathan.cameron@huawei.com>,
	<M.Chehab@huawei.com>, <roberto.sassu@huawei.com>, <shiju.jose@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
	<mchehab+huawei@kernel.org>
References: <20241115035014.1339256-1-tanxiaofei@huawei.com>
 <CAJZ5v0h4-cSFs+ED3ymJKHKkEAproXCtB2t3cP1wcyd6eq=Sgg@mail.gmail.com>
From: Xiaofei Tan <tanxiaofei@huawei.com>
In-Reply-To: <CAJZ5v0h4-cSFs+ED3ymJKHKkEAproXCtB2t3cP1wcyd6eq=Sgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200009.china.huawei.com (7.185.36.246)

Hi Rafael,

在 2024/12/11 1:59, Rafael J. Wysocki 写道:
> On Fri, Nov 15, 2024 at 4:56 AM Xiaofei Tan <tanxiaofei@huawei.com> wrote:
>> When the module hed is built-in, the init order is determined by
>> Makefile order.
> Are you sure?

yes

>> That order violates expectations. Because the module
>> hed init is behind evged. RAS records can't be handled in the
>> special time window that evged has initialized while hed not.
>> If the number of such RAS records is more than the APEI HEST error
>> source number, the HEST resources could be occupied all, and then
>> could affect subsequent RAS error reporting.
> Well, the problem is real, but does the change really prevent it from
> happening or does it just increase the likelihood of success?

It can be completely solved if the driver used as built-in way. If build HED as a
module, it not solved.

>
> In the latter case, and generally speaking too, it would be better to
> add explicit synchronization between evged and hed.
>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
>> ---
>>   drivers/acpi/Makefile | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index 61ca4afe83dc..54f60b7922ad 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -15,6 +15,13 @@ endif
>>
>>   obj-$(CONFIG_ACPI)             += tables.o
>>
>> +#
>> +# The hed.o needs to be in front of evged.o to avoid the problem that
>> +# RAS errors cannot be handled in the special time window of startup
>> +# phase that evged has initialized while hed not.
>> +#
>> +obj-$(CONFIG_ACPI_HED)         += hed.o
>> +
>>   #
>>   # ACPI Core Subsystem (Interpreter)
>>   #
>> @@ -95,7 +102,6 @@ obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) += ioapic.o
>>   obj-$(CONFIG_ACPI_BATTERY)     += battery.o
>>   obj-$(CONFIG_ACPI_SBS)         += sbshc.o
>>   obj-$(CONFIG_ACPI_SBS)         += sbs.o
>> -obj-$(CONFIG_ACPI_HED)         += hed.o
>>   obj-$(CONFIG_ACPI_EC_DEBUGFS)  += ec_sys.o
>>   obj-$(CONFIG_ACPI_BGRT)                += bgrt.o
>>   obj-$(CONFIG_ACPI_CPPC_LIB)    += cppc_acpi.o
>> --
>> 2.33.0
>>
> .

