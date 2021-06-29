Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953103B782D
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jun 2021 21:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbhF2TDu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 29 Jun 2021 15:03:50 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:46849 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbhF2TDt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Jun 2021 15:03:49 -0400
Received: by mail-ot1-f43.google.com with SMTP id v5-20020a0568301bc5b029045c06b14f83so23720404ota.13;
        Tue, 29 Jun 2021 12:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=4tvv2gaW7BaMP3/xEeJu3hsh1i+1AW25IirjrwJlez4=;
        b=o0lzaXI3TGQMUp8UfZlBkWZo4cTqHv98NzUq9winIZ14REeJCtq4xE+jaHLSkaBL6f
         fGM4DX+khSQjotzJYaBeJ0/xMet+/GvkcSIUPnJjROHRfWm5/zMlQpFaDAqYXy7IudOA
         MHIjlxrHSXKCfcd2lsw35QCxxq1wZcQK19LlHPChR3OSYn6BTaRt4azFmVfb6u0UCCLT
         re7/8ZonUQNG6HlpiOzbbj/59Y5EZL5UYuRTpQlSnBn2Pt0krA5EPgwFeFtfvFKYNcNa
         u6xuhn0+Zb29FJWHHE6TJNc6yjZtV6Ro0WcFTEaX2cWLOBz4ClmUnATi/8FJBYgEVupj
         uQRw==
X-Gm-Message-State: AOAM532i9xQxkWgABKerQbRfv7FEsib3IxYQCZE6uGY6GaeZBS+egK2F
        MCRSmKvEi2ulVy2xEtarCRytvN3UxkEddLb7AHs=
X-Google-Smtp-Source: ABdhPJxGrh/kV1C4kx65oDrBTXSJ+Ep1fQ6E7egSmyWCqFK0CdOHXnPpZX/90pkioWsXiruAAoeE4Fv1C+0v9aObI+M=
X-Received: by 2002:a05:6830:1bf7:: with SMTP id k23mr6092034otb.206.1624993280993;
 Tue, 29 Jun 2021 12:01:20 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 29 Jun 2021 21:01:10 +0200
Message-ID: <CAJZ5v0hm5ihfU_hBbMB9u7SmH18PLGp6+Z6=wBLa8WxaVQRTpg@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v5.14-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.14-rc1

with top-most commit 64f9111dd6225a50b8fdd365dfdda275c2a708c0

 Merge branches 'acpi-ec', 'acpi-apei', 'acpi-soc' and 'acpi-misc'

on top of commit 009c9aa5be652675a06d5211e1640e02bbb1c33d

 Linux 5.13-rc6

to receive ACPI updates for 5.14-rc1.

These update the ACPICA code in the kernel to the 20210604
upstream revision, add preliminary support for the Platform
Runtime Mechanism (PRM), address issues related to the handling
of device dependencies in the ACPI device eunmeration code,
improve the tracking of ACPI power resource states, improve
the ACPI support for suspend-to-idle on AMD systems, continue
the unification of message printing in the ACPI code, address
assorted issues and clean up the code in a number of places.

