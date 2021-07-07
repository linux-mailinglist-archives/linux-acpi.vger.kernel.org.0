Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C793C3BF016
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jul 2021 21:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhGGTQ3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Jul 2021 15:16:29 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:41943 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhGGTQ0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Jul 2021 15:16:26 -0400
Received: by mail-oi1-f171.google.com with SMTP id w74so4630437oiw.8;
        Wed, 07 Jul 2021 12:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=s57HET1CJ9VwocJDNMVl4bMwfDk+FHcmP4aVj9NssM8=;
        b=kupYP4W4SAv7R4chjgcqW4fDeR81pU1ywFmAQNEseCMO7iCHDhItbLXCSBbWtFerjl
         hjvX1zZ+1O+2sfVHAfLsr/gRT5XbdsV9/9jR56X6Pzm09gBsgsOFq7PlCjjtfFtDgvvs
         LhWwQ3TEVOarlZ0BmLoAwier5LfsmwDxsdIFCy824eImFnGoL+1fO9nk8em1yitpAUl0
         C7tC/+tedtz1IHii2Uy8XGR4jyWQYbsmADRGSNdByqW9abhJbz4fQdZvvoEZ5bgyLtZP
         9PWwRx/7fLuRu7SYVElnnkWH1E33fw6btkpoklUhYCtiqL2GqyZgMyN5/VROegiWQrg+
         +6Cg==
X-Gm-Message-State: AOAM5312NhDaWcCwwxPVcJG04P8rvtMUdN2H60drzeRnG1e/oxwyP58J
        1HqRB9GLAvLa/CzVqurGy/VpritYTeIqywwdoa4=
X-Google-Smtp-Source: ABdhPJx3Glz7RywfPWdLhoHFBOaOtbmUKzba/ibGgk3Ao5OXBO1JXiAPb6qG/pozIuGi8wDNt3EaI49URx9gPuAlMCk=
X-Received: by 2002:aca:c457:: with SMTP id u84mr10561786oif.69.1625685224619;
 Wed, 07 Jul 2021 12:13:44 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Jul 2021 21:13:33 +0200
Message-ID: <CAJZ5v0gQhJHNn99sEpen_CK3+7vkn=t-56bG574k_TyTPGy96Q@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v5.14-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.14-rc1-2

with top-most commit 843372db2e3bf9694e98a1ff9d0da6dc3d53aab8

 Merge branches 'pm-cpuidle', 'pm-sleep' and 'pm-domains'

on top of commit 3563f55ce65462063543dfa6a8d8c7fbfb9d7772

 Merge tag 'pm-5.14-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more power management updates for 5.14-rc1.

These include cpufreq core simplifications and fixes, cpufreq
driver updates, cpuidle driver update, a generic power domains
(genpd) locking fix and a debug-related simplification of the PM
core.

Specifics:

 - Drop the ->stop_cpu() (not really useful) and ->resolve_freq()
   (unused) cpufreq driver callbacks and modify the users of the
   former accordingly (Viresh Kumar, Rafael Wysocki).

 - Add frequency invariance support to the ACPI CPPC cpufreq driver
   again along with the related fixes and cleanups (Viresh Kumar).

 - Update the Meditak, qcom and SCMI ARM cpufreq drivers (Fabien
   Parent, Seiya Wang, Sibi Sankar, Christophe JAILLET).

 - Rename black/white-lists in the DT cpufreq driver (Viresh Kumar).

 - Add generic performance domains support to the dvfs DT bindings
   (Sudeep Holla).

 - Refine locking in the generic power domains (genpd) support code
   to avoid lock dependency issues (Stephen Boyd).

 - Update the MSM and qcom ARM cpuidle drivers (Bartosz Dudziak).

 - Simplify the PM core debug code by using ktime_us_delta() to
   compute time interval lengths (Mark-PK Tsai).

Thanks!


---------------

Bartosz Dudziak (2):
      dt-bindings: arm: msm: Add SAW2 for MSM8226
      cpuidle: qcom: Add SPM register data for MSM8226

Christophe JAILLET (1):
      cpufreq: scmi: Fix an error message

Fabien Parent (1):
      cpufreq: mediatek: add support for mt8365

Mark-PK Tsai (1):
      PM: sleep: Use ktime_us_delta() in initcall_debug_report()

Rafael J. Wysocki (1):
      cpufreq: intel_pstate: Combine ->stop_cpu() and ->offline()

Seiya Wang (2):
      clk: mediatek: remove deprecated CLK_INFRA_CA57SEL for MT8173 SoC
      dt-bindings: cpufreq: update cpu type and clock name for MT8173 SoC

Sibi Sankar (1):
      cpufreq: blacklist SC7280 in cpufreq-dt-platdev

Stephen Boyd (1):
      PM: domains: Shrink locking area of the gpd_list_lock

Sudeep Holla (1):
      dt-bindings: dvfs: Add support for generic performance domains

Viresh Kumar (10):
      cpufreq: dt: Rename black/white-lists
      cpufreq: CPPC: Migrate to ->exit() callback instead of ->stop_cpu()
      cpufreq: powernv: Migrate to ->exit() callback instead of ->stop_cpu()
      cpufreq: Remove the ->stop_cpu() driver callback
      cpufreq: Reuse cpufreq_driver_resolve_freq() in __cpufreq_driver_target()
      cpufreq: Remove ->resolve_freq()
      cpufreq: CPPC: Fix potential memleak in cppc_cpufreq_cpu_init
      cpufreq: CPPC: Pass structure instance by reference
      arch_topology: Avoid use-after-free for scale_freq_data
      cpufreq: CPPC: Add support for frequency invariance

---------------

 Documentation/cpu-freq/cpu-drivers.rst             |   6 -
 Documentation/devicetree/bindings/arm/cpus.yaml    |   7 +
 .../devicetree/bindings/arm/msm/qcom,saw2.txt      |   1 +
 .../bindings/cpufreq/cpufreq-mediatek.txt          |   8 +-
 .../bindings/dvfs/performance-domain.yaml          |  74 +++++
 .../translations/zh_CN/cpu-freq/cpu-drivers.rst    |   5 -
 drivers/base/arch_topology.c                       |  27 +-
 drivers/base/power/domain.c                        |  38 ++-
 drivers/base/power/main.c                          |   5 +-
 drivers/cpufreq/Kconfig.arm                        |  10 +
 drivers/cpufreq/cppc_cpufreq.c                     | 324 ++++++++++++++++++---
 drivers/cpufreq/cpufreq-dt-platdev.c               |  10 +-
 drivers/cpufreq/cpufreq.c                          |  44 ++-
 drivers/cpufreq/intel_pstate.c                     |  11 +-
 drivers/cpufreq/mediatek-cpufreq.c                 |   1 +
 drivers/cpufreq/powernv-cpufreq.c                  |  23 +-
 drivers/cpufreq/scmi-cpufreq.c                     |   2 +-
 drivers/cpuidle/cpuidle-qcom-spm.c                 |  14 +
 include/dt-bindings/clock/mt8173-clk.h             |   1 -
 include/linux/arch_topology.h                      |   1 +
 include/linux/cpufreq.h                            |  10 -
 kernel/sched/core.c                                |   1 +
 22 files changed, 474 insertions(+), 149 deletions(-)
