Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF11E3090A
	for <lists+linux-acpi@lfdr.de>; Fri, 31 May 2019 08:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfEaG5t (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 May 2019 02:57:49 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:38579 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaG5s (ORCPT
        <rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
        Fri, 31 May 2019 02:57:48 -0400
Received: from linux-8mug.suse.de (prva10-snat226-1.provo.novell.com [137.65.226.35])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Fri, 31 May 2019 00:57:37 -0600
From:   Chester Lin <clin@suse.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, gregkh@linuxfoundation.org
Cc:     jlee@suse.com, mhocko@suse.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chester Lin <clin@suse.com>
Subject: [PATCH 2/3] ACPI / hotplug: Eject status trace and auto-remove approach
Date:   Fri, 31 May 2019 14:56:41 +0800
Message-Id: <20190531065642.13254-3-clin@suse.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190531065642.13254-1-clin@suse.com>
References: <20190531065642.13254-1-clin@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is an eject-status trace mechanism which helps to count current online
devices under the ejection target, and it can automatically reschedules an
eject event when all related devices are offline. The number of online
nodes can be updated when any node has been put offline successfully.
Any online event within the whole device tree during ejection will stop the
whole process and devices who have been put offline will need be online
again as recovery.

Signed-off-by: Chester Lin <clin@suse.com>
---
 drivers/acpi/glue.c     |  81 +++++++++++++++++++++++
 drivers/acpi/internal.h |  28 ++++++++
 drivers/acpi/scan.c     | 139 +++++++++++++++++++++++++++++++++++++++-
 drivers/base/core.c     |   2 +
 include/acpi/acpi_bus.h |   1 +
 5 files changed, 248 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index edd10b3c7ec8..50745b12ae84 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -361,6 +361,81 @@ static int acpi_device_notify_remove(struct device *dev)
 	return 0;
 }
 
+static void acpi_device_eject_tracer(struct device *dev,
+				enum kobject_action action)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	struct acpi_device *adev_root = NULL;
+	struct eject_data *eject_node = NULL;
+	struct eject_data *eject_root = NULL;
+
+	if (!adev || !adev->eject_stat)
+		return;
+
+	acpi_scan_lock_acquire();
+
+	eject_node = (struct eject_data *)adev->eject_stat;
+
+	if (eject_node->base.root_handle)
+		adev_root =
+		    acpi_bus_get_acpi_device(eject_node->base.root_handle);
+
+	if (adev_root)
+		eject_root = (struct eject_data *)adev_root->eject_stat;
+
+	if (action == KOBJ_OFFLINE) {
+		/*
+		 * If the offline device is child, update its eject_root's
+		 * number of online nodes.
+		 */
+		if (eject_root) {
+			if (eject_root->online_nodes)
+				eject_root->online_nodes--;
+
+			if (eject_root->online_nodes <=
+			    adev_root->physical_node_count)
+				acpi_eject_retry(adev_root);
+
+			goto tracer_end;
+		}
+		/*
+		 * Adjust number of online nodes when any physical node under
+		 * eject_root is offline. Trigger acpi_eject_try() once all
+		 * nodes are offline.
+		 */
+		if (eject_node->online_nodes)
+			eject_node->online_nodes--;
+
+		if (!eject_node->online_nodes)
+			acpi_eject_retry(adev);
+
+	} else if (action == KOBJ_ONLINE) {
+		/* !eject_root means now eject_node is root */
+		if (!eject_root)
+			eject_root = eject_node;
+
+		if (eject_root->status == ACPI_EJECT_STATUS_GOING_OFFLINE) {
+			eject_root->status = ACPI_EJECT_STATUS_FAIL;
+			acpi_eject_retry(adev_root);
+		}
+	}
+tracer_end:
+	if (adev_root)
+		acpi_bus_put_acpi_device(adev_root);
+
+	acpi_scan_lock_release();
+}
+
+static inline void acpi_device_check_eject_status(struct device *dev)
+{
+	acpi_device_eject_tracer(dev, KOBJ_OFFLINE);
+}
+
+static inline void acpi_device_check_eject_recover(struct device *dev)
+{
+	acpi_device_eject_tracer(dev, KOBJ_ONLINE);
+}
+
 int acpi_platform_notify(struct device *dev, enum kobject_action action)
 {
 	switch (action) {
@@ -370,6 +445,12 @@ int acpi_platform_notify(struct device *dev, enum kobject_action action)
 	case KOBJ_REMOVE:
 		acpi_device_notify_remove(dev);
 		break;
+	case KOBJ_OFFLINE:
+		acpi_device_check_eject_status(dev);
+		break;
+	case KOBJ_ONLINE:
+		acpi_device_check_eject_recover(dev);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 47014776fecb..0dcec4243b23 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -266,4 +266,32 @@ void acpi_init_lpit(void);
 static inline void acpi_init_lpit(void) { }
 #endif
 
+/* --------------------------------------------------------------------------
+ *				Eject Status
+ * --------------------------------------------------------------------------
+ */
+enum acpi_eject_status {
+	ACPI_EJECT_STATUS_NONE = 0,
+	ACPI_EJECT_STATUS_GOING_OFFLINE,
+	ACPI_EJECT_STATUS_FAIL
+};
+
+enum acpi_eject_node_type {
+	ACPI_EJECT_CHILD_NODE = 0,
+	ACPI_EJECT_ROOT_NODE
+};
+
+struct eject_data_base {
+	enum acpi_eject_node_type type;
+	acpi_handle root_handle;
+};
+
+struct eject_data {
+	struct eject_data_base base;
+	enum acpi_eject_status status;
+	u32 online_nodes;
+};
+
+void acpi_eject_retry(struct acpi_device *adev);
+
 #endif /* _ACPI_INTERNAL_H_ */
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index d7628146eb5f..c60110db1cd6 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -134,11 +134,110 @@ bool acpi_scan_is_offline(struct acpi_device *adev)
 	return offline;
 }
 
+void acpi_eject_retry(struct acpi_device *adev)
+{
+	acpi_status status;
+
+	get_device(&adev->dev);
+
+	status = acpi_hotplug_schedule(adev, ACPI_OST_EC_OSPM_EJECT);
+	if (ACPI_FAILURE(status)) {
+		pr_debug("Failed to reschedule an eject event\n");
+		put_device(&adev->dev);
+		acpi_evaluate_ost(adev->handle, ACPI_OST_EC_OSPM_EJECT,
+				ACPI_OST_SC_NON_SPECIFIC_FAILURE, NULL);
+		return;
+	}
+	pr_debug("Rescheduled an eject event\n");
+}
+
+static acpi_status acpi_init_eject_stat(struct acpi_device *adev,
+					enum acpi_eject_node_type type)
+{
+	struct eject_data *eject_node = (struct eject_data *) adev->eject_stat;
+
+	if (!eject_node) {
+		eject_node = kzalloc(sizeof(*eject_node), GFP_KERNEL);
+		if (!eject_node)
+			return AE_NO_MEMORY;
+		adev->eject_stat = eject_node;
+	}
+
+	eject_node->base.type = type;
+
+	if (type == ACPI_EJECT_CHILD_NODE)
+		return AE_OK;
+
+	/* Initialization of eject root node */
+	eject_node->status = ACPI_EJECT_STATUS_GOING_OFFLINE;
+	eject_node->online_nodes = 0;
+
+	return AE_OK;
+}
+
+static void acpi_enable_eject_stat(struct acpi_device *adev,
+				struct acpi_device *root_adev, u32 online_nodes)
+{
+	struct eject_data *eject_node = NULL;
+	struct eject_data *eject_root = NULL;
+
+	if (adev)
+		eject_node = (struct eject_data *)adev->eject_stat;
+	if (root_adev)
+		eject_root = (struct eject_data *)root_adev->eject_stat;
+
+	if (eject_node) {
+		if (eject_node != eject_root)
+			eject_node->base.root_handle = root_adev->handle;
+		else
+			eject_node->base.root_handle = 0;
+	}
+
+	/* Update online_nodes of root device */
+	if (eject_root) {
+		eject_root->online_nodes += online_nodes;
+		pr_debug("Current online nodes:%u\n",
+			eject_root->online_nodes);
+	}
+}
+
+static void acpi_free_eject_stat(struct acpi_device *adev)
+{
+	kfree(adev->eject_stat);
+	adev->eject_stat = NULL;
+}
+
+static acpi_status acpi_bus_offline_prepare(acpi_handle handle, u32 lvl,
+					void *data, void **ret_p)
+{
+	struct acpi_device *device = NULL;
+	struct eject_data_base *eject_obj = (struct eject_data_base *)data;
+	acpi_status status = AE_OK;
+
+	if (acpi_bus_get_device(handle, &device))
+		return AE_OK;
+
+	if (device->handler && !device->handler->hotplug.enabled) {
+		*ret_p = &device->dev;
+		return AE_SUPPORT;
+	}
+
+	status = acpi_init_eject_stat(device, eject_obj->type);
+	if (ACPI_FAILURE(status))
+		*ret_p = &device->dev;
+
+	return status;
+}
+
+
 static acpi_status acpi_bus_offline_notify(acpi_handle handle, u32 lvl,
 					void *data, void **ret_p)
 {
 	struct acpi_device *device = NULL;
+	struct acpi_device *root_device = NULL;
 	struct acpi_device_physical_node *pn;
+	struct eject_data_base *eject_obj = (struct eject_data_base *)data;
+	u32 online_nodes = 0;
 	char *envp[] = { "EVENT=offline", NULL };
 
 	if (acpi_bus_get_device(handle, &device))
@@ -149,13 +248,22 @@ static acpi_status acpi_bus_offline_notify(acpi_handle handle, u32 lvl,
 		return AE_SUPPORT;
 	}
 
+	if (eject_obj->root_handle == device->handle) {
+		root_device = device;
+	} else if (acpi_bus_get_device(eject_obj->root_handle, &root_device)) {
+		*ret_p = &device->dev;
+		return AE_NULL_OBJECT;
+	}
+
 	mutex_lock(&device->physical_node_lock);
 	list_for_each_entry(pn, &device->physical_node_list, node) {
 		if (device_supports_offline(pn->dev) && !(pn->dev->offline)) {
 			kobject_uevent_env(&pn->dev->kobj, KOBJ_CHANGE, envp);
+			online_nodes++;
 			pn->changed_offline = true;
 		}
 	}
+	acpi_enable_eject_stat(device, root_device, online_nodes);
 	mutex_unlock(&device->physical_node_lock);
 
 	return AE_OK;
@@ -171,6 +279,8 @@ static acpi_status acpi_bus_online_notify(acpi_handle handle, u32 lvl,
 	if (acpi_bus_get_device(handle, &device))
 		return AE_OK;
 
+	acpi_free_eject_stat(device);
+
 	mutex_lock(&device->physical_node_lock);
 
 	list_for_each_entry(pn, &device->physical_node_list, node) {
@@ -197,15 +307,23 @@ static int acpi_scan_notify_offline(struct acpi_device *device)
 {
 	acpi_handle handle = device->handle;
 	struct device *errdev = NULL;
+	struct eject_data_base base_data = {ACPI_EJECT_ROOT_NODE, handle};
 	acpi_status status;
 
+	status = acpi_bus_offline_prepare(handle, 0, (void *)&base_data,
+					(void **)&errdev);
+	if (errdev)
+		goto notify_error;
+
+	base_data.type = ACPI_EJECT_CHILD_NODE;
 	status = acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
-			NULL, acpi_bus_offline_notify,
-			NULL, (void **)&errdev);
+			acpi_bus_offline_prepare, acpi_bus_offline_notify,
+			(void *)&base_data, (void **)&errdev);
 	if (errdev)
 		goto notify_error;
 
-	status = acpi_bus_offline_notify(handle, 0, NULL,
+	base_data.type = ACPI_EJECT_ROOT_NODE;
+	status = acpi_bus_offline_notify(handle, 0, (void *)&base_data,
 				(void **)&errdev);
 
 	if (errdev)
@@ -217,6 +335,10 @@ static int acpi_scan_notify_offline(struct acpi_device *device)
 	acpi_scan_notify_online(device);
 
 	switch (status) {
+	case AE_NO_MEMORY:
+		return -ENOMEM;
+	case AE_NULL_OBJECT:
+		return -EINVAL;
 	case AE_SUPPORT:
 		dev_warn(errdev, "Offline disabled.\n");
 		return -EPERM;
@@ -229,6 +351,15 @@ static int acpi_scan_notify_offline(struct acpi_device *device)
 static int acpi_scan_offline_check(struct acpi_device *device)
 {
 	int ret = 0;
+	struct eject_data *eject_obj = (struct eject_data *) device->eject_stat;
+
+	/* Send recovery events to userland if any failure occur */
+	if (eject_obj && eject_obj->status == ACPI_EJECT_STATUS_FAIL) {
+		dev_warn(&device->dev, "Eject failed. Recover bus status\n");
+		acpi_scan_notify_online(device);
+		return -EAGAIN;
+	}
+
 	/* Send offline request to userland if the container is not offline */
 	if (!acpi_scan_is_offline(device)) {
 		ret = acpi_scan_notify_offline(device);
@@ -2060,6 +2191,8 @@ void acpi_bus_trim(struct acpi_device *adev)
 	list_for_each_entry_reverse(child, &adev->children, node)
 		acpi_bus_trim(child);
 
+	acpi_free_eject_stat(adev);
+
 	adev->flags.match_driver = false;
 	if (handler) {
 		if (handler->detach)
diff --git a/drivers/base/core.c b/drivers/base/core.c
index fd7511e04e62..aca6976ed19b 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2542,6 +2542,7 @@ int device_offline(struct device *dev)
 			if (!ret) {
 				kobject_uevent(&dev->kobj, KOBJ_OFFLINE);
 				dev->offline = true;
+				device_platform_notify(dev, KOBJ_OFFLINE);
 			}
 		}
 	}
@@ -2571,6 +2572,7 @@ int device_online(struct device *dev)
 			if (!ret) {
 				kobject_uevent(&dev->kobj, KOBJ_ONLINE);
 				dev->offline = false;
+				device_platform_notify(dev, KOBJ_ONLINE);
 			}
 		} else {
 			ret = 1;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 2ad8262f2a47..f587bd1ca6ba 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -391,6 +391,7 @@ struct acpi_device {
 	struct list_head physical_node_list;
 	struct mutex physical_node_lock;
 	void (*remove)(struct acpi_device *);
+	void *eject_stat;
 };
 
 /* Non-device subnode */
-- 
2.20.1

