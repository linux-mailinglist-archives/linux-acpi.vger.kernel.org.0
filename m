Return-Path: <linux-acpi+bounces-12763-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD2AA7CDBB
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Apr 2025 13:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1091F16CE88
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Apr 2025 11:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B341BEF74;
	Sun,  6 Apr 2025 11:37:31 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B594E26289
	for <linux-acpi@vger.kernel.org>; Sun,  6 Apr 2025 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743939451; cv=none; b=qThMuLZ/r2TSYVK7HjlIexwPLFxOEHOT/+S0nFzPYQGhW1gYhfWyWOoHUcH1iTT4BIvPYXf5B29qVnON9KhqKmNKn7UkpOIJmmNvi72/nLC68J+FX1JJ9sDUvpH1j+0yZQ5H/QanpHMrI/+NvMu66mqtpPKnPgRv+vhPmiJSdz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743939451; c=relaxed/simple;
	bh=VGD20U7ax2wOW3rHPq72VdiKTz2nxDr05hz2h0YXGA0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=d4PJU643G2JeMZj6y5TWYOFiKRm41tePocNYaU5spYimXm/yM2FpV1rIUbSX6j/QnasBReFlWz4GGJ+Db8X0fpQq/Q8/AiNBWvX6bzuESaYAeHb7hMT2mxErtJaAvZsIy1yvlbXMZxmMzM07/1FFl+yXAfIPUuRztc7xHkiZIH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d5da4fb5e0so36638445ab.2
        for <linux-acpi@vger.kernel.org>; Sun, 06 Apr 2025 04:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743939449; x=1744544249;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AEojaYndoAuY2o0ZRhBirwtVGpDwZvQB7MK1WgQiq5I=;
        b=SBTHap2oN1vZCgffQ3WTGtCFvQ90yvD0ypAOMViHeOsyjFIvBOGQB0nU2NjwTxNlDX
         QekG0NqlzwxBqvGNcSentXSYtVrIQj0pqy6T2sRKHkfJsZRG1Vttg+pleXnXFUbwgTB/
         IbfXyC0TlJYa3SPF7H9o7DOHp5wISIb2eJUZGCQL9PJCwDbS5UOn251TqFFdxDGI9w0y
         dKmDKSNjtezvZNQbIjN4I4KvB6UPk04cR2XvTLA1Uvy4+mkaXLIsfGukSuEt/sC6PSPi
         m1aS9tjY+2lMdFWqE4J1XWFbSUeTTjBgm0E9CJp649h8azy6vS+YWVGXqdFLyE5aps9L
         jL8g==
X-Forwarded-Encrypted: i=1; AJvYcCX0znhNnzgWxFlQJhYm1dlWd04GiJV4TC3yqstW1ouh92M+cWALX9+LI0td/Y7nWs95cXE0pdw5AMcs@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/wkFxe8di9F6rApvzAPGz6d3XW2FMlAxZvKwfP/6umoSfmTR6
	N83YHYG4UNADjm1YE6gBwAfTjYLnIewetj6ZIT2+hxCm7/gxBpsQRbRQ4eIwpg8eSQqw7b3OArR
	lm0hXc0HGhhqsVJzJjtNbmXM+wcZSgxrnAIBKc0mnl3gzgrDJf536bjQ=
X-Google-Smtp-Source: AGHT+IEbBW1rCb8PuLTeVS+n9Vkoy1dBUqoqfgUNLTBUaxhDrq43L6GjOLSmb0wx8H0nwYBJhXNprvtO4YpD9qA7JTDl6Eebamar
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cc:b0:3d4:3fbf:967d with SMTP id
 e9e14a558f8ab-3d6e3f01680mr89965095ab.7.1743939448819; Sun, 06 Apr 2025
 04:37:28 -0700 (PDT)
