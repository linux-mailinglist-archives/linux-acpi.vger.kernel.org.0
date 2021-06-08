Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FF739F2AC
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jun 2021 11:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhFHJor (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 05:44:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56670 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhFHJop (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jun 2021 05:44:45 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0CD1B1FD2A;
        Tue,  8 Jun 2021 09:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623145372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H6PoiO6lcqvCK9WS8yWqTI1J9lOv+IF/9XzcF6kIZ7g=;
        b=N9E3L/wSCydc1dzeV986Ro0H1jM0zy53m9ctaYpZX+npqsW+7c7iS3cfcx7Qkwl6gOgU3h
        jNhYanmWGjFIAaRv0UMqGikcy7g5Qdblc1pzF5iolXYztd02NlgC5e2V4fSfKJH79W4Uvn
        9Wqdis2yfGRuEZKxUW5sxHbdqjunS5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623145372;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H6PoiO6lcqvCK9WS8yWqTI1J9lOv+IF/9XzcF6kIZ7g=;
        b=9OGduESGm4Z8Z7p7l1jzThieELESNMnXbpvKdUhYwAVBC5YqELBeAHqb1vNyEni4dG+7DH
        hOIt/BNuZLwh6tBg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id E2E83118DD;
        Tue,  8 Jun 2021 09:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623145372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H6PoiO6lcqvCK9WS8yWqTI1J9lOv+IF/9XzcF6kIZ7g=;
        b=N9E3L/wSCydc1dzeV986Ro0H1jM0zy53m9ctaYpZX+npqsW+7c7iS3cfcx7Qkwl6gOgU3h
        jNhYanmWGjFIAaRv0UMqGikcy7g5Qdblc1pzF5iolXYztd02NlgC5e2V4fSfKJH79W4Uvn
        9Wqdis2yfGRuEZKxUW5sxHbdqjunS5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623145372;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H6PoiO6lcqvCK9WS8yWqTI1J9lOv+IF/9XzcF6kIZ7g=;
        b=9OGduESGm4Z8Z7p7l1jzThieELESNMnXbpvKdUhYwAVBC5YqELBeAHqb1vNyEni4dG+7DH
        hOIt/BNuZLwh6tBg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id MhPENJo7v2A6ZgAALh3uQQ
        (envelope-from <osalvador@suse.de>); Tue, 08 Jun 2021 09:42:50 +0000
Date:   Tue, 8 Jun 2021 11:42:49 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Marek Kedzierski <mkedzier@redhat.com>,
        Hui Zhu <teawater@gmail.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
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
Subject: Re: [PATCH v1 00/12] mm/memory_hotplug: "auto-movable" online policy
 and memory groups
Message-ID: <20210608094244.GA22894@linux>
References: <20210607195430.48228-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607195430.48228-1-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 07, 2021 at 09:54:18PM +0200, David Hildenbrand wrote:
> Hi,
> 
> this series aims at improving in-kernel auto-online support. It tackles the
> fundamental problems that:

Hi David,

the idea sounds good to me, and I like that this series takes away part of the
responsability from the user to know where the memory should go.
I think the kernel is a much better fit for that as it has all the required
information to balance things.

I also glanced over the series and besides some things here and there the
whole approach looks sane.
I plan to have a look into it in a few days, just have some high level questions
for the time being:

>  1) We can create zone imbalances when onlining all memory blindly to
>     ZONE_MOVABLE, in the worst case crashing the system. We have to know
>     upfront how much memory we are going to hotplug such that we can
>     safely enable auto-onlining of all hotplugged memory to ZONE_MOVABLE
>     via "online_movable". This is far from practical and only applicable in
>     limited setups -- like inside VMs under the RHV/oVirt hypervisor which
>     will never hotplug more than 3 times the boot memory (and the
>     limitation is only in place due to the Linux limitation).

Could you give more insight about the problems created by zone imbalances (e.g:
a lot of movable memory and little kernel memory).

>  2) We see more setups that implement dynamic VM resizing, hot(un)plugging
>     memory to resize VM memory. In these setups, we might hotplug a lot of
>     memory, but it might happen in various small steps in both directions
>     (e.g., 2 GiB -> 8 GiB -> 4 GiB -> 16 GiB ...). virtio-mem is the
>     primary driver of this upstream right now, performing such dynamic
>     resizing NUMA-aware via multiple virtio-mem devices.
> 
>     Onlining all hotplugged memory to ZONE_NORMAL means we basically have
>     no hotunplug guarantees. Onlining all to ZONE_MOVABLE means we can
>     easily run into zone imbalances when growing a VM. We want a mixture,
>     and we want as much memory as reasonable/configured in ZONE_MOVABLE.
> 
>  3) Memory devices consist of 1..X memory block devices, however, the
>     kernel doesn't really track the relationship. Consequently, also user
>     space has no idea. We want to make per-device decisions. As one
>     example, for memory hotunplug it doesn't make sense to use a mixture of
>     zones within a single DIMM: we want all MOVABLE if possible, otherwise
>     all !MOVABLE, because any !MOVABLE part will easily block the DIMM from
>     getting hotunplugged. As another example, virtio-mem operates on
>     individual units that span 1..X memory blocks. Similar to a DIMM, we
>     want a unit to either be all MOVABLE or !MOVABLE. Further, we want
>     as much memory of a virtio-mem device to be MOVABLE as possible.

