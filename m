Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94EB4137788
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2020 20:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgAJTw0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Jan 2020 14:52:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:12666 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbgAJTwZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 10 Jan 2020 14:52:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 11:52:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; 
   d="scan'208";a="218165258"
Received: from sibelius.jf.intel.com ([10.54.75.38])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jan 2020 11:52:24 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 1/2] ACPICA: All acpica: Update copyrights to 2020 Including tool signons.
Date:   Fri, 10 Jan 2020 11:31:49 -0800
Message-Id: <20200110193150.4196-2-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200110193150.4196-1-erik.kaneda@intel.com>
References: <20200110193150.4196-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 8b9c69d0984067051ffbe8526f871448ead6a26b

Link: https://github.com/acpica/acpica/commit/8b9c69d0
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
index 863ade9add6d..173447d50acf 100644
--- a/drivers/acpi/acpica/acapps.h
+++ b/drivers/acpi/acpica/acapps.h
@@ -3,7 +3,7 @@
  *
  * Module Name: acapps - common include for ACPI applications/tools
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
@@ -17,7 +17,7 @@
 /* Common info for tool signons */
 
 #define ACPICA_NAME                 "Intel ACPI Component Architecture"
-#define ACPICA_COPYRIGHT            "Copyright (c) 2000 - 2019 Intel Corporation"
+#define ACPICA_COPYRIGHT            "Copyright (c) 2000 - 2020 Intel Corporation"
 
 #if ACPI_MACHINE_WIDTH == 64
 #define ACPI_WIDTH          " (64-bit version)"
