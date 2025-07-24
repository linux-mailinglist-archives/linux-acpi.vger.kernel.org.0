Return-Path: <linux-acpi+bounces-15308-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C16B10A4A
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Jul 2025 14:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9423A4942
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Jul 2025 12:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AAC2D1901;
	Thu, 24 Jul 2025 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qveIGIp7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A972D12EB;
	Thu, 24 Jul 2025 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753360508; cv=none; b=Ru1uJAXtLrnzY5nU3cXjPUpfzYUJN6cbAjPT2084EwqFQ8lyemr0Y27NNKdswRnekEnTAOZvll0DG+RVTFFwVVHh9WdZ9Pqa8JVFWVb07gs2+n7XaFAgbeK/Og8m0Txyp8BDOjpwNPu2EqP9Z4W1RI/NdsBRLpXvKhVs24ueNQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753360508; c=relaxed/simple;
	bh=z9qTDkmexw9CL4omG17ZERfW8qSWMjksf56EVOHN6fc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bsZGMtMatVMBTseRw3J7hBQIdgbZd6LES9AqZZtQOLNdJzVBMRnJ3uiCNFGV+f8oAjlxM/L7Rbn8nmR0D0bOZTV1XSP/AWQvl6zJUCcpW2y3P0l62Thq07xNgd0E3RJD5xZp/Ckrel1BGejfWk2BbTKbNxn0t4qZmbP23sQsHYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qveIGIp7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE515C4CEF7;
	Thu, 24 Jul 2025 12:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753360507;
	bh=z9qTDkmexw9CL4omG17ZERfW8qSWMjksf56EVOHN6fc=;
	h=From:Date:Subject:To:Cc:From;
	b=qveIGIp7fevyePiqFKs6KEAGzFNxaVFIktBkPo5vBDLn4ROIJyBS7Y7mwKWzF1Fri
	 49xJblSZqgjyURhzF/l/RfLMLpmjf60JYR4Khla5HARKIR9g4ki7fxtZWPtKJJWGrZ
	 +QmlT2VvnqV+lLHxIoeub5tC1wkqc5L+nkm907RecYmMxsiWRF+7xJSqSxggj9sqnY
	 8vLsQP/8UMQ4ab7Y6+DzOGprgTtoZCirzh/124SLSMvWBXJySMLyFfjKjAtcI9rIiC
	 uaBbMQcA05Ppt8UkvEVsfMWbDIfsfvo6a1nBNvdy5zcVQzik9cAigZhVDvMpAYo3M+
	 8pELFHc6jbibg==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-615a4b50215so25998eaf.1;
        Thu, 24 Jul 2025 05:35:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXxnxF9QkCO+QyrDv1LQxx1mZhohqyTaSyzZ78zwYIchuo6FecgUbI4Aj78sbErS8ntojSt4XXBPHI@vger.kernel.org, AJvYcCXdXMwt/d/UaevURHZQjzxXPToKJWj3mj3pD935XBtwjECMUt3pACN6A+OU2FXw92ec0oINVLoW5R5Np+eb@vger.kernel.org
X-Gm-Message-State: AOJu0YxrQH99SeT1nMFdysfJPSb42ZVcx6u3coknWHidctJs6FruQAWn
	fFduH8oAPQ94ADfSEEk0GCkvh11v8kk+9syacibjQgAX4UHnEjrKn3nWV7jsdd24d6DAOuWjSv6
	SJGJspYqeHHggqdxyhVVQfTfRKKuE/Kg=
X-Google-Smtp-Source: AGHT+IG3QehhTqHfl/UjErYL896J4JvJCCUoSsHQbMU5WpRk04NVVjNdcrsuBzIDn7aP8gjlkQH05LxcDolkZibF8/c=
X-Received: by 2002:a05:6820:997:b0:615:a212:2db0 with SMTP id
 006d021491bc7-61888a1400cmr5563687eaf.7.1753360507065; Thu, 24 Jul 2025
 05:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 24 Jul 2025 14:34:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jRGpZP4DDNVq0+27BmxhahpOHX-kZKGWxwrWy-JwQjHA@mail.gmail.com>
