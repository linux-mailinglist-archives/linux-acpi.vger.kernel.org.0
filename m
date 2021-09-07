Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457F94029A9
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Sep 2021 15:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343881AbhIGNYm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Sep 2021 09:24:42 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:41297 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344757AbhIGNYe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 Sep 2021 09:24:34 -0400
Received: from [141.14.13.3] (g258.RadioFreeInternet.molgen.mpg.de [141.14.13.3])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id C1AB661E64846;
        Tue,  7 Sep 2021 15:23:15 +0200 (CEST)
Subject: Re: New warning: PRMT not present
To:     Aubrey Li <aubrey.li@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <64150c95-3f7d-d21f-d6fb-b9d478ed6798@molgen.mpg.de>
 <766862fc-80fa-775b-6e63-6d9422d1d258@molgen.mpg.de>
 <CAJZ5v0i91+kPe4C-wy+oCDvYbR_Vp=MzwEyL+8T3xJU5O4XjRA@mail.gmail.com>
 <c6aaf684-2cd1-f615-34e1-7ef2020ae2d2@molgen.mpg.de>
 <54b6f8cb-4714-587c-b2d0-98134473293d@linux.intel.com>
 <a55ebebc-c8f8-5654-adff-3569d1de2e27@molgen.mpg.de>
 <727d85ff-9efc-42a5-70f1-fcd9fd9e4494@linux.intel.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <e7cbf294-1b0f-cd63-e6cf-3d743e1fe036@molgen.mpg.de>
Date:   Tue, 7 Sep 2021 15:23:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <727d85ff-9efc-42a5-70f1-fcd9fd9e4494@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dear Aubrey,


Am 07.09.21 um 15:02 schrieb Aubrey Li:
> On 9/7/21 3:22 PM, Paul Menzel wrote:

>> Am 07.09.21 um 05:26 schrieb Aubrey Li:
>>
>>> On 9/6/21 10:15 PM, Paul Menzel wrote:
>>
>>>> Am 06.09.21 um 14:02 schrieb Rafael J. Wysocki:
>>>>>
>>>>> This should be addressed by commit 2bbfa0addd63 "ACPI: PRM: Deal with
>>>>> table not present or no module found", or yet another fix is needed.
>>>>
>>>> Linux still warns on my systems with Linux 5.14 and Linus’ master in QEMU i440fx and an Asus F2A85-M PRO.
>>>
>>> Does the following patch address your problem?
>>
>> Yes, it does. With this patch cherry-picked to my Linux tree, the warning is gone in QEMU.
>>
>>      qemu-system-x86_64 -kernel /dev/shm/bzImage -append "earlyprintk=serial,ttyS0,keep console=ttyS0,115200 console=tty0" -display none -serial stdio
>>
>> (I have to check my configuration, why normal serial console does not work in QEMU.)
>>
>>> ----------------------------------------------------------------------
>>>   From 52fda76410fcb7a3661687e960634d34fa44fb5f Mon Sep 17 00:00:00 2001
>>> From: Aubrey Li <aubrey.li@intel.com>
>>> Date: Tue, 7 Sep 2021 11:06:59 +0800
>>> Subject: [PATCH] ACPI/RPM: Find PRMT table before parse it
>>
>> What does RPM mean?
> 
> PRM, Platform Runtime Mechanism:
> https://uefi.org/sites/default/files/resources/Platform%20Runtime%20Mechanism%20-%20with%20legal%20notice.pdf

Ah, so just a typo in the prefix: RPM → PRM.

>>> Find and verify PRMT table before parse it, this eliminates a
>>> warning on machines without PRMT table.
>>
>> Please paste the warning for people grepping the commit messages.
>>
>>      ACPI: PRMT not present
> 
> Nice suggestion.
> 
>>
>>> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
>>> ---
>>>    drivers/acpi/prmt.c | 10 +++++++++-
>>>    1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
>>> index 1f6007a..89c22bc 100644
>>> --- a/drivers/acpi/prmt.c
>>> +++ b/drivers/acpi/prmt.c
>>> @@ -288,10 +288,18 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
>>>      void __init init_prmt(void)
>>>    {
>>> +    struct acpi_table_header *tbl;
>>>        acpi_status status;
>>> -    int mc = acpi_table_parse_entries(ACPI_SIG_PRMT, sizeof(struct acpi_table_prmt) +
>>> +    int mc;
>>> +
>>> +    status = acpi_get_table(ACPI_SIG_PRMT, 0, &tbl);
>>> +    if (ACPI_FAILURE(status))
>>> +        return;
>>> +
>>> +    mc = acpi_table_parse_entries(ACPI_SIG_PRMT, sizeof(struct acpi_table_prmt) +
>>>                          sizeof (struct acpi_table_prmt_header),
>>>                          0, acpi_parse_prmt, 0);
>>> +    acpi_put_table(tbl);
>>>        /*
>>>         * Return immediately if PRMT table is not present or no PRM module found.
>>>         */
>>>
>>
>> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> Thanks for testing, I'll send a formal patch to Rafael.

Thank you.


Kind regards,

Paul
