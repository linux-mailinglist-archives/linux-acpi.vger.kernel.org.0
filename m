Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4943AB424
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 14:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhFQNAb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Jun 2021 09:00:31 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7473 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhFQNAb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jun 2021 09:00:31 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G5MV425MJzZjKX;
        Thu, 17 Jun 2021 20:55:24 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 20:58:19 +0800
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 20:58:19 +0800
Subject: Re: [PATCH -next v2] ACPI: sysfs: fix doc warnings in device_sysfs.c
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "Yue Haibing" <yuehaibing@huawei.com>, <yangjihong1@huawei.com>,
        yu kuai <yukuai3@huawei.com>
References: <20210615071914.3067407-1-libaokun1@huawei.com>
 <CAJZ5v0iMGTDAbY+JivBFRP6soTC5v_imqWZ9jSZoQVeYdgVoCw@mail.gmail.com>
From:   "libaokun (A)" <libaokun1@huawei.com>
Message-ID: <6e737a9a-72e9-509c-faa5-85a9f89da9ab@huawei.com>
Date:   Thu, 17 Jun 2021 20:58:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iMGTDAbY+JivBFRP6soTC5v_imqWZ9jSZoQVeYdgVoCw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thank you for your advice.

I'll follow your advice strictly.

Best Regards.


在 2021/6/17 20:34, Rafael J. Wysocki 写道:
> On Tue, Jun 15, 2021 at 9:10 AM Baokun Li <libaokun1@huawei.com> wrote:
>> Fixes the following W=1 kernel build warning(s):
>>
>>   drivers/acpi/device_sysfs.c:278: warning: Function parameter or
>>    member 'dev' not described in 'acpi_device_uevent_modalias'
>>   drivers/acpi/device_sysfs.c:278: warning: Function parameter or
>>    member 'env' not described in 'acpi_device_uevent_modalias'
>>   drivers/acpi/device_sysfs.c:323: warning: Function parameter or
>>    member 'dev' not described in 'acpi_device_modalias'
>>   drivers/acpi/device_sysfs.c:323: warning: Function parameter or
>>    member 'buf' not described in 'acpi_device_modalias'
>>   drivers/acpi/device_sysfs.c:323: warning: Function parameter or
>>    member 'size' not described in 'acpi_device_modalias'
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>> V1->V2:
>>          Make comments more appropriate
>>
>>   drivers/acpi/device_sysfs.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
>> index a393e0e09381..d96e38b2a0d1 100644
>> --- a/drivers/acpi/device_sysfs.c
>> +++ b/drivers/acpi/device_sysfs.c
>> @@ -268,6 +268,8 @@ int __acpi_device_uevent_modalias(struct acpi_device *adev,
>>
>>   /**
>>    * acpi_device_uevent_modalias - uevent modalias for ACPI-enumerated devices.
>> + * @dev: Struct device to get acpi device node.
>> + * @env: Environment variables of the kobject uevent.
>>    *
>>    * Create the uevent modalias field for ACPI-enumerated devices.
>>    *
>> @@ -313,6 +315,9 @@ static int __acpi_device_modalias(struct acpi_device *adev, char *buf, int size)
>>
>>   /**
>>    * acpi_device_modalias - modalias sysfs attribute for ACPI-enumerated devices.
>> + * @dev: Struct device to get acpi device node.
>> + * @buf: The buffer to save pnp_modalias and of_modalias.
>> + * @size: Size of buffer.
>>    *
>>    * Create the modalias sysfs attribute for ACPI-enumerated devices.
>>    *
>> --
> Applied as 5.14 material with fixed spelling ("acpi" -> "ACPI").
>
> Please always spell ACPI in capitals in comments, patch changelogs,
> subjects and similar.
>
> Thanks!
> .
