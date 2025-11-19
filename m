Return-Path: <linux-acpi+bounces-19074-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EDBC6E6F6
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 13:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68E154E6C77
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 12:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9570351FDE;
	Wed, 19 Nov 2025 12:23:31 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1F133FE05;
	Wed, 19 Nov 2025 12:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555011; cv=none; b=cHwV0RqPGMnBw1ixLtX9NX7Wa4U2disxxVW9/AiqrlOH8QWQKBSgCNh1anJD54tl5Kp5fl0dze8w5UcxnR+xI/PE9enucF6kWw+sozTCm4FL9W7lofDgeYW2Q6fo6tsIx/Q6Rot0uc9ACDeJXWn2oyxygpNuhk7IUv0qISM6jMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555011; c=relaxed/simple;
	bh=xbH2Z6sdxLaoR8hxzfCHfbH3JB+mrMcV1WoNyz0tWPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qk/IjyaZuHoebi7+7olKtFuKDEExmQzWq7Rf6Yw3oK35wDSAXyZY1BZ62X48QW1M4NQRUJDd7vsTiyy2k7Q2jv0QAYbrWHZSx0TRfqvrUrl3rBBcB9GxGoKooyKCGO1qKZxrg3gmbqD3xcckEarNopcDKKCgoMgTLenQot86Be4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEFF9FEC;
	Wed, 19 Nov 2025 04:23:20 -0800 (PST)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4FF173F740;
	Wed, 19 Nov 2025 04:23:23 -0800 (PST)
From: Ben Horgan <ben.horgan@arm.com>
To: james.morse@arm.com
Cc: amitsinght@marvell.com,
	baisheng.gao@unisoc.com,
	baolin.wang@linux.alibaba.com,
	bobo.shaobowang@huawei.com,
	carl@os.amperecomputing.com,
	catalin.marinas@arm.com,
	dakr@kernel.org,
	dave.martin@arm.com,
	david@redhat.com,
	dfustini@baylibre.com,
	fenghuay@nvidia.com,
	gregkh@linuxfoundation.org,
	gshan@redhat.com,
	guohanjun@huawei.com,
	jeremy.linton@arm.com,
	jonathan.cameron@huawei.com,
	kobak@nvidia.com,
	lcherian@marvell.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lpieralisi@kernel.org,
	peternewman@google.com,
	quic_jiles@quicinc.com,
	rafael@kernel.org,
	robh@kernel.org,
	rohit.mathew@arm.com,
	scott@os.amperecomputing.com,
	sdonthineni@nvidia.com,
	sudeep.holla@arm.com,
	tan.shaopeng@fujitsu.com,
	will@kernel.org,
	xhao@linux.alibaba.com,
	reinette.chatre@intel.com,
	Ben Horgan <ben.horgan@arm.com>
Subject: [PATCH v6 00/34] arm_mpam: Add basic mpam driver
Date: Wed, 19 Nov 2025 12:22:30 +0000
Message-ID: <20251119122305.302149-1-ben.horgan@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Just a handful of minor changes based on v5 review comments. See individual
patches for change lgos. I haven't asked James to host any branches for this
revision but please let me know if this would be helpful to anyone. Thanks for
all the help with reviews and testing.

Previous cover letter from James:

This is just enough MPAM driver for ACPI. DT got ripped out. If you need DT
support - please share your DTS so the DT folk know the binding is what is
needed.
This doesn't contain any of the resctrl code, meaning you can't actually drive it
from user-space yet. Because of that, its hidden behind CONFIG_EXPERT.
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

This series is based on v6.18-rc4, and can be retrieved from: (no v6 version)
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/driver/v5

The rest of the driver can be found here: (no v6 version)
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v6.18-rc4-v5

What is MPAM? Set your time-machine to 2020:
https://lore.kernel.org/lkml/20201030161120.227225-1-james.morse@arm.com/

Ben Horgan (5):
  ACPI / PPTT: Add acpi_pptt_cache_v1_full to use pptt cache as one
    structure
  platform: Define platform_device_put cleanup handler
  ACPI: Define acpi_put_table cleanup handler and
    acpi_get_table_pointer() helper
  arm_mpam: Consider overflow in bandwidth counter state
  MAINTAINERS: new entry for MPAM Driver

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
  arm_mpam: Reset MSC controls from cpuhp callbacks
  arm_mpam: Add a helper to touch an MSC from any CPU
  arm_mpam: Extend reset logic to allow devices to be reset any time
  arm_mpam: Register and enable IRQs
  arm_mpam: Use a static key to indicate when mpam is enabled
  arm_mpam: Allow configuration to be applied and restored during cpu
    online
  arm_mpam: Probe and reset the rest of the features
  arm_mpam: Add helpers to allocate monitors
  arm_mpam: Add mpam_msmon_read() to read monitor value
  arm_mpam: Track bandwidth counter state for power management
  arm_mpam: Add helper to reset saved mbwu state
  arm_mpam: Add kunit test for bitmap reset
  arm_mpam: Add kunit tests for props_mismatch()

Rohit Mathew (2):
  arm_mpam: Probe for long/lwd mbwu counters
  arm_mpam: Use long MBWU counters if supported

 MAINTAINERS                         |   10 +
 arch/arm64/Kconfig                  |   25 +
 drivers/Kconfig                     |    2 +
 drivers/Makefile                    |    1 +
 drivers/acpi/arm64/Kconfig          |    3 +
 drivers/acpi/arm64/Makefile         |    1 +
 drivers/acpi/arm64/mpam.c           |  411 ++++
 drivers/acpi/pptt.c                 |  280 ++-
 drivers/acpi/tables.c               |    2 +-
 drivers/resctrl/Kconfig             |   24 +
 drivers/resctrl/Makefile            |    4 +
 drivers/resctrl/mpam_devices.c      | 2723 +++++++++++++++++++++++++++
 drivers/resctrl/mpam_internal.h     |  658 +++++++
 drivers/resctrl/test_mpam_devices.c |  389 ++++
 include/linux/acpi.h                |   26 +
 include/linux/arm_mpam.h            |   66 +
 include/linux/platform_device.h     |    1 +
 17 files changed, 4608 insertions(+), 18 deletions(-)
 create mode 100644 drivers/acpi/arm64/mpam.c
 create mode 100644 drivers/resctrl/Kconfig
 create mode 100644 drivers/resctrl/Makefile
 create mode 100644 drivers/resctrl/mpam_devices.c
 create mode 100644 drivers/resctrl/mpam_internal.h
 create mode 100644 drivers/resctrl/test_mpam_devices.c
 create mode 100644 include/linux/arm_mpam.h

-- 
2.43.0


