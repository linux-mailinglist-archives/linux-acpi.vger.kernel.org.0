Return-Path: <linux-acpi+bounces-7461-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2262C94D089
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 14:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54B321C20BFF
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 12:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD11F1922C7;
	Fri,  9 Aug 2024 12:52:58 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D244194ACD;
	Fri,  9 Aug 2024 12:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723207978; cv=none; b=sBs18O0eEBecqN2Y+X2YOj5fkwtPgyOp+G2IKL1kEBJGD2b7br9785SgFG7BZU7r4krsdUsNNPLIF3Ld2xVJQoHLc8Rr1jgzqXJd3CKBg5SermUaGd41nspfzM9BUdIcLaN2E5Q3qD3a6l8PYou3KI3OaFRXLVYl6gRV98dYbiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723207978; c=relaxed/simple;
	bh=6wudglhokyP4tC07JF/f7SMg6sNUVXnwZZ9LHwXpI7c=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Vq5nQHJWDEdPNTj+VOAau3ldm1QHd/5gkmbogwL6CEwTH/6C54dR4uyo5ebA0BLrZDKvlaFUqwZwKg8CSt7D89BtQwaAnHpf9OHgoo/vz/vV7vDpVqJtUN4UDppnrRw2XDmaRn8uWhL5wDuMV9jmebOSAp8u+yq3KtDUPDjdl68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WgP2P25n4zyP1p;
	Fri,  9 Aug 2024 20:52:29 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id D62F3140121;
	Fri,  9 Aug 2024 20:52:52 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 9 Aug 2024 20:52:52 +0800
Subject: Re: [PATCH v1 1/1] ACPI/IORT: Switch to use kmemdup_array()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>
References: <20240606165005.3031490-1-andriy.shevchenko@linux.intel.com>
 <3a1e0ffe-db11-d18f-db33-881df7d9b18d@huawei.com>
 <2edd3b72-24a4-8b19-8738-cc82dc4fae6c@huawei.com>
 <ZrYIosRuNG9S-SqM@smile.fi.intel.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <f689986c-a0b9-f54b-226f-798325c9968d@huawei.com>
Date: Fri, 9 Aug 2024 20:52:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZrYIosRuNG9S-SqM@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2024/8/9 20:16, Andy Shevchenko wrote:
> On Fri, Jun 14, 2024 at 08:54:39AM +0800, Hanjun Guo wrote:
>> +Cc Catalin
>>
>> On 2024/6/11 18:42, Hanjun Guo wrote:
>>> On 2024/6/7 0:50, Andy Shevchenko wrote:
>>>> Let the kememdup_array() take care about multiplication and possible
>>>> overflows.
>>>>
>>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>> ---
>>>>    drivers/acpi/arm64/iort.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>>>> index c0b1c2c19444..e596dff20f1e 100644
>>>> --- a/drivers/acpi/arm64/iort.c
>>>> +++ b/drivers/acpi/arm64/iort.c
>>>> @@ -822,7 +822,7 @@ static struct iommu_iort_rmr_data *iort_rmr_alloc(
>>>>            return NULL;
>>>>        /* Create a copy of SIDs array to associate with this rmr_data */
>>>> -    sids_copy = kmemdup(sids, num_sids * sizeof(*sids), GFP_KERNEL);
>>>> +    sids_copy = kmemdup_array(sids, num_sids, sizeof(*sids),
>>>> GFP_KERNEL);
>>>>        if (!sids_copy) {
>>>>            kfree(rmr_data);
>>>>            return NULL;
>>>
>>> Looks good to me,
>>>
>>> Acked-by: Hanjun Guo <guohanjun@huawei.com>
>>
>> Catalin, would you mind pick this up as well?
> 
> Any news?
> 
> I do not see this even in Linux Next...

Sudeep, Lorenzo, would you mind giving it a go?

Thanks
Hanjun

