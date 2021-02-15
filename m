Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA40931C1E4
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Feb 2021 19:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhBOSrI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Feb 2021 13:47:08 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:35892 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhBOSqs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Feb 2021 13:46:48 -0500
Received: by mail-oi1-f176.google.com with SMTP id k204so8748161oih.3;
        Mon, 15 Feb 2021 10:46:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zRv53SuGB4/ms7SyZ2OaudlYbBezz/yNiLFWLL6rlsc=;
        b=m1fAkTb9nreYI30I2HFNCGpVMOM9ufHPwJGlk9j1DJqX03xL309CQJqrGJ8eZigNxF
         a+yqhlGlTirA6sMae5Y6JC9Ru4FprxdkFkZARtmzwO/EMVXOEXe4JpASQY9q1bQCSsuU
         odnN+wrGwRMEB+wOApZiIj65YYbz4/EemBLP0bw/DFyP5FP7+hjXr9PXLWSabEdpSkIq
         ke6e/7eGgPg+XGGwNreIeviTLQf72bhvJ3knfBxWCHkWvk9uSoVUvN5kOtiWVjbYBUl/
         dAjKtawMjyY5eSsoZrtUTF3ihXHoIz2kTSN/xTvMEupjgvwtKxWD2XKZmiV5nuOC5a96
         pqSw==
X-Gm-Message-State: AOAM533Mf9tyF++R54n1ZiIoajDEY2JxWD7AjNlU9gKp5bxLijb+VQu+
        ncN/BCbD5naqg7PxwOdgY0NqaF1JMQu/mM7/VmeAkryuHsE=
X-Google-Smtp-Source: ABdhPJzZJ72ugLIxNCi1pYchE/KkzPQe5439wsgy+ne/jyU5zoZOZO8Xi8TkweTZO1mmlfb2/9oD2bZx+O6JrX5ShaE=
X-Received: by 2002:aca:3d85:: with SMTP id k127mr165572oia.157.1613414764433;
 Mon, 15 Feb 2021 10:46:04 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 15 Feb 2021 19:45:53 +0100
Message-ID: <CAJZ5v0iGLCC_9pyyYE8AjqBzD+x7gQrAMDzMjkoyy0g3v9iXJw@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v5.12-rc1
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
 acpi-5.12-rc1

with top-most commit 2d4eb3317248c55268685e80f692c2eefb485a31

 Merge branch 'acpi-messages'

on top of commit fe0af09074bfeb46a35357e67635eefe33cdfc49

 Revert "ACPICA: Interpreter: fix memory leak by using existing buffer"

to receive ACPI updates for 5.12-rc1.

These update the ACPICA code in the kernel to upstream revision
20210105, fix and clean up the handling of device properties,
add support for setting global profile of the platform, clean up
device enumeration, the CPPC library, the APEI support and more,
update the documentation, consolidate the printing of messages in
several places and make assorted janitorial changes.

Specifics:

 - Update ACPICA code in the kernel to upstream revision 20201113
   with changes as follows:

   * Remove the MTMR (Mid-Timer) table (Al Stone).
   * Remove the VRTC table (Al Stone).
   * Add type casts for string functions (Bob Moore).
   * Update all copyrights to 2021 (Bob Moore).
   * Fix exception code class checks (Maximilian Luz).
   * Clean up exception code class checks (Maximilian Luz).
   * Fix -Wfallthrough (Nick Desaulniers).

 - Add support for setting and reading global profile of the platform
   along with documentation (Mark Pearson, Hans de Goede, Jiaxun Yang).

 - Fix fwnode properties matching and clean up the code handling
   device properties and its documentation (Rafael Wysocki, Andy
   Shevchenko).

 - Clean up ACPI-based device enumeration code (Rafael Wysocki).

 - Clean up the CPPC support library code (Ionela Voinescu).

 - Clean up the APEI support code (Yang Li, Yazen Ghannam).

 - Update GPIO-related properties documentation (Flavio Suligoi).

 - Consolidate and clean up the printing of messages in several
   places (Rafael Wysocki).

 - Fix error code path in configfs handling code (Qinglang Miao).

 - Use DEVICE_ATTR_<RW|RO|WO> macros where applicable (Dwaipayan Ray).

 - Replace tests for !ACPI_FAILURE with tests for ACPI_SUCCESS in
   multiple places (Bjorn Helgaas).

Thanks!


---------------

Al Stone (2):
      ACPICA: Remove the MTMR (Mid-Timer) table
      ACPICA: Remove the VRTC table

