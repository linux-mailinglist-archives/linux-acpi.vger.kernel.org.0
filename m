Return-Path: <linux-acpi+bounces-20870-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JYTJnDxhGnR6wMAu9opvQ
	(envelope-from <linux-acpi+bounces-20870-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Feb 2026 20:37:20 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AF4F6E25
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Feb 2026 20:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6AE73006020
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Feb 2026 19:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAD8327C1C;
	Thu,  5 Feb 2026 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrSZaLCR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA632264AB
	for <linux-acpi@vger.kernel.org>; Thu,  5 Feb 2026 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770320234; cv=none; b=J4vAT6jVDn/cssIks93N7i3eysBcvF8lebf0hQ4biKNi3Be5IKYh7DW1/RGtphGKeBuuuBl+zwpnBg4j+Ixgjvfi7nnLJAY8xmGbtWu8LeWa9MMfRtPhFlQczIrHztZvJjJKm2q4SvAabVozLlEuayiHB9FySihicDsuJEWolYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770320234; c=relaxed/simple;
	bh=C35OIlauGBh1KgJmGUKWlvHv4nFK/Uc2SNhDIHEmCh0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZDoHbfeh5uc7meHF27sHMYFhZfhX5lHPcGBjucBt4ZwfDuUg2JvEFUzonk5gDn9YtWK981vrNQFroBz1QXp7RxtmDSbim0XWxHjDBzIo65JkOBvhK7N5Erxavi/SSzevTbR38l9+U8xcMflUScldynj/C4PPTMiAhQHWc3E/uTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrSZaLCR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA78C19421
	for <linux-acpi@vger.kernel.org>; Thu,  5 Feb 2026 19:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770320233;
	bh=C35OIlauGBh1KgJmGUKWlvHv4nFK/Uc2SNhDIHEmCh0=;
	h=From:Date:Subject:To:Cc:From;
	b=YrSZaLCRKvrWpMNWBRN8zixdUMVWIsymyizJMQdseGLMyYKoCt4D8lpDWexFU5WiY
	 HiLuTXYcfl/pwEAG7VNGGwpsABouolNa5OhShNe5D6voXh/SttxM2CbkKp43J4daiA
	 6vo/Rko5SkE8qcuIZF6ybRBrkkB/YnWW3LkjTDdGgwepjGJh2KIBYxHCM3UG7P6CQp
	 edFbnSsRfKIZeFYHQJJiWdMvTJRRRv2iNlc30+LjtnJ92pmqc3khoCK11sC572goHv
	 zdSE4TH+KxC2e9bQmpdiuAOuX4qrzGxqKqvQDSUii53/jEUmaaF+orxkJBmEWec8jI
	 lTSRO17EVp07g==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6611cab8ca3so817218eaf.3
        for <linux-acpi@vger.kernel.org>; Thu, 05 Feb 2026 11:37:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW0p2AN8y7UbD7aoalyX8yxouCHlTtehJmiycm+ob52VwZViAY/QBKOG6HMw8oE/i08wiKynBsGZOF+@vger.kernel.org
X-Gm-Message-State: AOJu0YwIK0fEZPD9+oYF9n+5S9Z6EzRd/H+U19ZebAiol9NBRdtsd0sE
	aCaDC2+XtCFQAWZm/UHoH8NtIU+q3MHih6S0zIrJEFo5xdKnCR9UQYBS/p7Glhx5wkMtusRViu+
	HN+uFxFzNG9mQpB83nSjyYwq/MsJdzQM=
X-Received: by 2002:a05:6820:490e:b0:65d:b36:bdd4 with SMTP id
 006d021491bc7-66d09cac7d5mr223330eaf.17.1770320232670; Thu, 05 Feb 2026
 11:37:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Feb 2026 20:37:01 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j8M0=M3hO3kJKRPA4Q99TgQODRxPoSu5RFe6qV4Cv_-w@mail.gmail.com>
X-Gm-Features: AZwV_QiTgoy5pvdE7LZ5lmGdrlD2MxEkcuh0ir0X8YpkAd947UtZfMjZD02i-oI
Message-ID: <CAJZ5v0j8M0=M3hO3kJKRPA4Q99TgQODRxPoSu5RFe6qV4Cv_-w@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v6.20-rc1/v7.0-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20870-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A9AF4F6E25
X-Rspamd-Action: no action

Hi Linus,

This goes a bit early, but it's ready.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.20-rc1

with top-most commit 0f64b6acb0e14559daf1de7be5dbcee3874512aa

 Merge branch 'pm-tools'

on top of commit 1730daa3b425ea8c88ae599af6e1a4957bd2d81a

 Merge tag 'cpufreq-arm-fixes-6.19-rc8' of
git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm

to receive power management updates for 6.20-rc1/7.0-rc1 (whichever it
turns out to be).

By the number of commits, cpufreq is the leading party (again) and the
most visible change there is the removal of the omap-cpufreq driver
that has not been used for a long time (good riddance).  There are also
quite a few changes in the cppc_cpufreq driver, mostly related to fixing
its frequency invariance engine in the case when the CPPC registers
used by it are not in PCC.  In addition to that, support for AM62L3 is
added to the ti-cpufreq driver and the cpufreq-dt-platdev list is
updated for some platforms.  The remaining cpufreq changes are assorted
fixes and cleanups.

Next up is cpuidle and the changes there are dominated by intel_idle
driver updates, mostly related to the new command line facility allowing
users to adjust the list of C-states used by the driver.  There are also
a few updates of cpuidle governors, including two menu governor fixes
and some refinements of the teo governor, and a MAINTAINERS update
adding Christian Loehle as a cpuidle reviewer.  [Thanks for stepping up
Christian!]

The most significant update related to system suspend and hibernation
is the one to stop freezing the PM runtime workqueue during system PM
transitions which allows some deadlocks to be avoided.  There is also
a fix for possible concurrent bit field updates in the core device
suspend code and a few other minor fixes.

Apart from the above, several drivers are updated to discard the return
value of pm_runtime_put() which is going to be converted to a void
function as soon as everybody stops using its return value, PL4 support
for Ice Lake is added to the Intel RAPL power capping driver, and there
are assorted cleanups, documentation fixes, and some cpupower utility
improvements.

Specifics:

 - Remove the unused omap-cpufreq driver (Andreas Kemnade)

 - Optimize error handling code in cpufreq_boost_trigger_state() and
   make cpufreq_boost_trigger_state() return -EOPNOTSUPP if no policy
   supports boost (Lifeng Zheng)

 - Update cpufreq-dt-platdev list for tegra, qcom, TI (Aaron Kling,
   Dhruva Gole, and Konrad Dybcio)

 - Minor improvements to the cpufreq and cpumask rust implementation
   (Alexandre Courbot, Alice Ryhl, Tamir Duberstein, and Yilin Chen)

 - Add support for AM62L3 SoC to the ti-cpufreq driver (Dhruva Gole)

 - Update arch_freq_scale in the CPPC cpufreq driver's frequency
   invariance engine (FIE) in scheduler ticks if the related CPPC
   registers are not in PCC (Jie Zhan)

 - Assorted minor cleanups and improvements in ARM cpufreq drivers (Juan
   Martinez, Felix Gu, Luca Weiss, and Sergey Shtylyov)

 - Add generic helpers for sysfs show/store to cppc_cpufreq (Sumit
   Gupta)

 - Make the scaling_setspeed cpufreq sysfs attribute return the actual
   requested frequency to avoid confusion (Pengjie Zhang)

 - Simplify the idle CPU time granularity test in the ondemand cpufreq
   governor (Frederic Weisbecker)

 - Enable asym capacity in intel_pstate only when CPU SMT is not
   possible (Yaxiong Tian)

 - Update the description of rate_limit_us default value in cpufreq
   documentation (Yaxiong Tian)

 - Add a command line option to adjust the C-states table in the
   intel_idle driver, remove the 'preferred_cstates' module parameter
   from it, add C-states validation to it and clean it up (Artem
   Bityutskiy)

 - Make the menu cpuidle governor always check the time till the closest
   timer event when the scheduler tick has been stopped to prevent it
   from mistakenly selecting the deepest available idle state (Rafael
   Wysocki)

 - Update the teo cpuidle governor to avoid making suboptimal decisions
   in certain corner cases and generally improve idle state selection
   accuracy (Rafael Wysocki)

 - Remove an unlikely() annotation on the early-return condition in
   menu_select() that leads to branch misprediction 100% of the time
   on systems with only 1 idle state enabled, like ARM64 servers (Breno
   Leitao)

 - Add Christian Loehle to MAINTAINERS as a cpuidle reviewer (Christian
   Loehle)

 - Stop flagging the PM runtime workqueue as freezable to avoid system
   suspend and resume deadlocks in subsystems that assume asynchronous
   runtime PM to work during system-wide PM transitions (Rafael Wysocki)

 - Drop redundant NULL pointer checks before acomp_request_free() from
   the hibernation code handling image saving (Rafael Wysocki)

 - Update wakeup_sources_walk_start() to handle empty lists of wakeup
   sources as appropriate (Samuel Wu)

 - Make dev_pm_clear_wake_irq() check the power.wakeirq value under
   power.lock to avoid race conditions (Gui-Dong Han)

 - Avoid bit field races related to power.work_in_progress in the core
   device suspend code (Xuewen Yan)

 - Make several drivers discard pm_runtime_put() return value in
   preparation for converting that function to a void one (Rafael
   Wysocki)

 - Add PL4 support for Ice Lake to the Intel RAPL power capping
   driver (Daniel Tang)

 - Replace sprintf() with sysfs_emit() in power capping sysfs show
   functions (Sumeet Pawnikar)

 - Make dev_pm_opp_get_level() return value match the documentation
   after a previous update of the latter (Aleks Todorov)

 - Use scoped for each OF child loop in the OPP code (Krzysztof
   Kozlowski)

 - Fix a bug in an example code snippet and correct typos in the energy
   model management documentation (Patrick Little)

 - Fix miscellaneous problems in cpupower (Kaushlendra Kumar):

   * idle_monitor: Fix incorrect value logged after stop
   * Fix inverted APERF capability check
   * Use strcspn() to strip trailing newline
   * Reset errno before strtoull()
   * Show C0 in idle-info dump

 - Improve cpupower installation procedure by making the systemd step
   optional and allowing users to disable the installation of systemd's
   unit file (Jo=C3=A3o Marcos Costa)

Thanks!


---------------

Aaron Kling (1):
      cpufreq: Add Tegra186 and Tegra194 to cpufreq-dt-platdev blocklist

Aleks Todorov (1):
      OPP: Return correct value in dev_pm_opp_get_level

Alexandre Courbot (1):
      rust: cpufreq: always inline functions using build_assert with argume=
nts

Alice Ryhl (1):
      rust: cpufreq: add __rust_helper to helpers

Andreas Kemnade (2):
      cpufreq: omap: remove driver
      MAINTAINERS: remove omap-cpufreq

Artem Bityutskiy (5):
      intel_idle: Remove unused driver version constant
      intel_idle: Remove the 'preferred_cstates' parameter
      intel_idle: Initialize sysfs after cpuidle driver initialization
      intel_idle: Add cmdline option to adjust C-states table
      intel_idle: Add C-states validation

Breno Leitao (1):
      cpuidle: menu: Remove incorrect unlikely() annotation

Christian Loehle (1):
      MAINTAINERS: Add myself as cpuidle reviewer

Daniel Tang (1):
      powercap: intel_rapl: Add PL4 support for Ice Lake

Dhruva Gole (2):
      cpufreq: dt-platdev: Add ti,am62l3 to blocklist
      cpufreq: ti-cpufreq: add support for AM62L3 SoC

Felix Gu (1):
      cpufreq: scmi: Fix device_node reference leak in scmi_cpu_domain_id()

Frederic Weisbecker (1):
      cpufreq: ondemand: Simplify idle cputime granularity test

Gui-Dong Han (1):
      PM: sleep: wakeirq: harden dev_pm_clear_wake_irq() against races

Jie Zhan (3):
      ACPI: CPPC: Factor out and export per-cpu cppc_perf_ctrs_in_pcc_cpu()
      cpufreq: CPPC: Factor out cppc_fie_kworker_init()
      cpufreq: CPPC: Update FIE arch_freq_scale in ticks for non-PCC regs

Jo=C3=A3o Marcos Costa (1):
      cpupower: make systemd unit installation optional

Juan Martinez (1):
      cpufreq/amd-pstate: Add comment explaining nominal_perf usage
for performance policy

Kaushlendra Kumar (5):
      cpupower: idle_monitor: fix incorrect value logged after stop
      tools/cpupower: Fix inverted APERF capability check
      tools/cpupower: Use strcspn() to strip trailing newline
      tools/power cpupower: Reset errno before strtoull()
      tools/power cpupower: Show C0 in idle-info dump

Konrad Dybcio (1):
      cpufreq: dt-platdev: Block the driver from probing on more QC platfor=
ms

Krzysztof Kozlowski (1):
      OPP: of: Simplify with scoped for each OF child loop

Lifeng Zheng (2):
      cpufreq: Return -EOPNOTSUPP if no policy supports boost
      cpufreq: cpufreq_boost_trigger_state() optimization

Luca Weiss (1):
      dt-bindings: cpufreq: qcom-hw: document Milos CPUFREQ Hardware

Patrick Little (2):
      Documentation: Fix typos in energy model documentation
      PM: EM: Documentation: Fix bug in example code snippet

Pengjie Zhang (1):
      cpufreq: userspace: make scaling_setspeed return the actual
requested frequency

Rafael J. Wysocki (19):
      PM: sleep: Do not flag runtime PM workqueue as freezable
      USB: core: Discard pm_runtime_put() return value
      drm/imagination: Discard pm_runtime_put() return value
      media: ccs: Discard pm_runtime_put() return value
      watchdog: rz: Discard pm_runtime_put() return values
      watchdog: rzv2h_wdt: Discard pm_runtime_put() return value
      hwspinlock: omap: Discard pm_runtime_put() return value
      coresight: Discard pm_runtime_put() return values
      platform/chrome: cros_hps_i2c: Discard pm_runtime_put() return value
      scsi: ufs: core: Discard pm_runtime_put() return values
      genirq/chip: Change irq_chip_pm_put() return type to void
      drm: Discard pm_runtime_put() return value
      cpuidle: governors: menu: Always check timers with tick stopped
      cpuidle: governors: teo: Avoid selecting states with zero-size bins
      cpuidle: governors: teo: Avoid fake intercepts produced by tick
      cpuidle: governors: teo: Refine tick_intercepts vs total events check
      PM: hibernate: Drop NULL pointer checks before acomp_request_free()
      cpuidle: governors: teo: Adjust the classification of wakeup events
      cpuidle: governors: teo: Refine intercepts-based idle state lookup

Samuel Wu (1):
      PM: wakeup: Handle empty list in wakeup_sources_walk_start()

Sergey Shtylyov (1):
      cpufreq: scmi: correct SCMI explanation

Sumeet Pawnikar (1):
      powercap: Replace sprintf() with sysfs_emit() in sysfs show functions

Sumit Gupta (1):
      cpufreq: CPPC: Add generic helpers for sysfs show/store

Tamir Duberstein (1):
      rust: cpufreq: replace `kernel::c_str!` with C-Strings

Xuewen Yan (1):
      PM: sleep: core: Avoid bit field races related to work_in_progress

Yaxiong Tian (2):
      cpufreq: intel_pstate: Enable asym capacity only when CPU SMT is
not possible
      cpufreq: Documentation: Update description of rate_limit_us default v=
alue

Yilin Chen (1):
      rust: cpumask: rename methods of Cpumask for clarity and consistency

---------------

 Documentation/admin-guide/pm/cpufreq.rst           |   2 +-
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          |   2 +
 Documentation/power/energy-model.rst               |  18 +-
 Documentation/power/runtime_pm.rst                 |   7 +-
 Documentation/scheduler/sched-energy.rst           |   8 +-
 MAINTAINERS                                        |   2 +-
 drivers/acpi/cppc_acpi.c                           |  48 ++--
 drivers/base/power/main.c                          |   7 +-
 drivers/base/power/wakeirq.c                       |   9 +-
 drivers/base/power/wakeup.c                        |   4 +-
 drivers/cpufreq/Kconfig.arm                        |   5 -
 drivers/cpufreq/Makefile                           |   1 -
 drivers/cpufreq/amd-pstate.c                       |  13 +
 drivers/cpufreq/cppc_cpufreq.c                     | 164 +++++++------
 drivers/cpufreq/cpufreq-dt-platdev.c               |   6 +
 drivers/cpufreq/cpufreq.c                          |  13 +-
 drivers/cpufreq/cpufreq_ondemand.c                 |   7 +-
 drivers/cpufreq/cpufreq_userspace.c                |   4 +-
 drivers/cpufreq/intel_pstate.c                     |   2 +-
 drivers/cpufreq/omap-cpufreq.c                     | 195 ---------------
 drivers/cpufreq/rcpufreq_dt.rs                     |   5 +-
 drivers/cpufreq/scmi-cpufreq.c                     |   3 +-
 drivers/cpufreq/ti-cpufreq.c                       |  34 ++-
 drivers/cpuidle/governors/menu.c                   |  24 +-
 drivers/cpuidle/governors/teo.c                    |  98 ++++++--
 drivers/gpu/drm/arm/malidp_crtc.c                  |   6 +-
 drivers/gpu/drm/bridge/imx/imx8qm-ldb.c            |   4 +-
 drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c           |   4 +-
 .../gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c    |   5 +-
 drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c       |   5 +-
 drivers/gpu/drm/imagination/pvr_power.h            |   4 +-
 drivers/gpu/drm/imx/dc/dc-crtc.c                   |  12 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |   5 +-
 drivers/gpu/drm/vc4/vc4_vec.c                      |  12 +-
 drivers/hwspinlock/omap_hwspinlock.c               |   4 +-
 drivers/hwtracing/coresight/coresight-cpu-debug.c  |  12 +-
 drivers/idle/intel_idle.c                          | 268 +++++++++++++++++=
----
 drivers/media/i2c/ccs/ccs-core.c                   |   4 +-
 drivers/opp/core.c                                 |   2 +-
 drivers/opp/of.c                                   |   4 +-
 drivers/platform/chrome/cros_hps_i2c.c             |   4 +-
 drivers/powercap/intel_rapl_msr.c                  |   1 +
 drivers/powercap/powercap_sys.c                    |  13 +-
 drivers/ufs/core/ufshcd-priv.h                     |   4 +-
 drivers/usb/core/driver.c                          |   8 +-
 drivers/watchdog/rzg2l_wdt.c                       |   4 +-
 drivers/watchdog/rzv2h_wdt.c                       |   8 +-
 include/acpi/cppc_acpi.h                           |   5 +
 include/linux/irq.h                                |   2 +-
 include/linux/pm.h                                 |   2 +-
 include/linux/tick.h                               |   2 +
 kernel/irq/chip.c                                  |  22 +-
 kernel/power/main.c                                |   2 +-
 kernel/power/swap.c                                |   8 +-
 kernel/time/hrtimer.c                              |   2 +-
 kernel/time/tick-internal.h                        |   2 -
 kernel/time/tick-sched.c                           |   8 +-
 kernel/time/timer.c                                |   2 +-
 rust/helpers/cpufreq.c                             |   3 +-
 rust/kernel/cpufreq.rs                             |   5 +-
 rust/kernel/cpumask.rs                             |  10 +-
 tools/power/cpupower/Makefile                      |  17 +-
 tools/power/cpupower/lib/cpuidle.c                 |   7 +-
 tools/power/cpupower/utils/cpufreq-info.c          |   2 +-
 tools/power/cpupower/utils/cpuidle-info.c          |   2 +-
 .../cpupower/utils/idle_monitor/cpuidle_sysfs.c    |   2 +-
 66 files changed, 633 insertions(+), 546 deletions(-)

