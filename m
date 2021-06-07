Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC66E39E7C3
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 21:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhFGT4j (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 15:56:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60541 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230351AbhFGT4i (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2021 15:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623095686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=E+GWkoi5o/3+tnBcPnBYmV0MPLfSi0TMmWvZba2R+/E=;
        b=jJpBmiB3tiIcIQD6YqWkdrzbh9Ycaz4wvRFqt9a03Z/Jsntb+UsFSgg+WCb666TMPJKPpY
        kuzUS3nmkrQXoEYnOmsqnC+WxupPtgMoe0hK7Tmesg07TpiVsA9Z7aRDlr5eFNT1E6ON0c
        VuWhXxLAoKH/UTzR9Jy4XXO07bBF9to=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-Ep-RTuDENbWGYztZUkA75g-1; Mon, 07 Jun 2021 15:54:45 -0400
X-MC-Unique: Ep-RTuDENbWGYztZUkA75g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E39CA2D0;
        Mon,  7 Jun 2021 19:54:42 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-9.ams2.redhat.com [10.36.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 07D7410013C1;
        Mon,  7 Jun 2021 19:54:30 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Marek Kedzierski <mkedzier@redhat.com>,
        Hui Zhu <teawater@gmail.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v1 00/12] mm/memory_hotplug: "auto-movable" online policy and memory groups
Date:   Mon,  7 Jun 2021 21:54:18 +0200
Message-Id: <20210607195430.48228-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

this series aims at improving in-kernel auto-online support. It tackles the
fundamental problems that:

 1) We can create zone imbalances when onlining all memory blindly to
    ZONE_MOVABLE, in the worst case crashing the system. We have to know
    upfront how much memory we are going to hotplug such that we can
    safely enable auto-onlining of all hotplugged memory to ZONE_MOVABLE
    via "online_movable". This is far from practical and only applicable in
    limited setups -- like inside VMs under the RHV/oVirt hypervisor which
    will never hotplug more than 3 times the boot memory (and the
    limitation is only in place due to the Linux limitation).

 2) We see more setups that implement dynamic VM resizing, hot(un)plugging
    memory to resize VM memory. In these setups, we might hotplug a lot of
    memory, but it might happen in various small steps in both directions
    (e.g., 2 GiB -> 8 GiB -> 4 GiB -> 16 GiB ...). virtio-mem is the
    primary driver of this upstream right now, performing such dynamic
    resizing NUMA-aware via multiple virtio-mem devices.

    Onlining all hotplugged memory to ZONE_NORMAL means we basically have
    no hotunplug guarantees. Onlining all to ZONE_MOVABLE means we can
    easily run into zone imbalances when growing a VM. We want a mixture,
    and we want as much memory as reasonable/configured in ZONE_MOVABLE.

 3) Memory devices consist of 1..X memory block devices, however, the
    kernel doesn't really track the relationship. Consequently, also user
    space has no idea. We want to make per-device decisions. As one
    example, for memory hotunplug it doesn't make sense to use a mixture of
    zones within a single DIMM: we want all MOVABLE if possible, otherwise
    all !MOVABLE, because any !MOVABLE part will easily block the DIMM from
    getting hotunplugged. As another example, virtio-mem operates on
    individual units that span 1..X memory blocks. Similar to a DIMM, we
    want a unit to either be all MOVABLE or !MOVABLE. Further, we want
    as much memory of a virtio-mem device to be MOVABLE as possible.

 4) We want memory onlining to be done right from the kernel while adding
    memory; for example, this is reqired for fast memory hotplug for
    drivers that add individual memory blocks, like virito-mem. We want a
    way to configure a policy in the kernel and avoid implementing advanced
    policies in user space.

The auto-onlining support we have in the kernel is not sufficient. All we
have is a) online everything movable (online_movable) b) online everything
!movable (online_kernel) c) keep zones contiguous (online). This series
allows configuring c) to mean instead "online movable if possible according
to the coniguration, driven by a maximum MOVABLE:KERNEL ratio" -- a new
onlining policy.

This series does 3 things:

  1) Introduces the "auto-movable" online policy that initially operates on
     individual memory blocks only. It uses a maximum MOVABLE:KERNEL ratio
     to make a decision whether a memory block will be onlined to
     ZONE_MOVABLE or not. However, in the basic form, hotplugged KERNEL
     memory does not allow for more MOVABLE memory (details in the
     patches). CMA memory is treated like MOVABLE memory.

  2) Introduces static (e.g., DIMM) and dynamic (e.g., virtio-mem) memory
     groups and uses group information to make decisions in the
     "auto-movable" online policy accross memory blocks of a single memory
     device (modeled as memory group).

  3) Maximizes ZONE_MOVABLE memory within dynamic memory groups, by
     allowing ZONE_NORMAL memory within a dynamic memory group to allow for
     more ZONE_MOVABLE memory within the same memory group. The target use
     case is dynamic VM resizing using virtio-mem.

I remember that the basic idea of using a ratio to implement a policy in
the kernel was once mentioned by Vitaly Kuznetsov, but I might be wrong
(I lost the pointer to that discussion).

For me, the main use case is using it along with virtio-mem (and
DIMMs / ppc64 dlpar where necessary) for dynamic resizing of VMs,
increasing the amount of memory we can hotunplug reliably again if we
might eventually hotplug a lot of memory to a VM.


