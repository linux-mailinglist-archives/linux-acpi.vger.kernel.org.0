Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECACB4BE0
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Sep 2019 12:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfIQKX3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 17 Sep 2019 06:23:29 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39922 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfIQKX2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Sep 2019 06:23:28 -0400
Received: by mail-oi1-f194.google.com with SMTP id w144so2367206oia.6;
        Tue, 17 Sep 2019 03:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=bLh8uClUJZa0np6pYEs3eXBA4w9UfeDgXQeEz78I6ds=;
        b=n24DO2z6AWK67/ln330hurePL01JcrmMfnTriMogdC99giZ8Smqtth7B70C55f6hKg
         +U5DETAgGf0bwgPgtnj6LYfQ70gzkVRQmtkIBsJE4YU22uVdZ8foM6qWUNkaKgCfIkxO
         MwkpubZaKRDni4K9UITpcHXVYIca0A0kfhY7FIU+cN5zo1Vc7jqdC885ow7Yw5C9tip0
         YWgeaJVqo7Ow34TUvPRGLSYIW0B3CS4Fg7jNLdtZnoUICGcsfoIj3WXpIS5hnJ5SAc1l
         Wj5EhrKD/a21OHn9fkENEIrPjirNku83437y2f+uiIc2RtXAp1Ein0PoAnojClj/UJou
         YQ/w==
X-Gm-Message-State: APjAAAWwcLeibz/tRody9s7Ou2zVEEZYzG+RoIrm3UPOWacyTLQRKyDb
        7DGTBX1rabNTpH8lzS/lomLlC66c0k7etBmT5UwgAPjf
X-Google-Smtp-Source: APXvYqz6swm+PfWxfc0zXHhWEROoMSpqrjer2W+58qk283+vWpx52dXhN0cH67CJyc/pfvotGU5Rr8TZ3zD61AR3Ncw=
X-Received: by 2002:aca:db44:: with SMTP id s65mr171160oig.103.1568715806304;
 Tue, 17 Sep 2019 03:23:26 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Sep 2019 12:23:15 +0200
Message-ID: <CAJZ5v0jrNv=V2oVCNu5HO5akRW1m5Z9tbuW3GxL6H61vqxP7ng@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v5.4-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.4-rc1

with top-most commit fc6763a2d7e0a7f49ccec97a46e92e9fb1f3f9dd

 Merge branches 'pm-opp', 'pm-qos', 'acpi-pm', 'pm-domains' and 'pm-tools'

on top of commit 089cf7f6ecb266b6a4164919a2e69bd2f938374a

 Linux 5.3-rc7

to receive power management updates for 5.4-rc1.

These include a rework of the main suspend-to-idle code flow (related
to the handling of spurious wakeups), a switch over of several users
of cpufreq notifiers to QoS-based limits, a new devfreq driver for
Tegra20, a new cpuidle driver and governor for virtualized guests,
an extension of the wakeup sources framework to expose wakeup sources
as device objects in sysfs, and more.

