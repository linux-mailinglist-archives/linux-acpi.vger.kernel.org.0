Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5679A39F341
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jun 2021 12:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhFHKOI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 06:14:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24236 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230351AbhFHKOI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jun 2021 06:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623147135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GuWwz0l9Jq2D+rEX+ek9RVNrga2qQsCVfqJEFTY2fF0=;
        b=OYmgwJhE2o0L7Ugt5ddIOpVR7IL1BZ7Pn61i8sSYcFFNnvZ6FhKguRJnLra8LRZeMgRWQv
        FCeLY9t0C09SUBZ7hhTd398eHBMu44taSSHKtEtF//3MIR/59cd3CR555sThStjn6qw4Fe
        SfqzVe/5W2mYoUL237DvqpX+LdW+18g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-USTl1nGaOCm9SnBWCJayJw-1; Tue, 08 Jun 2021 06:12:12 -0400
X-MC-Unique: USTl1nGaOCm9SnBWCJayJw-1
Received: by mail-wr1-f71.google.com with SMTP id h104-20020adf90710000b029010de8455a3aso9236799wrh.12
        for <linux-acpi@vger.kernel.org>; Tue, 08 Jun 2021 03:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GuWwz0l9Jq2D+rEX+ek9RVNrga2qQsCVfqJEFTY2fF0=;
        b=OK84STKpBFyCvtdwacEUC1KtZo2H1uke+qe6YevXKTx/y/TpfAI6xoXKbRRHo5+mhh
         AjwQkWA4BU/OBnjUh3nUGt0qcA1yB55FzOsf8+4x0/1Fqav5eaHwSLDNEScDgPXJtkIu
         0+x/Wzdg5efeDySh2ppmd9PF67RbrvgjV/1IZOlfySX9e2+ugFvutIAYoBaqKWmhMB+E
         eoRkShIucYdb5Vwo8S03jKwk7GgeZwdcWrGIykAkUAwkVKNE7USsGjPa4T5UKjderEW/
         7B0Q8KA7jd5Aua/EBb9gpc3VT+5o0X/CbAiPGIL30802DNprsZoqdmgXj03XjvVv7Gbm
         XgJw==
X-Gm-Message-State: AOAM531ae5j7Lv1guS15zH0QptleE7lrjU4u/vSe9m4ynFteddzx76lA
        3noMiczrhxYm2/A+PisTqgbi5YtdJu8k7vbOHADB/lgOHApFcIlETvWxCeTeaMG/UMu81oo671+
        Zz028HZjhK0MW9LhRgnUW9nzP7FDSXZiIWlQuY7hfzsIkZuUef7LZQ1Q3FbfJJCWu8US5pg==
X-Received: by 2002:a1c:2202:: with SMTP id i2mr3308165wmi.72.1623147131490;
        Tue, 08 Jun 2021 03:12:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxblAl0xmXsTTtUWutRHTwHvYL1IPUjulz2jonRa8xW8vrpYP+2CmxiJibHeA1MgeeD+tc5LQ==
X-Received: by 2002:a1c:2202:: with SMTP id i2mr3308117wmi.72.1623147131043;
        Tue, 08 Jun 2021 03:12:11 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c61cf.dip0.t-ipconnect.de. [91.12.97.207])
        by smtp.gmail.com with ESMTPSA id o22sm2207186wmc.17.2021.06.08.03.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 03:12:10 -0700 (PDT)
To:     Oscar Salvador <osalvador@suse.de>
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
References: <20210607195430.48228-1-david@redhat.com>
 <20210608094244.GA22894@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 00/12] mm/memory_hotplug: "auto-movable" online policy
 and memory groups
Message-ID: <9ab50bc0-1714-67c4-ea9a-79e7d315315b@redhat.com>
Date:   Tue, 8 Jun 2021 12:12:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210608094244.GA22894@linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 08.06.21 11:42, Oscar Salvador wrote:
> On Mon, Jun 07, 2021 at 09:54:18PM +0200, David Hildenbrand wrote:
>> Hi,
>>
>> this series aims at improving in-kernel auto-online support. It tackles the
>> fundamental problems that:
> 
> Hi David,
> 
> the idea sounds good to me, and I like that this series takes away part of the
> responsability from the user to know where the memory should go.
> I think the kernel is a much better fit for that as it has all the required
> information to balance things.
> 
> I also glanced over the series and besides some things here and there the
> whole approach looks sane.
> I plan to have a look into it in a few days, just have some high level questions
> for the time being:

