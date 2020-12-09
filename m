Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F0D2D4A8B
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Dec 2020 20:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgLITiN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Dec 2020 14:38:13 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2238 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387804AbgLITiM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2020 14:38:12 -0500
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CrnKr5Hmkz67NYm;
        Thu, 10 Dec 2020 03:34:08 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 9 Dec 2020 20:37:29 +0100
Received: from [10.210.171.175] (10.210.171.175) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 9 Dec 2020 19:37:27 +0000
Subject: Re: [PATCH v5 4/5] Driver core: platform: Add
 devm_platform_get_irqs_affinity()
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <lenb@kernel.org>, <rjw@rjwysocki.net>, <tglx@linutronix.de>,
        <maz@kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-acpi@vger.kernel.org>, <dwagner@suse.de>
References: <1606905417-183214-1-git-send-email-john.garry@huawei.com>
 <1606905417-183214-5-git-send-email-john.garry@huawei.com>
 <X9EYRNDXS1Xcy4iU@kroah.com>
 <36730230-9fd7-8c6c-b997-328beea2fc31@huawei.com>
 <X9Ehy28876ezAOLH@kroah.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <0fa6487e-d225-dde6-f23f-f955d87ee706@huawei.com>
Date:   Wed, 9 Dec 2020 19:36:52 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <X9Ehy28876ezAOLH@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.171.175]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 09/12/2020 19:13, Greg KH wrote:

Hi Greg,

>> For this HW version, the device is on the system bus, directly addressable
>> by the CPU.
> What do you mean by "system bus"?

Maybe my terminology is wrong, the point is that we have a platform 
device driver.

> 
>> Motivation is that I wanted to switch the HW completion queues to use
>> managed interrupts.
> Fair enough, seems like overkill for a "platform" bus though:)
> 
>>> What in-kernel driver needs this complexity?  I can't take new apis
>>> without a real user in the tree, sorry.
>> It's in the final patch in the serieshttps://lore.kernel.org/linux-scsi/1606905417-183214-1-git-send-email-john.garry@huawei.com/T/#m0df7e7cd6f0819b99aaeb6b7f8939ef1e17b8a83.
> Ah, I missed that, I thought that was some high-speed scsi thing, not a
> tiny platform driver...

It is actually is a high-speed SCSI thing also, SAS 3.0 :)

> 
>> I don't anticipate a huge number of users of this API in future, as most
>> multi-queue devices are PCI devices; so we could do the work of this API in
>> the driver itself, but the preference was not to export genirq functions
>> like irq_update_affinity_desc() or irq_create_affinity_masks(), and rather
>> have a common helper in the core platform code.
> Ok, I'd like to have the irq maintainers/developers ack this before
> taking it in the driver core, as someone is going to have to maintain
> this crazy thing for forever if it gets merged.
> 

irq experts are cc'ed and have been very helpful here

So the API mushroomed a bit over time, as I realized that we need to 
support tearing down the irq mapping, make as devm method, use 
irq_calc_affinity_vectors(). Not sure how we could factor any of it out 
to become less of your problem.

Thanks,
John
