Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8EA28D321
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Oct 2020 19:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgJMRcB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 13 Oct 2020 13:32:01 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40077 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgJMRcB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Oct 2020 13:32:01 -0400
Received: by mail-oi1-f195.google.com with SMTP id m128so207275oig.7;
        Tue, 13 Oct 2020 10:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=mMlTpSCjcw28hMtYVpmIpgjAwdHBL/T+5PVO7Rv0uco=;
        b=ToaDJ/rYPYNlHEfpaPXBms4Ruxa4/YIUm/ZdXa3+Q4FYZAQErHuo/TyI1rLwkEsruc
         ss5S//r3oOIkYYj0DjZH4loWcWBPozRVItw+1mlCdiOESd2xYXaum2RbNXN8NFOwkyYO
         HLle5ej8A1M3Hf59jveQibJ7FlXZTpxNyULqI9CSm9czbLNDPowmnAjL4VrmcMdRI61o
         W3Nc9dK2VU02js0HIjWUZ5mPJiS73tnBzPi44JWdTQaODlOy+8604AftU9MBDV9MUvxq
         6Q8RNRwDGraRxEJkuw68QAUDg1Z1yMqBSdv9MDoTDT+DP+Z7PnqSsBSCZi077Gq6+ykK
         5pBA==
X-Gm-Message-State: AOAM532W4cxyYznJmQTHRZFQJZCCMEtuuOEy371pfEe3N7nboTzvNjrG
        sM9SgrLAJOnFdvCvJEH8sH5B9eY/FNxxc62oT1A=
X-Google-Smtp-Source: ABdhPJwiJluPPiCi3hCcuyUdukUk9r1ZzLErDoEmdt/iIPunndpEChtWq0SJ3+nornnDhco89LgOC+GO/JMZEa+V4nc=
X-Received: by 2002:aca:5256:: with SMTP id g83mr510094oib.71.1602610319729;
 Tue, 13 Oct 2020 10:31:59 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 13 Oct 2020 19:31:48 +0200
Message-ID: <CAJZ5v0jMkgxQ=Aa0z4YnhXudgemzET0jBgPu13+Q3RtEspaNgQ@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v5.10-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.10-rc1

with top-most commit 16641d81f9ff5f902d084754c84b2bde3a60bc6e

 Merge branches 'pm-avs' and 'powercap'

on top of commit 549738f15da0e5a00275977623be199fbbf7df50

 Linux 5.9-rc8

to receive power management updates for 5.10-rc1.

These rework the collection of cpufreq statistics to allow it to take
place if fast frequency switching is enabled in the governor, rework
the frequency invariance handling in the cpufreq core and drivers,
add new hardware support to a couple of cpufreq drivers, fix a number
of assorted issues and clean up the code all over.

Specifics:

 - Rework cpufreq statistics collection to allow it to take place
   when fast frequency switching is enabled in the governor (Viresh
   Kumar).

 - Make the cpufreq core set the frequency scale on behalf of the
   driver and update several cpufreq drivers accordingly (Ionela
   Voinescu, Valentin Schneider).

 - Add new hardware support to the STI and qcom cpufreq drivers and
   improve them (Alain Volmat, Manivannan Sadhasivam).

 - Fix multiple assorted issues in cpufreq drivers (Jon Hunter,
   Krzysztof Kozlowski, Matthias Kaehlcke, Pali Rohár, Stephan
   Gerhold, Viresh Kumar).

 - Fix several assorted issues in the operating performance points
   (OPP) framework (Stephan Gerhold, Viresh Kumar).

 - Allow devfreq drivers to fetch devfreq instances by DT enumeration
   instead of using explicit phandles and modify the devfreq core
   code to support driver-specific devfreq DT bindings (Leonard
   Crestez, Chanwoo Choi).

 - Improve initial hardware resetting in the tegra30 devfreq driver
   and clean up the tegra cpuidle driver (Dmitry Osipenko).

 - Update the cpuidle core to collect state entry rejection
   statistics and expose them via sysfs (Lina Iyer).

 - Improve the ACPI _CST code handling diagnostics (Chen Yu).

 - Update the PSCI cpuidle driver to allow the PM domain
   initialization to occur in the OSI mode as well as in the PC
   mode (Ulf Hansson).

 - Rework the generic power domains (genpd) core code to allow
   domain power off transition to be aborted in the absence of the
   "power off" domain callback (Ulf Hansson).

 - Fix two suspend-to-idle issues in the ACPI EC driver (Rafael
   Wysocki).

 - Fix the handling of timer_expires in the PM-runtime framework on
   32-bit systems and the handling of device links in it (Grygorii
   Strashko, Xiang Chen).

 - Add IO requests batching support to the hibernate image saving and
   reading code and drop a bogus get_gendisk() from there (Xiaoyi
   Chen, Christoph Hellwig).

 - Allow PCIe ports to be put into the D3cold power state if they
   are power-manageable via ACPI (Lukas Wunner).

 - Add missing header file include to a power capping driver (Pujin
   Shi).

 - Clean up the qcom-cpr AVS driver a bit (Liu Shixin).

 - Kevin Hilman steps down as designated reviewer of adaptive voltage
   scaling (AVS) drivers (Kevin Hilman).

