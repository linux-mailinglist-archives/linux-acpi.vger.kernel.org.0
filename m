Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5FA148AF
	for <lists+linux-acpi@lfdr.de>; Mon,  6 May 2019 13:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfEFLMO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 May 2019 07:12:14 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46668 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfEFLMO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 May 2019 07:12:14 -0400
Received: by mail-ot1-f68.google.com with SMTP id v17so2979645otp.13;
        Mon, 06 May 2019 04:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=qxFWxffUaNwCH+pTVKfTQVEOzDV7taE1r/9uB31qbsQ=;
        b=NPu91QuSXeam6b8dVVBxgSuSJDSvBz8TXlKZVPeldqnbMsFIXc0h0Tv/7VfK6YdcNr
         Sam/nZdVhxAPjp8SnFN2g8oTf/NGMRd+RZhxCcB082zEI2X1u2/rckMErbEvOUjVrABK
         gqkpnaHdG89Jsjsgfs9xWqp9MCB4eYKp0bl3G0SvRei6DlYGCr3dixld0OD9G1R9XkUd
         cRjmtMPbHrPj7yxbm5oRylqSYRT0rTJpXsc8IReVwl7jX15TozaaWBikSpXNpi8FVCnf
         ZN4FCr2tuQo+Uo20NFGWdKJWquOykP+jUE5H99rbHVUFXWBrJGXgwF+nNERANo+7qmRQ
         mjjA==
X-Gm-Message-State: APjAAAWJvy0LBFfdZz+ikirSMzqC19uBEQRQFcjgHKaSYAgiPP4BXahD
        S5SbBBa2jlKWAgfg5g/dO16yJswMzY7PyX1aBkhfS710
X-Google-Smtp-Source: APXvYqzkyRdCsWvfS8pdvLcCz76CRcEogRmt2E2SWYMnzefM4tm2s0FDHdVphTUkCBPbbV1qLoObdTTF6tDTIi78KFo=
X-Received: by 2002:a9d:4c06:: with SMTP id l6mr15827436otf.65.1557141133170;
 Mon, 06 May 2019 04:12:13 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 May 2019 13:12:01 +0200
Message-ID: <CAJZ5v0hW+jd7r5J5=XyMM2rk5oHQrrP70_LBEVdSMTGsd=zxNw@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v5.2-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.2-rc1

with top-most commit 10b4768b27a0b8f9459570723ecb1809f4d707e0

 Merge branch 'acpi-doc'

on top of commit 2c2a2fb1e2a9256714338875bede6b7cbd4b9542

 Revert "ACPICA: Clear status of GPEs before enabling them"

to receive ACPI updates for 5.2-rc1.

These rearrange the ACPI documentation by converting it to the .rst format
and splitting it into clear categories (admin guide, driver API, firmware
guide), switch over multiple users of a problematic library function to
a new better one, update the ACPICA code in the kernel to a new upstream
release, fix a few issues, improve power device management diagnostics
and do some cleanups.

Specifics:

 - Convert the ACPI documentation in the kernel source tree to the
   .rst format and split it into the admin guide, driver API and
   firmware guide parts (Changbin Du).

 - Add a PRP0001 usage example to the ACPI documentation (Thomas
   Preston).

 - Switch over the users of the acpi_dev_get_first_match_name()
   library function which turned out to be problematic to a new,
   better one called acpi_dev_get_first_match_dev() (Andy Shevchenko,
   YueHaibing).

 - Update the ACPICA code in the kernel to upstream release 20190405
   including:
   * Null pointer dereference check in acpi_ns_delete_node() (Erik
     Schmauss).
   * Multiple macro and function name changes (Bob Moore).
   * Predefined operation region name fix (Erik Schmauss).

 - Fix hibernation issue on systems using the Baytrail and
   Cherrytrail Intel SoCs introduced during the 4.20 development
   cycle (Hans de Goede).

 - Add Sony VPCEH3U1E to the backlight quirk list (Zhang Rui).

 - Fix button handling during system resume (Zhang Rui).

 - Add a device PM diagnostic message (Rafael Wysocki).

 - Clean up the code, comments and white space in multiple places
   (Bjorn Helgaas, Gustavo Silva, Kefeng Wang).

