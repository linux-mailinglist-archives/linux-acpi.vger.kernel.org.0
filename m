Return-Path: <linux-acpi+bounces-9629-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B8E9D0E6B
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 11:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02021F21BD1
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 10:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FC3194C8D;
	Mon, 18 Nov 2024 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sejU/WKd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77B7194AD8;
	Mon, 18 Nov 2024 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925341; cv=none; b=nCWLRcngXZaKDC6Yy53yJQc3h+nAI2u4e5v95YaSbglJzc3F4DDnBtpAKp0CgCShU1QQV9fth+zoXyMdpZVR1jnXErtwO4LZ4wVkjZ9ZoESEik6552H3oEQjuT45LKtF7oYNUR0CnPTG+N/h1i+tLHOo20N339UIb0IIG5l05cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925341; c=relaxed/simple;
	bh=F6LJAvT4xb9vEZMGIAEyCuPJQXJmFDXic1ZVvGyAo7Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ltyrpxJnF2aPXJzEJkmfq5ugkn8JOa1lVoT8vHZ4CsthXqjq+QL4sVM7ETOgxJwXZDqDH/9Bl94cyb8qgmzvVnpRVs/T4hL1THq2ZRMPONw5fZKVlBkaUY1eEDA+H04zr9xLuCJv6g2GyjiMMaz67qItCcQEWP0kbbz2I4hb1So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sejU/WKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D466C4CED0;
	Mon, 18 Nov 2024 10:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731925340;
	bh=F6LJAvT4xb9vEZMGIAEyCuPJQXJmFDXic1ZVvGyAo7Q=;
	h=From:Date:Subject:To:Cc:From;
	b=sejU/WKd0mxfrHAtuHfxqiqX5wmCYPApAgzQ9+EaHK7VsmZDatYuXfe+zXZdtoFX6
	 Lp2j+DgTpiqrvbupjVpYBZpUjTyfLrJ/1Qu8rm2rAi3eEoP342wbCfdgcAk9J5k/8K
	 a4shxJQaSgjGftq+QawQgtV0gmMBU2zJtwb+rPns5Sn3OJr9071GS+CoGmTHhLESFU
	 2KEnJcF+439v2O3hsYuP4asfy7ZvJAlhWK3oxk6tJtuIjGaVrrzQ8xGFEfCai/+LJ2
	 IF5I+ObTf8PyOhH1tfA8Vd4N10SxnN9y9e3WXKRr2cPrxWkiLeS3HmlRPMiNgSzM6A
	 pzXCIGNopNm0w==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e5f533e1c2so2121317b6e.3;
        Mon, 18 Nov 2024 02:22:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVssu6FGHGK/z0htBHWcjVLhvXRZojNPgpzCeXt43eNLSAJ3jULEcJOezjmjiSFdAUTtyzTp3QLhGlgOZ3v@vger.kernel.org, AJvYcCVswRYpr+qV94r4LBjp8m/U6LN0x8wC28ZLfxiOudLgBisoyhYk9GhP6E3cNHoLYzBbj6rwN8MBjy/k@vger.kernel.org
X-Gm-Message-State: AOJu0YyCOyx1GdaoQEgb83RaTaYintN2acVeNfk+xRngMi3s/o3B96hj
	QvDevWYdIevEn9ZS3DZ0oZ/GhFRoKWGrdSELXHQSHlH31gslhApUZic0JDPXWEm7ZSraK0VPvom
	iHvh4vbCNO0N6Z036TgSTE1yrDLU=
X-Google-Smtp-Source: AGHT+IGB0Q0xAufUUKH2H2oxeIC4U8QUE3WwW3fMFplzOdxQPzRm0oQ4NCT/hLkMR8nuu1Cyc7StjC87/kVZOJDldVs=
X-Received: by 2002:a05:6808:1250:b0:3e5:d093:d6e with SMTP id
 5614622812f47-3e7bc85054bmr12253112b6e.31.1731925339441; Mon, 18 Nov 2024
 02:22:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Nov 2024 11:22:04 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i90sb6CC=obDdmji-WeJnkwSp4Agd3UhGhuo+TVm4uXg@mail.gmail.com>
Message-ID: <CAJZ5v0i90sb6CC=obDdmji-WeJnkwSp4Agd3UhGhuo+TVm4uXg@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v6.13-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.13-rc1

with top-most commit c6e2a4c9eed5249c4158bc621882d44e94af3371

 Merge branch 'pm-tools'

on top of commit 1a1030d10a6335bb5e6cdb24fc9388d3d9bcc1ac

 cpufreq: intel_pstate: Rearrange locking in hybrid_init_cpu_capacity_scali=
ng()

