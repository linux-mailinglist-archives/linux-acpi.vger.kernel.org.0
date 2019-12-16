Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E00C712046F
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 12:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfLPLyx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Dec 2019 06:54:53 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7251 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727241AbfLPLyw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Dec 2019 06:54:52 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 23C8195EAB199B681CCD;
        Mon, 16 Dec 2019 19:54:51 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Mon, 16 Dec 2019
 19:54:41 +0800
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
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <eedbf670-00e2-93ce-06ac-469d6032ce74@huawei.com>
Date:   Mon, 16 Dec 2019 19:54:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <VI1PR0401MB2496E243F45C82E789B867A6F1510@VI1PR0401MB2496.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2019/12/16 13:14, Pankaj Bansal wrote:
> Hi Hanjun,
> 
> Thanks for replying. Please find my response inline
> 
>> Hi Pankaj,
>>
>> On 2019/12/15 23:12, Pankaj Bansal wrote:
>>> As per
>>> https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Finfoc
>>>
>> enter.arm.com%2Fhelp%2Ftopic%2Fcom.arm.doc.den0049d%2FDEN0049D_IO
>> _Rema
>>>
>> pping_Table.pdf&amp;data=02%7C01%7Cpankaj.bansal%40nxp.com%7C78d
>> 82a560
>>>
>> 5714219196008d781db06a7%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
>> 7C1%7C6
>>>
>> 37120650018983814&amp;sdata=%2FRhATUKx%2FA2gPEx%2BNY9X%2F7kqV
>> CrEeRnbE%
>>> 2B2qlTkdGDc%3D&amp;reserved=0
>>> in ID mappings:
>>> Number of IDs = The number of IDs in the range minus one.
>>
>> Hmm, the spec is confusing, the spec may need to be updated, for example,
>> for a PCI bus, device ID + function ID will take 8 bits and will be 256 IDs for
>> that PCI bus, not sure why we need to minus one.
>>
> 
> I agree that this "minus one" thing is confusing. Not sure why It was put in the spec
> like that. I guess they wanted the number of IDs to be 0 based instead of 1 based.
> 
>>>
>>> Therefore, it's valid for ID mapping to contain single device mapping
>>> which would have Number of IDs field 0.
>>
>> Why not use single mapping flag for this case?
> 
> Actually single mapping flag doesn't mean that there is single mapping in an ID mapping.
> It means that Input ID should not be considered when looking for Output ID.
> If we put single id flag, then we cannot have a case where we have an array of single mappings
> for one device.
> e.g. an array of single mappings for one PCIe Root Complex, where we have a unique output ID for a unique BDF(Input ID)

Agreed, single mapping flag is not working for multi-entris of single
mappings.

Do you have a real use case for this fix? I'm thinking if we will
break any delivered platforms with this patch applied, since this
code is not changed from 2016, and it's the key logic for mapping
the IDs.

I checked Hisilicon's ARM64 server platform, Number of IDs is equal
to the number of IDs in the range in the firmware, which is not doing
the same as the spec said, but (rid_in > map->input_base + map->id_count)
is still valid with this patch applied, not sure for other platforms.

Thanks
Hanjun

