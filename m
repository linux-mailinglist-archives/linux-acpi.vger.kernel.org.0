Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FE03987AD
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jun 2021 13:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhFBLI1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 07:08:27 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3511 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhFBLIX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 07:08:23 -0400
Received: from dggeme764-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fw5kK0rHhzYrwQ;
        Wed,  2 Jun 2021 19:03:53 +0800 (CST)
Received: from [10.174.179.31] (10.174.179.31) by
 dggeme764-chm.china.huawei.com (10.3.19.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 2 Jun 2021 19:06:37 +0800
Subject: Re: [PATCH] ACPI: tables: fixes the missed acpi_put_table() in
 acpi_init_fpdt()
To:     Hanjun Guo <guohanjun@huawei.com>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <rui.zhang@intel.com>
References: <20210602011723.23666-1-jingxiangfeng@huawei.com>
 <b70f1c51-08fa-4ddf-51c6-77064e02fe87@huawei.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
Message-ID: <60B7663C.8070903@huawei.com>
Date:   Wed, 2 Jun 2021 19:06:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <b70f1c51-08fa-4ddf-51c6-77064e02fe87@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.31]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme764-chm.china.huawei.com (10.3.19.110)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2021/6/2 17:21, Hanjun Guo wrote:
> The title of this patch is misleading, how about "ACPI: FPDT: Add the
> missed acpi_put_table() in acpi_init_fpdt()" ?
Thanks a lot for your comments! I'll send a v2 with this change.

>
> On 2021/6/2 9:17, Jing Xiangfeng wrote:
>> acpi_init_fpdt() misses to call acpi_put_table() in an error path. Add
>> the missed function call to fix it.
>>
>> Fixes: d1eb86e59be0 ("ACPI: tables: introduce support for FPDT table")
>> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
>> ---
>>   drivers/acpi/acpi_fpdt.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
>> index a89a806a7a2a..4ee2ad234e3d 100644
>> --- a/drivers/acpi/acpi_fpdt.c
>> +++ b/drivers/acpi/acpi_fpdt.c
>> @@ -240,8 +240,10 @@ static int __init acpi_init_fpdt(void)
>>           return 0;
>>         fpdt_kobj = kobject_create_and_add("fpdt", acpi_kobj);
>> -    if (!fpdt_kobj)
>> +    if (!fpdt_kobj) {
>> +        acpi_put_table(header);
>>           return -ENOMEM;
>> +    }
>
> The code looks good to me.
>
> Thanks
> Hanjun
> .
>

