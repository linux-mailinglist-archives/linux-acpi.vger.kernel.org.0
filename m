Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8233A3B8124
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Jun 2021 13:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbhF3LTq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Jun 2021 07:19:46 -0400
Received: from foss.arm.com ([217.140.110.172]:35640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233706AbhF3LTq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Jun 2021 07:19:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 715D511D4;
        Wed, 30 Jun 2021 04:17:17 -0700 (PDT)
Received: from [10.57.40.45] (unknown [10.57.40.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 155173F5A1;
        Wed, 30 Jun 2021 04:17:12 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=e2=9d=8c_FAIL=3a_Test_report_for_kernel_5=2e13=2e0?=
 =?UTF-8?Q?-rc7_=28arm-next=2c_8ab9b1a9=29?=
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Will Deacon <will@kernel.org>,
        CKI Project <cki-project@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Memory Management <mm-qe@redhat.com>,
        skt-results-master@redhat.com, Jeff Bastian <jbastian@redhat.com>,
        Jan Stancek <jstancek@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        rjw@rjwysocki.net, lenb@kernel.org, guohanjun@huawei.com,
        sudeep.holla@arm.com, ardb@kernel.org, lv.zheng@intel.com,
        tony.luck@intel.com, James Morse <james.morse@arm.com>
References: <cki.6A65B499FE.46BPQ6DJTC@redhat.com>
 <20210625083918.GA2736@willie-the-truck>
 <CA+tGwn=rP_hAMLLtoy_s90ZzBjfMggu7T2Qj8HyFfGh1BGUoRA@mail.gmail.com>
 <31ffe8fc-f5ee-2858-26c5-0fd8bdd68702@arm.com>
 <20210625110944.GB20835@arm.com>
 <48b23351-3dba-bec8-242f-3c918ae55708@arm.com>
 <8a28663f-6541-6ff4-3de0-b140e3f8a5b9@arm.com>
 <20210629144415.GA28457@lpieralisi>
 <14ca6f72-9b0f-ebd7-9cf8-a5d6190c8e5d@arm.com>
 <20210629163543.GA12361@arm.com> <20210630103715.GA12089@lpieralisi>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e548e72c-83a4-2366-dd57-3e746040fea9@arm.com>
Date:   Wed, 30 Jun 2021 12:17:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630103715.GA12089@lpieralisi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021-06-30 11:37, Lorenzo Pieralisi wrote:
> On Tue, Jun 29, 2021 at 05:35:43PM +0100, Catalin Marinas wrote:
>> On Tue, Jun 29, 2021 at 04:14:55PM +0100, Robin Murphy wrote:
>>> On 2021-06-29 15:44, Lorenzo Pieralisi wrote:
>>>> On Tue, Jun 29, 2021 at 12:48:14PM +0100, Robin Murphy wrote:
>>>>> [ +ACPI audience ]
>>>>>
>>>>> On 2021-06-25 12:15, Robin Murphy wrote:
>>>>>> On 2021-06-25 12:09, Catalin Marinas wrote:
>>>>>>> On Fri, Jun 25, 2021 at 12:02:52PM +0100, Robin Murphy wrote:
>>>>>>>> On 2021-06-25 10:52, Veronika Kabatova wrote:
>>>>>>>> [...]
>>>>>>>>>>>            ❌ stress: stress-ng
>>>>>>>>>>
>>>>>>>>>> Oh no, this looks like another alignment fault in memcpy:
>>>>>>>>>>
>>>>>>>>>> [13330.651903] Unable to handle kernel paging request at
>>>>>>>>>> virtual address ffff8000534705ff
>> [...]
>>>>>>>>>> [13330.652218] Call trace:
>>>>>>>>>> [13330.652221]  __memcpy+0x168/0x250
>>>>>>>>>> [13330.652225]  acpi_data_show+0x5c/0x8c
>>>>>>>>>> [13330.652232]  sysfs_kf_bin_read+0x78/0xa0
>>>>>>>>>> [13330.652238]  kernfs_file_read_iter+0x9c/0x1a4
>>>>>>>>>> [13330.652241]  kernfs_fop_read_iter+0x34/0x50
>>>>>>>>>> [13330.652244]  new_sync_read+0xdc/0x154
>>>>>>>>>> [13330.652253]  vfs_read+0x158/0x1e4
>>>>>>>>>> [13330.652260]  ksys_read+0x64/0xec
>>>>>>>>>> [13330.652266]  __arm64_sys_read+0x28/0x34
>>>>>>>>>> [13330.652273]  invoke_syscall+0x50/0x120
>>>>>>>>>> [13330.652280]  el0_svc_common.constprop.0+0x4c/0xd4
>>>>>>>>>> [13330.652284]  do_el0_svc+0x30/0x9c
>>>>>>>>>> [13330.652286]  el0_svc+0x2c/0x54
>>>>>>>>>> [13330.652294]  el0t_64_sync_handler+0x1a4/0x1b0
>>>>>>>>>> [13330.652296]  el0t_64_sync+0x19c/0x1a0
>>>>>>>>>> [13330.652303] Code: a984346c a9c4342c f1010042 54fffee8 (a97c3c8e)
>>>>>>>>>> [13330.652307] ---[ end trace 227d4380f57145d4 ]---
>>>>>>>>>>
>>>>>>>>>> So maybe this issue isn't limited to weird modules, after all...
>>>>>>>>>
>>>>>>>>> It ran on the machine from the same set that we were able to reproduce
>>>>>>>>> it on previously. If you or anyone else have an idea on how
>>>>>>>>> to stabilize the reproducibility or have a debug patch we'll be happy to try it.
>>>>>>>>
>>>>>>>> Possibly it depends on the individual machines' firmware exactly how the
>>>>>>>> relevant bits of their ACPI tables are aligned in memory?
>>>>>>>>
>>>>>>>> I've started digging into that callstack - it may not be a "weird module"
>>>>>>>> but it's definitely crusty ACPI code... a238317ce818 ("ACPI: Clean up
>>>>>>>> acpi_os_map/unmap_memory() to eliminate __iomem.") looks frankly a bit
>>>>>>>> questionable in its decision to blithely cast away __iomem, but then the
>>>>>>>> rationale in aafc65c731fe ("ACPI: add arm64 to the platforms that use
>>>>>>>> ioremap") seems particularly dubious on top of that (especially
>>>>>>>> given this end result).
>> [...]
>>>>> After picking through the UEFI spec I think I've now got a clearer picture
>>>>> of what's happening, but I'm not sure where it goes from here...
>>>>>
>>>>> The spec implies that it *is* legitimate for runtime-loaded ACPI tables to
>>>>> lie outside the EFI memory map, and that case they must be assumed to be
>>>>> uncached, so the behaviour of acpi_os_ioremap() is correct.
>>>>
>>>> I'd agree with the reasoning, it would be good to pinpoint whether
>>>> that's what actually triggers the issue.
>>>>
>>>> I'd like to replicate it if possible (it is TX2 HW but firmware
>>>> config is likely to differ from the HW I have at hand), the
>>>> test command line that triggers the fault would be useful as
>>>> a starting point.
>>>>
>>>> Furthermore, is this a v5.13-rc* regression ? If so it would be
>>>> good to bisect it - I can't recollect arm64 changes that could
>>>> have introduced this regression in the last cycle but I may have
>>>> missed something.
>>>
>>> The actual change which has brought this to light is the update to arm64's
>>> memcpy() routine for 5.13 - the new version is more aggressive at making
>>> unaligned loads from the source buffer, so now triggers alignment faults
>>> more readily when (wrongly) used on iomem mappings in places that were
>>> getting away with it by chance under the previous implementation (see also
>>> [1], for example).
>>
>> I wouldn't revert any of the memcpy() stuff as it just uncovered an
>> existing bug in how the ACPI tables are handled. Could we actually hit
>> a similar issue with C code parsing the ACPI tables?
> 
> I agree - I don't think a revert should be considered, this looks like
> a long standing ACPI bug.
> 
> This needs debugging but I believe that it all depends on the table
> being in the EFI map or not. I'd help a lot if I managed to reproduce
> the bug for a given set-up so that we can check which table is causing
> it.
> 
>> Is there a way to map the ACPI tables as Normal Noncacheable
>> (ioremap_wc)?
> 
> That's a good point. IIUC UEFI 2.9 (2.3.6) requires tables loaded at
> runtime (see above - I really would like to understand what table
> is triggering this bug) that are not in the EFI memory map and whose
> attributes cannot be retrieved through ACPI descriptors to be considered
> non-cacheable.
> 
> The question is whether [arm64] acpi_os_ioremap() can be changed so that
> the above is mapped to Normal NC rather than device-nGnRnE; this may
> cause surprises the other way around (given that dev-nGnRnE is an
> all encompassing fallback - again IIUC, I believe Ard knows better
> than me if he has time to chime in).
> 
> We need a reproducer and some tracing in the ACPI code.

Having looked even more at the sysfs code, I think this might not 
actually be an ACPI table per se, but specifically only the Generic 
Error Status Block pointed to by the BERT (so maybe it also requires the 
machine to have experienced a boot-time error to be present?). ACPI 
merely says that this is "a range of addressable memory" and "System 
firmware must report this memory range as firmware reserved", so I have 
no idea whether there's any specific expectation of how it's supposed to 
be mapped.

Robin.
