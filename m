Return-Path: <linux-acpi+bounces-10769-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AB1A175F2
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jan 2025 03:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0712164F0D
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jan 2025 02:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D956148FE6;
	Tue, 21 Jan 2025 02:23:23 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5A118E3F;
	Tue, 21 Jan 2025 02:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737426203; cv=none; b=Sr/hQ7pFzhp/PlC7zxxaSga5sIf7k7GnHv89UJnQxXUis8QLXyyZLm1xnF4VhmSRlwVIfu52zBLXVUOL0LctMPmPB/YvITEhqgw23jHRWCJ0LAI3x1Iqickyw/LgVQqno7EKqoA1ClnTrjDkMOpBerqgHC1D85uDRyXi5scsdos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737426203; c=relaxed/simple;
	bh=kz5Do6XJrFCQearnTl5tQ8n54TVUvvZQxRcywGTaE68=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LWrfxymwU1CMfPgEIlt2qTSeBKIsBPrEAzFiDW6kBymNFrraKtrYKWXVc5Fr+utLJIWplHqzlhML0g8kB81dho1hPzR1TFIDnasLB4C1I7xBG4yfIjOuax33mrkdzdddwUO56S5T0ya/Hjq77VqKtkMaIuu8eRIB2BNVfbNrveM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YcWDM2YMdzXp8p;
	Tue, 21 Jan 2025 10:21:39 +0800 (CST)
Received: from dggpemf200009.china.huawei.com (unknown [7.185.36.246])
	by mail.maildlp.com (Postfix) with ESMTPS id 776DD180105;
	Tue, 21 Jan 2025 10:23:18 +0800 (CST)
Received: from [10.67.121.188] (10.67.121.188) by
 dggpemf200009.china.huawei.com (7.185.36.246) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jan 2025 10:23:18 +0800
Message-ID: <58a450bb-55d1-5415-4b67-9d61603ce48e@huawei.com>
Date: Tue, 21 Jan 2025 10:23:17 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3] acpi: Fix HED module initialization order when it is
 built-in
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mchehab+huawei@kernel.org>,
	<roberto.sassu@huawei.com>, <shiju.jose@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
References: <20250117022957.25227-1-tanxiaofei@huawei.com>
 <20250120110417.00000a57@huawei.com>
From: Xiaofei Tan <tanxiaofei@huawei.com>
In-Reply-To: <20250120110417.00000a57@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200009.china.huawei.com (7.185.36.246)


在 2025/1/20 19:04, Jonathan Cameron 写道:
> On Fri, 17 Jan 2025 10:29:57 +0800
> Xiaofei Tan <tanxiaofei@huawei.com> wrote:
>
>> When the module HED is built-in, the module HED init is behind EVGED
>> as the driver are in the same initcall level, then the order is determined
>> by Makefile order. That order violates expectations. Because RAS records
>> can't be handled in the special time window that EVGED has initialized
>> while HED not.
>>
>> If the number of such RAS records is more than the APEI HEST error source
>> number, the HEST resources could be occupied all, and then could affect
>> subsequent RAS error reporting.
>>
>> Change the initcall level of HED to subsys_init to fix the issue. If build
>> HED as a module, the problem remains. To solve this problem completely,
>> change the ACPI_HED from tristate to bool.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Given the change in approach (even though I reviewed this internally)
> should probably have dropped my RB.   Anyhow, consider this me
> giving it again on list.
OK. thanks.
> Thanks,
>
> Jonathan
>
>> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
>> ---
>>   drivers/acpi/Kconfig | 2 +-
>>   drivers/acpi/hed.c   | 1 +
>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index d81b55f5068c..7f10aa38269d 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -452,7 +452,7 @@ config ACPI_SBS
>>   	  the modules will be called sbs and sbshc.
>>   
>>   config ACPI_HED
>> -	tristate "Hardware Error Device"
>> +	bool "Hardware Error Device"
>>   	help
>>   	  This driver supports the Hardware Error Device (PNP0C33),
>>   	  which is used to report some hardware errors notified via
>> diff --git a/drivers/acpi/hed.c b/drivers/acpi/hed.c
>> index 7652515a6be1..677dfcce2990 100644
>> --- a/drivers/acpi/hed.c
>> +++ b/drivers/acpi/hed.c
>> @@ -81,6 +81,7 @@ static struct acpi_driver acpi_hed_driver = {
>>   	},
>>   };
>>   module_acpi_driver(acpi_hed_driver);
>> +subsys_initcall(acpi_hed_driver_init);
>>   
>>   MODULE_AUTHOR("Huang Ying");
>>   MODULE_DESCRIPTION("ACPI Hardware Error Device Driver");
> .