Thanks!


---------------

Andy Shevchenko (10):
      ACPI / utils: Introduce acpi_dev_get_first_match_dev() helper
      extcon: axp288: Convert to use acpi_dev_get_first_match_dev()
      gpio: merrifield: Convert to use acpi_dev_get_first_match_dev()
      ASoC: Intel: bytcht_da7213: Convert to use acpi_dev_get_first_match_dev()
      ASoC: Intel: bytcht_es8316: Convert to use acpi_dev_get_first_match_dev()
      ASoC: Intel: bytcr_rt5640: Convert to use acpi_dev_get_first_match_dev()
      ASoC: Intel: bytcr_rt5651: Convert to use acpi_dev_get_first_match_dev()
      ASoC: Intel: cht_bsw_rt5645: Convert to use acpi_dev_get_first_match_dev()
      ASoC: Intel: cht_bsw_rt5672: Convert to use acpi_dev_get_first_match_dev()
      ACPI / utils: Remove deprecated function since no user left

Bjorn Helgaas (4):
      ACPI: Fix comment typos
      ACPI / scan: Simplify acpi_bus_extract_wakeup_device_power_package()
      ACPI / scan: Add labels for PNP button devices
      ACPI / tables: Clean up whitespace

Bob Moore (5):
      ACPICA: Rename nameseg copy macro for clarity
      ACPICA: Rename nameseg compare macro for clarity
      ACPICA: Rename nameseg length macro/define for clarity
      ACPICA: Update version to 20190329
      ACPICA: Update version to 20190405

Changbin Du (24):
      Documentation: add Linux ACPI to Sphinx TOC tree
      Documentation: ACPI: move namespace.txt to firmware-guide/acpi
and convert to reST
      Documentation: ACPI: move enumeration.txt to firmware-guide/acpi
and convert to reST
      Documentation: ACPI: move osi.txt to firmware-guide/acpi and
convert to reST
      Documentation: ACPI: move linuxized-acpica.txt to
driver-api/acpi and convert to reST
      Documentation: ACPI: move scan_handlers.txt to driver-api/acpi
and convert to reST
      Documentation: ACPI: move DSD-properties-rules.txt to
firmware-guide/acpi and covert to reST
      Documentation: ACPI: move gpio-properties.txt to
firmware-guide/acpi and convert to reST
      Documentation: ACPI: move method-customizing.txt to
firmware-guide/acpi and convert to reST
      Documentation: ACPI: move initrd_table_override.txt to
admin-guide/acpi and convert to reST
      Documentation: ACPI: move dsdt-override.txt to admin-guide/acpi
and convert to reST
      Documentation: ACPI: move i2c-muxes.txt to firmware-guide/acpi
and convert to reST
      Documentation: ACPI: move acpi-lid.txt to firmware-guide/acpi
and convert to reST
      Documentation: ACPI: move dsd/graph.txt to firmware-guide/acpi
and convert to reST
      Documentation: ACPI: move dsd/data-node-references.txt to
firmware-guide/acpi and convert to reST
      Documentation: ACPI: move debug.txt to firmware-guide/acpi and
convert to reST
      Documentation: ACPI: move method-tracing.txt to
firmware-guide/acpi and convert to rsST
      Documentation: ACPI: move aml-debugger.txt to
firmware-guide/acpi and convert to reST
      Documentation: ACPI: move apei/output_format.txt to
firmware-guide/acpi and convert to reST
      Documentation: ACPI: move apei/einj.txt to firmware-guide/acpi
and convert to reST
      Documentation: ACPI: move cppc_sysfs.txt to admin-guide/acpi and
convert to reST
      Documentation: ACPI: move lpit.txt to firmware-guide/acpi and
convert to reST
      Documentation: ACPI: move ssdt-overlays.txt to admin-guide/acpi
and convert to reST
      Documentation: ACPI: move video_extension.txt to
firmware-guide/acpi and convert to reST

Erik Schmauss (2):
      ACPICA: utilities: fix spelling of PCC to platform_comm_channel
      ACPICA: Namespace: add check to avoid null pointer dereference

