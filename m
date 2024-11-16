Return-Path: <linux-acpi+bounces-9611-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4B49CFDFB
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Nov 2024 11:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC3F283439
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Nov 2024 10:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A411957E2;
	Sat, 16 Nov 2024 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOQ3KqDv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B305D18BC2F;
	Sat, 16 Nov 2024 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731752314; cv=none; b=EnRfhD35D1jNRNadhKviL5b3XwbBepguYV+AythBJLe/izf/UCC/TP0/hyy1MDhXK5jBcHmAwJqSs+EzCUdkOWvzGl0KhKUlIC7FmE/luaE98ApurB4l3DPKt3oYybFsauodEQ4K/WNg3UjcUeq3bm0/6smSRZJjnNJAmIbZ+K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731752314; c=relaxed/simple;
	bh=dwfVVwk17x1uAJbWnEiUPGxkVz8JIp2SQSuLqBNj+mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BN2TjH861yJ/M0TL7C6lLf2uzVByjVcYV4Us7sjX810rnptETgDX/ofbMbM14AwyVZ2ow/j8NfxGuYCOvXIuFRsEy1DC8DvEOA8YvRY/nTEQZ1uzsAaY3nhp12Ty2rTtxoUzobfIqT5I5Y6qNb4b64NQzDnC7ItbEzE3PFFg6Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOQ3KqDv; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5ced377447bso3609767a12.1;
        Sat, 16 Nov 2024 02:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731752310; x=1732357110; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zEkEih+nSzBAoiRnyKrbpjbEfYSk7IWodG+8uebKiV0=;
        b=jOQ3KqDvrzBIWWnBetp+ilyfY3G3wI+c8cDDXEmS3Nsoln8AcK88Kh2cuhX9h2hk7B
         z5ool39h1xMhaPfcKlFPKo/DPK3L3C+0G1OCYwgYwwBxXIaX4lTFtUgQyiWt9iyIQnBU
         Sify/+pnht+s/c5F4Bc8NDtm3bYZ1l2g5DnpTaKbkgxx3pACLDYOwCXyNudkoza/HM7E
         PviPxDI78T6wBD4i1grVrnClKL3fP4q+mlL0jqY2UFJKLfXZybSssmOSudoV0VQmP0G/
         s+8W9KH3tvg02PHXoQM7x1IRpEo35qqiM5UeI2ZUZQfuWk7vBMO7zAHlScOahUKFPjcn
         e/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731752310; x=1732357110;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zEkEih+nSzBAoiRnyKrbpjbEfYSk7IWodG+8uebKiV0=;
        b=BDacq7xW1fbR3hQeU0KiCWX5httLIR1NupL38euL3qmHAAlj1BB6KU+Vhboi2RensW
         +ICUfAVnNe+Xl5v/oOQxMtkzZ+ZRQsFIt7K4tLiKpsTIqMZShcqtTjshA7fVUpWq7DnI
         kHZJYfR31Twfx8+dFyiekcuP8/NGsoCEsm9q9j4I1dvf+CuhxE7ERvFAdeRvMSDo/orh
         Rjcr92t0HhU3210zNI18rN0eRX5I/V9GXCslx5a58ArAjozoxMBeLUFMpnCIiB6BKv9L
         2ZuXX1EEPBfzP5Z/GPz2+Hx0lpBVI+W9MWjAF8iikerG7Gn1hGnh11YLguuOs8QaqUoD
         ORrw==
X-Forwarded-Encrypted: i=1; AJvYcCWGEsKX1lBSYkGHxTHHw3VxH3JdhbghlBhTmgAHy8z4v2rywKp/GvnYUixI0wuzHMI6zqSw8kP6Qe6n@vger.kernel.org, AJvYcCXmM/fapkdWpf6jAmYPnLB0NTCPmNPKixLJqvk2WaEqa27agisDg3P5MA5i+Te2MU0fDGlI/b9Ft9Y+qcBa@vger.kernel.org
X-Gm-Message-State: AOJu0YzYuQsCpzog1lnIQgBLosDYoNTHUT80OFGh4tYwPE/ejkJfGCtB
	C7COQK1aAaCEyEDBCfx3XfFTReDXpSk9QLP2++9EcLD2MrEGIMue5rvXQJfJt+uzntAUpQZ6PwO
	En5Ng+y23NHRaAchyBETfrxkES+o=
X-Google-Smtp-Source: AGHT+IFBzMXWr5UkC2Gm4/3P9/ZvA8w36q1HEkCEgsdfCzDr+mxZsaAXGYX6jnsN8fDxJkaQlNM1wFAIT++Tw1norb0=
X-Received: by 2002:a05:6402:27cc:b0:5cf:4527:4325 with SMTP id
 4fb4d7f45d1cf-5cf8fd2fe46mr4581794a12.24.1731752309472; Sat, 16 Nov 2024
 02:18:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <672a3997.050a0220.2a847.11f7.GAE@google.com>
