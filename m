Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496482CFC98
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Dec 2020 19:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgLEQrH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 5 Dec 2020 11:47:07 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:48130 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgLEQpq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Dec 2020 11:45:46 -0500
Received: from 89-77-60-66.dynamic.chello.pl (89.77.60.66) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.530)
 id 54f9f0d8f09ca8e0; Sat, 5 Dec 2020 16:44:30 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 0/7] ACPI: scan: Split root scanning into 2 steps
Date:   Sat, 05 Dec 2020 16:44:29 +0100
Message-ID: <10746938.kh9KKrt31x@kreacher>
In-Reply-To: <CAJZ5v0iP4a_6sSjO2sAgQUZ7T9BWvaV+s_JvYnD4NwdcCY9DMw@mail.gmail.com>
References: <20201121203040.146252-1-hdegoede@redhat.com> <00a4b9c2-aca2-4842-3006-720515f262db@redhat.com> <CAJZ5v0iP4a_6sSjO2sAgQUZ7T9BWvaV+s_JvYnD4NwdcCY9DMw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thursday, December 3, 2020 3:27:27 PM CET Rafael J. Wysocki wrote:
> On Thu, Dec 3, 2020 at 10:53 AM Hans de Goede <hdegoede@redhat.com> wrote:

[cut]

> > That indeed is not necessary if you take the entire set and always enable the
> > new behavior instead of using the module option. I guess we could go that route
> > for 5.12, and get it into next as soon as 5.11-rc1 is available for maximum
> > testing.

I'd prefer to do the whole thing in 5.11-rc and possibly revert something if it
causes problems to occur.

> > Do you want me to do a new version of the series which drops the acpi_defer_add_hids[]
> > thing and the module option and simply always uses the new behavior?
> 
> No, something else.  Stay tuned.

The patch below illustrates what I'd like to do.  It at least doesn't kill my
test-bed system, but also it doesn't cause the enumeration ordering to change
on that system.