to receive power management updates for 6.13-rc1.

The amd-pstate cpufreq driver gets the majority of changes this time.
They are mostly fixes and cleanups, but one of them causes it to become
the default cpufreq driver on some AMD server platforms.

Apart from that, the menu cpuidle governor is modified to not use iowait
any more, the intel_idle gets a custom C-states table for Granite Rapids
Xeon D, and the intel_pstate driver will use a more aggressive Balance-
performance default EPP value on Granite Rapids now.

There are also some fixes, cleanups and tooling updates.

Specifics:

 - Update the amd-pstate driver to set the initial scaling frequency
   policy lower bound to be the lowest non-linear frequency (Dhananjay
   Ugwekar).

 - Enable amd-pstate by default on servers starting with newer AMD Epyc
   processors (Swapnil Sapkal).

 - Align more codepaths between shared memory and MSR designs in
   amd-pstate (Dhananjay Ugwekar).

 - Clean up amd-pstate code to rename functions and remove redundant
   calls (Dhananjay Ugwekar, Mario Limonciello).

 - Do other assorted fixes and cleanups in amd-pstate (Dhananjay Ugwekar
   and Mario Limonciello).

 - Change the Balance-performance EPP value for Granite Rapids in the
   intel_pstate driver to a more performance-biased one (Srinivas
   Pandruvada).

 - Simplify MSR read on the boot CPU in the ACPI cpufreq driver (Chang
   S. Bae).

 - Ensure sugov_eas_rebuild_sd() is always called when sugov_init()
   succeeds to always enforce sched domains rebuild in case EAS needs
   to be enabled (Christian Loehle).

 - Switch cpufreq back to platform_driver::remove() (Uwe Kleine-K=C3=B6nig)=
.

 - Use proper frequency unit names in cpufreq (Marcin Juszkiewicz).

 - Add a built-in idle states table for Granite Rapids Xeon D to the
   intel_idle driver (Artem Bityutskiy).

 - Fix some typos in comments in the cpuidle core and drivers (Shen
   Lichuan).

 - Remove iowait influence from the menu cpuidle governor (Christian
   Loehle).

 - Add min/max available performance state limits to the Energy Model
   management code (Lukasz Luba).

 - Update pm-graph to v5.13 (Todd Brandt).

 - Add documentation for some recently introduced cpupower utility
   options (Tor Vic).

 - Make cpupower inform users where cpufreq-bench.conf should be located
   when opening it fails (Peng Fan).

 - Allow overriding cross-compiling env params in cpupower (Peng Fan).

 - Add compile_commands.json to .gitignore in cpupower (John B. Wyatt
   IV).

 - Improve disable c_state block in cpupower bindings and add a test to
   confirm that CPU state is disabled to it (John B. Wyatt IV).

 - Add Chinese Simplified translation to cpupower (Kieran Moy).

 - Add checks for xgettext and msgfmt to cpupower (Siddharth Menon).

Thanks!


---------------

Artem Bityutskiy (1):
      intel_idle: add Granite Rapids Xeon D support

Chang S. Bae (1):
      cpufreq: ACPI: Simplify MSR read on the boot CPU

Christian Loehle (2):
      cpuidle: menu: Remove iowait influence
      sched/cpufreq: Ensure sd is rebuilt for EAS check

Dhananjay Ugwekar (11):
      cpufreq/amd-pstate: Rename MSR and shared memory specific functions
      cpufreq/amd-pstate: Remove the redundant verify() function
      cpufreq/amd-pstate: Set the initial min_freq to lowest_nonlinear_freq
      cpufreq/amd-pstate: Call amd_pstate_register() in amd_pstate_init()
      cpufreq/amd-pstate: Call amd_pstate_set_driver() in
amd_pstate_register_driver()
      cpufreq/amd-pstate: Remove the switch case in amd_pstate_init()
      cpufreq/amd-pstate: Remove the redundant amd_pstate_set_driver() call
      cpufreq/amd-pstate: Rename functions that enable CPPC
      cpufreq/amd-pstate: Do not attempt to clear MSR_AMD_CPPC_ENABLE
      cpufreq/amd-pstate: Call cppc_set_epp_perf in the reenable function
      cpufreq/amd-pstate: Align offline flow of shared memory and MSR
based systems

Gautham R. Shenoy (1):
      amd-pstate: Set min_perf to nominal_perf for active mode performance =
gov

John B. Wyatt IV (3):
      pm: cpupower: gitignore: Add compile_commands.json
      pm: cpupower: bindings: Improve disable c_state block
      pm: cpupower: bindings: Add test to confirm cpu state is disabled

Kieran Moy (1):
      cpupower: Add Chinese Simplified translation

