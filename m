Return-Path: <linux-acpi+bounces-8299-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F78B979482
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Sep 2024 04:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1B001F231AA
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Sep 2024 02:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9BFC8CE;
	Sun, 15 Sep 2024 02:58:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0D82F32
	for <linux-acpi@vger.kernel.org>; Sun, 15 Sep 2024 02:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726369107; cv=none; b=Chra2l/FURmtEd08NoCINKdzJWUFGa4pYRzhjlZA0xqwxgcfWTVFKs8rTtN2dhx5yfQkPrxD6QRHfzViuGedrPNPo1NQK/d47+sXVN76or7l164rusNb7CBJ1Eycg18OSUeyjSZ5dRgrbuOTjAIhHkPRiDb3j7lwgoyIPoZ/Dp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726369107; c=relaxed/simple;
	bh=z+UqE0U/RSUElanrubdF3dIn6xXTrATxDHndfWc1KTA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MD1w0b6vfWNgBTsfUNtqVjPYuXoJ9rRbwJK1/B+ApyQxk4erjdwDGoaPS/5g0lePLJP5O1gCcRQAp3DgWY3zQXuHtcvHCSUqkT+NMInBMPrWKhwH+EN/VNZShWHqmFMZAd3T9TvZnu1RoFtG/Ngq/FBXDiMVJDfrhfKpz3k9IDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39f510b3f81so84563785ab.0
        for <linux-acpi@vger.kernel.org>; Sat, 14 Sep 2024 19:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726369105; x=1726973905;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hjLUsKGeoVoPKJ3al0/Nz3RmDdv0R6NiXx4KuJWRwHc=;
        b=DkFmQtppu1z/USKGbjoupbxQ+CMa9wC8x54bMLXJnN/6j1/hm+318m81P1O5vkZFUR
         Qz9kriNq5fwpfFeX02+oEiLFPFE8C8Gf0jxh7OYC8eJEn/JDTLqVO4lGw7rwfIXmQVYm
         B2CCHF/aa++B90QRCCQODTp5N0yJd3/1f6AC3GIebOXtWCkA+9vYvR7zK/ibNiegrpiY
         0yhUYxHfu+oaodHVfxkNIwDbZVtfBESkOmfPjUD9kAZB/d7esGtu/cfD1DsnVDJvP0NX
         kXmjgPEJQSw2D5UUEAi6/M8c/uQv6p64JYW/v31ODhLaGE4qwTyuEerG8WkbuqFEFcnC
         FGDA==
X-Forwarded-Encrypted: i=1; AJvYcCUnM3S9qivtTD6VVm6soSAYeJUj1FGqmr0xzheCHHhvaGVKUSo6ei6HNTWAO8JGusOVe4oX1CxawhlH@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg8vqMGbl+tyDe3YLNs34dhXx81SAh31D/XVKRr8rUcPJ/OeUd
	6ANOXxCr8pzHpRnEvL8xpEpR+dQXjBY3aDWxY+orB8bB1pZxvR1pe6MoIBSECt1m/nO/zA7fnUw
	tCInOROZX7rWtKR7gtHkOzQawL+eYKp9OtOIZ32yuZFA69wJs31MNxD0=
X-Google-Smtp-Source: AGHT+IESevztk4HmfitvDcTuYMhISYTTN0df7RIpThqtZPTssyZEyA3esCJB2Wm5A9txuzZtra60G1M7IJe02e6OwMyuB5UPqmPD
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:505:b0:3a0:9c04:8047 with SMTP id
 e9e14a558f8ab-3a09c048195mr14619655ab.6.1726369104872; Sat, 14 Sep 2024
 19:58:24 -0700 (PDT)
Date: Sat, 14 Sep 2024 19:58:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003f5a0c06221fa127@google.com>
Subject: [syzbot] [acpi?] [nvdimm?] WARNING in to_nfit_bus_uuid
From: syzbot <syzbot+c80d8dc0d9fa81a3cd8c@syzkaller.appspotmail.com>
To: dan.j.williams@intel.com, dave.jiang@intel.com, ira.weiny@intel.com, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, rafael@kernel.org, syzkaller-bugs@googlegroups.com, 
	vishal.l.verma@intel.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8d8d276ba2fb Merge tag 'trace-v6.11-rc6' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17987f29980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61d235cb8d15001c
dashboard link: https://syzkaller.appspot.com/bug?extid=c80d8dc0d9fa81a3cd8c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10be6797980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13386100580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-8d8d276b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d23708af23a4/vmlinux-8d8d276b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1aed2837c105/bzImage-8d8d276b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c80d8dc0d9fa81a3cd8c@syzkaller.appspotmail.com

------------[ cut here ]------------
only secondary bus families can be translated
WARNING: CPU: 0 PID: 15821 at drivers/acpi/nfit/core.c:80 to_nfit_bus_uuid+0x6f/0x90 drivers/acpi/nfit/core.c:79
Modules linked in:
CPU: 0 UID: 0 PID: 15821 Comm: syz-executor579 Not tainted 6.11.0-rc7-syzkaller-00020-g8d8d276ba2fb #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:to_nfit_bus_uuid+0x6f/0x90 drivers/acpi/nfit/core.c:79
Code: 01 75 0d e8 23 74 76 fc 31 c0 5b c3 cc cc cc cc e8 16 74 76 fc c6 05 4d 34 e5 0a 01 90 48 c7 c7 40 92 6a 8c e8 32 98 38 fc 90 <0f> 0b 90 90 eb d8 e8 f6 73 76 fc 48 c7 c7 40 9d 0e 8f 48 89 de e8
RSP: 0018:ffffc9000b6cfa90 EFLAGS: 00010246
RAX: 48f74db0fdd0b300 RBX: 0000000000000000 RCX: ffff88801e0e8000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000b6cfc90 R08: ffffffff8155b372 R09: 1ffff11003fc519a
R10: dffffc0000000000 R11: ffffed1003fc519b R12: ffff88801df22000
R13: 000000000000000a R14: ffffc9000b6cfc20 R15: 1ffff920016d9f6c
FS:  00007fb39f5416c0(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb39f546d30 CR3: 00000000377e2000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 acpi_nfit_ctl+0x8a9/0x24a0 drivers/acpi/nfit/core.c:489
 __nd_ioctl drivers/nvdimm/bus.c:1186 [inline]
 nd_ioctl+0x184d/0x1fe0 drivers/nvdimm/bus.c:1264
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb39f590b29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1d 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb39f541228 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fb39f590b29
RDX: 0000000020000180 RSI: 00000000c008640a RDI: 0000000000000003
RBP: 00007fb39f6143c8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb39f6143c0
R13: 63646e2f7665642f R14: 00007ffd8b32c140 R15: 00007ffd8b32c228
 </TASK>


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

