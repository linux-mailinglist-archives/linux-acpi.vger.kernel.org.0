Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A28230908
	for <lists+linux-acpi@lfdr.de>; Fri, 31 May 2019 08:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfEaG5j (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 May 2019 02:57:39 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:53142 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaG5j (ORCPT
        <rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
        Fri, 31 May 2019 02:57:39 -0400
Received: from linux-8mug.suse.de (prva10-snat226-1.provo.novell.com [137.65.226.35])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Fri, 31 May 2019 00:57:33 -0600
From:   Chester Lin <clin@suse.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, gregkh@linuxfoundation.org
Cc:     jlee@suse.com, mhocko@suse.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chester Lin <clin@suse.com>
Subject: [PATCH 1/3] ACPI / hotplug: Send change events for offline/online requests when eject is triggered
Date:   Fri, 31 May 2019 14:56:40 +0800
Message-Id: <20190531065642.13254-2-clin@suse.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190531065642.13254-1-clin@suse.com>
References: <20190531065642.13254-1-clin@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Here we change offline/online handling in device hotplug by sending change
events to userland as notification so that userland can have control and
determine when will be a good time to put them offline/online based on
current workload. In this approach the real offline/online opertions are
handed over to userland so that userland can have more time to prepare
before any device change actually happens.

All child devices under the ejection target are traversed and notified
hierarchically based on ACPI namespace in ascending order when an eject
event happens.

Signed-off-by: Chester Lin <clin@suse.com>
---
 drivers/acpi/container.c |   2 +-
 drivers/acpi/internal.h  |   2 +-
 drivers/acpi/scan.c      | 140 +++++++++++++++++----------------------
 include/acpi/acpi_bus.h  |   2 +-
 4 files changed, 65 insertions(+), 81 deletions(-)

diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 12c240903c18..f8c7768b4c8e 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -46,7 +46,7 @@ static int acpi_container_offline(struct container_dev *cdev)
 
 	/* Check all of the dependent devices' physical companions. */
 	list_for_each_entry(child, &adev->children, node)
-		if (!acpi_scan_is_offline(child, false))
+		if (!acpi_scan_is_offline(child))
 			return -EBUSY;
 
 	return 0;
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 6eaf06db7752..47014776fecb 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -92,7 +92,7 @@ void acpi_apd_init(void);
 acpi_status acpi_hotplug_schedule(struct acpi_device *adev, u32 src);
 bool acpi_queue_hotplug_work(struct work_struct *work);
 void acpi_device_hotplug(struct acpi_device *adev, u32 src);
-bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent);
+bool acpi_scan_is_offline(struct acpi_device *adev);
 
 acpi_status acpi_sysfs_table_handler(u32 event, void *table, void *context);
 void acpi_scan_table_handler(u32 event, void *table, void *context);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 0e28270b0fd8..d7628146eb5f 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -113,11 +113,10 @@ int acpi_scan_add_handler_with_hotplug(struct acpi_scan_handler *handler,
 	return 0;
 }
 
-bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent)
+bool acpi_scan_is_offline(struct acpi_device *adev)
 {
 	struct acpi_device_physical_node *pn;
 	bool offline = true;
-	char *envp[] = { "EVENT=offline", NULL };
 
 	/*
 	 * acpi_container_offline() calls this for all of the container's
@@ -127,9 +126,6 @@ bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent)
 
 	list_for_each_entry(pn, &adev->physical_node_list, node)
 		if (device_supports_offline(pn->dev) && !pn->dev->offline) {
-			if (uevent)
-				kobject_uevent_env(&pn->dev->kobj, KOBJ_CHANGE, envp);
-
 			offline = false;
 			break;
 		}
@@ -138,13 +134,12 @@ bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent)
 	return offline;
 }
 
-static acpi_status acpi_bus_offline(acpi_handle handle, u32 lvl, void *data,
-				    void **ret_p)
+static acpi_status acpi_bus_offline_notify(acpi_handle handle, u32 lvl,
+					void *data, void **ret_p)
 {
 	struct acpi_device *device = NULL;
 	struct acpi_device_physical_node *pn;
-	bool second_pass = (bool)data;
-	acpi_status status = AE_OK;
+	char *envp[] = { "EVENT=offline", NULL };
 
 	if (acpi_bus_get_device(handle, &device))
 		return AE_OK;
@@ -155,100 +150,93 @@ static acpi_status acpi_bus_offline(acpi_handle handle, u32 lvl, void *data,
 	}
 
 	mutex_lock(&device->physical_node_lock);
-
 	list_for_each_entry(pn, &device->physical_node_list, node) {
-		int ret;
-
-		if (second_pass) {
-			/* Skip devices offlined by the first pass. */
-			if (pn->put_online)
-				continue;
-		} else {
-			pn->put_online = false;
-		}
-		ret = device_offline(pn->dev);
-		if (ret >= 0) {
-			pn->put_online = !ret;
-		} else {
-			*ret_p = pn->dev;
-			if (second_pass) {
-				status = AE_ERROR;
-				break;
-			}
+		if (device_supports_offline(pn->dev) && !(pn->dev->offline)) {
+			kobject_uevent_env(&pn->dev->kobj, KOBJ_CHANGE, envp);
+			pn->changed_offline = true;
 		}
 	}
