Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC8D9197F8D
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Mar 2020 17:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgC3PZy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Mar 2020 11:25:54 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33306 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbgC3PZy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Mar 2020 11:25:54 -0400
Received: by mail-oi1-f195.google.com with SMTP id m14so16043178oic.0;
        Mon, 30 Mar 2020 08:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=kyCcTnDl3sCR2YamC47wuHL3QQ9WaTAgZrp8oHlCizY=;
        b=NvIhXSETJMANyHUDhQi/Htujji7/VvxN2tBWR7Fvg5bWwFXzjvXGS5q75wvHhhANRE
         mcyf2cfWZqtqRSOVotMuM5s9QljMlBzjHOn3Ul2Ko2IfrDbU/tJEtqCzI1n1aB1/dw1W
         wfao1VYn090aOgX8f1n1QdAIqcy/JRIYgojzhdbFnvuCESLV2SDi25mKSGAItjmpFlWu
         eqzzH8n7C7dIExp8ZrkuXUSoJpOEVAIfKzFBMwCF86KlG2vCwiMVf9igh300JTlCEdM5
         SOrwy77xqa5edcO0e8DnNUk7i8S/WUDXFC2+kRfHmeB2wmhKb0q+zQ2UCdTQ5WaG1Fvo
         Jsyw==
X-Gm-Message-State: ANhLgQ3GH50EfCm2pXRCZGuDValkaVL7tvd/9ZKeWJhC4uP3IActCgVq
        n8tqH7/WbOkayJtE32FF4QLIlwgeDKNWMoMZnhdRlKYr
X-Google-Smtp-Source: ADFU+vsS11wLNhl4djuB8zgKBwnZ9aIm2kF2XsfE1jsoudvMLkT4xs7rEAqYulPqdkt+mZPnoVVoDhDvTg+p+TsD5k8=
X-Received: by 2002:aca:f07:: with SMTP id 7mr7678700oip.68.1585581952782;
 Mon, 30 Mar 2020 08:25:52 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 30 Mar 2020 17:25:41 +0200
Message-ID: <CAJZ5v0ja_cmfL2Rwj-k-__B2QjH8kY-t2pM1Tg+yP0A=6kMYSg@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[Resending because of the messed-up subject, sorry.]

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.7-rc1

with top-most commit 1da28f032305383a664e5711ba07b7957901a72e

 Merge branches 'acpi-ec', 'acpi-fan' and 'acpi-pci'

on top of commit 2c523b344dfa65a3738e7039832044aa133c75fb

 Linux 5.6-rc5

to receive ACPI updates for 5.7-rc1.

These update the ACPICA code in the kernel to the 20200214 upstream
release, clean up the initialization of the EC driver, clean up the
quirk tables in the AC and battery drivers, fix the global lock
handling on x86, add a new "tiny" driver for ACPI button devices
exposed by VMs to guest kernels, modify the ACPI PCI host bridge and
fan drivers use scnprintf(), add add a kernel parameter to disable
ACPI BGRT on x86 and do some assorted cleanups.

Specifics:

 - Update the ACPICA code in the kernel to the 20200214 upstream
   release including:

   * Fix to re-enable the sleep button after wakeup (Anchal Agarwal).
   * Fixes for mistakes in comments and typos (Bob Moore).
   * ASL-ASL+ converter updates (Erik Kaneda).
   * Type casting cleanups (Sven Barth).

 - Clean up the intialization of the EC driver and eliminate some
   dead code from it (Rafael Wysocki).

 - Clean up the quirk tables in the AC and battery drivers (Hans de
   Goede).

 - Fix the global lock handling on x86 to ignore unspecified bit
   positions in the global lock field (Jan Engelhardt).

 - Add a new "tiny" driver for ACPI button devices exposed by VMs to
   guest kernels to send signals directly to init (Josh Triplett).

 - Add a kernel parameter to disable ACPI BGRT on x86 (Alex Hung).

 - Make the ACPI PCI host bridge and fan drivers use scnprintf() to
   avoid potential buffer overflows (Takashi Iwai).

 - Clean up assorted pieces of code:

   * Reorder "asmlinkage" to make g++ happy (Alexey Dobriyan).
   * Drop unneeded variable initialization (Colin Ian King).
   * Add missing __acquires/__releases annotations (Jules Irenge).
   * Replace list_for_each_safe() with list_for_each_entry_safe()
     (chenqiwu).

Thanks!


---------------

Alex Hung (1):
      acpi/x86: add a kernel parameter to disable ACPI BGRT

