Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FE32DA1AD
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Dec 2020 21:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502881AbgLNUf7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Dec 2020 15:35:59 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:57844 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503355AbgLNUeh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Dec 2020 15:34:37 -0500
Received: from 89-77-60-66.dynamic.chello.pl (89.77.60.66) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.530)
 id 4438d705b772e000; Mon, 14 Dec 2020 21:33:40 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Hans De Goede <hdegoede@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [RFT][PATCH v1 2/3] ACPI: scan: Defer enumeration of devices with _DEP lists
Date:   Mon, 14 Dec 2020 21:27:27 +0100
Message-ID: <2066680.U3vERgk28e@kreacher>
In-Reply-To: <1646930.v2jOOB1UEN@kreacher>
References: <1646930.v2jOOB1UEN@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In some cases ACPI control methods used during device enumeration
(such as _HID or _STA) may rely on Operation Region handlers
supplied by the drivers of other devices [1]:

 An example of this is the Acer Switch 10E SW3-016 model. The _HID
 method of the ACPI node for the UART attached Bluetooth, reads
 GPIOs to detect the installed wifi chip and update the _HID for the
 Bluetooth's ACPI node accordingly. The current ACPI scan code calls
 _HID before the GPIO controller's OpRegions are available, leading
 to the wrong _HID being used and Bluetooth not working.

In principle, in those cases there should be a _DEP control method
under the device object with OpRegion enumeration dependencies, so
deferring the enumeration of devices with _DEP returning a non-empty
list of suppliers of OpRegions depended on by the given device
(modulo some known exceptions that don't really supply any OpRegions
and are listed by _DEP for other reasons irrelevant for Linux) should
at least address the first-order dependencies by allowing the OpRegion
suppliers to be enumerated before their consumers.

Implement the above idea by modifying acpi_bus_scan() to enumerate
devices in the given scope of the ACPI namespace in two passes,
where the first pass covers the devices without "significant" lists
of dependencies coming from _DEP only and the second pass covers
all of the devices that were not enumerated in the first pass.

Take _DEP into account only for device objects with _HID, mostly in
order to avoid deferring the creation of ACPI device objects that
represent PCI devices and must be present during the enumeration
of the PCI bus (which takes place during the processing of the ACPI
device object that represents the host bridge), so that they can
be properly associated with the corresponding PCI devices.

Link: https://lore.kernel.org/linux-acpi/20201121203040.146252-1-hdegoede@redhat.com/ # [1]
Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |  103 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 78 insertions(+), 25 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -1635,8 +1635,6 @@ void acpi_init_device_object(struct acpi
 	device_initialize(&device->dev);
 	dev_set_uevent_suppress(&device->dev, true);
 	acpi_init_coherency(device);
-	/* Assume there are unmet deps until acpi_device_dep_initialize() runs */
-	device->dep_unmet = 1;
 }
 
 void acpi_device_add_finalize(struct acpi_device *device)
@@ -1849,7 +1847,13 @@ static u32 acpi_scan_check_dep(acpi_hand
 	u32 count;
 	int i;
 
-	if (!acpi_has_method(handle, "_DEP"))
+	/*
+	 * Check for _HID here to avoid deferring the enumeration of:
+	 * 1. PCI devices.
+	 * 2. ACPI nodes describing USB ports.
+	 * Still, checking for _HID catches more then just these cases ...
+	 */
+	if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID"))
 		return 0;
 
 	status = acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices);
@@ -1892,11 +1896,24 @@ static u32 acpi_scan_check_dep(acpi_hand
 	return count;
 }
 
