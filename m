Return-Path: <linux-acpi+bounces-244-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E432B7B0D78
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 22:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 0AB5B1C209EC
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 20:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27FE41A91
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 20:31:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B391A589
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 20:23:34 +0000 (UTC)
X-Greylist: delayed 342 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Sep 2023 13:23:32 PDT
Received: from endrift.com (endrift.com [173.255.198.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57F810A
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 13:23:32 -0700 (PDT)
Received: from nebulosa.vulpes.eutheria.net (unknown [50.47.218.115])
	by endrift.com (Postfix) with ESMTPSA id DBAFFA0BD;
	Wed, 27 Sep 2023 13:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1695845870; bh=TJYFcMrFrdQ/c027IJzYcymgaOIvRs02hrtmwo24skA=;
	h=From:To:Cc:Subject:Date:From;
	b=r7ZVq8rksfXEQoHjeYM9M6OQyA9Bnvj1W4xKpKPqwalxqUzCagjFjSTgQAjxoRgO/
	 yZWMGyNIr+BuSQCQSh/f9dSXW8r6p6eWOdmBGozaLls3YNeN5o+iJiIZuWfZqDtjZc
	 VTiGe6s1mfT6cs3YUjDxEF1O4Mps36tx+Q6+fFPFk/SuOL7W26x0c9ItKEkr+wGj1N
	 Z9V0vhnE6CbwRGgx1XZ0zE1HiKRPqeuR1ie5d+zkY1zo5SozJsgAmjYO2QlMEqo7dU
	 gARP0qU53dOFqEAyfBx6KSjxEikdP9SGgKYy1re2HAeV+i8KN3AfV6uvwbOqybooMW
	 HzLLaZoD9FxVQ==
From: Vicki Pfau <vi@endrift.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-acpi@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v2] ACPI: utils: Make acpi_handle_list dynamically allocated
Date: Wed, 27 Sep 2023 13:17:25 -0700
Message-ID: <20230927201725.2339488-1-vi@endrift.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This fixes a long-standing "TBD" comment in the ACPI headers regarding making
the acpi_handle_list struct's size dynamic. The number 10, which along with the
comment dates back to 2.4.23, seems like it may have been arbitrarily chosen,
and isn't sufficient in all cases. This patch finally makes the size dynamic
and updates its users to handle the modified API.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/acpi/acpi_lpss.c                      |  5 +++-
 drivers/acpi/scan.c                           |  1 +
 drivers/acpi/thermal.c                        | 23 ++++++++++++++-----
 drivers/acpi/utils.c                          |  5 ++--
 .../platform/surface/surface_acpi_notify.c    |  5 +++-
 include/acpi/acpi_bus.h                       |  4 +---
 6 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 539e700de4d2..4b3aa84faf70 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -591,10 +591,13 @@ static bool acpi_lpss_dep(struct acpi_device *adev, acpi_handle handle)
 	}
 
 	for (i = 0; i < dep_devices.count; i++) {
-		if (dep_devices.handles[i] == handle)
+		if (dep_devices.handles[i] == handle) {
+			kfree(dep_devices.handles);
 			return true;
+		}
 	}
 
+	kfree(dep_devices.handles);
 	return false;
 }
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 691d4b7686ee..2fbe354db0c0 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2032,6 +2032,7 @@ static u32 acpi_scan_check_dep(acpi_handle handle, bool check_dep)
 		mutex_unlock(&acpi_dep_list_lock);
 	}
 
+	kfree(dep_devices.handles);
 	return count;
 }
 
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 312730f8272e..48ddc56f96f6 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -307,8 +307,10 @@ static void __acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 			tz->trips.passive.trip.valid = true;
 		}
 
