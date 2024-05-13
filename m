Return-Path: <linux-acpi+bounces-5794-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B9E8C477E
	for <lists+linux-acpi@lfdr.de>; Mon, 13 May 2024 21:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E366286993
	for <lists+linux-acpi@lfdr.de>; Mon, 13 May 2024 19:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A239554BE7;
	Mon, 13 May 2024 19:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4DOgpBy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F212D058;
	Mon, 13 May 2024 19:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715628534; cv=none; b=JBIx+JzJa5lfgORwdyDMA0kZ08bskoSZ8uMtI8LePQnilnkFHfDaP0O5OcL3kxZaOrjgqcD+qcgQ+QC4Nu/KsVrHzGQzJnJ33OGvVBy2ohxUAg+rCtsE6ftxcSmLa+YuOt1Db+HXphMrpSljsMHNkysWPdl3UlZUqJJnqoG9Ofc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715628534; c=relaxed/simple;
	bh=BJB+OEtAm/BTUbJ1V1X5RuWEchXVMXe4ENVOmrRtpBI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=PDCbZ9rWo6hfV4w6swWdWjIJmlDBBA9Qm3R6ngLqmIrvHX/1qQqYkG1mX9vm5h5Aho0izbM96mc7TQ8zdO+upgyRFeMmFYIlh3M2OfPH53h0bxsuooZPc7QxBgunVFHusqjJw/GCMhnTVSgLgpvx5YHcQK8F4G1cUZHRR+t1YAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4DOgpBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F1BC2BD11;
	Mon, 13 May 2024 19:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715628534;
	bh=BJB+OEtAm/BTUbJ1V1X5RuWEchXVMXe4ENVOmrRtpBI=;
	h=From:Date:Subject:To:Cc:From;
	b=q4DOgpByyxPUkjg1RdBLgtmsdKl5QVbGcti5wOuQzxPC78RqdKXZjs3FYSIhgolQp
	 1WUXL3kzQGyi8Z/XCR4vWAPhrO2gcJxRv9cks8tlqDjer1S9I/ZuGH03/LuYfe8LEI
	 hAVz5G9f6ZEjefyEzv4gTA1i5Phqo4gkZagXgy+cMCvzqIiF9BA3eubMKm9NzochSc
	 qtjLj0t2iGhcm/qEZP5465aoxC+KbA7F0+8/vsuSHjWS9J1FdjnBaf6eW0GxWZH+17
	 hZSMwdxOzTl9UXVCMbo3Qh/YaLn0LtIFfz+x1PVrKfwAWZqIz9VU0SQyRw+ROjP7Jd
	 Wi+i/NGGpp7iw==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5b2b7af31d7so57213eaf.3;
        Mon, 13 May 2024 12:28:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUhKDcpEm2RZiHwzxYeRwB+igCVmWu1eOL/p2ZnATLPu3GkkAPe5AoMptQkSNN+T5WL8+BtOWQ6ScqnOexVCSzRsyYdpTZlwochEt6FwlbaMqTZ/1EjjrrvmpCZmyHBx4gT3oF9ntXyEg==
X-Gm-Message-State: AOJu0YyKzIrcaOc4HfIU7jLQRo2TKkEpOQqSP2EzGOfyakQN/SHXDVaO
	QF4T+cUNsS1dOQvc88gT5qrrUQhg6O+yhAz+CFFHtuAyh8boHOWgmkdlaJXVGeS3xg3urD8tmWR
	2FzKRS81pXW3rPZBV1dXCRBcbDdU=
X-Google-Smtp-Source: AGHT+IF+XjprH6DnNec88uq3BucfPMXtCA6tSbM5DoaGv5kPcLabPRVbFgf26kxZnLQUNyVC4Gf77IdpguqbVejc7r8=
X-Received: by 2002:a4a:d692:0:b0:5b2:f29:93f0 with SMTP id
 006d021491bc7-5b2815e3c4dmr12334252eaf.0.1715628533014; Mon, 13 May 2024
 12:28:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 13 May 2024 21:28:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hDjPb8n5wQODb==QMvp7ipEVpRoSqJ6pTii=_6XvRwEw@mail.gmail.com>
Message-ID: <CAJZ5v0hDjPb8n5wQODb==QMvp7ipEVpRoSqJ6pTii=_6XvRwEw@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v6.10-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.10-rc1

with top-most commit de1c2722e07819c7ea65bb4bf37a2cfe2556095b

 Merge branches 'pm-em' and 'pm-docs'

