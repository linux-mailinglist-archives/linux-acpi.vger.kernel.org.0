Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236473A2295
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jun 2021 05:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhFJDJh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Jun 2021 23:09:37 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:49704 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFJDJ3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jun 2021 23:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1623294454; x=1654830454;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=PKgLKEnHIlLzGSNLo7lwSd1HZk+pfLZkKoWfDoehmeE=;
  b=nd33e+FYrrvdEBCKIACVQH4m6rTEHrgaZ5AD2uQlQP7n7Ugn9QptlGIV
   pXBXFH+zo30+ydSZRD+NZjqFy8mknaFZaRJtAx9DA/FuKjdfxGyUgbUXc
   WA+gmiuQ0lc9agjgDpEFX60PY1leEBcz3/9GcbxvExDJTrCwCbkmXQpsz
   c=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 09 Jun 2021 20:07:34 -0700
X-QCInternal: smtphost
Received: from nalasexr03e.na.qualcomm.com ([10.49.195.114])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 09 Jun 2021 20:07:30 -0700
Received: from [10.111.160.165] (10.80.80.8) by nalasexr03e.na.qualcomm.com
 (10.49.195.114) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 9 Jun
 2021 20:07:27 -0700
Subject: Re: [PATCH V6 0/4] cpufreq: cppc: Add support for frequency
 invariance
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Ben Segall <bsegall@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Will Deacon <will@kernel.org>
CC:     <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <cover.1615351622.git.viresh.kumar@linaro.org>
 <41f5195e-0e5f-fdfe-ba37-34e1fd8e4064@quicinc.com>
Message-ID: <d2fe4755-787a-f0ab-078a-c87d852e233d@quicinc.com>
Date:   Wed, 9 Jun 2021 23:07:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <41f5195e-0e5f-fdfe-ba37-34e1fd8e4064@quicinc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03b.na.qualcomm.com (10.85.0.98) To
 nalasexr03e.na.qualcomm.com (10.49.195.114)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 6/9/2021 11:46 AM, Qian Cai wrote:
> 
> 
> On 3/10/2021 12:23 AM, Viresh Kumar wrote:
>> Hello,
>>
>> CPPC cpufreq driver is used for ARM servers and this patch series tries
>> to provide counter-based frequency invariance support for them in the
>> absence for architecture specific counters (like AMUs).
>>
>> This is tested by:
>> - Vincent Guittot on ThunderX2.
>> - Ionela Voinescu on Juno R2.
>> - /me with hacks on Hikey, as I don't have access to the right hardware.
> 
> Git blame pointed out this series for a use-after-free during CPU offline/online. Any thoughts?

FYI, it could trigger a linked-list corruption instead below sometimes.

Reverting only the 4th patch (cpufreq: CPPC: Add support for frequency invariance) alone fixed the use-after-free. The corruption seems gone as well. 

[  258.585467][  T704] WARNING: CPU: 1 PID: 704 at drivers/cpufreq/cppc_cpufreq.c:124 cppc_scale_freq_workfn+0x2d0/0x368 [cppc_cpufreq]
[  258.593303][   C13] list_add corruption. prev->next should be next (ffff0008d88e6e48), but was ffff009b676bed30. (prev=ffff009b676bed30).

