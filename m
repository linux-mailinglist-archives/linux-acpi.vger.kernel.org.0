Return-Path: <linux-acpi+bounces-8273-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6977897701D
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Sep 2024 20:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D70DEB2464D
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Sep 2024 18:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A331BFDF7;
	Thu, 12 Sep 2024 18:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iY0xqR4i"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1D81BFDEE;
	Thu, 12 Sep 2024 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726164494; cv=none; b=NL/IpbHCJLMFpexz/IVCY07my8R4ofdsDDTjkaW5jjr/nyglUC0oSMBJ2qt7TibnvI+CCekul/bQQ5Mo/BJkaTc4sAIN6boOS28yFSmsTuJNLf7Uu4anFkRaP4TIj29so9CPdUsjlQMMmFneAgbtPolQuSAZM9z5Xkow2rUolIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726164494; c=relaxed/simple;
	bh=gid7krXVX27L/aty4EOvU/vETo0leDus9x8d5iMnm/A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=t1/qRm/V0QxFbc5KHCnpKZLJ1yr/J8zWe8I1N3z4D7R65qmrSObS+XL/H6DvxIkN8mYJF0NXBlwhV4gswZO7RyCDxPnnEzo+fOUFuV/L1cOsZf/TkFJ9jGH70IUI/KX9/AvFTM72lpiVXIX5CVYGsxcwgkJlhllQ+uR10y6dMoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iY0xqR4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7D6C4CEC3;
	Thu, 12 Sep 2024 18:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726164493;
	bh=gid7krXVX27L/aty4EOvU/vETo0leDus9x8d5iMnm/A=;
	h=From:Date:Subject:To:Cc:From;
	b=iY0xqR4i/mhniBaANyLCdPYD/s7GWioPFfvSTPerE4ki8rg/vd3v/PFrljvLUAGov
	 dN6s5MwYMg7qY3N+GxMi2AnyEciAlrWOOqEC1I+h5PTbkn18pjxaTDRGmzOeP7wkQd
	 XuGRPW5UeRUSlAq/E6Ep92/1X76crN67P/typcTP+f92zq7EdGV4No9YzXavbC2jMk
	 dc85uDI5kNrXOIEr2UE0RZCM84UEl6lminc2+QsyJYlFXuj/JksbvKkcWifuuDkuXV
	 vhzlmyrW+s/e30NuEXMAFkYiPpp/SJ1SlNpqSHvmQXk/VfOHs3iiggS/64kZOn5gWc
	 3PFqhUBr/wkgA==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-27051f63018so11836fac.3;
        Thu, 12 Sep 2024 11:08:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIkXPdFPhX+fl7kv/jUEu0Ty2gzlOpZsCpuCjpPDv0ThRf2MtbxGYsCxXCcwryD+o68dM14gqe9IzK@vger.kernel.org, AJvYcCXL2Fyt3OEwRS4Xq0r/VO0YdwvZPYw4QtiD+E03zqaWmI8yXe3X39I7rRO6DAuzIDsPZS/81l5BT4Pe9Fly@vger.kernel.org
X-Gm-Message-State: AOJu0YzDCGCgy9zr9KtiR4abb6VxIr35LlQeYdnuMw7QW+eV1nNYHj7D
	antu/8uFXxKgPZZpzA4NOILTJiziHznetooLcf/ZOAjRM/b74SREmXKGGnLO9cCT7R2NK2Dfo4l
	fpzt0wwPqLNikS3R3e3Rp2m5wUT8=
X-Google-Smtp-Source: AGHT+IF5Z3l1d+LF8NMD7cdRe4IA2OKBePqJDtHWuhcIrP5Mr2RDddevMXZFTHyZoyDOun7Y0QO/8+sOJy9EJ8CwEng=
X-Received: by 2002:a05:6870:44c6:b0:25e:1cdf:c604 with SMTP id
 586e51a60fabf-27c68be3ed5mr204430fac.31.1726164492852; Thu, 12 Sep 2024
 11:08:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 12 Sep 2024 20:08:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gJXBx0jM4n8eO3-_bh1xcCaZVCHRA2K+Y468dFSJf4yg@mail.gmail.com>
