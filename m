Return-Path: <linux-acpi+bounces-2490-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6604A8151F4
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Dec 2023 22:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C378BB238D1
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Dec 2023 21:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8596147F71;
	Fri, 15 Dec 2023 21:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BoQKQ+G5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CFE82ED1;
	Fri, 15 Dec 2023 21:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702676230; x=1734212230;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=u0rSifhJstSojm/lW2TxHwOkR1V3aPcA8iXgMDwGwIA=;
  b=BoQKQ+G5FB7RyUu1osBSQNygK5FuV5fNe2TBfL8evQT/RUF1S/YIzeZk
   FwRPObO6jXffboRWROHdvuTpnEhbLh1xt9OIlShpsj6clWX9swLLB7MJZ
   M7Y8nyKnmwJy3R/RjljQJHNc7Tk8NaVbCQCBbPx73Zb34GcdIQzgRXTmd
   XdJJ1tBJIb2I67mTaOVrGhOa6ucXE2peAv5sZ8J6myqafTYBs0Tf1Ur/L
   pzG4fC78yap3a4RmgeIXDce1Ug9HJFlBU6axDDALGdEaxsxSulX94ZHTZ
   cR9LrtizCXO6ekfuAWlEwiiWfQ34AG2r+BglwNloDfSD4e2DP3rROZ66M
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="2418076"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="2418076"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 13:37:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="1022067096"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="1022067096"
Received: from kpowell-mobl.amr.corp.intel.com (HELO vcostago-mobl3) ([10.209.17.106])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 13:37:08 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Eric Dumazet <edumazet@google.com>, syzbot
 <syzbot+45b67ef6e09a39a2cbcd@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, jhs@mojatatu.com,
 jiri@resnulli.us, kuba@kernel.org, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, rjw@rjwysocki.net,
 syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in ip_list_rcv (6)
In-Reply-To: <CANn89i+nERqd=gPkSxvGA1tE3x2RNJif-ANZnCSTAZMYTj4CyA@mail.gmail.com>
References: <0000000000005c8e95060babfa0e@google.com>
 <CANn89i+nERqd=gPkSxvGA1tE3x2RNJif-ANZnCSTAZMYTj4CyA@mail.gmail.com>