Date: Sun, 06 Apr 2025 04:37:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f26778.050a0220.0a13.0265.GAE@google.com>
Subject: [syzbot] [acpi?] KASAN: slab-use-after-free Read in software_node_notify_remove
From: syzbot <syzbot+2ff22910687ee0dfd48e@syzkaller.appspotmail.com>
To: andriy.shevchenko@linux.intel.com, dakr@kernel.org, djrscally@gmail.com, 
	gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com, jgg@nvidia.com, 
	kevin.tian@intel.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nicolinc@nvidia.com, rafael@kernel.org, 
	sakari.ailus@linux.intel.com, syzkaller-bugs@googlegroups.com, 
	yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    acc4d5ff0b61 Merge tag 'net-6.15-rc0' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15a807cf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=24f9c4330e7c0609
dashboard link: https://syzkaller.appspot.com/bug?extid=2ff22910687ee0dfd48e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109077b0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13717c3f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e4bfa652b34a/disk-acc4d5ff.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3d19beb8bb92/vmlinux-acc4d5ff.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e7298ccc6331/bzImage-acc4d5ff.xz

The issue was bisected to:

commit 9eb59204d5197b4add63968c8c5b7633631f9a5a
Author: Yi Liu <yi.l.liu@intel.com>
Date:   Fri Mar 21 17:19:37 2025 +0000

    iommufd/selftest: Add set_dev_pasid in mock iommu

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=160ec7cf980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=150ec7cf980000
console output: https://syzkaller.appspot.com/x/log.txt?x=110ec7cf980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2ff22910687ee0dfd48e@syzkaller.appspotmail.com
Fixes: 9eb59204d519 ("iommufd/selftest: Add set_dev_pasid in mock iommu")

R10: 0000000000000002 R11: 0000000000000246 R12: 00007ffcce8ad2dc
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
iommufd_mock iommufd_mock0: Adding to iommu group 0
==================================================================
BUG: KASAN: slab-use-after-free in software_node_notify_remove+0x1bc/0x1c0 drivers/base/swnode.c:1108
Read of size 1 at addr ffff88807fe41108 by task syz-executor390/5849

