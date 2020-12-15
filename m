Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126392DB2F6
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Dec 2020 18:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbgLORoi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 15 Dec 2020 12:44:38 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36969 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbgLORoe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Dec 2020 12:44:34 -0500
Received: by mail-ot1-f68.google.com with SMTP id o11so20191662ote.4;
        Tue, 15 Dec 2020 09:44:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=yJe340pYqS1KarceB46iUuAHw6Kg/Q6YAYvI8s/71q4=;
        b=sZPiFEUPZgzQbjOgGOdh516MCrSf5EpabacoLm0ZZfDDob8zQZ5LwIFktU0PF0aEsK
         yueE6pQE+Q2v1owo/pipDeVmuj6o19lemcaVmp3ZpE934EpTl1Q3wyVR/LAN6sUBdPP4
         JgupI6bUQ8ELgRjZvS1bP9KtFyYUiLMBYVVu5So6ZHtI0la7u4t8NJTI5CFaaGFaWIrx
         nU1iTQLDniQ4/gLDn3/QnvO0RzBQXBfTQ6JcQrtfMJWSxrWleLCpeehqFRnx0opYB8w5
         LTMnhXLRnKlpl/WAbka0MUsAIULfkqZjQhO5EFe/4zDIk1EK9sr5p9vcO4QhK04eRf13
         j7/g==
X-Gm-Message-State: AOAM533nkaL23Qu6mYWz6g/l/WjvhSt1h+SLe8wc4DM3wKR0VGfJtBYh
        26P9aV9vn21y84gJIoqcl/GQrN5SdZdXEvn5sXyotbx+4c4=
X-Google-Smtp-Source: ABdhPJzTY3DDXv9HSueRlMJzWj96TTgPdABzjFPnHa0pHNxxAgwquJzQ7xmIoJWNysuBOiOewL1BmPqce+mavKk5kEo=
X-Received: by 2002:a9d:208a:: with SMTP id x10mr22082660ota.260.1608054231895;
 Tue, 15 Dec 2020 09:43:51 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Dec 2020 18:43:40 +0100
Message-ID: <CAJZ5v0hpMcY_EEfaCQMSzYwvKyauHgnY00nY5p-OOvEBn0R2dA@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v5.11-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.11-rc1

with top-most commit b3fac817830306328d5195e7f4fb332277f3b146

 Merge branches 'pm-devfreq' and 'pm-tools'

on top of commit 0477e92881850d44910a7e94fc2c46f96faa131f

 Linux 5.10-rc7

to receive power management updates for 5.11-rc1.

These update cpufreq (core and drivers), cpuidle (polling state
implementation and the PSCI driver), the OPP (operating performance
points) framework, devfreq (core and drivers), the power capping RAPL
(Running Average Power Limit) driver, the Energy Model support, the
generic power domains (genpd) framework, the ACPI device power
management, the core system-wide suspend code and power management
utilities.

