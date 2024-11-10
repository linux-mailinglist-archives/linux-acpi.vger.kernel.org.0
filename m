Return-Path: <linux-acpi+bounces-9485-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDA79C319F
	for <lists+linux-acpi@lfdr.de>; Sun, 10 Nov 2024 11:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1C2E1C209FF
	for <lists+linux-acpi@lfdr.de>; Sun, 10 Nov 2024 10:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54EC153824;
	Sun, 10 Nov 2024 10:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zap9Kb7f"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3EC142E7C;
	Sun, 10 Nov 2024 10:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731234939; cv=none; b=FIHS4wz7JZvF+2B5ArKPNLjqktHAQ179Scux0NjjePX6PcjBFb5t4fpziKcGwcD5ncKR9T8R2ze88zhNaGqbekDtGAIBBfJymkn5B3j0TGKzfe3Azg4gSgNJSCuQLCT24hlpC0nrqYl+E/coA594X3n3MUq6rGkZC8csg6hFTik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731234939; c=relaxed/simple;
	bh=5RvKLYrbKsZe2EL8I/yb+t8s4aX0EBY95WoLCYD8jzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=az5lml/VpgwhQ2itj03+txVBsCw+uZX8UUPVUwF3J4dWQXB6w2i5FMTrFhP6z82BQYqNOO4GIDhfpGIgW7j+Leg8TN5B/q3sx0OHhIf5CoZ8GCUow7hWkgplw3Q+qx6R4mO4V8+XF28jIy6M16Kj8ejCwG8B2cSCXPdZARz4GVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zap9Kb7f; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5ceb75f9631so4427412a12.0;
        Sun, 10 Nov 2024 02:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731234935; x=1731839735; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Av7jnK0Ej2OmTh/tA+7uPgduwhLiXyzD8zCnjvzcN1U=;
        b=Zap9Kb7fRXujTtlcIqL08kMl1CLLDTGTHq3zdeTktYgnJw1bGwpF6CIlzwkUPyFHO4
         ++5fHXv01vXhV1kLgfirWZcQVK9+2gB3M5uq1TEHvL+TdNw0+u6eqwCc0R0qGOQmS69C
         EUNJ6R/ZiPmOWjXIFYq+bzEfpoKGZ5bk/LDx0twBMls5vZN+vMmSAF9FxF6MnchxC1ee
         wqlyQAXlbKZK3LYbs9S2bJJGJ0EQ+IwY+oZyYD+ZG8XMS7Fjk8GiGxIAvWo1D5NjVYyd
         QZpHQMgzRO0p0hHznV6kxIllbyI0gS50O2NIQCN/pDdlG7Jzq9VOvZXatmAdp3MwcpTL
         z8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731234935; x=1731839735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Av7jnK0Ej2OmTh/tA+7uPgduwhLiXyzD8zCnjvzcN1U=;
        b=DxM+JX5XTmIv29Wy/OBuW7n8PuCPeNtL4rUdNFZ9q90hFB3ETB/K8zOAMcszlZgk0u
         FNQvPK83iNut4HyQmQUns19GU/2EfN949rzbgnmWgzmynMcMIlQDafDJsBp/z/xtKfs9
         4Er9vwX8kt0buF4529taEEKoOju94TjhGowma/OVpK6VQ2tz6JBpokjDr88wDIEb8Fol
         k2f98DikJi7QYqgKFUzNMiPZZxJ8giVt5yglpM3Fc+27JEuNWNNeYvLlNONKRFAStN5Y
         ZfE0Rz0yIFfZD5kqPxjeUOXYhkwx6zQ9Jm4/bUH9JJl1VqqpI967won5KGtqZ7HFCktT
         H/ww==
X-Forwarded-Encrypted: i=1; AJvYcCU6mODpdP3E/KJv9W59HYJaba1279rkarbBeurRUXT2GoO8eICAu+fK9QtwdBp6YCXReGankKRArwN0tM8z@vger.kernel.org, AJvYcCVbJZfrpPsOo01dqGugUd5IYtBcUoG3uJEDD0gJerQfpfB6KUg6i0TlUVjHLQdPG32uCrk2HmeY3Dvm@vger.kernel.org
X-Gm-Message-State: AOJu0YynEJ04ql6BCpaiBlJ3ue8iHjRC3akrMlIAVPVrdn89vLhQBtSo
	/dcj4koBEXeGKnti58aczKF83FNRfsJGfhqpc8DcZv5FpnjEJVEi3Bb5H0pI1avLdlrpL63NUlg
	4X3/ewlHWttSI3h5IOc5uNrJxGwo=