on top of commit dd5a440a31fae6e459c0d6271dddd62825505361

 Linux 6.9-rc7

to receive power management updates for 6.10-rc1.

These are mostly cpufreq updates, including a significant intel-pstate
driver update and several amd-pstate improvements plus some updates of
ARM cpufreq drivers, general fixes and cleanups.

Also included are changes related to system sleep, power capping updates
adding support for a new platform and a new hardware feature (among other
things), a Samsung exynos-asv driver update allowing it to change its
Energy Model after adjusting voltage, minor cpuidle and devfreq updates
and a small documentation cleanup.

Specifics:

 - Rework the handling of disabled turbo in the intel_pstate driver and
   make it update the maximum CPU frequency consistently regardless of
   the reason on top of a number of cleanups (Rafael Wysocki).

 - Add missing checks for NULL .exit() cpufreq driver callback to the
   cpufreq core (Viresh Kumar).

 - Prevent pulicy->max from going above the frequency QoS maximum value
   when cpufreq_frequency_table_verify() is used (Xuewen Yan).

 - Prevent a negative CPU number or frequency value from being printed
   if they are really large (Joshua Yeong).

 - Update MAINTAINERS entry for amd-pstate to add two new submaintainers
   and a designated reviewer (Huang Rui).

 - Clean up the amd-pstate driver and update its documentation (Gautham
   Shenoy).

 - Fix the highest frequency issue in the amd-pstate driver which limits
   performance (Perry Yuan).

 - Enable CPPC v2 for certain processors in the family 17H, as requested
   by TR40 processor users who expect improved performance and lower
   system temperature (Perry Yuan).

 - Change latency and delay values to be read from platform firmware
   firstly for more accurate timing (Perry Yuan).

 - A new quirk is introduced for supporting amd-pstate on legacy
   processors which either lack CPPC capability, or only only have CPPC
   v2 capability (Perry Yuan).

 - Sun50i cpufreq: Add support for opp_supported_hw, H616 platform and
   general cleanups (Andre Przywara, Martin Botka, Brandon Cheo Fusi,
   Dan Carpenter, Viresh Kumar).

 - CPPC cpufreq: Fix possible null pointer dereference (Aleksandr
   Mishin).

 - Eliminate uses of of_node_put() from cpufreq (Javier Carrasco,
   Shivani Gupta).

 - brcmstb-avs: ISO C90 forbids mixed declarations (Portia Stephens).

 - mediatek cpufreq: Add support for MT7988A (Sam Shih).

 - cpufreq-qcom-hw: Add SM4450 compatibles in DT bindings (Tengfei Fan).

 - Fix struct cpudata::epp_cached kernel-doc in the intel_pstate cpufreq
   driver (Jeff Johnson).

 - Fix kerneldoc description of ladder_do_selection() (Jeff Johnson).

 - Convert the cpuidle kirkwood driver to platform remove callback
   returning void (Yangtao Li).

 - Replace deprecated strncpy() with strscpy() in the hibernation core
   code (Justin Stitt).

 - Use %ps to simplify debug output in the core system-wide suspend and
   resume code (Len Brown).

 - Remove unnecessary else from device_init_wakeup() and make
   device_wakeup_disable() return void (Dhruva Gole).

 - Enable PMU support in the Intel TPMI RAPL driver (Zhang Rui).

 - Add support for ArrowLake-H platform to the Intel RAPL driver (Zhang
   Rui).

 - Avoid explicit cpumask allocation on stack in DTPM (Dawei Li).

 - Make the Samsung exynos-asv driver update the Energy Model after
   adjusting voltage on top of some preliminary changes of the OPP and
   Enery Model generic code (Lukasz Luba).

 - Remove a reference to a function that has been dropped from the power
   management documentation (Bjorn Helgaas).

 - Convert the platfrom remove callback to .remove_new for the
   exyno-nocp, exynos-ppmu, mtk-cci-devfreq, sun8i-a33-mbus, and
   rk3399_dmc devfreq drivers (Uwe Kleine-K=C3=B6nig).

 - Use DEFINE_SIMPLE_PM_OPS for exyno-bus.c driver (Anand Moon).

Thanks!


---------------

Aleksandr Mishin (1):
      cppc_cpufreq: Fix possible null pointer dereference

Anand Moon (1):
      PM / devfreq: exynos: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions

Andre Przywara (2):
      cpufreq: sun50i: Add support for opp_supported_hw
      arm64: dts: allwinner: h616: enable DVFS for all boards

Arnd Bergmann (1):
      cpufreq: intel_pstate: hide unused intel_pstate_cpu_oob_ids[]

