Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C040345904
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jun 2019 11:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfFNJm5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Jun 2019 05:42:57 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:55689 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726083AbfFNJm5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Jun 2019 05:42:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TU8i6m3_1560505372;
Received: from 30.5.116.80(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0TU8i6m3_1560505372)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 14 Jun 2019 17:42:52 +0800
Subject: Re: [PATCH] ACPI / APEI: release resources if gen_pool_add fails
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
References: <1560478845-19818-1-git-send-email-zhangliguang@linux.alibaba.com>
 <CAJZ5v0hsrbG0Cp6NY+45NEYCnjjibAvtD36fHEdBoTSRTspvAA@mail.gmail.com>
From:   =?UTF-8?B?5Lmx55+z?= <zhangliguang@linux.alibaba.com>
Message-ID: <3c17864a-8d6c-e680-1ec3-6245d4d7ceb4@linux.alibaba.com>
Date:   Fri, 14 Jun 2019 17:42:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hsrbG0Cp6NY+45NEYCnjjibAvtD36fHEdBoTSRTspvAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


在 2019/6/14 17:27, Rafael J. Wysocki 写道:
> On Fri, Jun 14, 2019 at 4:20 AM luanshi <zhangliguang@linux.alibaba.com> wrote:
>> If gen_pool_add fails, then ensure that ghes_estatus_pool and vmalloc
>> resources are released to avoid memory leak.
> The patch does more than this, it also destroys ghes_estatus_pool if
> vmalloc() fails.
>
> What about using this changelog:
>
> "To avoid memory leaks, destroy ghes_estatus_pool and release memory
> allocated via vmalloc() on errors in ghes_estatus_pool_init()."

Thanks,

I will modify the changelog by your suggestion, and resend this patch.


Thanks,

Liguang

>
>> Signed-off-by: liguang.zlg <zhangliguang@linux.alibaba.com>
>> ---
>>   drivers/acpi/apei/ghes.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 993940d..8472c96 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -153,6 +153,7 @@ static void ghes_unmap(void __iomem *vaddr, enum fixed_addresses fixmap_idx)
>>   int ghes_estatus_pool_init(int num_ghes)
>>   {
>>          unsigned long addr, len;
>> +       int rc = 0;
>>
>>          ghes_estatus_pool = gen_pool_create(GHES_ESTATUS_POOL_MIN_ALLOC_ORDER, -1);
>>          if (!ghes_estatus_pool)
>> @@ -163,8 +164,10 @@ int ghes_estatus_pool_init(int num_ghes)
>>
>>          ghes_estatus_pool_size_request = PAGE_ALIGN(len);
>>          addr = (unsigned long)vmalloc(PAGE_ALIGN(len));
>> -       if (!addr)
>> +       if (!addr) {
>> +               gen_pool_destroy(ghes_estatus_pool);
>>                  return -ENOMEM;
>> +       }
>>
>>          /*
>>           * New allocation must be visible in all pgd before it can be found by
>> @@ -172,7 +175,12 @@ int ghes_estatus_pool_init(int num_ghes)
>>           */
>>          vmalloc_sync_all();
>>
>> -       return gen_pool_add(ghes_estatus_pool, addr, PAGE_ALIGN(len), -1);
>> +       rc = gen_pool_add(ghes_estatus_pool, addr, PAGE_ALIGN(len), -1);
>> +       if (rc) {
>> +               vfree(addr);
>> +               gen_pool_destroy(ghes_estatus_pool);
>> +       }
>> +       return rc;
>>   }
>>
>>   static int map_gen_v2(struct ghes *ghes)
>> --
>> 1.8.3.1
>>