Specifics:

 - Rework the main suspend-to-idle control flow to avoid repeating
   "noirq" device resume and suspend operations in case of spurious
   wakeups from the ACPI EC and decouple the ACPI EC wakeups support
   from the LPS0 _DSM support (Rafael Wysocki).

 - Extend the wakeup sources framework to expose wakeup sources as
   device objects in sysfs (Tri Vo, Stephen Boyd).

 - Expose system suspend statistics in sysfs (Kalesh Singh).

 - Introduce a new haltpoll cpuidle driver and a new matching
   governor for virtualized guests wanting to do guest-side polling
   in the idle loop (Marcelo Tosatti, Joao Martins, Wanpeng Li,
   Stephen Rothwell).

 - Fix the menu and teo cpuidle governors to allow the scheduler tick
   to be stopped if PM QoS is used to limit the CPU idle state exit
   latency in some cases (Rafael Wysocki).

 - Increase the resolution of the play_idle() argument to microseconds
   for more fine-grained injection of CPU idle cycles (Daniel Lezcano).

 - Switch over some users of cpuidle notifiers to the new QoS-based
   frequency limits and drop the CPUFREQ_ADJUST and CPUFREQ_NOTIFY
   policy notifier events (Viresh Kumar).

 - Add new cpufreq driver based on nvmem for sun50i (Yangtao Li).

 - Add support for MT8183 and MT8516 to the mediatek cpufreq driver
   (Andrew-sh.Cheng, Fabien Parent).

 - Add i.MX8MN support to the imx-cpufreq-dt cpufreq driver (Anson
   Huang).

 - Add qcs404 to cpufreq-dt-platdev blacklist (Jorge Ramirez-Ortiz).

 - Update the qcom cpufreq driver (among other things, to make it
   easier to extend and to use kryo cpufreq for other nvmem-based
   SoCs) and add qcs404 support to it  (Niklas Cassel, Douglas
   RAILLARD, Sibi Sankar, Sricharan R).

 - Fix assorted issues and make assorted minor improvements in the
   cpufreq code (Colin Ian King, Douglas RAILLARD, Florian Fainelli,
   Gustavo Silva, Hariprasad Kelam).

 - Add new devfreq driver for NVidia Tegra20 (Dmitry Osipenko, Arnd
   Bergmann).

 - Add new Exynos PPMU events to devfreq events and extend that
   mechanism (Lukasz Luba).

 - Fix and clean up the exynos-bus devfreq driver (Kamil Konieczny).

 - Improve devfreq documentation and governor code, fix spelling
   typos in devfreq (Ezequiel Garcia, Krzysztof Kozlowski, Leonard
   Crestez, MyungJoo Ham, Gaël PORTAY).

 - Add regulators enable and disable to the OPP (operating performance
   points) framework (Kamil Konieczny).

 - Update the OPP framework to support multiple opp-suspend properties
   (Anson Huang).

 - Fix assorted issues and make assorted minor improvements in the OPP
   code (Niklas Cassel, Viresh Kumar, Yue Hu).

 - Clean up the generic power domains (genpd) framework (Ulf Hansson).

 - Clean up assorted pieces of power management code and documentation
   (Akinobu Mita, Amit Kucheria, Chuhong Yuan).

 - Update the pm-graph tool to version 5.5 including multiple fixes
   and improvements (Todd Brandt).

 - Update the cpupower utility (Benjamin Weis, Geert Uytterhoeven,
   Sébastien Szymanski).

Thanks!


---------------

Akinobu Mita (1):
      PM: runtime: Documentation: add runtime_status ABI document

Amit Kucheria (1):
      PM: QoS: Get rid of unused flags

Andrew-sh.Cheng (2):
      cpufreq: mediatek: change to regulator_get_optional
      cpufreq: mediatek: Add support for mt8183

Anson Huang (4):
      dt-bindings: opp: Support multiple opp-suspend properties
      opp: of: Support multiple suspend OPPs defined in DT
      cpufreq: Use imx-cpufreq-dt for i.MX8MN's speed grading
      cpufreq: imx-cpufreq-dt: Add i.MX8MN support

Arnd Bergmann (1):
      PM / devfreq: tegra20: add COMMON_CLK dependency

Benjamin Weis (1):
      cpupower: update German translation

Chuhong Yuan (1):
      PM: sleep: Replace strncmp() with str_has_prefix()

Colin Ian King (1):
      cpufreq: remove redundant assignment to ret

Daniel Lezcano (2):
      cpuidle: play_idle: Increase the resolution to usec
      powercap: idle_inject: Use higher resolution for idle injection

