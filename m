Return-Path: <linux-acpi+bounces-16620-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC33B522A0
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 22:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF81F18919F7
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 20:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0AF2FB985;
	Wed, 10 Sep 2025 20:43:28 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4582F39B0;
	Wed, 10 Sep 2025 20:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537008; cv=none; b=O7U+n98aXsrtGQ97xaZe1JQoE9wcTc3g83vvmJZVb4/bxBQQYBg1BYgtIW07ZzpB0/hccL5CR53J5tC2aTzxhYVbYhcVG8k/mqRutbzOB6reSHUKt/7dIw/1Mc1x+l8XxPz+Yu5u3qC936DMGhX3A7WN4rAI7dYG7X7zlh+fSgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537008; c=relaxed/simple;
	bh=A0tVBinvsXkfOohjrnd7BVpaj/ByOF9hpnfGYKaiA9E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L2ZYv+lBKWkhO8qvKM7F0117MBDIrRzxAZJ0cAoSJLSIDWWAvnmqDR5r1HMZQkLfRZawPvOc3smbYkbjp/9UZriMVOK9/QKFRAkpROwhH9rcvDLJOYVHYGje9g9IXGvpVD/N+3tWKPgcP8KQ/OxIYEZdyZjHh9qPo70A4BhfO9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDE4C153B;
	Wed, 10 Sep 2025 13:43:16 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F1223F63F;
	Wed, 10 Sep 2025 13:43:20 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Dave Martin <dave.martin@arm.com>,
	Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	fenghuay@nvidia.com,
	baisheng.gao@unisoc.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Rob Herring <robh@kernel.org>,
	Rohit Mathew <rohit.mathew@arm.com>,
	Rafael Wysocki <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 00/29] arm_mpam: Add basic mpam driver
Date: Wed, 10 Sep 2025 20:42:40 +0000
Message-Id: <20250910204309.20751-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The major changes since v1 are:
 * DT got ripped out - see below.
 * The mon_sel locking was simplified - but that will come back.
 
 Otherwise the myriad of changes are noted on each patch.
 
~

This is just enough MPAM driver for ACPI. DT got ripped out. If you need DT
support - please share your DTS so the DT folk know the binding is what is
needed.
This doesn't contain any of the resctrl code, meaning you can't actually drive it
from user-space yet. Becuase of that, its hidden behind CONFIG_EXPERT.
This will change once the user interface is connected up.

This is the initial group of patches that allows the resctrl code to be built
on top. Including that will increase the number of trees that may need to
coordinate, so breaking it up make sense.

The locking got simplified, but is still strange - this is because of the 'mpam-fb'
firmware interface specification that is still alpha. That thing needs to wait for
an interrupt after every system register write, which significantly impacts the
driver. Some features just won't work, e.g. reading the monitor registers via
perf.

I've not found a platform that can test all the behaviours around the monitors,
so this is where I'd expect the most bugs.

The MPAM spec that describes all the system and MMIO registers can be found here:
https://developer.arm.com/documentation/ddi0598/db/?lang=en
(Ignored the 'RETIRED' warning - that is just arm moving the documentation around.
 This document has the best overview)

The expectation is this will go via the arm64 tree.


This series is based on v6.17-rc4, and can be retrieved from:
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/driver/v2

The rest of the driver can be found here:
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v6.17-rc4

What is MPAM? Set your time-machine to 2020:
https://lore.kernel.org/lkml/20201030161120.227225-1-james.morse@arm.com/

This series was previously posted here:
[v1] lore.kernel.org/r/20250822153048.2287-1-james.morse@arm.com
[RFC] lore.kernel.org/r/20250711183648.30766-2-james.morse@arm.com


Bugs welcome,
Thanks,

James Morse (27):
  ACPI / PPTT: Add a helper to fill a cpumask from a processor container
  ACPI / PPTT: Stop acpi_count_levels() expecting callers to clear
    levels
  ACPI / PPTT: Find cache level by cache-id
  ACPI / PPTT: Add a helper to fill a cpumask from a cache_id
  arm64: kconfig: Add Kconfig entry for MPAM
  ACPI / MPAM: Parse the MPAM table
  arm_mpam: Add probe/remove for mpam msc driver and kbuild boiler plate
  arm_mpam: Add the class and component structures for firmware
    described ris
  arm_mpam: Add MPAM MSC register layout definitions
  arm_mpam: Add cpuhp callbacks to probe MSC hardware
  arm_mpam: Probe hardware to find the supported partid/pmg values
  arm_mpam: Add helpers for managing the locking around the mon_sel
    registers
  arm_mpam: Probe the hardware features resctrl supports
  arm_mpam: Merge supported features during mpam_enable() into
    mpam_class
  arm_mpam: Reset MSC controls from cpu hp callbacks
  arm_mpam: Add a helper to touch an MSC from any CPU
  arm_mpam: Extend reset logic to allow devices to be reset any time
  arm_mpam: Register and enable IRQs
  arm_mpam: Use a static key to indicate when mpam is enabled
  arm_mpam: Allow configuration to be applied and restored during cpu
    online
  arm_mpam: Probe and reset the rest of the features
  arm_mpam: Add helpers to allocate monitors
  arm_mpam: Add mpam_msmon_read() to read monitor value
  arm_mpam: Track bandwidth counter state for overflow and power
    management
  arm_mpam: Add helper to reset saved mbwu state
  arm_mpam: Add kunit test for bitmap reset
  arm_mpam: Add kunit tests for props_mismatch()

Rohit Mathew (2):
  arm_mpam: Probe for long/lwd mbwu counters
  arm_mpam: Use long MBWU counters if supported

 arch/arm64/Kconfig                  |   25 +
 drivers/Kconfig                     |    2 +
 drivers/Makefile                    |    1 +
 drivers/acpi/arm64/Kconfig          |    3 +
 drivers/acpi/arm64/Makefile         |    1 +
 drivers/acpi/arm64/mpam.c           |  361 ++++
 drivers/acpi/pptt.c                 |  224 ++-
 drivers/acpi/tables.c               |    2 +-
 drivers/resctrl/Kconfig             |   24 +
 drivers/resctrl/Makefile            |    4 +
 drivers/resctrl/mpam_devices.c      | 2668 +++++++++++++++++++++++++++
 drivers/resctrl/mpam_internal.h     |  676 +++++++
 drivers/resctrl/test_mpam_devices.c |  389 ++++
 include/linux/acpi.h                |   26 +
 include/linux/arm_mpam.h            |   58 +
 15 files changed, 4455 insertions(+), 9 deletions(-)
 create mode 100644 drivers/acpi/arm64/mpam.c
 create mode 100644 drivers/resctrl/Kconfig
 create mode 100644 drivers/resctrl/Makefile
 create mode 100644 drivers/resctrl/mpam_devices.c
 create mode 100644 drivers/resctrl/mpam_internal.h
 create mode 100644 drivers/resctrl/test_mpam_devices.c
 create mode 100644 include/linux/arm_mpam.h

-- 
2.39.5


