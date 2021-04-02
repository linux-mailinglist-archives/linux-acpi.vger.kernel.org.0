Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F394352D5E
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Apr 2021 18:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbhDBQEX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Apr 2021 12:04:23 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:42564 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbhDBQEW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Apr 2021 12:04:22 -0400
Received: by mail-ot1-f49.google.com with SMTP id c24-20020a9d6c980000b02902662e210895so4816192otr.9;
        Fri, 02 Apr 2021 09:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=PrQRLRn2ct06WLsFZJjMQX1v2JVaCYrntTHiGrGlQe0=;
        b=LV60RRc0nS/KyGQ42f9T1bA4pDemjQ/1Oy4LTOVee8+zaPo1B+76qz32uW32/7gWBI
         ZDkZn413DgSpz9sKt0eur7Ao5yWj3ebRygJZddy7tIqslbOUxPZ0tmxP+kMiU+r2t5B1
         uLb8GK+sLni/8XlbG0lx/pfDWA1BHfXkrdVoYh5dxvFYkZS0U10jP8M4EntLUQemLy/3
         PPVbBtEEon2mm6n317i/m41HKr+8NUD0yKLxodaHXy+nb50GbKGD5d2cWArspXhTsSIK
         5snpG8UMq5w4ATxSXuZmikeiKSJhIx4lIfStPyLOYSmI5R1lIuBh4MsbWgezQzj4z8B8
         mFUQ==
X-Gm-Message-State: AOAM533Buexzeel2K5YyYZ+74S9K+hCYpWUBOcu8dOmztDGIXm22deIL
        thZKjYETw9mZ2Skv0p4pEWI+/d7kYF4u1dugIhA=
X-Google-Smtp-Source: ABdhPJwajwbSju3nIDlrmi/53fbf5nGKmee539O3yCQChTyV0VBBs9D/eD27xqT7ji/mNTB2NxZKOiT2cYrny/Pe1ns=
X-Received: by 2002:a05:6830:55b:: with SMTP id l27mr11111584otb.260.1617379460876;
 Fri, 02 Apr 2021 09:04:20 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Apr 2021 18:04:09 +0200
Message-ID: <CAJZ5v0i0xTJfQuS5QK1Mkc-wkBAf1F4ga=tuNLrp9uHcQPUKNw@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v5.12-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.12-rc6

with top-most commit 91463ebff32d3e6fc71134784ae6aa91402bfe3d

 Merge branches 'acpi-tables' and 'acpi-scan'

on top of commit a5e13c6df0e41702d2b2c77c8ad41677ebb065b3

 Linux 5.12-rc5

to receive ACPI fixes for 5.12-rc6.

These fix an ACPI tables management issue, an issue related to the
ACPI enumeration of devices and CPU wakeup in the ACPI processor
driver.

Specifics:

 - Ensure that the memory occupied by ACPI tables on x86 will always
   be reserved to prevent it from being allocated for other purposes
   which was possible in some cases (Rafael Wysocki).

 - Fix the ACPI device enumeration code to prevent it from attempting
   to evaluate the _STA control method for devices with unmet
   dependencies which is likely to fail (Hans de Goede).

 - Fix the handling of CPU0 wakeup in the ACPI processor driver to
   prevent CPU0 online failures from occurring (Vitaly Kuznetsov).

Thanks!


---------------

Hans de Goede (1):
      ACPI: scan: Fix _STA getting called on devices with unmet dependencies

Rafael J. Wysocki (1):
      ACPI: tables: x86: Reserve memory occupied by ACPI tables

Vitaly Kuznetsov (1):
      ACPI: processor: Fix CPU0 wakeup in acpi_idle_play_dead()

---------------

 arch/x86/include/asm/smp.h    |  1 +
 arch/x86/kernel/acpi/boot.c   | 25 ++++++++++++-------------
 arch/x86/kernel/setup.c       |  8 +++-----
 arch/x86/kernel/smpboot.c     |  2 +-
 drivers/acpi/processor_idle.c |  7 +++++++
 drivers/acpi/scan.c           | 12 +++++++++++-
 drivers/acpi/tables.c         | 42 +++++++++++++++++++++++++++++++++++++++---
 include/linux/acpi.h          |  9 ++++++++-
 8 files changed, 82 insertions(+), 24 deletions(-)
