Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 788AFD4141
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2019 15:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfJKNao (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Oct 2019 09:30:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:25839 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728002AbfJKNao (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 11 Oct 2019 09:30:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2019 06:30:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,284,1566889200"; 
   d="scan'208";a="346027002"
Received: from fyin-mobl.ccr.corp.intel.com (HELO [10.254.209.213]) ([10.254.209.213])
  by orsmga004.jf.intel.com with ESMTP; 11 Oct 2019 06:30:42 -0700
Subject: Re: [RESEND] ACPI / processor_idle: use dead loop instead of io port
 access for wait
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190909073937.31554-1-fengwei.yin@intel.com>
 <12278756.3dKznOqol2@kreacher>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
Message-ID: <8a65bf97-c066-8e5e-ba82-75e2a6fd5b45@intel.com>
Date:   Fri, 11 Oct 2019 21:30:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <12278756.3dKznOqol2@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 10/11/2019 5:05 PM, Rafael J. Wysocki wrote:
> Sorry for the delay.
No problem.

> 
> On Monday, September 9, 2019 9:39:37 AM CEST Yin Fengwei wrote:
>> In function acpi_idle_do_entry(), we do an io port access to guarantee
>> hardware behavior. But it could trigger unnecessary vmexit for
>> virtualization environemnt.
> 
> Is this a theoretical problem, or do you actually see it?
> 
> If you see it, I'd like to have a pointer to a bug report regarding it
> or similar.
We did see this issue when we run linux as guest with ACRN hypervisor
instead of kvm or xen. In our case, we export all native C states to
guest and let guest choose which C state it will enter.

And we observed many pm timer port access when guest tried to enter
deeper C state (Yes, we emulate pm timer so pm timer access will trigger
vmexit).


> 
>>  From the comments of this part of code, we could use busy wait instead
>> of io port access to guarantee hardware behavior and avoid unnecessary
>> vmexit.
>>
>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>> ---
>>   drivers/acpi/processor_idle.c | 33 ++++++++++++++++++++++++++++++---
>>   1 file changed, 30 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index ed56c6d20b08..676553228e8f 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -55,6 +55,8 @@ struct cpuidle_driver acpi_idle_driver = {
>>   };
>>   
>>   #ifdef CONFIG_ACPI_PROCESSOR_CSTATE
>> +static struct timespec64 dummy_delta = {0L, 0L};
>> +
>>   static
>>   DEFINE_PER_CPU(struct acpi_processor_cx * [CPUIDLE_STATE_MAX], acpi_cstate);
>>   
>> @@ -64,6 +66,18 @@ static int disabled_by_idle_boot_param(void)
>>   		boot_option_idle_override == IDLE_HALT;
>>   }
>>   
>> +static void dummy_wait(void)
>> +{
>> +	struct timespec64 now, target;
>> +
>> +	ktime_get_real_ts64(&now);
>> +	target = timespec64_add(now, dummy_delta);
>> +
>> +	do {
>> +		ktime_get_real_ts64(&now);
>> +	} while (timespec64_compare(&now, &target) < 0);
>> +}
> 
> Why not to use ndelay() instead of this? ->
Yes. ndelay should work also.

> 
>> +
>>   /*
>>    * IBM ThinkPad R40e crashes mysteriously when going into C2 or C3.
>>    * For now disable this. Probably a bug somewhere else.
>> @@ -660,8 +674,12 @@ static void __cpuidle acpi_idle_do_entry(struct acpi_processor_cx *cx)
>>   		inb(cx->address);
>>   		/* Dummy wait op - must do something useless after P_LVL2 read
>>   		   because chipsets cannot guarantee that STPCLK# signal
>> -		   gets asserted in time to freeze execution properly. */
>> -		inl(acpi_gbl_FADT.xpm_timer_block.address);
>> +		   gets asserted in time to freeze execution properly.
>> +
>> +		   Previously, we do io port access here which could trigger
>> +		   unnecessary trap to HV for virtualization env. We use dead
>> +		   loop here to avoid the impact to virtualization env. */
>> +		dummy_wait();
>>   	}
>>   }
>>   
>> @@ -683,7 +701,7 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
>>   		else if (cx->entry_method == ACPI_CSTATE_SYSTEMIO) {
>>   			inb(cx->address);
>>   			/* See comment in acpi_idle_do_entry() */
>> -			inl(acpi_gbl_FADT.xpm_timer_block.address);
>> +			dummy_wait();
>>   		} else
>>   			return -ENODEV;
>>   	}
>> @@ -902,6 +920,7 @@ static inline void acpi_processor_cstate_first_run_checks(void)
>>   {
>>   	acpi_status status;
>>   	static int first_run;
>> +	struct timespec64 ts0, ts1;
>>   
>>   	if (first_run)
>>   		return;
>> @@ -912,6 +931,13 @@ static inline void acpi_processor_cstate_first_run_checks(void)
>>   			  max_cstate);
>>   	first_run++;
>>   
>> +	/* profiling the time used for dummy wait op */
>> +	ktime_get_real_ts64(&ts0);
>> +	inl(acpi_gbl_FADT.xpm_timer_block.address);
>> +	ktime_get_real_ts64(&ts1);
> 
> -> And simply measure the number of nsecs this takes?
Yes. nsecs is fine here. and use udelay in dummy_wait.

Regards
Yin, Fengwei

> 
>> +
>> +	dummy_delta = timespec64_sub(ts1, ts0);
>> +
>>   	if (acpi_gbl_FADT.cst_control && !nocst) {
>>   		status = acpi_os_write_port(acpi_gbl_FADT.smi_command,
>>   					    acpi_gbl_FADT.cst_control, 8);
>> @@ -920,6 +946,7 @@ static inline void acpi_processor_cstate_first_run_checks(void)
>>   					"Notifying BIOS of _CST ability failed"));
>>   	}
>>   }
>> +
>>   #else
>>   
>>   static inline int disabled_by_idle_boot_param(void) { return 0; }
>>
> 
> 
> 
> 

