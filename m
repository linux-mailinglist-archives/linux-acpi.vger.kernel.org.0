Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9DA2FD91D
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Jan 2021 20:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392315AbhATTHF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Jan 2021 14:07:05 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:58784 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392434AbhATTD0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jan 2021 14:03:26 -0500
Received: from 89-64-80-175.dynamic.chello.pl (89.64.80.175) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id b3ac235c7a1875e9; Wed, 20 Jan 2021 20:02:14 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v1 3/6] ACPI: bus: Clean up printing messages
Date:   Wed, 20 Jan 2021 19:59:05 +0100
Message-ID: <38373412.2kgsblc99s@kreacher>
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
in bus.c with pr_debug() and pr_info(), respectively, drop the
_COMPONENT and ACPI_MODULE_NAME() definitions that are not used any
more and replace direct printk() invocations with the matching
pr_*() calls (with a couple of exceptions where the log level is
decreased).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/bus.c |   60 ++++++++++++++++++++++-------------------------------
 1 file changed, 26 insertions(+), 34 deletions(-)

Index: linux-pm/drivers/acpi/bus.c
===================================================================
--- linux-pm.orig/drivers/acpi/bus.c
+++ linux-pm/drivers/acpi/bus.c
@@ -5,6 +5,8 @@
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
  */
 
+#define pr_fmt(fmt) "ACPI: " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
@@ -31,9 +33,6 @@
 
 #include "internal.h"
 
-#define _COMPONENT		ACPI_BUS_COMPONENT
-ACPI_MODULE_NAME("bus");
-
 struct acpi_device *acpi_root;
 struct proc_dir_entry *acpi_root_dir;
 EXPORT_SYMBOL(acpi_root_dir);
@@ -47,8 +46,7 @@ static inline int set_copy_dsdt(const st
 #else
 static int set_copy_dsdt(const struct dmi_system_id *id)
 {
-	printk(KERN_NOTICE "%s detected - "
-		"force copy of DSDT to local memory\n", id->ident);
+	pr_notice("%s detected - force copy of DSDT to local memory\n", id->ident);
 	acpi_gbl_copy_dsdt_locally = 1;
 	return 0;
 }
@@ -116,13 +114,11 @@ int acpi_bus_get_status(struct acpi_devi
 	acpi_set_device_status(device, sta);
 
 	if (device->status.functional && !device->status.present) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device [%s] status [%08x]: "
-		       "functional but not present;\n",
-			device->pnp.bus_id, (u32)sta));
+		pr_debug("Device [%s] status [%08x]: functional but not present\n",
+			 device->pnp.bus_id, (u32)sta);
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device [%s] status [%08x]\n",
-			  device->pnp.bus_id, (u32)sta));
+	pr_debug("Device [%s] status [%08x]\n", device->pnp.bus_id, (u32)sta);
 	return 0;
 }
 EXPORT_SYMBOL(acpi_bus_get_status);
@@ -915,9 +911,9 @@ static int acpi_device_probe(struct devi
 		return ret;
 
 	acpi_dev->driver = acpi_drv;
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Driver [%s] successfully bound to device [%s]\n",
-			  acpi_drv->name, acpi_dev->pnp.bus_id));
+
+	pr_debug("Driver [%s] successfully bound to device [%s]\n",
+		 acpi_drv->name, acpi_dev->pnp.bus_id);
 
 	if (acpi_drv->ops.notify) {
 		ret = acpi_device_install_notify_handler(acpi_dev);
@@ -931,8 +927,9 @@ static int acpi_device_probe(struct devi
 		}
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found driver [%s] for device [%s]\n",
-			  acpi_drv->name, acpi_dev->pnp.bus_id));
+	pr_debug("Found driver [%s] for device [%s]\n", acpi_drv->name,
+		 acpi_dev->pnp.bus_id);
+
 	get_device(dev);
 	return 0;
 }
@@ -995,15 +992,15 @@ static int __init acpi_bus_init_irq(void
 		message = "platform specific model";
 		break;
 	default:
-		printk(KERN_WARNING PREFIX "Unknown interrupt routing model\n");
+		pr_info("Unknown interrupt routing model\n");
 		return -ENODEV;
 	}
 
