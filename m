Return-Path: <linux-acpi+bounces-11876-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C58CA540F3
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 04:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62FD01891374
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 03:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058BC18DB20;
	Thu,  6 Mar 2025 03:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OV4Zh42Z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB4C1519A8;
	Thu,  6 Mar 2025 03:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741230177; cv=none; b=AyAajVsSB1rK9iAjV1P34WOX2x2KJaTpPCUnhoHk/46XX1OWa4572R6rwpTd+/X84xryskg9KaQIaVZxT+9j9lroymqJvubeIvAgvkS/9IGYrM6vFTMj2OIOYlPacvOizJS9bB5haSc5sJWYeUdXc5ynxRUV+53FX9NwfDvGjkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741230177; c=relaxed/simple;
	bh=gR+D/nNv6tD0i04PJOdCHa9N4xJvGW8XjsG/Ek2CWKM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kcafBWDuOblpL9JHHYuGaEZ6McqZUctAxL4QznqnxvQr8rJ+goSovx503heHwbsP8l1Zwni1/aZ26y3XvgWRe2nD3CIgzkRXB68ASBKdu4eFjhgOWZ2cG04DW+HWPEJniGvy7sXXit55XC5L7AjxVs7Z2ibNGZLRrd5g9waRbNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OV4Zh42Z; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6dd049b5428so2083016d6.2;
        Wed, 05 Mar 2025 19:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741230175; x=1741834975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gR+D/nNv6tD0i04PJOdCHa9N4xJvGW8XjsG/Ek2CWKM=;
        b=OV4Zh42ZK54pVXqtFz5AMvkD4xjWJ3LefQciGSd/ihmawZQeeBn4CFojcQ7/GtRPYc
         qlvE7voJ268YuUdmzHgpd77IVVfgmDp7a4AZdg148VoOJSwNcx4rku5gtWkkW+h3q9sb
         3sxHku0RGgfL8hfu11/4CQ3jqopvDchu5+OHHrrdq4+/PpjQquv32at6N5ZCszdH9t8S
         92HtHMTmskptx4I3r7IoK06tN27JeQg3CDTHAdhxZgH9ox+4dJszR/fx3wel4k+Bx63z
         754QSrP9aTtmMmhCR2Vox4iWp9xic7uRqVY/gsY90IgHo0t0scEgK4D9kn400+VXwIRS
         QzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741230175; x=1741834975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gR+D/nNv6tD0i04PJOdCHa9N4xJvGW8XjsG/Ek2CWKM=;
        b=E+LiCAT2SuKKbiV6YaCalrVk8X+E3rfwJJweAQS29m/EFWO2CvyOdAhPPE6wPwwjTP
         7OpYGUF6Rvp0J2JTFr+zD724GSts2bbOFmhGAcB4/9YMYcqH8fuFqmB5pRmXXxAz7BaC
         /tZD7Bajm6rKm1vuQ0uyIMtaOz7OxBdvLTSF69ufxEu0Zu9rQhL7k2EAweMa183b0DOI
         Qlc3jGltXVKCGtZ8O6h7b0xqIK7M6rqFyvm1Jxu407A3CAtY68V85ZnDKfQhaBG7rte/
         2qL8Dhw1/sVmifgNOPbzwtwPOeDvRnM6xkF+OQ6GKYNFHGE2t8+zZyezGGS+wNM4PJas
         Qp4w==
X-Forwarded-Encrypted: i=1; AJvYcCUCqZpnESp3M41XYIvBShz0UlBsKa7pA7krr5PlF80JU9G3L2/MFB9ZZC9P3K7L2Vo9MbEln1iqWn5seEy0@vger.kernel.org, AJvYcCWkU7oXM5MDnAwLpGTgCOtl2Cu2LW0LVHCpFI1N1mt94Pg7xAVg91n4Yrih2hTX1t/CKetpsKAdUKug@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4lcsHjUQdJibtezx9BuJNOW5Y+R9Ana1ytOcHszrssn70+IYw
	9O0CUzoDYIj0ERsjXrWCR1IrHQV+d8UcG489uhDyaOOLYF3BVM3GWk2uvrczEJEkidW07c0L7m8
	KaY8JUKFIohAfCTKn4+geuFWKvtA=
