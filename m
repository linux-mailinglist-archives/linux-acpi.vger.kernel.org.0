Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138091EA748
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jun 2020 17:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgFAPsl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Jun 2020 11:48:41 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:45246 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgFAPsk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Jun 2020 11:48:40 -0400
Received: by mail-ot1-f47.google.com with SMTP id m2so6408228otr.12;
        Mon, 01 Jun 2020 08:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=L8PsFQqnomG7bdjqwPjrkcnVbdsA106edRu4RBLE2vw=;
        b=HTF4icqYh71tmz2IhqMTAA4B3YHnJ4yxjOMM0ARtfGo66Qeo+SsbIRfSnlsFISG7ef
         lNlG1yoKdF1TxSeBYiYHsgnmwEdbG7lhQ3FI+RP1FRUeLk2lLQrUEY8q8lM7adjUMg6e
         p8C5TbL/VDWTDk97zu45G0zZqzMTyFzHA01TJoT8yKAYVf0967HvIYc1N6Izxj1qcmh+
         I1QIQ/kMZt8EiJVZWWwF3nRyEeo/zqtrtG6h/F68NJUMvkUkqHn+cazBnj0B/sLc9XLq
         j5lV2rpT7nQTbTMT5mO+87weSeyccu93yAIn2YiooquYkCiz48Tfmf920MI1W4MlK7RV
         79Cg==
X-Gm-Message-State: AOAM532dU3N7C+GBaOnIQn5ITdscG2fzkLc/v3nrmPTDGiEfMdyvtVp/
        6ehUVGMKsuenDcHyCx/YT4/QjVYaSP2pwVa7hlv1eLoG
X-Google-Smtp-Source: ABdhPJzakiNnTBW4UV4CYQbmEtQ3FuagYw2FxxX0gcmg4h99YWh4kawQDn28YOSdZyZ9DbPqIU9bXX/dYALeL1/SoNc=
X-Received: by 2002:a05:6830:20d1:: with SMTP id z17mr14918566otq.167.1591026518220;
 Mon, 01 Jun 2020 08:48:38 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 1 Jun 2020 17:48:27 +0200
Message-ID: <CAJZ5v0gV2T9BUBGT8TOt+kdO6+T_WwmcO1PPonWu76REGkoorQ@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v5.8-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.8-rc1

with top-most commit a34024d98eeaa78e2cd22017180df778800b83fc

 Merge branches 'pm-devfreq', 'powercap', 'pm-docs' and 'pm-tools'

on top of commit 9cb1fd0efd195590b828b9b865421ad345a4a145

 Linux 5.7-rc7

to receive power management updates for 5.8-rc1.

These rework the system-wide PM driver flags, make runtime switching
of cpuidle governors easier, improve the user space hibernation
interface code, add intel-speed-select interface documentation,
add more debug messages to the ACPI code handling suspend to idle,
update the cpufreq core and drivers, fix a minor issue in the
cpuidle core and update two cpuidle drivers, improve the PM-runtime
framework, update the Intel RAPL power capping driver, update devfreq
core and drivers, and clean up the cpupower utility.

