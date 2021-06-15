Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A86E3A77FB
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jun 2021 09:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhFOHcC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Jun 2021 03:32:02 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6504 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhFOHcC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Jun 2021 03:32:02 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G40J53PsgzZgWd;
        Tue, 15 Jun 2021 15:27:01 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 15:29:53 +0800
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 15:29:52 +0800
Subject: Re: [PATCH -next] acpi/nvs: fix doc warnings in nvs.c
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "Yue Haibing" <yuehaibing@huawei.com>, <yangjihong1@huawei.com>,
        yu kuai <yukuai3@huawei.com>
References: <20210608023841.2746826-1-libaokun1@huawei.com>
 <CAJZ5v0iPcSwjswJ7+1gPk-CKowLST7LG-4RQx_LkwFV+fUW6Gg@mail.gmail.com>
From:   "libaokun (A)" <libaokun1@huawei.com>
Message-ID: <5114c2aa-e198-419f-c5f0-68e989dbb6fc@huawei.com>
Date:   Tue, 15 Jun 2021 15:29:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iPcSwjswJ7+1gPk-CKowLST7LG-4RQx_LkwFV+fUW6Gg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thank you for your advice.

I'm about to send a patch v2 with the changes suggested by you.

Best Regards.


在 2021/6/9 21:12, Rafael J. Wysocki 写道:
> On Tue, Jun 8, 2021 at 4:29 AM Baokun Li <libaokun1@huawei.com> wrote:
>> Fixes the following W=1 kernel build warning(s):
>>
>>   drivers/acpi/nvs.c:94: warning: Function parameter or
>>    member 'start' not described in 'suspend_nvs_register'
>>   drivers/acpi/nvs.c:94: warning: Function parameter or
>>    member 'size' not described in 'suspend_nvs_register'
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   drivers/acpi/nvs.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/nvs.c b/drivers/acpi/nvs.c
>> index 9f8712a557b3..4609a8a2e42d 100644
>> --- a/drivers/acpi/nvs.c
>> +++ b/drivers/acpi/nvs.c
>> @@ -83,8 +83,8 @@ static LIST_HEAD(nvs_list);
>>
>>   /**
>>    *     suspend_nvs_register - register platform NVS memory region to save
>> - *     @start - physical address of the region
>> - *     @size - size of the region
>> + *     @start: physical address of the region
>> + *     @size: size of the region
> The format of this kerneldoc comment is still not following the common
> style after your change.
>
> Please fix it completely.
>
>>    *
>>    *     The NVS region need not be page-aligned (both ends) and we arrange
>>    *     things so that the data from page-aligned addresses in this region will
>> --
>> 2.31.1
>>
> .
