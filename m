Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F191DC2F0
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Oct 2019 12:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439363AbfJRKjU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Oct 2019 06:39:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:53275 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439341AbfJRKjT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Oct 2019 06:39:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2019 03:39:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,311,1566889200"; 
   d="scan'208";a="202665862"
Received: from fyin-mobl.ccr.corp.intel.com (HELO [10.239.205.42]) ([10.239.205.42])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Oct 2019 03:39:17 -0700
Subject: Re: [PATCH v2] ACPI / processor_idle: use ndelay instead of io port
 access for wait
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     David Laight <David.Laight@aculab.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191015080404.6013-1-fengwei.yin@intel.com>
 <c9f3f4f93bb946f790fce4709253b359@AcuMS.aculab.com>
 <2b3ce9e9-e805-1b8d-86c3-c8f498a4d3dd@intel.com>
 <2566427.rT6C98KLSe@kreacher>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
Message-ID: <c77ee452-ae82-db56-723c-f26b006b6a18@intel.com>
Date:   Fri, 18 Oct 2019 18:39:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <2566427.rT6C98KLSe@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 10/18/2019 6:12 PM, Rafael J. Wysocki wrote:
> On Wednesday, October 16, 2019 7:56:17 AM CEST Yin, Fengwei wrote:
>> Hi David,
>>
>> On 10/15/2019 7:48 PM, David Laight wrote:
>>> From: Yin Fengwei
>>>> Sent: 15 October 2019 09:04
>>>> In function acpi_idle_do_entry(), an ioport access is used for dummy
>>>> wait to guarantee hardware behavior. But it could trigger unnecessary
>>>> vmexit in virtualization environment.
>>>>
>>>> If we run linux as guest and export all available native C state to
>>>> guest, we did see many PM timer access triggered VMexit when guest
>>>> enter deeper C state in our environment (We used ACRN hypervisor
>>>> instead of kvm or xen which has PM timer emulated and exports all
>>>> native C state to guest).
>>>>
>>>> According to the original comments of this part of code, io port
>>>> access is only for dummy wait. We could use busy wait instead of io
>>>> port access to guarantee hardware behavior and avoid unnecessary
>>>> VMexit.
>>>
>>> You need some hard synchronisation instruction(s) after the inb()
>>> and before any kind of delay to ensure your delay code is executed
>>> after the inb() completes.
>>>
>>> I'm pretty sure that inb() is only synchronised with memory reads.
>> Thanks a lot for the comments.
>>
>> I didn't find the common serializing instructions API in kernel (only
>> memory  barrier which is used to make sure of memory access). For Intel
>> x86, cpuid could be used as serializing instruction. But it's not
>> suitable for common code here. Do you have any suggestion?
> 
> In the virt guest case you don't need to worry at all AFAICS, because the inb()
> itself will trap to the HV.
This is not always valid. If the physical cpu is totally owned by guest 
(not shared with other guest), it's possible we passthru the C state
port to guest. In that case, inb() which trigger C state transaction
doesn't trap to the HV.

> 
>>>
>>> ...
>>>> +	/* profiling the time used for dummy wait op */
>>>> +	ktime_get_real_ts64(&ts0);
>>>> +	inl(acpi_gbl_FADT.xpm_timer_block.address);
>>>> +	ktime_get_real_ts64(&ts1);
> 
> You may as well use ktime_get() for this, as it's almost the same code as
> ktime_get_real_ts64() AFAICS, only simpler.
> 
> Plus, static vars need not be initialized to 0.
Thanks for pointing this out. Will update the patch accordingly.

> 
>>>
>>> That could be dominated by the cost of ktime_get_real_ts64().
>>> It also need synchronising instructions.
>> I did some testing. ktime_get_real_ts64() takes much less time than io
>> port access.
>>
>> The test code is like:
>> 1.
>> 	local_irq_save(flag);
>> 	ktime_get_real_ts64(&ts0);
>> 	inl(acpi_gbl_FADT.xpm_timer_block.address);
>> 	ktime_get_real_ts64(&ts1);
>> 	local_irq_restore(flag);
>>
>> 2.
>> 	local_irq_save(flag);
>> 	ktime_get_real_ts64(&ts0);
>> 	ktime_get_real_ts64(&ts1);
>> 	local_irq_restore(flag);
>>
>> The delta in 1 is about 500000ns. And delta in 2 is about
>> 2000ns. The date is gotten on Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz.
>> So I suppose the impact of ktime_get_real_ts64 is small.
> 
> You may not be hitting the worst case for ktime_get_real_ts64(), though.
> 
> I wonder if special casing the virt guest would be a better approach.
> 
> Then, you could leave the code as is for non-virt and I'm not sure if the
> delay is needed in the virt guest case at all.
> 
> So maybe do something like "if not in a virt guest, do the dummy inl()"
> and that would be it?
Yes. This is better. Which we could control the impact to non-virt env.

Regards
Yin, Fengwei

> 
> 
> 