Specifics:

 - Rework the system-wide PM driver flags to make them easier to
   understand and use and update their documentation (Rafael Wysocki,
   Alan Stern).

 - Allow cpuidle governors to be switched at run time regardless of
   the kernel configuration and update the related documentation
   accordingly (Hanjun Guo).

 - Improve the resume device handling in the user space hibernation
   interface code (Domenico Andreoli).

 - Document the intel-speed-select sysfs interface (Srinivas
   Pandruvada).

 - Make the ACPI code handing suspend to idle print more debug
   messages to help diagnose issues with it (Rafael Wysocki).

 - Fix a helper routine in the cpufreq core and correct a typo in
   the struct cpufreq_driver kerneldoc comment (Rafael Wysocki, Wang
   Wenhu).

 - Update cpufreq drivers:

   * Make the intel_pstate driver start in the passive mode by
     default on systems without HWP (Rafael Wysocki).

   * Add i.MX7ULP support to the imx-cpufreq-dt driver and add
     i.MX7ULP to the cpufreq-dt-platdev blacklist (Peng Fan).

   * Convert the qoriq cpufreq driver to a platform one, make the
     platform code create a suitable device object for it and add
     platform dependencies to it (Mian Yousaf Kaukab, Geert
     Uytterhoeven).

   * Fix wrong compatible binding in the qcom driver (Ansuel Smith).

   * Build the omap driver by default for ARCH_OMAP2PLUS (Anders
     Roxell).

   * Add r8a7742 SoC support to the dt cpufreq driver (Lad Prabhakar).

 - Update cpuidle core and drivers:

   * Fix three reference count leaks in error code paths in the
     cpuidle core (Qiushi Wu).

   * Convert Qualcomm SPM to a generic cpuidle driver (Stephan
     Gerhold).

   * Fix up the execution order when entering a domain idle state in
     the PSCI driver (Ulf Hansson).

 - Fix a reference counting issue related to clock management and
   clean up two oddities in the PM-runtime framework (Rafael Wysocki,
   Andy Shevchenko).

 - Add ElkhartLake support to the Intel RAPL power capping driver
   and remove an unused local MSR definition from it (Jacob Pan,
   Sumeet Pawnikar).

 - Update devfreq core and drivers:

   * Replace strncpy() with strscpy() in the devfreq core and use
     lockdep asserts instead of manual checks for a locked mutex in
     it (Dmitry Osipenko, Krzysztof Kozlowski).

   * Add a generic imx bus scaling driver and make it register an
     interconnect device (Leonard Crestez, Gustavo A. R. Silva).

   * Make the cpufreq notifier in the tegra30 driver take boosting
     into account and delete an unuseful error message from that
     driver (Dmitry Osipenko, Markus Elfring).

 - Remove unneeded semicolon from the cpupower code (Zou Wei).

There is a merge conflict between this update and the drm tree which
was addressed in linux-next by applying the appended diff.

Thanks!


---------------

Alan Stern (1):
      PM: sleep: Helpful edits for devices.rst documentation

Anders Roxell (1):
      cpufreq: omap: Build driver by default for ARCH_OMAP2PLUS

Andy Shevchenko (1):
      PM: runtime: Make clear what we do when conditions are wrong in
rpm_suspend()

Ansuel Smith (1):
      cpufreq: qcom: fix wrong compatible binding

Dmitry Osipenko (2):
      PM / devfreq: tegra30: Make CPUFreq notifier to take into account boosting
      PM / devfreq: Replace strncpy with strscpy

Domenico Andreoli (3):
      PM: hibernate: Incorporate concurrency handling
      PM: hibernate: Split off snapshot dev option
      PM: hibernate: Restrict writes to the resume device

Geert Uytterhoeven (1):
      cpufreq: qoriq: Add platform dependencies

Gustavo A. R. Silva (1):
      PM / devfreq: imx-bus: Fix inconsistent IS_ERR and PTR_ERR

Hanjun Guo (8):
      cpuidle: sysfs: Remove the unused define_one_r(o/w) macros
      cpuidle: sysfs: Minor coding style corrections
      cpuidle: sysfs: Fix the overlap for showing available governors
      cpuidle: sysfs: Accept governor name with 15 characters
      cpuidle: Make cpuidle governor switchable to be the default behaviour
      cpuidle: sysfs: Remove sysfs_switch and switch attributes
      Documentation: cpuidle: update the document
      Documentation: ABI: make current_governer_ro as a candidate for removal

Jacob Pan (1):
      powercap/intel_rapl: add support for ElkhartLake

Krzysztof Kozlowski (1):
      PM / devfreq: Use lockdep asserts instead of manual checks for
locked mutex

Lad Prabhakar (1):
      cpufreq: dt: Add support for r8a7742