Hi Oscar,

> 
>>   1) We can create zone imbalances when onlining all memory blindly to
>>      ZONE_MOVABLE, in the worst case crashing the system. We have to know
>>      upfront how much memory we are going to hotplug such that we can
>>      safely enable auto-onlining of all hotplugged memory to ZONE_MOVABLE
>>      via "online_movable". This is far from practical and only applicable in
>>      limited setups -- like inside VMs under the RHV/oVirt hypervisor which
>>      will never hotplug more than 3 times the boot memory (and the
>>      limitation is only in place due to the Linux limitation).
> 
> Could you give more insight about the problems created by zone imbalances (e.g:
> a lot of movable memory and little kernel memory).

I just updated memory-hotplug.rst exactly for that purpose :)

https://lkml.kernel.org/r/20210525102604.8770-1-david@redhat.com

There, also safe zone ratios and "usually well known values" are given. 
I can link it in the next cover letter.

> 
>>   2) We see more setups that implement dynamic VM resizing, hot(un)plugging
>>      memory to resize VM memory. In these setups, we might hotplug a lot of
>>      memory, but it might happen in various small steps in both directions
>>      (e.g., 2 GiB -> 8 GiB -> 4 GiB -> 16 GiB ...). virtio-mem is the
>>      primary driver of this upstream right now, performing such dynamic
>>      resizing NUMA-aware via multiple virtio-mem devices.
>>
>>      Onlining all hotplugged memory to ZONE_NORMAL means we basically have
>>      no hotunplug guarantees. Onlining all to ZONE_MOVABLE means we can
>>      easily run into zone imbalances when growing a VM. We want a mixture,
>>      and we want as much memory as reasonable/configured in ZONE_MOVABLE.
>>
>>   3) Memory devices consist of 1..X memory block devices, however, the
>>      kernel doesn't really track the relationship. Consequently, also user
>>      space has no idea. We want to make per-device decisions. As one
>>      example, for memory hotunplug it doesn't make sense to use a mixture of
>>      zones within a single DIMM: we want all MOVABLE if possible, otherwise
>>      all !MOVABLE, because any !MOVABLE part will easily block the DIMM from
>>      getting hotunplugged. As another example, virtio-mem operates on
>>      individual units that span 1..X memory blocks. Similar to a DIMM, we
>>      want a unit to either be all MOVABLE or !MOVABLE. Further, we want
>>      as much memory of a virtio-mem device to be MOVABLE as possible.
> 
> So, a virtio-mem unit could be seen as DIMM right?

It's a bit more complicated. Each individual unit (e.g., a 128 MiB 
memory block) is the smallest granularity we can add/remove of that 
device. So such a unit is somewhat like a DIMM. However, all "units" of 
the device can interact -- it's a single memory device.


> 
>>   4) We want memory onlining to be done right from the kernel while adding
>>      memory; for example, this is reqired for fast memory hotplug for
>>      drivers that add individual memory blocks, like virito-mem. We want a
>>      way to configure a policy in the kernel and avoid implementing advanced
>>      policies in user space.
> 
> "we want memory onlining to be done right from the kernel while adding memory"
> 
> is not that always the case when a driver adds memory? User has no interaction
> with that right?

Well, with auto-onlining in the kernel disabled, user space has to do 
the onlining -- for example via udev rules right now in major distributions.

But there are also users that always want to online manually in user 
space to select a zone. Most prominently standby memory on s390x, but 
also in some cases dax/kmem memory. But these two are really corner 
cases. In general, we want hotplugged memory to be onlined immediately.

