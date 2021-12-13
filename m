Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1964472A2C
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Dec 2021 11:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241215AbhLMKeT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Dec 2021 05:34:19 -0500
Received: from mga14.intel.com ([192.55.52.115]:51747 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237517AbhLMKdl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 13 Dec 2021 05:33:41 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="238930007"
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="238930007"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 02:32:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="660821531"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Dec 2021 02:32:39 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] acpi: Store the Physical Location of Device (_PLD) information
Date:   Mon, 13 Dec 2021 13:32:39 +0300
Message-Id: <20211213103243.33657-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211213103243.33657-1-heikki.krogerus@linux.intel.com>
References: <20211213103243.33657-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This will remove the need for the drivers to always evaluate
the _PLD separately.

Because the _PLD may be shared between devices - for example
the USB2 and USB3 ports that share the same connector have
always the same _PLD - every unique _PLD that is detected is
registered as a single entry and stored in a dedicated list.
Then each of those entries will hold a list of devices that
share the location - have identical _PLD.

The location entry can be acquired with a new function
acpi_device_get_location(). The location structure that the
function returns contrains the _PLD of the device and the
list the other devices that share it.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/scan.c     | 79 +++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h | 14 ++++++++
 2 files changed, 93 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 5991dddbc9ceb..9946ca4451ebc 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -19,6 +19,7 @@
 #include <linux/dma-map-ops.h>
 #include <linux/platform_data/x86/apple.h>
 #include <linux/pgtable.h>
+#include <linux/crc32.h>
 
 #include "internal.h"
 
@@ -42,6 +43,8 @@ static LIST_HEAD(acpi_scan_handlers_list);
 DEFINE_MUTEX(acpi_device_lock);
 LIST_HEAD(acpi_wakeup_device_list);
 static DEFINE_MUTEX(acpi_hp_context_lock);
+static LIST_HEAD(acpi_location_list);
+static DEFINE_MUTEX(acpi_location_lock);
 
 /*
  * The UART device described by the SPCR table is the only object which needs
@@ -485,6 +488,7 @@ static void acpi_device_del(struct acpi_device *device)
 			break;
 		}
 
+	list_del(&device->location_list);
 	list_del(&device->wakeup_list);
 	mutex_unlock(&acpi_device_lock);
 
@@ -654,6 +658,78 @@ static int acpi_tie_acpi_dev(struct acpi_device *adev)
 	return 0;
 }
 
+static void acpi_store_device_location(struct acpi_device *adev)
+{
+	struct acpi_device_location *location;
+	struct acpi_pld_info *pld;
+	acpi_status status;
+	u32 crc;
+
+	status = acpi_get_physical_device_location(adev->handle, &pld);
+	if (ACPI_FAILURE(status))
+		return;
+
+	crc = crc32(~0, pld, sizeof(*pld));
+
+	mutex_lock(&acpi_location_lock);
+
+	list_for_each_entry(location, &acpi_location_list, node) {
+		if (location->pld_crc == crc) {
+			ACPI_FREE(pld);
+			goto out_add_to_location;
+		}
+	}
+
+	/* The location does not exist yet so creating it. */
+
+	location = kzalloc(sizeof(*location), GFP_KERNEL);
+	if (!location) {
+		acpi_handle_err(adev->handle, "Unable to store location\n");
+		goto err_unlock;
+	}
+
+	list_add_tail(&location->node, &acpi_location_list);
+	INIT_LIST_HEAD(&location->devices);
+	location->pld = pld;
+	location->pld_crc = crc;
+
+out_add_to_location:
+	list_add_tail(&adev->location_list, &location->devices);
+
+err_unlock:
+	mutex_unlock(&acpi_location_lock);
+}
+
+/**
+ * acpi_device_get_location - Get the device location
+ * @adev: ACPI device handle
+ *
+ * Returns the location of @adev when it's known. The location is known for all
+ * ACPI devices that have _PLD (Physical Location of Device). When the location
+ * is not known, the function returns NULL.
+ */
+struct acpi_device_location *acpi_device_get_location(struct acpi_device *adev)
+{
+	struct acpi_device_location *location;
+	struct list_head *tmp;
+
+	mutex_lock(&acpi_location_lock);
+
+	list_for_each_entry(location, &acpi_location_list, node) {
+		list_for_each(tmp, &location->devices) {
+			if (tmp == &adev->location_list)
+				goto out_unlock;
+		}
+	}
+	location = NULL;
+
+out_unlock:
+	mutex_unlock(&acpi_location_lock);
+
+	return location;
+}
+EXPORT_SYMBOL_GPL(acpi_device_get_location);
+
 static int __acpi_device_add(struct acpi_device *device,
 			     void (*release)(struct device *))
 {
@@ -670,6 +746,7 @@ static int __acpi_device_add(struct acpi_device *device,
 	INIT_LIST_HEAD(&device->wakeup_list);
 	INIT_LIST_HEAD(&device->physical_node_list);
 	INIT_LIST_HEAD(&device->del_list);
+	INIT_LIST_HEAD(&device->location_list);
 	mutex_init(&device->physical_node_lock);
 
 	mutex_lock(&acpi_device_lock);
@@ -712,6 +789,8 @@ static int __acpi_device_add(struct acpi_device *device,
 	if (device->wakeup.flags.valid)
 		list_add_tail(&device->wakeup_list, &acpi_wakeup_device_list);
 
+	acpi_store_device_location(device);
+
 	mutex_unlock(&acpi_device_lock);
 
 	if (device->parent)
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index d6fe27b695c3d..1a4af747198a4 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -354,6 +354,13 @@ struct acpi_device_data {
 	struct list_head subnodes;
 };
 
+struct acpi_device_location {
+	u32 pld_crc;
+	struct acpi_pld_info *pld;
+	struct list_head node;
+	struct list_head devices;
+};
+
 struct acpi_gpio_mapping;
 
 /* Device */
@@ -366,6 +373,7 @@ struct acpi_device {
 	struct list_head node;
 	struct list_head wakeup_list;
 	struct list_head del_list;
+	struct list_head location_list;
 	struct acpi_device_status status;
 	struct acpi_device_flags flags;
 	struct acpi_device_pnp pnp;
@@ -731,11 +739,17 @@ static inline void acpi_bus_put_acpi_device(struct acpi_device *adev)
 {
 	acpi_dev_put(adev);
 }
+
+struct acpi_device_location *acpi_device_get_location(struct acpi_device *adev);
 #else	/* CONFIG_ACPI */
 
 static inline int register_acpi_bus_type(void *bus) { return 0; }
 static inline int unregister_acpi_bus_type(void *bus) { return 0; }
 
+static inline struct acpi_device_location *acpi_device_get_location(struct acpi_device *adev)
+{
+	return NULL;
+}
 #endif				/* CONFIG_ACPI */
 
 #endif /*__ACPI_BUS_H__*/
-- 
2.33.0

