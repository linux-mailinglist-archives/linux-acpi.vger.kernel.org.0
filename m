Return-Path: <linux-acpi+bounces-12418-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BC5A6DFC4
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Mar 2025 17:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E751D16B32B
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Mar 2025 16:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8449826389D;
	Mon, 24 Mar 2025 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nB6WY5zs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E0C25E82C;
	Mon, 24 Mar 2025 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833948; cv=none; b=PJeD+4BL+0/TvIgLCIKDncy75GwHtJZ5XKXKc79JqwpXy5Ys5po5M/gPE2evmvZoyS4kombk/FlNc2ZKwdUOvTQElV+7/U3iimzRMMjkWsp45geUhaouc5HLzNWoM1HwS83O4wqkoCzoNwlVAVQjTXqB5pDs6UYWThQg5JEDjjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833948; c=relaxed/simple;
	bh=IjN7Pt5g56mBZfgNTqbZcnQDBK3mkDLRR6UzHU4i9q8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jzUGNWi/oC9xcib4+Rtduq/lRvvPn3v3GGI3q+VQx+ykK3Up60tsAjj+cHOvin0zNoUV448U370nJT5GdKhFjKEW4vvVKLs045CT8Vz/Iuz4b6G5NviUv1RiO1oL5v4/0FVBbV81g9kMBr1aARs1N0MmlmP+YJxM0drKbvX/QHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nB6WY5zs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C2DC4CEED;
	Mon, 24 Mar 2025 16:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742833947;
	bh=IjN7Pt5g56mBZfgNTqbZcnQDBK3mkDLRR6UzHU4i9q8=;
	h=From:Date:Subject:To:Cc:From;
	b=nB6WY5zs9v07eElTYMnXXLbR0o36KJAw376TXziGNrlXBWPvEnStduTvHyr3T6iSa
	 ZbHG3V4+oOj7MvIFTbyfng1a0/M8yX3XRWLffS8BHD38xl2B30DuQgZ+1RuicTQqKX
	 f1KURGg77oJYWmNze9IEtwzy5jF3NxO8KwWQtZfjVnduiQzq8wih28G6riZDIfsNT7
	 bkQJ3v7un8E0U+f9qJeWMCCRewhmS39zqafeuVZYk8ZBWOt/OFK76SaOaNNqYd4WZt
	 8sI+UcyqSeVDxppkREKi2Eko6fFJ0ZsMkdztfCy1XaKTxIGXJ4y27tqswCCkHwdMFh
	 Y5r1VP/pzSlUQ==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2c77a5747e0so2117616fac.2;
        Mon, 24 Mar 2025 09:32:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWNIwlFv+tczJHzhwLUKz3QacZauSu3UlJcD9Lq5uaDYZqtChix8iusOfdCUmahu3vo7REDJCdQQnl3@vger.kernel.org, AJvYcCWTEivmIvySivR6IkFyQeIqvShBejS2YcG44ovJK9r/5mjCXgsoitJP3+c5+akH/TJdMFBaadOA67+5p2pA@vger.kernel.org
X-Gm-Message-State: AOJu0YzlkHPGVepOX86v85j1R/bwrKJ9snkySdE+6bTPclB6MyqdeCE4
	WGFcf0eAUiPSjP/3zNO9zmJe131cMxlhg/AoYQpiidwQCB6M6ihB0xWEIoCqDgump1anpItABJ+
	XWsTb5fmS9yUMt8Evf2yNR/QKniI=
X-Google-Smtp-Source: AGHT+IHfeb0h+B+bkIRNmwuybw2Amzh7ICQIYlp9osDBdq+IeC0RcXkx0XLL9gggkT9SyGlGfIZ+fyKJYPPuZE+5o38=
X-Received: by 2002:a05:6870:8991:b0:2b7:da8e:48aa with SMTP id
 586e51a60fabf-2c7802c8436mr8196173fac.23.1742833946915; Mon, 24 Mar 2025
 09:32:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 24 Mar 2025 17:32:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hEX-1Yb_u3cjr8sVfX7jOk5puAY9iH-Qzto4UJHvXpfQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jr5r1ypJtSIVdj60zvrRpAzTUaQH2TOwIdVwer0GiMpXW3ezocvzTwYTSY
Message-ID: <CAJZ5v0hEX-1Yb_u3cjr8sVfX7jOk5puAY9iH-Qzto4UJHvXpfQ@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v6.15-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.15-rc1