X-Gm-Features: Ac12FXxut8QWz1hFs-nCj-Q9ZhNUY09aJMCo29hIr0R1AuA6arGRvajcqwDBzLk
Message-ID: <CAJZ5v0jRGpZP4DDNVq0+27BmxhahpOHX-kZKGWxwrWy-JwQjHA@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v6.17-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, 
	"Chanwoo Choi (samsung.com)" <chanwoo@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

I'm sending this early because I will be mostly offline next week
and I'm not planning to add anything to it.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.17-rc1

with top-most commit 40c28199550d5cdace4583bfe723a7636b170a90

 Merge branches 'pm-misc' and 'pm-tools'

on top of commit ebd6884167eac94bae9f92793fcd84069d9e4415

 PM: sleep: Update power.completion for all devices on errors

to receive power management updates for 6.17-rc1.

Traditionally, cpufreq is the part with the largest number of updates
that include core fixes and cleanups as well as updates of several
assorted drivers, but there are also quite a few updates related
to system sleep, mostly focused on asynchronous suspend and resume of
devices and on making the integration of system suspend and resume with
runtime PM easier.

Runtime PM is also updated to allow some code duplication in drivers
to be eliminated going forward and to work more consistently overall
in some cases.

Apart from that, there are some driver core updates related to PM
domains that should help to address ordering issues with devm_ cleanup
routines relying on PM domains, some assorted devfreq updates including
core fixes and cleanups, tooling updates, and documentation and
MAINTAINERS updates.

Specifics:

 - Fix two initialization ordering issues in the cpufreq core and a
   governor initialization error path in it, and clean it up (Lifeng
   Zheng)

 - Add Granite Rapids support in no-HWP mode to the intel_pstate cpufreq
   driver (Li RongQing)

 - Make intel_pstate always use HWP_DESIRED_PERF when operating in the
   passive mode (Rafael Wysocki)

 - Allow building the tegra124 cpufreq driver as a module (Aaron Kling)

 - Do minor cleanups for Rust cpufreq and cpumask APIs and fix MAINTAINERS
   entry for cpu.rs (Abhinav Ananthu, Ritvik Gupta, Lukas Bulwahn)

 - Clean up assorted cpufreq drivers (Arnd Bergmann, Dan Carpenter,
   Krzysztof Kozlowski, Sven Peter, Svyatoslav Ryhel, Lifeng Zheng)

 - Add the NEED_UPDATE_LIMITS flag to the CPPC cpufreq driver (Prashant
   Malani)

 - Fix minimum performance state label error in the amd-pstate driver
   documentation (Shouye Liu)

 - Add the CPUFREQ_GOV_STRICT_TARGET flag to the userspace cpufreq
   governor and explain HW coordination influence on it in the
   documentation (Shashank Balaji)

 - Fix opencoded for_each_cpu() in idle_state_valid() in the DT cpuidle
   driver (Yury Norov)

 - Remove info about non-existing QoS interfaces from the PM QoS
   documentation (Ulf Hansson)

 - Use c_* types via kernel prelude in Rust for OPP (Abhinav Ananthu)

 - Add HiSilicon uncore frequency scaling driver to devfreq (Jie Zhan)

 - Allow devfreq drivers to add custom sysfs ABIs (Jie Zhan)

 - Simplify the sun8i-a33-mbus devfreq driver by using more devm
   functions (Uwe Kleine-K=C3=B6nig)

 - Fix an index typo in trans_stat() in devfreq (Chanwoo Choi)

 - Check devfreq governor before using governor->name (Lifeng Zheng)

 - Remove a redundant devfreq_get_freq_range() call from
   devfreq_add_device() (Lifeng Zheng)

 - Limit max_freq with scaling_min_freq in devfreq (Lifeng Zheng)

 - Replace sscanf() with kstrtoul() in set_freq_store() (Lifeng Zheng)

 - Extend the asynchronous suspend and resume of devices to handle
   suppliers like parents and consumers like children (Rafael Wysocki)

 - Make pm_runtime_force_resume() work for drivers that set the
   DPM_FLAG_SMART_SUSPEND flag and allow PCI drivers and drivers that
   collaborate with the general ACPI PM domain to set it (Rafael
   Wysocki)

 - Add kernel parameter to disable asynchronous suspend/resume of
   devices (Tudor Ambarus)

 - Drop redundant might_sleep() calls from some functions in the device
   suspend/resume core code (Zhongqiu Han)

 - Fix the handling of monitors connected right before waking up the
   system from sleep (tuhaowen)

 - Clean up MAINTAINERS entries for suspend and hibernation (Rafael
   Wysocki)

 - Fix error code path in the KEXEC_JUMP flow and drop a redundant
   pm_restore_gfp_mask() call from it (Rafael Wysocki)

 - Rearrange suspend/resume error handling in the core device suspend
   and resume code (Rafael Wysocki)

 - Fix up white space that does not follow coding style in the
   hibernation core code (Darshan Rathod)

 - Document return values of suspend-related API functions in the
   runtime PM framework (Sakari Ailus)

 - Mark last busy stamp in multiple autosuspend-related functions in the
   runtime PM framework and update its documentation (Sakari Ailus)

 - Take active children into account in pm_runtime_get_if_in_use() for
   consistency (Rafael Wysocki)

 - Fix NULL pointer dereference in get_pd_power_uw() in the dtpm_cpu
   power capping driver (Sivan Zohar-Kotzer)

 - Add support for the Bartlett Lake platform to the Intel RAPL power
   capping driver (Qiao Wei)

 - Add PL4 support for Panther Lake to the intel_rapl_msr power capping
   driver (Zhang Rui)

 - Update contact information in the PM ABI docs and maintainer
   information in the power domains DT binding (Rafael Wysocki)

 - Update PM header inclusions to follow the IWYU (Include What You Use)
   principle (Andy Shevchenko)

 - Add flags to specify power on attach/detach for PM domains, make the
   driver core detach PM domains in device_unbind_cleanup(), and drop
   the dev_pm_domain_detach() call from the platform bus type (Claudiu
   Beznea)

 - Improve Python binding's Makefile for cpupower (John B. Wyatt IV)

 - Fix printing of CORE, CPU fields in cpupower-monitor (Gautham Shenoy)