It really is three patches in one and (again) I borrowed some code from your
patches in the $subject series.  [It is on top of the "ACPI: scan: Add PNP0D80
to the _DEP exceptions list" patch I've just posted.]


Please let me know what you think.

---
 drivers/acpi/scan.c |  141 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 120 insertions(+), 21 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -1646,17 +1646,77 @@ void acpi_device_add_finalize(struct acp
 	kobject_uevent(&device->dev.kobj, KOBJ_ADD);
 }
 
-static int acpi_add_single_object(struct acpi_device **child,
-				  acpi_handle handle, int type,
-				  unsigned long long sta)
+/*
+ * List of IDs for which we defer enumeration them to the second pass, because
+ * some of their methods used during addition depend on OpRegions registered by
+ * the drivers for other ACPI devices.
+ */
+static const char * const acpi_defer_enumeration_ids[] = {
+	"BCM2E5B", /* Acer SW3-016 bluetooth HID vs GPIO OpRegs */
+	NULL
+};
+
+static bool acpi_should_defer_enumeration(acpi_handle handle,
+					  struct acpi_device_info *info)
+{
+	struct acpi_handle_list dep_devices;
+	acpi_status status;
+	int i;
+
+	if (acpi_info_matches_ids(info, acpi_defer_enumeration_ids))
+		return true;
+
+	/*
+	 * We check for _HID here to avoid deferring the enumeration of:
+	 * 1. PCI devices
+	 * 2. ACPI nodes describing USB ports
+	 * However, checking for _HID catches more then just these cases ...
+	 */
+	if (!(info->valid & ACPI_VALID_HID))
+		return false;
+
+	status = acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices);
+	if (ACPI_FAILURE(status))
+		return false;
+
+	for (i = 0; i < dep_devices.count; i++) {
+		struct acpi_device_info *dep_info;
+		bool ignore;
+
+		status = acpi_get_object_info(dep_devices.handles[i], &dep_info);
+		if (ACPI_FAILURE(status))
+			continue;
+
+		ignore = acpi_info_matches_ids(dep_info, acpi_ignore_dep_ids);
+		kfree(dep_info);
+
+		if (ignore)
+			continue;
+
+		return true;
+	}
+
+	return false;
+}
+
+static int __acpi_add_single_object(struct acpi_device **child,
+				    acpi_handle handle, int type,
+				    unsigned long long sta, bool check_dep)
 {
 	int result;
 	struct acpi_device *device;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_device_info *info = NULL;
 
-	if (handle != ACPI_ROOT_OBJECT && type == ACPI_BUS_TYPE_DEVICE)
+	if (handle != ACPI_ROOT_OBJECT && type == ACPI_BUS_TYPE_DEVICE) {
 		acpi_get_object_info(handle, &info);
+		if (check_dep && info &&
+		    acpi_should_defer_enumeration(handle, info)) {
+			kfree(info);
+			acpi_handle_info(handle, "Missing dependencies\n");
+			return -EAGAIN;
+		}
+	}
 
 	device = kzalloc(sizeof(struct acpi_device), GFP_KERNEL);
 	if (!device) {
@@ -1696,6 +1756,13 @@ static int acpi_add_single_object(struct
 	return 0;
 }
 
+static int acpi_add_single_object(struct acpi_device **child,
+				  acpi_handle handle, int type,
+				  unsigned long long sta)
+{
+	return __acpi_add_single_object(child, handle, type, sta, false);
+}
+
 static acpi_status acpi_get_resource_memory(struct acpi_resource *ares,
 					    void *context)
 {
@@ -1892,8 +1959,8 @@ static void acpi_device_dep_initialize(s
 	}
 }
 
-static acpi_status acpi_bus_check_add(acpi_handle handle, u32 lvl_not_used,
-				      void *not_used, void **return_value)
+static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
+				      struct acpi_device **adev_p)
 {
 	struct acpi_device *device = NULL;
 	int type;
@@ -1913,7 +1980,7 @@ static acpi_status acpi_bus_check_add(ac
 		return AE_OK;
 	}
 
-	acpi_add_single_object(&device, handle, type, sta);
+	__acpi_add_single_object(&device, handle, type, sta, check_dep);
 	if (!device)
 		return AE_CTRL_DEPTH;
 
@@ -1921,12 +1988,24 @@ static acpi_status acpi_bus_check_add(ac
 	acpi_device_dep_initialize(device);
 
  out:
-	if (!*return_value)
-		*return_value = device;
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
@@ -1994,12 +2073,16 @@ static int acpi_scan_attach_handler(stru
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
 
@@ -2046,9 +2129,9 @@ static void acpi_bus_attach(struct acpi_
 
  ok:
 	list_for_each_entry(child, &device->children, node)
-		acpi_bus_attach(child);
+		acpi_bus_attach(child, first_pass);
 
-	if (device->handler && device->handler->hotplug.notify_online)
+	if (!skip && device->handler && device->handler->hotplug.notify_online)
 		device->handler->hotplug.notify_online(device);
 }
 
@@ -2066,7 +2149,8 @@ void acpi_walk_dep_device_list(acpi_hand
 
 			adev->dep_unmet--;
 			if (!adev->dep_unmet)
-				acpi_bus_attach(adev);
+				acpi_bus_attach(adev, true);
+
 			list_del(&dep->node);
 			kfree(dep);
 		}
@@ -2091,17 +2175,32 @@ EXPORT_SYMBOL_GPL(acpi_walk_dep_device_l
  */
 int acpi_bus_scan(acpi_handle handle)
 {
-	void *device = NULL;
+	struct acpi_device *device = NULL;
+
+	/* Pass 1: Avoid enumerating devices with missing dependencies. */
 
-	if (ACPI_SUCCESS(acpi_bus_check_add(handle, 0, NULL, &device)))
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
 



