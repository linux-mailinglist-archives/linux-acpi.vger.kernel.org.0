Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E86F146D53
	for <lists+linux-acpi@lfdr.de>; Sat, 15 Jun 2019 02:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbfFOAzO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Jun 2019 20:55:14 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:41564 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725809AbfFOAzN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Jun 2019 20:55:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TUC3mSH_1560560109;
Received: from 30.39.137.53(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0TUC3mSH_1560560109)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 15 Jun 2019 08:55:10 +0800
Subject: Re: [PATCH] ACPI / APEI: release resources if gen_pool_add fails
To:     James Morse <james.morse@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
References: <1560505783-130606-1-git-send-email-zhangliguang@linux.alibaba.com>
 <fbd31c48-e1e0-55a5-b341-46d25b2c2001@arm.com>
From:   =?UTF-8?B?5Lmx55+z?= <zhangliguang@linux.alibaba.com>
Message-ID: <0e774ff0-bf7b-808c-d403-c71588f7c3c2@linux.alibaba.com>
Date:   Sat, 15 Jun 2019 08:55:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <fbd31c48-e1e0-55a5-b341-46d25b2c2001@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


在 2019/6/14 22:51, James Morse 写道:
> Hi Liguang,
>
> On 14/06/2019 10:49, luanshi wrote:
>> To avoid memory leaks, destroy ghes_estatus_pool and release memory
>> allocated via vmalloc() on errors in ghes_estatus_pool_init().
>>
>> Signed-off-by: liguang.zlg <zhangliguang@linux.alibaba.com>
> (I'm surprised your name has a '.' in it!)
>
> Nit: This is v2. Please add a version number in the subject, e.g.:
> | [PATCH v2] ACPI / APEI: release resources if gen_pool_add fails
>
> This makes it easy for reviewers to know which is the latest. git format-patch will do
> this for you if you add '-v 2' to its command-line.
>
>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 993940d..8472c96 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
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
>> +		vfree(addr);
> addr here is unsigned long, but vfree() wants a void *.
>
> vfree() first leaves us with a pool containing memory we've vfree()d, which doesn't feel
> like a good state to step through.
> Can we vfree() after gen_pool_destroy()?

Hi James,

  I will modify this patch by your suggestion and send the patch v3 for 
review.

Thanks,

Liguang


>
>
>> +		gen_pool_destroy(ghes_estatus_pool);
>> +	}
>> +	return rc;
>>   }
>
> With that:
> Reviewed-by: James Morse <james.morse@arm.com>
> Tested-by: James Morse <james.morse@arm.com>
>
>
> Thanks for cleaning this up!
>
> James
