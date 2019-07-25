Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAC375149
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Jul 2019 16:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfGYOfK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Jul 2019 10:35:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728944AbfGYOfJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Jul 2019 10:35:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9D4D13DE1C;
        Thu, 25 Jul 2019 14:35:09 +0000 (UTC)
Received: from [10.36.117.70] (ovpn-117-70.ams2.redhat.com [10.36.117.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC04C60605;
        Thu, 25 Jul 2019 14:35:07 +0000 (UTC)
Subject: Re: [PATCH v1] ACPI / scan: Acquire device_hotplug_lock in
 acpi_scan_init()
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
References: <20190724143017.12841-1-david@redhat.com>
 <20190725125636.GA3582@dhcp22.suse.cz>
 <6dc566c2-faf6-565d-4ef1-2ac3a366bc76@redhat.com>
 <20190725135747.GB3582@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <447b74ca-f7c7-0835-fd50-a9f7191fe47c@redhat.com>
Date:   Thu, 25 Jul 2019 16:35:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190725135747.GB3582@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 25 Jul 2019 14:35:09 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 25.07.19 15:57, Michal Hocko wrote:
> On Thu 25-07-19 15:05:02, David Hildenbrand wrote:
>> On 25.07.19 14:56, Michal Hocko wrote:
>>> On Wed 24-07-19 16:30:17, David Hildenbrand wrote:
>>>> We end up calling __add_memory() without the device hotplug lock held.
>>>> (I used a local patch to assert in __add_memory() that the
>>>>  device_hotplug_lock is held - I might upstream that as well soon)
>>>>
>>>> [   26.771684]        create_memory_block_devices+0xa4/0x140
>>>> [   26.772952]        add_memory_resource+0xde/0x200
>>>> [   26.773987]        __add_memory+0x6e/0xa0
>>>> [   26.775161]        acpi_memory_device_add+0x149/0x2b0
>>>> [   26.776263]        acpi_bus_attach+0xf1/0x1f0
>>>> [   26.777247]        acpi_bus_attach+0x66/0x1f0
>>>> [   26.778268]        acpi_bus_attach+0x66/0x1f0
>>>> [   26.779073]        acpi_bus_attach+0x66/0x1f0
>>>> [   26.780143]        acpi_bus_scan+0x3e/0x90
>>>> [   26.780844]        acpi_scan_init+0x109/0x257
>>>> [   26.781638]        acpi_init+0x2ab/0x30d
>>>> [   26.782248]        do_one_initcall+0x58/0x2cf
>>>> [   26.783181]        kernel_init_freeable+0x1bd/0x247
>>>> [   26.784345]        kernel_init+0x5/0xf1
>>>> [   26.785314]        ret_from_fork+0x3a/0x50
>>>>
>>>> So perform the locking just like in acpi_device_hotplug().
>>>
>>> While playing with the device_hotplug_lock, can we actually document
>>> what it is protecting please? I have a bad feeling that we are adding
>>> this lock just because some other code path does rather than with a good
>>> idea why it is needed. This patch just confirms that. What exactly does
>>> the lock protect from here in an early boot stage.
>>
>> We have plenty of documentation already
>>
>> mm/memory_hotplug.c
>>
>> git grep -C5 device_hotplug mm/memory_hotplug.c
>>
>> Also see
>>
>> Documentation/core-api/memory-hotplug.rst
> 
> OK, fair enough. I was more pointing to a documentation right there
> where the lock is declared because that is the place where people
> usually check for documentation. The core-api documentation looks quite
> nice. And based on that doc it seems that this patch is actually not
> needed because neither the online/offline or cpu hotplug should be
> possible that early unless I am missing something.

I really prefer to stick to locking rules as outlined on the
interfaces if it doesn't hurt. Why it is not needed is not clear.

> 
>> Regarding the early stage: primarily lockdep as I mentioned.
> 
> Could you add a lockdep splat that would be fixed by this patch to the
> changelog for reference?
> 

I have one where I enforce what's documented (but that's of course not
upstream and therefore not "real" yet)

commit 263da346cd3cf526de3f5138827fbc3520f2f8e0
Author: David Hildenbrand <david@redhat.com>
Date:   Fri Jun 21 12:05:39 2019 +0200

    mm/memory_hotplug: Assert that the device_hotplug_lock is held
    
    We currently need the device_hotplug_lock(), as documented. Let's assert
    that the lock is held when adding/removing/onlining/offlining memory.
    
    Updated documentation to make this clearer.
    
    Signed-off-by: David Hildenbrand <david@redhat.com>


That patch in return was the result of debugging a lockdep warning
we can trigger right now (and I think it's a false positive
prevented by the device_hotplug_lock - I think it is the tie breaker).
Anyhow, this patch here didn't change it.


1. Start a guest with a DIMM attached
2. Online a memory block of that DIMM
3. Unplug the DIMM

:/# [   22.616108] Offlined Pages 32768
[   22.631567] 
[   22.632337] ======================================================
[   22.635104] WARNING: possible circular locking dependency detected
[   22.637475] 5.3.0-rc1-next-20190723+ #111 Not tainted
[   22.639314] ------------------------------------------------------
[   22.641276] kworker/u4:0/8 is trying to acquire lock:
[   22.642578] (____ptrval____) (kn->count#39){++++}, at: kernfs_remove_by_name_ns+0x3c/0x80
[   22.645004] 
[   22.645004] but task is already holding lock:
[   22.646495] (____ptrval____) (mem_sysfs_mutex){+.+.}, at: remove_memory_block_devices+0x65/0xd0
[   22.648649] 
[   22.648649] which lock already depends on the new lock.
[   22.648649] 
[   22.650488] 
[   22.650488] the existing dependency chain (in reverse order) is:
[   22.651987] 
[   22.651987] -> #4 (mem_sysfs_mutex){+.+.}:
[   22.653254]        __mutex_lock+0x8d/0x930
[   22.654079]        create_memory_block_devices+0xa4/0x140
[   22.655292]        add_memory_resource+0xd6/0x200
[   22.656252]        __add_memory+0x58/0x90
[   22.657096]        acpi_memory_device_add+0x149/0x2b0
[   22.658126]        acpi_bus_attach+0xf1/0x1f0
[   22.658899]        acpi_bus_attach+0x66/0x1f0
[   22.659698]        acpi_bus_attach+0x66/0x1f0
[   22.660482]        acpi_bus_attach+0x66/0x1f0
[   22.661265]        acpi_bus_scan+0x3e/0x90
[   22.662098]        acpi_scan_init+0x104/0x24d
[   22.662920]        acpi_init+0x2ab/0x30d
[   22.663733]        do_one_initcall+0x58/0x2cf
[   22.664727]        kernel_init_freeable+0x1b8/0x242
[   22.665780]        kernel_init+0x5/0xf1
[   22.666494]        ret_from_fork+0x3a/0x50
[   22.667271] 
[   22.667271] -> #3 (mem_hotplug_lock.rw_sem){++++}:
[   22.668378]        get_online_mems+0x39/0xc0
[   22.669327]        kmem_cache_create_usercopy+0x29/0x280
[   22.670369]        kmem_cache_create+0xd/0x10
[   22.671412]        ptlock_cache_init+0x1b/0x23
[   22.672206]        start_kernel+0x225/0x501
[   22.672979]        secondary_startup_64+0xa4/0xb0
[   22.673887] 
[   22.673887] -> #2 (cpu_hotplug_lock.rw_sem){++++}:
[   22.675091]        cpus_read_lock+0x39/0xc0
[   22.675962]        __offline_pages+0x3e/0x7c0
[   22.676997]        memory_subsys_offline+0x3a/0x60
[   22.678073]        device_offline+0x82/0xb0
[   22.679039]        acpi_bus_offline+0xdb/0x150
[   22.679912]        acpi_device_hotplug+0x1b4/0x3a0
[   22.680939]        acpi_hotplug_work_fn+0x15/0x20
[   22.682025]        process_one_work+0x26c/0x5a0
[   22.683019]        worker_thread+0x48/0x3e0
[   22.683942]        kthread+0x103/0x140
[   22.684855]        ret_from_fork+0x3a/0x50
[   22.685841] 
[   22.685841] -> #1 (&device->physical_node_lock){+.+.}:
[   22.687246]        __mutex_lock+0x8d/0x930
[   22.688179]        acpi_get_first_physical_node+0x18/0x60
[   22.689699]        acpi_companion_match+0x3b/0x60
[   22.690989]        acpi_device_uevent_modalias+0x9/0x20
[   22.692626]        platform_uevent+0xd/0x40
[   22.693832]        dev_uevent+0x86/0x1c0
[   22.695133]        uevent_show+0x93/0x100
[   22.695988]        dev_attr_show+0x14/0x40
[   22.697342]        sysfs_kf_seq_show+0xb2/0xf0
[   22.698845]        seq_read+0xd0/0x3f0
[   22.700066]        vfs_read+0xc0/0x170
[   22.701168]        ksys_read+0x63/0xe0
[   22.702392]        do_syscall_64+0x4b/0x1b0
[   22.703979]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   22.705708] 
[   22.705708] -> #0 (kn->count#39){++++}:
[   22.707658]        __lock_acquire+0xe2f/0x1a20
[   22.708877]        lock_acquire+0x95/0x190
[   22.710299]        __kernfs_remove+0x253/0x2f0
[   22.711936]        kernfs_remove_by_name_ns+0x3c/0x80
[   22.713392]        device_del+0x148/0x360
[   22.714685]        device_unregister+0x9/0x20
[   22.716414]        remove_memory_block_devices+0x90/0xd0
[   22.718135]        try_remove_memory+0xc6/0x130
[   22.719669]        __remove_memory+0x5/0xc
[   22.721178]        acpi_memory_device_remove+0x72/0xf0
[   22.723178]        acpi_bus_trim+0x50/0x90
[   22.724537]        acpi_device_hotplug+0x222/0x3a0
[   22.726257]        acpi_hotplug_work_fn+0x15/0x20
[   22.728044]        process_one_work+0x26c/0x5a0
[   22.729825]        worker_thread+0x48/0x3e0
[   22.731128]        kthread+0x103/0x140
[   22.732137]        ret_from_fork+0x3a/0x50
[   22.733368] 
[   22.733368] other info that might help us debug this:
[   22.733368] 
[   22.736178] Chain exists of:
[   22.736178]   kn->count#39 --> mem_hotplug_lock.rw_sem --> mem_sysfs_mutex
[   22.736178] 
[   22.739723]  Possible unsafe locking scenario:
[   22.739723] 
[   22.741143]        CPU0                    CPU1
[   22.741788]        ----                    ----
[   22.742653]   lock(mem_sysfs_mutex);
[   22.743990]                                lock(mem_hotplug_lock.rw_sem);
[   22.746069]                                lock(mem_sysfs_mutex);
[   22.747207]   lock(kn->count#39);
[   22.748132] 
[   22.748132]  *** DEADLOCK ***
[   22.748132] 
[   22.749182] 7 locks held by kworker/u4:0/8:
[   22.750684]  #0: (____ptrval____) ((wq_completion)kacpi_hotplug){+.+.}, at: process_one_work+0x1e9/0x5a0
[   22.753966]  #1: (____ptrval____) ((work_completion)(&hpw->work)){+.+.}, at: process_one_work+0x1e9/0x5a0
[   22.756429]  #2: (____ptrval____) (device_hotplug_lock){+.+.}, at: acpi_device_hotplug+0x2d/0x3a0
[   22.758292]  #3: (____ptrval____) (acpi_scan_lock){+.+.}, at: acpi_device_hotplug+0x3b/0x3a0
[   22.759836]  #4: (____ptrval____) (cpu_hotplug_lock.rw_sem){++++}, at: try_remove_memory+0x3b/0x130
[   22.761463]  #5: (____ptrval____) (mem_hotplug_lock.rw_sem){++++}, at: percpu_down_write+0x1b/0xf2
[   22.763812]  #6: (____ptrval____) (mem_sysfs_mutex){+.+.}, at: remove_memory_block_devices+0x65/0xd0


-- 

Thanks,

David / dhildenb
