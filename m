Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F8D369752
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 18:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhDWQpE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Apr 2021 12:45:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:21081 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230482AbhDWQpB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Apr 2021 12:45:01 -0400
IronPort-SDR: 9tJWFpEyBmIpbdgVE2gpFRoMG21zRqCF88DntE1COc6N8qmxXNJ7y5bMMkob4+oaIzw9hcIDMq
 Csd+jNh0jDjA==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="195653792"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="195653792"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 09:44:24 -0700
IronPort-SDR: gor60WCeUZ5pyLAO2wrhnuuYC9xzLkw850j5Y1O9fhJUkVSW1FFNkkD8bqwOb17iM922T9otea
 UJUQ3zZb9oBA==
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="456287024"
Received: from aberdasc-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.2.101])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 09:44:23 -0700
Subject: Re: [PATCH v2 1/3] ACPICA: ACPI 6.4: MADT: add Multiprocessor Wakeup
 Mailbox Structure
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     Rafael J Wysocki <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <20210422214708.716164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210422214708.716164-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAJZ5v0itaKL58ieMB6ER47GVns7Ukvd_7VNBAxkktWB5cDv-SQ@mail.gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <4fb6aefe-5873-b04e-dc0b-12dd0c52f411@linux.intel.com>
Date:   Fri, 23 Apr 2021 09:44:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0itaKL58ieMB6ER47GVns7Ukvd_7VNBAxkktWB5cDv-SQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 4/23/21 5:33 AM, Rafael J. Wysocki wrote:
> On Thu, Apr 22, 2021 at 11:47 PM Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>
>> ACPICA commit f1ee04207a212f6c519441e7e25397649ebc4cea
>>
>> Add Multiprocessor Wakeup Mailbox Structure definition. It is useful
>> in parsing MADT Wake table.
>>
>> Link: https://github.com/acpica/acpica/commit/f1ee0420
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> I'm expecting to receive this patch from Erik at one point, so I'm
> guessing that it's been added to this series for reference.

Yes. Since I had dependent patches, Erik sent it to me for
submission.

> 
>> ---
>>   include/acpi/actbl2.h | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
>> index b2362600b9ff..7dce422f6119 100644
>> --- a/include/acpi/actbl2.h
>> +++ b/include/acpi/actbl2.h
>> @@ -733,6 +733,20 @@ struct acpi_madt_multiproc_wakeup {
>>          u64 base_address;
>>   };
>>
>> +#define ACPI_MULTIPROC_WAKEUP_MB_OS_SIZE       2032
>> +#define ACPI_MULTIPROC_WAKEUP_MB_FIRMWARE_SIZE 2048
>> +
>> +struct acpi_madt_multiproc_wakeup_mailbox {
>> +       u16 command;
>> +       u16 reserved;           /* reserved - must be zero */
>> +       u32 apic_id;
>> +       u64 wakeup_vector;
>> +       u8 reserved_os[ACPI_MULTIPROC_WAKEUP_MB_OS_SIZE];       /* reserved for OS use */
>> +       u8 reserved_firmware[ACPI_MULTIPROC_WAKEUP_MB_FIRMWARE_SIZE];   /* reserved for firmware use */
>> +};
>> +
>> +#define ACPI_MP_WAKE_COMMAND_WAKEUP    1
>> +
>>   /*
>>    * Common flags fields for MADT subtables
>>    */
>> --
>> 2.25.1
>>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
