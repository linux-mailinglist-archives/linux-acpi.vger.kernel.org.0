Return-Path: <linux-acpi+bounces-19359-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDA2C931F2
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Nov 2025 21:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 403BC34BD32
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Nov 2025 20:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E7A2D0637;
	Fri, 28 Nov 2025 20:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9Oe8UBD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23172882AF
	for <linux-acpi@vger.kernel.org>; Fri, 28 Nov 2025 20:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764362043; cv=none; b=JvgZOfJTH40aw/WZ7j5xpYm+WLaRnl5T6lxRXB1dslKcsNxcRrffGtAKqY5axiGpF/pUqWWK19bmYqyS/LRTD31O/VZNwm5hFtRgZ6Wl2asIl/pR3nJy91R6yOE9GiLuVP5JQXm83HuKSgsrBdVuXyomBlWDlCssR9zJmk/IpTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764362043; c=relaxed/simple;
	bh=A3nSMvS46hZFTm2ODQrWZF0FSnlmd7CsrSW9Acg6xNA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=lcXct93fmYksaVo362sfjCpZM+Ps5YKs8PTFSXxPf2lEe11nD2DrexQH/X/vMvBGjY4lDXCG++/aNUyWmTgIcROTOrHCRMWN33DWbibdqut9sqotbF9czzFSVF9IP+LlJzZVjD9EUdqglE05gAFNFtR4OkyIsu9GmfpgTOXEsL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9Oe8UBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1002C4AF09
	for <linux-acpi@vger.kernel.org>; Fri, 28 Nov 2025 20:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764362043;
	bh=A3nSMvS46hZFTm2ODQrWZF0FSnlmd7CsrSW9Acg6xNA=;
	h=From:Date:Subject:To:Cc:From;
	b=L9Oe8UBDhk2Ahp3n3uR/tcv2L2F52phnYeALqGFjUGVpI/uSxYHSP3W/hRQvubXYZ
	 gjV+QtSYBRYwYh7BcM7yLKxEFLz0zRpoHTBrI9YJJOrNIyzSMpUaVJUpMEoM0jHzXB
	 +fkF8X4h3bICmGkElRnKXD3FmX7rpYHUVXbeoJGQXZe0d2kQL/wiXD7dchlOgo1Az3
	 zUKVag8DrYQ3/rFcujKUPX/uglL0oxTveg2mkQg9OloYQ2BBpGo9w5k1Zzk/FEsBHm
	 LbfPA//NDBU/DoqLdW+/wUc5XjXi+oFFkdd1FBSyZDuf8XMFQY+lR8/ahZrfGRZZwO
	 0/VlXH+T0YUbQ==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-657a6028fbbso830442eaf.3
        for <linux-acpi@vger.kernel.org>; Fri, 28 Nov 2025 12:34:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWOz9vdn6bz+yWnJkdUmg4HxKebSypfLxzDe/33NFDYhHPzfNIT+lAW2qBEWUzg9sjZ5EkVwa8+ozVu@vger.kernel.org
X-Gm-Message-State: AOJu0YxT4QDOe5kVu51zdYy6XNCXvDlSPSKEWeBlArgqZJjMsvHvX7eE
	13C4EE17+hmLwSYS/j8MT/l/r91H78KISlPNwGYzIVAYHRkweaM40HQx5kq4fQVrt6W2f8kdCzF
	GTDeAXeApQecCBc/bO00FRIpwwqOdt8c=
X-Google-Smtp-Source: AGHT+IH10fdsayn3pyGdZZ+J42Irjnmz0zUpuQM6KIMBBGCCxJg7aIUhlGp2ltM88z1LZeARQq5leRWUnmr9XId7n4E=
X-Received: by 2002:a05:6820:f004:b0:654:faee:1065 with SMTP id
 006d021491bc7-657bdcc0443mr5202094eaf.5.1764362042877; Fri, 28 Nov 2025
 12:34:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 28 Nov 2025 21:33:51 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iTbaZyAOqb=x4COUuX91u9CgJs-qi2pMBrFrOvC2e0ZQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmTqH6MOuNQrKWyBZnLBaKpYhS7DHQKlituwwFWI5KbBPjpdYoPQrI-cDY
