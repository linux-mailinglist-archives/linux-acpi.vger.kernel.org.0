Return-Path: <linux-acpi+bounces-13810-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED28EABC4A3
	for <lists+linux-acpi@lfdr.de>; Mon, 19 May 2025 18:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7754189F8D8
	for <lists+linux-acpi@lfdr.de>; Mon, 19 May 2025 16:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159EE28368E;
	Mon, 19 May 2025 16:35:30 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D89199931;
	Mon, 19 May 2025 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672530; cv=none; b=uXUkZYZTnJfvk9gLO6jkU2sjzGjvtDOjnoGjHx5wXRXGD60CE0maFSPoaIYrPxWJ1cvPdqc2CHp70o2b/NvJg4sW9mYXkxOZJPch18c59DyKFMx03zRqryPL1OedQloJkkSyPzSwIt96/fsYmyKhjYMd7aHtvXQ7ZsNPue/a0vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672530; c=relaxed/simple;
	bh=9eriE1PkVOELR+xjnTYu3UMZywdiBv6Uqwk/7wWDUgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i1140EZXdn7x6C1dC3/pzdn8R6uuoZpdz0sg3Srj2UW59lGPrroKs/Qs4ANq8MZ58LDu+y9G2BjH5OdE1oC+dwDvXtuXPcrpA5vYuKyapmAcdU3B9xb/K2mtrAcrquSlB2LTMlra8CCFBde0HaLomUuQorZufX5Z6gQybTiYNko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6F63A439B0;
	Mon, 19 May 2025 16:35:15 +0000 (UTC)
Message-ID: <8368aa6d-e5a9-4136-8eb6-c059bc888979@ghiti.fr>
Date: Mon, 19 May 2025 18:35:15 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] riscv/fixes test error: can't ssh into the instance (2)
To: syzbot <syzbot+2cae92ded758083f5bde@syzkaller.appspotmail.com>,
 aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, syzkaller-bugs@googlegroups.com,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-acpi@vger.kernel.org
References: <682b0412.a70a0220.3849cf.00b1.GAE@google.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <682b0412.a70a0220.3849cf.00b1.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -51
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddukeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhepuefhffegtddujedvveejkeffhfetueehkefhleduvdelleeffeejgfffleeikeetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpshihiihkrghllhgvrhdrrghpphhsphhothdrtghomhdpghhoohhglhgvrghpihhsrdgtohhmpdhgohhordhglhdpihhnfhhrrgguvggrugdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmeejjeeiudemiegsgeeimegrsgguugemfhgvtgefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmeejjeeiudemiegsgeeimegrsgguugemfhgvtgefpdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmeejjeeiudemiegsgeeimegrsgguugemfhgvtgefngdpmhgrihhlfhhrohhmpegrlhgvg
 iesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehshiiisghothdovdgtrggvledvuggvugejheektdekfehfhegsuggvsehshiiikhgrlhhlvghrrdgrphhpshhpohhtmhgrihhlrdgtohhmpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepshihiihkrghllhgvrhdqsghughhssehgohhoghhlvghgrhhouhhpshdrtghomhdprhgtphhtthhopehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-GND-Sasl: alex@ghiti.fr

On 5/19/25 12:12, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    01534f3e0dd7 Merge tag 'riscv-fixes-6.15-rc6' of ssh://git..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
> console output: https://syzkaller.appspot.com/x/log.txt?x=158796f4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2c32351e59d854b7
> dashboard link: https://syzkaller.appspot.com/bug?extid=2cae92ded758083f5bde
> compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: riscv64
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-01534f3e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4ca1cbb891a9/vmlinux-01534f3e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/5fb1db315d47/Image-01534f3e.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2cae92ded758083f5bde@syzkaller.appspotmail.com
>
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
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


So we hit the following warning:

