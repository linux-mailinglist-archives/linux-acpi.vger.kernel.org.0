Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F211A2FF9AC
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 02:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbhAVA51 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jan 2021 19:57:27 -0500
Received: from mga06.intel.com ([134.134.136.31]:34968 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbhAVA5Y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 21 Jan 2021 19:57:24 -0500
IronPort-SDR: hgvLFc/78xASwcchvwn1LnKpi7fhz5uW8enoIAfaLYz7jJJmLn+JU9KgwA2w9WkIibqYIIiYs3
 Px9vNbXJbzag==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="240908707"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="240908707"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 16:56:21 -0800
IronPort-SDR: mB9IcIv/wm4sMFTTEsUvlUIcnyJ+/Z533jQUqwsdJB+1yJn622bMYNcBLMpU8rHS/D8yTnoXdm
 KcILMEf9ZLVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="427595522"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga001.jf.intel.com with ESMTP; 21 Jan 2021 16:56:21 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v2 0/9] ACPICA release 20201217 and 20210105
Date:   Thu, 21 Jan 2021 16:23:48 -0800
Message-Id: <20210122002357.370836-1-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This series contains ACPICA versions 20201217 and 20210105. These
releases are quite small and contain trivial or stylistic fixes as well
as deprecating MTMR and VRTC tables. The copyright update patch is large
in size so it might not come through the mailing list. As an
alternative, this patch set is hosted at the following link on github:

https://github.com/SchmErik/linux/tree/20210105

v2 - replace missing line in include/acpi/actypes.h in Nick's fallthrough
patch. It looks like this line was missing due to a bug in ACPICA's
linuxize scripts...

Al Stone (2):
  ACPICA: Remove the MTMR (Mid-Timer) table
  ACPICA: Remove the VRTC table

Bob Moore (4):
  ACPICA: add type casts for string functions
  ACPICA: Update version to 20201217 Version 20201217.
  ACPICA: Updated all copyrights to 2021
  ACPICA: Update version to 20210105

Maximilian Luz (2):
  ACPICA: Fix exception code class checks
  ACPICA: Clean up exception code class checks

