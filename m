Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3D430AF22
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Feb 2021 19:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbhBASZY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Feb 2021 13:25:24 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:45586 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbhBASVv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2021 13:21:51 -0500
Received: from 89-64-80-124.dynamic.chello.pl (89.64.80.124) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id dab7a9325be5469d; Mon, 1 Feb 2021 19:20:27 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v1 2/5] ACPI: battery: Clean up printing messages
Date:   Mon, 01 Feb 2021 19:16:16 +0100
Message-ID: <1996712.1aSbzQgNOC@kreacher>
In-Reply-To: <2367702.B5bJTmGzJm@kreacher>
References: <2367702.B5bJTmGzJm@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Replace the ACPI_DEBUG_PRINT() and ACPI_EXCEPTION() instances
in battery.c with acpi_handle_debug() and acpi_handle_info() calls,
respectively, drop the _COMPONENT and ACPI_MODULE_NAME() definitions
that are not used any more, drop the no longer needed
ACPI_BATTERY_COMPONENT definition from the headers and update the
documentation accordingly.

While at it, update the pr_fmt() definition and drop the unneeded
PREFIX sybmbol definition from battery.c.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/firmware-guide/acpi/debug.rst |    1 
 drivers/acpi/battery.c                      |   29 ++++++++++++++--------------
 drivers/acpi/sysfs.c                        |    1 
 include/acpi/acpi_drivers.h                 |    1 
 4 files changed, 15 insertions(+), 17 deletions(-)

Index: linux-pm/drivers/acpi/battery.c
===================================================================
--- linux-pm.orig/drivers/acpi/battery.c
+++ linux-pm/drivers/acpi/battery.c
@@ -8,7 +8,7 @@
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#define pr_fmt(fmt) "ACPI: battery: " fmt
 
 #include <linux/async.h>
 #include <linux/delay.h>
@@ -29,8 +29,6 @@
 
 #include <acpi/battery.h>
 
-#define PREFIX "ACPI: "
-
 #define ACPI_BATTERY_VALUE_UNKNOWN 0xFFFFFFFF
 #define ACPI_BATTERY_CAPACITY_VALID(capacity) \
 	((capacity) != 0 && (capacity) != ACPI_BATTERY_VALUE_UNKNOWN)
@@ -44,10 +42,6 @@
 #define ACPI_BATTERY_STATE_CHARGING	0x2
 #define ACPI_BATTERY_STATE_CRITICAL	0x4
 
-#define _COMPONENT		ACPI_BATTERY_COMPONENT
-
-ACPI_MODULE_NAME("battery");
-
 MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_AUTHOR("Alexey Starikovskiy <astarikovskiy@suse.de>");
 MODULE_DESCRIPTION("ACPI Battery Driver");
@@ -466,7 +460,8 @@ static int extract_package(struct acpi_b
 static int acpi_battery_get_status(struct acpi_battery *battery)
 {
 	if (acpi_bus_get_status(battery->device)) {
-		ACPI_EXCEPTION((AE_INFO, AE_ERROR, "Evaluating _STA"));
+		acpi_handle_info(battery->device->handle,
+				 "_STA evaluation failed\n");
 		return -ENODEV;
 	}
 	return 0;
@@ -535,8 +530,10 @@ static int acpi_battery_get_info(struct
 		mutex_unlock(&battery->lock);
 
 		if (ACPI_FAILURE(status)) {
-			ACPI_EXCEPTION((AE_INFO, status, "Evaluating %s",
-					use_bix ? "_BIX":"_BIF"));
+			acpi_handle_info(battery->device->handle,
+					 "%s evaluation failed: %s\n",
+					 use_bix ?"_BIX":"_BIF",
+				         acpi_format_exception(status));
 		} else {
 			result = extract_battery_info(use_bix,
 						      battery,
@@ -573,7 +570,9 @@ static int acpi_battery_get_state(struct
 	mutex_unlock(&battery->lock);
 
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _BST"));
+		acpi_handle_info(battery->device->handle,
+				 "_BST evaluation failed: %s",
+				 acpi_format_exception(status));
 		return -ENODEV;
 	}
 
@@ -625,7 +624,9 @@ static int acpi_battery_set_alarm(struct
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Alarm set to %d\n", battery->alarm));
+	acpi_handle_debug(battery->device->handle, "Alarm set to %d\n",
+			  battery->alarm);
+
 	return 0;
 }
 
@@ -1201,7 +1202,7 @@ static int acpi_battery_add(struct acpi_
 	if (result)
 		goto fail;
 
-	pr_info(PREFIX "%s Slot [%s] (battery %s)\n",
+	pr_info("%s Slot [%s] (battery %s)\n",
 		ACPI_BATTERY_DEVICE_NAME, acpi_device_bid(device),
 		device->status.battery_present ? "present" : "absent");
 
@@ -1282,7 +1283,7 @@ static void __init acpi_battery_init_asy
 	if (battery_check_pmic) {
 		for (i = 0; i < ARRAY_SIZE(acpi_battery_blacklist); i++)
 			if (acpi_dev_present(acpi_battery_blacklist[i], "1", -1)) {
-				pr_info(PREFIX ACPI_BATTERY_DEVICE_NAME
+				pr_info(ACPI_BATTERY_DEVICE_NAME
 					": found native %s PMIC, not loading\n",
 					acpi_battery_blacklist[i]);
 				return;
Index: linux-pm/Documentation/firmware-guide/acpi/debug.rst
===================================================================
--- linux-pm.orig/Documentation/firmware-guide/acpi/debug.rst
+++ linux-pm/Documentation/firmware-guide/acpi/debug.rst
@@ -52,7 +52,6 @@ shows the supported mask values, current
     ACPI_CA_DISASSEMBLER            0x00000800
     ACPI_COMPILER                   0x00001000
     ACPI_TOOLS                      0x00002000
-    ACPI_BATTERY_COMPONENT          0x00040000
     ACPI_BUTTON_COMPONENT           0x00080000
     ACPI_SBS_COMPONENT              0x00100000
     ACPI_FAN_COMPONENT              0x00200000
Index: linux-pm/drivers/acpi/sysfs.c
===================================================================
--- linux-pm.orig/drivers/acpi/sysfs.c
+++ linux-pm/drivers/acpi/sysfs.c
@@ -52,7 +52,6 @@ static const struct acpi_dlayer acpi_deb
 	ACPI_DEBUG_INIT(ACPI_COMPILER),
 	ACPI_DEBUG_INIT(ACPI_TOOLS),
 
-	ACPI_DEBUG_INIT(ACPI_BATTERY_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_BUTTON_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_SBS_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_FAN_COMPONENT),
Index: linux-pm/include/acpi/acpi_drivers.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_drivers.h
+++ linux-pm/include/acpi/acpi_drivers.h
@@ -15,7 +15,6 @@
  * Please update drivers/acpi/debug.c and Documentation/firmware-guide/acpi/debug.rst
  * if you add to this list.
  */
-#define ACPI_BATTERY_COMPONENT		0x00040000
 #define ACPI_BUTTON_COMPONENT		0x00080000
 #define ACPI_SBS_COMPONENT		0x00100000
 #define ACPI_FAN_COMPONENT		0x00200000



