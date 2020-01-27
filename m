Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70AF714A816
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Jan 2020 17:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgA0QcG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 27 Jan 2020 11:32:06 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38063 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgA0QcG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jan 2020 11:32:06 -0500
Received: by mail-oi1-f196.google.com with SMTP id l9so7220344oii.5;
        Mon, 27 Jan 2020 08:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=VeccTOturxhWBwOWdsdrI8lN/hBVymQLTDOh5JKZxy8=;
        b=Rs2T5i6MGF/FWacjXCXK4uM1OmwfxHhGDJRCIm88Iae6vUE/CJEon/R2myiHFNmZeR
         eRcG9U0pCOTsHlmWXh5VFGaOgfaGoYS2jlHUODo3hC0LaNQh/IzFNb7Z8bG/pKZpk01T
         ZrO64uin5X3dTlNI4E3/N9CcCrE4/Ks5u4ud3rrYqFbnyNU+aD46NgPVRffbPIGUGNy3
         Yc7PjTIzQWVgbI8W+gcuX6KJJVwBO/+5Z6XMOChDTSRYaFE9sEfv3zOLacpoF20HYKRG
         PVPsMugXuCVOxj2UNwym25oUg2AUthbtZuqmgJJBUN+F6QqJYHPcrQGwhAPivnmR1CO8
         QteQ==
X-Gm-Message-State: APjAAAV4o/jTzCApvu4KeUmrUsvoGtLGus4b0+hVvokJfSuZ330YNTiT
        IVM+q59HMLCkE2uk26wqXND50BT+9emSgsP5xbYztm/O
X-Google-Smtp-Source: APXvYqwhoE7cDXsoVHRpYLKRzp4ltic/HLNEQ2Z/VljtCY4VPRS/aQEVKkmpvsaS/y9JYGdV6HdwnlHFm3qV9IGeeuc=
X-Received: by 2002:a54:488d:: with SMTP id r13mr7614457oic.115.1580142725384;
 Mon, 27 Jan 2020 08:32:05 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jan 2020 17:31:54 +0100
Message-ID: <CAJZ5v0jGdfSUK4s3nq_uCiQrg8tWrycv_C_xNg7CYk4LC8o-Dw@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v5.6-rc1
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
 pm-5.6-rc1

with top-most commit c102671af085aacf17219e9bdcfccddc6620a866

 Merge branch 'pm-devfreq'

on top of commit 3a83c8c81c91fe10e7002c2c0e74b23e80f41f28

 Merge tag 'pm-5.5-rc8' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive power management updates for 5.6-rc1.

These add ACPI support to the intel_idle driver along with an admin
guide document for it, add support for CPR (Core Power Reduction) to
the AVS (Adaptive Voltage Scaling) subsystem, add new hardware support
in a few places, add some new sysfs attributes, debugfs files and
tracepoints, fix bugs and clean up a bunch of things all over.

