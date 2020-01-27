Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15D8B14A824
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Jan 2020 17:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgA0QdZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 27 Jan 2020 11:33:25 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40900 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgA0QdZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jan 2020 11:33:25 -0500
Received: by mail-ot1-f66.google.com with SMTP id i6so5086198otr.7;
        Mon, 27 Jan 2020 08:33:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=f/ZGrZ9HsT6m0ACGhs2b9a+taXd9uRKJVazaOYIqfgc=;
        b=uNaoGDFfCsVdQJSQfJTDzPxLnWcwJJArOkth5Ib4+Qd9zm7hIZqHgI3g42jnsJsfKe
         Zh+IhNV99vNjPIwfw5X/lWdTQt5CAQxabLKOXQpkoZpFM5G+nh3zp42w7Jy0UbUqrNi4
         mU13IjpsxuA0QJM9uawy4pGXhFCKJNXj+BpADQfVxesMdL8Kg4MOmS36hjjKDPpHGaua
         9ZMSx11Rr2u5cK5X+WSFcTYLfQ7LV4WLccQfGMWHYIPs9zKezEuWh3QbvKqj8zUBhBeV
         TigdNCBvnvsF2QCovheDLWFqvtV6WSD66L1Rrzwkzjk3fXzwTOrqvlE7MvsbEm6v1r0n
         UakA==
X-Gm-Message-State: APjAAAVKL91j+J4BZRdaamBonOS2X8aydXyTGs6cy6LmtsT8NAjAlKml
        FjLioLtRGrbPmzWof5S5cw7X71DERetpFKTP56PkApHK
X-Google-Smtp-Source: APXvYqwpKJ1FM3ArpHg5ydqbpoltI25GBDgqtVln3A8hzr1RDwqFp4xjQlFHlcRA0uPNj+Rau68zt8qzpQXN8qdK5LA=
X-Received: by 2002:a05:6830:4b9:: with SMTP id l25mr13364327otd.266.1580142803396;
 Mon, 27 Jan 2020 08:33:23 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jan 2020 17:33:12 +0100
Message-ID: <CAJZ5v0iRaeR4n=ddVM9pJj0oxRpv1K2UWXqZbwiNmkrOPr3h1w@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v5.6-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.6-rc1

with top-most commit ca11abf113474fe8e1205c6851a9a6ffd598bb26

 Merge branches 'acpi-tables', 'acpi-button', 'acpi-ec', 'acpi-doc'
and 'acpi-tools'

on top of commit b3a987b0264d3ddbb24293ebff10eddfc472f653

 Linux 5.5-rc6

to receive ACPI updates for 5.6-rc1.

These update the ACPICA code in the kernel to the most recent
upstream revision (20200110), add new hardware support to a handful
of ACPI drivers, make the ACPI fan driver expose power states
information for fans, add some more quirks, fix bugs and clean up
assorted things.

Specifics:

 - Update the ACPICA code in the kernel to upstream revision
   20200110 including:

   * Update of copyright notices to 2020 (Bob Moore).

   * Dispatcher fix to always generate buffer objects for the ASL
     create_field() operator (Maximilian Luz).

   * Debugger cleanup (Colin Ian King).

   * Disassembler change to create buffer fields in
     ACPI_PARSE_LOAD_PASS1 (Erik Kaneda).

   * UNIX line ending support for non-windows builds in acpisrc
     (Erik Kaneda).

 - Update the list of ACPICA maintainers (Rafael Wysocki).

 - Add Intel Tiger Lake ACPI device IDs to the ACPI DPTF, ACPI fan,
   int340x_thermal and intel-hid drivers (Gayatri Kammela).

 - Make the ACPI fan driver create additional sysfs attributes to
   expose power states information for fans (Srinivas Pandruvada).

 - Fix up the ACPI battery driver to deal with unexpected battery
   capacity information in a better way (Hans de Goede).

 - Add ACPI backlight quirks for Lenovo E41-25/45 and MSI MS-7721
   boards (Aaron Ma, Hans de Goede).

 - Add DMI quirk for Razer Blade Stealth 13 late 2019 lid switch
   to the ACPI button driver (Jason Ekstrand).

 - Drop TIMER_DEFERRABLE from the GHES polling mode timer function
   flags to make it run precisely at the configured time (Bhaskar
   Upadhaya).

 - Fix race condition related to the reference counting of query
   handlers in the ACPI EC driver (Rafael Wysocki).

 - Fix ACPI tools build issue (Zhengyuan Liu).

 - Replace dma_request_slave_channel() with dma_request_chan() in the
   firmware guide documentation for ACPI (Peter Ujfalusi).

 - Fix typo in a comment and clean up function parameter data type
   inconsistencies (Kacper Piwiński, Tian Tao).

