Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9696CBBB3
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Mar 2023 12:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjC1KCi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Mar 2023 06:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbjC1KCO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2023 06:02:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535226184;
        Tue, 28 Mar 2023 03:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679997732; x=1711533732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HG+CpxWNvLTtlYIzomrMitI/nyW1Gu33KBf+LEMzwQ4=;
  b=K+1j4m+LMnPSY/ZXhKIJRBmpydVqk87/Lb+6V3a++xD21J+8QuwkSRGb
   xfdpUM9QyDh3eP+lR253pLPx53i6QCu0EWYNaNzDiXQyVENdwdDYFKIAC
   hgojzHM0sNFaRylDPD4VynrHY1n8QT6ViApGaWU/Oa1FYVUHwhtWK/8dV
   LSlqS2ZSuMHGsfkigDiysMLnhgYy/WkIEOXjZVlfRaw1pt3Hy3jMYFFSZ
   mZ1elUz2tLIJc8UPS6jXPCAjs/6yvDuSmnl01d+DPsigBcfrqxk5NGZe4
   n7kpRvQKiN90GOo/3VGKkefCikNJfBZHFhEnToZ4LAPfbOgXr92Vn9C/w
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="324420012"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="324420012"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 03:02:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="753078549"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="753078549"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 03:02:09 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id DEDF912243C;
        Tue, 28 Mar 2023 13:02:06 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v6 06/10] ACPI: scan: Postpone creating devices with "mipi-img-port-" data nodes
Date:   Tue, 28 Mar 2023 13:01:55 +0300
Message-Id: <20230328100159.1457160-8-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230328100159.1457160-1-sakari.ailus@linux.intel.com>
References: <20230328100159.1457160-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Postpone creating ACPI devices that have a _DSD hierarchical data node that
begins with "mipi-img-port-". These devices need software nodes that need to
be present before probing, and can only be constructed once all _CRS CSI2
records have been parsed.

