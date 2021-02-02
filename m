Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7F930C99B
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Feb 2021 19:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238537AbhBBSXE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 13:23:04 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:41688 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238411AbhBBSU4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2021 13:20:56 -0500
Received: from 89-64-80-193.dynamic.chello.pl (89.64.80.193) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id 67fbe224267611b1; Tue, 2 Feb 2021 19:19:51 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2 5/5] ACPI: thermal: Clean up printing messages
Date:   Tue, 02 Feb 2021 19:19:29 +0100
Message-ID: <2382444.QC0lEobvty@kreacher>
In-Reply-To: <1991501.dpTHplkurC@kreacher>
References: <2367702.B5bJTmGzJm@kreacher> <1991501.dpTHplkurC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Replace the ACPI_DEBUG_PRINT() instances in thermal.c with
acpi_handle_debug() calls and modify the ACPI_THERMAL_TRIPS_EXCEPTION()
macro in there to use acpi_handle_info() internally,  which among other
things causes the excessive log level of the messages printed by it to
be more adequate.

Drop the _COMPONENT and ACPI_MODULE_NAME() definitions that are not
used any more from thermal.c, drop the no longer needed
ACPI_THERMAL_COMPONENT definition from the headers and update the
documentation accordingly.

While at it, add a pr_fmt() definition to thermal.c, drop the PREFIX
definition from there and replace some pr_warn() calls with pr_info()
or acpi_handle_info() to reduce the excessive log level and (in the
latter case) facilitate easier identification of the message source.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Changelog update

---
 Documentation/firmware-guide/acpi/debug.rst |    1 
 drivers/acpi/sysfs.c                        |    1 
 drivers/acpi/thermal.c                      |   87 +++++++++++++---------------
 include/acpi/acpi_drivers.h                 |    1 
 4 files changed, 43 insertions(+), 47 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -13,6 +13,8 @@
  *          concepts of 'multiple limiters', upper/lower limits, etc.
  */
 
+#define pr_fmt(fmt) "ACPI: thermal: " fmt
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/dmi.h>
@@ -29,8 +31,6 @@
 #include <linux/uaccess.h>
 #include <linux/units.h>
 
-#define PREFIX "ACPI: "
-
 #define ACPI_THERMAL_CLASS		"thermal_zone"
 #define ACPI_THERMAL_DEVICE_NAME	"Thermal Zone"
 #define ACPI_THERMAL_NOTIFY_TEMPERATURE	0x80
@@ -43,9 +43,6 @@
 #define ACPI_THERMAL_MAX_ACTIVE	10
 #define ACPI_THERMAL_MAX_LIMIT_STR_LEN 65
 
-#define _COMPONENT		ACPI_THERMAL_COMPONENT
-ACPI_MODULE_NAME("thermal");
-
 MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI Thermal Zone Driver");
 MODULE_LICENSE("GPL");
@@ -197,8 +194,9 @@ static int acpi_thermal_get_temperature(
 		return -ENODEV;
 
 	tz->temperature = tmp;
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Temperature is %lu dK\n",
-			  tz->temperature));
+
+	acpi_handle_debug(tz->device->handle, "Temperature is %lu dK\n",
+			  tz->temperature);
 
 	return 0;
 }
@@ -216,8 +214,8 @@ static int acpi_thermal_get_polling_freq
 		return -ENODEV;
 
 	tz->polling_frequency = tmp;
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Polling frequency is %lu dS\n",
-			  tz->polling_frequency));
+	acpi_handle_debug(tz->device->handle, "Polling frequency is %lu dS\n",
+			  tz->polling_frequency);
 
 	return 0;
 }
@@ -254,12 +252,12 @@ static int acpi_thermal_set_cooling_mode
  * 2.TODO: Devices listed in _PSL, _ALx, _TZD may change.
  *   We need to re-bind the cooling devices of a thermal zone when this occurs.
  */
-#define ACPI_THERMAL_TRIPS_EXCEPTION(flags, str)	\
+#define ACPI_THERMAL_TRIPS_EXCEPTION(flags, tz, str)	\
 do {	\
 	if (flags != ACPI_TRIPS_INIT)	\
-		ACPI_EXCEPTION((AE_INFO, AE_ERROR,	\
+		acpi_handle_info(tz->device->handle,	\
 		"ACPI thermal trip point %s changed\n"	\
-		"Please send acpidump to linux-acpi@vger.kernel.org", str)); \
+		"Please report to linux-acpi@vger.kernel.org\n", str); \
 } while (0)
 
 static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
