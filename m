Return-Path: <linux-acpi+bounces-17416-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C77BA9B4E
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 16:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2076D1921E23
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 14:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22343090D2;
	Mon, 29 Sep 2025 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iah9okAv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1243016F8
	for <linux-acpi@vger.kernel.org>; Mon, 29 Sep 2025 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759157582; cv=none; b=sW1SKtjsO7CSNajLoSeDa9CKlheiPLXOuTQLplv8U690THrPgGIOMme4gqgzPY/6LQeodKrf3CWRexJj0FhyfmfAQ3k4ALOjrHQ6OP5h7RaNLOro/5Qi9WdatKy8kjKMOq/MWeN4yyBP6U+6kY1hH5sUhgVNLBeUjxApuXq97zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759157582; c=relaxed/simple;
	bh=IMJ+7NcspKCo2WneOhLe5l7ZSifIcueWPe1XVcAytBk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iIPC3CWM5OY5cv2RHibv/U4v5ZI8J8ZjUMLqcge7QN0kDqIk2zRd5C0Yit3IDeKlfgKbzfAAgs5KaUIjDO/ookKZx085cO8sL0nqHzuUif4gUiL8e1nN1BGdT6lLRbGRMaBV5ul6HElU5oiVbjxGJ2rdnRiXUSQXFm0RKKKdqQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iah9okAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E8BC19421
	for <linux-acpi@vger.kernel.org>; Mon, 29 Sep 2025 14:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759157582;
	bh=IMJ+7NcspKCo2WneOhLe5l7ZSifIcueWPe1XVcAytBk=;
	h=From:Date:Subject:To:Cc:From;
	b=Iah9okAv6wxlNXmJTBBZW/NDGoZ+GKLucAnsA5F+WFty92/9SwkJHeOYQHaiVGCaA
	 oE2a8wIBZvGCJGYI8+0c2i7wfHUHRHoElzX9WLSIL8JQBkogWUeCu1x4gjQaR8x1jX
	 CYSwM4uXB8eNsaWMznrbKLArn5BRPXM1KB9NUzpIMhAh011pWgKnjRPfKnjWaIwV9X
	 FZB4fDybgZw6WgYWJKlHkSc1Ap5I+nHo6Pgw/P7VHUABCsOuSq8CnEKpOmWjNBfotW
	 +aJpFIca/c1yEMS8i96DyEIYNJ+PT5YitdBbVR/Vfug4vaNRS4dkSCpyVa6KvtviHP
	 aU6IQePNDztjg==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-43f715fb44cso215385b6e.0
        for <linux-acpi@vger.kernel.org>; Mon, 29 Sep 2025 07:53:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLPm1B9YJZoT6CRaRbijMbvWqvqe2wGhh0smJa0pFbj11wdvHgiiNvERibJdB3vB+v7Yir2LRug+ef@vger.kernel.org
X-Gm-Message-State: AOJu0YzsCRRWOKXUavYaqWXYcvmxfPIroQ1JSI0lGhr2Y6Un+Kv4Dt9r
	YMAC4DeFAzB3lFf1ZujfykJhxxNQI5DYN7jVxMn3umaYV5WE4mxhLzLztJcMNXTkJcK4t662tkD
	iNcQpospTgQm0CNWkKNGeB8H/P2P4WfM=
X-Google-Smtp-Source: AGHT+IHVpPsqERtzJa/ZtWDzFfCQKAUxo+gFUDO0HTvWxM5Qj0n5sSGAm1tpYXlWl2UzOo5qZ7dfvE6ZepFKu5pSNRw=
X-Received: by 2002:a05:6808:f93:b0:439:b4fb:1d4f with SMTP id
 5614622812f47-43f4cc1f48amr5689573b6e.10.1759157581602; Mon, 29 Sep 2025
 07:53:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 29 Sep 2025 16:52:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jNZxcQ26TAPSGX43Psh0P8udTQmkOk+BrKdkS4RhUKmg@mail.gmail.com>
