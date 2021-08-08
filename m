Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3FD3E3AE2
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Aug 2021 16:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhHHOqW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 8 Aug 2021 10:46:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:32812 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231218AbhHHOqV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 8 Aug 2021 10:46:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="214305466"
X-IronPort-AV: E=Sophos;i="5.84,305,1620716400"; 
   d="scan'208";a="214305466"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2021 07:46:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,305,1620716400"; 
   d="scan'208";a="673563101"
Received: from aubrey-app.sh.intel.com (HELO [10.239.53.25]) ([10.239.53.25])
  by fmsmga005.fm.intel.com with ESMTP; 08 Aug 2021 07:46:01 -0700
Subject: Re: [PATCH] ACPI/PRM: Deal with table not present or no module found
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1628210784-136676-1-git-send-email-aubrey.li@intel.com>
 <CAJZ5v0hYVMnQFBkQ_yhF83q-CEJuQ7-TN_Hh2P6b2bM9K--xFQ@mail.gmail.com>
From:   Aubrey Li <aubrey.li@linux.intel.com>
Message-ID: <2728924f-25cf-25dc-df0f-d02bbc959b9f@linux.intel.com>
Date:   Mon, 9 Aug 2021 07:53:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hYVMnQFBkQ_yhF83q-CEJuQ7-TN_Hh2P6b2bM9K--xFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 8/6/21 9:23 PM, Rafael J. Wysocki wrote:
> On Fri, Aug 6, 2021 at 2:48 AM Aubrey Li <aubrey.li@intel.com> wrote:
>>
>> On the system PRMT table is not present, dmesg output:
>>
>>         $ dmesg | grep PRM
>>         [    1.532237] ACPI: PRMT not present
>>         [    1.532237] PRM: found 4294967277 modules
>>
>> The result of acpi_table_parse_entries need to be checked and return
>> immediately if PRMT table is not present or no PRM module found.
>>
>> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
>> ---
>>  drivers/acpi/prmt.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
>> index 31cf9ae..1f6007a 100644
>> --- a/drivers/acpi/prmt.c
>> +++ b/drivers/acpi/prmt.c
>> @@ -292,6 +292,12 @@ void __init init_prmt(void)
>>         int mc = acpi_table_parse_entries(ACPI_SIG_PRMT, sizeof(struct acpi_table_prmt) +
>>                                           sizeof (struct acpi_table_prmt_header),
>>                                           0, acpi_parse_prmt, 0);
>> +       /*
>> +        * Return immediately if PRMT table is not present or no PRM module found.
>> +        */
>> +       if (mc <= 0)
>> +               return;
>> +
>>         pr_info("PRM: found %u modules\n", mc);
>>
>>         status = acpi_install_address_space_handler(ACPI_ROOT_OBJECT,
>> --
> 
> Applied as 5.14-rc material, thanks!
> 
> However, since I'm on vacation next week, it will get into linux-next
> after -rc6.
> 

Thanks Rafael!
