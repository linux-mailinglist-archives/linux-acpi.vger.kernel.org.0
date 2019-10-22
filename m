Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04E7FDFDB2
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2019 08:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfJVG3B (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Oct 2019 02:29:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:31908 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbfJVG3A (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 22 Oct 2019 02:29:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 23:29:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,326,1566889200"; 
   d="scan'208";a="397572098"
Received: from fyin-dev.sh.intel.com (HELO [10.239.143.122]) ([10.239.143.122])
  by fmsmga005.fm.intel.com with ESMTP; 21 Oct 2019 23:28:59 -0700
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
From:   Yin Fengwei <fengwei.yin@intel.com>
Message-ID: <b2e0315e-a500-28cf-367e-599a36a975db@intel.com>
Date:   Tue, 22 Oct 2019 22:25:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2566427.rT6C98KLSe@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 2019/10/18 下午6:12, Rafael J. Wysocki wrote:
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
After re-think the scenario again, I'd like to change the patch to
something like following as Rafael suggested:

If it's not in virt guest, we still use inl for dummy wait.
If it's in virt guest, we could assume inb will be trapped to HV and
remove the dummy wait.

I will generate v3 soon.

Regards
Yin, Fengwei

> 
> 
> 