-	printk(KERN_INFO PREFIX "Using %s for interrupt routing\n", message);
+	pr_info("Using %s for interrupt routing\n", message);
 
 	status = acpi_execute_simple_method(NULL, "\\_PIC", acpi_irq_model);
 	if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PIC"));
+		pr_info("_PIC evaluation failed: %s\n", acpi_format_exception(status));
 		return -ENODEV;
 	}
 
@@ -1027,7 +1024,7 @@ void __init acpi_early_init(void)
 	if (acpi_disabled)
 		return;
 
-	printk(KERN_INFO PREFIX "Core revision %08x\n", ACPI_CA_VERSION);
+	pr_info("Core revision %08x\n", ACPI_CA_VERSION);
 
 	/* enable workarounds, unless strict ACPI spec. compliance */
 	if (!acpi_strict)
@@ -1048,15 +1045,13 @@ void __init acpi_early_init(void)
 
 	status = acpi_reallocate_root_table();
 	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR PREFIX
-		       "Unable to reallocate ACPI tables\n");
+		pr_err("Unable to reallocate ACPI tables\n");
 		goto error0;
 	}
 
 	status = acpi_initialize_subsystem();
 	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR PREFIX
-		       "Unable to initialize the ACPI Interpreter\n");
+		pr_err("Unable to initialize the ACPI Interpreter\n");
 		goto error0;
 	}
 
@@ -1102,7 +1097,7 @@ void __init acpi_subsystem_init(void)
 
 	status = acpi_enable_subsystem(~ACPI_NO_ACPI_ENABLE);
 	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR PREFIX "Unable to enable ACPI\n");
+		pr_err("Unable to enable ACPI\n");
 		disable_acpi();
 	} else {
 		/*
@@ -1131,8 +1126,7 @@ static int __init acpi_bus_init(void)
 
 	status = acpi_load_tables();
 	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR PREFIX
-		       "Unable to load the System Description Tables\n");
+		pr_err("Unable to load the System Description Tables\n");
 		goto error1;
 	}
 
@@ -1150,14 +1144,13 @@ static int __init acpi_bus_init(void)
 
 	status = acpi_enable_subsystem(ACPI_NO_ACPI_ENABLE);
 	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR PREFIX
-		       "Unable to start the ACPI Interpreter\n");
+		pr_err("Unable to start the ACPI Interpreter\n");
 		goto error1;
 	}
 
 	status = acpi_initialize_objects(ACPI_FULL_INITIALIZATION);
 	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR PREFIX "Unable to initialize ACPI objects\n");
+		pr_err("Unable to initialize ACPI objects\n");
 		goto error1;
 	}
 
@@ -1186,7 +1179,7 @@ static int __init acpi_bus_init(void)
 	 */
 	acpi_ec_dsdt_probe();
 
-	printk(KERN_INFO PREFIX "Interpreter enabled\n");
+	pr_info("Interpreter enabled\n");
 
 	/* Initialize sleep structures */
 	acpi_sleep_init();
@@ -1205,8 +1198,7 @@ static int __init acpi_bus_init(void)
 	    acpi_install_notify_handler(ACPI_ROOT_OBJECT, ACPI_SYSTEM_NOTIFY,
 					&acpi_bus_notify, NULL);
 	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR PREFIX
-		       "Unable to register for device notifications\n");
+		pr_err("Unable to register for system notifications\n");
 		goto error1;
 	}
 
@@ -1233,13 +1225,13 @@ static int __init acpi_init(void)
 	int result;
 
 	if (acpi_disabled) {
-		printk(KERN_INFO PREFIX "Interpreter disabled.\n");
+		pr_info("Interpreter disabled.\n");
 		return -ENODEV;
 	}
 
 	acpi_kobj = kobject_create_and_add("acpi", firmware_kobj);
 	if (!acpi_kobj) {
-		printk(KERN_WARNING "%s: kset create error\n", __func__);
+		pr_debug("%s: kset create error\n", __func__);
 		acpi_kobj = NULL;
 	}
 



