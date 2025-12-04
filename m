Return-Path: <linux-acpi+bounces-19421-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A36CA3539
	for <lists+linux-acpi@lfdr.de>; Thu, 04 Dec 2025 11:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56A6A302B9A2
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Dec 2025 10:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734E3336ED0;
	Thu,  4 Dec 2025 10:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMf+2J7/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473F0335BA6;
	Thu,  4 Dec 2025 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764845780; cv=none; b=JGe+qg3yI1ms1ILnj+qzOGzhXJ+/mTbTAiTFWYRcEhop3A7q6jh/rgCZsELm90Wte1IZVNcKb1g6ZA7jQFwm1k9o9mYfXVao/M0D4RtDugovO7nJuIgyIta1AxvDs8j5Wfry4JETvGyT5CT0vxQ4LcrWqiNus1960IPPqQclokc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764845780; c=relaxed/simple;
	bh=7svOgdyIfaLm3DHIa2l+XqDfoI2IEBo3sAJCu9Jwlq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3DszRkPdL6Ld9Bp3lh264UWT5zptwFkQAKw7W39cpCj1RQZWaCV4x1dR+9kEvjmwVEAMyzUEIiW1K1h4fKzXlCLlQm6kDxeNw87UKUDMEYheApy/lKPqhkhEzvLeVoFBRHpt5vLBQ88Cm4jc00RP9wJQEDR3ajFumpHamN9mxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMf+2J7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39AB8C4CEFB;
	Thu,  4 Dec 2025 10:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764845779;
	bh=7svOgdyIfaLm3DHIa2l+XqDfoI2IEBo3sAJCu9Jwlq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vMf+2J7/mSFOgQ9GXzzs4r8eCEcsaQlHhuJaQqcX+IQrrNFXFHIebaQ0xeUQzi1bD
	 NFh1n75R+S6/OXX4cssPtAxI2YDjj+iSTeta6zrG2TE13h+z0PaWzTuKeNvYLQZayq
	 H/S60WulXcI2GmJ9/9Tj8gSznk0MGrgyXGWp74MYSR8tg0x937wZkCjSp98X3pTuk7
	 vFRLsqyi46b/1P5z3GBPcKjJQqevh6zF3ZT1ChpYTtfBMPbOANSNYbxsioEyOu4bFa
	 810f4XvtmLwqKPPfiR7fonp6GhwdzrFTSi4CE/73od3XR5CZfdeSTYYKU3mkly1Q4H
	 JKDlMtQybrt5Q==
Date: Thu, 4 Dec 2025 10:56:13 +0000
From: Daniel Thompson <danielt@kernel.org>
To: Marc Zyngier <maz@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	James Clark <james.clark@linaro.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	linux-mips@vger.kernel.org
Subject: Re: [PATCH v4 16/26] genirq: Allow per-cpu interrupt sharing for
 non-overlapping affinities
Message-ID: <aTFozefMQRg7lYxh@aspen.lan>
References: <20251020122944.3074811-1-maz@kernel.org>
 <20251020122944.3074811-17-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020122944.3074811-17-maz@kernel.org>

On Mon, Oct 20, 2025 at 01:29:33PM +0100, Marc Zyngier wrote:
> Interrupt sharing for percpu-devid interrupts is forbidden, and
> for good reasons. These are interrupts generated *from* a CPU and
> handled by itself (timer, for example). Nobody in their right mind
> would put two devices on the same pin (and if they have, they get to
> keep the pieces...).
>
> But this also prevents more benign cases, where devices are connected
> to groups of CPUs, and for which the affinities are not overlapping.
> Effectively, the only thing they share is the interrupt number, and
> nothing else.
>
> Let's tweak the definition of IRQF_SHARED applied to percpu_devid
> interrupts to allow this particular case. This results in extra
> validation at the point of the interrupt being setup and freed,
> as well as a tiny bit of extra complexity for interrupts at handling
> time (to pick the correct irqaction).
>
> Tested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

I picked up this patch via linux-next and it appears be causing boot
regressions on MIPS/qemu. This patch was identified with a bisect and
a git revert of this patch from the linux-next tip resolves the problem
(specifically, next-20251204 with git revert bdf4e2ac295f).

I'm running the code as part of the kgdb test suite but the system
doesn't survive long enough for kgdb to be involved. In fact I was able
to reduce things to the following reproduction with all the kgdb pieces
removed:

    make malta_kvm_defconfig generic/64r6.config
    ../scripts/config \
        --enable WERROR --enable CPU_MIPS64_R6 --enable MIPS_CPS \
	--enable BLK_DEV_INITRD --set-val FRAME_WARN 2048
    make olddefconfig
    make -j$(nproc) all
    qemu-system-mips64el -cpu I6400 -M malta -m 1G -smp 2 \
        -kernel vmlinux -nographic \
	-append " console=ttyS0,115200 clk_ignore_unused"

The stack dumps continually so I have to abridge the logs but the logs
to second stack trace are:

