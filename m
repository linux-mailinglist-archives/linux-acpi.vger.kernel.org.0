Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7F836B8DA
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Apr 2021 20:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbhDZSZu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Apr 2021 14:25:50 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:45840 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbhDZSZu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Apr 2021 14:25:50 -0400
Received: by mail-ot1-f44.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so47893449otf.12;
        Mon, 26 Apr 2021 11:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=KMCt5AdBW7mmXPSQ6Q38ATS9byQNi7Tz5p4WwkBd5XM=;
        b=EQSuwHMF7geTkp5jtqpX5b6FXnr39Kki1cZFOVTE2M884BRMNxhVJF5vyBZuB7nVLg
         6ZOaMzLvq9piC+KRmstaUweE2v2zwG8NfTxUUG3wFYFi8E5CQkeUDeDHJI+EGmERxJGJ
         aG7YrC1o3GXVT0Pg+HSFWR/ChS691wBNda+yP76UjLnBL2jxVD3VY4mJYjoio1smeJQQ
         /cl9LX/049b/krmkgDAjpQiUBUA9gyu5oDJEaYTdjm/lAohlQLfdStqGPBaK3BWueBsA
         0p4g4j3REwnSB+gbUKHRCoT8+nDOp0snCyiJNPhgSitesRJz48aXzs+MVBJDZFPEF1tU
         /Auw==
X-Gm-Message-State: AOAM530WJJsTA+67w9qy4Y4BhFZD4pM0N5SftbDHZ0Sa8N0BeWPnaSf4
        QKz9C6Q8jiJ0U+aOg0donxAPpStlQdMzyXTEoTP0co/8W4Q=
X-Google-Smtp-Source: ABdhPJyXnTQiW7PL9bYS4frf85uxsHl9DEdVhl1j3IzEELlAVWO0ZjFwrWhbZkSZzR2a45eC4fM02GXYYQY5S8umfzc=
X-Received: by 2002:a9d:5a7:: with SMTP id 36mr16073239otd.321.1619461506733;
 Mon, 26 Apr 2021 11:25:06 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 26 Apr 2021 20:24:55 +0200
Message-ID: <CAJZ5v0jdRxPj-tJaxbOYHXk505NoG1EefSJUmtgso9KGAm3rzg@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v5.13-rc1
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
 acpi-5.13-rc1

with top-most commit b6237f61fc9ca79b8771a4fa412d2c630c9f8d2b

 Merge branch 'acpi-misc'

on top of commit bf05bf16c76bb44ab5156223e1e58e26dfe30a88

 Linux 5.12-rc8

to receive ACPI updates for 5.13-rc1.

These update the ACPICA code in the kernel to the most recent
upstream revision including (but not limited to) new material
introduced in the 6.4 version of the spec, update message printing
in the ACPI-related code, address a few issues and clean up code in
a number of places.

