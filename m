Return-Path: <linux-acpi+bounces-9296-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509C99BD05E
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 16:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC38283DBA
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 15:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0EC1DAC95;
	Tue,  5 Nov 2024 15:28:28 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48C61D90DD
	for <linux-acpi@vger.kernel.org>; Tue,  5 Nov 2024 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820508; cv=none; b=kCaMSmzomcYybxPMz4jHVsBsRzlEE9n8nOw3Hk0xCQeIctsVJZG1fzEvnV9Zv6zvCz2HGvpzmcMY/AUVOOOi6uat+K+LEXQ7vChox3mQ+jrJn09y9rUdDANrFLD6QbWa6UGfCjoDQjcVEds0IfQ1DzI5e4AzLPlRp6YuvtgQqmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820508; c=relaxed/simple;
	bh=Umw7hHA8NJTxEHzeXs3EOA1ZOePD3R18UEvNQTEolbE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Swstba2N+wRAJ+56plQUjLO+MzwJvZxmCGkyUkXfeB3vcW+HJy89S79NnQ6UVMWpb8ezk7KmEWG+4yNbWIJWbm5J7qPzDR3mkbrWPljsy0uxKwG8VGdeOpWpnZDGlALEtYOl9wS5jHnhbvq5udB4EVeCkV2jS6jGXeD0DjbsDTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3c27c72d5so58462765ab.2
        for <linux-acpi@vger.kernel.org>; Tue, 05 Nov 2024 07:28:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730820505; x=1731425305;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZIKcuIWij1X8qx5ncDl/9Nkjue6MvSRLjlDnhaH0nBI=;
        b=VNZDtwffuU2vFWVmMF2iG5dt7c38+TFaP/Q7MROiLASlJBiuk3WrThaUkO+1uXeemr
         rCFpKEAr7L7dPL2i07Q+MxMnUMmA+KoYvZVfRRn3IrsQ+Ffg/jg/ruhKQC00F+f1Yyi4
         CFfajTJRNaivqt5HCpNEj35pdPxpH9U1xYZD2Sb1OJhUPJiOU9BZAcNE5J2SayTWqa39
         mAyap6wOG91UEalfh2GtYczQd9SH2GlKUlcPwEEHuWZeZybGIOlpiNBoxkiOFDUI5FI6
         DIE5plDCY1v8KbNMekpMa5jorQxqlT8lOG1vufiNeQEwdL/dApQ95729L0P8T2sSW/yc
         sVMw==
X-Forwarded-Encrypted: i=1; AJvYcCWD8ywJxBVGlszjqPF48hOmekTJe+LI0lpCeoq2YuA9nf5yQ5Spc6jqbuuPzjpWjdts14dod6PBt9lf@vger.kernel.org
X-Gm-Message-State: AOJu0YxS5uB6/H73uSAePCm7yg4wBtokP8HxfbUV1gcmAQsMaIkiLPPx
	B4XG8tUJMjCXUyaPM3HAlyNbQUjc6OyjzvRYcMIInQfs9KJAlKFgcUGh3JPvzQrFTXGj7KzQ1Mh
	91OpE/i8igiHl4qkmDYDqwPKopgUzrMgTNoKIbDbuWvK/k2od8dnF7ZY=
X-Google-Smtp-Source: AGHT+IFf2xLDkeIymMV//zMPJ+Qh/bFah2TWKmNKzhqPOPB5abQc7nAM5rKTtIVA89Blnq3YBaAsdpKhD1ZPv6zhQYeUMv12q6Gd
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216e:b0:3a4:ecdb:d61d with SMTP id
 e9e14a558f8ab-3a6b02c72e1mr174793385ab.8.1730820503195; Tue, 05 Nov 2024
 07:28:23 -0800 (PST)
Date: Tue, 05 Nov 2024 07:28:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672a3997.050a0220.2a847.11f7.GAE@google.com>
Subject: [syzbot] [acpi?] [nvdimm?] KASAN: vmalloc-out-of-bounds Read in
 acpi_nfit_ctl (2)
From: syzbot <syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com>
To: dan.j.williams@intel.com, dave.jiang@intel.com, ira.weiny@intel.com, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, rafael@kernel.org, syzkaller-bugs@googlegroups.com, 
	vishal.l.verma@intel.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2e1b3cc9d7f7 Merge tag 'arm-fixes-6.12-2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12418e30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11254d3590b16717
dashboard link: https://syzkaller.appspot.com/bug?extid=7534f060ebda6b8b51b3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12170f40580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16418e30580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-2e1b3cc9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2f2588b04ae9/vmlinux-2e1b3cc9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2c9324cf16df/bzImage-2e1b3cc9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in cmd_to_func drivers/acpi/nfit/core.c:416 [inline]
BUG: KASAN: vmalloc-out-of-bounds in acpi_nfit_ctl+0x20e8/0x24a0 drivers/acpi/nfit/core.c:459
Read of size 4 at addr ffffc90000e0e038 by task syz-executor229/5316

CPU: 0 UID: 0 PID: 5316 Comm: syz-executor229 Not tainted 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 cmd_to_func drivers/acpi/nfit/core.c:416 [inline]
 acpi_nfit_ctl+0x20e8/0x24a0 drivers/acpi/nfit/core.c:459
 __nd_ioctl drivers/nvdimm/bus.c:1186 [inline]
 nd_ioctl+0x1844/0x1fd0 drivers/nvdimm/bus.c:1264
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb399ccda79
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcf6cb8d88 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb399ccda79
RDX: 0000000020000180 RSI: 00000000c008640a RDI: 0000000000000003
RBP: 00007fb399d405f0 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>

The buggy address belongs to the virtual mapping at
 [ffffc90000e0e000, ffffc90000e10000) created by:
 __nd_ioctl drivers/nvdimm/bus.c:1169 [inline]
 nd_ioctl+0x1594/0x1fd0 drivers/nvdimm/bus.c:1264

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880401b9a80 pfn:0x401b9
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: ffff8880401b9a80 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2cc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN), pid 5316, tgid 5316 (syz-executor229), ts 69039468240, free_ts 68666765389
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x303f/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
 alloc_pages_bulk_noprof+0x729/0xd40 mm/page_alloc.c:4681
 alloc_pages_bulk_array_mempolicy_noprof+0x8ea/0x1600 mm/mempolicy.c:2556
 vm_area_alloc_pages mm/vmalloc.c:3542 [inline]
 __vmalloc_area_node mm/vmalloc.c:3646 [inline]
 __vmalloc_node_range_noprof+0x752/0x13f0 mm/vmalloc.c:3828
 __vmalloc_node_noprof mm/vmalloc.c:3893 [inline]
 vmalloc_noprof+0x79/0x90 mm/vmalloc.c:3926
 __nd_ioctl drivers/nvdimm/bus.c:1169 [inline]
 nd_ioctl+0x1594/0x1fd0 drivers/nvdimm/bus.c:1264
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5312 tgid 5312 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
 __folio_put+0x2c7/0x440 mm/swap.c:126
 pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
 pipe_update_tail fs/pipe.c:224 [inline]
 pipe_read+0x6ed/0x13e0 fs/pipe.c:344
 new_sync_read fs/read_write.c:488 [inline]
 vfs_read+0x991/0xb70 fs/read_write.c:569
 ksys_read+0x183/0x2b0 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffffc90000e0df00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90000e0df80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc90000e0e000: 00 00 00 00 00 00 00 03 f8 f8 f8 f8 f8 f8 f8 f8
                                        ^
 ffffc90000e0e080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90000e0e100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

