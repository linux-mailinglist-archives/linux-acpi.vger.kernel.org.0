Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1432323AAE9
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Aug 2020 18:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgHCQwU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Aug 2020 12:52:20 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:42798 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgHCQwT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Aug 2020 12:52:19 -0400
Received: by mail-oi1-f175.google.com with SMTP id j7so17433575oij.9;
        Mon, 03 Aug 2020 09:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1HtX47GmTYniPJZ3GPCTfnJ6ByP+EBJwfpXB9Su3tkE=;
        b=ru46td6IKSdm3eKzef/UWG9ywXjUeEWF+LI0Z121BTqoGBlyhzrjRc1SX37fIzghEP
         1wGA3vNqf/JxArj+BeltC7cOmOvluD+Qxz+xlTChj4GBLXblePOJF1ErJzyyDBQYNw7B
         KcaNWI2aZ/Q6uuN5t7KuipFYMaPSBBOlqanG+yN7pzFF3iY+vm6dRQXXi/1UuyL7K7oh
         yRROUA5cGyGR9EJ27mM5EhG6/95xTq7hCJHNWhF4t5WMQgMMp2RMDMsEOlpXOVlVuVPA
         OHzPFjyED6n715mM/9z1JmuE99PzysyGi4nFD2QbbbUO4zWfIjZ1UMGDfYwOv6UUkQVy
         aLmA==
X-Gm-Message-State: AOAM532quS94nUUy27sbCT26fEGFWX6fERIe6J+14Ymwa23MmbUToFwj
        mOewZ9GdydApGcQ+xrjuGAzYszQ7FhPE9Re/Z9Q6lgRf
X-Google-Smtp-Source: ABdhPJw5e+kIbOpUWqDIfnRPqkThHBCNmpzqXOv8BKQn0nnrVd/wmeLBw9ovV/eTsJpeNJNu08mcT2P+2JSrehzz6PU=
X-Received: by 2002:aca:110a:: with SMTP id 10mr224330oir.68.1596473538005;
 Mon, 03 Aug 2020 09:52:18 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 3 Aug 2020 18:52:07 +0200
Message-ID: <CAJZ5v0hNz4ai_wmrGJzwRe179=swhG9iFMQRzRuyv4NVer2Erg@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v5.9-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.9-rc1

with top-most commit db1da2f52ea5477e917957dd80c1da63affa60e6

 Merge branches 'acpi-mm', 'acpi-tables', 'acpi-apei' and 'acpi-misc'

on top of commit 92ed301919932f777713b9172e525674157e983d

 Linux 5.8-rc7

to receive ACPI updates for 5.9-rc1.

These eliminate significant AML processing overhead related to using
operation regions in system memory, update the ACPICA code in the
kernel to upstream revision 20200717 (including a fix to prevent
operation region reference counts from overflowing in some cases),
remove the last bits of the (long deprecated) ACPI procfs interface
and do some assorted cleanups.

Specifics:

 - Eliminate significant AML processing overhead related to using
   operation regions in system memory by reworking the management
   of memory mappings in the ACPI code to defer unmap operations
   (to do them outside of the ACPICA locks, among other things) and
   making the memory operation reagion handler avoid releasing memory
   mappings created by it too early (Rafael Wysocki).

 - Update the ACPICA code in the kernel to upstream revision
   20200717:

   * Prevent operation region reference counts from overflowing in
     some cases (Erik Kaneda).

   * Replace one-element array with flexible-array (Gustavo A. R.
     Silva).

 - Fix ACPI PCI hotplug reference counting (Rafael Wysocki).

 - Drop last bits of the ACPI procfs interface (Thomas Renninger).

 - Drop some redundant checks from the code parsing ACPI tables
   related to NUMA (Hanjun Guo).

 - Avoid redundant object evaluation in the ACPI device properties
   handling code (Heikki Krogerus).

 - Avoid unecessary memory overhead related to storing the signatures
   of the ACPI tables recognized by the kernel (Ard Biesheuvel).

 - Add missing newline characters when printing module parameter
   values in some places (Xiongfeng Wang).

 - Update the link to the ACPI specifications in some places (Tiezhu
   Yang).

 - Use the fallthrough pseudo-keyword in the ACPI code (Gustavo A. R.
   Silva).

 - Drop redundant variable initialization from the APEI code (Colin
   Ian King).

 - Drop uninitialized_var() from the ACPI PAD driver (Jason Yan).

 - Replace HTTP links with HTTPS ones in the ACPI code (Alexander A.
   Klimov).

