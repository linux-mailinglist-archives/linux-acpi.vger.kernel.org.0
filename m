Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A388A28D32A
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Oct 2020 19:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388501AbgJMReL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 13 Oct 2020 13:34:11 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:44139 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgJMReK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Oct 2020 13:34:10 -0400
Received: by mail-oi1-f171.google.com with SMTP id x62so187590oix.11;
        Tue, 13 Oct 2020 10:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=C3HS1ypvkJ+lkqyxbx/aW32RyhpvBAPsU9JGvVzTGBA=;
        b=t0tr3L9bXzFpIuztI4xx0E10WPrbSiKJYDyxIxZx3sNIHsA+8f9bqldvjvtbwTD4fg
         /B7+w6SqqA9jGPFC17igktutIih+ZLsrVyY+jlqZzqsTB8ZJqr/E+Eddc+mpagL6jNy1
         HYvEN0VE6+eBdeIVq5QRJD9udOQAcptBfSVe4YbRzHUayvOnZBfzxuO/iU71ZDesyLVp
         4oy8R7j198YiADM2J6bwAuJ/ZE+O0HwHG8MmZ2EaxU2PQBzShAygZRfkNMfiRggO5kZS
         y+l8mbiw3TA2MOc6CovSRyKUPHIUHKBPfCHJyrLt4jdYCInKk/vkRRGPxfCtI/h4Smsn
         qL5g==
X-Gm-Message-State: AOAM533dZmrz2jsbgBOK8hILBIadaAnz7RIuPbSG/ayG2L1NyVmYBxnS
        M0ISXx3HSxi7XQR/2F1LcN6ei08iqeMr3lERcMk=
X-Google-Smtp-Source: ABdhPJztyDXq7LeXHVTVtd4ykTeLMqV2Kp7yXlaF3X5Jqf2e5A6e+nNfGHxbmg1WCKr4ex8f3dxnPiD7CqOucIU9KEM=
X-Received: by 2002:aca:5256:: with SMTP id g83mr517397oib.71.1602610449342;
 Tue, 13 Oct 2020 10:34:09 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 13 Oct 2020 19:33:58 +0200
Message-ID: <CAJZ5v0j7XkDh9ddK0BtjWjHqC=xkcyiEEDzTJN=Lykje5-wf3w@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v5.10-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.10-rc1

with top-most commit 8be2362d10e8b0ea9844706d8c388480d37226d2

 Merge branches 'acpi-extlog', 'acpi-memhotplug', 'acpi-button',
'acpi-tools' and 'acpi-pci'

on top of commit 549738f15da0e5a00275977623be199fbbf7df50

 Linux 5.9-rc8

to receive ACPI updates for 5.10-rc1.

These add support for generic initiator-only proximity domains to
the ACPI NUMA code and the architectures using it, clean up some
non-ACPICA code referring to debug facilities from ACPICA, reduce the
overhead related to accessing GPE registers, add a new DPTF (Dynamic
Power and Thermal Framework) participant driver, update the ACPICA
code in the kernel to upstream revision 20200925, add a new ACPI
backlight whitelist entry, fix a few assorted issues and clean up
some code.

Specifics:

 - Add support for generic initiator-only proximity domains to
   the ACPI NUMA code and the architectures using it (Jonathan
   Cameron).

 - Clean up some non-ACPICA code referring to debug facilities from
   ACPICA that are not actually used in there (Hanjun Guo).

 - Add new DPTF driver for the PCH FIVR participant (Srinivas
   Pandruvada).

 - Reduce overhead related to accessing GPE registers in ACPICA and
   the OS interface layer and make it possible to access GPE registers
   using logical addresses if they are memory-mapped (Rafael Wysocki).

 - Update the ACPICA code in the kernel to upstream revision 20200925
   including changes as follows:
   * Add predefined names from the SMBus specification (Bob Moore).
   * Update acpi_help UUID list (Bob Moore).
   * Return exceptions for string-to-integer conversions in iASL (Bob
     Moore).
   * Add a new "ALL <NameSeg>" debugger command (Bob Moore).
   * Add support for 64 bit risc-v compilation (Colin Ian King).
   * Do assorted cleanups (Bob Moore, Colin Ian King, Randy Dunlap).

 - Add new ACPI backlight whitelist entry for HP 635 Notebook (Alex
   Hung).

 - Move TPS68470 OpRegion driver to drivers/acpi/pmic/ and split out
   Kconfig and Makefile specific for ACPI PMIC (Andy Shevchenko).

 - Clean up the ACPI SoC driver for AMD SoCs (Hanjun Guo).

 - Add missing config_item_put() to fix refcount leak (Hanjun Guo).

 - Drop leftover field from struct acpi_memory_device (Hanjun Guo).

 - Make the ACPI extlog driver check for RDMSR failures (Ben
   Hutchings).

 - Fix handling of lid state changes in the ACPI button driver when
   input device is closed (Dmitry Torokhov).

 - Fix several assorted build issues (Barnabás Pőcze, John Garry,
   Nathan Chancellor, Tian Tao).

 - Drop unused inline functions and reduce code duplication by using
   kobj_to_dev() in the NFIT parsing code (YueHaibing, Wang Qing).

 - Serialize tools/power/acpi Makefile (Thomas Renninger).

