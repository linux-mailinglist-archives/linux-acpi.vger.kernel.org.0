Return-Path: <linux-acpi+bounces-16561-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2F9B51295
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 11:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 028227B4AD4
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 09:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEA3313E18;
	Wed, 10 Sep 2025 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="i10WYDv7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41027312807;
	Wed, 10 Sep 2025 09:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757496844; cv=none; b=bJZHxYbQKInhAMkzroEAb1Dqui4naVS39JkAK7kVcxy6WnuUU23sV+14Cb0QgMz9OQ68ILBlNFAoI+IEX7yiJns7Knsz9Q2DGi2Ypg86yEcnsEyp5EivhJNw8BsAJdbMqBQSTsfNEHwrucAOTwWZGTM6MzOZJirlYM1oexsLJR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757496844; c=relaxed/simple;
	bh=Cj4I9JJrSQKu7kDeTHshNLcQrlZ2TEFNJRQmrPSoc00=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=OpbWYXQk4I1ISDdu2l6S9s4heH20QGT5OQJk6SjhZeA50hr39gmsESOUN2OTE9bH5/ccTddZnLxYJl6pn3+mteVoSDLQqNRivjtrzURlbpgnYmtON2VIAh8zK4wq38DyRnyHS49TDy0gtOp98m7Q36gpkGZe/J8bDrnz/T2ZSeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=i10WYDv7; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757496833; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=kUn2anvFDF2qqR807aTGWlj36Qp+tfcJksS6Q6qbn5w=;
	b=i10WYDv7wFS8ypa8W+sVUlo1Ue1rsfI4Rk/DU3D/Mky8aUMgXRv2prz1H4uGBecdqgXlKX5TLWaJ5UKZos4KuvvoXoBAVRuv9p6K2FPMUQ3QRSRtzpvmM16EW6hA62WNQZ753c3wuDOFGHsBBhenZt/J8rgZ8rEuC+Q0JJ58vPo=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WnhgSX4_1757496830 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Sep 2025 17:33:52 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: xueshuai@linux.alibaba.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: james.morse@arm.com,
	tony.luck@intel.com,
	cleger@rivosinc.com,
	hchauhan@ventanamicro.com,
	tianruidong@linux.alibaba.com
Subject: [RFC PATCH 0/5] riscv: Handle synchronous hardware error exception
Date: Wed, 10 Sep 2025 17:33:42 +0800
Message-Id: <20250910093347.75822-1-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,
This patch series introduces support for handling synchronous hardware errors 
on RISC-V, laying the groundwork for more robust kernel-mode error recovery.

1. Background
Hardware error reporting mechanisms typically fall into two categories: 
asynchronous and synchronous.

- Asynchronous errors (e.g., memory scrubbing errors) repoted by a asynchronous
exceptions or a interrupt, are usually handled by GHES subsystems. For instance,
ARM uses SDEI, and a similar SSE specification is being proposed for RISC-V.
- Synchronous errors (e.g., reading poisoned data) cause the processor core to 
take a precise exception. This is known as a Synchronous External Abort (SEA)
on ARM, a Machine Check Exception (MCE) on x86, and is designated as trap with
mcause 19 on RISC-V.

Discussions within the RVI PRS TG have already led to proposals[0] to UEFI for 
standardizing two notification methods, SSE and Hardware Error Exception, 
on RISC-V. 
This series focuses on implementing Hardware Error Exception notification to
handle synchronous errors. Himanshu Chauhan has already started working on SSE[1].

2. Motivation
While a synchronous hardware errors occurring in kernel context (e.g., during 
get_user, put_user, CoW, etc.). The kernel requires a fixup mechanism (via
extable) to recover from such errors and prevent a system panic. However, the 
APEI/GHES subsystem, being asynchronous, cannot directly leverage the synchronous
extable fixup path.

By handling the synchronous exception directly, we enable the use of this fixup
mechanism, allowing the kernel to gracefully recover from hardware errors
encountered during kernel execution. This brings RISC-V's error handling
capabilities closer to the robustness found on ARM[2] and x86[3].

