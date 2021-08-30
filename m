Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37253FBC9B
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Aug 2021 20:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhH3Spc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Aug 2021 14:45:32 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:45587 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhH3Spc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Aug 2021 14:45:32 -0400
Received: by mail-ot1-f49.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso19547158otv.12;
        Mon, 30 Aug 2021 11:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=MMPiX+M8m/mnPpiclZ7Dkh794b6tZKCldJgp5Yf1a70=;
        b=Dm7YDCtZ1Hg5KzBoFC1QptrohUBh5XHHJ+CzUFRpkgmMvWZcRBjRksIl8C8DZ8nHe/
         0A7F3ipzhGMyqB3csxbK5ZbSlGUZTAXOPWVH1dXRBnV1E+mYyai+W5aoef4eA+MVLUVC
         CzvoZ+j0PkesorgmhkJjwaUH48AbPnhaHhTVEG1WI8P1GYvSlKvSiL6sg7vgBn0dhGcw
         Y/KkZ1HFuw5Uz1SiLnM+6AlgprwJEreCdCs9CgYO4NRgkE+OxQGcKKIBoevjkgjgLJ/i
         DBsntNeD1ou7rbplY7aPdpOgXcqyXWUXz1/Q4MZVzgJE3ZFotwJlbzC6NRgY6VpVzKpe
         P0pQ==
X-Gm-Message-State: AOAM5312sA7i/cR9HmgVFwppM6b6FTS1zYLUfUOhTLtBeOJVLRGgeYq1
        jd453RwUQj9DPIX4ASNWJ/GP13vM2eylBFeEqE8pju1nfWqljQ==
X-Google-Smtp-Source: ABdhPJxzVFLsOue37ehaRD7u+/UfRY3ZpRqcW6sQ3RZ+kBz12C37C4yIT1HSaZzqFyrDVlQ6NvU18k1QlH3f3oRGXRc=
X-Received: by 2002:a9d:7115:: with SMTP id n21mr15536721otj.321.1630349077953;
 Mon, 30 Aug 2021 11:44:37 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 30 Aug 2021 20:44:27 +0200
Message-ID: <CAJZ5v0hydPvLrqEuHhxAOp3fUVqA6hiKGbGXgch5xADfQiM-Tg@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v5.15-rc1
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
 acpi-5.15-rc1

with top-most commit 2cbd40709a9d44b8b0d418589de12efad6f71c15

 Merge branches 'acpi-osl', 'acpi-power' and 'acpi-misc'

on top of commit 294c34e704e78d641b039064ce72d4531afe0088

 media: ipu3-cio2: Drop reference on error path in cio2_bridge_connect_sensor()

to receive ACPI updates for 5.15-rc1.

These update the ACPICA kernel code to upstream revision 20210730,
clean up the ACPI companion binding code, optimize the I2C handling
in the XPower PMIC driver, add 16550-compatible Serial Port Subtype
support to the SPCR parsing code, add a few LoongArch support bits,
add a ne quirk to the button driver, add new PCH FIVR methods to
the DPTF code, replace deprecated CPU-hotplug functions in the
processor driver, improve the acpi_os_map_memory() handling on
non-x86 and do some assorted cleanups.

Specifics:

 - Update ACPICA code in the kernel to upstream revision 20210730
   including the following changes:
   * Add support for the AEST table (data compiler) to iASL (Bob
     Moore).
   * Fix an if statement (add parens) (Bob Moore).
   * Drop trailing semicolons from some macros (Bob Moore).
   * Fix compilation of WPBT table with no command-line arguments
     in iASL (Bob Moore).
   * Add method name "_DIS" for use with aslmethod.c (Bob Moore).
   * Add new DBG2 Serial Port Subtypes (Marcin Wojtas).

 - Add new PCH FIVR methods to the DPTF code (Srinivas Pandruvada).

 - Add support for the new 16550-compatible Serial Port Subtype to
   the SPCR table parsing code (Marcin Wojtas).

 - Add DMI quirk for Lenovo Yoga 9 (14INTL5) to the ACPI button
   driver (Ulrich Huber).

 - Add LoongArch support for ACPI_PROCESSOR/ACPI_NUMA (Huacai Chen).

 - Add memory semantics to acpi_os_map_memory() (Lorenzo Pieralisi).

 - Replace deprecated CPU-hotplug functions in the ACPI processor
   driver (Sebastian Andrzej Siewior).

 - Optimize I2C-bus handling in the XPower PMIC driver (Hans de Goede).

 - Make platform-profile catch profile changes initiated by user space
   and notify user processes of them (Hans de Goede).

 - Clean up the ACPI companion binding and unbinding code and update
   debug messaging in the ACPI power resources code (Rafael Wysocki).

 - Clean up a couple of code pieces related to configfs (Andy
   Shevchenko).

 - Rearrange the FPDT table parsing code to avoid printing warning
   messages for reserved record types (Adrian Huang).

