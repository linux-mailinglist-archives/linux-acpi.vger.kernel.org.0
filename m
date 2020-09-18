Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897A226EAB8
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Sep 2020 03:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgIRBzT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Sep 2020 21:55:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36078 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726065AbgIRBzT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Sep 2020 21:55:19 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1EE50BC3277EFEE3589E;
        Fri, 18 Sep 2020 09:55:18 +0800 (CST)
Received: from [10.174.179.33] (10.174.179.33) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 09:55:15 +0800
Subject: Re: [PATCH 00/25] ACPI: First step to decouple ACPICA debug
 functionality from ACPI driver
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <1600328345-27627-1-git-send-email-guohanjun@huawei.com>
 <CAJZ5v0hukTBCyNO0Tj=FyOzh4uM=f8bLTToOT4zG3Tn_1KjO0g@mail.gmail.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <28154b60-b07b-24e7-748f-88359d5343cb@huawei.com>
Date:   Fri, 18 Sep 2020 09:55:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hukTBCyNO0Tj=FyOzh4uM=f8bLTToOT4zG3Tn_1KjO0g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.33]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On 2020/9/17 23:08, Rafael J. Wysocki wrote:
> Hi Hanjun,
> 
> On Thu, Sep 17, 2020 at 10:34 AM Hanjun Guo <guohanjun@huawei.com> wrote:
>>
>> For now, ACPI driver debug functionality is mixed of pr_* functions and
>> ACPI_DEBUG_PRINT() which is provided ACPICA core directly, ACPICA debug
>> functions are not friendly for users and also make ACPICA core deeply
>> coupled with ACPI drivers.
>>
>> With the evolution of the ACPI driver code, lots of the ACPICA debug
>> functions used in ACPI drivers were removed away, this makes the ACPICA
>> debug in ACPI driver to be fragile, for example, some of the COMPONENT
>> such as ACPI_CONTAINER_COMPONENT and ACPI_MEMORY_DEVICE_COMPONENT are not
>> used anymore, they leaved as dead code.
>>
>>  From another aspert, removing the ACPICA debug functions didn't raise
>> concerns in the past, so I believe the ACPICA debug in ACPI driver can be
>> removed and replace with equivalent pr_* debug functions, then decouple
>> ACPICA debug functionality from ACPI driver.
> 
> This is a worthy goal, but the patch series appears to be a mixed bag
> of changes some of which are not directly related to this goal.

Sorry for that, I sent this patch set in a hurry, I will update
as you suggested.

> 
>> In order to decouple ACPICA debug functionality from ACPI driver, I do it
>> in two steps:
>>   - Remove the dead ACPICA functionality code, and remove the not used
>>     COMPONENT;
>>   - Remove all the ACPICA debug code from ACPI drivers.
>>
>> This patch set is the first step to decouple ACPICA debug functionality
>> from ACPI driver, just remove the dead ACPICA functionality code and
>> some cleanups for ACPI drivers, should no functional change if you don't
>> apply the last two patches.
>>
>> Patch 1/25 ~ patch 23/25 are removing the dead code and cleanups;
>> Patch 24/25 ~ patch 25/25 are the actual ABI change.
>>
>> If the ABI change is making sense, I will go further to remove the
>> ACPICA debug functionality from ACPI driver, just keep it inside
>> the ACPICA core.
>>
>> Hanjun Guo (25):
>>    ACPI: cmos_rtc: Remove the ACPI_MODULE_NAME()
> 
> This, for example, should be a separate cleanup patch.

ACPI_MODULE_NAME() and _COMPONENT are both used for ACPICA
debug functionality, so I will put them in the decouple
patch set.

> 
>>    ACPI: configfs: Decouple with ACPICA
>>    ACPI: configfs: Add the missing config_item_put()
> 
> This appears to be a fix that should go in separate from the rest of the series.

Will send a fix first!

> 
>>    ACPI: debug: Remove the not used function
> 
> Another separate cleanup.
> 
>>    ACPI: LPSS: Remove the ACPI_MODULE_NAME()
> 
> Yet another one.
> 
> So can you please split up the patch set into several smaller and more
> manageable ones?

Will do, thanks for your comments!

Thanks
Hanjun
