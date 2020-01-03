Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6294D12F94F
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Jan 2020 15:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgACOm7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Jan 2020 09:42:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:35430 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727527AbgACOm7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 3 Jan 2020 09:42:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5F487ACB1;
        Fri,  3 Jan 2020 14:42:54 +0000 (UTC)
Date:   Fri, 3 Jan 2020 15:42:53 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v9 09/12] lib/vsprintf: Make use of fwnode API to obtain
 node names and separators
Message-ID: <20200103144253.y6fnw44oe7asyniz@pathway.suse.cz>
References: <20191003123219.11237-1-sakari.ailus@linux.intel.com>
 <20191003123219.11237-10-sakari.ailus@linux.intel.com>
 <20200102222041.GA29067@roeck-us.net>
 <20200103112145.GM19828@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103112145.GM19828@paasikivi.fi.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri 2020-01-03 13:21:45, Sakari Ailus wrote:
> Hi Guenter,
> 
> On Thu, Jan 02, 2020 at 02:20:41PM -0800, Guenter Roeck wrote:
> > Hi,
> > 
> > On Thu, Oct 03, 2019 at 03:32:16PM +0300, Sakari Ailus wrote:
> > > Instead of implementing our own means of discovering parent nodes, node
> > > names or counting how many parents a node has, use the newly added
> > > functions in the fwnode API to obtain that information.
> > > 
> > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > > ---
> > 
> > This patch results in a lockdep splat when running one of my qemu
> > emulations. See below for log and bisect results. A complete log
> > is available at
> > https://kerneltests.org/builders/qemu-arm-master/builds/1408/steps/qemubuildcommand/logs/stdio
> > 
> > Guenter
> 
> Thank you for reporting this.
> 
> I looked into the issue, and indeed I can conform the patch introduces this
> as it takes the devtree_lock for printing the name of the fwnode. There is

I guess that you meant "is not".


> however chance of a deadlock in practice as the code in mm/slub.c does not
> deal with fwnodes (in which case acquiring devtree_lock could be possible),
> maybe for other reasons as well. The patch however introduces an unpleasant
> source of such warnings.

I agree that it is a false positive. alloc/free is called in OF code
under devtree_lock. But OF code is not called from alloc/free (slub.c)
and it should not happen.

lockdep sees the cycle only because the chains are connected via
printk() and logbuf_lock.


> One approach to address this could be not allocating memory while holding
> devtree_lock spinlock. That seems entirely feasible. But could also
> releasing memory cause something to be printed, effectively causing the
> same problem?

I expect that &n->list_lock)->rlock will be needed in kfree() as well.

Anyway, IMHO, allocation outside devtree_lock spinlock would create hairy
and tricky code.

The number of needed "cache_entries" need to be counted under
devtree_lock before the allocation. It means that we would need to
take and release the lock twice. It might create a bunch of possible
races. For example, when new entries are added in the mean time. Or
when this function is called twice in parallel.


> Perhaps a safest way to fix this could be returning to use dn->full_name
> for printing node names, in which case the devtree_lock would no longer be
> taken for printing names. The effect would be though that there would be
> again one more user for the full_name field, information that can be
> reconstructed from the node's parents.

Would this avoid using devtree_lock in all %pO? modifiers?

Removing the lock usage in vsprintf() would make sense
from two reasons:

  + It would allow to use %pOF from inside drivers/of/
    code called under devtree_lock. The current implementation
    would cause a deadlock because of the recursion.

  + There is a huge effort to make printk() lockless. Any lock
    in vsprintf() is just a call for troubles. We probably should
    not have allowed this in the first place.


Finally, this problem will be gone when printk uses a lockless
ringbuffer. I hope that it will happen either for-5.6 or 5.7.
The most tricky part, the ringbuffer itself is in good shape now, see
https://lkml.kernel.org/r/20191128015235.12940-1-john.ogness@linutronix.de

Temporary solution would be to disable lockdep in vsprintf() code.
But I would really prefer to avoid the lock in vsprintf() at all.

Best Regards,
Petr

