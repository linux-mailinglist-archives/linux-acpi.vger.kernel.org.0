Return-Path: <linux-acpi+bounces-10671-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40ACA11C40
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 09:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E67547A1709
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 08:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F081DB12F;
	Wed, 15 Jan 2025 08:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RSDmiNf1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E9E23F262;
	Wed, 15 Jan 2025 08:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736930565; cv=none; b=DeqKeNPWQ5z5eCfRhtZUv2lpvAz4+BX8BL2vcfZYKItBboULkZ/UTVg9msqkFPVZGX53nvRkO4iqwkTVOB0WZARlgOBHWQf3KTVWHYbRQQHgRAAoiRJJmMALXeWRnKT+kaIkI2D6tJFRqmhAvNqfkrLqXc/Y8H/pVd9cO1954Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736930565; c=relaxed/simple;
	bh=tEgsshAbUBioHoQkOp09L8D6p68ZegkgFQ31uJGj4hg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=g+BAEJXItbTjlbbAopWR741YA0qlxkQiWLVV1QO1bLWcCJAl2MI9tmKczWFD2IJEedRF+uw0PID9B5Moix8Ga2BOv8fwQ91FOHAkmzQB+EXM8/4HwdJnfb/fFApSf3iSf7X5e4CYLzsu/qZSQ5031VQ8ajZIr+qxU1lWCEkVEHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RSDmiNf1; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736930552; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=fxwuU5+5VjORoJdAH0BmKUJFqT/pGkjGg93nT/pd0ao=;
	b=RSDmiNf1FSam+9GmTBKkBVSupG+OKcXimfsEXVqsyeEkilsVbJkuUKNybcRVbCef6b7zaeDKgocmHFrjv9CzDgdSjR41ZeKYcZurXAZ9+hbu/XkT4TYKueGukCgZvsdX2LzguiEYnZ/p3VPzQj4j/rowAOTLhA1OJ4Q8N8fth/8=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WNi-.9S_1736930550 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Jan 2025 16:42:32 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	lpieralisi@kernel.org,
	guohanjun@huawei.com,
	sudeep.holla@arm.com,
	xueshuai@linux.alibaba.com,
	baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org,
	lenb@kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	yazen.ghannam@amd.com
Cc: tianruidong@linux.alibaba.com
Subject: [PATCH v3 0/5] ARM Error Source Table V2 Support
Date: Wed, 15 Jan 2025 16:42:23 +0800
Message-Id: <20250115084228.107573-1-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

AEST provides a mechanism for hardware to directly notify Kernel to
handle RAS errors through interrupts, which is also known as Kernel-first
mode.

AEST's Advantage
========================

1. AEST uses EL1 interrupts to report CE/DE, making it more lightweight
   than GHES (the Firmware First solution on Arm).
2. The lightweight AEST allows system to report each CE, enabling user
    applications to utilize this information for memory error prediction.

AEST Driver Architecture
========================

AEST Driver Device Mana
The AEST driver consists of three components:
  - AEST device: Handle interrupts and manage AEST nodes and records.
  - AEST node: corresponding to RAS node in hardware[1],
  - AEST record: RAS register sets.

They are organized together as follows.

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

Once AEST interrupt occur
1. The AEST device traverses all AEST nodes to locate errored record.
2. There are two types of records in each node：
      - report record: node can locate errored record through bitmap in
                       ERRGSR register.
      - poll record: node need poll all record to check if it errored.
3. process record:
      - if error is corrected, reset ce threshold and print it
      - if error is defered, dump register and call memory_fauilre
      - if error is uncorrected, panic, in fact UE usually raise a
        exception rather than interrupt.
4. decode record: AEST driver notify other driver，like EDAC，to decode
    RAS register.

AEST Error Injection
====================

AEST driver provides error(Software simulation instead of real hardware errors)
inject interface, details can be see in patch0003

Address Translation
===================

AS describe in 2.2[0], error address reported by AEST record may be
'''node-specific Logical Addresses''' rather than '''System Physical Address'''
used by Kernel, driver need tracelate LA to SPA, these is similar to AMD ATL[2].
So patch0004 introduce a common function both for AMD and ARM.

I have tested this series on THead Yitian710 SOC.

Future work:
1. Add CE storm mitigation.
2. Support AEST vendor node.

This series is based on Tyler Baicar's patches [1], which do not have v2
sended to mail list yet. Change from origin patch:
1. Add a genpool to collect all AEST error, and log them in a workqueue
other than in irq context.
2. Just use the same one aest_proc function for system register interface
and MMIO interface.
3. Reconstruct some structures and functions to make it more clear.
4. Accept all comments in Tyler Baicar's mail list.

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

[0]: https://developer.arm.com/documentation/den0085/0101/
[1]: https://lore.kernel.org/all/20211124170708.3874-1-baicar@os.amperecomputing.com/
[2]: https://lore.kernel.org/all/20240123041401.79812-2-yazen.ghannam@amd.com/

Ruidong Tian (5):
  ACPI/RAS/AEST: Initial AEST driver
  RAS/AEST: Introduce AEST driver sysfs interface
  RAS/AEST: Introduce AEST inject interface to test AEST driver
  RAS/ATL: Unified ATL interface for ARM64 and AMD
  trace, ras: add ARM RAS extension trace event

 Documentation/ABI/testing/debugfs-aest |  115 +++
 MAINTAINERS                            |   11 +
 arch/arm64/include/asm/ras.h           |   95 +++
 drivers/acpi/arm64/Kconfig             |   11 +
 drivers/acpi/arm64/Makefile            |    1 +
 drivers/acpi/arm64/aest.c              |  340 ++++++++
 drivers/acpi/arm64/init.c              |    2 +
 drivers/acpi/arm64/init.h              |    1 +
 drivers/edac/amd64_edac.c              |    2 +-
 drivers/ras/Kconfig                    |    1 +
 drivers/ras/Makefile                   |    1 +
 drivers/ras/aest/Kconfig               |   17 +
 drivers/ras/aest/Makefile              |    7 +
 drivers/ras/aest/aest-core.c           | 1017 ++++++++++++++++++++++++
 drivers/ras/aest/aest-inject.c         |  151 ++++
 drivers/ras/aest/aest-sysfs.c          |  230 ++++++
 drivers/ras/aest/aest.h                |  338 ++++++++
 drivers/ras/amd/atl/core.c             |    4 +-
 drivers/ras/amd/atl/internal.h         |    2 +-
 drivers/ras/amd/atl/umc.c              |    3 +-
 drivers/ras/ras.c                      |   27 +-
 include/linux/acpi_aest.h              |   68 ++
 include/linux/cpuhotplug.h             |    1 +
 include/linux/ras.h                    |   17 +-
 include/ras/ras_event.h                |   71 ++
 25 files changed, 2510 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-aest
 create mode 100644 arch/arm64/include/asm/ras.h
 create mode 100644 drivers/acpi/arm64/aest.c
 create mode 100644 drivers/ras/aest/Kconfig
 create mode 100644 drivers/ras/aest/Makefile
 create mode 100644 drivers/ras/aest/aest-core.c
 create mode 100644 drivers/ras/aest/aest-inject.c
 create mode 100644 drivers/ras/aest/aest-sysfs.c
 create mode 100644 drivers/ras/aest/aest.h
 create mode 100644 include/linux/acpi_aest.h

-- 
2.33.1


