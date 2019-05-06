Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02AF3148B8
	for <lists+linux-acpi@lfdr.de>; Mon,  6 May 2019 13:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfEFLPA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 May 2019 07:15:00 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45699 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfEFLO7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 May 2019 07:14:59 -0400
Received: by mail-oi1-f194.google.com with SMTP id u3so3417241oic.12;
        Mon, 06 May 2019 04:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=P4lMC6F6Cd1C6DhKl3ZTLOi8RjpWWmMw6rskcPZvVpQ=;
        b=B57cgPKiwaYoyyzoGReAZY1mT385rn2UWlXBA7bc6X3CNJQl9ycVCHfHLEzyW8g5Vf
         Cnek07rGLuZDCejLj4K/NtMJEUORrF7FDFKjyAhJP1TpTRMVsqZKg4+EPkASSgRknjkU
         TpqEkEp4XG5QWh54AoeCTn74MFJt2hWpAmMkKuKBxt/RtvxTHIc9zTsyehroOJghuG91
         S9Z2uloa/Rc46lMLGEKKiB3Y3vfSOMg2kNXUFA1QSNtmNGTWWXpzuGgWiwGF5L9F9Nfy
         BNNE2f8dokaTmHNmYMKVn/JBmVT9qkYBk4Rm0J0kCLDUtBuVeKbqxs9h8lMWWfHeNXGt
         271w==
X-Gm-Message-State: APjAAAXPWlcNcGEc0kSvOk73SqZMI8+TE1AyZXV1kqGqeh5UUYY3jycL
        WarZn0Bj6gJ7cEavQD4NWJ2KFiCUD8uxPMlKBCf9l/V9
X-Google-Smtp-Source: APXvYqxLepGrUB5lAjii9pFqGZyAmhpaKIrfdBtHvxun0MvSjmYii97gi8CxJL8Bi1qYYBAGsOaPriqQaBM9k7eoH8Q=
X-Received: by 2002:aca:f444:: with SMTP id s65mr717242oih.115.1557141298595;
 Mon, 06 May 2019 04:14:58 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 May 2019 13:14:47 +0200
Message-ID: <CAJZ5v0ge6JhqYEAiFY9cVF5rMW1u_VgC1Cgi=XQOVt4kw0oKTw@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v5.2-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.2-rc1

with top-most commit e07095c9bbcd296401bec8b6852d258d7c926969

 Merge branches 'pm-devfreq' and 'pm-domains'

on top of commit 37624b58542fb9f2d9a70e6ea006ef8a5f66c30b

 Linux 5.1-rc7

to receive power management updates for 5.2-rc1.

These fix the (Intel-specific) Performance and Energy Bias Hint (EPB)
handling and expose it to user space via sysfs, fix and clean up
several cpufreq drivers, add support for two new chips to the qoriq
cpufreq driver, fix, simplify and clean up the cpufreq core and the
schedutil governor, add support for "CPU" domains to the generic
power domains (genpd) framework and provide low-level PSCI firmware
support for that feature, fix the exynos cpuidle driver and fix a
couple of issues in the devfreq subsystem and clean it up.

