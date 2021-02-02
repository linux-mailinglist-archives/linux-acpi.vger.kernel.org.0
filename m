Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926C130C990
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Feb 2021 19:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbhBBSWp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 13:22:45 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:52586 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238412AbhBBSVH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2021 13:21:07 -0500
Received: from 89-64-80-193.dynamic.chello.pl (89.64.80.193) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id c67a78b1a2e04831; Tue, 2 Feb 2021 19:19:53 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2 4/5] ACPI: video: Clean up printing messages
Date:   Tue, 02 Feb 2021 19:18:24 +0100
Message-ID: <14420740.AtFQDP28HA@kreacher>
In-Reply-To: <1991501.dpTHplkurC@kreacher>
References: <2367702.B5bJTmGzJm@kreacher> <1991501.dpTHplkurC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Replace the ACPI_DEBUG_PRINT() instances in acpi_video.c with
acpi_handle_debug() calls and the ACPI_EXCEPTION()/ACPI_ERROR()/
ACPI_WARNING() instances in there with acpi_handle_info() calls,
which among other things causes the excessive log levels of those
messages to be more adequate.

Drop the _COMPONENT and ACPI_MODULE_NAME() definitions that are not
used any more from acpi_video.c, drop the no longer needed
ACPI_VIDEO_COMPONENT definition from the headers and update the
documentation accordingly.

While at it, add a pr_fmt() definition to acpi_video.c, replace the
direct printk() invocations in there with acpi_handle_info() or
pr_info() (and reduce the excessive log level where applicable) and
drop the PREFIX sybmbol definition which is not necessary any more
from acpi_video.c.

Also make one unrelated janitorial change to fix up white space and
use ACPI_FAILURE() instead of negating ACPI_SUCCESS().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Changelog update

---
 Documentation/firmware-guide/acpi/debug.rst |    1 
 drivers/acpi/acpi_video.c                   |   95 ++++++++++++++--------------
 drivers/acpi/sysfs.c                        |    1 
 include/acpi/acpi_drivers.h                 |    1 
 4 files changed, 49 insertions(+), 49 deletions(-)

Index: linux-pm/drivers/acpi/acpi_video.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_video.c
+++ linux-pm/drivers/acpi/acpi_video.c
@@ -7,6 +7,8 @@
  *  Copyright (C) 2006 Thomas Tuttle <linux-kernel@ttuttle.net>
  */
 
+#define pr_fmt(fmt) "ACPI: video: " fmt
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -26,16 +28,11 @@
 #include <acpi/video.h>
 #include <linux/uaccess.h>
 
-#define PREFIX "ACPI: "
-
 #define ACPI_VIDEO_BUS_NAME		"Video Bus"
 #define ACPI_VIDEO_DEVICE_NAME		"Video Device"
 
 #define MAX_NAME_LEN	20
 
-#define _COMPONENT		ACPI_VIDEO_COMPONENT
-ACPI_MODULE_NAME("video");
-
 MODULE_AUTHOR("Bruno Ducrot");
 MODULE_DESCRIPTION("ACPI Video Driver");
 MODULE_LICENSE("GPL");