Thanks!


---------------

Alex Hung (1):
      ACPI: video: use ACPI backlight for HP 635 Notebook

Andy Shevchenko (3):
      ACPI / PMIC: Split out Kconfig and Makefile specific for ACPI PMIC
      ACPI / PMIC: Move TPS68470 OpRegion driver to drivers/acpi/pmic/
      MAINTAINERS: Use my kernel.org address for Intel PMIC work

Barnabás Pőcze (1):
      ACPI: battery: include linux/power_supply.h

Ben Hutchings (1):
      ACPI / extlog: Check for RDMSR failure

Bob Moore (6):
      ACPICA: Add predefined names found in the SMBus sepcification
      ACPICA: acpi_help: Update UUID list
      ACPICA: iASL: Return exceptions for string-to-integer conversions
      ACPICA: Debugger: Add a new command: "ALL <NameSeg>"
      ACPICA: Remove unnecessary semicolon
      ACPICA: Update version to 20200925 Version 20200925

Colin Ian King (2):
      ACPICA: Add support for 64 bit risc-v compilation
      ACPICA: Tree-wide: fix various typos and spelling mistakes

Dmitry Torokhov (1):
      ACPI: button: fix handling lid state changes when input device closed

Hanjun Guo (22):
      ACPI: APD: Add kerneldoc for properties in struct apd_device_desc
      ACPI: APD: Remove flags from struct apd_device_desc
      ACPI: APD: Remove ACPI_MODULE_NAME()
      ACPI: APD: Remove unnecessary APD_ADDR() macro stub
      ACPI: APD: Clean up header file include statements
      ACPI: configfs: Add missing config_item_put() to fix refcount leak
      ACPI: cmos_rtc: Remove leftover ACPI_MODULE_NAME()
      ACPI: LPSS: Remove ACPI_MODULE_NAME()
      ACPI: memhotplug: Remove leftover ACPICA debug functionality
      ACPI: platform: Remove ACPI_MODULE_NAME()
      ACPI: container: Remove leftover ACPICA debug functionality
      ACPI: custom_method: Remove dead ACPICA debug code
      ACPI: debugfs: Remove dead ACPICA debug code
      ACPI: dock: Remove dead ACPICA debug code
      ACPI: event: Remove leftover ACPICA debug code
      ACPI: PCI: Remove unused ACPICA debug code
      ACPI: proc: Remove dead ACPICA debug code
      ACPI: processor: Remove dead ACPICA debug code
      ACPI: tiny-power-button: Remove dead ACPICA debug code
      ACPI: video: Remove leftover ACPICA debug code
      ACPI: wakeup: Remove dead ACPICA debug code
      ACPI: memhotplug: Remove 'state' from struct acpi_memory_device

John Garry (1):
      ACPI: Make acpi_evaluate_dsm() prototype consistent

Jonathan Cameron (12):
      ACPI: Add out of bounds and numa_off protections to pxm_to_node()
      ACPI: Do not create new NUMA domains from ACPI static tables
that are not SRAT
      ACPI: Remove side effect of partly creating a node in
acpi_map_pxm_to_online_node()
      ACPI: Rename acpi_map_pxm_to_online_node() to pxm_to_online_node()
      ACPI: Remove side effect of partly creating a node in acpi_get_node()
      irq-chip/gic-v3-its: Fix crash if ITS is in a proximity domain
without processor or memory
      ACPI: Support Generic Initiator only domains
      x86: Support Generic Initiator only proximity domains
      ACPI: Let ACPI know we support Generic Initiator Affinity Structures
      ACPI: HMAT: Fix handling of changes from ACPI 6.2 to ACPI 6.3
      node: Add access1 class to represent CPU to memory characteristics
      docs: mm: numaperf.rst Add brief description for access class 1.

Nathan Chancellor (1):
      ACPI / NUMA: Add stub function for pxm_to_node()

Rafael J. Wysocki (6):
      ACPICA: Validate GPE blocks at init time
      ACPICA: Introduce acpi_hw_gpe_read() and acpi_hw_gpe_write()
      ACPICA: Introduce special struct type for GPE register addresses
      ACPICA: Add support for using logical addresses of GPE blocks
      ACPI: OSL: Change the type of acpi_os_map_generic_address() return value
      ACPI: OSL: Make ACPICA use logical addresses of GPE blocks

Randy Dunlap (1):
      ACPICA: Drop the repeated word "an" in a comment

Srinivas Pandruvada (1):
      ACPI: DPTF: Add PCH FIVR participant driver

Thomas Renninger (1):
      tools/power/acpi: Serialize Makefile

Tian Tao (2):
      ACPI: PCI: update kernel-doc line comments
      ACPI: scan: Replace ACPI_DEBUG_PRINT() with pr_debug()

Wang Qing (1):
      ACPI: NFIT: Use kobj_to_dev() instead

YueHaibing (1):
      ACPI: Remove three unused inline functions