Bjorn Helgaas (1):
      Documentation: PM: Update platform_pci_wakeup_init() reference

Brandon Cheo Fusi (1):
      cpufreq: sun50i: Refactor speed bin decoding

Dan Carpenter (1):
      cpufreq: sun50i: fix error returns in dt_has_supported_hw()

Dawei Li (1):
      powercap: DTPM: Avoid explicit cpumask allocation on stack

Dhruva Gole (2):
      PM: wakeup: make device_wakeup_disable() return void
      PM: wakeup: Remove unnecessary else from device_init_wakeup()

Gautham R. Shenoy (3):
      cpufreq: amd-pstate: Document *_limit_* fields in struct amd_cpudata
      cpufreq: amd-pstate: Document the units for freq variables in amd_cpu=
data
      cpufreq: amd-pstate: Remove
amd_get_{min,max,nominal,lowest_nonlinear}_freq()

Huang Rui (1):
      MAINTAINERS: cpufreq: amd-pstate: Add co-maintainers and reviewer

Javier Carrasco (3):
      cpupfreq: tegra124: eliminate uses of of_node_put()
      cpufreq: dt: eliminate uses of of_node_put()
      cpufreq: dt-platdev: eliminate uses of of_node_put()

Jeff Johnson (2):
      cpuidle: ladder: fix ladder_do_selection() kernel-doc
      cpufreq: intel_pstate: fix struct cpudata::epp_cached kernel-doc

Joshua Yeong (1):
      cpufreq: Fix up printing large CPU numbers and frequency values

Justin Stitt (1):
      PM: hibernate: replace deprecated strncpy() with strscpy()

Len Brown (1):
      PM: sleep: Take advantage of %ps to simplify debug output

Lukasz Luba (4):
      OPP: OF: Export dev_opp_pm_calc_power() for usage from EM
      PM: EM: Refactor em_adjust_new_capacity()
      PM: EM: Add em_dev_update_chip_binning()
      soc: samsung: exynos-asv: Update Energy Model after adjusting voltage

Martin Botka (5):
      firmware: smccc: Export revision soc_id function
      cpufreq: dt-platdev: Blocklist Allwinner H616/618 SoCs
      dt-bindings: opp: Describe H616 OPPs and opp-supported-hw
      cpufreq: sun50i: Add H616 support
      arm64: dts: allwinner: h616: Add CPU OPPs table

Perry Yuan (8):
      cpufreq: amd-pstate: Unify computation of
{max,min,nominal,lowest_nonlinear}_freq
      cpufreq: amd-pstate: Bail out if min/max/nominal_freq is 0
      cpufreq: amd-pstate: get transition delay and latency value from
ACPI tables
      cppc_acpi: print error message if CPPC is unsupported
      cpufreq: amd-pstate: Add quirk for the pstate CPPC capabilities missi=
ng
      cpufreq: amd-pstate: fix code format problems
      cpufreq: amd-pstate: remove unused variable lowest_nonlinear_freq
      cpufreq: amd-pstate: fix the highest frequency issue which
limits performance

Portia Stephens (1):
      cpufreq: brcmstb-avs-cpufreq: ISO C90 forbids mixed declarations

Rafael J. Wysocki (11):
      cpufreq: intel_pstate: Drop redundant locking from
intel_pstate_driver_cleanup()
      cpufreq: intel_pstate: Simplify spinlock locking
      cpufreq: intel_pstate: Wait for canceled delayed work to complete
      cpufreq: intel_pstate: Get rid of unnecessary READ_ONCE() annotations
      cpufreq: intel_pstate: Use __ro_after_init for three variables
      cpufreq: intel_pstate: Fold intel_pstate_max_within_limits() into cal=
ler
      cpufreq: intel_pstate: Do not update global.turbo_disabled after
initialization
      cpufreq: intel_pstate: Rearrange show_no_turbo() and store_no_turbo()
      cpufreq: intel_pstate: Read global.no_turbo under READ_ONCE()
      cpufreq: intel_pstate: Replace three global.turbo_disabled checks
      cpufreq: intel_pstate: Update the maximum CPU frequency consistently

Sam Shih (1):
      cpufreq: mediatek: Add support for MT7988A

Shivani Gupta (1):
      cpufreq: ti: Implement scope-based cleanup in ti_cpufreq_match_node()

Tengfei Fan (1):
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add SM4450 compatibles

Uwe Kleine-K=C3=B6nig (5):
      PM / devfreq: exynos-nocp: Convert to platform remove callback