Thanks!


---------------

Aaron Kling (3):
      cpufreq: Export disable_cpufreq()
      cpufreq: dt: Add register helper
      cpufreq: tegra124: Allow building as a module

Abhinav Ananthu (3):
      rust: cpufreq: Ensure C ABI compatibility in all unsafe
      rust: cpufreq: use c_ types from kernel prelude
      rust: opp: use c_* types via kernel prelude

Andy Shevchenko (1):
      PM: Don't use "proxy" headers

Arnd Bergmann (1):
      cpufreq: armada-8k: make both cpu masks static

Chanwoo Choi (1):
      PM / devfreq: Fix a index typo in trans_stat

Claudiu Beznea (3):
      PM: domains: Add flags to specify power on attach/detach
      PM: domains: Detach on device_unbind_cleanup()
      driver core: platform: Drop dev_pm_domain_detach() call

Dan Carpenter (1):
      cpufreq: armada-8k: Fix off by one in armada_8k_cpufreq_free_table()

Darshan Rathod (1):
      PM: hibernate: Fix up white space that does not follow coding style

Gautham R. Shenoy (2):
      pm: cpupower: Fix the snapshot-order of tsc,mperf, clock in mperf_sto=
p()
      pm: cpupower: Fix printing of CORE, CPU fields in cpupower-monitor

Jie Zhan (2):
      PM / devfreq: Allow devfreq driver to add custom sysfs ABIs
      PM / devfreq: Add HiSilicon uncore frequency scaling driver

John B. Wyatt IV (1):
      cpupower: Improve Python binding's Makefile

Krzysztof Kozlowski (1):
      cpufreq: brcmstb-avs: Fully open-code compatible for grepping

Li RongQing (1):
      cpufreq: intel_pstate: Add Granite Rapids support in no-HWP mode

Lifeng Zheng (13):
      cpufreq: CPPC: Remove cpu_data_list
      cpufreq: CPPC: Do not return a value from populate_efficiency_class()
      cpufreq: CPPC: Remove forward declaration of cppc_cpufreq_register_em=
()
      PM / devfreq: governor: Replace sscanf() with kstrtoul() in
set_freq_store()
      PM / devfreq: Limit max_freq with scaling_min_freq
      PM / devfreq: Remove redundant devfreq_get_freq_range() calling