Specifics:

 - Update ACPICA code in the kernel to upstrea revision 20210604
   including the following changes:

   * Add defines for the CXL Host Bridge Structureand and add the
     CFMWS structure definition to CEDT (Alison Schofield).
   * iASL: Finish support for the IVRS ACPI table (Bob Moore).
   * iASL: Add support for the SVKL table (Bob Moore).
   * iASL: Add full support for RGRT ACPI table (Bob Moore).
   * iASL: Add support for the BDAT ACPI table (Bob Moore).
   * iASL: add disassembler support for PRMT (Erik Kaneda).
   * Fix memory leak caused by _CID repair function (Erik Kaneda).
   * Add support for PlatformRtMechanism OpRegion (Erik Kaneda).
   * Add PRMT module header to facilitate parsing (Erik Kaneda).
   * Add _PLD panel positions (Fabian Wüthrich).
   * MADT: add Multiprocessor Wakeup Mailbox Structure and the
     SVKL table headers (Kuppuswamy Sathyanarayanan).
   * Use ACPI_FALLTHROUGH (Wei Ming Chen).

 - Add preliminary support for the Platform Runtime Mechanism (PRM)
   to allow the AML interpreter to call PRM functions (Erik Kaneda).

 - Address some issues related to the handling of device dependencies
   reported by _DEP in the ACPI device enumeration code and clean up
   some related pieces of it (Rafael Wysocki).

 - Improve the tracking of states of ACPI power resources (Rafael
   Wysocki).

 - Improve ACPI support for suspend-to-idle on AMD systems (Alex
   Deucher, Mario Limonciello, Pratik Vishwakarma).

 - Continue the unification and cleanup of message printing in the
   ACPI code (Hanjun Guo, Heiner Kallweit).

 - Fix possible buffer overrun issue with the description_show()
   sysfs attribute method (Krzysztof Wilczyński).

 - Improve the acpi_mask_gpe kernel command line parameter handling
   and clean up the core ACPI code related to sysfs (Andy Shevchenko,
   Baokun Li, Clayton Casciato).

 - Postpone bringing devices in the general ACPI PM domain to D0
   during resume from system-wide suspend until they are really
   needed (Dmitry Torokhov).

 - Make the ACPI processor driver fix up C-state latency if not
   ordered (Mario Limonciello).

 - Add support for identifying devices depending on the given one
   that are not its direct descendants with the help of _DEP (Daniel
   Scally).

 - Extend the checks related to ACPI IRQ overrides on x86 in order to
   avoid false-positives (Hui Wang).

 - Add battery DPTF participant for Intel SoCs (Sumeet Pawnikar).

 - Rearrange the ACPI fan driver and device power management code to
   use a common list of device IDs (Rafael Wysocki).

 - Fix clang CFI violation in the ACPI BGRT table parsing code and
   clean it up (Nathan Chancellor).

 - Add GPE-related quirks for some laptops to the EC driver (Chris
   Chiu, Zhang Rui).

 - Make the ACPI PPTT table parsing code populate the cache-id
   value if present in the firmware (James Morse).

 - Remove redundant clearing of context->ret.pointer from
   acpi_run_osc() (Hans de Goede).

 - Add missing acpi_put_table() in acpi_init_fpdt() (Jing Xiangfeng).

 - Make ACPI APEI handle ARM Processor Error CPER records like
   Memory Error ones to avoid user space task lockups (Xiaofei Tan).

 - Stop warning about disabled ACPI in APEI (Jon Hunter).

 - Fix fall-through warning for Clang in the SBSHC driver (Gustavo A.
   R. Silva).

 - Add custom DSDT file as Makefile prerequisite (Richard Fitzgerald).

 - Initialize local variable to avoid garbage being returned (Colin
   Ian King).

 - Simplify assorted pieces of code, address assorted coding style
   and documentation issues and comment typos (Baokun Li, Christophe
   JAILLET, Clayton Casciato, Liu Shixin, Shaokun Zhang, Wei Yongjun,
   Yang Li, Zhen Lei).

Thanks!


---------------

Alex Deucher (1):
      ACPI: PM: s2idle: Add missing LPS0 functions for AMD

Alison Schofield (2):
      ACPICA: Add defines for the CXL Host Bridge Structure (CHBS)
      ACPICA: Add the CFMWS structure definition to the CEDT table

Andy Shevchenko (7):
      ACPI: sysfs: Make sparse happy about address space in use
      ACPI: sysfs: Allow bitmap list to be supplied to acpi_mask_gpe
      ACPI: sysfs: Unify pattern of memory allocations
      ACPI: sysfs: Refactor param_get_trace_state() to drop dead code
      ACPI: sysfs: Sort headers alphabetically
      ACPI: sysfs: Use __ATTR_RO() and __ATTR_RW() macros
      ACPI: sysfs: Remove tailing return statement in void function

Baokun Li (2):
      ACPI: sysfs: fix doc warnings in device_sysfs.c
      ACPI: NVS: fix doc warnings in nvs.c

Bob Moore (5):
      ACPICA: iASL: Finish support for the IVRS ACPI table
      ACPICA: iASL: Add support for the SVKL table
      ACPICA: iASL Table Compiler: Add full support for RGRT ACPI table
      ACPICA: iASL: Add support for the BDAT ACPI table
      ACPICA: Update version to 20210604

Chris Chiu (1):
      ACPI: EC: Make more Asus laptops use ECDT _GPE

Christophe JAILLET (1):
      ACPI: NUMA: fix typo in a comment

Clayton Casciato (3):
      ACPI: video: Drop three redundant return statements
      ACPI: sysfs: Drop four redundant return statements
      ACPI: processor_throttling: Fix several coding style issues

Colin Ian King (1):
      ACPI: scan: initialize local variable to avoid garbage being returned

Daniel Scally (2):
      ACPI: scan: Extend acpi_walk_dep_device_list()
      ACPI: scan: Add function to fetch dependent of ACPI device

Dmitry Torokhov (1):
      ACPI: PM: postpone bringing devices to D0 unless we need them

Erik Kaneda (6):
      ACPICA: Fix memory leak caused by _CID repair function
      ACPICA: iASL: add disassembler support for PRMT
      ACPICA: Add support for PlatformRtMechanism OperationRegion handler
      ACPICA: Add PRMT module header to facilitate parsing
      ACPI: PRM: implement OperationRegion handler for the