X-Google-Smtp-Source: AGHT+IEWVuCLtyK8A/FwP0CuMKwPWyntbKyq9v9Ya3ifeaTgsYSwZquQxvHMXLhqNsiuBICkI3MA7xLEx8IkvpRUOn4=
X-Received: by 2002:a17:907:3d90:b0:a86:8e3d:86e2 with SMTP id
 a640c23a62f3a-a9eefebd4b5mr898725966b.11.1731234934133; Sun, 10 Nov 2024
 02:35:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <672a3997.050a0220.2a847.11f7.GAE@google.com>
In-Reply-To: <672a3997.050a0220.2a847.11f7.GAE@google.com>
From: Suraj Sonawane <surajsonawane0215@gmail.com>
Date: Sun, 10 Nov 2024 16:04:56 +0530
Message-ID: <CAHiZj8ieKPXqLKx4oO6Vhb0QPU+8hF9B-gaQ=Xinawrqv86==w@mail.gmail.com>
Subject: Re: [syzbot] [acpi?] [nvdimm?] KASAN: vmalloc-out-of-bounds Read in
 acpi_nfit_ctl (2)
To: syzbot <syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com>
Cc: dan.j.williams@intel.com, dave.jiang@intel.com, ira.weiny@intel.com, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, rafael@kernel.org, syzkaller-bugs@googlegroups.com, 
	vishal.l.verma@intel.com
Content-Type: multipart/mixed; boundary="00000000000045d9cc06268c8ba3"

--00000000000045d9cc06268c8ba3
Content-Type: multipart/alternative; boundary="00000000000045d9ca06268c8ba1"

--00000000000045d9ca06268c8ba1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Tue, Nov 5, 2024 at 8:58=E2=80=AFPM syzbot <
syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com> wrote:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    2e1b3cc9d7f7 Merge tag 'arm-fixes-6.12-2' of
> git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D12418e3058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D11254d3590b16=
717
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=3D7534f060ebda6b8b51b3
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for
> Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12170f40580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16418e3058000=
0
>
> Downloadable assets:
> disk image (non-bootable):
> https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_di=
sk-2e1b3cc9.raw.xz
> vmlinux:
> https://storage.googleapis.com/syzbot-assets/2f2588b04ae9/vmlinux-2e1b3cc=
9.xz
> kernel image:
> https://storage.googleapis.com/syzbot-assets/2c9324cf16df/bzImage-2e1b3cc=
9.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the
> commit:
> Reported-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: vmalloc-out-of-bounds in cmd_to_func
> drivers/acpi/nfit/core.c:416 [inline]
> BUG: KASAN: vmalloc-out-of-bounds in acpi_nfit_ctl+0x20e8/0x24a0
> drivers/acpi/nfit/core.c:459
> Read of size 4 at addr ffffc90000e0e038 by task syz-executor229/5316
>
> CPU: 0 UID: 0 PID: 5316 Comm: syz-executor229 Not tainted
> 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  cmd_to_func drivers/acpi/nfit/core.c:416 [inline]
>  acpi_nfit_ctl+0x20e8/0x24a0 drivers/acpi/nfit/core.c:459
>  __nd_ioctl drivers/nvdimm/bus.c:1186 [inline]
>  nd_ioctl+0x1844/0x1fd0 drivers/nvdimm/bus.c:1264
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fb399ccda79
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f=
7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffcf6cb8d88 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb399ccda79
> RDX: 0000000020000180 RSI: 00000000c008640a RDI: 0000000000000003
> RBP: 00007fb399d405f0 R08: 0000000000000006 R09: 0000000000000006
> R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000000001
> R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
>
> The buggy address belongs to the virtual mapping at
>  [ffffc90000e0e000, ffffc90000e10000) created by:
>  __nd_ioctl drivers/nvdimm/bus.c:1169 [inline]
>  nd_ioctl+0x1594/0x1fd0 drivers/nvdimm/bus.c:1264
>
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000
> index:0xffff8880401b9a80 pfn:0x401b9
> flags: 0x4fff00000000000(node=3D1|zone=3D1|lastcpupid=3D0x7ff)
> raw: 04fff00000000000 0000000000000000 dead000000000122 0000000000000000
> raw: ffff8880401b9a80 0000000000000000 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask
> 0x2cc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN), pid 5316, tgid 5316
> (syz-executor229), ts 69039468240, free_ts 68666765389
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
>  prep_new_page mm/page_alloc.c:1545 [inline]
>  get_page_from_freelist+0x303f/0x3190 mm/page_alloc.c:3457
>  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
>  alloc_pages_bulk_noprof+0x729/0xd40 mm/page_alloc.c:4681
>  alloc_pages_bulk_array_mempolicy_noprof+0x8ea/0x1600 mm/mempolicy.c:2556
>  vm_area_alloc_pages mm/vmalloc.c:3542 [inline]
>  __vmalloc_area_node mm/vmalloc.c:3646 [inline]
>  __vmalloc_node_range_noprof+0x752/0x13f0 mm/vmalloc.c:3828
>  __vmalloc_node_noprof mm/vmalloc.c:3893 [inline]
>  vmalloc_noprof+0x79/0x90 mm/vmalloc.c:3926
>  __nd_ioctl drivers/nvdimm/bus.c:1169 [inline]
>  nd_ioctl+0x1594/0x1fd0 drivers/nvdimm/bus.c:1264
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> page last free pid 5312 tgid 5312 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1108 [inline]
>  free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
>  __folio_put+0x2c7/0x440 mm/swap.c:126
>  pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
>  pipe_update_tail fs/pipe.c:224 [inline]
>  pipe_read+0x6ed/0x13e0 fs/pipe.c:344
>  new_sync_read fs/read_write.c:488 [inline]
>  vfs_read+0x991/0xb70 fs/read_write.c:569
>  ksys_read+0x183/0x2b0 fs/read_write.c:712
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Memory state around the buggy address:
>  ffffc90000e0df00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>  ffffc90000e0df80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> >ffffc90000e0e000: 00 00 00 00 00 00 00 03 f8 f8 f8 f8 f8 f8 f8 f8
>                                         ^
>  ffffc90000e0e080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>  ffffc90000e0e100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion visit
> https://groups.google.com/d/msgid/syzkaller-bugs/672a3997.050a0220.2a847.=
11f7.GAE%40google.com
> .
>