with top-most commit c5a55e427c947f013f08cbbf2be23bd4df2c9590

 Merge branch 'pm-misc'

on top of commit 80e54e84911a923c40d7bee33a34c1b4be148d7a

 Linux 6.14-rc6

to receive power management updates for 6.15-rc1.

These are dominated by cpufreq updates which in turn are dominated by
updates related to boost support in the core and drivers and amd-pstate
driver optimizations.

Apart from the above, there are some cpuidle updates including a rework
of the most recent idle intervals handling in the venerable menu governor
that leads to significant improvements in some performance benchmarks, as
the governor is now more likely to predict a shorter idle duration in
some cases, and there are updates of the core device power management
code, mostly related to system suspend and resume, that should help to
avoid potential issues arising when the drivers of devices depending on
one another want to use different optimizations.

There is also a usual collection of assorted fixes and cleanups,
including removal of some unused code.

Specifics:

 - Manage sysfs attributes and boost frequencies efficiently from
   cpufreq core to reduce boilerplate code in drivers (Viresh Kumar).

 - Minor cleanups to cpufreq drivers (Aaron Kling, Benjamin Schneider,
   Dhananjay Ugwekar, Imran Shaik, zuoqian).

 - Migrate some cpufreq drivers to using for_each_present_cpu() (Jacky
   Bai).

 - cpufreq-qcom-hw DT binding fixes (Krzysztof Kozlowski).

 - Use str_enable_disable() helper in cpufreq_online() (Lifeng Zheng).

 - Optimize the amd-pstate driver to avoid cases where call paths end
   up calling the same writes multiple times and needlessly caching
   variables through code reorganization, locking overhaul and tracing
   adjustments (Mario Limonciello, Dhananjay Ugwekar).

 - Make it possible to avoid enabling capacity-aware scheduling (CAS) in
   the intel_pstate driver and relocate a check for out-of-band (OOB)
   platform handling in it to make it detect OOB before checking HWP
   availability (Rafael Wysocki).

 - Fix dbs_update() to avoid inadvertent conversions of negative integer
   values to unsigned int which causes CPU frequency selection to be
   inaccurate in some cases when the "conservative" cpufreq governor is
   in use (Jie Zhan).

 - Update the handling of the most recent idle intervals in the menu
   cpuidle governor to prevent useful information from being discarded
   by it in some cases and improve the prediction accuracy (Rafael
   Wysocki).

 - Make it possible to tell the intel_idle driver to ignore its built-in
   table of idle states for the given processor, clean up the handling
   of auto-demotion disabling on Baytrail and Cherrytrail chips in it,
   and update its MAINTAINERS entry (David Arcari, Artem Bityutskiy,
   Rafael Wysocki).

 - Make some cpuidle drivers use for_each_present_cpu() instead of
   for_each_possible_cpu() during initialization to avoid issues
   occurring when nosmp or maxcpus=0 are used (Jacky Bai).

 - Clean up the Energy Model handling code somewhat (Rafael Wysocki).

 - Use kfree_rcu() to simplify the handling of runtime Energy Model
   updates (Li RongQing).

 - Add an entry for the Energy Model framework to MAINTAINERS as
   properly maintained (Lukasz Luba).

 - Address RCU-related sparse warnings in the Energy Model code (Rafael
   Wysocki).

 - Remove ENERGY_MODEL dependency on SMP and allow it to be selected
   when DEVFREQ is set without CPUFREQ so it can be used on a wider
   range of systems (Jeson Gao).

 - Unify error handling during runtime suspend and runtime resume in the
   core to help drivers to implement more consistent runtime PM error
   handling (Rafael Wysocki).

 - Drop a redundant check from pm_runtime_force_resume() and rearrange
   documentation related to __pm_runtime_disable() (Rafael Wysocki).

 - Rework the handling of the "smart suspend" driver flag in the PM core
   to avoid issues that may occur when drivers using it depend on some
   other drivers and clean up the related PM core code (Rafael Wysocki,
   Colin Ian King).

 - Fix the handling of devices with the power.direct_complete flag set
   if device_suspend() returns an error for at least one device to avoid
   situations in which some of them may not be resumed (Rafael Wysocki).

 - Use mutex_trylock() in hibernate_compressor_param_set() to avoid a
   possible deadlock that may occur if the "compressor" hibernation
   module parameter is accessed during the registration of a new
   ieee80211 device (Lizhi Xu).

 - Suppress sleeping parent warning in device_pm_add() in the case when
   new children are added under a device with the power.direct_complete
   set after it has been processed by device_resume() (Xu Yang).

 - Remove needless return in three void functions related to system
   wakeup (Zijun Hu).

 - Replace deprecated kmap_atomic() with kmap_local_page() in the
   hibernation core code (David Reaver).

 - Remove unused helper functions related to system sleep (David Alan
   Gilbert).

 - Clean up s2idle_enter() so it does not lock and unlock CPU offline
   in vain and update comments in it (Ulf Hansson).

 - Clean up broken white space in dpm_wait_for_children() (Geert
   Uytterhoeven).

 - Update the cpupower utility to fix lib version-ing in it and memory
   leaks in error legs, remove hard-coded values, and implement CPU
   physical core querying (Thomas Renninger, John B. Wyatt IV, Shuah
   Khan, Yiwei Lin, Zhongqiu Han).

