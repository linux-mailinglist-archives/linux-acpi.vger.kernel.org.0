Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6273914BE89
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2020 18:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgA1R2g (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jan 2020 12:28:36 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2322 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726066AbgA1R2g (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Jan 2020 12:28:36 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id A5F7E907644890621BA9;
        Tue, 28 Jan 2020 17:28:34 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML711-CAH.china.huawei.com (10.201.108.34) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 28 Jan 2020 17:28:34 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 28 Jan
 2020 17:28:33 +0000
Subject: Re: [PATCH RFC 0/2] Add basic generic ACPI soc driver
To:     Jeremy Linton <jeremy.linton@arm.com>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>
CC:     <arnd@arndb.de>, <olof@lixom.net>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <guohanjun@huawei.com>,
        <gregkh@linuxfoundation.org>
References: <1580210059-199540-1-git-send-email-john.garry@huawei.com>
 <bb87efe5-d0be-498a-25a1-008a7bebd452@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5ab3a97d-bbc4-6d5a-fd06-f8da324339ab@huawei.com>
Date:   Tue, 28 Jan 2020 17:28:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <bb87efe5-d0be-498a-25a1-008a7bebd452@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.226.43]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 28/01/2020 16:56, Jeremy Linton wrote:
> Hi,
> 

Hi Jeremy,

> On 1/28/20 5:14 AM, John Garry wrote:
>> A requirement has come up recently to be able to read system SoC packages
>> identifiers from userspace [0].
>>
>> For device tree FW-based systems, this would be quite straightforward, in
>> that we could add a soc driver for that system and use the DT model
>> identifier as the soc id - that's how most soc drivers seem to do it.
>>
>> For ACPI-based systems, the only place I know to get (put) such SoC
>> information is in the PPTT, specifically the ID Type Structure for a
>> processor package node. A processor package node describes a physical
>> boundary of a processor topology.
> 
> Well presumably that is one of the use cases for DMI, which has fields 
> for the processor/socket as well as the machine vendor.

I did consider DMI, but I want something more generic, i.e. could cover 
embedded/DT systems also.

And I need to double check if DMI really has the info I require. Last 
time I checked, it didn't for my dev board, but I know that some fields 
are simply not filled in.

> 
> But, quickly looking at the use case, I can't help but think you don't 
> really want any of the above, or the PPTT id. It seems the mapping 
> should actually be tied directly to the uncore PMU definition, rather 
> than a soc/machine/whatever identifier. Which would imply keying off one 
> of the ACPI object identifiers for the PMU itself.

So a PMU device (/sys/bus/event_source/devices) does not have a link to 
the ACPI object identifiers or uncore PMU platform device etc.

And even if it did, there is no clear link between that ACPI object and 
the events it supports for that implementation.

Cheers,
John

> 
> 
>>
>> The ACPI spec does not declare how the fields in this structure must be
>> used, however it does provide pretty clear examples, which I would expect
>> most implementers to follow. As such, I try to solve the problem in 2
>> parts:
>> - Add ACPI PPTT API to get opaque package structure
>> - Add basic ACPI generic soc driver, which can interpret the fields
>>    for known platforms to fill in the ID Type Structure as per example
>>    in the spec.
>>
>> So I'm hoping here for some comments on this approach - hence the RFC.
>> I've cc'ed some folks which may have suggestions.
>>
>> [0] 
>> https://lore.kernel.org/linux-arm-kernel/1579876505-113251-6-git-send-email-john.garry@huawei.com/ 
>> ,
>>      
>> https://lore.kernel.org/linux-arm-kernel/1579876505-113251-1-git-send-email-john.garry@huawei.com/ 
>>
>>
>> John Garry (2):
>>    ACPI/PPTT: Add acpi_pptt_get_package_info() API
>>    soc: Add a basic ACPI generic driver
>>
>>   drivers/acpi/pptt.c        |  81 +++++++++++++++++++++++++++++
>>   drivers/soc/Makefile       |   1 +
>>   drivers/soc/acpi_generic.c | 102 +++++++++++++++++++++++++++++++++++++
>>   include/linux/acpi.h       |  13 +++++
>>   4 files changed, 197 insertions(+)
>>   create mode 100644 drivers/soc/acpi_generic.c
>>
> 
> .