Message-ID: <CAJZ5v0iTbaZyAOqb=x4COUuX91u9CgJs-qi2pMBrFrOvC2e0ZQ@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v6.19-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	"Chanwoo Choi (samsung.com)" <chanwoo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

I am sending this in advance because I am not expecting to make any changes
to it before next week.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.19-rc1

with top-most commit 7cede21e9f04f16a456d3c3c8a9a8899c8d84757

 Merge branches 'pm-qos' and 'pm-tools'

on top of commit ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d

 Linux 6.18-rc7

to receive power management updates for 6.19-rc1.

There are quite a few interesting things here, including new hardware
support, new features, some bug fixes and documentation updates.  In
addition, there are a usual bunch of minor fixes and cleanups all over.

In the new hardware support category, there are intel_pstate and
intel_rapl driver updates to support new processors, Panther Lake,
Wildcat Lake, Noval Lake, and Diamond Rapids in the OOB mode, OPP
and bandwidth allocation support in the tegra186 cpufreq driver,
and JH7110S SOC support in dt-platdev cpufreq.

The new features are the PM QoS CPU latency limit for suspend-to-idle,
the netlink support for the energy model management, support for
terminating system suspend via a wakeup event during the sync of
file systems, configurable number of hibernation compression threads,
the runtime PM auto-cleanup macros, and the "poweroff" PM event that
is expected to be used during system shutdown.

Bugs are mostly fixed in cpuidle governors, but there are also fixes
elsewhere, like in the amd-pstate cpufreq driver.

Documentation updates include, but are not limited to, a new doc on
debugging shutdown hangs, cross-referencing fixes and cleanups in the
intel_pstate documentation, and updates of comments in the core
hibernation code.

