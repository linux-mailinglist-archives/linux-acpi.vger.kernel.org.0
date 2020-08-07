Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C555223F26F
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Aug 2020 20:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgHGSGN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Aug 2020 14:06:13 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:47050 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHGSGN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Aug 2020 14:06:13 -0400
Received: by mail-ot1-f66.google.com with SMTP id v6so2248996ota.13;
        Fri, 07 Aug 2020 11:06:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=kNG/5GBmZ3pEAK3JxkSjLVsub+uSoAzlaHdTA+pv5gI=;
        b=iKc1cBaxZawM5HtuCaxehymhUnvmag9kClS/8vAHXcba2veFXeLV8c0N4QEmvvbKF/
         mSW41ToWYK1aBap8iQ2fI3GQ/sFLS+Rkv2gjQ6cNXdPfbvIYmUzgCvcwv0CoX4u0iKNg
         h+pApaEia15DDmC1Ki7/XrdDcfHbHhn6AE5ZS4EyJ3xc4rXWwOigL7jGzwyJ6vP/BKCS
         TmN65f2JrNpsJnxfgC3z+0736pDk0bPN1/J2bmlSckMMoVog6koBd3IEW8l8ePlCUGzW
         BbXtexr2Spm1nQZ3ZlYiTCJMvgd4cLAlc1coA6eI3VyAb/dhA3y1F+eSq7utdvdfP7AV
         65bA==
X-Gm-Message-State: AOAM532TJp+KvwPYBlws1EuI3a3X86vTUV3J/h8XNcxt3KXHayp9vCV4
        EY8TiHaWkvz0+ltnbVaTFkIY6QnD2vQbKs7+fDU=
X-Google-Smtp-Source: ABdhPJw62lTIxLZLH/C6sbNZE/oV3wS6xDPdh6tBo7gstFSw91g7CJinPRnzC7EcJQlARGphxfUlcO2VCA/sm9wy85s=
X-Received: by 2002:a05:6830:1c74:: with SMTP id s20mr12237581otg.167.1596823572067;
 Fri, 07 Aug 2020 11:06:12 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 7 Aug 2020 20:06:01 +0200
Message-ID: <CAJZ5v0hQS_aVFJpqJ2uPxpomKpyb3iM0fVUTg5oP-5AG=qwGsA@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v5.9-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.9-rc1-2

with top-most commit 0873ad923a05751a29a92229739ce2737c29d348

 Merge branch 'pm-core'

on top of commit 04084978003c1a1810a0b1fea581078106394a32

 Merge tag 'pm-5.9-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more power management updates for 5.9-rc1.

These are mostly ARM cpufreq driver updates plus a cpufreq core
cleanup, an ARM-wide change to make schedutil the default scaling
governor, an intel_pstate driver fix and some runtime PM changes
regarding kerneldoc comments.

Specifics:

 - Add adaptive voltage scaling (AVS) support to the brcmstb cpufreq
   driver and clean it up (Florian Fainelli, Markus Mayer).

 - Add a new Tegra cpufreq driver and clean up the existing one (Jon
   Hunter, Sumit Gupta).

 - Add bandwidth level support to the Qcom cpufreq driver along with
   OPP changes (Sibi Sankar).

 - Clean up the sti, cpufreq-dt, ap806, CPPC cpufreq drivers (Viresh
   Kumar, Lee Jones, Ivan Kokshaysky, Sven Auhagen, Xin Hao).

 - Make schedutil the default governor for ARM (Valentin Schneider).

 - Fix dependency issues for the imx cpufreq driver (Walter Lozano).

 - Clean up cached_resolved_idx handlihng in the cpufreq core (Viresh
   Kumar).

 - Fix the intel_pstate driver to use the correct maximum frequency
   value when MSR_TURBO_RATIO_LIMIT is 0 (Srinivas Pandruvada).

 - Provide kenrneldoc comments for multiple runtime PM helpers and
   improve the pm_runtime_get_if_active() kerneldoc (Rafael Wysocki).

Thanks!


---------------

Florian Fainelli (1):
      cpufreq: brcmstb-avs-cpufreq: Support polling AVS firmware

Ivan Kokshaysky (1):
      cpufreq: dt: fix oops on armada37xx

Jon Hunter (1):
      cpufreq: tegra186: Simplify probe return path

Lee Jones (1):
      cpufreq: sti-cpufreq: Fix some formatting and misspelling issues

Markus Mayer (2):
      cpufreq: brcmstb-avs-cpufreq: more flexible interface for
__issue_avs_command()
      cpufreq: brcmstb-avs-cpufreq: send S2_ENTER / S2_EXIT commands to AVS

Rafael J. Wysocki (2):
      PM: runtime: Add kerneldoc comments to multiple helpers
      PM: runtime: Improve kerneldoc of pm_runtime_get_if_active()

Sibi Sankar (5):
      cpufreq: blacklist SDM845 in cpufreq-dt-platdev
      cpufreq: blacklist SC7180 in cpufreq-dt-platdev
      OPP: Add and export helper to set bandwidth
      cpufreq: qcom: Update the bandwidth levels on frequency change
      cpufreq: qcom: Disable fast switch when scaling DDR/L3

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Fix cpuinfo_max_freq when
MSR_TURBO_RATIO_LIMIT is 0

Sumit Gupta (2):
      dt-bindings: arm: Add NVIDIA Tegra194 CPU Complex binding
      cpufreq: Add Tegra194 cpufreq driver

Sven Auhagen (1):
      cpufreq: ap806: fix cpufreq driver needs ap cpu clk

Valentin Schneider (1):
      cpufreq: make schedutil the default for arm and arm64

Viresh Kumar (2):
      cpufreq: cppc: Reorder code and remove apply_hisi_workaround variable
      cpufreq: cached_resolved_idx can not be negative

Walter Lozano (1):
      cpufreq: imx: Select NVMEM_IMX_OCOTP

Xin Hao (1):
      cpufreq: CPPC: Reuse caps variable in few routines

---------------

 .../bindings/arm/nvidia,tegra194-ccplex.yaml       |  69 ++++
 drivers/base/power/runtime.c                       |  26 +-
 drivers/cpufreq/Kconfig                            |   2 +-
 drivers/cpufreq/Kconfig.arm                        |   9 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/armada-37xx-cpufreq.c              |   1 +
 drivers/cpufreq/brcmstb-avs-cpufreq.c              |  89 +++--
 drivers/cpufreq/cppc_cpufreq.c                     |  95 +++--
 drivers/cpufreq/cpufreq-dt-platdev.c               |   2 +
 drivers/cpufreq/cpufreq.c                          |   2 +-
 drivers/cpufreq/intel_pstate.c                     |   1 +
 drivers/cpufreq/qcom-cpufreq-hw.c                  |  91 ++++-
 drivers/cpufreq/sti-cpufreq.c                      |   8 +-
 drivers/cpufreq/tegra186-cpufreq.c                 |   6 -
 drivers/cpufreq/tegra194-cpufreq.c                 | 390 +++++++++++++++++++++
 drivers/opp/core.c                                 |  31 ++
 include/linux/cpufreq.h                            |   2 +-
 include/linux/pm_opp.h                             |   6 +
 include/linux/pm_runtime.h                         | 246 +++++++++++++
 19 files changed, 963 insertions(+), 114 deletions(-)