---------------

 Documentation/ABI/testing/sysfs-platform-dptf      |  16 ++
 Documentation/admin-guide/mm/numaperf.rst          |   8 +
 MAINTAINERS                                        |   4 +-
 arch/x86/include/asm/numa.h                        |   2 +
 arch/x86/kernel/setup.c                            |   1 +
 arch/x86/mm/numa.c                                 |  21 +++
 drivers/acpi/Kconfig                               |  65 +-------
 drivers/acpi/Makefile                              |  10 +-
 drivers/acpi/acpi_apd.c                            |  32 +---
 drivers/acpi/acpi_cmos_rtc.c                       |   2 -
 drivers/acpi/acpi_configfs.c                       |   1 +
 drivers/acpi/acpi_extlog.c                         |   6 +-
 drivers/acpi/acpi_lpss.c                           |   2 -
 drivers/acpi/acpi_memhotplug.c                     |  19 +--
 drivers/acpi/acpi_platform.c                       |   2 -
 drivers/acpi/acpica/acdebug.h                      |   4 +
 drivers/acpi/acpica/acglobal.h                     |   6 +
 drivers/acpi/acpica/achware.h                      |   6 +
 drivers/acpi/acpica/aclocal.h                      |  11 +-
 drivers/acpi/acpica/acpredef.h                     |  33 +++-
 drivers/acpi/acpica/dbexec.c                       |  39 +++--
 drivers/acpi/acpica/dbinput.c                      |  14 +-
 drivers/acpi/acpica/dbmethod.c                     | 167 ++++++++++++++++++---
 drivers/acpi/acpica/evgpe.c                        |   4 +-
 drivers/acpi/acpica/evgpeblk.c                     |  27 +++-
 drivers/acpi/acpica/evgpeinit.c                    |  23 ++-
 drivers/acpi/acpica/hwgpe.c                        | 102 +++++++++++--
 drivers/acpi/acpica/hwvalid.c                      |  30 ++++
 drivers/acpi/acpica/nsalloc.c                      |   2 +-
 drivers/acpi/acpica/nsarguments.c                  |   4 +-
 drivers/acpi/acpica/nsxfobj.c                      |   3 +-
 drivers/acpi/acpica/psparse.c                      |   4 +-
 drivers/acpi/acpica/utpredef.c                     |   5 +-
 drivers/acpi/acpica/utstrsuppt.c                   |  33 ++--
 drivers/acpi/apei/apei-base.c                      |   6 +-
 drivers/acpi/arm64/iort.c                          |   2 +-
 drivers/acpi/bus.c                                 |   4 +
 drivers/acpi/button.c                              |  13 +-
 drivers/acpi/container.c                           |   3 -
 drivers/acpi/custom_method.c                       |   2 -
 drivers/acpi/debugfs.c                             |   3 -
 drivers/acpi/dock.c                                |   2 -
 drivers/acpi/dptf/Kconfig                          |  14 ++
 drivers/acpi/dptf/Makefile                         |   1 +
 drivers/acpi/dptf/dptf_pch_fivr.c                  | 126 ++++++++++++++++
 drivers/acpi/dptf/int340x_thermal.c                |   1 +
 drivers/acpi/event.c                               |   3 -
 drivers/acpi/nfit/core.c                           |  10 +-
 drivers/acpi/numa/hmat.c                           |  95 +++++++++---
 drivers/acpi/numa/srat.c                           |  73 ++++++++-
 drivers/acpi/osl.c                                 |  30 ++--
 drivers/acpi/pci_root.c                            |   4 +-
 drivers/acpi/pci_slot.c                            |   3 -
 drivers/acpi/pmic/Kconfig                          |  67 +++++++++
 drivers/acpi/pmic/Makefile                         |  10 ++
 drivers/acpi/proc.c                                |   4 -
 drivers/acpi/processor_core.c                      |   3 -
 drivers/acpi/processor_thermal.c                   |   2 -
 drivers/acpi/scan.c                                |   3 +-
 drivers/acpi/tiny-power-button.c                   |   1 -
 drivers/acpi/video_detect.c                        |  12 +-
 drivers/acpi/wakeup.c                              |   2 -
 drivers/base/node.c                                |   3 +
 drivers/iommu/intel/dmar.c                         |   2 +-
 drivers/irqchip/irq-gic-v3-its.c                   |   7 +-
 include/acpi/acconfig.h                            |   2 +-
 include/acpi/acexcep.h                             |   4 +-
 include/acpi/acpi_io.h                             |   2 +-
 include/acpi/acpi_numa.h                           |   5 +
 include/acpi/acpixf.h                              |   2 +-
 include/acpi/actypes.h                             |   2 +-
 include/acpi/acuuid.h                              |   7 +
 include/acpi/battery.h                             |   2 +
 include/acpi/platform/aclinux.h                    |   7 +-
 include/linux/acpi.h                               |  27 ++--
 include/linux/nodemask.h                           |   1 +
 tools/power/acpi/Makefile                          |   2 +
 .../acpi/os_specific/service_layers/oslinuxtbl.c   |   2 +-
 78 files changed, 955 insertions(+), 329 deletions(-)