PlatformRtMechanism subtype
      ACPI: Add \_SB._OSC bit for PRM

Fabian Wüthrich (1):
      ACPICA: Add _PLD panel positions

Gustavo A. R. Silva (1):
      ACPI: sbshc: Fix fall-through warning for Clang

Hanjun Guo (22):
      ACPI: ipmi: Remove address space handler in error path
      ACPI: configfs: Replace ACPI_INFO() with pr_debug()
      ACPI: cmos_rtc: Using pr_fmt() and remove PREFIX
      ACPI: blacklist: Unify the message printing
      ACPI: bus: Use pr_*() macros to replace printk()
      ACPI: event: Use pr_*() macros to replace printk()
      ACPI: glue: Clean up the printing messages
      ACPI: nvs: Unify the message printing
      ACPI: osl: Remove the duplicated PREFIX for message printing
      ACPI: pci_root: Unify the message printing
      ACPI: processor_thermal: Remove unused PREFIX for printing
      ACPI: processor_perflib: Cleanup print messages
      ACPI: processor_throttling: Cleanup the printing messages
      ACPI: reboot: Unify the message printing
      ACPI: sysfs: Cleanup message printing
      ACPI: sbshc: Unify the message printing
      ACPI: scan: Unify the log message printing
      ACPI: sbs: Unify the message printing
      ACPI: sleep: Unify the message printing
      ACPI: Remove the macro PREFIX "ACPI: "
      ACPI: bus: Remove unneeded assignment
      ACPI: bus: Call kobject_put() in acpi_init() error path

Hans de Goede (1):
      ACPI: Remove redundant clearing of context->ret.pointer from
acpi_run_osc()

Heiner Kallweit (1):
      x86/acpi: Switch to pr_xxx log functions

Hui Wang (1):
      ACPI: resources: Add checks for ACPI IRQ override

James Morse (1):
      ACPI: tables: PPTT: Populate cache-id if provided by firmware

Jing Xiangfeng (1):
      ACPI: tables: FPDT: Add missing acpi_put_table() in acpi_init_fpdt()

Jon Hunter (1):
      ACPI: APEI: Don't warn if ACPI is disabled

Krzysztof Wilczyński (1):
      ACPI: sysfs: Fix a buffer overrun problem with description_show()

Kuppuswamy Sathyanarayanan (2):
      ACPICA: ACPI 6.4: MADT: add Multiprocessor Wakeup Mailbox Structure
      ACPICA: Add SVKL table headers

Liu Shixin (1):
      ACPI: LPSS: Use kstrtol() instead of simple_strtol()

Mario Limonciello (2):
      ACPI: processor idle: Fix up C-state latency if not ordered
      ACPI: PM: Adjust behavior for field problems on AMD systems

Nathan Chancellor (2):
      ACPI: bgrt: Fix CFI violation
      ACPI: bgrt: Use sysfs_emit

Pratik Vishwakarma (4):
      ACPI: PM: s2idle: Use correct revision id
      ACPI: PM: s2idle: Refactor common code
      ACPI: PM: s2idle: Add support for multiple func mask
      ACPI: PM: s2idle: Add support for new Microsoft UUID

Rafael J. Wysocki (13):
      ACPI: scan: Rearrange dep_unmet initialization
      ACPI: PM / fan: Put fan device IDs into separate header file
      ACPI: power: Use u8 as the power resource state data type
      ACPI: power: Save the last known state of each power resource
      ACPI: power: Rework turning off unused power resources
      ACPI: power: Use dev_dbg() to print some messages
      ACPI: scan: Define acpi_bus_put_acpi_device() as static inline
      ACPI: scan: Rearrange acpi_dev_get_first_consumer_dev_cb()
      ACPI: scan: Make acpi_walk_dep_device_list()
      ACPI: scan: Fix device object rescan in acpi_scan_clear_dep()
      ACPI: scan: Reorganize acpi_device_add()
      ACPI: scan: Fix race related to dropping dependencies
      ACPI: scan: Simplify acpi_table_events_fn()

Richard Fitzgerald (1):
      ACPI: tables: Add custom DSDT file as makefile prerequisite

Shaokun Zhang (1):
      ACPI: event: Remove redundant initialization of local variable

Sumeet Pawnikar (1):
      ACPI: DPTF: Add battery participant for Intel SoCs

Wei Ming Chen (1):
      ACPICA: Use ACPI_FALLTHROUGH

Wei Yongjun (1):
      ACPI: PRM: make symbol 'prm_module_list' static