In-Reply-To: <672a3997.050a0220.2a847.11f7.GAE@google.com>
From: Suraj Sonawane <surajsonawane0215@gmail.com>
Date: Sat, 16 Nov 2024 15:47:52 +0530
Message-ID: <CAHiZj8iv2WBFHDdamhnOg+KTNqWrmNpDxshpEX7h4QdtF0Wb_g@mail.gmail.com>
Subject: Re: [syzbot] [acpi?] [nvdimm?] KASAN: vmalloc-out-of-bounds Read in
 acpi_nfit_ctl (2)
To: syzbot <syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com>
Cc: dan.j.williams@intel.com, dave.jiang@intel.com, ira.weiny@intel.com, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, rafael@kernel.org, syzkaller-bugs@googlegroups.com, 
	vishal.l.verma@intel.com
Content-Type: multipart/mixed; boundary="0000000000003edab7062705014a"

--0000000000003edab7062705014a
Content-Type: multipart/alternative; boundary="0000000000003edab50627050148"

--0000000000003edab50627050148
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

--0000000000003edab50627050148
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

--0000000000003edab50627050148--
--0000000000003edab7062705014a
Content-Type: text/x-patch; charset="US-ASCII"; name="0001-fix-vmalloc.patch"
Content-Disposition: attachment; filename="0001-fix-vmalloc.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m3k0l38d0>
X-Attachment-Id: f_m3k0l38d0

