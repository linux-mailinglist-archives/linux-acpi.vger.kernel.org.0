Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0115F2FD907
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Jan 2021 20:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392490AbhATTDb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Jan 2021 14:03:31 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:45850 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392413AbhATTDX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jan 2021 14:03:23 -0500
Received: from 89-64-80-175.dynamic.chello.pl (89.64.80.175) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id 3b1bfd3e35caa5f7; Wed, 20 Jan 2021 20:02:13 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v1 4/6] ACPI: scan: Clean up printing messages
Date:   Wed, 20 Jan 2021 19:59:51 +0100
Message-ID: <32235625.20C0QTXHV0@kreacher>
In-Reply-To: <2809410.8bz27usjlQ@kreacher>
References: <2809410.8bz27usjlQ@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Replace all of the ACPI_DEBUG_PRINT() and ACPI_EXCEPTION() instances
in scan.c with acpi_handle_debug() and acpi_handle_info(), respectively,
and drop the _COMPONENT and ACPI_MODULE_NAME() definitions that
are not used any more.

While at it, drop the redundant "Memory allocation error" message
from acpi_add_single_object() and clean up the list of local variables
in that function.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |   29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -19,8 +19,6 @@
 
 #include "internal.h"
 
-#define _COMPONENT		ACPI_BUS_COMPONENT
-ACPI_MODULE_NAME("scan");
 extern struct acpi_device *acpi_root;
 
 #define ACPI_BUS_CLASS			"system_bus"
@@ -265,8 +263,7 @@ static int acpi_scan_hot_remove(struct a
 			return error;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-		"Hot-removing device %s...\n", dev_name(&device->dev)));
+	acpi_handle_debug(handle, "Ejecting\n");
 
 	acpi_bus_trim(device);
 
@@ -827,7 +824,8 @@ static int acpi_bus_extract_wakeup_devic
 	/* _PRW */
 	status = acpi_evaluate_object(handle, "_PRW", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PRW"));
+		acpi_handle_info(handle, "_PRW evaluation failed: %s\n",
+				 acpi_format_exception(status));
 		return err;
 	}
 
@@ -932,7 +930,7 @@ static void acpi_bus_get_wakeup_device_f
 
 	err = acpi_bus_extract_wakeup_device_power_package(device);
 	if (err) {
-		dev_err(&device->dev, "_PRW evaluation error: %d\n", err);
+		dev_err(&device->dev, "Unable to extract wakeup power resources");
 		return;
 	}
 
@@ -1168,8 +1166,7 @@ acpi_backlight_cap_match(acpi_handle han
 
 	if (acpi_has_method(handle, "_BCM") &&
 	    acpi_has_method(handle, "_BCL")) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found generic backlight "
-				  "support\n"));
+		acpi_handle_debug(handle, "Found generic backlight support\n");
 		*cap |= ACPI_VIDEO_BACKLIGHT;
 		/* We have backlight support, no need to scan further */
 		return AE_CTRL_TERMINATE;
@@ -1660,17 +1657,15 @@ static int acpi_add_single_object(struct
 				  acpi_handle handle, int type,
 				  unsigned long long sta)
 {
-	int result;
-	struct acpi_device *device;
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_device_info *info = NULL;
+	struct acpi_device *device;
+	int result;
 
 	if (handle != ACPI_ROOT_OBJECT && type == ACPI_BUS_TYPE_DEVICE)
 		acpi_get_object_info(handle, &info);
 
 	device = kzalloc(sizeof(struct acpi_device), GFP_KERNEL);
 	if (!device) {
-		printk(KERN_ERR PREFIX "Memory allocation error\n");
 		kfree(info);
 		return -ENOMEM;
 	}
@@ -1697,11 +1692,11 @@ static int acpi_add_single_object(struct
 
 	acpi_power_add_remove_device(device, true);
 	acpi_device_add_finalize(device);
-	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Added %s [%s] parent %s\n",
-		dev_name(&device->dev), (char *) buffer.pointer,
-		device->parent ? dev_name(&device->parent->dev) : "(null)"));
-	kfree(buffer.pointer);
+
+	acpi_handle_debug(handle, "Added as %s, parent %s\n",
+			  dev_name(&device->dev), device->parent ?
+				dev_name(&device->parent->dev) : "(null)");
+
 	*child = device;
 	return 0;
 }



