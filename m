Return-Path: <linux-acpi+bounces-6886-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2838F931B2B
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jul 2024 21:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66511B22508
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jul 2024 19:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7440E139584;
	Mon, 15 Jul 2024 19:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jW77Yp0S"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474191292CE;
	Mon, 15 Jul 2024 19:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721072585; cv=none; b=S1NLIyhe2SOa/WKWVG67+ZMnE/nKLDN5H6ZsBvXCFAoDCAeSEPWTkCG6IWBnP9WbgwUcc1UZjY66f2GfpXSws4uYtLh+KkO6/Fk8z8RK7buQTvwUFuTfuge96+XXnTScoPs9YZgUkDF5oIXhCakxlAnapKX7A3GYKmRCct641+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721072585; c=relaxed/simple;
	bh=myDbQmknU/mmYnlOayc48mTzzQ4kyqn8YK5ExNq9sg0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SihfxPO6MBWZoHD0MLs4/1rEUNHMLFKIYj4b7HAoONtDpLz1CeNfSWjMF3gikxoKC1t9Cvsry7+U31N062jzpgcWoba6P1xu1LwbMRBuI4X3KSW5AkJQOdvRcal1/u3qk4XQ9oUDmoOuVySman9DIh5IwamO97apuKzO9eyiSZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jW77Yp0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB89DC4AF0A;
	Mon, 15 Jul 2024 19:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721072585;
	bh=myDbQmknU/mmYnlOayc48mTzzQ4kyqn8YK5ExNq9sg0=;
	h=From:Date:Subject:To:Cc:From;
	b=jW77Yp0SUlT49FNpBRurL4dgIrCArq8Fx3AI0SZCzPWbZ5IPT7sEvm09KtF/j0MBy
	 uVnqfOXOzsvqJ+pAYwOl1dw97kL7IqZ8m+pWz98c+1t6zY/eVqrDB72FWzV/61pzoR
	 Uvvy3w827lS/NSEAUefr+M/V42zDHPBMQjCLa7mf05jr0jzCNbKdB6sX+3rbIWdDVT
	 lgqNkoi5lDtySwnsQOet+nNB19E9MwcYvjvvQCdHUbP4M5WnbwvZWYlpVlZ65kzwYZ
	 EK4KvvVGpd2ziT+aOb5HpxuBoC1U/ruuTipOF5wEVFdw9NdBaALYmlf54/QzNlLTfm
	 4mAJh5383AmPw==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7036c788e2aso317224a34.3;
        Mon, 15 Jul 2024 12:43:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXsv3NYBWgSOvIeMaa1e4lPjSKV5BNi3clDyq2h8w9DCxEBfZHxoOxB/oP224CdsNQ0T5dH2ZQmNDil0A73/fHbKy5RNWTSwpYvIyA0J6GLnewk30WrzPmyp7PkL1lCEh6/A5PRMWhtAg==
X-Gm-Message-State: AOJu0YxLnkj+7G+/VQn8M2ErlFe82BiJdhJiYiT/6OWL3Sng/Vk0JVqd
	GqfL0NHwa3NeUiq6FXTwK1G++hb3Z9lKwlpl7C6WE+vP5ryluoZ/c6s+IsfwwpN5dZKegfuh7u0
	a7JyPX2jumx1gtmsIvqHxW8NrS/w=
X-Google-Smtp-Source: AGHT+IF4pgiA5VkY862jTIF7htzUsfBcG7AUH1JeIW2AEaEKmr1a0Wh9mPd25Eet7CjLG0WvmhcBXmY9RGSh+MoTK0g=
X-Received: by 2002:a4a:d0a2:0:b0:5cd:13e0:b0d3 with SMTP id
 006d021491bc7-5d254ef812emr483721eaf.2.1721072583746; Mon, 15 Jul 2024
 12:43:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Jul 2024 21:42:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h7OHR7ipj6ubgTLEz238JZkTshh93CYe_gDx5j+zBwfA@mail.gmail.com>
Message-ID: <CAJZ5v0h7OHR7ipj6ubgTLEz238JZkTshh93CYe_gDx5j+zBwfA@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v6.11-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.11-rc1

with top-most commit a02bed4183c48d42a2855a4e70867b6239c45770

 Merge branches 'pm-opp' and 'pm-tools'

on top of commit 130abfe9a1841189975f3770e825e441acd3c87c

 Merge tag 'pm-6.10-rc8' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive power management updates for 6.11-rc1.

These add a new cpufreq driver for Loongson-3, add support for new
features in the intel_pstate (Lunar Lake and Arrow Lake platforms,
OOB mode for Emerald Rapids, highest performance change interrupt),
amd-pstate (fast CPPC) and sun50i (Allwinner H700 speed bin) cpufreq
drivers, simplify the cpufreq driver interface, simplify the teo cpuidle
governor, adjust the pm-graph utility for a new version of Python,
address issues and clean up code.

