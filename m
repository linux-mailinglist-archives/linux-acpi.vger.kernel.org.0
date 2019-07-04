Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39C755F473
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jul 2019 10:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfGDITR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Jul 2019 04:19:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8696 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726679AbfGDITR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 Jul 2019 04:19:17 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 51232D64E59BC7EDB020;
        Thu,  4 Jul 2019 16:19:14 +0800 (CST)
Received: from [127.0.0.1] (10.184.52.56) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Thu, 4 Jul 2019
 16:19:08 +0800
Subject: Re: [RFC PATCH v2 2/3] arm64: mark all the GICC nodes in MADT as
 possible cpu
To:     Jia He <jiakernel2@gmail.com>, <rjw@rjwysocki.net>,
        <catalin.marinas@arm.com>, <james.morse@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <huawei.libin@huawei.com>,
        <john.garry@huawei.com>, <jonathan.cameron@huawei.com>
References: <1561776155-38975-1-git-send-email-wangxiongfeng2@huawei.com>
 <1561776155-38975-3-git-send-email-wangxiongfeng2@huawei.com>
 <762be90e-7629-ab5e-4c2d-6566b100f2e5@gmail.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <e3bcc250-240e-e2b0-c0d4-d882cf43d255@huawei.com>
Date:   Thu, 4 Jul 2019 16:18:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <762be90e-7629-ab5e-4c2d-6566b100f2e5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.52.56]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2019/7/4 14:46, Jia He wrote:
> 
> On 2019/6/29 10:42, Xiongfeng Wang wrote:
>> We set 'cpu_possible_mask' based on the enabled GICC node in MADT. If
>> the GICC node is disabled, we will skip initializing the kernel data
>> structure for that CPU.
>>
>> To support CPU hotplug, we need to initialize some CPU related data
>> structure in advance. This patch mark all the GICC nodes as possible CPU
>> and only these enabled GICC nodes as present CPU.
>>
>> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>> ---
>>   arch/arm64/kernel/setup.c |  2 +-
>>   arch/arm64/kernel/smp.c   | 11 +++++------
>>   2 files changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index 7e541f9..7f4d12a 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -359,7 +359,7 @@ static int __init topology_init(void)
>>       for_each_online_node(i)
>>           register_one_node(i);
>>   -    for_each_possible_cpu(i) {
>> +    for_each_online_cpu(i) {
> 
> Have you considered the case in non-acpi mode? and setting "maxcpus=n" in host kernel boot
> 
> parameters?

Thanks for your mention. I haven't considered non-acpi mode. I should add ACPI check in
'smp_prepare_cpus()'.
'maxcpus' is check when we actually online the CPU, so I think it is not influenced.

Thanks,
Xiongfeng

> 
> ---
> Cheers,
> Justin (Jia He)
> 
> 
>>           struct cpu *cpu = &per_cpu(cpu_data.cpu, i);
>>           cpu->hotpluggable = 1;
>>           register_cpu(cpu, i);
>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>> index 6dcf960..6d9983c 100644
>> --- a/arch/arm64/kernel/smp.c
>> +++ b/arch/arm64/kernel/smp.c
>> @@ -525,16 +525,14 @@ struct acpi_madt_generic_interrupt *acpi_cpu_get_madt_gicc(int cpu)
>>   {
>>       u64 hwid = processor->arm_mpidr;
>>   -    if (!(processor->flags & ACPI_MADT_ENABLED)) {
>> -        pr_debug("skipping disabled CPU entry with 0x%llx MPIDR\n", hwid);
>> -        return;
>> -    }
>> -
>>       if (hwid & ~MPIDR_HWID_BITMASK || hwid == INVALID_HWID) {
>>           pr_err("skipping CPU entry with invalid MPIDR 0x%llx\n", hwid);
>>           return;
>>       }
>>   +    if (!(processor->flags & ACPI_MADT_ENABLED))
>> +        pr_debug("disabled CPU entry with 0x%llx MPIDR\n", hwid);
>> +
>>       if (is_mpidr_duplicate(cpu_count, hwid)) {
>>           pr_err("duplicate CPU MPIDR 0x%llx in MADT\n", hwid);
>>           return;
>> @@ -755,7 +753,8 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>>           if (err)
>>               continue;
>>   -        set_cpu_present(cpu, true);
>> +        if ((cpu_madt_gicc[cpu].flags & ACPI_MADT_ENABLED))
>> +            set_cpu_present(cpu, true);
>>           numa_store_cpu_info(cpu);
>>       }
>>   }
> 

