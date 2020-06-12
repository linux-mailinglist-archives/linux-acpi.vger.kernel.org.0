Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97EB81F77E5
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jun 2020 14:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgFLM1S (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Jun 2020 08:27:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:10821 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgFLM1S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Jun 2020 08:27:18 -0400
IronPort-SDR: 8+DjIpNyjKa21fsS4JEFt40158dU05Pu+WwEZE+/UENfIpZYiXRjX0D6mSHafRyE6zkQ7+Dxhv
 Fu8GZfzeBjbA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 05:27:02 -0700
IronPort-SDR: 5WZaufnrzoUXsvtYe0Rxax+MystH0N8kwrQ67s/aKPc0w4EyzVUCDMIHxAARXSWKO+g5/i785j
 60savLejLf3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,503,1583222400"; 
   d="scan'208";a="259870518"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.145.154]) ([10.249.145.154])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jun 2020 05:26:59 -0700
Subject: Re: slub freelist issue / BUG: unable to handle page fault for
 address: 000000003ffe0018
To:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <4dc93ff8-f86e-f4c9-ebeb-6d3153a78d03@oracle.com>
 <7839183d-1c0b-da02-73a2-bf5e1e8b02b9@suse.cz>
 <94296941-1073-913c-2adb-bf2e41be9f0f@oracle.com>
 <202006041054.874AA564@keescook>
 <cb0cdaaa-7825-0b87-0384-db22329305bb@suse.cz>
 <34455dce-6675-1fc2-8d61-45bf56f3f554@suse.cz>
 <6b2b149e-c2bc-f87a-ea2c-3046c5e39bf9@oracle.com>
 <faea2c18-edbe-f8b4-b171-6be866624856@oracle.com>
 <CAJZ5v0jqmUmf7mv3wjniVM-YqPqhDSjxunU0E4VYCsUQqvrF_Q@mail.gmail.com>
 <ce333dcb-2b2c-3e1f-2a7e-02a7819b1db4@suse.cz>
 <894e8cee-33df-1f63-fb12-72dceb024ea7@oracle.com>
 <BYAPR11MB3096B20EECE8E5BCB12E3D09F0800@BYAPR11MB3096.namprd11.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <874c4ec0-5c2a-da39-c4c0-83f781cba41d@intel.com>