Leonard Crestez (2):
      PM / devfreq: Add generic imx bus scaling driver
      PM / devfreq: imx: Register interconnect device

Markus Elfring (1):
      PM / devfreq: tegra30: Delete an error message in tegra_devfreq_probe()

Mian Yousaf Kaukab (2):
      cpufreq: qoriq: convert to a platform driver
      clk: qoriq: add cpufreq platform device

Peng Fan (2):
      cpufreq: Add i.MX7ULP to cpufreq-dt-platdev blacklist
      cpufreq: imx-cpufreq-dt: support i.MX7ULP

Qiushi Wu (1):
      cpuidle: Fix three reference count leaks

Rafael J. Wysocki (15):
      cpufreq: intel_pstate: Use passive mode by default without HWP
      PM: sleep: core: Simplify the SMART_SUSPEND flag handling
      PM: sleep: core: Fold functions into their callers
      PM: sleep: core: Do not skip callbacks in the resume phase
      PM: sleep: core: Rework the power.may_skip_resume handling
      PM: sleep: core: Rename dev_pm_may_skip_resume()
      PM: sleep: core: Rename dev_pm_smart_suspend_and_suspended()
      PM: sleep: core: Rename DPM_FLAG_NEVER_SKIP
      PM: sleep: core: Rename DPM_FLAG_LEAVE_SUSPENDED
      Documentation: PM: sleep: Update driver flags documentation
      cpufreq: Fix up cpufreq_boost_set_sw()
      ACPI: PM: s2idle: Print type of wakeup debug messages
      ACPI: EC: PM: s2idle: Extend GPE dispatching debug message
      PM: runtime: clk: Fix clk_pm_runtime_get() error path
      PM: runtime: Replace pm_runtime_callbacks_present()

Srinivas Pandruvada (1):
      Documentation: admin-guide: pm: Document intel-speed-select

Stephan Gerhold (1):
      cpuidle: Convert Qualcomm SPM driver to a generic CPUidle driver

Sumeet Pawnikar (1):
      powercap: RAPL: remove unused local MSR define

Ulf Hansson (1):
      cpuidle: psci: Fixup execution order when entering a domain idle state

Wang Wenhu (1):
      cpufreq: fix minor typo in struct cpufreq_driver doc comment

Zou Wei (1):
      cpupower: Remove unneeded semicolon

