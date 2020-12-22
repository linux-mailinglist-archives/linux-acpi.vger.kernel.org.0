Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7637B2E0E9C
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Dec 2020 20:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgLVTO1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Dec 2020 14:14:27 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:38231 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgLVTO1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Dec 2020 14:14:27 -0500
Received: by mail-oi1-f182.google.com with SMTP id x13so15859574oic.5;
        Tue, 22 Dec 2020 11:14:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1Eh7m3hFGprfwN/8YW291dz5yjJJmnCPD2wugr7INuE=;
        b=bOzuFCC8V8ZHc48pAIh7olxkhPSzc0/N+pUkXayWznhanp8DbRIQplTeH++TBFglQn
         0rKSHTtzGwtAHx6FH8O1iJNorBf9DMxn6OnWQWH/vwJYUq5JWGfHlK7KkmzixguiWBfL
         pV23gH7VchMz6pZ39aA32Gl5bdbyjRzSr7j4CZtZKi7wTqYiumPazlUCYDPYpTwL7qbR
         tMpSNEAnPDCcuRT6uRBQ49r93/rFWPxeCq9nii+tkpyfDzGkAraFLzCG4o2BcOcNGINJ
         1eevK84UDF01Dn4BEOQPc09w+SffM/PuBPYD9SoSRaxMww/uzmxef1fXaEPBTJ/nPi7Q
         SMVg==
X-Gm-Message-State: AOAM531w3BY86XUHHRsitq+qgwTrk81fZA6bk9CblvQPBYjrGJXYFr8I
        D7FnKYJ57wxZ9Kizgn40tjKdyECwOpg9zl9cpsVgkWQpHLc=
X-Google-Smtp-Source: ABdhPJzxRHHCBlqNA0kd9DowFvps1I/s4YnaTlhdkSEgHi+JH4x0MhlTBOatlp7o6Uqxdm/pBG3QQsso3DTz7jGGogI=
X-Received: by 2002:aca:4c1:: with SMTP id 184mr15863763oie.157.1608664426224;
 Tue, 22 Dec 2020 11:13:46 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Dec 2020 20:13:35 +0100
Message-ID: <CAJZ5v0iS-Dv2iRkVGPhOLiP5-5D1vx+=9Nr7rtKtVbWmdrx=pg@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v5.11-rc1
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
 pm-5.11-rc1-2

with top-most commit c3a74f8e25e97166ca0f954414825ae98a3209f6

 Merge branch 'pm-cpufreq'

on top of commit b4ec805464a4a0299216a003278351d0b4806450

 Merge tag 'pm-5.11-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more power management updates for 5.11-rc1.

These update the CPPC cpufreq driver and intel_pstate (which
involves updating the cpufreq core and the schedutil governor)
and make janitorial changes in the ACPI code handling processor
objects.

Specifics:

 - Rework the passive-mode "fast switch" path in the intel_pstate
   driver to allow it receive the minimum (required) and target
   (desired) performance information from the schedutil governor so
   as to avoid running some workloads too fast (Rafael Wysocki).

 - Make the intel_pstate driver allow the policy max limit to be
   increased after the guaranteed performance value for the given
   CPU has increased (Rafael Wysocki).

 - Clean up the handling of CPU coordination types in the CPPC
   cpufreq driver and make it export frequency domains information
   to user space via sysfs (Ionela Voinescu).

 - Fix the ACPI code handling processor objects to use a correct
   coordination type when it fails to map frequency domains and drop
   a redundant CPU map initialization from it (Ionela Voinescu, Punit
   Agrawal).

Thanks!


---------------

Ionela Voinescu (5):
      ACPI: processor: fix NONE coordination for domain mapping failure
      cppc_cpufreq: use policy->cpu as driver of frequency setting
      cppc_cpufreq: clarify support for coordination types
      cppc_cpufreq: expose information on frequency domains
      cppc_cpufreq: replace per-cpu data array with a list

Punit Agrawal (1):
      ACPI: processor: Drop duplicate setting of shared_cpu_map

Rafael J. Wysocki (4):
      cpufreq: schedutil: Add util to struct sg_cpu
      cpufreq: Add special-purpose fast-switching callback for drivers
      cpufreq: intel_pstate: Implement the ->adjust_perf() callback
      cpufreq: intel_pstate: Use most recent guaranteed performance values

---------------

 Documentation/ABI/testing/sysfs-devices-system-cpu |   3 +-
 drivers/acpi/cppc_acpi.c                           | 141 ++++++--------
 drivers/acpi/processor_perflib.c                   |   3 +-
 drivers/cpufreq/cppc_cpufreq.c                     | 204 ++++++++++++---------
 drivers/cpufreq/cpufreq.c                          |  40 ++++
 drivers/cpufreq/intel_pstate.c                     |  86 +++++++--
 include/acpi/cppc_acpi.h                           |   6 +-
 include/linux/cpufreq.h                            |  14 ++
 include/linux/sched/cpufreq.h                      |   5 +
 kernel/sched/cpufreq_schedutil.c                   | 106 ++++++++---
 10 files changed, 388 insertions(+), 220 deletions(-)