--00000000000045d9ca06268c8ba1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">#syz test<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Nov 5, 2024 at 8:58=E2=80=AFPM syzbot=
 &lt;<a href=3D"mailto:syzbot%2B7534f060ebda6b8b51b3@syzkaller.appspotmail.=
com">syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hello,<br>
<br>
syzbot found the following issue on:<br>
<br>
HEAD commit:=C2=A0 =C2=A0 2e1b3cc9d7f7 Merge tag &#39;arm-fixes-6.12-2&#39;=
 of git://git.ker..<br>
git tree:=C2=A0 =C2=A0 =C2=A0 =C2=A0upstream<br>
console output: <a href=3D"https://syzkaller.appspot.com/x/log.txt?x=3D1241=
8e30580000" rel=3D"noreferrer" target=3D"_blank">https://syzkaller.appspot.=
com/x/log.txt?x=3D12418e30580000</a><br>
kernel config:=C2=A0 <a href=3D"https://syzkaller.appspot.com/x/.config?x=
=3D11254d3590b16717" rel=3D"noreferrer" target=3D"_blank">https://syzkaller=
.appspot.com/x/.config?x=3D11254d3590b16717</a><br>
dashboard link: <a href=3D"https://syzkaller.appspot.com/bug?extid=3D7534f0=
60ebda6b8b51b3" rel=3D"noreferrer" target=3D"_blank">https://syzkaller.apps=
pot.com/bug?extid=3D7534f060ebda6b8b51b3</a><br>
compiler:=C2=A0 =C2=A0 =C2=A0 =C2=A0Debian clang version 15.0.6, GNU ld (GN=
U Binutils for Debian) 2.40<br>
syz repro:=C2=A0 =C2=A0 =C2=A0 <a href=3D"https://syzkaller.appspot.com/x/r=
epro.syz?x=3D12170f40580000" rel=3D"noreferrer" target=3D"_blank">https://s=
yzkaller.appspot.com/x/repro.syz?x=3D12170f40580000</a><br>
C reproducer:=C2=A0 =C2=A0<a href=3D"https://syzkaller.appspot.com/x/repro.=
c?x=3D16418e30580000" rel=3D"noreferrer" target=3D"_blank">https://syzkalle=
r.appspot.com/x/repro.c?x=3D16418e30580000</a><br>
<br>
Downloadable assets:<br>
disk image (non-bootable): <a href=3D"https://storage.googleapis.com/syzbot=
-assets/7feb34a89c2a/non_bootable_disk-2e1b3cc9.raw.xz" rel=3D"noreferrer" =
target=3D"_blank">https://storage.googleapis.com/syzbot-assets/7feb34a89c2a=
/non_bootable_disk-2e1b3cc9.raw.xz</a><br>
vmlinux: <a href=3D"https://storage.googleapis.com/syzbot-assets/2f2588b04a=
e9/vmlinux-2e1b3cc9.xz" rel=3D"noreferrer" target=3D"_blank">https://storag=
e.googleapis.com/syzbot-assets/2f2588b04ae9/vmlinux-2e1b3cc9.xz</a><br>
kernel image: <a href=3D"https://storage.googleapis.com/syzbot-assets/2c932=
4cf16df/bzImage-2e1b3cc9.xz" rel=3D"noreferrer" target=3D"_blank">https://s=
torage.googleapis.com/syzbot-assets/2c9324cf16df/bzImage-2e1b3cc9.xz</a><br=
>
<br>
IMPORTANT: if you fix the issue, please add the following tag to the commit=
:<br>
Reported-by: <a href=3D"mailto:syzbot%2B7534f060ebda6b8b51b3@syzkaller.apps=
potmail.com" target=3D"_blank">syzbot+7534f060ebda6b8b51b3@syzkaller.appspo=
tmail.com</a><br>
<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
BUG: KASAN: vmalloc-out-of-bounds in cmd_to_func drivers/acpi/nfit/core.c:4=
16 [inline]<br>
BUG: KASAN: vmalloc-out-of-bounds in acpi_nfit_ctl+0x20e8/0x24a0 drivers/ac=
pi/nfit/core.c:459<br>
Read of size 4 at addr ffffc90000e0e038 by task syz-executor229/5316<br>
<br>
CPU: 0 UID: 0 PID: 5316 Comm: syz-executor229 Not tainted 6.12.0-rc6-syzkal=
ler-00077-g2e1b3cc9d7f7 #0<br>
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16=
.3-2~bpo12+1 04/01/2014<br>
Call Trace:<br>
=C2=A0&lt;TASK&gt;<br>
=C2=A0__dump_stack lib/dump_stack.c:94 [inline]<br>
=C2=A0dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120<br>
=C2=A0print_address_description mm/kasan/report.c:377 [inline]<br>
=C2=A0print_report+0x169/0x550 mm/kasan/report.c:488<br>
=C2=A0kasan_report+0x143/0x180 mm/kasan/report.c:601<br>
=C2=A0cmd_to_func drivers/acpi/nfit/core.c:416 [inline]<br>
=C2=A0acpi_nfit_ctl+0x20e8/0x24a0 drivers/acpi/nfit/core.c:459<br>
=C2=A0__nd_ioctl drivers/nvdimm/bus.c:1186 [inline]<br>
=C2=A0nd_ioctl+0x1844/0x1fd0 drivers/nvdimm/bus.c:1264<br>
=C2=A0vfs_ioctl fs/ioctl.c:51 [inline]<br>
=C2=A0__do_sys_ioctl fs/ioctl.c:907 [inline]<br>
=C2=A0__se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893<br>
=C2=A0do_syscall_x64 arch/x86/entry/common.c:52 [inline]<br>
=C2=A0do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83<br>
=C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f<br>
RIP: 0033:0x7fb399ccda79<br>
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 &lt;48&gt; 3d 01 f=
0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48<br>
RSP: 002b:00007ffcf6cb8d88 EFLAGS: 00000246 ORIG_RAX: 0000000000000010<br>
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb399ccda79<br>
RDX: 0000000020000180 RSI: 00000000c008640a RDI: 0000000000000003<br>
RBP: 00007fb399d405f0 R08: 0000000000000006 R09: 0000000000000006<br>
R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000000001<br>
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001<br>
=C2=A0&lt;/TASK&gt;<br>
<br>
The buggy address belongs to the virtual mapping at<br>
=C2=A0[ffffc90000e0e000, ffffc90000e10000) created by:<br>
=C2=A0__nd_ioctl drivers/nvdimm/bus.c:1169 [inline]<br>
=C2=A0nd_ioctl+0x1594/0x1fd0 drivers/nvdimm/bus.c:1264<br>
<br>
The buggy address belongs to the physical page:<br>
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880401b9a=
80 pfn:0x401b9<br>
flags: 0x4fff00000000000(node=3D1|zone=3D1|lastcpupid=3D0x7ff)<br>
raw: 04fff00000000000 0000000000000000 dead000000000122 0000000000000000<br=
>
raw: ffff8880401b9a80 0000000000000000 00000001ffffffff 0000000000000000<br=
>
page dumped because: kasan: bad access detected<br>
page_owner tracks the page as allocated<br>
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2cc2(GFP=
_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN), pid 5316, tgid 5316 (syz-executor229),=
 ts 69039468240, free_ts 68666765389<br>