Specifics:

 - Add Loongson-3 CPUFreq driver support (Huacai Chen).

 - Add support for the Arrow Lake and Lunar Lake platforms and
   the out-of-band (OOB) mode on Emerald Rapids to the intel_pstate
   cpufreq driver, make it support the highest performance change
   interrupt and clean it up (Srinivas Pandruvada).

 - Switch cpufreq to new Intel CPU model defines (Tony Luck).

 - Simplify the cpufreq driver interface by switching the .exit() driver
   callback to the void return data type (Lizhe, Viresh Kumar).

 - Make cpufreq_boost_enabled() return bool (Dhruva Gole).

 - Add fast CPPC support to the amd-pstate cpufreq driver, address
   multiple assorted issues in it and clean it up (Perry Yuan, Mario
   Limonciello, Dhananjay Ugwekar, Meng Li, Xiaojian Du).

 - Add Allwinner H700 speed bin to the sun50i cpufreq driver (Ryan
   Walklin).

 - Fix memory leaks and of_node_put() usage in the sun50i and qcom-nvmem
   cpufreq drivers (Javier Carrasco).

 - Clean up the sti and dt-platdev cpufreq drivers (Jeff Johnson,
   Raphael Gallais-Pou).

 - Fix deferred probe handling in the TI cpufreq driver and wrong return
   values of ti_opp_supply_probe(), and add OPP tables for the AM62Ax and
   AM62Px SoCs to it (Bryan Brattlof, Primoz Fiser).

 - Avoid overflow of target_freq in .fast_switch() in the SCMI cpufreq
   driver (Jagadeesh Kona).

 - Use dev_err_probe() in every error path in probe in the Mediatek
   cpufreq driver (N=C3=ADcolas Prado).

 - Fix kernel-doc param for longhaul_setstate in the longhaul cpufreq
   driver (Yang Li).

 - Fix system resume handling in the CPPC cpufreq driver (Riwen Lu).

 - Improve the teo cpuidle governor and clean up leftover comments from
   the menu cpuidle governor (Christian Loehle).

 - Clean up a comment typo in the teo cpuidle governor (Atul Kumar
   Pant).

 - Add missing MODULE_DESCRIPTION() macro to cpuidle haltpoll (Jeff
   Johnson).

 - Switch the intel_idle driver to new Intel CPU model defines (Tony
   Luck).

 - Switch the Intel RAPL driver new Intel CPU model defines (Tony Luck).

 - Simplify if condition in the idle_inject driver (Thorsten Blum).

 - Fix missing cleanup on error in _opp_attach_genpd() (Viresh Kumar).

 - Introduce an OF helper function to inform if required-opps is used
   and drop a redundant in-parameter to _set_opp_level() (Ulf Hansson).

 - Update pm-graph to v5.12 which includes fixes and major code revamp
   for python3.12 (Todd Brandt).

 - Address several assorted issues in the cpupower utility (Roman
   Storozhenko).

Thanks!


---------------

Atul Kumar Pant (1):
      cpuidle: governors: teo: Fix a typo in a comment

Bryan Brattlof (2):
      cpufreq: ti: update OPP table for AM62Ax SoCs
      cpufreq: ti: update OPP table for AM62Px SoCs

Christian Loehle (4):
      cpuidle: menu: Cleanup after loadavg removal
      Revert: "cpuidle: teo: Introduce util-awareness"
      cpuidle: teo: Remove recent intercepts metric
      cpuidle: teo: Don't count non-existent intercepts

Dhananjay Ugwekar (2):
      cpufreq/amd-pstate-ut: Convert nominal_freq to khz during comparisons
      cpufreq/amd-pstate: Fix the scaling_max_freq setting on shared
memory CPPC systems

Dhruva Gole (1):
      cpufreq: make cpufreq_boost_enabled() return bool

Huacai Chen (1):
      cpufreq: Add Loongson-3 CPUFreq driver support

Jagadeesh Kona (1):
      cpufreq: scmi: Avoid overflow of target_freq in fast switch

Javier Carrasco (4):
      cpufreq: sun50i: fix memory leak in dt_has_supported_hw()
      cpufreq: sun50i: replace of_node_put() with automatic cleanup handler
      cpufreq: qcom-nvmem: fix memory leaks in probe error paths
      cpufreq: qcom-nvmem: eliminate uses of of_node_put()

Jeff Johnson (2):
      cpufreq: dt-platdev: add missing MODULE_DESCRIPTION() macro
      cpuidle: haltpoll: add missing MODULE_DESCRIPTION() macro

Lizhe (1):
      cpufreq: Make cpufreq_driver->exit() return void

