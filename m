Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4478C2DA1A7
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Dec 2020 21:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503394AbgLNUeo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Dec 2020 15:34:44 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:58924 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503081AbgLNUeh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Dec 2020 15:34:37 -0500
Received: from 89-77-60-66.dynamic.chello.pl (89.77.60.66) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.530)
 id 7070c570a071b69d; Mon, 14 Dec 2020 21:33:41 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Hans De Goede <hdegoede@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [RFT][PATCH v1 1/3] ACPI: scan: Evaluate _DEP before adding the device
Date:   Mon, 14 Dec 2020 21:25:23 +0100
Message-ID: <1841307.UyYFXhZDfv@kreacher>
In-Reply-To: <1646930.v2jOOB1UEN@kreacher>
References: <1646930.v2jOOB1UEN@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Evaluate _DEP before calling acpi_add_single_object() from
acpi_bus_check_add() and do that only for ACPI_BUS_TYPE_DEVICE
objects.

While at it, rename acpi_device_dep_initialize() to
acpi_scan_check_dep(), fix up a memory allocation statement in
that function, consistently treat memory allocation failures in
there as intermittent errors and make some related janitorial
changes in it.

This change will help to avoid calling acpi_add_single_object() if
there are unmet _DEP dependencies in the future, as that may cause
some control methods, potentially depending on the presence of
operation regions supplied by other devices, to be evaluated
prematurely.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |   44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -1842,32 +1842,30 @@ static void acpi_scan_init_hotplug(struc
 	}
 }
 
-static void acpi_device_dep_initialize(struct acpi_device *adev)
+static u32 acpi_scan_check_dep(acpi_handle handle)
 {
-	struct acpi_dep_data *dep;
 	struct acpi_handle_list dep_devices;
 	acpi_status status;
+	u32 count;
 	int i;
 
-	adev->dep_unmet = 0;
+	if (!acpi_has_method(handle, "_DEP"))
+		return 0;
 
-	if (!acpi_has_method(adev->handle, "_DEP"))
-		return;
-
-	status = acpi_evaluate_reference(adev->handle, "_DEP", NULL,
-					&dep_devices);
+	status = acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices);
 	if (ACPI_FAILURE(status)) {
-		dev_dbg(&adev->dev, "Failed to evaluate _DEP.\n");
-		return;
+		acpi_handle_debug(handle, "Failed to evaluate _DEP.\n");
+		return 0;
 	}
 
-	for (i = 0; i < dep_devices.count; i++) {
+	for (count = 0, i = 0; i < dep_devices.count; i++) {
 		struct acpi_device_info *info;
-		int skip;
+		struct acpi_dep_data *dep;
+		bool skip;
 
 		status = acpi_get_object_info(dep_devices.handles[i], &info);
 		if (ACPI_FAILURE(status)) {
-			dev_dbg(&adev->dev, "Error reading _DEP device info\n");
+			acpi_handle_debug(handle, "Error reading _DEP device info\n");
 			continue;
 		}
 
@@ -1877,26 +1875,30 @@ static void acpi_device_dep_initialize(s
 		if (skip)
 			continue;
 
-		dep = kzalloc(sizeof(struct acpi_dep_data), GFP_KERNEL);
+		dep = kzalloc(sizeof(*dep), GFP_KERNEL);
 		if (!dep)
-			return;
+			continue;
+
+		count++;
 
 		dep->supplier = dep_devices.handles[i];
-		dep->consumer  = adev->handle;
-		adev->dep_unmet++;
+		dep->consumer = handle;
 
 		mutex_lock(&acpi_dep_list_lock);
 		list_add_tail(&dep->node , &acpi_dep_list);
 		mutex_unlock(&acpi_dep_list_lock);
 	}
+
+	return count;
 }
 
 static acpi_status acpi_bus_check_add(acpi_handle handle, u32 lvl_not_used,
 				      void *not_used, void **return_value)
 {
 	struct acpi_device *device = NULL;
-	int type;
+	u32 dep_count = 0;
 	unsigned long long sta;
+	int type;
 	int result;
 
 	acpi_bus_get_device(handle, &device);
@@ -1912,12 +1914,16 @@ static acpi_status acpi_bus_check_add(ac
 		return AE_OK;
 	}
 
+	if (type == ACPI_BUS_TYPE_DEVICE)
+		dep_count = acpi_scan_check_dep(handle);
+
 	acpi_add_single_object(&device, handle, type, sta);
 	if (!device)
 		return AE_CTRL_DEPTH;
 
+	device->dep_unmet = dep_count;
+
 	acpi_scan_init_hotplug(device);
-	acpi_device_dep_initialize(device);
 
  out:
 	if (!*return_value)