> 
>> The auto-onlining support we have in the kernel is not sufficient. All we
>> have is a) online everything movable (online_movable) b) online everything
>> !movable (online_kernel) c) keep zones contiguous (online). This series
>> allows configuring c) to mean instead "online movable if possible according
>> to the coniguration, driven by a maximum MOVABLE:KERNEL ratio" -- a new
>> onlining policy.
>>
>> This series does 3 things:
>>
>>    1) Introduces the "auto-movable" online policy that initially operates on
>>       individual memory blocks only. It uses a maximum MOVABLE:KERNEL ratio
>>       to make a decision whether a memory block will be onlined to
>>       ZONE_MOVABLE or not. However, in the basic form, hotplugged KERNEL
>>       memory does not allow for more MOVABLE memory (details in the
>>       patches). CMA memory is treated like MOVABLE memory.
> 
> How a user would know which ratio is sane? Could we add some info in the
> Docu part that kinda sets some "basic" rules?

Again, currently resides in the memory-hotplug.rst overhaul.

> 
>>    2) Introduces static (e.g., DIMM) and dynamic (e.g., virtio-mem) memory
>>       groups and uses group information to make decisions in the
>>       "auto-movable" online policy accross memory blocks of a single memory
>>       device (modeled as memory group).
> 
> So, the distinction being that a DIMM cannot grow larger but we can add more
> memory to a virtio-mem unit? I feel I am missing some insight here.

Right, the relevant patch contains more info.

You either plug or unplug a DIMM (or a NUMA node which spans multiple 
DIMMS) -- both are ACPI memory devices that span multiple physical 
regions. You cannot unplug parts of a DIMM or grow it. "static" as also 
expressed by ACPI code ("adds" and "removes" all memory device memory in 
one go).

virtio-mem behaves differently, as it's a single physical memory region 
in which we dynamically add or remove memory. The granularity in which 
we add/remove memory from Linux is a "unit". In the simplest case, it's 
just a single memory block (e.g., 128 MiB). So it's a memory device that 
can grow/shrink in the given unit -- "dynamic".

> 
>>    3) Maximizes ZONE_MOVABLE memory within dynamic memory groups, by
>>       allowing ZONE_NORMAL memory within a dynamic memory group to allow for
>>       more ZONE_MOVABLE memory within the same memory group. The target use
>>       case is dynamic VM resizing using virtio-mem.
> 
> Sorry, I got lost in this one. Care to explain a bit more?

The virtio-mem example below should make this a bit more clearer (in 
addition to the relevant patch), especially in contrast to static memory 
devices like DIMMs. Key is that a single virtio-mem device is a "dynamic 
memory group" in which memory can get added/removed dynamically in a 
given unit granularity. And we want to special case that type of device 
to have as much memory of a virtio-mem device being MOVABLE as possible 
(and configured).

> 
>> The target usage will be:
>>
>>    1) Linux boots with "mhp_default_online_type=offline"
>>
>>    2) User space (e.g., systemd unit) configures memory onlining (according
>>       to a config file and system properties), for example:
>>       * Setting memory_hotplug.online_policy=auto-movable
>>       * Setting memory_hotplug.auto_movable_ratio=301
>>       * Setting memory_hotplug.auto_movable_numa_aware=true
> 
> I think we would need to document those in order to let the user know what
> it is best for them. e.g: when do we want to enable auto_movable_numa_aware etc.

Yes, as mentioned below, an memory-hotplug.rst update will follow once 
the overhaul is done. The respective patch contains more information.

> 
>> For DIMMs, hotplugging 4 GiB DIMMs to a 4 GiB VM with a configured ratio of
>> 301% results in the following layout:
>> 	Memory block 1-15:    DMA32   (early)
>> 	Memory block 32-47:   Normal  (early)
>> 	Memory block 48-79:   Movable (DIMM 0)
>> 	Memory block 80-111:  Movable (DIMM 1)
>> 	Memory block 112-143: Movable (DIMM 2)
>> 	Memory block 144-275: Normal  (DIMM 3)
>> 	Memory block 176-207: Normal  (DIMM 4)
>> 	... all Normal
>> 	(-> hotplugged Normal memory does not allow for more Movable memory)
> 
> Uhm, I am sorry for being dense here:
> 
> On x86_64, 4GB = 32 sections (of 128MB each). Why the memblock span from #1 to #47?

Sorry, it's actually "Memory block 0-15", which gives us 0-15 and 32-47 
== 32 memory blocks corresponding to boot memory. Note that the absent 
memory blocks 16-31 should correspond to the PCI hole.


Thanks Oscar!

-- 
Thanks,

David / dhildenb