Nick Desaulniers (1):
  ACPICA: ACPICA: fix -Wfallthrough

 drivers/acpi/acpica/acapps.h                  |  4 +--
 drivers/acpi/acpica/accommon.h                |  2 +-
 drivers/acpi/acpica/acconvert.h               |  2 +-
 drivers/acpi/acpica/acdebug.h                 |  2 +-
 drivers/acpi/acpica/acdispat.h                |  2 +-
 drivers/acpi/acpica/acevents.h                |  2 +-
 drivers/acpi/acpica/acglobal.h                |  2 +-
 drivers/acpi/acpica/achware.h                 |  2 +-
 drivers/acpi/acpica/acinterp.h                |  2 +-
 drivers/acpi/acpica/aclocal.h                 |  2 +-
 drivers/acpi/acpica/acmacros.h                |  2 +-
 drivers/acpi/acpica/acnamesp.h                |  2 +-
 drivers/acpi/acpica/acobject.h                |  2 +-
 drivers/acpi/acpica/acopcode.h                |  2 +-
 drivers/acpi/acpica/acparser.h                |  2 +-
 drivers/acpi/acpica/acpredef.h                |  2 +-
 drivers/acpi/acpica/acresrc.h                 |  2 +-
 drivers/acpi/acpica/acstruct.h                |  2 +-
 drivers/acpi/acpica/actables.h                |  2 +-
 drivers/acpi/acpica/acutils.h                 |  2 +-
 drivers/acpi/acpica/amlcode.h                 |  2 +-
 drivers/acpi/acpica/amlresrc.h                |  2 +-
 drivers/acpi/acpica/dbhistry.c                |  2 +-
 drivers/acpi/acpica/dbinput.c                 |  4 +--
 drivers/acpi/acpica/dbobject.c                |  2 +-
 drivers/acpi/acpica/dsargs.c                  |  2 +-
 drivers/acpi/acpica/dscontrol.c               |  4 +--
 drivers/acpi/acpica/dsdebug.c                 |  4 +--
 drivers/acpi/acpica/dsfield.c                 |  2 +-
 drivers/acpi/acpica/dsinit.c                  |  2 +-
 drivers/acpi/acpica/dsmethod.c                |  2 +-
 drivers/acpi/acpica/dsobject.c                |  2 +-
 drivers/acpi/acpica/dsopcode.c                |  2 +-
 drivers/acpi/acpica/dspkginit.c               |  2 +-
 drivers/acpi/acpica/dswexec.c                 |  5 ++--
 drivers/acpi/acpica/dswload.c                 |  4 +--
 drivers/acpi/acpica/dswload2.c                |  4 +--
 drivers/acpi/acpica/dswscope.c                |  2 +-
 drivers/acpi/acpica/dswstate.c                |  2 +-
 drivers/acpi/acpica/evevent.c                 |  2 +-
 drivers/acpi/acpica/evglock.c                 |  2 +-
 drivers/acpi/acpica/evgpe.c                   |  2 +-
 drivers/acpi/acpica/evgpeblk.c                |  2 +-
 drivers/acpi/acpica/evgpeinit.c               |  2 +-
 drivers/acpi/acpica/evgpeutil.c               |  2 +-
 drivers/acpi/acpica/evhandler.c               |  2 +-
 drivers/acpi/acpica/evmisc.c                  |  2 +-
 drivers/acpi/acpica/evregion.c                |  2 +-
 drivers/acpi/acpica/evrgnini.c                |  2 +-
 drivers/acpi/acpica/evxface.c                 |  2 +-
 drivers/acpi/acpica/evxfevnt.c                |  2 +-
 drivers/acpi/acpica/evxfgpe.c                 |  2 +-
 drivers/acpi/acpica/evxfregn.c                |  2 +-
 drivers/acpi/acpica/exconcat.c                |  2 +-
 drivers/acpi/acpica/exconfig.c                |  2 +-
 drivers/acpi/acpica/exconvrt.c                |  2 +-
 drivers/acpi/acpica/excreate.c                |  2 +-
 drivers/acpi/acpica/exdebug.c                 |  2 +-
 drivers/acpi/acpica/exdump.c                  |  2 +-
 drivers/acpi/acpica/exfield.c                 |  2 +-
 drivers/acpi/acpica/exfldio.c                 |  4 +--
 drivers/acpi/acpica/exmisc.c                  |  2 +-
 drivers/acpi/acpica/exmutex.c                 |  2 +-
 drivers/acpi/acpica/exnames.c                 |  2 +-
 drivers/acpi/acpica/exoparg1.c                |  2 +-
 drivers/acpi/acpica/exoparg2.c                |  2 +-
 drivers/acpi/acpica/exoparg3.c                |  2 +-
 drivers/acpi/acpica/exoparg6.c                |  2 +-
 drivers/acpi/acpica/exprep.c                  |  2 +-
 drivers/acpi/acpica/exregion.c                |  2 +-
 drivers/acpi/acpica/exresnte.c                |  2 +-
 drivers/acpi/acpica/exresolv.c                |  2 +-
 drivers/acpi/acpica/exresop.c                 |  6 ++---
 drivers/acpi/acpica/exserial.c                |  2 +-
 drivers/acpi/acpica/exstore.c                 |  6 ++---
 drivers/acpi/acpica/exstoren.c                |  2 +-
 drivers/acpi/acpica/exstorob.c                |  2 +-
 drivers/acpi/acpica/exsystem.c                |  2 +-
 drivers/acpi/acpica/extrace.c                 |  2 +-
 drivers/acpi/acpica/exutils.c                 |  2 +-
 drivers/acpi/acpica/hwacpi.c                  |  2 +-
 drivers/acpi/acpica/hwesleep.c                |  2 +-
 drivers/acpi/acpica/hwgpe.c                   |  4 +--
 drivers/acpi/acpica/hwsleep.c                 |  2 +-
 drivers/acpi/acpica/hwtimer.c                 |  2 +-
 drivers/acpi/acpica/hwvalid.c                 |  2 +-
 drivers/acpi/acpica/hwxface.c                 |  2 +-
 drivers/acpi/acpica/hwxfsleep.c               |  2 +-
 drivers/acpi/acpica/nsarguments.c             |  2 +-
 drivers/acpi/acpica/nsconvert.c               |  2 +-
 drivers/acpi/acpica/nsdump.c                  |  2 +-
 drivers/acpi/acpica/nsdumpdv.c                |  2 +-
 drivers/acpi/acpica/nsinit.c                  |  2 +-
 drivers/acpi/acpica/nsload.c                  |  2 +-
 drivers/acpi/acpica/nsparse.c                 |  2 +-
 drivers/acpi/acpica/nspredef.c                |  2 +-
 drivers/acpi/acpica/nsprepkg.c                |  2 +-
 drivers/acpi/acpica/nsrepair.c                |  2 +-
 drivers/acpi/acpica/nsrepair2.c               |  2 +-
 drivers/acpi/acpica/nsutils.c                 |  2 +-
 drivers/acpi/acpica/nswalk.c                  |  2 +-
 drivers/acpi/acpica/nsxfname.c                |  2 +-
 drivers/acpi/acpica/psargs.c                  |  2 +-
 drivers/acpi/acpica/psloop.c                  |  5 ++--
 drivers/acpi/acpica/psobject.c                |  2 +-
 drivers/acpi/acpica/psopcode.c                |  2 +-
 drivers/acpi/acpica/psopinfo.c                |  2 +-
 drivers/acpi/acpica/psparse.c                 |  4 +--
 drivers/acpi/acpica/psscope.c                 |  2 +-
 drivers/acpi/acpica/pstree.c                  |  2 +-
 drivers/acpi/acpica/psutils.c                 |  2 +-
 drivers/acpi/acpica/pswalk.c                  |  2 +-
 drivers/acpi/acpica/psxface.c                 |  2 +-
 drivers/acpi/acpica/tbdata.c                  |  2 +-
 drivers/acpi/acpica/tbfadt.c                  |  2 +-
 drivers/acpi/acpica/tbfind.c                  |  2 +-
 drivers/acpi/acpica/tbinstal.c                |  2 +-
 drivers/acpi/acpica/tbprint.c                 |  2 +-
 drivers/acpi/acpica/tbutils.c                 |  2 +-
 drivers/acpi/acpica/tbxface.c                 |  2 +-
 drivers/acpi/acpica/tbxfload.c                |  2 +-
 drivers/acpi/acpica/tbxfroot.c                |  2 +-
 drivers/acpi/acpica/utaddress.c               |  2 +-
 drivers/acpi/acpica/utalloc.c                 |  2 +-
 drivers/acpi/acpica/utascii.c                 |  2 +-
 drivers/acpi/acpica/utbuffer.c                |  2 +-
 drivers/acpi/acpica/utcache.c                 |  2 +-
 drivers/acpi/acpica/utcopy.c                  |  2 +-
 drivers/acpi/acpica/utdebug.c                 |  2 +-
 drivers/acpi/acpica/utdecode.c                |  2 +-
 drivers/acpi/acpica/utdelete.c                |  2 +-
 drivers/acpi/acpica/uteval.c                  |  2 +-
 drivers/acpi/acpica/utglobal.c                |  2 +-
 drivers/acpi/acpica/uthex.c                   |  2 +-
 drivers/acpi/acpica/utids.c                   |  2 +-
 drivers/acpi/acpica/utinit.c                  |  2 +-
 drivers/acpi/acpica/utlock.c                  |  2 +-
 drivers/acpi/acpica/utobject.c                |  2 +-
 drivers/acpi/acpica/utosi.c                   |  2 +-
 drivers/acpi/acpica/utpredef.c                |  2 +-
 drivers/acpi/acpica/utprint.c                 |  2 +-
 drivers/acpi/acpica/utstrsuppt.c              |  4 +--
 drivers/acpi/acpica/uttrack.c                 |  2 +-
 drivers/acpi/acpica/utuuid.c                  |  2 +-
 drivers/acpi/acpica/utxface.c                 |  2 +-
 drivers/acpi/acpica/utxfinit.c                |  2 +-
 include/acpi/acbuffer.h                       |  2 +-
 include/acpi/acconfig.h                       |  2 +-
 include/acpi/acexcep.h                        | 12 ++++-----
 include/acpi/acnames.h                        |  2 +-
 include/acpi/acoutput.h                       |  2 +-
 include/acpi/acpi.h                           |  2 +-
 include/acpi/acpiosxf.h                       |  2 +-
 include/acpi/acpixf.h                         |  4 +--
 include/acpi/acrestyp.h                       |  2 +-
 include/acpi/actbl.h                          |  2 +-
 include/acpi/actbl1.h                         |  2 +-
 include/acpi/actbl2.h                         | 26 +------------------
 include/acpi/actbl3.h                         | 25 +-----------------
 include/acpi/actypes.h                        |  8 +++++-
 include/acpi/acuuid.h                         |  2 +-
 include/acpi/platform/acenv.h                 |  2 +-
 include/acpi/platform/acenvex.h               |  2 +-
 include/acpi/platform/acgcc.h                 | 17 +++++++++++-
 include/acpi/platform/acgccex.h               |  2 +-
 include/acpi/platform/acintel.h               |  2 +-
 include/acpi/platform/aclinux.h               |  2 +-
 include/acpi/platform/aclinuxex.h             |  2 +-
 tools/power/acpi/common/cmfsize.c             |  2 +-
 tools/power/acpi/common/getopt.c              |  2 +-
 .../os_specific/service_layers/oslinuxtbl.c   |  2 +-
 .../os_specific/service_layers/osunixdir.c    |  2 +-
 .../os_specific/service_layers/osunixmap.c    |  2 +-
 .../os_specific/service_layers/osunixxf.c     |  2 +-
 tools/power/acpi/tools/acpidump/acpidump.h    |  2 +-
 tools/power/acpi/tools/acpidump/apdump.c      |  2 +-
 tools/power/acpi/tools/acpidump/apfiles.c     |  2 +-
 tools/power/acpi/tools/acpidump/apmain.c      |  2 +-
 178 files changed, 221 insertions(+), 249 deletions(-)

-- 
2.29.2