Thanks!


---------------

Aaron Kling (2):
      cpufreq: tegra194: Allow building for Tegra234
      cpufreq: tegra186: Share policy per cluster

Artem Bityutskiy (1):
      intel_idle: clean up BYT/CHT auto demotion disable

Benjamin Schneider (1):
      cpufreq: enable 1200Mhz clock speed for armada-37xx

Colin Ian King (1):
      PM: sleep: Fix bit masking operation

David Arcari (1):
      intel_idle: introduce 'no_native' module parameter

David Reaver (1):
      PM: hibernate: Replace deprecated kmap_atomic() with kmap_local_page()

Dhananjay Ugwekar (11):
      cpufreq: amd-pstate: Remove unnecessary driver_lock in set_boost
      cpufreq/amd-pstate: Modify the min_perf calculation in
adjust_perf callback
      cpufreq/amd-pstate: Remove the redundant des_perf clamping in adjust_perf
      cpufreq/amd-pstate: Pass min/max_limit_perf as min/max_perf to
amd_pstate_update
      cpufreq/amd-pstate: Convert all perf values to u8
      cpufreq/amd-pstate: Modularize perf<->freq conversion
      cpufreq/amd-pstate: Remove the unnecessary cpufreq_update_policy call
      cpufreq/amd-pstate: Add missing NULL ptr check in amd_pstate_update
      cpufreq/amd-pstate: Use scope based cleanup for cpufreq_policy refs
      cpufreq/amd-pstate: Remove the unncecessary driver_lock in
amd_pstate_update_limits
      cpufreq/amd-pstate: Fix the clamping of perf values

Dr. David Alan Gilbert (3):
      PM: clk: remove unused of_pm_clk_add_clk()
      PM: sleep: Remove unused pm_generic_ wrappers
      PM: clk: Remove unused pm_clk_remove()

Geert Uytterhoeven (1):
      PM: sleep: core: Fix indentation in dpm_wait_for_children()

Imran Shaik (1):
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add QCS8300 compatible

Jacky Bai (2):
      cpuidle: Init cpuidle only for present CPUs
      cpufreq: Init cpufreq only for present CPUs

Jeson Gao (1):
      PM: EM: Rework the depends on for CONFIG_ENERGY_MODEL

Jie Zhan (1):
      cpufreq: governor: Fix negative 'idle_time' handling in dbs_update()

John B. Wyatt IV (1):
      cpupower: Implement CPU physical core querying

Krzysztof Kozlowski (3):
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add missing constraint
for interrupt-names
      dt-bindings: cpufreq: cpufreq-qcom-hw: Drop redundant minItems:1
      dt-bindings: cpufreq: cpufreq-qcom-hw: Narrow properties on
SDX75, SA8775p and SM8650

Li RongQing (1):
      PM: EM: use kfree_rcu() to simplify the code

Lifeng Zheng (1):
      cpufreq: Use str_enable_disable() helper

Lizhi Xu (1):
      PM: hibernate: Avoid deadlock in hibernate_compressor_param_set()

Lukasz Luba (1):
      MAINTAINERS: Add Energy Model framework as properly maintained

Mario Limonciello (19):
      cpufreq/amd-pstate: Invalidate cppc_req_cached during suspend
      cpufreq/amd-pstate: Show a warning when a CPU fails to setup
      cpufreq/amd-pstate: Drop min and max cached frequencies
      cpufreq/amd-pstate: Move perf values into a union
      cpufreq/amd-pstate: Overhaul locking
      cpufreq/amd-pstate: Drop `cppc_cap1_cached`
      cpufreq/amd-pstate-ut: Use _free macro to free put policy
      cpufreq/amd-pstate-ut: Allow lowest nonlinear and lowest to be the same
      cpufreq/amd-pstate-ut: Drop SUCCESS and FAIL enums
      cpufreq/amd-pstate-ut: Run on all of the correct CPUs
      cpufreq/amd-pstate-ut: Adjust variable scope
      cpufreq/amd-pstate: Replace all AMD_CPPC_* macros with masks
      cpufreq/amd-pstate: Cache CPPC request in shared mem case too
      cpufreq/amd-pstate: Move all EPP tracing into *_update_perf and
