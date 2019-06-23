Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 648EE4F994
	for <lists+linux-acpi@lfdr.de>; Sun, 23 Jun 2019 04:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfFWCsm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 22 Jun 2019 22:48:42 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:44920 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725844AbfFWCsl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 22 Jun 2019 22:48:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TUwRVeg_1561258117;
Received: from 30.38.59.190(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0TUwRVeg_1561258117)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 23 Jun 2019 10:48:38 +0800
Subject: Re: [PATCH v2] ACPI / APEI: release resources if gen_pool_add fails
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>
References: <1560734870-27742-1-git-send-email-zhangliguang@linux.alibaba.com>
 <20190621152951.GB19067@zn.tnic>
From:   =?UTF-8?B?5Lmx55+z?= <zhangliguang@linux.alibaba.com>
Message-ID: <f9d82879-07e9-1930-5f84-87c2f425b671@linux.alibaba.com>
Date:   Sun, 23 Jun 2019 10:48:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190621152951.GB19067@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Borislav,

在 2019/6/21 23:29, Borislav Petkov 写道:
> On Mon, Jun 17, 2019 at 09:27:50AM +0800, luanshi wrote:
>> To avoid memory leaks, destroy ghes_estatus_pool and release memory
>> allocated via vmalloc() on errors in ghes_estatus_pool_init().
>>
>> Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
>> Reviewed-by: James Morse <james.morse@arm.com>
>> Tested-by: James Morse <james.morse@arm.com>
>> ---
>>   drivers/acpi/apei/ghes.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 993940d..4e5de30 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -153,6 +153,7 @@ static void ghes_unmap(void __iomem *vaddr, enum fixed_addresses fixmap_idx)
>>   int ghes_estatus_pool_init(int num_ghes)
>>   {
>>   	unsigned long addr, len;
>> +	int rc = 0;
>>   
>>   	ghes_estatus_pool = gen_pool_create(GHES_ESTATUS_POOL_MIN_ALLOC_ORDER, -1);
>>   	if (!ghes_estatus_pool)
>> @@ -163,8 +164,10 @@ int ghes_estatus_pool_init(int num_ghes)
>>   
>>   	ghes_estatus_pool_size_request = PAGE_ALIGN(len);
>>   	addr = (unsigned long)vmalloc(PAGE_ALIGN(len));
>> -	if (!addr)
>> +	if (!addr) {
>> +		gen_pool_destroy(ghes_estatus_pool);
>>   		return -ENOMEM;
>> +	}
>>   
>>   	/*
>>   	 * New allocation must be visible in all pgd before it can be found by
>> @@ -172,7 +175,12 @@ int ghes_estatus_pool_init(int num_ghes)
>>   	 */
>>   	vmalloc_sync_all();
>>   
>> -	return gen_pool_add(ghes_estatus_pool, addr, PAGE_ALIGN(len), -1);
>> +	rc = gen_pool_add(ghes_estatus_pool, addr, PAGE_ALIGN(len), -1);
>> +	if (rc) {
>> +		gen_pool_destroy(ghes_estatus_pool);
>> +		vfree((void *)addr);
>> +	}
>> +	return rc;
> Please put the error path in labels at the end of the function to which
> you goto from each error case, like it is usually done in kernel code,
> instead of repeating the free calls in each error handling path.

Thanks, I will modify this patch by your suggestion and send the patch 
v3 for review.

Thanks,

Liguang

>
> Grep the tree for examples, if you need some.
>
> Thx.
>