Date:   Fri, 12 Jun 2020 14:26:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB3096B20EECE8E5BCB12E3D09F0800@BYAPR11MB3096.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 6/11/2020 3:40 AM, Kaneda, Erik wrote:
>
>> -----Original Message-----
>> From: Vegard Nossum <vegard.nossum@oracle.com>
>> Sent: Friday, June 5, 2020 7:45 AM
>> To: Vlastimil Babka <vbabka@suse.cz>; Rafael J. Wysocki
>> <rafael@kernel.org>; Moore, Robert <robert.moore@intel.com>; Kaneda,
>> Erik <erik.kaneda@intel.com>
>> Cc: Kees Cook <keescook@chromium.org>; Wysocki, Rafael J
>> <rafael.j.wysocki@intel.com>; Christoph Lameter <cl@linux.com>; Andrew
>> Morton <akpm@linux-foundation.org>; Marco Elver <elver@google.com>;
>> Waiman Long <longman@redhat.com>; LKML <linux-
>> kernel@vger.kernel.org>; Linux MM <linux-mm@kvack.org>; ACPI Devel
>> Maling List <linux-acpi@vger.kernel.org>; Len Brown <lenb@kernel.org>;
>> Steven Rostedt <rostedt@goodmis.org>
>> Subject: Re: slub freelist issue / BUG: unable to handle page fault for
>> address: 000000003ffe0018
>>
>> On 2020-06-05 16:08, Vlastimil Babka wrote:
>>> On 6/5/20 3:12 PM, Rafael J. Wysocki wrote:
>>>> On Fri, Jun 5, 2020 at 2:48 PM Vegard Nossum
>> <vegard.nossum@oracle.com> wrote:
>>>>> On 2020-06-05 11:36, Vegard Nossum wrote:
>>>>>> On 2020-06-05 11:11, Vlastimil Babka wrote:
>>>>>>> On 6/4/20 8:46 PM, Vlastimil Babka wrote:
>>>>>>>> On 6/4/20 7:57 PM, Kees Cook wrote:
>>>>>>>>> On Thu, Jun 04, 2020 at 07:20:18PM +0200, Vegard Nossum wrote:
>>>>>>>>>> On 2020-06-04 19:18, Vlastimil Babka wrote:
>>>>>>>>>>> On 6/4/20 7:14 PM, Vegard Nossum wrote:
>>>>>>>>>>>> Hi all,
>>>>>>>>>>>>
>>>>>>>>>>>> I ran into a boot problem with latest linus/master
>>>>>>>>>>>> (6929f71e46bdddbf1c4d67c2728648176c67c555) that manifests
>> like this:
>>>>>>>>>>> Hi, what's the .config you use?
>>>>>>>>>> Pretty much x86_64 defconfig minus a few options (PCI, USB,
>>>>>>>>>> ...)
>>>>>>>>> Oh yes indeed. I immediately crash in the same way with this config.
>>>>>>>>> I'll
>>>>>>>>> start digging...
>>>>>>>>>
>>>>>>>>> (defconfig finishes boot)
>>>>>>>> This is funny, booting with slub_debug=F results in:
>>>>>>>> I'm not sure if it's ACPI or ftrace wrong here, but looks like
>>>>>>>> the changed free pointer offset merely exposes a bug in something
>>>>>>>> else.
>>>>>>> So, with Kees' patch reverted, booting with slub_debug=F (or even
>>>>>>> more specific slub_debug=F,ftrace_event_field) also hits this bug
>>>>>>> below. I wanted to bisect it, but v5.7 was also bad, and also
>>>>>>> v5.6. Didn't try further in history. So it's not new at all, and
>>>>>>> likely very specific to your config+QEMU? (and related to the ACPI
>>>>>>> error messages that precede it?).
>>>>>> I see it too, but not on v5.0. I can bisect it.
>>>>> commit 67a72420a326b45514deb3f212085fb2cd1595b5
>>>>> Author: Bob Moore <robert.moore@intel.com>
>>>>> Date:   Fri Aug 16 14:43:21 2019 -0700
>>>>>
>>>>>        ACPICA: Increase total number of possible Owner IDs
>>>>>
>>>>>        ACPICA commit 1f1652dad88b9d767767bc1f7eb4f7d99e6b5324
>>>>>
>>>>>        From 255 to 4095 possible IDs.
>>>>>
>>>>>        Link: https://github.com/acpica/acpica/commit/1f1652da
>>>>>        Reported-by: Hedi Berriche <hedi.berriche @hpe.com>
>>>>>        Signed-off-by: Bob Moore <robert.moore@intel.com>
>>>>>        Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
>>>>>        Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>> Bob, Erik, did we miss something in that patch?
>>> Maybe the patch just changes layout in a way that exposes the bug.
>>>
>>> Anyway the "ftrace_event_field" cache is not really involved, this is
>>> just because of slab merging. After adding "slub_nomerge" to
>>> "slub_debug=F", it starts making more sense, as the cache becomes
>>> Acpi-Namespace
>>>
>>> [    0.140408] ------------[ cut here ]------------
>>> [    0.140837] cache_from_obj: Wrong slab cache. Acpi-Namespace but
>> object is from kmalloc-64
>>> [    0.141406] WARNING: CPU: 0 PID: 1 at mm/slab.h:524
>> kmem_cache_free+0x1d3/0x250
>>> [    0.142105] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.7.0+ #45
>>> [    0.142393] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> BIOS rel-1.13.0-0-gf21b5a4-rebuilt.opensuse.org 04/01/2014
>>> [    0.142393] RIP: 0010:kmem_cache_free+0x1d3/0x250
>>> [    0.142393] Code: 18 4d 85 ed 0f 84 10 ff ff ff 4c 39 ed 74 2f 49 8b 4d 58 48
>> 8b 55 58 48 c7 c6 10 47 a1 ac 48 c7 c7 00 c2 b0 ac e8 b1 cc eb ff <0f> 0b 48 89 de
>> 4c 89 ef e8 10 d7 ff ff 48 8b 15 59 36 9b 00 4c 89
>>> [    0.142393] RSP: 0018:ffffb39cc0013dc0 EFLAGS: 00010282
>>> [    0.142393] RAX: 0000000000000000 RBX: ffff937287409e00 RCX:
>> 0000000000000000
>>> [    0.142393] RDX: 0000000000000001 RSI: 0000000000000092 RDI:
>> ffffffffacfdd32c
>>> [    0.142393] RBP: ffff93728742ef00 R08: ffffb39cc0013c7d R09:
>> 00000000000000fc
>>> [    0.142393] R10: ffffb39cc0013c78 R11: ffffb39cc0013c7d R12:
>> ffff937307409e00
>>> [    0.142393] R13: ffff937287401d00 R14: 0000000000000000 R15:
>> 0000000000000000
>>> [    0.142393] FS:  0000000000000000(0000) GS:ffff937287a00000(0000)
>> knlGS:0000000000000000
>>> [    0.142393] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [    0.142393] CR2: 0000000000000000 CR3: 0000000003a0a000 CR4:
>> 00000000003406f0
>>> [    0.142393] Call Trace:
>>> [    0.142393]  acpi_os_release_object+0x5/0x10
>>> [    0.142393]  acpi_ns_delete_children+0x46/0x59
>>> [    0.142393]  acpi_ns_delete_namespace_subtree+0x5c/0x79
>>> [    0.142393]  ? acpi_sleep_proc_init+0x1f/0x1f
>>> [    0.142393]  acpi_ns_terminate+0xc/0x31
>>> [    0.142393]  acpi_ut_subsystem_shutdown+0x45/0xa3
>>> [    0.142393]  ? acpi_sleep_proc_init+0x1f/0x1f
>>> [    0.142393]  acpi_terminate+0x5/0xf
>>> [    0.142393]  acpi_init+0x27b/0x308
>>> [    0.142393]  ? video_setup+0x79/0x79
>>> [    0.142393]  do_one_initcall+0x7b/0x160
>>> [    0.142393]  kernel_init_freeable+0x190/0x1f2
>>> [    0.142393]  ? rest_init+0x9a/0x9a
>>> [    0.142393]  kernel_init+0x5/0xf6
>>> [    0.142393]  ret_from_fork+0x22/0x30
>>> [    0.142393] ---[ end trace 3539f236ef812ba1 ]---
>>> [    0.142396] ------------[ cut here ]------------
>>>
>>> I've also changed the warning so it's not printed just once, and also
>>> prints tracking info (see the hunk at the end of my mail, I'll turn this to a
>> proper patch later).
>>> With "slub_debug=FU slub_nomerge" there are now multiple warnings,
>> but they all look the same:
>>> [    0.143815] ------------[ cut here ]------------
>>> [    0.144131] cache_from_obj: Wrong slab cache. Acpi-Namespace but
>> object is from kmalloc-64
>>> [    0.144929] WARNING: CPU: 0 PID: 1 at mm/slab.h:524
>> kmem_cache_free+0x1d3/0x250
>>> [    0.145129] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.7.0+ #45
>>> [    0.145129] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> BIOS rel-1.13.0-0-gf21b5a4-rebuilt.opensuse.org 04/01/2014
>>> [    0.145129] RIP: 0010:kmem_cache_free+0x1d3/0x250
>>> [    0.145129] Code: 18 4d 85 ed 0f 84 10 ff ff ff 4c 39 ed 74 2f 49 8b 4d 58 48
>> 8b 55 58 48 c7 c6 10 47 c1 8d 48 c7 c7 00 c2 d0 8d e8 b1 cc eb ff <0f> 0b 48 89 de
>> 4c 89 ef e8 10 d7 ff ff 48 8b 15 59 36 9b 00 4c 89
>>> [    0.145129] RSP: 0018:ffff990b80013dc0 EFLAGS: 00010282
>>> [    0.145129] RAX: 0000000000000000 RBX: ffff972d474ada80 RCX:
>> 0000000000000000
>>> [    0.145129] RDX: 0000000000000001 RSI: 0000000000000092 RDI:
>> ffffffff8e1dd32c
>>> [    0.145129] RBP: ffff972d47425680 R08: ffff990b80013c7d R09:
>> 00000000000000fc
>>> [    0.145129] R10: ffff990b80013c78 R11: ffff990b80013c7d R12:
>> ffff972dc74ada80
>>> [    0.145129] R13: ffff972d474038c0 R14: 0000000000000000 R15:
>> 0000000000000000
>>> [    0.145129] FS:  0000000000000000(0000) GS:ffff972d47a00000(0000)
>> knlGS:0000000000000000
>>> [    0.145129] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [    0.145129] CR2: 0000000000000000 CR3: 000000000660a000 CR4:
>> 00000000003406f0
>>> [    0.145129] Call Trace:
>>> [    0.145129]  acpi_os_release_object+0x5/0x10
>>> [    0.145129]  acpi_ns_delete_children+0x46/0x59
>>> [    0.145129]  acpi_ns_delete_namespace_subtree+0x5c/0x79
>>> [    0.145129]  ? acpi_sleep_proc_init+0x1f/0x1f
>>> [    0.145129]  acpi_ns_terminate+0xc/0x31
>>> [    0.145129]  acpi_ut_subsystem_shutdown+0x45/0xa3
>>> [    0.145129]  ? acpi_sleep_proc_init+0x1f/0x1f
>>> [    0.145129]  acpi_terminate+0x5/0xf
>>> [    0.145129]  acpi_init+0x27b/0x308
>>> [    0.145129]  ? video_setup+0x79/0x79
>>> [    0.145129]  do_one_initcall+0x7b/0x160
>>> [    0.145129]  kernel_init_freeable+0x190/0x1f2
>>> [    0.145129]  ? rest_init+0x9a/0x9a
>>> [    0.145129]  kernel_init+0x5/0xf6
>>> [    0.145129]  ret_from_fork+0x22/0x30
>>> [    0.145129] ---[ end trace 574554fca7bd06bb ]---
>>> [    0.145133] INFO: Allocated in acpi_ns_root_initialize+0xb6/0x2d1 age=58
>> cpu=0 pid=0
>>> [    0.145881]  kmem_cache_alloc_trace+0x1a9/0x1c0
>>> [    0.146132]  acpi_ns_root_initialize+0xb6/0x2d1
>>> [    0.146578]  acpi_initialize_subsystem+0x65/0xa8
>>> [    0.147024]  acpi_early_init+0x5d/0xd1
>>> [    0.147132]  start_kernel+0x45b/0x518
>>> [    0.147491]  secondary_startup_64+0xb6/0xc0
>>> [    0.147897] ------------[ cut here ]------------
>>>
>>> And it seems ACPI is allocating an object via kmalloc() and then
>>> freeing it via kmem_cache_free(<"Acpi-Namespace" kmem_cache>) which
>> is wrong.
>>>> ./scripts/faddr2line vmlinux 'acpi_ns_root_initialize+0xb6'
>>> acpi_ns_root_initialize+0xb6/0x2d1:
>>> kmalloc at include/linux/slab.h:555
>>> (inlined by) kzalloc at include/linux/slab.h:669 (inlined by)
>>> acpi_os_allocate_zeroed at include/acpi/platform/aclinuxex.h:57
>>> (inlined by) acpi_ns_root_initialize at
>>> drivers/acpi/acpica/nsaccess.c:102
>>>
> Hi Vegard,
>
>> That's it :-) This fixes it for me:
> We'll take this patch for ACPICA and it will be in the next release.
>
> Rafael, do you want to take this as a part of the next rc?

Yes, I do.

Cheers!


