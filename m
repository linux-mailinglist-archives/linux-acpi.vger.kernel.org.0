Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC141C8D3A
	for <lists+linux-acpi@lfdr.de>; Thu,  7 May 2020 16:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgEGOCR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 May 2020 10:02:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4281 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726678AbgEGOCQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 May 2020 10:02:16 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E086F7C6EBFA0A9EE031;
        Thu,  7 May 2020 22:02:09 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.93) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Thu, 7 May 2020
 22:02:04 +0800
Subject: Re: [PATCH] ACPI: IORT: Add extra message "applying workaround" for
 off-by-1 issue
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>
References: <1588858868-18039-1-git-send-email-guohanjun@huawei.com>
 <CAMj1kXHGfW=OKLO1S1Mf__9TzNXkrZ5BNvD8H_QYUTtF+awwpg@mail.gmail.com>
 <251b222a-7340-2d06-f07b-f81a9c19ac43@huawei.com>
Message-ID: <628896e3-e43f-5814-a5ff-2bd5de223f20@huawei.com>
Date:   Thu, 7 May 2020 22:02:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <251b222a-7340-2d06-f07b-f81a9c19ac43@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.213.93]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020/5/7 21:53, Hanjun Guo wrote:
> Hi Ard,
> 
> On 2020/5/7 21:49, Ard Biesheuvel wrote:
>> On Thu, 7 May 2020 at 15:47, Hanjun Guo <guohanjun@huawei.com> wrote:
>>>
>>> As we already applied a workaround for the off-by-1 issue,
>>> it's good to add extra message "applying workaround" to
>>> make people less uneasy to see such message in the boot log.
>>>
>>> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
>>
>> Hi Hanjun,
>>
>>> ---
>>>
>>> Based on top of for-next/acpi branch of ARM64 repo
>>>
>>>   drivers/acpi/arm64/iort.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>>> index b011d25..f3d492a 100644
>>> --- a/drivers/acpi/arm64/iort.c
>>> +++ b/drivers/acpi/arm64/iort.c
>>> @@ -328,7 +328,7 @@ static int iort_id_map(struct 
>>> acpi_iort_id_mapping *map, u8 type, u32 rid_in,
>>>                   * Otherwise, things are *really* broken, and we 
>>> just disregard
>>>                   * duplicate matches entirely to retain compatibility.
>>>                   */
>>> -               pr_err(FW_BUG "[map %p] conflicting mapping for input 
>>> ID 0x%x\n",
>>> +               pr_err(FW_BUG "[map %p] conflicting mapping for input 
>>> ID 0x%x, applying workaround\n",
>>
>> This is not correct. The workaround is only applied if rid_in ==
>> map->input_base, so better to print a second line after the 'return'
>> below that is only reached in that particular case.
> 
> Obvious I'm wrong, I will update this patch, thanks a lot!

By the way, how about the print below? Should I add something more?

                 if (rid_in != map->input_base)
                         return -ENXIO;
+
+         pr_err(FW_BUG "applying workaround for the conflicting 
mapping\n");

Thanks
Hanjun