Date: Fri, 15 Dec 2023 13:37:07 -0800
Message-ID: <87cyv7p2po.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> On Mon, Dec 4, 2023 at 10:45=E2=80=AFAM syzbot
> <syzbot+45b67ef6e09a39a2cbcd@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    753c8608f3e5 Merge tag 'for-netdev' of https://git.kerne=
l...
>> git tree:       net-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1381f352e800=
00
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df8715b6ede5c=
4b90
>> dashboard link: https://syzkaller.appspot.com/bug?extid=3D45b67ef6e09a39=
a2cbcd
>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for =
Debian) 2.40
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15abc0e2e8=
0000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10b0c7c2e800=
00
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/17dd61ceadb9/di=
sk-753c8608.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/fed6ba43d9bd/vmlin=
ux-753c8608.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/3e68e49966d3/=
bzImage-753c8608.xz
>>
>> The issue was bisected to:
>>
>> commit b5b73b26b3ca34574124ed7ae9c5ba8391a7f176
>> Author: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> Date:   Thu Sep 10 00:03:11 2020 +0000
>>
>>     taprio: Fix allowing too small intervals
>>
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D13b90672e=
80000
>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D10790672e=
80000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17b90672e800=
00
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the com=
mit:
>> Reported-by: syzbot+45b67ef6e09a39a2cbcd@syzkaller.appspotmail.com
>> Fixes: b5b73b26b3ca ("taprio: Fix allowing too small intervals")
>>
>> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>> rcu:    0-...!: (2 GPs behind) idle=3D9444/0/0x3 softirq=3D6168/6168 fqs=
=3D0
>> rcu:    (detected by 1, t=3D10504 jiffies, g=3D7341, q=3D186 ncpus=3D2)
>> Sending NMI from CPU 1 to CPUs 0:
>> NMI backtrace for cpu 0
>> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.7.0-rc3-syzkaller-00666-g753=
c8608f3e5 #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =
Google 11/10/2023
>> RIP: 0010:rcu_is_watching+0x7c/0xb0 kernel/rcu/tree.c:701
>> Code: 89 da 48 c1 ea 03 0f b6 14 02 48 89 d8 83 e0 07 83 c0 03 38 d0 7c =
04 84 d2 75 1c 8b 03 c1 e8 02 83 e0 01 65 ff 0d fc d9 93 7e <74> 03 5b 5d c=
3 e8 fa 9d 90 ff 5b 5d c3 48 89 df e8 bf 90 6e 00 eb
>> RSP: 0000:ffffc90000006b90 EFLAGS: 00000006
>> RAX: 0000000000000001 RBX: ffff8880b9836de8 RCX: ffffffff81680cf5
>> RDX: 0000000000000000 RSI: ffffffff8b2f1340 RDI: ffffffff8ca6ea60
>> RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff1e31dea
>> R10: ffffffff8f18ef57 R11: 0000000000000004 R12: ffff8880b982b958
>> R13: 179cc057f149e962 R14: ffff88807627b340 R15: ffffffff88a26e60
>> FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:000000000000=
0000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f3bc135f410 CR3: 000000001ab22000 CR4: 00000000003506f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>  <NMI>
>>  </NMI>
>>  <IRQ>
>>  trace_lock_release include/trace/events/lock.h:69 [inline]
>>  lock_release+0x4bf/0x690 kernel/locking/lockdep.c:5765
>>  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:149 [inli=
ne]
>>  _raw_spin_unlock_irqrestore+0x1a/0x70 kernel/locking/spinlock.c:194
>>  __run_hrtimer kernel/time/hrtimer.c:1684 [inline]
>>  __hrtimer_run_queues+0x58b/0xc20 kernel/time/hrtimer.c:1752
>>  hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
>>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1065 [inline]
>>  __sysvec_apic_timer_interrupt+0x105/0x400 arch/x86/kernel/apic/apic.c:1=
082
>>  sysvec_apic_timer_interrupt+0x43/0xb0 arch/x86/kernel/apic/apic.c:1076
>>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry=
.h:645
>> RIP: 0010:unwind_get_return_address+0xa1/0xe0 arch/x86/kernel/unwind_orc=
.c:369
>> Code: 00 31 ff 89 c5 89 c6 e8 8d 9d 4d 00 85 ed 74 b9 e8 14 a2 4d 00 4c =
89 e2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 <75> 28 48 8b 5=
b 48 e8 f4 a1 4d 00 48 89 d8 5b 5d 41 5c c3 48 89 df
>> RSP: 0000:ffffc90000006f08 EFLAGS: 00000246
>> RAX: dffffc0000000000 RBX: ffffc90000006f30 RCX: ffffffff8139f033
>> RDX: 1ffff92000000def RSI: ffffffff8139f03c RDI: 0000000000000005
>> RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
>> R10: 0000000000000001 R11: 0000000000000003 R12: ffffc90000006f78
>> R13: ffffffff8174f4a0 R14: ffffc90000006ff0 R15: ffffffff8cc95900
>>  arch_stack_walk+0xbe/0x170 arch/x86/kernel/stacktrace.c:26
>>  stack_trace_save+0x96/0xd0 kernel/stacktrace.c:122
>>  kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
>>  kasan_set_track+0x25/0x30 mm/kasan/common.c:52
>>  kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
>>  ____kasan_slab_free mm/kasan/common.c:236 [inline]
>>  ____kasan_slab_free+0x15b/0x1b0 mm/kasan/common.c:200
>>  kasan_slab_free include/linux/kasan.h:164 [inline]
>>  slab_free_hook mm/slub.c:1800 [inline]
>>  slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
>>  slab_free mm/slub.c:3809 [inline]
>>  kmem_cache_free+0xf8/0x350 mm/slub.c:3831
>>  kfree_skbmem+0xef/0x1b0 net/core/skbuff.c:1015
>>  tcp_rcv_established+0xd5f/0x20e0 net/ipv4/tcp_input.c:6065
>>  tcp_v4_do_rcv+0x68c/0xa10 net/ipv4/tcp_ipv4.c:1912
>>  tcp_v4_rcv+0x3892/0x3b40 net/ipv4/tcp_ipv4.c:2335
>>  ip_protocol_deliver_rcu+0x9f/0x480 net/ipv4/ip_input.c:205
>>  ip_local_deliver_finish+0x2e4/0x510 net/ipv4/ip_input.c:233
>>  NF_HOOK include/linux/netfilter.h:314 [inline]
>>  NF_HOOK include/linux/netfilter.h:308 [inline]
>>  ip_local_deliver+0x18e/0x1f0 net/ipv4/ip_input.c:254
>>  dst_input include/net/dst.h:461 [inline]
>>  ip_sublist_rcv_finish+0x99/0x2e0 net/ipv4/ip_input.c:580
>>  ip_list_rcv_finish.constprop.0+0x560/0x720 net/ipv4/ip_input.c:631
>>  ip_sublist_rcv net/ipv4/ip_input.c:639 [inline]
>>  ip_list_rcv+0x339/0x440 net/ipv4/ip_input.c:674
>>  __netif_receive_skb_list_ptype net/core/dev.c:5572 [inline]
>>  __netif_receive_skb_list_core+0x52c/0x8a0 net/core/dev.c:5620
>>  __netif_receive_skb_list net/core/dev.c:5672 [inline]
>>  netif_receive_skb_list_internal+0x769/0xe00 net/core/dev.c:5763
>>  gro_normal_list include/net/gro.h:439 [inline]
>>  gro_normal_list include/net/gro.h:435 [inline]
>>  napi_complete_done+0x23f/0x990 net/core/dev.c:6103
>>  virtqueue_napi_complete drivers/net/virtio_net.c:440 [inline]
>>  virtnet_poll+0xf4a/0x15d0 drivers/net/virtio_net.c:2158
>>  __napi_poll.constprop.0+0xb4/0x540 net/core/dev.c:6533
>>  napi_poll net/core/dev.c:6602 [inline]
>>  net_rx_action+0x956/0xe90 net/core/dev.c:6735
>>  __do_softirq+0x21a/0x8de kernel/softirq.c:553
>>  invoke_softirq kernel/softirq.c:427 [inline]
>>  __irq_exit_rcu kernel/softirq.c:632 [inline]
>>  irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
>>  common_interrupt+0xb0/0xd0 arch/x86/kernel/irq.c:247
>>  </IRQ>
>>  <TASK>
>>  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:636
>> RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
>> RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [inl=
ine]
>> RIP: 0010:acpi_safe_halt+0x1b/0x20 drivers/acpi/processor_idle.c:113
>> Code: ed c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 65 48 8b 04 25 c0 bc =
03 00 48 8b 00 a8 08 75 0c 66 90 0f 00 2d b7 7b ba 00 fb f4 <fa> c3 0f 1f 0=
0 0f b6 47 08 3c 01 74 0b 3c 02 74 05 8b 7f 04 eb 9f
>> RSP: 0000:ffffffff8cc07d68 EFLAGS: 00000246
>> RAX: 0000000000004000 RBX: 0000000000000001 RCX: ffffffff8a7fa837
>> RDX: 0000000000000001 RSI: ffff888014ebd800 RDI: ffff888014ebd864
>> RBP: ffff888014ebd864 R08: 0000000000000001 R09: ffffed1017306dbd
>> R10: ffff8880b9836deb R11: 0000000000000000 R12: ffff8881412c4000
>> R13: ffffffff8db1cf20 R14: 0000000000000000 R15: 0000000000000000
>>  acpi_idle_enter+0xc5/0x160 drivers/acpi/processor_idle.c:707
>>  cpuidle_enter_state+0x83/0x500 drivers/cpuidle/cpuidle.c:267
>>  cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:388
>>  cpuidle_idle_call kernel/sched/idle.c:215 [inline]
>>  do_idle+0x319/0x400 kernel/sched/idle.c:282
>>  cpu_startup_entry+0x50/0x60 kernel/sched/idle.c:380
>>  rest_init+0x16f/0x2b0 init/main.c:730
>>  arch_call_rest_init+0x13/0x30 init/main.c:827
>>  start_kernel+0x39f/0x480 init/main.c:1072
>>  x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:555
>>  x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:536
>>  secondary_startup_64_no_verify+0x166/0x16b
>>  </TASK>
>> INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 5.00=
4 msecs
>> rcu: rcu_preempt kthread starved for 10504 jiffies! g7341 f0x0 RCU_GP_WA=
IT_FQS(5) ->state=3D0x0 ->cpu=3D1
>> rcu:    Unless rcu_preempt kthread gets sufficient CPU time, OOM is now =
expected behavior.
>> rcu: RCU grace-period kthread stack dump:
>> task:rcu_preempt     state:R  running task     stack:28752 pid:17    tgi=
d:17    ppid:2      flags:0x00004000
>> Call Trace:
>>  <TASK>
>>  context_switch kernel/sched/core.c:5376 [inline]
>>  __schedule+0xedb/0x5af0 kernel/sched/core.c:6688
>>  __schedule_loop kernel/sched/core.c:6763 [inline]
>>  schedule+0xe9/0x270 kernel/sched/core.c:6778
>>  schedule_timeout+0x137/0x290 kernel/time/timer.c:2167
>>  rcu_gp_fqs_loop+0x1ec/0xb10 kernel/rcu/tree.c:1631
>>  rcu_gp_kthread+0x24b/0x380 kernel/rcu/tree.c:1830
>>  kthread+0x2c6/0x3a0 kernel/kthread.c:388
>>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
>>  </TASK>
>> rcu: Stack dump where RCU GP kthread last ran:
>> CPU: 1 PID: 5093 Comm: syz-executor163 Not tainted 6.7.0-rc3-syzkaller-0=
0666-g753c8608f3e5 #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =
Google 11/10/2023
>> RIP: 0010:kvm_wait+0x146/0x180 arch/x86/kernel/kvm.c:1062
>> Code: 5b 5d 41 5c 41 5d e9 c9 34 4e 00 e8 c4 34 4e 00 e8 8f ed 54 00 66 =
90 e8 b8 34 4e 00 0f 00 2d 41 5a 90 09 e8 ac 34 4e 00 fb f4 <5b> 5d 41 5c 4=
1 5d e9 9f 34 4e 00 e8 9a 34 4e 00 e8 d5 ed 54 00 e9
>> RSP: 0018:ffffc900001f0ae0 EFLAGS: 00000246
>> RAX: 0000000000000000 RBX: 0000000000000003 RCX: 1ffffffff23ec48c
>> RDX: ffff888076299dc0 RSI: ffffffff81395da4 RDI: ffffffff8b2f13c0
>> RBP: ffff88807e768098 R08: 0000000000000001 R09: fffffbfff23e29e7
>> R10: ffffffff91f14f3f R11: 0000000000000002 R12: 0000000000000003
>> R13: 0000000000000003 R14: 0000000000000000 R15: ffffed100fced013
>> FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:000000000000=
0000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f3bc14032d0 CR3: 000000007af32000 CR4: 00000000003506f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>  <IRQ>
>>  pv_wait arch/x86/include/asm/paravirt.h:598 [inline]
>>  pv_wait_head_or_lock kernel/locking/qspinlock_paravirt.h:470 [inline]
>>  __pv_queued_spin_lock_slowpath+0x959/0xc70 kernel/locking/qspinlock.c:5=
11
>>  pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:586 [inlin=
e]
>>  queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
>>  queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
>>  do_raw_spin_lock+0x20e/0x2b0 kernel/locking/spinlock_debug.c:115
>>  spin_lock include/linux/spinlock.h:351 [inline]
>>  tcp_write_timer+0x2a/0x2b0 net/ipv4/tcp_timer.c:708
>>  call_timer_fn+0x193/0x590 kernel/time/timer.c:1700
>>  expire_timers kernel/time/timer.c:1751 [inline]
>>  __run_timers+0x764/0xb20 kernel/time/timer.c:2022
>>  run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
>>  __do_softirq+0x21a/0x8de kernel/softirq.c:553
>>  invoke_softirq kernel/softirq.c:427 [inline]
>>  __irq_exit_rcu kernel/softirq.c:632 [inline]
>>  irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
>>  sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1076
>>  </IRQ>
>>  <TASK>
>>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry=
.h:645
>> RIP: 0010:csd_lock_wait kernel/smp.c:311 [inline]
>> RIP: 0010:smp_call_function_many_cond+0x4e4/0x1550 kernel/smp.c:855
>> Code: 0b 00 85 ed 74 4d 48 b8 00 00 00 00 00 fc ff df 4d 89 f4 4c 89 f5 =
49 c1 ec 03 83 e5 07 49 01 c4 83 c5 03 e8 8e c0 0b 00 f3 90 <41> 0f b6 04 2=
4 40 38 c5 7c 08 84 c0 0f 85 24 0e 00 00 8b 43 08 31
>> RSP: 0018:ffffc90003bffa48 EFLAGS: 00000293
>> RAX: 0000000000000000 RBX: ffff8880b98441a0 RCX: ffffffff817bd1e8
>> RDX: ffff888076299dc0 RSI: ffffffff817bd1c2 RDI: 0000000000000005
>> RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000
>> R10: 0000000000000001 R11: 0000000000000001 R12: ffffed1017308835
>> R13: 0000000000000001 R14: ffff8880b98441a8 R15: ffff8880b993d8c0
>>  on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:1023
>>  __flush_tlb_multi arch/x86/include/asm/paravirt.h:87 [inline]
>>  flush_tlb_multi arch/x86/mm/tlb.c:944 [inline]
>>  flush_tlb_mm_range+0x28f/0x320 arch/x86/mm/tlb.c:1030
>>  tlb_flush arch/x86/include/asm/tlb.h:20 [inline]
>>  tlb_flush_mmu_tlbonly include/asm-generic/tlb.h:458 [inline]
>>  tlb_flush_mmu_tlbonly include/asm-generic/tlb.h:448 [inline]
>>  tlb_flush_mmu mm/mmu_gather.c:299 [inline]
>>  tlb_finish_mmu+0x335/0x6f0 mm/mmu_gather.c:392
>>  exit_mmap+0x38b/0xa70 mm/mmap.c:3321
>>  __mmput+0x12a/0x4d0 kernel/fork.c:1349
>>  mmput+0x62/0x70 kernel/fork.c:1371
>>  exit_mm kernel/exit.c:567 [inline]
>>  do_exit+0x9ad/0x2ae0 kernel/exit.c:858
>>  do_group_exit+0xd4/0x2a0 kernel/exit.c:1021
>>  __do_sys_exit_group kernel/exit.c:1032 [inline]
>>  __se_sys_exit_group kernel/exit.c:1030 [inline]
>>  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1030
>>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>>  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
>>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>> RIP: 0033:0x7f3bc13802e9
>> Code: Unable to access opcode bytes at 0x7f3bc13802bf.
>> RSP: 002b:00007ffde3662848 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
>> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3bc13802e9
>> RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
>> RBP: 00007f3bc1400390 R08: ffffffffffffffb8 R09: 0000000100000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3bc1400390
>> R13: 0000000000000000 R14: 00007f3bc1402ec0 R15: 00007f3bc13507c0
>>  </TASK>
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>> For information about bisection process see: https://goo.gl/tpsmEJ#bisec=
tion
>>
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>>
>> If you want syzbot to run the reproducer, reply with:
>> #syz test: git://repo/address.git branch-or-commit-hash
>> If you attach or paste a git patch, syzbot will apply it before testing.
>>
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>>
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>>
>> If you want to undo deduplication, reply with:
>> #syz undup
>
> FYI : Many other syzbot reports are pointing to taprio these days.
>

