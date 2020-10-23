Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6A12975C9
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Oct 2020 19:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753446AbgJWR35 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Oct 2020 13:29:57 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46018 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753444AbgJWR34 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Oct 2020 13:29:56 -0400
Received: by mail-ot1-f65.google.com with SMTP id f37so2041057otf.12;
        Fri, 23 Oct 2020 10:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=IXO+oFGzZFMe3RRcGxHZuWeA7SXQBaRULI8TubEz+OI=;
        b=n96vEu3UOxF0mRNxww5z8Wcywg9sS3mv096mKu+qAti6x7vIRdEK1xWzxt9PXEAkF7
         OkrbAzlHKRPDr8omgHwQGcXmRCvb4OXyvhBOLW8A0G0XwJ8qM0LLexkevn3VglK+mvIW
         kmzJvLgxSoVfwsb5up0Jsc6Hn9IeCI+DJljfBGbzybQzMlzQO8+4NwMop2yxVtKVaxxN
         vjfD+QeIrsMIzJmIIZkjlSdDwlkvHQ/4BOY0I1Le2h5NCj+5/PF5u+X2/4C3LaQt4d4N
         ba/icmLe5GONkwDQX8jcmct+tBlaVmO9JAjQk+70NcE7iPF6Mnh4PUlcw8xVITD6Lpdp
         Zlxg==
X-Gm-Message-State: AOAM532OfCzNTW7i4qfcXSFjXQgmGPqqidwBuNiuCVhZ+Kf8MrrYM/wl
        mZKOhd+hWjaMZBj5ibg8bjzPcAiPJ43iJyErBL1ii2XjVF4=
X-Google-Smtp-Source: ABdhPJwaUqMQ79RjPWrxI58BBn8CNW72fehlhqLoEjF976dRF9ieYVvgsIO9tsiM0PkRTle3VTzmhkyVS+eM5OWXCD8=
X-Received: by 2002:a05:6830:18cd:: with SMTP id v13mr2650846ote.206.1603474194821;
 Fri, 23 Oct 2020 10:29:54 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 23 Oct 2020 19:29:43 +0200
Message-ID: <CAJZ5v0jJq1myATF3gG=4JwCbBnn3X-MsPXA=nN=WVMcSuDGVzg@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v5.10-rc1
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
 pm-5.10-rc1-2

with top-most commit 41c169d9ae2c890552044e129d101995b62c8a02

 Merge branch 'pm-avs'

on top of commit defb53a7c790f9e37a765de8a5d830ed15e2055b

 Merge tag 'pnp-5.10-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more power management updates for 5.10-rc1.

First of all, the adaptive voltage scaling (AVS) drivers go to new
platform-specific locations as planned (this part was reported to
have merge conflicts against the new arm-soc updates in linux-next).

In addition to that, there are some fixes (intel_idle, intel_pstate,
RAPL, acpi_cpufreq), the addition of on/off notifiers and idle state
accounting support to the generic power domains (genpd) code and some
janitorial changes all over.

Specifics:

 - Move the AVS drivers to new platform-specific locations and get
   rid of the drivers/power/avs directory (Ulf Hansson).

 - Add on/off notifiers and idle state accounting support to the
   generic power domains (genpd) framework (Ulf Hansson, Lina Iyer).

 - Ulf will maintain the PM domain part of cpuidle-psci (Ulf Hansson).

 - Make intel_idle disregard ACPI _CST if it cannot use the data
   returned by that method (Mel Gorman).

 - Modify intel_pstate to avoid leaving useless sysfs directory
   structure behind if it cannot be registered (Chen Yu).

 - Fix domain detection in the RAPL power capping driver and prevent
   it from failing to enumerate the Psys RAPL domain (Zhang Rui).

 - Allow acpi-cpufreq to use ACPI _PSD information with Family 19 and
   later AMD chips (Wei Huang).

 - Update the driver assumptions comment in intel_idle and fix a
   kerneldoc comment in the runtime PM framework (Alexander Monakov,
   Bean Huo).

 - Avoid unnecessary resets of the cached frequency in the schedutil
   cpufreq governor to reduce overhead (Wei Wang).

 - Clean up the cpufreq core a bit (Viresh Kumar).

 - Make assorted minor janitorial changes (Daniel Lezcano, Geert
   Uytterhoeven, Hubert Jasudowicz, Tom Rix).

 - Clean up and optimize the cpupower utility somewhat (Colin Ian
   King, Martin Kaistra).

