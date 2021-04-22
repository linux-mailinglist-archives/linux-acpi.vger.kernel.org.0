Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C068636896F
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 01:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbhDVXk0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Apr 2021 19:40:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:63196 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235977AbhDVXk0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Apr 2021 19:40:26 -0400
IronPort-SDR: Mwa9HBkBuiGBzi8SNCZkoqzfanmpxiydE6l2BXGKmlCPz7KqRDLDjXtPqEMrBx57/MkuBeYVMt
 4LUHe24YgGPg==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="259945407"
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="259945407"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 16:39:50 -0700
IronPort-SDR: fmKGgfD1JABtsbStomHNXO8bPJadKSbGD0TkH4jdxKyCaf921nwThakZORy+79MtXxsC6w2vvq
 v3twAiW1iF8g==
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="402011468"
Received: from eassadia-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.4.68])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 16:39:49 -0700
Subject: Re: [PATCH 3/3] x86/acpi, x86/boot: Add multiprocessor wake-up
 support
To:     Thomas Gleixner <tglx@linutronix.de>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andi Kleen <ak@linux.intel.com>
References: <20210422192442.706906-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210422192442.706906-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <87lf99x6nn.ffs@nanos.tec.linutronix.de>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <03d54f69-c172-e2b8-72ec-b91e8e96d643@linux.intel.com>
Date:   Thu, 22 Apr 2021 16:39:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87lf99x6nn.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 4/22/21 4:04 PM, Thomas Gleixner wrote:
> Kuppuswamy!
> 
> On Thu, Apr 22 2021 at 12:24, Kuppuswamy Sathyanarayanan wrote:
>> +static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
>> +{
>> +	acpi_mp_wake_mailbox_init();
>> +
>> +	if (!acpi_mp_wake_mailbox)
>> +		return -EINVAL;
>> +
>> +	WRITE_ONCE(acpi_mp_wake_mailbox->apic_id, apicid);
>> +	WRITE_ONCE(acpi_mp_wake_mailbox->wakeup_vector, start_ip);
>> +	WRITE_ONCE(acpi_mp_wake_mailbox->command, ACPI_MP_WAKE_COMMAND_WAKEUP);
> 
> What's the point of using WRITE_ONCE() here? Where is the required
> READ_ONCE() counterpart and the required documentation in form of a
> comment?

mailbox memory is shared between firmware and OS. We use WRITE_ONCE to notify
compiler about it, and also to preserve the order of writes to these
addresses. As per MADT Wake protocol, once OS update the mailbox command
address with ACPI_MP_*_WAKEUP command, firmware will be bring the AP out sleep
state and trigger the boot process.
Since its a one way communication, we don't need to read the mailbox address
again. So there is no corresponding READ_ONCE() call.

I will add some comments about it in next version.

> 
>> +static int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
>> +				      const unsigned long end)
>> +{
> ...
>> +	acpi_wake_cpu_handler_update(acpi_wakeup_cpu);
> ...
> 
>> +++ b/arch/x86/kernel/apic/probe_32.c
>> @@ -207,3 +207,11 @@ int __init default_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
>>   	}
>>   	return 0;
>>   }
>> +
>> +void __init acpi_wake_cpu_handler_update(wakeup_cpu_handler handler)
>> +{
>> +	struct apic **drv;
>> +
>> +	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++)
>> +		(*drv)->wakeup_secondary_cpu = handler;
>> +}
>> diff --git a/arch/x86/kernel/apic/probe_64.c b/arch/x86/kernel/apic/probe_64.c
>> index c46720f185c0..986dbb68d3c4 100644
>> --- a/arch/x86/kernel/apic/probe_64.c
>> +++ b/arch/x86/kernel/apic/probe_64.c
>> @@ -50,3 +50,11 @@ int __init default_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
>>   	}
>>   	return 0;
>>   }
>> +
>> +void __init acpi_wake_cpu_handler_update(wakeup_cpu_handler handler)
>> +{
>> +	struct apic **drv;
>> +
>> +	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++)
>> +		(*drv)->wakeup_secondary_cpu = handler;
>> +}
> 
> What's the reason for having two verbatim copies of the same function
> which has no dependency on CONFIG_*_32/64 at all?

Initially I thought all ACPI related functions are grouped in probe_*.c.
After some review, now I know its incorrect. I will move the function
definition to apic.c

> 
> Thanks,
> 
>          tglx
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
