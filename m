Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDEA1E27AE
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Oct 2019 03:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392318AbfJXBWq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Oct 2019 21:22:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:46317 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbfJXBWq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 23 Oct 2019 21:22:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 18:22:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; 
   d="scan'208";a="228325784"
Received: from fyin-dev.sh.intel.com (HELO [10.239.143.122]) ([10.239.143.122])
  by fmsmga002.fm.intel.com with ESMTP; 23 Oct 2019 18:22:44 -0700
Subject: Re: [PATCH v3] ACPI/processor_idle: Remove dummy wait if kernel is in
 guest mode
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>
References: <20191023074945.17016-1-fengwei.yin@intel.com>
 <30ee0a348f624698801691f65eeecd87@AcuMS.aculab.com>
 <CAJZ5v0jizy95pVh1gek5rmaVvGeZUMkVdKJUdesZeXGbj=mwRw@mail.gmail.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
Message-ID: <07760c4a-b3f0-83a3-ed1b-6df45f8deb35@intel.com>
Date:   Thu, 24 Oct 2019 09:22:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jizy95pVh1gek5rmaVvGeZUMkVdKJUdesZeXGbj=mwRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2019/10/23 下午5:03, Rafael J. Wysocki wrote:
> On Wed, Oct 23, 2019 at 10:45 AM David Laight <David.Laight@aculab.com> wrote:
>>
>> From: Yin Fengwei
>>> Sent: 23 October 2019 08:50
>>
>>
>>> In function acpi_idle_do_entry(), an ioport access is used for dummy
>>> wait to guarantee hardware behavior. But it could trigger unnecessary
>>> vmexit if kernel is running as guest in virtualization environtment.
>>>
>>> If it's in virtualization environment, the deeper C state enter
>>> operation (inb()) will trap to hyervisor. It's not needed to do
>>> dummy wait after the inb() call. So we remove the dummy io port
>>> access to avoid unnecessary VMexit.
>>>
>>> We keep dummy io port access to maintain timing for native environment.
>>>
>>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>>> ---
>>> ChangeLog:
>>> v2 -> v3:
>>>   - Remove dummy io port access totally for virtualization env.
>>>
>>> v1 -> v2:
>>>   - Use ndelay instead of dead loop for dummy delay.
>>>
>>>   drivers/acpi/processor_idle.c | 36 ++++++++++++++++++++++++++++++++---
>>>   1 file changed, 33 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>>> index ed56c6d20b08..0c4a97dd6917 100644
>>> --- a/drivers/acpi/processor_idle.c
>>> +++ b/drivers/acpi/processor_idle.c
>>> @@ -58,6 +58,17 @@ struct cpuidle_driver acpi_idle_driver = {
>>>   static
>>>   DEFINE_PER_CPU(struct acpi_processor_cx * [CPUIDLE_STATE_MAX], acpi_cstate);
>>>
>>> +static void (*dummy_wait)(u64 address);
>>> +
>>> +static void default_dummy_wait(u64 address)
>>> +{
>>> +     inl(address);
>>> +}
>>> +
>>> +static void default_noop_wait(u64 address)
>>> +{
>>> +}
>>> +
>>
>> Overengineered...
>> Just add:
>>
>> static void wait_for_freeze(void)
>> {
>> #ifdef  CONFIG_X86
>>          /* No delay is needed if we are a guest */
>>          if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
>>                  return;
>> #endif
>>
>>          /* Dummy wait op - must do something useless after P_LVL2 read
>>             because chipsets cannot guarantee that STPCLK# signal
>>             gets asserted in time to freeze execution properly. */
>>          inl(acpi_gbl_FADT.xpm_timer_block.address);
>> }
>>
>> and use it to replace the inl().
> 
> I was about to make a similar comment.
OK. Will send v4 soon.

Regards
Yin, Fengwei

> 