The target usage will be:

  1) Linux boots with "mhp_default_online_type=offline"

  2) User space (e.g., systemd unit) configures memory onlining (according
     to a config file and system properties), for example:
     * Setting memory_hotplug.online_policy=auto-movable
     * Setting memory_hotplug.auto_movable_ratio=301
     * Setting memory_hotplug.auto_movable_numa_aware=true

  3) User space enabled auto onlining via "echo online >
     /sys/devices/system/memory/auto_online_blocks"

  4) User space triggers manual onlining of all already-offline memory
     blocks (go over offline memory blocks and set them to "online")


For DIMMs, hotplugging 4 GiB DIMMs to a 4 GiB VM with a configured ratio of
301% results in the following layout:
	Memory block 1-15:    DMA32   (early)
	Memory block 32-47:   Normal  (early)
	Memory block 48-79:   Movable (DIMM 0)
	Memory block 80-111:  Movable (DIMM 1)
	Memory block 112-143: Movable (DIMM 2)
	Memory block 144-275: Normal  (DIMM 3)
	Memory block 176-207: Normal  (DIMM 4)
	... all Normal
	(-> hotplugged Normal memory does not allow for more Movable memory)

For virtio-mem, using a simple, single virtio-mem device with a 4 GiB VM
will result in the following layout:
	Memory block 1-15:    DMA32   (early)
	Memory block 32-47:   Normal  (early)
	Memory block 48-143:  Movable (virtio-mem, first 12 GiB)
	Memory block 144:     Normal  (virtio-mem, next 128 MiB)
	Memory block 145-147: Movable (virtio-mem, next 384 MiB)
	Memory block 148:     Normal  (virtio-mem, next 128 MiB)
	Memory block 149-151: Movable (virtio-mem, next 384 MiB)
	... Normal/Movable mixture as above
	(-> hotplugged Normal memory allows for more Movable memory within
	    the same device)

Which gives us maximum flexibility when dynamically growing/shrinking a
VM in smaller steps. When shrinking, virtio-mem will prioritize unplug of
MOVABLE memory with [1] sent last week, such that we won't accidentially
trigger zone imbalances in more complicated setups that involve multiple
virtio-mem devices.


I'll update the memory-hotplug.rst documentation separately, once the
overhaul is done. For now I decided to use module parameters that can be
changed at runtime and not add new sysfs files for configuration. Easier
and cleaner IMHO -- especially, temporarily overwritable via the cmdline.

Future work:
- Use a single static memory group for dax/kmem
- Sense upfront for DIMMs (and dax/kmem) which pieces can actually be added
  and won't actually contribute to the static memory group size
- Use memory groups for ppc64 dlpar
- More tunables. For example, a way to configure to keep some memory
  default offline (s390x standby memory, dax/kmem)
- Indicate to user space that MOVABLE might be a bad idea -- especially
  relevant when memory ballooning without support for balloon compaction
  is active.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Marek Kedzierski <mkedzier@redhat.com>
Cc: Hui Zhu <teawater@gmail.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: virtualization@lists.linux-foundation.org
Cc: linux-mm@kvack.org
Cc: linux-acpi@vger.kernel.org

[1] https://lkml.kernel.org/r/20210602185720.31821-1-david@redhat.com

David Hildenbrand (12):
  mm/memory_hotplug: use "unsigned long" for PFN in zone_for_pfn_range()
  mm: track present early pages per zone
  mm/memory_hotplug: introduce "auto-movable" online policy
  mm/memory_hotplug: remove nid parameter from arch_remove_memory()
  mm/memory_hotplug: remove nid parameter from remove_memory() and
    friends
  drivers/base/memory: "memory groups" to logically group memory blocks
  mm/memory_hotplug: track present pages in memory groups
  ACPI: memhotplug: memory resources cannot be enabled yet
  ACPI: memhotplug: use a single static memory group for a single memory
    device
  virtio-mem: use a single dynamic memory group for a single virtio-mem
    device
  mm/memory_hotplug: memory group aware "auto-movable" online policy
  mm/memory_hotplug: improved dynamic memory group aware "auto-movable"
    online policy

 arch/arm64/mm/mmu.c                           |   3 +-
 arch/ia64/mm/init.c                           |   3 +-
 arch/powerpc/mm/mem.c                         |   3 +-
 .../platforms/pseries/hotplug-memory.c        |   9 +-
 arch/s390/mm/init.c                           |   3 +-
 arch/sh/mm/init.c                             |   3 +-
 arch/x86/mm/init_32.c                         |   3 +-
 arch/x86/mm/init_64.c                         |   3 +-
 drivers/acpi/acpi_memhotplug.c                |  46 ++-
 drivers/base/memory.c                         | 163 +++++++--
 drivers/dax/kmem.c                            |   3 +-
 drivers/virtio/virtio_mem.c                   |  26 +-
 include/linux/memory.h                        |  53 ++-
 include/linux/memory_hotplug.h                |  35 +-
 include/linux/mmzone.h                        |   7 +
 mm/memory_hotplug.c                           | 346 +++++++++++++++++-
 mm/memremap.c                                 |   5 +-
 mm/page_alloc.c                               |   3 +
 18 files changed, 618 insertions(+), 99 deletions(-)


base-commit: 614124bea77e452aa6df7a8714e8bc820b489922
-- 
2.31.1

