Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DFF2C50BB
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Nov 2020 09:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbgKZItz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Nov 2020 03:49:55 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2156 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgKZItz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Nov 2020 03:49:55 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ChWcR1vTFz67HgK;
        Thu, 26 Nov 2020 16:48:07 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 26 Nov 2020 09:49:53 +0100
Received: from [10.210.172.213] (10.210.172.213) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Thu, 26 Nov 2020 08:49:52 +0000
Subject: Re: [PATCH v3 2/5] ACPI: Make acpi_dev_irqresource_disabled() public
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>
References: <1606324841-217570-1-git-send-email-john.garry@huawei.com>
 <1606324841-217570-3-git-send-email-john.garry@huawei.com>
 <CAJZ5v0j=H4NVdvdrC6nCd36zEA2n1xpiRSgKN-OV6+GLasA+Jw@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <7b9e1500-f520-24a8-548e-d4952dab028c@huawei.com>
Date:   Thu, 26 Nov 2020 08:49:30 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0j=H4NVdvdrC6nCd36zEA2n1xpiRSgKN-OV6+GLasA+Jw@mail.gmail.com>
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

On 25/11/2020 17:43, Rafael J. Wysocki wrote:
> On Wed, Nov 25, 2020 at 6:25 PM John Garry<john.garry@huawei.com>  wrote:
>> To allow the platform device to "put" an irq, make the function to reset
>> an ACPI companion device irq resource public.
>>
>> Signed-off-by: John Garry<john.garry@huawei.com>
> I'd rather move it to kernel/resource.c as it is not ACPI-specific and
> its only connection to ACPI is that it is used in the ACPI resources
> management code.
> 

Hi Rafael,

That's ok, but we could also just put in include/linux/ioport.h as a 
static inline as it’s so small. Not so important, I guess.

And I'm not sure how this part could be merged, so maybe I can do as 2x 
patches now - 1. add resource.c function 2. remove ACPI duplicate. - so 
we have the option to merge ACPI part later if it makes things easier.

Thanks,
John