~~~
Linux version 6.18.0-next-20251204 (drt@wychelm) (mips64el-linux-gcc.br_real (Buildroot 2025.02.8) 14.3.0, GNU ld (GNU Binutils) 2.44) #20 SMP Thu Dec  4 10:37:28 GMT 2025
earlycon: uart8250 at I/O port 0x3f8 (options '38400n8')
printk: legacy bootconsole [uart8250] enabled
CPU0 revision is: 0001a900 (MIPS I6400)
FPU revision is: 20f30300
MSA revision is: 00000300
MIPS: machine is mti,malta
Software DMA cache coherency enabled
Initial ramdisk at: 0x900000000fc40000 (3818338 bytes)
OF: reserved mem: Reserved memory: No reserved-memory node in the DT
VP topology {2} total 2
Primary instruction cache 64kB, VIPT, 4-way, linesize 64 bytes.
Primary data cache 64kB, 4-way, PIPT, no aliases, linesize 64 bytes
Zone ranges:
  DMA      [mem 0x0000000000000000-0x0000000000ffffff]
  DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
  Normal   empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000000000-0x000000000fffffff]
  node   0: [mem 0x0000000090000000-0x00000000bfffffff]
Initmem setup node 0 [mem 0x0000000000000000-0x00000000bfffffff]
On node 0, zone DMA32: 131072 pages in unavailable ranges
random: crng init done
percpu: Embedded 7 pages/cpu s69728 r8192 d36768 u114688
Kernel command line: rd_start=0xffffffff8fc40000 rd_size=3818338  console=ttyS0,115200 kgdboc=ttyS0 clk_ignore_unused
Unknown kernel command line parameters "kgdboc=ttyS0", will be passed to user space.
printk: log buffer data + meta data: 32768 + 114688 = 147456 bytes
Dentry cache hash table entries: 131072 (order: 6, 1048576 bytes, linear)
Inode-cache hash table entries: 65536 (order: 5, 524288 bytes, linear)
Cache parity protection disabled
MAAR configuration:
  [0]: 0x0000000000000000-0x000000000fffffff speculate
  [1]: 0x0000000090000000-0x00000000bfffffff speculate
  [2]: disabled
  [3]: disabled
  [4]: disabled
  [5]: disabled
  [6]: disabled
  [7]: disabled
Built 1 zonelists, mobility grouping on.  Total pages: 65536
mem auto-init: stack:all(zero), heap alloc:off, heap free:off
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
rcu: Hierarchical RCU implementation.
rcu: 	RCU event tracing is enabled.
	Tracing variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
