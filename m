Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1473231D2
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Feb 2021 21:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbhBWUHJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Feb 2021 15:07:09 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:41691 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbhBWUGU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Feb 2021 15:06:20 -0500
Received: by mail-ot1-f47.google.com with SMTP id s107so16889387otb.8;
        Tue, 23 Feb 2021 12:06:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=GR50Cg3/a4uZ0hQeKt4wjkzEAKKZSTaWGiA/JDHOJss=;
        b=ID1+YKT4Om7sWVeIoZ6CVAYnqq7TvX6HAfT+F7s40To6soMUnKfolptauC7DFUjRCK
         U+yks46F4l3LqUdhQM9rBB6dXB33k1DlE/RNytxzTLe210GwY6q5Mf/BvWYB6vUZg3DQ
         csl+R92U8kBpLwu63Ly4G5uKSeeTNJkvXZ083SwjF4vmWUciiQKjP+ooUXvLOYbG3rht
         FNemJoDftR4Guabi5btLuC8dsygbo1DEGbR/B/BwUxQHGRf2JEw6xjhs3DrZpd11cmH+
         XjxJBDrZ3jdW/rZiD1Kg7bQMzsbnLxDdp6ZMMyXV8Fni0iuX0IkoyTXWOXD3+cjsKrsa
         olgg==
X-Gm-Message-State: AOAM532oj/YUiSEqtyTCEbJVZbvZf6Iy8AboBNOtXGcePyhzQmiLfMLQ
        ZrgbTHg4hnO/KbD5DOy5DGTovJ2iFDpQM7cAD2TLKxIVgPE=
X-Google-Smtp-Source: ABdhPJxhb2pQ0hxYuUlulW381EYLw7BjdlvWk7Lj2lFId3lfCdvCRQFbXMbIvNIwwx2NDAFisISKfJqwZpMdo1YcZjw=
X-Received: by 2002:a05:6830:1e03:: with SMTP id s3mr1063134otr.260.1614110737318;
 Tue, 23 Feb 2021 12:05:37 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Feb 2021 21:05:26 +0100
Message-ID: <CAJZ5v0gOvJ4OXK2Sqt6ncm-G0BVeC1Aiuettd02E=7wq73g=oA@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v5.12-rc1
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
 pm-5.12-rc1-2

with top-most commit 08c2a406b974eea893dd9b2f159d715f2b15c683

 Merge branches 'pm-cpufreq' and 'pm-opp'

on top of commit a9a939cb34dfffb9f43b988a681d2566ca157b74

 Merge branches 'powercap' and 'pm-misc'

to receive more power management updates for 5.12-rc1.

These are fixes and cleanups on top of the power management
material for 5.12-rc1 merged previously.

Specifics:

 - Address cpufreq regression introduced in 5.11 that causes
   CPU frequency reporting to be distorted on systems with CPPC
   that use acpi-cpufreq as the scaling driver (Rafael Wysocki).

 - Fix regression introduced during the 5.10 development cycle
   related to CPU hotplug and policy recreation in the
   qcom-cpufreq-hw driver (Shawn Guo).

 - Fix recent regression in the operating performance points (OPP)
   framework that may cause frequency updates to be skipped by
   mistake in some cases (Jonathan Marek).

 - Simplify schedutil governor code and remove a misleading comment
   from it (Yue Hu).

 - Fix kerneldoc comment typo in the cpufreq core (Yue Hu).

Thanks!


---------------

Jonathan Marek (1):
      opp: Don't skip freq update for different frequency

Rafael J. Wysocki (1):
      cpufreq: ACPI: Set cpuinfo.max_freq directly if max boost is known

Shawn Guo (1):
      cpufreq: qcom-hw: drop devm_xxx() calls from init/exit hooks

Yue Hu (3):
      cpufreq: schedutil: Remove needless sg_policy parameter from
ignore_dl_rate_limit()
      cpufreq: schedutil: Remove update_lock comment from struct
sugov_policy definition
      cpufreq: Fix typo in kerneldoc comment

---------------

 drivers/cpufreq/acpi-cpufreq.c    | 62 ++++++++++-----------------------------
 drivers/cpufreq/cpufreq.c         |  2 +-
 drivers/cpufreq/freq_table.c      |  8 ++++-
 drivers/cpufreq/qcom-cpufreq-hw.c | 40 ++++++++++++++++++++-----
 drivers/opp/core.c                |  8 +++--
 drivers/opp/opp.h                 |  2 ++
 kernel/sched/cpufreq_schedutil.c  | 14 ++++-----
 7 files changed, 69 insertions(+), 67 deletions(-)