Thanks!


---------------

Aaron Ma (1):
      ACPI: video: Use native backlight on Lenovo E41-25/45

Bhaskar Upadhaya (1):
      apei/ghes: Do not delay GHES polling

Bob Moore (3):
      ACPICA: Update version to 20191213
      ACPICA: All acpica: Update copyrights to 2020 Including tool signons.
      ACPICA: Update version to 20200110

Colin Ian King (1):
      ACPICA: debugger: fix spelling mistake "adress" -> "address"

Erik Kaneda (2):
      ACPICA: Disassembler: create buffer fields in ACPI_PARSE_LOAD_PASS1
      ACPICA: acpisrc: add unix line ending support for non-windows build

Gayatri Kammela (4):
      ACPI: DPTF: Add Tiger Lake ACPI device IDs
      ACPI: fan: Add Tiger Lake ACPI device ID
      platform/x86: intel-hid: Add Tiger Lake ACPI device ID
      thermal: int340x_thermal: Add Tiger Lake ACPI device IDs

Hans de Goede (4):
      ACPI / battery: Deal with design or full capacity being reported as -1
      ACPI / battery: Use design-cap for capacity calculations if
full-cap is not available
      ACPI / battery: Deal better with neither design nor full
capacity not being reported
      ACPI: video: Do not export a non working backlight interface on
MSI MS-7721 boards

Jason Ekstrand (1):
      ACPI: button: Add DMI quirk for Razer Blade Stealth 13 late 2019
lid switch

Kacper Piwiński (1):
      ACPI: video: fix typo in comment

Maximilian Luz (1):
      ACPICA: Dispatcher: always generate buffer objects for ASL
create_field() operator

Peter Ujfalusi (1):
      docs: firmware-guide: ACPI: Replace dma_request_slave_channel()
with dma_request_chan()

Rafael J. Wysocki (2):
      ACPICA: Update the list of maintainers
      ACPI: EC: Reference count query handlers under lock

Srinivas Pandruvada (1):
      ACPI: fan: Expose fan performance state information

Tian Tao (1):
      ACPI: PPTT: Consistently use unsigned int as parameter type

Zhengyuan Liu (1):
      tools/power/acpi: fix compilation error