Thanks!


---------------

Alexander Monakov (1):
      intel_idle: mention assumption that WBINVD is not needed

Bean Huo (1):
      PM: runtime: Fix typo in pm_runtime_set_active() helper comment

Chen Yu (1):
      cpufreq: intel_pstate: Delete intel_pstate sysfs if failed to
register the driver

Colin Ian King (1):
      cpupowerutils: fix spelling mistake "dependant" -> "dependent"

Daniel Lezcano (1):
      cpuidle: Remove pointless stub

Geert Uytterhoeven (1):
      PM: domains: Add curly braces to delimit comment + statement block

Hubert Jasudowicz (1):
      powercap: Fix typo in Kconfig "Plance" -> "Plane"

Lina Iyer (1):
      PM: domains: enable domain idle state accounting

Martin Kaistra (1):
      cpupower: speed up generating git version string

Mel Gorman (1):
      intel_idle: Ignore _CST if control cannot be taken from the platform

Tom Rix (1):
      PM: sleep: remove unreachable break

Ulf Hansson (7):
      MAINTAINERS: Add section for cpuidle-psci PM domain
      PM: domains: Add support for PM domain on/off notifiers for genpd
      PM: AVS: rockchip-io: Move the driver to the rockchip specific drivers
      PM: AVS: smartreflex Move driver to soc specific drivers
      PM: domains: Fix build error for genpd notifiers
      PM: AVS: qcom-cpr: Move the driver to the qcom specific drivers
      PM: AVS: Drop the avs directory and the corresponding Kconfig

Viresh Kumar (1):
      cpufreq: Improve code around unlisted freq check

Wei Huang (1):
      acpi-cpufreq: Honor _PSD table setting on new AMD CPUs

Wei Wang (1):
      cpufreq: schedutil: restore cached freq when next_f is not changed

Zhang Rui (2):
      powercap/intel_rapl: Fix domain detection
      powercap/intel_rapl: enumerate Psys RAPL domain together with
package RAPL domain

---------------

 MAINTAINERS                                        |  14 +-
 arch/arm/plat-omap/Kconfig                         |   2 +-
 drivers/base/power/domain.c                        | 167 +++++++++++++++++++--
 drivers/base/power/main.c                          |   1 -
 drivers/cpufreq/acpi-cpufreq.c                     |   3 +-
 drivers/cpufreq/cpufreq.c                          |  15 +-
 drivers/cpufreq/intel_pstate.c                     |  22 ++-
 drivers/idle/intel_idle.c                          |  15 +-
 drivers/power/Kconfig                              |   1 -
 drivers/power/Makefile                             |   1 -
 drivers/power/avs/Kconfig                          |  37 -----
 drivers/power/avs/Makefile                         |   4 -
 drivers/powercap/Kconfig                           |   2 +-
 drivers/powercap/intel_rapl_common.c               |  82 ++--------
 drivers/powercap/intel_rapl_msr.c                  |   5 +-
 drivers/soc/qcom/Kconfig                           |  16 ++
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/{power/avs/qcom-cpr.c => soc/qcom/cpr.c}   |   0
 drivers/soc/rockchip/Kconfig                       |   8 +
 drivers/soc/rockchip/Makefile                      |   1 +
 .../rockchip/io-domain.c}                          |   0
 drivers/soc/ti/Makefile                            |   1 +
 drivers/{power/avs => soc/ti}/smartreflex.c        |   0
 include/linux/cpuidle.h                            |   5 -
 include/linux/intel_rapl.h                         |   7 +-
 include/linux/pm_domain.h                          |  24 +++
 include/linux/pm_runtime.h                         |   2 +-
 kernel/sched/cpufreq_schedutil.c                   |   5 +-
 tools/power/cpupower/Makefile                      |   2 +-
 tools/power/cpupower/debug/i386/intel_gsic.c       |   2 +-
 30 files changed, 281 insertions(+), 164 deletions(-)
