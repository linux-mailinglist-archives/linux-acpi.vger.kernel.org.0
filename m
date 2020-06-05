Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699421EFB31
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jun 2020 16:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgFEOYa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jun 2020 10:24:30 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34054 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgFEOY3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jun 2020 10:24:29 -0400
Received: by mail-ot1-f68.google.com with SMTP id b18so7744600oti.1;
        Fri, 05 Jun 2020 07:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tBXueIgAhTGePYxt4EA55wVZofFmvGwvt4Ki1Dv4GFA=;
        b=aEV7FqksQd0gIYU7bYycgaO8nuoE5dbEeYMNQJzG5oiNlJ+61YF1BcFyqCx7n4+pc9
         bxFl3ItSo+VUsec7EqF3898PN1U9RYxEXZTaEnmPKf+ujROiwpUbApj4CNQhDsDW6MeY
         HKA2PHbQoKXnv+GjoaOyRElxEzizRqFPHnwuWTDZUKKEQIWZSp8XvNKO6Ydf+0H8Hnw5
         JOWbyRZdvx+ljUJtb2fVX4dET58lEgT/TBZhrzKH5SDhXS1p1SOh3NCbmfFpYrVmKTKy
         APfnRj8a2gf6CDHejTMA0M9ScXq/yX79ISwLmt+s/EqqVgBMNW3d51+okoucIhGZgKR3
         atow==
X-Gm-Message-State: AOAM531gauS4Ik36SnXHLcX1m9ya2Bn52+lm15rxCG1Y0sVuko9ld7Df
        bt0b4pwQNHbEefu5fxi/PMPoVSwXPmfv/C2xlB0=
X-Google-Smtp-Source: ABdhPJwy4jpEuDjrt8q3LXzO0rVxqzf6M+4Nesej+p2sIPTXtf3ctDMxValFlrEDgGEaAVQUrxJRQcB6qzJ38s8xigk=
X-Received: by 2002:a05:6830:20d1:: with SMTP id z17mr7496168otq.167.1591367067427;
 Fri, 05 Jun 2020 07:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <4dc93ff8-f86e-f4c9-ebeb-6d3153a78d03@oracle.com>
 <7839183d-1c0b-da02-73a2-bf5e1e8b02b9@suse.cz> <94296941-1073-913c-2adb-bf2e41be9f0f@oracle.com>
 <202006041054.874AA564@keescook> <cb0cdaaa-7825-0b87-0384-db22329305bb@suse.cz>
 <34455dce-6675-1fc2-8d61-45bf56f3f554@suse.cz> <6b2b149e-c2bc-f87a-ea2c-3046c5e39bf9@oracle.com>
 <faea2c18-edbe-f8b4-b171-6be866624856@oracle.com> <CAJZ5v0jqmUmf7mv3wjniVM-YqPqhDSjxunU0E4VYCsUQqvrF_Q@mail.gmail.com>
 <ce333dcb-2b2c-3e1f-2a7e-02a7819b1db4@suse.cz>
In-Reply-To: <ce333dcb-2b2c-3e1f-2a7e-02a7819b1db4@suse.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Jun 2020 16:24:16 +0200
Message-ID: <CAJZ5v0iYDSTWWR-JO4YkMCE3ohBWm=L0Uyfhz83kHzOdONhojA@mail.gmail.com>
Subject: Re: slub freelist issue / BUG: unable to handle page fault for
 address: 000000003ffe0018
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Kees Cook <keescook@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

