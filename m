Return-Path: <linux-acpi+bounces-10724-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC41FA13C68
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 15:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00229165A53
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 14:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B041DE8AC;
	Thu, 16 Jan 2025 14:36:58 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A752022AE49;
	Thu, 16 Jan 2025 14:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038218; cv=none; b=OUVOFCU9D7sfyyoUFbMwoRW55VKCzGKsJshSEqlEe6CB1EjopO96eg1CjwN0D4S4FAsZlZ7f4sEVKdg7M53yFPI1B5NmhnzsHAEOyoME31NS++TEYPu02fXqCjZmk22NIFdDVNDrSEPLoUMjugZ4e1b4amiggpv8na83InIFpnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038218; c=relaxed/simple;
	bh=Ox9aS8jYvRZa+UKv9FrPv180KZtV06NED7LM9JbJMF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Uw3hg2Q9KIbYJ2ofQVuV0c9QcR5P/Tr+Do1/JqeVtoLZZvW7KklXrWGTQeQ78TrILZVwnXpNGjtKJul3JxXxL8Zyw5bFa3f/FuA2/PII/9kwqd6SrC7+kpC/DxVXehFIRNiPkHFSS04np3T9WpxwkgPrUcbv+cIQU3thAjk5dK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YYlhX4Wq5z1W3V0;
	Thu, 16 Jan 2025 22:33:00 +0800 (CST)
Received: from dggpemf200009.china.huawei.com (unknown [7.185.36.246])
	by mail.maildlp.com (Postfix) with ESMTPS id F01E51401E9;
	Thu, 16 Jan 2025 22:36:52 +0800 (CST)
Received: from [10.67.121.188] (10.67.121.188) by
 dggpemf200009.china.huawei.com (7.185.36.246) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Jan 2025 22:36:52 +0800
Message-ID: <2f2e91d0-b4b4-8eb1-8d9c-0020654dedff@huawei.com>
Date: Thu, 16 Jan 2025 22:36:52 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] acpi: Fix HED module initialization order when it is
 built-in
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jonathan.cameron@huawei.com>,
	<mchehab+huawei@kernel.org>, <roberto.sassu@huawei.com>,
	<shiju.jose@huawei.com>, <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
References: <20250115123149.3324733-1-tanxiaofei@huawei.com>
 <CAJZ5v0gWPkmvpPGMO5fbXfrOcAgofML+WQE54cwiwDbaK6vfZw@mail.gmail.com>
From: Xiaofei Tan <tanxiaofei@huawei.com>
In-Reply-To: <CAJZ5v0gWPkmvpPGMO5fbXfrOcAgofML+WQE54cwiwDbaK6vfZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200009.china.huawei.com (7.185.36.246)


在 2025/1/15 23:51, Rafael J. Wysocki 写道:
> On Wed, Jan 15, 2025 at 1:38 PM Xiaofei Tan <tanxiaofei@huawei.com> wrote:
>> When the module HED is built-in, the init order is determined by
>> Makefile order. That order violates expectations. Because the module
>> HED init is behind evged. RAS records can't be handled in the
>> special time window that evged has initialized while HED not.
>> If the number of such RAS records is more than the APEI HEST error
>> source number, the HEST resources could be occupied all, and then
>> could affect subsequent RAS error reporting.
>>
>> If build HED as a module, the problem remains. To solve this problem
>> completely, change the ACPI_HED from tristate to bool.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
>> ---
>>   drivers/acpi/Kconfig  | 2 +-
>>   drivers/acpi/Makefile | 8 +++++++-
>>   2 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index d81b55f5068c..7f10aa38269d 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -452,7 +452,7 @@ config ACPI_SBS
>>            the modules will be called sbs and sbshc.
>>
>>   config ACPI_HED
>> -       tristate "Hardware Error Device"
>> +       bool "Hardware Error Device"
>>          help
>>            This driver supports the Hardware Error Device (PNP0C33),
>>            which is used to report some hardware errors notified via
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index 40208a0f5dfb..b50d1baeb71f 100644
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
> I'm not sure why you are insisting on this Makefile ordering change.
>
> It would be much more robust to run the hed driver init at a different
> initcall level than evged.
>
> If there is a problem with this approach, it needs to be mentioned in
> the changelog or in the comment above.

Hi Rafael，

The approach of changing the initcall level can work too.  Will send v3 patch later, thanks.


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
> .