Dmitry Osipenko (16):
      PM / devfreq: tegra: Fix kHz to Hz conversion
      PM / devfreq: tegra: Replace readl-writel with relaxed versions
      PM / devfreq: tegra: Replace write memory barrier with the read barrier
      PM / devfreq: tegra: Don't ignore clk errors
      PM / devfreq: tegra: Don't set EMC clock rate to maximum on probe
      PM / devfreq: tegra: Drop primary interrupt handler
      PM / devfreq: tegra: Properly disable interrupts
      PM / devfreq: tegra: Clean up driver's probe / remove
      PM / devfreq: tegra: Avoid inconsistency of current frequency value
      PM / devfreq: tegra: Mark ACTMON's governor as immutable
      PM / devfreq: tegra: Move governor registration to driver's probe
      PM / devfreq: tegra: Reconfigure hardware on governor's restart
      PM / devfreq: tegra: Support Tegra30
      PM / devfreq: tegra: Enable COMPILE_TEST for the driver
      PM / devfreq: tegra: Rename tegra-devfreq.c to tegra30-devfreq.c
      PM / devfreq: Introduce driver for NVIDIA Tegra20

Douglas RAILLARD (2):
      cpufreq: qcom-hw: invoke frequency-invariance setter function
      sched/cpufreq: Align trace event behavior of fast switching

Ezequiel Garcia (1):
      PM / devfreq: Fix kernel oops on governor module load

Fabien Parent (1):
      cpufreq: mediatek-cpufreq: Add compatible for MT8516

Florian Fainelli (1):
      cpufreq: Print driver name if cpufreq_suspend() fails

Gaël PORTAY (2):
      PM / devfreq: Fix spelling typo
      PM / devfreq: rk3399_dmc: Fix spelling typo

Geert Uytterhoeven (1):
      cpupower: Add missing newline at end of file

Gustavo A. R. Silva (1):
      cpufreq: ti-cpufreq: Mark expected switch fall-through

Hariprasad Kelam (1):
      cpufreq: ap806: Add NULL check after kcalloc

Joao Martins (5):
      cpuidle-haltpoll: vcpu hotplug support
      cpuidle: allow governor switch on cpuidle_register_driver()
      cpuidle-haltpoll: set haltpoll as preferred governor
      cpuidle-haltpoll: return -ENODEV on modinit failure
      cpuidle-haltpoll: do not set an owner to allow modunload

Jorge Ramirez-Ortiz (1):
      cpufreq: Add qcs404 to cpufreq-dt-platdev blacklist

Kalesh Singh (1):
      PM/sleep: Expose suspend stats in sysfs

Kamil Konieczny (2):
      PM / devfreq: exynos-bus: Correct clock enable sequence
      PM / devfreq: exynos-bus: Convert to use dev_pm_opp_set_rate()

Krzysztof Kozlowski (1):
      PM / devfreq: Correct devm_devfreq_remove_device() documentation

Leonard Crestez (1):
      PM / devfreq: passive: Use non-devm notifiers

Lukasz Luba (3):
      PM / devfreq: events: add Exynos PPMU new events
      PM / devfreq: exynos-events: change matching code during probe
      PM / devfreq: events: extend events by type of counted data

Marcelo Tosatti (5):
      add cpuidle-haltpoll driver
      cpuidle: add poll_limit_ns to cpuidle_device structure
      governors: unify last_state_idx
      cpuidle: add haltpoll governor
      cpuidle-haltpoll: disable host side polling when kvm virtualized

MyungJoo Ham (1):
      PM / devfreq: passive: fix compiler warning

Niklas Cassel (6):
      opp: Add dev_pm_opp_find_level_exact()
      dt-bindings: opp: qcom-nvmem: Make speedbin related properties optional
      dt-bindings: opp: qcom-nvmem: Support pstates provided by a power domain
      dt-bindings: opp: Add qcom-opp bindings with properties needed for CPR
      cpufreq: qcom: Refactor the driver to make it easier to extend
      cpufreq: qcom: Add support for qcs404 on nvmem driver

