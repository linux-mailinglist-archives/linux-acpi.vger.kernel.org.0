Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6571E3A01
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Oct 2019 19:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394030AbfJXR3M (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Oct 2019 13:29:12 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43738 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439987AbfJXR3M (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Oct 2019 13:29:12 -0400
Received: by mail-oi1-f195.google.com with SMTP id s5so5934237oie.10;
        Thu, 24 Oct 2019 10:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=n5/rr+7Iw1y1Xy/3+ehYuCjVxFwNY/p/xnADvXnbRFY=;
        b=lm+1av40snF4o1Dg9GOrsscwEm9vWqOelQ9oiOTU2Eg8UhS1LTu579EjBSmHtA6MkT
         iy0bO9EA4PioKW0qs9a5oZ4veyp/T7a6qxGMdEhGp0RwmYBrFZQr7HK9AbSQPHFEtx4u
         Wzq84YYaCiWyjJaXxIJethv1VKF9nNL26jh1a6ht5dzFigrsv7qxukGEeDQXvLWSJCSw
         YZh5WjClpE1HbF9RtZ7+JGpPGlWwjR99Vo2y8SCOC3f2dbUX92DO6eoJLtW083Apf/6Z
         Utp9UWHG4P3WzQLrAGahS15CNIi2olpFNfvbkJpWQ5QLTFjnuQR6DZM/xGGyDceFq0l0
         MgOA==
X-Gm-Message-State: APjAAAW2Tq/+vYBRqSfajQ2i/jGOBOi5ZJG04kEpkMd6wQZvf6+c4aOC
        9EXOQvnM76U2VUVilkOgaLMK8GVvQHpZBsj5FbGNJEG6
X-Google-Smtp-Source: APXvYqz8XiDgEsBH3NsG0Lt5ZM8CfElOkevsns8Tg3fMEbRsL5nkTur+76lw9j2XQO1yTyx9DWZGsas3wYd0G717TKA=
X-Received: by 2002:aca:d706:: with SMTP id o6mr5915677oig.57.1571938149356;
 Thu, 24 Oct 2019 10:29:09 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 24 Oct 2019 19:28:58 +0200
Message-ID: <CAJZ5v0jJ_hWQKH0FNoTk+EtzLS=y3ovC4+pXPq+NWB1vPZU9pg@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.4-rc5
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
 pm-5.4-rc5

with top-most commit 767d2d710e9066c47919a4e5f05a21e1ad40ddc4

 Merge branches 'pm-cpuidle' and 'pm-opp'

on top of commit 7d194c2100ad2a6dded545887d02754948ca5241

 Linux 5.4-rc4

to receive power management fixes for 5.4-rc5.

These fix problems related to frequency limits management in
cpufreq that were introduced during the 5.3 cycle (when PM QoS
had started to be used for that), fix a few issues in the OPP
(operating performance points) library code and fix up the
recently added haltpoll cpuidle driver.

The cpufreq changes are somewhat bigger that I would like them
to be at this stage of the cycle, but the problems fixed by them
include crashes on boot and shutdown in some cases (among other
things) and in my view it is better to address the root of the
issue right away.

Specifics:

 - Using device PM QoS of CPU devices for managing frequency limits
   in cpufreq does not work, so introduce frequency QoS (based on the
   original low-level PM QoS) for this purpose, switch cpufreq and
   related code over to using it and fix a race involving deferred
   updates of frequency limits on top of that (Rafael Wysocki, Sudeep
   Holla).

 - Avoid calling regulator_enable()/disable() from the OPP framework
   to avoid side-effects on boot-enabled regulators that may change their
   initial voltage due to performing initial voltage balancing without
   all restrictions from the consumers (Marek Szyprowski).

 - Avoid a kref management issue in the OPP library code and drop an
   incorrectly added lockdep_assert_held() from it (Viresh Kumar).

 - Make the recently added haltpoll cpuidle driver take the 'idle='
   override into account as appropriate (Zhenzhong Duan).

Thanks!


---------------

Marek Szyprowski (1):
      opp: core: Revert "add regulators enable and disable"

Rafael J. Wysocki (3):
      PM: QoS: Introduce frequency QoS
      cpufreq: Use per-policy frequency QoS
      PM: QoS: Drop frequency QoS types from device PM QoS

Sudeep Holla (1):
      cpufreq: Cancel policy update work scheduled before freeing

Viresh Kumar (2):
      opp: of: drop incorrect lockdep_assert_held()
      opp: Reinitialize the list_kref before adding the static OPPs again

Zhenzhong Duan (1):
      cpuidle: haltpoll: Take 'idle=' override into account

---------------

 drivers/acpi/processor_driver.c            |   9 +-
 drivers/acpi/processor_perflib.c           |  18 +--
 drivers/acpi/processor_thermal.c           |  18 +--
 drivers/base/power/qos.c                   |  70 +--------
 drivers/cpufreq/cpufreq.c                  |  62 ++++----
 drivers/cpufreq/intel_pstate.c             |  30 ++--
 drivers/cpufreq/ppc_cbe_cpufreq_pmi.c      |  15 +-
 drivers/cpuidle/cpuidle-haltpoll.c         |   4 +
 drivers/macintosh/windfarm_cpufreq_clamp.c |  38 +++--
 drivers/opp/core.c                         |  16 +-
 drivers/opp/of.c                           |   9 +-
 drivers/thermal/cpu_cooling.c              |  14 +-
 include/acpi/processor.h                   |  20 +--
 include/linux/cpufreq.h                    |   7 +-
 include/linux/pm_qos.h                     |  56 +++++--
 kernel/power/qos.c                         | 240 +++++++++++++++++++++++++++++
 16 files changed, 417 insertions(+), 209 deletions(-)
