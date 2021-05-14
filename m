Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C37380686
	for <lists+linux-acpi@lfdr.de>; Fri, 14 May 2021 11:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhENJz2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 May 2021 05:55:28 -0400
Received: from foss.arm.com ([217.140.110.172]:46100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229477AbhENJz1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 May 2021 05:55:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0CD5169E;
        Fri, 14 May 2021 02:54:15 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 832AF3F719;
        Fri, 14 May 2021 02:54:14 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] arch_topology, ACPI: populate cpu capacity from CPPC
Date:   Fri, 14 May 2021 10:53:36 +0100
Message-Id: <20210514095339.12979-1-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.29.2.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi all,

These are a few trivial patches to populate cpu capacity information
using performance information from ACPI's CPPC.

I've tied this functionality to the existing function
init_freq_invariance_cppc() called in acpi_cppc_processor_probe().
This function is renamed to a more generic arch_init_invariance_cppc().

The patches have been build tested on x86 and more thoroughly tested on
Juno R2 (arm64), which uses the new functionality, with the following
results:


root@ubuntu:~# dmesg | grep cpu_capacity
[    2.157494] init_cpu_capacity_cppc: CPU0 cpu_capacity=38300 (raw).
[    2.163699] init_cpu_capacity_cppc: CPU1 cpu_capacity=38300 (raw).
[    2.169899] init_cpu_capacity_cppc: CPU2 cpu_capacity=38300 (raw).
[    2.176098] init_cpu_capacity_cppc: CPU3 cpu_capacity=38300 (raw).
[    2.182296] init_cpu_capacity_cppc: CPU4 cpu_capacity=102400 (raw).
[    2.188581] init_cpu_capacity_cppc: CPU5 cpu_capacity=102400 (raw).
[    2.194867] cpu_capacity: capacity_scale=102400
[    2.199409] cpu_capacity: CPU0 cpu_capacity=383
[    2.203952] cpu_capacity: CPU1 cpu_capacity=383
[    2.208495] cpu_capacity: CPU2 cpu_capacity=383
[    2.213037] cpu_capacity: CPU3 cpu_capacity=383
[    2.217580] cpu_capacity: CPU4 cpu_capacity=1024
[    2.222209] cpu_capacity: CPU5 cpu_capacity=1024
[    2.226886] init_cpu_capacity_cppc: cpu_capacity initialization done

root@ubuntu:~# tail -n +1 /sys/devices/system/cpu/cpu*/cpu_capacity
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

All works as expected even if ACPI processor support is built as a
module.

Patches are based on v5.13-rc1.

Let me know what you think!

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
 drivers/base/arch_topology.c      | 39 +++++++++++++++++++++++++++++++
 include/linux/arch_topology.h     |  4 ++++
 5 files changed, 51 insertions(+), 4 deletions(-)

-- 
2.29.2.dirty

