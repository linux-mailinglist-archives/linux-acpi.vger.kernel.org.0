Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EEE30E2DE
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 19:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbhBCSwS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Feb 2021 13:52:18 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:56092 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbhBCSwF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Feb 2021 13:52:05 -0500
Received: from 89-64-80-249.dynamic.chello.pl (89.64.80.249) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id 438ba9a2e3b12916; Wed, 3 Feb 2021 19:51:20 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Joe Perches <joe@perches.com>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v3 1/5] ACPI: AC: Clean up printing messages
Date:   Wed, 03 Feb 2021 19:43:17 +0100
Message-ID: <15677254.uJehtQVoeh@kreacher>
In-Reply-To: <1961054.9MKZ8ejxOh@kreacher>
References: <2367702.B5bJTmGzJm@kreacher> <1991501.dpTHplkurC@kreacher> <1961054.9MKZ8ejxOh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Replace the ACPI_DEBUG_PRINT() and ACPI_EXCEPTION() instances
in ac.c with acpi_handle_debug() and acpi_handle_info() calls,
respectively, which among other things causes the excessive log
level of the messages previously printed via ACPI_EXCEPTION() to
be increased.

Drop the _COMPONENT and ACPI_MODULE_NAME() definitions that are not
used any more, drop the no longer needed ACPI_AC_COMPONENT definition
from the headers and update the documentation accordingly.

While at it, replace the direct printk() invocation with pr_info(),
add a pr_fmt() definition to ac.c and drop the unneeded PREFIX
symbol definition from there.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3: Also add a pr_fmt() definition to ac.c and replace direct
          printk() with pr_info (no log level change).

v1 -> v2: Changelog update.

---
 Documentation/firmware-guide/acpi/debug.rst |    1 -
 drivers/acpi/ac.c                           |   23 ++++++++++-------------
 drivers/acpi/sysfs.c                        |    1 -
 include/acpi/acpi_drivers.h                 |    1 -
 4 files changed, 10 insertions(+), 16 deletions(-)

Index: linux-pm/Documentation/firmware-guide/acpi/debug.rst
===================================================================
--- linux-pm.orig/Documentation/firmware-guide/acpi/debug.rst
+++ linux-pm/Documentation/firmware-guide/acpi/debug.rst
@@ -52,7 +52,6 @@ shows the supported mask values, current
     ACPI_CA_DISASSEMBLER            0x00000800
     ACPI_COMPILER                   0x00001000
     ACPI_TOOLS                      0x00002000
-    ACPI_AC_COMPONENT               0x00020000
     ACPI_BATTERY_COMPONENT          0x00040000
     ACPI_BUTTON_COMPONENT           0x00080000
     ACPI_SBS_COMPONENT              0x00100000
Index: linux-pm/drivers/acpi/ac.c
===================================================================
--- linux-pm.orig/drivers/acpi/ac.c
+++ linux-pm/drivers/acpi/ac.c
@@ -6,6 +6,8 @@
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
  */
 
+#define pr_fmt(fmt) "ACPI: AC: " fmt
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -18,8 +20,6 @@
 #include <linux/acpi.h>
 #include <acpi/battery.h>
 
-#define PREFIX "ACPI: "
-
 #define ACPI_AC_CLASS			"ac_adapter"
 #define ACPI_AC_DEVICE_NAME		"AC Adapter"
 #define ACPI_AC_FILE_STATE		"state"
@@ -28,9 +28,6 @@
 #define ACPI_AC_STATUS_ONLINE		0x01
 #define ACPI_AC_STATUS_UNKNOWN		0xFF
 
-#define _COMPONENT		ACPI_AC_COMPONENT
-ACPI_MODULE_NAME("ac");
-
 MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI AC Adapter Driver");
 MODULE_LICENSE("GPL");
@@ -102,8 +99,9 @@ static int acpi_ac_get_state(struct acpi
 	status = acpi_evaluate_integer(ac->device->handle, "_PSR", NULL,
 				       &ac->state);
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status,
-				"Error reading AC Adapter state"));
+		acpi_handle_info(ac->device->handle,
+				"Error reading AC Adapter state: %s\n",
+				acpi_format_exception(status));
 		ac->state = ACPI_AC_STATUS_UNKNOWN;
 		return -ENODEV;
 	}
@@ -153,8 +151,8 @@ static void acpi_ac_notify(struct acpi_d
 
 	switch (event) {
 	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Unsupported event [0x%x]\n", event));
+		acpi_handle_debug(device->handle, "Unsupported event [0x%x]\n",
+				  event);
 		fallthrough;
 	case ACPI_AC_NOTIFY_STATUS:
 	case ACPI_NOTIFY_BUS_CHECK:
@@ -278,9 +276,8 @@ static int acpi_ac_add(struct acpi_devic
 		goto end;
 	}
 
-	printk(KERN_INFO PREFIX "%s [%s] (%s)\n",
-	       acpi_device_name(device), acpi_device_bid(device),
-	       ac->state ? "on-line" : "off-line");
+	pr_info("%s [%s] (%s)\n", acpi_device_name(device),
+		acpi_device_bid(device), ac->state ? "on-line" : "off-line");
 
 	ac->battery_nb.notifier_call = acpi_ac_battery_notify;
 	register_acpi_notifier(&ac->battery_nb);
@@ -348,7 +345,7 @@ static int __init acpi_ac_init(void)
 		for (i = 0; i < ARRAY_SIZE(acpi_ac_blacklist); i++)
 			if (acpi_dev_present(acpi_ac_blacklist[i].hid, "1",
 					     acpi_ac_blacklist[i].hrv)) {
-				pr_info(PREFIX "AC: found native %s PMIC, not loading\n",
+				pr_info("found native %s PMIC, not loading\n",
 					acpi_ac_blacklist[i].hid);
 				return -ENODEV;
 			}
Index: linux-pm/drivers/acpi/sysfs.c
===================================================================
--- linux-pm.orig/drivers/acpi/sysfs.c
+++ linux-pm/drivers/acpi/sysfs.c
@@ -52,7 +52,6 @@ static const struct acpi_dlayer acpi_deb
 	ACPI_DEBUG_INIT(ACPI_COMPILER),
 	ACPI_DEBUG_INIT(ACPI_TOOLS),
 
-	ACPI_DEBUG_INIT(ACPI_AC_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_BATTERY_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_BUTTON_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_SBS_COMPONENT),
Index: linux-pm/include/acpi/acpi_drivers.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_drivers.h
+++ linux-pm/include/acpi/acpi_drivers.h
@@ -15,7 +15,6 @@
  * Please update drivers/acpi/debug.c and Documentation/firmware-guide/acpi/debug.rst
  * if you add to this list.
  */
-#define ACPI_AC_COMPONENT		0x00020000
 #define ACPI_BATTERY_COMPONENT		0x00040000
 #define ACPI_BUTTON_COMPONENT		0x00080000
 #define ACPI_SBS_COMPONENT		0x00100000



