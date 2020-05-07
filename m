Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D001C8BEB
	for <lists+linux-acpi@lfdr.de>; Thu,  7 May 2020 15:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgEGNSN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 May 2020 09:18:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58226 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726007AbgEGNSN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 May 2020 09:18:13 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3A8A97432AF0C4F5C273;
        Thu,  7 May 2020 21:18:09 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.93) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Thu, 7 May 2020
 21:18:01 +0800
Subject: Re: [PATCH v2 2/2] ACPI/IORT: work around num_ids ambiguity
To:     Will Deacon <will@kernel.org>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linuxarm <linuxarm@huawei.com>
References: <20200501161014.5935-1-ardb@kernel.org>
 <20200501161014.5935-3-ardb@kernel.org>
 <bbd56b89-643a-2f86-79af-f65ef46822ef@huawei.com>
 <CAMj1kXEuV_Lmhu-2zZhD-YgL-zu+o0v+vooQTK30cemJW5dfNg@mail.gmail.com>
 <86c60895-365e-9166-8f70-7a353bbc4e86@huawei.com>
 <20200506125519.GI8043@willie-the-truck>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <3f00493b-b629-490f-b26d-b56d817a1b88@huawei.com>
Date:   Thu, 7 May 2020 21:18:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200506125519.GI8043@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.213.93]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020/5/6 20:55, Will Deacon wrote:
> On Wed, May 06, 2020 at 08:44:55PM +0800, Hanjun Guo wrote:
>> On 2020/5/4 15:36, Ard Biesheuvel wrote:
>>> On Mon, 4 May 2020 at 06:32, Hanjun Guo <guohanjun@huawei.com> wrote:
>>>> On 2020/5/2 0:10, Ard Biesheuvel wrote:
>>>>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>>>>> index 98be18266a73..9f139a94a1d3 100644
>>>>> --- a/drivers/acpi/arm64/iort.c
>>>>> +++ b/drivers/acpi/arm64/iort.c
>>>>> @@ -300,7 +300,7 @@ static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
>>>>>     }
>>>>>
>>>>>     static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
>>>>> -                    u32 *rid_out)
>>>>> +                    u32 *rid_out, bool check_overlap)
>>>>>     {
>>>>>         /* Single mapping does not care for input id */
>>>>>         if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
>>>>> @@ -316,10 +316,34 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
>>>>>         }
>>>>>
>>>>>         if (rid_in < map->input_base ||
>>>>> -         (rid_in >= map->input_base + map->id_count))
>>>>> +         (rid_in > map->input_base + map->id_count))
>>>>>                 return -ENXIO;
>>>>>
>>>>> +     if (check_overlap) {
>>>>> +             /*
>>>>> +              * We already found a mapping for this input ID at the end of
>>>>> +              * another region. If it coincides with the start of this
>>>>> +              * region, we assume the prior match was due to the off-by-1
>>>>> +              * issue mentioned below, and allow it to be superseded.
>>>>> +              * Otherwise, things are *really* broken, and we just disregard
>>>>> +              * duplicate matches entirely to retain compatibility.
>>>>> +              */
>>>>> +             pr_err(FW_BUG "[map %p] conflicting mapping for input ID 0x%x\n",
>>>>> +                    map, rid_in);
>>>>
>>>> As we already applied a workaround here, can we add "applying
>>>> workaround" in the error message? This will make the customers
>>>> less uneasy to see such message in the boot log. Once the product
>>>> was deliveried to customers, it's not that easy to update all the
>>>> firmwares entirely.
>>>>
>>>
>>> Sure.
>>
>> Since Will already merged this patchset, I would like to send a patch
>> on top of it, what do you think?
> 
> Yes, please! I figured I'd queue it, as I could always revert it if your
> testing came back negative but extra stuff on top is always fine.

OK, I will prepare a patch and send out for review.

Thanks
Hanjun

