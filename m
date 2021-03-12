Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24A3338DC1
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Mar 2021 13:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhCLMwt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Mar 2021 07:52:49 -0500
Received: from lizzard.sbs.de ([194.138.37.39]:54876 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232762AbhCLMwZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Mar 2021 07:52:25 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 12CCqMpT020506
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 13:52:22 +0100
Received: from [167.87.253.211] ([167.87.253.211])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 12CCbL5i009474;
        Fri, 12 Mar 2021 13:37:22 +0100
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: "cache_from_obj: Wrong slab cache." on failing ACPI init
Message-ID: <a1461e21-c744-767d-6dfc-6641fd3e3ce2@siemens.com>
Date:   Fri, 12 Mar 2021 13:37:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

a wrong config surfaced a potential issue in the cleanup path of ACPI, 
at least according to my current understanding. Use x86_64_defconfig, 
add CONFIG_SLAB_FREELIST_HARDENED=y and disable CONFIG_PCI, then boot in 
QEMU (likely also real HW) to get this:

...
[    0.041398] ACPI: Added _OSI(Module Device)
[    0.041978] ACPI: Added _OSI(Processor Device)
[    0.042342] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.043060] ACPI: Added _OSI(Processor Aggregator Device)
[    0.043337] ACPI: Added _OSI(Linux-Dell-Video)
[    0.044095] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.044341] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.045020] ACPI Error: AE_BAD_PARAMETER, During Region initialization (20210105/tbxfload-53)
[    0.045340] ACPI: Unable to load the System Description Tables
[    0.046076] ACPI Error: Could not remove SCI handler (20210105/evmisc-251)
[    0.046367] ------------[ cut here ]------------
[    0.047004] cache_from_obj: Wrong slab cache. ftrace_event_field but object is from kmalloc-64
[    0.047340] WARNING: CPU: 0 PID: 1 at ../mm/slab.h:456 kmem_cache_free+0x1c8/0x280
[    0.048319] Modules linked in:
[    0.048335] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc2+ #7
[    0.049174] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[    0.049336] RIP: 0010:kmem_cache_free+0x1c8/0x280
[    0.050041] Code: 28 48 01 d8 48 85 db 0f 85 2d ff ff ff 0f 0b 48 8b 57 60 48 8b 4d 60 48 c7 c6 f0 5b c1 af 48 c7 c7 50 5c da af e8 c8 36 e8 ff <0f> 0b 48 89 de 48 89 ef e8 8b be ff ff 48 8b 0d 7c 9e e4 00 e9 a6
[    0.050336] RSP: 0000:ffffb12e80017d90 EFLAGS: 00010282
[    0.051135] RAX: 0000000000000000 RBX: ffff89570104f340 RCX: 00000000ffffdfff
[    0.051335] RDX: ffffb12e80017bb0 RSI: 00000000ffffdfff RDI: 0000000000000003
[    0.052304] RBP: ffff895701042500 R08: 0000000000000000 R09: 0000000000000001
[    0.052335] R10: 0000000000000001 R11: ffffb12e80017ba8 R12: ffffffffafdcb739
[    0.053201] R13: ffff89570104f380 R14: ffff89578104f340 R15: 0000000000000000
[    0.053335] FS:  0000000000000000(0000) GS:ffff89573ec00000(0000) knlGS:0000000000000000
[    0.054337] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.055342] CR2: 0000000000000000 CR3: 000000001780c001 CR4: 0000000000370ef0
[    0.056345] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.057291] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.057337] Call Trace:
[    0.057743]  ? rdinit_setup+0x26/0x26
[    0.058268]  acpi_os_release_object+0x5/0x10
[    0.058335]  acpi_ns_delete_children+0x4b/0x60
[    0.059168]  acpi_ns_delete_namespace_subtree+0x5c/0x79
[    0.059336]  ? acpi_sleep_proc_init+0x1f/0x1f
[    0.059987]  acpi_ns_terminate+0xc/0x31
[    0.060335]  acpi_ut_subsystem_shutdown+0x45/0xa1
[    0.061060]  ? acpi_sleep_proc_init+0x1f/0x1f
[    0.061335]  acpi_terminate+0x5/0xf
[    0.062160]  acpi_init+0x3f7/0x482
[    0.062337]  ? video_setup+0x79/0x79
[    0.062958]  ? acpi_sleep_proc_init+0x1f/0x1f
[    0.063335]  do_one_initcall+0x3f/0x1c0
[    0.063876]  kernel_init_freeable+0x1bb/0x1f9
[    0.064335]  ? rest_init+0xb0/0xb0
[    0.064833]  kernel_init+0x5/0x110
[    0.065329]  ret_from_fork+0x22/0x30
[    0.065338] ---[ end trace 8bfe26bf6796f23c ]---
[    0.066028] ------------[ cut here ]------------

and many more of those. This was with current Linus head and also 
v5.10.23.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
