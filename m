Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED9D219F899
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Apr 2020 17:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgDFPLz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Apr 2020 11:11:55 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33658 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728826AbgDFPLz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Apr 2020 11:11:55 -0400
Received: by mail-ot1-f65.google.com with SMTP id 22so15712282otf.0;
        Mon, 06 Apr 2020 08:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=u8ykfgBJGuOLzGB62yjhFp2Guk42jSBAx1kTOapN3Hw=;
        b=AXx4x00jeiy8IsL8cssOGQ5w73CzC+TTKbmqwzOT1y5oEWIyqrRAG6/u9fx36pCPmH
         FyjFKwSHr3sbwU+IXXgNOTQDkKZGYGYwaliGmt0rqIFG9D1+idZZZMTwK4nR70WXmyds
         JZP49og/5lLJDmtYBCoi8RjHLk9RE00ZNfKCKmh6gMeBrxYkItQlJ1MO5hGzwjo/iG9L
         BMSfcwyx8P56K3HNo4JIglJn7sDYY2/1dkyws7IksEdsaR62u8DVc1wb5deCs7PNtxjP
         oqa+qj9+oL6nfy9TsZTK6Tjnx3tR3skA5txeY+I31mixKBElYhTWl5/1CuAPZj7OyqjX
         Rjjg==
X-Gm-Message-State: AGi0PuZBjlvJYyA5J2hq+MkDoi/BBc0J68dbvq1ycDUVdS6W4GkkLVh6
        YuQGOS7pPggHGoEseXTpvhEn1VpdeZXgzXavLTy6c/yJ
X-Google-Smtp-Source: APiQypIMtEUk9Hu/T++tT7xX1wArYeG8PQwsD8mhVKF0nSWAqCSfhREcJlnBumjcakZ4h9vUHgbaoUKCyqcJ+ya1EWc=
X-Received: by 2002:a4a:e08b:: with SMTP id w11mr17889317oos.62.1586185910850;
 Mon, 06 Apr 2020 08:11:50 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 Apr 2020 17:11:39 +0200
Message-ID: <CAJZ5v0ji9p4_whgcJbh6mm8cdYpruHEzOsTqje7JedD45wH5Dg@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.7-rc1-2

with top-most commit 54032b863b56b0e5313bfcd6ef0818943c59c4f4

 Merge branches 'pm-sleep' and 'pm-cpufreq'

on top of commit 2ce94bc4e056d3e48291aac87a95ebd2a86348ba

 Merge tag 'pnp-5.7-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional power management updates for 5.7-rc1.

These fix a corner-case suspend-to-idle wakeup issue on systems
where the ACPI SCI is shared with another wakeup source, add a
kernel command line option to set pm_debug_messages via the kernel
command line, add a document desctibing system-wide suspend and
resume code flows, modify cpufreq Kconfig to choose schedutil as
the preferred governor by default in a couple of cases and do some
assorted cleanups.

Specifics:

 - Fix corner-case suspend-to-idle wakeup issue on systems where
   the ACPI SCI is shared with another wakeup source (Hans de Goede).

 - Add document describing system-wide suspend and resume code flows
   to the admin guide (Rafael Wysocki).

 - Add kernel command line option to set pm_debug_messages (Chen Yu).

 - Choose schedutil as the preferred scaling governor by default on
   ARM big.LITTLE systems and on x86 systems using the intel_pstate
   driver in the passive mode (Linus Walleij, Rafael Wysocki).

 - Drop racy and redundant checks from the PM core's device_prepare()
   routine (Rafael Wysocki).

 - Make resume from hibernation take the hibernation_restore() return
   value into account (Dexuan Cui).

Thanks!


---------------

Chen Yu (1):
      PM: sleep: Add pm_debug_messages kernel command line option

Dexuan Cui (1):
      PM: hibernate: Propagate the return value of hibernation_restore()

Hans de Goede (2):
      ACPI: PM: Add acpi_[un]register_wakeup_handler()
      platform/x86: intel_int0002_vgpio: Use acpi_register_wakeup_handler()

Linus Walleij (1):
      cpufreq: Select schedutil when using big.LITTLE

Rafael J. Wysocki (3):
      cpufreq: intel_pstate: Select schedutil as the default governor
      PM: sleep: core: Drop racy and redundant checks from device_prepare()
      Documentation: PM: sleep: Document system-wide suspend code flows

---------------

 Documentation/admin-guide/kernel-parameters.txt |   3 +
 Documentation/admin-guide/pm/suspend-flows.rst  | 270 ++++++++++++++++++++++++
 Documentation/admin-guide/pm/system-wide.rst    |   1 +
 drivers/acpi/sleep.c                            |   4 +
 drivers/acpi/sleep.h                            |   1 +
 drivers/acpi/wakeup.c                           |  81 +++++++
 drivers/base/power/main.c                       |   7 +-
 drivers/cpufreq/Kconfig                         |   4 +-
 drivers/cpufreq/Kconfig.x86                     |   2 +
 drivers/platform/x86/intel_int0002_vgpio.c      |  10 +
 include/linux/acpi.h                            |   5 +
 kernel/power/hibernate.c                        |   2 +-
 kernel/power/main.c                             |   7 +
 13 files changed, 389 insertions(+), 8 deletions(-)