acpi_os_allocate_zeroed(On Fri, Jun 5, 2020 at 4:08 PM Vlastimil Babka
<vbabka@suse.cz> wrote:
>
> On 6/5/20 3:12 PM, Rafael J. Wysocki wrote:
> > On Fri, Jun 5, 2020 at 2:48 PM Vegard Nossum <vegard.nossum@oracle.com> wrote:
> >>
> >> On 2020-06-05 11:36, Vegard Nossum wrote:
> >> >
> >> > On 2020-06-05 11:11, Vlastimil Babka wrote:
> >> >> On 6/4/20 8:46 PM, Vlastimil Babka wrote:
> >> >>> On 6/4/20 7:57 PM, Kees Cook wrote:
> >> >>>> On Thu, Jun 04, 2020 at 07:20:18PM +0200, Vegard Nossum wrote:
> >> >>>>> On 2020-06-04 19:18, Vlastimil Babka wrote:
> >> >>>>>> On 6/4/20 7:14 PM, Vegard Nossum wrote:
> >> >>>>>>>
> >> >>>>>>> Hi all,
> >> >>>>>>>
> >> >>>>>>> I ran into a boot problem with latest linus/master
> >> >>>>>>> (6929f71e46bdddbf1c4d67c2728648176c67c555) that manifests like this:
> >> >>>>>>
> >> >>>>>> Hi, what's the .config you use?
> >> >>>>>
> >> >>>>> Pretty much x86_64 defconfig minus a few options (PCI, USB, ...)
> >> >>>>
> >> >>>> Oh yes indeed. I immediately crash in the same way with this config.
> >> >>>> I'll
> >> >>>> start digging...
> >> >>>>
> >> >>>> (defconfig finishes boot)
> >> >>>
> >> >>> This is funny, booting with slub_debug=F results in:
> >> >>> I'm not sure if it's ACPI or ftrace wrong here, but looks like the
> >> >>> changed
> >> >>> free pointer offset merely exposes a bug in something else.
> >> >>
> >> >> So, with Kees' patch reverted, booting with slub_debug=F (or even more
> >> >> specific slub_debug=F,ftrace_event_field) also hits this bug below. I
> >> >> wanted to bisect it, but v5.7 was also bad, and also v5.6. Didn't try
> >> >> further in history. So it's not new at all, and likely very specific to
> >> >> your config+QEMU? (and related to the ACPI error messages that precede
> >> >> it?).
> >> >
> >> > I see it too, but not on v5.0. I can bisect it.
> >>
> >> commit 67a72420a326b45514deb3f212085fb2cd1595b5
> >> Author: Bob Moore <robert.moore@intel.com>
> >> Date:   Fri Aug 16 14:43:21 2019 -0700
> >>
> >>      ACPICA: Increase total number of possible Owner IDs
> >>
> >>      ACPICA commit 1f1652dad88b9d767767bc1f7eb4f7d99e6b5324
> >>
> >>      From 255 to 4095 possible IDs.
> >>
> >>      Link: https://github.com/acpica/acpica/commit/1f1652da
> >>      Reported-by: Hedi Berriche <hedi.berriche @hpe.com>
> >>      Signed-off-by: Bob Moore <robert.moore@intel.com>
> >>      Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
> >>      Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Bob, Erik, did we miss something in that patch?
>
> Maybe the patch just changes layout in a way that exposes the bug.
>
> Anyway the "ftrace_event_field" cache is not really involved, this is just
> because of slab merging. After adding "slub_nomerge" to "slub_debug=F", it
> starts making more sense, as the cache becomes Acpi-Namespace
>
> [    0.140408] ------------[ cut here ]------------
> [    0.140837] cache_from_obj: Wrong slab cache. Acpi-Namespace but object is from kmalloc-64
> [    0.141406] WARNING: CPU: 0 PID: 1 at mm/slab.h:524 kmem_cache_free+0x1d3/0x250
> [    0.142105] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.7.0+ #45
> [    0.142393] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4-rebuilt.opensuse.org 04/01/2014
> [    0.142393] RIP: 0010:kmem_cache_free+0x1d3/0x250
> [    0.142393] Code: 18 4d 85 ed 0f 84 10 ff ff ff 4c 39 ed 74 2f 49 8b 4d 58 48 8b 55 58 48 c7 c6 10 47 a1 ac 48 c7 c7 00 c2 b0 ac e8 b1 cc eb ff <0f> 0b 48 89 de 4c 89 ef e8 10 d7 ff ff 48 8b 15 59 36 9b 00 4c 89
> [    0.142393] RSP: 0018:ffffb39cc0013dc0 EFLAGS: 00010282
> [    0.142393] RAX: 0000000000000000 RBX: ffff937287409e00 RCX: 0000000000000000
> [    0.142393] RDX: 0000000000000001 RSI: 0000000000000092 RDI: ffffffffacfdd32c
> [    0.142393] RBP: ffff93728742ef00 R08: ffffb39cc0013c7d R09: 00000000000000fc
> [    0.142393] R10: ffffb39cc0013c78 R11: ffffb39cc0013c7d R12: ffff937307409e00
> [    0.142393] R13: ffff937287401d00 R14: 0000000000000000 R15: 0000000000000000
> [    0.142393] FS:  0000000000000000(0000) GS:ffff937287a00000(0000) knlGS:0000000000000000
> [    0.142393] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.142393] CR2: 0000000000000000 CR3: 0000000003a0a000 CR4: 00000000003406f0
> [    0.142393] Call Trace:
> [    0.142393]  acpi_os_release_object+0x5/0x10
> [    0.142393]  acpi_ns_delete_children+0x46/0x59
> [    0.142393]  acpi_ns_delete_namespace_subtree+0x5c/0x79
> [    0.142393]  ? acpi_sleep_proc_init+0x1f/0x1f
> [    0.142393]  acpi_ns_terminate+0xc/0x31
> [    0.142393]  acpi_ut_subsystem_shutdown+0x45/0xa3
> [    0.142393]  ? acpi_sleep_proc_init+0x1f/0x1f
> [    0.142393]  acpi_terminate+0x5/0xf
> [    0.142393]  acpi_init+0x27b/0x308
> [    0.142393]  ? video_setup+0x79/0x79
> [    0.142393]  do_one_initcall+0x7b/0x160
> [    0.142393]  kernel_init_freeable+0x190/0x1f2
> [    0.142393]  ? rest_init+0x9a/0x9a
> [    0.142393]  kernel_init+0x5/0xf6
> [    0.142393]  ret_from_fork+0x22/0x30
> [    0.142393] ---[ end trace 3539f236ef812ba1 ]---
> [    0.142396] ------------[ cut here ]------------
>
> I've also changed the warning so it's not printed just once, and also prints tracking info
> (see the hunk at the end of my mail, I'll turn this to a proper patch later).
>
> With "slub_debug=FU slub_nomerge" there are now multiple warnings, but they all look the same:
>
> [    0.143815] ------------[ cut here ]------------
> [    0.144131] cache_from_obj: Wrong slab cache. Acpi-Namespace but object is from kmalloc-64
> [    0.144929] WARNING: CPU: 0 PID: 1 at mm/slab.h:524 kmem_cache_free+0x1d3/0x250
> [    0.145129] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.7.0+ #45
> [    0.145129] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4-rebuilt.opensuse.org 04/01/2014
> [    0.145129] RIP: 0010:kmem_cache_free+0x1d3/0x250
> [    0.145129] Code: 18 4d 85 ed 0f 84 10 ff ff ff 4c 39 ed 74 2f 49 8b 4d 58 48 8b 55 58 48 c7 c6 10 47 c1 8d 48 c7 c7 00 c2 d0 8d e8 b1 cc eb ff <0f> 0b 48 89 de 4c 89 ef e8 10 d7 ff ff 48 8b 15 59 36 9b 00 4c 89
> [    0.145129] RSP: 0018:ffff990b80013dc0 EFLAGS: 00010282
> [    0.145129] RAX: 0000000000000000 RBX: ffff972d474ada80 RCX: 0000000000000000
> [    0.145129] RDX: 0000000000000001 RSI: 0000000000000092 RDI: ffffffff8e1dd32c
> [    0.145129] RBP: ffff972d47425680 R08: ffff990b80013c7d R09: 00000000000000fc
> [    0.145129] R10: ffff990b80013c78 R11: ffff990b80013c7d R12: ffff972dc74ada80
> [    0.145129] R13: ffff972d474038c0 R14: 0000000000000000 R15: 0000000000000000
> [    0.145129] FS:  0000000000000000(0000) GS:ffff972d47a00000(0000) knlGS:0000000000000000
> [    0.145129] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.145129] CR2: 0000000000000000 CR3: 000000000660a000 CR4: 00000000003406f0
> [    0.145129] Call Trace:
> [    0.145129]  acpi_os_release_object+0x5/0x10
> [    0.145129]  acpi_ns_delete_children+0x46/0x59
> [    0.145129]  acpi_ns_delete_namespace_subtree+0x5c/0x79
> [    0.145129]  ? acpi_sleep_proc_init+0x1f/0x1f
> [    0.145129]  acpi_ns_terminate+0xc/0x31
> [    0.145129]  acpi_ut_subsystem_shutdown+0x45/0xa3
> [    0.145129]  ? acpi_sleep_proc_init+0x1f/0x1f
> [    0.145129]  acpi_terminate+0x5/0xf
> [    0.145129]  acpi_init+0x27b/0x308
> [    0.145129]  ? video_setup+0x79/0x79
> [    0.145129]  do_one_initcall+0x7b/0x160
> [    0.145129]  kernel_init_freeable+0x190/0x1f2
> [    0.145129]  ? rest_init+0x9a/0x9a
> [    0.145129]  kernel_init+0x5/0xf6
> [    0.145129]  ret_from_fork+0x22/0x30
> [    0.145129] ---[ end trace 574554fca7bd06bb ]---
> [    0.145133] INFO: Allocated in acpi_ns_root_initialize+0xb6/0x2d1 age=58 cpu=0 pid=0
> [    0.145881]  kmem_cache_alloc_trace+0x1a9/0x1c0
> [    0.146132]  acpi_ns_root_initialize+0xb6/0x2d1
> [    0.146578]  acpi_initialize_subsystem+0x65/0xa8
> [    0.147024]  acpi_early_init+0x5d/0xd1
> [    0.147132]  start_kernel+0x45b/0x518
> [    0.147491]  secondary_startup_64+0xb6/0xc0
> [    0.147897] ------------[ cut here ]------------
>
> And it seems ACPI is allocating an object via kmalloc() and then freeing it
> via kmem_cache_free(<"Acpi-Namespace" kmem_cache>) which is wrong.
>
> > ./scripts/faddr2line vmlinux 'acpi_ns_root_initialize+0xb6'
> acpi_ns_root_initialize+0xb6/0x2d1:
> kmalloc at include/linux/slab.h:555
> (inlined by) kzalloc at include/linux/slab.h:669
> (inlined by) acpi_os_allocate_zeroed at include/acpi/platform/aclinuxex.h:57
> (inlined by) acpi_ns_root_initialize at drivers/acpi/acpica/nsaccess.c:102
>
>
> ----8<----
> diff --git a/mm/slab.h b/mm/slab.h
> index 207c83ef6e06..282e78964018 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -503,6 +503,7 @@ static __always_inline void uncharge_slab_page(struct page *page, int order,
>         memcg_uncharge_slab(page, order, s);
>  }
>
> +extern void print_tracking(struct kmem_cache *s, void *object);
>  static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
>  {
>         struct kmem_cache *cachep;
> @@ -520,9 +521,11 @@ static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
>                 return s;
>
>         cachep = virt_to_cache(x);
> -       WARN_ONCE(cachep && !slab_equal_or_root(cachep, s),
> +       if (WARN(cachep && !slab_equal_or_root(cachep, s),
>                   "%s: Wrong slab cache. %s but object is from %s\n",
> -                 __func__, s->name, cachep->name);
> +                 __func__, s->name, cachep->name)) {
> +               print_tracking(cachep, x);
> +       }
>         return cachep;
>  }

Well, the bug seems to be that the object in question is allocated via
acpi_os_allocate_zeroed() while it should be allocated with
acpi_os_acquire_object().
