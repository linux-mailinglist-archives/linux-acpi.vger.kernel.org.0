Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0B33DBE8B
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jul 2021 20:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhG3SxA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Jul 2021 14:53:00 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:44022 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhG3SxA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Jul 2021 14:53:00 -0400
Received: by mail-oi1-f174.google.com with SMTP id z26so14479444oih.10;
        Fri, 30 Jul 2021 11:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=RuHOO+tvlD2YfqaGK+Oz0rBM0rH5c8DYOmI/fOMJusE=;
        b=b/oKOmMSo1GyTiHC94odEcxNx/I82/WOX15HRyKG0zi1IZi63P/qAHNYpv/FAIJphX
         UL4BQuXH98HG6rU4xePdui+D2s0r2EBtTO0cSFlzWTdwMVUZzl1mVqdOPttSZ5V3Pvd4
         16mTOQLXKUIrGR4ii5Neb8ru3LGe1fOMDCdgTsqFSLLmsV6oeI0JQ2Yy7vvUlOLNxBvb
         p5wtGqb5PJw1jCEjuQQO8TgXPuGy2/jhBhMpNbDgiUuL9TP6aTq2VPptVNZm1fC0T6N4
         3FIJAhrfvYvXlYB5M1WMOie7Udb/nIaqjHaRAWjGWeV/3iK2oayKN6UCEpdlkB6old7Z
         /ydQ==
X-Gm-Message-State: AOAM5304f2LeUHW/6gKTvivAZxT1pXG05BvqCp7oJTwovq0U5BDhTbfM
        OlEx6ylTory0Gcap2ddbKBBqjFpV2nrgQaQ5ytRkJQtSB6E=
X-Google-Smtp-Source: ABdhPJyPsVCLDmYR9zFPb5UJ5xtrAa2d5QTnBtP1chLNPz6XoDPxB0Qot80b+0JMLgn9/U9GZ+8w/FfJQG3l/bN0juY=
X-Received: by 2002:aca:d7d5:: with SMTP id o204mr2669951oig.69.1627671175176;
 Fri, 30 Jul 2021 11:52:55 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Jul 2021 20:52:44 +0200
Message-ID: <CAJZ5v0h_QSqNjAz9EEp4DBk0jQSE3W+m5niC_7KWgvETwS1Yyg@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v5.14-rc4
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
 acpi-5.14-rc4

with top-most commit e83f54eacf137de228a52c20c74e77f575684600

 Merge branches 'acpi-resources' and 'acpi-dptf'

on top of commit ff1176468d368232b684f75e82563369208bc371

 Linux 5.14-rc3

to receive ACPI fixes for 5.14-rc4.

These revert a recent IRQ resources handling modification that
turned out to be problematic, fix suspend-to-idle handling on
AMD platforms to take upcoming systems into account properly
and fix the retrieval of the DPTF attributes of the PCH FIVR.

Specifics:

 - Revert recent change of the ACPI IRQ resources handling that
   attempted to improve the ACPI IRQ override selection logic, but
   introduced serious regressions on some systems (Hui Wang).

 - Fix up quirks for AMD platforms in the suspend-to-idle support
   code so as to take upcoming systems using uPEP HID AMDI007 into
   account as appropriate (Mario Limonciello).

 - Fix the code retrieving DPTF attributes of the PCH FIVR so that
   it agrees on the return data type with the ACPI control method
   evaluated for this purpose (Srinivas Pandruvada).

Thanks!


---------------

Hui Wang (1):
      Revert "ACPI: resources: Add checks for ACPI IRQ override"

Mario Limonciello (1):
      ACPI: PM: Add support for upcoming AMD uPEP HID AMDI007

Srinivas Pandruvada (1):
      ACPI: DPTF: Fix reading of attributes

---------------

 drivers/acpi/dptf/dptf_pch_fivr.c | 51 +++++++++++++++++++++++++++++++++------
 drivers/acpi/resource.c           |  9 +------
 drivers/acpi/x86/s2idle.c         | 10 ++++++--
 3 files changed, 52 insertions(+), 18 deletions(-)