X-Gm-Gg: ASbGncvAS0Q1nNYQ5CwAYGUEeAF0PUXgDap8/2KRUqEvvqTfeLRUOFXDB1XT0qHAJeV
	ghkMct5s+UHzobuUHr3OXxZIPzgArW9mCoBgzLCOLzmodgBewbRGqNV0oAkCQi62LE8rYCGgLep
	IsIwQvK+/2NfrnkKN4T7ILhoO+Td8=
X-Google-Smtp-Source: AGHT+IE+DMh5JnIy8OhF6gThQ29MjaOP9qGnjxeH0Yj9frhBeBdXlGi1dN3DsPr5UssZdyTrcs0lzTVRVYUpdwtq4so=
X-Received: by 2002:a05:6214:1089:b0:6e8:efd0:2dad with SMTP id
 6a1803df08f44-6e8efd0309dmr32098496d6.12.1741230174979; Wed, 05 Mar 2025
 19:02:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luka <luka.2016.cs@gmail.com>
Date: Thu, 6 Mar 2025 11:02:43 +0800
X-Gm-Features: AQ5f1JqAAhkZ8OPJc6k-o-yGioRG0IiD2rxQn-voX51pCMGbrK5T9Bd-Fj78exk
Message-ID: <CALm_T+1CroJ5OcWxJ=S3J6wS8xdM6xDgRT0LCDDOuTZWWSNrpA@mail.gmail.com>
Subject: Potential Linux Crash: KASAN: slab-use-after-free Read in
 acpi_ut_valid_internal_object in Linux kernel v6.13-rc5
To: Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linux Kernel Experts,

Hello!

I am a security researcher focused on testing Linux kernel
vulnerabilities. Recently, while testing the v6.13-rc5 Linux kernel,
we encountered a crash related to the drivers/acpi/acpica kernel
module. We have successfully captured the call trace information for
this crash.

Unfortunately, we have not been able to reproduce the issue in our
local environment, so we are unable to provide a PoC (Proof of
Concept) at this time.

We fully understand the complexity and importance of Linux kernel
maintenance, and we would like to share this finding with you for
further analysis and confirmation of the root cause. Below is a
summary of the relevant information:

Kernel Version: v6.13.0-rc5

Kernel Module: drivers/acpi/acpica/utobject.c

=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94CallTr=
ace=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94

BUG: KASAN: slab-use-after-free in
acpi_ut_valid_internal_object+0x5e/0x60
drivers/acpi/acpica/utobject.c:319
Read of size 1 at addr ffff888108821620 by task sh/6442

CPU: 0 UID: 0 PID: 6442 Comm: sh Not tainted 6.13.0-rc5-00012-g0bc21e701a6f=
 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x7b/0xa0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xce/0x660 mm/kasan/report.c:489
 kasan_report+0xc6/0x100 mm/kasan/report.c:602
 acpi_ut_valid_internal_object+0x5e/0x60 drivers/acpi/acpica/utobject.c:319
 acpi_ut_add_reference+0x15/0x30 drivers/acpi/acpica/utdelete.c:684
 acpi_ds_method_data_get_value+0xc2/0x2e0 drivers/acpi/acpica/dsmthdat.c:41=
7
 acpi_ex_resolve_object_to_value drivers/acpi/acpica/exresolv.c:129 [inline=
]
 acpi_ex_resolve_to_value+0x3ba/0x730 drivers/acpi/acpica/exresolv.c:59
 acpi_ex_resolve_operands+0x740/0xde0 drivers/acpi/acpica/exresop.c:321
 acpi_ds_exec_end_op+0x8fc/0x1350 drivers/acpi/acpica/dswexec.c:400
 acpi_ps_parse_loop+0x3e4/0x1b00 drivers/acpi/acpica/psloop.c:525
 acpi_ps_parse_aml+0x372/0xbe0 drivers/acpi/acpica/psparse.c:475
 acpi_ps_execute_method+0x52e/0xb20 drivers/acpi/acpica/psxface.c:190
 acpi_ns_evaluate+0x717/0xc30 drivers/acpi/acpica/nseval.c:205
 acpi_ut_evaluate_object+0xcf/0x420 drivers/acpi/acpica/uteval.c:60
 acpi_rs_get_prt_method_data+0x84/0xf0 drivers/acpi/acpica/rsutils.c:446
 acpi_get_irq_routing_table+0x9b/0xd0 drivers/acpi/acpica/rsxface.c:137
 acpi_pci_irq_find_prt_entry+0x171/0xc00 drivers/acpi/pci_irq.c:214
 acpi_pci_irq_lookup+0x8a/0x5a0 drivers/acpi/pci_irq.c:298
 acpi_pci_irq_enable+0x1aa/0x570 drivers/acpi/pci_irq.c:413
 pcibios_enable_device+0x97/0xc0 arch/x86/pci/common.c:699
 do_pci_enable_device+0x11f/0x260 drivers/pci/pci.c:2077
 pci_enable_device_flags+0x1cf/0x250 drivers/pci/pci.c:2162
 enable_store+0x1b2/0x220 drivers/pci/pci-sysfs.c:314
 dev_attr_store+0x58/0x80 drivers/base/core.c:2439
 sysfs_kf_write+0x136/0x1a0 fs/sysfs/file.c:139
 kernfs_fop_write_iter+0x323/0x530 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x51e/0xc80 fs/read_write.c:679
 ksys_write+0x110/0x200 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xa6/0x1a0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9fe9b04513