Gustavo A. R. Silva (1):
      ACPI: event: replace strcpy() by strscpy()

Hans de Goede (1):
      ACPI / LPSS: Use acpi_lpss_* instead of acpi_subsys_* functions
for hibernate

Kefeng Wang (1):
      ACPI / DPTF: Use dev_get_drvdata()

Rafael J. Wysocki (1):
      ACPI: PM: Print debug messages when enabling GPEs for wakeup

Thomas Preston (1):
      Documentation: acpi: Add an example for PRP0001

YueHaibing (1):
      gpio: merrifield: Fix build err without CONFIG_ACPI

Zhang Rui (2):
      ACPI: video: Use vendor backlight on Sony VPCEH3U1E
      ACPI: button: reinitialize button state upon resume

---------------

 Documentation/acpi/aml-debugger.txt                |  66 -----
 Documentation/acpi/apei/output_format.txt          | 147 -----------
 Documentation/acpi/i2c-muxes.txt                   |  58 ----
 Documentation/acpi/initrd_table_override.txt       | 111 --------
 Documentation/acpi/method-customizing.txt          |  73 -----
 Documentation/acpi/method-tracing.txt              | 192 --------------
 Documentation/acpi/ssdt-overlays.txt               | 172 ------------
 .../acpi/cppc_sysfs.rst}                           |  71 ++---
 .../acpi/dsdt-override.rst}                        |   8 +-
 Documentation/admin-guide/acpi/index.rst           |  14 +
 .../admin-guide/acpi/initrd_table_override.rst     | 115 ++++++++
 Documentation/admin-guide/acpi/ssdt-overlays.rst   | 180 +++++++++++++
 Documentation/admin-guide/index.rst                |   1 +
 Documentation/driver-api/acpi/index.rst            |   9 +
 .../acpi/linuxized-acpica.rst}                     | 109 ++++----
 .../acpi/scan_handlers.rst}                        |  24 +-
 Documentation/driver-api/index.rst                 |   1 +
 .../acpi/DSD-properties-rules.rst}                 |  21 +-
 .../acpi/acpi-lid.rst}                             |  40 ++-
 Documentation/firmware-guide/acpi/aml-debugger.rst |  75 ++++++
 .../einj.txt => firmware-guide/acpi/apei/einj.rst} |  94 ++++---
 .../firmware-guide/acpi/apei/output_format.rst     | 150 +++++++++++
 .../debug.txt => firmware-guide/acpi/debug.rst}    |  31 ++-
 .../acpi/dsd/data-node-references.rst}             |  36 +--
 .../acpi/dsd/graph.rst}                            | 157 +++++------
 .../acpi/enumeration.rst}                          | 161 ++++++-----
 .../acpi/gpio-properties.rst}                      |  78 +++---
 Documentation/firmware-guide/acpi/i2c-muxes.rst    |  61 +++++
 Documentation/firmware-guide/acpi/index.rst        |  26 ++
 .../lpit.txt => firmware-guide/acpi/lpit.rst}      |  18 +-
 .../firmware-guide/acpi/method-customizing.rst     |  89 +++++++
 .../firmware-guide/acpi/method-tracing.rst         | 238 +++++++++++++++++
 .../acpi/namespace.rst}                            | 294 +++++++++++----------
 .../{acpi/osi.txt => firmware-guide/acpi/osi.rst}  |  15 +-
 .../acpi/video_extension.rst}                      |  83 +++---
 Documentation/firmware-guide/index.rst             |  13 +
 Documentation/index.rst                            |  10 +
 MAINTAINERS                                        |   2 +-
 arch/x86/boot/compressed/acpi.c                    |   2 +-
 drivers/acpi/acpi_configfs.c                       |   4 +-
 drivers/acpi/acpi_dbg.c                            |   2 +-
 drivers/acpi/acpi_lpat.c                           |   2 +-
 drivers/acpi/acpi_lpss.c                           |   4 +-
 drivers/acpi/acpica/aclocal.h                      |   4 +-
 drivers/acpi/acpica/dbexec.c                       |   2 +-
 drivers/acpi/acpica/dbnames.c                      |   2 +-
 drivers/acpi/acpica/dsinit.c                       |   2 +-
 drivers/acpi/acpica/evgpeinit.c                    |   4 +-
 drivers/acpi/acpica/exnames.c                      |   6 +-
 drivers/acpi/acpica/nsaccess.c                     |   2 +-
 drivers/acpi/acpica/nsalloc.c                      |   4 +
 drivers/acpi/acpica/nsdump.c                       |   2 +-
 drivers/acpi/acpica/nsinit.c                       |   4 +-
 drivers/acpi/acpica/nsnames.c                      |   8 +-
 drivers/acpi/acpica/nsparse.c                      |   2 +-
 drivers/acpi/acpica/nsrepair.c                     |   2 +-
 drivers/acpi/acpica/nsrepair2.c                    |   4 +-
 drivers/acpi/acpica/nsutils.c                      |  14 +-
 drivers/acpi/acpica/nsxfname.c                     |   4 +-
 drivers/acpi/acpica/psargs.c                       |   8 +-
 drivers/acpi/acpica/rsxface.c                      |   8 +-
 drivers/acpi/acpica/tbdata.c                       |   3 +-
 drivers/acpi/acpica/tbfind.c                       |  20 +-
 drivers/acpi/acpica/tbinstal.c                     |   2 +-
 drivers/acpi/acpica/tbprint.c                      |  10 +-
 drivers/acpi/acpica/tbutils.c                      |   6 +-
 drivers/acpi/acpica/tbxface.c                      |   4 +-
 drivers/acpi/acpica/tbxfload.c                     |  15 +-
 drivers/acpi/acpica/utascii.c                      |   2 +-
 drivers/acpi/acpica/utdecode.c                     |   4 +-
 drivers/acpi/acpica/utmisc.c                       |   8 +-
 drivers/acpi/acpica/utpredef.c                     |   4 +-
 drivers/acpi/acpica/utstring.c                     |   6 +-
 drivers/acpi/button.c                              |   5 +-
 drivers/acpi/cppc_acpi.c                           |  34 +--
 drivers/acpi/device_pm.c                           |   3 +
 drivers/acpi/dptf/dptf_power.c                     |   3 +-
 drivers/acpi/event.c                               |   4 +-
 drivers/acpi/power.c                               |   4 +-
 drivers/acpi/pptt.c                                |  48 ++--
 drivers/acpi/scan.c                                |  21 +-
 drivers/acpi/spcr.c                                |   2 +-
 drivers/acpi/sysfs.c                               |  14 +-
 drivers/acpi/tables.c                              |  22 +-
 drivers/acpi/utils.c                               |  16 +-
 drivers/acpi/video_detect.c                        |  10 +-
 drivers/extcon/extcon-axp288.c                     |   9 +-
 drivers/firmware/iscsi_ibft.c                      |   2 +-
 drivers/gpio/gpio-merrifield.c                     |  18 +-
 .../intel/int340x_thermal/acpi_thermal_rel.c       |   2 +-
 include/acpi/acpi_bus.h                            |   8 +-
 include/acpi/acpixf.h                              |   2 +-
 include/acpi/actbl.h                               |   4 +-
 include/acpi/actypes.h                             |  12 +-
 include/linux/acpi.h                               |   6 +-
 sound/soc/intel/boards/bytcht_da7213.c             |   9 +-
 sound/soc/intel/boards/bytcht_es8316.c             |   9 +-
 sound/soc/intel/boards/bytcr_rt5640.c              |  10 +-
 sound/soc/intel/boards/bytcr_rt5651.c              |  14 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c            |   9 +-
 sound/soc/intel/boards/cht_bsw_rt5672.c            |   9 +-
 .../acpi/os_specific/service_layers/oslinuxtbl.c   |  48 ++--
 tools/power/acpi/tools/acpidump/apdump.c           |   8 +-
 tools/power/acpi/tools/acpidump/apfiles.c          |   8 +-
 104 files changed, 1977 insertions(+), 1619 deletions(-)
