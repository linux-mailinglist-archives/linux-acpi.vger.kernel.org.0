Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE59659EB8
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Jun 2019 17:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfF1PVv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Jun 2019 11:21:51 -0400
Received: from foss.arm.com ([217.140.110.172]:49976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbfF1PVv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 28 Jun 2019 11:21:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C99C28;
        Fri, 28 Jun 2019 08:21:50 -0700 (PDT)
Received: from [192.168.122.164] (u201426.austin.arm.com [10.118.28.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11A1B3F706;
        Fri, 28 Jun 2019 08:21:50 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] ACPI/PPTT: Add support for ACPI 6.3 thread flag
To:     John Garry <john.garry@huawei.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
        sudeep.holla@arm.com, lenb@kernel.org
References: <20190614223158.49575-1-jeremy.linton@arm.com>
 <20190614223158.49575-2-jeremy.linton@arm.com>
 <667f95c0-5aa9-f460-a49a-e6dfefc027d8@arm.com>
 <2d1b547f-f9ee-391c-c4f3-0232a08a86bc@arm.com>
 <718438d0-8648-897a-83e8-801146a0af86@arm.com>
 <f6f7f9bb-547d-3fd3-f3f8-1d55181f63d7@huawei.com>
 <11fb712f-b3c2-5491-89ee-ea7efb18ddd8@arm.com>
 <63f6c6a8-9d79-ae75-3c15-96bded9b14e4@huawei.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <b7877a38-6c30-af7d-f627-1618684afb55@arm.com>
Date:   Fri, 28 Jun 2019 10:21:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <63f6c6a8-9d79-ae75-3c15-96bded9b14e4@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/19/19 4:15 AM, John Garry wrote:
> On 18/06/2019 22:28, Jeremy Linton wrote:
>> Hi,
>>
>> On 6/18/19 12:23 PM, John Garry wrote:
>>> On 18/06/2019 15:40, Valentin Schneider wrote:
>>>> On 18/06/2019 15:21, Jeremy Linton wrote:
>>>> [...]
>>>>>>> + * Return: -ENOENT if the PPTT doesn't exist, the CPU cannot be
>>>>>>> found or
>>>>>>> + *       the table revision isn't new enough.
>>>>>>> + * Otherwise returns flag value
>>>>>>> + */
>>>>>>
>>>>>> Nit: strictly speaking we're not returning the flag value but its 
>>>>>> mask
>>>>>> applied to the flags field. I don't think anyone will care about
>>>>>> getting
>>>>>> the actual flag value, but it should be made obvious in the doc:
>>>>>
>>>>> Or I clarify the code to actually do what the comments says. Maybe
>>>>> that is what John G was also pointing out too?
>>>>>
>>>
>>> No, I was just saying that the kernel topology can be broken without
>>> this series.
>>>
>>>>
>>>> Mmm I didn't find any reply from John regarding this in v1, but I
>>>> wouldn't
>>>> mind either way, as long as the doc & code are aligned.
>>>>
>>>
>>> BTW, to me, function acpi_pptt_cpu_is_thread() seems to try to do too
>>> much, i.e. check if the PPTT is new enough to support the thread flag
>>> and also check if it is set for a specific cpu. I'd consider separate
>>> functions here.
>>
> 
> Hi,
> 
>> ? Your suggesting replacing the
>>
> 
> I am not saying definitely that this should be changed, it's just that 
> acpi_pptt_cpu_is_thread() returning false, true, or "no entry" is not a 
> typical API format.
> 
> How about acpi_pptt_support_thread_info(cpu) and 
> acpi_pptt_cpu_is_threaded(cpu), both returning false/true only?

I'm not sure we want to be exporting what is effectively a version check 
into the rest of the code. Plus, AFAIK it doesn't really simplify 
anything except the case of ACPI machines with revision 1 PPTTs, because 
those would only be doing a single check and assuming the state of the 
MT bit. That MT check is suspect anyway, although AFAIK it gets the 
right answer on all machines that predate ACPI 6.3..


> 
> None of this is ideal.
> 
> BTW, Have you audited which arm64 systems have MT bit set legitimately?

Not formally, given I don't have access to everything available.

> 
>>
>> if (table->revision >= rev)
> 
> I know that checking the table revision is not on the fast path, but it 
> seems unnecessarily inefficient to always read it this way, I mean 
> calling acpi_table_get().
> 
> Can you have a static value for the table revision? Or is this just how 
> other table info is accessed in ACPI code?

Yes caching the revision internally would save a get/put per core, for 
older machines. I don't think its a big deal in normal operation but its 
a couple extra lines so...

I will post it with an internally cached saved_pptt_rev. That will save 
CPU count get/puts in the case where the revision isn't new enough.


> 
>>     cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
>>
>> check with
>>
>> if (revision_check(table, rev))
>>     cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
>>
>>
>> and a function like
>>
>> static int revision_check(acpixxxx *table, int rev)
>> {
>>     return (table->revision >= rev);
>> }
>>
>> Although, frankly if one were to do this, it should probably be a macro
>> with the table type, and used in the dozen or so other places I found
>> doing similar checks (spcr, iort, etc).
>>
>> Or something else?
>>
>>
>>
>>
> 
> thanks,
> John