diff --git a/drivers/acpi/acpica/accommon.h b/drivers/acpi/acpica/accommon.h
index 54f81eac7ec9..89101e53324b 100644
--- a/drivers/acpi/acpica/accommon.h
+++ b/drivers/acpi/acpica/accommon.h
@@ -3,7 +3,7 @@
  *
  * Name: accommon.h - Common include files for generation of ACPICA source
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acconvert.h b/drivers/acpi/acpica/acconvert.h
index d5478cd4a857..ede4b9cc9e85 100644
--- a/drivers/acpi/acpica/acconvert.h
+++ b/drivers/acpi/acpica/acconvert.h
@@ -3,7 +3,7 @@
  *
  * Module Name: acapps - common include for ACPI applications/tools
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index 694cf206fa9a..a676daaa2da5 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -3,7 +3,7 @@
  *
  * Name: acdebug.h - ACPI/AML debugger
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acdispat.h b/drivers/acpi/acpica/acdispat.h
index 82f81501566b..7ba6e308f146 100644
--- a/drivers/acpi/acpica/acdispat.h
+++ b/drivers/acpi/acpica/acdispat.h
@@ -3,7 +3,7 @@
  *
  * Name: acdispat.h - dispatcher (parser to interpreter interface)
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index c8652f91054e..79f292687bd6 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -3,7 +3,7 @@
  *
  * Name: acevents.h - Event subcomponent prototypes and defines
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index fd3beea93421..38ffa2c0a496 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -3,7 +3,7 @@
  *
  * Name: acglobal.h - Declarations for global variables
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index bcf8f7501db7..67f282e9e0af 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -3,7 +3,7 @@
  *
  * Name: achware.h -- hardware specific interfaces
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acinterp.h b/drivers/acpi/acpica/acinterp.h
index 20706adbc148..a6d896cda2a5 100644
--- a/drivers/acpi/acpica/acinterp.h
+++ b/drivers/acpi/acpica/acinterp.h
@@ -3,7 +3,7 @@
  *
  * Name: acinterp.h - Interpreter subcomponent prototypes and defines
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 1ea52576f0a2..af58cd2dc9d3 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -3,7 +3,7 @@
  *
  * Name: aclocal.h - Internal data types used across the ACPI subsystem
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index 283614e82a20..2269e10bc21b 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -3,7 +3,7 @@
  *
  * Name: acmacros.h - C macros for the entire subsystem.
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 7da1864798a0..e618ddfab2fd 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -3,7 +3,7 @@
  *
  * Name: acnamesp.h - Namespace subcomponent prototypes and defines
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index 10154a8157ec..9f0219a8cb98 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -3,7 +3,7 @@
  *
  * Name: acobject.h - Definition of union acpi_operand_object  (Internal object only)
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acopcode.h b/drivers/acpi/acpica/acopcode.h
index 9d78134428e3..8825394be9ab 100644
--- a/drivers/acpi/acpica/acopcode.h
+++ b/drivers/acpi/acpica/acopcode.h
@@ -3,7 +3,7 @@
  *
  * Name: acopcode.h - AML opcode information for the AML parser and interpreter
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acparser.h b/drivers/acpi/acpica/acparser.h
index 6e32c97cba6c..bc00b85c0a8f 100644
--- a/drivers/acpi/acpica/acparser.h
+++ b/drivers/acpi/acpica/acparser.h
@@ -3,7 +3,7 @@
  *
  * Module Name: acparser.h - AML Parser subcomponent prototypes and defines
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index 387163b962a7..cd0f5df0ea23 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -3,7 +3,7 @@
  *
  * Name: acpredef - Information table for ACPI predefined methods and objects
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acresrc.h b/drivers/acpi/acpica/acresrc.h
index 422cd8f2b92e..6de8a1650d3d 100644
--- a/drivers/acpi/acpica/acresrc.h
+++ b/drivers/acpi/acpica/acresrc.h
@@ -3,7 +3,7 @@
  *
  * Name: acresrc.h - Resource Manager function prototypes
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acstruct.h b/drivers/acpi/acpica/acstruct.h
index 2043dff370b1..4c900c108f3f 100644
--- a/drivers/acpi/acpica/acstruct.h
+++ b/drivers/acpi/acpica/acstruct.h
@@ -3,7 +3,7 @@
  *
  * Name: acstruct.h - Internal structs
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index dfbf1dbd4033..734624facda3 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -3,7 +3,7 @@
  *
  * Name: actables.h - ACPI table management
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 5fb50634e08e..7c89b470ec81 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -3,7 +3,7 @@
  *
  * Name: acutils.h -- prototypes for the common (subsystem-wide) procedures
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/amlcode.h b/drivers/acpi/acpica/amlcode.h
index 49e412edd7c6..1d541bbac4a3 100644
--- a/drivers/acpi/acpica/amlcode.h
+++ b/drivers/acpi/acpica/amlcode.h
@@ -5,7 +5,7 @@
  *                   Declarations and definitions contained herein are derived
  *                   directly from the ACPI specification.
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/amlresrc.h b/drivers/acpi/acpica/amlresrc.h
index 7c3bd4ab60fc..e5234e001acf 100644
--- a/drivers/acpi/acpica/amlresrc.h
+++ b/drivers/acpi/acpica/amlresrc.h
@@ -3,7 +3,7 @@
  *
  * Module Name: amlresrc.h - AML resource descriptors
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dbhistry.c b/drivers/acpi/acpica/dbhistry.c
index 47d2e5059849..bb9600b867ee 100644
--- a/drivers/acpi/acpica/dbhistry.c
+++ b/drivers/acpi/acpica/dbhistry.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dbhistry - debugger HISTORY command
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dsargs.c b/drivers/acpi/acpica/dsargs.c
index 85b34d02233e..ad17f62e51d9 100644
--- a/drivers/acpi/acpica/dsargs.c
+++ b/drivers/acpi/acpica/dsargs.c
@@ -4,7 +4,7 @@
  * Module Name: dsargs - Support for execution of dynamic arguments for static
  *                       objects (regions, fields, buffer fields, etc.)
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dscontrol.c b/drivers/acpi/acpica/dscontrol.c
index 5034fab9cf69..4b5b6e859f62 100644
--- a/drivers/acpi/acpica/dscontrol.c
+++ b/drivers/acpi/acpica/dscontrol.c
@@ -4,7 +4,7 @@
  * Module Name: dscontrol - Support for execution control opcodes -
  *                          if/else/while/return
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dsdebug.c b/drivers/acpi/acpica/dsdebug.c
index 0d3e1ced1f57..63bc5f19fb82 100644
--- a/drivers/acpi/acpica/dsdebug.c
+++ b/drivers/acpi/acpica/dsdebug.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dsdebug - Parser/Interpreter interface - debugging
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index ae713d746c8b..c901f5aec739 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dsfield - Dispatcher field routines
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dsinit.c b/drivers/acpi/acpica/dsinit.c
index a1ffed29903b..9be2a309424c 100644
--- a/drivers/acpi/acpica/dsinit.c
+++ b/drivers/acpi/acpica/dsinit.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dsinit - Object initialization namespace walk
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index f59b4d944f7f..cf67caff878a 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dsmethod - Parser/Interpreter interface - control method parsing
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dsobject.c b/drivers/acpi/acpica/dsobject.c
index 179129a2deb1..c0a14a6a2c20 100644
--- a/drivers/acpi/acpica/dsobject.c
+++ b/drivers/acpi/acpica/dsobject.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dsobject - Dispatcher object management routines
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index 2488218f8562..d9c26e720cb7 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dsopcode - Dispatcher support for regions and fields
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dspkginit.c b/drivers/acpi/acpica/dspkginit.c
index 997faa10f615..d869568d55c2 100644
--- a/drivers/acpi/acpica/dspkginit.c
+++ b/drivers/acpi/acpica/dspkginit.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dspkginit - Completion of deferred package initialization
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
index d75aae304595..5e81a1ae44cf 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -4,7 +4,7 @@
  * Module Name: dswexec - Dispatcher method execution callbacks;
  *                        dispatch to interpreter.
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index 4bcf15bf03de..697974e37edf 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dswload - Dispatcher first pass namespace load callbacks
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
index 935a8e2623e4..b31457ca926c 100644
--- a/drivers/acpi/acpica/dswload2.c
+++ b/drivers/acpi/acpica/dswload2.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dswload2 - Dispatcher second pass namespace load callbacks
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dswscope.c b/drivers/acpi/acpica/dswscope.c
index 39acf7b286da..9c397642fed7 100644
--- a/drivers/acpi/acpica/dswscope.c
+++ b/drivers/acpi/acpica/dswscope.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dswscope - Scope stack manipulation
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/dswstate.c b/drivers/acpi/acpica/dswstate.c
index de79f835a373..809a0c0536b5 100644
--- a/drivers/acpi/acpica/dswstate.c
+++ b/drivers/acpi/acpica/dswstate.c
@@ -3,7 +3,7 @@
  *
  * Module Name: dswstate - Dispatcher parse tree walk management routines
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evevent.c b/drivers/acpi/acpica/evevent.c
index 9e2f5a05c066..8c83d8c620dc 100644
--- a/drivers/acpi/acpica/evevent.c
+++ b/drivers/acpi/acpica/evevent.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evevent - Fixed Event handling and dispatch
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evglock.c b/drivers/acpi/acpica/evglock.c
index 5c77bee5d31f..0ced84ae13e4 100644
--- a/drivers/acpi/acpica/evglock.c
+++ b/drivers/acpi/acpica/evglock.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evglock - Global Lock support
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 344feba29063..3e39907fedd9 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evgpe - General Purpose Event handling and dispatch
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index 9c7adaa7b582..132adff1e131 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evgpeblk - GPE block creation and initialization.
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evgpeinit.c b/drivers/acpi/acpica/evgpeinit.c
index 70d21d5ec5f3..6effd8076dcc 100644
--- a/drivers/acpi/acpica/evgpeinit.c
+++ b/drivers/acpi/acpica/evgpeinit.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evgpeinit - System GPE initialization and update
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evgpeutil.c b/drivers/acpi/acpica/evgpeutil.c
index 917892227e09..738873e876ca 100644
--- a/drivers/acpi/acpica/evgpeutil.c
+++ b/drivers/acpi/acpica/evgpeutil.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evgpeutil - GPE utilities
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandler.c
index 3ef4e27995f0..5884eba047f7 100644
--- a/drivers/acpi/acpica/evhandler.c
+++ b/drivers/acpi/acpica/evhandler.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evhandler - Support for Address Space handlers
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index aa98fe07cd1b..ce1eda6beb84 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evmisc - Miscellaneous event manager support functions
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 1ff126460007..738d4b231f34 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evregion - Operation Region support
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index aee09640d710..aefc0145e583 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evrgnini- ACPI address_space (op_region) init
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index 279ef0557aa3..e4e012297eee 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evxface - External interfaces for ACPI events
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index e528fe56b755..1a15b0087379 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evxfevnt - External Interfaces, ACPI event disable/enable
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index 04a40d563dd6..2c39ff2a7406 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -3,7 +3,7 @@
  *
  * Module Name: evxfgpe - External Interfaces for General Purpose Events (GPEs)
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index 47265b073e6f..da97fd0c6b51 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -4,7 +4,7 @@
  * Module Name: evxfregn - External Interfaces, ACPI Operation Regions and
  *                         Address Spaces.
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exconcat.c b/drivers/acpi/acpica/exconcat.c
index c7af07566b7b..43711412722f 100644
--- a/drivers/acpi/acpica/exconcat.c
+++ b/drivers/acpi/acpica/exconcat.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exconcat - Concatenate-type AML operators
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 46a8baf28bd0..68efd704e2dc 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exconfig - Namespace reconfiguration (Load/Unload opcodes)
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index ca2966bacb50..50c7aad2e86d 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exconvrt - Object conversion routines
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/excreate.c
index f376fc00064e..a17482428b46 100644
--- a/drivers/acpi/acpica/excreate.c
+++ b/drivers/acpi/acpica/excreate.c
@@ -3,7 +3,7 @@
  *
  * Module Name: excreate - Named object creation
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exdebug.c b/drivers/acpi/acpica/exdebug.c
index b1aeec8cac55..a5223dcaee70 100644
--- a/drivers/acpi/acpica/exdebug.c
+++ b/drivers/acpi/acpica/exdebug.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exdebug - Support for stores to the AML Debug Object
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index a9bc938a3b55..47a4d9a40d6b 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exdump - Interpreter debug output routines
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index 633417650f3d..e85eb31e5075 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exfield - AML execution - field_unit read/write
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index 95a0dcb4f7b9..ade35ff1c7ba 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exfldio - Aml Field I/O
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exmisc.c b/drivers/acpi/acpica/exmisc.c
index 60e854965af9..717e3998fd77 100644
--- a/drivers/acpi/acpica/exmisc.c
+++ b/drivers/acpi/acpica/exmisc.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exmisc - ACPI AML (p-code) execution - specific opcodes
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exmutex.c b/drivers/acpi/acpica/exmutex.c
index 775cd62af5b3..9ff247cba571 100644
--- a/drivers/acpi/acpica/exmutex.c
+++ b/drivers/acpi/acpica/exmutex.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exmutex - ASL Mutex Acquire/Release functions
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exnames.c b/drivers/acpi/acpica/exnames.c
index 6b76be5212a4..74f8b0d0452b 100644
--- a/drivers/acpi/acpica/exnames.c
+++ b/drivers/acpi/acpica/exnames.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exnames - interpreter/scanner name load/execute
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index 06e35ea09823..a46d685a3ffc 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exoparg1 - AML execution - opcodes with 1 argument
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exoparg2.c b/drivers/acpi/acpica/exoparg2.c
index 5e4a31a11df4..03241d18ac1d 100644
--- a/drivers/acpi/acpica/exoparg2.c
+++ b/drivers/acpi/acpica/exoparg2.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exoparg2 - AML execution - opcodes with 2 arguments
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exoparg3.c b/drivers/acpi/acpica/exoparg3.c
index a4ebce417930..c8d0d75fc450 100644
--- a/drivers/acpi/acpica/exoparg3.c
+++ b/drivers/acpi/acpica/exoparg3.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exoparg3 - AML execution - opcodes with 3 arguments
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exoparg6.c b/drivers/acpi/acpica/exoparg6.c
index 31385a0b2dab..55d0fa056fe7 100644
--- a/drivers/acpi/acpica/exoparg6.c
+++ b/drivers/acpi/acpica/exoparg6.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exoparg6 - AML execution - opcodes with 6 arguments
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index 728d752f7adc..a4e306690a21 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exprep - ACPI AML field prep utilities
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index c08521194b29..d15a66de26c0 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exregion - ACPI default op_region (address space) handlers
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exresnte.c b/drivers/acpi/acpica/exresnte.c
index b223d01e6bf8..3e4018678c09 100644
--- a/drivers/acpi/acpica/exresnte.c
+++ b/drivers/acpi/acpica/exresnte.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exresnte - AML Interpreter object resolution
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exresolv.c b/drivers/acpi/acpica/exresolv.c
index 36da5c0ef69c..912a078c60a4 100644
--- a/drivers/acpi/acpica/exresolv.c
+++ b/drivers/acpi/acpica/exresolv.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exresolv - AML Interpreter object resolution
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
index bdfe4d33b483..4d1b22971d58 100644
--- a/drivers/acpi/acpica/exresop.c
+++ b/drivers/acpi/acpica/exresop.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exresop - AML Interpreter operand/object resolution
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exserial.c b/drivers/acpi/acpica/exserial.c
index c5aa4b0deb70..760bc7cef55a 100644
--- a/drivers/acpi/acpica/exserial.c
+++ b/drivers/acpi/acpica/exserial.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exserial - field_unit support for serial address spaces
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exstore.c b/drivers/acpi/acpica/exstore.c
index 7f3c3571c292..3adc0a29d890 100644
--- a/drivers/acpi/acpica/exstore.c
+++ b/drivers/acpi/acpica/exstore.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exstore - AML Interpreter object store support
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exstoren.c b/drivers/acpi/acpica/exstoren.c
index 4e43c8277f07..8c34f4e2ab8f 100644
--- a/drivers/acpi/acpica/exstoren.c
+++ b/drivers/acpi/acpica/exstoren.c
@@ -4,7 +4,7 @@
  * Module Name: exstoren - AML Interpreter object store support,
  *                        Store to Node (namespace object)
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exstorob.c b/drivers/acpi/acpica/exstorob.c
index dc9e2b1c1ad9..dc66696080a5 100644
--- a/drivers/acpi/acpica/exstorob.c
+++ b/drivers/acpi/acpica/exstorob.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exstorob - AML object store support, store to object
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsystem.c
index a538f7799b78..f329b01672bb 100644
--- a/drivers/acpi/acpica/exsystem.c
+++ b/drivers/acpi/acpica/exsystem.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exsystem - Interface to OS services
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/extrace.c b/drivers/acpi/acpica/extrace.c
index db7f93ca539f..832a47885b99 100644
--- a/drivers/acpi/acpica/extrace.c
+++ b/drivers/acpi/acpica/extrace.c
@@ -3,7 +3,7 @@
  *
  * Module Name: extrace - Support for interpreter execution tracing
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/exutils.c b/drivers/acpi/acpica/exutils.c
index 75380be1c2ef..8fefa6feac2f 100644
--- a/drivers/acpi/acpica/exutils.c
+++ b/drivers/acpi/acpica/exutils.c
@@ -3,7 +3,7 @@
  *
  * Module Name: exutils - interpreter/scanner utilities
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwacpi.c b/drivers/acpi/acpica/hwacpi.c
index 926f7e080f22..9b9aac27ff7e 100644
--- a/drivers/acpi/acpica/hwacpi.c
+++ b/drivers/acpi/acpica/hwacpi.c
@@ -3,7 +3,7 @@
  *
  * Module Name: hwacpi - ACPI Hardware Initialization/Mode Interface
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwesleep.c b/drivers/acpi/acpica/hwesleep.c
index dee3affaca49..d9be5d0545d4 100644
--- a/drivers/acpi/acpica/hwesleep.c
+++ b/drivers/acpi/acpica/hwesleep.c
@@ -4,7 +4,7 @@
  * Name: hwesleep.c - ACPI Hardware Sleep/Wake Support functions for the
  *                    extended FADT-V5 sleep registers.
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index 565bd3f29f31..1b4252bdcd0b 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -3,7 +3,7 @@
  *
  * Module Name: hwgpe - Low level GPE enable/disable/clear functions
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index b62db8ec446f..243a25add28f 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -4,7 +4,7 @@
  * Name: hwsleep.c - ACPI Hardware Sleep/Wake Support functions for the
  *                   original/legacy sleep/PM registers.
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwtimer.c b/drivers/acpi/acpica/hwtimer.c
index 2fb9f75d71c5..07473ddfa9a9 100644
--- a/drivers/acpi/acpica/hwtimer.c
+++ b/drivers/acpi/acpica/hwtimer.c
@@ -3,7 +3,7 @@
  *
  * Name: hwtimer.c - ACPI Power Management Timer Interface
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
index cd576153257c..4d94861e6093 100644
--- a/drivers/acpi/acpica/hwvalid.c
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -3,7 +3,7 @@
  *
  * Module Name: hwvalid - I/O request validation
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index c4fd97104024..134dbfadcd15 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -3,7 +3,7 @@
  *
  * Module Name: hwxface - Public ACPICA hardware interfaces
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index 2919746c9041..a4b66f4b2714 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -3,7 +3,7 @@
  *
  * Name: hwxfsleep.c - ACPI Hardware Sleep/Wake External Interfaces
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsarguments.c b/drivers/acpi/acpica/nsarguments.c
index 0e97ed38973f..d5e8405e9d8f 100644
--- a/drivers/acpi/acpica/nsarguments.c
+++ b/drivers/acpi/acpica/nsarguments.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsarguments - Validation of args for ACPI predefined methods
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsconvert.c b/drivers/acpi/acpica/nsconvert.c
index c86d0770ed6e..c86c82939ebb 100644
--- a/drivers/acpi/acpica/nsconvert.c
+++ b/drivers/acpi/acpica/nsconvert.c
@@ -4,7 +4,7 @@
  * Module Name: nsconvert - Object conversions for objects returned by
  *                          predefined methods
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 9ad340f644a1..994f0b556c60 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsdump - table dumping routines for debug
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsdumpdv.c b/drivers/acpi/acpica/nsdumpdv.c
index 73e5c83c8c9f..b691fe20e384 100644
--- a/drivers/acpi/acpica/nsdumpdv.c
+++ b/drivers/acpi/acpica/nsdumpdv.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsdump - table dumping routines for debug
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index 61e9dfc9fe8c..e16f6a0c2c3f 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsinit - namespace initialization
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsload.c b/drivers/acpi/acpica/nsload.c
index d7c4d6e8e21e..9ba17891edb6 100644
--- a/drivers/acpi/acpica/nsload.c
+++ b/drivers/acpi/acpica/nsload.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsload - namespace loading/expanding/contracting procedures
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
index f16cf5e4742c..7e74a765e785 100644
--- a/drivers/acpi/acpica/nsparse.c
+++ b/drivers/acpi/acpica/nsparse.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsparse - namespace interface to AML parser
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 2f9d93122d0c..0cea9c363ace 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nspredef - Validation of ACPI predefined methods and objects
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsprepkg.c b/drivers/acpi/acpica/nsprepkg.c
index 9a80e3b23496..237b3ddeb075 100644
--- a/drivers/acpi/acpica/nsprepkg.c
+++ b/drivers/acpi/acpica/nsprepkg.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsprepkg - Validation of package objects for predefined names
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index be86fea8e4d4..90db2d85e7f5 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nsrepair - Repair for objects returned by predefined methods
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 663d85e0adba..125143c41bb8 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -4,7 +4,7 @@
  * Module Name: nsrepair2 - Repair for objects returned by specific
  *                          predefined methods
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index b8d007c84d32..e66abdab8f31 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -4,7 +4,7 @@
  * Module Name: nsutils - Utilities for accessing ACPI namespace, accessing
  *                        parents and siblings and Scope manipulation
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
index ceea6af79d12..b7f3e8603ad8 100644
--- a/drivers/acpi/acpica/nswalk.c
+++ b/drivers/acpi/acpica/nswalk.c
@@ -3,7 +3,7 @@
  *
  * Module Name: nswalk - Functions for walking the ACPI namespace
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index 161e60ddfb69..984129dcaa0c 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -4,7 +4,7 @@
  * Module Name: nsxfname - Public interfaces to the ACPI subsystem
  *                         ACPI Namespace oriented interfaces
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index e62c7897fdf1..3b40db4ad9f3 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psargs - Parse AML opcode arguments
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index 207805047bc4..3cf0687b9915 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psloop - Main AML parse loop
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psobject.c b/drivers/acpi/acpica/psobject.c
index ded2779fc8ea..2480c26c5171 100644
--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psobject - Support for parse objects
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psopcode.c b/drivers/acpi/acpica/psopcode.c
index 43775c5ce17c..28af49263ebf 100644
--- a/drivers/acpi/acpica/psopcode.c
+++ b/drivers/acpi/acpica/psopcode.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psopcode - Parser/Interpreter opcode information table
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psopinfo.c b/drivers/acpi/acpica/psopinfo.c
index 15e7563829f1..ab9327f6a63c 100644
--- a/drivers/acpi/acpica/psopinfo.c
+++ b/drivers/acpi/acpica/psopinfo.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psopinfo - AML opcode information functions and dispatch tables
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index 9b386530ffbe..c780046bf294 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psparse - Parser top level AML parse routines
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psscope.c b/drivers/acpi/acpica/psscope.c
index f153ca804740..fceb311995e9 100644
--- a/drivers/acpi/acpica/psscope.c
+++ b/drivers/acpi/acpica/psscope.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psscope - Parser scope stack management routines
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/pstree.c b/drivers/acpi/acpica/pstree.c
index 22d8a2becdd0..c8aef0694864 100644
--- a/drivers/acpi/acpica/pstree.c
+++ b/drivers/acpi/acpica/pstree.c
@@ -3,7 +3,7 @@
  *
  * Module Name: pstree - Parser op tree manipulation/traversal/search
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psutils.c b/drivers/acpi/acpica/psutils.c
index 2512f584fa3c..00efae2f95ba 100644
--- a/drivers/acpi/acpica/psutils.c
+++ b/drivers/acpi/acpica/psutils.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psutils - Parser miscellaneous utilities (Parser only)
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/pswalk.c b/drivers/acpi/acpica/pswalk.c
index cf91841297c2..0fe3adf6b0e5 100644
--- a/drivers/acpi/acpica/pswalk.c
+++ b/drivers/acpi/acpica/pswalk.c
@@ -3,7 +3,7 @@
  *
  * Module Name: pswalk - Parser routines to walk parsed op tree(s)
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/psxface.c b/drivers/acpi/acpica/psxface.c
index ee2ee2c858f2..1bbfc8def388 100644
--- a/drivers/acpi/acpica/psxface.c
+++ b/drivers/acpi/acpica/psxface.c
@@ -3,7 +3,7 @@
  *
  * Module Name: psxface - Parser external interfaces
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 2cf36451e46f..523b1e9b98d4 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbdata - Table manager data structure functions
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 0041bfba9abc..907edc5edba7 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbfadt   - FADT table utilities
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
index b2abb40023a6..56d81e490a5c 100644
--- a/drivers/acpi/acpica/tbfind.c
+++ b/drivers/acpi/acpica/tbfind.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbfind   - find table
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index ef1ffd36ab3f..0bb15add2245 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbinstal - ACPI table installation and removal
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbprint.c b/drivers/acpi/acpica/tbprint.c
index 4764f849cb78..0b3494ad9a70 100644
--- a/drivers/acpi/acpica/tbprint.c
+++ b/drivers/acpi/acpica/tbprint.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbprint - Table output utilities
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index c5f0b8ec70cc..dfe1ac3ae34a 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbutils - ACPI Table utilities
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 1640685bf4ae..f8403d480318 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbxface - ACPI table-oriented external interfaces
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 0782acf85722..bcba993d4dac 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbxfload - Table load/unload external interfaces
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
index e2859d09ca2e..0edc6ef5d46d 100644
--- a/drivers/acpi/acpica/tbxfroot.c
+++ b/drivers/acpi/acpica/tbxfroot.c
@@ -3,7 +3,7 @@
  *
  * Module Name: tbxfroot - Find the root ACPI table (RSDT)
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utaddress.c b/drivers/acpi/acpica/utaddress.c
index bb260376bd59..99fa48722cf6 100644
--- a/drivers/acpi/acpica/utaddress.c
+++ b/drivers/acpi/acpica/utaddress.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utaddress - op_region address range check
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utalloc.c b/drivers/acpi/acpica/utalloc.c
index d64da4d9e8d0..303ab51b4fcf 100644
--- a/drivers/acpi/acpica/utalloc.c
+++ b/drivers/acpi/acpica/utalloc.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utalloc - local memory allocation routines
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utascii.c b/drivers/acpi/acpica/utascii.c
index f6cd7d4f698b..d78656d960e8 100644
--- a/drivers/acpi/acpica/utascii.c
+++ b/drivers/acpi/acpica/utascii.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utascii - Utility ascii functions
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utbuffer.c b/drivers/acpi/acpica/utbuffer.c
index db897af1de05..f2ec427f4e29 100644
--- a/drivers/acpi/acpica/utbuffer.c
+++ b/drivers/acpi/acpica/utbuffer.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utbuffer - Buffer dump routines
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utcache.c b/drivers/acpi/acpica/utcache.c
index 8533fce7fa93..1b03a2747401 100644
--- a/drivers/acpi/acpica/utcache.c
+++ b/drivers/acpi/acpica/utcache.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utcache - local cache allocation routines
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
index 1fb8327f3c3b..41bdd0278dd8 100644
--- a/drivers/acpi/acpica/utcopy.c
+++ b/drivers/acpi/acpica/utcopy.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utcopy - Internal to external object translation utilities
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index 5b169b5f0f1a..0c8cb0612414 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utdebug - Debug print/trace routines
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index 65beaa237669..befdd13b403b 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utdecode - Utility decoding routines (value-to-string)
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/uteval.c b/drivers/acpi/acpica/uteval.c
index 558a9f3b0678..8180d1a458f5 100644
--- a/drivers/acpi/acpica/uteval.c
+++ b/drivers/acpi/acpica/uteval.c
@@ -3,7 +3,7 @@
  *
  * Module Name: uteval - Object evaluation
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index b0622ec4bb85..e6dcbdc3fc6e 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utglobal - Global variables for the ACPI subsystem
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/uthex.c b/drivers/acpi/acpica/uthex.c
index b6da135d5f41..0e02f12513dc 100644
--- a/drivers/acpi/acpica/uthex.c
+++ b/drivers/acpi/acpica/uthex.c
@@ -3,7 +3,7 @@
  *
  * Module Name: uthex -- Hex/ASCII support functions
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utids.c b/drivers/acpi/acpica/utids.c
index 30198c828ab6..3bb06935a2ad 100644
--- a/drivers/acpi/acpica/utids.c
+++ b/drivers/acpi/acpica/utids.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utids - support for device Ids - HID, UID, CID, SUB, CLS
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utinit.c b/drivers/acpi/acpica/utinit.c
index 6f33e7c72327..fdbc397c038d 100644
--- a/drivers/acpi/acpica/utinit.c
+++ b/drivers/acpi/acpica/utinit.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utinit - Common ACPI subsystem initialization
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utlock.c b/drivers/acpi/acpica/utlock.c
index 8b4ff11d617a..46be549539e7 100644
--- a/drivers/acpi/acpica/utlock.c
+++ b/drivers/acpi/acpica/utlock.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utlock - Reader/Writer lock interfaces
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobject.c
index eee97a902696..3e60bdac2200 100644
--- a/drivers/acpi/acpica/utobject.c
+++ b/drivers/acpi/acpica/utobject.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utobject - ACPI object create/delete/size/cache routines
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
index ad2b218039d0..0a01c08dad8a 100644
--- a/drivers/acpi/acpica/utosi.c
+++ b/drivers/acpi/acpica/utosi.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utosi - Support for the _OSI predefined control method
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utpredef.c b/drivers/acpi/acpica/utpredef.c
index 1b0f68f5ed8c..05fe3470fb93 100644
--- a/drivers/acpi/acpica/utpredef.c
+++ b/drivers/acpi/acpica/utpredef.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utpredef - support functions for predefined names
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
index 5839f2fa7400..a874dac7db5c 100644
--- a/drivers/acpi/acpica/utprint.c
+++ b/drivers/acpi/acpica/utprint.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utprint - Formatted printing routines
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/uttrack.c b/drivers/acpi/acpica/uttrack.c
index 14de4d15e618..d366be431a84 100644
--- a/drivers/acpi/acpica/uttrack.c
+++ b/drivers/acpi/acpica/uttrack.c
@@ -3,7 +3,7 @@
  *
  * Module Name: uttrack - Memory allocation tracking routines (debug only)
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utuuid.c b/drivers/acpi/acpica/utuuid.c
index 0a7cf8007643..b8039954b0d1 100644
--- a/drivers/acpi/acpica/utuuid.c
+++ b/drivers/acpi/acpica/utuuid.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utuuid -- UUID support functions
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index f497c4b30e65..ca7c9f0144ef 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utxface - External interfaces, miscellaneous utility functions
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index cf769e94fe0f..653e3bb20036 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -3,7 +3,7 @@
  *
  * Module Name: utxfinit - External interfaces for ACPICA initialization
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acbuffer.h b/include/acpi/acbuffer.h
index c2acd29f973d..531c1e9a7d10 100644
--- a/include/acpi/acbuffer.h
+++ b/include/acpi/acbuffer.h
@@ -3,7 +3,7 @@
  *
  * Name: acbuffer.h - Support for buffers returned by ACPI predefined names
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index 42d573172e53..5940a3c68a96 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -3,7 +3,7 @@
  *
  * Name: acconfig.h - Global configuration constants
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index 233a72f169bb..436cd1411c3a 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -3,7 +3,7 @@
  *
  * Name: acexcep.h - Exception codes returned by the ACPI subsystem
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
index 8b3eae96706a..8922edb32730 100644
--- a/include/acpi/acnames.h
+++ b/include/acpi/acnames.h
@@ -3,7 +3,7 @@
  *
  * Name: acnames.h - Global names and strings
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index c50542dc71e0..c5d900c0ecda 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -3,7 +3,7 @@
  *
  * Name: acoutput.h -- debug output
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acpi.h b/include/acpi/acpi.h
index bc7d39ecf574..e3e8051d4812 100644
--- a/include/acpi/acpi.h
+++ b/include/acpi/acpi.h
@@ -3,7 +3,7 @@
  *
  * Name: acpi.h - Master public include file used to interface to ACPICA
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 2e63b7b390f5..33bb8c9a089d 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -5,7 +5,7 @@
  *                    interfaces must be implemented by OSL to interface the
  *                    ACPI components to the host operating system.
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index c558d3677a4a..ca07b1371daf 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -3,7 +3,7 @@
  *
  * Name: acpixf.h - External interfaces to the ACPI subsystem
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
index 62930583219f..d3521894ce6a 100644
--- a/include/acpi/acrestyp.h
+++ b/include/acpi/acrestyp.h
@@ -3,7 +3,7 @@
  *
  * Name: acrestyp.h - Defines, types, and structures for resource descriptors
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index d568128025df..5007c41f4d54 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -3,7 +3,7 @@
  *
  * Name: actbl.h - Basic ACPI Table Definitions
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 22c039ebc6c5..02d06b79e1cd 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -3,7 +3,7 @@
  *
  * Name: actbl1.h - Additional ACPI table definitions
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index e45ced27f4c3..b818ba60e19d 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -3,7 +3,7 @@
  *
  * Name: actbl2.h - ACPI Table Definitions (tables not in ACPI spec)
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 7a58c10ce421..2bf3baf819bb 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -3,7 +3,7 @@
  *
  * Name: actbl3.h - ACPI Table Definitions
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 2f3f28c7cea3..a2583c2bc054 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -3,7 +3,7 @@
  *
  * Name: actypes.h - Common data types for the entire ACPI subsystem
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/acuuid.h b/include/acpi/acuuid.h
index 23262cab047a..9dd4689a39cf 100644
--- a/include/acpi/acuuid.h
+++ b/include/acpi/acuuid.h
@@ -3,7 +3,7 @@
  *
  * Name: acuuid.h - ACPI-related UUID/GUID definitions
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 94e89ad478f5..8f6b2654c0b3 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -3,7 +3,7 @@
  *
  * Name: acenv.h - Host and compiler configuration
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/platform/acenvex.h b/include/acpi/platform/acenvex.h
index 2e36c8344897..c3facf5f8495 100644
--- a/include/acpi/platform/acenvex.h
+++ b/include/acpi/platform/acenvex.h
@@ -3,7 +3,7 @@
  *
  * Name: acenvex.h - Extra host and compiler configuration
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
index 6a0705b433d2..7d63d03cf507 100644
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -3,7 +3,7 @@
  *
  * Name: acgcc.h - GCC specific defines, etc.
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/platform/acgccex.h b/include/acpi/platform/acgccex.h
index 8dda2856aca1..7c88fd1de955 100644
--- a/include/acpi/platform/acgccex.h
+++ b/include/acpi/platform/acgccex.h
@@ -3,7 +3,7 @@
  *
  * Name: acgccex.h - Extra GCC specific defines, etc.
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/platform/acintel.h b/include/acpi/platform/acintel.h
index d2cc247248cb..e7fd5e71be62 100644
--- a/include/acpi/platform/acintel.h
+++ b/include/acpi/platform/acintel.h
@@ -3,7 +3,7 @@
  *
  * Name: acintel.h - VC specific defines, etc.
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 310501994c02..987e2af7c335 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -3,7 +3,7 @@
  *
  * Name: aclinux.h - OS specific defines, etc. for Linux
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/include/acpi/platform/aclinuxex.h b/include/acpi/platform/aclinuxex.h
index cc4f1eb53cba..04f88f2de781 100644
--- a/include/acpi/platform/aclinuxex.h
+++ b/include/acpi/platform/aclinuxex.h
@@ -3,7 +3,7 @@
  *
  * Name: aclinuxex.h - Extra OS specific defines, etc. for Linux
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/common/cmfsize.c b/tools/power/acpi/common/cmfsize.c
index 28c11c6b4d06..d1d18ff5c911 100644
--- a/tools/power/acpi/common/cmfsize.c
+++ b/tools/power/acpi/common/cmfsize.c
@@ -3,7 +3,7 @@
  *
  * Module Name: cfsize - Common get file size function
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/common/getopt.c b/tools/power/acpi/common/getopt.c
index 6b41d8b64a00..c3708f30ab3a 100644
--- a/tools/power/acpi/common/getopt.c
+++ b/tools/power/acpi/common/getopt.c
@@ -3,7 +3,7 @@
  *
  * Module Name: getopt
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
index d1f3d44e315e..5aaddc79adf7 100644
--- a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
+++ b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
@@ -3,7 +3,7 @@
  *
  * Module Name: oslinuxtbl - Linux OSL for obtaining ACPI tables
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/os_specific/service_layers/osunixdir.c b/tools/power/acpi/os_specific/service_layers/osunixdir.c
index 30913f124dd5..fd05ddee240f 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixdir.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixdir.c
@@ -3,7 +3,7 @@
  *
  * Module Name: osunixdir - Unix directory access interfaces
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/os_specific/service_layers/osunixmap.c b/tools/power/acpi/os_specific/service_layers/osunixmap.c
index 29dfb47adfeb..c565546e85bc 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixmap.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixmap.c
@@ -3,7 +3,7 @@
  *
  * Module Name: osunixmap - Unix OSL for file mappings
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/os_specific/service_layers/osunixxf.c b/tools/power/acpi/os_specific/service_layers/osunixxf.c
index 83d3b3b829b8..5b2fd968535f 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixxf.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixxf.c
@@ -3,7 +3,7 @@
  *
  * Module Name: osunixxf - UNIX OSL interfaces
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/tools/acpidump/acpidump.h b/tools/power/acpi/tools/acpidump/acpidump.h
index 2eb0aaa4f462..26a5eae9f87f 100644
--- a/tools/power/acpi/tools/acpidump/acpidump.h
+++ b/tools/power/acpi/tools/acpidump/acpidump.h
@@ -3,7 +3,7 @@
  *
  * Module Name: acpidump.h - Include file for acpi_dump utility
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/tools/acpidump/apdump.c b/tools/power/acpi/tools/acpidump/apdump.c
index 820baeb5092b..76433296055d 100644
--- a/tools/power/acpi/tools/acpidump/apdump.c
+++ b/tools/power/acpi/tools/acpidump/apdump.c
@@ -3,7 +3,7 @@
  *
  * Module Name: apdump - Dump routines for ACPI tables (acpidump)
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/tools/acpidump/apfiles.c b/tools/power/acpi/tools/acpidump/apfiles.c
index 16d919bd133b..a682bae4e6f6 100644
--- a/tools/power/acpi/tools/acpidump/apfiles.c
+++ b/tools/power/acpi/tools/acpidump/apfiles.c
@@ -3,7 +3,7 @@
  *
  * Module Name: apfiles - File-related functions for acpidump utility
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
diff --git a/tools/power/acpi/tools/acpidump/apmain.c b/tools/power/acpi/tools/acpidump/apmain.c
index d8f1b57537d3..046e6b8d6baa 100644
--- a/tools/power/acpi/tools/acpidump/apmain.c
+++ b/tools/power/acpi/tools/acpidump/apmain.c
@@ -3,7 +3,7 @@
  *
  * Module Name: apmain - Main module for the acpidump utility
  *
- * Copyright (C) 2000 - 2019, Intel Corp.
+ * Copyright (C) 2000 - 2020, Intel Corp.
  *
  *****************************************************************************/
 
-- 
2.21.0