Specifics:

 - Use local_clock() instead of jiffies in the cpufreq statistics to
   improve accuracy (Viresh Kumar).

 - Fix up OPP usage in the cpufreq-dt and qcom-cpufreq-nvmem cpufreq
   drivers (Viresh Kumar).

 - Clean up the cpufreq core, the intel_pstate driver and the
   schedutil cpufreq governor (Rafael Wysocki).

 - Fix up error code paths in the sti-cpufreq and mediatek cpufreq
   drivers (Yangtao Li, Qinglang Miao).

 - Fix cpufreq_online() to return error codes instead of success (0)
   in all cases when it fails (Wang ShaoBo).

 - Add mt8167 support to the mediatek cpufreq driver and blacklist
   mt8516 in the cpufreq-dt-platdev driver (Fabien Parent).

 - Modify the tegra194 cpufreq driver to always return values from
   the frequency table as the current frequency and clean up that
   driver (Sumit Gupta, Jon Hunter).

 - Modify the arm_scmi cpufreq driver to allow it to discover the
   power scale present in the performance protocol and provide this
   information to the Energy Model (Lukasz Luba).

 - Add missing MODULE_DEVICE_TABLE to several cpufreq drivers (Pali
   Rohár).

 - Clean up the CPPC cpufreq driver (Ionela Voinescu).

 - Fix NVMEM_IMX_OCOTP dependency in the imx cpufreq driver (Arnd
   Bergmann).

 - Rework the poling interval selection for the polling state in
   cpuidle (Mel Gorman).

 - Enable suspend-to-idle for PSCI OSI mode in the PSCI cpuidle
   driver (Ulf Hansson).

 - Modify the OPP framework to support empty (node-less) OPP tables
   in DT for passing dependency information (Nicola Mazzucato).

 - Fix potential lockdep issue in the OPP core and clean up the OPP
   core (Viresh Kumar).

 - Modify dev_pm_opp_put_regulators() to accept a NULL argument and
   update its users accordingly (Viresh Kumar).

 - Add frequency changes tracepoint to devfreq (Matthias Kaehlcke).

 - Add support for governor feature flags to devfreq, make devfreq
   sysfs file permissions depend on the governor and clean up the
   devfreq core (Chanwoo Choi).

 - Clean up the tegra20 devfreq driver and deprecate it to allow
   another driver based on EMC_STAT to be used instead of it (Dmitry
   Osipenko).

 - Add interconnect support to the tegra30 devfreq driver, allow it
   to take the interconnect and OPP information from DT and clean it
   up ((Dmitry Osipenko).

 - Add interconnect support to the exynos-bus devfreq driver along
   with interconnect properties documentation (Sylwester Nawrocki).

 - Add suport for AMD Fam17h and Fam19h processors to the RAPL power
   capping driver (Victor Ding, Kim Phillips).

 - Fix handling of overly long constraint names in the powercap
   framework (Lukasz Luba).

 - Fix the wakeup configuration handling for bridges in the ACPI
   device power management core (Rafael Wysocki).

 - Add support for using an abstract scale for power units in the
   Energy Model (EM) and document it (Lukasz Luba).

 - Add em_cpu_energy() micro-optimization to the EM (Pavankumar
   Kondeti).

 - Modify the generic power domains (genpd) framwework to support
   suspend-to-idle (Ulf Hansson).

 - Fix creation of debugfs nodes in genpd (Thierry Strudel).

 - Clean up genpd (Lina Iyer).

 - Clean up the core system-wide suspend code and make it print
   driver flags for devices with debug enabled (Alex Shi, Patrice
   Chotard, Chen Yu).

 - Modify the ACPI system reboot code to make it prepare for system
   power off to avoid confusing the platform firmware (Kai-Heng Feng).

 - Update the pm-graph (multiple changes, mostly usability-related)
   and cpupower (online and offline CPU information support) PM
   utilities (Todd Brandt, Brahadambal Srinivasan).

Thanks!


---------------

Alex Shi (1):
      PM / suspend: fix kernel-doc markup

Arnd Bergmann (1):
      cpufreq: imx: fix NVMEM_IMX_OCOTP dependency

Brahadambal Srinivasan (1):
      cpupower: Provide online and offline CPU information

Chanwoo Choi (5):
      trace: events: devfreq: Use fixed indentation size to improve readability
      PM / devfreq: Unify frequency change to devfreq_update_target func
      PM / devfreq: Add governor feature flag
      PM / devfreq: Add governor attribute flag for specifc sysfs nodes
      PM / devfreq: Remove redundant governor_name from struct devfreq

Chen Yu (1):
      PM: sleep: Print driver flags for all devices during suspend/resume

Dmitry Osipenko (9):
      PM / devfreq: tegra20: Silence deferred probe error
      PM / devfreq: tegra20: Relax Kconfig dependency
      PM / devfreq: tegra30: Silence deferred probe error
      clk: tegra: Export Tegra20 EMC kernel symbols
      soc/tegra: fuse: Export tegra_read_ram_code()
      soc/tegra: fuse: Add stub for tegra_sku_info
      PM / devfreq: tegra20: Deprecate in a favor of emc-stat based driver
      PM / devfreq: tegra30: Support interconnect and OPPs from device-tree
      PM / devfreq: tegra30: Separate configurations per-SoC generation

Fabien Parent (2):
      cpufreq: mediatek: Add support for mt8167
      cpufreq: blacklist mt8516 in cpufreq-dt-platdev

Ionela Voinescu (3):
      cppc_cpufreq: fix misspelling, code style and readability issues
      cppc_cpufreq: clean up cpu, cpu_num and cpunum variable use
      cppc_cpufreq: simplify use of performance capabilities

Jon Hunter (4):
      cpufreq: tegra186: Fix sparse 'incorrect type in assignment' warning
      cpufreq: tegra186: Simplify cluster information lookup
      cpufreq: tegra194: Remove unnecessary frequency calculation
      cpufreq: tegra194: Rename tegra194_get_speed_common function

Kai-Heng Feng (1):
      PM: ACPI: reboot: Use S5 for reboot

Kim Phillips (1):
      powercap: RAPL: Add AMD Fam19h RAPL support

Lina Iyer (1):
      PM: domains: replace -ENOTSUPP with -EOPNOTSUPP

Lukasz Luba (7):
      PM: EM: Add a flag indicating units of power values in Energy Model
      PM: EM: Clarify abstract scale usage for power values in Energy Model
      PM: EM: update the comments related to power scale
      PM: EM: Update Energy Model with new flag indicating power scale
      powercap: Adjust printing the constraint name with new line
      firmware: arm_scmi: Add power_scale_mw_get() interface
      cpufreq: arm_scmi: Discover the power scale in performance protocol

Matthias Kaehlcke (1):
      PM / devfreq: Add tracepoint for frequency changes

Mel Gorman (1):
      cpuidle: Select polling interval based on a c-state with a
longer target residency

Nicola Mazzucato (2):
      dt-bindings: opp: Allow empty OPP tables
      opp: of: Allow empty opp-table with opp-shared

Pali Rohár (9):
      cpufreq: ap806: Add missing MODULE_DEVICE_TABLE
      cpufreq: highbank: Add missing MODULE_DEVICE_TABLE
      cpufreq: mediatek: Add missing MODULE_DEVICE_TABLE
      cpufreq: qcom: Add missing MODULE_DEVICE_TABLE
      cpufreq: st: Add missing MODULE_DEVICE_TABLE
      cpufreq: sun50i: Add missing MODULE_DEVICE_TABLE
      cpufreq: loongson1: Add missing MODULE_ALIAS
      cpufreq: scpi: Add missing MODULE_ALIAS
      cpufreq: vexpress-spc: Add missing MODULE_ALIAS

Patrice Chotard (1):
      PM: sleep: Add dev_wakeup_path() helper

Pavankumar Kondeti (1):
      PM / EM: Micro optimization in em_cpu_energy

Qinglang Miao (1):
      cpufreq: mediatek: add missing platform_driver_unregister() on
error in mtk_cpufreq_driver_init

Rafael J. Wysocki (6):
      cpufreq: Drop restore_freq from struct cpufreq_policy
      PM: ACPI: PCI: Drop acpi_pm_set_bridge_wakeup()
      PM: ACPI: Refresh wakeup device power configuration every time
      cpufreq: intel_pstate: Simplify intel_cpufreq_update_pstate()
      cpufreq: schedutil: Simplify sugov_update_next_freq()
      cpufreq: Fix up several kerneldoc comments

Sumit Gupta (1):
      cpufreq: tegra194: get consistent cpuinfo_cur_freq

Sylwester Nawrocki (2):
      dt-bindings: devfreq: Add documentation for the interconnect properties
      PM / devfreq: exynos-bus: Add registration of interconnect child device

Thierry Strudel (1):
      PM: domains: create debugfs nodes when adding power domains

Todd Brandt (1):
      pm-graph v5.8

Ulf Hansson (3):
      PM: domains: Rename pm_genpd_syscore_poweroff|poweron()
      PM: domains: Enable dev_pm_genpd_suspend|resume() for suspend-to-idle
      cpuidle: psci: Enable suspend-to-idle for PSCI OSI mode

Victor Ding (3):
      x86/msr-index: sort AMD RAPL MSRs by address
      powercap/intel_rapl_msr: Convert rapl_msr_priv into pointer
      powercap: Add AMD Fam17h RAPL support

Viresh Kumar (14):
      opp: Always add entries in dev_list with opp_table->lock held
      opp: Allocate the OPP table outside of opp_table_lock
      opp: Don't return opp_dev from _find_opp_dev()
      opp: Reduce the size of critical section in _opp_kref_release()
      cpufreq: dt: Don't (ab)use dev_pm_opp_get_opp_table() to create OPP table
      opp: Don't create an OPP table from dev_pm_opp_get_opp_table()
      opp: Allow dev_pm_opp_put_*() APIs to accept NULL opp_table
      cpufreq: dt: dev_pm_opp_put_regulators() accepts NULL argument
      cpufreq: qcom-cpufreq-nvmem: dev_pm_opp_put_*() accepts NULL argument
      PM / devfreq: exynos: dev_pm_opp_put_*() accepts NULL argument
      drm/lima: dev_pm_opp_put_*() accepts NULL argument
      drm/panfrost: dev_pm_opp_put_*() accepts NULL argument
      media: venus: dev_pm_opp_put_*() accepts NULL argument
      cpufreq: stats: Use local_clock() instead of jiffies

Wang ShaoBo (1):
      cpufreq: Fix cpufreq_online() return value on errors

Yangtao Li (1):
      cpufreq: sti-cpufreq: fix mem leak in sti_cpufreq_set_opp_info()

---------------

 Documentation/ABI/testing/sysfs-class-devfreq      |  54 +--
 .../devicetree/bindings/devfreq/exynos-bus.txt     |  71 +++-
 Documentation/devicetree/bindings/opp/opp.txt      |  54 ++-
 .../driver-api/thermal/power_allocator.rst         |  12 +-
 Documentation/power/energy-model.rst               |  30 +-
 Documentation/scheduler/sched-energy.rst           |   5 +
 MAINTAINERS                                        |   1 -
 arch/x86/include/asm/msr-index.h                   |   3 +-
 drivers/acpi/device_pm.c                           |  62 ++--
 drivers/base/power/domain.c                        | 130 ++++---
 drivers/base/power/main.c                          |   8 +-
 drivers/clk/tegra/clk-tegra20-emc.c                |   3 +
 drivers/clocksource/sh_cmt.c                       |   8 +-
 drivers/clocksource/sh_mtu2.c                      |   4 +-
 drivers/clocksource/sh_tmu.c                       |   8 +-
 drivers/cpufreq/Kconfig.arm                        |   2 +-
 drivers/cpufreq/armada-8k-cpufreq.c                |   6 +
 drivers/cpufreq/cppc_cpufreq.c                     | 163 ++++-----
 drivers/cpufreq/cpufreq-dt-platdev.c               |   2 +
 drivers/cpufreq/cpufreq-dt.c                       | 155 ++++-----
 drivers/cpufreq/cpufreq.c                          |  85 ++---
 drivers/cpufreq/cpufreq_stats.c                    |  16 +-
 drivers/cpufreq/highbank-cpufreq.c                 |   7 +
 drivers/cpufreq/intel_pstate.c                     |   9 +-
 drivers/cpufreq/loongson1-cpufreq.c                |   1 +
 drivers/cpufreq/mediatek-cpufreq.c                 |   3 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c               |  16 +-
 drivers/cpufreq/scmi-cpufreq.c                     |   5 +-
 drivers/cpufreq/scpi-cpufreq.c                     |   1 +
 drivers/cpufreq/sti-cpufreq.c                      |  14 +-
 drivers/cpufreq/sun50i-cpufreq-nvmem.c             |   1 +
 drivers/cpufreq/tegra186-cpufreq.c                 | 122 +++----
 drivers/cpufreq/tegra194-cpufreq.c                 |  72 +++-
 drivers/cpufreq/vexpress-spc-cpufreq.c             |   1 +
 drivers/cpuidle/cpuidle-psci-domain.c              |   2 +
 drivers/cpuidle/cpuidle-psci.c                     |  34 +-
 drivers/cpuidle/cpuidle.c                          |  25 +-
 drivers/devfreq/Kconfig                            |  10 -
 drivers/devfreq/Makefile                           |   1 -
 drivers/devfreq/devfreq.c                          | 242 ++++++++-----
 drivers/devfreq/exynos-bus.c                       |  29 +-
 drivers/devfreq/governor.h                         |  33 +-
 drivers/devfreq/governor_passive.c                 |  44 +--
 drivers/devfreq/governor_simpleondemand.c          |   2 +
 drivers/devfreq/tegra20-devfreq.c                  | 212 -----------
 drivers/devfreq/tegra30-devfreq.c                  | 159 +++++----
 drivers/firmware/arm_scmi/perf.c                   |   8 +
 drivers/gpu/drm/lima/lima_devfreq.c                |  13 +-
 drivers/gpu/drm/panfrost/panfrost_devfreq.c        |   6 +-
 drivers/i2c/busses/i2c-stm32f7.c                   |   4 +-
 drivers/media/platform/qcom/venus/pm_helpers.c     |   3 +-
 drivers/opp/core.c                                 | 228 +++++++-----
 drivers/opp/of.c                                   |  18 +-
 drivers/opp/opp.h                                  |   1 +
 drivers/pci/pci-acpi.c                             |   4 +-
 drivers/powercap/intel_rapl_common.c               |   7 +
 drivers/powercap/intel_rapl_msr.c                  |  51 ++-
 drivers/powercap/powercap_sys.c                    |   5 +-
 drivers/soc/tegra/fuse/tegra-apbmisc.c             |   2 +
 include/acpi/acpi_bus.h                            |   5 -
 include/linux/cpufreq.h                            |   5 -
 include/linux/devfreq.h                            |   4 -
 include/linux/energy_model.h                       |  23 +-
 include/linux/pm_domain.h                          |  22 +-
 include/linux/pm_opp.h                             |   1 -
 include/linux/pm_wakeup.h                          |  10 +
 include/linux/scmi_protocol.h                      |   1 +
 include/soc/tegra/fuse.h                           |   4 +
 include/trace/events/devfreq.h                     |  30 +-
 kernel/power/energy_model.c                        |  26 +-
 kernel/power/suspend.c                             |   2 +
 kernel/reboot.c                                    |   2 +
 kernel/sched/cpufreq_schedutil.c                   |   8 +-
 tools/power/cpupower/utils/cpufreq-set.c           |   3 +
 tools/power/cpupower/utils/cpuidle-set.c           |   4 +
 tools/power/cpupower/utils/cpupower.c              |   8 +
 tools/power/cpupower/utils/helpers/helpers.h       |  12 +
 tools/power/cpupower/utils/helpers/misc.c          |  66 +++-
 tools/power/pm-graph/README                        |   4 +-
 tools/power/pm-graph/sleepgraph.py                 | 387 ++++++++++++---------
 80 files changed, 1695 insertions(+), 1209 deletions(-)