Mario Limonciello (3):
      cpufreq: amd-pstate: Allow users to write 'default' EPP string
      cpufreq: amd-pstate: Make amd-pstate unit tests depend on amd-pstate
      cpufreq: amd-pstate: Don't create attributes when registration fails

Meng Li (1):
      cpufreq/amd-pstate: fix setting policy current frequency value

N=C3=ADcolas F. R. A. Prado (1):
      cpufreq: mediatek: Use dev_err_probe in every error path in probe

Perry Yuan (15):
      x86/cpufeatures: Add AMD FAST CPPC feature flag
      cpufreq: update to sysfs_emit() for safer buffer handling
      cpufreq: amd-pstate: optimize the initial frequency values verificati=
on
      cpufreq: amd-pstate: remove unused variable nominal_freq
      cpufreq: amd-pstate: show CPPC debug message if CPPC is not supported
      cpufreq: amd-pstate: add debug message while CPPC is supported
and disabled by SBIOS
      Documentation: PM: amd-pstate: add guided mode to the Operation mode
      cpufreq: amd-pstate: switch boot_cpu_has() to cpu_feature_enabled()
      cpufreq: amd-pstate: enable shared memory type CPPC by default
      cpufreq: amd-pstate: auto-load pstate driver by default
      cpufreq: simplify boolean parsing with kstrtobool in store function
      cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
      cpufreq: amd-pstate: initialize core precision boost state
      cpufreq: amd-pstate: Cap the CPPC.max_perf to nominal_perf if CPB is =
off
      Documentation: cpufreq: amd-pstate: update doc for Per CPU boost
control method

Primoz Fiser (2):
      cpufreq: ti-cpufreq: Handle deferred probe with dev_err_probe()
      OPP: ti: Fix ti_opp_supply_probe wrong return values

Raphael Gallais-Pou (3):
      cpufreq: sti: add missing MODULE_DEVICE_TABLE entry for stih418
      cpufreq: docs: Add missing scaling_available_frequencies description
      cpufreq: sti: fix build warning

Riwen Lu (1):
      cpufreq/cppc: Don't compare desired_perf in target()

Roman Storozhenko (7):
      cpupower: Replace a dead reference link with working ones
      cpupower: Add 'help' target to the main Makefile
      cpupower: Improve cpupower build process description
      cpupower: Remove absent 'v' parameter from monitor man page
      cpupower: Change the var type of the 'monitor' subcommand display mod=
e
      cpupower: Disable direct build of the 'bench' subproject
      cpupower: fix lib default installation path

Ryan Walklin (1):
      cpufreq: sun50i: add Allwinner H700 speed bin

Srinivas Pandruvada (8):
      cpufreq: intel_pstate: Update Meteor Lake EPPs
      cpufreq: intel_pstate: Use Meteor Lake EPPs for Arrow Lake
      cpufreq: intel_pstate: Support Emerald Rapids OOB mode
      cpufreq: intel_pstate: Update Arrow Lake hybrid scaling factor
      cpufreq: intel_pstate: Update Lunar Lake hybrid scaling factor
      cpufreq: intel_pstate: Replace boot_cpu_has()
      x86/cpufeatures: Add HWP highest perf change feature flag
      cpufreq: intel_pstate: Support highest performance change interrupt

Thorsten Blum (1):
      powercap: idle_inject: Simplify if condition

Todd Brandt (2):
      pm-graph: v5.12, fixes
      pm-graph: v5.12, code revamp for python3.12

Tony Luck (5):
      cpufreq: Switch to new Intel CPU model defines
      cpufreq: intel_pstate: Switch to new Intel CPU model defines
      intel_idle: Switch to new Intel CPU model defines
      powercap: intel_rapl_msr: Switch to new Intel CPU model defines
      powercap: intel_rapl: Switch to new Intel CPU model defines

Ulf Hansson (2):
      OPP: Drop a redundant in-parameter to _set_opp_level()
      OPP: Introduce an OF helper function to inform if required-opps is us=
ed

Viresh Kumar (4):
      OPP: Fix missing cleanup on error in _opp_attach_genpd()
      cpufreq: nforce2: Remove empty exit() callback
      cpufreq: loongson2: Remove empty exit() callback
      cpufreq: pcc: Remove empty exit() callback

Xiaojian Du (1):
      cpufreq: amd-pstate: change cpu freq transition delay for some models

Yang Li (1):
      cpufreq: longhaul: Fix kernel-doc param for longhaul_setstate

