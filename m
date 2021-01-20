Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D6D2FD905
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Jan 2021 20:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392463AbhATTDY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Jan 2021 14:03:24 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:43302 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392380AbhATTDV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jan 2021 14:03:21 -0500
Received: from 89-64-80-175.dynamic.chello.pl (89.64.80.175) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id 37c59415165b22d5; Wed, 20 Jan 2021 20:02:10 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v1 6/6] ACPI: bus: Drop ACPI_BUS_COMPONENT which is not used any more
Date:   Wed, 20 Jan 2021 20:01:18 +0100
Message-ID: <1953409.1HvooF2U0O@kreacher>
In-Reply-To: <2809410.8bz27usjlQ@kreacher>
References: <2809410.8bz27usjlQ@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After dropping all of the code using ACPI_BUS_COMPONENT drop it
too and modify the example in the documentation using it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/firmware-guide/acpi/debug.rst |   13 ++++++-------
 drivers/acpi/sysfs.c                        |    1 -
 include/acpi/acpi_drivers.h                 |    1 -
 3 files changed, 6 insertions(+), 9 deletions(-)

Index: linux-pm/Documentation/firmware-guide/acpi/debug.rst
===================================================================
--- linux-pm.orig/Documentation/firmware-guide/acpi/debug.rst
+++ linux-pm/Documentation/firmware-guide/acpi/debug.rst
@@ -52,7 +52,6 @@ shows the supported mask values, current
     ACPI_CA_DISASSEMBLER            0x00000800
     ACPI_COMPILER                   0x00001000
     ACPI_TOOLS                      0x00002000
-    ACPI_BUS_COMPONENT              0x00010000
     ACPI_AC_COMPONENT               0x00020000
     ACPI_BATTERY_COMPONENT          0x00040000
     ACPI_BUTTON_COMPONENT           0x00080000
@@ -117,15 +116,15 @@ currently these::
 Examples
 ========
 
-For example, drivers/acpi/bus.c contains this::
+For example, drivers/acpi/acpica/evxfevnt.c contains this::
 
-    #define _COMPONENT              ACPI_BUS_COMPONENT
+    #define _COMPONENT          ACPI_EVENTS
     ...
-    ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device insertion detected\n"));
+    ACPI_DEBUG_PRINT((ACPI_DB_INIT, "ACPI mode disabled\n"));
 
-To turn on this message, set the ACPI_BUS_COMPONENT bit in acpi.debug_layer
-and the ACPI_LV_INFO bit in acpi.debug_level.  (The ACPI_DEBUG_PRINT
-statement uses ACPI_DB_INFO, which is macro based on the ACPI_LV_INFO
+To turn on this message, set the ACPI_EVENTS bit in acpi.debug_layer
+and the ACPI_LV_INIT bit in acpi.debug_level.  (The ACPI_DEBUG_PRINT
+statement uses ACPI_DB_INIT, which is a macro based on the ACPI_LV_INIT
 definition.)
 
 Enable all AML "Debug" output (stores to the Debug object while interpreting
Index: linux-pm/drivers/acpi/sysfs.c
===================================================================
--- linux-pm.orig/drivers/acpi/sysfs.c
+++ linux-pm/drivers/acpi/sysfs.c
@@ -52,7 +52,6 @@ static const struct acpi_dlayer acpi_deb
 	ACPI_DEBUG_INIT(ACPI_COMPILER),
 	ACPI_DEBUG_INIT(ACPI_TOOLS),
 
-	ACPI_DEBUG_INIT(ACPI_BUS_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_AC_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_BATTERY_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_BUTTON_COMPONENT),
Index: linux-pm/include/acpi/acpi_drivers.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_drivers.h
+++ linux-pm/include/acpi/acpi_drivers.h
@@ -15,7 +15,6 @@
  * Please update drivers/acpi/debug.c and Documentation/firmware-guide/acpi/debug.rst
  * if you add to this list.
  */
-#define ACPI_BUS_COMPONENT		0x00010000
 #define ACPI_AC_COMPONENT		0x00020000
 #define ACPI_BATTERY_COMPONENT		0x00040000
 #define ACPI_BUTTON_COMPONENT		0x00080000



