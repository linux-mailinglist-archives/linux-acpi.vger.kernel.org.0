Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC5B2975CE
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Oct 2020 19:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753483AbgJWRbg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Oct 2020 13:31:36 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35791 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461620AbgJWRbg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Oct 2020 13:31:36 -0400
Received: by mail-ot1-f68.google.com with SMTP id n11so2086202ota.2;
        Fri, 23 Oct 2020 10:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hT2i530CLOTYlwicvZdH7tp3aHwzMHf9nt1Ew4Fstvo=;
        b=hnO15ku5wZHPvJlsSylvO3RWP2DEubFoFuXSXXICmfN89WXc5QsuOlIWezc6B/HG1r
         Dope8V4tEgHCUzdv3k+I5eJ+VWL3vUfVqP2YDjD5pkc4x1qNKubCWDq8HZUS1xUHVEc6
         0+RrhCeszmGlhnaHlJJsuWxdV/oPgmduBw4MVs+n2+PCKzLkNuLJaUFKc+AKXfZeObY8
         x/NYA54cIf+tbANVR52A4qZwf3WE46dDw5c3fXvac4hCRvLR+Z+T/eYvWW7rcndC2HJ9
         llWu2SdvGBt+RSjYtjxkO9Mc+0TDi76SObYnb1Qll/4b/Uew33gtbPRMbLgGyMRVWBUs
         9KhQ==
X-Gm-Message-State: AOAM530Vdo5ZpSGTueGIN5p89tEEaSiVYSrWJQp6YCb23xIB3EvtKGfP
        VwSgHjMZ6fG7kbEZ1MDuPVCvdUw6fse6dKn94cAZPr0YPOw=
X-Google-Smtp-Source: ABdhPJzVYBjwtKKMSaTxsR2lpJzPEyvQmO1p2eGiFjZwKiH1xkc5Qno4uWu9/C0hyRYhPno/hIgTeQomUf4GVHlbJ/Q=
X-Received: by 2002:a9d:734f:: with SMTP id l15mr2649488otk.260.1603474295544;
 Fri, 23 Oct 2020 10:31:35 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 23 Oct 2020 19:31:24 +0200
Message-ID: <CAJZ5v0hSpDBUG34ahJDQqs4u+io9x5HBSy6wq15RENG6ci3cJA@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v5.10-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.10-rc1-2

with top-most commit 2818cc745445ae5866598fe45fe563ef843e30af

 Merge branches 'acpi-debug', 'acpi-reboot', 'acpi-processor',
'acpi-dptf' and 'acpi-utils'

on top of commit cf1d2b44f6c701ffff58606b5b8a8996190d6e7d

 Merge tag 'acpi-5.10-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more ACPI updates for 5.10-rc1.

These include an ACPICA code build fix related to recent GPE register
access changes, a Kconfig cleanup related to the Dynamic Platform and
Thremal Framework (DPTF) support, a reboot issue workaround, a debug
module fix and a couple of janitorial changes.

Specifics:

 - Fix ACPICA code build after recent changes related to accessing
   GPE registers (Rafael Wysocki).

 - Clean up DPTF part of the ACPI Kconfig (Rafael Wysocki).

 - Work around a reboot issue related to RESET_REG (Zhang Rui).

 - Prevent ACPI debug module from attempting to run (and crashing)
   when ACPI is disabled (Jamie Iles).

 - Drop confusing comment from the ACPI processor driver (Alex Hung).

 - Drop a few unreachable break statements (Tom Rix).

Thanks!


---------------

Alex Hung (1):
      ACPI: processor: remove comment regarding string _UID support

Jamie Iles (1):
      ACPI: debug: don't allow debugging when ACPI is disabled

Rafael J. Wysocki (3):
      ACPI: DPTF: Fix participant driver names
      ACPI: DPTF: Add ACPI_DPTF Kconfig menu
      ACPICA: Add missing type casts in GPE register access code

Tom Rix (1):
      ACPI: utils: remove unreachable breaks

Zhang Rui (1):
      ACPI: reboot: Avoid racing after writing to ACPI RESET_REG

---------------

 drivers/acpi/acpi_dbg.c           |  3 +++
 drivers/acpi/acpi_processor.c     |  1 -
 drivers/acpi/acpica/hwgpe.c       |  4 ++--
 drivers/acpi/dptf/Kconfig         | 29 ++++++++++++++++++++++++-----
 drivers/acpi/dptf/dptf_pch_fivr.c |  2 +-
 drivers/acpi/dptf/dptf_power.c    |  2 +-
 drivers/acpi/reboot.c             | 11 +++++++++++
 drivers/acpi/utils.c              |  4 ----
 8 files changed, 42 insertions(+), 14 deletions(-)
