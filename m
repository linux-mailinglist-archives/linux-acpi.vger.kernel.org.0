Return-Path: <linux-acpi+bounces-13904-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE94FAC4444
	for <lists+linux-acpi@lfdr.de>; Mon, 26 May 2025 22:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 491FB7A27A4
	for <lists+linux-acpi@lfdr.de>; Mon, 26 May 2025 20:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9F323E354;
	Mon, 26 May 2025 20:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIdBF+fr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5983FE7;
	Mon, 26 May 2025 20:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748290340; cv=none; b=M1kam78gtZ4RrE275LlUG3X3Tc7+5oqf8YxGsMvaFZRZv3O2b+NaHaJ3iLdQdkxdCHfnLVztc8ygxze2fA87MGLxZnylbaZBQScaPeX2SHgvosTmwp/3aSPAAfQmIbqSIFUz4ktDJaJEH/xCXHY3wcgUIvm/80PZO0lnPKQAjAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748290340; c=relaxed/simple;
	bh=jh/tF4rtDx9TN6BskFp9fOGlfEIylMCbMK9zzx4Jnnc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=S/iojG2iT1w9iTRQIlJ3+PvH+g63NCmOJw56p20869JXZNHutG2QYerns5stoudCKlBHLxL6BaCx2C40yzl9NaM20fIsqqg7uDGpSz+/BdC9oi6VGbKtBD9BeRJMqJTVUF9gNGgV0OFItGVs7EoM+sANHF1GdQR0A4WFT6BryK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIdBF+fr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB14CC4CEE7;
	Mon, 26 May 2025 20:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748290339;
	bh=jh/tF4rtDx9TN6BskFp9fOGlfEIylMCbMK9zzx4Jnnc=;
	h=From:Date:Subject:To:Cc:From;
	b=HIdBF+frlQWBmIRuSrkL+a+y+8KAR7dojRJo9WdArgCj+RLwwfW44Dsur3nBG86Ev
	 kUkLqI65K4D17BmLOWJA5dOzpPLGrJ+mxsYiCO4Fqg5SUEfCzhmAhza4mFm26nDNBD
	 s2H9JBK9zY46row3lP0IUKwdGPXciMzqy4K+9d0S/kY9X3Wk9zAlGo5M8yKB9lGmRz
	 BwJreBlctWMGd//5DhxwiIhCXhqj8PTUpqfwS+wn1hfhiai3BbnHGD+AlR13PBCvtp
	 pIR2FR6e1VJgZrNJnhwVw3oiUErLsXCNM9C4fyTCV5C/kE2uZgLJm7s3pUV2EeUwrW
	 gcTdmPvb6bCkg==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-404da7584adso1051366b6e.3;
        Mon, 26 May 2025 13:12:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUb0s2Y5MX0Wsx2t/K7zShDzrYz0cTvQzLy6xM7JEdWqcKim9WCddNAP13NdVqiCt0uG8OygqOUD1gi@vger.kernel.org, AJvYcCXIq7hrkd0dazd8I+pmS/H15V79DPoPA93bQJMpdLibeWYa/K49ADWhy7frvdk/CKAf9bSa3oEgNeOrE4+3@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs7jJZVBN5Ex7Ok+yQLwJuomKFlf3KjPI6B6pd0PI9VNcf31es
	QW0Xbq03B+w+j7RimSljyl5tmLbwzOLOfn/EVfBlYCZ7jl7rThx8uAJNLBu3jED9zWIYYl1T5Tg
	wFDuTV/egz/zGCuK3lwLGxQg5Qo5aSOk=
X-Google-Smtp-Source: AGHT+IEwHBixHJeadRDoOmPkk8pwJuXktV/RpEPtbyJLCKvP4+sL2uh8P30O5tjagcs0piJZcWKDfz1Pl5NNLRZJYPE=
X-Received: by 2002:a05:6808:318f:b0:406:4ec6:2613 with SMTP id
 5614622812f47-4064ec62a50mr3808626b6e.19.1748290339098; Mon, 26 May 2025
 13:12:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 May 2025 22:12:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gK5=_HkTg-O7GOz-xUw27_484_AeoJHaz9vN0XRZvmqw@mail.gmail.com>