[  259.155595][   C13] Call trace:
[  259.158727][   C13]  __list_add_valid+0xf0/0xf8
[  259.163251][   C13]  kthread_insert_work+0x114/0x5c8
[  259.168209][   C13]  kthread_queue_work+0xf8/0x138
[  259.172993][   C13]  cppc_irq_work+0x24/0x30 [cppc_cpufreq]
[  259.178566][   C13]  irq_work_single+0xec/0x1e0
[  259.183091][   C13]  irq_work_run_list+0x88/0xb8
[  259.187701][   C13]  irq_work_run+0x28/0x48
[  259.191876][   C13]  ipi_handler+0x3dc/0x7a0
[  259.196140][   C13]  handle_percpu_devid_irq+0x240/0xb70
[  259.201447][   C13]  handle_domain_irq+0xe4/0x168
[  259.206144][   C13]  gic_handle_irq+0x5c/0x150
[  259.210582][   C13]  do_interrupt_handler+0x58/0xa8
[  259.215453][   C13]  el1_interrupt+0x30/0x48
[  259.219717][   C13]  el1h_64_irq_handler+0x18/0x28
[  259.224502][   C13]  el1h_64_irq+0x74/0x78
[  259.228590][   C13]  _stext+0x264/0x1114
[  259.232504][   C13]  irq_exit+0x53c/0x610
[  259.236507][   C13]  handle_domain_irq+0xe8/0x168
[  259.241203][   C13]  gic_handle_irq+0x5c/0x150
[  259.245640][   C13]  call_on_irq_stack+0x28/0x50
[  259.250250][   C13]  do_interrupt_handler+0x80/0xa8
[  259.255120][   C13]  el1_interrupt+0x30/0x48
[  259.259383][   C13]  el1h_64_irq_handler+0x18/0x28
[  259.264167][   C13]  el1h_64_irq+0x74/0x78
[  259.268255][   C13]  cpuidle_enter_state+0x2a4/0xff0
[  259.273214][   C13]  cpuidle_enter+0x60/0xb0
[  259.277476][   C13]  call_cpuidle+0x44/0xc0
[  259.281652][   C13]  do_idle+0x36c/0x420
[  259.285568][   C13]  cpu_startup_entry+0x30/0x88
[  259.290177][   C13]  secondary_start_kernel+0x28c/0x2d8
[  259.295395][   C13]  __secondary_switched+0x90/0x94
[  259.300269][   C13] Code: aa0103e3 91020000 aa1303e1 941b5a28 (d4210000)
[  259.307049][   C13] ---[ end trace dabb4391495b1abe ]---
[  259.312353][   C13] Kernel panic - not syncing: Oops - BUG: Fatal exception in interrupt