Specifics:

 - Fix the handling of Performance and Energy Bias Hint (EPB) on
   Intel processors and expose it to user space via sysfs to avoid
   having to access it through the generic MSR I/F (Rafael Wysocki).

 - Improve the handling of global turbo changes made by the platform
   firmware in the intel_pstate driver (Rafael Wysocki).

 - Convert some slow-path static_cpu_has() callers to boot_cpu_has()
   in cpufreq (Borislav Petkov).

 - Fix the frequency calculation loop in the armada-37xx cpufreq
   driver (Gregory CLEMENT).

 - Fix possible object reference leaks in multuple cpufreq drivers
   (Wen Yang).

 - Fix kerneldoc comment in the centrino cpufreq driver (dongjian).

 - Clean up the ACPI and maple cpufreq drivers (Viresh Kumar, Mohan
   Kumar).

 - Add support for lx2160a and ls1028a to the qoriq cpufreq driver
   (Vabhav Sharma, Yuantian Tang).

 - Fix kobject memory leak in the cpufreq core (Viresh Kumar).

 - Simplify the IOwait boosting in the schedutil cpufreq governor
   and rework the TSC cpufreq notifier on x86 (Rafael Wysocki).

 - Clean up the cpufreq core and statistics code (Yue Hu, Kyle Lin).

 - Improve the cpufreq documentation, add SPDX license tags to
   some PM documentation files and unify copyright notices in
   them (Rafael Wysocki).

 - Add support for "CPU" domains to the generic power domains (genpd)
   framework and provide low-level PSCI firmware support for that
   feature (Ulf Hansson).

 - Rearrange the PSCI firmware support code and add support for
   SYSTEM_RESET2 to it (Ulf Hansson, Sudeep Holla).

 - Improve genpd support for devices in multiple power domains (Ulf
   Hansson).

 - Unify target residency for the AFTR and coupled AFTR states in the
   exynos cpuidle driver (Marek Szyprowski).

 - Introduce new helper routine in the operating performance points
   (OPP) framework (Andrew-sh.Cheng).

 - Add support for passing on-die termination (ODT) and auto power
   down parameters from the kernel to Trusted Firmware-A (TF-A) to
   the rk3399_dmc devfreq driver (Enric Balletbo i Serra).

 - Add tracing to devfreq (Lukasz Luba).

 - Make the exynos-bus devfreq driver suspend all devices on system
   shutdown (Marek Szyprowski).

 - Fix a few minor issues in the devfreq subsystem and clean it up
   somewhat (Enric Balletbo i Serra, MyungJoo Ham, Rob Herring,
   Saravana Kannan, Yangtao Li).

 - Improve system wakeup diagnostics (Stephen Boyd).

 - Rework filesystem sync messages emitted during system suspend and
   hibernation (Harry Pan).

Thanks!


---------------

Andrew-sh.Cheng (1):
      OPP: Introduce dev_pm_opp_find_freq_ceil_by_volt()

Borislav Petkov (1):
      drivers/cpufreq: Convert some slow-path static_cpu_has() callers
to boot_cpu_has()

Enric Balletbo i Serra (3):
      PM / devfreq: Fix static checker warning in try_then_request_governor
      PM / devfreq: rockchip-dfi: Move GRF definitions to a common place.
      PM / devfreq: rk3399_dmc: Pass ODT and auto power down parameters to TF-A.

Gregory CLEMENT (1):
      cpufreq: armada-37xx: fix frequency calculation for opp

Harry Pan (2):
      PM / sleep: Refactor filesystems sync to reduce duplication
      PM / sleep: Measure the time of filesystems syncing

Kyle Lin (1):
      cpufreq: stats: Use lock by stat to replace global spin lock

Lukasz Luba (2):
      trace: events: add devfreq trace event file
      PM / devfreq: add tracing for scheduling work

Marek Szyprowski (2):
      cpuidle: exynos: Unify target residency for AFTR and coupled AFTR states
      PM / devfreq: exynos-bus: Suspend all devices on system shutdown

Mohan Kumar (1):
      drivers/cpufreq/acpi-cpufreq.c: This fixes the following
checkpatch warning

MyungJoo Ham (1):
      PM / devfreq: consistent indentation

Rafael J. Wysocki (11):
      cpufreq: intel_pstate: Driver-specific handling of _PPC updates
      cpufreq: Add cpufreq_cpu_acquire() and cpufreq_cpu_release()
      PM / arch: x86: Rework the MSR_IA32_ENERGY_PERF_BIAS handling
      PM / arch: x86: MSR_IA32_ENERGY_PERF_BIAS sysfs interface
      cpufreq: schedutil: Simplify iowait boosting
      cpufreq: intel_pstate: Update max frequency on global turbo changes
      cpufreq: intel_pstate: Documentation: Add references sections
      Documentation: PM: Add SPDX license tags to multiple files
      Documentation: PM: Unify copyright notices
      admin-guide: pm: intel_epb: Add SPDX license tag and copyright notice
      x86: tsc: Rework time_cpufreq_notifier()

Rob Herring (1):
      PM / devfreq: Use of_node_name_eq for node name comparisons

Saravana Kannan (1):
      PM / devfreq: Restart previous governor if new governor fails to start

Stephen Boyd (1):
      PM / wakeup: Use pm_pr_dbg() instead of pr_debug()

Sudeep Holla (1):
      firmware/psci: add support for SYSTEM_RESET2