Message-ID: <CAJZ5v0gJXBx0jM4n8eO3-_bh1xcCaZVCHRA2K+Y468dFSJf4yg@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v6.12-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

The next week will be all conference travel for me and I'll be traveling in
the week after it too, so here's an early request to pull power management
updates for 6.12-rc1.

To receive them, please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.12-rc1

with top-most commit 0a06811d664b8695a7612d3e59c1defb4382f4e0

 Merge branches 'pm-sleep', 'pm-opp' and 'pm-tools'

on top of commit da3ea35007d0af457a0afc87e84fddaebc4e0b63

 Linux 6.11-rc7

By the number of new lines of code, the most visible change here is the
addition of hybrid CPU capacity scaling support to the intel_pstate
driver.  Next are the amd-pstate driver changes related to the
calculation of the AMD boost numerator and preferred core detection.

As far as new hardware support is concerned, the intel_idle driver will
now handle Granite Rapids Xeon processors natively, the intel_rapl power
capping driver will recognize family 1Ah of AMD processors and Intel
ArrowLake-U chipos, and intel_pstate will handle Granite Rapids and
Sierra Forest chips in the out-of-band (OOB) mode.

Apart from the above, there is a usual collection of assorted fixes
and code cleanups in many places and there are tooling updates.

Specifics:

 - Remove LATENCY_MULTIPLIER from cpufreq (Qais Yousef).

 - Add support for Granite Rapids and Sierra Forest in OOB mode to the
   intel_pstate cpufreq driver (Srinivas Pandruvada).

 - Add basic support for CPU capacity scaling on x86 and make the
   intel_pstate driver set asymmetric CPU capacity on hybrid systems
   without SMT (Rafael Wysocki).

 - Add missing MODULE_DESCRIPTION() macros to the powerpc cpufreq
   driver (Jeff Johnson).

 - Several OF related cleanups in cpufreq drivers (Rob Herring).

 - Enable COMPILE_TEST for ARM drivers (Rob Herring).

 - Introduce quirks for syscon failures and use socinfo to get revision
   for TI cpufreq driver (Dhruva Gole, Nishanth Menon).

 - Minor cleanups in amd-pstate driver (Anastasia Belova, Dhananjay
   Ugwekar).

 - Minor cleanups for loongson, cpufreq-dt and powernv cpufreq drivers
   (Danila Tikhonov, Huacai Chen, and Liu Jing).

 - Make amd-pstate validate return of any attempt to update EPP limits,
   which fixes the masking hardware problems (Mario Limonciello).

 - Move the calculation of the AMD boost numerator outside of amd-pstate,
   correcting acpi-cpufreq on systems with preferred cores (Mario
   Limonciello).

 - Harden preferred core detection in amd-pstate to avoid potential
   false positives (Mario Limonciello).

 - Add extra unit test coverage for mode state machine (Mario
   Limonciello).

 - Fix an "Uninitialized variables" issue in amd-pstate (Qianqiang Liu).

 - Add Granite Rapids Xeon support to intel_idle (Artem Bityutskiy).

 - Disable promotion to C1E on Jasper Lake and Elkhart Lake in
   intel_idle (Kai-Heng Feng).

 - Use scoped device node handling to fix missing of_node_put() and
   simplify walking OF children in the riscv-sbi cpuidle driver (Krzysztof
   Kozlowski).

 - Remove dead code from cpuidle_enter_state() (Dhruva Gole).

 - Change an error pointer to NULL to fix error handling in the
   intel_rapl power capping driver (Dan Carpenter).

 - Fix off by one in get_rpi() in the intel_rapl power capping
   driver (Dan Carpenter).

 - Add support for ArrowLake-U to the intel_rapl power capping
   driver (Sumeet Pawnikar).

 - Fix the energy-pkg event for AMD CPUs in the intel_rapl power capping
   driver (Dhananjay Ugwekar).

 - Add support for AMD family 1Ah processors to the intel_rapl power
   capping driver (Dhananjay Ugwekar).

 - Remove unused stub for saveable_highmem_page() and remove deprecated
   macros from power management documentation (Andy Shevchenko).

 - Use ysfs_emit() and sysfs_emit_at() in "show" functions in the PM
   sysfs interface (Xueqin Luo).

 - Update the maintainers information for the operating-points-v2-ti-cpu DT
   binding (Dhruva Gole).

 - Drop unnecessary of_match_ptr() from ti-opp-supply (Rob Herring).

 - Add missing MODULE_DESCRIPTION() macros to devfreq governors (Jeff
   Johnson).

 - Use devm_clk_get_enabled() in the exynos-bus devfreq driver (Anand
   Moon).

 - Use of_property_present() instead of of_get_property() in the imx-bus
   devfreq driver (Rob Herring).

 - Update directory handling and installation process in the pm-graph
   Makefile and add .gitignore to ignore sleepgraph.py artifacts to
   pm-graph (Amit Vadhavana, Yo-Jung Lin).

 - Make cpupower display residency value in idle-info (Aboorva
   Devarajan).

 - Add missing powercap_set_enabled() stub function to cpupower (John
   B. Wyatt IV).

 - Add SWIG support to cpupower (John B. Wyatt IV).