X-Gm-Features: AX0GCFvmXz6tFBEWzA30kzSLciOq5iaWrISE4xpQmRMo9b8rpcHbmILU13SpVr8
Message-ID: <CAJZ5v0gK5=_HkTg-O7GOz-xUw27_484_AeoJHaz9vN0XRZvmqw@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v6.16-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.16-rc1

with top-most commit 3e0c509fbdb106ba2d2fa13beafe58f4ba11e13d

 Merge branch 'pm-tools'

on top of commit a5806cd506af5a7c19bcd596e4708b5c464bfd21

 Linux 6.15-rc7

to receive power management updates for 6.16-rc1.

Once again, the changes are dominated by cpufreq updates, but this time
the majority of them are cpufreq core changes, mostly related to the
introduction of policy locking guards and __free() usage, and fixes
related to boost handling.  Still, there is also a significant update
of the intel_pstate driver making it register an energy model when
running on a hybrid platform which is used for enabling energy-aware
scheduling (EAS) if the driver operates in the passive mode (and
schedutil is used as the cpufreq governor for all CPUs which is the
passive mode default).  There are some amd-pstate driver updates too,
for a good measure, including the "Requested CPU Min frequency" BIOS
option support and new online/offline callbacks.

In the cpuidle space, the most significant change is the addition of
a C1 demotion on/off sysfs knob to intel_idle which should help some
users to configure their systems more precisely.  There is also the
conversion of the PSCI cpuidle driver to a faux device one and there
are two small updates of cpuidle governors.

Device power management is also modified quite a bit, especially the
handling of devices with asynchronous suspend and resume enabled during
system transitions.  They are now going to be handled more asynchronously
during suspend transitions and somewhat less aggressively during resume
transitions.

Apart from the above, the operating performance points (OPP) library
is now going to use mutex locking guards and scope-based cleanup
helpers and there is the usual bunch of assorted fixes and code
cleanups.

