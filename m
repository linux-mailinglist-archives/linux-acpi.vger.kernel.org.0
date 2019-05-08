Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD90617CD4
	for <lists+linux-acpi@lfdr.de>; Wed,  8 May 2019 17:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfEHPI1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 May 2019 11:08:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7735 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726869AbfEHPI1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 8 May 2019 11:08:27 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CECED658C1D51FA908F1;
        Wed,  8 May 2019 23:08:23 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Wed, 8 May 2019
 23:08:14 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <robert.moore@intel.com>, <erik.schmauss@intel.com>,
        <rafael.j.wysocki@intel.com>, <lenb@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devel@acpica.org>,
        <linux-acpi@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] ACPICA: acpica: Fix possible NULL pointer dereference in acpi_ut_remove_reference
Date:   Wed, 8 May 2019 23:06:34 +0800
Message-ID: <20190508150634.9108-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1
 CPU: 0 PID: 7393 Comm: modprobe Not tainted 5.1.0+ #34
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.9.3-0-ge2fc41e-prebuilt.qemu-project.org 04/01/2014
 RIP: 0010:acpi_ut_update_object_reference+0xda/0x1e8
 Code: 4c 89 e7 eb ea 48 8b 7b 18 48 85 ff 0f 84 95 00 00 00 4c 8b 67 38 44 89 ee e8 dd fb ff ff 4c 89 e7 eb e6 48 8b 43 18 44 89 e2 <48> 8b 3c d0 48 85 ff 75 0b 41 ff c4 44 3b 63 2c 72 e7 eb 66 8a 47
 RSP: 0018:ffffc90001c9f550 EFLAGS: 00010283
 RAX: 0000000000000000 RBX: ffff8882310d7288 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8882310d7288
 RBP: ffffc90001c9f580 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000001 R11: 000000003ef29b78 R12: 0000000000000000
 R13: 0000000000000001 R14: ffff88823122e000 R15: 0000000000000000
 FS:  00007f4469ead540(0000) GS:ffff888237a00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 000000022c2b5000 CR4: 00000000000006f0
 Call Trace:
  acpi_ut_remove_reference+0x29/0x2c
  acpi_ut_copy_iobject_to_iobject+0xd7/0xee
  acpi_ds_store_object_to_local+0x9a/0x181
  acpi_ex_store+0x233/0x279
  ? acpi_ds_create_operands+0x74/0xdb
  acpi_ex_opcode_1A_1T_1R+0x3c3/0x4fc
  acpi_ds_exec_end_op+0xd1/0x419
  acpi_ps_parse_loop+0x532/0x5d0
  acpi_ps_parse_aml+0x93/0x2c8
  acpi_ps_execute_method+0x16d/0x1b2
  acpi_ns_evaluate+0x1c1/0x26c
  acpi_ut_evaluate_object+0x7d/0x1a4
  acpi_rs_get_prt_method_data+0x30/0x66
  acpi_get_irq_routing_table+0x3d/0x56
  acpi_pci_irq_find_prt_entry+0x8d/0x300
  ? trace_hardirqs_on+0x3f/0x110
  acpi_pci_irq_lookup+0x35/0x1f0
  acpi_pci_irq_enable+0x72/0x1e0
  ? pci_read_config_word+0x2e/0x30
  pcibios_enable_device+0x2e/0x40
  do_pci_enable_device+0x5c/0x100
  pci_enable_device_flags+0xe0/0x130
  pci_enable_device+0xe/0x10
  e1000_probe+0xd2/0xfc0 [e1000
  ? trace_hardirqs_on+0x3f/0x110
  local_pci_probe+0x41/0x90
  pci_device_probe+0x14c/0x1b0
  really_probe+0x1d4/0x2d0
  driver_probe_device+0x50/0xf0
  device_driver_attach+0x54/0x60
  __driver_attach+0x7e/0xd0
  ? device_driver_attach+0x60/0x60
  bus_for_each_dev+0x68/0xc0
  driver_attach+0x19/0x20
  bus_add_driver+0x15e/0x200
  driver_register+0x5b/0xf0
  __pci_register_driver+0x66/0x70
  ? 0xffffffffa0179000
  e1000_init_module+0x50/0x1000 [e1000
  ? 0xffffffffa0179000
  do_one_initcall+0x6c/0x3cc
  ? do_init_module+0x22/0x207
  ? rcu_read_lock_sched_held+0x97/0xb0
  ? kmem_cache_alloc_trace+0x325/0x3b0
  do_init_module+0x5b/0x207
  load_module+0x1e34/0x2560
  ? m_show+0x1d0/0x1d0
  __do_sys_finit_module+0xc5/0xd0
  __x64_sys_finit_module+0x15/0x20
  do_syscall_64+0x6b/0x1d0
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

In acpi_ut_copy_iobject_to_iobject, if
acpi_ut_copy_ipackage_to_ipackage failed with
AE_NO_MEMORY, acpi_ut_remove_reference will be
called and in which calls acpi_ut_update_object_reference,
then it try to dereference 'object->package.elements[i]'
which trigger NULL pointer dereference.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 8aa5e56eeb61 ("ACPICA: Utilities: Fix memory leak in acpi_ut_copy_iobject_to_iobject")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/acpi/acpica/utcopy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
index 1fb8327..038d518 100644
--- a/drivers/acpi/acpica/utcopy.c
+++ b/drivers/acpi/acpica/utcopy.c
@@ -895,7 +895,6 @@
 
 	dest_obj->common.type = source_obj->common.type;
 	dest_obj->common.flags = source_obj->common.flags;
-	dest_obj->package.count = source_obj->package.count;
 
 	/*
 	 * Create the object array and walk the source package tree
@@ -909,6 +908,8 @@
 		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
 
+	dest_obj->package.count = source_obj->package.count;
+
 	/*
 	 * Copy the package element-by-element by walking the package "tree".
 	 * This handles nested packages of arbitrary depth.
-- 
1.8.3.1