Thanks!


---------------

Aboorva Devarajan (1):
      tools/cpupower: display residency value in idle-info

Amit Vadhavana (1):
      pm-graph: Update directory handling and installation process in Makefile

Anand Moon (1):
      PM / devfreq: exynos: Use Use devm_clk_get_enabled() helpers

Anastasia Belova (1):
      cpufreq: amd-pstate: add check for cpufreq_cpu_get's return value

Andy Shevchenko (2):
      Documentation: PM: Discourage use of deprecated macros
      PM: hibernate: Remove unused stub for saveable_highmem_page()

Artem Bityutskiy (1):
      intel_idle: add Granite Rapids Xeon support

Dan Carpenter (2):
      powercap: intel_rapl: Fix off by one in get_rpi()
      powercap: intel_rapl: Change an error pointer to NULL

Danila Tikhonov (1):
      cpufreq: Add SM7325 to cpufreq-dt-platdev blocklist

Dhananjay Ugwekar (3):
      powercap/intel_rapl: Add support for AMD family 1Ah
      powercap/intel_rapl: Fix the energy-pkg event for AMD CPUs
      cpufreq/amd-pstate: Add the missing cpufreq_cpu_put()

Dhruva Gole (3):
      cpuidle: remove dead code from cpuidle_enter_state()
      dt-bindings: opp: operating-points-v2-ti-cpu: Update maintainers
      cpufreq: ti-cpufreq: Use socinfo to get revision in AM62 family

Huacai Chen (1):
      cpufreq: loongson3: Use raw_smp_processor_id() in do_service_request()

Jeff Johnson (2):
      cpufreq: powerpc: add missing MODULE_DESCRIPTION() macros
      PM/devfreq: governor: add missing MODULE_DESCRIPTION() macros

John B. Wyatt IV (5):
      pm:cpupower: Add missing powercap_set_enabled() stub function
      pm:cpupower: Add SWIG bindings files for libcpupower
      pm:cpupower: Include test_raw_pylibcpupower.py
      MAINTAINERS: Add Maintainers for SWIG Python bindings
      pm:cpupower: Add error warning when SWIG is not installed

Kai-Heng Feng (1):
      intel_idle: Disable promotion to C1E on Jasper Lake and Elkhart Lake