So, a virtio-mem unit could be seen as DIMM right? 

>  4) We want memory onlining to be done right from the kernel while adding
>     memory; for example, this is reqired for fast memory hotplug for
>     drivers that add individual memory blocks, like virito-mem. We want a
>     way to configure a policy in the kernel and avoid implementing advanced
>     policies in user space.

"we want memory onlining to be done right from the kernel while adding memory"

is not that always the case when a driver adds memory? User has no interaction
with that right?

> The auto-onlining support we have in the kernel is not sufficient. All we
> have is a) online everything movable (online_movable) b) online everything
> !movable (online_kernel) c) keep zones contiguous (online). This series
> allows configuring c) to mean instead "online movable if possible according
> to the coniguration, driven by a maximum MOVABLE:KERNEL ratio" -- a new
> onlining policy.
> 
> This series does 3 things:
> 
>   1) Introduces the "auto-movable" online policy that initially operates on
>      individual memory blocks only. It uses a maximum MOVABLE:KERNEL ratio
>      to make a decision whether a memory block will be onlined to
>      ZONE_MOVABLE or not. However, in the basic form, hotplugged KERNEL
>      memory does not allow for more MOVABLE memory (details in the
>      patches). CMA memory is treated like MOVABLE memory.

How a user would know which ratio is sane? Could we add some info in the
Docu part that kinda sets some "basic" rules?

>   2) Introduces static (e.g., DIMM) and dynamic (e.g., virtio-mem) memory
>      groups and uses group information to make decisions in the
>      "auto-movable" online policy accross memory blocks of a single memory
>      device (modeled as memory group).

So, the distinction being that a DIMM cannot grow larger but we can add more
memory to a virtio-mem unit? I feel I am missing some insight here.

>   3) Maximizes ZONE_MOVABLE memory within dynamic memory groups, by
>      allowing ZONE_NORMAL memory within a dynamic memory group to allow for
>      more ZONE_MOVABLE memory within the same memory group. The target use
>      case is dynamic VM resizing using virtio-mem.

Sorry, I got lost in this one. Care to explain a bit more? 

> The target usage will be:
> 
>   1) Linux boots with "mhp_default_online_type=offline"
> 
>   2) User space (e.g., systemd unit) configures memory onlining (according
>      to a config file and system properties), for example:
>      * Setting memory_hotplug.online_policy=auto-movable
>      * Setting memory_hotplug.auto_movable_ratio=301
>      * Setting memory_hotplug.auto_movable_numa_aware=true

I think we would need to document those in order to let the user know what
it is best for them. e.g: when do we want to enable auto_movable_numa_aware etc.

> For DIMMs, hotplugging 4 GiB DIMMs to a 4 GiB VM with a configured ratio of
> 301% results in the following layout:
> 	Memory block 1-15:    DMA32   (early)
> 	Memory block 32-47:   Normal  (early)
> 	Memory block 48-79:   Movable (DIMM 0)
> 	Memory block 80-111:  Movable (DIMM 1)
> 	Memory block 112-143: Movable (DIMM 2)
> 	Memory block 144-275: Normal  (DIMM 3)
> 	Memory block 176-207: Normal  (DIMM 4)
> 	... all Normal
> 	(-> hotplugged Normal memory does not allow for more Movable memory)

Uhm, I am sorry for being dense here:

On x86_64, 4GB = 32 sections (of 128MB each). Why the memblock span from #1 to #47?

> For virtio-mem, using a simple, single virtio-mem device with a 4 GiB VM
> will result in the following layout:
> 	Memory block 1-15:    DMA32   (early)
> 	Memory block 32-47:   Normal  (early)
> 	Memory block 48-143:  Movable (virtio-mem, first 12 GiB)
> 	Memory block 144:     Normal  (virtio-mem, next 128 MiB)
> 	Memory block 145-147: Movable (virtio-mem, next 384 MiB)
> 	Memory block 148:     Normal  (virtio-mem, next 128 MiB)
> 	Memory block 149-151: Movable (virtio-mem, next 384 MiB)
> 	... Normal/Movable mixture as above
> 	(-> hotplugged Normal memory allows for more Movable memory within
> 	    the same device)
> 
> Which gives us maximum flexibility when dynamically growing/shrinking a
> VM in smaller steps. When shrinking, virtio-mem will prioritize unplug of
> MOVABLE memory with [1] sent last week, such that we won't accidentially
> trigger zone imbalances in more complicated setups that involve multiple
> virtio-mem devices.

-- 
Oscar Salvador
SUSE L3