RCU Tasks Trace: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=2.
NR_IRQS: 256
rcu: srcu_init: Setting srcu_struct sizes based on contention.
CPU frequency 320.00 MHz
GIC frequency 100.00 MHz
clocksource: GIC: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19113045595 ns
sched_clock: 32 bits at 100MHz, resolution 10ns, wraps every 21475332090ns
clocksource: MIPS: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 11945377117 ns
Console: colour dummy device 80x25
Calibrating delay loop...
CPU 0 Unable to handle kernel paging request at virtual address 0000000000000000, epc == ffffffff801c2398, ra == ffffffff801bab00
Oops[#1]:
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.18.0-next-20251204 #20 NONE
Hardware name: mti,malta
$ 0   : 0000000000000000 0000000000000001 0000000000000000 0000000000000000
$ 4   : 0000000000000001 a8000000020e8008 0000000000000000 ffffffff80c23b80
$ 8   : 0000000000000004 0000000000000000 0000000000000000 000000000000002f
$12   : a8000000020f4000 0000000000003ff0 0000000000003000 0000000000000003
$16   : ffffffff80d095c0 ffffffff80ceb410 0000000000000019 ffffffff80c378c0
$20   : ffffffff80c4bec8 0000000000000000 ffffffff80e00000 ffffffff80de0000
$24   : 0000000000000000 0000000000000010
$28   : ffffffff80c20000 a8000000020f7ec0 a800000000e12fcd ffffffff801bab00
epc   : ffffffff801c2398 handle_percpu_devid_irq+0xb8/0x250
ra    : ffffffff801bab00 handle_irq_desc+0x48/0x88
Status: 1400a4e2	KX SX UX KERNEL EXL
Cause : 00800408 (ExcCode 02)
BadVA : 0000000000000000
PrId  : 0001a900 (MIPS I6400)
Modules linked in:
Process swapper/0 (pid: 0, threadinfo=(____ptrval____), task=(____ptrval____), tls=0000000000000000)
Stack : ffffffff80c35a2c 0000000000000002 ffffffff80e00000 0fffffffffffffff
        ffffffff80c50000 0000000000000001 0000000000000003 ffffffff801bab00
        0000000000000000 ffffffff805d82a8 0000000000000000 0000000000000008
        0000000000000000 0000000000000000 0000000000000000 5189d95a7a4f4800
        a800000002014300 0000000000000002 0000000000000001 000000000000001f
        ffffffff80e00000 0000000000000004 0000000000000000 ffffffff801bab00
        0000000000000000 ffffffff809ec128 0000000000000001 fffffffffffffffb
        0000000000000001 ffffffff805d7ebc 0000000000000000 0000000000000000
        ffffffff80c23c80 ffffffff80c50000 ffffffff80de0000 ffffffff80db0000
        0000000000000000 ffffffff80112f10 ffffffff80c23c80 0000000000000000
Call Trace:
[<ffffffff801c2398>] handle_percpu_devid_irq+0xb8/0x250
[<ffffffff801bab00>] handle_irq_desc+0x48/0x88
[<ffffffff805d82a8>] gic_irq_dispatch+0xc0/0x288
[<ffffffff801bab00>] handle_irq_desc+0x48/0x88
[<ffffffff809ec128>] do_domain_IRQ+0x28/0x40
[<ffffffff805d7ebc>] plat_irq_dispatch+0x64/0xe8
[<ffffffff80112f10>] handle_int+0x134/0x140
[<ffffffff80110dc8>] calibrate_delay+0x158/0x290
[<ffffffff80d58e48>] start_kernel+0x754/0x7a4

Code: da000048  de020010  0043102d <dc420000> 00c21016  30420001  d85ffff8  00000000  00000000

CPU 0 Unable to handle kernel paging request at virtual address 0000000000000000, epc == ffffffff801c2398, ra == ffffffff801bab00
Oops[#2]:
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G      D             6.18.0-next-20251204 #20 NONE
Tainted: [D]=DIE
Hardware name: mti,malta
$ 0   : 0000000000000000 0000000000000001 0000000000000000 0000000000000000
$ 4   : 0000000000000002 a8000000020e8008 0000000000000000 a8000000020f7ae0
$ 8   : 0000000000000004 0000000000000000 0000000000000000 0000000000000000
$12   : a8000000020f4000 a8000000020f4000 0000000000003000 0000000000000000
$16   : ffffffff80d095c0 ffffffff80ceb410 0000000000000019 ffffffff80c378c0
$20   : ffffffff80c4bec8 0000000000000000 ffffffff80e00000 0000000000000001
$24   : 0000000000000000 ffffffffffffffff
$28   : ffffffff80c20000 a8000000020f7ab0 a800000000e12fcd ffffffff801bab00
epc   : ffffffff801c2398 handle_percpu_devid_irq+0xb8/0x250
ra    : ffffffff801bab00 handle_irq_desc+0x48/0x88
Status: 1400a4e2	KX SX UX KERNEL EXL
Cause : 00800408 (ExcCode 02)
BadVA : 0000000000000000
PrId  : 0001a900 (MIPS I6400)
Modules linked in:
Process swapper/0 (pid: 0, threadinfo=(____ptrval____), task=(____ptrval____), tls=0000000000000000)
Stack : ffffffff80c50000 0000000000000002 ffffffff80e00000 0fffffffffffffff
        ffffffff80c50000 0000000000000001 0000000000000003 ffffffff801bab00
        0000000000000000 ffffffff805d82a8 a8000000020f7bd8 ffffffff801b94f4
        0000000000000000 0000000000000000 ffffffff80c4bc10 5189d95a7a4f4800
        a800000002014300 0000000000000002 0000000000000001 000000000000001f
        ffffffff80e00000 0000000000000004 0000000000000000 ffffffff801bab00
        0000000000000001 ffffffff809ec128 0000000000000000 fffffffffffffffb
        0000000000000001 ffffffff805d7ebc ffffffff80c7b558 ffffffff80c23c80
        a8000000020f7be0 ffffffff80b2fcb8 ffffffff80de0000 ffffffff80c4bec8
        ffffffff80c515c0 ffffffff80112f10 0000000000000000 0000000000000001
        ...
Call Trace:
[<ffffffff801c2398>] handle_percpu_devid_irq+0xb8/0x250
[<ffffffff801bab00>] handle_irq_desc+0x48/0x88
[<ffffffff805d82a8>] gic_irq_dispatch+0xc0/0x288
[<ffffffff801bab00>] handle_irq_desc+0x48/0x88
[<ffffffff809ec128>] do_domain_IRQ+0x28/0x40
[<ffffffff805d7ebc>] plat_irq_dispatch+0x64/0xe8
[<ffffffff80112f10>] handle_int+0x134/0x140
[<ffffffff8011a730>] die+0xa8/0xf8
[<ffffffff80134680>] do_page_fault+0x530/0x540
[<ffffffff8013a1a8>] tlb_do_page_fault_0+0x108/0x110
[<ffffffff801bab00>] handle_irq_desc+0x48/0x88

Code: da000048  de020010  0043102d <dc420000> 00c21016  30420001  d85ffff8  00000000  00000000
~~~

FWIW I'm using a buildroot gcc-14 toolchain but I've seen the same problem on
gcc-13 in previous kgdbtest logs.


Daniel.

