Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 449B3198A7C
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Mar 2020 05:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgCaD3R (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Mar 2020 23:29:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12657 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727358AbgCaD3R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 30 Mar 2020 23:29:17 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 78841DC6D5413620629F;
        Tue, 31 Mar 2020 11:29:14 +0800 (CST)
Received: from [127.0.0.1] (10.173.223.234) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Tue, 31 Mar 2020
 11:29:09 +0800
Subject: Re: [PATCH -next] ACPICA: Make acpi_protocol_lengths static
To:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
References: <20200328034706.17840-1-yuehaibing@huawei.com>
 <CAJZ5v0ikZoo5bgrfUsGic7FTCZQu7m_EYLDH1LMcMGNwNjtvqw@mail.gmail.com>
 <CY4PR11MB171942777865293C74EF1D9AF0CB0@CY4PR11MB1719.namprd11.prod.outlook.com>
CC:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <81c23927-e3eb-dd97-6b9d-5e91d19a61b8@huawei.com>
Date:   Tue, 31 Mar 2020 11:29:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CY4PR11MB171942777865293C74EF1D9AF0CB0@CY4PR11MB1719.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020/3/31 1:52, Kaneda, Erik wrote:
> 
> 
>> -----Original Message-----
>> From: linux-acpi-owner@vger.kernel.org <linux-acpi-
>> owner@vger.kernel.org> On Behalf Of Rafael J. Wysocki
>> Sent: Saturday, March 28, 2020 2:14 AM
>> To: YueHaibing <yuehaibing@huawei.com>; Moore, Robert
>> <robert.moore@intel.com>; Kaneda, Erik <erik.kaneda@intel.com>
>> Cc: Wysocki, Rafael J <rafael.j.wysocki@intel.com>; Len Brown
>> <lenb@kernel.org>; ACPI Devel Maling List <linux-acpi@vger.kernel.org>;
>> open list:ACPI COMPONENT ARCHITECTURE (ACPICA) <devel@acpica.org>;
>> Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
>> Subject: Re: [PATCH -next] ACPICA: Make acpi_protocol_lengths static
>>
>> On Sat, Mar 28, 2020 at 4:47 AM YueHaibing <yuehaibing@huawei.com>
>> wrote:
>>>
>>> Fix sparse warning:
>>>
>>> drivers/acpi/acpica/exfield.c:25:10: warning:
>>>  symbol 'acpi_protocol_lengths' was not declared. Should it be static?
>  
> I don’t understand what sparse is trying to say here. This variable is declared in exfield.c...
> Could you provide more details on this sparse warning?

This is sparse -Wdel option's job, see man manual:

       -Wdecl Warn about any non-static variable or function definition that
              has no previous declaration.

              Private symbols (functions and variables) internal to a given
              source file should use static, to allow additional compiler
              optimizations, allow detection of unused symbols, and prevent
              other code from relying on these internal symbols.  Public
              symbols used by other source files will need declarations
              visible to those other source files, such as in a header file.
              All declarations should fall into one of these two categories.
              Thus, with -Wdecl, Sparse warns about any symbol definition
              with neither static nor a declaration.  To fix this warning,
              declare private symbols static, and ensure that the files
              defining public symbols have the symbol declarations available
              first (such as by including the appropriate header file).

> 
> Erik
> 
>>>
>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>
>> Bob, Erik, I'm leaving this one to you.
>>
>>> ---
>>>  drivers/acpi/acpica/exfield.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/acpi/acpica/exfield.c
>>> b/drivers/acpi/acpica/exfield.c index e85eb31e5075..3323a2ba6a31
>>> 100644
>>> --- a/drivers/acpi/acpica/exfield.c
>>> +++ b/drivers/acpi/acpica/exfield.c
>>> @@ -22,7 +22,7 @@ ACPI_MODULE_NAME("exfield")
>>>   */
>>>  #define ACPI_INVALID_PROTOCOL_ID        0x80
>>>  #define ACPI_MAX_PROTOCOL_ID            0x0F
>>> -const u8 acpi_protocol_lengths[] = {
>>> +static const u8 acpi_protocol_lengths[] = {
>>>         ACPI_INVALID_PROTOCOL_ID,       /* 0 - reserved */
>>>         ACPI_INVALID_PROTOCOL_ID,       /* 1 - reserved */
>>>         0x00,                   /* 2 - ATTRIB_QUICK */
>>> --
>>> 2.17.1
>>>
>>>

