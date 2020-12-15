Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EAB2DB2F8
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Dec 2020 18:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbgLORqe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Dec 2020 12:46:34 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46515 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730540AbgLORqY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Dec 2020 12:46:24 -0500
Received: by mail-ot1-f67.google.com with SMTP id w3so20185262otp.13;
        Tue, 15 Dec 2020 09:46:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=oqtGwAPR2d4Wt18zLy0GHQ0zDKO3/YFV3oFzfCY361k=;
        b=J1CDNTrnbOA3lNVeR+gNVN4BVAMDmN9i+hlMTi/HdjWdMS6zxLg5BBXfNUZgNnIVa7
         SrN/ReeE2Jm7G+3oZC9uPr19CgzRMtlEc/9UtqRDvJkW4xGxmhtUIbbcShbT4tx2PHrd
         l89QjT807ZAVS96hqjf9FBN6/QvArX3xK4igFHFknFEdT2F3sK+QeivdU17HhNy/d6Jo
         eYTr3LIpLHRr++68HWUOs/X9o0D3SG9qobw3kPHUK1hbJN/PN//lBKWJDvsTHKMwrkmM
         32LJBtAphC5rFmyGScw2+p2ecamC8OuzdazdqCWpAEJxGsGm5F/eaL7ikqjj3M2XZH9M
         xoCg==
X-Gm-Message-State: AOAM531fqmLReTERCk9waRtysg5IHD0jxFAkBPux703LKayH2Fcm8DQc
        TdasgQ9SiWIBGugBq28jSSfBoNFJvV9dS+ULPq0=
X-Google-Smtp-Source: ABdhPJyVimQBFRbftoy4obgC+/i7NzFayfIM+t1TboJrso9xO5OyuJedjVnMLuPEQoTKIlzt61n1a1Hg75HlSnkXyVg=
X-Received: by 2002:a9d:208a:: with SMTP id x10mr22087576ota.260.1608054342627;
 Tue, 15 Dec 2020 09:45:42 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Dec 2020 18:45:31 +0100
Message-ID: <CAJZ5v0gEDn2QvKwRWWtAJDCdiL4yM3_KKnAKu7pjyiT-OyF4Ag@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v5.11-rc1
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
 acpi-5.11-rc1

with top-most commit 38a0925c5fc89689433f2a2ad415982397cf626e

 Merge branch 'acpi-ec'

on top of commit 0477e92881850d44910a7e94fc2c46f96faa131f

 Linux 5.10-rc7

to receive ACPI updates for 5.11-rc1.

These update the ACPICA code in the kernel to upstream revision
20201113, fix and clean up some resources manipulation code, extend
the enumeration and gpio-line-names property documentation, clean up
the handling of _DEP during device enumeration, add a new backlight
DMI quirk, clean up transaction handling in the EC driver and make
some assorted janitorial changes.

Specifics:

 - Update ACPICA code in the kernel to upstream revision 20201113
   with changes as follows:

   * Add 5 new UUIDs to the known UUID table (Bob Moore).
   * Remove extraneous "the" in comments (Colin Ian King).
   * Add function trace macros to improve debugging (Erik Kaneda).
   * Fix interpreter memory leak (Erik Kaneda).
   * Handle "orphan" _REG for GPIO OpRegions (Hans de Goede).

 - Introduce resource_union() and resource_intersection() helpers
   and clean up some resource-manipulation code with the help of
   them (Andy Shevchenko).

 - Revert problematic commit related to the handling of resources
   in the ACPI core (Daniel Scally).

 - Extend the ACPI device enumeration documentation and the
   gpio-line-names _DSD property documentation, clean up the
   latter (Flavio Suligoi).

 - Clean up _DEP handling during device enumeration, modify the list
   of _DEP exceptions and the handling of it and fix up terminology
   related to _DEP (Hans de Goede, Rafael Wysocki).

 - Eliminate in_interrupt() usage from the ACPI EC driver (Sebastian
   Andrzej Siewior).

 - Clean up the advance_transaction() routine and related code in
   the ACPI EC driver (Rafael Wysocki).

 - Add new backlight quirk for GIGABYTE GB-BXBT-2807 (Jasper
   St. Pierre).

 - Make assorted janitorial changes in several ACPI-related pieces
   of code (Hanjun Guo, Jason Yan, Punit Agrawal).

Thanks!


---------------

Andy Shevchenko (9):
      resource: Simplify region_intersects() by reducing conditionals
      resource: Group resource_overlaps() with other inline helpers
      resource: Introduce resource_union() for overlapping resources
      resource: Introduce resource_intersection() for overlapping resources
      resource: Add test cases for new resource API
      PCI/ACPI: Replace open coded variant of resource_union()
      ACPI: watchdog: Replace open coded variant of resource_union()
      ASoC: Intel: catpt: Replace open coded variant of resource_intersection()
      resource: provide meaningful MODULE_LICENSE() in test suite