RnJvbSBjZDcwZWFkNTAwYzQ0OTg5MTRhZjU3OGZkNjVmYjQ0Njg1NGNkOWNhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdXJhaiBTb25hd2FuZSA8c3VyYWpzb25hd2FuZTAyMTVAZ21h
aWwuY29tPgpEYXRlOiBTYXQsIDE2IE5vdiAyMDI0IDE1OjQ0OjI4ICswNTMwClN1YmplY3Q6IFtQ
QVRDSCB2NV0gYWNwaTogbmZpdDogdm1hbGxvYy1vdXQtb2YtYm91bmRzIFJlYWQgaW4gYWNwaV9u
Zml0X2N0bAoKRml4IGFuIGlzc3VlIGRldGVjdGVkIGJ5IHN5emJvdCB3aXRoIEtBU0FOOgoKQlVH
OiBLQVNBTjogdm1hbGxvYy1vdXQtb2YtYm91bmRzIGluIGNtZF90b19mdW5jIGRyaXZlcnMvYWNw
aS9uZml0Lwpjb3JlLmM6NDE2IFtpbmxpbmVdCkJVRzogS0FTQU46IHZtYWxsb2Mtb3V0LW9mLWJv
dW5kcyBpbiBhY3BpX25maXRfY3RsKzB4MjBlOC8weDI0YTAKZHJpdmVycy9hY3BpL25maXQvY29y
ZS5jOjQ1OQoKVGhlIGlzc3VlIG9jY3VycyBpbiBjbWRfdG9fZnVuYyB3aGVuIHRoZSBjYWxsX3Br
Zy0+bmRfcmVzZXJ2ZWQyCmFycmF5IGlzIGFjY2Vzc2VkIHdpdGhvdXQgdmVyaWZ5aW5nIHRoYXQg
Y2FsbF9wa2cgcG9pbnRzIHRvIGEgYnVmZmVyCnRoYXQgaXMgYXBwcm9wcmlhdGVseSBzaXplZCBh
cyBhIHN0cnVjdCBuZF9jbWRfcGtnLiBUaGlzIGNhbiBsZWFkCnRvIG91dC1vZi1ib3VuZHMgYWNj
ZXNzIGFuZCB1bmRlZmluZWQgYmVoYXZpb3IgaWYgdGhlIGJ1ZmZlciBkb2VzIG5vdApoYXZlIHN1
ZmZpY2llbnQgc3BhY2UuCgpUbyBhZGRyZXNzIHRoaXMsIGEgY2hlY2sgd2FzIGFkZGVkIGluIGFj
cGlfbmZpdF9jdGwoKSB0byBlbnN1cmUgdGhhdApidWYgaXMgbm90IE5VTEwgYW5kIHRoYXQgYnVm
X2xlbiBpcyBsZXNzIHRoYW4gc2l6ZW9mKCpjYWxsX3BrZykKYmVmb3JlIGFjY2Vzc2luZyBpdC4g
VGhpcyBlbnN1cmVzIHNhZmUgYWNjZXNzIHRvIHRoZSBtZW1iZXJzIG9mCmNhbGxfcGtnLCBpbmNs
dWRpbmcgdGhlIG5kX3Jlc2VydmVkMiBhcnJheS4KClJlcG9ydGVkLWJ5OiBzeXpib3QrNzUzNGYw
NjBlYmRhNmI4YjUxYjNAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQpDbG9zZXM6IGh0dHBzOi8v
c3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9leHRpZD03NTM0ZjA2MGViZGE2YjhiNTFiMwpUZXN0
ZWQtYnk6IHN5emJvdCs3NTM0ZjA2MGViZGE2YjhiNTFiM0BzeXprYWxsZXIuYXBwc3BvdG1haWwu
Y29tCkZpeGVzOiBlYmU5ZjZmMTlkODAgKCJhY3BpL25maXQ6IEZpeCBidXMgY29tbWFuZCB2YWxp
ZGF0aW9uIikKU2lnbmVkLW9mZi1ieTogU3VyYWogU29uYXdhbmUgPHN1cmFqc29uYXdhbmUwMjE1
QGdtYWlsLmNvbT4KLS0tClYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjQxMTEx
MDgwNDI5Ljk4NjEtMS1zdXJhanNvbmF3YW5lMDIxNUBnbWFpbC5jb20vClYyOiBJbml0aWFsaXpl
ZCBgb3V0X29iamAgdG8gYE5VTExgIGluIGBhY3BpX25maXRfY3RsKClgIHRvIHByZXZlbnQKcG90
ZW50aWFsIHVuaW5pdGlhbGl6ZWQgdmFyaWFibGUgdXNhZ2UgaWYgY29uZGl0aW9uIGlzIHRydWUu
ClYzOiBDaGFuZ2VkIHRoZSBjb25kaXRpb24gdG8gaWYgKCFidWYgfHwgYnVmX2xlbiA8IHNpemVv
ZigqY2FsbF9wa2cpKQphbmQgdXBkYXRlZCB0aGUgRml4ZXMgdGFnIHRvIHJlZmVyZW5jZSB0aGUg
Y29ycmVjdCBjb21taXQuClY0OiBSZW1vdmVkIHRoZSBleHBsaWNpdCBjYXN0IHRvIG1haW50YWlu
IHRoZSBvcmlnaW5hbCBjb2RlIHN0eWxlLgpWNTogUmUtSW5pdGlhbGl6ZWQgYG91dF9vYmpgIHRv
IE5VTEwuCgogZHJpdmVycy9hY3BpL25maXQvY29yZS5jIHwgMTEgKysrKysrKysrLS0KIDEgZmls
ZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9hY3BpL25maXQvY29yZS5jIGIvZHJpdmVycy9hY3BpL25maXQvY29yZS5jCmluZGV4
IDU0MjllYzllZi4uNTczZWQyNjRjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2FjcGkvbmZpdC9jb3Jl
LmMKKysrIGIvZHJpdmVycy9hY3BpL25maXQvY29yZS5jCkBAIC00MzksNyArNDM5LDcgQEAgaW50
IGFjcGlfbmZpdF9jdGwoc3RydWN0IG52ZGltbV9idXNfZGVzY3JpcHRvciAqbmRfZGVzYywgc3Ry
dWN0IG52ZGltbSAqbnZkaW1tLAogewogCXN0cnVjdCBhY3BpX25maXRfZGVzYyAqYWNwaV9kZXNj
ID0gdG9fYWNwaV9kZXNjKG5kX2Rlc2MpOwogCXN0cnVjdCBuZml0X21lbSAqbmZpdF9tZW0gPSBu
dmRpbW1fcHJvdmlkZXJfZGF0YShudmRpbW0pOwotCXVuaW9uIGFjcGlfb2JqZWN0IGluX29iaiwg
aW5fYnVmLCAqb3V0X29iajsKKwl1bmlvbiBhY3BpX29iamVjdCBpbl9vYmosIGluX2J1ZiwgKm91
dF9vYmogPSBOVUxMOwogCWNvbnN0IHN0cnVjdCBuZF9jbWRfZGVzYyAqZGVzYyA9IE5VTEw7CiAJ
c3RydWN0IGRldmljZSAqZGV2ID0gYWNwaV9kZXNjLT5kZXY7CiAJc3RydWN0IG5kX2NtZF9wa2cg
KmNhbGxfcGtnID0gTlVMTDsKQEAgLTQ1NCw4ICs0NTQsMTUgQEAgaW50IGFjcGlfbmZpdF9jdGwo
c3RydWN0IG52ZGltbV9idXNfZGVzY3JpcHRvciAqbmRfZGVzYywgc3RydWN0IG52ZGltbSAqbnZk
aW1tLAogCWlmIChjbWRfcmMpCiAJCSpjbWRfcmMgPSAtRUlOVkFMOwogCi0JaWYgKGNtZCA9PSBO
RF9DTURfQ0FMTCkKKwlpZiAoY21kID09IE5EX0NNRF9DQUxMKSB7CisJCWlmICghYnVmIHx8IGJ1
Zl9sZW4gPCBzaXplb2YoKmNhbGxfcGtnKSkgeworCQkJcmMgPSAtRUlOVkFMOworCQkJZ290byBv
dXQ7CisJCX0KKwogCQljYWxsX3BrZyA9IGJ1ZjsKKwl9CisKIAlmdW5jID0gY21kX3RvX2Z1bmMo
bmZpdF9tZW0sIGNtZCwgY2FsbF9wa2csICZmYW1pbHkpOwogCWlmIChmdW5jIDwgMCkKIAkJcmV0
dXJuIGZ1bmM7Ci0tIAoyLjM0LjEKCg==
--0000000000003edab7062705014a--

