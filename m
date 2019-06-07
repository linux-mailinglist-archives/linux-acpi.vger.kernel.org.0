Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9980939575
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2019 21:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbfFGTVg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Jun 2019 15:21:36 -0400
Received: from foss.arm.com ([217.140.110.172]:46106 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730111AbfFGTVg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 7 Jun 2019 15:21:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C42DC2B;
        Fri,  7 Jun 2019 12:21:35 -0700 (PDT)
Received: from [192.168.100.221] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F99A3F718;
        Fri,  7 Jun 2019 12:21:35 -0700 (PDT)
Subject: Re: [PATCH 2/2] arm64: topology: Use PPTT to determine if PE is a
 thread
To:     John Garry <john.garry@huawei.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        sudeep.holla@arm.com, Linuxarm <linuxarm@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>, yaohongbo@huawei.com
References: <20190523224015.56270-1-jeremy.linton@arm.com>
 <20190523224015.56270-3-jeremy.linton@arm.com>
 <be03d428-b543-0233-a98b-233f367a6bd0@huawei.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <24541261-f86d-0d19-6275-6e110144e761@arm.com>
Date:   Fri, 7 Jun 2019 14:21:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <be03d428-b543-0233-a98b-233f367a6bd0@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

Thanks for testing and looking at this.

On 6/6/19 3:49 AM, John Garry wrote:
> On 23/05/2019 23:40, Jeremy Linton wrote:
>> ACPI 6.3 adds a thread flag to represent if a CPU/PE is
>> actually a thread. Given that the MPIDR_MT bit may not
>> represent this information consistently on homogeneous machines
>> we should prefer the PPTT flag if its available.
>>
> 
> Hi Jeremy,
> 
> I was just wondering if we should look to get this support backported 
> (when merged)?

I imagine that will happen..

> 
> I worry about the case of a system with the CPU having MT bit in the 
> MPIDR (while not actually threaded), i.e. the system for which these 
> PPTT flags were added (as I understand).

I have tested this patch on DAWN which happens to have the MT bit set, 
but isn't threaded, and it appears to work.

> 
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>  arch/arm64/kernel/topology.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>> index 0825c4a856e3..cbbedb53cf06 100644
>> --- a/arch/arm64/kernel/topology.c
>> +++ b/arch/arm64/kernel/topology.c
>> @@ -346,11 +346,9 @@ void remove_cpu_topology(unsigned int cpu)
>>   */
>>  static int __init parse_acpi_topology(void)
>>  {
>> -    bool is_threaded;
>> +    int is_threaded;
>>      int cpu, topology_id;
>>
>> -    is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
>> -
>>      for_each_possible_cpu(cpu) {
>>          int i, cache_id;
>>
>> @@ -358,6 +356,10 @@ static int __init parse_acpi_topology(void)
>>          if (topology_id < 0)
>>              return topology_id;
>>
>> +        is_threaded = acpi_pptt_cpu_is_thread(cpu);
>> +        if (is_threaded < 0)
>> +            is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
>> +
>>          if (is_threaded) {
>>              cpu_topology[cpu].thread_id = topology_id;
> 
> For described above scenario, this seems wrong.

I'm not sure I understand the concern.

This is going to ignore the MPIDR_MT bit on any machine with a PPTT 
revision > 1. Are you worried about the topology_id assignment?


> 
>>              topology_id = find_acpi_cpu_topology(cpu, 1);
>>
> 
> BTW, we did test an old kernel with 6.3 PPTT bios for this on D06 (some 
> versions have MT bit set), and it looked ok. But I am still a bit 
> skeptical.
> 
> Thanks,
> John
> 
> 


Thanks,