X-Gm-Features: AS18NWAb8fhmXwnxmx0TAaX-ffQ1EmtucMV_92y44Casy9QSSUOPfz6emfDrbTc
Message-ID: <CAJZ5v0jNZxcQ26TAPSGX43Psh0P8udTQmkOk+BrKdkS4RhUKmg@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v6.18-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	"Chanwoo Choi (samsung.com)" <chanwoo@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.18-rc1

with top-most commit 40d2cf9c3c1a5a1a9a443389d6b57a87362e4237

 Merge branch 'pm-tools'

on top of commit 4ea5af08590825c79ba2f146482ed54443e22c28

 Merge tag 'pm-6.17-rc8' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive power management updates for 6.18-rc1.

The majority of these are cpufreq changes, which has been a recurring
pattern for a few recent cycles.  Those changes include new hardware
support (AN7583 SoC support in the airoha cpufreq driver, ipq5424
support in the qcom-nvmem cpufreq driver, MT8196 support in the
mediatek cpufreq driver, AM62D2 support in the ti cpufreq driver),
DT bindings and Rust code updates, cleanups of the core and governors,
and multiple driver fixes and cleanups.

Beyond that, there are hibernation fixes (some remaining 6.16 cycle
fallout and an issue related to hybrid suspend in the amdgpu driver),
cleanups of the PM core code, runtime PM documentation update, cpuidle
and power capping cleanups, and tooling updates.