Krzysztof Kozlowski (2):
      cpuidle: riscv-sbi: Use scoped device node handling to fix
missing of_node_put
      cpuidle: riscv-sbi: Simplify with scoped for each OF child loop

Liu Jing (1):
      cpufreq: Fix the cacography in powernv-cpufreq.c

Mario Limonciello (14):
      cpufreq/amd-pstate: Catch failures for amd_pstate_epp_update_limit()
      x86/amd: Move amd_get_highest_perf() from amd.c to cppc.c
      ACPI: CPPC: Adjust return code for inline functions in
!CONFIG_ACPI_CPPC_LIB
      x86/amd: Rename amd_get_highest_perf() to amd_get_boost_ratio_numerator()
      ACPI: CPPC: Drop check for non zero perf ratio
      ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to warn
      x86/amd: Move amd_get_highest_perf() out of amd-pstate
      x86/amd: Detect preferred cores in amd_get_boost_ratio_numerator()
      cpufreq: amd-pstate: Merge amd_pstate_highest_perf_set() into
amd_get_boost_ratio_numerator()
      cpufreq: amd-pstate: Optimize amd_pstate_update_limits()
      cpufreq: amd-pstate: Add documentation for `amd_pstate_hw_prefcore`
      amd-pstate: Add missing documentation for `amd_pstate_prefcore_ranking`
      cpufreq/amd-pstate: Export symbols for changing modes
      cpufreq/amd-pstate-ut: Add test case for mode switches

Nishanth Menon (1):
      cpufreq: ti-cpufreq: Introduce quirks to handle syscon fails appropriately

Qais Yousef (1):
      cpufreq: Remove LATENCY_MULTIPLIER

Qianqiang Liu (1):
      cpufreq/amd-pstate-ut: Fix an "Uninitialized variables" issue

Rafael J. Wysocki (2):
      x86/sched: Add basic support for CPU capacity scaling
      cpufreq: intel_pstate: Set asymmetric CPU capacity on hybrid systems

Rob Herring (Arm) (10):
      cpufreq: Use of_property_present()
      cpufreq: spear: Use of_property_for_each_u32() instead of open coding
      cpufreq: qcom: Add explicit io.h include for readl/writel_relaxed
      cpufreq: omap: Drop asm includes
      cpufreq: armada-8k: Avoid excessive stack usage
      opp: ti: Drop unnecessary of_match_ptr()
      cpufreq: Enable COMPILE_TEST on Arm drivers
      cpufreq: Drop CONFIG_ARM and CONFIG_ARM64 dependency on Arm drivers
      cpufreq: Fix warning on unused of_device_id tables for !CONFIG_OF
      PM / devfreq: imx-bus: Use of_property_present()

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Support Granite Rapids and Sierra Forest OOB mode

Sumeet Pawnikar (1):
      powercap: intel_rapl: Add support for ArrowLake-U platform

Xueqin Luo (2):
      PM: hibernate: Use sysfs_emit() and sysfs_emit_at() in "show" functions
      PM: sleep: Use sysfs_emit() and sysfs_emit_at() in "show" functions

Yo-Jung (Leo) Lin (1):
      pm-graph: Make git ignore sleepgraph.py artifacts