Rafael J. Wysocki (25):
      PCI: irq: Introduce rearm_wake_irq()
      ACPICA: Return u32 from acpi_dispatch_gpe()
      ACPI: EC: Return bool from acpi_ec_dispatch_gpe()
      PM: sleep: Fix possible overflow in pm_system_cancel_wakeup()
      ACPI: PM: Set s2idle_wakeup earlier and clear it later
      PM: sleep: Simplify suspend-to-idle control flow
      PM: sleep: Integrate suspend-to-idle with generig suspend flow
      PM: sleep: Drop dpm_noirq_begin() and dpm_noirq_end()
      ACPI: PM: Set up EC GPE for system wakeup from drivers that need it
      cpuidle: menu: Allow tick to be stopped if PM QoS is used
      cpuidle: teo: Allow tick to be stopped if PM QoS is used
      ACPI: PM: s2idle: Rearrange lps0_device_attach()
      ACPI: PM: s2idle: Add acpi.sleep_no_lps0 module parameter
      ACPI: PM: s2idle: Switch EC over to polling during "noirq" suspend
      ACPI: PM: s2idle: Eliminate acpi_sleep_no_ec_events()
      ACPI: EC: PM: Consolidate some code depending on PM_SLEEP
      ACPI: EC: PM: Make acpi_ec_dispatch_gpe() print debug message
      ACPI: PM: s2idle: Execute LPS0 _DSM functions with suspended devices
      ACPI: PM: Print debug messages on device power state changes
      intel-hid: intel-vbtn: Avoid leaking wakeup_mode set
      intel-hid: Disable button array during suspend-to-idle
      PM: suspend: Fix platform_suspend_prepare_noirq()
      cpuidle: teo: Get rid of redundant check in teo_update()
      ACPI: PM: s2idle: Avoid rearming SCI for wakeup unnecessarily
      ACPI: PM: s2idle: Always set up EC GPE for system wakeup

Sibi Sankar (1):
      cpufreq: qcom-hw: Update logic to detect turbo frequency

Sricharan R (2):
      dt-bindings: opp: Re-organise kryo cpufreq to use it for other
nvmem based qcom socs
      cpufreq: qcom: Re-organise kryo cpufreq to use it for other
nvmem based qcom socs

Stephen Boyd (3):
      PM / wakeup: Fix sysfs registration error path
      PM / wakeup: Register wakeup class kobj after device is added
      PM / wakeup: Unexport wakeup_source_sysfs_{add,remove}()

Stephen Rothwell (1):
      cpuidle: header file stubs must be "static inline"

Sébastien Szymanski (1):
      tools/power/cpupower: fix 64bit detection when cross-compiling

Todd Brandt (2):
      pm-graph v5.5
      pm-graph: make setVal unbuffered again for python2 and python3

Tri Vo (3):
      PM / wakeup: Drop wakeup_source_init(), wakeup_source_prepare()
      PM / wakeup: Use wakeup_source_register() in wakelock.c
      PM / wakeup: Show wakeup sources stats in sysfs

Ulf Hansson (3):
      PM / Domains: Align in-parameter names for some genpd functions
      PM / Domains: Simplify genpd_lookup_dev()
      PM / Domains: Verify PM domain type in
dev_pm_genpd_set_performance_state()

Viresh Kumar (14):
      opp: Not all power-domains are scalable
      opp: Return genpd virtual devices from dev_pm_opp_attach_genpd()
      opp: Don't decrement uninitialized list_kref
      cpufreq: Add policy create/remove notifiers back
      thermal: cpu_cooling: Switch to QoS requests for freq limits
      cpufreq: intel_pstate: Implement QoS supported freq constraints
      cpufreq: powerpc: macintosh: Switch to QoS requests for freq limits
      cpufreq: powerpc_cbe: Switch to QoS requests for freq limits
      arch_topology: Use CPUFREQ_CREATE_POLICY instead of CPUFREQ_NOTIFY
      video: sa1100fb: Remove cpufreq policy notifier
      video: pxafb: Remove cpufreq policy notifier
      ACPI: cpufreq: Switch to QoS requests instead of cpufreq notifier
      cpufreq: Remove CPUFREQ_ADJUST and CPUFREQ_NOTIFY policy notifier events
      Documentation: cpufreq: Update policy notifier documentation

Wanpeng Li (1):
      cpuidle-haltpoll: Enable kvm guest polling when dedicated
physical CPUs are available

Yangtao Li (2):
      cpufreq: Add sun50i nvmem based CPU scaling driver
      dt-bindings: cpufreq: Document allwinner,sun50i-h6-operating-points

