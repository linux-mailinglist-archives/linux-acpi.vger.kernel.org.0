Return-Path: <linux-acpi+bounces-12767-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6DDA7CE5E
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Apr 2025 16:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1CD188ED01
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Apr 2025 14:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A25218EB4;
	Sun,  6 Apr 2025 14:09:07 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A489218E83
	for <linux-acpi@vger.kernel.org>; Sun,  6 Apr 2025 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743948547; cv=none; b=lW9o8zdnKO6MqVeR/jmwtr8lTByppcXNmDWvywiLeSFue2UghBWzqHZyhlX+8R97L3UMfQKP7Piap80zqsrbYNawf8h7clI8dlRnm+SVkurUGCCB+Zg5ljv4ZhiOOl/tY/2F+Sc3ZcjCnLEYEFnCQzYBpxm11cCTJ+7DzyXgZag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743948547; c=relaxed/simple;
	bh=m+4+9HmLA1W3Y+XP5CFi2fuTRL+IGVBbugonxbcYCbA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gwVGzWqsA/B9Q5xh3a49OLxC5W/JevcgE4mfbSM31EWdP9jMQU+Gv1idVSJMHPGLUmxhJgQzq8JUhmqE9k7Y2MJKv62adEklpvf5cGvhjnGQe54jI3uD0PGYdy6/l95H8zx6EHQqAJW73K0dJ9Pu9CSKdRsz3+5+HREL+zZDk4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85e318dc464so757428039f.1
        for <linux-acpi@vger.kernel.org>; Sun, 06 Apr 2025 07:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743948545; x=1744553345;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dlnz3QUWVHoJAB4rH18Hc6CGYwZXQHnTUZNR/puT8KM=;
        b=lHsOMpSGUE8hK8Qx7PMvYCjqMTTJX17DkwCcRD/52uO2yQbsOHGQS/cIY29idjEiXT
         lfyIslJK3G0jCmEKgL80wuuMTCBiVdcrA8y9rAVkRiVCUEVB+8gCvAoYXeyuFdL/iYzD
         YXdtUBW/tXifxNedO5vQrF1ZrqrfgNalXwOKNFNMexkOYE8zWNrjyjob1G/1Mzkc57Xe
         i2gy3m3S0FtCPBqGD6t8NsO7vMsuxCLWviEAGwwRsHdLiqDfsBC3tjcp0zzkxiMjJ6Ic
         RMvFqqcfVlljB6ZTPIV5o7SwhdMHCUeb7LdLCo773Gsrop2qLwy35NKYw6FBPhvboQ2K
         EhAw==
X-Forwarded-Encrypted: i=1; AJvYcCV4q4rc/ApXqEWHuOiPJICa/zF/O0U0gAgQQfPAIdxUa/5LrGeQc2Heu1MjdeYoH2FWoGXagtjfUKzN@vger.kernel.org
X-Gm-Message-State: AOJu0Yy23VpvGr5PAUw3D9f1e4Yo5WBKopQLaB48T0XLR0K9TlGuTRKk
	ESkxCdua7iEgbzEaegO2EJKX2nrLIT8+yBWQnUY1DaTQXoGmg92ExHx7ghtsbUxe73R7y0da+Km
	tvq0eelswD4zHtYqvz6ZB2ImeXV+zwawv6RxBIKrgHdZOPqkrsQY/eto=
X-Google-Smtp-Source: AGHT+IFVk6B3KojEZ3HHyDg7b7Q2KgR8+e22Z3aTgtBeq8fXrlmEnRT2d1Mw60kBpCc7sQyRFyMLKPSIDt3XS/IeWyV6D7w8upDr
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24f:0:b0:3d3:dcfd:2768 with SMTP id
 e9e14a558f8ab-3d6e3eea7d0mr105686255ab.4.1743948544799; Sun, 06 Apr 2025
 07:09:04 -0700 (PDT)
Date: Sun, 06 Apr 2025 07:09:04 -0700
In-Reply-To: <Z_KAmSNLsAhctKv8@smile.fi.intel.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f28b00.050a0220.0a13.026a.GAE@google.com>
Subject: Re: [syzbot] [acpi?] KASAN: slab-use-after-free Read in software_node_notify_remove
From: syzbot <syzbot+2ff22910687ee0dfd48e@syzkaller.appspotmail.com>
To: andriy.shevchenko@linux.intel.com, dakr@kernel.org, djrscally@gmail.com, 
	gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com, jgg@nvidia.com, 
	kevin.tian@intel.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nicolinc@nvidia.com, rafael@kernel.org, 
	sakari.ailus@linux.intel.com, syzkaller-bugs@googlegroups.com, 
	yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in set_secondary_fwnode

R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000000000000 R14: 00007f0934da5fa0 R15: 00007ffe7c9dc778
 </TASK>
iommufd_mock iommufd_mock0: Adding to iommu group 0
==================================================================
BUG: KASAN: slab-use-after-free in fwnode_is_primary drivers/base/core.c:5105 [inline]
BUG: KASAN: slab-use-after-free in set_secondary_fwnode+0x89/0xd0 drivers/base/core.c:5167
Read of size 8 at addr ffff8880358f0440 by task syz.0.19/6201

CPU: 0 UID: 0 PID: 6201 Comm: syz.0.19 Not tainted 6.14.0-syzkaller-13525-g22ea69445c54 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0x16e/0x5b0 mm/kasan/report.c:521
 kasan_report+0x143/0x180 mm/kasan/report.c:634
 fwnode_is_primary drivers/base/core.c:5105 [inline]
 set_secondary_fwnode+0x89/0xd0 drivers/base/core.c:5167
 software_node_notify_remove+0x1a8/0x1e0 drivers/base/swnode.c:1112
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
RIP: 0033:0x7f0934b8d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0935a12038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0934da5fa0 RCX: 00007f0934b8d169
RDX: 0000200000000200 RSI: 0000000000003ba0 RDI: 0000000000000003
RBP: 00007f0935a12090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000000000000 R14: 00007f0934da5fa0 R15: 00007ffe7c9dc778
 </TASK>

Allocated by task 6201:
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

Freed by task 6201:
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
 software_node_notify_remove+0x18d/0x1e0 drivers/base/swnode.c:1109
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

The buggy address belongs to the object at ffff8880358f0400
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 64 bytes inside of
 freed 512-byte region [ffff8880358f0400, ffff8880358f0600)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x358f0
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b041c80 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b041c80 dead000000000100 dead000000000122
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffea0000d63c01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5211, tgid 5211 (udevd), ts 44437391568, free_ts 41364354329
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
page last free pid 5213 tgid 5213 stack trace:
 create_dummy_stack mm/page_owner.c:94 [inline]
 register_dummy_stack+0x8e/0xe0 mm/page_owner.c:100
 init_page_owner+0x3e/0x790 mm/page_owner.c:118
 invoke_init_callbacks mm/page_ext.c:148 [inline]
 page_ext_init+0x731/0x790 mm/page_ext.c:497
 mm_core_init+0x5b/0x70 mm/mm_init.c:2783

Memory state around the buggy address:
 ffff8880358f0300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880358f0380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880358f0400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff8880358f0480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880358f0500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         22ea6944 software node: Avoid use-after-free access in..
git tree:       https://bitbucket.org/andy-shev/linux.git test-swnode
console output: https://syzkaller.appspot.com/x/log.txt?x=1276f404580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2054704dd53fb80
dashboard link: https://syzkaller.appspot.com/bug?extid=2ff22910687ee0dfd48e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