Andy Shevchenko (4):
      ACPI: property: Remove dead code
      ACPI: property: Make acpi_node_prop_read() static
      ACPI: property: Satisfy kernel doc validator (part 1)
      ACPI: property: Satisfy kernel doc validator (part 2)

Bjorn Helgaas (1):
      ACPI: Test for ACPI_SUCCESS rather than !ACPI_FAILURE

Bob Moore (4):
      ACPICA: add type casts for string functions
      ACPICA: Update version to 20201217
      ACPICA: Updated all copyrights to 2021
      ACPICA: Update version to 20210105

Dwaipayan Ray (1):
      ACPI: Use DEVICE_ATTR_<RW|RO|WO> macros

Flavio Suligoi (1):
      Documentation: ACPI: add new rule for gpio-line-names

Hans de Goede (1):
      ACPI: platform-profile: Fix possible deadlock in platform_profile_remove()

Ionela Voinescu (3):
      ACPI: CPPC: remove __iomem annotation for cpc_reg's address
      ACPI: CPPC: add __iomem annotation to generic_comm_base pointer
      ACPI: CPPC: initialise vaddr pointers to NULL

Jiaxun Yang (2):
      ACPI: platform-profile: Drop const qualifier for cur_profile
      ACPI: platform-profile: Introduce object pointers to callbacks

Mark Pearson (2):
      Documentation: Add documentation for new platform_profile sysfs attribute
      ACPI: platform: Add platform profile support

Maximilian Luz (2):
      ACPICA: Fix exception code class checks
      ACPICA: Clean up exception code class checks

Nick Desaulniers (1):
      ACPICA: fix -Wfallthrough

Qinglang Miao (1):
      ACPI: configfs: add missing check after configfs_register_default_group()

Rafael J. Wysocki (17):
      ACPI: scan: Rearrange memory allocation in acpi_device_add()
      ACPI: scan: Adjust white space in acpi_device_add()
      ACPI: scan: Rearrange code related to acpi_get_device_data()
      ACPI: power: Clean up printing messages
      ACPI: PM: Clean up printing messages
      ACPI: bus: Clean up printing messages
      ACPI: scan: Clean up printing messages
      ACPI: utils: Clean up printing messages
      ACPI: bus: Drop ACPI_BUS_COMPONENT which is not used any more
      ACPI: AC: Clean up printing messages
      ACPI: battery: Clean up printing messages
      ACPI: button: Clean up printing messages
      ACPI: video: Clean up printing messages
      ACPI: thermal: Clean up printing messages
      ACPI: OSL: Rework acpi_check_resource_conflict()
      ACPI: OSL: Clean up printing messages
      ACPI: property: Fix fwnode string properties matching

Yang Li (1):
      ACPI: APEI: ERST: remove unneeded semicolon

Yazen Ghannam (1):
      ACPI: APEI: Add is_generic_error() to identify GHES sources