[   33.466472][    C6] WARNING: CPU: 6 PID: 1 at fs/sysfs/group.c:131 
internal_create_group+0xa22/0xdd8
[   33.471115][    C6] Modules linked in:
[   33.475123][    C6] CPU: 6 UID: 0 PID: 1 Comm: swapper/0 Not tainted 
6.15.0-rc6-dirty #3 PREEMPT
[   33.476075][    C6] Hardware name: riscv-virtio,qemu (DT)
[   33.476615][    C6] epc : internal_create_group+0xa22/0xdd8
[   33.477194][    C6]  ra : internal_create_group+0xa22/0xdd8
[   33.477696][    C6] epc : ffffffff80dd956c ra : ffffffff80dd956c sp : 
ffffffc600087b50
[   33.478048][    C6]  gp : ffffffff89a659e0 tp : ffffffd681688000 t0 : 
ffffffc600087a80
[   33.478377][    C6]  t1 : 1ffffff8c0010f78 t2 : ffffffff89b70a80 s0 : 
ffffffc600087cc0
[   33.478690][    C6]  s1 : ffffffc600087c40 a0 : 0000000000000000 a1 : 
0000000000000000
[   33.478990][    C6]  a2 : 0000000000000002 a3 : ffffffff80dd956c a4 : 
0000000000000000
[   33.479291][    C6]  a5 : ffffffd681689000 a6 : fffffffff1f1f1f1 a7 : 
ffffffff80dd8b4a
[   33.479602][    C6]  s2 : dfffffff00000000 s3 : ffffffff86a381a0 s4 : 
ffffffc600087dc0
[   33.479967][    C6]  s5 : 0000000000000002 s6 : 0000000000000000 s7 : 
0000000000000000
[   33.480327][    C6]  s8 : 1ffffffff136df40 s9 : ffffffff89b6fa00 s10: 
1ffffff8c0010fa4
[   33.480673][    C6]  s11: ffffffff87bece20 t3 : 0000000000000000 t4 : 
fffffffef10e33b2
[   33.481019][    C6]  t5 : fffffffef10e33b3 t6 : ffffffd68aabf2f8
[   33.481326][    C6] status: 0000000200000120 badaddr: 
ffffffff80dd956c cause: 0000000000000003
[   33.481962][    C6] [<ffffffff80dd956c>] 
internal_create_group+0xa22/0xdd8
[   33.482681][    C6] [<ffffffff80dd9944>] sysfs_create_group+0x22/0x2e
[   33.483136][    C6] [<ffffffff86289d82>] platform_profile_init+0x74/0xb2
[   33.483555][    C6] [<ffffffff80061860>] do_one_initcall+0x198/0xa9e
[   33.484158][    C6] [<ffffffff8620293e>] kernel_init_freeable+0x6d8/0x780
[   33.484689][    C6] [<ffffffff8609fe54>] kernel_init+0x28/0x24c
[   33.485208][    C6] [<ffffffff860c2542>] ret_from_fork+0xe/0x18
[   33.485885][    C6] irq event stamp: 950699
[   33.486072][    C6] hardirqs last  enabled at (950699): 
[<ffffffff80a6182c>] kasan_quarantine_put+0x1a8/0x208
[   33.486710][    C6] hardirqs last disabled at (950698): 
[<ffffffff80a61726>] kasan_quarantine_put+0xa2/0x208
[   33.487398][    C6] softirqs last  enabled at (950420): 
[<ffffffff801533a6>] handle_softirqs+0x98e/0x119c
[   33.487930][    C6] softirqs last disabled at (950413): 
[<ffffffff80153fd6>] __irq_exit_rcu+0x2e8/0x53c

Because we don't have acpi enabled and then acpi_kobj is null 
(https://elixir.bootlin.com/linux/v6.15-rc6/source/fs/sysfs/group.c#L131).

The following patch fixes it, but not sure this is the right way, let me 
know if I should send it, it would be nice to have it in 6.15:

diff --git a/drivers/acpi/platform_profile.c 
b/drivers/acpi/platform_profile.c
index ffbfd32f4cf1b..afbe4705d3e7a 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -688,6 +688,9 @@ static int __init platform_profile_init(void)
  {
         int err;

+       if (acpi_disabled)
+               return -ENOTSUPP;
+
         err = class_register(&platform_profile_class);
         if (err)
                 return err;

Thanks,

Alex


