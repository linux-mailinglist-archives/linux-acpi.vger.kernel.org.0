Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0492FF9B5
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 02:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbhAVA7b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jan 2021 19:59:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:35006 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbhAVA7W (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 21 Jan 2021 19:59:22 -0500
IronPort-SDR: I7hni6oKypzz3ksarvlfhFlC8hb3nOex8BaDI/U9FPrjaJ8M/SKMIv6zs8AOpk2+aX5j7GbCtF
 IL35scEfnPrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="240908715"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="240908715"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 16:56:22 -0800
IronPort-SDR: th7X/CHZS/RiVJMEkmEMGAYRX5rs/81SBogyJhs9ppngR2Xgpji7QWx8uTcxYOWwlQiqarY3qp
 0NyQGI+a3XZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="427595552"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga001.jf.intel.com with ESMTP; 21 Jan 2021 16:56:22 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v2 8/9] ACPICA: Updated all copyrights to 2021
Date:   Thu, 21 Jan 2021 16:23:56 -0800
Message-Id: <20210122002357.370836-9-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122002357.370836-1-erik.kaneda@intel.com>
References: <20210122002357.370836-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

This affects all ACPICA source code modules.

ACPICA commit c570953c914437e621dd5f160f26ddf352e0d2f4

Link: https://github.com/acpica/acpica/commit/c570953c
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 drivers/acpi/acpica/acapps.h                             | 4 ++--
 drivers/acpi/acpica/accommon.h                           | 2 +-
 drivers/acpi/acpica/acconvert.h                          | 2 +-
 drivers/acpi/acpica/acdebug.h                            | 2 +-
 drivers/acpi/acpica/acdispat.h                           | 2 +-
 drivers/acpi/acpica/acevents.h                           | 2 +-
 drivers/acpi/acpica/acglobal.h                           | 2 +-
 drivers/acpi/acpica/achware.h                            | 2 +-
 drivers/acpi/acpica/acinterp.h                           | 2 +-
 drivers/acpi/acpica/aclocal.h                            | 2 +-
 drivers/acpi/acpica/acmacros.h                           | 2 +-
 drivers/acpi/acpica/acnamesp.h                           | 2 +-
 drivers/acpi/acpica/acobject.h                           | 2 +-
 drivers/acpi/acpica/acopcode.h                           | 2 +-
 drivers/acpi/acpica/acparser.h                           | 2 +-
 drivers/acpi/acpica/acpredef.h                           | 2 +-
 drivers/acpi/acpica/acresrc.h                            | 2 +-
 drivers/acpi/acpica/acstruct.h                           | 2 +-
 drivers/acpi/acpica/actables.h                           | 2 +-
 drivers/acpi/acpica/acutils.h                            | 2 +-
 drivers/acpi/acpica/amlcode.h                            | 2 +-
 drivers/acpi/acpica/amlresrc.h                           | 2 +-
 drivers/acpi/acpica/dbhistry.c                           | 2 +-
 drivers/acpi/acpica/dsargs.c                             | 2 +-
 drivers/acpi/acpica/dscontrol.c                          | 2 +-
 drivers/acpi/acpica/dsdebug.c                            | 2 +-
 drivers/acpi/acpica/dsfield.c                            | 2 +-
 drivers/acpi/acpica/dsinit.c                             | 2 +-
 drivers/acpi/acpica/dsmethod.c                           | 2 +-
 drivers/acpi/acpica/dsobject.c                           | 2 +-
 drivers/acpi/acpica/dsopcode.c                           | 2 +-
 drivers/acpi/acpica/dspkginit.c                          | 2 +-
 drivers/acpi/acpica/dswexec.c                            | 2 +-
 drivers/acpi/acpica/dswload.c                            | 2 +-
 drivers/acpi/acpica/dswload2.c                           | 2 +-
 drivers/acpi/acpica/dswscope.c                           | 2 +-
 drivers/acpi/acpica/dswstate.c                           | 2 +-
 drivers/acpi/acpica/evevent.c                            | 2 +-
 drivers/acpi/acpica/evglock.c                            | 2 +-
 drivers/acpi/acpica/evgpe.c                              | 2 +-
 drivers/acpi/acpica/evgpeblk.c                           | 2 +-
 drivers/acpi/acpica/evgpeinit.c                          | 2 +-
 drivers/acpi/acpica/evgpeutil.c                          | 2 +-
 drivers/acpi/acpica/evhandler.c                          | 2 +-
 drivers/acpi/acpica/evmisc.c                             | 2 +-
 drivers/acpi/acpica/evregion.c                           | 2 +-
 drivers/acpi/acpica/evrgnini.c                           | 2 +-
 drivers/acpi/acpica/evxface.c                            | 2 +-
 drivers/acpi/acpica/evxfevnt.c                           | 2 +-
 drivers/acpi/acpica/evxfgpe.c                            | 2 +-
 drivers/acpi/acpica/evxfregn.c                           | 2 +-
 drivers/acpi/acpica/exconcat.c                           | 2 +-
 drivers/acpi/acpica/exconfig.c                           | 2 +-
 drivers/acpi/acpica/exconvrt.c                           | 2 +-
 drivers/acpi/acpica/excreate.c                           | 2 +-
 drivers/acpi/acpica/exdebug.c                            | 2 +-
 drivers/acpi/acpica/exdump.c                             | 2 +-
 drivers/acpi/acpica/exfield.c                            | 2 +-
 drivers/acpi/acpica/exfldio.c                            | 2 +-
 drivers/acpi/acpica/exmisc.c                             | 2 +-
 drivers/acpi/acpica/exmutex.c                            | 2 +-
 drivers/acpi/acpica/exnames.c                            | 2 +-
 drivers/acpi/acpica/exoparg1.c                           | 2 +-
 drivers/acpi/acpica/exoparg2.c                           | 2 +-
 drivers/acpi/acpica/exoparg3.c                           | 2 +-
 drivers/acpi/acpica/exoparg6.c                           | 2 +-
 drivers/acpi/acpica/exprep.c                             | 2 +-
 drivers/acpi/acpica/exregion.c                           | 2 +-
 drivers/acpi/acpica/exresnte.c                           | 2 +-
 drivers/acpi/acpica/exresolv.c                           | 2 +-
 drivers/acpi/acpica/exresop.c                            | 2 +-
 drivers/acpi/acpica/exserial.c                           | 2 +-
 drivers/acpi/acpica/exstore.c                            | 2 +-
 drivers/acpi/acpica/exstoren.c                           | 2 +-
 drivers/acpi/acpica/exstorob.c                           | 2 +-
 drivers/acpi/acpica/exsystem.c                           | 2 +-
 drivers/acpi/acpica/extrace.c                            | 2 +-
 drivers/acpi/acpica/exutils.c                            | 2 +-
 drivers/acpi/acpica/hwacpi.c                             | 2 +-
 drivers/acpi/acpica/hwesleep.c                           | 2 +-
 drivers/acpi/acpica/hwgpe.c                              | 2 +-
 drivers/acpi/acpica/hwsleep.c                            | 2 +-
 drivers/acpi/acpica/hwtimer.c                            | 2 +-
 drivers/acpi/acpica/hwvalid.c                            | 2 +-
 drivers/acpi/acpica/hwxface.c                            | 2 +-
 drivers/acpi/acpica/hwxfsleep.c                          | 2 +-
 drivers/acpi/acpica/nsarguments.c                        | 2 +-
 drivers/acpi/acpica/nsconvert.c                          | 2 +-
 drivers/acpi/acpica/nsdump.c                             | 2 +-
 drivers/acpi/acpica/nsdumpdv.c                           | 2 +-
 drivers/acpi/acpica/nsinit.c                             | 2 +-
 drivers/acpi/acpica/nsload.c                             | 2 +-
 drivers/acpi/acpica/nsparse.c                            | 2 +-
 drivers/acpi/acpica/nspredef.c                           | 2 +-
 drivers/acpi/acpica/nsprepkg.c                           | 2 +-
 drivers/acpi/acpica/nsrepair.c                           | 2 +-
 drivers/acpi/acpica/nsrepair2.c                          | 2 +-
 drivers/acpi/acpica/nsutils.c                            | 2 +-
 drivers/acpi/acpica/nswalk.c                             | 2 +-
 drivers/acpi/acpica/nsxfname.c                           | 2 +-
 drivers/acpi/acpica/psargs.c                             | 2 +-
 drivers/acpi/acpica/psloop.c                             | 2 +-
 drivers/acpi/acpica/psobject.c                           | 2 +-
 drivers/acpi/acpica/psopcode.c                           | 2 +-
 drivers/acpi/acpica/psopinfo.c                           | 2 +-
 drivers/acpi/acpica/psparse.c                            | 2 +-
 drivers/acpi/acpica/psscope.c                            | 2 +-
 drivers/acpi/acpica/pstree.c                             | 2 +-
 drivers/acpi/acpica/psutils.c                            | 2 +-
 drivers/acpi/acpica/pswalk.c                             | 2 +-
 drivers/acpi/acpica/psxface.c                            | 2 +-
 drivers/acpi/acpica/tbdata.c                             | 2 +-
 drivers/acpi/acpica/tbfadt.c                             | 2 +-
 drivers/acpi/acpica/tbfind.c                             | 2 +-
 drivers/acpi/acpica/tbinstal.c                           | 2 +-
 drivers/acpi/acpica/tbprint.c                            | 2 +-
 drivers/acpi/acpica/tbutils.c                            | 2 +-
 drivers/acpi/acpica/tbxface.c                            | 2 +-
 drivers/acpi/acpica/tbxfload.c                           | 2 +-
 drivers/acpi/acpica/tbxfroot.c                           | 2 +-
 drivers/acpi/acpica/utaddress.c                          | 2 +-
 drivers/acpi/acpica/utalloc.c                            | 2 +-
 drivers/acpi/acpica/utascii.c                            | 2 +-
 drivers/acpi/acpica/utbuffer.c                           | 2 +-
 drivers/acpi/acpica/utcache.c                            | 2 +-
 drivers/acpi/acpica/utcopy.c                             | 2 +-
 drivers/acpi/acpica/utdebug.c                            | 2 +-
 drivers/acpi/acpica/utdecode.c                           | 2 +-
 drivers/acpi/acpica/uteval.c                             | 2 +-
 drivers/acpi/acpica/utglobal.c                           | 2 +-
 drivers/acpi/acpica/uthex.c                              | 2 +-
 drivers/acpi/acpica/utids.c                              | 2 +-
 drivers/acpi/acpica/utinit.c                             | 2 +-
 drivers/acpi/acpica/utlock.c                             | 2 +-
 drivers/acpi/acpica/utobject.c                           | 2 +-
 drivers/acpi/acpica/utosi.c                              | 2 +-
 drivers/acpi/acpica/utpredef.c                           | 2 +-
 drivers/acpi/acpica/utprint.c                            | 2 +-
 drivers/acpi/acpica/uttrack.c                            | 2 +-
 drivers/acpi/acpica/utuuid.c                             | 2 +-
 drivers/acpi/acpica/utxface.c                            | 2 +-
 drivers/acpi/acpica/utxfinit.c                           | 2 +-
 include/acpi/acbuffer.h                                  | 2 +-
 include/acpi/acconfig.h                                  | 2 +-
 include/acpi/acexcep.h                                   | 2 +-
 include/acpi/acnames.h                                   | 2 +-
 include/acpi/acoutput.h                                  | 2 +-
 include/acpi/acpi.h                                      | 2 +-
 include/acpi/acpiosxf.h                                  | 2 +-
 include/acpi/acpixf.h                                    | 2 +-
 include/acpi/acrestyp.h                                  | 2 +-
 include/acpi/actbl.h                                     | 2 +-
 include/acpi/actbl1.h                                    | 2 +-
 include/acpi/actbl2.h                                    | 2 +-
 include/acpi/actbl3.h                                    | 2 +-
 include/acpi/actypes.h                                   | 2 +-
 include/acpi/acuuid.h                                    | 2 +-
 include/acpi/platform/acenv.h                            | 2 +-
 include/acpi/platform/acenvex.h                          | 2 +-
 include/acpi/platform/acgcc.h                            | 2 +-
 include/acpi/platform/acgccex.h                          | 2 +-
 include/acpi/platform/acintel.h                          | 2 +-
 include/acpi/platform/aclinux.h                          | 2 +-
 include/acpi/platform/aclinuxex.h                        | 2 +-
 tools/power/acpi/common/cmfsize.c                        | 2 +-
 tools/power/acpi/common/getopt.c                         | 2 +-
 tools/power/acpi/os_specific/service_layers/oslinuxtbl.c | 2 +-
 tools/power/acpi/os_specific/service_layers/osunixdir.c  | 2 +-
 tools/power/acpi/os_specific/service_layers/osunixmap.c  | 2 +-
 tools/power/acpi/os_specific/service_layers/osunixxf.c   | 2 +-
 tools/power/acpi/tools/acpidump/acpidump.h               | 2 +-
 tools/power/acpi/tools/acpidump/apdump.c                 | 2 +-
 tools/power/acpi/tools/acpidump/apfiles.c                | 2 +-
 tools/power/acpi/tools/acpidump/apmain.c                 | 2 +-
 174 files changed, 175 insertions(+), 175 deletions(-)