> > ---
> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 5.5.0-rc4-00066-g738d2902773e #1 Not tainted
> > ------------------------------------------------------
> > swapper/0/1 is trying to acquire lock:
> > c1313b00 (logbuf_lock){-.-.}, at: vprintk_emit+0x68/0x2d4
> > 
> > but task is already holding lock:
> > ef030b90 (&(&n->list_lock)->rlock){..-.}, at: free_debug_processing+0x38/0x418
> > 
> > which lock already depends on the new lock.
> > 
> > 
> > the existing dependency chain (in reverse order) is:
> > 
> > -> #2 (&(&n->list_lock)->rlock){..-.}:
> >        ___slab_alloc.constprop.23+0x12c/0x798
> >        __slab_alloc.constprop.22+0x44/0x70
> >        __kmalloc+0x384/0x41c
> >        of_populate_phandle_cache+0xcc/0x148
> >        of_core_init+0x8/0xbc
> >        driver_init+0x1c/0x2c
> >        kernel_init_freeable+0xac/0x1b4
> >        kernel_init+0x8/0x118
> >        ret_from_fork+0x14/0x20
> >        0x0
> > 
> > -> #1 (devtree_lock){....}:
> >        of_get_parent+0x18/0x34
> >        of_fwnode_get_parent+0x34/0x40
> >        fwnode_count_parents+0x28/0x58
> >        fwnode_full_name_string+0x18/0xa0
> >        device_node_string+0x490/0x4f0
> >        pointer+0x440/0x4d8
> >        vsnprintf+0x1bc/0x3d8
> >        vscnprintf+0xc/0x24
> >        vprintk_store+0x34/0x204
> >        vprintk_emit+0x94/0x2d4
> >        vprintk_default+0x20/0x28
> >        printk+0x30/0x54
> >        exynos4_pm_init_power_domain+0x220/0x258
> >        do_one_initcall+0x8c/0x440
> >        kernel_init_freeable+0x150/0x1b4
> >        kernel_init+0x8/0x118
> >        ret_from_fork+0x14/0x20
> >        0x0
> > 
> > -> #0 (logbuf_lock){-.-.}:
> >        lock_acquire+0xec/0x290
> >        _raw_spin_lock+0x38/0x48
> >        vprintk_emit+0x68/0x2d4
> >        vprintk_default+0x20/0x28
> >        printk+0x30/0x54
> >        unwind_frame+0x6a8/0x6fc
> >        walk_stackframe+0x2c/0x38
> >        __save_stack_trace+0x84/0x8c
> >        stack_trace_save+0x3c/0x5c
> >        set_track+0x40/0x9c
> >        free_debug_processing+0x1a4/0x418
> >        __slab_free+0x2d4/0x510
> >        kmem_cache_free+0x44c/0x49c
> >        rcu_core+0x348/0x994
> >        __do_softirq+0x164/0x668
> >        irq_exit+0x16c/0x170
> >        __handle_domain_irq+0x80/0xec
> >        gic_handle_irq+0x58/0x9c
> >        __irq_svc+0x70/0xb0
> >        raid6_neon8_gen_syndrome_real+0x264/0x39c
> >        raid6_neon8_gen_syndrome_real+0x264/0x39c
> > 
> > other info that might help us debug this:
> > 
> > Chain exists of:
> >   logbuf_lock --> devtree_lock --> &(&n->list_lock)->rlock
> > 
> >  Possible unsafe locking scenario:
> > 
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(&(&n->list_lock)->rlock);
> >                                lock(devtree_lock);
> >                                lock(&(&n->list_lock)->rlock);
> >   lock(logbuf_lock);
> > 
> >  *** DEADLOCK ***
> > 
> > 2 locks held by swapper/0/1:
> >  #0: c131466c (rcu_callback){....}, at: rcu_core+0x304/0x994
> >  #1: ef030b90 (&(&n->list_lock)->rlock){..-.}, at: free_debug_processing+0x38/0x418
> > 
> > stack backtrace:
> > CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.5.0-rc4-00066-g738d2902773e #1
> > Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> > [<c0113264>] (unwind_backtrace) from [<c010e448>] (show_stack+0x10/0x14)
> > [<c010e448>] (show_stack) from [<c0c9b754>] (dump_stack+0xa4/0xd0)
> > [<c0c9b754>] (dump_stack) from [<c018cbd8>] (check_noncircular+0x258/0x274)
> > [<c018cbd8>] (check_noncircular) from [<c019043c>] (__lock_acquire+0x1870/0x2860)
> > [<c019043c>] (__lock_acquire) from [<c018e088>] (lock_acquire+0xec/0x290)
> > [<c018e088>] (lock_acquire) from [<c0cbf278>] (_raw_spin_lock+0x38/0x48)
> > [<c0cbf278>] (_raw_spin_lock) from [<c01a1f84>] (vprintk_emit+0x68/0x2d4)
> > [<c01a1f84>] (vprintk_emit) from [<c01a2210>] (vprintk_default+0x20/0x28)
> > [<c01a2210>] (vprintk_default) from [<c01a2844>] (printk+0x30/0x54)
> > [<c01a2844>] (printk) from [<c0113210>] (unwind_frame+0x6a8/0x6fc)
> > [<c0113210>] (unwind_frame) from [<c010ddf0>] (walk_stackframe+0x2c/0x38)
> > [<c010ddf0>] (walk_stackframe) from [<c010df54>] (__save_stack_trace+0x84/0x8c)
> > [<c010df54>] (__save_stack_trace) from [<c01c2d40>] (stack_trace_save+0x3c/0x5c)
> > [<c01c2d40>] (stack_trace_save) from [<c02ae258>] (set_track+0x40/0x9c)
> > [<c02ae258>] (set_track) from [<c02b06a8>] (free_debug_processing+0x1a4/0x418)
> > [<c02b06a8>] (free_debug_processing) from [<c02b0bf0>] (__slab_free+0x2d4/0x510)
> > [<c02b0bf0>] (__slab_free) from [<c02b17ac>] (kmem_cache_free+0x44c/0x49c)
> > [<c02b17ac>] (kmem_cache_free) from [<c01bd608>] (rcu_core+0x348/0x994)
> > [<c01bd608>] (rcu_core) from [<c010230c>] (__do_softirq+0x164/0x668)
> > [<c010230c>] (__do_softirq) from [<c0131310>] (irq_exit+0x16c/0x170)
> > [<c0131310>] (irq_exit) from [<c01a3740>] (__handle_domain_irq+0x80/0xec)
> > [<c01a3740>] (__handle_domain_irq) from [<c0630828>] (gic_handle_irq+0x58/0x9c)
> > [<c0630828>] (gic_handle_irq) from [<c0101a70>] (__irq_svc+0x70/0xb0)
> > Exception stack(0xef19bd30 to 0xef19bd78)
> > bd20:                                     c0d43e50 c0d43e60 ef19bebc c0d43e70
> > bd40: c0d43e20 c0d43e10 00000400 00000430 00000440 00000450 00000460 00000470
> > bd60: c0d43e40 ef19bd80 c0d43e30 c0625c00 20000013 ffffffff
> > [<c0101a70>] (__irq_svc) from [<c0625c00>] (raid6_neon8_gen_syndrome_real+0x264/0x39c)
> > 
> > ---
> > Bisect:
> > 
> > # bad: [738d2902773e30939a982c8df7a7f94293659810] Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> > # good: [219d54332a09e8d8741c1e1982f5eae56099de85] Linux 5.4
> > git bisect start 'HEAD' 'v5.4'
> > # bad: [8c39f71ee2019e77ee14f88b1321b2348db51820] Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> > git bisect bad 8c39f71ee2019e77ee14f88b1321b2348db51820
> > # good: [3b397c7ccafe0624018cb09fc96729f8f6165573] Merge tag 'regmap-v5.5' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap
> > git bisect good 3b397c7ccafe0624018cb09fc96729f8f6165573
> > # bad: [89d57dddd7d319ded00415790a0bb3c954b7e386] Merge tag 'media/v5.5-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
> > git bisect bad 89d57dddd7d319ded00415790a0bb3c954b7e386
> > # good: [9e7a03233e02afd3ee061e373355f34d7254f1e6] Merge tag 'pm-5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> > git bisect good 9e7a03233e02afd3ee061e373355f34d7254f1e6
> > # good: [09578eacaaa44149738267083ccc050990409f86] Merge tag 'asoc-v5.5-2' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-linus
> > git bisect good 09578eacaaa44149738267083ccc050990409f86
> > # good: [1c7ae4a51298d52a21f63b2214657982036c7498] media: ad5820: Add support for of-autoload
> > git bisect good 1c7ae4a51298d52a21f63b2214657982036c7498
> > # good: [99cf8a7074c4ce3ff3685cd389f54e7bd4bbf510] media: dt-bindings: Fix building error for dt_binding_check
> > git bisect good 99cf8a7074c4ce3ff3685cd389f54e7bd4bbf510
> > # good: [782b59711e1561ee0da06bc478ca5e8249aa8d09] Merge branch 'acpi-mm'
> > git bisect good 782b59711e1561ee0da06bc478ca5e8249aa8d09
> > # good: [0ca40f41d795fd91811e44506bb73d0b9ca33bdd] Merge branch 'patchwork' into v4l_for_linus
> > git bisect good 0ca40f41d795fd91811e44506bb73d0b9ca33bdd
> > # bad: [a00351687f8a05773c1c57be80a5bbca68fa9ae8] software node: remove DEV_PROP_MAX
> > git bisect bad a00351687f8a05773c1c57be80a5bbca68fa9ae8
> > # good: [9af7706492f985867d070861fe39fee0fe41326f] lib/vsprintf: Remove support for %pF and %pf in favour of %pS and %ps
> > git bisect good 9af7706492f985867d070861fe39fee0fe41326f
> > # bad: [83abc5a77f3b028b8c845c39ce4053119e1de35b] lib/vsprintf: OF nodes are first and foremost, struct device_nodes
> > git bisect bad 83abc5a77f3b028b8c845c39ce4053119e1de35b
> > # bad: [a92eb7621b9fb2c28a588ce333d226f56fab6a85] lib/vsprintf: Make use of fwnode API to obtain node names and separators
> > git bisect bad a92eb7621b9fb2c28a588ce333d226f56fab6a85
> > # good: [1586c5ae2f9310235b5e70abe712c73fc32eb98f] lib/vsprintf: Add a note on re-using %pf or %pF
> > git bisect good 1586c5ae2f9310235b5e70abe712c73fc32eb98f
> > # first bad commit: [a92eb7621b9fb2c28a588ce333d226f56fab6a85] lib/vsprintf: Make use of fwnode API to obtain node names and separators
> 
> -- 
> Kind regards,
> 
> Sakari Ailus
