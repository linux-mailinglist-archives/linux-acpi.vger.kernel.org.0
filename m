Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF082FD91A
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Jan 2021 20:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbhATTGy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Jan 2021 14:06:54 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:52034 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392433AbhATTD0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jan 2021 14:03:26 -0500
Received: from 89-64-80-175.dynamic.chello.pl (89.64.80.175) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id 1695341e921a8916; Wed, 20 Jan 2021 20:02:15 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v1 2/6] ACPI: PM: Clean up printing messages
Date:   Wed, 20 Jan 2021 19:58:18 +0100
Message-ID: <1984297.f6DJSeQy12@kreacher>
In-Reply-To: <2809410.8bz27usjlQ@kreacher>
References: <2809410.8bz27usjlQ@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Replace the remaining ACPI_DEBUG_PRINT() instances in device_pm.c
with dev_dbg() invocations, drop the _COMPONENT and ACPI_MODULE_NAME()
definitions that are not used any more, and drop the no longer needed
ACPI_POWER_COMPONENT definition from the headers and documentation.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/firmware-guide/acpi/debug.rst |    1 -
 drivers/acpi/device_pm.c                    |   20 ++++++++------------
 drivers/acpi/sysfs.c                        |    1 -
 include/acpi/acpi_drivers.h                 |    1 -
 4 files changed, 8 insertions(+), 15 deletions(-)

Index: linux-pm/Documentation/firmware-guide/acpi/debug.rst
===================================================================
--- linux-pm.orig/Documentation/firmware-guide/acpi/debug.rst
+++ linux-pm/Documentation/firmware-guide/acpi/debug.rst
@@ -59,7 +59,6 @@ shows the supported mask values, current
     ACPI_SBS_COMPONENT              0x00100000
     ACPI_FAN_COMPONENT              0x00200000
     ACPI_PCI_COMPONENT              0x00400000
-    ACPI_POWER_COMPONENT            0x00800000
     ACPI_CONTAINER_COMPONENT        0x01000000
     ACPI_SYSTEM_COMPONENT           0x02000000
     ACPI_THERMAL_COMPONENT          0x04000000
Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -10,6 +10,8 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
+#define pr_fmt(fmt) "ACPI: PM: " fmt
+
 #include <linux/acpi.h>
 #include <linux/export.h>
 #include <linux/mutex.h>
@@ -20,9 +22,6 @@
 
 #include "internal.h"
 
-#define _COMPONENT	ACPI_POWER_COMPONENT
-ACPI_MODULE_NAME("device_pm");
-
 /**
  * acpi_power_state_string - String representation of ACPI device power state.
  * @state: ACPI device power state to return the string representation of.
@@ -130,8 +129,8 @@ int acpi_device_get_power(struct acpi_de
 	*state = result;
 
  out:
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device [%s] power state is %s\n",
-			  device->pnp.bus_id, acpi_power_state_string(*state)));
+	dev_dbg(&device->dev, "Device power state is %s\n",
+		acpi_power_state_string(*state));
 
 	return 0;
 }
@@ -174,9 +173,8 @@ int acpi_device_set_power(struct acpi_de
 
 	/* There is a special case for D0 addressed below. */
 	if (state > ACPI_STATE_D0 && state == device->power.state) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device [%s] already in %s\n",
-				  device->pnp.bus_id,
-				  acpi_power_state_string(state)));
+		dev_dbg(&device->dev, "Device already in %s\n",
+			acpi_power_state_string(state));
 		return 0;
 	}
 
@@ -276,10 +274,8 @@ int acpi_device_set_power(struct acpi_de
 			 acpi_power_state_string(target_state));
 	} else {
 		device->power.state = target_state;
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Device [%s] transitioned to %s\n",
-				  device->pnp.bus_id,
-				  acpi_power_state_string(target_state)));
+		dev_dbg(&device->dev, "Power state changed to %s\n",
+			acpi_power_state_string(target_state));
 	}
 
 	return result;
Index: linux-pm/drivers/acpi/sysfs.c
===================================================================
--- linux-pm.orig/drivers/acpi/sysfs.c
+++ linux-pm/drivers/acpi/sysfs.c
@@ -59,7 +59,6 @@ static const struct acpi_dlayer acpi_deb
 	ACPI_DEBUG_INIT(ACPI_SBS_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_FAN_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_PCI_COMPONENT),
-	ACPI_DEBUG_INIT(ACPI_POWER_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_CONTAINER_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_SYSTEM_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_THERMAL_COMPONENT),
Index: linux-pm/include/acpi/acpi_drivers.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_drivers.h
+++ linux-pm/include/acpi/acpi_drivers.h
@@ -22,7 +22,6 @@
 #define ACPI_SBS_COMPONENT		0x00100000
 #define ACPI_FAN_COMPONENT		0x00200000
 #define ACPI_PCI_COMPONENT		0x00400000
-#define ACPI_POWER_COMPONENT		0x00800000
 #define ACPI_CONTAINER_COMPONENT	0x01000000
 #define ACPI_SYSTEM_COMPONENT		0x02000000
 #define ACPI_THERMAL_COMPONENT		0x04000000



