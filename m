Return-Path: <linux-acpi+bounces-19890-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AFBCE929B
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Dec 2025 10:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D90A8302F6A0
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Dec 2025 09:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D7727F4CA;
	Tue, 30 Dec 2025 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pujkHNxu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756D127E7EC;
	Tue, 30 Dec 2025 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767085799; cv=none; b=D/bxvTUNtiBNftzmqvdjEkJP/jdznreXoyjXm4FRNg6G/SPVYoph4WErRjCqCMWYkzHH5D9Apeph4EMqzYWuzD4xt+e1U7+dWxX51J3auBPg/Z0AnRCS3PWFc3IX8etHITUWcYWEGmjJhGApkBuwoi87oEFqi1NXeFJZNvEQ8Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767085799; c=relaxed/simple;
	bh=s/j65Mmpx0Nrco5NVZ5iT6wJB4RbrWqrZDzAt7QZTNk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rodsi5y3JnEqCM2WLN/Ekhrr1Wdy77hwAZhFgnwdlVZFxZSZoHstNtIf4jQzPw8zscPRDm7d+34ZFInKpk1V59zYM3E+1yGbel7xCW2y/NH26zgzigzKMolLS2PSTkf9Ps70E1myi6SqCM/wihsCr/zIE6xIxnGUhdbFj2Fj+U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pujkHNxu; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767085790; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=R37K5bnkFLlaLsxncXYszF8Zty1Riqbzy6aJpYTk1eY=;
	b=pujkHNxuOvgkDL7A2g/ebNkXKi+OrQXIqVE8Ah7ossdJs1f26HZfGkD4tao0Eo7NnqH2OgoBVjGU1xCoEj8SG0noyS+tdgGkx/lgbUA4eqy2p9IxbhJIfUQSWQ3fpPCAbW4CV7gCnxK/wSFoVshyoz6VWP/YfW6Xjhe3EJH7z0g=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WvzWb5._1767085788 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Dec 2025 17:09:50 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	lpieralisi@kernel.org,
	guohanjun@huawei.com,
	sudeep.holla@arm.com,
	xueshuai@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org,
	lenb@kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	yazen.ghannam@amd.com,
	misono.tomohiro@fujitsu.com,
	fengwei_yin@linux.alibaba.com
Cc: tianruidong@linux.alibaba.com
Subject: [PATCH v5 00/17] ARM Error Source Table V2 Support
Date: Tue, 30 Dec 2025 17:09:28 +0800
Message-Id: <20251230090945.43969-1-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series introduces support for the ARM Error Source Table (AEST), aligning
with version 2.0 of ACPI for Armv8 RAS Extensions [0].

AEST provides a critical mechanism for hardware to directly notify the
operating system kernel about RAS errors via interrupts, a concept known as
Kernel-first error handling. Compared to firmware-first error handling
(e.g., GHES), AEST offers a more lightweight approach. This efficiency allows
the OS to potentially report every Corrected Error (CE), enabling upper-layer
applications to leverage CE information for error prediction[1][2].

This series is based on Tyler Baicar's preliminary patches [3], which have not
yet been sent to the mailing list as v2.

AEST Driver Architecture
========================

The AEST driver is structured into three primary components:
  - AEST device: Responsible for handling interrupts, managing the lifecycle
                 of AEST nodes, and processing error records.
  - AEST node: Corresponds directly to a RAS node in the hardware
  - AEST record: Represents a set of RAS registers associated with a specific
                 error source.

These components are organized hierarchically as follows:

 ┌──────────────────────────────────────────────────┐
 │             AEST Driver Device Management        │
 │┌─────────────┐    ┌──────────┐     ┌───────────┐ │
 ││ AEST Device ├─┬─►│AEST Node ├──┬─►│AEST Record│ │
 │└─────────────┘ │  └──────────┘  │  └───────────┘ │
 │                │       .        │  ┌───────────┐ │
 │                │       .        ├─►│AEST Record│ │
 │                │       .        │  └───────────┘ │
 │                │  ┌──────────┐  │        .       │
 │                ├─►│AEST Node │  │        .       │
 │                │  └──────────┘  │        .       │
 │                │                │  ┌───────────┐ │
 │                │  ┌──────────┐  └─►│AEST Record│ │
 │                └─►│AEST Node │     └───────────┘ │
 │                   └──────────┘                   │
 └──────────────────────────────────────────────────┘

AEST Interrupt Handle
=====================

Upon an AEST interrupt, the driver performs the following sequence:
1. The AEST device iterates through all registered AEST nodes to identify the
   specific node(s) and record(s) that reported an error.
2. Each node typically contains two types of records:
      - report record: Errors can be located efficiently through a bitmap
                       in the `ERRGSR` register.
      - poll record: The node must individually poll all records to determine
                     if an error has occurred.