Bob Moore (2):
      ACPICA: Add 5 new UUIDs to the known UUID table
      ACPICA: Update version to 20201113

Colin Ian King (1):
      ACPICA: Remove extreaneous "the" in comments

Daniel Scally (1):
      Revert "ACPI / resources: Use AE_CTRL_TERMINATE to terminate
resources walks"

Erik Kaneda (2):
      ACPICA: Add function trace macros to improve debugging
      ACPICA: Interpreter: fix memory leak by using existing buffer

Flavio Suligoi (3):
      Documentation: ACPI: explain how to use gpio-line-names
      Documentation: ACPI: _DSD: enable hyperlink in final references
      Documentation: ACPI: enumeration: add PCI hierarchy representation

Hanjun Guo (7):
      ACPI: processor: Remove the duplicated ACPI_PROCESSOR_CLASS macro
      ACPI: debug: Remove the not used function
      ACPI: SBS: Simplify the driver init code
      ACPI: SBS: Simplify the code using module_acpi_driver()
      ACPI: tiny-power-button: Simplify the code using module_acpi_driver()
      ACPI: acpi_drivers.h: Remove the leftover dead code
      ACPI: acpi_drivers.h: Update the kernel doc

Hans de Goede (3):
      ACPICA: Also handle "orphan" _REG methods for GPIO OpRegions
      ACPI: scan: Add acpi_info_matches_hids() helper
      ACPI: scan: Call acpi_get_object_info() from acpi_add_single_object()

Jason Yan (1):
      ACPI, APEI: make apei_resources_all static

Jasper St. Pierre (1):
      ACPI: video: Add DMI quirk for GIGABYTE GB-BXBT-2807

Punit Agrawal (1):
      ACPI: processor: Drop duplicate setting of shared_cpu_map

Rafael J. Wysocki (8):
      ACPI: EC: Fold acpi_ec_clear_gpe() into its caller
      ACPI: EC: Rename acpi_ec_is_gpe_raised()
      ACPI: EC: Simplify error handling in advance_transaction()
      ACPI: EC: Untangle error handling in advance_transaction()
      ACPI: EC: Clean up status flags checks in advance_transaction()
      ACPI: scan: Add PNP0D80 to the _DEP exceptions list
      ACPI: scan: Drop INT3396 from acpi_ignore_dep_ids[]
      ACPI: scan: Fix up _DEP-related terminology with supplier/consumer

Sebastian Andrzej Siewior (1):
      ACPI: EC: Eliminate in_interrupt() usage

---------------

 Documentation/firmware-guide/acpi/dsd/leds.rst     |   8 +-
 Documentation/firmware-guide/acpi/enumeration.rst  | 154 +++++++++++++++++++++
 .../firmware-guide/acpi/gpio-properties.rst        |  56 +++++++-
 drivers/acpi/acpi_dbg.c                            |   7 -
 drivers/acpi/acpi_watchdog.c                       |   6 +-
 drivers/acpi/acpica/accommon.h                     |   2 +-
 drivers/acpi/acpica/evregion.c                     |  54 ++++----
 drivers/acpi/acpica/nspredef.c                     |  10 +-
 drivers/acpi/acpica/nsprepkg.c                     |  38 ++---
 drivers/acpi/acpica/nsrepair2.c                    |  39 +++---
 drivers/acpi/apei/apei-base.c                      |   2 +-
 drivers/acpi/ec.c                                  | 117 +++++++---------
 drivers/acpi/internal.h                            |   3 +-
 drivers/acpi/pci_root.c                            |   4 +-
 drivers/acpi/power.c                               |   2 +-
 drivers/acpi/processor_idle.c                      |   1 -
 drivers/acpi/processor_perflib.c                   |   2 -
 drivers/acpi/processor_thermal.c                   |   2 -
 drivers/acpi/processor_throttling.c                |   1 -
 drivers/acpi/resource.c                            |   2 +-
 drivers/acpi/sbs.c                                 |  24 +---
 drivers/acpi/scan.c                                |  78 ++++++++---
 drivers/acpi/tiny-power-button.c                   |   4 +-
 drivers/acpi/video_detect.c                        |   7 +
 include/acpi/acpi_drivers.h                        |  12 +-
 include/acpi/acpixf.h                              |   2 +-
 include/acpi/acuuid.h                              |   5 +
 include/linux/ioport.h                             |  34 ++++-
 kernel/Makefile                                    |   1 +
 kernel/resource.c                                  |  10 +-
 kernel/resource_kunit.c                            | 152 ++++++++++++++++++++
 lib/Kconfig.debug                                  |  11 ++
 sound/soc/intel/catpt/core.h                       |  11 --
 sound/soc/intel/catpt/loader.c                     |   2 +-
 34 files changed, 612 insertions(+), 251 deletions(-)