-		if (memcmp(&tz->trips.passive.devices, &devices,
-			   sizeof(struct acpi_handle_list))) {
+		if (&tz->trips.passive.devices.count != devices.count ||
+			   memcmp(tz->trips.passive.devices.handles,
+			   devices.handles, sizeof(acpi_handle) * devices.count)) {
+			kfree(tz->trips.passive.devices.handles);
 			memcpy(&tz->trips.passive.devices, &devices,
 			       sizeof(struct acpi_handle_list));
 			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
@@ -372,8 +374,10 @@ static void __acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 				tz->trips.active[i].trip.valid = true;
 			}
 
-			if (memcmp(&tz->trips.active[i].devices, &devices,
-				   sizeof(struct acpi_handle_list))) {
+			if (&tz->trips.active[i].devices.count != devices.count ||
+				   memcmp(tz->trips.active[i].devices.handles,
+				   devices.handles, sizeof(acpi_handle) * devices.count)) {
+				kfree(tz->trips.active[i].devices.handles);
 				memcpy(&tz->trips.active[i].devices, &devices,
 				       sizeof(struct acpi_handle_list));
 				ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
@@ -391,8 +395,10 @@ static void __acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 		memset(&devices, 0, sizeof(devices));
 		status = acpi_evaluate_reference(tz->device->handle, "_TZD",
 						 NULL, &devices);
-		if (ACPI_SUCCESS(status) &&
-		    memcmp(&tz->devices, &devices, sizeof(devices))) {
+		if (ACPI_SUCCESS(status) && (tz->devices.count != devices.count ||
+		    memcmp(tz->devices.handles, devices.handles,
+		    sizeof(acpi_handle) * devices.count))) {
+			kfree(tz->devices.handles);
 			tz->devices = devices;
 			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
 		}
@@ -974,6 +980,7 @@ static int acpi_thermal_add(struct acpi_device *device)
 static void acpi_thermal_remove(struct acpi_device *device)
 {
 	struct acpi_thermal *tz;
+	int i;
 
 	if (!device || !acpi_driver_data(device))
 		return;
@@ -986,6 +993,10 @@ static void acpi_thermal_remove(struct acpi_device *device)
 	flush_workqueue(acpi_thermal_pm_queue);
 	acpi_thermal_unregister_thermal_zone(tz);
 
+	kfree(tz->trips.passive.devices.handles);
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
+		kfree(tz->trips.active[i].devices.handles);
+	kfree(tz->devices.handles);
 	kfree(tz);
 }
 
diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 2ea14648a661..96f821c41756 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -370,7 +370,8 @@ acpi_evaluate_reference(acpi_handle handle,
 		goto end;
 	}
 
-	if (package->package.count > ACPI_MAX_HANDLES) {
+	list->handles = kcalloc(package->package.count, sizeof(*list->handles), GFP_KERNEL);
+	if (!list->handles) {
 		kfree(package);
 		return AE_NO_MEMORY;
 	}
@@ -402,7 +403,7 @@ acpi_evaluate_reference(acpi_handle handle,
       end:
 	if (ACPI_FAILURE(status)) {
 		list->count = 0;
-		//kfree(list->handles);
+		kfree(list->handles);
 	}
 
 	kfree(buffer.pointer);
diff --git a/drivers/platform/surface/surface_acpi_notify.c b/drivers/platform/surface/surface_acpi_notify.c
index 897cdd9c3aae..6932d4b35c6c 100644
--- a/drivers/platform/surface/surface_acpi_notify.c
+++ b/drivers/platform/surface/surface_acpi_notify.c
@@ -753,10 +753,13 @@ static bool is_san_consumer(struct platform_device *pdev, acpi_handle handle)
 	}
 
 	for (i = 0; i < dep_devices.count; i++) {
-		if (dep_devices.handles[i] == supplier)
+		if (dep_devices.handles[i] == supplier) {
+			kfree(dep_devices.handles);
 			return true;
+		}
 	}
 
+	kfree(dep_devices.handles);
 	return false;
 }
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 254685085c82..b4bf12343a22 100644
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
+	acpi_handle* handles;
 };
 
 /* acpi_utils.h */
-- 
2.42.0


