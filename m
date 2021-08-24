Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9862A3F5C83
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Aug 2021 12:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbhHXK5p (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Aug 2021 06:57:45 -0400
Received: from foss.arm.com ([217.140.110.172]:33904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235905AbhHXK5p (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 24 Aug 2021 06:57:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2B6E101E;
        Tue, 24 Aug 2021 03:57:00 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (e108754-lin.cambridge.arm.com [10.1.198.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3FF683F66F;
        Tue, 24 Aug 2021 03:56:59 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sean Kelley <skelley@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/3] arch_topology, ACPI: populate cpu capacity from CPPC
Date:   Tue, 24 Aug 2021 11:56:48 +0100
Message-Id: <20210824105651.28660-1-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.29.2.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi all,

Apologies for the long delay in posting v2.

v1->v2:
 - v1 can be found at [1]
 - Changed debug prints to the format used on the DT path
 - s/init_cpu_capacity_cppc/topology_init_cpu_capacity_cppc

Patches are based on v5.14-rc7.

The patches have been build tested on x86 and more thoroughly tested on
Juno R2 (arm64), which uses the new functionality, with the following
results:

root@buildroot:~# dmesg | grep cpu_capacity
[    2.191152] cpu_capacity: CPU0 cpu_capacity=38300 (raw).
[    2.196482] cpu_capacity: CPU1 cpu_capacity=38300 (raw).
[    2.201809] cpu_capacity: CPU2 cpu_capacity=38300 (raw).
[    2.207136] cpu_capacity: CPU3 cpu_capacity=38300 (raw).
[    2.212463] cpu_capacity: CPU4 cpu_capacity=102400 (raw).
[    2.217877] cpu_capacity: CPU5 cpu_capacity=102400 (raw).
[    2.223291] cpu_capacity: capacity_scale=102400
[    2.227834] cpu_capacity: CPU0 cpu_capacity=383
[    2.232376] cpu_capacity: CPU1 cpu_capacity=383
[    2.236919] cpu_capacity: CPU2 cpu_capacity=383
[    2.241462] cpu_capacity: CPU3 cpu_capacity=383
[    2.246004] cpu_capacity: CPU4 cpu_capacity=1024
[    2.250634] cpu_capacity: CPU5 cpu_capacity=1024
[    2.255321] cpu_capacity: cpu_capacity initialization done

root@buildroot:~# tail -n +1 /sys/devices/system/cpu/cpu*/cpu_capacity
==> /sys/devices/system/cpu/cpu0/cpu_capacity <==
383
==> /sys/devices/system/cpu/cpu1/cpu_capacity <==
383
==> /sys/devices/system/cpu/cpu2/cpu_capacity <==
383
==> /sys/devices/system/cpu/cpu3/cpu_capacity <==
383
==> /sys/devices/system/cpu/cpu4/cpu_capacity <==
1024
==> /sys/devices/system/cpu/cpu5/cpu_capacity <==
1024

[1]
https://lore.kernel.org/lkml/20210514095339.12979-1-ionela.voinescu@arm.com/

Thanks,
Ionela.

Ionela Voinescu (3):
  x86, ACPI: rename init_freq_invariance_cppc to
    arch_init_invariance_cppc
  arch_topology: obtain cpu capacity using information from CPPC
  arm64, topology: enable use of init_cpu_capacity_cppc()

 arch/arm64/include/asm/topology.h |  4 ++++
 arch/x86/include/asm/topology.h   |  2 +-
 drivers/acpi/cppc_acpi.c          |  6 ++---
 drivers/base/arch_topology.c      | 37 +++++++++++++++++++++++++++++++
 include/linux/arch_topology.h     |  4 ++++
 5 files changed, 49 insertions(+), 4 deletions(-)

-- 
2.29.2.dirty