Specifics:

 - Update the ACPI processor driver in order to export
   acpi_processor_evaluate_cst() to the code outside of it, add
   ACPI support to the intel_idle driver based on that and clean
   up that driver somewhat (Rafael Wysocki).

 - Add an admin guide document for the intel_idle driver (Rafael
   Wysocki).

 - Clean up cpuidle core and drivers, enable compilation testing
   for some of them (Benjamin Gaignard, Krzysztof Kozlowski, Rafael
   Wysocki, Yangtao Li).

 - Fix reference counting of OPP (operating performance points) table
   structures (Viresh Kumar).

 - Add support for CPR (Core Power Reduction) to the AVS (Adaptive
   Voltage Scaling) subsystem (Niklas Cassel, Colin Ian King,
   YueHaibing).

 - Add support for TigerLake Mobile and JasperLake to the Intel RAPL
   power capping driver (Zhang Rui).

 - Update cpufreq drivers:

   * Add i.MX8MP support to imx-cpufreq-dt (Anson Huang).

   * Fix usage of a macro in loongson2_cpufreq (Alexandre Oliva).

   * Fix cpufreq policy reference counting issues in s3c and
     brcmstb-avs (chenqiwu).

   * Fix ACPI table reference counting issue and HiSilicon quirk
     handling in the CPPC driver (Hanjun Guo).

   * Clean up spelling mistake in intel_pstate (Harry Pan).

   * Convert the kirkwood and tegra186 drivers to using
     devm_platform_ioremap_resource() (Yangtao Li).

 - Update devfreq core:

   * Add 'name' sysfs attribute for devfreq devices (Chanwoo Choi).

   * Clean up the handing of transition statistics and allow them
     to be reset by writing 0 to the 'trans_stat' devfreq device
     attribute in sysfs (Kamil Konieczny).

   * Add 'devfreq_summary' to debugfs (Chanwoo Choi).

   * Clean up kerneldoc comments and Kconfig indentation (Krzysztof
     Kozlowski, Randy Dunlap).

 - Update devfreq drivers:

   * Add dynamic scaling for the imx8m DDR controller and clean up
     imx8m-ddrc (Leonard Crestez, YueHaibing).

   * Fix DT node reference counting and nitialization error code path
     in rk3399_dmc and add COMPILE_TEST and HAVE_ARM_SMCCC dependency
     for it (Chanwoo Choi, Yangtao Li).

   * Fix DT node reference counting in rockchip-dfi and make it use
     devm_platform_ioremap_resource() (Yangtao Li).

   * Fix excessive stack usage in exynos-ppmu (Arnd Bergmann).

   * Fix initialization error code paths in exynos-bus (Yangtao Li).

   * Clean up exynos-bus and exynos somewhat (Artur Świgoń, Krzysztof
     Kozlowski).

 - Add tracepoints for tracking usage_count updates unrelated to
   status changes in PM-runtime (Michał Mirosław).

 - Add sysfs attribute to control the "sync on suspend" behavior
   during system-wide suspend (Jonas Meurer).

 - Switch system-wide suspend tests over to 64-bit time (Alexandre
   Belloni).

 - Make wakeup sources statistics in debugfs cover deleted ones which
   used to be the case some time ago (zhuguangqing).

 - Clean up computations carried out during hibernation, update
   messages related to hibernation and fix a spelling mistake in one
   of them (Wen Yang, Luigi Semenzato, Colin Ian King).

 - Add mailmap entry for maintainer e-mail address that has not been
   functional for several years (Rafael Wysocki).

Thanks!


---------------

Alexandre Belloni (1):
      PM: sleep: Switch to rtc_time64_to_tm()/rtc_tm_to_time64()

Alexandre Oliva (1):
      cpufreq: loongson2_cpufreq: adjust cpufreq uses of LOONGSON_CHIPCFG

Anson Huang (2):
      cpufreq: Use imx-cpufreq-dt for i.MX8MP's speed grading
      cpufreq: imx-cpufreq-dt: Add i.MX8MP support

Arnd Bergmann (1):
      PM / devfreq: exynos-ppmu: Fix excessive stack usage

Artur Świgoń (3):
      PM / devfreq: exynos-bus: Extract exynos_bus_profile_init()
      PM / devfreq: exynos-bus: Extract exynos_bus_profile_init_passive()
      PM / devfreq: exynos-bus: Reduce goto statements and remove unused headers

Benjamin Gaignard (3):
      cpuidle: coupled: fix warnings when compiling with W=1
      cpuidle: sysfs: fix warnings when compiling with W=1
      cpuidle: fix cpuidle_find_deepest_state() kerneldoc warnings

Chanwoo Choi (3):
      PM / devfreq: Add new name attribute for sysfs
      PM / devfreq: rk3399_dmc: Add COMPILE_TEST and HAVE_ARM_SMCCC dependency
      PM / devfreq: Add debugfs support with devfreq_summary file

Colin Ian King (2):
      power: avs: fix uninitialized error return on failed
cpr_read_fuse_uV() call
      PM: hibernate: fix spelling mistake "shapshot" -> "snapshot"

Hanjun Guo (2):
      cpufreq : CPPC: Break out if HiSilicon CPPC workaround is matched
      cpufreq: CPPC: put ACPI table after using it

Harry Pan (1):
      cpufreq: intel_pstate: fix spelling mistake: "Whethet" -> "Whether"

Jonas Meurer (1):
      PM: suspend: Add sysfs attribute to control the "sync on suspend" behavior

Kamil Konieczny (4):
      PM / devfreq: Change time stats to 64-bit
      PM / devfreq: Add clearing transitions stats
      PM / devfreq: Move statistics to separate struct devfreq_stats
      PM / devfreq: Move declaration of DEVICE_ATTR_RW(min_freq)

Krzysztof Kozlowski (3):
      PM / devfreq: Fix Kconfig indentation
      PM / devfreq: exynos: Rename Exynos to lowercase
      cpuidle: arm: Enable compile testing for some of drivers

