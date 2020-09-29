Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF09127D5CF
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Sep 2020 20:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgI2Sey (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Sep 2020 14:34:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43447 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727740AbgI2Sey (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Sep 2020 14:34:54 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601404491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FfKogqPI4RDlW0YYC3c4xJNHnuiLN6dhs19349Htcrg=;
        b=ShkUin3Qe9Qptrwr68Grr8Z/FIH5UkgSDgPO6ja1sQG/Y5nuyx6y2wiOLxbjbwSDYAqpq7
        VYJZOIiwzhrYRGW0grJExhR7BXwz5UrypJdirVHmmYSFmgZvgUkDMv2bniYsBbACnffLJY
        Xc+7TQibTUmWVV1bpskhpvhwgmbnc1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-cHV3WGSuORKFCG_ly6EV9g-1; Tue, 29 Sep 2020 14:34:47 -0400
X-MC-Unique: cHV3WGSuORKFCG_ly6EV9g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDDF0186840A;
        Tue, 29 Sep 2020 18:34:45 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-66-32.rdu2.redhat.com [10.10.66.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA38978807;
        Tue, 29 Sep 2020 18:34:44 +0000 (UTC)
From:   Qian Cai <cai@redhat.com>
To:     Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH] ACPICA: Fix a soft-lockup on large systems
Date:   Tue, 29 Sep 2020 14:34:44 -0400
Message-Id: <20200929183444.25079-1-cai@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It could take a long time in the loop of acpi_ns_walk_namespace() on
large systems due to there are many nodes in ACPI namespace, and then
trigger a soft-lockup. Fix it by adding cond_resched() within the loop.

[   70.533393] watchdog: BUG: soft lockup - CPU#25 stuck for 22s! [swapper/0:1]
[   70.533438] Modules linked in:
[   70.533468] irq event stamp: 26257732
[   70.533489] hardirqs last  enabled at (26257731): [<ffffa000106f2e88>] __slab_alloc+0xa8/0xc8
[   70.533505] hardirqs last disabled at (26257732): [<ffffa0001017387c>] el1_irq+0x7c/0x140
el1_irq at arch/arm64/kernel/entry.S:650
[   70.533520] softirqs last  enabled at (26197382): [<ffffa00010171a90>] efi_header_end+0xa90/0x10bc
[   70.533535] softirqs last disabled at (26197377): [<ffffa0001024a63c>] irq_exit+0x2c4/0x348
[   70.533551] CPU: 25 PID: 1 Comm: swapper/0 Not tainted 5.9.0-rc7-next-20200929 #1
[   70.533563] Hardware name: HPE Apollo 70             /C01_APACHE_MB         , BIOS L50_5.13_1.15 05/08/2020
[   70.533577] pstate: 60400009 (nZCv daif +PAN -UAO -TCO BTYPE=--)
[   70.533593] pc : arch_local_irq_restore+0x4/0x8
[   70.533605] lr : __slab_alloc+0xb0/0xc8
[   70.533617] sp : ffff000005bd61a0
[   70.533628] x29: ffff000005bd61a0 x28: 000000000000000e
[   70.533653] x27: ffff0087b41c8ff8 x26: 0080000000000000
[   70.533677] x25: ffffa000190db000 x24: ffff000e788d6c10
[   70.533700] x23: ffffa00010cb41c8 x22: 00000000ffffffff
[   70.533723] x21: 0000000000012b20 x20: ffff0087b41cde10
[   70.533746] x19: 0000000000000000 x18: 1fffe001cf1193ca
[   70.533768] x17: 0000000000000000 x16: 0000000000000000
[   70.533791] x15: 0000000000071ccc x14: 0000000000071ccc
[   70.533813] x13: ffff800000b7ac1d x12: 1fffe00000b7ac1c
[   70.533836] x11: 1fffe00000b7ac1c x10: ffff800000b7ac1c
[   70.533859] x9 : dfffa00000000000 x8 : ffff000005bd60e7
[   70.533882] x7 : 00000000f2000000 x6 : dfffa00000000000
[   70.533904] x5 : 00000000f2f2f200 x4 : 00000000f2f2f2f2
[   70.533927] x3 : 1fffe00000b6ddca x2 : ffffa00019bf2000
[   70.533950] x1 : 000000000190a943 x0 : 0000000000000000
[   70.533973] Call trace:
[   70.533987]  arch_local_irq_restore+0x4/0x8
[   70.534000]  kmem_cache_alloc+0x35c/0x3c0
[   70.534015]  fill_pool+0x278/0x588
[   70.534028]  __debug_object_init+0x8c/0x1100
[   70.534041]  debug_object_activate+0x234/0x448
[   70.534055]  call_rcu+0x38/0x630
[   70.534070]  put_object+0x84/0xc0
[   70.534082]  __delete_object+0xc4/0x110
[   70.534095]  delete_object_full+0x18/0x20
[   70.534110]  kmemleak_free+0x2c/0x38
[   70.534122]  slab_free_freelist_hook+0x15c/0x240
[   70.534135]  kmem_cache_free+0x10c/0x518
[   70.534150]  acpi_os_release_object+0xc/0x18
[   70.534165]  acpi_ut_delete_object_desc+0xa8/0xac
[   70.534177]  acpi_ut_update_ref_count.part.2+0x33c/0x788
[   70.534190]  acpi_ut_update_object_reference+0x304/0x42c
[   70.534203]  acpi_ut_remove_reference+0x64/0x74
[   70.534218]  acpi_ds_store_object_to_local+0x2d8/0x300
[   70.534231]  acpi_ex_store+0x600/0x658
[   70.534244]  acpi_ex_opcode_1A_0T_1R+0x3e4/0xb34
[   70.534257]  acpi_ds_exec_end_op+0x338/0xad0
[   70.534270]  acpi_ps_parse_loop+0xdb4/0x1020
[   70.534282]  acpi_ps_parse_aml+0x1f0/0x614
[   70.534295]  acpi_ps_execute_method+0x500/0x508
[   70.534308]  acpi_ns_evaluate+0x680/0x7b4
[   70.534320]  acpi_ut_evaluate_object+0xc4/0x30c
[   70.534333]  acpi_rs_get_method_data+0x84/0xd8
[   70.534345]  acpi_walk_resources+0x13c/0x17c
[   70.534359]  __acpi_dev_get_resources+0x150/0x1d8
[   70.534371]  acpi_dev_get_resources+0x14/0x20
[   70.534384]  acpi_init_device_object+0x698/0x10b8
[   70.534396]  acpi_add_single_object+0xf8/0x1028
[   70.534408]  acpi_bus_check_add+0x160/0x3f8
[   70.534421]  acpi_ns_walk_namespace+0x1f4/0x298
[   70.534433]  acpi_walk_namespace+0xa4/0xe8
[   70.534446]  acpi_bus_scan+0xe0/0xf0
[   70.534460]  acpi_scan_init+0x218/0x51c
[   70.534472]  acpi_init+0x45c/0x4e4
[   70.534485]  do_one_initcall+0x168/0xb60
[   70.534498]  kernel_init_freeable+0x698/0x724
[   70.534511]  kernel_init+0x10/0x11c
[   70.534524]  ret_from_fork+0x10/0x18
[  113.641710] rcu: INFO: rcu_sched self-detected stall on CPU
[  113.641774] rcu:     25-....: (6495 ticks this GP) idle=cbe/1/0x4000000000000002 softirq=772/772 fqs=3246
[  113.641842]  (t=6500 jiffies g=309 q=1185230)
[  113.641852] Task dump for CPU 25:
[  113.641872] task:swapper/0       state:R  running task     stack:22624 pid:    1 ppid:     0 flags:0x0000002a
[  113.641907] Call trace:
[  113.641927]  dump_backtrace+0x0/0x398
[  113.641941]  show_stack+0x14/0x60
[  113.641956]  sched_show_task.part.94+0x358/0x374
[  113.641970]  sched_show_task+0x13c/0x1c0
[  113.641983]  dump_cpu_task+0x80/0x90
[  113.641996]  rcu_dump_cpu_stacks+0x1ac/0x1f8
[  113.642012]  rcu_sched_clock_irq+0x1d94/0x2048
[  113.642027]  update_process_times+0x30/0x1b8
[  113.642041]  tick_periodic+0x6c/0x310
[  113.642054]  tick_handle_periodic+0x70/0x140
[  113.642070]  arch_timer_handler_phys+0x48/0x68
[  113.642084]  handle_percpu_devid_irq+0x234/0xc08
[  113.642099]  generic_handle_irq+0x74/0xa0
[  113.642112]  __handle_domain_irq+0x98/0x158
[  113.642126]  gic_handle_irq+0xd0/0x158
[  113.642139]  el1_irq+0xbc/0x140
[  113.642154]  arch_local_irq_restore+0x4/0x8
[  113.642167]  kmem_cache_alloc+0x35c/0x3c0
[  113.642182]  acpi_os_acquire_object+0x28/0x30
[  113.642195]  acpi_ps_alloc_op+0x98/0x1d4
[  113.642208]  acpi_ps_create_op+0x374/0x86c
[  113.642221]  acpi_ps_parse_loop+0x3f4/0x1020
[  113.642233]  acpi_ps_parse_aml+0x1f0/0x614
[  113.642246]  acpi_ps_execute_method+0x500/0x508
[  113.642258]  acpi_ns_evaluate+0x680/0x7b4
[  113.642273]  acpi_ut_evaluate_object+0xc4/0x30c
[  113.642286]  acpi_rs_get_method_data+0x84/0xd8
[  113.642298]  acpi_walk_resources+0x13c/0x17c
[  113.642313]  __acpi_dev_get_resources+0x150/0x1d8
[  113.642325]  acpi_dev_get_resources+0x14/0x20
[  113.642338]  acpi_init_device_object+0x698/0x10b8
[  113.642351]  acpi_add_single_object+0xf8/0x1028
[  113.642363]  acpi_bus_check_add+0x160/0x3f8
acpi_bus_check_add at drivers/acpi/scan.c:1885
[  113.642376]  acpi_ns_walk_namespace+0x1f4/0x298
acpi_ns_walk_namespace at drivers/acpi/acpica/nswalk.c:237
[  113.642389]  acpi_walk_namespace+0xa4/0xe8
[  113.642401]  acpi_bus_scan+0xe0/0xf0
[  113.642416]  acpi_scan_init+0x218/0x51c
[  113.642428]  acpi_init+0x45c/0x4e4
[  113.642441]  do_one_initcall+0x168/0xb60
[  113.642455]  kernel_init_freeable+0x698/0x724
[  113.642469]  kernel_init+0x10/0x11c
[  113.642481]  ret_from_fork+0x10/0x18
[  128.674020] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7f])

Signed-off-by: Qian Cai <cai@redhat.com>
---
 drivers/acpi/acpica/nswalk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
index b7f3e8603ad8..216bf9e5a96e 100644
--- a/drivers/acpi/acpica/nswalk.c
+++ b/drivers/acpi/acpica/nswalk.c
@@ -267,6 +267,7 @@ acpi_ns_walk_namespace(acpi_object_type type,
 
 				return_ACPI_STATUS(status);
 			}
+			cond_resched();
 		}
 
 		/*
-- 
2.18.4

