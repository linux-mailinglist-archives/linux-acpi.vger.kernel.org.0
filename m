Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B4C3A7568
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jun 2021 05:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhFODwV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Jun 2021 23:52:21 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:10067 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhFODwV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jun 2021 23:52:21 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G3vQd02WFzZf1J;
        Tue, 15 Jun 2021 11:47:21 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 11:50:01 +0800
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 11:50:01 +0800
Subject: Re: [PATCH -next] ACPI: sysfs: fix doc warnings in device_sysfs.c
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "Yue Haibing" <yuehaibing@huawei.com>, <yangjihong1@huawei.com>,
        yu kuai <yukuai3@huawei.com>
References: <20210610113501.3439670-1-libaokun1@huawei.com>
 <CAJZ5v0ivf6xN0pd4Ub6YuKCwDUpXLcEZywdT+JPKa=1qTOH-iA@mail.gmail.com>
From:   "libaokun (A)" <libaokun1@huawei.com>
Message-ID: <02304aec-c4d5-a9d8-ae8e-6803b6dee602@huawei.com>
Date:   Tue, 15 Jun 2021 11:50:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0ivf6xN0pd4Ub6YuKCwDUpXLcEZywdT+JPKa=1qTOH-iA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


在 2021/6/14 23:26, Rafael J. Wysocki 写道:
> On Thu, Jun 10, 2021 at 1:25 PM Baokun Li <libaokun1@huawei.com> wrote:
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
>>   drivers/acpi/device_sysfs.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
>> index fa2c1c93072c..3b08efa88ba5 100644
>> --- a/drivers/acpi/device_sysfs.c
>> +++ b/drivers/acpi/device_sysfs.c
>> @@ -268,7 +268,8 @@ int __acpi_device_uevent_modalias(struct acpi_device *adev,
>>
>>   /**
>>    * acpi_device_uevent_modalias - uevent modalias for ACPI-enumerated devices.
>> - *
>> + * @dev: Struct device.
>> + * @env: Uevent kobject.
> This doesn't appear to be accurate.
>
> @env doesn't point to a kobject.

I didn't quite understand that variable.

But I saw the same paramter in  'drivers/misc/mei/bus.c +1001' where has 
comments.

So I copied that comments here.


  997 /**
  998  * mei_cl_device_uevent - me client bus uevent handler
  999  *
1000  * @dev: device
1001  * @env: uevent kobject
1002  *
1003  * Return: 0 on success -ENOMEM on when add_uevent_var fails
1004  */
1005 static int mei_cl_device_uevent(struct device *dev, struct 
kobj_uevent_env *env)


Thank you for your advice.

I'm about to send a patch v2 with the changes suggested by you.

Best Regards.


>
>>    * Create the uevent modalias field for ACPI-enumerated devices.
>>    *
>>    * Because other buses do not support ACPI HIDs & CIDs, e.g. for a device with
>> @@ -313,7 +314,9 @@ static int __acpi_device_modalias(struct acpi_device *adev, char *buf, int size)
>>
>>   /**
>>    * acpi_device_modalias - modalias sysfs attribute for ACPI-enumerated devices.
>> - *
>> + * @dev: Struct device.
>> + * @buf: The buffer.
>> + * @size: Size of the buffer.
>>    * Create the modalias sysfs attribute for ACPI-enumerated devices.
>>    *
>>    * Because other buses do not support ACPI HIDs & CIDs, e.g. for a device with
>> --
>> 2.31.1
>>
> .