-
 	mutex_unlock(&device->physical_node_lock);
 
-	return status;
+	return AE_OK;
 }
 
-static acpi_status acpi_bus_online(acpi_handle handle, u32 lvl, void *data,
-				   void **ret_p)
+static acpi_status acpi_bus_online_notify(acpi_handle handle, u32 lvl,
+						void *data, void **ret_p)
 {
 	struct acpi_device *device = NULL;
 	struct acpi_device_physical_node *pn;
+	char *envp[] = { "EVENT=online", NULL };
 
 	if (acpi_bus_get_device(handle, &device))
 		return AE_OK;
 
 	mutex_lock(&device->physical_node_lock);
 
-	list_for_each_entry(pn, &device->physical_node_list, node)
-		if (pn->put_online) {
-			device_online(pn->dev);
-			pn->put_online = false;
+	list_for_each_entry(pn, &device->physical_node_list, node) {
+		if (pn->changed_offline) {
+			kobject_uevent_env(&pn->dev->kobj, KOBJ_CHANGE, envp);
+			pn->changed_offline = false;
 		}
+	}
 
 	mutex_unlock(&device->physical_node_lock);
-
 	return AE_OK;
 }
 
-static int acpi_scan_try_to_offline(struct acpi_device *device)
+static void acpi_scan_notify_online(struct acpi_device *device)
+{
+	acpi_handle handle = device->handle;
+
+	acpi_bus_online_notify(handle, 0, NULL, NULL);
+	acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
+				acpi_bus_online_notify, NULL, NULL, NULL);
+}
+
+static int acpi_scan_notify_offline(struct acpi_device *device)
 {
 	acpi_handle handle = device->handle;
 	struct device *errdev = NULL;
 	acpi_status status;
 
-	/*
-	 * Carry out two passes here and ignore errors in the first pass,
-	 * because if the devices in question are memory blocks and
-	 * CONFIG_MEMCG is set, one of the blocks may hold data structures
-	 * that the other blocks depend on, but it is not known in advance which
-	 * block holds them.
-	 *
-	 * If the first pass is successful, the second one isn't needed, though.
-	 */
 	status = acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
-				     NULL, acpi_bus_offline, (void *)false,
-				     (void **)&errdev);
-	if (status == AE_SUPPORT) {
+			NULL, acpi_bus_offline_notify,
+			NULL, (void **)&errdev);
+	if (errdev)
+		goto notify_error;
+
+	status = acpi_bus_offline_notify(handle, 0, NULL,
+				(void **)&errdev);
+
+	if (errdev)
+		goto notify_error;
+
+	return 0;
+
+notify_error:
+	acpi_scan_notify_online(device);
+
+	switch (status) {
+	case AE_SUPPORT:
 		dev_warn(errdev, "Offline disabled.\n");
-		acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
-				    acpi_bus_online, NULL, NULL, NULL);
 		return -EPERM;
+	default:
+		dev_warn(errdev, "Offline failed. (status:%#x)\n", status);
+		return -EBUSY;
 	}
-	acpi_bus_offline(handle, 0, (void *)false, (void **)&errdev);
-	if (errdev) {
-		errdev = NULL;
-		acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
-				    NULL, acpi_bus_offline, (void *)true,
-				    (void **)&errdev);
-		if (!errdev)
-			acpi_bus_offline(handle, 0, (void *)true,
-					 (void **)&errdev);
-
-		if (errdev) {
-			dev_warn(errdev, "Offline failed.\n");
-			acpi_bus_online(handle, 0, NULL, NULL);
-			acpi_walk_namespace(ACPI_TYPE_ANY, handle,
-					    ACPI_UINT32_MAX, acpi_bus_online,
-					    NULL, NULL, NULL);
+}
+
+static int acpi_scan_offline_check(struct acpi_device *device)
+{
+	int ret = 0;
+	/* Send offline request to userland if the container is not offline */
+	if (!acpi_scan_is_offline(device)) {
+		ret = acpi_scan_notify_offline(device);
+		if (!ret)
 			return -EBUSY;
-		}
 	}
-	return 0;
+
+	return ret;
 }
 
 static int acpi_scan_hot_remove(struct acpi_device *device)
@@ -256,15 +244,11 @@ static int acpi_scan_hot_remove(struct acpi_device *device)
 	acpi_handle handle = device->handle;
 	unsigned long long sta;
 	acpi_status status;
+	int ret;
 
-	if (device->handler && device->handler->hotplug.demand_offline) {
-		if (!acpi_scan_is_offline(device, true))
-			return -EBUSY;
-	} else {
-		int error = acpi_scan_try_to_offline(device);
-		if (error)
-			return error;
-	}
+	ret = acpi_scan_offline_check(device);
+	if (ret)
+		return ret;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 		"Hot-removing device %s...\n", dev_name(&device->dev)));
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 52d4375bde9d..2ad8262f2a47 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -343,7 +343,7 @@ struct acpi_device_physical_node {
 	unsigned int node_id;
 	struct list_head node;
 	struct device *dev;
-	bool put_online:1;
+	bool changed_offline:1;
 };
 
 struct acpi_device_properties {
-- 
2.20.1

