Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFA2247E6E
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Aug 2020 08:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgHRG3q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 Aug 2020 02:29:46 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46766 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726519AbgHRG3p (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Aug 2020 02:29:45 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9AA41F6886A1652A6D0B;
        Tue, 18 Aug 2020 14:29:42 +0800 (CST)
Received: from [10.174.185.226] (10.174.185.226) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Tue, 18 Aug 2020 14:29:36 +0800
Subject: Re: [PATCH] ACPI/IORT: Drop the unused @ops of
 iort_add_device_replay()
To:     Hanjun Guo <guohanjun@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>
References: <20200817105946.1511-1-yuzenghui@huawei.com>
 <8b15f022-8fb9-aa5c-fcd8-f92d4878a0a3@huawei.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <ae3a3b0e-ba0f-7ccc-7ddf-d0f0cf69a818@huawei.com>
Date:   Tue, 18 Aug 2020 14:29:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <8b15f022-8fb9-aa5c-fcd8-f92d4878a0a3@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.185.226]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020/8/18 11:49, Hanjun Guo wrote:
> On 2020/8/17 18:59, Zenghui Yu wrote:
>> Since commit d2e1a003af56 ("ACPI/IORT: Don't call iommu_ops->add_device
>> directly"), we use the IOMMU core API to replace a direct invoke of the
>> specified callback. The parameter @ops has therefore became unused. Let's
>> drop it.
>>
>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>> ---
>>   drivers/acpi/arm64/iort.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index ec782e4a0fe4..a0ece0e201b2 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -811,8 +811,7 @@ static inline const struct iommu_ops 
>> *iort_fwspec_iommu_ops(struct device *dev)
>>       return (fwspec && fwspec->ops) ? fwspec->ops : NULL;
>>   }
>> -static inline int iort_add_device_replay(const struct iommu_ops *ops,
>> -                     struct device *dev)
>> +static inline int iort_add_device_replay(struct device *dev)
>>   {
>>       int err = 0;
>> @@ -1072,7 +1071,7 @@ const struct iommu_ops 
>> *iort_iommu_configure_id(struct device *dev,
>>        */
>>       if (!err) {
>>           ops = iort_fwspec_iommu_ops(dev);
>> -        err = iort_add_device_replay(ops, dev);
>> +        err = iort_add_device_replay(dev);
>>       }
>>       /* Ignore all other errors apart from EPROBE_DEFER */
>> @@ -1089,8 +1088,7 @@ const struct iommu_ops 
>> *iort_iommu_configure_id(struct device *dev,
>>   #else
>>   static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct 
>> device *dev)
>>   { return NULL; }
>> -static inline int iort_add_device_replay(const struct iommu_ops *ops,
>> -                     struct device *dev)
>> +static inline int iort_add_device_replay(struct device *dev)
> 
> inline functions iort_fwspec_iommu_ops() and iort_add_device_replay()
> are not needed anymore after commit 8212688600ed ("ACPI/IORT: Fix build
> error when IOMMU_SUPPORT is disabled"), could you please add another
> patch to remove them as well?

Sure, I will remove them in v2. Thanks for the reminder.


Zenghui