@@ -330,7 +327,7 @@ acpi_video_device_lcd_query_levels(acpi_
 		return status;
 	obj = (union acpi_object *)buffer.pointer;
 	if (!obj || (obj->type != ACPI_TYPE_PACKAGE)) {
-		printk(KERN_ERR PREFIX "Invalid _BCL data\n");
+		acpi_handle_info(handle, "Invalid _BCL data\n");
 		status = -EFAULT;
 		goto err;
 	}
@@ -354,7 +351,7 @@ acpi_video_device_lcd_set_level(struct a
 	status = acpi_execute_simple_method(device->dev->handle,
 					    "_BCM", level);
 	if (ACPI_FAILURE(status)) {
-		ACPI_ERROR((AE_INFO, "Evaluating _BCM failed"));
+		acpi_handle_info(device->dev->handle, "_BCM evaluation failed\n");
 		return -EIO;
 	}
 
@@ -368,7 +365,7 @@ acpi_video_device_lcd_set_level(struct a
 			return 0;
 		}
 
-	ACPI_ERROR((AE_INFO, "Current brightness invalid"));
+	acpi_handle_info(device->dev->handle, "Current brightness invalid\n");
 	return -EINVAL;
 }
 
@@ -622,9 +619,8 @@ acpi_video_device_lcd_get_level_current(
 			 * BQC returned an invalid level.
 			 * Stop using it.
 			 */
-			ACPI_WARNING((AE_INFO,
-				      "%s returned an invalid level",
-				      buf));
+			acpi_handle_info(device->dev->handle,
+					 "%s returned an invalid level", buf);
 			device->cap._BQC = device->cap._BCQ = 0;
 		} else {
 			/*
@@ -635,7 +631,8 @@ acpi_video_device_lcd_get_level_current(
 			 * ACPI video backlight still works w/ buggy _BQC.
 			 * http://bugzilla.kernel.org/show_bug.cgi?id=12233
 			 */
-			ACPI_WARNING((AE_INFO, "Evaluating %s failed", buf));
+			acpi_handle_info(device->dev->handle,
+					 "%s evaluation failed", buf);
 			device->cap._BQC = device->cap._BCQ = 0;
 		}
 	}
@@ -675,7 +672,7 @@ acpi_video_device_EDID(struct acpi_video
 	if (obj && obj->type == ACPI_TYPE_BUFFER)
 		*edid = obj;
 	else {
-		printk(KERN_ERR PREFIX "Invalid _DDC data\n");
+		acpi_handle_info(device->dev->handle, "Invalid _DDC data\n");
 		status = -EFAULT;
 		kfree(obj);
 	}
@@ -827,10 +824,9 @@ int acpi_video_get_levels(struct acpi_de
 	int result = 0;
 	u32 value;
 
-	if (!ACPI_SUCCESS(acpi_video_device_lcd_query_levels(device->handle,
-								&obj))) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Could not query available "
-						"LCD brightness level\n"));
+	if (ACPI_FAILURE(acpi_video_device_lcd_query_levels(device->handle, &obj))) {
+		acpi_handle_debug(device->handle,
+				  "Could not query available LCD brightness level\n");
 		result = -ENODEV;
 		goto out;
 	}
