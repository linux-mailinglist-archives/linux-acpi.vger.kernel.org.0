Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA7D713A103
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2020 07:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgANGeL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Jan 2020 01:34:11 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:34043 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbgANGeL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Jan 2020 01:34:11 -0500
Received: by mail-il1-f200.google.com with SMTP id l13so9790279ils.1
        for <linux-acpi@vger.kernel.org>; Mon, 13 Jan 2020 22:34:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=AsoDybWiu9oeeZIYozVRkA2K+tw442FbkqUUZ2+BDk4=;
        b=hpaHDIE6NsYlgfJ6oYoQwaw2YVPioUbpQK9L1xN5hmvsan/TnDFtYksf0/IrSLq6aO
         SogQOusVI4NKZpfT4NMwySMPJ0Hd7u5I5xfo0peiDjXfyaY95k+adg90v3HI5ojJtRNt
         eQ7DRDPMM3C6CELKk8o6430CzjGsiwyhx72z1HmErdfy5+IT0gfjFCZeqCaaKpnaJDJW
         xQ5MOHlk7OnsUMlZRpdPQFfsHOu2pDhzGZH18bphofohmHwGNzsxttOItDrdppbO5Lev
         l6u9EGzJ8zmqHkx8WOqZM4hGXOfkzLs0Oju3LXqnlR2NMMB4X49bE1eak0zVxGOZ2HCx
         rWbA==
X-Gm-Message-State: APjAAAW35uZtyP+eq2gJlXkrpqeoO8buhzufHXZKhvNDrPEFC+R/JeMC
        tmkG8aiUdjJVbg0pse1Wy64BlN18iIYfzNy4Pj2h3IO23c6W
X-Google-Smtp-Source: APXvYqwgTdOp85AttTjzBrnZD7gxdOtH9RZ0rYYksQSDiYgMzGVwR5CKnEeGUOuZFCV7CKvHoAtRchuXup6x4gmDCairIf8TIA24
MIME-Version: 1.0
X-Received: by 2002:a5d:8a0c:: with SMTP id w12mr15667659iod.194.1578983650674;
 Mon, 13 Jan 2020 22:34:10 -0800 (PST)
Date:   Mon, 13 Jan 2020 22:34:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009acfef059c13c771@google.com>
Subject: KASAN: vmalloc-out-of-bounds Read in acpi_nfit_ctl
From:   syzbot <syzbot+002f559bf34c2c7467d0@syzkaller.appspotmail.com>
To:     dan.j.williams@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        rjw@rjwysocki.net, syzkaller-bugs@googlegroups.com,
        vishal.l.verma@intel.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    040a3c33 Merge tag 'iommu-fixes-v5.5-rc5' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=120a5d8ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e89bd00623fe71e
dashboard link: https://syzkaller.appspot.com/bug?extid=002f559bf34c2c7467d0
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+002f559bf34c2c7467d0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in test_bit  
include/asm-generic/bitops/instrumented-non-atomic.h:110 [inline]
BUG: KASAN: vmalloc-out-of-bounds in acpi_nfit_ctl+0x47f/0x1840  
drivers/acpi/nfit/core.c:495
Read of size 8 at addr ffffc90002ddbbb8 by task syz-executor.1/5941

CPU: 3 PID: 5941 Comm: syz-executor.1 Not tainted 5.5.0-rc5-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS  
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0x5/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:639
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
  __kasan_check_read+0x11/0x20 mm/kasan/common.c:95
  test_bit include/asm-generic/bitops/instrumented-non-atomic.h:110 [inline]
  acpi_nfit_ctl+0x47f/0x1840 drivers/acpi/nfit/core.c:495
  __nd_ioctl drivers/nvdimm/bus.c:1152 [inline]
  nd_ioctl.isra.0+0xfe2/0x1580 drivers/nvdimm/bus.c:1230
  bus_ioctl+0x59/0x70 drivers/nvdimm/bus.c:1242
  compat_ptr_ioctl+0x6e/0xa0 fs/ioctl.c:788
  __do_compat_sys_ioctl fs/compat_ioctl.c:214 [inline]
  __se_compat_sys_ioctl fs/compat_ioctl.c:142 [inline]
  __ia32_compat_sys_ioctl+0x233/0x610 fs/compat_ioctl.c:142
  do_syscall_32_irqs_on arch/x86/entry/common.c:337 [inline]
  do_fast_syscall_32+0x27b/0xe16 arch/x86/entry/common.c:408
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f37a39
Code: 00 00 00 89 d3 5b 5e 5f 5d c3 b8 80 96 98 00 eb c4 8b 04 24 c3 8b 1c  
24 c3 8b 34 24 c3 8b 3c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f5d330cc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000000560a
RDX: 0000000020000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000


Memory state around the buggy address:
  ffffc90002ddba80: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
  ffffc90002ddbb00: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
> ffffc90002ddbb80: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
                                         ^
  ffffc90002ddbc00: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
  ffffc90002ddbc80: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