Yue Hu (1):
      PM / OPP: Correct Documentation about library location

k.konieczny@partner.samsung.com (1):
      opp: core: add regulators enable and disable

---------------

 Documentation/ABI/testing/sysfs-class-wakeup       |  76 +++
 Documentation/ABI/testing/sysfs-devices-power      |   9 +
 Documentation/ABI/testing/sysfs-power              | 106 ++++
 Documentation/cpu-freq/core.txt                    |  16 +-
 Documentation/devicetree/bindings/opp/opp.txt      |   4 +-
 .../{kryo-cpufreq.txt => qcom-nvmem-cpufreq.txt}   | 127 ++++-
 Documentation/devicetree/bindings/opp/qcom-opp.txt |  19 +
 .../bindings/opp/sun50i-nvmem-cpufreq.txt          | 167 ++++++
 Documentation/power/opp.rst                        |   2 +-
 Documentation/power/pm_qos_interface.rst           |   5 +-
 Documentation/virtual/guest-halt-polling.txt       |  78 +++
 MAINTAINERS                                        |  11 +-
 arch/x86/Kconfig                                   |   7 +
 arch/x86/include/asm/cpuidle_haltpoll.h            |   8 +
 arch/x86/kernel/kvm.c                              |  37 ++
 arch/x86/kernel/process.c                          |   2 +-
 drivers/acpi/acpica/evxfgpe.c                      |   6 +-
 drivers/acpi/device_pm.c                           |   7 +-
 drivers/acpi/ec.c                                  |  57 +-
 drivers/acpi/internal.h                            |   6 +-
 drivers/acpi/processor_driver.c                    |  39 +-
 drivers/acpi/processor_perflib.c                   | 100 ++--
 drivers/acpi/processor_thermal.c                   |  84 ++-
 drivers/acpi/sleep.c                               | 165 +++---
 drivers/base/arch_topology.c                       |   2 +-
 drivers/base/power/Makefile                        |   2 +-
 drivers/base/power/domain.c                        |  25 +-
 drivers/base/power/main.c                          |  35 +-
 drivers/base/power/power.h                         |  18 +
 drivers/base/power/sysfs.c                         |   6 +
 drivers/base/power/wakeup.c                        |  72 ++-
 drivers/base/power/wakeup_stats.c                  | 214 +++++++
 drivers/cpufreq/Kconfig.arm                        |  16 +-
 drivers/cpufreq/Makefile                           |   3 +-
 drivers/cpufreq/armada-8k-cpufreq.c                |   2 +
 drivers/cpufreq/cpufreq-dt-platdev.c               |   5 +
 drivers/cpufreq/cpufreq.c                          |  57 +-
 drivers/cpufreq/imx-cpufreq-dt.c                   |   8 +-
 drivers/cpufreq/intel_pstate.c                     | 120 +++-
 drivers/cpufreq/mediatek-cpufreq.c                 |   4 +-
 drivers/cpufreq/ppc_cbe_cpufreq.c                  |  19 +-
 drivers/cpufreq/ppc_cbe_cpufreq.h                  |   8 +
 drivers/cpufreq/ppc_cbe_cpufreq_pmi.c              |  96 ++--
 drivers/cpufreq/qcom-cpufreq-hw.c                  |  23 +-
 drivers/cpufreq/qcom-cpufreq-kryo.c                | 249 ---------
 drivers/cpufreq/qcom-cpufreq-nvmem.c               | 352 ++++++++++++
 drivers/cpufreq/sun50i-cpufreq-nvmem.c             | 226 ++++++++
 drivers/cpufreq/ti-cpufreq.c                       |   1 +
 drivers/cpuidle/Kconfig                            |  20 +
 drivers/cpuidle/Makefile                           |   1 +
 drivers/cpuidle/cpuidle-haltpoll.c                 | 134 +++++
 drivers/cpuidle/cpuidle.c                          |  30 +
 drivers/cpuidle/cpuidle.h                          |   2 +
 drivers/cpuidle/driver.c                           |  25 +
 drivers/cpuidle/governor.c                         |   7 +-
 drivers/cpuidle/governors/Makefile                 |   1 +
 drivers/cpuidle/governors/haltpoll.c               | 150 +++++
 drivers/cpuidle/governors/ladder.c                 |  21 +-
 drivers/cpuidle/governors/menu.c                   |  21 +-
 drivers/cpuidle/governors/teo.c                    |  60 +-
 drivers/cpuidle/poll_state.c                       |  11 +-
 drivers/cpuidle/sysfs.c                            |   7 +
 drivers/devfreq/Kconfig                            |  19 +-
 drivers/devfreq/Makefile                           |   3 +-
 drivers/devfreq/devfreq.c                          |  12 +-
 drivers/devfreq/event/exynos-ppmu.c                | 104 ++--
 drivers/devfreq/exynos-bus.c                       | 153 ++---
 drivers/devfreq/governor_passive.c                 |   7 +-
 drivers/devfreq/rk3399_dmc.c                       |   2 +-
 drivers/devfreq/tegra20-devfreq.c                  | 212 +++++++
 .../devfreq/{tegra-devfreq.c => tegra30-devfreq.c} | 315 +++++------
 drivers/macintosh/windfarm_cpufreq_clamp.c         |  77 ++-
 drivers/opp/core.c                                 |  85 ++-
 drivers/opp/of.c                                   |  30 +-
 drivers/platform/x86/intel-hid.c                   |  36 +-
 drivers/platform/x86/intel-vbtn.c                  |  20 +-
 drivers/powercap/idle_inject.c                     |  53 +-
 drivers/thermal/cpu_cooling.c                      | 110 +---
 drivers/thermal/intel/intel_powerclamp.c           |   2 +-
 drivers/video/fbdev/pxafb.c                        |  21 -
 drivers/video/fbdev/pxafb.h                        |   1 -
 drivers/video/fbdev/sa1100fb.c                     |  27 -
 drivers/video/fbdev/sa1100fb.h                     |   1 -
 fs/eventpoll.c                                     |   4 +-
 include/acpi/acpixf.h                              |   8 +-
 include/acpi/processor.h                           |  26 +-
 include/linux/acpi.h                               |   4 +
 include/linux/cpu.h                                |   2 +-
 include/linux/cpufreq.h                            |   4 +-
 include/linux/cpuidle.h                            |  10 +
 include/linux/cpuidle_haltpoll.h                   |  16 +
 include/linux/devfreq-event.h                      |   6 +
 include/linux/idle_inject.h                        |   8 +-
 include/linux/interrupt.h                          |   1 +
 include/linux/pm.h                                 |   4 -
 include/linux/pm_domain.h                          |  16 +-
 include/linux/pm_opp.h                             |  12 +-
 include/linux/pm_qos.h                             |   6 -
 include/linux/pm_wakeup.h                          |  21 +-
 include/linux/suspend.h                            |   4 +-
 include/trace/events/power.h                       |   8 +-
 kernel/irq/pm.c                                    |  20 +
 kernel/power/autosleep.c                           |   2 +-
 kernel/power/main.c                                |  99 +++-
 kernel/power/qos.c                                 |  48 --
 kernel/power/suspend.c                             |  65 +--
 kernel/power/wakelock.c                            |  32 +-
 kernel/sched/cpufreq_schedutil.c                   |   7 +-
 kernel/sched/idle.c                                |   7 +-
 kernel/time/alarmtimer.c                           |   2 +-
 tools/power/cpupower/Makefile                      |  14 +-
 tools/power/cpupower/bench/cpufreq-bench_plot.sh   |   2 +-
 tools/power/cpupower/bench/cpufreq-bench_script.sh |   2 +-
 tools/power/cpupower/po/de.po                      | 344 ++++++------
 tools/power/pm-graph/README                        |   6 +-
 tools/power/pm-graph/bootgraph.py                  |  59 +-
 tools/power/pm-graph/sleepgraph.8                  |   8 +-
 tools/power/pm-graph/sleepgraph.py                 | 618 ++++++++++++---------
 118 files changed, 4052 insertions(+), 1924 deletions(-)
