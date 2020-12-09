Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843412D49BD
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Dec 2020 20:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387531AbgLITFY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Dec 2020 14:05:24 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2237 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387504AbgLITFW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2020 14:05:22 -0500
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Crmcn6529z67MVK;
        Thu, 10 Dec 2020 03:02:01 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 9 Dec 2020 20:04:39 +0100
Received: from [10.210.171.175] (10.210.171.175) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 9 Dec 2020 19:04:37 +0000
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
From:   John Garry <john.garry@huawei.com>
Message-ID: <36730230-9fd7-8c6c-b997-328beea2fc31@huawei.com>
Date:   Wed, 9 Dec 2020 19:04:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <X9EYRNDXS1Xcy4iU@kroah.com>
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

On 09/12/2020 18:32, Greg KH wrote:
> On Wed, Dec 02, 2020 at 06:36:56PM +0800, John Garry wrote:
>> Drivers for multi-queue platform devices may also want managed interrupts
>> for handling HW queue completion interrupts, so add support.
> 

Hi Greg,

> Why would a platform device want all of this?  Shouldn't such a device
> be on a "real" bus instead?

For this HW version, the device is on the system bus, directly 
addressable by the CPU.

Motivation is that I wanted to switch the HW completion queues to use 
managed interrupts.

> 
> What in-kernel driver needs this complexity?  I can't take new apis
> without a real user in the tree, sorry.

It's in the final patch in the series 
https://lore.kernel.org/linux-scsi/1606905417-183214-1-git-send-email-john.garry@huawei.com/T/#m0df7e7cd6f0819b99aaeb6b7f8939ef1e17b8a83.

I don't anticipate a huge number of users of this API in future, as most 
multi-queue devices are PCI devices; so we could do the work of this API 
in the driver itself, but the preference was not to export genirq 
functions like irq_update_affinity_desc() or 
irq_create_affinity_masks(), and rather have a common helper in the core 
platform code.

Thanks,
John

