Return-Path: <linux-acpi+bounces-15909-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1FBB31EB3
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 17:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9DC16FB03
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 15:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4C1214204;
	Fri, 22 Aug 2025 15:31:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B552F21D3CD;
	Fri, 22 Aug 2025 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876670; cv=none; b=QlFQIBzqshbWaAxxDrEazZBvaZJa/qlBH5Ga+9NiI3o2IE9Yx3LHZ1aWgfEq+FZhO41wC5maQ7K9RIpwbr59y/cCSNWVZCfaXYziwHFcRqp2Ey3HCIZzj3PrqIrxsNI3YqyvdTp7EvPX3zaF6ok047rU/K7M5OAgeSHhyG0YXPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876670; c=relaxed/simple;
	bh=+hoU4wxg242iRgLe3Vo5s1Sa9/tEfDVtgMJ/pID/5Wg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oJ+dPW0do6IJ5kUr6nCJPzTbEmn6UaVta4/W2TnQm4Qk/wYUGbAirDs0zhHBFGwZiG/EFtbB9KsP41tXlKRJKczLWMpdwNiw9lW2+DdfdlcspnjYK0we69SQjl3Is11x9IZFbVHH/p6acxCiXWL71iNZSPjJoe+qwyMogYj0hdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3481215A1;
	Fri, 22 Aug 2025 08:30:53 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21EC13F63F;
	Fri, 22 Aug 2025 08:30:56 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
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
	Rex Nie <rex.nie@jaguarmicro.com>,
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
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 00/33] arm_mpam: Add basic mpam driver
Date: Fri, 22 Aug 2025 15:29:41 +0000
Message-Id: <20250822153048.2287-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is just enough MPAM driver for the ACPI and DT pre-requisites.
It doesn't contain any of the resctrl code, meaning you can't actually drive it
from user-space yet. Becuase of that, its hidden behind CONFIG_EXPERT.
This will change once the user interface is connected up.

This is the initial group of patches that allows the resctrl code to be built
on top. Including that will increase the number of trees that may need to
coordinate, so breaking it up make sense.

The locking looks very strange - but is influenced by the 'mpam-fb' firmware
interface specification that is still alpha. That thing needs to wait for an
interrupt after every system register write, which significantly impacts the
driver. Some features just won't work, e.g. reading the monitor registers via
perf.
The aim is to not have to make invasive changes to the locking to support the
firmware interface, hence it looks strange from day-1.

I've not found a platform that can test all the behaviours around the monitors,
so this is where I'd expect the most bugs.

The MPAM spec that describes all the system and MMIO registers can be found here:
https://developer.arm.com/documentation/ddi0598/db/?lang=en
(Ignored the 'RETIRED' warning - that is just arm moving the documentation around.
 This document has the best overview)

The expectation is this will go via the arm64 tree.


This series is based on v6.17-rc2, and can be retrieved from:
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/driver/rv1

The rest of the driver can be found here:
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v6.17-rc2

What is MPAM? Set your time-machine to 2020:
https://lore.kernel.org/lkml/20201030161120.227225-1-james.morse@arm.com/

This series was previously posted here:
[RFC] lore.kernel.org/r/20250711183648.30766-2-james.morse@arm.com


Bugs welcome,
Thanks,

James Morse (29):
  cacheinfo: Expose the code to generate a cache-id from a device_node
  drivers: base: cacheinfo: Add helper to find the cache size from
    cpu+level
  ACPI / PPTT: Add a helper to fill a cpumask from a processor container
  ACPI / PPTT: Stop acpi_count_levels() expecting callers to clear
    levels
  ACPI / PPTT: Find cache level by cache-id
  ACPI / PPTT: Add a helper to fill a cpumask from a cache_id
  arm64: kconfig: Add Kconfig entry for MPAM
  ACPI / MPAM: Parse the MPAM table
  arm_mpam: Add probe/remove for mpam msc driver and kbuild boiler plate
  arm_mpam: Add the class and component structures for ris firmware
    described
  arm_mpam: Add MPAM MSC register layout definitions
  arm_mpam: Add cpuhp callbacks to probe MSC hardware
  arm_mpam: Probe MSCs to find the supported partid/pmg values
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

Rob Herring (1):
  dt-bindings: arm: Add MPAM MSC binding

Rohit Mathew (2):
  arm_mpam: Probe for long/lwd mbwu counters
  arm_mpam: Use long MBWU counters if supported

Shanker Donthineni (1):
  arm_mpam: Add support for memory controller MSC on DT platforms

 .../devicetree/bindings/arm/arm,mpam-msc.yaml |  200 ++
 arch/arm64/Kconfig                            |   19 +
 drivers/Kconfig                               |    2 +
 drivers/Makefile                              |    1 +
 drivers/acpi/arm64/Kconfig                    |    3 +
 drivers/acpi/arm64/Makefile                   |    1 +
 drivers/acpi/arm64/mpam.c                     |  331 ++
 drivers/acpi/pptt.c                           |  230 +-
 drivers/acpi/tables.c                         |    2 +-
 drivers/base/cacheinfo.c                      |   19 +-
 drivers/resctrl/Kconfig                       |   24 +
 drivers/resctrl/Makefile                      |    4 +
 drivers/resctrl/mpam_devices.c                | 2909 +++++++++++++++++
 drivers/resctrl/mpam_internal.h               |  692 ++++
 drivers/resctrl/test_mpam_devices.c           |  390 +++
 include/linux/acpi.h                          |   26 +
 include/linux/arm_mpam.h                      |   56 +
 include/linux/cacheinfo.h                     |   16 +
 18 files changed, 4911 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,mpam-msc.yaml
 create mode 100644 drivers/acpi/arm64/mpam.c
 create mode 100644 drivers/resctrl/Kconfig
 create mode 100644 drivers/resctrl/Makefile
 create mode 100644 drivers/resctrl/mpam_devices.c
 create mode 100644 drivers/resctrl/mpam_internal.h
 create mode 100644 drivers/resctrl/test_mpam_devices.c
 create mode 100644 include/linux/arm_mpam.h

-- 
2.20.1


