Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEBD915D578
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2020 11:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgBNKZH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Feb 2020 05:25:07 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43613 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729070AbgBNKZH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Feb 2020 05:25:07 -0500
Received: by mail-oi1-f193.google.com with SMTP id p125so8924810oif.10;
        Fri, 14 Feb 2020 02:25:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=J/ylcXowH9IUbay2pFa/zekk1oZvednUbZRzx4NaqLY=;
        b=Gg2LMxYDDKHkeXiZSi8T2Qoe/jW5qpnGqAoRcgpO9erhnA6U0DRgzW3+ZKLVvR548G
         oH7YOLfbxxxewVbEfeojehjb+hwi+28alB1k5pVGMfBsDzUz8iDwnC33Osbbq9jENbcx
         S5FgKIm0/4AWXFUpvqpMxp/DlolFvls1R523n+6zr64yIJpUIcC8PtZHBGY0x2wAN1Cl
         C3qXMRGdXNEMhfNr7HMcVnxE3gkA023O2QAt7QVNQ4cmBkF2BtRupgbOxaXli36GB/uj
         F7+HihWWYbnTKDm3oYHpX52GtGH/1XUQphmh7n0ZoyDjOljbHksZ35rG2NiR1K4xSv0l
         VOnA==
X-Gm-Message-State: APjAAAVRB7F5XRk4JByQEd5+FdhZMkvrEef0AnrtZuZOPq3HKPWOw5v7
        h4uFMMeWzqF2R6gmIts4CQTJQC3/VjpvDJMiRW8Z8Y6E
X-Google-Smtp-Source: APXvYqw/xXyV8lUVHLdZmTfxQI/QoiAon39/YamwUDTUht0OQpDS41igPTjvp8rgplu89uqrwLEPFjqDiXdtsD5i9Bk=
X-Received: by 2002:aca:d6c8:: with SMTP id n191mr1411911oig.103.1581675906194;
 Fri, 14 Feb 2020 02:25:06 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Feb 2020 11:24:55 +0100
Message-ID: <CAJZ5v0hpEebbSFUFdtRnLWvXhyruzNgNaL9o-Od1a3jkgYRQKg@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.6-rc2
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
 pm-5.6-rc2

with top-most commit 3629ac5b92535793ba6226e243c2324a20c35fae

 Merge branch 'pm-cpufreq'

on top of commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9

 Linux 5.6-rc1

to receive power management fixes for 5.6-rc2.

These fix issues related to the handling of wakeup events signaled
through the ACPI SCI while suspended to idle (Rafael Wysocki) and
unexport an internal cpufreq variable (Yangtao Li).

Thanks!


---------------

Rafael J. Wysocki (4):
      ACPI: EC: Fix flushing of pending work
      ACPI: PM: s2idle: Avoid possible race related to the EC GPE
      ACPICA: Introduce acpi_any_gpe_status_set()
      ACPI: PM: s2idle: Prevent spurious SCIs from waking up the system

Yangtao Li (1):
      cpufreq: Make cpufreq_global_kobject static

---------------

 drivers/acpi/acpica/achware.h |  2 ++
 drivers/acpi/acpica/evxfgpe.c | 32 +++++++++++++++++++
 drivers/acpi/acpica/hwgpe.c   | 71 +++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/ec.c             | 44 ++++++++++++++++-----------
 drivers/acpi/sleep.c          | 50 ++++++++++++++++++++++--------
 drivers/cpufreq/cpufreq.c     |  5 ++-
 include/acpi/acpixf.h         |  1 +
 include/linux/cpufreq.h       |  3 --
 include/linux/suspend.h       |  2 +-
 kernel/power/suspend.c        |  9 +++---
 10 files changed, 177 insertions(+), 42 deletions(-)
