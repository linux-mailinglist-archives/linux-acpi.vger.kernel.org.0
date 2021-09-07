Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B90402954
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Sep 2021 15:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344499AbhIGNEv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Sep 2021 09:04:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:24565 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344592AbhIGNEv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 Sep 2021 09:04:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="220217769"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="220217769"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 06:03:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="430911363"
Received: from unknown (HELO [10.239.53.25]) ([10.239.53.25])
  by orsmga003.jf.intel.com with ESMTP; 07 Sep 2021 06:03:42 -0700
Subject: Re: New warning: PRMT not present
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
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
From:   Aubrey Li <aubrey.li@linux.intel.com>
Message-ID: <727d85ff-9efc-42a5-70f1-fcd9fd9e4494@linux.intel.com>
Date:   Tue, 7 Sep 2021 21:02:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a55ebebc-c8f8-5654-adff-3569d1de2e27@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 9/7/21 3:22 PM, Paul Menzel wrote:
> Dear Aubrey,
> 
> 
> Thank you very much for quick reply.
> 
> 
> Am 07.09.21 um 05:26 schrieb Aubrey Li:
> 
>> On 9/6/21 10:15 PM, Paul Menzel wrote:
> 
>>> Am 06.09.21 um 14:02 schrieb Rafael J. Wysocki:
>>>>
>>>> This should be addressed by commit 2bbfa0addd63 "ACPI: PRM: Deal with
>>>> table not present or no module found", or yet another fix is needed.
>>>
>>> Linux still warns on my systems with Linux 5.14 and Linus’ master in QEMU i440fx and an Asus F2A85-M PRO.
>>
>> Does the following patch address your problem?
> 
> Yes, it does. With this patch cherry-picked to my Linux tree, the warning is gone in QEMU.
> 
>     qemu-system-x86_64 -kernel /dev/shm/bzImage -append "earlyprintk=serial,ttyS0,keep console=ttyS0,115200 console=tty0" -display none -serial stdio
> 
> (I have to check my configuration, why normal serial console does not work in QEMU.)
> 
>> ----------------------------------------------------------------------
>>  From 52fda76410fcb7a3661687e960634d34fa44fb5f Mon Sep 17 00:00:00 2001
>> From: Aubrey Li <aubrey.li@intel.com>
>> Date: Tue, 7 Sep 2021 11:06:59 +0800
>> Subject: [PATCH] ACPI/RPM: Find PRMT table before parse it
> 
> What does RPM mean?

PRM, Platform Runtime Mechanism:
https://uefi.org/sites/default/files/resources/Platform%20Runtime%20Mechanism%20-%20with%20legal%20notice.pdf

> 
>> Find and verify PRMT table before parse it, this eliminates a
>> warning on machines without PRMT table.
> 
> Please paste the warning for people grepping the commit messages.
> 
>     ACPI: PRMT not present

Nice suggestion.

> 
>> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
>> ---
>>   drivers/acpi/prmt.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
>> index 1f6007a..89c22bc 100644
>> --- a/drivers/acpi/prmt.c
>> +++ b/drivers/acpi/prmt.c
>> @@ -288,10 +288,18 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
>>     void __init init_prmt(void)
>>   {
>> +    struct acpi_table_header *tbl;
>>       acpi_status status;
>> -    int mc = acpi_table_parse_entries(ACPI_SIG_PRMT, sizeof(struct acpi_table_prmt) +
>> +    int mc;
>> +
>> +    status = acpi_get_table(ACPI_SIG_PRMT, 0, &tbl);
>> +    if (ACPI_FAILURE(status))
>> +        return;
>> +
>> +    mc = acpi_table_parse_entries(ACPI_SIG_PRMT, sizeof(struct acpi_table_prmt) +
>>                         sizeof (struct acpi_table_prmt_header),
>>                         0, acpi_parse_prmt, 0);
>> +    acpi_put_table(tbl);
>>       /*
>>        * Return immediately if PRMT table is not present or no PRM module found.
>>        */
>>
> 
> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>

Thanks for testing, I'll send a formal patch to Rafael.
> 
> 
> Kind regards,
> 
> Paul