Specifics:

 - Introduce and document a QoS limit on CPU exit latency during wakeup
   from suspend-to-idle (Ulf Hansson)

 - Add support for building libcpupower statically (Zuo An)

 - Add support for sending netlink notifications to user space on energy
   model updates (Changwoo Mini, Peng Fan)

 - Minor improvements to the Rust OPP interface (Tamir Duberstein)

 - Fixes to scope-based pointers in the OPP library (Viresh Kumar)

 - Use residency threshold in polling state override decisions in the
   menu cpuidle governor (Aboorva Devarajan)

 - Add sanity check for exit latency and target residency in the cpufreq
   core (Rafael Wysocki)

 - Use this_cpu_ptr() where possible in the teo governor (Christian
   Loehle)

 - Rework the handling of tick wakeups in the teo cpuidle governor to
   increase the likelihood of stopping the scheduler tick in the cases
   when tick wakeups can be counted as non-timer ones (Rafael Wysocki)

 - Fix a reverse condition in the teo cpuidle governor and drop a
   misguided target residency check from it (Rafael Wysocki)

 - Clean up multiple minor defects in the teo cpuidle governor (Rafael
   Wysocki)

 - Update header inclusion to make it follow the Include What You Use
   principle (Andy Shevchenko)

 - Enable MSR-based RAPL PMU support in the intel_rapl power capping
   driver and arrange for using it on the Panther Lake and Wildcat Lake
   processors (Kuppuswamy Sathyanarayanan)

 - Add support for Nova Lake and Wildcat Lake processors to the
   intel_rapl power capping driver (Kaushlendra Kumar, Srinivas
   Pandruvada)

 - Add OPP and bandwidth support for Tegra186 (Aaron Kling)

 - Optimizations for parameter array handling in the amd-pstate cpufreq
   driver (Mario Limonciello)

 - Fix for mode changes with offline CPUs in the amd-pstate cpufreq
   driver (Gautham Shenoy)

 - Preserve freq_table_sorted across suspend/hibernate in the cpufreq
   core (Zihuan Zhang)

 - Adjust energy model rules for Intel hybrid platforms in the
   intel_pstate cpufreq driver and improve printing of debug messages
   in it (Rafael Wysocki)

 - Replace deprecated strcpy() in cpufreq_unregister_governor()
   (Thorsten Blum)

 - Fix duplicate hyperlink target errors in the intel_pstate cpufreq
   driver documentation and use :ref: directive for internal linking in
   it (Swaraj Gaikwad, Bagas Sanjaya)

 - Add Diamond Rapids OOB mode support to the intel_pstate cpufreq
   driver (Kuppuswamy Sathyanarayanan)

 - Use mutex guard for driver locking in the intel_pstate driver and
   eliminate some code duplication from it (Rafael Wysocki)

 - Replace udelay() with usleep_range() in ACPI cpufreq (Kaushlendra
   Kumar)

 - Minor improvements to various cpufreq drivers (Christian Marangi, Hal
   Feng, Jie Zhan, Marco Crivellari, Miaoqian Lin, and Shuhao Fu)

 - Replace snprintf() with scnprintf() in show_trace_dev_match()
   (Kaushlendra Kumar)

 - Fix memory allocation error handling in pm_vt_switch_required()
   (Malaya Kumar Rout)

 - Introduce CALL_PM_OP() macro and use it to simplify code in
   generic PM operations (Kaushlendra Kumar)

 - Add module param to backtrace all CPUs in the device power management
   watchdog (Sergey Senozhatsky)

 - Rework message printing in swsusp_save() (Rafael Wysocki)

 - Make it possible to change the number of hibernation compression
   threads (Xueqin Luo)

 - Clarify that only cgroup1 freezer uses PM freezer (Tejun Heo)

 - Add document on debugging shutdown hangs to PM documentation and
   correct a mistaken configuration option in it (Mario Limonciello)

 - Shut down wakeup source timer before removing the wakeup source from
   the list (Kaushlendra Kumar, Rafael Wysocki)

 - Introduce new PMSG_POWEROFF event for system shutdown handling with
   the help of PM device callbacks (Mario Limonciello)

 - Make pm_test delay interruptible by wakeup events (Riwen Lu)

 - Clean up kernel-doc comment style usage in the core hibernation
   code and remove unuseful comments from it (Sunday Adelodun, Rafael
   Wysocki)

 - Add support for handling wakeup events and aborting the suspend
   process while it is syncing file systems (Samuel Wu, Rafael Wysocki)

 - Add WQ_UNBOUND to pm_wq workqueue (Marco Crivellari)

 - Add runtime PM wrapper macros for ACQUIRE()/ACQUIRE_ERR() and use
   them in the PCI core and the ACPI TAD driver (Rafael Wysocki)

 - Improve runtime PM in the ACPI TAD driver (Rafael Wysocki)

 - Update pm_runtime_allow/forbid() documentation (Rafael Wysocki)

 - Fix typos in runtime.c comments (Malaya Kumar Rout)

 - Move governor.h from devfreq under include/linux/ and rename to
   devfreq-governor.h to allow devfreq governor definitions in out
   of drivers/devfreq/ (Dmitry Baryshkov)

 - Use min() to improve readability in tegra30-devfreq.c (Thorsten
   Blum)

 - Fix potential use-after-free issue of OPP handling in
   hisi_uncore_freq.c (Pengjie Zhang)

 - Fix typo in DFSO_DOWNDIFFERENTIAL macro name in
   governor_simpleondemand.c in devfreq (Riwen Lu)

Thanks!


---------------

Aaron Kling (1):
      cpufreq: tegra186: add OPP support and set bandwidth

Aboorva Devarajan (1):
      cpuidle: menu: Use residency threshold in polling state override decisions

Andy Shevchenko (1):
      cpuidle: Update header inclusion

Bagas Sanjaya (1):
      Documentation: intel-pstate: Use :ref: directive for internal linking

Changwoo Min (10):
      PM: EM: Assign a unique ID when creating a performance domain
      PM: EM: Expose the ID of a performance domain via debugfs
      PM: EM: Add em.yaml and autogen files
      PM: EM: Add a skeleton code for netlink notification
      PM: EM: Add an iterator and accessor for the performance domain
      PM: EM: Implement em_nl_get_pds_doit()
      PM: EM: Implement em_nl_get_pd_table_doit()
      PM: EM: Implement em_notify_pd_deleted()
      PM: EM: Implement em_notify_pd_created/updated()
      PM: EM: Notify an event when the performance domain changes

Christian Loehle (1):
      cpuidle: teo: Use this_cpu_ptr() where possible

