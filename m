Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477BE6CF978
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Mar 2023 05:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjC3DNp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Mar 2023 23:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjC3DNo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2023 23:13:44 -0400
X-Greylist: delayed 515 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Mar 2023 20:13:42 PDT
Received: from endrift.com (endrift.com [173.255.198.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEB74EFC
        for <linux-acpi@vger.kernel.org>; Wed, 29 Mar 2023 20:13:42 -0700 (PDT)
Received: from nebulosa.vulpes.eutheria.net (unknown [50.47.218.115])
        by endrift.com (Postfix) with ESMTPSA id 56437A25D;
        Wed, 29 Mar 2023 20:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=endrift.com; s=2020;
        t=1680145506; bh=FPdHLLjyNhh/mBEn0I+jL04mN+2ttyjRzZShvUVXw8E=;
        h=From:To:Cc:Subject:Date:From;
        b=H+4N445nX2dxcu8XrlEtIrp2yd6j1AUN6cNodZfdpEsAgNxhmWUB1KnJ+LWIlIfjB
         YKE7TRxd4sFfzVhJqVJrlJ911wxZMdsFh4+xB1oHEDjNPwuOQomBcghIvfY5Ap492p
         ZiPfdb1eNurFJ8HgTD+7FGnraUytQ1AXJBOl2gXBqLmJ5viZNMdqnkGO8CqqPRs691
         ajFoK7dKZvcQyOENWCEv6rYFF0xUyw4MvclA0oMO9/BrhKxQBk1bctrswpq9hEST3P
         FzbgF4yfK70WHetJ9sGfezd25ePcStnV+rkFNqO1l2GnpO8ZIJtWjQPBKVLLMyKzdR
         iTaMb++uUfT1Q==
From:   Vicki Pfau <vi@endrift.com>
To:     linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>
Cc:     Vicki Pfau <vi@endrift.com>
Subject: [PATCH] ACPI: utils: Make acpi_handle_list dynamically allocated
Date:   Wed, 29 Mar 2023 20:04:46 -0700
Message-Id: <20230330030446.2469338-1-vi@endrift.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This fixes a long-standing "TBD" comment in the ACPI headers regarding making
the acpi_handle_list struct's size dynamic. The number 10, which along with the
comment dates back to 2.4.23, seems like it may have been arbitrarily chosen,
and isn't sufficient in all cases. This patch finally makes the size dynamic
and updates its users to handle the modified API.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/acpi/acpi_lpss.c                      |  9 ++--
 drivers/acpi/scan.c                           |  9 ++--
 drivers/acpi/thermal.c                        | 54 +++++++++++--------
 drivers/acpi/utils.c                          | 14 ++---
 .../platform/surface/surface_acpi_notify.c    |  9 ++--
 include/acpi/acpi_bus.h                       | 18 +++++--
 6 files changed, 71 insertions(+), 42 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index f08ffa75f4a7..5aebd338943f 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -561,7 +561,7 @@ static struct device *acpi_lpss_find_device(const char *hid, const char *uid)
 
 static bool acpi_lpss_dep(struct acpi_device *adev, acpi_handle handle)
 {
-	struct acpi_handle_list dep_devices;
+	struct acpi_handle_list *dep_devices;
 	acpi_status status;
 	int i;
 
@@ -575,11 +575,14 @@ static bool acpi_lpss_dep(struct acpi_device *adev, acpi_handle handle)
 		return false;
 	}
 
-	for (i = 0; i < dep_devices.count; i++) {
-		if (dep_devices.handles[i] == handle)
+	for (i = 0; i < dep_devices->count; i++) {
+		if (dep_devices->handles[i] == handle) {
+			kfree(dep_devices);
 			return true;
+		}
 	}
 
+	kfree(dep_devices);
 	return false;
 }
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 0c6f06abe3f4..167423b68f83 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1972,7 +1972,7 @@ static void acpi_scan_init_hotplug(struct acpi_device *adev)
 
 static u32 acpi_scan_check_dep(acpi_handle handle, bool check_dep)
 {
-	struct acpi_handle_list dep_devices;
+	struct acpi_handle_list *dep_devices;
 	acpi_status status;
 	u32 count;
 	int i;
@@ -1993,12 +1993,12 @@ static u32 acpi_scan_check_dep(acpi_handle handle, bool check_dep)
 		return 0;
 	}
 
-	for (count = 0, i = 0; i < dep_devices.count; i++) {
+	for (count = 0, i = 0; i < dep_devices->count; i++) {
 		struct acpi_device_info *info;
 		struct acpi_dep_data *dep;
 		bool skip, honor_dep;
 
-		status = acpi_get_object_info(dep_devices.handles[i], &info);
+		status = acpi_get_object_info(dep_devices->handles[i], &info);
 		if (ACPI_FAILURE(status)) {
 			acpi_handle_debug(handle, "Error reading _DEP device info\n");
 			continue;
@@ -2017,7 +2017,7 @@ static u32 acpi_scan_check_dep(acpi_handle handle, bool check_dep)
 
 		count++;
 
-		dep->supplier = dep_devices.handles[i];
+		dep->supplier = dep_devices->handles[i];
 		dep->consumer = handle;
 		dep->honor_dep = honor_dep;
 
@@ -2026,6 +2026,7 @@ static u32 acpi_scan_check_dep(acpi_handle handle, bool check_dep)
 		mutex_unlock(&acpi_dep_list_lock);
 	}
 
+	kfree(dep_devices);
 	return count;
 }
 
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 0b4b844f9d4c..132b206cd4e6 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -135,13 +135,13 @@ struct acpi_thermal_passive {
 	unsigned long tc1;
 	unsigned long tc2;
 	unsigned long tsp;
-	struct acpi_handle_list devices;
+	struct acpi_handle_list *devices;
 };
 
 struct acpi_thermal_active {
 	struct acpi_thermal_state_flags flags;
 	unsigned long temperature;
-	struct acpi_handle_list devices;
+	struct acpi_handle_list *devices;
 };
 
 struct acpi_thermal_trips {
@@ -167,7 +167,7 @@ struct acpi_thermal {
 	struct acpi_thermal_flags flags;
 	struct acpi_thermal_state state;
 	struct acpi_thermal_trips trips;
-	struct acpi_handle_list devices;
+	struct acpi_handle_list *devices;
 	struct thermal_zone_device *thermal_zone;
 	int kelvin_offset;	/* in millidegrees */
 	struct work_struct thermal_check_work;
@@ -264,7 +264,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 {
 	acpi_status status;
 	unsigned long long tmp;
-	struct acpi_handle_list devices;
+	struct acpi_handle_list *devices;
 	int valid = 0;
 	int i;
 
@@ -368,7 +368,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 		}
 	}
 	if ((flag & ACPI_TRIPS_DEVICES) && tz->trips.passive.flags.valid) {
-		memset(&devices, 0, sizeof(struct acpi_handle_list));
+		devices = NULL;
 		status = acpi_evaluate_reference(tz->device->handle, "_PSL",
 						 NULL, &devices);
 		if (ACPI_FAILURE(status)) {
@@ -379,11 +379,12 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 			tz->trips.passive.flags.valid = 1;
 		}
 
-		if (memcmp(&tz->trips.passive.devices, &devices,
-			   sizeof(struct acpi_handle_list))) {
-			memcpy(&tz->trips.passive.devices, &devices,
-			       sizeof(struct acpi_handle_list));
+		if (!acpi_handle_list_equal(tz->trips.passive.devices, devices)) {
+			kfree(tz->trips.passive.devices);
+			tz->trips.passive.devices = devices;
 			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
+		} else if (devices) {
+			kfree(devices);
 		}
 	}
 	if ((flag & ACPI_TRIPS_PASSIVE) || (flag & ACPI_TRIPS_DEVICES)) {
@@ -433,7 +434,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 
 		name[2] = 'L';
 		if ((flag & ACPI_TRIPS_DEVICES) && tz->trips.active[i].flags.valid) {
-			memset(&devices, 0, sizeof(struct acpi_handle_list));
+			devices = NULL;
 			status = acpi_evaluate_reference(tz->device->handle,
 							 name, NULL, &devices);
 			if (ACPI_FAILURE(status)) {
@@ -444,11 +445,12 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 				tz->trips.active[i].flags.valid = 1;
 			}
 
-			if (memcmp(&tz->trips.active[i].devices, &devices,
-				   sizeof(struct acpi_handle_list))) {
-				memcpy(&tz->trips.active[i].devices, &devices,
-				       sizeof(struct acpi_handle_list));
+			if (!acpi_handle_list_equal(tz->trips.active[i].devices, devices)) {
+				kfree(tz->trips.active[i].devices);
+				tz->trips.active[i].devices = devices;
 				ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
+			} else if (devices) {
+				kfree(devices);
 			}
 		}
 		if ((flag & ACPI_TRIPS_ACTIVE) || (flag & ACPI_TRIPS_DEVICES))
@@ -460,13 +462,16 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 	}
 
 	if (flag & ACPI_TRIPS_DEVICES) {
-		memset(&devices, 0, sizeof(devices));
+		devices = NULL;
 		status = acpi_evaluate_reference(tz->device->handle, "_TZD",
 						 NULL, &devices);
 		if (ACPI_SUCCESS(status) &&
-		    memcmp(&tz->devices, &devices, sizeof(devices))) {
+		    !acpi_handle_list_equal(tz->devices, devices)) {
+			kfree(tz->devices);
 			tz->devices = devices;
 			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
+		} else if (devices) {
+			kfree(devices);
 		}
 	}
 
@@ -709,8 +714,8 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
 
 	if (tz->trips.passive.flags.valid) {
 		trip++;
-		for (i = 0; i < tz->trips.passive.devices.count; i++) {
-			handle = tz->trips.passive.devices.handles[i];
+		for (i = 0; i < tz->trips.passive.devices->count; i++) {
+			handle = tz->trips.passive.devices->handles[i];
 			dev = acpi_fetch_acpi_dev(handle);
 			if (dev != device)
 				continue;
@@ -736,8 +741,8 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
 			break;
 
 		trip++;
-		for (j = 0; j < tz->trips.active[i].devices.count; j++) {
-			handle = tz->trips.active[i].devices.handles[j];
+		for (j = 0; j < tz->trips.active[i].devices->count; j++) {
+			handle = tz->trips.active[i].devices->handles[j];
 			dev = acpi_fetch_acpi_dev(handle);
 			if (dev != device)
 				continue;
@@ -1062,6 +1067,7 @@ static int acpi_thermal_add(struct acpi_device *device)
 static void acpi_thermal_remove(struct acpi_device *device)
 {
 	struct acpi_thermal *tz;
+	int i;
 
 	if (!device || !acpi_driver_data(device))
 		return;
@@ -1070,6 +1076,10 @@ static void acpi_thermal_remove(struct acpi_device *device)
 	tz = acpi_driver_data(device);
 
 	acpi_thermal_unregister_thermal_zone(tz);
+	kfree(tz->trips.passive.devices);
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
+		kfree(tz->trips.active[i].devices);
+	kfree(tz->devices);
 	kfree(tz);
 }
 
@@ -1098,9 +1108,9 @@ static int acpi_thermal_resume(struct device *dev)
 			break;
 
 		tz->trips.active[i].flags.enabled = 1;
-		for (j = 0; j < tz->trips.active[i].devices.count; j++) {
+		for (j = 0; j < tz->trips.active[i].devices->count; j++) {
 			result = acpi_bus_update_power(
-					tz->trips.active[i].devices.handles[j],
+					tz->trips.active[i].devices->handles[j],
 					&power_state);
 			if (result || (power_state != ACPI_STATE_D0)) {
 				tz->trips.active[i].flags.enabled = 0;
diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 2ea14648a661..dd76389ede96 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -333,16 +333,17 @@ acpi_status
 acpi_evaluate_reference(acpi_handle handle,
 			acpi_string pathname,
 			struct acpi_object_list *arguments,
-			struct acpi_handle_list *list)
+			struct acpi_handle_list **out)
 {
 	acpi_status status = AE_OK;
+	struct acpi_handle_list *list = NULL;
 	union acpi_object *package = NULL;
 	union acpi_object *element = NULL;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	u32 i = 0;
 
 
-	if (!list) {
+	if (!out) {
 		return AE_BAD_PARAMETER;
 	}
 
@@ -370,7 +371,8 @@ acpi_evaluate_reference(acpi_handle handle,
 		goto end;
 	}
 
-	if (package->package.count > ACPI_MAX_HANDLES) {
+	list = kmalloc(package->package.count * sizeof(list->handles[0]) + sizeof(*list), GFP_KERNEL);
+	if (!list) {
 		kfree(package);
 		return AE_NO_MEMORY;
 	}
@@ -400,12 +402,12 @@ acpi_evaluate_reference(acpi_handle handle,
 	}
 
       end:
-	if (ACPI_FAILURE(status)) {
-		list->count = 0;
-		//kfree(list->handles);
+	if (ACPI_FAILURE(status) && list) {
+		kfree(list);
 	}
 
 	kfree(buffer.pointer);
+	*out = list;
 
 	return status;
 }
diff --git a/drivers/platform/surface/surface_acpi_notify.c b/drivers/platform/surface/surface_acpi_notify.c
index 897cdd9c3aae..c6ead68cefc9 100644
--- a/drivers/platform/surface/surface_acpi_notify.c
+++ b/drivers/platform/surface/surface_acpi_notify.c
@@ -738,7 +738,7 @@ do {										\
 
 static bool is_san_consumer(struct platform_device *pdev, acpi_handle handle)
 {
-	struct acpi_handle_list dep_devices;
+	struct acpi_handle_list *dep_devices;
 	acpi_handle supplier = ACPI_HANDLE(&pdev->dev);
 	acpi_status status;
 	int i;
@@ -752,11 +752,14 @@ static bool is_san_consumer(struct platform_device *pdev, acpi_handle handle)
 		return false;
 	}
 
-	for (i = 0; i < dep_devices.count; i++) {
-		if (dep_devices.handles[i] == supplier)
+	for (i = 0; i < dep_devices->count; i++) {
+		if (dep_devices->handles[i] == supplier) {
+			kfree(dep_devices);
 			return true;
+		}
 	}
 
+	kfree(dep_devices);
 	return false;
 }
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 57acb895c038..8684efcf0e17 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -12,11 +12,9 @@
 #include <linux/device.h>
 #include <linux/property.h>
 
-/* TBD: Make dynamic */
-#define ACPI_MAX_HANDLES	10
 struct acpi_handle_list {
 	u32 count;
-	acpi_handle handles[ACPI_MAX_HANDLES];
+	acpi_handle handles[];
 };
 
 /* acpi_utils.h */
@@ -31,7 +29,7 @@ acpi_status
 acpi_evaluate_reference(acpi_handle handle,
 			acpi_string pathname,
 			struct acpi_object_list *arguments,
-			struct acpi_handle_list *list);
+			struct acpi_handle_list **list);
 acpi_status
 acpi_evaluate_ost(acpi_handle handle, u32 source_event, u32 status_code,
 		  struct acpi_buffer *status_buf);
@@ -69,6 +67,18 @@ acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 rev,
 	return obj;
 }
 
+static inline bool
+acpi_handle_list_equal(struct acpi_handle_list *a, struct acpi_handle_list *b)
+{
+	if (!a || !b)
+		return false;
+
+	if (a->count != b->count)
+		return false;
+
+	return !memcmp(a->handles, b->handles, a->count * sizeof(acpi_handle));
+}
+
 #define	ACPI_INIT_DSM_ARGV4(cnt, eles)			\
 	{						\
 	  .package.type = ACPI_TYPE_PACKAGE,		\
-- 
2.40.0

