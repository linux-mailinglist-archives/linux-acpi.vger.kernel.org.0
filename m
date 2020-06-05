Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748931EF3BD
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jun 2020 11:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgFEJLM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jun 2020 05:11:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:60258 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbgFEJLL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 5 Jun 2020 05:11:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9785CAE5C;
        Fri,  5 Jun 2020 09:11:11 +0000 (UTC)
Subject: Re: slub freelist issue / BUG: unable to handle page fault for
 address: 000000003ffe0018
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Kees Cook <keescook@chromium.org>,
        Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, linux-acpi@vger.kernel.org,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <4dc93ff8-f86e-f4c9-ebeb-6d3153a78d03@oracle.com>
 <7839183d-1c0b-da02-73a2-bf5e1e8b02b9@suse.cz>
 <94296941-1073-913c-2adb-bf2e41be9f0f@oracle.com>
 <202006041054.874AA564@keescook>
 <cb0cdaaa-7825-0b87-0384-db22329305bb@suse.cz>
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <34455dce-6675-1fc2-8d61-45bf56f3f554@suse.cz>
Date:   Fri, 5 Jun 2020 11:11:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <cb0cdaaa-7825-0b87-0384-db22329305bb@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 6/4/20 8:46 PM, Vlastimil Babka wrote:
> On 6/4/20 7:57 PM, Kees Cook wrote:
>> On Thu, Jun 04, 2020 at 07:20:18PM +0200, Vegard Nossum wrote:
>>> On 2020-06-04 19:18, Vlastimil Babka wrote:
>>>> On 6/4/20 7:14 PM, Vegard Nossum wrote:
>>>>>
>>>>> Hi all,
>>>>>
>>>>> I ran into a boot problem with latest linus/master
>>>>> (6929f71e46bdddbf1c4d67c2728648176c67c555) that manifests like this:
>>>>
>>>> Hi, what's the .config you use?
>>>
>>> Pretty much x86_64 defconfig minus a few options (PCI, USB, ...)
>>
>> Oh yes indeed. I immediately crash in the same way with this config. I'll
>> start digging...
>>
>> (defconfig finishes boot)
> 
> This is funny, booting with slub_debug=F results in:
> I'm not sure if it's ACPI or ftrace wrong here, but looks like the changed
> free pointer offset merely exposes a bug in something else.

So, with Kees' patch reverted, booting with slub_debug=F (or even more
specific slub_debug=F,ftrace_event_field) also hits this bug below. I
wanted to bisect it, but v5.7 was also bad, and also v5.6. Didn't try
further in history. So it's not new at all, and likely very specific to
your config+QEMU? (and related to the ACPI error messages that precede it?).

> This would mean acpi_os_release_object() calling kmem_cache_free(ftrace_event_field, x)
> where x is actually from kmalloc-64? Both parts of that sounds wrong.
> 
> Thread starts here: https://lore.kernel.org/linux-mm/4dc93ff8-f86e-f4c9-ebeb-6d3153a78d03@oracle.com/
> 
> [    0.144386] ACPI: Added _OSI(Module Device)
> [    0.144496] ACPI: Added _OSI(Processor Device)
> [    0.144956] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.145432] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.145501] ACPI: Added _OSI(Linux-Dell-Video)
> [    0.145951] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> [    0.146522] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> [    0.147070] ACPI Error: AE_BAD_PARAMETER, During Region initialization (20200430/tbxfload-52)
> [    0.147494] ACPI: Unable to load the System Description Tables
> [    0.148104] ACPI Error: Could not remove SCI handler (20200430/evmisc-251)
> [    0.148507] ------------[ cut here ]------------
> [    0.148985] cache_from_obj: Wrong slab cache. ftrace_event_field but object is from kmalloc-64
> [    0.149502] WARNING: CPU: 0 PID: 1 at mm/slab.h:523 kmem_cache_free+0x248/0x260
> [    0.150254] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.7.0+ #43
> [    0.150490] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4-rebuilt.opensuse.org 04/01/2014
> [    0.150490] RIP: 0010:kmem_cache_free+0x248/0x260
> [    0.150490] Code: ff 0f 0b e9 9d fe ff ff 49 8b 4d 58 48 8b 55 58 48 c7 c6 10 47 c1 a4 48 c7 c7 f0 c1 d0 a4 c6 05 9f 05 b1 00 01 e8 bc cc eb ff <0f> 0b 48 8b 15 5f 36 9b 00 4c 89 ed e9 d6 fd ff ff 0f 1f 80 00 00
> [    0.150490] RSP: 0018:ffffb4dac0013dc0 EFLAGS: 00010282
> [    0.150490] RAX: 0000000000000000 RBX: ffffa38a07409e00 RCX: 0000000000000000
> [    0.150490] RDX: 0000000000000001 RSI: 0000000000000092 RDI: ffffffffa51dd32c
> [    0.150490] RBP: ffffa38a07403900 R08: ffffb4dac0013c7d R09: 00000000000000eb
> [    0.150490] R10: ffffb4dac0013c78 R11: ffffb4dac0013c7d R12: ffffa38a87409e00
> [    0.150490] R13: ffffa38a07401d00 R14: 0000000000000000 R15: 0000000000000000
> [    0.150490] FS:  0000000000000000(0000) GS:ffffa38a07a00000(0000) knlGS:0000000000000000
> [    0.150490] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.150490] CR2: 0000000000000000 CR3: 000000000560a000 CR4: 00000000003406f0
> [    0.150490] Call Trace:
> [    0.150490]  acpi_os_release_object+0x5/0x10
> [    0.150490]  acpi_ns_delete_children+0x46/0x59
> [    0.150490]  acpi_ns_delete_namespace_subtree+0x5c/0x79
> [    0.150490]  ? acpi_sleep_proc_init+0x1f/0x1f
> [    0.150490]  acpi_ns_terminate+0xc/0x31
> [    0.150490]  acpi_ut_subsystem_shutdown+0x45/0xa3
> [    0.150490]  ? acpi_sleep_proc_init+0x1f/0x1f
> [    0.150490]  acpi_terminate+0x5/0xf
> [    0.150490]  acpi_init+0x27b/0x308
> [    0.150490]  ? video_setup+0x79/0x79
> [    0.150490]  do_one_initcall+0x7b/0x160
> [    0.150490]  kernel_init_freeable+0x190/0x1f2
> [    0.150490]  ? rest_init+0x9a/0x9a
> [    0.150490]  kernel_init+0x5/0xf6
> [    0.150490]  ret_from_fork+0x22/0x30
> [    0.150490] ---[ end trace 967e9fbc065d7911 ]---
> 
> 
> 