Specifics:

 - Rearrange variable declarations involving __free() in the cpufreq
   core and intel_pstate driver to follow common coding style (Rafael
   Wysocki)

 - Fix object lifecycle issue in update_qos_request(), rearrange
   freq QoS updates using __free(), and adjust frequency percentage
   computations in the intel_pstate driver (Rafael Wysocki)

 - Update intel_pstate to allow it to enable HWP without EPP if the
   new DEC (Dynamic Efficiency Control) HW feature is enabled (Rafael
   Wysocki)

 - Use on_each_cpu_mask() in drv_write() in the ACPI cpufreq driver
   to simplify the code (Rafael Wysocki)

 - Use likely() optimization in intel_pstate_sample() (Yaxiong Tian)

 - Remove dead EPB-related code from intel_pstate (Srinivas Pandruvada)

 - Use scope-based cleanup for cpufreq policy references in multiple
   cpufreq drivers (Zihuan Zhang)

 - Avoid calling get_governor() for the first policy in the cpufreq core
   to simplify the initial policy path (Zihuan Zhang)

 - Clean up the cpufreq core in multiple places (Zihuan Zhang)

 - Use int type to store negative error codes in the cpufreq core and
   update the speedstep-lib to use int for error codes (Qianfeng Rong)

 - Update the efficient idle check for Intel extended Families in the
   ondemand cpufreq governor (Sohil Mehta)

 - Replace sscanf() with kstrtouint() in the conservative cpufreq
   governor (Kaushlendra Kumar)

 - Rename CpumaskVar::as[_mut]_ref to from_raw[_mut] in the cpumask
   Rust code and mark CpumaskVar as transparent (Alice Ryhl, Baptiste
   Lepers)

 - Update ARef and AlwaysRefCounted imports from sync::aref in the OPP
   Rust code (Shankari Anand)

 - Add support for AN7583 SoC to the airoha cpufreq driver (Christian
   Marangi)

 - Enable cpufreq for ipq5424 in the qcom-nvmem cpufreq driver (Md Sadre
   Alam)

 - Add support for MT8196 to the mediatek-hw cpufreq driver, refactor
   that driver and add mediatek,mt8196-cpufreq-hw DT binding (Nicolas
   Frattaroli)

 - Avoid redundant conditions in the mediatek cpufreq driver (Liao
   Yuanhong)

 - Add support for AM62D2 to the ti cpufreq driver and blocklist
   ti,am62d2 SoC in dt-platdev (Paresh Bhagat)

 - Support more speed grades on AM62Px SoC in the ti cpufreq driver,
   allow all silicon revisions to support OPPs in it, and fix supported
   hardware for 1GHz OPP (Judith Mendez)

 - Add QCS615 compatible to DT bindings for cpufreq-qcom-hw (Taniya Das)

 - Minor assorted updates of the scmi, longhaul, CPPC, and armada-37xx
   cpufreq drivers (Akhilesh Patil, BowenYu, Dennis Beier, and Florian
   Fainelli)

 - Remove outdated cpufreq-dt.txt (Frank Li)

 - Fix python gnuplot package names in the amd_pstate_tracer utility
   (Kuan-Wei Chiu)

 - Saravana Kannan will maintain the virtual-cpufreq driver (Saravana
   Kannan)

 - Prevent CPU capacity updates after registering a perf domain from
   failing on a first CPU that is not present (Christian Loehle)

 - Add support for the cases in which frequency alone is not sufficient
   to uniquely identify an OPP (Krishna Chaitanya Chundru)

 - Use to_result() for OPP error handling in Rust (Onur =C3=96zkan)

 - Add support for LPDDR5 on Rockhip RK3588 SoC to rockchip-dfi devfreq
   driver (Nicolas Frattaroli)

 - Fix an issue where DDR cycle counts on RK3588/RK3528 with LPDDR4(X)
   are reported as half by adding a cycle multiplier to the DFI driver
   in rockchip-dfi devfreq-event driver (Nicolas Frattaroli)

 - Fix missing error pointer dereference check of regulator instance in
   the mtk-cci devfreq driver probe and remove a redundant condition from
   an if () statement in that driver (Dan Carpenter, Liao Yuanhong)

 - Fail cpuidle device registration if there is one already to avoid
   sysfs-related issues (Rafael Wysocki)

 - Use sysfs_emit()/sysfs_emit_at() instead of sprintf()/scnprintf() in
   cpuidle (Vivek Yadav)

 - Fix device and OF node leaks at probe in the qcom-spm cpuidle driver
   and drop unnecessary initialisations from it (Johan Hovold)

 - Remove unnecessary address-of operators from the intel_idle cpuidle
   driver (Kaushlendra Kumar)

 - Rearrange main loop in menu_select() to make the code in that function
   easier to follow (Rafael Wysocki)

 - Convert values in microseconds to ktime using us_to_ktime() where
   applicable in the intel_idle power capping driver (Xichao Zhao)

 - Annotate loops walking device links in the power management core
   code as _srcu and add macros for walking device links to reduce the
   likelihood of coding mistakes related to them (Rafael Wysocki)

 - Document time units for *_time functions in the runtime PM API (Brian
   Norris)

 - Clear power.must_resume in noirq suspend error path to avoid resuming
   a dependant device under a suspended parent or supplier (Rafael
   Wysocki)

 - Fix GFP mask handling during hybrid suspend and make the amdgpu
   driver handle hybrid suspend correctly (Mario Limonciello, Rafael
   Wysocki)

 - Fix GFP mask handling after aborted hibernation in platform mode and
   combine exit paths in power_down() to avoid code duplication (Rafael
   Wysocki)

 - Use vmalloc_array() and vcalloc() in the hibernation core to avoid
   open-coded size computations (Qianfeng Rong)

 - Fix typo in hibernation core code comment (Li Jun)

 - Call pm_wakeup_clear() in the same place where other functions that do
   bookkeeping prior to suspend_prepare() are called (Samuel Wu)

 - Fix and clean up the x86_energy_perf_policy utility and update its
   documentation (Len Brown, Kaushlendra Kumar)

 - Fix incorrect sorting of PMT telemetry in turbostat (Kaushlendra
   Kumar)

 - Fix incorrect size in cpuidle_state_disable() and the error return
   value of cpupower_write_sysfs() in cpupower (Kaushlendra Kumar)