Xiaofei Tan (1):
      ACPI: APEI: fix synchronous external aborts in user-mode

Yang Li (2):
      ACPI: processor_throttling: Remove redundant initialization of 'obj'
      ACPI: sleep: Fix acpi_pm_pre_suspend() kernel-doc

Zhang Rui (1):
      ACPI: EC: trust DSDT GPE for certain HP laptop

Zhen Lei (1):
      ACPI: OSL: Use DEFINE_RES_IO_NAMED() to simplify code

---------------

 Documentation/admin-guide/kernel-parameters.txt |   2 +-
 arch/x86/kernel/acpi/boot.c                     | 118 ++++-----
 drivers/acpi/Kconfig                            |   5 +
 drivers/acpi/Makefile                           |   6 +
 drivers/acpi/acpi_cmos_rtc.c                    |   6 +-
 drivers/acpi/acpi_configfs.c                    |   5 +-
 drivers/acpi/acpi_fpdt.c                        |   4 +-
 drivers/acpi/acpi_ipmi.c                        |   7 +-
 drivers/acpi/acpi_lpss.c                        |  13 +-
 drivers/acpi/acpi_video.c                       |   6 -
 drivers/acpi/acpica/acutils.h                   |   2 +
 drivers/acpi/acpica/exfield.c                   |   8 +-
 drivers/acpi/acpica/exserial.c                  |  12 +
 drivers/acpi/acpica/nsrepair2.c                 |   7 +
 drivers/acpi/acpica/utprint.c                   |   2 +-
 drivers/acpi/acpica/utuuid.c                    |  41 +++
 drivers/acpi/apei/einj.c                        |   2 +-
 drivers/acpi/apei/ghes.c                        |  81 ++++--
 drivers/acpi/bgrt.c                             |  57 ++---
 drivers/acpi/blacklist.c                        |   9 +-
 drivers/acpi/bus.c                              |  17 +-
 drivers/acpi/device_pm.c                        |  38 ++-
 drivers/acpi/device_sysfs.c                     |   7 +-
 drivers/acpi/dptf/int340x_thermal.c             |   2 +
 drivers/acpi/ec.c                               |  39 ++-
 drivers/acpi/event.c                            |   8 +-
 drivers/acpi/fan.c                              |   7 +-
 drivers/acpi/fan.h                              |  13 +
 drivers/acpi/glue.c                             |  29 +--
 drivers/acpi/internal.h                         |   6 +-
 drivers/acpi/nvs.c                              |  32 +--
 drivers/acpi/osl.c                              |  11 +-
 drivers/acpi/pci_root.c                         |   4 +-
 drivers/acpi/pmic/intel_pmic_chtdc_ti.c         |   2 +-
 drivers/acpi/power.c                            | 116 +++++----
 drivers/acpi/pptt.c                             |  18 +-
 drivers/acpi/prmt.c                             | 303 +++++++++++++++++++++++
 drivers/acpi/processor_idle.c                   |  40 +++
 drivers/acpi/processor_perflib.c                |  38 ++-
 drivers/acpi/processor_thermal.c                |   2 -
 drivers/acpi/processor_throttling.c             |  75 +++---
 drivers/acpi/reboot.c                           |   4 +-
 drivers/acpi/resource.c                         |   9 +-
 drivers/acpi/sbs.c                              |  12 +-
 drivers/acpi/sbshc.c                            |   9 +-
 drivers/acpi/scan.c                             | 316 ++++++++++++++++--------
 drivers/acpi/sleep.c                            |  22 +-
 drivers/acpi/sysfs.c                            |  85 +++----
 drivers/acpi/tables.c                           |   9 +
 drivers/acpi/x86/s2idle.c                       | 145 +++++++----
 drivers/gpio/gpiolib-acpi.c                     |  10 +-
 drivers/i2c/i2c-core-acpi.c                     |   8 +-
 drivers/platform/surface/aggregator/core.c      |   6 +-
 drivers/platform/surface/surface3_power.c       |  22 +-
 drivers/platform/surface/surface_acpi_notify.c  |   7 +-
 include/acpi/acbuffer.h                         |  10 +
 include/acpi/acconfig.h                         |   2 +
 include/acpi/acpi_bus.h                         |  17 +-
 include/acpi/acpi_numa.h                        |   2 +-
 include/acpi/acpixf.h                           |   2 +-
 include/acpi/actbl1.h                           |  41 ++-
 include/acpi/actbl2.h                           | 137 ++++++++++
 include/linux/acpi.h                            |   3 +-
 include/linux/prmt.h                            |   7 +
 64 files changed, 1469 insertions(+), 616 deletions(-)