Specifics:

 - Fix potential division-by-zero error in em_compute_costs() (Yaxiong
   Tian).

 - Fix typos in energy model documentation and example driver code (Moon
   Hee Lee, Atul Kumar Pant).

 - Rearrange the energy model management code and add a new function for
   adjusting a CPU energy model after adjusting the capacity of the
   given CPU to it (Rafael Wysocki).

 - Refactor cpufreq_online(), add and use cpufreq policy locking guards,
   use __free() in policy reference counting, and clean up core cpufreq
   code on top of that (Rafael Wysocki).

 - Fix boost handling on CPU suspend/resume and sysfs updates (Viresh
   Kumar).

 - Fix des_perf clamping with max_perf in amd_pstate_update() (Dhananjay
   Ugwekar).

 - Add offline, online and suspend callbacks to the amd-pstate driver,
   rename and use the existing amd_pstate_epp callbacks in it (Dhananjay
   Ugwekar).

 - Add support for the "Requested CPU Min frequency" BIOS option to the
   amd-pstate driver (Dhananjay Ugwekar).

 - Reset amd-pstate driver mode after running selftests (Swapnil
   Sapkal).

 - Avoid shadowing ret in amd_pstate_ut_check_driver() (Nathan
   Chancellor).

 - Add helper for governor checks to the schedutil cpufreq governor and
   move cpufreq-specific EAS checks to cpufreq (Rafael Wysocki).

 - Populate the cpu_capacity sysfs entries from the intel_pstate driver
   after registering asym capacity support (Ricardo Neri).

 - Add support for enabling Energy-aware scheduling (EAS) to the
   intel_pstate driver when operating in the passive mode on a hybrid
   platform (Rafael Wysocki).

 - Drop redundant cpus_read_lock() from store_local_boost() in the
   cpufreq core (Seyediman Seyedarab).

 - Replace sscanf() with kstrtouint() in the cpufreq code and use a
   symbol instead of a raw number in it (Bowen Yu).

 - Add support for autonomous CPU performance state selection to the
   CPPC cpufreq driver (Lifeng Zheng).

 - OPP: Add dev_pm_opp_set_level() (Praveen Talari).

 - Introduce scope-based cleanup headers and mutex locking guards in OPP
   core (Viresh Kumar).

 - Switch OPP to use kmemdup_array() (Zhang Enpei).

 - Optimize bucket assignment when next_timer_ns equals KTIME_MAX in the
   menu cpuidle governor (Zhongqiu Han).

 - Convert the cpuidle PSCI driver to a faux device one (Sudeep Holla).

 - Add C1 demotion on/off sysfs knob to the intel_idle driver (Artem
   Bityutskiy).

 - Fix typos in two comments in the teo cpuidle governor (Atul Kumar
   Pant).

 - Fix denying of auto suspend in pm_suspend_timer_fn() (Charan Teja
   Kalla).

 - Move debug runtime PM attributes to runtime_attrs[] (Rafael Wysocki).

 - Add new devm_ functions for enabling runtime PM and runtime PM
   reference counting (Bence Cs=C3=B3k=C3=A1s).

 - Remove size arguments from strscpy() calls in the hibernation core
   code (Thorsten Blum).

 - Adjust the handling of devices with asynchronous suspend enabled
   during system suspend and resume to start resuming them immediately
   after resuming their parents and to start suspending such a device
   immediately after suspending its first child (Rafael Wysocki).

 - Adjust messages printed during tasks freezing to avoid using
   pr_cont() (Andrew Sayers, Paul Menzel).

 - Clean up unnecessary usage of !! in pm_print_times_init() (Zihuan
   Zhang).

 - Add missing wakeup source attribute relax_count to sysfs and
   remove the space character at the end ofi the string produced by
   pm_show_wakelocks() (Zijun Hu).

 - Add configurable pm_test delay for hibernation (Zihuan Zhang).

 - Disable asynchronous suspend in ucsi_ccg_probe() to prevent the
   cypd4226 device on Tegra boards from suspending prematurely (Jon
   Hunter).

 - Unbreak printing PM debug messages during hibernation and clean up
   some related code (Rafael Wysocki).

 - Add a systemd service to run cpupower and change cpupower binding's
   Makefile to use -lcpupower (John B. Wyatt IV, Francesco Poli).

Thanks!


---------------

Andrew Sayers (1):
      PM: sleep: Use two lines for "Restarting..." / "done" messages

Artem Bityutskiy (3):
      intel_idle: Add C1 demotion on/off sysfs knob
      Documentation: admin-guide: pm: Document intel_idle C1 demotion
      Documentation: ABI: testing: document the new cpuidle sysfs file

Atul Kumar Pant (2):
      cpuidle: teo: Fix typos in two comments
      PM: EM: Documentation: Fix typos in example driver code

Bence Cs=C3=B3k=C3=A1s (1):
      PM: runtime: Add new devm functions

Bowen Yu (2):
      cpufreq: Replace magic number
      cpufreq: Update sscanf() to kstrtouint()

Charan Teja Kalla (1):
      PM: runtime: fix denying of auto suspend in pm_suspend_timer_fn()

Dhananjay Ugwekar (3):
      cpufreq/amd-pstate: Move max_perf limiting in amd_pstate_update
      cpufreq/amd-pstate: Add offline, online and suspend callbacks
for amd_pstate_driver
      cpufreq/amd-pstate: Add support for the "Requested CPU Min
frequency" BIOS option

Francesco Poli (wintermute) (4):
      cpupower: add a systemd service to run cpupower
      cpupower: do not write DESTDIR to cpupower.service
      cpupower: do not call systemctl at install time
      cpupower: do not install files to /etc/default/

