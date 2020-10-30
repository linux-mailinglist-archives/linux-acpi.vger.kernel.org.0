Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A713E2A0B12
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 17:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgJ3Q2o (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Oct 2020 12:28:44 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44904 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgJ3Q2n (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Oct 2020 12:28:43 -0400
Received: by mail-oi1-f194.google.com with SMTP id k27so7186991oij.11;
        Fri, 30 Oct 2020 09:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=N4XrkGP0kfHl+6C37uH3pC+4L7r56rDfCcTmxy0Tqe4=;
        b=NSi8IEFeNftS6rA3ivbLaq1ck0bDnY9AjsC0/OBl4FQSOYDsn/CZgbsMkLTHC3d4Fw
         A0R3xV1uZlZL9BSxzaEr0ruwR3YxPHjzFXQVKqtk0CdNwzM3P/6mzVz2WqBK40vUU2J0
         WUA1wRgBYdfZ/mobS67DUBO2Qct5zkB/cPrd6fu+auy3FSGhmst1QwZjOTHf6kgcZ59i
         ivOVAITQmMd7j9LtvN1fM5VyYcTxSdXtoQ5t+oTq/YVKC4HxGyVmurNASftJUAjBZSlk
         YQED8lrdIYcF3KEasg1al08GJy4wW4QAlKTfO3uVqcBQOSAfanJCdZChnYkx9WeBSSi2
         s/Mg==
X-Gm-Message-State: AOAM531FyKJoebXyZzvNh/atC7Exg1lVeC5zJ9GkESxxTcDJVf/ECwYl
        X0FWMARKF7JMHsUZis26gYnmYzEm+uTFtWT270ueHyVuPMc=
X-Google-Smtp-Source: ABdhPJzWZ6yTjfPS5vwqqtSHtRnnbwbG5hJgNNxEv4FVatTJYAqTaWDcfM2oBIsSdR23WFtS9IljS74PvlS5EgWE0+E=
X-Received: by 2002:aca:724a:: with SMTP id p71mr2159790oic.157.1604075322923;
 Fri, 30 Oct 2020 09:28:42 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Oct 2020 17:28:32 +0100
Message-ID: <CAJZ5v0jUdG-6MO8BWz0BsJTqFCbaad1Bk6MexFy8ugdgBFexLg@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.10-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.10-rc2

with top-most commit dea47cf45a7f9bb94684830c47d4b259d5f8d6af

 Merge branches 'pm-cpuidle' and 'pm-sleep'

on top of commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec

 Linux 5.10-rc1

to receive power management fixes for 5.10-rc2.

These fix a few issues related to running intel_pstate in the passive
mode with HWP enabled, correct the handling of the max_cstate module
parameter in intel_idle and make a few janitorial changes.

Specifics:

 - Modify Kconfig to prevent configuring either the "conservative"
   or the "ondemand" governor as the default cpufreq governor if
   intel_pstate is selected, in which case "schedutil" is the
   default choice for the default governor setting (Rafael Wysocki).

 - Modify the cpufreq core, intel_pstate and the schedutil governor
   to avoid missing updates of the HWP max limit when intel_pstate
   operates in the passive mode with HWP enabled (Rafael Wysocki).

 - Fix max_cstate module parameter handling in intel_idle for
   processor models with C-state tables coming from ACPI (Chen Yu).

 - Clean up assorted pieces of power management code (Jackie Zamow,
   Tom Rix, Zhang Qilong).

Thanks!


---------------

Chen Yu (1):
      intel_idle: Fix max_cstate for processor models without C-state tables

Jackie Zamow (1):
      PM: sleep: fix typo in kernel/power/process.c

Rafael J. Wysocki (5):
      cpufreq: Avoid configuring old governors as default with intel_pstate
      cpufreq: Introduce CPUFREQ_NEED_UPDATE_LIMITS driver flag
      cpufreq: intel_pstate: Avoid missing HWP max updates in passive mode
      cpufreq: Introduce cpufreq_driver_test_flags()
      cpufreq: schedutil: Always call driver if
CPUFREQ_NEED_UPDATE_LIMITS is set

Tom Rix (1):
      cpufreq: speedstep: remove unneeded semicolon

Zhang Qilong (1):
      cpufreq: e_powersaver: remove unreachable break

---------------

 drivers/cpufreq/Kconfig          |  2 ++
 drivers/cpufreq/cpufreq.c        | 15 ++++++++++++++-
 drivers/cpufreq/e_powersaver.c   |  1 -
 drivers/cpufreq/intel_pstate.c   | 13 ++++++-------
 drivers/cpufreq/longhaul.c       |  1 -
 drivers/cpufreq/speedstep-lib.c  |  2 +-
 drivers/idle/intel_idle.c        |  2 +-
 include/linux/cpufreq.h          | 11 ++++++++++-
 kernel/power/process.c           |  2 +-
 kernel/sched/cpufreq_schedutil.c |  6 ++++--
 10 files changed, 39 insertions(+), 16 deletions(-)