*_set_epp functions
      cpufreq/amd-pstate: Update cppc_req_cached for shared mem EPP writes
      cpufreq/amd-pstate: Drop debug statements for policy setting
      cpufreq/amd-pstate: Rework CPPC enabling
      cpufreq/amd-pstate: Stop caching EPP
      cpufreq/amd-pstate: Drop actions in amd_pstate_epp_cpu_offline()

Rafael J. Wysocki (27):
      PM: EM: Drop unused parameter from em_adjust_new_capacity()
      PM: EM: Slightly reduce em_check_capacity_update() overhead
      cpufreq: intel_pstate: Make it possible to avoid enabling CAS
      PM: Rearrange documentation related to __pm_runtime_disable()
      PM: Block enabling of runtime PM during system suspend
      PM: runtime: Introduce pm_runtime_blocked()
      PM: sleep: Use DPM_FLAG_SMART_SUSPEND conditionally
      cpufreq: intel_pstate: Relocate platform preference check
      cpuidle: menu: Drop a redundant local variable
      cpuidle: menu: Use one loop for average and variance computations
      cpuidle: menu: Tweak threshold use in get_typical_interval()
      cpuidle: menu: Eliminate outliers on both ends of the sample set
      cpuidle: menu: Avoid discarding useful information
      cpuidle: menu: Update documentation after get_typical_interval() changes
      cpuidle: intel_idle: Update MAINTAINERS
      PM: sleep: Avoid unnecessary checks in device_prepare_smart_suspend()
      PM: runtime: Drop status check from pm_runtime_force_resume()
      PM: sleep: Adjust check before setting power.must_resume
      PM: sleep: Update power.smart_suspend under PM spinlock
      PM: runtime: Convert pm_runtime_blocked() to static inline
      PM: core: Tweak pm_runtime_block_if_disabled() return value
      PM: sleep: Rename power.async_in_progress to power.work_in_progress
      PM: sleep: Rearrange dpm_async_fn() and async state clearing
      PM: runtime: Unify error handling during suspend and resume
      PM: EM: Consify two parameters of em_dev_register_perf_domain()
      PM: EM: Address RCU-related sparse warnings
      PM: sleep: Fix handling devices with direct_complete set on errors

Shuah Khan (2):
      pm: cpupower: Fix cmd_monitor() error legs to free cpu_topology
      pm: cpupower: remove hard-coded topology depth values

Thomas Renninger (1):
      cpupower: Make lib versioning scheme more obvious and fix version link

Ulf Hansson (2):
      PM: s2idle: Drop redundant locks when entering s2idle
      PM: s2idle: Extend comment in s2idle_enter()