John B. Wyatt IV (1):
      cpupower: change binding's makefile to use -lcpupower

Jon Hunter (1):
      ucsi_ccg: Disable async suspend in ucsi_ccg_probe()

Lifeng Zheng (1):
      cpufreq: CPPC: Add support for autonomous selection

Moon Hee Lee (1):
      PM: EM: Documentation: fix typo in energy-model.rst

Nathan Chancellor (1):
      cpufreq/amd-pstate: Avoid shadowing ret in amd_pstate_ut_check_driver=
()

Paul Menzel (1):
      PM: freezer: Rewrite restarting tasks log to remove stray *done.*

Praveen Talari (1):
      OPP: Add dev_pm_opp_set_level()

Rafael J. Wysocki (25):
      cpufreq: Consolidate some code in cpufreq_online()
      cpufreq: Split cpufreq_online()
      cpufreq: Add and use cpufreq policy locking guards
      cpufreq: intel_pstate: Rearrange max frequency updates handling code
      cpufreq: Use locking guard and __free() in cpufreq_update_policy()
      cpufreq: Drop cpufreq_cpu_acquire() and cpufreq_cpu_release()
      cpufreq: Use __free() for policy reference counting cleanup
      cpufreq: Introduce cpufreq_policy_refresh()
      cpufreq: Pass policy pointer to ->update_limits()
      cpufreq: Drop unused cpufreq_get_policy()
      PM: sleep: Resume children after resuming the parent
      PM: sleep: Suspend async parents after suspending children
      PM: sleep: Make suspend of devices more asynchronous
      cpufreq/sched: schedutil: Add helper for governor checks
      cpufreq/sched: Move cpufreq-specific EAS checks to cpufreq
      PM: sysfs: Move debug runtime PM attributes to runtime_attrs[]
      PM: sleep: Print PM debug messages during hibernation
      PM: sleep: Introduce pm_suspend_in_progress()
      cpufreq: Drop policy locking from cpufreq_policy_is_good_for_eas()
      PM: EM: Move CPU capacity check to em_adjust_new_capacity()
      PM: EM: Introduce em_adjust_cpu_capacity()
      cpufreq: intel_pstate: EAS support for hybrid platforms
      cpufreq: intel_pstate: EAS: Increase cost for CPUs using L3 cache
      cpufreq: intel_pstate: Document hybrid processor support
      PM: sleep: Introduce pm_sleep_transition_in_progress()

Ricardo Neri (2):
      arch_topology: Relocate cpu_scale to topology.[h|c]
      cpufreq: intel_pstate: Populate the cpu_capacity sysfs entries

Seyediman Seyedarab (1):
      cpufreq: drop redundant cpus_read_lock() from store_local_boost()

Sudeep Holla (2):
      cpuidle: psci: Transition to the faux device interface
      cpuidle: psci: Avoid initializing faux device if no DT idle
states are present

Swapnil Sapkal (1):
      amd-pstate-ut: Reset amd-pstate driver mode after running selftests

Thorsten Blum (1):
      PM: hibernate: Remove size arguments when calling strscpy()

Viresh Kumar (10):
      OPP: Remove _get_opp_table_kref()
      OPP: Return opp from dev_pm_opp_get()
      OPP: Return opp_table from dev_pm_opp_get_opp_table_ref()
      OPP: Use scope-based OF cleanup helpers
      cpufreq: Don't unnecessarily call set_boost()
      cpufreq: Introduce policy_set_boost()
      cpufreq: Preserve policy's boost state after resume
      cpufreq: Force sync policy boost with global boost on sysfs update
      OPP: Define and use scope-based cleanup helpers
      OPP: Use mutex locking guards

Yaxiong Tian (1):
      PM: EM: Fix potential division-by-zero error in em_compute_costs()

Zhang Enpei (1):
      OPP: switch to use kmemdup_array()