Note that because of the Kevin Hilman's resignation (so long, and
thanks for all the fish Kevin!), the maintenance of AVS drivers is
expected to be transferred to arm-soc.

Thanks!


---------------

Alain Volmat (3):
      cpufreq: sti-cpufreq: add stih418 support
      cpufreq: dt-platdev: Blacklist st,stih418 SoC
      cpufreq: arm: Kconfig: add CPUFREQ_DT depend for STI CPUFREQ

Chanwoo Choi (2):
      PM / devfreq: Change prototype of devfreq_get_devfreq_by_phandle function
      PM / devfreq: event: Change prototype of
devfreq_event_get_edev_by_phandle function

Chen Yu (1):
      ACPI: processor: Print more information when
acpi_processor_evaluate_cst() fails

Christoph Hellwig (1):
      PM: hibernate: remove the bogus call to get_gendisk() in software_resume()

Dmitry Osipenko (2):
      cpuidle: tegra: Correctly handle result of arm_cpuidle_simple_enter()
      PM / devfreq: tegra30: Improve initial hardware resetting

Grygorii Strashko (1):
      PM: runtime: Fix timer_expires data type on 32-bit arches

Ionela Voinescu (5):
      arch_topology: validate input frequencies to arch_set_freq_scale()
      cpufreq: move invariance setter calls in cpufreq core
      cpufreq: report whether cpufreq supports Frequency Invariance (FI)
      cpufreq,arm,arm64: restructure definitions of arch_set_freq_scale()
      arm: disable frequency invariance for CONFIG_BL_SWITCHER

Jon Hunter (1):
      cpufreq: tegra186: Fix initial frequency

Kevin Hilman (1):
      MAINTAINERS: drop myself from PM AVS drivers

Krzysztof Kozlowski (2):
      cpufreq: s5pv210: Simplify with dev_err_probe()
      cpufreq: s5pv210: Use dev_err instead of pr_err in probe

Leonard Crestez (1):
      PM / devfreq: Add devfreq_get_devfreq_by_node function

Lina Iyer (1):
      cpuidle: record state entry rejection statistics

Liu Shixin (1):
      PM: AVS: qcom-cpr: simplify the return expression of cpr_disable()

Lukas Wunner (1):
      PCI/ACPI: Whitelist hotplug ports for D3 if power managed by ACPI

Manivannan Sadhasivam (5):
      cpufreq: qcom-hw: Make use of cpufreq driver_data for passing pdev
      dt-bindings: cpufreq: cpufreq-qcom-hw: Document Qcom EPSS compatible
      cpufreq: qcom-hw: Use devm_platform_ioremap_resource() to simplify code
      cpufreq: qcom-hw: Use of_device_get_match_data for offsets and row size
      cpufreq: qcom-hw: Add cpufreq support for SM8250 SoC

Matthias Kaehlcke (1):
      cpufreq: qcom: Don't add frequencies without an OPP

Pali Rohár (1):
      cpufreq: armada-37xx: Add missing MODULE_DEVICE_TABLE

Pujin Shi (1):
      powercap: include header to fix -Wmissing-prototypes

Rafael J. Wysocki (4):
      ACPI: EC: PM: Flush EC work unconditionally after wakeup
      ACPI: EC: PM: Drop ec_no_wakeup check from acpi_ec_dispatch_gpe()
      cpufreq: schedutil: Simplify sugov_fast_switch()
      cpufreq: stats: Add memory barrier to store_reset()

Stephan Gerhold (4):
      opp: Allow dev_pm_opp_get_opp_table() to return -EPROBE_DEFER
      cpufreq: dt: Refactor initialization to handle probe deferral properly
      opp: Reduce code duplication in _set_required_opps()
      opp: Set required OPPs in reverse order when scaling down

Ulf Hansson (4):
      firmware: psci: Extend psci_set_osi_mode() to allow reset to PC mode
      cpuidle: psci: Allow PM domain to be initialized even if no OSI mode
      PM: domains: Rename power state enums for genpd
      PM: domains: Allow to abort power off when no ->power_off() callback

Valentin Schneider (2):
      arch_topology, cpufreq: constify arch_* cpumasks
      arch_topology, arm, arm64: define arch_scale_freq_invariant()

