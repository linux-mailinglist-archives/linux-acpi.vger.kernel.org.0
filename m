Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88F88D8846
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2019 07:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387714AbfJPF4T (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Oct 2019 01:56:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:27078 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387456AbfJPF4T (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Oct 2019 01:56:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 22:56:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,302,1566889200"; 
   d="scan'208";a="397057384"
Received: from fyin-mobl.ccr.corp.intel.com (HELO [10.239.204.241]) ([10.239.204.241])
  by fmsmga006.fm.intel.com with ESMTP; 15 Oct 2019 22:56:18 -0700
Subject: Re: [PATCH v2] ACPI / processor_idle: use ndelay instead of io port
 access for wait
To:     David Laight <David.Laight@ACULAB.COM>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191015080404.6013-1-fengwei.yin@intel.com>
 <c9f3f4f93bb946f790fce4709253b359@AcuMS.aculab.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
Message-ID: <2b3ce9e9-e805-1b8d-86c3-c8f498a4d3dd@intel.com>
Date:   Wed, 16 Oct 2019 13:56:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c9f3f4f93bb946f790fce4709253b359@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi David,

On 10/15/2019 7:48 PM, David Laight wrote:
> From: Yin Fengwei
>> Sent: 15 October 2019 09:04
>> In function acpi_idle_do_entry(), an ioport access is used for dummy
>> wait to guarantee hardware behavior. But it could trigger unnecessary
>> vmexit in virtualization environment.
>>
>> If we run linux as guest and export all available native C state to
>> guest, we did see many PM timer access triggered VMexit when guest
>> enter deeper C state in our environment (We used ACRN hypervisor
>> instead of kvm or xen which has PM timer emulated and exports all
>> native C state to guest).
>>
>> According to the original comments of this part of code, io port
>> access is only for dummy wait. We could use busy wait instead of io
>> port access to guarantee hardware behavior and avoid unnecessary
>> VMexit.
> 
> You need some hard synchronisation instruction(s) after the inb()
> and before any kind of delay to ensure your delay code is executed
> after the inb() completes.
> 
> I'm pretty sure that inb() is only synchronised with memory reads.
Thanks a lot for the comments.

I didn't find the common serializing instructions API in kernel (only
memory  barrier which is used to make sure of memory access). For Intel
x86, cpuid could be used as serializing instruction. But it's not
suitable for common code here. Do you have any suggestion?

> 
> ...
>> +	/* profiling the time used for dummy wait op */
>> +	ktime_get_real_ts64(&ts0);
>> +	inl(acpi_gbl_FADT.xpm_timer_block.address);
>> +	ktime_get_real_ts64(&ts1);
> 
> That could be dominated by the cost of ktime_get_real_ts64().
> It also need synchronising instructions.
I did some testing. ktime_get_real_ts64() takes much less time than io
port access.

The test code is like:
1.
	local_irq_save(flag);
	ktime_get_real_ts64(&ts0);
	inl(acpi_gbl_FADT.xpm_timer_block.address);
	ktime_get_real_ts64(&ts1);
	local_irq_restore(flag);

2.
	local_irq_save(flag);
	ktime_get_real_ts64(&ts0);
	ktime_get_real_ts64(&ts1);
	local_irq_restore(flag);

The delta in 1 is about 500000ns. And delta in 2 is about
2000ns. The date is gotten on Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz.
So I suppose the impact of ktime_get_real_ts64 is small.

Regards
Yin, Fengwei

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