Christian Marangi (2):
      cpufreq: qcom-nvmem: add compatible fallback for ipq806x for no SMEM
      cpufreq: qcom-nvmem: fix compilation warning for
qcom_cpufreq_ipq806x_match_list

Dmitry Baryshkov (1):
      PM / devfreq: Move governor.h to a public header location

Gautham R. Shenoy (1):
      cpufreq/amd-pstate: Call cppc_set_auto_sel() only for online CPUs

Hal Feng (1):
      cpufreq: dt-platdev: Add JH7110S SOC to the allowlist

Jie Zhan (1):
      cpufreq: CPPC: Don't warn if FIE init fails to read counters

Kaushlendra Kumar (5):
      PM: sleep: Replace snprintf() with scnprintf() in show_trace_dev_match()
      PM: sleep: Introduce CALL_PM_OP() macro to simplify code
      PM: wakeup: Delete timer before removing wakeup source from list
      powercap: intel_rapl: Add support for Nova Lake processors
      cpufreq: ACPI: Replace udelay() with usleep_range()

Kuppuswamy Sathyanarayanan (3):
      cpufreq: intel_pstate: Add Diamond Rapids OOB mode support
      powercap: intel_rapl: Prepare read_raw() interface for
atomic-context callers
      powercap: intel_rapl: Enable MSR-based RAPL PMU support

Malaya Kumar Rout (2):
      PM: console: Fix memory allocation error handling in
pm_vt_switch_required()
      PM: runtime: fix typos in runtime.c comments

Marco Crivellari (2):
      PM: WQ_UNBOUND added to pm_wq workqueue
      cpufreq: tegra194: add WQ_PERCPU to alloc_workqueue users

Mario Limonciello (AMD) (11):
      Documentation: power: Add document on debugging shutdown hangs
      Documentation: power: Correct a mistaken configuration option
      cpufreq/amd-pstate: Use sysfs_match_string() for epp
      cpufreq/amd-pstate: Drop NULL value from amd_pstate_mode_string
      cpufreq/amd-pstate: Make amd_pstate_get_mode_string() never return NULL
      cpufreq/amd-pstate: Adjust return values in amd_pstate_update_status()
      cpufreq/amd-pstate: Fix some whitespace issues
      cpufreq/amd-pstate: Add static asserts for EPP indices
      PM: Introduce new PMSG_POWEROFF event
      scsi: Add PM_EVENT_POWEROFF into suspend callbacks
      usb: sl811-hcd: Add PM_EVENT_POWEROFF into suspend callbacks

Miaoqian Lin (1):
      cpufreq: nforce2: fix reference count leak in nforce2

Peng Fan (1):
      PM: EM: Add to em_pd_list only when no failure

Pengjie Zhang (1):
      PM / devfreq: hisi: Fix potential UAF in OPP handling

Rafael J. Wysocki (25):
      PM: hibernate: Rework message printing in swsusp_save()
      cpufreq: intel_pstate: Add and use hybrid_get_cpu_type()
      cpufreq: intel_pstate: Add and use hybrid_has_l3()
      cpufreq: intel_pstate: hybrid: Adjust energy model rules
      cpufreq: intel_pstate: Improve printing of debug messages
      PM: runtime: docs: Update pm_runtime_allow/forbid() documentation
      ACPI: TAD: Rearrange runtime PM operations in acpi_tad_remove()
      ACPI: TAD: Improve runtime PM using guard macros
      cpufreq: intel_pstate: Use mutex guard for driver locking
      PM: wakeup: Update after recent wakeup source removal ordering change
      cpuidle: Add sanity check for exit latency and target residency
      cpuidle: governors: teo: Drop misguided target residency check
      cpuidle: governors: teo: Drop redundant function parameter
      cpuidle: governors: teo: Use s64 consistently in teo_update()
      cpuidle: governors: teo: Decay metrics below DECAY_SHIFT threshold
      PM: runtime: Wrapper macros for ACQUIRE()/ACQUIRE_ERR()
      ACPI: TAD: Use PM_RUNTIME_ACQUIRE()/PM_RUNTIME_ACQUIRE_ERR()
      PCI/sysfs: Use PM_RUNTIME_ACQUIRE()/PM_RUNTIME_ACQUIRE_ERR()
      cpufreq: intel_pstate: Eliminate some code duplication
      cpuidle: governors: teo: Rework the handling of tick wakeups
      cpuidle: governors: teo: Fix tick_intercepts handling in teo_update()
      cpuidle: governors: teo: Simplify intercepts-based state lookup
      PM: hibernate: Extra cleanup of comments in swap handling code
      cpuidle: governors: teo: Add missing space to the description
      cpuidle: Warn instead of bailing out if target residency check fails

