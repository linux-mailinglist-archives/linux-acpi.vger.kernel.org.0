Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99A1BE47F9
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2019 11:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501944AbfJYJ7j (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Oct 2019 05:59:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:6275 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2501943AbfJYJ7j (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 25 Oct 2019 05:59:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 02:59:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="228849164"
Received: from fyin-mobl.ccr.corp.intel.com (HELO [10.239.204.247]) ([10.239.204.247])
  by fmsmga002.fm.intel.com with ESMTP; 25 Oct 2019 02:59:37 -0700
Subject: Re: [PATCH v4] ACPI/processor_idle: Remove dummy wait if kernel is in
 guest
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
References: <20191024070420.4512-1-fengwei.yin@intel.com>
 <CAJZ5v0hU9z3BfAK5x1i4Qw334Wf8o5azaKL9kyAJoADcau3hxA@mail.gmail.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
Message-ID: <13725e35-03ec-abb5-466d-0961775a4800@intel.com>
Date:   Fri, 25 Oct 2019 17:59:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hU9z3BfAK5x1i4Qw334Wf8o5azaKL9kyAJoADcau3hxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 10/25/2019 5:06 PM, Rafael J. Wysocki wrote:
> On Thu, Oct 24, 2019 at 9:04 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>
>> In function acpi_idle_do_entry(), an ioport access is used for
>> dummy wait to guarantee hardware behavior. But it could trigger
>> unnecessary VMexit if kernel is running as guest in virtualization
>> environment.
>>
>> If it's in virtualization environment, the deeper C state enter
>> operation (inb()) will trap to hypervisor. It's not needed to do
>> dummy wait after the inb() call. So we could just remove the
>> dummy io port access to avoid unnecessary VMexit.
>>
>> And keep dummy io port access to maintain timing for native
>> environment.
>>
>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>> ---
>> ChangeLog:
>> v3 -> v4:
>>   - Drop overengineered function pointer and do check whether
>>     we are in guest before dummy inl call.
>>
>> v2 -> v3:
>>   - Remove dummy io port access totally for virtualization env.
>>
>> v1 -> v2:
>>   - Use ndelay instead of dead loop for dummy delay.
>>
>>   drivers/acpi/processor_idle.c | 21 +++++++++++++++------
>>   1 file changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index ed56c6d20b08..2ae95df2e74f 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -642,6 +642,19 @@ static int acpi_idle_bm_check(void)
>>          return bm_status;
>>   }
>>
>> +static void wait_for_freeze(void)
>> +{
>> +#ifdef CONFIG_X86
>> +       /* No delay is needed if we are in guest */
>> +       if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
>> +               return;
>> +#endif
>> +       /* Dummy wait op - must do something useless after P_LVL2 read
>> +          because chipsets cannot guarantee that STPCLK# signal
>> +          gets asserted in time to freeze execution properly. */
>> +       inl(acpi_gbl_FADT.xpm_timer_block.address);
>> +}
>> +
>>   /**
>>    * acpi_idle_do_entry - enter idle state using the appropriate method
>>    * @cx: cstate data
>> @@ -658,10 +671,7 @@ static void __cpuidle acpi_idle_do_entry(struct acpi_processor_cx *cx)
>>          } else {
>>                  /* IO port based C-state */
>>                  inb(cx->address);
>> -               /* Dummy wait op - must do something useless after P_LVL2 read
>> -                  because chipsets cannot guarantee that STPCLK# signal
>> -                  gets asserted in time to freeze execution properly. */
>> -               inl(acpi_gbl_FADT.xpm_timer_block.address);
>> +               wait_for_freeze();
>>          }
>>   }
>>
>> @@ -682,8 +692,7 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
>>                          safe_halt();
>>                  else if (cx->entry_method == ACPI_CSTATE_SYSTEMIO) {
>>                          inb(cx->address);
>> -                       /* See comment in acpi_idle_do_entry() */
>> -                       inl(acpi_gbl_FADT.xpm_timer_block.address);
>> +                       wait_for_freeze();
>>                  } else
>>                          return -ENODEV;
>>          }
>> --
> 
> Applying as 5.5 material, thanks!
Thanks a lot.

Regards
Yin, Fengwei

> 