Ulf Hansson (17):
      PM / Domains: Add generic data pointer to struct genpd_power_state
      PM / Domains: Add support for CPU devices to genpd
      cpuidle: Export the next timer expiration for CPUs
      PM / Domains: Add genpd governor for CPUs
      drivers: firmware: psci: Move psci to separate directory
      MAINTAINERS: Update files for PSCI
      drivers: firmware: psci: Split psci_dt_cpu_init_idle()
      drivers: firmware: psci: Simplify error path of psci_dt_init()
      drivers: firmware: psci: Announce support for OS initiated suspend mode
      PM / core: Propagate dev->power.wakeup_path when no callbacks
      PM / Domains: Don't kfree() the virtual device in the error path
      PM / Domains: Allow OF lookup for multi PM domain case from ->attach_dev()
      PM / Domains: Enable genpd_dev_pm_attach_by_id|name() for single PM domain
      PM / Domains: Use the base device for driver_deferred_probe_check_state()
      PM / Domains: Drop unused in-parameter to some genpd functions
      PM / Domains: Search for the CPU device outside the genpd lock
      PM / Domains: Allow to attach a CPU via genpd_dev_pm_attach_by_id|name()

Vabhav Sharma (1):
      cpufreq: qoriq: add support for lx2160a

Viresh Kumar (2):
      cpufreq: maple: Remove redundant code from maple_cpufreq_init()
      cpufreq: Fix kobject memleak

Wen Yang (7):
      cpufreq: ap806: fix possible object reference leak
      cpufreq: imx6q: fix possible object reference leak
      cpufreq: kirkwood: fix possible object reference leak
      cpufreq: maple: fix possible object reference leak
      cpufreq/pasemi: fix possible object reference leak
      cpufreq: pmac32: fix possible object reference leak
      cpufreq: ppc_cbe: fix possible object reference leak

Yangtao Li (9):
      PM / core: fix kerneldoc comment for dpm_watchdog_handler()
      PM / core: fix kerneldoc comment for device_pm_wait_for_dev()
      PM / core: Introduce dpm_async_fn() helper
      PM / devfreq: fix mem leak in devfreq_add_device()
      PM / devfreq: fix missing check of return value in devfreq_add_device()
      PM / devfreq: rk3399_dmc: remove unneeded semicolon
      PM / devfreq: rockchip-dfi: remove unneeded semicolon
      PM / devfreq: tegra: remove unneeded variable
      PM / Domains: remove unnecessary unlikely()

Yuantian Tang (1):
      cpufreq: qoriq: Add ls1028a chip support

Yue Hu (4):
      cpufreq: Remove cpufreq_driver check in cpufreq_boost_supported()
      cpufreq: boost: Remove CONFIG_CPU_FREQ_BOOST_SW Kconfig option
      cpufreq: Remove needless bios_limit check in show_bios_limit()
      cpufreq: Move ->get callback check outside of __cpufreq_get()

dongjian (1):
      cpufreq: centrino: Fix centrino_setpolicy() kerneldoc comment