Riwen Lu (2):
      PM: suspend: Make pm_test delay interruptible by wakeup events
      PM / devfreq: Fix typo in DFSO_DOWNDIFFERENTIAL macro name

Samuel Wu (2):
      PM: sleep: Add support for wakeup during filesystem sync
      PM: sleep: Call pm_sleep_fs_sync() instead of ksys_sync_helper()

Sergey Senozhatsky (1):
      PM: dpm_watchdog: add module param to backtrace all CPUs

Shuhao Fu (1):
      cpufreq: s5pv210: fix refcount leak

Srinivas Pandruvada (1):
      powercap: intel_rapl: Add support for Wildcat Lake platform

Sunday Adelodun (1):
      PM: hibernate: Clean up kernel-doc comment style usage

Swaraj Gaikwad (1):
      Documentation: intel_pstate: fix duplicate hyperlink target errors

Tamir Duberstein (2):
      rust: opp: fix broken rustdoc link
      rust: opp: simplify callers of `to_c_str_array`

Tejun Heo (1):
      freezer: Clarify that only cgroup1 freezer uses PM freezer

Thorsten Blum (2):
      cpufreq: Replace deprecated strcpy() in cpufreq_unregister_governor()
      PM / devfreq: tegra30: use min to simplify actmon_cpu_to_emc_rate

Ulf Hansson (6):
      PM: QoS: Introduce a CPU system wakeup QoS limit
      pmdomain: Respect the CPU system wakeup QoS limit for s2idle
      pmdomain: Respect the CPU system wakeup QoS limit for cpuidle
      sched: idle: Respect the CPU system wakeup QoS limit for s2idle
      cpuidle: Respect the CPU system wakeup QoS limit for cpuidle
      Documentation: power/cpuidle: Document the CPU system wakeup latency QoS

Viresh Kumar (1):
      OPP: Initialize scope-based pointers inline

Xueqin Luo (3):
      PM: hibernate: dynamically allocate crc->unc_len/unc for
configurable threads
      PM: hibernate: make compression threads configurable
      PM: hibernate: add sysfs interface for hibernate_compression_threads

Zihuan Zhang (1):
      cpufreq: preserve freq_table_sorted across suspend/hibernate

Zuo An (1):
      tools/power/cpupower: Support building libcpupower statically