Specifics:

 - Update ACPICA code in the kernel to upstream revision 20210331
   including the following changes:

   * Add parsing for IVRS IVHD 40h and device entry F0h (Alexander
     Monakov).

   * Add new CEDT table for CXL 2.0 and iASL support for it (Ben
     Widawsky, Bob Moore).

   * NFIT: add Location Cookie field (Bob Moore).

   * HMAT: add new fields/flags (Bob Moore).

   * Add new flags in SRAT (Bob Moore).

   * PMTT: add new fields/structures (Bob Moore).

   * Add CSI2Bus resource template (Bob Moore).

   * iASL: Decode subtable type field for VIOT (Bob Moore).

   * Fix various typos and spelling mistakes (Colin Ian King).

   * Add new predefined objects _BPC, _BPS, and _BPT (Erik Kaneda).

   * Add USB4 capabilities UUID (Erik Kaneda).

   * Add CXL ACPI device ID and _CBR object (Erik Kaneda).

   * MADT: add Multiprocessor Wakeup Structure (Erik Kaneda).

   * PCCT: add support for subtable type 5 (Erik Kaneda).

   * PPTT: add new version of subtable type 1 (Erik Kaneda).

   * Add SDEV secure access components (Erik Kaneda).

   * Add support for PHAT table (Erik Kaneda).

   * iASL: Add definitions for the VIOT table (Jean-Philippe Brucker).

   * acpisrc: Add missing conversion for VIOT support (Jean-Philippe
     Brucker).

   * IORT: Updates for revision E.b (Shameer Kolothum).

 - Rearrange message printing in ACPI-related code to avoid using the
   ACPICA's internal message printing macros outside ACPICA and do
   some related code cleanups (Rafael Wysocki).

 - Modify the device enumeration code to turn off all of the unused
   ACPI power resources at the end (Rafael Wysocki).

 - Change the ACPI power resources handling code to turn off unused
   ACPI power resources without checking their status which should
   not be necessary by the spec (Rafael Wysocki).

 - Add empty stubs for CPPC-related functions to be used when
   CONFIG_ACPI_CPPC_LIB is not set (Rafael Wysocki).

 - Simplify device enumeration code (Rafael Wysocki).

 - Change device enumeration code to use match_string() for string
   matching (Andy Shevchenko).

 - Modify irqresource_disabled() to retain the resource flags that
   have been set already (Angela Czubak).

 - Add native backlight whitelist entry for GA401/GA502/GA503 (Luke
   Jones).

 - Modify the ACPI backlight driver to let the native backlight
   handling take over on hardware-reduced systems (Hans de Goede).

 - Introduce acpi_dev_get() and switch over the ACPI core code to
   using it (Andy Shevchenko).

 - Use kobj_attribute as callback argument instead of a local struct
   type in the CPPC library code (Nathan Chancellor).

 - Drop unneeded initialization of a static variable from the ACPI
   processor driver (Tian Tao).

 - Drop unnecessary local variable assignment from the ACPI APEI
   code (Colin Ian King).

 - Document for_each_acpi_dev_match() macro (Andy Shevchenko).

 - Address assorted coding style issues in multiple places (Xiaofei
   Tan).

 - Capitalize TLAs in a few comments (Andy Shevchenko).

 - Correct assorted typos in comments (Tom Saeger).

Thanks!


---------------

Alexander Monakov (1):
      ACPICA: Add parsing for IVRS IVHD 40h and device entry F0h

Andy Shevchenko (4):
      ACPI: scan: Utilize match_string() API
      ACPI: bus: Introduce acpi_dev_get() and reuse it in ACPI code
      ACPI: utils: Document for_each_acpi_dev_match() macro
      ACPI: utils: Capitalize abbreviations in the comments

Angela Czubak (1):
      resource: Prevent irqresource_disabled() from erasing flags

Ben Widawsky (1):
      ACPICA: CXL 2.0: CEDT: Add new CEDT table

Bob Moore (8):
      ACPICA: ACPI 6.4: NFIT: add Location Cookie field
      ACPICA: ACPI 6.4: HMAT: add new fields/flags
      ACPICA: ACPI 6.4: Add new flags in SRAT
      ACPICA: ACPI 6.4: PMTT: add new fields/structures
      ACPICA: ACPI 6.4: add CSI2Bus resource template
      ACPICA: iASL: Add support for CEDT table
      ACPICA: iASL: Decode subtable type field for VIOT
      ACPICA: Update version to 20210331

Colin Ian King (2):
      ACPICA: Tree-wide: fix various typos and spelling mistakes
      ACPI: APEI: remove redundant assignment to variable rc

Erik Kaneda (8):
      ACPICA: ACPI 6.4: Add new predefined objects _BPC, _BPS, and _BPT
      ACPICA: ACPI 6.4: add USB4 capabilities UUID
      ACPICA: ACPI 6.4: add CXL ACPI device ID and _CBR object
      ACPICA: ACPI 6.4: MADT: add Multiprocessor Wakeup Structure
      ACPICA: ACPI 6.4: PCCT: add support for subtable type 5
      ACPICA: ACPI 6.4: PPTT: add new version of subtable type 1
      ACPICA: ACPI 6.4: add SDEV secure access components
      ACPICA: ACPI 6.4: add support for PHAT table

