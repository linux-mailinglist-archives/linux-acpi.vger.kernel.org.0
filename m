Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77B423AAE7
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Aug 2020 18:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgHCQuw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Aug 2020 12:50:52 -0400
Received: from mail-oo1-f42.google.com ([209.85.161.42]:46206 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgHCQuw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Aug 2020 12:50:52 -0400
Received: by mail-oo1-f42.google.com with SMTP id s190so7393245ooa.13;
        Mon, 03 Aug 2020 09:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=d7lsX/juYpS8qv5Z3gL+5ZnOZBTEwatV3aK9NXHDoPg=;
        b=OUpGqpzZGxRAyVRrBC8w6JArfl6/X/Ar8cSg4LqWDHm+L37zom/EahpF4o7J2WWncC
         imhwX8sDVY+66xbflEjKn+97rOHeY+19f+/eisBDy1TGfkWUr5lWMO+op3KAKM13E2FL
         6OoHlb0WqAaPbIo9cRELAq6epDREVXslC2+AgOgpjWxCqUHmjw/scqS3xlTb96x5t5ok
         KxZ0AtKBoaZk6p0dVW3jdhAHn32DBpA0tbVUzqgJSbE9CD+tNyr/pZegG8EYI2NOP7pY
         lFLdHmkal//QHbBg9Uvpu9tnrFujxYKHfLMU+X8yX4Qhn1U7WUuon8G+uEwzHoi+vqan
         JJPA==
X-Gm-Message-State: AOAM531SWnx4bdkWOUQOZ+dokdpxyJ65IHhD1kPNV+mOLK8W3hPImmi3
        nym9akUevar5IEV/0ShX4Bz4SOq0+PrWSLbbCXeqR2Y7
X-Google-Smtp-Source: ABdhPJzwTzK/kdfhDGQvVoWNOU9GHSR6aJB2Sjk0WHuT7flhcKgL61iwUWUVNH1SV5bP5YJKYeF0eS/ZVTJRyKib+Ns=
X-Received: by 2002:a4a:d62c:: with SMTP id n12mr15004545oon.38.1596473450357;
 Mon, 03 Aug 2020 09:50:50 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 3 Aug 2020 18:50:39 +0200
Message-ID: <CAJZ5v0gu2wsaPqb=qTVh1+AfQJQviHF=33EyB5kYS6-ZqZTE8Q@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.9-rc1
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
 pm-5.9-rc1

with top-most commit 86ba54fb0816480941cda78a99f107ab2bbd4249

 Merge branches 'pm-sleep', 'pm-domains', 'powercap' and 'pm-tools'

on top of commit 92ed301919932f777713b9172e525674157e983d

 Linux 5.8-rc7

to receive power management updates for 5.9-rc1.

The most significant change here is the extension of the Energy
Model to cover non-CPU devices (as well as CPUs) from Lukasz Luba.

There is also some new hardware support (Ice Lake server idle
states table for intel_idle, Sapphire Rapids and Power Limit 4
support in the RAPL driver), some new functionality in the existing
drivers (eg. a new switch to disable/enable CPU energy-efficiency
optimizations in intel_pstate, delayed timers in devfreq), some
assorted fixes (cpufreq core, intel_pstate, intel_idle) and cleanups
(eg. cpuidle-psci, devfreq), including the elimination of W=1 build
warnings from cpufreq done by Lee Jones.

Specifics:

 - Make the Energy Model cover non-CPU devices (Lukasz Luba).

 - Add Ice Lake server idle states table to the intel_idle driver
   and eliminate a redundant static variable from it (Chen Yu,
   Rafael Wysocki).

 - Eliminate all W=1 build warnings from cpufreq (Lee Jones).

 - Add support for Sapphire Rapids and for Power Limit 4 to the
   Intel RAPL power capping driver (Sumeet Pawnikar, Zhang Rui).

 - Fix function name in kerneldoc comments in the idle_inject power
   capping driver (Yangtao Li).

 - Fix locking issues with cpufreq governors and drop a redundant
   "weak" function definition from cpufreq (Viresh Kumar).

 - Rearrange cpufreq to register non-modular governors at the
   core_initcall level and allow the default cpufreq governor to
   be specified in the kernel command line (Quentin Perret).

 - Extend, fix and clean up the intel_pstate driver (Srinivas
   Pandruvada, Rafael Wysocki):

   * Add a new sysfs attribute for disabling/enabling CPU
     energy-efficiency optimizations in the processor.

   * Make the driver avoid enabling HWP if EPP is not supported.

   * Allow the driver to handle numeric EPP values in the sysfs
     interface and fix the setting of EPP via sysfs in the active
     mode.

   * Eliminate a static checker warning and clean up a kerneldoc
     comment.

 - Clean up some variable declarations in the powernv cpufreq
   driver (Wei Yongjun).

 - Fix up the ->enter_s2idle callback definition to cover the case
   when it points to the same function as ->idle correctly (Neal
   Liu).

 - Rearrange and clean up the PSCI cpuidle driver (Ulf Hansson).

 - Make the PM core emit "changed" uevent when adding/removing the
   "wakeup" sysfs attribute of devices (Abhishek Pandit-Subedi).

 - Add a helper macro for declaring PM callbacks and use it in the
   MMC jz4740 driver (Paul Cercueil).

 - Fix white space in some places in the hibernate code and make the
   system-wide PM code use "const char *" where appropriate (Xiang
   Chen, Alexey Dobriyan).

 - Add one more "unsafe" helper macro to the freezer to cover the NFS
   use case (He Zhe).

 - Change the language in the generic PM domains framework to use
   parent/child terminology and clean up a typo and some comment
   formatting in that code (Kees Cook, Geert Uytterhoeven).

 - Update the operating performance points OPP framework (Lukasz
   Luba, Andrew-sh.Cheng, Valdis Kletnieks):

   * Refactor dev_pm_opp_of_register_em() and update related drivers.

   * Add a missing function export.

   * Allow disabled OPPs in dev_pm_opp_get_freq().

 - Update devfreq core and drivers (Chanwoo Choi, Lukasz Luba, Enric
   Balletbo i Serra, Dmitry Osipenko, Kieran Bingham, Marc Zyngier):

   * Add support for delayed timers to the devfreq core and make the
     Samsung exynos5422-dmc driver use it.

   * Unify sysfs interface to use "df-" as a prefix in instance names
     consistently.

   * Fix devfreq_summary debugfs node indentation.

   * Add the rockchip,pmu phandle to the rk3399_dmc driver DT
     bindings.

   * List Dmitry Osipenko as the Tegra devfreq driver maintainer.

   * Fix typos in the core devfreq code.

 - Update the pm-graph utility to version 5.7 including a number of
   fixes related to suspend-to-idle (Todd Brandt).

 - Fix coccicheck errors and warnings in the cpupower utility (Shuah
   Khan).

 - Replace HTTP links with HTTPs ones in multiple places (Alexander
   A. Klimov).

Thanks!


---------------

Abhishek Pandit-Subedi (1):
      PM: sleep: core: Emit changed uevent on wakeup_sysfs_add/remove

Alexander A. Klimov (3):
      cpufreq: Replace HTTP links with HTTPS ones
      cpupower: Replace HTTP links with HTTPS ones
      opp: ti-opp-supply: Replace HTTP links with HTTPS ones

Alexey Dobriyan (1):
      PM: sleep: spread "const char *" correctness

Andrew-sh.Cheng (1):
      opp: Allow disabled OPPs in dev_pm_opp_get_freq()

Chanwoo Choi (5):
      PM / devfreq: Add support delayed timer for polling mode
      memory: samsung: exynos5422-dmc: Use delayed timer as default
      PM / devfreq: Clean up the devfreq instance name in sysfs attr
      PM / devfreq: Fix indentaion of devfreq_summary debugfs node
      PM / devfreq: Fix the wrong end with semicolon

Chen Yu (1):
      intel_idle: Customize IceLake server support

Dmitry Osipenko (1):
      PM / devfreq: tegra: Add Dmitry as a maintainer

Enric Balletbo i Serra (1):
      dt-bindings: devfreq: rk3399_dmc: Add rockchip,pmu phandle

Geert Uytterhoeven (1):
      PM: domains: Restore comment indentation for generic_pm_domain.child_links

He Zhe (1):
      freezer: Add unsafe version of
freezable_schedule_timeout_interruptible() for NFS

Kees Cook (1):
      PM: domains: Fix up terminology with parent/child

Kieran Bingham (1):
      PM / devfreq: event: Fix trivial spelling

Lee Jones (11):
      cpufreq: freq_table: Demote obvious misuse of kerneldoc to
standard comment blocks
      cpufreq: cpufreq: Demote lots of function headers unworthy of
kerneldoc status
      cpufreq: cpufreq_governor: Demote store_sampling_rate() header
to standard comment block
      cpufreq: pasemi: Include header file for {check,restore}_astate prototypes
      cpufreq: powernv-cpufreq: Fix a bunch of kerneldoc related issues
      cpufreq: acpi-cpufreq: Mark 'dummy' variable as __always_unused
      cpufreq: acpi-cpufreq: Mark sometimes used ID structs as __maybe_unused
      cpufreq: powernow-k8: Mark 'hi' and 'lo' dummy variables as
__always_unused
      cpufreq: pcc-cpufreq: Mark sometimes used ID structs as __maybe_unused
      cpufreq: intel_pstate: Supply struct attribute description for
get_aperf_mperf_shift()
      cpufreq: amd_freq_sensitivity: Mark sometimes used ID structs as
__maybe_unused

Lukasz Luba (10):
      PM / EM: change naming convention from 'capacity' to 'performance'
      PM / EM: introduce em_dev_register_perf_domain function
      PM / EM: update callback structure and add device pointer
      PM / EM: add support for other devices than CPUs in Energy Model
      PM / EM: remove em_register_perf_domain
      PM / EM: change name of em_pd_energy to em_cpu_energy
      Documentation: power: update Energy Model description
      OPP: refactor dev_pm_opp_of_register_em() and update related drivers
      memory: samsung: exynos5422-dmc: Adjust polling interval and uptreshold
      memory: samsung: exynos5422-dmc: Add module param to control IRQ mode

Marc Zyngier (1):
      PM / devfreq: rk3399_dmc: Fix kernel oops when rockchip,pmu is absent

Neal Liu (2):
      cpuidle: change enter_s2idle() prototype
      cpuidle: ACPI: fix 'return' with no value build warning

Paul Cercueil (3):
      PM: core: introduce pm_ptr() macro
      PM: Make *_DEV_PM_OPS macros use __maybe_unused
      mmc: jz4740: Use pm_ptr() macro

Quentin Perret (2):
      cpufreq: Register governors at core_initcall
      cpufreq: Specify default governor on command line

Rafael J. Wysocki (5):
      intel_idle: Eliminate redundant static variable
      cpufreq: intel_pstate: Clean up aperf_mperf_shift description
      cpufreq: intel_pstate: Avoid enabling HWP if EPP is not supported
      cpufreq: intel_pstate: Rearrange the storing of new EPP values
      cpufreq: intel_pstate: Fix EPP setting via sysfs in active mode

Shuah Khan (2):
      cpupower: Fix comparing pointer to 0 coccicheck warns
      cpupower: Fix NULL but dereferenced coccicheck errors

Srinivas Pandruvada (3):
      cpufreq: intel_pstate: Allow enable/disable energy efficiency
      cpufreq: intel_pstate: Allow raw energy performance preference value
      cpufreq: intel_pstate: Fix static checker warning for epp variable

Sumeet Pawnikar (1):
      powercap: Add Power Limit4 support

Todd Brandt (1):
      pm-graph v5.7 - important s2idle fixes

Ulf Hansson (5):
      cpuidle: psci: Split into two separate build objects
      cpuidle: psci: Fail cpuidle registration if set OSI mode failed
      cpuidle: psci: Fix error path via converting to a platform driver
      cpuidle: psci: Convert PM domain to platform driver
      cpuidle: psci: Prevent domain idlestates until consumers are ready

Valdis Kletnieks (1):
      opp: core: Add missing export for dev_pm_opp_adjust_voltage

Viresh Kumar (2):
      cpufreq: Fix locking issues with governors
      cpufreq: Remove the weakly defined cpufreq_default_governor()

Wei Yongjun (1):
      cpufreq: powernv: Make some symbols static

Xiang Chen (1):
      PM: hibernate: fix white space in a few places

Yangtao Li (1):
      powercap: idle_inject: Replace play_idle() with
play_idle_precise() in comments

Zhang Rui (1):
      powercap: intel_rapl: add support for Sapphire Rapids

---------------

 Documentation/ABI/testing/sysfs-class-devfreq      |  12 +
 Documentation/admin-guide/kernel-parameters.txt    |   5 +
 Documentation/admin-guide/pm/cpufreq.rst           |   6 +-
 Documentation/admin-guide/pm/intel_pstate.rst      |  17 +-
 .../devicetree/bindings/devfreq/rk3399_dmc.txt     |   2 +
 Documentation/power/energy-model.rst               | 135 +++++-----
 Documentation/power/powercap/powercap.rst          |  15 +-
 MAINTAINERS                                        |   9 +
 arch/powerpc/platforms/cell/cpufreq_spudemand.c    |  26 +-
 arch/x86/include/asm/msr-index.h                   |   6 +-
 drivers/acpi/processor_idle.c                      |  10 +-
 drivers/base/power/domain.c                        | 194 +++++++-------
 drivers/base/power/domain_governor.c               |  12 +-
 drivers/base/power/sysfs.c                         |   9 +-
 drivers/cpufreq/acpi-cpufreq.c                     |  10 +-
 drivers/cpufreq/amd_freq_sensitivity.c             |   2 +-
 drivers/cpufreq/cpufreq-dt.c                       |   2 +-
 drivers/cpufreq/cpufreq.c                          | 122 +++++----
 drivers/cpufreq/cpufreq_conservative.c             |  22 +-
 drivers/cpufreq/cpufreq_governor.c                 |   2 +-
 drivers/cpufreq/cpufreq_ondemand.c                 |  24 +-
 drivers/cpufreq/cpufreq_performance.c              |  14 +-
 drivers/cpufreq/cpufreq_powersave.c                |  18 +-
 drivers/cpufreq/cpufreq_userspace.c                |  18 +-
 drivers/cpufreq/davinci-cpufreq.c                  |   2 +-
 drivers/cpufreq/freq_table.c                       |   6 +-
 drivers/cpufreq/imx6q-cpufreq.c                    |   2 +-
 drivers/cpufreq/intel_pstate.c                     | 187 +++++++++----
 drivers/cpufreq/mediatek-cpufreq.c                 |   2 +-
 drivers/cpufreq/omap-cpufreq.c                     |   2 +-
 drivers/cpufreq/pasemi-cpufreq.c                   |   2 +
 drivers/cpufreq/pcc-cpufreq.c                      |   2 +-
 drivers/cpufreq/powernow-k8.c                      |   4 +-
 drivers/cpufreq/powernv-cpufreq.c                  |  19 +-
 drivers/cpufreq/qcom-cpufreq-hw.c                  |   2 +-
 drivers/cpufreq/scmi-cpufreq.c                     |  11 +-
 drivers/cpufreq/scpi-cpufreq.c                     |   2 +-
 drivers/cpufreq/vexpress-spc-cpufreq.c             |   2 +-
 drivers/cpuidle/Kconfig.arm                        |  10 +
 drivers/cpuidle/Makefile                           |   5 +-
 drivers/cpuidle/cpuidle-psci-domain.c              |  74 ++++--
 drivers/cpuidle/cpuidle-psci.c                     | 141 +++++-----
 drivers/cpuidle/cpuidle-psci.h                     |  11 +-
 drivers/cpuidle/cpuidle-tegra.c                    |   8 +-
 drivers/devfreq/devfreq-event.c                    |   4 +-
 drivers/devfreq/devfreq.c                          | 195 ++++++++++----
 drivers/devfreq/rk3399_dmc.c                       |  42 +--
 drivers/idle/intel_idle.c                          |  53 +++-
 drivers/memory/samsung/exynos5422-dmc.c            |  14 +-
 drivers/mmc/host/jz4740_mmc.c                      |  12 +-
 drivers/opp/core.c                                 |   3 +-
 drivers/opp/of.c                                   |  76 +++---
 drivers/opp/ti-opp-supply.c                        |   2 +-
 drivers/powercap/idle_inject.c                     |  10 +-
 drivers/powercap/intel_rapl_common.c               |  77 +++++-
 drivers/powercap/intel_rapl_msr.c                  |  15 ++
 drivers/thermal/cpufreq_cooling.c                  |  12 +-
 fs/nfs/nfs4proc.c                                  |   2 +-
 include/linux/cpufreq.h                            |  14 +
 include/linux/cpuidle.h                            |   9 +-
 include/linux/devfreq.h                            |   9 +
 include/linux/device.h                             |   5 +
 include/linux/energy_model.h                       | 149 ++++++-----
 include/linux/freezer.h                            |  14 +
 include/linux/intel_rapl.h                         |   5 +-
 include/linux/pm.h                                 |  10 +-
 include/linux/pm_domain.h                          |  12 +-
 include/linux/pm_opp.h                             |  15 +-
 kernel/power/energy_model.c                        | 290 ++++++++++++++-------
 kernel/power/hibernate.c                           |   6 +-
 kernel/power/power.h                               |   2 +-
 kernel/power/snapshot.c                            |   4 +-
 kernel/sched/cpufreq_schedutil.c                   |   6 +-
 kernel/sched/fair.c                                |   2 +-
 kernel/sched/topology.c                            |  20 +-
 scripts/gdb/linux/genpd.py                         |  12 +-
 tools/power/cpupower/lib/cpufreq.c                 |  10 +-
 tools/power/cpupower/man/cpupower-monitor.1        |   4 +-
 tools/power/cpupower/utils/helpers/bitmask.c       |   6 +-
 tools/power/pm-graph/README                        |   2 +-
 tools/power/pm-graph/sleepgraph.py                 | 249 +++++++++++-------
 81 files changed, 1596 insertions(+), 962 deletions(-)
