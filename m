Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67BD30021C
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 12:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbhAVLzz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Jan 2021 06:55:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11570 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbhAVLyg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Jan 2021 06:54:36 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DMd0l2PvczM8bR;
        Fri, 22 Jan 2021 19:52:23 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.87) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Fri, 22 Jan 2021
 19:53:41 +0800
Subject: Re: [PATCH v9 05/10] uacce: Enable IOMMU_DEV_FEAT_IOPF
To:     Dave Jiang <dave.jiang@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <joro@8bytes.org>, <will@kernel.org>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
 <20210108145217.2254447-6-jean-philippe@linaro.org>
 <e14f47bd-1b0c-1905-3bb7-62e1c5b096c7@intel.com>
CC:     <vivek.gautam@arm.com>, <guohanjun@huawei.com>,
        <linux-acpi@vger.kernel.org>, <zhangfei.gao@linaro.org>,
        <lenb@kernel.org>, <devicetree@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, <eric.auger@redhat.com>,
        <vdumpa@nvidia.com>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <rjw@rjwysocki.net>, <shameerali.kolothum.thodi@huawei.com>,
        <iommu@lists.linux-foundation.org>, <sudeep.holla@arm.com>,
        <robin.murphy@arm.com>, <linux-accelerators@lists.ozlabs.org>,
        <baolu.lu@linux.intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <d25faa15-eaaf-a3b8-adaf-f7c81653f688@hisilicon.com>
Date:   Fri, 22 Jan 2021 19:53:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <e14f47bd-1b0c-1905-3bb7-62e1c5b096c7@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.188.87]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/1/21 4:47, Dave Jiang wrote:
> 
> On 1/8/2021 7:52 AM, Jean-Philippe Brucker wrote:
>> The IOPF (I/O Page Fault) feature is now enabled independently from the
>> SVA feature, because some IOPF implementations are device-specific and
>> do not require IOMMU support for PCIe PRI or Arm SMMU stall.
>>
>> Enable IOPF unconditionally when enabling SVA for now. In the future, if
>> a device driver implementing a uacce interface doesn't need IOPF
>> support, it will need to tell the uacce module, for example with a new
>> flag.
>>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> ---
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
>> Cc: Zhou Wang <wangzhou1@hisilicon.com>
>> ---
>>   drivers/misc/uacce/uacce.c | 32 +++++++++++++++++++++++++-------
>>   1 file changed, 25 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
>> index d07af4edfcac..41ef1eb62a14 100644
>> --- a/drivers/misc/uacce/uacce.c
>> +++ b/drivers/misc/uacce/uacce.c
>> @@ -385,6 +385,24 @@ static void uacce_release(struct device *dev)
>>       kfree(uacce);
>>   }
>>   +static unsigned int uacce_enable_sva(struct device *parent, unsigned int flags)
>> +{
>> +    if (!(flags & UACCE_DEV_SVA))
>> +        return flags;
>> +
>> +    flags &= ~UACCE_DEV_SVA;
>> +
>> +    if (iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_IOPF))
>> +        return flags;
>> +
>> +    if (iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA)) {
>> +        iommu_dev_disable_feature(parent, IOMMU_DEV_FEAT_IOPF);
>> +        return flags;
>> +    }
> 
> Sorry to jump in a bit late on this and not specifically towards the
> intent of this patch. But I'd like to start a discussion on if we want
> to push the iommu dev feature enabling to the device driver itself rather
> than having UACCE control this? Maybe allow the device driver to manage
> the feature bits and UACCE only verify that they are enabled?
> 
> 1. The device driver knows what platform it's on and what specific
>    feature bits its devices supports. Maybe in the future if there are
>    feature bits that's needed on one platform and not on another?

Hi Dave,

From the discussion in this series, the meaning of IOMMU_DEV_FEAT_IOPF here
is the IOPF capability of iommu device itself. So I think check it in UACCE
will be fine.

> 2. This allows the possibility of multiple uacce device registered to 1
>    pci dev, which for a device with asymmetric queues (Intel DSA/idxd
>    driver) that is desirable feature. The current setup forces a single
>    uacce device per pdev. If additional uacce devs are registered, the
>    first removal of uacce device will disable the feature bit for the
>    rest of the registered devices. With uacce managing the feature bit,
>    it would need to add device context to the parent pdev and ref
>    counting. It may be cleaner to just allow device driver to manage
>    the feature bits and the driver should have all the information on
>    when the feature needs to be turned on and off.

Yes, we have this problem, however, this problem exists for IOMMU_DEV_FEAT_SVA
too. How about to fix it in another patch?

Best,
Zhou

> 
> - DaveJ
> 
> 
>> +
>> +    return flags | UACCE_DEV_SVA;
>> +}
>> +
>>   /**
>>    * uacce_alloc() - alloc an accelerator
>>    * @parent: pointer of uacce parent device
>> @@ -404,11 +422,7 @@ struct uacce_device *uacce_alloc(struct device *parent,
>>       if (!uacce)
>>           return ERR_PTR(-ENOMEM);
>>   -    if (flags & UACCE_DEV_SVA) {
>> -        ret = iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA);
>> -        if (ret)
>> -            flags &= ~UACCE_DEV_SVA;
>> -    }
>> +    flags = uacce_enable_sva(parent, flags);
>>         uacce->parent = parent;
>>       uacce->flags = flags;
>> @@ -432,8 +446,10 @@ struct uacce_device *uacce_alloc(struct device *parent,
>>       return uacce;
>>     err_with_uacce:
>> -    if (flags & UACCE_DEV_SVA)
>> +    if (flags & UACCE_DEV_SVA) {
>>           iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_SVA);
>> +        iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_IOPF);
>> +    }
>>       kfree(uacce);
>>       return ERR_PTR(ret);
>>   }
>> @@ -487,8 +503,10 @@ void uacce_remove(struct uacce_device *uacce)
>>       mutex_unlock(&uacce->queues_lock);
>>         /* disable sva now since no opened queues */
>> -    if (uacce->flags & UACCE_DEV_SVA)
>> +    if (uacce->flags & UACCE_DEV_SVA) {
>>           iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_SVA);
>> +        iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_IOPF);
>> +    }
>>         if (uacce->cdev)
>>           cdev_device_del(uacce->cdev, &uacce->dev);
> 
> .
> 

