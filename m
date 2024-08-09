Return-Path: <linux-acpi+bounces-7462-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C95BA94D0FE
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 15:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80DBA1F21B59
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 13:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2992218C93F;
	Fri,  9 Aug 2024 13:16:55 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD4A2F37;
	Fri,  9 Aug 2024 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209415; cv=none; b=n9dhTcHvASCnCu0UBEdd5/xqTFipGxkfPMlEcDbI/coetBR/8B31RJOVjIGuvTw7wm4u04Pl/iMXge2RPC/pzgFj8jdwByLHER382/b/WIm67K04ODXCFcQ+BMqVS5impzYowtSeA2Kxxq3RMRQGmcZf6fCSiXrtGhP//re+Vjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209415; c=relaxed/simple;
	bh=stRr/ELDXNp234twU4cggytXPYhZO+angZXt2yhKMIQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=X+p42QT6ClhHQc3furmHwpgXYz+v8wIqrkiKj7S54EaK2qsszSRUTNm5X0+7rkCOKkApJBhTQ19jeSbFlZ1yPdh0JbN/XGOhWI0dTn/mHBgC5u8DbLfYcWFnYK41DEhiL0Y2YRP3st4FZMkxNriq2o/9BU6bU7IfJleiS7CEkxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WgPVy5LVwz20lH6;
	Fri,  9 Aug 2024 21:13:46 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id B881F18002B;
	Fri,  9 Aug 2024 21:16:45 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 9 Aug 2024 21:16:45 +0800
Subject: Re: [PATCH v1 1/1] ACPI/IORT: Switch to use kmemdup_array()
To: Catalin Marinas <catalin.marinas@arm.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Will Deacon <will@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
References: <20240606165005.3031490-1-andriy.shevchenko@linux.intel.com>
 <3a1e0ffe-db11-d18f-db33-881df7d9b18d@huawei.com>
 <2edd3b72-24a4-8b19-8738-cc82dc4fae6c@huawei.com>
 <ZrYIosRuNG9S-SqM@smile.fi.intel.com> <ZrYRIPYv8euBkStd@arm.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <c00c6b13-9048-ead1-0535-f8c9e8fab240@huawei.com>
Date: Fri, 9 Aug 2024 21:16:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZrYRIPYv8euBkStd@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2024/8/9 20:52, Catalin Marinas wrote:
> On Fri, Aug 09, 2024 at 03:16:34PM +0300, Andy Shevchenko wrote:
>> On Fri, Jun 14, 2024 at 08:54:39AM +0800, Hanjun Guo wrote:
>>> +Cc Catalin
>>>
>>> On 2024/6/11 18:42, Hanjun Guo wrote:
>>>> On 2024/6/7 0:50, Andy Shevchenko wrote:
>>>>> Let the kememdup_array() take care about multiplication and possible
>>>>> overflows.
>>>>>
>>>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>>> ---
>>>>>    drivers/acpi/arm64/iort.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>>>>> index c0b1c2c19444..e596dff20f1e 100644
>>>>> --- a/drivers/acpi/arm64/iort.c
>>>>> +++ b/drivers/acpi/arm64/iort.c
>>>>> @@ -822,7 +822,7 @@ static struct iommu_iort_rmr_data *iort_rmr_alloc(
>>>>>            return NULL;
>>>>>        /* Create a copy of SIDs array to associate with this rmr_data */
>>>>> -    sids_copy = kmemdup(sids, num_sids * sizeof(*sids), GFP_KERNEL);
>>>>> +    sids_copy = kmemdup_array(sids, num_sids, sizeof(*sids),
>>>>> GFP_KERNEL);
>>>>>        if (!sids_copy) {
>>>>>            kfree(rmr_data);
>>>>>            return NULL;
>>>>
>>>> Looks good to me,
>>>>
>>>> Acked-by: Hanjun Guo <guohanjun@huawei.com>
>>>
>>> Catalin, would you mind pick this up as well?
>>
>> Any news?
>>
>> I do not see this even in Linux Next...
> 
> Ah, sorry, I missed this. Since it doesn't look like a fix, I guess it's
> fine to go in 6.12. Adding Will since he's handling the upcoming merging
> window.

Sorry, I sent another email almost at the same time, so missed this one.

Thanks
Hanjun