@@ -283,17 +281,17 @@ static int acpi_thermal_trips_update(str
 		 */
 		if (ACPI_FAILURE(status)) {
 			tz->trips.critical.flags.valid = 0;
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "No critical threshold\n"));
+			acpi_handle_debug(tz->device->handle,
+					  "No critical threshold\n");
 		} else if (tmp <= 2732) {
-			pr_warn(FW_BUG "Invalid critical threshold (%llu)\n",
+			pr_info(FW_BUG "Invalid critical threshold (%llu)\n",
 				tmp);
 			tz->trips.critical.flags.valid = 0;
 		} else {
 			tz->trips.critical.flags.valid = 1;
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			acpi_handle_debug(tz->device->handle,
 					  "Found critical threshold [%lu]\n",
-					  tz->trips.critical.temperature));
+					  tz->trips.critical.temperature);
 		}
 		if (tz->trips.critical.flags.valid == 1) {
 			if (crt == -1) {
@@ -305,8 +303,8 @@ static int acpi_thermal_trips_update(str
 				 * Allow override critical threshold
 				 */
 				if (crt_k > tz->trips.critical.temperature)
-					pr_warn(PREFIX "Critical threshold %d C\n",
-						crt);
+					pr_info("Critical threshold %d C\n", crt);
+
 				tz->trips.critical.temperature = crt_k;
 			}
 		}
@@ -318,14 +316,14 @@ static int acpi_thermal_trips_update(str
 				"_HOT", NULL, &tmp);
 		if (ACPI_FAILURE(status)) {
 			tz->trips.hot.flags.valid = 0;
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					"No hot threshold\n"));
+			acpi_handle_debug(tz->device->handle,
+					  "No hot threshold\n");
 		} else {
 			tz->trips.hot.temperature = tmp;
 			tz->trips.hot.flags.valid = 1;
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					"Found hot threshold [%lu]\n",
-					tz->trips.hot.temperature));
+			acpi_handle_debug(tz->device->handle,
+					  "Found hot threshold [%lu]\n",
+					  tz->trips.hot.temperature);
 		}
 	}
 
@@ -378,7 +376,8 @@ static int acpi_thermal_trips_update(str
 		status = acpi_evaluate_reference(tz->device->handle, "_PSL",
 							NULL, &devices);
 		if (ACPI_FAILURE(status)) {
-			pr_warn(PREFIX "Invalid passive threshold\n");
+			acpi_handle_info(tz->device->handle,
+					 "Invalid passive threshold\n");
 			tz->trips.passive.flags.valid = 0;
 		}
 		else
@@ -388,12 +387,12 @@ static int acpi_thermal_trips_update(str
 				sizeof(struct acpi_handle_list))) {
 			memcpy(&tz->trips.passive.devices, &devices,
 				sizeof(struct acpi_handle_list));
-			ACPI_THERMAL_TRIPS_EXCEPTION(flag, "device");
+			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
 		}
 	}
 	if ((flag & ACPI_TRIPS_PASSIVE) || (flag & ACPI_TRIPS_DEVICES)) {
 		if (valid != tz->trips.passive.flags.valid)
-				ACPI_THERMAL_TRIPS_EXCEPTION(flag, "state");
+				ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "state");
 	}
 
 	/* Active (optional) */
@@ -440,8 +439,8 @@ static int acpi_thermal_trips_update(str
 			status = acpi_evaluate_reference(tz->device->handle,
 						name, NULL, &devices);
 			if (ACPI_FAILURE(status)) {
-				pr_warn(PREFIX "Invalid active%d threshold\n",
-					i);
+				acpi_handle_info(tz->device->handle,
+						 "Invalid active%d threshold\n", i);
 				tz->trips.active[i].flags.valid = 0;
 			}
 			else
@@ -451,12 +450,12 @@ static int acpi_thermal_trips_update(str
 					sizeof(struct acpi_handle_list))) {
 				memcpy(&tz->trips.active[i].devices, &devices,
 					sizeof(struct acpi_handle_list));
-				ACPI_THERMAL_TRIPS_EXCEPTION(flag, "device");
+				ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
 			}
 		}
 		if ((flag & ACPI_TRIPS_ACTIVE) || (flag & ACPI_TRIPS_DEVICES))
 			if (valid != tz->trips.active[i].flags.valid)
-				ACPI_THERMAL_TRIPS_EXCEPTION(flag, "state");
+				ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "state");
 
 		if (!tz->trips.active[i].flags.valid)
 			break;
@@ -469,7 +468,7 @@ static int acpi_thermal_trips_update(str
 		if (ACPI_SUCCESS(status)
 		    && memcmp(&tz->devices, &devices, sizeof(devices))) {
 			tz->devices = devices;
-			ACPI_THERMAL_TRIPS_EXCEPTION(flag, "device");
+			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
 		}
 	}
 