> 
> cppc_scale_freq_workfn+0x2e8/0x368:
> cppc_perf_from_fbctrs at /usr/src/linux-next/drivers/cpufreq/cppc_cpufreq.c:584
> (inlined by) cppc_scale_freq_workfn at /usr/src/linux-next/drivers/cpufreq/cppc_cpufreq.c:119
> 
> [ 9334.586904][  T694] BUG: KASAN: use-after-free in cppc_scale_freq_workfn+0x2e8/0x368 [cppc_cpufreq]
> [ 9334.595966][  T694] Read of size 4 at addr ffff0008d52557b4 by task cppc_fie/694
> [ 9334.603360][  T694]
> [ 9334.605543][  T694] CPU: 2 PID: 694 Comm: cppc_fie Tainted: G        W         5.13.0-rc5-next-20210609+ #19
> [ 9334.615368][  T694] Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2020
> [ 9334.623888][  T694] Call trace:
> [ 9334.627025][  T694]  dump_backtrace+0x0/0x3b8
> [ 9334.631385][  T694]  show_stack+0x20/0x30
> [ 9334.635394][  T694]  dump_stack_lvl+0x144/0x190
> [ 9334.639925][  T694]  print_address_description.constprop.0+0x74/0x3c8
> [ 9334.646368][  T694]  kasan_report+0x1f0/0x208
> [ 9334.650724][  T694]  __asan_report_load4_noabort+0x34/0x60
> [ 9334.656208][  T694]  cppc_scale_freq_workfn+0x2e8/0x368 [cppc_cpufreq]
> [ 9334.662740][  T694]  kthread_worker_fn+0x2f0/0xda0
> [ 9334.667532][  T694]  kthread+0x3ac/0x460
> [ 9334.671453][  T694]  ret_from_fork+0x10/0x18
> [ 9334.675722][  T694]
> [ 9334.677904][  T694] Allocated by task 607:
> [ 9334.681996][  T694]  kasan_save_stack+0x28/0x58
> [ 9334.686525][  T694]  94]  cppc_cpufre7164][  T694]  cpufreq_add_dev+0x164/0x1b8
> [ 9334.711779][  T694]  subsys_interface_register+0x218/0x360
> [ 9334.717265][  T694]  cpufreq_register_driver+0x2a4/0x4c0
> [ 9334.722577][  T694]  0xffff80000af902a4
> [ 9334.726412][  T694]  do_one_initcall+0x170/0xb98
> [ 9334.731029][  T694]  do_init_module+0x18c/0x648
> [ 9334.735559][  T694]  load_module+0x2618/0x3240
> [ 9334.740001][  T694]  __do_sys_finit_module+0x118/0x1a8
> [ 9334.745138][  T694]  __arm64_sys_finit_module+0x74/0xa8
> [ 9334.750360][  T694]  invoke_syscall.constprop.0+0xdc/0x1d8
> [ 9334.755846][  T694]  do_el0_svc+0x1f8/0x298
> [ 9334.760028][  T694]  el0_svc+0x20/0x30
> [ 9334.763775][  T694]  el0t_64_sync_handler+0xb0/0xb8
> [ 9334.768651][  T694]  el0t_64_sync+0x178/0x17c
> [ 9334.773006][  T694]
> [ 9334.775187][  T694] The buggy address belongs to the object at ffff0008d5255780
> [ 9334.775187][  T694]  which belongs to the cache kmalloc-128 of size 128
> [ 9334.789089][  T694] The buggy address is located 52 bytes inside of
> [ 9334.789089][  T694]  128-byte region [ffff0008d5255780, ffff0008d5255800)
> [ 9334.802125][  T694] The buggy address belongs to the page:
> [ 9334.807606][  T694] page:ffffffc002354940 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff0008d5255780 pfn:0x95525
> [ 9334.818907][  T694] flags: 0x7ffff800000200(slab|node=0|zone=0|lastcpupid=0xfffff)
> [ 9334.826480][  T694] raw: 007ffff800000200 ffff000012900448 ffffffc00240f8c8 ffff000012910580
> [ 9334.834915][  T694] raw: ffff0008d5255780 0000000000aa00a9 00000001ffffffff 0000000000000000
> [ 9334.843347][  T694] page dumped because: kasan: bad access detected
> [ 9334.849609][  T694]
> [ 9334.851790][  T694] Memory state around the buggy address:
> [ 9334.857272][  T694]  ffff0008d5255680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [ 9334.865184][  T694]  ffff0008d5255700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [ 9334.873096][  T694] >ffff0008d5255780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [ 9334.881007][  T694]                                      ^
> [ 9334.886489][  T694]  ffff0008d5255800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [ 9334.894401][  T694]  ffff0008d5255880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [ 9334.902312][  T694] ==================================================================
> [ 9334.910223][  T694] Disabling lock debugging due to kernel taint
> [ 9334.916638][T62553] CPU1: shutdown
> [ 9334.920044][T62553] psci: CPU1 killed (polled 0 ms)
> [ 9335.175037][   T22] IRQ 326: no longer affine to CPU2
> [ 9335.180136][   T22] IRQ 382: no longer affine to CPU2
> [ 9335.185320][T62553] CPU2: shutdown
> [ 9335.188751][T62553] psci: CPU2 killed (polled 0 ms)
> [ 9335.469684][   T27] IRQ 327: no longer affine to CPU3
> [ 9335.474792][   T27] IRQ 361: no longer affine to CPU3
> [ 9335.479938][T62553] CPU3: shutdown
> [ 9335.483344][T62553] psci: CPU3 killed (polled 0 ms)
> [ 9335.797240][   T32] IRQ 15: no longer affine to CPU4
> [ 9335.802343][   T32] IRQ 334: no longer affine to CPU4
> [ 9335.807554][T62553] CPU4: shutdown
> [ 9335.810973][T62553] psci: CPU4 killed (polled 0 ms)
> [ 9336.064091][T62553] CPU5: shutdown
> [ 9336.067529][T62553] psci: CPU5 killed (polled 0 ms)
> [ 9336.346263][T62553] CPU6: shutdown
> [ 9336.349668][T62553] psci: CPU6 killed (polled 0 ms)
> [ 9336.586727][T62553] CPU7: shutdown
> [ 9336.590140][T62553] psci: CPU7 killed (polled 0 ms)
> [ 9336.846866][T62553] CPU8: shutdown
> [ 9336.850273][T62553] psci: CPU8 killed (polled 0 ms)
> [ 9357.773249][T62671] loop0: detected capacity change from 0 to 8
> [ 9471.525541][  T191] INFO: task cpuhp/9:56 blocked for more than 122 seconds.
> [ 9471.532603][  T191]       Tainted: G    B   W         5.13.0-rc5-next-20210609+ #19
> [ 9471.540291][  T191] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 9471.548837][  T191] task:cpuhp/9         state:D stack:58816 pid:   56 ppid:     2 flags:0x00000008
> [ 9471.557924][  T191] Call trace:
> [ 9471.561063][  T191]  __switch_to+0x184/0x400
> [ 9471.565338][  T191]  __schedule+0x744/0x1930
> [ 9471.569632][  T191]  schedule+0x1d0/0x3e8
> [ 9471.573641][  T191]  schedule_timeout+0x188/0x1f8
> [ 9471.578380][  T191]  wait_for_completion+0x15c/0x270
> [ 9471.583348][  T191]  kthread_flush_work+0x15c/0x248
> [ 9471.588274][  T191]  __kthread_cancel_work_sync+0x1a0/0x230
> [ 9471.593851][  T191]  kthread_cancel_work_sync+0x1c/0x28
> [ 9471.599114][  T191]  sugov_stop+0x104/0x148
> [ 9471.603302][  T191]  cpufreq_stop_governor+0x78/0x138
> [ 9471.608390][  T191]  cpufreq_offline+0x7c/0x748
> [ 9471.612924][  T191]  cpuhp_cpufreq_offline+0x18/0x28
> [ 9471.617924][  T191]  cpuhp_invoke_callback+0x54c/0x2be0
> [ 9471.623153][  T191]  cpuhp_thread_fun+0x204/0x588
> [ 9471.627892][  T191]  smpboot_thread_fn+0x3c8/0xbf8
> [ 9471.632687][  T191]  kthread+0x3ac/0x460
> [ 9471.636646][  T191]  ret_from_fork+0x10/0x18
> [ 9471.640998][  T191] INFO: task irqbalance:940 blocked for more than 122 seconds.
> [ 9471.648437][  T191]       Tainted: G    B   W         5.13.0-rc5-next-20210609+ #19
> [ 9471.656127][  T191] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 9471.664650][  T191] task:irqbalance      state:D stack:55696 pid:  940 ppid:     1 flags:0x00000800
> [ 9471.673753][  T191] Call trace:
> [ 9471.676931][  T191]  __switch_to+0x184/0x400
> [ 9471.681207][  T191]  __schedule+0x744/0x1930
> [ 9471.685513][  T191]  schedule+0x1d0/0x3e8
> [ 9471.689526][  T191]  schedule_preempt_disabled+0x80/0x110
> [ 9471.694925][  T191]  __mutex_lock+0x618/0x1330
> [ 9471.699401][  T191]  mutex_lock_nested+0x6c/0xc0
> [ 9471.704024][  T191]  online_show+0x34/0xa8
> [ 9471.708167][  T191]  dev_attr_show+0x50/0xc8
> [ 9471.712442][  T191]  sysfs_kf_seq_show+0x164/0x368
> [ 9471.717271][  T191]  kernfs_seq_show+0x130/0x198
> [ 9471.721893][  T191]  seq_read_iter+0x344/0xd50
> [ 9471.726371][  T191]  kernfs_fop_read_iter+0x32c/0x4a8
> [ 9471.731426][  T191]  new_sync_read+0x2bc/0x4e8
> [ 9471.735905][  T191]  vfs_read+0x18c/0x340
> [ 9471.739918][  T191]  ksys_read+0xf8/0x1e0
> [ 9471.743927][  T191]  __arm64_sys_read+0x74/0xa8
> [ 9471.748479][  T191]  invoke_syscall.constprop.0+0xdc/0x1d8
> [ 9471.753967][  T191]  do_el0_svc+0x1f8/0x298
> [ 9471.758168][  T191]  el0_svc+0x20/0x30
> [ 9471.761916][  T191]  el0t_64_sync_handler+0xb0/0xb8
> [ 9471.766828][  T191]  el0t_64_sync+0x178/0x17c
> [ 9471.771209][  T191] INFO: task kworker/9:2:27306 blocked for more than 123 seconds.
> [ 9471.778895][  T191]       Tainted: G    B   W         5.13.0-rc5-next-20210609+ #19
> [ 9471.786574][  T191] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 9471.795094][  T191] task:kworker/9:2     state:D stack:57552 pid:27306 ppid:     2 flags:0x00000008
> [ 9471.804179][  T191] Workqueue: events cpuset_hotplug_workfn
> [ 9471.809782][  T191] Call trace:
> [ 9471.812919][  T191]  __switch_to+0x184/0x400
> [ 9471.817208][  T191]  __schedule+0x744/0x1930
> [ 9471.821479][  T191]  schedule+0x1d0/0x3e8
> [ 9471.825512][  T191]  percpu_rwsem_wait+0x1a4/0x320
> [ 9471.830303][  T191]  __percpu_down_read+0xb0/0x148
> [ 9471.835089][  T191]  cpus_read_lock+0x2b4/0x308
> [ 9471.839635][  T191]  rebuild_sched_domains+0x24/0x50
> [ 9471.844598][  T191]  cpuset_hotplug_workfn+0x21c/0x11e0
> [ 9471.849839][  T191]  process_one_work+0x7e4/0x1998
> [ 9471.854629][  T191]  worker_thread+0x334/0xad0
> [ 9471.859089][  T191]  kthread+0x3ac/0x460
> [ 9471.863011][  T191]  ret_from_fork+0x10/0x18
> [ 9471.867318][  T191] INFO: task kworker/31:1:49260 blocked for more than 123 seconds.
> [ 9471.875058][  T191]       Tainted: G    B   W         5.13.0-rc5-next-20210609+ #19
> [ 9471.882732][  T191] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 9471.891280][  T191] task:kworker/31:1    state:D stack:60640 pid:49260 ppid:     2 flags:0x00000008
> [ 9471.900366][  T191] Workqueue: events vmstat_shepherd
> [ 9471.905425][  T191] Call trace:
> [ 9471.908582][  T191]  __switch_to+0x184/0x400
> [ 9471.912853][  T191]  __schedule+0x744/0x1930
> [ 9471.917142][  T191]  schedule+0x1d0/0x3e8
> [ 9471.921150][  T191]  percpu_rwsem_wait+0x1a4/0x320
> [ 9471.925960][  T191]  __percpu_down_read+0xb0/0x148
> [ 9471.930751][  T191]  cpus_read_lock+0x2b4/0x308
> [ 9471.935277][  T191]  vmstat_shepherd+0x5c/0x1a8
> [ 9471.939828][  T191]  process_one_work+0x7e4/0x1998
> [ 9471.944618][  T191]  worker_thread+0x334/0xad0
> [ 9471.949084][  T191]  kthread+0x3ac/0x460
> [ 9471.953007][  T191]  ret_from_fork+0x10/0x18
> [ 9471.957305][  T191] INFO: task cpuhotplug04.sh:62553 blocked for more than 123 seconds.
> [ 9471.965306][  T191]       Tainted: G    B   W         5.13.0-rc5-next-20210609+ #19
> [ 9471.972991][  T191] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 9471.981538][  T191] task:cpuhotplug04.sh state:D stack:55936 pid:62553 ppid:  7301 flags:0x00000000
> [ 9471.990625][  T191] Call trace:
> [ 9471.993764][  T191]  __switch_to+0x184/0x400
> [ 9471.998053][  T191]  __schedule+0x744/0x1930
> [ 9472.002322][  T191]  schedule+0x1d0/0x3e8
> [ 9472.006352][  T191]  schedule_timeout+0x188/0x1f8
> [ 9472.011056][  T191]  wait_for_completion+0x15c/0x270
> [ 9472.016038][  T191]  __cpuhp_kick_ap+0x158/0x1a8
> [ 9472.020656][  T191]  cpuhp_kick_ap+0x200/0x7f8
> [ 9472.025095][  T191]  cpuhp_kick_ap_work+0x1f0/0xc98
> [ 9472.029990][  T191]  _cpu_down.constprop.0+0x348/0x1118
> [ 9472.035214][  T191]  cpu_down+0x50/0x80
> [ 9472.039065][  T191]  cpu_device_down+0x4c/0x68
> [ 9472.043507][  T191]  cpu_subsys_offline+0x18/0x28
> [ 9472.048229][  T191]  device_offline+0x154/0x1e0
> [ 9472.052757][  T191]  online_store+0xa4/0x118
> [ 9472.057042][  T191]  dev_attr_store+0x44/0x78
> [ 9472.061397][  T191]  sysfs_kf_write+0xe8/0x138
> [ 9472.065867][  T191]  kernfs_fop_write_iter+0x26c/0x3d0
> [ 9472.071006][  T191]  new_sync_write+0x2bc/0x4f8
> [ 9472.075554][  T191]  vfs_write+0x718/0xc88
> [ 9472.079649][  T191]  ksys_write+0xf8/0x1e0
> [ 9472.083742][  T191]  __arm64_sys_write+0x74/0xa8
> [ 9472.088374][  T191]  invoke_syscall.constprop.0+0xdc/0x1d8
> [ 9472.093859][  T191]  do_el0_svc+0xe4/0x298
> [ 9472.097971][  T191]  el0_svc+0x20/0x30
> [ 9472.101718][  T191]  el0t_64_sync_handler+0xb0/0xb8
> [ 9472.106610][  T191]  el0t_64_sync+0x178/0x17c
> [ 9472.110972][  T191] INFO: lockdep is turned off.
> [ 9594.405358][  T191] INFO: task cpuhp/9:56 blocked for more than 245 seconds.
> [ 9594.412416][  T191]       Tainted: G    B   W         5.13.0-rc5-next-20210609+ #19
> [ 9594.420107][  T191] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 9594.428651][  T191] task:cpuhp/9         state:D stack:58816 pid:   56 ppid:     2 flags:0x00000008
> [ 9594.437737][  T191] Call trace:
> [ 9594.440877][  T191]  __switch_to+0x184/0x400
> [ 9594.445148][  T191]  __schedule+0x744/0x1930
> [ 9594.449438][  T191]  schedule+0x1d0/0x3e8
> [ 9594.453447][  T191]  schedule_timeout+0x188/0x1f8
> [ 9594.458169][  T191]  wait_for_completion+0x15c/0x270
> [ 9594.463133][  T191]  kthread_flush_work+0x15c/0x248
> [ 9594.468038][  T191]  __kthread_cancel_work_sync+0x1a0/0x230
> [ 9594.473611][  T191]  kthread_cancel_work_sync+0x1c/0x28
> [ 9594.478853][  T191]  sugov_stop+0x104/0x148
> [ 9594.483036][  T191]  cpufreq_stop_governor+0x78/0x138
> [ 9594.488106][  T191]  cpufreq_offline+0x7c/0x748
> [ 9594.492634][  T191]  cpuhp_cpufreq_offline+0x18/0x28
> [ 9594.497616][  T191]  cpuhp_invoke_callback+0x54c/0x2be0
> [ 9594.502840][  T191]  cpuhp_thread_fun+0x204/0x588
> [ 9594.507559][  T191]  smpboot_thread_fn+0x3c8/0xbf8
> [ 9594.512349][  T191]  kthread+0x3ac/0x460
> [ 9594.516291][  T191]  ret_from_fork+0x10/0x18
> 
> 
>>
>> This is based of 5.12-rc2. I will merge these via the arm-cpufreq tree
>> directly.
>>
>> Changes since V5:
>> - New patch to rename freq_scale to arch_freq_scale (Will Deacon).
>> - Separate patch to export arch_freq_scale and helpers (Will Deacon).
>> - Some improvements in the last patch like commit log, moving more stuff
>>   to policy init, new fie_disabled flag, etc. (Ionela Voinescu).
>> - Added Reviewed/Acked/Tested-by tags.
>>
>> Changes since V4:
>> - Move some code to policy specific initialization for cppc driver.
>> - Initialize kthread specific stuff only once in cppc driver.
>> - Added a kerneldoc comment in cppc driver and improved changelog as
>>   well.
>>
>> Changes since V3:
>> - rebuild_sched_domains_energy() stuff moved from arm64 to drivers/base.
>> - Added Reviewed/Tested-by Ionela for the first patch.
>> - Remove unused max_freq field from structure in cppc driver.
>> - s/cppc_f_i/cppc_freq_inv.
>> - Fix an per-cpu access, there was a bug in earlier version.
>> - Create a single kthread which can run on any CPU and takes care of
>>   work from all the CPUs.
>> - Do the whole FIE thing under a new CONFIG option for cppc driver.
>> - Few minor improvements.
>>
>> Changes since V2:
>> - Not sending as an RFC anymore.
>> - Several renames, reordering of code in 1/2 based on Ionela's comments.
>> - Several rebase changes for 2/2.
>> - The freq_scale calculations are optimized a bit.
>> - Better overall commenting and commit logs.
>>
>> Changes since V1:
>> - The interface for setting the callbacks is improved, so different
>>   parts looking to provide their callbacks don't need to think about
>>   each other.
>>
>> - Moved to per-cpu storage for storing the callback related data, AMU
>>   counters have higher priority with this.
>>
>> --
>> Viresh
>>
>> Viresh Kumar (4):
>>   arch_topology: Rename freq_scale as arch_freq_scale
>>   arch_topology: Allow multiple entities to provide sched_freq_tick()
>>     callback
>>   arch_topology: Export arch_freq_scale and helpers
>>   cpufreq: CPPC: Add support for frequency invariance
>>
>>  arch/arm64/include/asm/topology.h |  10 +-
>>  arch/arm64/kernel/topology.c      | 109 +++++--------
>>  drivers/base/arch_topology.c      |  89 ++++++++++-
>>  drivers/cpufreq/Kconfig.arm       |  10 ++
>>  drivers/cpufreq/cppc_cpufreq.c    | 245 ++++++++++++++++++++++++++++--
>>  include/linux/arch_topology.h     |  19 ++-
>>  kernel/sched/core.c               |   1 +
>>  7 files changed, 385 insertions(+), 98 deletions(-)
>>
>>
>> base-commit: a38fd8748464831584a19438cbb3082b5a2dab15
>>
