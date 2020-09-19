Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F175270B65
	for <lists+linux-acpi@lfdr.de>; Sat, 19 Sep 2020 09:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgISHWe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 19 Sep 2020 03:22:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13721 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726262AbgISHWe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 19 Sep 2020 03:22:34 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F35F044B8B45F45EE860;
        Sat, 19 Sep 2020 15:22:31 +0800 (CST)
Received: from [10.174.179.33] (10.174.179.33) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 15:22:28 +0800
Subject: Re: [PATCH 00/25] ACPI: First step to decouple ACPICA debug
 functionality from ACPI driver
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <1600328345-27627-1-git-send-email-guohanjun@huawei.com>
 <CAJZ5v0hukTBCyNO0Tj=FyOzh4uM=f8bLTToOT4zG3Tn_1KjO0g@mail.gmail.com>
 <28154b60-b07b-24e7-748f-88359d5343cb@huawei.com>
 <CAJZ5v0jfxESXKJDV_JimG-ao58GjfvX6ZT2Sch+qn24ptVOx4w@mail.gmail.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <a792f08d-1680-bfc6-fc8d-01e278a9627f@huawei.com>
Date:   Sat, 19 Sep 2020 15:22:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jfxESXKJDV_JimG-ao58GjfvX6ZT2Sch+qn24ptVOx4w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.33]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On 2020/9/18 21:34, Rafael J. Wysocki wrote:
> On Fri, Sep 18, 2020 at 3:55 AM Hanjun Guo <guohanjun@huawei.com> wrote:
>>
>> Hi Rafael,
>>
>> On 2020/9/17 23:08, Rafael J. Wysocki wrote:
>>> Hi Hanjun,
>>>
>>> On Thu, Sep 17, 2020 at 10:34 AM Hanjun Guo <guohanjun@huawei.com> wrote:
>>>>
>>>> For now, ACPI driver debug functionality is mixed of pr_* functions and
>>>> ACPI_DEBUG_PRINT() which is provided ACPICA core directly, ACPICA debug
>>>> functions are not friendly for users and also make ACPICA core deeply
>>>> coupled with ACPI drivers.
>>>>
>>>> With the evolution of the ACPI driver code, lots of the ACPICA debug
>>>> functions used in ACPI drivers were removed away, this makes the ACPICA
>>>> debug in ACPI driver to be fragile, for example, some of the COMPONENT
>>>> such as ACPI_CONTAINER_COMPONENT and ACPI_MEMORY_DEVICE_COMPONENT are not
>>>> used anymore, they leaved as dead code.
>>>>
>>>>   From another aspert, removing the ACPICA debug functions didn't raise
>>>> concerns in the past, so I believe the ACPICA debug in ACPI driver can be
>>>> removed and replace with equivalent pr_* debug functions, then decouple
>>>> ACPICA debug functionality from ACPI driver.
>>>
>>> This is a worthy goal, but the patch series appears to be a mixed bag
>>> of changes some of which are not directly related to this goal.
>>
>> Sorry for that, I sent this patch set in a hurry, I will update
>> as you suggested.
>>>>
>>>> Hanjun Guo (25):
>>>>     ACPI: cmos_rtc: Remove the ACPI_MODULE_NAME()
>>>
>>> This, for example, should be a separate cleanup patch.
>>
>> ACPI_MODULE_NAME() and _COMPONENT are both used for ACPICA
>> debug functionality, so I will put them in the decouple
>> patch set.
> 
> So if the ACPICA debug functionality is not used in the given C file,
> you can drop these macros from there right away without any side
> effects.
> 
> Why don't you do that in a separate series of patches then?

Good point, so I will split this patch set into four parts:

- The bugfix patch goes in separate from the rest of the series,
   already sent out.

- Cleanup patches which is not related to ACPICA debug,
   - ACPI: debug: Remove the not used function
   - ACPI: memhotplug: Remove the state for memory device
   - ACPI: processor: Remove the duplicated ACPI_PROCESSOR_CLASS macro

   - ACPI: SBS: Simplify the driver init code
   - ACPI: SBS: Simplify the code using module_acpi_driver()
   - ACPI: tiny-power-button: Simplify the code using module_acpi_driver()

- A patch set removing all the leftover ACPICA debug functionality
   which is not used in the C file, no functional change.

- A patch set for actual ABI change (RFC).

Do it make sense to you?

Thanks
Hanjun
