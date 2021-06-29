Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0883B781D
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jun 2021 20:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbhF2TBL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Jun 2021 15:01:11 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:38865 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbhF2TBK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Jun 2021 15:01:10 -0400
Received: by mail-ot1-f52.google.com with SMTP id a5-20020a05683012c5b029046700014863so6933889otq.5;
        Tue, 29 Jun 2021 11:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0CoFhyprg0SMvOyQS94tuYmUx7xloDVzGT6KX0wc08w=;
        b=byEHm/U6ypI7SPTj6INCiyWw5iddS8j4ihe5qa5UhXYGWhiqypPV+Oe46Q7B8M3D7w
         /3hZxvTfZyeFDJs+dg6dtQa8fya61PpMGtE1T6dkVGTeHAaqgt2vBhuUJCFAN+E5FTUC
         QlpjBdCUQXpmlW84l4sWhain1GVd+eF2FPB2tQa/GeYBuipsvGZEUm89AePNDlpYjykj
         kFTWUtskKMDmTkk0AnMefgRJKD3HPQTZD2TT7qLyDL5z1a1TpBE742x285oRv91EOn44
         iz5klP24eLiINyab4urFERusCgVp/tZWXimt6ZPN/B2FwF/wvJ8wP4EC2q3kYoHGlPg9
         M3DA==
X-Gm-Message-State: AOAM532uaO+aKg9mZd8xrNNqLYS2KKUkChULwf3yJc6zmtg9vl3hijmP
        K533XetfYNZRZp3tHBhFR0W6uzevkOMC1fsS+Ash9H6AJ0Q=
X-Google-Smtp-Source: ABdhPJxkb1twkcvyJ3PCBO5pKtjfkffDGUbto1NL5Fae9XwuLs03F8xkc3984XiTVrQ58KLUhdkqoQvITanx9836Das=
X-Received: by 2002:a05:6830:1bf7:: with SMTP id k23mr6081928otb.206.1624993121973;
 Tue, 29 Jun 2021 11:58:41 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 29 Jun 2021 20:58:30 +0200
Message-ID: <CAJZ5v0i+RhTN4LYqG0X5oUg8e2gs1AbwHP__PSvCRoFT48P7Ug@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v5.14-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.14-rc1

with top-most commit 22b65d31ad9d10cdd726239966b6d6f67db8f251

 Merge branches 'pm-domains' and 'pm-devfreq'

on top of commit 4d6035f9bf4ea12776322746a216e856dfe46698

 Revert "PCI: PM: Do not read power state in pci_enable_device_flags()"

to receive power management updates for 5.14-rc1.

These add hybrid processors support to the intel_pstate driver
and make it work with more processor models when HWP is disabled,
make the intel_idle driver use special C6 idle state paremeters
when package C-states are disabled, add cooling support to the
tegra30 devfreq driver, rework the TEO (timer events oriented)
cpuidle governor, extend the OPP (operating performance points)
framework to use the required-opps DT property in more cases, fix
some issues and clean up a number of assorted pieces of code.

Specifics:

 - Make intel_pstate support hybrid processors using abstract
   performance units in the HWP interface (Rafael Wysocki).

 - Add Icelake servers and Cometlake support in no-HWP mode to
   intel_pstate (Giovanni Gherdovich).

 - Make cpufreq_online() error path be consistent with the CPU
   device removal path in cpufreq (Rafael Wysocki).

 - Clean up 3 cpufreq drivers and the statistics code (Hailong Liu,
   Randy Dunlap, Shaokun Zhang).

 - Make intel_idle use special idle state parameters for C6 when
   package C-states are disabled (Chen Yu).

 - Rework the TEO (timer events oriented) cpuidle governor to address
   some theoretical shortcomings in it (Rafael Wysocki).

 - Drop unneeded semicolon from the TEO governor (Wan Jiabing).

 - Modify the runtime PM framework to accept unassigned suspend
   and resume callback pointers (Ulf Hansson).

 - Improve pm_runtime_get_sync() documentation (Krzysztof Kozlowski).

 - Improve device performance states support in the generic power
   domains (genpd) framework (Ulf Hansson).

 - Fix some documentation issues in genpd (Yang Yingliang).

 - Make the operating performance points (OPP) framework use the
   required-opps DT property in use cases that are not related to
   genpd (Hsin-Yi Wang).

 - Make lazy_link_required_opp_table() use list_del_init instead of
   list_del/INIT_LIST_HEAD (Yang Yingliang).

 - Simplify wake IRQs handling in the core system-wide sleep support
   code and clean up some coding style inconsistencies in it (Tian
   Tao, Zhen Lei).

 - Add cooling support to the tegra30 devfreq driver and improve its
   DT bindings (Dmitry Osipenko).

 - Fix some assorted issues in the devfreq core and drivers (Chanwoo
   Choi, Dong Aisheng, YueHaibing).

Thanks!


---------------

Chanwoo Choi (1):
      PM / devfreq: passive: Fix get_target_freq when not using required-opp

Chen Yu (1):
      intel_idle: Adjust the SKX C6 parameters if PC6 is disabled