Leonard Crestez (3):
      dt-bindings: memory: Add bindings for imx8m ddr controller
      PM / devfreq: Add dynamic scaling for imx8m ddr controller
      PM / devfreq: imx8m-ddrc: Remove unused defines

Luigi Semenzato (1):
      PM: hibernate: Add more logging on hibernation failure

Michał Mirosław (1):
      PM-runtime: add tracepoints for usage_count changes

Niklas Cassel (7):
      dt-bindings: power: avs: Add support for CPR (Core Power Reduction)
      power: avs: Add support for CPR (Core Power Reduction)
      power: avs: qcom-cpr: fix invalid printk specifier in debug print
      power: avs: qcom-cpr: fix unsigned expression compared with zero
      power: avs: qcom-cpr: make sure that regmap is available
      power: avs: qcom-cpr: remove set but unused variable
      power: avs: qcom-cpr: make cpr_get_opp_hz_for_req() static

Rafael J. Wysocki (22):
      ACPI: processor: Export function to claim _CST control
      ACPI: processor: Introduce acpi_processor_evaluate_cst()
      ACPI: processor: Clean up acpi_processor_evaluate_cst()
      mailmap: Add entry for <rjw@sisk.pl>
      ACPI: processor: Make ACPI_PROCESSOR_CSTATE depend on ACPI_PROCESSOR
      ACPI: processor: Export acpi_processor_evaluate_cst()
      intel_idle: Refactor intel_idle_cpuidle_driver_init()
      intel_idle: Use ACPI _CST for processor models without C-state tables
      cpuidle: Allow idle states to be disabled by default
      intel_idle: Allow ACPI _CST to be used for selected known processors
      intel_idle: Add module parameter to prevent ACPI _CST from being used
      intel_idle: Use ACPI _CST on server systems
      cpuidle: Drop unused cpuidle_driver_ref/unref() functions
      Documentation: admin-guide: PM: Add intel_idle document
      intel_idle: Eliminate __setup_broadcast_timer()
      intel_idle: Fold intel_idle_probe() into intel_idle_init()
      intel_idle: Clean up NULL pointer check in intel_idle_init()
      intel_idle: Rearrange intel_idle_cpuidle_driver_init()
      intel_idle: Move and clean up intel_idle_cpuidle_devices_uninit()
      intel_idle: Annotate initialization code and data structures
      intel_idle: Move 3 functions closer to their callers
      intel_idle: Clean up irtl_2_usec()

Randy Dunlap (1):
      PM / devfreq: Fix multiple kernel-doc warnings

Viresh Kumar (2):
      opp: Free static OPPs on errors while adding them
      opp: Replace list_kref with a local counter

Wen Yang (1):
      PM: hibernate: improve arithmetic division in
preallocate_highmem_fraction()

Yangtao Li (10):
      cpuidle: clps711x: convert to devm_platform_ioremap_resource()
      cpuidle: kirkwood: convert to devm_platform_ioremap_resource()
      PM / devfreq: rockchip-dfi: Add missing of_node_put()
      PM / devfreq: rk3399_dmc: Add missing of_node_put()
      PM / devfreq: rockchip-dfi: Convert to devm_platform_ioremap_resource
      PM / devfreq: rk3399_dmc: Disable devfreq-event device when fails
      PM / devfreq: exynos-bus: Disable devfreq-event device when fails
      PM / devfreq: exynos-bus: Add error log when fail to get devfreq-event
      cpufreq: kirkwood: convert to devm_platform_ioremap_resource
      cpufreq: tegra186: convert to devm_platform_ioremap_resource

YueHaibing (2):
      PM / devfreq: imx8m-ddrc: Fix inconsistent IS_ERR and PTR_ERR
      power: avs: qcom-cpr: remove duplicated include from qcom-cpr.c

Zhang Rui (3):
      powercap/intel_rapl: add support for TigerLake Mobile
      x86/cpu: Add Jasper Lake to Intel family
      powercap/intel_rapl: add support for JasperLake

chenqiwu (2):
      cpufreq: s3c: fix unbalances of cpufreq policy refcount
      cpufreq: brcmstb-avs: fix imbalance of cpufreq policy refcount

zhuguangqing (1):
      PM: wakeup: Show statistics for deleted wakeup sources again