---------------

 Documentation/admin-guide/pm/amd-pstate.rst        |   18 +-
 Documentation/admin-guide/pm/cpufreq.rst           |    4 +
 MAINTAINERS                                        |    1 +
 arch/x86/include/asm/cpufeatures.h                 |    2 +
 arch/x86/include/asm/msr-index.h                   |    2 +
 arch/x86/kernel/cpu/scattered.c                    |    1 +
 drivers/cpufreq/Kconfig                            |   12 +
 drivers/cpufreq/Kconfig.x86                        |    1 +
 drivers/cpufreq/Makefile                           |    1 +
 drivers/cpufreq/acpi-cpufreq.c                     |    6 +-
 drivers/cpufreq/amd-pstate-ut.c                    |   12 +-
 drivers/cpufreq/amd-pstate.c                       |  357 +++++--
 drivers/cpufreq/amd-pstate.h                       |    2 +
 drivers/cpufreq/apple-soc-cpufreq.c                |    4 +-
 drivers/cpufreq/bmips-cpufreq.c                    |    4 +-
 drivers/cpufreq/cppc_cpufreq.c                     |   12 +-
 drivers/cpufreq/cpufreq-dt-platdev.c               |    1 +
 drivers/cpufreq/cpufreq-dt.c                       |    3 +-
 drivers/cpufreq/cpufreq-nforce2.c                  |    6 -
 drivers/cpufreq/cpufreq.c                          |   50 +-
 drivers/cpufreq/e_powersaver.c                     |    3 +-
 drivers/cpufreq/intel_pstate.c                     |  131 ++-
 drivers/cpufreq/longhaul.c                         |    5 +-
 drivers/cpufreq/loongson2_cpufreq.c                |    6 -
 drivers/cpufreq/loongson3_cpufreq.c                |  395 +++++++
 drivers/cpufreq/mediatek-cpufreq-hw.c              |    4 +-
 drivers/cpufreq/mediatek-cpufreq.c                 |   76 +-
 drivers/cpufreq/omap-cpufreq.c                     |    3 +-
 drivers/cpufreq/pasemi-cpufreq.c                   |    6 +-
 drivers/cpufreq/pcc-cpufreq.c                      |    6 -
 drivers/cpufreq/powernow-k6.c                      |    5 +-
 drivers/cpufreq/powernow-k7.c                      |    3 +-
 drivers/cpufreq/powernow-k8.c                      |    6 +-
 drivers/cpufreq/powernv-cpufreq.c                  |    4 +-
 drivers/cpufreq/ppc_cbe_cpufreq.c                  |    3 +-
 drivers/cpufreq/qcom-cpufreq-hw.c                  |    4 +-
 drivers/cpufreq/qcom-cpufreq-nvmem.c               |   12 +-
 drivers/cpufreq/qoriq-cpufreq.c                    |    4 +-
 drivers/cpufreq/scmi-cpufreq.c                     |    8 +-
 drivers/cpufreq/scpi-cpufreq.c                     |    4 +-
 drivers/cpufreq/sh-cpufreq.c                       |    4 +-
 drivers/cpufreq/sparc-us2e-cpufreq.c               |    3 +-
 drivers/cpufreq/sparc-us3-cpufreq.c                |    3 +-
 drivers/cpufreq/speedstep-centrino.c               |   18 +-
 drivers/cpufreq/sti-cpufreq.c                      |    3 +-
 drivers/cpufreq/sun50i-cpufreq-nvmem.c             |   30 +-
 drivers/cpufreq/tegra194-cpufreq.c                 |    4 +-
 drivers/cpufreq/ti-cpufreq.c                       |   96 +-
 drivers/cpufreq/vexpress-spc-cpufreq.c             |    5 +-
 drivers/cpuidle/cpuidle-haltpoll.c                 |    1 +
 drivers/cpuidle/governors/menu.c                   |   17 +-
 drivers/cpuidle/governors/teo.c                    |  194 +---
 drivers/idle/intel_idle.c                          |  116 +--
 drivers/opp/core.c                                 |   15 +-
 drivers/opp/of.c                                   |   32 +
 drivers/opp/ti-opp-supply.c                        |    6 +-
 drivers/powercap/idle_inject.c                     |    2 +-
 drivers/powercap/intel_rapl_common.c               |  120 +--
 drivers/powercap/intel_rapl_msr.c                  |   16 +-
 include/linux/cpufreq.h                            |    8 +-
 include/linux/pm_opp.h                             |    6 +
 tools/power/cpupower/Makefile                      |   47 +-
 tools/power/cpupower/README                        |  160 ++-
 tools/power/cpupower/bench/Makefile                |    5 +
 tools/power/cpupower/man/cpupower-monitor.1        |   13 +-
 .../cpupower/utils/idle_monitor/cpupower-monitor.c |    2 +-
 tools/power/pm-graph/bootgraph.py                  |   16 +-
 tools/power/pm-graph/sleepgraph.py                 | 1098 ++++++++++------=
----
 68 files changed, 1958 insertions(+), 1269 deletions(-)