Thanks!


---------------

Alexander A. Klimov (1):
      ACPI: Replace HTTP links with HTTPS ones

Ard Biesheuvel (1):
      ACPI: tables: avoid relocations for table signature array

Bob Moore (1):
      ACPICA: Update version to 20200717

Colin Ian King (1):
      ACPI: APEI: remove redundant assignment to variable rc

Erik Kaneda (1):
      ACPICA: Do not increment operation_region reference counts for field units

Gustavo A. R. Silva (2):
      ACPI: Use fallthrough pseudo-keyword
      ACPICA: Replace one-element array with flexible-array

Hanjun Guo (3):
      ACPI: tables: Remove the duplicated checks for acpi_parse_entries_array()
      ACPI: NUMA: Remove the useless sub table pointer check
      ACPI: NUMA: Remove the useless 'node >= MAX_NUMNODES' check

Heikki Krogerus (1):
      ACPI: property: use cached name in acpi_fwnode_get_named_child_node()

Jason Yan (1):
      ACPI: PAD: Eliminate usage of uninitialized_var() macro

Rafael J. Wysocki (6):
      PCI: hotplug: ACPI: Fix context refcounting in acpiphp_grab_context()
      ACPI: OSL: Implement deferred unmapping of ACPI memory
      ACPICA: Preserve memory opregion mappings
      ACPI: OSL: Use deferred unmapping in acpi_os_unmap_generic_address()
      ACPI: OSL: Use deferred unmapping in acpi_os_unmap_iomem()
      ACPI: OSL: Clean up the removal of unused memory mappings

Thomas Renninger (1):
      ACPI: procfs: Remove last dirs after being marked deprecated for a decade

Tiezhu Yang (1):
      ACPI: Use valid link to the ACPI specification

Xiongfeng Wang (2):
      ACPI: EC: add newline when printing 'ec_event_clearing' module parameter
      ACPI: sysfs: add newlines when printing module parameters

---------------

 .../firmware-guide/acpi/DSD-properties-rules.rst   |   4 +-
 .../acpi/dsd/data-node-references.rst              |   4 +-
 Documentation/firmware-guide/acpi/dsd/graph.rst    |  10 +-
 Documentation/firmware-guide/acpi/dsd/leds.rst     |   6 +-
 Documentation/firmware-guide/acpi/lpit.rst         |   2 +-
 Documentation/hwmon/acpi_power_meter.rst           |   2 +-
 drivers/acpi/Kconfig                               |  22 +-
 drivers/acpi/Makefile                              |   1 -
 drivers/acpi/ac.c                                  | 108 +--------
 drivers/acpi/acpi_pad.c                            |   2 +-
 drivers/acpi/acpi_processor.c                      |   2 +-
 drivers/acpi/acpica/evrgnini.c                     |  14 +-
 drivers/acpi/acpica/exprep.c                       |   4 -
 drivers/acpi/acpica/exregion.c                     |  64 ++++--
 drivers/acpi/acpica/utdelete.c                     |   6 +-
 drivers/acpi/acpica/utids.c                        |   3 +-
 drivers/acpi/apei/hest.c                           |   2 +-
 drivers/acpi/battery.c                             | 255 ---------------------
 drivers/acpi/button.c                              |   2 +-
 drivers/acpi/cm_sbs.c                              |  87 -------
 drivers/acpi/dock.c                                |   2 +-
 drivers/acpi/ec.c                                  |   8 +-
 drivers/acpi/evged.c                               |   2 +-
 drivers/acpi/nfit/nfit.h                           |   2 +-
 drivers/acpi/numa/srat.c                           |  10 +-
 drivers/acpi/osl.c                                 |  63 ++---
 drivers/acpi/processor_idle.c                      |   3 +-
 drivers/acpi/property.c                            |  14 +-
 drivers/acpi/resource.c                            |   2 +-
 drivers/acpi/spcr.c                                |   4 +-
 drivers/acpi/sysfs.c                               |  12 +-
 drivers/acpi/tables.c                              |  25 +-
 drivers/pci/hotplug/acpiphp_glue.c                 |  14 +-
 drivers/pci/pci-acpi.c                             |   6 +-
 include/acpi/acpixf.h                              |   2 +-
 include/acpi/actypes.h                             |  14 +-
 include/linux/tboot.h                              |   2 +-
 tools/power/cpupower/man/cpupower-idle-info.1      |   2 +-
 38 files changed, 167 insertions(+), 620 deletions(-)