---------------

 Documentation/ABI/testing/sysfs-platform_profile   |  24 +++
 Documentation/firmware-guide/acpi/debug.rst        |  19 +--
 .../firmware-guide/acpi/gpio-properties.rst        |   1 +
 Documentation/userspace-api/index.rst              |   1 +
 .../userspace-api/sysfs-platform_profile.rst       |  42 +++++
 drivers/acpi/Kconfig                               |  17 ++
 drivers/acpi/Makefile                              |   1 +
 drivers/acpi/ac.c                                  |  23 ++-
 drivers/acpi/acpi_configfs.c                       |   7 +-
 drivers/acpi/acpi_pad.c                            |  24 ++-
 drivers/acpi/acpi_tad.c                            |  14 +-
 drivers/acpi/acpi_video.c                          |  99 ++++++------
 drivers/acpi/acpica/acapps.h                       |   4 +-
 drivers/acpi/acpica/accommon.h                     |   2 +-
 drivers/acpi/acpica/acconvert.h                    |   2 +-
 drivers/acpi/acpica/acdebug.h                      |   2 +-
 drivers/acpi/acpica/acdispat.h                     |   2 +-
 drivers/acpi/acpica/acevents.h                     |   2 +-
 drivers/acpi/acpica/acglobal.h                     |   2 +-
 drivers/acpi/acpica/achware.h                      |   2 +-
 drivers/acpi/acpica/acinterp.h                     |   2 +-
 drivers/acpi/acpica/aclocal.h                      |   2 +-
 drivers/acpi/acpica/acmacros.h                     |   2 +-
 drivers/acpi/acpica/acnamesp.h                     |   2 +-
 drivers/acpi/acpica/acobject.h                     |   2 +-
 drivers/acpi/acpica/acopcode.h                     |   2 +-
 drivers/acpi/acpica/acparser.h                     |   2 +-
 drivers/acpi/acpica/acpredef.h                     |   2 +-
 drivers/acpi/acpica/acresrc.h                      |   2 +-
 drivers/acpi/acpica/acstruct.h                     |   2 +-
 drivers/acpi/acpica/actables.h                     |   2 +-
 drivers/acpi/acpica/acutils.h                      |   2 +-
 drivers/acpi/acpica/amlcode.h                      |   2 +-
 drivers/acpi/acpica/amlresrc.h                     |   2 +-
 drivers/acpi/acpica/dbhistry.c                     |   2 +-
 drivers/acpi/acpica/dbinput.c                      |   4 +-
 drivers/acpi/acpica/dbobject.c                     |   2 +-
 drivers/acpi/acpica/dsargs.c                       |   2 +-
 drivers/acpi/acpica/dscontrol.c                    |   4 +-
 drivers/acpi/acpica/dsdebug.c                      |   4 +-
 drivers/acpi/acpica/dsfield.c                      |   2 +-
 drivers/acpi/acpica/dsinit.c                       |   2 +-
 drivers/acpi/acpica/dsmethod.c                     |   2 +-
 drivers/acpi/acpica/dsobject.c                     |   2 +-
 drivers/acpi/acpica/dsopcode.c                     |   2 +-
 drivers/acpi/acpica/dspkginit.c                    |   2 +-
 drivers/acpi/acpica/dswexec.c                      |   5 +-
 drivers/acpi/acpica/dswload.c                      |   4 +-
 drivers/acpi/acpica/dswload2.c                     |   4 +-
 drivers/acpi/acpica/dswscope.c                     |   2 +-
 drivers/acpi/acpica/dswstate.c                     |   2 +-
 drivers/acpi/acpica/evevent.c                      |   2 +-
 drivers/acpi/acpica/evglock.c                      |   2 +-
 drivers/acpi/acpica/evgpe.c                        |   2 +-
 drivers/acpi/acpica/evgpeblk.c                     |   2 +-
 drivers/acpi/acpica/evgpeinit.c                    |   2 +-
 drivers/acpi/acpica/evgpeutil.c                    |   2 +-
 drivers/acpi/acpica/evhandler.c                    |   2 +-
 drivers/acpi/acpica/evmisc.c                       |   2 +-
 drivers/acpi/acpica/evregion.c                     |   2 +-
 drivers/acpi/acpica/evrgnini.c                     |   2 +-
 drivers/acpi/acpica/evxface.c                      |   2 +-
 drivers/acpi/acpica/evxfevnt.c                     |   2 +-
 drivers/acpi/acpica/evxfgpe.c                      |   2 +-
 drivers/acpi/acpica/evxfregn.c                     |   2 +-
 drivers/acpi/acpica/exconcat.c                     |   2 +-
 drivers/acpi/acpica/exconfig.c                     |   2 +-
 drivers/acpi/acpica/exconvrt.c                     |   2 +-
 drivers/acpi/acpica/excreate.c                     |   2 +-
 drivers/acpi/acpica/exdebug.c                      |   2 +-
 drivers/acpi/acpica/exdump.c                       |   2 +-
 drivers/acpi/acpica/exfield.c                      |   2 +-
 drivers/acpi/acpica/exfldio.c                      |   4 +-
 drivers/acpi/acpica/exmisc.c                       |   2 +-
 drivers/acpi/acpica/exmutex.c                      |   2 +-
 drivers/acpi/acpica/exnames.c                      |   2 +-
 drivers/acpi/acpica/exoparg1.c                     |   2 +-
 drivers/acpi/acpica/exoparg2.c                     |   2 +-
 drivers/acpi/acpica/exoparg3.c                     |   2 +-
 drivers/acpi/acpica/exoparg6.c                     |   2 +-
 drivers/acpi/acpica/exprep.c                       |   2 +-
 drivers/acpi/acpica/exregion.c                     |   2 +-
 drivers/acpi/acpica/exresnte.c                     |   2 +-
 drivers/acpi/acpica/exresolv.c                     |   2 +-
 drivers/acpi/acpica/exresop.c                      |   6 +-
 drivers/acpi/acpica/exserial.c                     |   2 +-
 drivers/acpi/acpica/exstore.c                      |   6 +-
 drivers/acpi/acpica/exstoren.c                     |   2 +-
 drivers/acpi/acpica/exstorob.c                     |   2 +-
 drivers/acpi/acpica/exsystem.c                     |   2 +-
 drivers/acpi/acpica/extrace.c                      |   2 +-
 drivers/acpi/acpica/exutils.c                      |   2 +-
 drivers/acpi/acpica/hwacpi.c                       |   2 +-
 drivers/acpi/acpica/hwesleep.c                     |   2 +-
 drivers/acpi/acpica/hwgpe.c                        |   4 +-
 drivers/acpi/acpica/hwsleep.c                      |   2 +-
 drivers/acpi/acpica/hwtimer.c                      |   2 +-
 drivers/acpi/acpica/hwvalid.c                      |   2 +-
 drivers/acpi/acpica/hwxface.c                      |   2 +-
 drivers/acpi/acpica/hwxfsleep.c                    |   2 +-
 drivers/acpi/acpica/nsarguments.c                  |   2 +-
 drivers/acpi/acpica/nsconvert.c                    |   2 +-
 drivers/acpi/acpica/nsdump.c                       |   2 +-
 drivers/acpi/acpica/nsdumpdv.c                     |   2 +-
 drivers/acpi/acpica/nsinit.c                       |   2 +-
 drivers/acpi/acpica/nsload.c                       |   2 +-
 drivers/acpi/acpica/nsparse.c                      |   2 +-
 drivers/acpi/acpica/nspredef.c                     |   2 +-
 drivers/acpi/acpica/nsprepkg.c                     |   2 +-
 drivers/acpi/acpica/nsrepair.c                     |   2 +-
 drivers/acpi/acpica/nsrepair2.c                    |   2 +-
 drivers/acpi/acpica/nsutils.c                      |   2 +-
 drivers/acpi/acpica/nswalk.c                       |   2 +-
 drivers/acpi/acpica/nsxfname.c                     |   2 +-
 drivers/acpi/acpica/psargs.c                       |   2 +-
 drivers/acpi/acpica/psloop.c                       |   5 +-
 drivers/acpi/acpica/psobject.c                     |   2 +-
 drivers/acpi/acpica/psopcode.c                     |   2 +-
 drivers/acpi/acpica/psopinfo.c                     |   2 +-
 drivers/acpi/acpica/psparse.c                      |   4 +-
 drivers/acpi/acpica/psscope.c                      |   2 +-
 drivers/acpi/acpica/pstree.c                       |   2 +-
 drivers/acpi/acpica/psutils.c                      |   2 +-
 drivers/acpi/acpica/pswalk.c                       |   2 +-
 drivers/acpi/acpica/psxface.c                      |   2 +-
 drivers/acpi/acpica/tbdata.c                       |   2 +-
 drivers/acpi/acpica/tbfadt.c                       |   2 +-
 drivers/acpi/acpica/tbfind.c                       |   2 +-
 drivers/acpi/acpica/tbinstal.c                     |   2 +-
 drivers/acpi/acpica/tbprint.c                      |   2 +-
 drivers/acpi/acpica/tbutils.c                      |   2 +-
 drivers/acpi/acpica/tbxface.c                      |   2 +-
 drivers/acpi/acpica/tbxfload.c                     |   2 +-
 drivers/acpi/acpica/tbxfroot.c                     |   2 +-
 drivers/acpi/acpica/utaddress.c                    |   2 +-
 drivers/acpi/acpica/utalloc.c                      |   2 +-
 drivers/acpi/acpica/utascii.c                      |   2 +-
 drivers/acpi/acpica/utbuffer.c                     |   2 +-
 drivers/acpi/acpica/utcache.c                      |   2 +-
 drivers/acpi/acpica/utcopy.c                       |   2 +-
 drivers/acpi/acpica/utdebug.c                      |   2 +-
 drivers/acpi/acpica/utdecode.c                     |   2 +-
 drivers/acpi/acpica/utdelete.c                     |   2 +-
 drivers/acpi/acpica/uteval.c                       |   2 +-
 drivers/acpi/acpica/utglobal.c                     |   2 +-
 drivers/acpi/acpica/uthex.c                        |   2 +-
 drivers/acpi/acpica/utids.c                        |   2 +-
 drivers/acpi/acpica/utinit.c                       |   2 +-
 drivers/acpi/acpica/utlock.c                       |   2 +-
 drivers/acpi/acpica/utobject.c                     |   2 +-
 drivers/acpi/acpica/utosi.c                        |   2 +-
 drivers/acpi/acpica/utpredef.c                     |   2 +-
 drivers/acpi/acpica/utprint.c                      |   2 +-
 drivers/acpi/acpica/utstrsuppt.c                   |   4 +-
 drivers/acpi/acpica/uttrack.c                      |   2 +-
 drivers/acpi/acpica/utuuid.c                       |   2 +-
 drivers/acpi/acpica/utxface.c                      |   2 +-
 drivers/acpi/acpica/utxfinit.c                     |   2 +-
 drivers/acpi/apei/erst.c                           |   2 +-
 drivers/acpi/apei/hest.c                           |  12 +-
 drivers/acpi/battery.c                             |  33 ++--
 drivers/acpi/bgrt.c                                |  20 +--
 drivers/acpi/bus.c                                 |  60 +++----
 drivers/acpi/button.c                              |  15 +-
 drivers/acpi/cppc_acpi.c                           |   8 +-
 drivers/acpi/device_pm.c                           |  20 +--
 drivers/acpi/device_sysfs.c                        |  44 ++---
 drivers/acpi/dock.c                                |  26 +--
 drivers/acpi/osl.c                                 |  75 ++++-----
 drivers/acpi/platform_profile.c                    | 177 +++++++++++++++++++++
 drivers/acpi/power.c                               |  53 +++---
 drivers/acpi/property.c                            |  73 ++++-----
 drivers/acpi/scan.c                                | 128 +++++++--------
 drivers/acpi/sysfs.c                               |   7 -
 drivers/acpi/thermal.c                             |  87 +++++-----
 drivers/acpi/utils.c                               |  56 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c           |   4 +-
 drivers/gpu/drm/radeon/radeon_bios.c               |   4 +-
 drivers/hwmon/acpi_power_meter.c                   |   4 +-
 drivers/platform/x86/asus-laptop.c                 |   6 +-
 drivers/spi/spi.c                                  |   2 +-
 include/acpi/acbuffer.h                            |   2 +-
 include/acpi/acconfig.h                            |   2 +-
 include/acpi/acexcep.h                             |  12 +-
 include/acpi/acnames.h                             |   2 +-
 include/acpi/acoutput.h                            |   2 +-
 include/acpi/acpi.h                                |   2 +-
 include/acpi/acpi_drivers.h                        |   7 -
 include/acpi/acpiosxf.h                            |   2 +-
 include/acpi/acpixf.h                              |   4 +-
 include/acpi/acrestyp.h                            |   2 +-
 include/acpi/actbl.h                               |   2 +-
 include/acpi/actbl1.h                              |   2 +-
 include/acpi/actbl2.h                              |  26 +--
 include/acpi/actbl3.h                              |  25 +--
 include/acpi/actypes.h                             |   8 +-
 include/acpi/acuuid.h                              |   2 +-
 include/acpi/cppc_acpi.h                           |   2 +-
 include/acpi/platform/acenv.h                      |   2 +-
 include/acpi/platform/acenvex.h                    |   2 +-
 include/acpi/platform/acgcc.h                      |  17 +-
 include/acpi/platform/acgccex.h                    |   2 +-
 include/acpi/platform/acintel.h                    |   2 +-
 include/acpi/platform/aclinux.h                    |   2 +-
 include/acpi/platform/aclinuxex.h                  |   2 +-
 include/linux/acpi.h                               |  32 ----
 include/linux/platform_profile.h                   |  41 +++++
 sound/pci/hda/hda_intel.c                          |   4 +-
 tools/power/acpi/common/cmfsize.c                  |   2 +-
 tools/power/acpi/common/getopt.c                   |   2 +-
 .../acpi/os_specific/service_layers/oslinuxtbl.c   |   2 +-
 .../acpi/os_specific/service_layers/osunixdir.c    |   2 +-
 .../acpi/os_specific/service_layers/osunixmap.c    |   2 +-
 .../acpi/os_specific/service_layers/osunixxf.c     |   2 +-
 tools/power/acpi/tools/acpidump/acpidump.h         |   2 +-
 tools/power/acpi/tools/acpidump/apdump.c           |   2 +-
 tools/power/acpi/tools/acpidump/apfiles.c          |   2 +-
 tools/power/acpi/tools/acpidump/apmain.c           |   2 +-
 218 files changed, 951 insertions(+), 793 deletions(-)