Viresh Kumar (48):
      cpufreq: Always create freq-table related sysfs file
      cpufreq: dt: Stop setting cpufreq_driver->attr field
      cpufreq: acpi: Stop setting common freq attributes
      cpufreq: apple: Stop setting cpufreq_driver->attr field
      cpufreq: bmips: Stop setting cpufreq_driver->attr field
      cpufreq: brcmstb: Stop setting common freq attributes
      cpufreq: davinci: Stop setting cpufreq_driver->attr field
      cpufreq: e_powersaver: Stop setting cpufreq_driver->attr field
      cpufreq: elanfreq: Stop setting cpufreq_driver->attr field
      cpufreq: imx6q: Stop setting cpufreq_driver->attr field
      cpufreq: kirkwood: Stop setting cpufreq_driver->attr field
      cpufreq: longhaul: Stop setting cpufreq_driver->attr field
      cpufreq: loongson: Stop setting cpufreq_driver->attr field
      cpufreq: mediatek: Stop setting cpufreq_driver->attr field
      cpufreq: omap: Stop setting cpufreq_driver->attr field
      cpufreq: p4: Stop setting cpufreq_driver->attr field
      cpufreq: pasemi: Stop setting cpufreq_driver->attr field
      cpufreq: pmac: Stop setting cpufreq_driver->attr field
      cpufreq: powernow: Stop setting cpufreq_driver->attr field
      cpufreq: powernv: Stop setting common freq attributes
      cpufreq: qcom: Stop setting cpufreq_driver->attr field
      cpufreq: qoriq: Stop setting cpufreq_driver->attr field
      cpufreq: sc520_freq: Stop setting cpufreq_driver->attr field
      cpufreq: scmi: Stop setting cpufreq_driver->attr field
      cpufreq: scpi: Stop setting cpufreq_driver->attr field
      cpufreq: sh: Stop setting cpufreq_driver->attr field
      cpufreq: spear: Stop setting cpufreq_driver->attr field
      cpufreq: speedstep: Stop setting cpufreq_driver->attr field
      cpufreq: tegra: Stop setting cpufreq_driver->attr field
      cpufreq: vexpress: Stop setting cpufreq_driver->attr field
      cpufreq: virtual: Stop setting cpufreq_driver->attr field
      cpufreq: Remove cpufreq_generic_attrs
      cpufreq: Stop checking for duplicate available/boost freq attributes
      cpufreq: staticize cpufreq_boost_trigger_state()
      cpufreq: Export cpufreq_boost_set_sw()
      cpufreq: Introduce policy->boost_supported flag
      cpufreq: acpi: Set policy->boost_supported
      cpufreq: amd: Set policy->boost_supported
      cpufreq: cppc: Set policy->boost_supported
      cpufreq: Restrict enabling boost on policies with no boost frequencies
      cpufreq: apple: Set .set_boost directly
      cpufreq: loongson: Set .set_boost directly
      cpufreq: powernv: Set .set_boost directly
      cpufreq: scmi: Set .set_boost directly
      cpufreq: dt: Set .set_boost directly
      cpufreq: qcom: Set .set_boost directly
      cpufreq: staticize policy_has_boost_freq()
      cpufreq: Remove cpufreq_enable_boost_support()

Xu Yang (1):
      PM: sleep: Suppress sleeping parent warning in special case

Yiwei Lin (1):
      cpupower: monitor: Exit with error status if execvp() fail

Zhongqiu Han (1):
      pm: cpupower: bench: Prevent NULL dereference on malloc failure

Zijun Hu (1):
      PM: wakeup: Remove needless return in three void APIs

zuoqian (1):
      cpufreq: scpi: compare kHz instead of Hz