in devfreq_add_device()
      PM / devfreq: Check governor before using governor->name
      cpufreq: Contain scaling_cur_freq.attr in cpufreq_attrs
      cpufreq: Remove duplicate check in __cpufreq_offline()
      cpufreq: Initialize cpufreq-based frequency-invariance later
      cpufreq: Init policy->rwsem before it may be possibly used
      cpufreq: Move the check of cpufreq_driver->get into
cpufreq_verify_current_freq()
      cpufreq: Exit governor when failed to start old governor

Lukas Bulwahn (1):
      MAINTAINERS: adjust file entry in CPU HOTPLUG

Prashant Malani (1):
      cpufreq: CPPC: Mark driver with NEED_UPDATE_LIMITS flag

Qiao Wei (1):
      powercap: intel_rapl: Add support for Bartlett Lake platform

Rafael J. Wysocki (18):
      PM: sleep: Make async resume handle consumers like children
      PM: sleep: Make async suspend handle suppliers like parents
      PM: Use true/false as power.needs_force_resume values
      PM: Move two sleep-related functions under CONFIG_PM_SLEEP
      PM: Make pm_runtime_force_resume() work with DPM_FLAG_SMART_SUSPEND
      PM: runtime: Clear power.needs_force_resume in pm_runtime_reinit()
      PM: Check power.needs_force_resume in pm_runtime_force_suspend()
      PM: runtime: Introduce __rpm_get_driver_callback()
      PM: sleep: Add strict_midlayer flag to struct dev_pm_info
      ACPI: PM: Set/clear power.strict_midlayer in prepare/complete
      PCI/PM: Set power.strict_midlayer in pci_pm_init()
      cpufreq: intel_pstate: Always use HWP_DESIRED_PERF in passive mode
      PM: sleep: Clean up MAINTAINERS entries for suspend and hibernation
      kexec_core: Fix error code path in the KEXEC_JUMP flow
      kexec_core: Drop redundant pm_restore_gfp_mask() call
      PM: runtime: Take active children into account in
pm_runtime_get_if_in_use()
      PM: sleep: Rearrange suspend/resume error handling in the core
      PM: docs: Use my kernel.org address in ABI docs and DT bindings

Ritvik Gupta (1):
      rust: cpumask: Replace `MaybeUninit` and `mem::zeroed` with `Opaque` =
APIs

Sakari Ailus (6):
      PM: runtime: Document return values of suspend-related API functions
      PM: runtime: Mark last busy stamp in pm_runtime_put_autosuspend()
      PM: runtime: Mark last busy stamp in pm_runtime_put_sync_autosuspend(=
)
      PM: runtime: Mark last busy stamp in pm_runtime_autosuspend()
      PM: runtime: Mark last busy stamp in pm_request_autosuspend()
      Documentation: PM: *_autosuspend() functions update last busy time

Shashank Balaji (2):
      cpufreq: userspace: set CPUFREQ_GOV_STRICT_TARGET flag
      cpufreq: docs: userspace: Explain HW coordination influence

Sivan Zohar-Kotzer (1):
      powercap: dtpm_cpu: Fix NULL pointer dereference in get_pd_power_uw()

Sven Peter (1):
      cpufreq: apple: drop default ARCH_APPLE in Kconfig

Svyatoslav Ryhel (1):
      drivers: cpufreq: add Tegra114 support

Tudor Ambarus (1):
      PM: sleep: add kernel parameter to disable asynchronous suspend/resum=
e

Ulf Hansson (1):
      Documentation: power: Remove info about non-existing QoS interfaces

Uwe Kleine-K=C3=B6nig (1):
      PM / devfreq: sun8i-a33-mbus: Simplify by using more devm functions

Yury Norov [NVIDIA] (1):
      cpuidle: dt: fix opencoded for_each_cpu() in idle_state_valid()

Zhang Rui (1):
      powercap: intel_rapl_msr: Add PL4 support for Panther Lake

Zhongqiu Han (1):
      PM: sleep: Drop superfluous might_sleep() calls

shouyeliu (1):
      Documentation: amd-pstate:fix minimum performance state label error

tuhaowen (1):
      PM: sleep: console: Fix the black screen issue

