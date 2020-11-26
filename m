Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1CE2C52DC
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Nov 2020 12:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgKZLXa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Nov 2020 06:23:30 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2160 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbgKZLXa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Nov 2020 06:23:30 -0500
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Chb0c2V2Dz67HSx;
        Thu, 26 Nov 2020 19:20:48 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 26 Nov 2020 12:23:27 +0100
Received: from [10.210.172.213] (10.210.172.213) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Thu, 26 Nov 2020 11:23:25 +0000
Subject: Re: [PATCH v3 3/5] driver core: platform: Add platform_put_irq()
To:     Marc Zyngier <maz@kernel.org>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <lenb@kernel.org>, <rjw@rjwysocki.net>,
        <gregkh@linuxfoundation.org>, <tglx@linutronix.de>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-acpi@vger.kernel.org>
References: <1606324841-217570-1-git-send-email-john.garry@huawei.com>
 <1606324841-217570-4-git-send-email-john.garry@huawei.com>
 <f6fb9ff74c8b361a592a6a4ceebd032d@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4a7359bb-620b-2219-9b88-8a657f716336@huawei.com>
Date:   Thu, 26 Nov 2020 11:23:04 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <f6fb9ff74c8b361a592a6a4ceebd032d@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.210.172.213]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 26/11/2020 09:28, Marc Zyngier wrote:
> On 2020-11-25 17:20, John Garry wrote:
>> Add a function to tear down the work which was done in platform_get_irq()
>> for when the device driver is done with the irq.
>>
>> For ACPI companion devices the irq resource is set as disabled, as this
>> resource is configured from platform_get_irq()->acpi_irq_get() and 
>> requires
>> resetting.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>  drivers/base/platform.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
>> index 88aef93eb4dd..3eeda3746701 100644
>> --- a/drivers/base/platform.c
>> +++ b/drivers/base/platform.c
>> @@ -289,6 +289,20 @@ int platform_irq_count(struct platform_device *dev)
>>  }
>>  EXPORT_SYMBOL_GPL(platform_irq_count);
>>

Hi Marc,

>> +void platform_put_irq(struct platform_device *dev, unsigned int num)
>> +{
>> +    unsigned int virq = platform_get_irq(dev, num);
> 
> I find it pretty odd to have to recompute the interrupt number,
> which in turn results in a domain lookup. 

Well we do have the virq available, but then we need to pass the virq 
and device irq index. But maybe I somehow reverse-lookup the ACPI res 
somehow from virq, such that we don't require the irq device index.

> It things were refcounted
> (they aren't yet), irq_dispose_mapping() would have no effect.
> 
> <pedant>
> It also goes against the usual construct where if you obtain an object
> based on some parameters, the release happens by specifying the object
> itself, and not the parameters that lead to the object.
> </pedant>

Yes, ideally we can use virq.

> 
>> +
>> +    irq_dispose_mapping(virq);
>> +    if (has_acpi_companion(&dev->dev)) {
>> +        struct resource *r = platform_get_resource(dev, IORESOURCE_IRQ,
>> +                               num);
>> +
>> +        if (r)
>> +            acpi_dev_irqresource_disabled(r, 0);
> 
> It looks to me that the ACPI thing is what needs to be promoted to a
> first class function, releasing all the resources that have used by
> a given device.

This is just clearing the irq resource flags, but it could be reasonable 
(to promote).

Thanks,
John