=C2=A0set_page_owner include/linux/page_owner.h:32 [inline]<br>
=C2=A0post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537<br>
=C2=A0prep_new_page mm/page_alloc.c:1545 [inline]<br>
=C2=A0get_page_from_freelist+0x303f/0x3190 mm/page_alloc.c:3457<br>
=C2=A0__alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733<br>
=C2=A0alloc_pages_bulk_noprof+0x729/0xd40 mm/page_alloc.c:4681<br>
=C2=A0alloc_pages_bulk_array_mempolicy_noprof+0x8ea/0x1600 mm/mempolicy.c:2=
556<br>
=C2=A0vm_area_alloc_pages mm/vmalloc.c:3542 [inline]<br>
=C2=A0__vmalloc_area_node mm/vmalloc.c:3646 [inline]<br>
=C2=A0__vmalloc_node_range_noprof+0x752/0x13f0 mm/vmalloc.c:3828<br>
=C2=A0__vmalloc_node_noprof mm/vmalloc.c:3893 [inline]<br>
=C2=A0vmalloc_noprof+0x79/0x90 mm/vmalloc.c:3926<br>
=C2=A0__nd_ioctl drivers/nvdimm/bus.c:1169 [inline]<br>
=C2=A0nd_ioctl+0x1594/0x1fd0 drivers/nvdimm/bus.c:1264<br>
=C2=A0vfs_ioctl fs/ioctl.c:51 [inline]<br>
=C2=A0__do_sys_ioctl fs/ioctl.c:907 [inline]<br>
=C2=A0__se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893<br>
=C2=A0do_syscall_x64 arch/x86/entry/common.c:52 [inline]<br>
=C2=A0do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83<br>
=C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f<br>
page last free pid 5312 tgid 5312 stack trace:<br>
=C2=A0reset_page_owner include/linux/page_owner.h:25 [inline]<br>
=C2=A0free_pages_prepare mm/page_alloc.c:1108 [inline]<br>
=C2=A0free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638<br>
=C2=A0__folio_put+0x2c7/0x440 mm/swap.c:126<br>
=C2=A0pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]<br>
=C2=A0pipe_update_tail fs/pipe.c:224 [inline]<br>
=C2=A0pipe_read+0x6ed/0x13e0 fs/pipe.c:344<br>
=C2=A0new_sync_read fs/read_write.c:488 [inline]<br>
=C2=A0vfs_read+0x991/0xb70 fs/read_write.c:569<br>
=C2=A0ksys_read+0x183/0x2b0 fs/read_write.c:712<br>
=C2=A0do_syscall_x64 arch/x86/entry/common.c:52 [inline]<br>
=C2=A0do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83<br>
=C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f<br>
<br>
Memory state around the buggy address:<br>
=C2=A0ffffc90000e0df00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8<br>
=C2=A0ffffc90000e0df80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8<br>
&gt;ffffc90000e0e000: 00 00 00 00 00 00 00 03 f8 f8 f8 f8 f8 f8 f8 f8<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>
=C2=A0ffffc90000e0e080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8<br>
=C2=A0ffffc90000e0e100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
<br>
---<br>
This report is generated by a bot. It may contain errors.<br>
See <a href=3D"https://goo.gl/tpsmEJ" rel=3D"noreferrer" target=3D"_blank">=
https://goo.gl/tpsmEJ</a> for more information about syzbot.<br>
syzbot engineers can be reached at <a href=3D"mailto:syzkaller@googlegroups=
.com" target=3D"_blank">syzkaller@googlegroups.com</a>.<br>
<br>
syzbot will keep track of this issue. See:<br>
<a href=3D"https://goo.gl/tpsmEJ#status" rel=3D"noreferrer" target=3D"_blan=
k">https://goo.gl/tpsmEJ#status</a> for how to communicate with syzbot.<br>
<br>
If the report is already addressed, let syzbot know by replying with:<br>
#syz fix: exact-commit-title<br>
<br>
If you want syzbot to run the reproducer, reply with:<br>
#syz test: git://repo/address.git branch-or-commit-hash<br>
If you attach or paste a git patch, syzbot will apply it before testing.<br=
>
<br>
If you want to overwrite report&#39;s subsystems, reply with:<br>
#syz set subsystems: new-subsystem<br>
(See the list of subsystem names on the web dashboard)<br>
<br>
If the report is a duplicate of another one, reply with:<br>
#syz dup: exact-subject-of-another-report<br>
<br>
If you want to undo deduplication, reply with:<br>
#syz undup<br>
<br>
-- <br>
You received this message because you are subscribed to the Google Groups &=
quot;syzkaller-bugs&quot; group.<br>
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:syzkaller-bugs%2Bunsubscribe@googlegroups.com" ta=
rget=3D"_blank">syzkaller-bugs+unsubscribe@googlegroups.com</a>.<br>
To view this discussion visit <a href=3D"https://groups.google.com/d/msgid/=
syzkaller-bugs/672a3997.050a0220.2a847.11f7.GAE%40google.com" rel=3D"norefe=
rrer" target=3D"_blank">https://groups.google.com/d/msgid/syzkaller-bugs/67=
2a3997.050a0220.2a847.11f7.GAE%40google.com</a>.<br>
</blockquote></div>