---------------

 Documentation/ABI/testing/sysfs-devices-system-cpu |  18 ++
 Documentation/admin-guide/pm/cpufreq.rst           |  18 +-
 Documentation/admin-guide/pm/cpuidle.rst           |   8 +-
 Documentation/admin-guide/pm/index.rst             |   2 +
 Documentation/admin-guide/pm/intel_epb.rst         |  41 ++++
 Documentation/admin-guide/pm/intel_pstate.rst      |  32 +--
 Documentation/admin-guide/pm/sleep-states.rst      |   8 +-
 Documentation/admin-guide/pm/strategies.rst        |   8 +-
 Documentation/admin-guide/pm/system-wide.rst       |   2 +
 Documentation/admin-guide/pm/working-state.rst     |   3 +
 Documentation/driver-api/pm/cpuidle.rst            |   7 +-
 Documentation/driver-api/pm/devices.rst            |  12 +-
 Documentation/driver-api/pm/index.rst              |   2 +
 Documentation/driver-api/pm/notifiers.rst          |   8 +-
 Documentation/driver-api/pm/types.rst              |   2 +
 MAINTAINERS                                        |   3 +-
 arch/x86/kernel/cpu/Makefile                       |   2 +-
 arch/x86/kernel/cpu/common.c                       |  17 --
 arch/x86/kernel/cpu/cpu.h                          |   1 -
 arch/x86/kernel/cpu/intel.c                        |  34 ----
 arch/x86/kernel/cpu/intel_epb.c                    | 216 +++++++++++++++++++++
 arch/x86/kernel/tsc.c                              |  29 ++-
 drivers/acpi/processor_perflib.c                   |   2 +-
 drivers/base/power/domain.c                        | 118 ++++++++---
 drivers/base/power/domain_governor.c               |  67 ++++++-
 drivers/base/power/main.c                          |  70 +++----
 drivers/base/power/wakeup.c                        |   6 +-
 drivers/cpufreq/Kconfig                            |   4 -
 drivers/cpufreq/acpi-cpufreq.c                     |  19 +-
 drivers/cpufreq/amd_freq_sensitivity.c             |   2 +-
 drivers/cpufreq/armada-37xx-cpufreq.c              |  22 ++-
 drivers/cpufreq/armada-8k-cpufreq.c                |   1 +
 drivers/cpufreq/cpufreq.c                          | 100 +++++++---
 drivers/cpufreq/cpufreq_governor.c                 |   2 +
 drivers/cpufreq/cpufreq_stats.c                    |  15 +-
 drivers/cpufreq/freq_table.c                       |   3 -
 drivers/cpufreq/imx6q-cpufreq.c                    |   4 +-
 drivers/cpufreq/intel_pstate.c                     |  65 ++++++-
 drivers/cpufreq/kirkwood-cpufreq.c                 |  19 +-
 drivers/cpufreq/maple-cpufreq.c                    |   6 +-
 drivers/cpufreq/pasemi-cpufreq.c                   |   1 +
 drivers/cpufreq/pmac32-cpufreq.c                   |   2 +
 drivers/cpufreq/powernow-k8.c                      |   2 +-
 drivers/cpufreq/ppc_cbe_cpufreq.c                  |   1 +
 drivers/cpufreq/qoriq-cpufreq.c                    |   2 +
 drivers/cpufreq/speedstep-centrino.c               |   2 +-
 drivers/cpuidle/cpuidle-exynos.c                   |   2 +-
 drivers/cpuidle/cpuidle.c                          |  19 +-
 drivers/devfreq/devfreq-event.c                    |   2 +-
 drivers/devfreq/devfreq.c                          |  90 ++++++---
 drivers/devfreq/event/exynos-ppmu.c                |   2 +-
 drivers/devfreq/event/rockchip-dfi.c               |  25 +--
 drivers/devfreq/exynos-bus.c                       |   8 +
 drivers/devfreq/rk3399_dmc.c                       |  73 ++++++-
 drivers/devfreq/tegra-devfreq.c                    |   7 +-
 drivers/firmware/Kconfig                           |  15 +-
 drivers/firmware/Makefile                          |   3 +-
 drivers/firmware/psci/Kconfig                      |  13 ++
 drivers/firmware/psci/Makefile                     |   4 +
 drivers/firmware/{ => psci}/psci.c                 | 110 +++++++----
 drivers/firmware/{ => psci}/psci_checker.c         |   0
 drivers/opp/core.c                                 |  54 ++++++
 include/linux/cpufreq.h                            |  14 ++
 include/linux/cpuhotplug.h                         |   1 +
 include/linux/cpuidle.h                            |   1 +
 include/linux/pm_domain.h                          |  22 ++-
 include/linux/pm_opp.h                             |   8 +
 include/linux/suspend.h                            |   3 +
 include/linux/tick.h                               |   7 +-
 include/soc/rockchip/rk3399_grf.h                  |  21 ++
 include/soc/rockchip/rockchip_sip.h                |   1 +
 include/trace/events/devfreq.h                     |  40 ++++
 include/uapi/linux/psci.h                          |   7 +
 kernel/power/hibernate.c                           |   5 +-
 kernel/power/main.c                                |  14 ++
 kernel/power/suspend.c                             |  13 +-
 kernel/power/user.c                                |   5 +-
 kernel/sched/cpufreq_schedutil.c                   |  21 +-
 kernel/time/tick-sched.c                           |  12 ++
 79 files changed, 1240 insertions(+), 390 deletions(-)