@@ -842,7 +838,6 @@ int acpi_video_get_levels(struct acpi_de
 
 	br = kzalloc(sizeof(*br), GFP_KERNEL);
 	if (!br) {
-		printk(KERN_ERR "can't allocate memory\n");
 		result = -ENOMEM;
 		goto out;
 	}
@@ -863,7 +858,7 @@ int acpi_video_get_levels(struct acpi_de
 	for (i = 0; i < obj->package.count; i++) {
 		o = (union acpi_object *)&obj->package.elements[i];
 		if (o->type != ACPI_TYPE_INTEGER) {
-			printk(KERN_ERR PREFIX "Invalid data\n");
+			acpi_handle_info(device->handle, "Invalid data\n");
 			continue;
 		}
 		value = (u32) o->integer.value;
@@ -900,7 +895,8 @@ int acpi_video_get_levels(struct acpi_de
 			br->levels[i] = br->levels[i - level_ac_battery];
 		count += level_ac_battery;
 	} else if (level_ac_battery > ACPI_VIDEO_FIRST_LEVEL)
-		ACPI_ERROR((AE_INFO, "Too many duplicates in _BCL package"));
+		acpi_handle_info(device->handle,
+				 "Too many duplicates in _BCL package");
 
 	/* Check if the _BCL package is in a reversed order */
 	if (max_level == br->levels[ACPI_VIDEO_FIRST_LEVEL]) {
@@ -910,8 +906,8 @@ int acpi_video_get_levels(struct acpi_de
 		     sizeof(br->levels[ACPI_VIDEO_FIRST_LEVEL]),
 		     acpi_video_cmp_level, NULL);
 	} else if (max_level != br->levels[count - 1])
-		ACPI_ERROR((AE_INFO,
-			    "Found unordered _BCL package"));
+		acpi_handle_info(device->handle,
+				 "Found unordered _BCL package");
 
 	br->count = count;
 	*dev_br = br;
@@ -989,9 +985,9 @@ set_level:
 	if (result)
 		goto out_free_levels;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "found %d brightness levels\n",
-			  br->count - ACPI_VIDEO_FIRST_LEVEL));
+	acpi_handle_debug(device->dev->handle, "found %d brightness levels\n",
+			  br->count - ACPI_VIDEO_FIRST_LEVEL);
+
 	return 0;
 
 out_free_levels:
@@ -1023,7 +1019,8 @@ static void acpi_video_device_find_cap(s
 	if (acpi_has_method(device->dev->handle, "_BQC")) {
 		device->cap._BQC = 1;
 	} else if (acpi_has_method(device->dev->handle, "_BCQ")) {
-		printk(KERN_WARNING FW_BUG "_BCQ is used instead of _BQC\n");
+		acpi_handle_info(device->dev->handle,
+				 "_BCQ is used instead of _BQC\n");
 		device->cap._BCQ = 1;
 	}
 
@@ -1083,8 +1080,7 @@ static int acpi_video_bus_check(struct a
 	/* Does this device support video switching? */
 	if (video->cap._DOS || video->cap._DOD) {
 		if (!video->cap._DOS) {
-			printk(KERN_WARNING FW_BUG
-				"ACPI(%s) defines _DOD but not _DOS\n",
+			pr_info(FW_BUG "ACPI(%s) defines _DOD but not _DOS\n",
 				acpi_device_bid(video->device));
 		}
 		video->flags.multihead = 1;
@@ -1272,7 +1268,8 @@ acpi_video_device_bind(struct acpi_video
 		ids = &video->attached_array[i];
 		if (device->device_id == (ids->value.int_val & 0xffff)) {
 			ids->bind_info = device;
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO, "device_bind %d\n", i));
+			acpi_handle_debug(video->device->handle, "%s: %d\n",
+					  __func__, i);
 		}
 	}
 }
@@ -1325,19 +1322,21 @@ static int acpi_video_device_enumerate(s
 
 	status = acpi_evaluate_object(video->device->handle, "_DOD", NULL, &buffer);
 	if (!ACPI_SUCCESS(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _DOD"));
+		acpi_handle_info(video->device->handle,
+				 "_DOD evaluation failed: %s\n",
+				 acpi_format_exception(status));
 		return status;
 	}
 
 	dod = buffer.pointer;
 	if (!dod || (dod->type != ACPI_TYPE_PACKAGE)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Invalid _DOD data"));
+		acpi_handle_info(video->device->handle, "Invalid _DOD data\n");
 		status = -EFAULT;
 		goto out;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d video heads in _DOD\n",
-			  dod->package.count));
+	acpi_handle_debug(video->device->handle, "Found %d video heads in _DOD\n",
+			  dod->package.count);
 
 	active_list = kcalloc(1 + dod->package.count,
 			      sizeof(struct acpi_video_enumerated_device),
@@ -1352,15 +1351,18 @@ static int acpi_video_device_enumerate(s
 		obj = &dod->package.elements[i];
 
 		if (obj->type != ACPI_TYPE_INTEGER) {
-			printk(KERN_ERR PREFIX
-				"Invalid _DOD data in element %d\n", i);
+			acpi_handle_info(video->device->handle,
+					 "Invalid _DOD data in element %d\n", i);
 			continue;
 		}
 
 		active_list[count].value.int_val = obj->integer.value;
 		active_list[count].bind_info = NULL;
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "dod element[%d] = %d\n", i,
-				  (int)obj->integer.value));
+
+		acpi_handle_debug(video->device->handle,
+				  "_DOD element[%d] = %d\n", i,
+				  (int)obj->integer.value);
+
 		count++;
 	}
 
@@ -1451,7 +1453,8 @@ acpi_video_switch_brightness(struct work
 
 out:
 	if (result)
-		printk(KERN_ERR PREFIX "Failed to switch the brightness\n");
+		acpi_handle_info(device->dev->handle,
+				 "Failed to switch brightness\n");
 }
 
 int acpi_video_get_edid(struct acpi_device *device, int type, int device_id,
@@ -1601,8 +1604,8 @@ static void acpi_video_bus_notify(struct
 		break;
 
 	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Unsupported event [0x%x]\n", event));
+		acpi_handle_debug(device->handle, "Unsupported event [0x%x]\n",
+				  event);
 		break;
 	}
 
@@ -1675,8 +1678,7 @@ static void acpi_video_device_notify(acp
 		keycode = KEY_DISPLAY_OFF;
 		break;
 	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Unsupported event [0x%x]\n", event));
+		acpi_handle_debug(handle, "Unsupported event [0x%x]\n", event);
 		break;
 	}
 
@@ -1812,11 +1814,12 @@ static void acpi_video_dev_register_back
 			&device->cooling_dev->device.kobj,
 			"thermal_cooling");
 	if (result)
-		printk(KERN_ERR PREFIX "Create sysfs link\n");
+		pr_info("sysfs link creation failed\n");
+
 	result = sysfs_create_link(&device->cooling_dev->device.kobj,
 			&device->dev->dev.kobj, "device");
 	if (result)
-		printk(KERN_ERR PREFIX "Create sysfs link\n");
+		pr_info("Reverse sysfs link creation failed\n");
 }
 
 static void acpi_video_run_bcl_for_osi(struct acpi_video_bus *video)
@@ -2030,7 +2033,7 @@ static int acpi_video_bus_add(struct acp
 				acpi_video_bus_match, NULL,
 				device, NULL);
 	if (status == AE_ALREADY_EXISTS) {
-		printk(KERN_WARNING FW_BUG
+		pr_info(FW_BUG
 			"Duplicate ACPI video bus devices for the"
 			" same VGA controller, please try module "
 			"parameter \"video.allow_duplicates=1\""
@@ -2073,7 +2076,7 @@ static int acpi_video_bus_add(struct acp
 	if (error)
 		goto err_put_video;
 
-	printk(KERN_INFO PREFIX "%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
+	pr_info("%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
 	       ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
 	       video->flags.multihead ? "yes" : "no",
 	       video->flags.rom ? "yes" : "no",
Index: linux-pm/Documentation/firmware-guide/acpi/debug.rst
===================================================================
--- linux-pm.orig/Documentation/firmware-guide/acpi/debug.rst
+++ linux-pm/Documentation/firmware-guide/acpi/debug.rst
@@ -59,7 +59,6 @@ shows the supported mask values, current
     ACPI_SYSTEM_COMPONENT           0x02000000
     ACPI_THERMAL_COMPONENT          0x04000000
     ACPI_MEMORY_DEVICE_COMPONENT    0x08000000
-    ACPI_VIDEO_COMPONENT            0x10000000
     ACPI_PROCESSOR_COMPONENT        0x20000000
 
 debug_level
Index: linux-pm/drivers/acpi/sysfs.c
===================================================================
--- linux-pm.orig/drivers/acpi/sysfs.c
+++ linux-pm/drivers/acpi/sysfs.c
@@ -59,7 +59,6 @@ static const struct acpi_dlayer acpi_deb
 	ACPI_DEBUG_INIT(ACPI_SYSTEM_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_THERMAL_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_MEMORY_DEVICE_COMPONENT),
-	ACPI_DEBUG_INIT(ACPI_VIDEO_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_PROCESSOR_COMPONENT),
 };
 
Index: linux-pm/include/acpi/acpi_drivers.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_drivers.h
+++ linux-pm/include/acpi/acpi_drivers.h
@@ -22,7 +22,6 @@
 #define ACPI_SYSTEM_COMPONENT		0x02000000
 #define ACPI_THERMAL_COMPONENT		0x04000000
 #define ACPI_MEMORY_DEVICE_COMPONENT	0x08000000
-#define ACPI_VIDEO_COMPONENT		0x10000000
 #define ACPI_PROCESSOR_COMPONENT	0x20000000
 
 /*