--00000000000045d9ca06268c8ba1--
--00000000000045d9cc06268c8ba3
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-v3KASAN-vmalloc-out-of-bounds-Read-in-acpi_nfit_ctl-.patch"
Content-Disposition: attachment; 
	filename="0001-v3KASAN-vmalloc-out-of-bounds-Read-in-acpi_nfit_ctl-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m3bgjv640>
X-Attachment-Id: f_m3bgjv640

RnJvbSA0NDNiNWMzNjY2OTQ2NTBmOWM3NzE4NjM1NTY0MzMyNzBmZmY4YmMyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdXJhaiBTb25hd2FuZSA8c3VyYWpzb25hd2FuZTAyMTVAZ21h
aWwuY29tPgpEYXRlOiBTdW4sIDEwIE5vdiAyMDI0IDE2OjAxOjI0ICswNTMwClN1YmplY3Q6IFtQ
QVRDSCB2M10gS0FTQU46IHZtYWxsb2Mtb3V0LW9mLWJvdW5kcyBSZWFkIGluIGFjcGlfbmZpdF9j
dGwgKDIpCgpzeXogdGVzdAoKU2lnbmVkLW9mZi1ieTogU3VyYWogU29uYXdhbmUgPHN1cmFqc29u
YXdhbmUwMjE1QGdtYWlsLmNvbT4KLS0tCiBkcml2ZXJzL2FjcGkvbmZpdC9jb3JlLmMgfCA5ICsr
KysrKystLQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvbmZpdC9jb3JlLmMgYi9kcml2ZXJzL2FjcGkvbmZp
dC9jb3JlLmMKaW5kZXggNTQyOWVjOWVmLi40YTI5OTdiNjAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
YWNwaS9uZml0L2NvcmUuYworKysgYi9kcml2ZXJzL2FjcGkvbmZpdC9jb3JlLmMKQEAgLTQ1NCw4
ICs0NTQsMTMgQEAgaW50IGFjcGlfbmZpdF9jdGwoc3RydWN0IG52ZGltbV9idXNfZGVzY3JpcHRv
ciAqbmRfZGVzYywgc3RydWN0IG52ZGltbSAqbnZkaW1tLAogCWlmIChjbWRfcmMpCiAJCSpjbWRf
cmMgPSAtRUlOVkFMOwogCi0JaWYgKGNtZCA9PSBORF9DTURfQ0FMTCkKLQkJY2FsbF9wa2cgPSBi
dWY7CisJaWYgKGNtZCA9PSBORF9DTURfQ0FMTCkgeworCQlpZiAoYnVmID09IE5VTEwgfHwgYnVm
X2xlbiA8IHNpemVvZihzdHJ1Y3QgbmRfY21kX3BrZykpIHsKKwkJCXJjID0gLUVJTlZBTDsKKwkJ
CWdvdG8gb3V0OworCQl9CisJCWNhbGxfcGtnID0gKHN0cnVjdCBuZF9jbWRfcGtnICopYnVmOwor
CX0KIAlmdW5jID0gY21kX3RvX2Z1bmMobmZpdF9tZW0sIGNtZCwgY2FsbF9wa2csICZmYW1pbHkp
OwogCWlmIChmdW5jIDwgMCkKIAkJcmV0dXJuIGZ1bmM7Ci0tIAoyLjM0LjEKCg==
--00000000000045d9cc06268c8ba3--

