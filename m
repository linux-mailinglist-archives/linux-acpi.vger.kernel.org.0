Return-Path: <linux-acpi+bounces-6397-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5A5908050
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jun 2024 02:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED3B1F2285C
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jun 2024 00:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7699217D2;
	Fri, 14 Jun 2024 00:54:52 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CAC1C27;
	Fri, 14 Jun 2024 00:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718326492; cv=none; b=RCQkzV0H3G8cm1vRWkyatTS1fSvul+mk5c2PD6riU0xqX6no6TEVDFcJBkXusSWXa+A1QHJpNmSxkfsr6vC1/8JtPI0JOSAyfStIbXilhC49ylgLQLiHhSGpnh3cnYmemDU7Le3ZPHGOCvpSiwSzT0LU91+1dwzg4nnMwh9cVWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718326492; c=relaxed/simple;
	bh=vqYf6YTMrYPXIZv+rpZeQD4CeKk3G+SZAYDkZ+fh1Gk=;
	h=Subject:From:To:CC:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=X6qcq4WZ9cxlJoBVJF3efZspNaMnj4odrEI9bb+7uBDXw1nPzIAQXlJaqNm4DhrNiY/ptxskVVKK6XVczex54KzAcev38gKuQdnL4MWtSUp1UEGFIBXcTNXxwkngAJaQi+fCGRGb/yh/cv117NhBoYAhrj48XYam6HNsv/sSrCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4W0ggb3zMLz1X3Rk;
	Fri, 14 Jun 2024 08:50:51 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id DC30B1402E2;
	Fri, 14 Jun 2024 08:54:40 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Jun 2024 08:54:40 +0800
Subject: Re: [PATCH v1 1/1] ACPI/IORT: Switch to use kmemdup_array()
From: Hanjun Guo <guohanjun@huawei.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, Sudeep Holla
	<sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>
References: <20240606165005.3031490-1-andriy.shevchenko@linux.intel.com>
 <3a1e0ffe-db11-d18f-db33-881df7d9b18d@huawei.com>
Message-ID: <2edd3b72-24a4-8b19-8738-cc82dc4fae6c@huawei.com>
Date: Fri, 14 Jun 2024 08:54:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3a1e0ffe-db11-d18f-db33-881df7d9b18d@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf500002.china.huawei.com (7.185.36.57)

+Cc Catalin

On 2024/6/11 18:42, Hanjun Guo wrote:
> On 2024/6/7 0:50, Andy Shevchenko wrote:
>> Let the kememdup_array() take care about multiplication and possible
>> overflows.
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>   drivers/acpi/arm64/iort.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index c0b1c2c19444..e596dff20f1e 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -822,7 +822,7 @@ static struct iommu_iort_rmr_data *iort_rmr_alloc(
>>           return NULL;
>>       /* Create a copy of SIDs array to associate with this rmr_data */
>> -    sids_copy = kmemdup(sids, num_sids * sizeof(*sids), GFP_KERNEL);
>> +    sids_copy = kmemdup_array(sids, num_sids, sizeof(*sids), 
>> GFP_KERNEL);
>>       if (!sids_copy) {
>>           kfree(rmr_data);
>>           return NULL;
> 
> Looks good to me,
> 
> Acked-by: Hanjun Guo <guohanjun@huawei.com>

Catalin, would you mind pick this up as well?

Thanks
Hanjun