---------------

 Documentation/admin-guide/kernel-parameters.txt    |   3 +
 Documentation/admin-guide/pm/cpuidle.rst           |  29 +-
 Documentation/admin-guide/pm/intel_idle.rst        |  18 +-
 Documentation/admin-guide/pm/intel_pstate.rst      |   3 +
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          |  35 +-
 MAINTAINERS                                        |  17 +-
 arch/x86/include/asm/msr-index.h                   |  20 +-
 arch/x86/kernel/acpi/cppc.c                        |   4 +-
 drivers/acpi/device_pm.c                           |   4 +-
 drivers/base/power/clock_ops.c                     |  73 ---
 drivers/base/power/generic_ops.c                   |  24 -
 drivers/base/power/main.c                          | 165 +++--
 drivers/base/power/runtime.c                       |  87 ++-
 drivers/cpufreq/Kconfig.arm                        |   2 +-
 drivers/cpufreq/acpi-cpufreq.c                     |   4 +-
 drivers/cpufreq/amd-pstate-trace.h                 |  57 +-
 drivers/cpufreq/amd-pstate-ut.c                    | 211 +++----
 drivers/cpufreq/amd-pstate.c                       | 670 +++++++++------------
 drivers/cpufreq/amd-pstate.h                       |  65 +-
 drivers/cpufreq/apple-soc-cpufreq.c                |  18 +-
 drivers/cpufreq/armada-37xx-cpufreq.c              |   6 +-
 drivers/cpufreq/armada-8k-cpufreq.c                |   2 +-
 drivers/cpufreq/bmips-cpufreq.c                    |   1 -
 drivers/cpufreq/brcmstb-avs-cpufreq.c              |   1 -
 drivers/cpufreq/cppc_cpufreq.c                     |   9 +-
 drivers/cpufreq/cpufreq-dt.c                       |  24 +-
 drivers/cpufreq/cpufreq.c                          |  46 +-
 drivers/cpufreq/cpufreq_governor.c                 |  45 +-
 drivers/cpufreq/davinci-cpufreq.c                  |   1 -
 drivers/cpufreq/e_powersaver.c                     |   1 -
 drivers/cpufreq/elanfreq.c                         |   1 -
 drivers/cpufreq/freq_table.c                       |  15 +-
 drivers/cpufreq/imx6q-cpufreq.c                    |   1 -
 drivers/cpufreq/intel_pstate.c                     |  27 +-
 drivers/cpufreq/kirkwood-cpufreq.c                 |   1 -
 drivers/cpufreq/longhaul.c                         |   1 -
 drivers/cpufreq/loongson2_cpufreq.c                |   1 -
 drivers/cpufreq/loongson3_cpufreq.c                |  11 +-
 drivers/cpufreq/mediatek-cpufreq-hw.c              |   3 +-
 drivers/cpufreq/mediatek-cpufreq.c                 |   3 +-
 drivers/cpufreq/mvebu-cpufreq.c                    |   2 +-
 drivers/cpufreq/omap-cpufreq.c                     |   1 -
 drivers/cpufreq/p4-clockmod.c                      |   1 -
 drivers/cpufreq/pasemi-cpufreq.c                   |   1 -
 drivers/cpufreq/pmac32-cpufreq.c                   |   1 -
 drivers/cpufreq/pmac64-cpufreq.c                   |   1 -
 drivers/cpufreq/powernow-k6.c                      |   1 -
 drivers/cpufreq/powernow-k7.c                      |   1 -
 drivers/cpufreq/powernow-k8.c                      |   1 -
 drivers/cpufreq/powernv-cpufreq.c                  |  11 +-
 drivers/cpufreq/qcom-cpufreq-hw.c                  |  16 +-
 drivers/cpufreq/qcom-cpufreq-nvmem.c               |   8 +-
 drivers/cpufreq/qoriq-cpufreq.c                    |   1 -
 drivers/cpufreq/sc520_freq.c                       |   1 -
 drivers/cpufreq/scmi-cpufreq.c                     |  21 +-
 drivers/cpufreq/scpi-cpufreq.c                     |   8 +-
 drivers/cpufreq/sh-cpufreq.c                       |   1 -
 drivers/cpufreq/spear-cpufreq.c                    |   1 -
 drivers/cpufreq/speedstep-centrino.c               |   1 -
 drivers/cpufreq/speedstep-ich.c                    |   1 -
 drivers/cpufreq/speedstep-smi.c                    |   1 -
 drivers/cpufreq/sun50i-cpufreq-nvmem.c             |   6 +-
 drivers/cpufreq/tegra186-cpufreq.c                 |   8 +-
 drivers/cpufreq/tegra194-cpufreq.c                 |   1 -
 drivers/cpufreq/vexpress-spc-cpufreq.c             |   1 -
 drivers/cpufreq/virtual-cpufreq.c                  |   3 +-
 drivers/cpuidle/cpuidle-arm.c                      |   8 +-
 drivers/cpuidle/cpuidle-big_little.c               |   2 +-
 drivers/cpuidle/cpuidle-psci.c                     |   4 +-
 drivers/cpuidle/cpuidle-qcom-spm.c                 |   2 +-
 drivers/cpuidle/cpuidle-riscv-sbi.c                |   4 +-
 drivers/cpuidle/governors/menu.c                   | 129 ++--
 drivers/idle/intel_idle.c                          |  35 +-
 drivers/mfd/intel-lpss.c                           |   2 +-
 drivers/pci/pci-driver.c                           |   6 +-
 drivers/powercap/Kconfig                           |   2 +-
 include/linux/cpufreq.h                            |  24 +-
 include/linux/device.h                             |   9 +
 include/linux/energy_model.h                       |  20 +-
 include/linux/pm.h                                 |   9 +-
 include/linux/pm_clock.h                           |   5 -
 include/linux/pm_runtime.h                         |  33 +-
 include/linux/pm_wakeup.h                          |   6 +-
 kernel/power/Kconfig                               |   3 +-
 kernel/power/energy_model.c                        |  67 +--
 kernel/power/hibernate.c                           |   6 +-
 kernel/power/snapshot.c                            |  16 +-
 kernel/power/suspend.c                             |  14 +-
 tools/power/cpupower/Makefile                      |  19 +-
 tools/power/cpupower/bench/parse.c                 |   4 +
 tools/power/cpupower/lib/cpupower.c                |  48 +-
 tools/power/cpupower/lib/cpupower.h                |   3 +
 .../cpupower/utils/idle_monitor/cpupower-monitor.c |  48 +-
 93 files changed, 1146 insertions(+), 1191 deletions(-)

