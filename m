Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D486CD75F
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Mar 2023 12:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjC2KKL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Mar 2023 06:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjC2KKI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2023 06:10:08 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5394D40E9;
        Wed, 29 Mar 2023 03:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680084603; x=1711620603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UtgT5D8TRKfH5+qP9IRVRWvJ1wo9Gv7+UjrwDZfPg3Q=;
  b=UvJDnqoOjn05ltmc7jlOo/HnN7OAoDf2Yt5JVPwFV7f4AgUmk6rI1WD8
   g3b+c7Yjp4/0USQz3R/Yyr6GSxwY2iX5QMawXGOx8h26rVphemdp0d0h3
   g8vRpIN9RtqZ/rKAK/jsN7TFwVK6sjuhBn7O6NtfVjfNEITXh8q5n1sV/
   PFZaivNHVGOGXAtgQVHqbKKkFdmfvWVypF1h8MEWbhFLc73rrd3YC3Aod
   XeDX+eRSI1HcxWDocsCeBqPvFMlMZh/qxWjuUBM6jCayBI0frMTBsfHTY
   SvY8guIL6DeDetUmqVCUFNBKC+UyZeyNE47P4QF0UNXybkk+Gh/4KPZZt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="343256244"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="343256244"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 03:10:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="773517718"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="773517718"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 03:10:01 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 4A7731224D2;
        Wed, 29 Mar 2023 13:09:58 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v8 06/10] ACPI: scan: Generate software nodes based on MIPI DisCo for Imaging
Date:   Wed, 29 Mar 2023 13:09:47 +0300
Message-Id: <20230329100951.1522322-7-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230329100951.1522322-1-sakari.ailus@linux.intel.com>
References: <20230329100951.1522322-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Generate software nodes for driver use, based on MIPI DisCo for Imaging
definitions.

During the (sub-)namespace walk, ACPI device nodes are created but the
drivers aren't probed for the devices yet. A convenient way to determine
which ACPI devices this applies to is to find a hierarchical data node that
begins with "mipi-img-port-". These devices need software nodes that need
to be present before probing, and can only be constructed once the related
_CRS CSI2 records have been parsed.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/internal.h | 11 ++++--
 drivers/acpi/power.c    |  2 +-
 drivers/acpi/property.c | 48 +++++++++++++++++--------
 drivers/acpi/scan.c     | 80 +++++++++++++++++++++++++++++++++--------
 4 files changed, 109 insertions(+), 32 deletions(-)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 1634a177c75e..36799cde281c 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -111,17 +111,23 @@ struct acpi_scan_context_csi2 {
 /**
  * struct acpi_scan_context - Context for scanning ACPI devices
  * @postponed_head: The list head of the postponed ACPI handles
+ * @mipi_img_head: The list of ACPI devices with MIPI DisCo for Imaging related
+ *		   properties
  * @device: The first encountered device, typically the root of the scanned tree
  * @csi2: Context for scanning _CRS CSI2 resource descriptors
  */
 struct acpi_scan_context {
 	struct list_head postponed_head;
+	struct list_head mipi_img_head;
 	struct acpi_device *device;
 	struct acpi_scan_context_csi2 csi2;
 };
 
+void acpi_bus_device_postpone(struct acpi_device *device,
+			      struct list_head *head);
 void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
-			     int type, void (*release)(struct device *));
+			     int type, void (*release)(struct device *),
+			     struct list_head *mipi_img_head);
 int acpi_tie_acpi_dev(struct acpi_device *adev);
 int acpi_device_add(struct acpi_device *device);
 int acpi_device_setup_files(struct acpi_device *dev);
@@ -275,7 +281,8 @@ static inline bool force_storage_d3(void)
   -------------------------------------------------------------------------- */
 #define ACPI_DT_NAMESPACE_HID	"PRP0001"
 
-void acpi_init_properties(struct acpi_device *adev);
+void acpi_init_properties(struct acpi_device *adev,
+			  struct list_head *mipi_img_head);
 void acpi_free_properties(struct acpi_device *adev);
 
 #ifdef CONFIG_X86
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 23507d29f000..1096cdbf3d28 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -945,7 +945,7 @@ struct acpi_device *acpi_add_power_resource(acpi_handle handle)
 
 	device = &resource->device;
 	acpi_init_device_object(device, handle, ACPI_BUS_TYPE_POWER,
-				acpi_release_power_resource);
+				acpi_release_power_resource, NULL);
 	mutex_init(&resource->resource_lock);
 	INIT_LIST_HEAD(&resource->list_node);
 	INIT_LIST_HEAD(&resource->dependents);
diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 08831ffba26c..1892787e73a6 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -62,10 +62,12 @@ static const guid_t buffer_prop_guid =
 	GUID_INIT(0xedb12dd0, 0x363d, 0x4085,
 		  0xa3, 0xd2, 0x49, 0x52, 0x2c, 0xa1, 0x60, 0xc4);
 
-static bool acpi_enumerate_nondev_subnodes(acpi_handle scope,
+static bool acpi_enumerate_nondev_subnodes(struct acpi_device *device,
+					   acpi_handle scope,
 					   union acpi_object *desc,
 					   struct acpi_device_data *data,
-					   struct fwnode_handle *parent);
+					   struct fwnode_handle *parent,
+					   struct list_head *mipi_img_head);
 static bool acpi_extract_properties(acpi_handle handle,
 				    union acpi_object *desc,
 				    struct acpi_device_data *data);
@@ -103,11 +105,12 @@ static bool acpi_nondev_subnode_extract(union acpi_object *desc,
 		 */
 		status = acpi_get_parent(handle, &scope);
 		if (ACPI_SUCCESS(status)
-		    && acpi_enumerate_nondev_subnodes(scope, desc, &dn->data,
-						      &dn->fwnode))
+		    && acpi_enumerate_nondev_subnodes(NULL, scope, desc,
+						      &dn->data, &dn->fwnode,
+						      NULL))
 			result = true;
-	} else if (acpi_enumerate_nondev_subnodes(NULL, desc, &dn->data,
-						  &dn->fwnode)) {
+	} else if (acpi_enumerate_nondev_subnodes(NULL, NULL, desc, &dn->data,
+						  &dn->fwnode, NULL)) {
 		result = true;
 	}
 
@@ -163,11 +166,14 @@ static bool acpi_nondev_subnode_ok(acpi_handle scope,
 	return acpi_nondev_subnode_data_ok(handle, link, list, parent);
 }
 
