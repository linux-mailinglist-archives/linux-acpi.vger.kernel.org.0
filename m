Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2C7278F20
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Sep 2020 18:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgIYQxZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Sep 2020 12:53:25 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39412 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbgIYQxZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2020 12:53:25 -0400
Received: by mail-ot1-f66.google.com with SMTP id u25so2935059otq.6;
        Fri, 25 Sep 2020 09:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fJTtSUwyASxVJzC78M9UtgW3Gnkvqlxlm8ZCb8ZlYrQ=;
        b=Gfa6Z5UTTcusw1Y1AO3oyc2uu1QF1UsFFLf6AuQ09Bj43vJRKoUF4//rkAS95h1MHg
         vWxVlg1oCQXL29SGiR4DCaUmkbn8Ib7f0cUK7eL43Dhrj7dmlKB2g5i13A/cU4JGIfkK
         wSqjOcSYWnfJ87KqWH2ys3toDSZ+PNlBb/yaAGn4Vw7HnubMxDN5bmoyspMHhILQZS+2
         GeozcVgV8vRnJMzCjcTcrNkatdRuXHbkp+xrtwXm84XMmjdWv+XWcvvTSfk7tgEDriN/
         ATqucAIgZRErOqSH4w8SX8sroqm8IlvbHYLgOPX84aI6Zoqc21jEIPXa9kY6tHnFQ0tk
         HCBg==
X-Gm-Message-State: AOAM53026ECN9PazzYOA3OiuF6l6L9gVua/cpWLtCDb9Y8O0KzZDLAup
        CHDfqYOZAWnrt32jv+J+BcIQi7iY0KFH1d7sbu0KmSvvtLs=
X-Google-Smtp-Source: ABdhPJyCMzxKnePEtgfIIqf3VsWpaEy+Dj/SyVMNOBWnK0BRT9ZAEQ0cnv1NvGTC6GggQuuaHUilrmN426XTwMAuTrs=
X-Received: by 2002:a05:6830:150a:: with SMTP id k10mr879687otp.167.1601052804474;
 Fri, 25 Sep 2020 09:53:24 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Sep 2020 18:53:13 +0200
Message-ID: <CAJZ5v0hyx0Jh7Cc2ZpHTM0V+QzFrQtwsXbMjcBRp3TRFgY9vUQ@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.9-rc7
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
 pm-5.9-rc7

with top-most commit 6040723009060ed356dc93dd9a27e80b2206e59b

 Merge branch 'pm-cpuidle'

on top of commit ba4f184e126b751d1bffad5897f263108befc780

 Linux 5.9-rc6

to receive power management fixes for 5.9-rc7.

These fix more fallout of recent RCU-lockdep changes in CPU idle
code and two devfreq issues.

Specifics:

 - Export rcu_idle_{enter,exit} to modules to fix build issues
   introduced by recent RCU-lockdep fixes (Borislav Petkov).

 - Add missing return statement to a stub function in the ACPI
   processor driver to fix a build issue introduced by recent
   RCU-lockdep fixes (Rafael Wysocki).

 - Fix recently introduced suspicious RCU usage warnings in the PSCI
   cpuidle driver and drop stale comments regarding RCU_NONIDLE()
   usage from enter_s2idle_proper() (Ulf Hansson).

 - Fix error code path in the tegra30 devfreq driver (Dan Carpenter).

 - Add missing information to devfreq_summary debugfs (Chanwoo Choi).

Thanks!


---------------

Borislav Petkov (1):
      rcu/tree: Export rcu_idle_{enter,exit} to modules

Chanwoo Choi (1):
      PM / devfreq: Add timer type to devfreq_summary debugfs

Dan Carpenter (1):
      PM / devfreq: tegra30: Disable clock on error in probe

Rafael J. Wysocki (1):
      ACPI: processor: Fix build for ARCH_APICTIMER_STOPS_ON_C3 unset

Ulf Hansson (2):
      cpuidle: psci: Fix suspicious RCU usage
      cpuidle: Drop misleading comments about RCU usage

---------------

 drivers/acpi/processor_idle.c     |  1 +
 drivers/cpuidle/cpuidle-psci.c    |  4 ++--
 drivers/cpuidle/cpuidle.c         | 10 ----------
 drivers/devfreq/devfreq.c         | 11 ++++++++---
 drivers/devfreq/tegra30-devfreq.c |  4 +++-
 kernel/rcu/tree.c                 |  2 ++
 6 files changed, 16 insertions(+), 16 deletions(-)
