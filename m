Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61C65122C71
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Dec 2019 14:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfLQNBG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Dec 2019 08:01:06 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7698 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726141AbfLQNBG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 17 Dec 2019 08:01:06 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 383559BDEB357B89426A;
        Tue, 17 Dec 2019 21:01:03 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 17 Dec 2019
 21:00:54 +0800
Subject: Re: [PATCH] ACPI/IORT: fix the iort_id_map function
To:     Pankaj Bansal <pankaj.bansal@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20191215203303.29811-1-pankaj.bansal@nxp.com>
 <ffc5a6e9-cac3-d6c6-fe16-745b4f9e481f@huawei.com>
 <VI1PR0401MB2496E243F45C82E789B867A6F1510@VI1PR0401MB2496.eurprd04.prod.outlook.com>
 <eedbf670-00e2-93ce-06ac-469d6032ce74@huawei.com>
 <VI1PR0401MB2496DEA6CDEFD57C9427883FF1510@VI1PR0401MB2496.eurprd04.prod.outlook.com>
 <VI1PR0401MB2496A549A21DD18B214A083BF1500@VI1PR0401MB2496.eurprd04.prod.outlook.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <3a3f4624-cbb0-390f-6285-d91663c82d87@huawei.com>
Date:   Tue, 17 Dec 2019 21:00:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <VI1PR0401MB2496A549A21DD18B214A083BF1500@VI1PR0401MB2496.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Pankaj,

On 2019/12/17 19:58, Pankaj Bansal wrote:
[...]
>>>>>> Number of IDs = The number of IDs in the range minus one.
>>>>>
>>>>> Hmm, the spec is confusing, the spec may need to be updated, for
>>>>> example, for a PCI bus, device ID + function ID will take 8 bits
>>>>> and will be 256 IDs for that PCI bus, not sure why we need to minus one.
>>>>>
>>>>
>>>> I agree that this "minus one" thing is confusing. Not sure why It
>>>> was put in the spec like that. I guess they wanted the number of IDs
>>>> to be 0
>>> based instead of 1 based.
>>>>
>>>>>>
>>>>>> Therefore, it's valid for ID mapping to contain single device
>>>>>> mapping which would have Number of IDs field 0.
>>>>>
>>>>> Why not use single mapping flag for this case?
>>>>
>>>> Actually single mapping flag doesn't mean that there is single
>>>> mapping in
>>> an ID mapping.
>>>> It means that Input ID should not be considered when looking for
>>>> Output
>>> ID.
>>>> If we put single id flag, then we cannot have a case where we have
>>>> an array of single mappings for one device.
>>>> e.g. an array of single mappings for one PCIe Root Complex, where we
>>>> have a unique output ID for a unique BDF(Input ID)
>>>
>>> Agreed, single mapping flag is not working for multi-entris of single
>> mappings.
>>>
>>> Do you have a real use case for this fix? I'm thinking if we will
>>> break any delivered platforms with this patch applied, since this code
>>> is not changed from 2016, and it's the key logic for mapping the IDs.
>>
>> We have this use case in our platform NXP LX2160A, where we provide the
>> array of single mappings in IORT table. Actually we can only have limited
>> number of output IDs for PCIe devices, so we allocate unique output ID to
>> each BDF connected to a PCIe root complex and pass these IDs in IORT table.

Thanks for the detail information, it's quite useful.

>>
>>>
>>> I checked Hisilicon's ARM64 server platform, Number of IDs is equal to
>>> the number of IDs in the range in the firmware, which is not doing the
>>> same as the spec said, but (rid_in > map->input_base + map->id_count)
>>> is still valid with this patch applied, not sure for other platforms.
>>
>> I don't think that this patch would break any platform which has IORT table
>> defined as per spec.	
> 
> Let me rephase this to persuade you. This patch is *increasing* the allowed input
> IDs. Therefore, this patch would *include* more platforms and none of the existing
> Platforms can be affected by it, because already their Input IDs would fall in the allowed IDs.

Unfortunately it breaks systems (Number of IDs = The number of IDs in the range)
in this way:

PCI hostbridge mapping entry 1:
Input base:  0x1000
ID Count:    0x100
Output base: 0x1000
Output reference: 0xC4

PCI hostbridge mapping entry 2:
Input base:  0x1100
ID Count:    0x100
Output base: 0x2000
Output reference: 0xD4

Without your patch, Requester ID 0x1100 will be excluded to mapping
entry1, and will map to entry 2, pointing to ITS or SMMU 0xD4;

With your patch, will mapping to ITS or SMMU 0xC4. Correct me if I'm
wrong.

Also will not work if we update the firmware but leave the kernel
not updated.

Your patch is doing the right thing, but I need to figure out how to
avoid breaking the exiting system as well, the basic idea is to
workaroud the firmware issue with some OEM information such as
OEM ID/Table ID/Oem Revision in IORT table, please shout if you
have some other ideas.

Thanks
Hanjun