Viresh Kumar (18):
      opp: Rename regulator_enabled and use it as status of all resources
      opp: Reuse the enabled flag in !target_freq path
      opp: Split out _opp_set_rate_zero()
      opp: Remove _dev_pm_opp_find_and_remove_table() wrapper
      cpufreq: imx6q: Unconditionally call dev_pm_opp_of_remove_table()
      opp: Handle multiple calls for same OPP table in _of_add_opp_table_v1()
      opp: Drop unnecessary check from dev_pm_opp_attach_genpd()
      dt-bindings: opp: Allow opp-supported-hw to contain multiple versions
      opp: Allow opp-supported-hw to contain multiple versions
      ARM: tegra: Pass multiple versions in opp-supported-hw property
      opp: Prevent memory leak in dev_pm_opp_attach_genpd()
      opp: Allow opp-level to be set to 0
      cpufreq: stats: Defer stats update to cpufreq_stats_record_transition()
      cpufreq: stats: Remove locking
      cpufreq: stats: Mark few conditionals with unlikely()
      cpufreq: stats: Enable stats for fast-switch as well
      cpufreq: Move traces and update to policy->cur to cpufreq core
      cpufreq: stats: Fix string format specifier mismatch

Xiang Chen (1):
      PM: runtime: Remove link state checks in rpm_get/put_supplier()

Xiaoyi Chen (1):
      PM: hibernate: Batch hibernate and resume IO requests

---------------

 Documentation/admin-guide/pm/cpuidle.rst           |   9 +
 .../bindings/cpufreq/cpufreq-qcom-hw.txt           |   2 +-
 Documentation/devicetree/bindings/opp/opp.txt      |  53 +-
 MAINTAINERS                                        |   1 -
 arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi   |  36 -
 arch/arm/boot/dts/tegra20-cpu-opp.dtsi             |  67 +-
 arch/arm/boot/dts/tegra30-cpu-opp-microvolt.dtsi   | 512 -----------
 arch/arm/boot/dts/tegra30-cpu-opp.dtsi             | 984 +++------------------
 arch/arm/include/asm/topology.h                    |   5 +
 arch/arm64/include/asm/topology.h                  |   2 +
 arch/arm64/kernel/topology.c                       |   9 +-
 drivers/acpi/acpi_processor.c                      |  34 +-
 drivers/acpi/ec.c                                  |  10 +-
 drivers/base/arch_topology.c                       |  15 +-
 drivers/base/power/domain.c                        |  71 +-
 drivers/base/power/runtime.c                       |   5 +-
 drivers/cpufreq/Kconfig.arm                        |   2 +-
 drivers/cpufreq/armada-37xx-cpufreq.c              |   6 +
 drivers/cpufreq/cpufreq-dt-platdev.c               |   1 +
 drivers/cpufreq/cpufreq-dt.c                       | 296 +++----
 drivers/cpufreq/cpufreq.c                          |  45 +-
 drivers/cpufreq/cpufreq_stats.c                    | 105 ++-
 drivers/cpufreq/imx6q-cpufreq.c                    |  10 +-
 drivers/cpufreq/qcom-cpufreq-hw.c                  | 144 +--
 drivers/cpufreq/s5pv210-cpufreq.c                  |  31 +-
 drivers/cpufreq/scmi-cpufreq.c                     |  12 +-
 drivers/cpufreq/scpi-cpufreq.c                     |   6 +-
 drivers/cpufreq/sti-cpufreq.c                      |   6 +-
 drivers/cpufreq/tegra186-cpufreq.c                 |  30 +
 drivers/cpufreq/vexpress-spc-cpufreq.c             |  12 +-
 drivers/cpuidle/cpuidle-psci-domain.c              |  59 +-
 drivers/cpuidle/cpuidle-tegra.c                    |  34 +-
 drivers/cpuidle/cpuidle.c                          |   1 +
 drivers/cpuidle/sysfs.c                            |   3 +
 drivers/devfreq/devfreq-event.c                    |  14 +-
 drivers/devfreq/devfreq.c                          |  57 +-
 drivers/devfreq/exynos-bus.c                       |   7 +-
 drivers/devfreq/rk3399_dmc.c                       |   2 +-
 drivers/devfreq/tegra30-devfreq.c                  |   8 +-
 drivers/firmware/psci/psci.c                       |  12 +-
 drivers/memory/samsung/exynos5422-dmc.c            |   6 +-
 drivers/opp/core.c                                 | 231 ++---
 drivers/opp/cpu.c                                  |   2 +-
 drivers/opp/of.c                                   | 112 ++-
 drivers/opp/opp.h                                  |   5 +-
 drivers/pci/pci-acpi.c                             |  10 +
 drivers/power/avs/qcom-cpr.c                       |   8 +-
 drivers/powercap/idle_inject.c                     |   1 +
 drivers/soc/samsung/exynos-asv.c                   |   2 +-
 include/linux/arch_topology.h                      |   6 +-
 include/linux/cpufreq.h                            |  15 +-
 include/linux/cpuidle.h                            |   1 +
 include/linux/devfreq-event.h                      |  14 +-
 include/linux/devfreq.h                            |  11 +-
 include/linux/pm.h                                 |   2 +-
 include/linux/pm_domain.h                          |   4 +-
 include/linux/psci.h                               |   2 +-
 kernel/power/hibernate.c                           |  11 -
 kernel/power/swap.c                                |  15 +
 kernel/sched/cpufreq_schedutil.c                   |  18 +-
 60 files changed, 1075 insertions(+), 2119 deletions(-)
