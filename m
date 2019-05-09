Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2EA18451
	for <lists+linux-acpi@lfdr.de>; Thu,  9 May 2019 06:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbfEIET7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 May 2019 00:19:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7736 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725774AbfEIET7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 9 May 2019 00:19:59 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0D2E184F714A38271ED9;
        Thu,  9 May 2019 12:19:56 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Thu, 9 May 2019
 12:19:54 +0800
Subject: Re: [PATCH] ACPICA: acpica: Fix possible NULL pointer dereference in
 acpi_ut_remove_reference
To:     "Schmauss, Erik" <erik.schmauss@intel.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>
References: <20190508150634.9108-1-yuehaibing@huawei.com>
 <CF6A88132359CE47947DB4C6E1709ED53C5AAB1C@ORSMSX122.amr.corp.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <a062710c-3a97-b9c1-996a-365ef6c31901@huawei.com>
Date:   Thu, 9 May 2019 12:19:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53C5AAB1C@ORSMSX122.amr.corp.intel.com>
Content-Type: multipart/mixed;
        boundary="------------73DCA54FF54A10EFA34593D6"
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

--------------73DCA54FF54A10EFA34593D6
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit

On 2019/5/9 3:52, Schmauss, Erik wrote:
> 
> 
>> -----Original Message-----
>> From: YueHaibing [mailto:yuehaibing@huawei.com]
>> Sent: Wednesday, May 8, 2019 8:07 AM
>> To: Moore, Robert <robert.moore@intel.com>; Schmauss, Erik
>> <erik.schmauss@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>;
>> lenb@kernel.org
>> Cc: linux-kernel@vger.kernel.org; devel@acpica.org; linux-
>> acpi@vger.kernel.org; YueHaibing <yuehaibing@huawei.com>
>> Subject: [PATCH] ACPICA: acpica: Fix possible NULL pointer dereference in
>> acpi_ut_remove_reference
>>
>>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>>  #PF: supervisor read access in kernel mode
>>  #PF: error_code(0x0000) - not-present page  PGD 0 P4D 0
>>  Oops: 0000 [#1
>>  CPU: 0 PID: 7393 Comm: modprobe Not tainted 5.1.0+ #34  Hardware name:
>> QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.9.3-0-ge2fc41e-
>> prebuilt.qemu-project.org 04/01/2014
>>  RIP: 0010:acpi_ut_update_object_reference+0xda/0x1e8
>>  Code: 4c 89 e7 eb ea 48 8b 7b 18 48 85 ff 0f 84 95 00 00 00 4c 8b 67 38 44 89 ee
>> e8 dd fb ff ff 4c 89 e7 eb e6 48 8b 43 18 44 89 e2 <48> 8b 3c d0 48 85 ff 75 0b 41
>> ff c4 44 3b 63 2c 72 e7 eb 66 8a 47
>>  RSP: 0018:ffffc90001c9f550 EFLAGS: 00010283
>>  RAX: 0000000000000000 RBX: ffff8882310d7288 RCX: 0000000000000000
>>  RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8882310d7288
>>  RBP: ffffc90001c9f580 R08: 0000000000000000 R09: 0000000000000000
>>  R10: 0000000000000001 R11: 000000003ef29b78 R12: 0000000000000000
>>  R13: 0000000000000001 R14: ffff88823122e000 R15: 0000000000000000
>>  FS:  00007f4469ead540(0000) GS:ffff888237a00000(0000)
>> knlGS:0000000000000000
>>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>  CR2: 0000000000000000 CR3: 000000022c2b5000 CR4: 00000000000006f0  Call
>> Trace:
>>   acpi_ut_remove_reference+0x29/0x2c
>>   acpi_ut_copy_iobject_to_iobject+0xd7/0xee
>>   acpi_ds_store_object_to_local+0x9a/0x181
>>   acpi_ex_store+0x233/0x279
>>   ? acpi_ds_create_operands+0x74/0xdb
>>   acpi_ex_opcode_1A_1T_1R+0x3c3/0x4fc
>>   acpi_ds_exec_end_op+0xd1/0x419
>>   acpi_ps_parse_loop+0x532/0x5d0
>>   acpi_ps_parse_aml+0x93/0x2c8
>>   acpi_ps_execute_method+0x16d/0x1b2
>>   acpi_ns_evaluate+0x1c1/0x26c
>>   acpi_ut_evaluate_object+0x7d/0x1a4
>>   acpi_rs_get_prt_method_data+0x30/0x66
>>   acpi_get_irq_routing_table+0x3d/0x56
>>   acpi_pci_irq_find_prt_entry+0x8d/0x300
>>   ? trace_hardirqs_on+0x3f/0x110
>>   acpi_pci_irq_lookup+0x35/0x1f0
>>   acpi_pci_irq_enable+0x72/0x1e0
>>   ? pci_read_config_word+0x2e/0x30
>>   pcibios_enable_device+0x2e/0x40
>>   do_pci_enable_device+0x5c/0x100
>>   pci_enable_device_flags+0xe0/0x130
>>   pci_enable_device+0xe/0x10
>>   e1000_probe+0xd2/0xfc0 [e1000
>>   ? trace_hardirqs_on+0x3f/0x110
>>   local_pci_probe+0x41/0x90
>>   pci_device_probe+0x14c/0x1b0
>>   really_probe+0x1d4/0x2d0
>>   driver_probe_device+0x50/0xf0
>>   device_driver_attach+0x54/0x60
>>   __driver_attach+0x7e/0xd0
>>   ? device_driver_attach+0x60/0x60
>>   bus_for_each_dev+0x68/0xc0
>>   driver_attach+0x19/0x20
>>   bus_add_driver+0x15e/0x200
>>   driver_register+0x5b/0xf0
>>   __pci_register_driver+0x66/0x70
>>   ? 0xffffffffa0179000
>>   e1000_init_module+0x50/0x1000 [e1000
>>   ? 0xffffffffa0179000
>>   do_one_initcall+0x6c/0x3cc
>>   ? do_init_module+0x22/0x207
>>   ? rcu_read_lock_sched_held+0x97/0xb0
>>   ? kmem_cache_alloc_trace+0x325/0x3b0
>>   do_init_module+0x5b/0x207
>>   load_module+0x1e34/0x2560
>>   ? m_show+0x1d0/0x1d0
>>   __do_sys_finit_module+0xc5/0xd0
>>   __x64_sys_finit_module+0x15/0x20
>>   do_syscall_64+0x6b/0x1d0
>>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> In acpi_ut_copy_iobject_to_iobject, if
>> acpi_ut_copy_ipackage_to_ipackage failed with AE_NO_MEMORY,
>> acpi_ut_remove_reference will be called and in which calls
>> acpi_ut_update_object_reference, then it try to dereference 'object-
>>> package.elements[i]'
>> which trigger NULL pointer dereference.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Fixes: 8aa5e56eeb61 ("ACPICA: Utilities: Fix memory leak in
>> acpi_ut_copy_iobject_to_iobject")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/acpi/acpica/utcopy.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c index
>> 1fb8327..038d518 100644
>> --- a/drivers/acpi/acpica/utcopy.c
>> +++ b/drivers/acpi/acpica/utcopy.c
>> @@ -895,7 +895,6 @@
>>
>>  	dest_obj->common.type = source_obj->common.type;
>>  	dest_obj->common.flags = source_obj->common.flags;
>> -	dest_obj->package.count = source_obj->package.count;
>>
>>  	/*
>>  	 * Create the object array and walk the source package tree @@ -
>> 909,6 +908,8 @@
>>  		return_ACPI_STATUS(AE_NO_MEMORY);
>>  	}
>>
>> +	dest_obj->package.count = source_obj->package.count;
>> +
>>  	/*
>>  	 * Copy the package element-by-element by walking the package
>> "tree".
>>  	 * This handles nested packages of arbitrary depth.
>> --
>> 1.8.3.1
>>
> 
> Please provide the acpidump as well as the dmesg

acpidump is attached and full CallTrace as below:

[ 1325.207834][ T5707] modprobe (5707) used greatest stack depth: 11672 bytes left
[ 1325.210188][ T5710] e1000 0000:00:03.0 enp0s3: renamed from eth0
finit_module(3, "", 0[ 1325.409956][ T5733] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[ 1325.411224][ T5733] e1000: Copyright (c) 1999-2006 Intel Corporation.
[ 1325.412416][ T5733] FAULT_INJECTION: forcing a failure.
[ 1325.412416][ T5733] name failslab, interval 1, probability 0, space 0, times 0
[ 1325.414494][ T5733] CPU: 0 PID: 5733 Comm: modprobe Not tainted 5.1.0+ #48
[ 1325.415585][ T5733] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.9.3-0-ge2fc41e-prebuilt.qemu-project.org 04/01/2014
[ 1325.417495][ T5733] Call Trace:
[ 1325.418050][ T5733]  dump_stack+0xa5/0xdc
[ 1325.418651][ T5733]  should_fail+0x145/0x170
[ 1325.419388][ T5733]  __should_failslab+0x49/0x50
[ 1325.420070][ T5733]  should_failslab+0x9/0x14
[ 1325.420697][ T5733]  __kmalloc+0x70/0x710
[ 1325.421453][ T5733]  ? acpi_ut_allocate_object_desc_dbg+0x3c/0x67
[ 1325.422332][ T5733]  ? acpi_os_allocate_zeroed+0x2b/0x2d
[ 1325.423224][ T5733]  acpi_os_allocate_zeroed+0x2b/0x2d
[ 1325.423978][ T5733]  acpi_ut_copy_iobject_to_iobject+0x72/0xef
[ 1325.424868][ T5733]  acpi_ds_store_object_to_local+0x98/0x17e
[ 1325.425715][ T5733]  acpi_ex_store+0x22f/0x271
[ 1325.426423][ T5733]  ? acpi_ex_resolve_to_value+0x77/0x255
[ 1325.427221][ T5733]  acpi_ex_opcode_1A_1T_1R+0x3d0/0x504
[ 1325.428021][ T5733]  ? acpi_ex_resolve_operands+0x203/0x538
[ 1325.428831][ T5733]  acpi_ds_exec_end_op+0xca/0x41b
[ 1325.429535][ T5733]  acpi_ps_parse_loop+0x49b/0x5cf
[ 1325.430372][ T5733]  acpi_ps_parse_aml+0x94/0x2c2
[ 1325.431390][ T5733]  acpi_ps_execute_method+0x163/0x19a
[ 1325.432193][ T5733]  acpi_ns_evaluate+0x1c4/0x260
[ 1325.432892][ T5733]  acpi_ut_evaluate_object+0x82/0x19c
[ 1325.433644][ T5733]  acpi_rs_get_prt_method_data+0x30/0x6a
[ 1325.434441][ T5733]  ? acpi_rs_validate_parameters+0x3a/0x4e
[ 1325.435450][ T5733]  acpi_get_irq_routing_table+0x34/0x4d
[ 1325.436343][ T5733]  acpi_pci_irq_find_prt_entry+0x89/0x2e0
[ 1325.437428][ T5733]  ? trace_hardirqs_on+0x3b/0x110
[ 1325.438180][ T5733]  acpi_pci_irq_lookup+0x35/0x1b0
[ 1325.439006][ T5733]  acpi_pci_irq_enable+0x70/0x1c0
[ 1325.439714][ T5733]  ? pci_read_config_word+0x1e/0x30
[ 1325.440456][ T5733]  pcibios_enable_device+0x29/0x30
[ 1325.441179][ T5733]  do_pci_enable_device+0x83/0x100
[ 1325.441907][ T5733]  pci_enable_device_flags+0xe3/0x130
[ 1325.442659][ T5733]  ? __pm_runtime_resume+0x56/0x80
[ 1325.443379][ T5733]  pci_enable_device+0xe/0x10
[ 1325.444188][ T5733]  e1000_probe+0xcf/0xfa0 [e1000]
[ 1325.444911][ T5733]  local_pci_probe+0x42/0x90
[ 1325.445573][ T5733]  pci_device_probe+0x144/0x1b0
[ 1325.446262][ T5733]  really_probe+0x1ba/0x2c0
[ 1325.446912][ T5733]  driver_probe_device+0x50/0xf0
[ 1325.447604][ T5733]  device_driver_attach+0x53/0x60
[ 1325.448317][ T5733]  __driver_attach+0x72/0xc0
[ 1325.448973][ T5733]  ? device_driver_attach+0x60/0x60
[ 1325.449712][ T5733]  bus_for_each_dev+0x76/0xc0
[ 1325.450372][ T5733]  driver_attach+0x19/0x20
[ 1325.451001][ T5733]  bus_add_driver+0x179/0x200
[ 1325.451660][ T5733]  ? 0xffffffffa0174000
[ 1325.452247][ T5733]  driver_register+0x5b/0xf0
[ 1325.452903][ T5733]  ? 0xffffffffa0174000
[ 1325.453496][ T5733]  __pci_register_driver+0x66/0x70
[ 1325.454218][ T5733]  e1000_init_module+0x4c/0x1000 [e1000]
[ 1325.455020][ T5733]  do_one_initcall+0x65/0x350
[ 1325.455679][ T5733]  do_init_module+0x5a/0x205
[ 1325.456328][ T5733]  load_module+0x1f07/0x2710
[ 1325.456983][ T5733]  ? ima_post_read_file+0xec/0x130
[ 1325.457705][ T5733]  __do_sys_finit_module+0xd1/0xf0
[ 1325.458436][ T5733]  ? __do_sys_finit_module+0xd1/0xf0
[ 1325.459199][ T5733]  __x64_sys_finit_module+0x15/0x20
[ 1325.459954][ T5733]  do_syscall_64+0x6e/0x1f0
[ 1325.460582][ T5733]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 1325.461411][ T5733] RIP: 0033:0x7f641c63d839
[ 1325.462035][ T5733] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
[ 1325.464809][ T5733] RSP: 002b:00007ffc9fe7ee08 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[ 1325.465989][ T5733] RAX: ffffffffffffffda RBX: 000055854b7b3bf0 RCX: 00007f641c63d839
[ 1325.467110][ T5733] RDX: 0000000000000000 RSI: 000055854a76dc2e RDI: 0000000000000003
[ 1325.468231][ T5733] RBP: 000055854a76dc2e R08: 0000000000000000 R09: 000055854b7b5e80
[ 1325.469494][ T5733] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
[ 1325.470615][ T5733] R13: 000055854b7b3ba0 R14: 0000000000040000 R15: 000055854b7b3bf0
[ 1325.479649][ T5733] ACPI Error: Package allocation failure (20190405/utcopy-908)
[ 1325.480771][ T5733] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 1325.481994][ T5733] #PF: supervisor read access in kernel mode
[ 1325.482844][ T5733] #PF: error_code(0x0000) - not-present page
[ 1325.483685][ T5733] PGD 0 P4D 0
[ 1325.484261][ T5733] Oops: 0000 [#1] PREEMPT SMP
[ 1325.485013][ T5733] CPU: 0 PID: 5733 Comm: modprobe Not tainted 5.1.0+ #48
[ 1325.486110][ T5733] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.9.3-0-ge2fc41e-prebuilt.qemu-project.org 04/01/2014
[ 1325.487999][ T5733] RIP: 0010:acpi_ut_update_object_reference+0xda/0x1e9
[ 1325.489042][ T5733] Code: 4c 89 e7 eb ea 48 8b 7b 18 48 85 ff 0f 84 94 00 00 00 4c 8b 67 38 44 89 ee e8 e8 fb ff ff 4c 89 e7 eb e6 48 8b 53 18 44 89 e0 <48> 8b 3c c2 48 85 ff 75 0b 41 ff c4 44 39 63 2c 77 e7 eb 65 8a 47
[ 1325.491970][ T5733] RSP: 0018:ffffc90001c6b548 EFLAGS: 00010202
[ 1325.492904][ T5733] RAX: 0000000000000000 RBX: ffff8882312c01f8 RCX: 0000000000000000
[ 1325.494109][ T5733] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8882312c01f8
[ 1325.495307][ T5733] RBP: ffffc90001c6b578 R08: 0000000000000000 R09: 0000000000000000
[ 1325.496495][ T5733] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[ 1325.497668][ T5733] R13: 0000000000000001 R14: ffff888232bcf800 R15: 0000000000000000
[ 1325.498924][ T5733] FS:  00007f641cb34540(0000) GS:ffff888237a00000(0000) knlGS:0000000000000000
[ 1325.500237][ T5733] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1325.501243][ T5733] CR2: 0000000000000000 CR3: 000000022bf0b000 CR4: 00000000000006f0
[ 1325.502433][ T5733] Call Trace:
[ 1325.502954][ T5733]  acpi_ut_remove_reference+0x29/0x2d
[ 1325.503706][ T5733]  acpi_ut_copy_iobject_to_iobject+0xe2/0xef
[ 1325.504643][ T5733]  acpi_ds_store_object_to_local+0x98/0x17e
[ 1325.505530][ T5733]  acpi_ex_store+0x22f/0x271
[ 1325.506222][ T5733]  ? acpi_ex_resolve_to_value+0x77/0x255
[ 1325.507098][ T5733]  acpi_ex_opcode_1A_1T_1R+0x3d0/0x504
[ 1325.507943][ T5733]  ? acpi_ex_resolve_operands+0x203/0x538
[ 1325.508750][ T5733]  acpi_ds_exec_end_op+0xca/0x41b
[ 1325.509517][ T5733]  acpi_ps_parse_loop+0x49b/0x5cf
[ 1325.510243][ T5733]  acpi_ps_parse_aml+0x94/0x2c2
[ 1325.511055][ T5733]  acpi_ps_execute_method+0x163/0x19a
[ 1325.511845][ T5733]  acpi_ns_evaluate+0x1c4/0x260
[ 1325.512611][ T5733]  acpi_ut_evaluate_object+0x82/0x19c
[ 1325.513368][ T5733]  acpi_rs_get_prt_method_data+0x30/0x6a
[ 1325.514180][ T5733]  ? acpi_rs_validate_parameters+0x3a/0x4e
[ 1325.515064][ T5733]  acpi_get_irq_routing_table+0x34/0x4d
[ 1325.515853][ T5733]  acpi_pci_irq_find_prt_entry+0x89/0x2e0
[ 1325.516658][ T5733]  ? trace_hardirqs_on+0x3b/0x110
[ 1325.517434][ T5733]  acpi_pci_irq_lookup+0x35/0x1b0
[ 1325.518171][ T5733]  acpi_pci_irq_enable+0x70/0x1c0
[ 1325.518941][ T5733]  ? pci_read_config_word+0x1e/0x30
[ 1325.519671][ T5733]  pcibios_enable_device+0x29/0x30
[ 1325.520460][ T5733]  do_pci_enable_device+0x83/0x100
[ 1325.521195][ T5733]  pci_enable_device_flags+0xe3/0x130
[ 1325.521975][ T5733]  ? __pm_runtime_resume+0x56/0x80
[ 1325.522689][ T5733]  pci_enable_device+0xe/0x10
[ 1325.523427][ T5733]  e1000_probe+0xcf/0xfa0 [e1000]
[ 1325.524218][ T5733]  local_pci_probe+0x42/0x90
[ 1325.524890][ T5733]  pci_device_probe+0x144/0x1b0
[ 1325.525575][ T5733]  really_probe+0x1ba/0x2c0
[ 1325.526255][ T5733]  driver_probe_device+0x50/0xf0
[ 1325.526977][ T5733]  device_driver_attach+0x53/0x60
[ 1325.527679][ T5733]  __driver_attach+0x72/0xc0
[ 1325.528330][ T5733]  ? device_driver_attach+0x60/0x60
[ 1325.529080][ T5733]  bus_for_each_dev+0x76/0xc0
[ 1325.529747][ T5733]  driver_attach+0x19/0x20
[ 1325.530368][ T5733]  bus_add_driver+0x179/0x200
[ 1325.531105][ T5733]  ? 0xffffffffa0174000
[ 1325.531688][ T5733]  driver_register+0x5b/0xf0
[ 1325.532411][ T5733]  ? 0xffffffffa0174000
[ 1325.533066][ T5733]  __pci_register_driver+0x66/0x70
[ 1325.533809][ T5733]  e1000_init_module+0x4c/0x1000 [e1000]
[ 1325.534639][ T5733]  do_one_initcall+0x65/0x350
[ 1325.535342][ T5733]  do_init_module+0x5a/0x205
[ 1325.536014][ T5733]  load_module+0x1f07/0x2710
[ 1325.536656][ T5733]  ? ima_post_read_file+0xec/0x130
[ 1325.537389][ T5733]  __do_sys_finit_module+0xd1/0xf0
[ 1325.538174][ T5733]  ? __do_sys_finit_module+0xd1/0xf0
[ 1325.538978][ T5733]  __x64_sys_finit_module+0x15/0x20
[ 1325.539706][ T5733]  do_syscall_64+0x6e/0x1f0
[ 1325.540343][ T5733]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 1325.541177][ T5733] RIP: 0033:0x7f641c63d839
[ 1325.541818][ T5733] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
[ 1325.544631][ T5733] RSP: 002b:00007ffc9fe7ee08 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[ 1325.545913][ T5733] RAX: ffffffffffffffda RBX: 000055854b7b3bf0 RCX: 00007f641c63d839
[ 1325.547096][ T5733] RDX: 0000000000000000 RSI: 000055854a76dc2e RDI: 0000000000000003
[ 1325.548265][ T5733] RBP: 000055854a76dc2e R08: 0000000000000000 R09: 000055854b7b5e80
[ 1325.549468][ T5733] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
[ 1325.550603][ T5733] R13: 000055854b7b3ba0 R14: 0000000000040000 R15: 000055854b7b3bf0
[ 1325.551731][ T5733] Modules linked in: e1000(+) ip_tables ipv6 [last unloaded: e1000]
[ 1325.552864][ T5733] CR2: 0000000000000000
[ 1325.554138][ T5733] ---[ end trace 5346f55aacb38eb5 ]---
[ 1325.555027][ T5733] RIP: 0010:acpi_ut_update_object_reference+0xda/0x1e9
[ 1325.556395][ T5733] Code: 4c 89 e7 eb ea 48 8b 7b 18 48 85 ff 0f 84 94 00 00 00 4c 8b 67 38 44 89 ee e8 e8 fb ff ff 4c 89 e7 eb e6 48 8b 53 18 44 89 e0 <48> 8b 3c c2 48 85 ff 75 0b 41 ff c4 44 39 63 2c 77 e7 eb 65 8a 47
[ 1325.559271][ T5733] RSP: 0018:ffffc90001c6b548 EFLAGS: 00010202
[ 1325.560199][ T5733] RAX: 0000000000000000 RBX: ffff8882312c01f8 RCX: 0000000000000000
[ 1325.561343][ T5733] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8882312c01f8
[ 1325.562568][ T5733] RBP: ffffc90001c6b578 R08: 0000000000000000 R09: 0000000000000000
[ 1325.563773][ T5733] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[ 1325.564974][ T5733] R13: 0000000000000001 R14: ffff888232bcf800 R15: 0000000000000000
[ 1325.569567][ T5733] FS:  00007f641cb34540(0000) GS:ffff888237a00000(0000) knlGS:0000000000000000
[ 1325.571031][ T5733] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1325.572072][ T5733] CR2: 00007fa706d674a0 CR3: 000000022bf0b000 CR4: 00000000000006f0
[ 1325.573260][ T5733] Kernel panic - not syncing: Fatal exception
[ 1325.574611][ T5733] Kernel Offset: disabled
[ 1325.575233][ T5733] Rebooting in 86400 seconds..

> 
> Thanks,
> Erik
> 
> .
> 

--------------73DCA54FF54A10EFA34593D6
Content-Type: text/plain; charset="UTF-8"; name="acpi_table.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="acpi_table.out"

APIC @ 0x0000000000000000
  0000: 41 50 49 43 78 00 00 00 01 ED 42 4F 43 48 53 20  APICx.....BOCHS 
  0010: 42 58 50 43 41 50 49 43 01 00 00 00 42 58 50 43  BXPCAPIC....BXPC
  0020: 01 00 00 00 00 00 E0 FE 01 00 00 00 00 08 00 00  ................
  0030: 01 00 00 00 01 0C 00 00 00 00 C0 FE 00 00 00 00  ................
  0040: 02 0A 00 00 02 00 00 00 00 00 02 0A 00 05 05 00  ................
  0050: 00 00 0D 00 02 0A 00 09 09 00 00 00 0D 00 02 0A  ................
  0060: 00 0A 0A 00 00 00 0D 00 02 0A 00 0B 0B 00 00 00  ................
  0070: 0D 00 04 06 FF 00 00 01                          ........

DSDT @ 0x0000000000000000
  0000: 44 53 44 54 78 17 00 00 01 EC 42 4F 43 48 53 20  DSDTx.....BOCHS 
  0010: 42 58 50 43 44 53 44 54 01 00 00 00 42 58 50 43  BXPCDSDT....BXPC
  0020: 01 00 00 00 10 49 04 5C 00 5B 80 44 42 47 5F 01  .....I.\.[.DBG_.
  0030: 0B 02 04 01 5B 81 0B 44 42 47 5F 01 44 42 47 42  ....[..DBG_.DBGB
  0040: 08 14 2C 44 42 55 47 01 98 68 60 96 60 60 74 87  ..,DBUG..h`.``t.
  0050: 60 01 61 70 00 62 A2 10 95 62 61 70 83 88 60 62  `.ap.b...bap..`b
  0060: 00 44 42 47 42 75 62 70 0A 0A 44 42 47 42 10 22  .DBGBubp..DBGB."
  0070: 5F 53 42 5F 5B 82 1B 50 43 49 30 08 5F 48 49 44  _SB_[..PCI0._HID
  0080: 0C 41 D0 0A 03 08 5F 41 44 52 00 08 5F 55 49 44  .A...._ADR.._UID
  0090: 01 10 4D 08 5F 53 42 5F 5B 82 45 08 48 50 45 54  ..M._SB_[.E.HPET
  00A0: 08 5F 48 49 44 0C 41 D0 01 03 08 5F 55 49 44 00  ._HID.A...._UID.
  00B0: 5B 80 48 50 54 4D 00 0C 00 00 D0 FE 0B 00 04 5B  [.HPTM.........[
  00C0: 81 10 48 50 54 4D 13 56 45 4E 44 20 50 52 44 5F  ..HPTM.VEND PRD_
  00D0: 20 14 36 5F 53 54 41 00 70 56 45 4E 44 60 70 50   .6_STA.pVEND`pP
  00E0: 52 44 5F 61 7A 60 0A 10 60 A0 0C 91 93 60 00 93  RD_az`..`....`..
  00F0: 60 0B FF FF A4 00 A0 0E 91 93 61 00 94 61 0C 00  `.........a..a..
  0100: E1 F5 05 A4 00 A4 0A 0F 08 5F 43 52 53 11 11 0A  ........._CRS...
  0110: 0E 86 09 00 00 00 00 D0 FE 00 04 00 00 79 00 10  .............y..
  0120: 25 2E 5F 53 42 5F 50 43 49 30 5B 82 19 50 58 31  %._SB_PCI0[..PX1
  0130: 33 08 5F 41 44 52 0C 03 00 01 00 5B 80 50 31 33  3._ADR.....[.P13
  0140: 43 02 00 0A FF 10 40 05 2E 5F 53 42 5F 50 43 49  C.....@.._SB_PCI
  0150: 30 5B 82 43 04 49 53 41 5F 08 5F 41 44 52 0C 00  0[.C.ISA_._ADR..
  0160: 00 01 00 5B 80 50 34 30 43 02 0A 60 0A 04 5B 81  ...[.P40C..`..[.
  0170: 26 5E 2E 50 58 31 33 50 31 33 43 00 00 48 2F 00  &^.PX13P13C..H/.
  0180: 07 4C 50 45 4E 01 00 38 00 03 43 41 45 4E 01 00  .LPEN..8..CAEN..
  0190: 03 43 42 45 4E 01 10 43 1F 2F 03 5F 53 42 5F 50  .CBEN..C./._SB_P
  01A0: 43 49 30 49 53 41 5F 5B 82 2D 52 54 43 5F 08 5F  CI0ISA_[.-RTC_._
  01B0: 48 49 44 0C 41 D0 0B 00 08 5F 43 52 53 11 18 0A  HID.A...._CRS...
  01C0: 15 47 01 70 00 70 00 10 02 22 00 01 47 01 72 00  .G.p.p..."..G.r.
  01D0: 72 00 02 06 79 00 5B 82 37 4B 42 44 5F 08 5F 48  r...y.[.7KBD_._H
  01E0: 49 44 0C 41 D0 03 03 14 09 5F 53 54 41 00 A4 0A  ID.A....._STA...
  01F0: 0F 08 5F 43 52 53 11 18 0A 15 47 01 60 00 60 00  .._CRS....G.`.`.
  0200: 01 01 47 01 64 00 64 00 01 01 22 02 00 79 00 5B  ..G.d.d..."..y.[
  0210: 82 27 4D 4F 55 5F 08 5F 48 49 44 0C 41 D0 0F 13  .'MOU_._HID.A...
  0220: 14 09 5F 53 54 41 00 A4 0A 0F 08 5F 43 52 53 11  .._STA....._CRS.
  0230: 08 0A 05 22 00 10 79 00 5B 82 41 08 46 44 43 30  ..."..y.[.A.FDC0
  0240: 08 5F 48 49 44 0C 41 D0 07 00 08 5F 43 52 53 11  ._HID.A...._CRS.
  0250: 1B 0A 18 47 01 F2 03 F2 03 00 04 47 01 F7 03 F7  ...G.......G....
  0260: 03 00 01 22 40 00 2A 04 00 79 00 5B 82 31 46 4C  ..."@.*..y.[.1FL
  0270: 50 41 08 5F 41 44 52 00 08 5F 46 44 49 12 20 10  PA._ADR.._FDI. .
  0280: 00 0A 05 0A 4F 0A 30 01 0A AF 0A 02 0A 25 0A 02  ....O.0......%..
  0290: 0A 12 0A 1B 0A FF 0A 6C 0A F6 0A 0F 0A 08 08 5F  .......l......._
  02A0: 46 44 45 11 17 0A 14 01 00 00 00 00 00 00 00 00  FDE.............
  02B0: 00 00 00 00 00 00 00 02 00 00 00 5B 82 3E 4C 50  ...........[.>LP
  02C0: 54 5F 08 5F 48 49 44 0C 41 D0 04 00 14 18 5F 53  T_._HID.A....._S
  02D0: 54 41 00 70 4C 50 45 4E 60 A0 06 93 60 00 A4 00  TA.pLPEN`...`...
  02E0: A1 04 A4 0A 0F 08 5F 43 52 53 11 10 0A 0D 47 01  ......_CRS....G.
  02F0: 78 03 78 03 08 08 22 80 00 79 00 5B 82 45 04 43  x.x..."..y.[.E.C
  0300: 4F 4D 31 08 5F 48 49 44 0C 41 D0 05 01 08 5F 55  OM1._HID.A...._U
  0310: 49 44 01 14 18 5F 53 54 41 00 70 43 41 45 4E 60  ID..._STA.pCAEN`
  0320: A0 06 93 60 00 A4 00 A1 04 A4 0A 0F 08 5F 43 52  ...`........._CR
  0330: 53 11 10 0A 0D 47 01 F8 03 F8 03 00 08 22 10 00  S....G......."..
  0340: 79 00 5B 82 46 04 43 4F 4D 32 08 5F 48 49 44 0C  y.[.F.COM2._HID.
  0350: 41 D0 05 01 08 5F 55 49 44 0A 02 14 18 5F 53 54  A...._UID...._ST
  0360: 41 00 70 43 42 45 4E 60 A0 06 93 60 00 A4 00 A1  A.pCBEN`...`....
  0370: 04 A4 0A 0F 08 5F 43 52 53 11 10 0A 0D 47 01 F8  ....._CRS....G..
  0380: 02 F8 02 00 08 22 08 00 79 00 10 48 08 2E 5F 53  ....."..y..H.._S
  0390: 42 5F 50 43 49 30 5B 80 50 43 53 54 01 0B 00 AE  B_PCI0[.PCST....
  03A0: 0A 08 5B 81 10 50 43 53 54 43 50 43 49 55 20 50  ..[..PCSTCPCIU P
  03B0: 43 49 44 20 5B 80 53 45 4A 5F 01 0B 08 AE 0A 04  CID [.SEJ_......
  03C0: 5B 81 0B 53 45 4A 5F 43 42 30 45 4A 20 5B 80 42  [..SEJ_CB0EJ [.B
  03D0: 4E 4D 52 01 0B 10 AE 0A 04 5B 81 0B 42 4E 4D 52  NMR......[..BNMR
  03E0: 43 42 4E 55 4D 20 5B 01 42 4C 43 4B 00 14 25 50  CBNUM [.BLCK..%P
  03F0: 43 45 4A 02 5B 23 42 4C 43 4B FF FF 70 68 42 4E  CEJ.[#BLCK..phBN
  0400: 55 4D 70 79 01 69 00 42 30 45 4A 5B 27 42 4C 43  UMpy.i.B0EJ['BLC
  0410: 4B A4 00 10 4E 36 5F 53 42 5F 10 4B 0A 50 43 49  K...N6_SB_.K.PCI
  0420: 30 14 44 0A 5F 50 52 54 00 70 12 02 80 60 70 00  0.D._PRT.p...`p.
  0430: 61 A2 42 09 95 61 0A 80 70 7A 61 0A 02 00 62 70  a.B..a..pza...bp
  0440: 7B 72 61 62 00 0A 03 00 63 A0 10 93 63 00 70 12  {rab....c...c.p.
  0450: 09 04 00 00 4C 4E 4B 44 00 64 A0 24 93 63 01 A0  ....LNKD.d.$.c..
  0460: 11 93 61 0A 04 70 12 09 04 00 00 4C 4E 4B 53 00  ..a..p.....LNKS.
  0470: 64 A1 0D 70 12 09 04 00 00 4C 4E 4B 41 00 64 A0  d..p.....LNKA.d.
  0480: 11 93 63 0A 02 70 12 09 04 00 00 4C 4E 4B 42 00  ..c..p.....LNKB.
  0490: 64 A0 11 93 63 0A 03 70 12 09 04 00 00 4C 4E 4B  d...c..p.....LNK
  04A0: 43 00 64 70 7D 79 62 0A 10 00 0B FF FF 00 88 64  C.dp}yb........d
  04B0: 00 00 70 7B 61 0A 03 00 88 64 01 00 70 64 88 60  ..p{a....d..pd.`
  04C0: 61 00 75 61 A4 60 5B 81 24 2F 03 50 43 49 30 49  a.ua.`[.$/.PCI0I
  04D0: 53 41 5F 50 34 30 43 01 50 52 51 30 08 50 52 51  SA_P40C.PRQ0.PRQ
  04E0: 31 08 50 52 51 32 08 50 52 51 33 08 14 13 49 51  1.PRQ2.PRQ3...IQ
  04F0: 53 54 01 A0 09 7B 0A 80 68 00 A4 0A 09 A4 0A 0B  ST...{..h.......
  0500: 14 36 49 51 43 52 09 08 50 52 52 30 11 0E 0A 0B  .6IQCR..PRR0....
  0510: 89 06 00 09 01 00 00 00 00 79 00 8A 50 52 52 30  .........y..PRR0
  0520: 0A 05 50 52 52 49 A0 0B 95 68 0A 80 70 68 50 52  ..PRRI...h..phPR
  0530: 52 49 A4 50 52 52 30 5B 82 4C 07 4C 4E 4B 41 08  RI.PRR0[.L.LNKA.
  0540: 5F 48 49 44 0C 41 D0 0C 0F 08 5F 55 49 44 00 08  _HID.A...._UID..
  0550: 5F 50 52 53 11 16 0A 13 89 0E 00 09 03 05 00 00  _PRS............
  0560: 00 0A 00 00 00 0B 00 00 00 79 00 14 0F 5F 53 54  .........y..._ST
  0570: 41 00 A4 49 51 53 54 50 52 51 30 14 11 5F 44 49  A..IQSTPRQ0.._DI
  0580: 53 00 7D 50 52 51 30 0A 80 50 52 51 30 14 0F 5F  S.}PRQ0..PRQ0.._
  0590: 43 52 53 00 A4 49 51 43 52 50 52 51 30 14 17 5F  CRS..IQCRPRQ0.._
  05A0: 53 52 53 01 8A 68 0A 05 50 52 52 49 70 50 52 52  SRS..h..PRRIpPRR
  05B0: 49 50 52 51 30 5B 82 4C 07 4C 4E 4B 42 08 5F 48  IPRQ0[.L.LNKB._H
  05C0: 49 44 0C 41 D0 0C 0F 08 5F 55 49 44 01 08 5F 50  ID.A...._UID.._P
  05D0: 52 53 11 16 0A 13 89 0E 00 09 03 05 00 00 00 0A  RS..............
  05E0: 00 00 00 0B 00 00 00 79 00 14 0F 5F 53 54 41 00  .......y..._STA.
  05F0: A4 49 51 53 54 50 52 51 31 14 11 5F 44 49 53 00  .IQSTPRQ1.._DIS.
  0600: 7D 50 52 51 31 0A 80 50 52 51 31 14 0F 5F 43 52  }PRQ1..PRQ1.._CR
  0610: 53 00 A4 49 51 43 52 50 52 51 31 14 17 5F 53 52  S..IQCRPRQ1.._SR
  0620: 53 01 8A 68 0A 05 50 52 52 49 70 50 52 52 49 50  S..h..PRRIpPRRIP
  0630: 52 51 31 5B 82 4D 07 4C 4E 4B 43 08 5F 48 49 44  RQ1[.M.LNKC._HID
  0640: 0C 41 D0 0C 0F 08 5F 55 49 44 0A 02 08 5F 50 52  .A...._UID..._PR
  0650: 53 11 16 0A 13 89 0E 00 09 03 05 00 00 00 0A 00  S...............
  0660: 00 00 0B 00 00 00 79 00 14 0F 5F 53 54 41 00 A4  ......y..._STA..
  0670: 49 51 53 54 50 52 51 32 14 11 5F 44 49 53 00 7D  IQSTPRQ2.._DIS.}
  0680: 50 52 51 32 0A 80 50 52 51 32 14 0F 5F 43 52 53  PRQ2..PRQ2.._CRS
  0690: 00 A4 49 51 43 52 50 52 51 32 14 17 5F 53 52 53  ..IQCRPRQ2.._SRS
  06A0: 01 8A 68 0A 05 50 52 52 49 70 50 52 52 49 50 52  ..h..PRRIpPRRIPR
  06B0: 51 32 5B 82 4D 07 4C 4E 4B 44 08 5F 48 49 44 0C  Q2[.M.LNKD._HID.
  06C0: 41 D0 0C 0F 08 5F 55 49 44 0A 03 08 5F 50 52 53  A...._UID..._PRS
  06D0: 11 16 0A 13 89 0E 00 09 03 05 00 00 00 0A 00 00  ................
  06E0: 00 0B 00 00 00 79 00 14 0F 5F 53 54 41 00 A4 49  .....y..._STA..I
  06F0: 51 53 54 50 52 51 33 14 11 5F 44 49 53 00 7D 50  QSTPRQ3.._DIS.}P
  0700: 52 51 33 0A 80 50 52 51 33 14 0F 5F 43 52 53 00  RQ3..PRQ3.._CRS.
  0710: A4 49 51 43 52 50 52 51 33 14 17 5F 53 52 53 01  .IQCRPRQ3.._SRS.
  0720: 8A 68 0A 05 50 52 52 49 70 50 52 52 49 50 52 51  .h..PRRIpPRRIPRQ
  0730: 33 5B 82 4F 04 4C 4E 4B 53 08 5F 48 49 44 0C 41  3[.O.LNKS._HID.A
  0740: D0 0C 0F 08 5F 55 49 44 0A 04 08 5F 50 52 53 11  ...._UID..._PRS.
  0750: 0E 0A 0B 89 06 00 09 01 09 00 00 00 79 00 14 09  ............y...
  0760: 5F 53 54 41 00 A4 0A 0B 14 06 5F 44 49 53 00 14  _STA......_DIS..
  0770: 0B 5F 43 52 53 00 A4 5F 50 52 53 14 06 5F 53 52  ._CRS.._PRS.._SR
  0780: 53 01 10 49 37 5F 53 42 5F 5B 82 43 0A 5C 2F 03  S..I7_SB_[.C.\/.
  0790: 5F 53 42 5F 50 43 49 30 50 52 45 53 08 5F 48 49  _SB_PCI0PRES._HI
  07A0: 44 0C 41 D0 0A 06 08 5F 55 49 44 0D 43 50 55 20  D.A...._UID.CPU 
  07B0: 48 6F 74 70 6C 75 67 20 72 65 73 6F 75 72 63 65  Hotplug resource
  07C0: 73 00 5B 01 43 50 4C 4B 00 08 5F 43 52 53 11 0D  s.[.CPLK.._CRS..
  07D0: 0A 0A 47 01 00 AF 00 AF 01 0C 79 00 5B 80 50 52  ..G.......y.[.PR
  07E0: 53 54 01 0B 00 AF 0A 0C 5B 81 23 50 52 53 54 41  ST......[.#PRSTA
  07F0: 00 20 43 50 45 4E 01 43 49 4E 53 01 43 52 4D 56  . CPEN.CINS.CRMV
  0800: 01 43 45 4A 30 01 00 04 43 43 4D 44 08 5B 81 12  .CEJ0...CCMD.[..
  0810: 50 52 53 54 03 43 53 45 4C 20 00 20 43 44 41 54  PRST.CSEL . CDAT
  0820: 20 14 0C 5F 49 4E 49 08 70 00 43 53 45 4C 5B 82   .._INI.p.CSEL[.
  0830: 4C 2C 5C 2E 5F 53 42 5F 43 50 55 53 08 5F 48 49  L,\._SB_CPUS._HI
  0840: 44 0D 41 43 50 49 30 30 31 30 00 08 5F 43 49 44  D.ACPI0010.._CID
  0850: 0C 41 D0 0A 05 14 11 43 54 46 59 02 A0 0A 93 68  .A.....CTFY....h
  0860: 00 86 43 30 30 30 69 14 48 06 43 53 54 41 09 5B  ..C000i.H.CSTA.[
  0870: 23 5C 2F 04 5F 53 42 5F 50 43 49 30 50 52 45 53  #\/._SB_PCI0PRES
  0880: 43 50 4C 4B FF FF 70 68 5C 2F 04 5F 53 42 5F 50  CPLK..ph\/._SB_P
  0890: 43 49 30 50 52 45 53 43 53 45 4C 70 00 60 A0 1A  CI0PRESCSELp.`..
  08A0: 93 5C 2F 04 5F 53 42 5F 50 43 49 30 50 52 45 53  .\/._SB_PCI0PRES
  08B0: 43 50 45 4E 01 70 0A 0F 60 5B 27 5C 2F 04 5F 53  CPEN.p..`['\/._S
  08C0: 42 5F 50 43 49 30 50 52 45 53 43 50 4C 4B A4 60  B_PCI0PRESCPLK.`
  08D0: 14 4D 05 43 45 4A 30 09 5B 23 5C 2F 04 5F 53 42  .M.CEJ0.[#\/._SB
  08E0: 5F 50 43 49 30 50 52 45 53 43 50 4C 4B FF FF 70  _PCI0PRESCPLK..p
  08F0: 68 5C 2F 04 5F 53 42 5F 50 43 49 30 50 52 45 53  h\/._SB_PCI0PRES
  0900: 43 53 45 4C 70 01 5C 2F 04 5F 53 42 5F 50 43 49  CSELp.\/._SB_PCI
  0910: 30 50 52 45 53 43 45 4A 30 5B 27 5C 2F 04 5F 53  0PRESCEJ0['\/._S
  0920: 42 5F 50 43 49 30 50 52 45 53 43 50 4C 4B 14 48  B_PCI0PRESCPLK.H
  0930: 0E 43 53 43 4E 08 5B 23 5C 2F 04 5F 53 42 5F 50  .CSCN.[#\/._SB_P
  0940: 43 49 30 50 52 45 53 43 50 4C 4B FF FF 70 01 60  CI0PRESCPLK..p.`
  0950: A2 41 0B 93 60 01 70 00 60 70 00 5C 2F 04 5F 53  .A..`.p.`p.\/._S
  0960: 42 5F 50 43 49 30 50 52 45 53 43 43 4D 44 A0 47  B_PCI0PRESCCMD.G
  0970: 04 93 5C 2F 04 5F 53 42 5F 50 43 49 30 50 52 45  ..\/._SB_PCI0PRE
  0980: 53 43 49 4E 53 01 43 54 46 59 5C 2F 04 5F 53 42  SCINS.CTFY\/._SB
  0990: 5F 50 43 49 30 50 52 45 53 43 44 41 54 01 70 01  _PCI0PRESCDAT.p.
  09A0: 5C 2F 04 5F 53 42 5F 50 43 49 30 50 52 45 53 43  \/._SB_PCI0PRESC
  09B0: 49 4E 53 70 01 60 A1 4B 04 A0 48 04 93 5C 2F 04  INSp.`.K..H..\/.
  09C0: 5F 53 42 5F 50 43 49 30 50 52 45 53 43 52 4D 56  _SB_PCI0PRESCRMV
  09D0: 01 43 54 46 59 5C 2F 04 5F 53 42 5F 50 43 49 30  .CTFY\/._SB_PCI0
  09E0: 50 52 45 53 43 44 41 54 0A 03 70 01 5C 2F 04 5F  PRESCDAT..p.\/._
  09F0: 53 42 5F 50 43 49 30 50 52 45 53 43 52 4D 56 70  SB_PCI0PRESCRMVp
  0A00: 01 60 5B 27 5C 2F 04 5F 53 42 5F 50 43 49 30 50  .`['\/._SB_PCI0P
  0A10: 52 45 53 43 50 4C 4B 14 4D 09 43 4F 53 54 0C 5B  RESCPLK.M.COST.[
  0A20: 23 5C 2F 04 5F 53 42 5F 50 43 49 30 50 52 45 53  #\/._SB_PCI0PRES
  0A30: 43 50 4C 4B FF FF 70 68 5C 2F 04 5F 53 42 5F 50  CPLK..ph\/._SB_P
  0A40: 43 49 30 50 52 45 53 43 53 45 4C 70 01 5C 2F 04  CI0PRESCSELp.\/.
  0A50: 5F 53 42 5F 50 43 49 30 50 52 45 53 43 43 4D 44  _SB_PCI0PRESCCMD
  0A60: 70 69 5C 2F 04 5F 53 42 5F 50 43 49 30 50 52 45  pi\/._SB_PCI0PRE
  0A70: 53 43 44 41 54 70 0A 02 5C 2F 04 5F 53 42 5F 50  SCDATp..\/._SB_P
  0A80: 43 49 30 50 52 45 53 43 43 4D 44 70 6A 5C 2F 04  CI0PRESCCMDpj\/.
  0A90: 5F 53 42 5F 50 43 49 30 50 52 45 53 43 44 41 54  _SB_PCI0PRESCDAT
  0AA0: 5B 27 5C 2F 04 5F 53 42 5F 50 43 49 30 50 52 45  ['\/._SB_PCI0PRE
  0AB0: 53 43 50 4C 4B 5B 83 45 04 43 30 30 30 00 00 00  SCPLK[.E.C000...
  0AC0: 00 00 00 14 0C 5F 53 54 41 08 A4 43 53 54 41 00  ....._STA..CSTA.
  0AD0: 08 5F 4D 41 54 11 0B 0A 08 00 08 00 00 01 00 00  ._MAT...........
  0AE0: 00 14 0B 5F 45 4A 30 01 43 45 4A 30 00 14 0E 5F  ..._EJ0.CEJ0..._
  0AF0: 4F 53 54 0B 43 4F 53 54 00 68 69 6A 14 1B 5C 2E  OST.COST.hij..\.
  0B00: 5F 47 50 45 5F 45 30 32 00 5C 2F 03 5F 53 42 5F  _GPE_E02.\/._SB_
  0B10: 43 50 55 53 43 53 43 4E 10 4E 2D 2E 5F 53 42 5F  CPUSCSCN.N-._SB_
  0B20: 50 43 49 30 5B 82 41 2D 4D 48 50 44 08 5F 48 49  PCI0[.A-MHPD._HI
  0B30: 44 0D 50 4E 50 30 41 30 36 00 08 5F 55 49 44 0D  D.PNP0A06.._UID.
  0B40: 4D 65 6D 6F 72 79 20 68 6F 74 70 6C 75 67 20 72  Memory hotplug r
  0B50: 65 73 6F 75 72 63 65 73 00 14 13 5F 53 54 41 00  esources..._STA.
  0B60: A0 09 93 4D 44 4E 52 00 A4 00 A4 0A 0B 5B 01 4D  ...MDNR......[.M
  0B70: 4C 43 4B 00 14 41 06 4D 53 43 4E 00 A0 09 93 4D  LCK..A.MSCN....M
  0B80: 44 4E 52 00 A4 00 70 00 60 5B 23 4D 4C 43 4B FF  DNR...p.`[#MLCK.
  0B90: FF A2 3C 95 60 4D 44 4E 52 70 60 4D 53 45 4C A0  ..<.`MDNRp`MSEL.
  0BA0: 13 93 4D 49 4E 53 01 4D 54 46 59 60 01 70 01 4D  ..MINS.MTFY`.p.M
  0BB0: 49 4E 53 A1 16 A0 14 93 4D 52 4D 56 01 4D 54 46  INS.....MRMV.MTF
  0BC0: 59 60 0A 03 70 01 4D 52 4D 56 72 60 01 60 5B 27  Y`..p.MRMVr`.`['
  0BD0: 4D 4C 43 4B A4 01 14 2D 4D 52 53 54 01 70 00 60  MLCK...-MRST.p.`
  0BE0: 5B 23 4D 4C 43 4B FF FF 70 99 68 00 4D 53 45 4C  [#MLCK..p.h.MSEL
  0BF0: A0 0B 93 4D 45 53 5F 01 70 0A 0F 60 5B 27 4D 4C  ...MES_.p..`['ML
  0C00: 43 4B A4 60 14 41 18 4D 43 52 53 09 5B 23 4D 4C  CK.`.A.MCRS.[#ML
  0C10: 43 4B FF FF 70 99 68 00 4D 53 45 4C 08 4D 52 36  CK..p.h.MSEL.MR6
  0C20: 34 11 33 0A 30 8A 2B 00 00 0C 03 00 00 00 00 00  4.3.0.+.........
  0C30: 00 00 00 00 00 00 00 00 00 00 00 FE FF FF FF FF  ................
  0C40: FF FF FF 00 00 00 00 00 00 00 00 FF FF FF FF FF  ................
  0C50: FF FF FF 79 00 8A 4D 52 36 34 0A 0E 4D 49 4E 4C  ...y..MR64..MINL
  0C60: 8A 4D 52 36 34 0A 12 4D 49 4E 48 8A 4D 52 36 34  .MR64..MINH.MR64
  0C70: 0A 26 4C 45 4E 4C 8A 4D 52 36 34 0A 2A 4C 45 4E  .&LENL.MR64.*LEN
  0C80: 48 8A 4D 52 36 34 0A 16 4D 41 58 4C 8A 4D 52 36  H.MR64..MAXL.MR6
  0C90: 34 0A 1A 4D 41 58 48 70 4D 52 42 48 4D 49 4E 48  4..MAXHpMRBHMINH
  0CA0: 70 4D 52 42 4C 4D 49 4E 4C 70 4D 52 4C 48 4C 45  pMRBLMINLpMRLHLE
  0CB0: 4E 48 70 4D 52 4C 4C 4C 45 4E 4C 72 4D 49 4E 4C  NHpMRLLLENLrMINL
  0CC0: 4C 45 4E 4C 4D 41 58 4C 72 4D 49 4E 48 4C 45 4E  LENLMAXLrMINHLEN
  0CD0: 48 4D 41 58 48 A0 14 95 4D 41 58 4C 4D 49 4E 4C  HMAXH...MAXLMINL
  0CE0: 72 4D 41 58 48 01 4D 41 58 48 A0 11 95 4D 41 58  rMAXH.MAXH...MAX
  0CF0: 4C 01 74 4D 41 58 48 01 4D 41 58 48 74 4D 41 58  L.tMAXH.MAXHtMAX
  0D00: 4C 01 4D 41 58 4C A0 44 07 93 4D 41 58 48 00 08  L.MAXL.D..MAXH..
  0D10: 4D 52 33 32 11 1F 0A 1C 87 17 00 00 0C 03 00 00  MR32............
  0D20: 00 00 00 00 00 00 FE FF FF FF 00 00 00 00 FF FF  ................
  0D30: FF FF 79 00 8A 4D 52 33 32 0A 0A 4D 49 4E 5F 8A  ..y..MR32..MIN_.
  0D40: 4D 52 33 32 0A 0E 4D 41 58 5F 8A 4D 52 33 32 0A  MR32..MAX_.MR32.
  0D50: 16 4C 45 4E 5F 70 4D 49 4E 4C 4D 49 4E 5F 70 4D  .LEN_pMINLMIN_pM
  0D60: 41 58 4C 4D 41 58 5F 70 4C 45 4E 4C 4C 45 4E 5F  AXLMAX_pLENLLEN_
  0D70: 5B 27 4D 4C 43 4B A4 4D 52 33 32 5B 27 4D 4C 43  ['MLCK.MR32['MLC
  0D80: 4B A4 4D 52 36 34 14 24 4D 50 58 4D 01 5B 23 4D  K.MR64.$MPXM.[#M
  0D90: 4C 43 4B FF FF 70 99 68 00 4D 53 45 4C 70 4D 50  LCK..p.h.MSELpMP
  0DA0: 58 5F 60 5B 27 4D 4C 43 4B A4 60 14 28 4D 4F 53  X_`['MLCK.`.(MOS
  0DB0: 54 04 5B 23 4D 4C 43 4B FF FF 70 99 68 00 4D 53  T.[#MLCK..p.h.MS
  0DC0: 45 4C 70 69 4D 4F 45 56 70 6A 4D 4F 53 43 5B 27  ELpiMOEVpjMOSC['
  0DD0: 4D 4C 43 4B 14 22 4D 45 4A 30 02 5B 23 4D 4C 43  MLCK."MEJ0.[#MLC
  0DE0: 4B FF FF 70 99 68 00 4D 53 45 4C 70 01 4D 45 4A  K..p.h.MSELp.MEJ
  0DF0: 5F 5B 27 4D 4C 43 4B 10 49 06 5F 47 50 45 08 5F  _['MLCK.I._GPE._
  0E00: 48 49 44 0D 41 43 50 49 30 30 30 36 00 14 39 5F  HID.ACPI0006..9_
  0E10: 45 30 31 00 5B 23 5C 2F 03 5F 53 42 5F 50 43 49  E01.[#\/._SB_PCI
  0E20: 30 42 4C 43 4B FF FF 5C 2F 03 5F 53 42 5F 50 43  0BLCK..\/._SB_PC
  0E30: 49 30 50 43 4E 54 5B 27 5C 2F 03 5F 53 42 5F 50  I0PCNT['\/._SB_P
  0E40: 43 49 30 42 4C 43 4B 14 19 5F 45 30 33 00 5C 2F  CI0BLCK.._E03.\/
  0E50: 04 5F 53 42 5F 50 43 49 30 4D 48 50 44 4D 53 43  ._SB_PCI0MHPDMSC
  0E60: 4E 10 45 11 5C 2E 5F 53 42 5F 50 43 49 30 08 5F  N.E.\._SB_PCI0._
  0E70: 43 52 53 11 42 07 0A 6E 88 0D 00 02 0C 00 00 00  CRS.B..n........
  0E80: 00 00 FF 00 00 00 00 01 47 01 F8 0C F8 0C 01 08  ........G.......
  0E90: 88 0D 00 01 0C 03 00 00 00 00 F7 0C 00 00 F8 0C  ................
  0EA0: 88 0D 00 01 0C 03 00 00 00 0D FF FF 00 00 00 F3  ................
  0EB0: 87 17 00 00 0C 03 00 00 00 00 00 00 0A 00 FF FF  ................
  0EC0: 0B 00 00 00 00 00 00 00 02 00 87 17 00 00 0C 01  ................
  0ED0: 00 00 00 00 00 00 00 C0 FF FF BF FE 00 00 00 00  ................
  0EE0: 00 00 C0 3E 79 00 5B 82 43 04 47 50 45 30 08 5F  ...>y.[.C.GPE0._
  0EF0: 48 49 44 0D 50 4E 50 30 41 30 36 00 08 5F 55 49  HID.PNP0A06.._UI
  0F00: 44 0D 47 50 45 30 20 72 65 73 6F 75 72 63 65 73  D.GPE0 resources
  0F10: 00 08 5F 53 54 41 0A 0B 08 5F 43 52 53 11 0D 0A  .._STA..._CRS...
  0F20: 0A 47 01 E0 AF E0 AF 01 04 79 00 5B 82 4A 04 50  .G.......y.[.J.P
  0F30: 48 50 52 08 5F 48 49 44 0D 50 4E 50 30 41 30 36  HPR._HID.PNP0A06
  0F40: 00 08 5F 55 49 44 0D 50 43 49 20 48 6F 74 70 6C  .._UID.PCI Hotpl
  0F50: 75 67 20 72 65 73 6F 75 72 63 65 73 00 08 5F 53  ug resources.._S
  0F60: 54 41 0A 0B 08 5F 43 52 53 11 0D 0A 0A 47 01 00  TA..._CRS....G..
  0F70: AE 00 AE 01 14 79 00 10 29 5C 00 08 5F 53 33 5F  .....y..)\.._S3_
  0F80: 12 06 04 01 01 00 00 08 5F 53 34 5F 12 08 04 0A  ........_S4_....
  0F90: 02 0A 02 00 00 08 5F 53 35 5F 12 06 04 00 00 00  ......_S5_......
  0FA0: 00 10 3B 5C 2E 5F 53 42 5F 50 43 49 30 5B 82 2E  ..;\._SB_PCI0[..
  0FB0: 46 57 43 46 08 5F 48 49 44 0D 51 45 4D 55 30 30  FWCF._HID.QEMU00
  0FC0: 30 32 00 08 5F 53 54 41 0A 0B 08 5F 43 52 53 11  02.._STA..._CRS.
  0FD0: 0D 0A 0A 47 01 10 05 10 05 01 0C 79 00 10 4A 79  ...G.......y..Jy
  0FE0: 5C 5F 53 42 5F 10 4D 08 5C 2F 03 5F 53 42 5F 50  \_SB_.M.\/._SB_P
  0FF0: 43 49 30 4D 48 50 44 08 4D 44 4E 52 00 08 5F 43  CI0MHPD.MDNR.._C
  1000: 52 53 11 0D 0A 0A 47 01 00 0A 00 0A 00 18 79 00  RS....G.......y.
  1010: 5B 80 48 50 4D 52 01 0B 00 0A 0A 18 5B 81 1F 48  [.HPMR......[..H
  1020: 50 4D 52 03 4D 52 42 4C 20 4D 52 42 48 20 4D 52  PMR.MRBL MRBH MR
  1030: 4C 4C 20 4D 52 4C 48 20 4D 50 58 5F 20 5B 81 1D  LL MRLH MPX_ [..
  1040: 48 50 4D 52 41 00 40 0A 4D 45 53 5F 01 4D 49 4E  HPMRA.@.MES_.MIN
  1050: 53 01 4D 52 4D 56 01 4D 45 4A 5F 01 5B 81 15 48  S.MRMV.MEJ_.[..H
  1060: 50 4D 52 03 4D 53 45 4C 20 4D 4F 45 56 20 4D 4F  PMR.MSEL MOEV MO
  1070: 53 43 20 14 06 4D 54 46 59 02 10 4D 6F 50 43 49  SC ..MTFY..MoPCI
  1080: 30 08 42 53 45 4C 00 5B 82 0B 53 30 30 5F 08 5F  0.BSEL.[..S00_._
  1090: 41 44 52 00 5B 82 2A 53 31 30 5F 08 5F 41 44 52  ADR.[.*S10_._ADR
  10A0: 0C 00 00 02 00 14 08 5F 53 31 44 00 A4 00 14 08  ......._S1D.....
  10B0: 5F 53 32 44 00 A4 00 14 08 5F 53 33 44 00 A4 00  _S2D....._S3D...
  10C0: 5B 82 29 53 31 38 5F 08 5F 41 44 52 0C 00 00 03  [.)S18_._ADR....
  10D0: 00 08 5F 53 55 4E 0A 03 14 12 5F 45 4A 30 01 50  .._SUN...._EJ0.P
  10E0: 43 45 4A 42 53 45 4C 5F 53 55 4E 5B 82 29 53 32  CEJBSEL_SUN[.)S2
  10F0: 30 5F 08 5F 53 55 4E 0A 04 08 5F 41 44 52 0C 00  0_._SUN..._ADR..
  1100: 00 04 00 14 12 5F 45 4A 30 01 50 43 45 4A 42 53  ....._EJ0.PCEJBS
  1110: 45 4C 5F 53 55 4E 5B 82 29 53 32 38 5F 08 5F 53  EL_SUN[.)S28_._S
  1120: 55 4E 0A 05 08 5F 41 44 52 0C 00 00 05 00 14 12  UN..._ADR.......
  1130: 5F 45 4A 30 01 50 43 45 4A 42 53 45 4C 5F 53 55  _EJ0.PCEJBSEL_SU
  1140: 4E 5B 82 29 53 33 30 5F 08 5F 53 55 4E 0A 06 08  N[.)S30_._SUN...
  1150: 5F 41 44 52 0C 00 00 06 00 14 12 5F 45 4A 30 01  _ADR......._EJ0.
  1160: 50 43 45 4A 42 53 45 4C 5F 53 55 4E 5B 82 29 53  PCEJBSEL_SUN[.)S
  1170: 33 38 5F 08 5F 53 55 4E 0A 07 08 5F 41 44 52 0C  38_._SUN..._ADR.
  1180: 00 00 07 00 14 12 5F 45 4A 30 01 50 43 45 4A 42  ......_EJ0.PCEJB
  1190: 53 45 4C 5F 53 55 4E 5B 82 29 53 34 30 5F 08 5F  SEL_SUN[.)S40_._
  11A0: 53 55 4E 0A 08 08 5F 41 44 52 0C 00 00 08 00 14  SUN..._ADR......
  11B0: 12 5F 45 4A 30 01 50 43 45 4A 42 53 45 4C 5F 53  ._EJ0.PCEJBSEL_S
  11C0: 55 4E 5B 82 29 53 34 38 5F 08 5F 53 55 4E 0A 09  UN[.)S48_._SUN..
  11D0: 08 5F 41 44 52 0C 00 00 09 00 14 12 5F 45 4A 30  ._ADR......._EJ0
  11E0: 01 50 43 45 4A 42 53 45 4C 5F 53 55 4E 5B 82 29  .PCEJBSEL_SUN[.)
  11F0: 53 35 30 5F 08 5F 53 55 4E 0A 0A 08 5F 41 44 52  S50_._SUN..._ADR
  1200: 0C 00 00 0A 00 14 12 5F 45 4A 30 01 50 43 45 4A  ......._EJ0.PCEJ
  1210: 42 53 45 4C 5F 53 55 4E 5B 82 29 53 35 38 5F 08  BSEL_SUN[.)S58_.
  1220: 5F 53 55 4E 0A 0B 08 5F 41 44 52 0C 00 00 0B 00  _SUN..._ADR.....
  1230: 14 12 5F 45 4A 30 01 50 43 45 4A 42 53 45 4C 5F  .._EJ0.PCEJBSEL_
  1240: 53 55 4E 5B 82 29 53 36 30 5F 08 5F 53 55 4E 0A  SUN[.)S60_._SUN.
  1250: 0C 08 5F 41 44 52 0C 00 00 0C 00 14 12 5F 45 4A  .._ADR......._EJ
  1260: 30 01 50 43 45 4A 42 53 45 4C 5F 53 55 4E 5B 82  0.PCEJBSEL_SUN[.
  1270: 29 53 36 38 5F 08 5F 53 55 4E 0A 0D 08 5F 41 44  )S68_._SUN..._AD
  1280: 52 0C 00 00 0D 00 14 12 5F 45 4A 30 01 50 43 45  R......._EJ0.PCE
  1290: 4A 42 53 45 4C 5F 53 55 4E 5B 82 29 53 37 30 5F  JBSEL_SUN[.)S70_
  12A0: 08 5F 53 55 4E 0A 0E 08 5F 41 44 52 0C 00 00 0E  ._SUN..._ADR....
  12B0: 00 14 12 5F 45 4A 30 01 50 43 45 4A 42 53 45 4C  ..._EJ0.PCEJBSEL
  12C0: 5F 53 55 4E 5B 82 29 53 37 38 5F 08 5F 53 55 4E  _SUN[.)S78_._SUN
  12D0: 0A 0F 08 5F 41 44 52 0C 00 00 0F 00 14 12 5F 45  ..._ADR......._E
  12E0: 4A 30 01 50 43 45 4A 42 53 45 4C 5F 53 55 4E 5B  J0.PCEJBSEL_SUN[
  12F0: 82 29 53 38 30 5F 08 5F 53 55 4E 0A 10 08 5F 41  .)S80_._SUN..._A
  1300: 44 52 0C 00 00 10 00 14 12 5F 45 4A 30 01 50 43  DR......._EJ0.PC
  1310: 45 4A 42 53 45 4C 5F 53 55 4E 5B 82 29 53 38 38  EJBSEL_SUN[.)S88
  1320: 5F 08 5F 53 55 4E 0A 11 08 5F 41 44 52 0C 00 00  _._SUN..._ADR...
  1330: 11 00 14 12 5F 45 4A 30 01 50 43 45 4A 42 53 45  ...._EJ0.PCEJBSE
  1340: 4C 5F 53 55 4E 5B 82 29 53 39 30 5F 08 5F 53 55  L_SUN[.)S90_._SU
  1350: 4E 0A 12 08 5F 41 44 52 0C 00 00 12 00 14 12 5F  N..._ADR......._
  1360: 45 4A 30 01 50 43 45 4A 42 53 45 4C 5F 53 55 4E  EJ0.PCEJBSEL_SUN
  1370: 5B 82 29 53 39 38 5F 08 5F 53 55 4E 0A 13 08 5F  [.)S98_._SUN..._
  1380: 41 44 52 0C 00 00 13 00 14 12 5F 45 4A 30 01 50  ADR......._EJ0.P
  1390: 43 45 4A 42 53 45 4C 5F 53 55 4E 5B 82 29 53 41  CEJBSEL_SUN[.)SA
  13A0: 30 5F 08 5F 53 55 4E 0A 14 08 5F 41 44 52 0C 00  0_._SUN..._ADR..
  13B0: 00 14 00 14 12 5F 45 4A 30 01 50 43 45 4A 42 53  ....._EJ0.PCEJBS
  13C0: 45 4C 5F 53 55 4E 5B 82 29 53 41 38 5F 08 5F 53  EL_SUN[.)SA8_._S
  13D0: 55 4E 0A 15 08 5F 41 44 52 0C 00 00 15 00 14 12  UN..._ADR.......
  13E0: 5F 45 4A 30 01 50 43 45 4A 42 53 45 4C 5F 53 55  _EJ0.PCEJBSEL_SU
  13F0: 4E 5B 82 29 53 42 30 5F 08 5F 53 55 4E 0A 16 08  N[.)SB0_._SUN...
  1400: 5F 41 44 52 0C 00 00 16 00 14 12 5F 45 4A 30 01  _ADR......._EJ0.
  1410: 50 43 45 4A 42 53 45 4C 5F 53 55 4E 5B 82 29 53  PCEJBSEL_SUN[.)S
  1420: 42 38 5F 08 5F 53 55 4E 0A 17 08 5F 41 44 52 0C  B8_._SUN..._ADR.
  1430: 00 00 17 00 14 12 5F 45 4A 30 01 50 43 45 4A 42  ......_EJ0.PCEJB
  1440: 53 45 4C 5F 53 55 4E 5B 82 29 53 43 30 5F 08 5F  SEL_SUN[.)SC0_._
  1450: 53 55 4E 0A 18 08 5F 41 44 52 0C 00 00 18 00 14  SUN..._ADR......
  1460: 12 5F 45 4A 30 01 50 43 45 4A 42 53 45 4C 5F 53  ._EJ0.PCEJBSEL_S
  1470: 55 4E 5B 82 29 53 43 38 5F 08 5F 53 55 4E 0A 19  UN[.)SC8_._SUN..
  1480: 08 5F 41 44 52 0C 00 00 19 00 14 12 5F 45 4A 30  ._ADR......._EJ0
  1490: 01 50 43 45 4A 42 53 45 4C 5F 53 55 4E 5B 82 29  .PCEJBSEL_SUN[.)
  14A0: 53 44 30 5F 08 5F 53 55 4E 0A 1A 08 5F 41 44 52  SD0_._SUN..._ADR
  14B0: 0C 00 00 1A 00 14 12 5F 45 4A 30 01 50 43 45 4A  ......._EJ0.PCEJ
  14C0: 42 53 45 4C 5F 53 55 4E 5B 82 29 53 44 38 5F 08  BSEL_SUN[.)SD8_.
  14D0: 5F 53 55 4E 0A 1B 08 5F 41 44 52 0C 00 00 1B 00  _SUN..._ADR.....
  14E0: 14 12 5F 45 4A 30 01 50 43 45 4A 42 53 45 4C 5F  .._EJ0.PCEJBSEL_
  14F0: 53 55 4E 5B 82 29 53 45 30 5F 08 5F 53 55 4E 0A  SUN[.)SE0_._SUN.
  1500: 1C 08 5F 41 44 52 0C 00 00 1C 00 14 12 5F 45 4A  .._ADR......._EJ
  1510: 30 01 50 43 45 4A 42 53 45 4C 5F 53 55 4E 5B 82  0.PCEJBSEL_SUN[.
  1520: 29 53 45 38 5F 08 5F 53 55 4E 0A 1D 08 5F 41 44  )SE8_._SUN..._AD
  1530: 52 0C 00 00 1D 00 14 12 5F 45 4A 30 01 50 43 45  R......._EJ0.PCE
  1540: 4A 42 53 45 4C 5F 53 55 4E 5B 82 29 53 46 30 5F  JBSEL_SUN[.)SF0_
  1550: 08 5F 53 55 4E 0A 1E 08 5F 41 44 52 0C 00 00 1E  ._SUN..._ADR....
  1560: 00 14 12 5F 45 4A 30 01 50 43 45 4A 42 53 45 4C  ..._EJ0.PCEJBSEL
  1570: 5F 53 55 4E 5B 82 29 53 46 38 5F 08 5F 53 55 4E  _SUN[.)SF8_._SUN
  1580: 0A 1F 08 5F 41 44 52 0C 00 00 1F 00 14 12 5F 45  ..._ADR......._E
  1590: 4A 30 01 50 43 45 4A 42 53 45 4C 5F 53 55 4E 14  J0.PCEJBSEL_SUN.
  15A0: 48 1B 44 56 4E 54 02 A0 0C 7B 68 0A 08 00 86 53  H.DVNT...{h....S
  15B0: 31 38 5F 69 A0 0C 7B 68 0A 10 00 86 53 32 30 5F  18_i..{h....S20_
  15C0: 69 A0 0C 7B 68 0A 20 00 86 53 32 38 5F 69 A0 0C  i..{h. ..S28_i..
  15D0: 7B 68 0A 40 00 86 53 33 30 5F 69 A0 0C 7B 68 0A  {h.@..S30_i..{h.
  15E0: 80 00 86 53 33 38 5F 69 A0 0D 7B 68 0B 00 01 00  ...S38_i..{h....
  15F0: 86 53 34 30 5F 69 A0 0D 7B 68 0B 00 02 00 86 53  .S40_i..{h.....S
  1600: 34 38 5F 69 A0 0D 7B 68 0B 00 04 00 86 53 35 30  48_i..{h.....S50
  1610: 5F 69 A0 0D 7B 68 0B 00 08 00 86 53 35 38 5F 69  _i..{h.....S58_i
  1620: A0 0D 7B 68 0B 00 10 00 86 53 36 30 5F 69 A0 0D  ..{h.....S60_i..
  1630: 7B 68 0B 00 20 00 86 53 36 38 5F 69 A0 0D 7B 68  {h.. ..S68_i..{h
  1640: 0B 00 40 00 86 53 37 30 5F 69 A0 0D 7B 68 0B 00  ..@..S70_i..{h..
  1650: 80 00 86 53 37 38 5F 69 A0 0F 7B 68 0C 00 00 01  ...S78_i..{h....
  1660: 00 00 86 53 38 30 5F 69 A0 0F 7B 68 0C 00 00 02  ...S80_i..{h....
  1670: 00 00 86 53 38 38 5F 69 A0 0F 7B 68 0C 00 00 04  ...S88_i..{h....
  1680: 00 00 86 53 39 30 5F 69 A0 0F 7B 68 0C 00 00 08  ...S90_i..{h....
  1690: 00 00 86 53 39 38 5F 69 A0 0F 7B 68 0C 00 00 10  ...S98_i..{h....
  16A0: 00 00 86 53 41 30 5F 69 A0 0F 7B 68 0C 00 00 20  ...SA0_i..{h... 
  16B0: 00 00 86 53 41 38 5F 69 A0 0F 7B 68 0C 00 00 40  ...SA8_i..{h...@
  16C0: 00 00 86 53 42 30 5F 69 A0 0F 7B 68 0C 00 00 80  ...SB0_i..{h....
  16D0: 00 00 86 53 42 38 5F 69 A0 0F 7B 68 0C 00 00 00  ...SB8_i..{h....
  16E0: 01 00 86 53 43 30 5F 69 A0 0F 7B 68 0C 00 00 00  ...SC0_i..{h....
  16F0: 02 00 86 53 43 38 5F 69 A0 0F 7B 68 0C 00 00 00  ...SC8_i..{h....
  1700: 04 00 86 53 44 30 5F 69 A0 0F 7B 68 0C 00 00 00  ...SD0_i..{h....
  1710: 08 00 86 53 44 38 5F 69 A0 0F 7B 68 0C 00 00 00  ...SD8_i..{h....
  1720: 10 00 86 53 45 30 5F 69 A0 0F 7B 68 0C 00 00 00  ...SE0_i..{h....
  1730: 20 00 86 53 45 38 5F 69 A0 0F 7B 68 0C 00 00 00   ..SE8_i..{h....
  1740: 40 00 86 53 46 30 5F 69 A0 0F 7B 68 0C 00 00 00  @..SF0_i..{h....
  1750: 80 00 86 53 46 38 5F 69 14 1F 50 43 4E 54 00 70  ...SF8_i..PCNT.p
  1760: 00 42 4E 55 4D 44 56 4E 54 50 43 49 55 01 44 56  .BNUMDVNTPCIU.DV
  1770: 4E 54 50 43 49 44 0A 03                          NTPCID..

FACP @ 0x0000000000000000
  0000: 46 41 43 50 74 00 00 00 01 E7 42 4F 43 48 53 20  FACPt.....BOCHS 
  0010: 42 58 50 43 46 41 43 50 01 00 00 00 42 58 50 43  BXPCFACP....BXPC
  0020: 01 00 00 00 00 00 FE BF 40 00 FE BF 01 00 09 00  ........@.......
  0030: B2 00 00 00 F1 F0 00 00 00 06 00 00 00 00 00 00  ................
  0040: 04 06 00 00 00 00 00 00 00 00 00 00 08 06 00 00  ................
  0050: E0 AF 00 00 00 00 00 00 04 02 00 04 04 00 00 00  ................
  0060: FF 0F FF 0F 00 00 00 00 00 00 00 00 32 00 00 00  ............2...
  0070: A5 80 00 00                                      ....

HPET @ 0x0000000000000000
  0000: 48 50 45 54 38 00 00 00 01 03 42 4F 43 48 53 20  HPET8.....BOCHS 
  0010: 42 58 50 43 48 50 45 54 01 00 00 00 42 58 50 43  BXPCHPET....BXPC
  0020: 01 00 00 00 01 A2 86 80 00 00 00 00 00 00 D0 FE  ................
  0030: 00 00 00 00 00 00 00 00                          ........

FACS @ 0x0000000000000000
  0000: 46 41 43 53 40 00 00 00 00 00 00 00 00 00 00 00  FACS@...........
  0010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................


--------------73DCA54FF54A10EFA34593D6--