-static acpi_status acpi_bus_check_add(acpi_handle handle, u32 lvl_not_used,
-				      void *not_used, void **return_value)
+static void acpi_scan_dep_init(struct acpi_device *adev)
+{
+	struct acpi_dep_data *dep;
+
+	mutex_lock(&acpi_dep_list_lock);
+
+	list_for_each_entry(dep, &acpi_dep_list, node) {
+		if (dep->consumer == adev->handle)
+			adev->dep_unmet++;
+	}
+
+	mutex_unlock(&acpi_dep_list_lock);
+}
+
+static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
+				      struct acpi_device **adev_p)
 {
 	struct acpi_device *device = NULL;
-	u32 dep_count = 0;
 	unsigned long long sta;
 	int type;
 	int result;
@@ -1914,24 +1931,40 @@ static acpi_status acpi_bus_check_add(ac
 		return AE_OK;
 	}
 
-	if (type == ACPI_BUS_TYPE_DEVICE)
-		dep_count = acpi_scan_check_dep(handle);
+	if (type == ACPI_BUS_TYPE_DEVICE && check_dep) {
+		u32 count = acpi_scan_check_dep(handle);
+		/* Bail out if the number of recorded dependencies is not 0. */
+		if (count > 0)
+			return AE_CTRL_DEPTH;
+	}
 
 	acpi_add_single_object(&device, handle, type, sta);
 	if (!device)
 		return AE_CTRL_DEPTH;
 
-	device->dep_unmet = dep_count;
-
 	acpi_scan_init_hotplug(device);
+	if (!check_dep)
+		acpi_scan_dep_init(device);
 
- out:
-	if (!*return_value)
-		*return_value = device;
+out:
+	if (!*adev_p)
+		*adev_p = device;
 
 	return AE_OK;
 }
 
+static acpi_status acpi_bus_check_add_1(acpi_handle handle, u32 lvl_not_used,
+					void *not_used, void **ret_p)
+{
+	return acpi_bus_check_add(handle, true, (struct acpi_device **)ret_p);
+}
+
+static acpi_status acpi_bus_check_add_2(acpi_handle handle, u32 lvl_not_used,
+					void *not_used, void **ret_p)
+{
+	return acpi_bus_check_add(handle, false, (struct acpi_device **)ret_p);
+}
+
 static void acpi_default_enumeration(struct acpi_device *device)
 {
 	/*
@@ -1999,12 +2032,16 @@ static int acpi_scan_attach_handler(stru
 	return ret;
 }
 
-static void acpi_bus_attach(struct acpi_device *device)
+static void acpi_bus_attach(struct acpi_device *device, bool first_pass)
 {
 	struct acpi_device *child;
+	bool skip = !first_pass && device->flags.visited;
 	acpi_handle ejd;
 	int ret;
 
+	if (skip)
+		goto ok;
+
 	if (ACPI_SUCCESS(acpi_bus_get_ejd(device->handle, &ejd)))
 		register_dock_dependent_device(device, ejd);
 
@@ -2051,9 +2088,9 @@ static void acpi_bus_attach(struct acpi_
 
  ok:
 	list_for_each_entry(child, &device->children, node)
-		acpi_bus_attach(child);
+		acpi_bus_attach(child, first_pass);
 
-	if (device->handler && device->handler->hotplug.notify_online)
+	if (!skip && device->handler && device->handler->hotplug.notify_online)
 		device->handler->hotplug.notify_online(device);
 }
 
@@ -2071,7 +2108,8 @@ void acpi_walk_dep_device_list(acpi_hand
 
 			adev->dep_unmet--;
 			if (!adev->dep_unmet)
-				acpi_bus_attach(adev);
+				acpi_bus_attach(adev, true);
+
 			list_del(&dep->node);
 			kfree(dep);
 		}
@@ -2096,17 +2134,32 @@ EXPORT_SYMBOL_GPL(acpi_walk_dep_device_l
  */
 int acpi_bus_scan(acpi_handle handle)
 {
-	void *device = NULL;
+	struct acpi_device *device = NULL;
 
-	if (ACPI_SUCCESS(acpi_bus_check_add(handle, 0, NULL, &device)))
+	/* Pass 1: Avoid enumerating devices with missing dependencies. */
+
+	if (ACPI_SUCCESS(acpi_bus_check_add(handle, true, &device)))
 		acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
-				    acpi_bus_check_add, NULL, NULL, &device);
+				    acpi_bus_check_add_1, NULL, NULL,
+				    (void **)&device);
 
-	if (device) {
-		acpi_bus_attach(device);
-		return 0;
-	}
-	return -ENODEV;
+	if (!device)
+		return -ENODEV;
+
+	acpi_bus_attach(device, true);
+
+	/* Pass 2: Enumerate all of the remaining devices. */
+
+	device = NULL;
+
+	if (ACPI_SUCCESS(acpi_bus_check_add(handle, false, &device)))
+		acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
+				    acpi_bus_check_add_2, NULL, NULL,
+				    (void **)&device);
+
+	acpi_bus_attach(device, false);
+
+	return 0;
 }
 EXPORT_SYMBOL(acpi_bus_scan);
 