Thanks!


---------------

Akhilesh Patil (1):
      cpufreq: armada-37xx: use max() to calculate target_vm

Alice Ryhl (1):
      rust: cpumask: rename CpumaskVar::as[_mut]_ref to from_raw[_mut]

Baptiste Lepers (1):
      rust: cpumask: Mark CpumaskVar as transparent

BowenYu (1):
      cpufreq: Remove unused parameter in cppc_perf_from_fbctrs()

Brian Norris (1):
      PM: runtime: Documentation: ABI: Document time units for *_time

Christian Loehle (1):
      PM: EM: Fix late boot with holes in CPU topology

Christian Marangi (1):
      cpufreq: airoha: Add support for AN7583 SoC

Dan Carpenter (1):
      PM / devfreq: mtk-cci: Fix potential error pointer dereference in pro=
be()

Dennis Beier (1):
      cpufreq/longhaul: handle NULL policy in longhaul_exit

Florian Fainelli (1):
      cpufreq: scmi: Account for malformed DT in scmi_dev_used_by_cpus()

Frank Li (1):
      dt-bindings: Remove outdated cpufreq-dt.txt

Johan Hovold (2):
      cpuidle: qcom-spm: fix device and OF node leaks at probe
      cpuidle: qcom-spm: drop unnecessary initialisations

Judith Mendez (3):
      cpufreq: ti: Support more speed grades on AM62Px SoC
      cpufreq: ti: Allow all silicon revisions to support OPPs
      arm64: dts: ti: k3-am62p: Fix supported hardware for 1GHz OPP

Kaushlendra Kumar (6):
      intel_idle: Remove unnecessary address-of operators
      cpufreq: conservative: Replace sscanf() with kstrtouint()
      tools/cpupower: fix error return value in cpupower_write_sysfs()
      tools/cpupower: Fix incorrect size in cpuidle_state_disable()
      tools/power turbostat: Fix incorrect sorting of PMT telemetry
      tools/power x86_energy_perf_policy: Fix incorrect fopen mode usage

Krishna Chaitanya Chundru (1):
      OPP: Add support to find OPP for a set of keys

Kuan-Wei Chiu (1):
      tools/power/x86/amd_pstate_tracer: Fix python gnuplot package names

Len Brown (7):
      tools/power x86_energy_perf_policy: Enhance HWP enabled check
      tools/power x86_energy_perf_policy: Enhance HWP enable
      tools/power x86_energy_perf_policy: Prepare for MSR/sysfs refactoring
      tools/power x86_energy_perf_policy: EPB access is only via sysfs
      tools/power x86_energy_perf_policy: Prefer driver HWP limits
      tools/power x86_energy_perf_policy: Add make snapshot target
      tools/power x86_energy_perf_policy.8: Emphasize preference for
SW interfaces

Li Jun (1):
      PM: hibernate: Fix typo in memory bitmaps description comment

Liao Yuanhong (2):
      cpufreq: mediatek: avoid redundant conditions
      PM / devfreq: mtk-cci: avoid redundant conditions

Mario Limonciello (AMD) (3):
      PM: hibernate: Fix hybrid-sleep
      PM: hibernate: Add pm_hibernation_mode_is_suspend()
      drm/amd: Fix hybrid sleep

Md Sadre Alam (1):
      cpufreq: qcom-nvmem: Enable cpufreq for ipq5424

Nicolas Frattaroli (7):
      dt-bindings: cpufreq: Add mediatek,mt8196-cpufreq-hw binding
      cpufreq: mediatek-hw: Refactor match data into struct
      cpufreq: mediatek-hw: Separate per-domain and per-instance data
      cpufreq: mediatek-hw: Add support for MT8196
      cpufreq: mediatek-hw: don't use error path on NULL fdvfs
      PM / devfreq: rockchip-dfi: double count on RK3588
      PM / devfreq: rockchip-dfi: add support for LPDDR5