---------------

 Documentation/ABI/obsolete/sysfs-cpuidle           |   9 +
 Documentation/ABI/testing/sysfs-devices-system-cpu |  24 +-
 Documentation/admin-guide/pm/cpuidle.rst           |  20 +-
 .../admin-guide/pm/intel-speed-select.rst          | 917 +++++++++++++++++++++
 Documentation/admin-guide/pm/intel_pstate.rst      |  32 +-
 Documentation/admin-guide/pm/working-state.rst     |   1 +
 Documentation/driver-api/pm/cpuidle.rst            |   5 +-
 Documentation/driver-api/pm/devices.rst            | 199 +++--
 Documentation/power/pci.rst                        |  58 +-
 MAINTAINERS                                        |   1 +
 drivers/acpi/acpi_lpss.c                           |  14 +-
 drivers/acpi/acpi_tad.c                            |   2 +-
 drivers/acpi/device_pm.c                           |  31 +-
 drivers/acpi/ec.c                                  |   2 +-
 drivers/acpi/sleep.c                               |  20 +-
 drivers/base/power/main.c                          | 348 +++-----
 drivers/base/power/runtime.c                       |   6 +-
 drivers/base/power/sysfs.c                         |   4 +-
 drivers/clk/clk-qoriq.c                            |  30 +-
 drivers/clk/clk.c                                  |   6 +-
 drivers/cpufreq/Kconfig                            |   3 +-
 drivers/cpufreq/Kconfig.arm                        |   1 +
 drivers/cpufreq/cpufreq-dt-platdev.c               |   2 +
 drivers/cpufreq/cpufreq.c                          |  11 +-
 drivers/cpufreq/imx-cpufreq-dt.c                   |  84 +-
 drivers/cpufreq/intel_pstate.c                     |   3 +-
 drivers/cpufreq/qcom-cpufreq-nvmem.c               |   2 +-
 drivers/cpufreq/qoriq-cpufreq.c                    |  76 +-
 drivers/cpuidle/Kconfig.arm                        |  13 +
 drivers/cpuidle/Makefile                           |   1 +
 drivers/cpuidle/cpuidle-psci.c                     |   8 +-
 .../{soc/qcom/spm.c => cpuidle/cpuidle-qcom-spm.c} | 138 ++--
 drivers/cpuidle/sysfs.c                            |  73 +-
 drivers/devfreq/Kconfig                            |   8 +
 drivers/devfreq/Makefile                           |   1 +
 drivers/devfreq/devfreq.c                          |  19 +-
 drivers/devfreq/imx-bus.c                          | 179 ++++
 drivers/devfreq/tegra30-devfreq.c                  |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |   2 +-
 drivers/gpu/drm/i915/intel_runtime_pm.c            |   2 +-
 drivers/gpu/drm/radeon/radeon_kms.c                |   2 +-
 drivers/i2c/busses/i2c-designware-platdrv.c        |   4 +-
 drivers/misc/mei/pci-me.c                          |   2 +-
 drivers/misc/mei/pci-txe.c                         |   2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |   2 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   2 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |   2 +-
 drivers/pci/hotplug/pciehp_core.c                  |   2 +-
 drivers/pci/pci-driver.c                           |  34 +-
 drivers/pci/pcie/portdrv_pci.c                     |   2 +-
 drivers/powercap/intel_rapl_common.c               |   4 +-
 drivers/soc/qcom/Kconfig                           |  10 -
 drivers/soc/qcom/Makefile                          |   1 -
 fs/block_dev.c                                     |   3 +-
 include/linux/cpufreq.h                            |   2 +-
 include/linux/pm.h                                 |  34 +-
 include/linux/pm_runtime.h                         |   4 +-
 include/linux/suspend.h                            |   6 +
 kernel/power/Kconfig                               |  12 +
 kernel/power/Makefile                              |   3 +-
 kernel/power/hibernate.c                           |  20 +-
 kernel/power/power.h                               |   4 +-
 kernel/power/user.c                                |  22 +-
 tools/power/cpupower/utils/cpupower-info.c         |   2 +-
 tools/power/cpupower/utils/cpupower-set.c          |   2 +-
 .../cpupower/utils/idle_monitor/amd_fam14h_idle.c  |   2 +-
 .../cpupower/utils/idle_monitor/cpuidle_sysfs.c    |   6 +-
 .../cpupower/utils/idle_monitor/hsw_ext_idle.c     |   2 +-
 tools/power/cpupower/utils/idle_monitor/nhm_idle.c |   2 +-
 tools/power/cpupower/utils/idle_monitor/snb_idle.c |   2 +-
 70 files changed, 1831 insertions(+), 728 deletions(-)

---------------

diff --cc drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index c201bc827389,4e4c9550dcf8..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@@ -189,10 -188,12 +188,12 @@@ int amdgpu_driver_load_kms(struct drm_d
          dev_dbg(&dev->pdev->dev, "Error during ACPI methods call\n");

      if (adev->runpm) {
-         dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
+         /* only need to skip on ATPX */
+         if (amdgpu_device_supports_boco(dev) &&
+             !amdgpu_is_atpx_hybrid())
 -            dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NEVER_SKIP);
++            dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
          pm_runtime_use_autosuspend(dev->dev);
          pm_runtime_set_autosuspend_delay(dev->dev, 5000);
-         pm_runtime_set_active(dev->dev);
          pm_runtime_allow(dev->dev);
          pm_runtime_mark_last_busy(dev->dev);
          pm_runtime_put_autosuspend(dev->dev);
