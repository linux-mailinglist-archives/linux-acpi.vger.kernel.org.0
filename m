Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8B3812197F
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 19:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfLPSzM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Dec 2019 13:55:12 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:35522 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbfLPSzL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Dec 2019 13:55:11 -0500
Received: by mail-io1-f69.google.com with SMTP id x10so6471484iob.2
        for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2019 10:55:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=tmqmR3+vlPyZZu/9yb3HcQ7dVLCo+U2onyjU4cVHi0w=;
        b=mtwhuq/j+68W3tezUKb787OVJsEWm+FqcdJKIQLqD1M9jV2AkKgCRiZk0uThbV1lZ4
         cflrFkh/fLdiF8yxEGRIW3TQMXc4KOfyIiNs+9zMYHm8k7O+MfiHz2B33eSItb1AnANe
         fDOcoQJKbrupChHhInLzlRc9oNYtiYb4G4/1yqTCdsLYPUPwrLKt5jrFyzMubtq7cr9m
         JJzdsbEBxDV4D8LL6WKbR13xCrOA8RBk9fyQajRg+HNeCoLbhNlCtER8vpVt7AZ/Wdck
         KAywUH0q2dJ3tbqdTMhmEnCJx2y8Vz+1G92Il2RBBtaFVarOvzvogIrBNrlHFE4Hqfsc
         4XOg==
X-Gm-Message-State: APjAAAXN8JFs5kpVPQpjjeKVbr9jfcWk4sCmBfodTW3mmts3Xt6qTO5k
        8GxW/L2tLohpuD2VVACxji1imu5lvvNmU2p5b94surHjoLNX
X-Google-Smtp-Source: APXvYqxFNUUSx7QdncAf6uGRlTJWldYx4Lhfu3gnPt+XtiWQ6HMfGu0/RPiDMlRDDPq8ZIcFuaXACWXUu4a7tGMb00bNSpJ76BuB
MIME-Version: 1.0
X-Received: by 2002:a5d:9046:: with SMTP id v6mr458515ioq.302.1576522509304;
 Mon, 16 Dec 2019 10:55:09 -0800 (PST)
Date:   Mon, 16 Dec 2019 10:55:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025cf0f0599d6c049@google.com>
Subject: KASAN: stack-out-of-bounds Read in acpi_nfit_ctl
From:   syzbot <syzbot+2812ea3c67cdf329dde3@syzkaller.appspotmail.com>
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

HEAD commit:    510c9788 Merge tag 'Wimplicit-fallthrough-5.5-rc2' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17bbac99e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79f79de2a27d3e3d
dashboard link: https://syzkaller.appspot.com/bug?extid=2812ea3c67cdf329dde3
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117b520ae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a5cf41e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2812ea3c67cdf329dde3@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: stack-out-of-bounds in test_bit  
include/asm-generic/bitops/instrumented-non-atomic.h:110 [inline]
BUG: KASAN: stack-out-of-bounds in acpi_nfit_ctl+0x47f/0x1840  
drivers/acpi/nfit/core.c:495
Read of size 8 at addr ffffc90003267bd0 by task syz-executor077/8537

CPU: 2 PID: 8537 Comm: syz-executor077 Not tainted 5.5.0-rc1-syzkaller #0
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
RIP: 0023:0xf7f12a39
Code: 00 00 00 89 d3 5b 5e 5f 5d c3 b8 80 96 98 00 eb c4 8b 04 24 c3 8b 1c  
24 c3 8b 34 24 c3 8b 3c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000ff8ed9cc EFLAGS: 00000213 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000004018920a
RDX: 00000000200001c0 RSI: 00000000ff8eda20 RDI: 00000000080481b0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000


addr ffffc90003267bd0 is located in stack of task syz-executor077/8537 at  
offset 88 in frame:
  acpi_nfit_ctl+0x0/0x1840 drivers/acpi/nfit/core.c:288

this frame has 5 objects:
  [32, 40) 'cmd_mask'
  [64, 72) 'dsm_mask'
  [96, 112) 'buf'
  [128, 152) 'in_obj'
  [192, 216) 'in_buf'

Memory state around the buggy address:
  ffffc90003267a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffffc90003267b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f1
> ffffc90003267b80: f1 f1 f1 00 f2 f2 f2 00 f2 f2 f2 00 00 f2 f2 00
                                                  ^
  ffffc90003267c00: 00 00 f2 f2 f2 f2 f2 00 00 00 f3 f3 f3 f3 f3 00
  ffffc90003267c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