Onur =C3=96zkan (1):
      rust: opp: use to_result for error handling

Paresh Bhagat (2):
      cpufreq: dt-platdev: Blacklist ti,am62d2 SoC
      cpufreq: ti: Add support for AM62D2

Qianfeng Rong (3):
      PM: hibernate: Use vmalloc_array() and vcalloc() to improve code
      cpufreq: Use int type to store negative error codes
      cpufreq: speedstep-lib: Use int type to store negative error codes

Rafael J. Wysocki (15):
      cpuidle: governors: menu: Rearrange main loop in menu_select()
      PM: sleep: core: Clear power.must_resume in noirq suspend error path
      cpufreq: core: Rearrange variable declarations involving __free()
      cpufreq: intel_pstate: Rearrange variable declaration involving __fre=
e()
      PM: core: Annotate loops walking device links as _srcu
      PM: core: Add two macros for walking device links
      cpufreq: intel_pstate: Fix object lifecycle issue in update_qos_reque=
st()
      cpufreq: intel_pstate: Rearrange freq QoS updates using __free()
      cpufreq: intel_pstate: Adjust frequency percentage computations
      cpufreq: ACPI: Use on_each_cpu_mask() in drv_write()
      cpufreq: intel_pstate: Enable HWP without EPP if DEC is enabled
      cpuidle: Fail cpuidle device registration if there is one already
      PM: hibernate: Fix pm_hibernation_mode_is_suspend() build breakage
      PM: hibernate: Restrict GFP mask in power_down()
      PM: hibernate: Combine return paths in power_down()

Samuel Wu (1):
      PM: sleep: Make pm_wakeup_clear() call more clear

Saravana Kannan (1):
      MAINTAINERS: Add myself as virtual-cpufreq maintainer

Shankari Anand (1):
      rust: opp: update ARef and AlwaysRefCounted imports from sync::aref

Sohil Mehta (1):
      cpufreq: ondemand: Update the efficient idle check for Intel
extended Families

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Remove EPB-related code

Taniya Das (1):
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add QCS615 compatible

Vivek Yadav (1):
      cpuidle: sysfs: Use sysfs_emit()/sysfs_emit_at() instead of
sprintf()/scnprintf()

Xichao Zhao (1):
      powercap: idle_inject: use us_to_ktime() where appropriate

Yaxiong Tian (1):
      cpufreq: intel_pstate: Use likely() optimization in intel_pstate_samp=
le()

Zihuan Zhang (11):
      cpufreq: Avoid calling get_governor() for first policy
      cpufreq: use strlen() for governor name comparison
      cpufreq: simplify setpolicy/target check in driver verification
      cpufreq: brcmstb-avs: Use scope-based cleanup helper
      cpufreq: CPPC: Use scope-based cleanup helper
      cpufreq: s5pv210: Use scope-based cleanup helper
      cpufreq: mediatek: Use scope-based cleanup helper
      cpufreq: tegra186: Use scope-based cleanup helper
      cpufreq: Drop redundant freq_table parameter
      cpufreq: Add defensive check during driver registration
      cpufreq: Replace pointer subtraction with iteration macro

