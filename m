Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD372FD906
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Jan 2021 20:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392484AbhATTD2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Jan 2021 14:03:28 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:52026 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392425AbhATTDY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jan 2021 14:03:24 -0500
Received: from 89-64-80-175.dynamic.chello.pl (89.64.80.175) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id 7fd8987296b51fa0; Wed, 20 Jan 2021 20:02:16 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v1 1/6] ACPI: power: Clean up printing messages
Date:   Wed, 20 Jan 2021 19:57:03 +0100
Message-ID: <2085818.bEvWYRANqJ@kreacher>
In-Reply-To: <2809410.8bz27usjlQ@kreacher>
References: <2809410.8bz27usjlQ@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Replace all of the ACPI_DEBUG_PRINT() instances in power.c with
acpi_handle_debug() or pr_debug(), depending on the context,
drop the _COMPONENT and ACPI_MODULE_NAME() definitions that
are not used any more, and replace the direct invocations of
printk() in there with acpi_handle_info() or pr_info(), depending
on the context.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/power.c |   44 +++++++++++++++-----------------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

Index: linux-pm/drivers/acpi/power.c
===================================================================
--- linux-pm.orig/drivers/acpi/power.c
+++ linux-pm/drivers/acpi/power.c
@@ -21,6 +21,8 @@
  * may be shared by multiple devices.
  */
 
+#define pr_fmt(fmt) "ACPI: PM: " fmt
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -32,8 +34,6 @@
 #include "sleep.h"
 #include "internal.h"
 
-#define _COMPONENT			ACPI_POWER_COMPONENT
-ACPI_MODULE_NAME("power");
 #define ACPI_POWER_CLASS		"power_resource"
 #define ACPI_POWER_DEVICE_NAME		"Power Resource"
 #define ACPI_POWER_RESOURCE_STATE_OFF	0x00
@@ -181,9 +181,6 @@ static int acpi_power_get_state(acpi_han
 {
 	acpi_status status = AE_OK;
 	unsigned long long sta = 0;
-	char node_name[5];
-	struct acpi_buffer buffer = { sizeof(node_name), node_name };
-
 
 	if (!handle || !state)
 		return -EINVAL;
@@ -195,11 +192,8 @@ static int acpi_power_get_state(acpi_han
 	*state = (sta & 0x01)?ACPI_POWER_RESOURCE_STATE_ON:
 			      ACPI_POWER_RESOURCE_STATE_OFF;
 
-	acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer);
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Resource [%s] is %s\n",
-			  node_name,
-				*state ? "on" : "off"));
+	acpi_handle_debug(handle, "Power resource is %s\n",
+			  *state ? "on" : "off");
 
 	return 0;
 }
@@ -229,8 +223,7 @@ static int acpi_power_get_list_state(str
 			break;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Resource list is %s\n",
-			  cur_state ? "on" : "off"));
+	pr_debug("Power resource list is %s\n", cur_state ? "on" : "off");
 
 	*state = cur_state;
 	return 0;
@@ -357,8 +350,7 @@ static int __acpi_power_on(struct acpi_p
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Power resource [%s] turned on\n",
-			  resource->name));
+	pr_debug("Power resource [%s] turned on\n", resource->name);
 
 	/*
 	 * If there are other dependents on this power resource we need to
@@ -383,9 +375,7 @@ static int acpi_power_on_unlocked(struct
 	int result = 0;
 
 	if (resource->ref_count++) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Power resource [%s] already on\n",
-				  resource->name));
+		pr_debug("Power resource [%s] already on\n", resource->name);
 	} else {
 		result = __acpi_power_on(resource);
 		if (result)
@@ -413,8 +403,8 @@ static int __acpi_power_off(struct acpi_
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Power resource [%s] turned off\n",
-			  resource->name));
+	pr_debug("Power resource [%s] turned off\n", resource->name);
+
 	return 0;
 }
 
@@ -423,16 +413,12 @@ static int acpi_power_off_unlocked(struc
 	int result = 0;
 
 	if (!resource->ref_count) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Power resource [%s] already off\n",
-				  resource->name));
+		pr_debug("Power resource [%s] already off\n", resource->name);
 		return 0;
 	}
 
 	if (--resource->ref_count) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Power resource [%s] still in use\n",
-				  resource->name));
+		pr_debug("Power resource [%s] still in use\n", resource->name);
 	} else {
 		result = __acpi_power_off(resource);
 		if (result)
@@ -672,7 +658,7 @@ int acpi_device_sleep_wake(struct acpi_d
 	if (ACPI_SUCCESS(status)) {
 		return 0;
 	} else if (status != AE_NOT_FOUND) {
-		printk(KERN_ERR PREFIX "_DSW execution failed\n");
+		acpi_handle_info(dev->handle, "_DSW execution failed\n");
 		dev->wakeup.flags.valid = 0;
 		return -ENODEV;
 	}
@@ -680,7 +666,7 @@ int acpi_device_sleep_wake(struct acpi_d
 	/* Execute _PSW */
 	status = acpi_execute_simple_method(dev->handle, "_PSW", enable);
 	if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
-		printk(KERN_ERR PREFIX "_PSW execution failed\n");
+		acpi_handle_info(dev->handle, "_PSW execution failed\n");
 		dev->wakeup.flags.valid = 0;
 		return -ENODEV;
 	}
@@ -960,8 +946,8 @@ int acpi_add_power_resource(acpi_handle
 	if (result)
 		goto err;
 
-	printk(KERN_INFO PREFIX "%s [%s] (%s)\n", acpi_device_name(device),
-	       acpi_device_bid(device), state ? "on" : "off");
+	pr_info("%s [%s] (%s)\n", acpi_device_name(device),
+		acpi_device_bid(device), state ? "on" : "off");
 
 	device->flags.match_driver = true;
 	result = acpi_device_add(device, acpi_release_power_resource);