CPU: 1 UID: 0 PID: 5849 Comm: syz-executor390 Not tainted 6.14.0-syzkaller-12456-gacc4d5ff0b61 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0x16e/0x5b0 mm/kasan/report.c:521
 kasan_report+0x143/0x180 mm/kasan/report.c:634
 software_node_notify_remove+0x1bc/0x1c0 drivers/base/swnode.c:1108
 device_platform_notify_remove drivers/base/core.c:2387 [inline]
 device_del+0x594/0x9b0 drivers/base/core.c:3858
 device_unregister+0x20/0xc0 drivers/base/core.c:3896
 mock_dev_destroy drivers/iommu/iommufd/selftest.c:960 [inline]
 iommufd_test_mock_domain drivers/iommu/iommufd/selftest.c:1022 [inline]
 iommufd_test+0x3715/0x56a0 drivers/iommu/iommufd/selftest.c:1866
 iommufd_fops_ioctl+0x4fc/0x610 drivers/iommu/iommufd/main.c:419
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7feea50b36e9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcce8ad2c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffcce8ad2e0 RCX: 00007feea50b36e9
RDX: 0000200000000200 RSI: 0000000000003ba0 RDI: 0000000000000003
RBP: 0000000000000002 R08: 00007ffcce8ad066 R09: 00000000000000a0
R10: 0000000000000002 R11: 0000000000000246 R12: 00007ffcce8ad2dc
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Allocated by task 5849:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x9d/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x236/0x370 mm/slub.c:4362
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 swnode_register+0x5a/0x540 drivers/base/swnode.c:790
 fwnode_create_software_node+0x199/0x1f0 drivers/base/swnode.c:949
 device_create_managed_software_node+0xd5/0x1f0 drivers/base/swnode.c:1060
 mock_dev_create drivers/iommu/iommufd/selftest.c:942 [inline]
 iommufd_test_mock_domain drivers/iommu/iommufd/selftest.c:989 [inline]
 iommufd_test+0x3335/0x56a0 drivers/iommu/iommufd/selftest.c:1866
 iommufd_fops_ioctl+0x4fc/0x610 drivers/iommu/iommufd/main.c:419
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5849:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2389 [inline]
 slab_free mm/slub.c:4646 [inline]
 kfree+0x198/0x430 mm/slub.c:4845
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22f/0x480 lib/kobject.c:737
 software_node_notify_remove+0x159/0x1c0 drivers/base/swnode.c:1106
 device_platform_notify_remove drivers/base/core.c:2387 [inline]
 device_del+0x594/0x9b0 drivers/base/core.c:3858
 device_unregister+0x20/0xc0 drivers/base/core.c:3896
 mock_dev_destroy drivers/iommu/iommufd/selftest.c:960 [inline]
 iommufd_test_mock_domain drivers/iommu/iommufd/selftest.c:1022 [inline]
 iommufd_test+0x3715/0x56a0 drivers/iommu/iommufd/selftest.c:1866
 iommufd_fops_ioctl+0x4fc/0x610 drivers/iommu/iommufd/main.c:419
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807fe41000
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 264 bytes inside of
 freed 512-byte region [ffff88807fe41000, ffff88807fe41200)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7fe40
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b041c80 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b041c80 0000000000000000 dead000000000001
head: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffea0001ff9001 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5226, tgid 5226 (udevd), ts 58838564258, free_ts 55546510086
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f4/0x240 mm/page_alloc.c:1717
 prep_new_page mm/page_alloc.c:1725 [inline]
 get_page_from_freelist+0x352b/0x36c0 mm/page_alloc.c:3652
 __alloc_frozen_pages_noprof+0x211/0x5b0 mm/page_alloc.c:4934
 alloc_pages_mpol+0x339/0x690 mm/mempolicy.c:2301
 alloc_slab_page mm/slub.c:2459 [inline]
 allocate_slab+0x8f/0x3a0 mm/slub.c:2623
 new_slab mm/slub.c:2676 [inline]
 ___slab_alloc+0xc3b/0x1500 mm/slub.c:3862
 __slab_alloc+0x58/0xa0 mm/slub.c:3952
 __slab_alloc_node mm/slub.c:4027 [inline]
 slab_alloc_node mm/slub.c:4188 [inline]
 __kmalloc_cache_noprof+0x26a/0x370 mm/slub.c:4357
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 kernfs_fop_open+0x3a3/0xdf0 fs/kernfs/file.c:623
 do_dentry_open+0xdec/0x1960 fs/open.c:956
 vfs_open+0x3b/0x370 fs/open.c:1086
 do_open fs/namei.c:3845 [inline]
 path_openat+0x2caf/0x35d0 fs/namei.c:4004
 do_filp_open+0x284/0x4e0 fs/namei.c:4031
 do_sys_openat2+0x12b/0x1d0 fs/open.c:1429
 do_sys_open fs/open.c:1444 [inline]
 __do_sys_openat fs/open.c:1460 [inline]
 __se_sys_openat fs/open.c:1455 [inline]
 __x64_sys_openat+0x249/0x2a0 fs/open.c:1455
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
page last free pid 5223 tgid 5223 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1262 [inline]
 __free_frozen_pages+0xde8/0x10a0 mm/page_alloc.c:2680
 mm_free_pgd kernel/fork.c:793 [inline]
 __mmdrop+0xb9/0x490 kernel/fork.c:939
 mmdrop include/linux/sched/mm.h:55 [inline]
 mmdrop_sched include/linux/sched/mm.h:83 [inline]
 mmdrop_lazy_tlb_sched include/linux/sched/mm.h:110 [inline]
 finish_task_switch+0x304/0x870 kernel/sched/core.c:5275
 context_switch kernel/sched/core.c:5385 [inline]
 __schedule+0x1b90/0x5240 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0x163/0x360 kernel/sched/core.c:6860
 schedule_hrtimeout_range_clock+0x193/0x360 kernel/time/sleep_timeout.c:216
 ep_poll fs/eventpoll.c:2107 [inline]
 do_epoll_wait+0xe2c/0x1100 fs/eventpoll.c:2523
 __do_sys_epoll_wait fs/eventpoll.c:2531 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2526 [inline]
 __x64_sys_epoll_wait+0x259/0x2b0 fs/eventpoll.c:2526
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88807fe41000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807fe41080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807fe41100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88807fe41180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807fe41200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

