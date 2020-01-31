Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38C4E14EA57
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Jan 2020 11:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgAaKBi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 Jan 2020 05:01:38 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45358 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbgAaKBi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Jan 2020 05:01:38 -0500
Received: by mail-oi1-f194.google.com with SMTP id v19so6662016oic.12;
        Fri, 31 Jan 2020 02:01:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=qn10BmEuDVjkBqOHdzIV8xNrO2BJH8fDrRakRfgRhPU=;
        b=ChJQ9MRWVP/MeX0ZO97TzkVYz/YT/8qQMpMGGRlh/cowuwvw3O2TsqebIJJnvNFgzK
         JddZkuvQ/LSZ9uJGxdNBwLurytx0esakkWJNQdjrYgKhwZSDSh7buAaCLw1Ngn002Zf9
         HGey+y0qXSN9QOeevOmG7p3666TRnKwedZyZjQsC98T3nc5IsJLDG4RDWluhkUn/gSZ6
         4ubZLiGGL/5YDCRnYIftLXi9BCCdWzwOhV4LX4hheJKh0zViaQxrZCwDcTpuC5QL5iUk
         HIcGZpCvGPGxzmXXriCDnHaNU44Ub1ArWHwwyxsaYSZsQE5Y0PmDg2RGSG77ENuC4ZYX
         hBvw==
X-Gm-Message-State: APjAAAWBT3/odmoInbNQHPHwChLzDjs+Ho2R604If3UZ1b1/nspDCUK+
        DwtOYPDL14OKfLx+p92BHfBrC32TWi/WW+VdYp332drf
X-Google-Smtp-Source: APXvYqxnchmpm4Ho6//yi2eeApqlgYCPq+/GzJ3WxRUWOnyDTeXsh1w+u/YhJVdhwBi7AaasTYNiR40/j9zKHJCjcpw=
X-Received: by 2002:aca:d6c8:: with SMTP id n191mr5971134oig.103.1580464897490;
 Fri, 31 Jan 2020 02:01:37 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 31 Jan 2020 11:01:26 +0100
Message-ID: <CAJZ5v0h7igCZU43nqcZytEgXsQ4vHYs9CBbGr-uSruj8pwoA+g@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v5.6-rc1
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
 pm-5.6-rc1-2

with top-most commit 82b2c6ffd399c9fcd542fd681bb8c6d41f035c7e

 Merge branches 'pm-cpufreq' and 'pm-core'

on top of commit 6d277aca488fdf0a1e67cd14b5a58869f66197c9

 Merge tag 'pm-5.6-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional power management updates for 5.6-rc1.

These prevent cpufreq from creating excessively large stack frames
and fix the handling of devices deleted during system-wide resume in
the PM core (Rafael Wysocki), revert a problematic commit affecting
the cpupower utility and correct its man page (Thomas Renninger,
Brahadambal Srinivasan), and improve the intel_pstate_tracer utility
(Doug Smythies).

Thanks!


---------------

Brahadambal Srinivasan (1):
      Correction to manpage of cpupower

Doug Smythies (2):
      tools/power/x86/intel_pstate_tracer: changes for python 3 compatibility
      tools/power/x86/intel_pstate_tracer: change several graphs to
autoscale y-axis

Rafael J. Wysocki (2):
      PM: core: Fix handling of devices deleted during system-wide resume
      cpufreq: Avoid creating excessively large stack frames

Thomas Renninger (1):
      cpupower: Revert library ABI changes from commit ae2917093fb60bdc1ed3e

---------------

 drivers/base/power/main.c                          |  42 +++++-
 drivers/cpufreq/cppc_cpufreq.c                     |   2 +-
 drivers/cpufreq/cpufreq-nforce2.c                  |   2 +-
 drivers/cpufreq/cpufreq.c                          | 147 ++++++++++-----------
 drivers/cpufreq/freq_table.c                       |   4 +-
 drivers/cpufreq/gx-suspmod.c                       |   2 +-
 drivers/cpufreq/intel_pstate.c                     |  38 +++---
 drivers/cpufreq/longrun.c                          |   6 +-
 drivers/cpufreq/pcc-cpufreq.c                      |   2 +-
 drivers/cpufreq/sh-cpufreq.c                       |   2 +-
 drivers/cpufreq/unicore2-cpufreq.c                 |   2 +-
 include/linux/cpufreq.h                            |  32 +++--
 tools/power/cpupower/lib/cpufreq.c                 |  78 +++++++++--
 tools/power/cpupower/lib/cpufreq.h                 |  20 ++-
 tools/power/cpupower/man/cpupower.1                |   6 +-
 tools/power/cpupower/utils/cpufreq-info.c          |  12 +-
 .../x86/intel_pstate_tracer/intel_pstate_tracer.py |  38 +++---
 17 files changed, 264 insertions(+), 171 deletions(-)
