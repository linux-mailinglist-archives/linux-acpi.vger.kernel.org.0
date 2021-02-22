Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED39321F8F
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Feb 2021 20:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhBVTDZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Feb 2021 14:03:25 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:47962 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbhBVTDQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Feb 2021 14:03:16 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_smtp) via UNIX with SMTP (IdeaSmtpServer 0.83.537)
 id be9fa58f915f17ae; Mon, 22 Feb 2021 20:02:20 +0100
Received: from kreacher.localnet (89-64-81-242.dynamic.chello.pl [89.64.81.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id C564E662057;
        Mon, 22 Feb 2021 20:02:19 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v1 3/4] ACPI: Drop unused ACPI_*_COMPONENT definitions and update documentation
Date:   Mon, 22 Feb 2021 20:00:43 +0100
Message-ID: <1894278.zaleJvVaSW@kreacher>
In-Reply-To: <5138173.kHyPcihzTF@kreacher>
References: <5138173.kHyPcihzTF@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrkeefgdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtvdenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefgleehfffhtefflefhleetjeffteettefgteekjedvhfeffedtueefveegveeiveenucfkphepkeelrdeigedrkedurddvgedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedurddvgedvpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhuohhhrghnjhhunheshhhurgifvghirdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Drop the definitions of the following symbols:

 ACPI_SBS_COMPONENT
 ACPI_FAN_COMPONENT
 ACPI_CONTAINER_COMPONENT
 ACPI_MEMORY_DEVICE_COMPONENT

that are not used in a meaningful way any more and update the ACPI
debug documentation to avoid confusing users by making the impression
that the ACPICA debug can be used for anything other than ACPICA
itself, which is incorrect.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/firmware-guide/acpi/debug.rst |   29 +++++++++++-----------------
 drivers/acpi/sysfs.c                        |    5 ----
 include/acpi/acpi_drivers.h                 |    9 --------
 3 files changed, 12 insertions(+), 31 deletions(-)

Index: linux-pm/Documentation/firmware-guide/acpi/debug.rst
===================================================================
--- linux-pm.orig/Documentation/firmware-guide/acpi/debug.rst
+++ linux-pm/Documentation/firmware-guide/acpi/debug.rst
@@ -1,18 +1,17 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-=================
-ACPI Debug Output
-=================
+====================
+ACPI CA Debug Output
+====================
 
-The ACPI CA, the Linux ACPI core, and some ACPI drivers can generate debug
-output.  This document describes how to use this facility.
+The ACPI CA can generate debug output.  This document describes how to use this
+facility.
 
 Compile-time configuration
 ==========================
 
-ACPI debug output is globally enabled by CONFIG_ACPI_DEBUG.  If this config
-option is turned off, the debug messages are not even built into the
-kernel.
+The ACPI CA debug output is globally enabled by CONFIG_ACPI_DEBUG.  If this
+config option is not set, the debug messages are not even built into the kernel.
 
 Boot- and run-time configuration
 ================================
@@ -27,16 +26,16 @@ debug_layer (component)
 =======================
 
 The "debug_layer" is a mask that selects components of interest, e.g., a
-specific driver or part of the ACPI interpreter.  To build the debug_layer
-bitmask, look for the "#define _COMPONENT" in an ACPI source file.
+specific part of the ACPI interpreter.  To build the debug_layer bitmask, look
+for the "#define _COMPONENT" in an ACPI source file.
 
 You can set the debug_layer mask at boot-time using the acpi.debug_layer
 command line argument, and you can change it after boot by writing values
 to /sys/module/acpi/parameters/debug_layer.
 
-The possible components are defined in include/acpi/acoutput.h and
-include/acpi/acpi_drivers.h.  Reading /sys/module/acpi/parameters/debug_layer
-shows the supported mask values, currently these::
+The possible components are defined in include/acpi/acoutput.h.
+
+Reading /sys/module/acpi/parameters/debug_layer shows the supported mask values::
 
     ACPI_UTILITIES                  0x00000001
     ACPI_HARDWARE                   0x00000002
@@ -52,10 +51,6 @@ shows the supported mask values, current
     ACPI_CA_DISASSEMBLER            0x00000800
     ACPI_COMPILER                   0x00001000
     ACPI_TOOLS                      0x00002000
-    ACPI_SBS_COMPONENT              0x00100000
-    ACPI_FAN_COMPONENT              0x00200000
-    ACPI_CONTAINER_COMPONENT        0x01000000
-    ACPI_MEMORY_DEVICE_COMPONENT    0x08000000
 
 debug_level
 ===========
Index: linux-pm/drivers/acpi/sysfs.c
===================================================================
--- linux-pm.orig/drivers/acpi/sysfs.c
+++ linux-pm/drivers/acpi/sysfs.c
@@ -48,11 +48,6 @@ static const struct acpi_dlayer acpi_deb
 	ACPI_DEBUG_INIT(ACPI_CA_DISASSEMBLER),
 	ACPI_DEBUG_INIT(ACPI_COMPILER),
 	ACPI_DEBUG_INIT(ACPI_TOOLS),
-
-	ACPI_DEBUG_INIT(ACPI_SBS_COMPONENT),
-	ACPI_DEBUG_INIT(ACPI_FAN_COMPONENT),
-	ACPI_DEBUG_INIT(ACPI_CONTAINER_COMPONENT),
-	ACPI_DEBUG_INIT(ACPI_MEMORY_DEVICE_COMPONENT),
 };
 
 static const struct acpi_dlevel acpi_debug_levels[] = {
Index: linux-pm/include/acpi/acpi_drivers.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_drivers.h
+++ linux-pm/include/acpi/acpi_drivers.h
@@ -12,15 +12,6 @@
 #define ACPI_MAX_STRING			80
 
 /*
- * Please update drivers/acpi/debug.c and Documentation/firmware-guide/acpi/debug.rst
- * if you add to this list.
- */
-#define ACPI_SBS_COMPONENT		0x00100000
-#define ACPI_FAN_COMPONENT		0x00200000
-#define ACPI_CONTAINER_COMPONENT	0x01000000
-#define ACPI_MEMORY_DEVICE_COMPONENT	0x08000000
-
-/*
  * _HID definitions
  * HIDs must conform to ACPI spec(6.1.4)
  * Linux specific HIDs do not apply to this and begin with LNX:



