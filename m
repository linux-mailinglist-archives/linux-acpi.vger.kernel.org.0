Return-Path: <linux-acpi+bounces-10765-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 830DEA173E6
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jan 2025 22:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C31A3A86FE
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jan 2025 21:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D65192D68;
	Mon, 20 Jan 2025 21:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+dKx/UZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7B517B421;
	Mon, 20 Jan 2025 21:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737407078; cv=none; b=W7OoQLce4E9qOvw4im0rCSbKtzynETma3LdLYHzYKi7BlsdcOaZXZaO4G6pUODR6cuLf8iRMifHsZbUh5n/pV7R2TZs2vM4OOzE1hlhN6HM3jFpba6bexb66fMVb+dRCdNz9lkRM6e2oMwn6mxrffLD9iYfcb05d5zKWdirn7Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737407078; c=relaxed/simple;
	bh=MHGCyeIwJAga4JIEGvRvqiuQk8h+Yhs9gEQ7YyRG5kQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FnVf7UoNp+SD+gkrAc01EvB4xaXxq6g2TJvSpNBajceuo6Jm2n/76bBjUhGAHA2VQYuGYM5/gBA8dKO99jfOC18toUXwaQPL5cu5laKn2H1rSpX5Oc6oDPhaOM+uEDHcxxrPEhQLBJAobIQV3rx+YCxsJ6eBqVFBL3GnO6oh5Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+dKx/UZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1991CC4CEE5;
	Mon, 20 Jan 2025 21:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737407078;
	bh=MHGCyeIwJAga4JIEGvRvqiuQk8h+Yhs9gEQ7YyRG5kQ=;
	h=From:Date:Subject:To:Cc:From;
	b=F+dKx/UZcPp8bxSQlmnlE12P8E5MZSylsoT1aaI3J4IV17CDRS5KygMTFg2tqFSLM
	 FZJdCEoEhOwEV4Jre+TNQZTHt94B2mbDZHmijXAnRosiuJD1pqVljrwgfIOa4latFP
	 xymM2ZsLNIA1t8t8jRsxGVVDtU6ZqQ8Gr7KuK0r28eJ0BzYFm9UGXNO6gewE/MsLKk
	 DZPfDXQN+M5UgDpN9mVBObUZ7BCtq7lKeHIzey2AL64Gpfqghxc3pL3cyNuu9N9xfx
	 Cr/pS/rkxACKEs9LdvNMEdDogb+NWDpuxmWG9+VczSN/g85Ghy8574gJN4Pzaq/w2l
	 OGxpPpYVRRnOg==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7231e2ac9e4so1240939a34.0;
        Mon, 20 Jan 2025 13:04:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUHQvA3U55HGw5two5F5dpeBPE63aBh0rdZSLMEPzTC50RUYp1whXDKkXY77MatRqdKzJiiJ4HLde7Ej0Ym@vger.kernel.org, AJvYcCXvdDStcKmu0RnfkB+Rd/UVWCZqoeSLRDYyCHI6M5mu8Cyxv317W+cd65uTzfACDQrnlBjTXQYNN4Fb@vger.kernel.org
X-Gm-Message-State: AOJu0YxmFrN1uldCKsuU/c9fk3S6FFSDySueamdOaY5IjvZqrkhcgN9x
	xBRKA8WP1T5pkf7PSMTVfqlHcNhBZzxjL01eHeV0BarxuwoblIJ5RiW5TfKlXWLwz9jvEHtZity
	jHe/AZde1sdCetSV3JYPOTVbWFww=
X-Google-Smtp-Source: AGHT+IEg2/jkzglFqyp1d8rk2JiiD+Pz+t4sNwHp+UIQ6IOFRttZkiojjTeWgvybUnuNXbYDcbgHCd7nbZ/3vYSU+YQ=
X-Received: by 2002:a05:6830:6989:b0:71d:f581:3c0 with SMTP id
 46e09a7af769-7249da8fa91mr9589819a34.16.1737407077227; Mon, 20 Jan 2025
 13:04:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Jan 2025 22:04:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i4eh2z_8vDf6U+Ro0V+221wA8BL656kpREgvMWYR83SA@mail.gmail.com>
X-Gm-Features: AbW1kvahU2SzyPJ0w8i1-EW3zMmqTW64wtZ0X0_fSn5PUTJJiQ8RcBmnWHucmEw
Message-ID: <CAJZ5v0i4eh2z_8vDf6U+Ro0V+221wA8BL656kpREgvMWYR83SA@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v6.14-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.14-rc1

with top-most commit 1c91c99075db4e31fb5cf0838ce59e80ecd51eab

 Merge branch 'pm-tools'

on top of commit 3744b08449c27bfa085aa218c4830f3996a51626

 Merge branch 'pm-cpufreq'

to receive power management updates for 6.14-rc1.

The majority of changes here are cpufreq updates which are dominated by
amd-pstate driver changes, like in the previous cycle.  Moreover, changes
related to amd-pstate are also the majority of cpupower utility updates.

Included are some pieces of new hardware support, like the addition of
Clearwater Forest processors support to intel_idle, new cpufreq driver
for Airoha SoCs, and Apple cpufreq driver extensions to support more
SoCs.  The intel_pstate driver is also extended to be able to support
new platforms by using ACPI CPPC to compute scaling factors between HWP
performance states and frequency.

The rest is mostly fixes and cleanups in assorted pieces of power
management code.

Specifics:

 - Use str_enable_disable()-like helpers in cpufreq (Krzysztof
   Kozlowski).

 - Extend the Apple cpufreq driver to support more SoCs (Hector Martin,
   Nick Chan).

 - Add new cpufreq driver for Airoha SoCs (Christian Marangi).

 - Fix using cpufreq-dt as module (Andreas Kemnade).

 - Minor fixes for Sparc, SCMI, and Qcom cpufreq drivers (Ethan Carter
   Edwards, Sibi Sankar, Manivannan Sadhasivam).

 - Fix the maximum supported frequency computation in the ACPI cpufreq
   driver to avoid relying on unfounded assumptions (Gautham Shenoy).

 - Fix an amd-pstate driver regression with preferred core rankings not
   being used (Mario Limonciello).

 - Fix a precision issue with frequency calculation in the amd-pstate
   driver (Naresh Solanki).

 - Add ftrace event to the amd-pstate driver for active mode (Mario
   Limonciello).

 - Set default EPP policy on Ryzen processors in amd-pstate (Mario
   Limonciello).

 - Clean up the amd-pstate cpufreq driver and optimize it to increase
   code reuse (Mario Limonciello, Dhananjay Ugwekar).

 - Use CPPC to get scaling factors between HWP performance levels and
   frequency in the intel_pstate driver and make it stop using a built
   -in scaling factor for Arrow Lake processors (Rafael Wysocki).

 - Make intel_pstate initialize epp_policy to CPUFREQ_POLICY_UNKNOWN for
   consistency with CPU offline (Christian Loehle).

 - Fix superfluous updates caused by need_freq_update in the schedutil
   cpufreq governor (Sultan Alsawaf).

 - Allow configuring the system suspend-resume (DPM) watchdog to warn
   earlier than panic (Douglas Anderson).

 - Implement devm_device_init_wakeup() helper and introduce a device-
   managed variant of dev_pm_set_wake_irq() (Joe Hattori, Peng Fan).

 - Remove direct inclusions of 'pm_wakeup.h' which should be only
   included via 'device.h' (Wolfram Sang).

 - Clean up two comments in the core system-wide PM code (Rafael
   Wysocki, Randy Dunlap).

 - Add Clearwater Forest processor support to the intel_idle cpuidle
   driver (Artem Bityutskiy).

 - Clean up the Exynos devfreq driver and devfreq core (Markus Elfring,
   Jeongjun Park).

 - Minor cleanups and fixes for OPP (Dan Carpenter, Neil Armstrong, Joe
   Hattori).

 - Implement dev_pm_opp_get_bw() (Neil Armstrong).

 - Expose OPP reference counting helpers for Rust (Viresh Kumar).

 - Fix TSC MHz calculation in cpupower (He Rongguang).

 - Add install and uninstall options to bindings Makefile and add header
   changes for cpufreq.h to SWIG bindings in cpupower (John B. Wyatt IV).

 - Add missing residency header changes in cpuidle.h to SWIG bindings in
   cpupower (John B. Wyatt IV).

 - Add output files to .gitignore and clean them up in "make clean" in
   selftests/cpufreq (Li Zhijian).

 - Fix cross-compilation in cpupower Makefile (Peng Fan).

 - Revise the is_valid flag handling for idle_monitor in the cpupower
   utility (wangfushuai).

 - Extend and clean up AMD processors support in cpupower (Mario
   Limonciello).

Thanks!


---------------

Andreas Kemnade (1):
      cpufreq: fix using cpufreq-dt as module

Artem Bityutskiy (1):
      intel_idle: add Clearwater Forest SoC support

Christian Loehle (1):
      cpufreq: intel_pstate: Use CPUFREQ_POLICY_UNKNOWN

Christian Marangi (2):
      dt-bindings: cpufreq: Document support for Airoha EN7581 CPUFreq
      cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver

Dan Carpenter (1):
      opp: core: Fix off by one in dev_pm_opp_get_bw()