---------------

 Documentation/admin-guide/pm/amd-pstate.rst        |  15 +-
 .../bindings/opp/operating-points-v2-ti-cpu.yaml   |   2 +-
 Documentation/power/pci.rst                        |  11 +-
 Documentation/power/runtime_pm.rst                 |   4 +-
 MAINTAINERS                                        |   3 +
 arch/x86/include/asm/processor.h                   |   3 -
 arch/x86/include/asm/topology.h                    |  13 ++
 arch/x86/kernel/acpi/cppc.c                        | 172 +++++++++++++-
 arch/x86/kernel/cpu/amd.c                          |  16 --
 arch/x86/kernel/cpu/aperfmperf.c                   |  89 +++++++-
 drivers/cpufreq/Kconfig                            |   2 -
 drivers/cpufreq/Kconfig.arm                        |  50 +++--
 drivers/cpufreq/acpi-cpufreq.c                     |  12 +-
 drivers/cpufreq/amd-pstate-ut.c                    |  41 +++-
 drivers/cpufreq/amd-pstate.c                       | 181 ++++++---------
 drivers/cpufreq/amd-pstate.h                       |  14 ++
 drivers/cpufreq/apple-soc-cpufreq.c                |   2 +-
 drivers/cpufreq/armada-8k-cpufreq.c                |   2 +-
 drivers/cpufreq/cpufreq-dt-platdev.c               |   1 +
 drivers/cpufreq/cpufreq-dt.c                       |  11 +-
 drivers/cpufreq/cpufreq.c                          |  27 +--
 drivers/cpufreq/intel_pstate.c                     | 240 +++++++++++++++++++-
 drivers/cpufreq/loongson3_cpufreq.c                |   2 +-
 drivers/cpufreq/maple-cpufreq.c                    |   1 +
 drivers/cpufreq/mediatek-cpufreq.c                 |   2 +-
 drivers/cpufreq/omap-cpufreq.c                     |   3 -
 drivers/cpufreq/pasemi-cpufreq.c                   |   1 +
 drivers/cpufreq/pmac64-cpufreq.c                   |   3 +-
 drivers/cpufreq/powernv-cpufreq.c                  |   3 +-
 drivers/cpufreq/ppc_cbe_cpufreq.c                  |   1 +
 drivers/cpufreq/qcom-cpufreq-hw.c                  |   1 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c               |   2 +-
 drivers/cpufreq/spear-cpufreq.c                    |  18 +-
 drivers/cpufreq/sti-cpufreq.c                      |   2 +-
 drivers/cpufreq/sun50i-cpufreq-nvmem.c             |   2 +-
 drivers/cpufreq/ti-cpufreq.c                       |  31 ++-
 drivers/cpuidle/cpuidle-riscv-sbi.c                |  28 +--
 drivers/cpuidle/cpuidle.c                          |   5 +-
 drivers/devfreq/exynos-bus.c                       |  22 +-
 drivers/devfreq/governor_performance.c             |   1 +
 drivers/devfreq/governor_powersave.c               |   1 +
 drivers/devfreq/governor_simpleondemand.c          |   1 +
 drivers/devfreq/governor_userspace.c               |   1 +
 drivers/devfreq/imx-bus.c                          |   2 +-
 drivers/idle/intel_idle.c                          |  60 ++++-
 drivers/opp/ti-opp-supply.c                        |   2 +-
 drivers/powercap/intel_rapl_common.c               |  38 +++-
 include/acpi/cppc_acpi.h                           |  41 ++--
 include/linux/cpufreq.h                            |   6 -
 kernel/power/hibernate.c                           |  26 ++-
 kernel/power/main.c                                |  76 ++++---
 kernel/power/snapshot.c                            |   5 -
 tools/power/cpupower/bindings/python/.gitignore    |   8 +
 tools/power/cpupower/bindings/python/Makefile      |  33 +++
 tools/power/cpupower/bindings/python/README        |  59 +++++
 .../cpupower/bindings/python/raw_pylibcpupower.i   | 247 +++++++++++++++++++++
 .../bindings/python/test_raw_pylibcpupower.py      |  42 ++++
 tools/power/cpupower/lib/cpuidle.c                 |   8 +
 tools/power/cpupower/lib/cpuidle.h                 |   2 +
 tools/power/cpupower/lib/powercap.c                |   8 +
 tools/power/cpupower/utils/cpuidle-info.c          |   4 +
 tools/power/pm-graph/.gitignore                    |   3 +
 tools/power/pm-graph/Makefile                      | 111 +++++----
 63 files changed, 1416 insertions(+), 407 deletions(-)

