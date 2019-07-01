Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF1854EF61
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2019 21:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfFUTZw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Jun 2019 15:25:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfFUTZw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Jun 2019 15:25:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ADB62308FBB1;
        Fri, 21 Jun 2019 19:25:30 +0000 (UTC)
Received: from [10.36.116.40] (ovpn-116-40.ams2.redhat.com [10.36.116.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AAD15C21E;
        Fri, 21 Jun 2019 19:25:21 +0000 (UTC)
Subject: Re: [PATCH v3 0/6] mm: Further memory block device cleanups
To:     Qian Cai <cai@lca.pw>, linux-kernel@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org, Andrew Banman <andrew.banman@hpe.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arun KS <arunks@codeaurora.org>, Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Juergen Gross <jgross@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Len Brown <lenb@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "mike.travis@hpe.com" <mike.travis@hpe.com>,
        Oscar Salvador <osalvador@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Paul Mackerras <paulus@samba.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>
References: <20190620183139.4352-1-david@redhat.com>
 <1561130120.5154.47.camel@lca.pw>
 <1c2edc22-afd7-2211-c4c7-40e54e5007e8@redhat.com>
 <5b4e4f85-8f3e-0a15-6c85-704512205a42@redhat.com>
 <1561144059.5154.52.camel@lca.pw>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <d9c9ca84-8747-6309-7dd2-69b959fe15b3@redhat.com>
Date:   Fri, 21 Jun 2019 21:25:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561144059.5154.52.camel@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 21 Jun 2019 19:25:51 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 21.06.19 21:07, Qian Cai wrote:
> On Fri, 2019-06-21 at 20:56 +0200, David Hildenbrand wrote:
>> On 21.06.19 20:24, David Hildenbrand wrote:
>>> On 21.06.19 17:15, Qian Cai wrote:
>>>> On Thu, 2019-06-20 at 20:31 +0200, David Hildenbrand wrote:
>>>>> @Andrew: Only patch 1, 4 and 6 changed compared to v1.
>>>>>
>>>>> Some further cleanups around memory block devices. Especially, clean up
>>>>> and simplify walk_memory_range(). Including some other minor cleanups.
>>>>>
>>>>> Compiled + tested on x86 with DIMMs under QEMU. Compile-tested on ppc64.
>>>>>
>>>>> v2 -> v3:
>>>>> - "mm/memory_hotplug: Rename walk_memory_range() and pass start+size .."
>>>>> -- Avoid warning on ppc.
>>>>> - "drivers/base/memory.c: Get rid of find_memory_block_hinted()"
>>>>> -- Fixup a comment regarding hinted devices.
>>>>>
>>>>> v1 -> v2:
>>>>> - "mm: Section numbers use the type "unsigned long""
>>>>> -- "unsigned long i" -> "unsigned long nr", in one case -> "int i"
>>>>> - "drivers/base/memory.c: Get rid of find_memory_block_hinted("
>>>>> -- Fix compilation error
>>>>> -- Get rid of the "hint" parameter completely
>>>>>
>>>>> David Hildenbrand (6):
>>>>>   mm: Section numbers use the type "unsigned long"
>>>>>   drivers/base/memory: Use "unsigned long" for block ids
>>>>>   mm: Make register_mem_sect_under_node() static
>>>>>   mm/memory_hotplug: Rename walk_memory_range() and pass start+size
>>>>>     instead of pfns
>>>>>   mm/memory_hotplug: Move and simplify walk_memory_blocks()
>>>>>   drivers/base/memory.c: Get rid of find_memory_block_hinted()
>>>>>
>>>>>  arch/powerpc/platforms/powernv/memtrace.c |  23 ++---
>>>>>  drivers/acpi/acpi_memhotplug.c            |  19 +---
>>>>>  drivers/base/memory.c                     | 120 +++++++++++++---------
>>>>>  drivers/base/node.c                       |   8 +-
>>>>>  include/linux/memory.h                    |   5 +-
>>>>>  include/linux/memory_hotplug.h            |   2 -
>>>>>  include/linux/mmzone.h                    |   4 +-
>>>>>  include/linux/node.h                      |   7 --
>>>>>  mm/memory_hotplug.c                       |  57 +---------
>>>>>  mm/sparse.c                               |  12 +--
>>>>>  10 files changed, 106 insertions(+), 151 deletions(-)
>>>>>
>>>>
>>>> This series causes a few machines are unable to boot triggering endless
>>>> soft
>>>> lockups. Reverted those commits fixed the issue.
>>>>
>>>> 97f4217d1da0 Revert "mm/memory_hotplug: rename walk_memory_range() and
>>>> pass
>>>> start+size instead of pfns"
>>>> c608eebf33c6 Revert "mm-memory_hotplug-rename-walk_memory_range-and-pass-
>>>> startsize-instead-of-pfns-fix"
>>>> 34b5e4ab7558 Revert "mm/memory_hotplug: move and simplify
>>>> walk_memory_blocks()"
>>>> 59a9f3eec5d1 Revert "drivers/base/memory.c: Get rid of
>>>> find_memory_block_hinted()"
>>>> 5cfcd52288b6 Revert "drivers-base-memoryc-get-rid-of-
>>>> find_memory_block_hinted-
>>>> v3"
>>>>
>>>> [    4.582081][    T1] ACPI FADT declares the system doesn't support PCIe
>>>> ASPM,
>>>> so disable it
>>>> [    4.590405][    T1] ACPI: bus type PCI registered
>>>> [    4.592908][    T1] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
>>>> 0x80000000-0x8fffffff] (base 0x80000000)
>>>> [    4.601860][    T1] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff]
>>>> reserved in
>>>> E820
>>>> [    4.601860][    T1] PCI: Using configuration type 1 for base access
>>>> [   28.661336][   C16] watchdog: BUG: soft lockup - CPU#16 stuck for 22s!
>>>> [swapper/0:1]
>>>> [   28.671351][   C16] Modules linked in:
>>>> [   28.671354][   C16] CPU: 16 PID: 1 Comm: swapper/0 Not tainted 5.2.0-
>>>> rc5-
>>>> next-20190621+ #1
>>>> [   28.681366][   C16] Hardware name: HPE ProLiant DL385 Gen10/ProLiant
>>>> DL385
>>>> Gen10, BIOS A40 03/09/2018
>>>> [   28.691334][   C16] RIP: 0010:_raw_spin_unlock_irqrestore+0x2f/0x40
>>>> [   28.701334][   C16] Code: 55 48 89 e5 41 54 49 89 f4 be 01 00 00 00 53
>>>> 48 8b
>>>> 55 08 48 89 fb 48 8d 7f 18 e8 4c 89 7d ff 48 89 df e8 94 f9 7d ff 41 54 9d
>>>> <65>
>>>> ff 0d c2 44 8d 48 5b 41 5c 5d c3 0f 1f 44 00 00 0f 1f 44 00 00
>>>> [   28.711354][   C16] RSP: 0018:ffff888205b27bf8 EFLAGS: 00000246
>>>> ORIG_RAX:
>>>> ffffffffffffff13
>>>> [   28.721372][   C16] RAX: 0000000000000000 RBX: ffff8882053d6138 RCX:
>>>> ffffffffb6f2a3b8
>>>> [   28.731371][   C16] RDX: 1ffff11040a7ac27 RSI: dffffc0000000000 RDI:
>>>> ffff8882053d6138
>>>> [   28.741371][   C16] RBP: ffff888205b27c08 R08: ffffed1040a7ac28 R09:
>>>> ffffed1040a7ac27
>>>> [   28.751334][   C16] R10: ffffed1040a7ac27 R11: ffff8882053d613b R12:
>>>> 0000000000000246
>>>> [   28.751370][   C16] R13: ffff888205b27c98 R14: ffff8884504d0a20 R15:
>>>> 0000000000000000
>>>> [   28.761368][   C16] FS:  0000000000000000(0000)
>>>> GS:ffff888454500000(0000)
>>>> knlGS:0000000000000000
>>>> [   28.771373][   C16] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [   28.781334][   C16] CR2: 0000000000000000 CR3: 00000007c9012000 CR4:
>>>> 00000000001406a0
>>>> [   28.791333][   C16] Call Trace:
>>>> [   28.791374][   C16]  klist_next+0xd8/0x1c0
>>>> [   28.791374][   C16]  subsys_find_device_by_id+0x13b/0x1f0
>>>> [   28.801334][   C16]  ? bus_find_device_by_name+0x20/0x20
>>>> [   28.801370][   C16]  ? kobject_put+0x23/0x250
>>>> [   28.811333][   C16]  walk_memory_blocks+0x6c/0xb8
>>>> [   28.811353][   C16]  ? write_policy_show+0x40/0x40
>>>> [   28.821334][   C16]  link_mem_sections+0x7e/0xa0
>>>> [   28.821369][   C16]  ? unregister_memory_block_under_nodes+0x210/0x210
>>>> [   28.831353][   C16]  ? __register_one_node+0x3bd/0x600
>>>> [   28.831353][   C16]  topology_init+0xbf/0x126
>>>> [   28.841364][   C16]  ? enable_cpu0_hotplug+0x1a/0x1a
>>>> [   28.841368][   C16]  do_one_initcall+0xfe/0x45a
>>>> [   28.851334][   C16]  ? initcall_blacklisted+0x150/0x150
>>>> [   28.851353][   C16]  ? kasan_check_write+0x14/0x20
>>>> [   28.861333][   C16]  ? up_write+0x75/0x140
>>>> [   28.861369][   C16]  kernel_init_freeable+0x619/0x6ac
>>>> [   28.871333][   C16]  ? rest_init+0x188/0x188
>>>> [   28.871353][   C16]  kernel_init+0x11/0x138
>>>> [   28.881363][   C16]  ? rest_init+0x188/0x188
>>>> [   28.881363][   C16]  ret_from_fork+0x22/0x40
>>>> [   56.661336][   C16] watchdog: BUG: soft lockup - CPU#16 stuck for 22s!
>>>> [swapper/0:1]
>>>> [   56.671352][   C16] Modules linked in:
>>>> [   56.671354][   C16] CPU: 16 PID: 1 Comm: swapper/0 Tainted:
>>>> G             L    5.2.0-rc5-next-20190621+ #1
>>>> [   56.681357][   C16] Hardware name: HPE ProLiant DL385 Gen10/ProLiant
>>>> DL385
>>>> Gen10, BIOS A40 03/09/2018
>>>> [   56.691356][   C16] RIP: 0010:subsys_find_device_by_id+0x168/0x1f0
>>>> [   56.701334][   C16] Code: 48 85 c0 74 3e 48 8d 78 58 e8 14 77 ca ff 4d
>>>> 8b 7e
>>>> 58 4d 85 ff 74 2c 49 8d bf a0 03 00 00 e8 bf 75 ca ff 45 39 a7 a0 03 00 00
>>>> <75>
>>>> c9 4c 89 ff e8 0e 89 ff ff 48 85 c0 74 bc 48 89 df e8 21 3b 24
>>>> [   56.721333][   C16] RSP: 0018:ffff888205b27c68 EFLAGS: 00000287
>>>> ORIG_RAX:
>>>> ffffffffffffff13
>>>> [   56.721370][   C16] RAX: 0000000000000000 RBX: ffff888205b27c90 RCX:
>>>> ffffffffb74c9dc1
>>>> [   56.731370][   C16] RDX: 0000000000000003 RSI: dffffc0000000000 RDI:
>>>> ffff8888774ec3e0
>>>> [   56.741371][   C16] RBP: ffff888205b27cf8 R08: ffffed1040a7ac28 R09:
>>>> ffffed1040a7ac27
>>>> [   56.751335][   C16] R10: ffffed1040a7ac27 R11: ffff8882053d613b R12:
>>>> 0000000000085c1b
>>>> [   56.761334][   C16] R13: 1ffff11040b64f8e R14: ffff888450de4a20 R15:
>>>> ffff8888774ec040
>>>> [   56.761372][   C16] FS:  0000000000000000(0000)
>>>> GS:ffff888454500000(0000)
>>>> knlGS:0000000000000000
>>>> [   56.771374][   C16] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [   56.781370][   C16] CR2: 0000000000000000 CR3: 00000007c9012000 CR4:
>>>> 00000000001406a0
>>>> [   56.791373][   C16] Call Trace:
>>>> [   56.791373][   C16]  ? bus_find_device_by_name+0x20/0x20
>>>> [   56.801334][   C16]  ? kobject_put+0x23/0x250
>>>> [   56.801334][   C16]  walk_memory_blocks+0x6c/0xb8
>>>> [   56.811333][   C16]  ? write_policy_show+0x40/0x40
>>>> [   56.811353][   C16]  link_mem_sections+0x7e/0xa0
>>>> [   56.811353][   C16]  ? unregister_memory_block_under_nodes+0x210/0x210
>>>> [   56.821333][   C16]  ? __register_one_node+0x3bd/0x600
>>>> [   56.831333][   C16]  topology_init+0xbf/0x126
>>>> [   56.831355][   C16]  ? enable_cpu0_hotplug+0x1a/0x1a
>>>> [   56.841334][   C16]  do_one_initcall+0xfe/0x45a
>>>> [   56.841334][   C16]  ? initcall_blacklisted+0x150/0x150
>>>> [   56.851333][   C16]  ? kasan_check_write+0x14/0x20
>>>> [   56.851354][   C16]  ? up_write+0x75/0x140
>>>> [   56.861333][   C16]  kernel_init_freeable+0x619/0x6ac
>>>> [   56.861333][   C16]  ? rest_init+0x188/0x188
>>>> [   56.861369][   C16]  kernel_init+0x11/0x138
>>>> [   56.871333][   C16]  ? rest_init+0x188/0x188
>>>> [   56.871354][   C16]  ret_from_fork+0x22/0x40
>>>> [   64.601362][   C16] rcu: INFO: rcu_sched self-detected stall on CPU
>>>> [   64.611335][   C16] rcu: 	16-....: (5958 ticks this GP)
>>>> idle=37e/1/0x4000000000000002 softirq=27/27 fqs=3000 
>>>> [   64.621334][   C16] 	(t=6002 jiffies g=-1079 q=25)
>>>> [   64.621334][   C16] NMI backtrace for cpu 16
>>>> [   64.621374][   C16] CPU: 16 PID: 1 Comm: swapper/0 Tainted:
>>>> G             L    5.2.0-rc5-next-20190621+ #1
>>>> [   64.631372][   C16] Hardware name: HPE ProLiant DL385 Gen10/ProLiant
>>>> DL385
>>>> Gen10, BIOS A40 03/09/2018
>>>> [   64.641371][   C16] Call Trace:
>>>> [   64.651337][   C16]  <IRQ>
>>>> [   64.651376][   C16]  dump_stack+0x62/0x9a
>>>> [   64.651376][   C16]  nmi_cpu_backtrace.cold.0+0x2e/0x33
>>>> [   64.661337][   C16]  ? nmi_cpu_backtrace_handler+0x20/0x20
>>>> [   64.661337][   C16]  nmi_trigger_cpumask_backtrace+0x1a6/0x1b9
>>>> [   64.671353][   C16]  arch_trigger_cpumask_backtrace+0x19/0x20
>>>> [   64.681366][   C16]  rcu_dump_cpu_stacks+0x18b/0x1d6
>>>> [   64.681366][   C16]  rcu_sched_clock_irq.cold.64+0x368/0x791
>>>> [   64.691336][   C16]  ? kasan_check_read+0x11/0x20
>>>> [   64.691354][   C16]  ? __raise_softirq_irqoff+0x66/0x150
>>>> [   64.701336][   C16]  update_process_times+0x2f/0x60
>>>> [   64.701362][   C16]  tick_periodic+0x38/0xe0
>>>> [   64.711334][   C16]  tick_handle_periodic+0x2e/0x80
>>>> [   64.711353][   C16]  smp_apic_timer_interrupt+0xfb/0x370
>>>> [   64.721367][   C16]  apic_timer_interrupt+0xf/0x20
>>>> [   64.721367][   C16]  </IRQ>
>>>> [   64.721367][   C16] RIP: 0010:_raw_spin_unlock_irqrestore+0x2f/0x40
>>>> [   64.731370][   C16] Code: 55 48 89 e5 41 54 49 89 f4 be 01 00 00 00 53 
>>>>
>>>
>>> @Qian Cai, unfortunately I can't reproduce.
>>>
>>> If you get the chance, it would be great if you could retry with
>>>
>>> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>>> index 972c5336bebf..742f99ddd148 100644
>>> --- a/drivers/base/memory.c
>>> +++ b/drivers/base/memory.c
>>> @@ -868,6 +868,9 @@ int walk_memory_blocks(unsigned long start, unsigned
>>> long size,
>>>         unsigned long block_id;
>>>         int ret = 0;
>>>
>>> +       if (!size)
>>> +               return;
>>> +
>>>         for (block_id = start_block_id; block_id <= end_block_id;
>>> block_id++) {
>>>                 mem = find_memory_block_by_id(block_id);
>>>                 if (!mem)
>>>
>>>
>>>
>>> If both, start and size are 0, we would get a veeeery long loop. This
>>> would mean that we have an online node that does not span any pages at
>>> all (pgdat->node_start_pfn = 0, start_pfn + pgdat->node_spanned_pages = 0).
>>>
>>
>>
>> ...trying to reproduce with QEMU (setting 0MB for the second node):
>>
>> qemu-system-x86_64 --enable-kvm -m 4G,maxmem=20G,slots=2 \
>> 	-smp sockets=2,cores=1 \
>> 	-numa node,nodeid=0,cpus=0,mem=4G \
>> 	-numa node,nodeid=1,cpus=1,mem=0 ...
>>
>> I can indeed see that the node is online and
>> "pgdat->node_start_pfn == 0 && start_pfn + pgdat->node_spanned_pages == 0".
>>
>> However, the kernel segfaults in an unrelated code path, so I can't
>> verify if this solves this problem:
>>
>> [    0.313284] BUG: kernel NULL pointer dereference, address: 00000000000000a0
>> [    0.313479] #PF: supervisor read access in kernel mode
>> [    0.313479] #PF: error_code(0x0000) - not-present page
>> [    0.313479] PGD 0 P4D 0 
>> [    0.313479] Oops: 0000 [#1] SMP PTI
>> [    0.313479] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.2.0-rc5-next-
>> 20190620+ #56
>> [    0.313479] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>> rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.4
>> [    0.313479] RIP: 0010:bus_add_device+0x59/0x110
>> [    0.313479] Code: 20 48 89 df e8 f8 b4 ff ff 41 89 c4 85 c0 0f 85 81 00 00
>> 00 48 8b 53 50 48 85 d2 75 03 48 8b 135
>> [    0.313479] RSP: 0000:ffffb4a6c0013e20 EFLAGS: 00010246
>> [    0.313479] RAX: 0000000000000000 RBX: ffff8b61bac23800 RCX:
>> 0000000000000000
>> [    0.313479] RDX: ffff8b61bac29038 RSI: ffff8b61bac23800 RDI:
>> ffff8b61bac23800
>> [    0.313479] RBP: ffffffff9d2f4500 R08: 0000000000000000 R09:
>> 0000000000000001
>> [    0.313479] R10: 0000000000000000 R11: ffff8b61bad20878 R12:
>> 0000000000000000
>> [    0.313479] R13: 0000000000000000 R14: 0000000000000000 R15:
>> 0000000000000000
>> [    0.313479] FS:  0000000000000000(0000) GS:ffff8b61bba00000(0000)
>> knlGS:0000000000000000
>> [    0.313479] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [    0.313479] CR2: 00000000000000a0 CR3: 0000000013c24000 CR4:
>> 00000000000006f0
>> [    0.313479] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>> 0000000000000000
>> [    0.313479] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>> 0000000000000400
>> [    0.313479] Call Trace:
>> [    0.313479]  device_add+0x304/0x660
>> [    0.313479]  ? __init_waitqueue_head+0x31/0x50
>> [    0.313479]  __register_one_node+0x67/0x170
>> [    0.313479]  __try_online_node.cold+0x3e/0x78
>> [    0.313479]  try_online_node+0x25/0x40
>> [    0.313479]  do_cpu_up+0x36/0xc0
>> [    0.313479]  smp_init+0x59/0xb3
>> [    0.313479]  kernel_init_freeable+0x11a/0x247
>> [    0.313479]  ? rest_init+0x23f/0x23f
>> [    0.313479]  kernel_init+0x5/0xf1
>> [    0.313479]  ret_from_fork+0x3a/0x50
>> [    0.313479] Modules linked in:
>>
>> Figuring out what goes wrong here (maybe QEMU creating a weird
>> system configuration) is a different journey :)
>>
> 
> That is a separate issue need to revert,
> 
> "x86, numa: always initialize all possible nodes"
> 
> and then, you should be able to reproduce.
> 

Thanks, reproduced and verified that this is the fix.

-- 

Thanks,

David / dhildenb