returning void
      PM / devfreq: exynos-ppmu: Convert to platform remove callback
returning void
      PM / devfreq: mtk-cci: Convert to platform remove callback returning =
void
      PM / devfreq: sun8i-a33-mbus: Convert to platform remove
callback returning void
      PM / devfreq: rk3399_dmc: Convert to platform remove callback
returning void

Viresh Kumar (2):
      cpufreq: exit() callback is optional
      cpufreq: sun50i: Fix build warning around snprint()

Xuewen Yan (1):
      cpufreq: Use a smaller freq for the policy->max when verify

Yangtao Li (1):
      cpuidle: kirkwood: Convert to platform remove callback returning void

Zhang Rui (4):
      powercap: intel_rapl: Add support for ArrowLake-H platform
      powercap: intel_rapl: Sort header files
      powercap: intel_rapl: Introduce APIs for PMU support
      powercap: intel_rapl_tpmi: Enable PMU support

---------------

 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          |   2 +
 .../opp/allwinner,sun50i-h6-operating-points.yaml  |  87 ++-
 Documentation/power/pci.rst                        |   2 +-
 MAINTAINERS                                        |   3 +
 .../dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi |   5 +
 .../boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi    | 115 ++++
 .../dts/allwinner/sun50i-h616-orangepi-zero2.dts   |   5 +
 .../boot/dts/allwinner/sun50i-h616-x96-mate.dts    |   5 +
 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi     |   8 +
 .../allwinner/sun50i-h618-longan-module-3h.dtsi    |   5 +
 .../dts/allwinner/sun50i-h618-orangepi-zero2w.dts  |   5 +
 .../dts/allwinner/sun50i-h618-orangepi-zero3.dts   |   5 +
 .../allwinner/sun50i-h618-transpeed-8k618-t.dts    |   5 +
 drivers/acpi/cppc_acpi.c                           |   4 +-
 drivers/base/power/main.c                          |   6 +-
 drivers/base/power/wakeup.c                        |  11 +-
 drivers/cpufreq/amd-pstate.c                       | 280 ++++++----
 drivers/cpufreq/brcmstb-avs-cpufreq.c              |   5 +-
 drivers/cpufreq/cppc_cpufreq.c                     |  14 +-
 drivers/cpufreq/cpufreq-dt-platdev.c               |  10 +-
 drivers/cpufreq/cpufreq-dt.c                       |  21 +-
 drivers/cpufreq/cpufreq.c                          |  11 +-
 drivers/cpufreq/freq_table.c                       |  12 +-
 drivers/cpufreq/intel_pstate.c                     | 173 +++---
 drivers/cpufreq/mediatek-cpufreq.c                 |  10 +
 drivers/cpufreq/sun50i-cpufreq-nvmem.c             | 209 +++++--
 drivers/cpufreq/tegra124-cpufreq.c                 |  19 +-
 drivers/cpufreq/ti-cpufreq.c                       |   4 +-
 drivers/cpuidle/cpuidle-kirkwood.c                 |   5 +-
 drivers/cpuidle/governors/ladder.c                 |   1 +
 drivers/devfreq/event/exynos-nocp.c                |   6 +-
 drivers/devfreq/event/exynos-ppmu.c                |   6 +-
 drivers/devfreq/exynos-bus.c                       |   9 +-
 drivers/devfreq/mtk-cci-devfreq.c                  |   6 +-
 drivers/devfreq/rk3399_dmc.c                       |   6 +-
 drivers/devfreq/sun8i-a33-mbus.c                   |   6 +-
 drivers/firmware/smccc/smccc.c                     |   1 +
 drivers/mmc/host/sdhci-pci-core.c                  |   2 +-
 drivers/opp/of.c                                   |  17 +-
 drivers/powercap/dtpm_cpu.c                        |   8 +-
 drivers/powercap/intel_rapl_common.c               | 607 +++++++++++++++++=
+++-
 drivers/powercap/intel_rapl_tpmi.c                 |   3 +
 drivers/soc/samsung/exynos-asv.c                   |  10 +-
 include/linux/amd-pstate.h                         |  20 +-
 include/linux/energy_model.h                       |   5 +
 include/linux/intel_rapl.h                         |  32 ++
 include/linux/pm_opp.h                             |   8 +
 include/linux/pm_wakeup.h                          |  12 +-
 kernel/power/energy_model.c                        | 106 +++-
 kernel/power/hibernate.c                           |   2 +-
 50 files changed, 1481 insertions(+), 438 deletions(-)