Alexey Dobriyan (1):
      x86/acpi: make "asmlinkage" part first thing in the function definition

Anchal Agarwal (1):
      ACPICA: Enable sleep button on ACPI legacy wake

Bob Moore (4):
      ACPICA: Fix a comment "enable" fixed events -> "disable" all fixed events.
      ACPICA: Table Manager: Update comments in a function header
      ACPICA: Fix a couple of typos
      ACPICA: Update version to 20200214

Colin Ian King (1):
      ACPI: video: remove redundant assignments to variable result

Erik Kaneda (2):
      ACPICA: ASL-ASL+ converter: remove function parameters from
cv_init_file_tree()
      ACPICA: ASL-ASL+ converter: make root file a parameter for
cv_init_file_tree

Hans de Goede (2):
      ACPI / AC: Cleanup DMI quirk table
      ACPI / battery: Cleanup Lenovo Ideapad Miix 320 DMI table entry

Jan Engelhardt (1):
      acpi/x86: ignore unspecified bit positions in the ACPI global lock field

Josh Triplett (2):
      ACPI: button: move HIDs to acpi/button.h
      ACPI: Add new tiny-power-button driver to directly signal init

Jules Irenge (1):
      ACPI: OSL: Add missing __acquires/__releases annotations

Rafael J. Wysocki (9):
      ACPI: EC: Avoid printing confusing messages in acpi_ec_setup()
      ACPI: EC: Avoid passing redundant argument to functions
      ACPI: EC: Drop AE_NOT_FOUND special case from ec_install_handlers()
      ACPI: EC: Simplify acpi_ec_add()
      ACPI: EC: Use fast path in acpi_ec_add() for DSDT boot EC
      ACPI: EC: Consolidate event handler installation code
      ACPI: EC: Simplify acpi_ec_ecdt_start() and acpi_ec_init()
      ACPI: EC: Do not clear boot_ec_is_ecdt in acpi_ec_add()
      ACPI: EC: Eliminate EC_FLAGS_QUERY_HANDSHAKE

Sven Barth (3):
      ACPICA: cast the result of the pointer difference to u32
      ACPICA: cast length arguement to acpi_ns_build_normalized_path() as u32
      ACPICA: use acpi_size instead of u32 for prefix_path_length

Takashi Iwai (2):
      ACPI: fan: Use scnprintf() for avoiding potential buffer overflow
      ACPI: PCI: Use scnprintf() for avoiding potential buffer overflow

chenqiwu (1):
      ACPI: list_for_each_safe() -> list_for_each_entry_safe()

---------------

 Documentation/admin-guide/kernel-parameters.txt |   3 +
 arch/x86/kernel/acpi/boot.c                     |  12 +-
 arch/x86/kernel/acpi/sleep.c                    |   2 +-
 arch/x86/kernel/acpi/sleep.h                    |   2 +-
 drivers/acpi/Kconfig                            |  24 ++
 drivers/acpi/Makefile                           |   1 +
 drivers/acpi/ac.c                               |  25 +-
 drivers/acpi/acpi_video.c                       |   2 +-
 drivers/acpi/acpica/acconvert.h                 |   4 +-
 drivers/acpi/acpica/acmacros.h                  |   4 +-
 drivers/acpi/acpica/evevent.c                   |   2 +-
 drivers/acpi/acpica/hwsleep.c                   |  12 +
 drivers/acpi/acpica/nsnames.c                   |   6 +-
 drivers/acpi/acpica/nsxfname.c                  |   2 +-
 drivers/acpi/acpica/tbxface.c                   |  12 +-
 drivers/acpi/acpica/utobject.c                  |   2 +-
 drivers/acpi/battery.c                          |  10 +-
 drivers/acpi/button.c                           |   3 -
 drivers/acpi/ec.c                               | 312 ++++++++++--------------
 drivers/acpi/fan.c                              |  20 +-
 drivers/acpi/internal.h                         |   2 +-
 drivers/acpi/osl.c                              |   2 +
 drivers/acpi/pci_root.c                         |   2 +-
 drivers/acpi/proc.c                             |  14 +-
 drivers/acpi/tiny-power-button.c                |  46 ++++
 drivers/acpi/wakeup.c                           |  24 +-
 include/acpi/acpixf.h                           |   2 +-
 include/acpi/actbl1.h                           |   2 +-
 include/acpi/button.h                           |   4 +
 29 files changed, 298 insertions(+), 260 deletions(-)
