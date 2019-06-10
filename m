Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F04AE3B0C1
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Jun 2019 10:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387879AbfFJIbH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 Jun 2019 04:31:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18105 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387862AbfFJIbH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 Jun 2019 04:31:07 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C42DAD8FAD9F6E5E5A51;
        Mon, 10 Jun 2019 16:31:04 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Mon, 10 Jun 2019
 16:30:56 +0800
Subject: Re: [PATCH 2/2] arm64: topology: Use PPTT to determine if PE is a
 thread
To:     Jeremy Linton <jeremy.linton@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190523224015.56270-1-jeremy.linton@arm.com>
 <20190523224015.56270-3-jeremy.linton@arm.com>
 <be03d428-b543-0233-a98b-233f367a6bd0@huawei.com>
 <24541261-f86d-0d19-6275-6e110144e761@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <sudeep.holla@arm.com>, Linuxarm <linuxarm@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>, <yaohongbo@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4c8db8fa-de8e-d9b8-2de3-eda13651f223@huawei.com>
Date:   Mon, 10 Jun 2019 09:30:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <24541261-f86d-0d19-6275-6e110144e761@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 07/06/2019 20:21, Jeremy Linton wrote:
> Hi,
>
> Thanks for testing and looking at this.
>
> On 6/6/19 3:49 AM, John Garry wrote:
>> On 23/05/2019 23:40, Jeremy Linton wrote:
>>> ACPI 6.3 adds a thread flag to represent if a CPU/PE is
>>> actually a thread. Given that the MPIDR_MT bit may not
>>> represent this information consistently on homogeneous machines
>>> we should prefer the PPTT flag if its available.
>>>
>>

Hi Jeremy,

>>
>> I was just wondering if we should look to get this support backported
>> (when merged)?
>
> I imagine that will happen..
>
>>
>> I worry about the case of a system with the CPU having MT bit in the
>> MPIDR (while not actually threaded), i.e. the system for which these
>> PPTT flags were added (as I understand).
>
> I have tested this patch on DAWN which happens to have the MT bit set,
> but isn't threaded, and it appears to work.

Can you describe your test?

>
>>
>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>> ---
>>>  arch/arm64/kernel/topology.c | 8 +++++---
>>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>>> index 0825c4a856e3..cbbedb53cf06 100644
>>> --- a/arch/arm64/kernel/topology.c
>>> +++ b/arch/arm64/kernel/topology.c
>>> @@ -346,11 +346,9 @@ void remove_cpu_topology(unsigned int cpu)
>>>   */
>>>  static int __init parse_acpi_topology(void)
>>>  {
>>> -    bool is_threaded;
>>> +    int is_threaded;
>>>      int cpu, topology_id;
>>>
>>> -    is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
>>> -
>>>      for_each_possible_cpu(cpu) {
>>>          int i, cache_id;
>>>
>>> @@ -358,6 +356,10 @@ static int __init parse_acpi_topology(void)
>>>          if (topology_id < 0)
>>>              return topology_id;
>>>
>>> +        is_threaded = acpi_pptt_cpu_is_thread(cpu);
>>> +        if (is_threaded < 0)
>>> +            is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
>>> +
>>>          if (is_threaded) {
>>>              cpu_topology[cpu].thread_id = topology_id;
>>
>> For described above scenario, this seems wrong.
>
> I'm not sure I understand the concern.

Maybe I wasn't clear enough previously. I am saying that without this 
patch, then this info would not be correct. Hence the request to 
backport to stable.

cheers,

>
> This is going to ignore the MPIDR_MT bit on any machine with a PPTT
> revision > 1. Are you worried about the topology_id assignment?
>
>
>>
>>>              topology_id = find_acpi_cpu_topology(cpu, 1);
>>>
>>
>> BTW, we did test an old kernel with 6.3 PPTT bios for this on D06
>> (some versions have MT bit set), and it looked ok. But I am still a
>> bit skeptical.
>>
>> Thanks,
>> John
>>
>>
>
>
> Thanks,
>
> .
>