---------------

 .mailmap                                           |    1 +
 Documentation/ABI/testing/sysfs-class-devfreq      |   18 +-
 Documentation/ABI/testing/sysfs-devices-system-cpu |    6 +
 Documentation/ABI/testing/sysfs-power              |   13 +
 Documentation/admin-guide/pm/cpuidle.rst           |    3 +
 Documentation/admin-guide/pm/intel_idle.rst        |  246 +++
 Documentation/admin-guide/pm/working-state.rst     |    1 +
 .../memory-controllers/fsl/imx8m-ddrc.yaml         |   72 +
 .../devicetree/bindings/power/avs/qcom,cpr.txt     |  130 ++
 MAINTAINERS                                        |    8 +
 arch/x86/include/asm/intel-family.h                |    1 +
 drivers/acpi/Kconfig                               |    1 +
 drivers/acpi/acpi_processor.c                      |  182 ++
 drivers/acpi/processor_idle.c                      |  174 +-
 drivers/base/power/runtime.c                       |   13 +-
 drivers/base/power/wakeup.c                        |    3 +
 drivers/cpufreq/brcmstb-avs-cpufreq.c              |    2 +
 drivers/cpufreq/cppc_cpufreq.c                     |    8 +-
 drivers/cpufreq/cpufreq-dt-platdev.c               |    1 +
 drivers/cpufreq/imx-cpufreq-dt.c                   |    6 +-
 drivers/cpufreq/intel_pstate.c                     |    2 +-
 drivers/cpufreq/kirkwood-cpufreq.c                 |    4 +-
 drivers/cpufreq/loongson2_cpufreq.c                |    8 +-
 drivers/cpufreq/s3c2416-cpufreq.c                  |   12 +-
 drivers/cpufreq/s5pv210-cpufreq.c                  |   11 +-
 drivers/cpufreq/tegra186-cpufreq.c                 |    4 +-
 drivers/cpuidle/Kconfig.arm                        |   12 +-
 drivers/cpuidle/coupled.c                          |    9 +-
 drivers/cpuidle/cpuidle-clps711x.c                 |    5 +-
 drivers/cpuidle/cpuidle-kirkwood.c                 |    5 +-
 drivers/cpuidle/cpuidle.c                          |    9 +-
 drivers/cpuidle/driver.c                           |   46 -
 drivers/cpuidle/sysfs.c                            |   16 +-
 drivers/devfreq/Kconfig                            |   21 +-
 drivers/devfreq/Makefile                           |    1 +
 drivers/devfreq/devfreq-event.c                    |    4 +-
 drivers/devfreq/devfreq.c                          |  166 +-
 drivers/devfreq/event/Kconfig                      |    6 +-
 drivers/devfreq/event/exynos-nocp.c                |    2 +-
 drivers/devfreq/event/exynos-nocp.h                |    2 +-
 drivers/devfreq/event/exynos-ppmu.c                |   15 +-
 drivers/devfreq/event/exynos-ppmu.h                |    2 +-
 drivers/devfreq/event/rockchip-dfi.c               |    5 +-
 drivers/devfreq/exynos-bus.c                       |  155 +-
 drivers/devfreq/imx8m-ddrc.c                       |  471 +++++
 drivers/devfreq/rk3399_dmc.c                       |   19 +-
 drivers/idle/intel_idle.c                          |  482 ++++--
 drivers/opp/core.c                                 |   48 +-
 drivers/opp/of.c                                   |   31 +-
 drivers/opp/opp.h                                  |    6 +-
 drivers/power/avs/Kconfig                          |   16 +
 drivers/power/avs/Makefile                         |    1 +
 drivers/power/avs/qcom-cpr.c                       | 1793 ++++++++++++++++++++
 drivers/powercap/intel_rapl_common.c               |    2 +
 include/linux/acpi.h                               |   15 +
 include/linux/cpuidle.h                            |    6 +-
 include/linux/devfreq.h                            |   29 +-
 include/linux/suspend.h                            |    2 +
 include/trace/events/rpm.h                         |    6 +
 kernel/power/Kconfig                               |    5 +-
 kernel/power/hibernate.c                           |   23 +-
 kernel/power/main.c                                |   33 +
 kernel/power/snapshot.c                            |   28 +-
 kernel/power/suspend.c                             |    2 +-
 kernel/power/suspend_test.c                        |    6 +-
 65 files changed, 3829 insertions(+), 606 deletions(-)