3. process record:
      - if error is corrected, The CE threshold is reset, and the error event
        is logged.
      - if error is defered, Relevant registers are dumped, and
        `memory_failure()` is invoked.
      - if error is uncorrected, panic, While UEs typically trigger an
        exception rather than an interrupt, if detected, the system will panic.
4. decode record: The AEST driver notifies other relevant drivers, such as
   EDAC, to further decode the reported RAS register information.

Address Translation
===================

As described in section 2.2 [0], error addresses reported by AEST records
may be "node-specific Logical Addresses" rather than the "System Physical
Addresses" (SPA) used by the kernel. Therefore, the driver needs to translate
these Logical Addresses (LA) to SPA. This translation mechanism is conceptually
similar to AMD's Address Translation Logic (ATL) [4], leading patch 0014 to
introduce a common translation function for both AMD and ARM architectures.

Testing
===================
I have tested this series on THead Yitian710 SOC with customized BIOS. Someone
can also use QEMU[5] for preliminary driver testing.

1. Boot Qemu

qemu-system-aarch64 -smp 4 -m 32G \
  -cpu host --enable-kvm -machine virt,gic-version=3 \
  -kernel Image -initrd initrd.cpio.gz \
  -device virtio-net-pci,netdev=t0 -netdev user,id=t0 \
  -bios /usr/share/edk2/aarch64/QEMU_EFI.fd  \
  -append "rdinit=/sbin/init earlycon verbose debug console=ttyAMA0 aest.dyndbg='+pt'" \
  -nographic -d guest_errors -D qemu.log

2. inject error
devmem 0x90d0808 l 0xc4800390

2.1 Memory error
[   64.959849] AEST: {1}[Hardware Error]: Hardware error from AEST memory.90d0000
[   64.959852] AEST: {1}[Hardware Error]:  Error from memory at SRAT proximity domain 0x0
[   64.959855] AEST: {1}[Hardware Error]:   ERR0FR: 0x40000080044081
[   64.959858] AEST: {1}[Hardware Error]:   ERR0CTRL: 0x108
[   64.959859] AEST: {1}[Hardware Error]:   ERR0STATUS: 0xc4800390
[   64.959860] AEST: {1}[Hardware Error]:   ERR0ADDR: 0x8400000043344521
[   64.959861] AEST: {1}[Hardware Error]:   ERR0MISC0: 0x7fff00000000
[   64.959861] AEST: {1}[Hardware Error]:   ERR0MISC1: 0x0
[   64.959862] AEST: {1}[Hardware Error]:   ERR0MISC2: 0x0
[   64.959863] AEST: {1}[Hardware Error]:   ERR0MISC3: 0x0
[   64.959873] Memory failure: 0x43344: recovery action for free buddy page: Recovered

2.2 CMN error
[  132.044283] AEST: {2}[Hardware Error]: Hardware error from AEST XP
[  132.044286] AEST: {2}[Hardware Error]:  Error from vendor hid ARMHC700 uid 0x0
[  132.044288] AEST: {2}[Hardware Error]:   ERR0FR: 0x48a5
[  132.044290] AEST: {2}[Hardware Error]:   ERR0CTRL: 0x108
[  132.044292] AEST: {2}[Hardware Error]:   ERR0STATUS: 0xc4800390
[  132.044293] AEST: {2}[Hardware Error]:   ERR0ADDR: 0x8400000043344521
[  132.044295] AEST: {2}[Hardware Error]:   ERR0MISC0: 0x0
[  132.044296] AEST: {2}[Hardware Error]:   ERR0MISC1: 0x0
[  132.044298] AEST: {2}[Hardware Error]:   ERR0MISC2: 0x0
[  132.044299] AEST: {2}[Hardware Error]:   ERR0MISC3: 0x0
[  132.044302] Memory failure: 0x43344: recovery action for already poisoned page: Failed

[0]: https://developer.arm.com/documentation/den0085/0101/
[1]: Intel: Predicting Uncorrectable Memory Errors from the Correctable Error History
[2]: Alibaba. Predicting DRAM-Caused Risky VMs in Large-Scale Clouds. Published in HPCA2025
[3]: https://lore.kernel.org/all/20211124170708.3874-1-baicar@os.amperecomputing.com/
[4]: https://lore.kernel.org/all/20240123041401.79812-2-yazen.ghannam@amd.com/
[5]: https://github.com/winterddd/qemu/tree/error_record

Change from V4:
https://lore.kernel.org/all/20251222094351.38792-1-tianruidong@linux.alibaba.com/
1. Fix build warning in 0010 and 0014 report by kernel test robot:
    https://lore.kernel.org/all/202512230122.CfXZcF76-lkp@intel.com/
    https://lore.kernel.org/all/202512230007.Vs6IvFVD-lkp@intel.com/