@@ -925,8 +924,8 @@ static void acpi_thermal_notify(struct a
 						  dev_name(&device->dev), event, 0);
 		break;
 	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Unsupported event [0x%x]\n", event));
+		acpi_handle_debug(device->handle, "Unsupported event [0x%x]\n",
+				  event);
 		break;
 	}
 }
@@ -1074,7 +1073,7 @@ static int acpi_thermal_add(struct acpi_
 	mutex_init(&tz->thermal_check_lock);
 	INIT_WORK(&tz->thermal_check_work, acpi_thermal_check_fn);
 
-	pr_info(PREFIX "%s [%s] (%ld C)\n", acpi_device_name(device),
+	pr_info("%s [%s] (%ld C)\n", acpi_device_name(device),
 		acpi_device_bid(device), deci_kelvin_to_celsius(tz->temperature));
 	goto end;
 
@@ -1146,24 +1145,24 @@ static int acpi_thermal_resume(struct de
 static int thermal_act(const struct dmi_system_id *d) {
 
 	if (act == 0) {
-		pr_notice(PREFIX "%s detected: "
-			  "disabling all active thermal trip points\n", d->ident);
+		pr_notice("%s detected: disabling all active thermal trip points\n",
+			  d->ident);
 		act = -1;
 	}
 	return 0;
 }
 static int thermal_nocrt(const struct dmi_system_id *d) {
 
-	pr_notice(PREFIX "%s detected: "
-		  "disabling all critical thermal trip point actions.\n", d->ident);
+	pr_notice("%s detected: disabling all critical thermal trip point actions.\n",
+		  d->ident);
 	nocrt = 1;
 	return 0;
 }
 static int thermal_tzp(const struct dmi_system_id *d) {
 
 	if (tzp == 0) {
-		pr_notice(PREFIX "%s detected: "
-			  "enabling thermal zone polling\n", d->ident);
+		pr_notice("%s detected: enabling thermal zone polling\n",
+			  d->ident);
 		tzp = 300;	/* 300 dS = 30 Seconds */
 	}
 	return 0;
@@ -1171,8 +1170,8 @@ static int thermal_tzp(const struct dmi_
 static int thermal_psv(const struct dmi_system_id *d) {
 
 	if (psv == 0) {
-		pr_notice(PREFIX "%s detected: "
-			  "disabling all passive thermal trip points\n", d->ident);
+		pr_notice("%s detected: disabling all passive thermal trip points\n",
+			  d->ident);
 		psv = -1;
 	}
 	return 0;
@@ -1225,7 +1224,7 @@ static int __init acpi_thermal_init(void
 	dmi_check_system(thermal_dmi_table);
 
 	if (off) {
-		pr_notice(PREFIX "thermal control disabled\n");
+		pr_notice("thermal control disabled\n");
 		return -ENODEV;
 	}
 
Index: linux-pm/Documentation/firmware-guide/acpi/debug.rst
===================================================================
--- linux-pm.orig/Documentation/firmware-guide/acpi/debug.rst
+++ linux-pm/Documentation/firmware-guide/acpi/debug.rst
@@ -57,7 +57,6 @@ shows the supported mask values, current
     ACPI_PCI_COMPONENT              0x00400000
     ACPI_CONTAINER_COMPONENT        0x01000000
     ACPI_SYSTEM_COMPONENT           0x02000000
-    ACPI_THERMAL_COMPONENT          0x04000000
     ACPI_MEMORY_DEVICE_COMPONENT    0x08000000
     ACPI_PROCESSOR_COMPONENT        0x20000000
 
Index: linux-pm/drivers/acpi/sysfs.c
===================================================================
--- linux-pm.orig/drivers/acpi/sysfs.c
+++ linux-pm/drivers/acpi/sysfs.c
@@ -57,7 +57,6 @@ static const struct acpi_dlayer acpi_deb
 	ACPI_DEBUG_INIT(ACPI_PCI_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_CONTAINER_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_SYSTEM_COMPONENT),
-	ACPI_DEBUG_INIT(ACPI_THERMAL_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_MEMORY_DEVICE_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_PROCESSOR_COMPONENT),
 };
Index: linux-pm/include/acpi/acpi_drivers.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_drivers.h
+++ linux-pm/include/acpi/acpi_drivers.h
@@ -20,7 +20,6 @@
 #define ACPI_PCI_COMPONENT		0x00400000
 #define ACPI_CONTAINER_COMPONENT	0x01000000
 #define ACPI_SYSTEM_COMPONENT		0x02000000
-#define ACPI_THERMAL_COMPONENT		0x04000000
 #define ACPI_MEMORY_DEVICE_COMPONENT	0x08000000
 #define ACPI_PROCESSOR_COMPONENT	0x20000000
 