This also moves initialising the _DSD properties as the first operation of
initialising an ACPI device in order to avoid unnecessary device
preparation.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/internal.h | 13 +++++--
 drivers/acpi/mipi.c     |  5 ++-
 drivers/acpi/power.c    |  2 +-
 drivers/acpi/property.c | 48 +++++++++++++++++--------
 drivers/acpi/scan.c     | 78 ++++++++++++++++++++++++++++++++++-------
 5 files changed, 112 insertions(+), 34 deletions(-)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 55e5eb8aecdc..edfb5522bd6e 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -112,16 +112,22 @@ struct acpi_scan_context_csi2 {
  * struct acpi_scan_context - Context for scanning ACPI devices
  * @device: The first encountered device, typically the root of the scanned tree
  * @postponed_head: The list head of the postponed ACPI handles
+ * @mipi_img_head: The list of ACPI handles (device object) with MIPI DisCo for
+ *		   Imaging related properties
  * @csi2: Context for scanning _CRS CSI2 resource descriptors
  */
 struct acpi_scan_context {
 	struct acpi_device *device;
 	struct list_head postponed_head;
+	struct list_head mipi_img_head;
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
@@ -304,6 +311,8 @@ static inline void acpi_init_lpit(void) { }
 				ACPI and MIPI DisCo for Imaging conversion
   -------------------------------------------------------------------------- */
 
+#define MIPI_IMG_PORT_PREFIX "mipi-img-port-"
+
 void acpi_crs_csi2_swnodes_del_free(void);
 void acpi_bus_scan_check_crs_csi2(acpi_handle handle, struct acpi_scan_context *ctx);
 void acpi_bus_scan_crs_csi2(struct acpi_scan_context_csi2 *ctx);
diff --git a/drivers/acpi/mipi.c b/drivers/acpi/mipi.c
index 68576c21141c..a16dab090527 100644
--- a/drivers/acpi/mipi.c
+++ b/drivers/acpi/mipi.c
@@ -486,11 +486,10 @@ void acpi_bus_scan_crs_csi2(struct acpi_scan_context_csi2 *ctx)
 static struct fwnode_handle *get_mipi_port_handle(struct acpi_device *device,
 						  unsigned int port)
 {
-	static const char mipi_port_prefix[] = "mipi-img-port-";
-	char mipi_port_name[sizeof(mipi_port_prefix) + 2];
+	char mipi_port_name[sizeof(MIPI_IMG_PORT_PREFIX) + 2];
 
 	if (snprintf(mipi_port_name, sizeof(mipi_port_name), "%s%u",
-		     mipi_port_prefix, port) >= sizeof(mipi_port_name)) {
+		     MIPI_IMG_PORT_PREFIX, port) >= sizeof(mipi_port_name)) {
 		acpi_handle_info(acpi_device_handle(device),
 				 "mipi port name too long for port %u\n", port);
 		return NULL;
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
index 5eb10be49832..256bc511072f 100644
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
@@ -2050,13 +2054,17 @@ static u32 acpi_scan_check_dep(acpi_handle handle, bool check_dep)
 /**
  * struct acpi_postponed_handle - A postponed ACPI handle
  * @handle: The postponed handle
+ * @device: The postponed device
  * @list: Entry in a postponed list
  *
  * One such entry represents an ACPI handle the scanning of which has been
  * postponed.
  */
 struct acpi_postponed_handle {
-	acpi_handle handle;
+	union {
+		acpi_handle handle;
+		struct acpi_device *device;
+	};
 	struct list_head list;
 };
 
@@ -2068,8 +2076,7 @@ struct acpi_postponed_handle {
  * Add a given ACPI handle to a list of ACPI objects for which the creation
  * of the device objects is to be postponed.
  */
-static void acpi_bus_handle_postpone(acpi_handle handle,
-				     struct list_head *head)
+static void acpi_bus_handle_postpone(acpi_handle handle, struct list_head *head)
 {
 	struct acpi_postponed_handle *ph;
 
@@ -2081,6 +2088,27 @@ static void acpi_bus_handle_postpone(acpi_handle handle,
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
+void acpi_bus_device_postpone(struct acpi_device *device,
+			      struct list_head *head)
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
@@ -2132,7 +2160,8 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, bool first_pass,
 	 * If first_pass is true at this point, the device has no dependencies,
 	 * or the creation of the device object would have been postponed above.
 	 */
-	acpi_add_single_object(&device, handle, type, !first_pass);
+	acpi_add_single_object(&device, handle, type, !first_pass,
+			       &ctx->mipi_img_head);
 	if (!device)
 		return AE_CTRL_DEPTH;
 
@@ -2485,6 +2514,7 @@ int acpi_bus_scan(acpi_handle handle)
 {
 	struct acpi_scan_context ctx = {
 		.postponed_head = LIST_HEAD_INIT(ctx.postponed_head),
+		.mipi_img_head = LIST_HEAD_INIT(ctx.mipi_img_head),
 		.csi2.crs_csi2_head = LIST_HEAD_INIT(ctx.csi2.crs_csi2_head),
 	};
 	struct acpi_postponed_handle *ph, *tmp_ph;
@@ -2514,13 +2544,25 @@ int acpi_bus_scan(acpi_handle handle)
 	/* Construct software nodes out of _CRS CSI2 records */
 	acpi_bus_scan_crs_csi2(&ctx.csi2);
 
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
@@ -2532,6 +2574,16 @@ int acpi_bus_scan(acpi_handle handle)
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
@@ -2592,7 +2644,7 @@ int acpi_bus_register_early_device(int type)
 	struct acpi_device *device = NULL;
 	int result;
 
-	result = acpi_add_single_object(&device, NULL, type, false);
+	result = acpi_add_single_object(&device, NULL, type, false, NULL);
 	if (result)
 		return result;
 
@@ -2607,7 +2659,7 @@ static void acpi_bus_scan_fixed(void)
 		struct acpi_device *adev = NULL;
 
 		acpi_add_single_object(&adev, NULL, ACPI_BUS_TYPE_POWER_BUTTON,
-				       false);
+				       false, NULL);
 		if (adev) {
 			adev->flags.match_driver = true;
 			if (device_attach(&adev->dev) >= 0)
@@ -2621,7 +2673,7 @@ static void acpi_bus_scan_fixed(void)
 		struct acpi_device *adev = NULL;
 
 		acpi_add_single_object(&adev, NULL, ACPI_BUS_TYPE_SLEEP_BUTTON,
-				       false);
+				       false, NULL);
 		if (adev) {
 			adev->flags.match_driver = true;
 			if (device_attach(&adev->dev) < 0)
-- 
2.30.2

