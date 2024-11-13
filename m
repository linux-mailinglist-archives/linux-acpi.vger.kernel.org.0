Return-Path: <linux-acpi+bounces-9544-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A163D9C6EBB
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 13:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3104A1F273E1
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 12:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F02200C99;
	Wed, 13 Nov 2024 12:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuxXu/PV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF2120013C;
	Wed, 13 Nov 2024 12:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499664; cv=none; b=uqZyhyLRvSdGNRw31nQBSz8bvSRHC6FxdUr2aktwWWTzd3jc1ZKJA+CxrENqGbh9HLHtrG4hxqtnEhOszvCCzu4LCM50QNopcW15l0z9p9+0jFM7bIFWtwWcdXZJONBAA485ocPE+hRh5kC9LgfGM2hbp49TtJ5X4CNFaycLKJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499664; c=relaxed/simple;
	bh=jwByywtL23ZBaJNTAWV9MtGK38HVA0m1kmp4oEx77Vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gj/HWzzdjXU68MhHvO1RABkmsLltihK0VmaNlgsqOFhLMVpA8bwsd2KREYWSJWRnK9uPf5WXm3agz5kChXs7gAjQL1QDDpwrCCxq7qCkxWZWRu1arq9EnWn1zRsSUk4jx4BAIidZy5w3Med/y1WL7LE5b1rAWYz28T4jjm9Pnwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CuxXu/PV; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cef772621eso8360156a12.3;
        Wed, 13 Nov 2024 04:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731499661; x=1732104461; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yepkduG988DyArhMPl7KeG6VvQ8oAXjW6ukIHwOZYf8=;
        b=CuxXu/PVfVT5GFRjeCsfHJE5ODcq+3crFIzXT89PNLt55+AclZA/so76j7zMzmswbP
         iT2s3wbidAMX5heSqiR5rhM/wj+a7bfgNyXkTH0rwQj2vQuTeXHSBYOaWo9uroOYv2Nd
         tKNN+/OOZl94CwvNQTc3q+/jjncZOu12fLnt7mFhHIVsygNVdo5x9M/Mpl0wjVzXvJxM
         al55R2XolOdP4trpQZrAwAFiQhqHDFD6o2U2BlQWgwvE0Q1IKMz5PkRYpcxrzy/F2uAM
         0hRenLUaTf1+MorYFweVW+u7Gea2kL2vEXigSiIavXLGT1bcfjpEhYDSqnSaZ9CPuMYO
         mqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731499661; x=1732104461;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yepkduG988DyArhMPl7KeG6VvQ8oAXjW6ukIHwOZYf8=;
        b=HwaZXATlXW2XVN2PWtwrLOiE4JD8CuKKQyCsg20tT0koke/LRW+U/AofjKHH/ww3bQ
         Tvg754o919oTgtx+czfONG0K9MvaRY3m9ydyN/xT+ldykOIzfv8tv0jsh8Mqw5vPxbSy
         iqdjZe63xLG3dwbARB0Emf9ZsnoLDANLxxkPsBhsWGHDU/ZPDew9c5cIA4Bnk1JfYAH8
         QJfzDe5P/Nt/dTk8L3nNUvvx9hTcmJNcLvIm36PJvEVOr9VP0oAbdGKqjxFxkbnzFqfM
         45/HfCOtT9aj6La6dDh68bIQWPMy2ChvbT3tVt024sNx16PApGJRb8Zi4CFn1GAsJZRd
         cDzA==
X-Forwarded-Encrypted: i=1; AJvYcCWdnpbzxWZrh2Plj3ck3S1lCtTQDvuHb02b32bhO4FGqOeo6QY3fhA17VpBwmuYoM1sSH+y2GwvyN+nVmgs@vger.kernel.org, AJvYcCXoRCU+/MrXEHT2AIoEwOXWypF5a5EZC0zlUuHeVGCvbKFpn7vtZuywyZ7yjxNgs6eYitMu8onAVA1N@vger.kernel.org
X-Gm-Message-State: AOJu0YxMKYuukRz50rTCjBscmEIPMTAKrVr+UncnijqQBiUYlOpn8gXP
	3hvy3GYCsnIiwi4lmNrxVL6C722nDzfude25dbKhBJm+zYA3LGCxdyyzMiZkh6Y+sKBCyo4VH28
	JVhPW+tKob4Vk0ap5oDNnDFDURPc=
X-Google-Smtp-Source: AGHT+IGb/CpkitQYjOqwg+rHTeEyy9n2hByFcpxrr/0MZejT/kmgjubKa8ElRE7ERKKc2xTQPN01UtVSGbRSVxUc2f4=
X-Received: by 2002:a17:907:9344:b0:a9e:b0a6:6e13 with SMTP id
 a640c23a62f3a-aa1f807a38dmr241821866b.30.1731499660442; Wed, 13 Nov 2024
 04:07:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <672a3997.050a0220.2a847.11f7.GAE@google.com>
In-Reply-To: <672a3997.050a0220.2a847.11f7.GAE@google.com>
From: Suraj Sonawane <surajsonawane0215@gmail.com>
Date: Wed, 13 Nov 2024 17:37:03 +0530
Message-ID: <CAHiZj8j+=3paytYbPMDqof6cVYxSFjjaev1PTc0EUsNz8hXExg@mail.gmail.com>
Subject: Re: [syzbot] [acpi?] [nvdimm?] KASAN: vmalloc-out-of-bounds Read in
 acpi_nfit_ctl (2)
