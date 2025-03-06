Return-Path: <linux-acpi+bounces-11877-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A85A54102
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 04:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD2D16A90C
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 03:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1DF1917C2;
	Thu,  6 Mar 2025 03:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdDlyX97"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6F3F513;
	Thu,  6 Mar 2025 03:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741230395; cv=none; b=Mon3sg4zNCe7vZfUT48M/V60Eew4SW5UEMnt79h08Iegtq4xbDvvpJvpI2JKg9YBDlUJRnnP8quYJDsjhdHsOgFMxVsjMNtfg6HVssBi1loNJzlhqXIXNCR4ZDfCcfGaHIix5eR8nxTz9qGRQnDKmBJU5hafb7ihQs6hR4/ZH04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741230395; c=relaxed/simple;
	bh=Xlz9r5dgABLXp+EuZeZfVtT8mnEGTMyXPNGzaZpzcxk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Mw/qrU/VuNgqlnwn2GPo8xQ3iL2w3pPTPhpB6aua3JzZmPUE8tLnCJEd8X+HEgdq93vmNjRC76KBhsHgN7bxNfykwmHavWWM0+livPx0Fz2IO7wojb9miskidnbgykgMHfToGgXoS56TTzmHArB8BYz1ArUyuinshanjY6Hd8Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdDlyX97; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c3b533a683so19245685a.2;
        Wed, 05 Mar 2025 19:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741230392; x=1741835192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xlz9r5dgABLXp+EuZeZfVtT8mnEGTMyXPNGzaZpzcxk=;
        b=LdDlyX97NGbK3IzAVHphjUMCv/7Sc5MzugpTgcSg8jnmRf+UtkvzVI++evVL3lGgjn
         roEEYm1Uy27z/1ZofsNdW6DMkNfnZP5We4NWrgzhddI8tWtNCMQQZbKbPd5dvGKmvxAt
         dkMezk1lVgfsPBHNJ801+jmzAU4Xq1T3ogWmtH6COG0yAL/tUjBqGdgMitIw5jBWudJ+
         G9DqHu2VeJzyqwzFAL2qHvY2NJf0K3OO8oqiqZYv6dWcob7+6qucXvtT9052ePtMwoLC
         YjWlmENbEKDkyW1SSZnEV6OvWF8e/11eTabjTY0bUdEh/9KmZKqiFLFHJSB96U2MCE3Z
         m6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741230392; x=1741835192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xlz9r5dgABLXp+EuZeZfVtT8mnEGTMyXPNGzaZpzcxk=;
        b=sNdu9Z7BbgB3JnIDybWBXBv4I6NbmZdN4DuURnCBVv5/cgENaPMsbH2oUEwXar9Agy
         3vybUM0OVbHR0Div5Cx3DEx2AH+4D9RBrmsGnXuSeJ7oHLTp1WnFuc4L0PZxL4oSHSAD
         bz1cUfwC3wkHhQRSY45NtnUjnWIw32fJI/FP6lMBCevontZ+Idh7GBcuJ3aj0dyw5QN0
         GiW8AV3Gj3DR3vY9avJ//A3D5+yNaZ1jC9u23WPoNGJV6YyV1NrVO+RrCpOxibPNAR8c
         /dhwWaU++AEClI7WmrxXK8ODXjTlMdSMt9LA0mu3xKqkGUuwgVhebOjlc2a/VrAUX+re
         jnKA==
X-Forwarded-Encrypted: i=1; AJvYcCVXMZtKCvPuWFbXmGueaxduy72OQe4t4/3qRqEhQUxdaaHwIVj7etxWda/pEmDruUganhZghMO0YRkoJuA4@vger.kernel.org, AJvYcCVu6wBiDwHJR34Rs3jkEek+gN+2jhEIpTYFH4hPk0A+gLhjrvLHjwCdJ3cf3S+auo+qlDh1fRxGL7i4@vger.kernel.org
X-Gm-Message-State: AOJu0YyaYwGOB+kEtxHruPC90hDPL+2DN24Qybjs1qp3wD5we7i7WqYL
	RBvjTyxSLslirOrIc60iuszaYYx70tu/gH4GF6Q8P7dE7EzWy1A3lT/TsD+LHF9vFAQgiPVrjRe
	9TnomfvXIBtVGPpsefqX06XPWQ1CLHs1jfedT2g==
X-Gm-Gg: ASbGncu0wrvGneogXShU5RadOWVlBAbKCT/LCkQmGHwHI+fZqRNWKJueqN3IuuZbcVX
	nHoT4VidLZoI8WFBxJEGfatX05bODxYEHCSkEfsVHddv6C6svztiyKnm7s++5t7kfBn/TLBKz58
	smdtbYra2la0F+QY6WTQtYdjQGb0g=
