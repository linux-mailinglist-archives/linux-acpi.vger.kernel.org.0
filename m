Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FF61C708A
	for <lists+linux-acpi@lfdr.de>; Wed,  6 May 2020 14:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgEFMnS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 May 2020 08:43:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3822 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725887AbgEFMnS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 6 May 2020 08:43:18 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C7EFA2357DDA44AEB548;
        Wed,  6 May 2020 20:43:15 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.93) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 6 May 2020
 20:43:07 +0800
Subject: Re: [PATCH v2 2/2] ACPI/IORT: work around num_ids ambiguity
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-acpi@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        "Will Deacon" <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linuxarm <linuxarm@huawei.com>
References: <20200501161014.5935-1-ardb@kernel.org>
 <20200501161014.5935-3-ardb@kernel.org>
 <bbd56b89-643a-2f86-79af-f65ef46822ef@huawei.com>
Message-ID: <127f1bc8-01ed-6c14-20f3-eb944ec5c4db@huawei.com>
Date:   Wed, 6 May 2020 20:43:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <bbd56b89-643a-2f86-79af-f65ef46822ef@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.213.93]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020/5/4 12:32, Hanjun Guo wrote:
> On 2020/5/2 0:10, Ard Biesheuvel wrote:
>> The ID mapping table structure of the IORT table describes the size of
>> a range using a num_ids field carrying the number of IDs in the region
>> minus one. This has been misinterpreted in the past in the parsing code,
>> and firmware is known to have shipped where this results in an ambiguity,
>> where regions that should be adjacent have an overlap of one value.
>>
>> So let's work around this by detecting this case specifically: when
>> resolving an ID translation, allow one that matches right at the end of
>> a multi-ID region to be superseded by a subsequent one.
>>
>> To prevent potential regressions on broken firmware that happened to
>> work before, only take the subsequent match into account if it occurs
>> at the start of a mapping region.
>>
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> ---
>>   drivers/acpi/arm64/iort.c | 40 +++++++++++++++++---
>>   1 file changed, 34 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index 98be18266a73..9f139a94a1d3 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -300,7 +300,7 @@ static acpi_status iort_match_node_callback(struct 
>> acpi_iort_node *node,
>>   }
>>   static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, 
>> u32 rid_in,
>> -               u32 *rid_out)
>> +               u32 *rid_out, bool check_overlap)
>>   {
>>       /* Single mapping does not care for input id */
>>       if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
>> @@ -316,10 +316,34 @@ static int iort_id_map(struct 
>> acpi_iort_id_mapping *map, u8 type, u32 rid_in,
>>       }
>>       if (rid_in < map->input_base ||
>> -        (rid_in >= map->input_base + map->id_count))
>> +        (rid_in > map->input_base + map->id_count))
>>           return -ENXIO;
>> +    if (check_overlap) {
>> +        /*
>> +         * We already found a mapping for this input ID at the end of
>> +         * another region. If it coincides with the start of this
>> +         * region, we assume the prior match was due to the off-by-1
>> +         * issue mentioned below, and allow it to be superseded.
>> +         * Otherwise, things are *really* broken, and we just disregard
>> +         * duplicate matches entirely to retain compatibility.
>> +         */
>> +        pr_err(FW_BUG "[map %p] conflicting mapping for input ID 
>> 0x%x\n",
>> +               map, rid_in);
> 
> As we already applied a workaround here, can we add "applying
> workaround" in the error message? This will make the customers
> less uneasy to see such message in the boot log. Once the product
> was deliveried to customers, it's not that easy to update all the
> firmwares entirely.
> 
> I'm out of reach for D05/D06 hardware as it's holidays in China,
> please allow me to test this patch set in Wednesday this week.

Tested this patchset on D06 and I comapared each sucessful mapped
ID, no regressions, and also no function regressions as well,

Tested-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