---------------

 Documentation/ABI/testing/sysfs-class-devfreq      |   9 +
 Documentation/ABI/testing/sysfs-devices-power      |  34 +-
 Documentation/ABI/testing/sysfs-power              |  26 +-
 Documentation/admin-guide/kernel-parameters.txt    |  12 +
 Documentation/admin-guide/pm/amd-pstate.rst        |   2 +-
 Documentation/admin-guide/pm/cpufreq.rst           |   4 +-
 .../devicetree/bindings/power/power-domain.yaml    |   2 +-
 Documentation/power/pm_qos_interface.rst           |   7 -
 Documentation/power/runtime_pm.rst                 |  50 +-
 MAINTAINERS                                        |  10 +-
 drivers/acpi/device_pm.c                           |   4 +
 drivers/amba/bus.c                                 |   4 +-
 drivers/base/auxiliary.c                           |   2 +-
 drivers/base/dd.c                                  |   2 +
 drivers/base/platform.c                            |   9 +-
 drivers/base/power/common.c                        |   9 +-
 drivers/base/power/main.c                          | 155 +++--
 drivers/base/power/runtime.c                       | 154 +++--
 drivers/clk/qcom/apcs-sdx55.c                      |   2 +-
 drivers/cpufreq/Kconfig.arm                        |   3 +-
 drivers/cpufreq/armada-8k-cpufreq.c                |   5 +-
 drivers/cpufreq/brcmstb-avs-cpufreq.c              |   2 +-
 drivers/cpufreq/cppc_cpufreq.c                     |  61 +-
 drivers/cpufreq/cpufreq-dt-platdev.c               |   1 +
 drivers/cpufreq/cpufreq-dt.c                       |  11 +
 drivers/cpufreq/cpufreq-dt.h                       |   2 +
 drivers/cpufreq/cpufreq.c                          |  56 +-
 drivers/cpufreq/cpufreq_userspace.c                |   1 +
 drivers/cpufreq/intel_pstate.c                     |   6 +-
 drivers/cpufreq/tegra124-cpufreq.c                 |  49 +-
 drivers/cpuidle/dt_idle_states.c                   |  14 +-
 drivers/devfreq/Kconfig                            |  11 +
 drivers/devfreq/Makefile                           |   1 +
 drivers/devfreq/devfreq.c                          |  23 +-
 drivers/devfreq/governor_userspace.c               |   6 +-
 drivers/devfreq/hisi_uncore_freq.c                 | 658 +++++++++++++++++=
++++
 drivers/devfreq/sun8i-a33-mbus.c                   |  38 +-
 drivers/gpu/drm/display/drm_dp_aux_bus.c           |   2 +-
 drivers/i2c/i2c-core-base.c                        |   2 +-
 drivers/mmc/core/sdio_bus.c                        |   2 +-
 drivers/pci/pci-driver.c                           |   4 +
 drivers/powercap/dtpm_cpu.c                        |   2 +
 drivers/powercap/intel_rapl_common.c               |   1 +
 drivers/powercap/intel_rapl_msr.c                  |   1 +
 drivers/rpmsg/rpmsg_core.c                         |   2 +-
 drivers/soundwire/bus_type.c                       |   2 +-
 drivers/spi/spi.c                                  |   2 +-
 drivers/tty/serdev/core.c                          |   2 +-
 include/acpi/cppc_acpi.h                           |   1 -
 include/linux/devfreq.h                            |   4 +
 include/linux/device.h                             |  27 +
 include/linux/pm.h                                 |  13 +-
 include/linux/pm_domain.h                          |  10 +-
 include/linux/pm_runtime.h                         | 203 ++++++-
 kernel/kexec_core.c                                |   4 +-
 kernel/power/console.c                             |   7 +-
 kernel/power/main.c                                |   9 +
 kernel/power/snapshot.c                            |  12 +-
 rust/kernel/cpufreq.rs                             |  60 +-
 rust/kernel/cpumask.rs                             |  13 +-
 rust/kernel/opp.rs                                 |   8 +-
 tools/power/cpupower/bindings/python/Makefile      |  12 +-
 .../cpupower/utils/idle_monitor/cpupower-monitor.c |   4 -
 .../cpupower/utils/idle_monitor/mperf_monitor.c    |   4 +-
 64 files changed, 1403 insertions(+), 455 deletions(-)