Hans de Goede (2):
      ACPI: utils: Add acpi_reduced_hardware() helper
      ACPI: video: Check LCD flag on ACPI-reduced-hardware devices

Jean-Philippe Brucker (2):
      ACPICA: iASL: Add definitions for the VIOT table
      ACPICA: acpisrc: Add missing conversion for VIOT support

Luke D Jones (1):
      ACPI: video: use native backlight for GA401/GA502/GA503

Nathan Chancellor (1):
      ACPI: CPPC: Replace cppc_attr with kobj_attribute

Rafael J. Wysocki (21):
      ACPI: PCI: IRQ: Consolidate printing diagnostic messages
      ACPI: PCI: Replace ACPI_DEBUG_PRINT() and ACPI_EXCEPTION()
      ACPI: PCI: Drop ACPI_PCI_COMPONENT that is not used any more
      ACPI: PCI: Replace direct printk() invocations in pci_link.c
      ACPI: processor: idle: Drop extra prefix from pr_notice()
      ACPI: processor: Get rid of ACPICA message printing
      ACPI: HED: Drop unused ACPI_MODULE_NAME() definition
      ACPI: sysfs: Get rid of ACPICA message printing
      ACPI: Drop unused ACPI_*_COMPONENT definitions and update documentation
      ACPI: processor: perflib: Eliminate redundant status check
      ACPI: utils: Introduce acpi_evaluation_failure_warn()
      IIO: acpi-als: Get rid of ACPICA message printing
      hwmon: acpi_power_meter: Get rid of ACPICA message printing
      ACPI: scan: Turn off unused power resources during initialization
      ACPI: power: Turn off unused power resources unconditionally
      ACPI: CPPC: Add empty stubs of functions for CONFIG_ACPI_CPPC_LIB unset
      ACPI: scan: Fold acpi_bus_type_and_status() into its caller
      ACPI: scan: Rearrange checks in acpi_bus_check_add()
      ACPI: scan: Drop sta argument from acpi_add_single_object()
      ACPI: scan: Drop sta argument from acpi_init_device_object()
      ACPI: scan: Call acpi_get_object_info() from acpi_set_pnp_ids()

Shameer Kolothum (1):
      ACPICA: IORT: Updates for revision E.b

Tian Tao (1):
      ACPI: processor: Remove initialization of static variable

Tom Saeger (1):
      ACPI: fix various typos in comments

Xiaofei Tan (13):
      ACPI: AC: fix some coding style issues
      ACPI: APD: fix a block comment align issue
      ACPI: processor: fix some coding style issues
      ACPI: ipmi: remove useless return statement for void function
      ACPI: LPSS: add a missed blank line after declarations
      ACPI: acpi_pad: add a missed blank line after declarations
      ACPI: battery: fix some coding style issues
      ACPI: button: fix some coding style issues
      ACPI: CPPC: fix some coding style issues
      ACPI: custom_method: fix a coding style issue
      ACPI: PM: add a missed blank line after declarations
      ACPI: sysfs: fix some coding style issues
      ACPI: dock: fix some coding style issues