---------------

 Documentation/ABI/testing/sysfs-devices-power      |   8 +-
 .../devicetree/bindings/cpufreq/cpufreq-dt.txt     |  61 -----
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          |   2 +
 .../cpufreq/mediatek,mt8196-cpufreq-hw.yaml        |  82 +++++++
 MAINTAINERS                                        |   6 +
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi              |   2 +-
 drivers/base/base.h                                |   8 +
 drivers/base/power/main.c                          |  32 ++-
 drivers/base/power/runtime.c                       |   3 +-
 drivers/cpufreq/acpi-cpufreq.c                     |   9 +-
 drivers/cpufreq/airoha-cpufreq.c                   |   1 +
 drivers/cpufreq/armada-37xx-cpufreq.c              |   4 +-
 drivers/cpufreq/brcmstb-avs-cpufreq.c              |   4 +-
 drivers/cpufreq/cppc_cpufreq.c                     |  16 +-
 drivers/cpufreq/cpufreq-dt-platdev.c               |   3 +
 drivers/cpufreq/cpufreq.c                          |  44 ++--
 drivers/cpufreq/cpufreq_conservative.c             |  24 +-
 drivers/cpufreq/cpufreq_ondemand.c                 |  25 +-
 drivers/cpufreq/cpufreq_ondemand.h                 |  23 ++
 drivers/cpufreq/freq_table.c                       |  22 +-
 drivers/cpufreq/intel_pstate.c                     | 182 +++++++--------
 drivers/cpufreq/longhaul.c                         |   3 +
 drivers/cpufreq/mediatek-cpufreq-hw.c              | 134 +++++++++--
 drivers/cpufreq/mediatek-cpufreq.c                 |  11 +-
 drivers/cpufreq/qcom-cpufreq-nvmem.c               |   5 +
 drivers/cpufreq/s5pv210-cpufreq.c                  |   4 +-
 drivers/cpufreq/scmi-cpufreq.c                     |  10 +
 drivers/cpufreq/sh-cpufreq.c                       |   6 +-
 drivers/cpufreq/speedstep-lib.c                    |  12 +-
 drivers/cpufreq/speedstep-lib.h                    |  10 +-
 drivers/cpufreq/tegra186-cpufreq.c                 |   4 +-
 drivers/cpufreq/ti-cpufreq.c                       |  12 +-
 drivers/cpufreq/virtual-cpufreq.c                  |   2 +-
 drivers/cpuidle/cpuidle-qcom-spm.c                 |  11 +-
 drivers/cpuidle/cpuidle.c                          |   8 +-
 drivers/cpuidle/governors/menu.c                   |  70 +++---
 drivers/cpuidle/sysfs.c                            |  34 +--
 drivers/devfreq/event/rockchip-dfi.c               |  91 ++++++--
 drivers/devfreq/mtk-cci-devfreq.c                  |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   2 +-
 drivers/idle/intel_idle.c                          | 256 ++++++++++-------=
----
 drivers/opp/core.c                                 |  99 ++++++++
 drivers/powercap/idle_inject.c                     |   5 +-
 include/linux/cpufreq.h                            |   7 +-
 include/linux/pm_opp.h                             |  30 +++
 include/linux/suspend.h                            |   6 +
 include/soc/rockchip/rk3588_grf.h                  |   8 +-
 include/soc/rockchip/rockchip_grf.h                |   1 +
 kernel/power/energy_model.c                        |  11 +-
 kernel/power/hibernate.c                           |  39 ++--
 kernel/power/process.c                             |   1 -
 kernel/power/snapshot.c                            |   2 +-
 kernel/power/suspend.c                             |   1 +
 kernel/power/swap.c                                |   6 +-
 rust/kernel/cpufreq.rs                             |   2 +-
 rust/kernel/cpumask.rs                             |   5 +-
 rust/kernel/opp.rs                                 |  29 +--
 tools/power/cpupower/lib/cpuidle.c                 |   5 +-
 tools/power/cpupower/lib/cpupower.c                |   2 +-
 .../x86/amd_pstate_tracer/amd_pstate_trace.py      |   2 +-
 tools/power/x86/turbostat/turbostat.c              |   2 +-
 tools/power/x86/x86_energy_perf_policy/Makefile    |  29 ++-
 .../x86_energy_perf_policy.8                       |  15 +-
 .../x86_energy_perf_policy.c                       | 133 +++++++----
 64 files changed, 1050 insertions(+), 641 deletions(-)