Dmitry Osipenko (3):
      PM / devfreq: tegra30: Support thermal cooling
      dt-bindings: devfreq: tegra30-actmon: Convert to schema
      dt-bindings: devfreq: tegra30-actmon: Add cooling-cells

Dong Aisheng (2):
      PM / devfreq: imx-bus: Remove imx_bus_get_dev_status
      PM / devfreq: imx8m-ddrc: Remove DEVFREQ_GOV_SIMPLE_ONDEMAND dependency

Giovanni Gherdovich (2):
      cpufreq: intel_pstate: Add Icelake servers support in no-HWP mode
      cpufreq: intel_pstate: Add Cometlake support in no-HWP mode

Hailong Liu (2):
      cpufreq: sh: Remove unused linux/sched.h headers
      cpufreq: loongson2: Remove unused linux/sched.h headers

Hsin-Yi Wang (1):
      opp: Allow required-opps to be used for non genpd use cases

Krzysztof Kozlowski (1):
      PM: runtime: document common mistake with pm_runtime_get_sync()

Rafael J. Wysocki (9):
      cpufreq: intel_pstate: hybrid: Avoid exposing two global attributes
      cpufreq: intel_pstate: hybrid: CPU-specific scaling factor
      cpufreq: intel_pstate: hybrid: Fix build with CONFIG_ACPI unset
      cpuidle: teo: Cosmetic modifications of teo_update()
      cpuidle: teo: Cosmetic modification of teo_select()
      cpuidle: teo: Change the main idle state selection logic
      cpuidle: teo: Rework most recent idle duration values treatment
      cpuidle: teo: Use kerneldoc documentation in admin-guide
      cpufreq: Make cpufreq_online() call driver->offline() on errors

Randy Dunlap (1):
      cpufreq: sc520_freq: add 'fallthrough' to one case

Shaokun Zhang (1):
      cpufreq: stats: Clean up local variable in cpufreq_stats_create_table()

Tian Tao (1):
      PM: wakeirq: Set IRQF_NO_AUTOEN when requesting the IRQ

Ulf Hansson (6):
      PM: domains: Split code in dev_pm_genpd_set_performance_state()
      PM: domains: Return early if perf state is already set for the device
      PM: domains: Drop/restore performance state votes for devices at
runtime PM
      PM: runtime: Improve path in rpm_idle() when no callback
      PM: runtime: Allow unassigned ->runtime_suspend|resume callbacks
      PM: runtime: Clarify documentation when callbacks are unassigned

Wan Jiabing (1):
      cpuidle: teo: remove unneeded semicolon in teo_select()

Yang Yingliang (2):
      opp: use list_del_init instead of list_del/INIT_LIST_HEAD
      PM: domains: fix some kernel-doc issues

YueHaibing (2):
      PM / devfreq: Add missing error code in devfreq_add_device()
      PM / devfreq: userspace: Use DEVICE_ATTR_RW macro

Zhen Lei (3):
      PM: hibernate: fix spelling mistakes
      PM: sleep: remove trailing spaces and tabs
      PM: hibernate: remove leading spaces before tabs

---------------

 Documentation/admin-guide/pm/cpuidle.rst           |  77 +---
 Documentation/admin-guide/pm/intel_pstate.rst      |   6 +
 .../bindings/arm/tegra/nvidia,tegra30-actmon.txt   |  57 ---
 .../bindings/devfreq/nvidia,tegra30-actmon.yaml    | 126 ++++++
 Documentation/power/runtime_pm.rst                 |  15 +-
 drivers/base/power/domain.c                        |  64 ++-
 drivers/base/power/domain_governor.c               |   1 +
 drivers/base/power/runtime.c                       |  18 +-
 drivers/base/power/wakeirq.c                       |   4 +-
 drivers/cpufreq/cpufreq.c                          |  11 +-
 drivers/cpufreq/cpufreq_stats.c                    |   5 +-
 drivers/cpufreq/intel_pstate.c                     | 263 ++++++++++--
 drivers/cpufreq/loongson2_cpufreq.c                |   1 -
 drivers/cpufreq/sc520_freq.c                       |   1 +
 drivers/cpufreq/sh-cpufreq.c                       |   1 -
 drivers/cpuidle/governors/teo.c                    | 476 +++++++++++----------
 drivers/devfreq/Kconfig                            |   1 -
 drivers/devfreq/devfreq.c                          |   1 +
 drivers/devfreq/governor_passive.c                 |   3 +-
 drivers/devfreq/governor_userspace.c               |  10 +-
 drivers/devfreq/imx-bus.c                          |  14 -
 drivers/devfreq/tegra30-devfreq.c                  |   1 +
 drivers/idle/intel_idle.c                          |  33 ++
 drivers/opp/core.c                                 |  10 +
 drivers/opp/of.c                                   |  27 +-
 include/linux/pm_domain.h                          |   1 +
 include/linux/pm_runtime.h                         |   3 +
 kernel/power/Kconfig                               |  12 +-
 kernel/power/process.c                             |   2 +-
 kernel/power/snapshot.c                            |  10 +-
 kernel/power/swap.c                                |   2 +-
 31 files changed, 775 insertions(+), 481 deletions(-)