-static bool acpi_add_nondev_subnodes(acpi_handle scope,
+static bool acpi_add_nondev_subnodes(struct acpi_device *device,
+				     acpi_handle scope,
 				     union acpi_object *links,
 				     struct list_head *list,
-				     struct fwnode_handle *parent)
+				     struct fwnode_handle *parent,
+				     struct list_head *mipi_img_head)
 {
+	bool has_mipi_img_nodes = false;
 	bool ret = false;
 	int i;
 
@@ -188,6 +194,13 @@ static bool acpi_add_nondev_subnodes(acpi_handle scope,
 		/* The second one may be a string, a reference or a package. */
 		switch (link->package.elements[1].type) {
 		case ACPI_TYPE_STRING:
+			if (!has_mipi_img_nodes && mipi_img_head &&
+			    !strncmp(MIPI_IMG_PORT_PREFIX,
+				     link->package.elements[0].string.pointer,
+				     strlen(MIPI_IMG_PORT_PREFIX))) {
+				acpi_bus_device_postpone(device, mipi_img_head);
+				has_mipi_img_nodes = true;
+			}
 			result = acpi_nondev_subnode_ok(scope, link, list,
 							 parent);
 			break;
@@ -211,10 +224,12 @@ static bool acpi_add_nondev_subnodes(acpi_handle scope,
 	return ret;
 }
 
-static bool acpi_enumerate_nondev_subnodes(acpi_handle scope,
+static bool acpi_enumerate_nondev_subnodes(struct acpi_device *device,
+					   acpi_handle scope,
 					   union acpi_object *desc,
 					   struct acpi_device_data *data,
-					   struct fwnode_handle *parent)
+					   struct fwnode_handle *parent,
+					   struct list_head *mipi_img_head)
 {
 	int i;
 
@@ -238,8 +253,9 @@ static bool acpi_enumerate_nondev_subnodes(acpi_handle scope,
 		if (!guid_equal((guid_t *)guid->buffer.pointer, &ads_guid))
 			continue;
 
-		return acpi_add_nondev_subnodes(scope, links, &data->subnodes,
-						parent);
+		return acpi_add_nondev_subnodes(device, scope, links,
+						&data->subnodes, parent,
+						mipi_img_head);
 	}
 
 	return false;
@@ -533,7 +549,8 @@ static bool acpi_extract_properties(acpi_handle scope, union acpi_object *desc,
 	return !list_empty(&data->properties);
 }
 
-void acpi_init_properties(struct acpi_device *adev)
+void acpi_init_properties(struct acpi_device *adev,
+			  struct list_head *mipi_img_head)
 {
 	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER };
 	struct acpi_hardware_id *hwid;
@@ -567,8 +584,9 @@ void acpi_init_properties(struct acpi_device *adev)
 		if (acpi_of)
 			acpi_init_of_compatible(adev);
 	}
-	if (acpi_enumerate_nondev_subnodes(adev->handle, buf.pointer,
-					&adev->data, acpi_fwnode_handle(adev)))
+	if (acpi_enumerate_nondev_subnodes(adev, adev->handle, buf.pointer,
+					   &adev->data, acpi_fwnode_handle(adev),
+					   mipi_img_head))
 		adev->data.pointer = buf.pointer;
 
 	if (!adev->data.pointer) {
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index bf0645854cf1..a3ad0060c2fc 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1774,7 +1774,8 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 }
 
 void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
-			     int type, void (*release)(struct device *))
+			     int type, void (*release)(struct device *),
+			     struct list_head *mipi_img_head)
 {
 	struct acpi_device *parent = acpi_find_parent_acpi_dev(handle);
 
@@ -1788,7 +1789,7 @@ void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
 	acpi_set_device_status(device, ACPI_STA_DEFAULT);
 	acpi_device_get_busid(device);
 	acpi_set_pnp_ids(handle, &device->pnp, type);
-	acpi_init_properties(device);
+	acpi_init_properties(device, mipi_img_head);
 	acpi_bus_get_flags(device);
 	device->flags.match_driver = false;
 	device->flags.initialized = true;
@@ -1827,7 +1828,8 @@ static void acpi_scan_init_status(struct acpi_device *adev)
 }
 
 static int acpi_add_single_object(struct acpi_device **child,
-				  acpi_handle handle, int type, bool dep_init)
+				  acpi_handle handle, int type, bool dep_init,
+				  struct list_head *mipi_img_head)
 {
 	struct acpi_device *device;
 	bool release_dep_lock = false;
@@ -1837,7 +1839,9 @@ static int acpi_add_single_object(struct acpi_device **child,
 	if (!device)
 		return -ENOMEM;
 
-	acpi_init_device_object(device, handle, type, acpi_device_release);
+	acpi_init_device_object(device, handle, type, acpi_device_release,
+				mipi_img_head);
+
 	/*
 	 * Getting the status is delayed till here so that we can call
 	 * acpi_bus_get_status() and use its quirk handling.  Note that
@@ -2048,16 +2052,20 @@ static u32 acpi_scan_check_dep(acpi_handle handle, bool check_dep)
 }
 
 /**
- * struct acpi_postponed_handle - A postponed ACPI handle
+ * struct acpi_postponed_handle - A postponed ACPI handle or device
  * @list: Entry in a postponed list
  * @handle: The postponed handle
+ * @device: The postponed device
  *
- * One such entry represents an ACPI handle the scanning of which has been
- * postponed.
+ * One such entry represents an ACPI handle or an ACPI device the scanning of
+ * which has been postponed.
  */
 struct acpi_postponed_handle {
 	struct list_head list;
-	acpi_handle handle;
+	union {
+		acpi_handle handle;
+		struct acpi_device *device;
+	};
 };
 
 /**
@@ -2080,6 +2088,26 @@ static void acpi_bus_handle_postpone(acpi_handle handle, struct list_head *head)
 	list_add(&ph->list, head);
 }
 
+/**
+ * acpi_bus_device_postpone - Add an ACPI device to a given postponed list
+ * @device: The ACPI device
+ * @head: Postponed list head
+ *
+ * Add a given ACPI device to a list of ACPI objects for which the creation
+ * of the device objects is to be postponed.
+ */
+void acpi_bus_device_postpone(struct acpi_device *device, struct list_head *head)
+{
+	struct acpi_postponed_handle *ph;
+
+	ph = kzalloc(sizeof(*ph), GFP_KERNEL);
+	if (!ph)
+		return;
+
+	ph->device = device;
+	list_add(&ph->list, head);
+}
+
 static acpi_status acpi_bus_check_add(acpi_handle handle, bool first_pass,
 				      struct acpi_scan_context *ctx)
 {
@@ -2131,7 +2159,8 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, bool first_pass,
 	 * If first_pass is true at this point, the device has no dependencies,
 	 * or the creation of the device object would have been postponed above.
 	 */
-	acpi_add_single_object(&device, handle, type, !first_pass);
+	acpi_add_single_object(&device, handle, type, !first_pass,
+			       &ctx->mipi_img_head);
 	if (!device)
 		return AE_CTRL_DEPTH;
 
@@ -2484,6 +2513,7 @@ int acpi_bus_scan(acpi_handle handle)
 {
 	struct acpi_scan_context ctx = {
 		.postponed_head = LIST_HEAD_INIT(ctx.postponed_head),
+		.mipi_img_head = LIST_HEAD_INIT(ctx.mipi_img_head),
 		.csi2.crs_csi2_head = LIST_HEAD_INIT(ctx.csi2.crs_csi2_head),
 	};
 	struct acpi_postponed_handle *ph, *tmp_ph;
@@ -2517,13 +2547,25 @@ int acpi_bus_scan(acpi_handle handle)
 	acpi_bus_scan_crs_csi2(&ctx.csi2);
 	acpi_bus_scan_crs_csi2_release(&ctx.csi2.crs_csi2_head);
 
+	/*
+	 * Initialise software nodes for devices that have MIPI DisCo for
+	 * Imaging related properties.
+	 */
+	list_for_each_entry_safe(ph, tmp_ph, &ctx.mipi_img_head, list) {
+		list_del(&ph->list);
+		acpi_init_swnodes(ph->device);
+		kfree(ph);
+	}
+
 	acpi_bus_attach(ctx.device, (void *)true);
 
 	/*
-	 * Proceed to register ACPI devices that were postponed due to _DEP
-	 * objects during the namespace walk.
+	 * Proceed to register ACPI devices that were postponed due to _CRS CSI2
+	 * resources or _DEP objects during the namespace walk.
 	 */
 	list_for_each_entry_safe(ph, tmp_ph, &ctx.postponed_head, list) {
+		struct acpi_postponed_handle *pm, *tmp_pm;
+
 		list_del(&ph->list);
 		/* Set device NULL here to obtain the root for this sub-tree. */
 		ctx.device = NULL;
@@ -2537,6 +2579,16 @@ int acpi_bus_scan(acpi_handle handle)
 		acpi_walk_namespace(ACPI_TYPE_ANY, ph->handle, ACPI_UINT32_MAX,
 				    acpi_bus_check_add_2, NULL, (void *)&ctx,
 				    NULL);
+		/*
+		 * Initialise software nodes for devices that have MIPI DisCo
+		 * for Imaging related properties but which were postponed
+		 * because of _DEP.
+		 */
+		list_for_each_entry_safe(pm, tmp_pm, &ctx.mipi_img_head, list) {
+			list_del(&pm->list);
+			acpi_init_swnodes(pm->device);
+			kfree(pm);
+		}
 		if (ctx.device)
 			acpi_bus_attach(ctx.device, NULL);
 		kfree(ph);
@@ -2597,7 +2649,7 @@ int acpi_bus_register_early_device(int type)
 	struct acpi_device *device = NULL;
 	int result;
 
-	result = acpi_add_single_object(&device, NULL, type, false);
+	result = acpi_add_single_object(&device, NULL, type, false, NULL);
 	if (result)
 		return result;
 
@@ -2612,7 +2664,7 @@ static void acpi_bus_scan_fixed(void)
 		struct acpi_device *adev = NULL;
 
 		acpi_add_single_object(&adev, NULL, ACPI_BUS_TYPE_POWER_BUTTON,
-				       false);
+				       false, NULL);
 		if (adev) {
 			adev->flags.match_driver = true;
 			if (device_attach(&adev->dev) >= 0)
@@ -2626,7 +2678,7 @@ static void acpi_bus_scan_fixed(void)
 		struct acpi_device *adev = NULL;
 
 		acpi_add_single_object(&adev, NULL, ACPI_BUS_TYPE_SLEEP_BUTTON,
-				       false);
+				       false, NULL);
 		if (adev) {
 			adev->flags.match_driver = true;
 			if (device_attach(&adev->dev) < 0)
-- 
2.30.2