Dhananjay Ugwekar (5):
      cpufreq/amd-pstate: Convert the amd_pstate_get/set_epp() to static calls
      cpufreq/amd-pstate: Move the invocation of amd_pstate_update_perf()
      cpufreq/amd-pstate: Refactor amd_pstate_epp_reenable() and
amd_pstate_epp_offline()
      cpufreq/amd-pstate: Remove the cppc_state check in
offline/online functions
      cpufreq/amd-pstate: Merge amd_pstate_epp_cpu_offline() and
amd_pstate_epp_offline()

Douglas Anderson (1):
      PM: sleep: Allow configuring the DPM watchdog to warn earlier than panic

Ethan Carter Edwards (1):
      cpufreq: sparc: change kzalloc to kcalloc

Gautham R. Shenoy (1):
      cpufreq: ACPI: Fix max-frequency computation

He Rongguang (1):
      cpupower: fix TSC MHz calculation

Hector Martin (1):
      cpufreq: apple-soc: Drop setting the PS2 field on M2+

Jeongjun Park (1):
      PM / devfreq: exynos: remove unused function parameter

Joe Hattori (2):
      PM: wakeup: implement devm_device_init_wakeup() helper
      OPP: OF: Fix an OF node leak in _opp_add_static_v2()

John B. Wyatt IV (3):
      pm: cpupower: Add install and uninstall options to bindings makefile
      pm: cpupower: Add header changes for cpufreq.h to SWIG bindings
      pm: cpupower: Add missing residency header changes in cpuidle.h to SWIG

Krzysztof Kozlowski (1):
      cpufreq: Use str_enable_disable()-like helpers

Li Zhijian (1):
      selftests/cpufreq: gitignore output files and clean them in make clean

Manivannan Sadhasivam (2):
      cpufreq: qcom: Fix qcom_cpufreq_hw_recalc_rate() to query LUT if
LMh IRQ is not available
      cpufreq: qcom: Implement clk_ops::determine_rate() for
qcom_cpufreq* clocks

Mario Limonciello (21):
      cpufreq/amd-pstate: Add trace event for EPP perf updates
      cpufreq/amd-pstate: convert mutex use to guard()
      cpufreq/amd-pstate: Drop cached epp_policy variable
      cpufreq/amd-pstate: Use FIELD_PREP and FIELD_GET macros
      cpufreq/amd-pstate: Only update the cached value in
msr_set_epp() on success
      cpufreq/amd-pstate: store all values in cpudata struct in khz
      cpufreq/amd-pstate: Change amd_pstate_update_perf() to return an int
      cpufreq/amd-pstate: Move limit updating code
      cpufreq/amd-pstate: Cache EPP value and use that everywhere
      cpufreq/amd-pstate: Always write EPP value when updating perf
      cpufreq/amd-pstate: Drop ret variable from
amd_pstate_set_energy_pref_index()
      cpufreq/amd-pstate: Set different default EPP policy for Epyc and Ryzen
      cpufreq/amd-pstate: Drop boost_state variable
      cpupower: Remove spurious return statement
      cpupower: Add support for parsing 'enabled' or 'disabled'
strings from table
      cpupower: Add support for amd-pstate preferred core rankings
      cpupower: Don't try to read frequency from hardware when kernel
uses aperfmperf
      cpupower: Add support for showing energy performance preference
      cpupower: Don't fetch maximum latency when EPP is enabled
      cpupower: Adjust whitespace for amd-pstate specific prints
      cpufreq/amd-pstate: Fix prefcore rankings

Markus Elfring (1):
      PM / devfreq: event: Call of_node_put() only once in
devfreq_event_get_edev_by_phandle()

Naresh Solanki (1):
      cpufreq/amd-pstate: Refactor max frequency calculation

Neil Armstrong (3):
      opp: core: implement dev_pm_opp_get_bw
      OPP: add index check to assert to avoid buffer overflow in _read_freq()
      OPP: fix dev_pm_opp_find_bw_*() when bandwidth table not initialized

Nick Chan (6):
      dt-bindings: cpufreq: apple,cluster-cpufreq: Add A7-A11, T2 compatibles
      cpufreq: apple-soc: Allow per-SoC configuration of APPLE_DVFS_CMD_PS1
      cpufreq: apple-soc: Use 32-bit read for status register
      cpufreq: apple-soc: Increase cluster switch timeout to 400us
      cpufreq: apple-soc: Set fallback transition latency to
APPLE_DVFS_TRANSITION_TIMEOUT
      cpufreq: apple-soc: Add Apple A7-A8X SoC cpufreq support

Peng Fan (2):
      pm: cpupower: Makefile: Fix cross compilation
      PM: sleep: wakeirq: Introduce device-managed variant of