Code: Unable to access opcode bytes at 0x7f9fe9b044e9.
RSP: 002b:00007ffd9a260f18 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00005560279bf6b0 RCX: 00007f9fe9b04513
RDX: 0000000000000005 RSI: 00005560279bf6b0 RDI: 0000000000000001
RBP: 0000000000000005 R08: 00005560279bf6b0 R09: 00007f9fe9be7be0
R10: 0000000000000070 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000005 R14: 7fffffffffffffff R15: 0000000000000000
 </TASK>

Allocated by task 6442:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x6e/0x70 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4119 [inline]
 slab_alloc_node mm/slub.c:4168 [inline]
 kmem_cache_alloc_noprof+0xf5/0x360 mm/slub.c:4175
 acpi_ut_allocate_object_desc_dbg drivers/acpi/acpica/utobject.c:359 [inlin=
e]
 acpi_ut_create_internal_object_dbg+0x6d/0x3c0 drivers/acpi/acpica/utobject=
.c:69
 acpi_ut_copy_iobject_to_iobject+0x65/0x390 drivers/acpi/acpica/utcopy.c:94=
7
 acpi_ds_store_object_to_local+0x260/0x440 drivers/acpi/acpica/dsmthdat.c:5=
42
 acpi_ex_store+0x1ee/0x970 drivers/acpi/acpica/exstore.c:147
 acpi_ex_opcode_1A_1T_1R+0x51d/0x10b0 drivers/acpi/acpica/exoparg1.c:443
 acpi_ds_exec_end_op+0x618/0x1350 drivers/acpi/acpica/dswexec.c:415
 acpi_ps_parse_loop+0x3e4/0x1b00 drivers/acpi/acpica/psloop.c:525
 acpi_ps_parse_aml+0x372/0xbe0 drivers/acpi/acpica/psparse.c:475
 acpi_ps_execute_method+0x52e/0xb20 drivers/acpi/acpica/psxface.c:190
 acpi_ns_evaluate+0x717/0xc30 drivers/acpi/acpica/nseval.c:205
 acpi_ut_evaluate_object+0xcf/0x420 drivers/acpi/acpica/uteval.c:60
 acpi_rs_get_prt_method_data+0x84/0xf0 drivers/acpi/acpica/rsutils.c:446
 acpi_get_irq_routing_table+0x9b/0xd0 drivers/acpi/acpica/rsxface.c:137
 acpi_pci_irq_find_prt_entry+0x171/0xc00 drivers/acpi/pci_irq.c:214
 acpi_pci_irq_lookup+0x8a/0x5a0 drivers/acpi/pci_irq.c:298
 acpi_pci_irq_enable+0x1aa/0x570 drivers/acpi/pci_irq.c:413
 pcibios_enable_device+0x97/0xc0 arch/x86/pci/common.c:699
 do_pci_enable_device+0x11f/0x260 drivers/pci/pci.c:2077
 pci_enable_device_flags+0x1cf/0x250 drivers/pci/pci.c:2162
 enable_store+0x1b2/0x220 drivers/pci/pci-sysfs.c:314
 dev_attr_store+0x58/0x80 drivers/base/core.c:2439
 sysfs_kf_write+0x136/0x1a0 fs/sysfs/file.c:139
 kernfs_fop_write_iter+0x323/0x530 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x51e/0xc80 fs/read_write.c:679
 ksys_write+0x110/0x200 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xa6/0x1a0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6442:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x37/0x50 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4613 [inline]
 kmem_cache_free+0xec/0x380 mm/slub.c:4715
 acpi_os_release_object+0x1c/0x30 drivers/acpi/osl.c:1624
 acpi_ut_delete_object_desc+0x92/0xb0 drivers/acpi/acpica/utobject.c:402
 acpi_ut_delete_internal_obj drivers/acpi/acpica/utdelete.c:316 [inline]
 acpi_ut_update_ref_count.part.0+0x3a4/0xc80 drivers/acpi/acpica/utdelete.c=