---------------

 Documentation/ABI/testing/sysfs-power              |  16 ++
 Documentation/admin-guide/kernel-parameters.txt    |  10 +
 Documentation/admin-guide/pm/cpuidle.rst           |   9 +
 Documentation/admin-guide/pm/intel_pstate.rst      | 133 +++++----
 Documentation/netlink/specs/em.yaml                | 113 ++++++++
 Documentation/power/index.rst                      |   1 +
 Documentation/power/pm_qos_interface.rst           |   9 +-
 Documentation/power/runtime_pm.rst                 |  10 -
 Documentation/power/shutdown-debugging.rst         |  53 ++++
 MAINTAINERS                                        |   3 +
 drivers/acpi/acpi_tad.c                            |  73 ++---
 drivers/base/power/generic_ops.c                   |  85 ++----
 drivers/base/power/main.c                          |  15 +
 drivers/base/power/runtime.c                       |  23 +-
 drivers/base/power/trace.c                         |   4 +-
 drivers/base/power/wakeup.c                        |  24 +-
 drivers/cpufreq/acpi-cpufreq.c                     |   2 +-
 drivers/cpufreq/amd-pstate.c                       |  35 +--
 drivers/cpufreq/cppc_cpufreq.c                     |  17 +-
 drivers/cpufreq/cpufreq-dt-platdev.c               |   1 +
 drivers/cpufreq/cpufreq-nforce2.c                  |   3 +
 drivers/cpufreq/cpufreq.c                          |  11 +-
 drivers/cpufreq/intel_pstate.c                     | 227 +++++++--------
 drivers/cpufreq/qcom-cpufreq-nvmem.c               |  35 ++-
 drivers/cpufreq/s5pv210-cpufreq.c                  |   6 +-
 drivers/cpufreq/tegra186-cpufreq.c                 | 150 +++++++++-
 drivers/cpufreq/tegra194-cpufreq.c                 |   3 +-
 drivers/cpuidle/cpuidle.c                          |  12 +-
 drivers/cpuidle/driver.c                           |  10 +
 drivers/cpuidle/governor.c                         |   4 +
 drivers/cpuidle/governors/menu.c                   |   9 +-
 drivers/cpuidle/governors/teo.c                    | 159 +++++------
 drivers/cpuidle/poll_state.c                       |   4 +
 drivers/devfreq/devfreq.c                          |   2 +-
 drivers/devfreq/governor_passive.c                 |  27 +-
 drivers/devfreq/governor_performance.c             |   2 +-
 drivers/devfreq/governor_powersave.c               |   2 +-
 drivers/devfreq/governor_simpleondemand.c          |   6 +-
 drivers/devfreq/governor_userspace.c               |   2 +-
 drivers/devfreq/hisi_uncore_freq.c                 |   6 +-
 drivers/devfreq/tegra30-devfreq.c                  |  15 +-
 drivers/opp/core.c                                 |  69 ++---
 drivers/opp/cpu.c                                  |  16 +-
 drivers/opp/of.c                                   | 125 +++++----
 drivers/pci/pci-sysfs.c                            |   4 +-
 drivers/pmdomain/core.c                            |  10 +-
 drivers/pmdomain/governor.c                        |  33 ++-
 drivers/powercap/intel_rapl_common.c               |  39 +--
 drivers/powercap/intel_rapl_msr.c                  |  43 ++-
 drivers/powercap/intel_rapl_tpmi.c                 |   2 +-
 drivers/scsi/mesh.c                                |   1 +
 drivers/scsi/stex.c                                |   1 +
 .../intel/int340x_thermal/processor_thermal_rapl.c |   2 +-
 drivers/usb/host/sl811-hcd.c                       |   1 +
 include/linux/cpuidle.h                            |   6 +-
 .../governor.h => include/linux/devfreq-governor.h |  33 +--
 include/linux/energy_model.h                       |   4 +
 include/linux/freezer.h                            |  12 +-
 include/linux/intel_rapl.h                         |   2 +-
 include/linux/pm.h                                 |   8 +-
 include/linux/pm_domain.h                          |   1 +
 include/linux/pm_qos.h                             |   9 +
 include/linux/pm_runtime.h                         |  24 ++
 include/trace/events/power.h                       |   3 +-
 include/uapi/linux/energy_model.h                  |  62 +++++
 kernel/cgroup/legacy_freezer.c                     |   2 +-
 kernel/freezer.c                                   |   2 +-
 kernel/power/Kconfig                               |  11 +
 kernel/power/Makefile                              |   4 +-
 kernel/power/console.c                             |   8 +-
 kernel/power/em_netlink.c                          | 308 +++++++++++++++++++++
 kernel/power/em_netlink.h                          |  39 +++
 kernel/power/em_netlink_autogen.c                  |  48 ++++
 kernel/power/em_netlink_autogen.h                  |  23 ++
 kernel/power/energy_model.c                        |  90 +++++-
 kernel/power/hibernate.c                           |   6 +-
 kernel/power/main.c                                |  81 +++++-
 kernel/power/power.h                               |   1 +
 kernel/power/qos.c                                 | 106 +++++++
 kernel/power/snapshot.c                            |  13 +-
 kernel/power/suspend.c                             |  12 +-
 kernel/power/swap.c                                | 256 +++++++++--------
 kernel/power/user.c                                |   4 +-
 kernel/sched/idle.c                                |  12 +-
 rust/kernel/opp.rs                                 | 114 ++++----
 tools/power/cpupower/Makefile                      |  32 ++-
 86 files changed, 2166 insertions(+), 847 deletions(-)