dev_pm_set_wake_irq()

Rafael J. Wysocki (4):
      PM: sleep: Update stale comment in device_resume()
      cpufreq: intel_pstate: Use CPPC to get scaling factors
      cpufreq: intel_pstate: Drop Arrow Lake from "scaling factor" list
      PM: EM: Move sched domains rebuild function from schedutil to EM

Randy Dunlap (1):
      PM: sleep: convert comment from kernel-doc to plain comment

Sibi Sankar (1):
      cpufreq: scmi: Register for limit change notifications

Sultan Alsawaf (unemployed) (1):
      cpufreq: schedutil: Fix superfluous updates caused by need_freq_update

Viresh Kumar (1):
      PM / OPP: Add reference counting helpers for Rust implementation

Wolfram Sang (2):
      PM: sleep: autosleep: don't include 'pm_wakeup.h' directly
      PM: sleep: sysfs: don't include 'pm_wakeup.h' directly

wangfushuai (1):
      cpupower: revise is_valid flag handling for idle_monitor

---------------

 .../bindings/cpufreq/airoha,en7581-cpufreq.yaml    |  55 +++
 .../bindings/cpufreq/apple,cluster-cpufreq.yaml    |  10 +-
 drivers/base/power/main.c                          |  26 +-
 drivers/base/power/sysfs.c                         |   1 -
 drivers/base/power/wakeirq.c                       |  26 ++
 drivers/cpufreq/Kconfig                            |   2 +-
 drivers/cpufreq/Kconfig.arm                        |   8 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/acpi-cpufreq.c                     |  36 +-
 drivers/cpufreq/airoha-cpufreq.c                   | 152 +++++++
 drivers/cpufreq/amd-pstate-trace.h                 |  52 ++-
 drivers/cpufreq/amd-pstate-ut.c                    |  12 +-
 drivers/cpufreq/amd-pstate.c                       | 483 ++++++++++-----------
 drivers/cpufreq/amd-pstate.h                       |   3 -
 drivers/cpufreq/apple-soc-cpufreq.c                |  56 ++-
 drivers/cpufreq/cpufreq-dt-platdev.c               |   4 +-
 drivers/cpufreq/cpufreq.c                          |   9 +-
 drivers/cpufreq/intel_pstate.c                     |  60 +--
 drivers/cpufreq/powernv-cpufreq.c                  |   3 +-
 drivers/cpufreq/qcom-cpufreq-hw.c                  |  34 +-
 drivers/cpufreq/scmi-cpufreq.c                     |  45 ++
 drivers/cpufreq/sparc-us2e-cpufreq.c               |   2 +-
 drivers/cpufreq/sparc-us3-cpufreq.c                |   2 +-
 drivers/devfreq/devfreq-event.c                    |   8 +-
 drivers/devfreq/exynos-bus.c                       |   5 +-
 drivers/idle/intel_idle.c                          |   1 +
 drivers/opp/core.c                                 |  99 ++++-
 drivers/opp/of.c                                   |   4 +-
 drivers/opp/opp.h                                  |   1 -
 include/linux/energy_model.h                       |   2 +
 include/linux/pm_opp.h                             |  13 +
 include/linux/pm_wakeirq.h                         |   6 +
 include/linux/pm_wakeup.h                          |  17 +
 kernel/power/Kconfig                               |  21 +-
 kernel/power/autosleep.c                           |   1 -
 kernel/power/energy_model.c                        |  17 +
 kernel/power/power.h                               |   2 +-
 kernel/sched/cpufreq_schedutil.c                   |  37 +-
 tools/power/cpupower/Makefile                      |   8 +
 tools/power/cpupower/bindings/python/Makefile      |  10 +
 tools/power/cpupower/bindings/python/README        |  25 ++
 .../cpupower/bindings/python/raw_pylibcpupower.swg |   5 +
 tools/power/cpupower/lib/cpufreq.c                 |  18 +
 tools/power/cpupower/lib/cpufreq.h                 |   8 +
 tools/power/cpupower/utils/cpufreq-info.c          |  36 +-
 tools/power/cpupower/utils/helpers/amd.c           |  18 +-
 .../cpupower/utils/idle_monitor/hsw_ext_idle.c     |   4 +-
 .../cpupower/utils/idle_monitor/mperf_monitor.c    |  17 +-
 tools/power/cpupower/utils/idle_monitor/nhm_idle.c |   2 +-
 tools/power/cpupower/utils/idle_monitor/snb_idle.c |   4 +-
 tools/testing/selftests/cpufreq/.gitignore         |   2 +
 tools/testing/selftests/cpufreq/Makefile           |   1 +
 52 files changed, 1044 insertions(+), 430 deletions(-)