---------------

 Documentation/admin-guide/kernel-parameters.txt |   4 +-
 Documentation/firmware-guide/acpi/debug.rst     |  36 ++--
 drivers/acpi/ac.c                               |  30 +--
 drivers/acpi/acpi_apd.c                         |   8 +-
 drivers/acpi/acpi_ipmi.c                        |   1 -
 drivers/acpi/acpi_lpss.c                        |   2 +
 drivers/acpi/acpi_pad.c                         |   4 +
 drivers/acpi/acpi_processor.c                   |  51 ++---
 drivers/acpi/acpi_video.c                       |  43 +++--
 drivers/acpi/acpica/acpredef.h                  |  15 ++
 drivers/acpi/acpica/acresrc.h                   |   4 +
 drivers/acpi/acpica/acutils.h                   |   1 +
 drivers/acpi/acpica/amlresrc.h                  |  19 +-
 drivers/acpi/acpica/rscalc.c                    |   4 +-
 drivers/acpi/acpica/rsdump.c                    |   8 +
 drivers/acpi/acpica/rsdumpinfo.c                |  26 +++
 drivers/acpi/acpica/rsinfo.c                    |   6 +-
 drivers/acpi/acpica/rslist.c                    |   9 +-
 drivers/acpi/acpica/rsmisc.c                    |  19 ++
 drivers/acpi/acpica/rsserial.c                  |  75 ++++++++
 drivers/acpi/acpica/utresdecode.c               |  10 +-
 drivers/acpi/acpica/utresrc.c                   |   1 +
 drivers/acpi/apei/einj.c                        |   1 -
 drivers/acpi/apei/erst.c                        |   2 +-
 drivers/acpi/apei/hest.c                        |   2 +-
 drivers/acpi/battery.c                          |  63 ++++---
 drivers/acpi/button.c                           |   9 +-
 drivers/acpi/cppc_acpi.c                        |  96 +++++-----
 drivers/acpi/custom_method.c                    |   2 +-
 drivers/acpi/device_pm.c                        |   3 +
 drivers/acpi/device_sysfs.c                     |  19 +-
 drivers/acpi/dock.c                             |   7 +-
 drivers/acpi/glue.c                             |   8 +-
 drivers/acpi/hed.c                              |   1 -
 drivers/acpi/internal.h                         |   4 +-
 drivers/acpi/nfit/core.c                        |   2 +-
 drivers/acpi/numa/hmat.c                        |   2 +-
 drivers/acpi/pci_irq.c                          |  34 +---
 drivers/acpi/pci_link.c                         | 164 +++++++---------
 drivers/acpi/pmic/intel_pmic_chtcrc.c           |   2 +-
 drivers/acpi/power.c                            |  18 +-
 drivers/acpi/processor_driver.c                 |   6 +-
 drivers/acpi/processor_idle.c                   |  38 ++--
 drivers/acpi/processor_pdc.c                    |   7 +-
 drivers/acpi/processor_perflib.c                |  50 +++--
 drivers/acpi/processor_throttling.c             | 102 +++++-----
 drivers/acpi/resource.c                         |   2 +-
 drivers/acpi/scan.c                             | 178 +++++++-----------
 drivers/acpi/sleep.h                            |   1 -
 drivers/acpi/sysfs.c                            |  14 +-
 drivers/acpi/utils.c                            |  37 +++-
 drivers/acpi/video_detect.c                     |  24 +++
 drivers/hwmon/acpi_power_meter.c                |  29 ++-
 drivers/iio/light/acpi-als.c                    |   4 +-
 include/acpi/acoutput.h                         |   2 +-
 include/acpi/acpi_bus.h                         |  20 ++
 include/acpi/acpi_drivers.h                     |  12 --
 include/acpi/acpixf.h                           |   2 +-
 include/acpi/acrestyp.h                         |   9 +-
 include/acpi/actbl1.h                           |  54 +++++-
 include/acpi/actbl2.h                           | 240 +++++++++++++++++++++---
 include/acpi/actbl3.h                           |  70 ++++++-
 include/acpi/acuuid.h                           |   1 +
 include/acpi/cppc_acpi.h                        |  40 ++++
 include/acpi/platform/acgcc.h                   |   2 +-
 include/linux/acpi.h                            |  10 +
 include/linux/ioport.h                          |   2 +-
 tools/power/acpi/common/cmfsize.c               |   2 +-
 68 files changed, 1127 insertions(+), 646 deletions(-)