Lukasz Luba (1):
      PM: EM: Add min/max available performance state limits

Marcin Juszkiewicz (1):
      cpufreq: use proper units for frequency

Mario Limonciello (7):
      cpufreq/amd-pstate: Fix non kerneldoc comment
      cpufreq/amd-pstate: Don't update CPPC request in
amd_pstate_cpu_boost_update()
      cpufreq/amd-pstate: Use amd_pstate_update_min_max_limit() for EPP lim=
its
      cpufreq/amd-pstate: Drop needless EPP initialization
      cpufreq/amd-pstate-ut: Add fix for min freq unit test
      cpufreq/amd-pstate: Push adjust_perf vfunc init into cpu_init
      cpufreq/amd-pstate: Move registration after static function call upda=
te

Peng Fan (2):
      pm: cpupower: bench: print config file path when open
cpufreq-bench.conf fails
      pm: cpupower: Makefile: Allow overriding cross-compiling env params

Shen Lichuan (1):
      cpuidle: Correct some typos in comments

Siddharth Menon (1):
      cpupower: add checks for xgettext and msgfmt

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Update Balance-performance EPP for Granite Rap=
ids

Swapnil Sapkal (1):
      amd-pstate: Switch to amd-pstate by default on some Server platforms

Todd Brandt (1):
      pm-graph v5.13

Tor Vic (1):
      tools/power/cpupower: Add documentation for some recently
introduced options

Uwe Kleine-K=C3=B6nig (1):
      cpufreq: Switch back to struct platform_driver::remove()

---------------

 drivers/cpufreq/acpi-cpufreq.c                     |   9 +-
 drivers/cpufreq/amd-pstate-ut.c                    |   6 +-
 drivers/cpufreq/amd-pstate.c                       | 229 ++---
 drivers/cpufreq/brcmstb-avs-cpufreq.c              |   2 +-
 drivers/cpufreq/cpufreq-dt.c                       |   2 +-
 drivers/cpufreq/cpufreq.c                          |   2 +-
 drivers/cpufreq/davinci-cpufreq.c                  |   2 +-
 drivers/cpufreq/imx-cpufreq-dt.c                   |   2 +-
 drivers/cpufreq/imx6q-cpufreq.c                    |   2 +-
 drivers/cpufreq/intel_pstate.c                     |   2 +
 drivers/cpufreq/kirkwood-cpufreq.c                 |   2 +-
 drivers/cpufreq/loongson3_cpufreq.c                |   2 +-
 drivers/cpufreq/mediatek-cpufreq-hw.c              |   2 +-
 drivers/cpufreq/omap-cpufreq.c                     |   2 +-
 drivers/cpufreq/pcc-cpufreq.c                      |   2 +-
 drivers/cpufreq/qcom-cpufreq-hw.c                  |   2 +-
 drivers/cpufreq/qcom-cpufreq-nvmem.c               |   2 +-
 drivers/cpufreq/qoriq-cpufreq.c                    |   2 +-
 drivers/cpufreq/raspberrypi-cpufreq.c              |   2 +-
 drivers/cpufreq/scpi-cpufreq.c                     |   2 +-
 drivers/cpufreq/sun50i-cpufreq-nvmem.c             |   2 +-
 drivers/cpufreq/tegra186-cpufreq.c                 |   2 +-
 drivers/cpufreq/tegra194-cpufreq.c                 |   2 +-
 drivers/cpufreq/vexpress-spc-cpufreq.c             |   2 +-
 drivers/cpuidle/cpuidle-arm.c                      |   2 +-
 drivers/cpuidle/cpuidle-qcom-spm.c                 |   2 +-
 drivers/cpuidle/cpuidle.c                          |   2 +-
 drivers/cpuidle/driver.c                           |   4 +-
 drivers/cpuidle/governors/menu.c                   |  76 +-
 drivers/idle/intel_idle.c                          |  48 ++
 include/linux/energy_model.h                       |  29 +-
 kernel/power/energy_model.c                        |  52 ++
 kernel/sched/cpufreq_schedutil.c                   |   3 +-
 tools/power/cpupower/.gitignore                    |   3 +
 tools/power/cpupower/Makefile                      |  26 +-
 tools/power/cpupower/bench/parse.c                 |   5 +-
 .../bindings/python/test_raw_pylibcpupower.py      |  28 +-
 tools/power/cpupower/man/cpupower-set.1            |  38 +-
 tools/power/cpupower/po/zh_CN.po                   | 942 +++++++++++++++++=
++++
 tools/power/pm-graph/sleepgraph.8                  |   3 +
 tools/power/pm-graph/sleepgraph.py                 |  59 +-
 41 files changed, 1330 insertions(+), 278 deletions(-)