Thanks!


---------------

Adrian Huang (1):
      ACPI: tables: FPDT: Do not print FW_BUG message if record types
are reserved

Andy Shevchenko (2):
      ACPI: configfs: Use sysfs_emit() in "show" functions
      ACPI: configfs: Make get_header() to return error pointer

Bob Moore (6):
      ACPICA: iASL: Add support for the AEST table (data compiler)
      ACPICA: Fix an if statement (add parens)
      ACPICA: Macros should not use a trailing semicolon
      ACPICA: iASL: Fix for WPBT table with no command-line arguments
      ACPICA: Add method name "_DIS" For use with aslmethod.c
      ACPICA: Update version to 20210730

Hans de Goede (3):
      ACPI / PMIC: XPower: optimize I2C-bus accesses
      ACPI / PMIC: XPower: optimize MIPI PMIQ sequence I2C-bus accesses
      ACPI: platform-profile: call sysfs_notify() from platform_profile_store()

Huacai Chen (1):
      ACPI: Add LoongArch support for ACPI_PROCESSOR/ACPI_NUMA

Lorenzo Pieralisi (1):
      ACPI: Add memory semantics to acpi_os_map_memory()

Marcin Wojtas (2):
      ACPICA: Headers: Add new DBG2 Serial Port Subtypes
      ACPI: SPCR: Add support for the new 16550-compatible Serial Port Subtype

Rafael J. Wysocki (8):
      ACPI: glue: Rearrange acpi_device_notify()
      ACPI: glue: Change return type of two functions to void
      ACPI: bus: Rename functions to avoid name collision
      ACPI: glue: Eliminate acpi_platform_notify()
      software nodes: Split software_node_notify()
      driver core: Split device_platform_notify()
      ACPI: power: Use acpi_handle_debug() to print debug messages
      ACPI: power: Drop name from struct acpi_power_resource

Sebastian Andrzej Siewior (1):
      ACPI: processor: Replace deprecated CPU-hotplug functions

Srinivas Pandruvada (1):
      ACPI: DPTF: Add new PCH FIVR methods

Ulrich Huber (1):
      ACPI: button: Add DMI quirk for Lenovo Yoga 9 (14INTL5)

---------------

 Documentation/ABI/testing/sysfs-platform-dptf    |  40 ++++++
 Documentation/ABI/testing/sysfs-platform_profile |   7 +
 arch/arm64/include/asm/acpi.h                    |   3 +
 arch/arm64/kernel/acpi.c                         |  19 ++-
 drivers/acpi/Kconfig                             |   4 +-
 drivers/acpi/acpi_configfs.c                     |  54 +++----
 drivers/acpi/acpi_fpdt.c                         |   7 +-
 drivers/acpi/acpi_pad.c                          |   4 +-
 drivers/acpi/acpi_processor.c                    |   8 +-
 drivers/acpi/acpica/dswexec.c                    |   5 +-
 drivers/acpi/bus.c                               |  12 +-
 drivers/acpi/button.c                            |  11 ++
 drivers/acpi/dptf/dptf_pch_fivr.c                |   9 ++
 drivers/acpi/glue.c                              |  51 ++-----
 drivers/acpi/numa/Kconfig                        |   2 +-
 drivers/acpi/numa/srat.c                         |   2 +-
 drivers/acpi/osl.c                               |  23 ++-
 drivers/acpi/platform_profile.c                  |   3 +
 drivers/acpi/pmic/intel_pmic_xpower.c            |  47 ++++++-
 drivers/acpi/power.c                             |  38 +++--
 drivers/acpi/processor_idle.c                    |   4 +-
 drivers/acpi/spcr.c                              |   1 +
 drivers/base/base.h                              |   3 +
 drivers/base/core.c                              |  35 +++--
 drivers/base/swnode.c                            |  61 ++++----
 include/acpi/acnames.h                           |   1 +
 include/acpi/acoutput.h                          |   2 +-
 include/acpi/acpi_io.h                           |   8 ++
 include/acpi/acpixf.h                            |   2 +-
 include/acpi/actbl1.h                            |  16 ++-
 include/acpi/actbl2.h                            | 170 +++++++++++++++++++++++
 include/acpi/actbl3.h                            |   4 +
 include/linux/acpi.h                             |  12 +-
 include/linux/property.h                         |   2 -
 34 files changed, 491 insertions(+), 179 deletions(-)
