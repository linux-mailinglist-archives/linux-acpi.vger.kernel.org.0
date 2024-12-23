Return-Path: <linux-acpi+bounces-10280-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C14049FAC7F
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2024 10:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455B5166F19
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2024 09:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8BE199EA2;
	Mon, 23 Dec 2024 09:44:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EF0194A44;
	Mon, 23 Dec 2024 09:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947096; cv=none; b=NXYqcs/uFQYzHTspGKBCQsxDK9/hKiaL9ZtnxlruL9+t+yZydYSq41okpMOWM7l79cyt5DW1Dchlh457FjqehWO74RoFIqgE4HFJQlJip6XMAw4lLsIF5eSkNJcyjckKJDiNgDnAc/S+gpzmGFG51D1kRU5F3nVGSW4Pgu7F/fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947096; c=relaxed/simple;
	bh=g3BcAZHnvqSJh1oVj6nSOImOEf7CM/3Jq0GFiTLceok=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Vc59Jhm2nQTnMUwOXpOGN2fRIsCugVy8exBzWGvH9qPL8lFUeOwW/aR8eP9a0KPEE1+cPTGbK/cdadZZf3JntK3kDoKZD+8KSFwv41Gwmm4Dnm9uJZmomF94IrX798DTAt9znVRRvfIIFxWkVlgGuGa/q+b7k3EHkj3cPr5+YjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YGtNz6WWbzrRsR;
	Mon, 23 Dec 2024 17:42:59 +0800 (CST)
Received: from dggpemf200009.china.huawei.com (unknown [7.185.36.246])
	by mail.maildlp.com (Postfix) with ESMTPS id B74F7140120;
	Mon, 23 Dec 2024 17:44:44 +0800 (CST)
Received: from [10.67.121.188] (10.67.121.188) by
 dggpemf200009.china.huawei.com (7.185.36.246) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Dec 2024 17:44:44 +0800
Message-ID: <6916864a-f2cc-f484-180f-a0edd2149fc5@huawei.com>
Date: Mon, 23 Dec 2024 17:44:44 +0800
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
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jonathan.cameron@huawei.com>,
	<M.Chehab@huawei.com>, <roberto.sassu@huawei.com>, <shiju.jose@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
References: <20241115035014.1339256-1-tanxiaofei@huawei.com>
 <20241211172207.513957e2@sal.lan>
From: Xiaofei Tan <tanxiaofei@huawei.com>
In-Reply-To: <20241211172207.513957e2@sal.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200009.china.huawei.com (7.185.36.246)

Hi Mauro,

在 2024/12/12 0:22, Mauro Carvalho Chehab 写道:
> Em Fri, 15 Nov 2024 11:50:14 +0800
> Xiaofei Tan <tanxiaofei@huawei.com> escreveu:
>
> Please always copy my @kernel.org address for upstream work.

OK

>> When the module hed is built-in, the init order is determined by
>> Makefile order. That order violates expectations. Because the module
>> hed init is behind evged. RAS records can't be handled in the
>> special time window that evged has initialized while hed not.
>> If the number of such RAS records is more than the APEI HEST error
>> source number, the HEST resources could be occupied all, and then
>> could affect subsequent RAS error reporting.
> IMO, it is a lot better to use a late init call. Please see:
> 	include/linux/init.h
>
> This would be done by, for instance, using late_initcall().
>
> Now, what we have is:
>
> 	acpi-y                          += evged.o
> 	obj-$(CONFIG_ACPI_HED)          += hed.o
>
> Where ACPI_HED being a tri-state.
>
> It sounds to me, that even, with your patch, if you build
> HED as a module, you'll still have a problem.
Yes, and it is also  affected by loading sequence of HED and GHES. Anyway, the risk remains.
>
> Shouldn't be ACPI_HED be changed from tristate to bool?

agree,

@Rafael

Hi Rafael, Please help check if we can do this change, thanks.


>
> Regards,
> Mauro
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
>>   obj-$(CONFIG_ACPI)		+= tables.o
>>   
>> +#
>> +# The hed.o needs to be in front of evged.o to avoid the problem that
>> +# RAS errors cannot be handled in the special time window of startup
>> +# phase that evged has initialized while hed not.
>> +#
>> +obj-$(CONFIG_ACPI_HED)		+= hed.o
>> +
>>   #
>>   # ACPI Core Subsystem (Interpreter)
>>   #
>> @@ -95,7 +102,6 @@ obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) += ioapic.o
>>   obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
>>   obj-$(CONFIG_ACPI_SBS)		+= sbshc.o
>>   obj-$(CONFIG_ACPI_SBS)		+= sbs.o
>> -obj-$(CONFIG_ACPI_HED)		+= hed.o
>>   obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
>>   obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
>>   obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
> .