I know, it's bothering me a lot, really.

I'll investigate this one a bit better, and see if I can come up with
a fix for the short term.

For the long term, I am thinking that the solution is to re-write the
taprio software mode "engine" to not be 'hrtimer' dependent. And it will
have the advantage that I would be able to unify some of the code for
"txtime-assisted mode" and software mode, i.e. the "get the schedule
entry for a particular time" function will be the used for both.

> In a3d43c0d56f1b94e74963a2fbadfb70126d92213 ("taprio: Add support
> adding an admin schedule"),
> advance_sched() was changed to call switch_schedules(q, &admin, &oper);
>
> This is done while qdisc spinlock is not held, I fail to see how this
> can work safely ?
>

I took a look at the code at a3d43c0d56f1b94e74963a2fbadfb70126d92213
point, there are two calls to switch_schedules() and both calls to
switch_schedules() (both in advance_sched()) are done with the lock held
(q->current_entry_lock). Am I missing anything?

But the situation in the current code is definitely worse, I admit,
there are two additional calls to switch_schedules(), one in
get_packet_txtime() and one in taprio_offload_config_changed(), these
are done without the lock, but in these modes the hrtimer isn't running.

I will send a patch fixing this, adding locking for those two extra
cases as well.

> Which lock is supposed to protect q->oper_sched and q->admin_sched ?
>
> This can not be q->current_entry_lock in some cases, and qdisc lock in ot=
hers.
>

It should have been q->current_entry_lock.


Cheers,
--=20
Vinicius

