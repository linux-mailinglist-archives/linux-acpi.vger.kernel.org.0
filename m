Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E21A4EF7A
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2019 21:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfFUT3m (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Jun 2019 15:29:42 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39776 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfFUT3l (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jun 2019 15:29:41 -0400
Received: by mail-qt1-f193.google.com with SMTP id i34so8075590qta.6
        for <linux-acpi@vger.kernel.org>; Fri, 21 Jun 2019 12:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eaq6o0jEFZv8/JF3SG+zuJxqtOBR8z4g1YpyAiV+9sg=;
        b=YckziFfllqrKa9KEWXpr9B2S+pLMvT4Fqcu3KqSIm4yyPDzRmRKtdHsrjt6e6RPlCK
         uDPml6B5GjW4BC3BtJBFub4/fT4uGL5okpQaBy54w+DstFg0nC68C3TUlFy+okpJs7Bx
         8nqJLxxZPRCUJMibu5VvyFysAflgRKCre8bXqiYx7NT3V18oLlGdoxvDFuWDhzX4Qho0
         qwXv6JBbeyWAIRNGW1DnvGPREAVNcx1OHJKDSXbSscSha1Ml8ybeawOOW+0cMYd28g0C
         vVklQwCZVl9QJ7zUjaR7TLUYafnzhozdSO2NX3dhPnD+XLsazDCw55QMiF0dUX2q5WZF
         EdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eaq6o0jEFZv8/JF3SG+zuJxqtOBR8z4g1YpyAiV+9sg=;
        b=dGhYNdgy2P1PEkU/UBfMJaaCiOa1sjYmtbkkZFWSzFprdzgOV3WGxXcBIMzBSfSnVR
         y4f9+upnzH0x9XB0p1mpIQJVDTzikno+8bFzUZlxJ561RZA5W2flgP5hNCCTOqV6Nf8D
         K7/X7SNtKsUma5qcIr8tHbSWSPUYVG9XezKCmf7TKel+f+mLqPGI7g4syL07kmH/qkit
         +QlYCWjfCSQJ7wwiXovsec1PjZejXxUArD2v6d4GRRPAduXT/VOgM6tWIH9gxagchvxz
         vzv8KCs+rmilJPWxLwgaWiV8+pzkBb8iS2+Ebc8v+l3ejLmw2s5FZUhlQT+a9WS53Vdt
         F3Rw==
X-Gm-Message-State: APjAAAWLLo1EI3ISOHMrj6CG/jR16AiXYPu0a7862uGS+e6Brk1qceN+
        ZWK/6xkSTgk68kW/ESCvspLXIg==
X-Google-Smtp-Source: APXvYqyDr9MHRcfy99d2/cuLXxz/6dgagvqzeZRXZcFcm8HXGN4a8gSXm7onJWHnyosXR7D7wKaTqg==
X-Received: by 2002:a0c:b5ae:: with SMTP id g46mr46998204qve.228.1561145380422;
        Fri, 21 Jun 2019 12:29:40 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 6sm1892100qkk.69.2019.06.21.12.29.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 12:29:39 -0700 (PDT)
Message-ID: <1561145377.5154.53.camel@lca.pw>
Subject: Re: [PATCH v3 0/6] mm: Further memory block device cleanups
From:   Qian Cai <cai@lca.pw>
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
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
Date:   Fri, 21 Jun 2019 15:29:37 -0400
In-Reply-To: <1c2edc22-afd7-2211-c4c7-40e54e5007e8@redhat.com>
References: <20190620183139.4352-1-david@redhat.com>
         <1561130120.5154.47.camel@lca.pw>
         <1c2edc22-afd7-2211-c4c7-40e54e5007e8@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 2019-06-21 at 20:24 +0200, David Hildenbrand wrote:
> On 21.06.19 17:15, Qian Cai wrote:
> > On Thu, 2019-06-20 at 20:31 +0200, David Hildenbrand wrote:
> > > @Andrew: Only patch 1, 4 and 6 changed compared to v1.
> > > 
> > > Some further cleanups around memory block devices. Especially, clean up
> > > and simplify walk_memory_range(). Including some other minor cleanups.
> > > 
> > > Compiled + tested on x86 with DIMMs under QEMU. Compile-tested on ppc64.
> > > 
> > > v2 -> v3:
> > > - "mm/memory_hotplug: Rename walk_memory_range() and pass start+size .."
> > > -- Avoid warning on ppc.
> > > - "drivers/base/memory.c: Get rid of find_memory_block_hinted()"
> > > -- Fixup a comment regarding hinted devices.
> > > 
> > > v1 -> v2:
> > > - "mm: Section numbers use the type "unsigned long""
> > > -- "unsigned long i" -> "unsigned long nr", in one case -> "int i"
> > > - "drivers/base/memory.c: Get rid of find_memory_block_hinted("
> > > -- Fix compilation error
> > > -- Get rid of the "hint" parameter completely
> > > 
> > > David Hildenbrand (6):
> > >   mm: Section numbers use the type "unsigned long"
> > >   drivers/base/memory: Use "unsigned long" for block ids
> > >   mm: Make register_mem_sect_under_node() static
> > >   mm/memory_hotplug: Rename walk_memory_range() and pass start+size
> > >     instead of pfns
> > >   mm/memory_hotplug: Move and simplify walk_memory_blocks()
> > >   drivers/base/memory.c: Get rid of find_memory_block_hinted()
> > > 
> > >  arch/powerpc/platforms/powernv/memtrace.c |  23 ++---
> > >  drivers/acpi/acpi_memhotplug.c            |  19 +---
> > >  drivers/base/memory.c                     | 120 +++++++++++++---------
> > >  drivers/base/node.c                       |   8 +-
> > >  include/linux/memory.h                    |   5 +-
> > >  include/linux/memory_hotplug.h            |   2 -
> > >  include/linux/mmzone.h                    |   4 +-
> > >  include/linux/node.h                      |   7 --
> > >  mm/memory_hotplug.c                       |  57 +---------
> > >  mm/sparse.c                               |  12 +--
> > >  10 files changed, 106 insertions(+), 151 deletions(-)
> > > 
> > 
> > This series causes a few machines are unable to boot triggering endless soft
> > lockups. Reverted those commits fixed the issue.
> > 
> > 97f4217d1da0 Revert "mm/memory_hotplug: rename walk_memory_range() and pass
> > start+size instead of pfns"
> > c608eebf33c6 Revert "mm-memory_hotplug-rename-walk_memory_range-and-pass-
> > startsize-instead-of-pfns-fix"
> > 34b5e4ab7558 Revert "mm/memory_hotplug: move and simplify
> > walk_memory_blocks()"
> > 59a9f3eec5d1 Revert "drivers/base/memory.c: Get rid of
> > find_memory_block_hinted()"
> > 5cfcd52288b6 Revert "drivers-base-memoryc-get-rid-of-
> > find_memory_block_hinted-
> > v3"
> > 
> > [    4.582081][    T1] ACPI FADT declares the system doesn't support PCIe
> > ASPM,
> > so disable it
> > [    4.590405][    T1] ACPI: bus type PCI registered
> > [    4.592908][    T1] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
> > 0x80000000-0x8fffffff] (base 0x80000000)
> > [    4.601860][    T1] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved
> > in
> > E820
> > [    4.601860][    T1] PCI: Using configuration type 1 for base access
> > [   28.661336][   C16] watchdog: BUG: soft lockup - CPU#16 stuck for 22s!
> > [swapper/0:1]
> > [   28.671351][   C16] Modules linked in:
> > [   28.671354][   C16] CPU: 16 PID: 1 Comm: swapper/0 Not tainted 5.2.0-rc5-
> > next-20190621+ #1
> > [   28.681366][   C16] Hardware name: HPE ProLiant DL385 Gen10/ProLiant
> > DL385
> > Gen10, BIOS A40 03/09/2018
> > [   28.691334][   C16] RIP: 0010:_raw_spin_unlock_irqrestore+0x2f/0x40
> > [   28.701334][   C16] Code: 55 48 89 e5 41 54 49 89 f4 be 01 00 00 00 53 48
> > 8b
> > 55 08 48 89 fb 48 8d 7f 18 e8 4c 89 7d ff 48 89 df e8 94 f9 7d ff 41 54 9d
> > <65>
> > ff 0d c2 44 8d 48 5b 41 5c 5d c3 0f 1f 44 00 00 0f 1f 44 00 00
> > [   28.711354][   C16] RSP: 0018:ffff888205b27bf8 EFLAGS: 00000246 ORIG_RAX:
> > ffffffffffffff13
> > [   28.721372][   C16] RAX: 0000000000000000 RBX: ffff8882053d6138 RCX:
> > ffffffffb6f2a3b8
> > [   28.731371][   C16] RDX: 1ffff11040a7ac27 RSI: dffffc0000000000 RDI:
> > ffff8882053d6138
> > [   28.741371][   C16] RBP: ffff888205b27c08 R08: ffffed1040a7ac28 R09:
> > ffffed1040a7ac27
> > [   28.751334][   C16] R10: ffffed1040a7ac27 R11: ffff8882053d613b R12:
> > 0000000000000246
> > [   28.751370][   C16] R13: ffff888205b27c98 R14: ffff8884504d0a20 R15:
> > 0000000000000000
> > [   28.761368][   C16] FS:  0000000000000000(0000) GS:ffff888454500000(0000)
> > knlGS:0000000000000000
> > [   28.771373][   C16] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   28.781334][   C16] CR2: 0000000000000000 CR3: 00000007c9012000 CR4:
> > 00000000001406a0
> > [   28.791333][   C16] Call Trace:
> > [   28.791374][   C16]  klist_next+0xd8/0x1c0
> > [   28.791374][   C16]  subsys_find_device_by_id+0x13b/0x1f0
> > [   28.801334][   C16]  ? bus_find_device_by_name+0x20/0x20
> > [   28.801370][   C16]  ? kobject_put+0x23/0x250
> > [   28.811333][   C16]  walk_memory_blocks+0x6c/0xb8
> > [   28.811353][   C16]  ? write_policy_show+0x40/0x40
> > [   28.821334][   C16]  link_mem_sections+0x7e/0xa0
> > [   28.821369][   C16]  ? unregister_memory_block_under_nodes+0x210/0x210
> > [   28.831353][   C16]  ? __register_one_node+0x3bd/0x600
> > [   28.831353][   C16]  topology_init+0xbf/0x126
> > [   28.841364][   C16]  ? enable_cpu0_hotplug+0x1a/0x1a
> > [   28.841368][   C16]  do_one_initcall+0xfe/0x45a
> > [   28.851334][   C16]  ? initcall_blacklisted+0x150/0x150
> > [   28.851353][   C16]  ? kasan_check_write+0x14/0x20
> > [   28.861333][   C16]  ? up_write+0x75/0x140
> > [   28.861369][   C16]  kernel_init_freeable+0x619/0x6ac
> > [   28.871333][   C16]  ? rest_init+0x188/0x188
> > [   28.871353][   C16]  kernel_init+0x11/0x138
> > [   28.881363][   C16]  ? rest_init+0x188/0x188
> > [   28.881363][   C16]  ret_from_fork+0x22/0x40
> > [   56.661336][   C16] watchdog: BUG: soft lockup - CPU#16 stuck for 22s!
> > [swapper/0:1]
> > [   56.671352][   C16] Modules linked in:
> > [   56.671354][   C16] CPU: 16 PID: 1 Comm: swapper/0 Tainted:
> > G             L    5.2.0-rc5-next-20190621+ #1
> > [   56.681357][   C16] Hardware name: HPE ProLiant DL385 Gen10/ProLiant
> > DL385
> > Gen10, BIOS A40 03/09/2018
> > [   56.691356][   C16] RIP: 0010:subsys_find_device_by_id+0x168/0x1f0
> > [   56.701334][   C16] Code: 48 85 c0 74 3e 48 8d 78 58 e8 14 77 ca ff 4d 8b
> > 7e
> > 58 4d 85 ff 74 2c 49 8d bf a0 03 00 00 e8 bf 75 ca ff 45 39 a7 a0 03 00 00
> > <75>
> > c9 4c 89 ff e8 0e 89 ff ff 48 85 c0 74 bc 48 89 df e8 21 3b 24
> > [   56.721333][   C16] RSP: 0018:ffff888205b27c68 EFLAGS: 00000287 ORIG_RAX:
> > ffffffffffffff13
> > [   56.721370][   C16] RAX: 0000000000000000 RBX: ffff888205b27c90 RCX:
> > ffffffffb74c9dc1
> > [   56.731370][   C16] RDX: 0000000000000003 RSI: dffffc0000000000 RDI:
> > ffff8888774ec3e0
> > [   56.741371][   C16] RBP: ffff888205b27cf8 R08: ffffed1040a7ac28 R09:
> > ffffed1040a7ac27
> > [   56.751335][   C16] R10: ffffed1040a7ac27 R11: ffff8882053d613b R12:
> > 0000000000085c1b
> > [   56.761334][   C16] R13: 1ffff11040b64f8e R14: ffff888450de4a20 R15:
> > ffff8888774ec040
> > [   56.761372][   C16] FS:  0000000000000000(0000) GS:ffff888454500000(0000)
> > knlGS:0000000000000000
> > [   56.771374][   C16] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   56.781370][   C16] CR2: 0000000000000000 CR3: 00000007c9012000 CR4:
> > 00000000001406a0
> > [   56.791373][   C16] Call Trace:
> > [   56.791373][   C16]  ? bus_find_device_by_name+0x20/0x20
> > [   56.801334][   C16]  ? kobject_put+0x23/0x250
> > [   56.801334][   C16]  walk_memory_blocks+0x6c/0xb8
> > [   56.811333][   C16]  ? write_policy_show+0x40/0x40
> > [   56.811353][   C16]  link_mem_sections+0x7e/0xa0
> > [   56.811353][   C16]  ? unregister_memory_block_under_nodes+0x210/0x210
> > [   56.821333][   C16]  ? __register_one_node+0x3bd/0x600
> > [   56.831333][   C16]  topology_init+0xbf/0x126
> > [   56.831355][   C16]  ? enable_cpu0_hotplug+0x1a/0x1a
> > [   56.841334][   C16]  do_one_initcall+0xfe/0x45a
> > [   56.841334][   C16]  ? initcall_blacklisted+0x150/0x150
> > [   56.851333][   C16]  ? kasan_check_write+0x14/0x20
> > [   56.851354][   C16]  ? up_write+0x75/0x140
> > [   56.861333][   C16]  kernel_init_freeable+0x619/0x6ac
> > [   56.861333][   C16]  ? rest_init+0x188/0x188
> > [   56.861369][   C16]  kernel_init+0x11/0x138
> > [   56.871333][   C16]  ? rest_init+0x188/0x188
> > [   56.871354][   C16]  ret_from_fork+0x22/0x40
> > [   64.601362][   C16] rcu: INFO: rcu_sched self-detected stall on CPU
> > [   64.611335][   C16] rcu: 	16-....: (5958 ticks this GP)
> > idle=37e/1/0x4000000000000002 softirq=27/27 fqs=3000 
> > [   64.621334][   C16] 	(t=6002 jiffies g=-1079 q=25)
> > [   64.621334][   C16] NMI backtrace for cpu 16
> > [   64.621374][   C16] CPU: 16 PID: 1 Comm: swapper/0 Tainted:
> > G             L    5.2.0-rc5-next-20190621+ #1
> > [   64.631372][   C16] Hardware name: HPE ProLiant DL385 Gen10/ProLiant
> > DL385
> > Gen10, BIOS A40 03/09/2018
> > [   64.641371][   C16] Call Trace:
> > [   64.651337][   C16]  <IRQ>
> > [   64.651376][   C16]  dump_stack+0x62/0x9a
> > [   64.651376][   C16]  nmi_cpu_backtrace.cold.0+0x2e/0x33
> > [   64.661337][   C16]  ? nmi_cpu_backtrace_handler+0x20/0x20
> > [   64.661337][   C16]  nmi_trigger_cpumask_backtrace+0x1a6/0x1b9
> > [   64.671353][   C16]  arch_trigger_cpumask_backtrace+0x19/0x20
> > [   64.681366][   C16]  rcu_dump_cpu_stacks+0x18b/0x1d6
> > [   64.681366][   C16]  rcu_sched_clock_irq.cold.64+0x368/0x791
> > [   64.691336][   C16]  ? kasan_check_read+0x11/0x20
> > [   64.691354][   C16]  ? __raise_softirq_irqoff+0x66/0x150
> > [   64.701336][   C16]  update_process_times+0x2f/0x60
> > [   64.701362][   C16]  tick_periodic+0x38/0xe0
> > [   64.711334][   C16]  tick_handle_periodic+0x2e/0x80
> > [   64.711353][   C16]  smp_apic_timer_interrupt+0xfb/0x370
> > [   64.721367][   C16]  apic_timer_interrupt+0xf/0x20
> > [   64.721367][   C16]  </IRQ>
> > [   64.721367][   C16] RIP: 0010:_raw_spin_unlock_irqrestore+0x2f/0x40
> > [   64.731370][   C16] Code: 55 48 89 e5 41 54 49 89 f4 be 01 00 00 00 53 
> > 
> 
> @Qian Cai, unfortunately I can't reproduce.
> 
> If you get the chance, it would be great if you could retry with
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 972c5336bebf..742f99ddd148 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -868,6 +868,9 @@ int walk_memory_blocks(unsigned long start, unsigned
> long size,
>         unsigned long block_id;
>         int ret = 0;
> 
> +       if (!size)
> +               return;
> +
>         for (block_id = start_block_id; block_id <= end_block_id;
> block_id++) {
>                 mem = find_memory_block_by_id(block_id);
>                 if (!mem)
> 
> 
> 
> If both, start and size are 0, we would get a veeeery long loop. This
> would mean that we have an online node that does not span any pages at
> all (pgdat->node_start_pfn = 0, start_pfn + pgdat->node_spanned_pages = 0).
> 

It works fine here.