diff --git a/drivers/acpi/acpica/acapps.h b/drivers/acpi/acpica/acapps.h
index 173447d50acf..725e2f65cdca 100644
--- a/drivers/acpi/acpica/acapps.h
+++ b/drivers/acpi/acpica/acapps.h
@@ -3,7 +3,7 @@
  *
  * Module Name: acapps - common include for ACPI applications/tools
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
@@ -17,7 +17,7 @@
 /* Common info for tool signons */
 
 #define ACPICA_NAME                 "Intel ACPI Component Architecture"
-#define ACPICA_COPYRIGHT            "Copyright (c) 2000 - 2020 Intel Corporation"
+#define ACPICA_COPYRIGHT            "Copyright (c) 2000 - 2021 Intel Corporation"
 
 #if ACPI_MACHINE_WIDTH == 64
 #define ACPI_WIDTH          " (64-bit version)"
diff --git a/drivers/acpi/acpica/accommon.h b/drivers/acpi/acpica/accommon.h
index 94e18bb76556..be3826f46f88 100644
--- a/drivers/acpi/acpica/accommon.h
+++ b/drivers/acpi/acpica/accommon.h
@@ -3,7 +3,7 @@
  *
  * Name: accommon.h - Common include files for generation of ACPICA source
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acconvert.h b/drivers/acpi/acpica/acconvert.h
index cf85d66da6e7..53b41c7a6119 100644
--- a/drivers/acpi/acpica/acconvert.h
+++ b/drivers/acpi/acpica/acconvert.h
@@ -3,7 +3,7 @@
  *
  * Module Name: acapps - common include for ACPI applications/tools
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index f8a3abdfe250..3ccc7b2a76f1 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -3,7 +3,7 @@
  *
  * Name: acdebug.h - ACPI/AML debugger
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acdispat.h b/drivers/acpi/acpica/acdispat.h
index 7ba6e308f146..3170a24fe505 100644
--- a/drivers/acpi/acpica/acdispat.h
+++ b/drivers/acpi/acpica/acdispat.h
@@ -3,7 +3,7 @@
  *
  * Name: acdispat.h - dispatcher (parser to interpreter interface)
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 79f292687bd6..82a75964343b 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -3,7 +3,7 @@
  *
  * Name: acevents.h - Event subcomponent prototypes and defines
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 2fee91f57b21..d41b810e367c 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -3,7 +3,7 @@
  *
  * Name: acglobal.h - Declarations for global variables
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index 6ab92e28330d..810de0b4c125 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -3,7 +3,7 @@
  *
  * Name: achware.h -- hardware specific interfaces
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acinterp.h b/drivers/acpi/acpica/acinterp.h
index a6d896cda2a5..816a16e1fc4c 100644
--- a/drivers/acpi/acpica/acinterp.h
+++ b/drivers/acpi/acpica/acinterp.h
@@ -3,7 +3,7 @@
  *
  * Name: acinterp.h - Interpreter subcomponent prototypes and defines
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index f83b98fa13ac..be57436182a1 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -3,7 +3,7 @@
  *
  * Name: aclocal.h - Internal data types used across the ACPI subsystem
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index 168904ba3086..93bd2d19c156 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -3,7 +3,7 @@
  *
  * Name: acmacros.h - C macros for the entire subsystem.
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 40f6a3c33a15..199aabac3790 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -3,7 +3,7 @@
  *
  * Name: acnamesp.h - Namespace subcomponent prototypes and defines
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index 9f0219a8cb98..af47a3ffd2a4 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -3,7 +3,7 @@
  *
  * Name: acobject.h - Definition of union acpi_operand_object  (Internal object only)
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acopcode.h b/drivers/acpi/acpica/acopcode.h
index 8825394be9ab..c3f12ee9fc6f 100644
--- a/drivers/acpi/acpica/acopcode.h
+++ b/drivers/acpi/acpica/acopcode.h
@@ -3,7 +3,7 @@
  *
  * Name: acopcode.h - AML opcode information for the AML parser and interpreter
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acparser.h b/drivers/acpi/acpica/acparser.h
index bc00b85c0a8f..8e40e5909458 100644
--- a/drivers/acpi/acpica/acparser.h
+++ b/drivers/acpi/acpica/acparser.h
@@ -3,7 +3,7 @@
  *
  * Module Name: acparser.h - AML Parser subcomponent prototypes and defines
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index 57ea2276790f..15cf904f0751 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -3,7 +3,7 @@
  *
  * Name: acpredef - Information table for ACPI predefined methods and objects
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acresrc.h b/drivers/acpi/acpica/acresrc.h
index 6de8a1650d3d..0cb975a3e01d 100644
--- a/drivers/acpi/acpica/acresrc.h
+++ b/drivers/acpi/acpica/acresrc.h
@@ -3,7 +3,7 @@
  *
  * Name: acresrc.h - Resource Manager function prototypes
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acstruct.h b/drivers/acpi/acpica/acstruct.h
index 4c900c108f3f..e3beb096c46d 100644
--- a/drivers/acpi/acpica/acstruct.h
+++ b/drivers/acpi/acpica/acstruct.h
@@ -3,7 +3,7 @@
  *
  * Name: acstruct.h - Internal structs
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index 734624facda3..e2d0046799a2 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -3,7 +3,7 @@
  *
  * Name: actables.h - ACPI table management
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 7c89b470ec81..be6de7149e67 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -3,7 +3,7 @@
  *
  * Name: acutils.h -- prototypes for the common (subsystem-wide) procedures
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/amlcode.h b/drivers/acpi/acpica/amlcode.h
index 1d541bbac4a3..d6b088c5001f 100644
--- a/drivers/acpi/acpica/amlcode.h
+++ b/drivers/acpi/acpica/amlcode.h
@@ -5,7 +5,7 @@
  *                   Declarations and definitions contained herein are derived
  *                   directly from the ACPI specification.
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/amlresrc.h b/drivers/acpi/acpica/amlresrc.h
index e5234e001acf..a9d91a3c2994 100644
--- a/drivers/acpi/acpica/amlresrc.h
+++ b/drivers/acpi/acpica/amlresrc.h
@@ -3,7 +3,7 @@
  *
  * Module Name: amlresrc.h - AML resource descriptors
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dbhistry.c b/drivers/acpi/acpica/dbhistry.c
index f5fba14461a6..fd813c5d3952 100644
--- a/drivers/acpi/acpica/dbhistry.c
+++ b/drivers/acpi/acpica/dbhistry.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dbhistry - debugger HISTORY command
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dsargs.c b/drivers/acpi/acpica/dsargs.c
index ad17f62e51d9..6630d6536fb0 100644
--- a/drivers/acpi/acpica/dsargs.c
+++ b/drivers/acpi/acpica/dsargs.c
@@ -4,7 +4,7 @@
  * Module Name: dsargs - Support for execution of dynamic arguments for static
  *                       objects (regions, fields, buffer fields, etc.)
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dscontrol.c b/drivers/acpi/acpica/dscontrol.c
index b58ffc7acdb9..a152f03135cd 100644
--- a/drivers/acpi/acpica/dscontrol.c
+++ b/drivers/acpi/acpica/dscontrol.c
@@ -4,7 +4,7 @@
  * Module Name: dscontrol - Support for execution control opcodes -
  *                          if/else/while/return
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dsdebug.c b/drivers/acpi/acpica/dsdebug.c
index 2c22e3eff535..b9b03d629930 100644
--- a/drivers/acpi/acpica/dsdebug.c
+++ b/drivers/acpi/acpica/dsdebug.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dsdebug - Parser/Interpreter interface - debugging
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index fa768b3a989e..a16817767969 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dsfield - Dispatcher field routines
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dsinit.c b/drivers/acpi/acpica/dsinit.c
index 9be2a309424c..ba6f882e83bc 100644
--- a/drivers/acpi/acpica/dsinit.c
+++ b/drivers/acpi/acpica/dsinit.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dsinit - Object initialization namespace walk
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index cf67caff878a..8e011e59b9b4 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dsmethod - Parser/Interpreter interface - control method parsing
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dsobject.c b/drivers/acpi/acpica/dsobject.c
index c0a14a6a2c20..3c0c31157e7e 100644
--- a/drivers/acpi/acpica/dsobject.c
+++ b/drivers/acpi/acpica/dsobject.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dsobject - Dispatcher object management routines
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index d9c26e720cb7..639635291ab7 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dsopcode - Dispatcher support for regions and fields
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dspkginit.c b/drivers/acpi/acpica/dspkginit.c
index d869568d55c2..e642d65bcc66 100644
--- a/drivers/acpi/acpica/dspkginit.c
+++ b/drivers/acpi/acpica/dspkginit.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dspkginit - Completion of deferred package initialization
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
index 4a9799246fae..41ba7773fd10 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -4,7 +4,7 @@
  * Module Name: dswexec - Dispatcher method execution callbacks;
  *                        dispatch to interpreter.
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index dd97c86f8e41..a377638e44f9 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dswload - Dispatcher first pass namespace load callbacks
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
index d9a3dfca7555..3625952c3957 100644
--- a/drivers/acpi/acpica/dswload2.c
+++ b/drivers/acpi/acpica/dswload2.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dswload2 - Dispatcher second pass namespace load callbacks
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dswscope.c b/drivers/acpi/acpica/dswscope.c
index 9c397642fed7..9c123af08bc1 100644
--- a/drivers/acpi/acpica/dswscope.c
+++ b/drivers/acpi/acpica/dswscope.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dswscope - Scope stack manipulation
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dswstate.c b/drivers/acpi/acpica/dswstate.c
index 809a0c0536b5..fbe2ba05c82a 100644
--- a/drivers/acpi/acpica/dswstate.c
+++ b/drivers/acpi/acpica/dswstate.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dswstate - Dispatcher parse tree walk management routines
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evevent.c b/drivers/acpi/acpica/evevent.c
index 9efca54c51ac..35385148fedb 100644
--- a/drivers/acpi/acpica/evevent.c
+++ b/drivers/acpi/acpica/evevent.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evevent - Fixed Event handling and dispatch
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evglock.c b/drivers/acpi/acpica/evglock.c
index 0ced84ae13e4..de4eea606ccd 100644
--- a/drivers/acpi/acpica/evglock.c
+++ b/drivers/acpi/acpica/evglock.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evglock - Global Lock support
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 06b9c8dd11c9..c5a06882bdf6 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evgpe - General Purpose Event handling and dispatch
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index f5298be4273a..e5f8245c2d93 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evgpeblk - GPE block creation and initialization.
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evgpeinit.c b/drivers/acpi/acpica/evgpeinit.c
index 6d82d30d8f7b..b0724d6e6e80 100644
--- a/drivers/acpi/acpica/evgpeinit.c
+++ b/drivers/acpi/acpica/evgpeinit.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evgpeinit - System GPE initialization and update
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evgpeutil.c b/drivers/acpi/acpica/evgpeutil.c
index 738873e876ca..2e74308d7725 100644
--- a/drivers/acpi/acpica/evgpeutil.c
+++ b/drivers/acpi/acpica/evgpeutil.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evgpeutil - GPE utilities
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandler.c
index 5884eba047f7..ea9485e6a475 100644
--- a/drivers/acpi/acpica/evhandler.c
+++ b/drivers/acpi/acpica/evhandler.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evhandler - Support for Address Space handlers
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index ce1eda6beb84..f14ebcd610ab 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evmisc - Miscellaneous event manager support functions
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index a8a4c8c9b9ef..3ed7d9ae95cf 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evregion - Operation Region support
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index 89be3ccdad53..984c172453bf 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evrgnini- ACPI address_space (op_region) init
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index e4e012297eee..ff5cf5b0705a 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evxface - External interfaces for ACPI events
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index 1a15b0087379..5445a361c621 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evxfevnt - External Interfaces, ACPI event disable/enable
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index 3be60673e461..a6d53cf86450 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evxfgpe - External Interfaces for General Purpose Events (GPEs)
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index da97fd0c6b51..7672d70da850 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -4,7 +4,7 @@
  * Module Name: evxfregn - External Interfaces, ACPI Operation Regions and
  *                         Address Spaces.
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exconcat.c b/drivers/acpi/acpica/exconcat.c
index 43711412722f..2d220d470c60 100644
--- a/drivers/acpi/acpica/exconcat.c
+++ b/drivers/acpi/acpica/exconcat.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exconcat - Concatenate-type AML operators
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 68efd704e2dc..0cd9b3738e76 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exconfig - Namespace reconfiguration (Load/Unload opcodes)
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index 50c7aad2e86d..6b7498371eb0 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exconvrt - Object conversion routines
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/excreate.c
index a17482428b46..80b52ad55775 100644
--- a/drivers/acpi/acpica/excreate.c
+++ b/drivers/acpi/acpica/excreate.c
@@ -3,7 +3,7 @@
  *
  * Module Name: excreate - Named object creation
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exdebug.c b/drivers/acpi/acpica/exdebug.c
index a5223dcaee70..6a01e38b7d5a 100644
--- a/drivers/acpi/acpica/exdebug.c
+++ b/drivers/acpi/acpica/exdebug.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exdebug - Support for stores to the AML Debug Object
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index 47a4d9a40d6b..2aea44ecc37d 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exdump - Interpreter debug output routines
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index 3323a2ba6a31..32f03ee81785 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exfield - AML execution - field_unit read/write
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index cde24e0fa6a8..bdc7a30d1217 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exfldio - Aml Field I/O
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exmisc.c b/drivers/acpi/acpica/exmisc.c
index 717e3998fd77..ad19f914641b 100644
--- a/drivers/acpi/acpica/exmisc.c
+++ b/drivers/acpi/acpica/exmisc.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exmisc - ACPI AML (p-code) execution - specific opcodes
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exmutex.c b/drivers/acpi/acpica/exmutex.c
index 9ff247cba571..6237ae8284b1 100644
--- a/drivers/acpi/acpica/exmutex.c
+++ b/drivers/acpi/acpica/exmutex.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exmutex - ASL Mutex Acquire/Release functions
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exnames.c b/drivers/acpi/acpica/exnames.c
index 74f8b0d0452b..5283603d078d 100644
--- a/drivers/acpi/acpica/exnames.c
+++ b/drivers/acpi/acpica/exnames.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exnames - interpreter/scanner name load/execute
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index a46d685a3ffc..b639e930d642 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exoparg1 - AML execution - opcodes with 1 argument
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exoparg2.c b/drivers/acpi/acpica/exoparg2.c
index 03241d18ac1d..10323ab186da 100644
--- a/drivers/acpi/acpica/exoparg2.c
+++ b/drivers/acpi/acpica/exoparg2.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exoparg2 - AML execution - opcodes with 2 arguments
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exoparg3.c b/drivers/acpi/acpica/exoparg3.c
index c8d0d75fc450..140aae009690 100644
--- a/drivers/acpi/acpica/exoparg3.c
+++ b/drivers/acpi/acpica/exoparg3.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exoparg3 - AML execution - opcodes with 3 arguments
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exoparg6.c b/drivers/acpi/acpica/exoparg6.c
index 55d0fa056fe7..2cf9f37a0ba8 100644
--- a/drivers/acpi/acpica/exoparg6.c
+++ b/drivers/acpi/acpica/exoparg6.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exoparg6 - AML execution - opcodes with 6 arguments
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index 4a0f03157e08..d8c55dde191b 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exprep - ACPI AML field prep utilities
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 4914dbc44517..82b713a9a193 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exregion - ACPI default op_region (address space) handlers
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exresnte.c b/drivers/acpi/acpica/exresnte.c
index 3e4018678c09..d80b76455c50 100644
--- a/drivers/acpi/acpica/exresnte.c
+++ b/drivers/acpi/acpica/exresnte.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exresnte - AML Interpreter object resolution
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exresolv.c b/drivers/acpi/acpica/exresolv.c
index 912a078c60a4..fa6a96242835 100644
--- a/drivers/acpi/acpica/exresolv.c
+++ b/drivers/acpi/acpica/exresolv.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exresolv - AML Interpreter object resolution
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
index 4a0f8b8bfe62..cbe2c88b1dc2 100644
--- a/drivers/acpi/acpica/exresop.c
+++ b/drivers/acpi/acpica/exresop.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exresop - AML Interpreter operand/object resolution
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exserial.c b/drivers/acpi/acpica/exserial.c
index 760bc7cef55a..8e8d95f7947b 100644
--- a/drivers/acpi/acpica/exserial.c
+++ b/drivers/acpi/acpica/exserial.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exserial - field_unit support for serial address spaces
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exstore.c b/drivers/acpi/acpica/exstore.c
index 8fe33051275d..12f4210ea085 100644
--- a/drivers/acpi/acpica/exstore.c
+++ b/drivers/acpi/acpica/exstore.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exstore - AML Interpreter object store support
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exstoren.c b/drivers/acpi/acpica/exstoren.c
index 8c34f4e2ab8f..08469d37e73e 100644
--- a/drivers/acpi/acpica/exstoren.c
+++ b/drivers/acpi/acpica/exstoren.c
@@ -4,7 +4,7 @@
  * Module Name: exstoren - AML Interpreter object store support,
  *                        Store to Node (namespace object)
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exstorob.c b/drivers/acpi/acpica/exstorob.c
index dc66696080a5..a82628683329 100644
--- a/drivers/acpi/acpica/exstorob.c
+++ b/drivers/acpi/acpica/exstorob.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exstorob - AML object store support, store to object
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsystem.c
index f329b01672bb..1281c07112de 100644
--- a/drivers/acpi/acpica/exsystem.c
+++ b/drivers/acpi/acpica/exsystem.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exsystem - Interface to OS services
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/extrace.c b/drivers/acpi/acpica/extrace.c
index 832a47885b99..8846f483fb02 100644
--- a/drivers/acpi/acpica/extrace.c
+++ b/drivers/acpi/acpica/extrace.c
@@ -3,7 +3,7 @@
  *
  * Module Name: extrace - Support for interpreter execution tracing
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exutils.c b/drivers/acpi/acpica/exutils.c
index 8fefa6feac2f..4d41a866f633 100644
--- a/drivers/acpi/acpica/exutils.c
+++ b/drivers/acpi/acpica/exutils.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exutils - interpreter/scanner utilities
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwacpi.c b/drivers/acpi/acpica/hwacpi.c
index 9b9aac27ff7e..96f55f079988 100644
--- a/drivers/acpi/acpica/hwacpi.c
+++ b/drivers/acpi/acpica/hwacpi.c
@@ -3,7 +3,7 @@
  *
  * Module Name: hwacpi - ACPI Hardware Initialization/Mode Interface
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwesleep.c b/drivers/acpi/acpica/hwesleep.c
index d9be5d0545d4..803402aefaeb 100644
--- a/drivers/acpi/acpica/hwesleep.c
+++ b/drivers/acpi/acpica/hwesleep.c
@@ -4,7 +4,7 @@
  * Name: hwesleep.c - ACPI Hardware Sleep/Wake Support functions for the
  *                    extended FADT-V5 sleep registers.
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index 0c84300e915c..0770aa176cd5 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -3,7 +3,7 @@
  *
  * Module Name: hwgpe - Low level GPE enable/disable/clear functions
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index 317ae870336b..14baa13bf848 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -4,7 +4,7 @@
  * Name: hwsleep.c - ACPI Hardware Sleep/Wake Support functions for the
  *                   original/legacy sleep/PM registers.
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwtimer.c b/drivers/acpi/acpica/hwtimer.c
index 07473ddfa9a9..63deadde9f48 100644
--- a/drivers/acpi/acpica/hwtimer.c
+++ b/drivers/acpi/acpica/hwtimer.c
@@ -3,7 +3,7 @@
  *
  * Name: hwtimer.c - ACPI Power Management Timer Interface
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
index b2ca7dfd3fc9..e15badf4077a 100644
--- a/drivers/acpi/acpica/hwvalid.c
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -3,7 +3,7 @@
  *
  * Module Name: hwvalid - I/O request validation
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index 134dbfadcd15..fb27aaad0dee 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -3,7 +3,7 @@
  *
  * Module Name: hwxface - Public ACPICA hardware interfaces
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index a4b66f4b2714..89b12afed564 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -3,7 +3,7 @@
  *
  * Name: hwxfsleep.c - ACPI Hardware Sleep/Wake External Interfaces
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsarguments.c b/drivers/acpi/acpica/nsarguments.c
index 6bbc7d350a16..c8a2747005c5 100644
--- a/drivers/acpi/acpica/nsarguments.c
+++ b/drivers/acpi/acpica/nsarguments.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsarguments - Validation of args for ACPI predefined methods
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsconvert.c b/drivers/acpi/acpica/nsconvert.c
index c86c82939ebb..597d0eed23c1 100644
--- a/drivers/acpi/acpica/nsconvert.c
+++ b/drivers/acpi/acpica/nsconvert.c
@@ -4,7 +4,7 @@
  * Module Name: nsconvert - Object conversions for objects returned by
  *                          predefined methods
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 994f0b556c60..2f66f3ed1810 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsdump - table dumping routines for debug
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsdumpdv.c b/drivers/acpi/acpica/nsdumpdv.c
index b691fe20e384..d3dc6761bcdd 100644
--- a/drivers/acpi/acpica/nsdumpdv.c
+++ b/drivers/acpi/acpica/nsdumpdv.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsdump - table dumping routines for debug
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index e16f6a0c2c3f..4db81f8ba29b 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsinit - namespace initialization
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsload.c b/drivers/acpi/acpica/nsload.c
index 9ba17891edb6..7d77956ed790 100644
--- a/drivers/acpi/acpica/nsload.c
+++ b/drivers/acpi/acpica/nsload.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsload - namespace loading/expanding/contracting procedures
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
index 7e74a765e785..778f80e624be 100644
--- a/drivers/acpi/acpica/nsparse.c
+++ b/drivers/acpi/acpica/nsparse.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsparse - namespace interface to AML parser
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 167a1c2495ab..e4e5f32da7dc 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nspredef - Validation of ACPI predefined methods and objects
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsprepkg.c b/drivers/acpi/acpica/nsprepkg.c
index 1875b1cba202..6742b50836f7 100644
--- a/drivers/acpi/acpica/nsprepkg.c
+++ b/drivers/acpi/acpica/nsprepkg.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsprepkg - Validation of package objects for predefined names
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index 90db2d85e7f5..499067daa22c 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsrepair - Repair for objects returned by predefined methods
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index d2c8d8279e7a..918513da1b26 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -4,7 +4,7 @@
  * Module Name: nsrepair2 - Repair for objects returned by specific
  *                          predefined methods
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index e66abdab8f31..83d0f276da4d 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -4,7 +4,7 @@
  * Module Name: nsutils - Utilities for accessing ACPI namespace, accessing
  *                        parents and siblings and Scope manipulation
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
index b7f3e8603ad8..915c2433463d 100644
--- a/drivers/acpi/acpica/nswalk.c
+++ b/drivers/acpi/acpica/nswalk.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nswalk - Functions for walking the ACPI namespace
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index 0e6aba81605b..03487546da5a 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -4,7 +4,7 @@
  * Module Name: nsxfname - Public interfaces to the ACPI subsystem
  *                         ACPI Namespace oriented interfaces
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 3b40db4ad9f3..b9ff535aa02e 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psargs - Parse AML opcode arguments
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index 1ba17cf16c41..4b51dd939f29 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psloop - Main AML parse loop
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psobject.c b/drivers/acpi/acpica/psobject.c
index 2480c26c5171..e4420cd6d281 100644
--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psobject - Support for parse objects
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psopcode.c b/drivers/acpi/acpica/psopcode.c
index 28af49263ebf..3e80eb1a5f35 100644
--- a/drivers/acpi/acpica/psopcode.c
+++ b/drivers/acpi/acpica/psopcode.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psopcode - Parser/Interpreter opcode information table
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psopinfo.c b/drivers/acpi/acpica/psopinfo.c
index ab9327f6a63c..476b00a121f3 100644
--- a/drivers/acpi/acpica/psopinfo.c
+++ b/drivers/acpi/acpica/psopinfo.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psopinfo - AML opcode information functions and dispatch tables
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index 06490a137982..7eb7a81619a3 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psparse - Parser top level AML parse routines
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psscope.c b/drivers/acpi/acpica/psscope.c
index fceb311995e9..3f2eada44942 100644
--- a/drivers/acpi/acpica/psscope.c
+++ b/drivers/acpi/acpica/psscope.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psscope - Parser scope stack management routines
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/pstree.c b/drivers/acpi/acpica/pstree.c
index c8aef0694864..ffb2a7bfc6d7 100644
--- a/drivers/acpi/acpica/pstree.c
+++ b/drivers/acpi/acpica/pstree.c
@@ -3,7 +3,7 @@
  *
  * Module Name: pstree - Parser op tree manipulation/traversal/search
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psutils.c b/drivers/acpi/acpica/psutils.c
index 00efae2f95ba..e6596051d548 100644
--- a/drivers/acpi/acpica/psutils.c
+++ b/drivers/acpi/acpica/psutils.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psutils - Parser miscellaneous utilities (Parser only)
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/pswalk.c b/drivers/acpi/acpica/pswalk.c
index 0fe3adf6b0e5..7018a789debc 100644
--- a/drivers/acpi/acpica/pswalk.c
+++ b/drivers/acpi/acpica/pswalk.c
@@ -3,7 +3,7 @@
  *
  * Module Name: pswalk - Parser routines to walk parsed op tree(s)
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psxface.c b/drivers/acpi/acpica/psxface.c
index 1bbfc8def388..fd0f28c7af1e 100644
--- a/drivers/acpi/acpica/psxface.c
+++ b/drivers/acpi/acpica/psxface.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psxface - Parser external interfaces
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 523b1e9b98d4..ebbca109edcb 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbdata - Table manager data structure functions
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 907edc5edba7..5174abfa8af9 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbfadt   - FADT table utilities
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
index 56d81e490a5c..2c2c2b1f5a28 100644
--- a/drivers/acpi/acpica/tbfind.c
+++ b/drivers/acpi/acpica/tbfind.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbfind   - find table
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 0bb15add2245..8d1e5b572493 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbinstal - ACPI table installation and removal
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbprint.c b/drivers/acpi/acpica/tbprint.c
index 0b3494ad9a70..254823d494a2 100644
--- a/drivers/acpi/acpica/tbprint.c
+++ b/drivers/acpi/acpica/tbprint.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbprint - Table output utilities
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index dfe1ac3ae34a..4b9b329a5a92 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbutils - ACPI Table utilities
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 7490429ddbf6..e6f51fedaf1a 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbxface - ACPI table-oriented external interfaces
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index bcba993d4dac..38623049b962 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbxfload - Table load/unload external interfaces
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
index 0edc6ef5d46d..9fec3df6c3ba 100644
--- a/drivers/acpi/acpica/tbxfroot.c
+++ b/drivers/acpi/acpica/tbxfroot.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbxfroot - Find the root ACPI table (RSDT)
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utaddress.c b/drivers/acpi/acpica/utaddress.c
index 99fa48722cf6..7001f4b113f1 100644
--- a/drivers/acpi/acpica/utaddress.c
+++ b/drivers/acpi/acpica/utaddress.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utaddress - op_region address range check
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utalloc.c b/drivers/acpi/acpica/utalloc.c
index 303ab51b4fcf..796fd9b33a7d 100644
--- a/drivers/acpi/acpica/utalloc.c
+++ b/drivers/acpi/acpica/utalloc.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utalloc - local memory allocation routines
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utascii.c b/drivers/acpi/acpica/utascii.c
index d78656d960e8..e1b55575d5fb 100644
--- a/drivers/acpi/acpica/utascii.c
+++ b/drivers/acpi/acpica/utascii.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utascii - Utility ascii functions
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utbuffer.c b/drivers/acpi/acpica/utbuffer.c
index f2ec427f4e29..8ab90f78825b 100644
--- a/drivers/acpi/acpica/utbuffer.c
+++ b/drivers/acpi/acpica/utbuffer.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utbuffer - Buffer dump routines
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utcache.c b/drivers/acpi/acpica/utcache.c
index 1b03a2747401..814145019f95 100644
--- a/drivers/acpi/acpica/utcache.c
+++ b/drivers/acpi/acpica/utcache.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utcache - local cache allocation routines
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
index 41bdd0278dd8..d9877153f400 100644
--- a/drivers/acpi/acpica/utcopy.c
+++ b/drivers/acpi/acpica/utcopy.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utcopy - Internal to external object translation utilities
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index 0c8cb0612414..09245945f319 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utdebug - Debug print/trace routines
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index ed9aedf604a1..bcd3871079d7 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utdecode - Utility decoding routines (value-to-string)
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/uteval.c b/drivers/acpi/acpica/uteval.c
index 8180d1a458f5..d2503920c620 100644
--- a/drivers/acpi/acpica/uteval.c
+++ b/drivers/acpi/acpica/uteval.c
@@ -3,7 +3,7 @@
  *
  * Module Name: uteval - Object evaluation
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index e6dcbdc3fc6e..59a48371a7bc 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utglobal - Global variables for the ACPI subsystem
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/uthex.c b/drivers/acpi/acpica/uthex.c
index 0e02f12513dc..b1e94c094f9a 100644
--- a/drivers/acpi/acpica/uthex.c
+++ b/drivers/acpi/acpica/uthex.c
@@ -3,7 +3,7 @@
  *
  * Module Name: uthex -- Hex/ASCII support functions
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utids.c b/drivers/acpi/acpica/utids.c
index 3e68864ef242..08e9f316cbde 100644
--- a/drivers/acpi/acpica/utids.c
+++ b/drivers/acpi/acpica/utids.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utids - support for device Ids - HID, UID, CID, SUB, CLS
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utinit.c b/drivers/acpi/acpica/utinit.c
index fdbc397c038d..7b606a1e6986 100644
--- a/drivers/acpi/acpica/utinit.c
+++ b/drivers/acpi/acpica/utinit.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utinit - Common ACPI subsystem initialization
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utlock.c b/drivers/acpi/acpica/utlock.c
index 46be549539e7..923dd15e7a16 100644
--- a/drivers/acpi/acpica/utlock.c
+++ b/drivers/acpi/acpica/utlock.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utlock - Reader/Writer lock interfaces
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobject.c
index bbec04c291d2..84a210b49e3a 100644
--- a/drivers/acpi/acpica/utobject.c
+++ b/drivers/acpi/acpica/utobject.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utobject - ACPI object create/delete/size/cache routines
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
index 0a01c08dad8a..7b8e8bf1e824 100644
--- a/drivers/acpi/acpica/utosi.c
+++ b/drivers/acpi/acpica/utosi.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utosi - Support for the _OSI predefined control method
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utpredef.c b/drivers/acpi/acpica/utpredef.c
index dd277f7e9f10..a6f87a88c30e 100644
--- a/drivers/acpi/acpica/utpredef.c
+++ b/drivers/acpi/acpica/utpredef.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utpredef - support functions for predefined names
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
index 681c11f4af4e..e37d612e8db5 100644
--- a/drivers/acpi/acpica/utprint.c
+++ b/drivers/acpi/acpica/utprint.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utprint - Formatted printing routines
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/uttrack.c b/drivers/acpi/acpica/uttrack.c
index d366be431a84..2ce85fcfeb5b 100644
--- a/drivers/acpi/acpica/uttrack.c
+++ b/drivers/acpi/acpica/uttrack.c
@@ -3,7 +3,7 @@
  *
  * Module Name: uttrack - Memory allocation tracking routines (debug only)
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utuuid.c b/drivers/acpi/acpica/utuuid.c
index b8039954b0d1..090e44b6b6c7 100644
--- a/drivers/acpi/acpica/utuuid.c
+++ b/drivers/acpi/acpica/utuuid.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utuuid -- UUID support functions
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index ca7c9f0144ef..3285c1a92e40 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utxface - External interfaces, miscellaneous utility functions
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index 653e3bb20036..91016366de1d 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utxfinit - External interfaces for ACPICA initialization
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acbuffer.h b/include/acpi/acbuffer.h
index 531c1e9a7d10..18197c16149f 100644
--- a/include/acpi/acbuffer.h
+++ b/include/acpi/acbuffer.h
@@ -3,7 +3,7 @@
  *
  * Name: acbuffer.h - Support for buffers returned by ACPI predefined names
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index a225eff499c8..e92f84fa8c68 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -3,7 +3,7 @@
  *
  * Name: acconfig.h - Global configuration constants
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index f8a4afb0279a..ea3b1c41bc79 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -3,7 +3,7 @@
  *
  * Name: acexcep.h - Exception codes returned by the ACPI subsystem
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
index 8922edb32730..a2bc381c7ce7 100644
--- a/include/acpi/acnames.h
+++ b/include/acpi/acnames.h
@@ -3,7 +3,7 @@
  *
  * Name: acnames.h - Global names and strings
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index c5d900c0ecda..1538a6853822 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -3,7 +3,7 @@
  *
  * Name: acoutput.h -- debug output
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acpi.h b/include/acpi/acpi.h
index e3e8051d4812..6f6282a862bc 100644
--- a/include/acpi/acpi.h
+++ b/include/acpi/acpi.h
@@ -3,7 +3,7 @@
  *
  * Name: acpi.h - Master public include file used to interface to ACPICA
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 33bb8c9a089d..690c369b717a 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -5,7 +5,7 @@
  *                    interfaces must be implemented by OSL to interface the
  *                    ACPI components to the host operating system.
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index be76e40769cb..be76ba3166cf 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -3,7 +3,7 @@
  *
  * Name: acpixf.h - External interfaces to the ACPI subsystem
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
index d3521894ce6a..9bccac9becd7 100644
--- a/include/acpi/acrestyp.h
+++ b/include/acpi/acrestyp.h
@@ -3,7 +3,7 @@
  *
  * Name: acrestyp.h - Defines, types, and structures for resource descriptors
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index 5007c41f4d54..f9cda909f92c 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -3,7 +3,7 @@
  *
  * Name: actbl.h - Basic ACPI Table Definitions
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 43549547ed3e..ea1c2998d54e 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -3,7 +3,7 @@
  *
  * Name: actbl1.h - Additional ACPI table definitions
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 94bfc0c2a893..d6478c430c99 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -3,7 +3,7 @@
  *
  * Name: actbl2.h - ACPI Table Definitions (tables not in ACPI spec)
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index d90c3e1978e6..df5f4b27f3aa 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -3,7 +3,7 @@
  *
  * Name: actbl3.h - ACPI Table Definitions
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 2a32593691bc..92c71dfce0d5 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -3,7 +3,7 @@
  *
  * Name: actypes.h - Common data types for the entire ACPI subsystem
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acuuid.h b/include/acpi/acuuid.h
index fb7d8d1fd93c..a5c2ca019a12 100644
--- a/include/acpi/acuuid.h
+++ b/include/acpi/acuuid.h
@@ -3,7 +3,7 @@
  *
  * Name: acuuid.h - ACPI-related UUID/GUID definitions
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 8f6b2654c0b3..e8958e0d1646 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -3,7 +3,7 @@
  *
  * Name: acenv.h - Host and compiler configuration
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/platform/acenvex.h b/include/acpi/platform/acenvex.h
index c3facf5f8495..277fe2fa4d9b 100644
--- a/include/acpi/platform/acenvex.h
+++ b/include/acpi/platform/acenvex.h
@@ -3,7 +3,7 @@
  *
  * Name: acenvex.h - Extra host and compiler configuration
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
index 91f7a02c798a..0cd4f61d4248 100644
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -3,7 +3,7 @@
  *
  * Name: acgcc.h - GCC specific defines, etc.
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/platform/acgccex.h b/include/acpi/platform/acgccex.h
index 7c88fd1de955..738d52865e0a 100644
--- a/include/acpi/platform/acgccex.h
+++ b/include/acpi/platform/acgccex.h
@@ -3,7 +3,7 @@
  *
  * Name: acgccex.h - Extra GCC specific defines, etc.
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/platform/acintel.h b/include/acpi/platform/acintel.h
index e7fd5e71be62..550fe9a8cd6c 100644
--- a/include/acpi/platform/acintel.h
+++ b/include/acpi/platform/acintel.h
@@ -3,7 +3,7 @@
  *
  * Name: acintel.h - VC specific defines, etc.
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 72f52a1342a0..b3ffb9bbf664 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -3,7 +3,7 @@
  *
  * Name: aclinux.h - OS specific defines, etc. for Linux
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/platform/aclinuxex.h b/include/acpi/platform/aclinuxex.h
index 04f88f2de781..5f642b07ad64 100644
--- a/include/acpi/platform/aclinuxex.h
+++ b/include/acpi/platform/aclinuxex.h
@@ -3,7 +3,7 @@
  *
  * Name: aclinuxex.h - Extra OS specific defines, etc. for Linux
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/common/cmfsize.c b/tools/power/acpi/common/cmfsize.c
index d1d18ff5c911..9ea2c0aeb86c 100644
--- a/tools/power/acpi/common/cmfsize.c
+++ b/tools/power/acpi/common/cmfsize.c
@@ -3,7 +3,7 @@
  *
  * Module Name: cfsize - Common get file size function
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/common/getopt.c b/tools/power/acpi/common/getopt.c
index c3708f30ab3a..3c265bc917a1 100644
--- a/tools/power/acpi/common/getopt.c
+++ b/tools/power/acpi/common/getopt.c
@@ -3,7 +3,7 @@
  *
  * Module Name: getopt
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
index 11c5046dce16..ccabdbaae6a4 100644
--- a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
+++ b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
@@ -3,7 +3,7 @@
  *
  * Module Name: oslinuxtbl - Linux OSL for obtaining ACPI tables
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/os_specific/service_layers/osunixdir.c b/tools/power/acpi/os_specific/service_layers/osunixdir.c
index fd05ddee240f..edd99274cd12 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixdir.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixdir.c
@@ -3,7 +3,7 @@
  *
  * Module Name: osunixdir - Unix directory access interfaces
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/os_specific/service_layers/osunixmap.c b/tools/power/acpi/os_specific/service_layers/osunixmap.c
index c565546e85bc..fee0022560d5 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixmap.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixmap.c
@@ -3,7 +3,7 @@
  *
  * Module Name: osunixmap - Unix OSL for file mappings
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/os_specific/service_layers/osunixxf.c b/tools/power/acpi/os_specific/service_layers/osunixxf.c
index 5b2fd968535f..0861728da562 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixxf.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixxf.c
@@ -3,7 +3,7 @@
  *
  * Module Name: osunixxf - UNIX OSL interfaces
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/tools/acpidump/acpidump.h b/tools/power/acpi/tools/acpidump/acpidump.h
index 26a5eae9f87f..e0ebc1dab1cc 100644
--- a/tools/power/acpi/tools/acpidump/acpidump.h
+++ b/tools/power/acpi/tools/acpidump/acpidump.h
@@ -3,7 +3,7 @@
  *
  * Module Name: acpidump.h - Include file for acpi_dump utility
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/tools/acpidump/apdump.c b/tools/power/acpi/tools/acpidump/apdump.c
index 76433296055d..444e3d78bd89 100644
--- a/tools/power/acpi/tools/acpidump/apdump.c
+++ b/tools/power/acpi/tools/acpidump/apdump.c
@@ -3,7 +3,7 @@
  *
  * Module Name: apdump - Dump routines for ACPI tables (acpidump)
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/tools/acpidump/apfiles.c b/tools/power/acpi/tools/acpidump/apfiles.c
index a682bae4e6f6..da0c6e13042b 100644
--- a/tools/power/acpi/tools/acpidump/apfiles.c
+++ b/tools/power/acpi/tools/acpidump/apfiles.c
@@ -3,7 +3,7 @@
  *
  * Module Name: apfiles - File-related functions for acpidump utility
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/tools/acpidump/apmain.c b/tools/power/acpi/tools/acpidump/apmain.c
index 046e6b8d6baa..a4cf6042fcfd 100644
--- a/tools/power/acpi/tools/acpidump/apmain.c
+++ b/tools/power/acpi/tools/acpidump/apmain.c
@@ -3,7 +3,7 @@
  *
  * Module Name: apmain - Main module for the acpidump utility
  *
- * Copyright (C) 2000 - 2020, Intel Corp.
+ * Copyright (C) 2000 - 2021, Intel Corp.
  *
  *****************************************************************************/
 
-- 
2.29.2

