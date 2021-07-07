Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0043BF01A
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jul 2021 21:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhGGTSR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Jul 2021 15:18:17 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:38568 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhGGTSQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Jul 2021 15:18:16 -0400
Received: by mail-oi1-f181.google.com with SMTP id t3so4650054oic.5;
        Wed, 07 Jul 2021 12:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=VS+OavrM7FmP/g20PDOoldlmx3b2KcPSPd27JXFo4F4=;
        b=X6Vesw7+jfSbnDY9jsXvP/5/bVIIZDGsNy9YQtP5/xdo4C24ZL7sbYsR9TlA/8NM/Y
         TeBMlkAUSCGrjk28HXvzuXd43hEqcHQIexMHEyndRcuWQcVPV8wEu44vbBLGTaXCF8Og
         WOcBBpXnGyKxmE3aK92v8bkWOMC5PEugYodVBeUtIv6KPPgoRLRZOANMR2HuMnpLOAsI
         KjpcbgB5siv48hYnljRqNDzIpdW3JdZJ+evdxUK/GNJ8Eat5sm+e0wmFjGb65vY2XXYV
         aNtEclZGOWhSC+OpF6mVMXBi4kAfEEPVngOGcrik7nEtTY2oIN2sBsEtRFo9E+jyBnNk
         widQ==
X-Gm-Message-State: AOAM533VN/99n+RHaR5XBZM+Ln3wNbV6O2yhQBr4mQsMWX8wsZ5coVmr
        Pw2mX3kXGBR3ldWPijkfuy0qPb43MDfp0vLhFzf0Se7Hqgo=
X-Google-Smtp-Source: ABdhPJwU7hf6NL7lCQJehECFecihPzycPteoe/6+wmp+h/fTpcxXTg+wuVfUbAtw060jgznxxAmzjvlZbb0nAXPITV4=
X-Received: by 2002:aca:c457:: with SMTP id u84mr10568372oif.69.1625685334843;
 Wed, 07 Jul 2021 12:15:34 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Jul 2021 21:15:24 +0200
Message-ID: <CAJZ5v0ijscuK9x8CbGR1ak2Gdox6J1fzyFrTgYoS-AGca=peuQ@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v5.14-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.14-rc1-2

with top-most commit 166fdb4dd05f2e9f3b3d347682ab6d1b679b362d

 Merge branches 'acpi-misc', 'acpi-video' and 'acpi-prm'

on top of commit 5e6928249b81b4d8727ab6a4037a171d15455cb0

 Merge tag 'acpi-5.14-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more ACPI updates for 5.14-rc1.

These include fixes of the recently introduced support for the
Platform Runtime Mechanism (PRM) feature, a new backlight quirk,
a suspend-to-idle wakeup fix for non-Intel platforms and a fix
for the AMBA bus resource list in /proc/iomem.

Specifics:

 - Fix up the recently added Platform Runtime Mechanism (PRM)
   support by correcting a couple of implementation mistakes in it
   and adding a Kconfig help text to describe it (Aubrey Li,
   Rafael Wysocki).

 - Add backlight quirk for Dell Vostro 3350 (Hans de Goede).

 - Avoid spurious wakeups from suspend-to-idle on non-Intel platforms
   by restricting special EC GPE handling to the Intel ones (Mario
   Limonciello).

 - Modify the AMBA bus support in ACPI to avoid adding invalid
   resource names in /proc/iomem (Liguang Zhang).

Thanks!


---------------

Aubrey Li (2):
      ACPI: Correct \_SB._OSC bit definition for PRM
      ACPI: Do not singal PRM support if not enabled

Hans de Goede (1):
      ACPI: video: Add quirk for the Dell Vostro 3350

Liguang Zhang (1):
      ACPI: AMBA: Fix resource name in /proc/iomem

Mario Limonciello (1):
      ACPI: PM: Only mark EC GPE for wakeup on Intel systems

Rafael J. Wysocki (1):
      ACPI: Kconfig: Provide help text for the ACPI_PRMT option

---------------

 drivers/acpi/Kconfig      | 10 ++++++++++
 drivers/acpi/acpi_amba.c  |  1 +
 drivers/acpi/acpi_video.c |  9 +++++++++
 drivers/acpi/bus.c        |  3 ++-
 drivers/acpi/x86/s2idle.c | 12 ++++++++----
 include/linux/acpi.h      |  2 +-
 6 files changed, 31 insertions(+), 6 deletions(-)