Zhongqiu Han (1):
      cpuidle: menu: Optimize bucket assignment when next_timer_ns
equals KTIME_MAX

Zihuan Zhang (2):
      PM: sleep: Remove unnecessary !!
      PM: hibernate: add configurable delay for pm_test

Zijun Hu (2):
      PM: wakeup: Add missing wakeup source attribute relax_count
      PM: wakeup: Delete space in the end of string shown by pm_show_wakelo=
cks()

---------------

 Documentation/ABI/testing/sysfs-devices-system-cpu |  61 ++-
 Documentation/admin-guide/kernel-parameters.txt    |   7 +
 Documentation/admin-guide/pm/intel_idle.rst        |  21 +
 Documentation/admin-guide/pm/intel_pstate.rst      | 104 ++++-
 Documentation/power/energy-model.rst               |   8 +-
 arch/x86/pci/fixup.c                               |   4 +-
 drivers/base/arch_topology.c                       |  52 ---
 drivers/base/power/main.c                          | 216 ++++++++--
 drivers/base/power/runtime.c                       |  46 +-
 drivers/base/power/sysfs.c                         |  15 +-
 drivers/base/power/wakeup.c                        |   2 +-
 drivers/base/power/wakeup_stats.c                  |   2 +
 drivers/base/topology.c                            |  52 +++
 drivers/cpufreq/amd-pstate-ut.c                    |  21 +-
 drivers/cpufreq/amd-pstate.c                       | 120 ++++--
 drivers/cpufreq/amd-pstate.h                       |   3 +
 drivers/cpufreq/cppc_cpufreq.c                     | 109 +++++
 drivers/cpufreq/cpufreq.c                          | 463 ++++++++++-------=
----
 drivers/cpufreq/intel_pstate.c                     | 181 ++++++--
 drivers/cpuidle/cpuidle-psci.c                     |  43 +-
 drivers/cpuidle/governors/menu.c                   |   2 +-
 drivers/cpuidle/governors/teo.c                    |   4 +-
 drivers/gpu/drm/xe/xe_pm.c                         |   2 +-
 drivers/idle/intel_idle.c                          | 102 +++++
 drivers/opp/core.c                                 | 428 +++++++----------=
--
 drivers/opp/cpu.c                                  |  30 +-
 drivers/opp/of.c                                   | 205 ++++-----
 drivers/opp/opp.h                                  |   1 -
 drivers/usb/typec/ucsi/ucsi_ccg.c                  |   2 +
 include/linux/arch_topology.h                      |   8 -
 include/linux/cpufreq.h                            |  22 +-
 include/linux/energy_model.h                       |   2 +
 include/linux/pm_opp.h                             |  32 +-
 include/linux/pm_runtime.h                         |   4 +
 include/linux/suspend.h                            |   9 +
 include/linux/topology.h                           |   9 +
 kernel/power/energy_model.c                        |  72 ++--
 kernel/power/hibernate.c                           |  23 +-
 kernel/power/main.c                                |   8 +-
 kernel/power/power.h                               |   4 +
 kernel/power/process.c                             |   8 +-
 kernel/power/wakelock.c                            |   3 +
 kernel/sched/cpufreq_schedutil.c                   |   9 +-
 kernel/sched/sched.h                               |   2 -
 kernel/sched/topology.c                            |  25 +-
 tools/power/cpupower/Makefile                      |  13 +
 tools/power/cpupower/README                        |  28 ++
 tools/power/cpupower/bindings/python/Makefile      |   8 +-
 tools/power/cpupower/bindings/python/README        |  13 +-
 tools/power/cpupower/cpupower-service.conf         |  32 ++
 tools/power/cpupower/cpupower.service.in           |  16 +
 tools/power/cpupower/cpupower.sh                   |  26 ++
 tools/power/pm-graph/sleepgraph.py                 |   3 +-
 53 files changed, 1723 insertions(+), 962 deletions(-)