To: syzbot <syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com>
Cc: dan.j.williams@intel.com, dave.jiang@intel.com, ira.weiny@intel.com, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, rafael@kernel.org, syzkaller-bugs@googlegroups.com, 
	vishal.l.verma@intel.com
Content-Type: multipart/mixed; boundary="00000000000030a1570626ca2e46"

--00000000000030a1570626ca2e46
Content-Type: multipart/alternative; boundary="00000000000030a1560626ca2e44"

--00000000000030a1560626ca2e44
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

--00000000000030a1560626ca2e44
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

--00000000000030a1560626ca2e44--
--00000000000030a1570626ca2e46
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-PATCH-v4-KASAN-vmalloc-out-of-bounds-Read-in-acpi_nf.patch"
Content-Disposition: attachment; 
	filename="0001-PATCH-v4-KASAN-vmalloc-out-of-bounds-Read-in-acpi_nf.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m3fu60bz0>
X-Attachment-Id: f_m3fu60bz0

RnJvbSA2YzA5MTU1OGQ3NGIxOWRiZDE4ODhhZWQ5MzM4YjRkMGZkMzM5NmRhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdXJhaiBTb25hd2FuZSA8c3VyYWpzb25hd2FuZTAyMTVAZ21h
aWwuY29tPgpEYXRlOiBXZWQsIDEzIE5vdiAyMDI0IDE3OjM1OjMyICswNTMwClN1YmplY3Q6IFtQ
QVRDSF0gW1BBVENIIHY0XSBLQVNBTjogdm1hbGxvYy1vdXQtb2YtYm91bmRzIFJlYWQgaW4gYWNw
aV9uZml0X2N0bCgyKQoKc3l6IHRlc3QKClNpZ25lZC1vZmYtYnk6IFN1cmFqIFNvbmF3YW5lIDxz
dXJhanNvbmF3YW5lMDIxNUBnbWFpbC5jb20+Ci0tLQogZHJpdmVycy9hY3BpL25maXQvY29yZS5j
IHwgMTIgKysrKysrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9uZml0L2NvcmUuYyBiL2RyaXZl
cnMvYWNwaS9uZml0L2NvcmUuYwppbmRleCA1NDI5ZWM5ZWYuLmViNTM0OTYwNiAxMDA2NDQKLS0t
IGEvZHJpdmVycy9hY3BpL25maXQvY29yZS5jCisrKyBiL2RyaXZlcnMvYWNwaS9uZml0L2NvcmUu
YwpAQCAtNDM5LDcgKzQzOSw3IEBAIGludCBhY3BpX25maXRfY3RsKHN0cnVjdCBudmRpbW1fYnVz
X2Rlc2NyaXB0b3IgKm5kX2Rlc2MsIHN0cnVjdCBudmRpbW0gKm52ZGltbSwKIHsKIAlzdHJ1Y3Qg
YWNwaV9uZml0X2Rlc2MgKmFjcGlfZGVzYyA9IHRvX2FjcGlfZGVzYyhuZF9kZXNjKTsKIAlzdHJ1
Y3QgbmZpdF9tZW0gKm5maXRfbWVtID0gbnZkaW1tX3Byb3ZpZGVyX2RhdGEobnZkaW1tKTsKLQl1
bmlvbiBhY3BpX29iamVjdCBpbl9vYmosIGluX2J1ZiwgKm91dF9vYmo7CisJdW5pb24gYWNwaV9v
YmplY3QgaW5fb2JqLCBpbl9idWYsICpvdXRfb2JqID0gTlVMTDsKIAljb25zdCBzdHJ1Y3QgbmRf
Y21kX2Rlc2MgKmRlc2MgPSBOVUxMOwogCXN0cnVjdCBkZXZpY2UgKmRldiA9IGFjcGlfZGVzYy0+
ZGV2OwogCXN0cnVjdCBuZF9jbWRfcGtnICpjYWxsX3BrZyA9IE5VTEw7CkBAIC00NTQsOCArNDU0
LDE0IEBAIGludCBhY3BpX25maXRfY3RsKHN0cnVjdCBudmRpbW1fYnVzX2Rlc2NyaXB0b3IgKm5k
X2Rlc2MsIHN0cnVjdCBudmRpbW0gKm52ZGltbSwKIAlpZiAoY21kX3JjKQogCQkqY21kX3JjID0g
LUVJTlZBTDsKIAotCWlmIChjbWQgPT0gTkRfQ01EX0NBTEwpCi0JCWNhbGxfcGtnID0gYnVmOwor
CWlmIChjbWQgPT0gTkRfQ01EX0NBTEwpIHsKKwkJaWYgKCFidWYgfHwgYnVmX2xlbiA8IHNpemVv
ZigqY2FsbF9wa2cpKSB7CisJCQlyYyA9IC1FSU5WQUw7CisJCQlnb3RvIG91dDsKKwkJfQorCQlj
YWxsX3BrZyA9IChzdHJ1Y3QgbmRfY21kX3BrZyAqKWJ1ZjsKKwl9CisKIAlmdW5jID0gY21kX3Rv
X2Z1bmMobmZpdF9tZW0sIGNtZCwgY2FsbF9wa2csICZmYW1pbHkpOwogCWlmIChmdW5jIDwgMCkK
IAkJcmV0dXJuIGZ1bmM7Ci0tIAoyLjM0LjEKCg==
--00000000000030a1570626ca2e46--