X-Google-Smtp-Source: AGHT+IGuV8I4lGu/BiaT2CPPqNNCKrrFqca7miWSDaXiSXkrjqr/9LxSmnR5hi2TN/ltgQTKrWGl47zF7Tt+0yHKOQQ=
X-Received: by 2002:ad4:5ba3:0:b0:6e4:2e5f:c03b with SMTP id
 6a1803df08f44-6e8e6d60dbfmr83797296d6.22.1741230392362; Wed, 05 Mar 2025
 19:06:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luka <luka.2016.cs@gmail.com>
Date: Thu, 6 Mar 2025 11:06:21 +0800
X-Gm-Features: AQ5f1Jocv5Qcj2kNRuYNc8BYc0xo7Q8YLmK47upb9QsraCDR8xg0t84BzQi1ZDE
Message-ID: <CALm_T+0f2Z4yjoB6J-HO-Ttk6z-RXQB54zKi+rLkkhhpp=huRQ@mail.gmail.com>
Subject: Potential Linux Crash: KASAN: slab-use-after-free Read in
 acpi_ut_update_object_reference in Linux kernel v6.13-rc5
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

Kernel Version: v6.13-rc5

Kernel Module: drivers/acpi/acpica/utdelete.c

=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94CallTr=
ace=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94

BUG: KASAN: slab-use-after-free in
acpi_ut_update_object_reference+0x601/0x6a0
drivers/acpi/acpica/utdelete.c:497
Read of size 1 at addr ffff888104ecbdd8 by task sh/4165

Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:94 [inline]
dump_stack_lvl+0x7b/0xa0 lib/dump_stack.c:120
print_address_description mm/kasan/report.c:378 [inline]
print_report+0xce/0x660 mm/kasan/report.c:489
kasan_report+0xc6/0x100 mm/kasan/report.c:602
acpi_ut_update_object_reference+0x601/0x6a0 drivers/acpi/acpica/utdelete.c:=
497
acpi_ut_remove_reference drivers/acpi/acpica/utdelete.c:740 [inline]
acpi_ut_remove_reference+0x65/0x80 drivers/acpi/acpica/utdelete.c:710
acpi_ds_clear_implicit_return drivers/acpi/acpica/dsutils.c:55 [inline]
acpi_ds_clear_implicit_return+0x7c/0xd0 drivers/acpi/acpica/dsutils.c:34
acpi_ds_method_error+0x1c8/0x2f0 drivers/acpi/acpica/dsmethod.c:219
acpi_ds_exec_end_op+0x6f6/0x1350 drivers/acpi/acpica/dswexec.c:753
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
RIP: 0033:0x7f615e492513
Code: 8b 15 81 29 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f
1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
RSP: 002b:00007ffe949c1848 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000056557c2586b0 RCX: 00007f615e492513
RDX: 0000000000000002 RSI: 000056557c2586b0 RDI: 0000000000000001
RBP: 0000000000000002 R08: 000056557c2586b0 R09: 00007f615e575be0
R10: 0000000000000070 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000002 R14: 7fffffffffffffff R15: 0000000000000000
</TASK>

Allocated by task 4165:
kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
kasan_save_track+0x14/0x30 mm/kasan/common.c:68
unpoison_slab_object mm/kasan/common.c:319 [inline]
__kasan_slab_alloc+0x6e/0x70 mm/kasan/common.c:345
kasan_slab_alloc include/linux/kasan.h:250 [inline]
slab_post_alloc_hook mm/slub.c:4119 [inline]
slab_alloc_node mm/slub.c:4168 [inline]
kmem_cache_alloc_noprof+0xf5/0x360 mm/slub.c:4175
acpi_ut_allocate_object_desc_dbg drivers/acpi/acpica/utobject.c:359 [inline=
]
acpi_ut_create_internal_object_dbg+0x6d/0x3c0 drivers/acpi/acpica/utobject.=
c:69
acpi_ut_copy_iobject_to_iobject+0x65/0x390 drivers/acpi/acpica/utcopy.c:947
acpi_ds_store_object_to_local+0x260/0x440 drivers/acpi/acpica/dsmthdat.c:54=
2
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

The buggy address belongs to the object at ffff888104ecbdd0
which belongs to the cache Acpi-Operand of size 72
The buggy address is located 8 bytes inside of
freed 72-byte region [ffff888104ecbdd0, ffff888104ecbe18)



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