2. Dropped the extra patch(0014) that was mistakenly included in v4.

Change from V3:
https://lore.kernel.org/all/20250115084228.107573-1-tianruidong@linux.alibaba.com/
1. Add vendor AEST node framework and support CMN700
2. Borislav Petkov
    - Split into multiple smaller patches for easier review.
    - refined the English in the cover letter for better flow.
3. Accept Tomohiro Misono's comment

Change from V2:
https://lore.kernel.org/all/20240321025317.114621-1-tianruidong@linux.alibaba.com/
1. Tomohiro Misono
    - dump register before panic
2. Baolin Wang & Shuai Xue: accept all comment.
3. Support AEST V2.

Change from V1:
https://lore.kernel.org/all/20240304111517.33001-1-tianruidong@linux.alibaba.com/
1. Marc Zyngier
  - Use readq/writeq_relaxed instead of readq/writeq for MMIO address.
  - Add sync for system register operation.
  - Use irq_is_percpu_devid() helper to identify a per-CPU interrupt.
  - Other fix.
2. Set RAS CE threshold in AEST driver.
3. Enable RAS interrupt explicitly in driver.
4. UER and UEO trigger memory_failure other than panic.

Ruidong Tian (17):
  ACPI/AEST: Parse the AEST table
  ras: AEST: Add probe/remove for AEST driver
  ras: AEST: support different group format
  ras: AEST: Unify the read/write interface for system and MMIO register
  ras: AEST: Probe RAS system architecture version
  ras: AEST: Support RAS Common Fault Injection Model Extension
  ras: AEST: Support CE threshold of error record
  ras: AEST: Enable and register IRQs
  ras: AEST: Add cpuhp callback
  ras: AEST: Introduce AEST driver sysfs interface
  ras: AEST: Add error count tracking and debugfs interface
  ras: AEST: Allow configuring CE threshold via debugfs
  ras: AEST: Introduce AEST inject interface to test AEST driver
  ras: ATL: Unify ATL interface for ARM64 and AMD
  ras: AEST: Add framework to process AEST vendor node
  ras: AEST: support vendor node CMN700
  trace, ras: add ARM RAS extension trace event

 Documentation/ABI/testing/debugfs-aest |   99 +++
 MAINTAINERS                            |   11 +
 arch/arm64/include/asm/arm-cmn.h       |   47 ++
 arch/arm64/include/asm/ras.h           |   95 +++
 drivers/acpi/arm64/Kconfig             |   11 +
 drivers/acpi/arm64/Makefile            |    1 +
 drivers/acpi/arm64/aest.c              |  311 +++++++
 drivers/edac/amd64_edac.c              |    2 +-
 drivers/perf/arm-cmn.c                 |   37 +-
 drivers/ras/Kconfig                    |    1 +
 drivers/ras/Makefile                   |    1 +
 drivers/ras/aest/Kconfig               |   17 +
 drivers/ras/aest/Makefile              |    8 +
 drivers/ras/aest/aest-cmn.c            |  332 ++++++++
 drivers/ras/aest/aest-core.c           | 1057 ++++++++++++++++++++++++
 drivers/ras/aest/aest-inject.c         |  131 +++
 drivers/ras/aest/aest-sysfs.c          |  228 +++++
 drivers/ras/aest/aest.h                |  410 +++++++++
 drivers/ras/amd/atl/core.c             |    4 +-
 drivers/ras/amd/atl/internal.h         |    2 +-
 drivers/ras/amd/atl/umc.c              |    5 +-
 drivers/ras/amd/fmpm.c                 |    2 +-
 drivers/ras/ras.c                      |   27 +-
 include/linux/acpi_aest.h              |   75 ++
 include/linux/cpuhotplug.h             |    1 +
 include/linux/ras.h                    |   17 +-
 include/ras/ras_event.h                |   71 ++
 27 files changed, 2942 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-aest
 create mode 100644 arch/arm64/include/asm/arm-cmn.h
 create mode 100644 arch/arm64/include/asm/ras.h
 create mode 100644 drivers/acpi/arm64/aest.c
 create mode 100644 drivers/ras/aest/Kconfig
 create mode 100644 drivers/ras/aest/Makefile
 create mode 100644 drivers/ras/aest/aest-cmn.c
 create mode 100644 drivers/ras/aest/aest-core.c
 create mode 100644 drivers/ras/aest/aest-inject.c
 create mode 100644 drivers/ras/aest/aest-sysfs.c
 create mode 100644 drivers/ras/aest/aest.h
 create mode 100644 include/linux/acpi_aest.h

-- 
2.47.3