:436
 acpi_ut_update_ref_count drivers/acpi/acpica/utdelete.c:374 [inline]
 acpi_ut_update_object_reference+0x58f/0x6a0 drivers/acpi/acpica/utdelete.c=
:632
 acpi_ut_remove_reference drivers/acpi/acpica/utdelete.c:740 [inline]
 acpi_ut_remove_reference+0x65/0x80 drivers/acpi/acpica/utdelete.c:710
 acpi_ds_clear_implicit_return drivers/acpi/acpica/dsutils.c:55 [inline]
 acpi_ds_clear_implicit_return drivers/acpi/acpica/dsutils.c:34 [inline]
 acpi_ds_do_implicit_return drivers/acpi/acpica/dsutils.c:106 [inline]
 acpi_ds_do_implicit_return+0xaa/0x140 drivers/acpi/acpica/dsutils.c:79
 acpi_ds_is_result_used+0x5b/0x3b0 drivers/acpi/acpica/dsutils.c:156
 acpi_ds_delete_result_if_not_used+0x8f/0x120 drivers/acpi/acpica/dsutils.c=
:320
 acpi_ds_exec_end_op+0x2ca/0x1350 drivers/acpi/acpica/dswexec.c:740
 acpi_ps_parse_loop+0x3e4/0x1b00 drivers/acpi/acpica/psloop.c:525
 acpi_ps_parse_aml+0x372/0xbe0 drivers/acpi/acpica/psparse.c:475
 acpi_ps_execute_method+0x52e/0xb20 drivers/acpi/acpica/psxface.c:190
 acpi_ns_evaluate+0x717/0xc30 drivers/acpi/acpica/nseval.c:205
 acpi_ut_evaluate_object+0xcf/0x420 drivers/acpi/acpica/uteval.c:60
 acpi_rs_get_prt_method_data+0x84/0xf0 drivers/acpi/acpica/rsutils.c:446
 acpi_get_irq_routing_table+0x9b/0xd0 drivers/acpi/acpica/rsxface.c:137
 acpi_pci_irq_find_prt_entry+0x171/0xc00 drivers/acpi/pci_irq.c:214
 acpi_pci_irq_lookup+0x8a/0x5a0 drivers/acpi/pci_irq.c:298
 acpi_pci_irq_enable+0x1aa/0x570 drivers/acpi/pci_irq.c:413
 pcibios_enable_device+0x97/0xc0 arch/x86/pci/common.c:699
 do_pci_enable_device+0x11f/0x260 drivers/pci/pci.c:2077
 pci_enable_device_flags+0x1cf/0x250 drivers/pci/pci.c:2162
 enable_store+0x1b2/0x220 drivers/pci/pci-sysfs.c:314
 dev_attr_store+0x58/0x80 drivers/base/core.c:2439
 sysfs_kf_write+0x136/0x1a0 fs/sysfs/file.c:139
 kernfs_fop_write_iter+0x323/0x530 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x51e/0xc80 fs/read_write.c:679
 ksys_write+0x110/0x200 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xa6/0x1a0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888108821618
 which belongs to the cache Acpi-Operand of size 72
The buggy address is located 8 bytes inside of
 freed 72-byte region [ffff888108821618, ffff888108821660)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x108821
flags: 0x200000000000000(node=3D0|zone=3D2)
page_type: f5(slab)
raw: 0200000000000000 ffff8881000e0a00 ffffea000402fd40 dead000000000002
raw: 0000000000000000 0000000000270027 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected



=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94CallTr=
ace=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94

If you need more details or additional test results, please feel free
to let us know. Thank you so much for your attention! Please don't
hesitate to reach out if you have any suggestions or need further
communication.

Best regards,
Luka

