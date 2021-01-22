Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E013007AC
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 16:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbhAVPoI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Jan 2021 10:44:08 -0500
Received: from mga06.intel.com ([134.134.136.31]:63805 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729084AbhAVPn4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Jan 2021 10:43:56 -0500
IronPort-SDR: +DnACV0wGxOILPzIwTQW9HZrAZHZP6Qw3Rb2PgSANa0dXSe8fVeRZaa0kiQkU/G0LfRfGg03YR
 MzbLntBAwN2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9872"; a="241001783"
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="241001783"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 07:43:14 -0800
IronPort-SDR: HhVvVYp9UNmAue99p2JpAnb8MYodJe2PpnP5Q2H5t3j+vb7w+TRaAAehQbJmESyDt/fKxv9iqK
 jTA3C8i7r2Gg==
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="367469522"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.160.72]) ([10.212.160.72])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 07:43:12 -0800
Subject: Re: [PATCH v9 05/10] uacce: Enable IOMMU_DEV_FEAT_IOPF
To:     Zhou Wang <wangzhou1@hisilicon.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        joro@8bytes.org, will@kernel.org
Cc:     vivek.gautam@arm.com, guohanjun@huawei.com,
        linux-acpi@vger.kernel.org, zhangfei.gao@linaro.org,
        lenb@kernel.org, devicetree@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, eric.auger@redhat.com,
        vdumpa@nvidia.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rjw@rjwysocki.net, shameerali.kolothum.thodi@huawei.com,
        iommu@lists.linux-foundation.org, sudeep.holla@arm.com,
        robin.murphy@arm.com, linux-accelerators@lists.ozlabs.org,
        baolu.lu@linux.intel.com, Dan Williams <dan.j.williams@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
 <20210108145217.2254447-6-jean-philippe@linaro.org>
 <e14f47bd-1b0c-1905-3bb7-62e1c5b096c7@intel.com>
 <d25faa15-eaaf-a3b8-adaf-f7c81653f688@hisilicon.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <ee066d95-c8ef-887b-35bc-d47d641c9f58@intel.com>
Date:   Fri, 22 Jan 2021 08:43:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <d25faa15-eaaf-a3b8-adaf-f7c81653f688@hisilicon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 1/22/2021 4:53 AM, Zhou Wang wrote:
> On 2021/1/21 4:47, Dave Jiang wrote:
>> On 1/8/2021 7:52 AM, Jean-Philippe Brucker wrote:
>>> The IOPF (I/O Page Fault) feature is now enabled independently from the
>>> SVA feature, because some IOPF implementations are device-specific and
>>> do not require IOMMU support for PCIe PRI or Arm SMMU stall.
>>>
>>> Enable IOPF unconditionally when enabling SVA for now. In the future, if
>>> a device driver implementing a uacce interface doesn't need IOPF
>>> support, it will need to tell the uacce module, for example with a new
>>> flag.
>>>
>>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>> ---
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
>>> Cc: Zhou Wang <wangzhou1@hisilicon.com>
>>> ---
>>>    drivers/misc/uacce/uacce.c | 32 +++++++++++++++++++++++++-------
>>>    1 file changed, 25 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
>>> index d07af4edfcac..41ef1eb62a14 100644
>>> --- a/drivers/misc/uacce/uacce.c
>>> +++ b/drivers/misc/uacce/uacce.c
>>> @@ -385,6 +385,24 @@ static void uacce_release(struct device *dev)
>>>        kfree(uacce);
>>>    }
>>>    +static unsigned int uacce_enable_sva(struct device *parent, unsigned int flags)
>>> +{
>>> +    if (!(flags & UACCE_DEV_SVA))
>>> +        return flags;
>>> +
>>> +    flags &= ~UACCE_DEV_SVA;
>>> +
>>> +    if (iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_IOPF))
>>> +        return flags;
>>> +
>>> +    if (iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA)) {
>>> +        iommu_dev_disable_feature(parent, IOMMU_DEV_FEAT_IOPF);
>>> +        return flags;
>>> +    }
>> Sorry to jump in a bit late on this and not specifically towards the
>> intent of this patch. But I'd like to start a discussion on if we want
>> to push the iommu dev feature enabling to the device driver itself rather
>> than having UACCE control this? Maybe allow the device driver to manage
>> the feature bits and UACCE only verify that they are enabled?
>>
>> 1. The device driver knows what platform it's on and what specific
>>     feature bits its devices supports. Maybe in the future if there are
>>     feature bits that's needed on one platform and not on another?
> Hi Dave,
>
>  From the discussion in this series, the meaning of IOMMU_DEV_FEAT_IOPF here
> is the IOPF capability of iommu device itself. So I think check it in UACCE
> will be fine.
>
>> 2. This allows the possibility of multiple uacce device registered to 1
>>     pci dev, which for a device with asymmetric queues (Intel DSA/idxd
>>     driver) that is desirable feature. The current setup forces a single
>>     uacce device per pdev. If additional uacce devs are registered, the
>>     first removal of uacce device will disable the feature bit for the
>>     rest of the registered devices. With uacce managing the feature bit,
>>     it would need to add device context to the parent pdev and ref
>>     counting. It may be cleaner to just allow device driver to manage
>>     the feature bits and the driver should have all the information on
>>     when the feature needs to be turned on and off.
> Yes, we have this problem, however, this problem exists for IOMMU_DEV_FEAT_SVA
> too. How about to fix it in another patch?

Hi Zhou,

Right that's what I'm implying. I'm not pushing back on the IOPF feature 
set. Just trying to survey  the opinions from people on moving the 
feature settings to the actual drivers rather than having it in UACCE. I 
will create some patches to show what I mean for comments.


>
> Best,
> Zhou
>
>> - DaveJ
>>
>>
>>> +
>>> +    return flags | UACCE_DEV_SVA;
>>> +}
>>> +
>>>    /**
>>>     * uacce_alloc() - alloc an accelerator
>>>     * @parent: pointer of uacce parent device
>>> @@ -404,11 +422,7 @@ struct uacce_device *uacce_alloc(struct device *parent,
>>>        if (!uacce)
>>>            return ERR_PTR(-ENOMEM);
>>>    -    if (flags & UACCE_DEV_SVA) {
>>> -        ret = iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA);
>>> -        if (ret)
>>> -            flags &= ~UACCE_DEV_SVA;
>>> -    }
>>> +    flags = uacce_enable_sva(parent, flags);
>>>          uacce->parent = parent;
>>>        uacce->flags = flags;
>>> @@ -432,8 +446,10 @@ struct uacce_device *uacce_alloc(struct device *parent,
>>>        return uacce;
>>>      err_with_uacce:
>>> -    if (flags & UACCE_DEV_SVA)
>>> +    if (flags & UACCE_DEV_SVA) {
>>>            iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_SVA);
>>> +        iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_IOPF);
>>> +    }
>>>        kfree(uacce);
>>>        return ERR_PTR(ret);
>>>    }
>>> @@ -487,8 +503,10 @@ void uacce_remove(struct uacce_device *uacce)
>>>        mutex_unlock(&uacce->queues_lock);
>>>          /* disable sva now since no opened queues */
>>> -    if (uacce->flags & UACCE_DEV_SVA)
>>> +    if (uacce->flags & UACCE_DEV_SVA) {
>>>            iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_SVA);
>>> +        iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_IOPF);
>>> +    }
>>>          if (uacce->cdev)
>>>            cdev_device_del(uacce->cdev, &uacce->dev);
>> .
>>