3. What This Patch Series Does
This initial series lays the foundational infrastructure. It primarily:
- Introduces a new exception handler for synchronous hardware errors (mcause=19).
- Establishes the core exception path, which is a prerequisite for kernel
  context error recovery.

Please note that this version does not yet implement the full kernel fixup logic
for recovery. That functionality is planned for the next formal version.

Some adaptations for GHES are included, based on the work from Himanshu Chauhan[1]

4. Future Plans
- Implement full kernel fixup support to handle and recover from errors in 
  some kernel context[2].
- Add support for handling "double trap" scenarios.

5. Testing Methodology

test program: ras-tools: https://kernel.googlesource.com/pub/scm/linux/kernel/git/aegl/ras-tools/
qemu: https://github.com/winterddd/qemu
offcial opensbi and edk2:

- Run qemu:
qemu-system-riscv64 -M virt,pflash0=pflash0,pflash1=pflash1,acpi=on,aia=aplic-imsic 
 -cpu max -m 64G -smp 64 -device virtio-gpu-pci -full-screen -device qemu-xhci 
 -device usb-kbd -device virtio-rng-pci 
 -blockdev node-name=pflash0,driver=file,read-only=on,filename=RISCV_VIRT_CODE.fd 
 -blockdev node-name=pflash1,driver=file,filename=RISCV_VIRT_VARS.fd 
 -bios fw_dynamic.bin -device virtio-net-device,netdev=net0 
 -netdev user,id=net0,hostfwd=tcp::2223-:22 
 -kernel Image -initrd rootfs
 -append "rdinit=/sbin/init earlycon verbose debug strict_devmem=0 nokaslr" 
 -monitor telnet:127.0.0.1:5557,server,nowait -nographic

- Run ras-tools:
./einj_mem_uc -j -k single &
$ 0: single   vaddr = 0x7fff86ff4400 paddr = 107d11b400

- Inject poison
telnet localhost 5557
poison_enable on
poison_add 0x107d11b400

- Read poison
echo trigger > ./trigger_start
$ triggering ...
$ signal 7 code 3 addr 0x7fff86ff4400

[0]: https://lists.riscv.org/g/tech-prs/topic/risc_v_ras_related_ecrs/113685653 
[1]: https://patchew.org/linux/20250227123628.2931490-1-hchauhan@ventanamicro.com/
[2]: https://lore.kernel.org/lkml/20241209024257.3618492-1-tongtiangen@huawei.com/
[3]: https://github.com/torvalds/linux/blob/9dd1835ecda5b96ac88c166f4a87386f3e727bd9/arch/x86/kernel/cpu/mce/core.c#L1514

Himanshu Chauhan (2):
  riscv: Define ioremap_cache for RISC-V
  riscv: Define arch_apei_get_mem_attribute for RISC-V

Ruidong Tian (3):
  acpi: Introduce SSE and HEE in HEST notification types
  riscv: Introduce HEST HEE notification handlers for APEI
  riscv: Add Hardware Error Exception trap handler

 arch/riscv/Kconfig              |  1 +
 arch/riscv/include/asm/acpi.h   | 22 +++++++++++++
 arch/riscv/include/asm/fixmap.h |  6 ++++
 arch/riscv/include/asm/io.h     |  3 ++
 arch/riscv/kernel/acpi.c        | 55 +++++++++++++++++++++++++++++++
 arch/riscv/kernel/entry.S       |  4 +++
 arch/riscv/kernel/traps.c       | 19 +++++++++++
 drivers/acpi/apei/Kconfig       | 12 +++++++
 drivers/acpi/apei/ghes.c        | 58 +++++++++++++++++++++++++++++++++
 include/acpi/actbl1.h           |  4 ++-
 include/acpi/ghes.h             |  6 ++++
 11 files changed, 189 insertions(+), 1 deletion(-)

-- 
2.43.7