---------------

 .mailmap                                           |  1 +
 .../admin-guide/acpi/fan_performance_states.rst    | 62 ++++++++++++++
 Documentation/admin-guide/acpi/index.rst           |  1 +
 Documentation/firmware-guide/acpi/enumeration.rst  | 16 ++--
 MAINTAINERS                                        |  2 +-
 drivers/acpi/acpi_video.c                          |  2 +-
 drivers/acpi/acpica/acapps.h                       |  4 +-
 drivers/acpi/acpica/accommon.h                     |  2 +-
 drivers/acpi/acpica/acconvert.h                    |  2 +-
 drivers/acpi/acpica/acdebug.h                      |  2 +-
 drivers/acpi/acpica/acdispat.h                     |  2 +-
 drivers/acpi/acpica/acevents.h                     |  2 +-
 drivers/acpi/acpica/acglobal.h                     |  2 +-
 drivers/acpi/acpica/achware.h                      |  2 +-
 drivers/acpi/acpica/acinterp.h                     |  2 +-
 drivers/acpi/acpica/aclocal.h                      |  2 +-
 drivers/acpi/acpica/acmacros.h                     |  2 +-
 drivers/acpi/acpica/acnamesp.h                     |  2 +-
 drivers/acpi/acpica/acobject.h                     |  5 +-
 drivers/acpi/acpica/acopcode.h                     |  2 +-
 drivers/acpi/acpica/acparser.h                     |  2 +-
 drivers/acpi/acpica/acpredef.h                     |  2 +-
 drivers/acpi/acpica/acresrc.h                      |  2 +-
 drivers/acpi/acpica/acstruct.h                     |  2 +-
 drivers/acpi/acpica/actables.h                     |  2 +-
 drivers/acpi/acpica/acutils.h                      |  2 +-
 drivers/acpi/acpica/amlcode.h                      |  2 +-
 drivers/acpi/acpica/amlresrc.h                     |  2 +-
 drivers/acpi/acpica/dbhistry.c                     |  2 +-
 drivers/acpi/acpica/dbinput.c                      |  2 +-
 drivers/acpi/acpica/dsargs.c                       |  2 +-
 drivers/acpi/acpica/dscontrol.c                    |  2 +-
 drivers/acpi/acpica/dsdebug.c                      |  2 +-
 drivers/acpi/acpica/dsfield.c                      |  4 +-
 drivers/acpi/acpica/dsinit.c                       |  2 +-
 drivers/acpi/acpica/dsmethod.c                     |  2 +-
 drivers/acpi/acpica/dsobject.c                     |  2 +-
 drivers/acpi/acpica/dsopcode.c                     |  4 +-
 drivers/acpi/acpica/dspkginit.c                    |  2 +-
 drivers/acpi/acpica/dswexec.c                      |  2 +-
 drivers/acpi/acpica/dswload.c                      | 23 ++++-
 drivers/acpi/acpica/dswload2.c                     |  2 +-
 drivers/acpi/acpica/dswscope.c                     |  2 +-
 drivers/acpi/acpica/dswstate.c                     |  2 +-
 drivers/acpi/acpica/evevent.c                      |  2 +-
 drivers/acpi/acpica/evglock.c                      |  2 +-
 drivers/acpi/acpica/evgpe.c                        |  2 +-
 drivers/acpi/acpica/evgpeblk.c                     |  2 +-
 drivers/acpi/acpica/evgpeinit.c                    |  2 +-
 drivers/acpi/acpica/evgpeutil.c                    |  2 +-
 drivers/acpi/acpica/evhandler.c                    |  2 +-
 drivers/acpi/acpica/evmisc.c                       |  2 +-
 drivers/acpi/acpica/evregion.c                     |  2 +-
 drivers/acpi/acpica/evrgnini.c                     |  2 +-
 drivers/acpi/acpica/evxface.c                      |  2 +-
 drivers/acpi/acpica/evxfevnt.c                     |  2 +-
 drivers/acpi/acpica/evxfgpe.c                      |  2 +-
 drivers/acpi/acpica/evxfregn.c                     |  2 +-
 drivers/acpi/acpica/exconcat.c                     |  2 +-
 drivers/acpi/acpica/exconfig.c                     |  2 +-
 drivers/acpi/acpica/exconvrt.c                     |  2 +-
 drivers/acpi/acpica/excreate.c                     |  2 +-
 drivers/acpi/acpica/exdebug.c                      |  2 +-
 drivers/acpi/acpica/exdump.c                       |  2 +-
 drivers/acpi/acpica/exfield.c                      | 12 ++-
 drivers/acpi/acpica/exfldio.c                      |  2 +-
 drivers/acpi/acpica/exmisc.c                       |  2 +-
 drivers/acpi/acpica/exmutex.c                      |  2 +-
 drivers/acpi/acpica/exnames.c                      |  2 +-
 drivers/acpi/acpica/exoparg1.c                     |  2 +-
 drivers/acpi/acpica/exoparg2.c                     |  2 +-
 drivers/acpi/acpica/exoparg3.c                     |  2 +-
 drivers/acpi/acpica/exoparg6.c                     |  2 +-
 drivers/acpi/acpica/exprep.c                       |  2 +-
 drivers/acpi/acpica/exregion.c                     |  2 +-
 drivers/acpi/acpica/exresnte.c                     |  2 +-
 drivers/acpi/acpica/exresolv.c                     |  2 +-
 drivers/acpi/acpica/exresop.c                      |  2 +-
 drivers/acpi/acpica/exserial.c                     |  2 +-
 drivers/acpi/acpica/exstore.c                      |  2 +-
 drivers/acpi/acpica/exstoren.c                     |  2 +-
 drivers/acpi/acpica/exstorob.c                     |  2 +-
 drivers/acpi/acpica/exsystem.c                     |  2 +-
 drivers/acpi/acpica/extrace.c                      |  2 +-
 drivers/acpi/acpica/exutils.c                      |  2 +-
 drivers/acpi/acpica/hwacpi.c                       |  2 +-
 drivers/acpi/acpica/hwesleep.c                     |  2 +-
 drivers/acpi/acpica/hwgpe.c                        |  2 +-
 drivers/acpi/acpica/hwsleep.c                      |  2 +-
 drivers/acpi/acpica/hwtimer.c                      |  2 +-
 drivers/acpi/acpica/hwvalid.c                      |  2 +-
 drivers/acpi/acpica/hwxface.c                      |  2 +-
 drivers/acpi/acpica/hwxfsleep.c                    |  2 +-
 drivers/acpi/acpica/nsarguments.c                  |  2 +-
 drivers/acpi/acpica/nsconvert.c                    |  2 +-
 drivers/acpi/acpica/nsdump.c                       |  2 +-
 drivers/acpi/acpica/nsdumpdv.c                     |  2 +-
 drivers/acpi/acpica/nsinit.c                       |  2 +-
 drivers/acpi/acpica/nsload.c                       |  2 +-
 drivers/acpi/acpica/nsparse.c                      |  2 +-
 drivers/acpi/acpica/nspredef.c                     |  2 +-
 drivers/acpi/acpica/nsprepkg.c                     |  2 +-
 drivers/acpi/acpica/nsrepair.c                     |  2 +-
 drivers/acpi/acpica/nsrepair2.c                    |  2 +-
 drivers/acpi/acpica/nsutils.c                      |  2 +-
 drivers/acpi/acpica/nswalk.c                       |  2 +-
 drivers/acpi/acpica/nsxfname.c                     |  2 +-
 drivers/acpi/acpica/psargs.c                       |  2 +-
 drivers/acpi/acpica/psloop.c                       |  2 +-
 drivers/acpi/acpica/psobject.c                     |  2 +-
 drivers/acpi/acpica/psopcode.c                     |  2 +-
 drivers/acpi/acpica/psopinfo.c                     |  2 +-
 drivers/acpi/acpica/psparse.c                      |  2 +-
 drivers/acpi/acpica/psscope.c                      |  2 +-
 drivers/acpi/acpica/pstree.c                       |  2 +-
 drivers/acpi/acpica/psutils.c                      |  2 +-
 drivers/acpi/acpica/pswalk.c                       |  2 +-
 drivers/acpi/acpica/psxface.c                      |  2 +-
 drivers/acpi/acpica/tbdata.c                       |  2 +-
 drivers/acpi/acpica/tbfadt.c                       |  2 +-
 drivers/acpi/acpica/tbfind.c                       |  2 +-
 drivers/acpi/acpica/tbinstal.c                     |  2 +-
 drivers/acpi/acpica/tbprint.c                      |  2 +-
 drivers/acpi/acpica/tbutils.c                      |  2 +-
 drivers/acpi/acpica/tbxface.c                      |  2 +-
 drivers/acpi/acpica/tbxfload.c                     |  2 +-
 drivers/acpi/acpica/tbxfroot.c                     |  2 +-
 drivers/acpi/acpica/utaddress.c                    |  2 +-
 drivers/acpi/acpica/utalloc.c                      |  2 +-
 drivers/acpi/acpica/utascii.c                      |  2 +-
 drivers/acpi/acpica/utbuffer.c                     |  2 +-
 drivers/acpi/acpica/utcache.c                      |  2 +-
 drivers/acpi/acpica/utcopy.c                       |  2 +-
 drivers/acpi/acpica/utdebug.c                      |  2 +-
 drivers/acpi/acpica/utdecode.c                     |  2 +-
 drivers/acpi/acpica/uteval.c                       |  2 +-
 drivers/acpi/acpica/utglobal.c                     |  2 +-
 drivers/acpi/acpica/uthex.c                        |  2 +-
 drivers/acpi/acpica/utids.c                        |  2 +-
 drivers/acpi/acpica/utinit.c                       |  2 +-
 drivers/acpi/acpica/utlock.c                       |  2 +-
 drivers/acpi/acpica/utobject.c                     |  2 +-
 drivers/acpi/acpica/utosi.c                        |  2 +-
 drivers/acpi/acpica/utpredef.c                     |  2 +-
 drivers/acpi/acpica/utprint.c                      |  2 +-
 drivers/acpi/acpica/uttrack.c                      |  2 +-
 drivers/acpi/acpica/utuuid.c                       |  2 +-
 drivers/acpi/acpica/utxface.c                      |  2 +-
 drivers/acpi/acpica/utxfinit.c                     |  2 +-
 drivers/acpi/apei/ghes.c                           |  2 +-
 drivers/acpi/battery.c                             | 75 ++++++++++++-----
 drivers/acpi/button.c                              | 11 +++
 drivers/acpi/device_pm.c                           |  1 +
 drivers/acpi/dptf/dptf_power.c                     |  1 +
 drivers/acpi/dptf/int340x_thermal.c                |  4 +
 drivers/acpi/ec.c                                  | 16 +---
 drivers/acpi/fan.c                                 | 97 ++++++++++++++++++++--
 drivers/acpi/pptt.c                                | 29 +++----
 drivers/acpi/video_detect.c                        | 29 +++++++
 drivers/platform/x86/intel-hid.c                   |  1 +
 .../intel/int340x_thermal/int3400_thermal.c        |  1 +
 .../intel/int340x_thermal/int3403_thermal.c        |  1 +
 include/acpi/acbuffer.h                            |  2 +-
 include/acpi/acconfig.h                            |  2 +-
 include/acpi/acexcep.h                             |  2 +-
 include/acpi/acnames.h                             |  2 +-
 include/acpi/acoutput.h                            |  2 +-
 include/acpi/acpi.h                                |  2 +-
 include/acpi/acpiosxf.h                            |  2 +-
 include/acpi/acpixf.h                              |  4 +-
 include/acpi/acrestyp.h                            |  2 +-
 include/acpi/actbl.h                               |  2 +-
 include/acpi/actbl1.h                              |  2 +-
 include/acpi/actbl2.h                              |  2 +-
 include/acpi/actbl3.h                              |  2 +-
 include/acpi/actypes.h                             |  2 +-
 include/acpi/acuuid.h                              |  2 +-
 include/acpi/platform/acenv.h                      | 13 ++-
 include/acpi/platform/acenvex.h                    |  2 +-
 include/acpi/platform/acgcc.h                      |  2 +-
 include/acpi/platform/acgccex.h                    |  2 +-
 include/acpi/platform/acintel.h                    |  2 +-
 include/acpi/platform/aclinux.h                    |  2 +-
 include/acpi/platform/aclinuxex.h                  |  2 +-
 tools/power/acpi/Makefile.config                   |  2 +-
 tools/power/acpi/common/cmfsize.c                  |  2 +-
 tools/power/acpi/common/getopt.c                   |  2 +-
 .../acpi/os_specific/service_layers/oslinuxtbl.c   |  2 +-
 .../acpi/os_specific/service_layers/osunixdir.c    |  2 +-
 .../acpi/os_specific/service_layers/osunixmap.c    |  2 +-
 .../acpi/os_specific/service_layers/osunixxf.c     |  2 +-
 tools/power/acpi/tools/acpidump/acpidump.h         |  2 +-
 tools/power/acpi/tools/acpidump/apdump.c           |  2 +-
 tools/power/acpi/tools/acpidump/apfiles.c          |  2 +-
 tools/power/acpi/tools/acpidump/apmain.c           |  2 +-
 195 files changed, 511 insertions(+), 246 deletions(-)
