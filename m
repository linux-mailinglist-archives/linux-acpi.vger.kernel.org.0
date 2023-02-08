Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F7568F200
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 16:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjBHP3E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 10:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjBHP2x (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 10:28:53 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B023B0DE;
        Wed,  8 Feb 2023 07:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675870130; x=1707406130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s2Y4uGmnsEcoAeaVe4ItJE78auTjalmyMjYhLV7sN2U=;
  b=Svacg6UMRKo4bnMCB+KTz+SEMYSkr4pQgW1E8rE2XnIHledjn/T71dGx
   +5FaJEexVyNNbMJYuTdHmQB04ZOhRnmBMvQjnZO0ldqE4lc1dihh8Bb81
   YmdOXvSGk2WKoTg39vFBsY0YPl7EKzrUF7m9Wr6SIeTCuczzUMAZPiMAl
   TlK0jmKroltmWOVZRDi7pfcNpD7bQbofEnVBn1J40pYUbdTq06urvpYFI
   44ro3CdUlStb6W0FoniXm0RVcQ2HsOzQAkZ1vU/oYAfQ0UlBUtdC9IvxJ
   4Z0mI05g39cob/qnZ5ZXBqnm4eyU+TvMT1O7jjRGupBW6zl6GL3pOPQrk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="310182284"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="310182284"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 07:28:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="617237830"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="617237830"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 07:28:45 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 08C7612190B;
        Wed,  8 Feb 2023 17:28:42 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1pPmMr-00CrAG-G4; Wed, 08 Feb 2023 17:28:17 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v4 2/8] ACPI: property: Parse _CRS CSI-2 descriptor
Date:   Wed,  8 Feb 2023 17:28:01 +0200
Message-Id: <20230208152807.3064242-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230208152807.3064242-1-sakari.ailus@linux.intel.com>
References: <20230208152807.3064242-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Parse newly added ACPI _CRS CSI-2 descriptor for CSI-2 and camera
configuration. For now, only figure out where the descriptor is present in
order to allow adding information from it to related devices.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/Makefile   |   2 +-
 drivers/acpi/internal.h |   7 +
 drivers/acpi/mipi.c     | 358 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/scan.c     |  16 +-
 include/acpi/acpi_bus.h |  11 ++
 5 files changed, 389 insertions(+), 5 deletions(-)
 create mode 100644 drivers/acpi/mipi.c

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index a5b649e71ab1b..a98fa1bc15548 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -37,7 +37,7 @@ acpi-$(CONFIG_ACPI_SLEEP)	+= proc.o
 # ACPI Bus and Device Drivers
 #
 acpi-y				+= bus.o glue.o
-acpi-y				+= scan.o
+acpi-y				+= scan.o mipi.o
 acpi-y				+= resource.o
 acpi-y				+= acpi_processor.o
 acpi-y				+= processor_core.o
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index ec584442fb298..1ec4aa92bf17a 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -282,4 +282,11 @@ void acpi_init_lpit(void);
 static inline void acpi_init_lpit(void) { }
 #endif
 
+/*--------------------------------------------------------------------------
+				ACPI and MIPI DisCo for Imaging conversion
+  -------------------------------------------------------------------------- */
+
+void acpi_crs_csi2_swnodes_del_free(void);
+void acpi_bus_scan_crs_csi2(acpi_handle handle);
+
 #endif /* _ACPI_INTERNAL_H_ */
diff --git a/drivers/acpi/mipi.c b/drivers/acpi/mipi.c
new file mode 100644
index 0000000000000..0df6147dc8c9d
--- /dev/null
+++ b/drivers/acpi/mipi.c
@@ -0,0 +1,358 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MIPI DisCo for Imaging support.
+ *
+ * Copyright (C) 2023 Intel Corporation
+ */
+
+#include <linux/acpi.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/overflow.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/sort.h>
+#include <linux/string.h>
+
+#include "internal.h"
+
+/* Temporary ACPI device handle to software node data structure mapping */
+struct crs_csi2_swnodes {
+	struct list_head list;
+	acpi_handle handle;
+	struct acpi_device_software_nodes *ads;
+};
+
+static LIST_HEAD(crs_csi2_swnodes);
+
+static void crs_csi2_swnode_del_free(struct crs_csi2_swnodes *swnodes)
+{
+	list_del(&swnodes->list);
+	kfree(swnodes);
+}
+
+void acpi_crs_csi2_swnodes_del_free(void)
+{
+	struct crs_csi2_swnodes *swnodes, *swnodes_tmp;
+
+	list_for_each_entry_safe(swnodes, swnodes_tmp, &crs_csi2_swnodes, list)
+		crs_csi2_swnode_del_free(swnodes);
+}
+
+/*
+ * Description of a _CRS CSI2 resource descriptor before software node creation
+ */
+struct crs_csi2_instance {
+	struct list_head list;
+	struct acpi_resource_csi2_serialbus csi2;
+	acpi_handle remote_handle;
+	char remote_name[];
+};
+
+/* Temporary list of ACPI device nodes with _CRS CSI2 resource descriptors */
+struct crs_csi2 {
+	struct list_head list;
+	acpi_handle handle;
+	struct list_head buses;
+};
+
+/*
+ * Context for collecting _CRS CSI2 resource descriptors during ACPI namespace
+ * walk
+ */
+struct scan_check_crs_csi2_context {
+	struct list_head res_head;
+	acpi_handle handle;
+	size_t handle_count;
+};
+
+/* Context for scanning ACPI device nodes for _CRS CSI2 resource descriptors */
+struct crs_csi2_all {
+	struct list_head crs_csi2_head;
+	size_t handle_count;
+};
+
+/* Scan a single CSI2 resource descriptor in _CRS */
+static acpi_status scan_check_crs_csi2_instance(struct acpi_resource *res,
+						void *context)
+{
+	struct scan_check_crs_csi2_context *inst_context = context;
+	struct acpi_resource_csi2_serialbus *csi2;
+	struct crs_csi2_instance *inst;
+	acpi_handle remote_handle;
+
+	if (res->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
+		return AE_OK;
+
+	csi2 = &res->data.csi2_serial_bus;
+
+	if (csi2->type != ACPI_RESOURCE_SERIAL_TYPE_CSI2)
+		return AE_OK;
+
+	if (!csi2->resource_source.string_length) {
+		acpi_handle_debug(inst_context->handle,
+				  "invalid resource source string length\n");
+		return AE_OK;
+	}
+
+	if (ACPI_FAILURE(acpi_get_handle(NULL, csi2->resource_source.string_ptr,
+					 &remote_handle))) {
+		acpi_handle_warn(inst_context->handle,
+				 "cannot get handle for %s\n",
+				 csi2->resource_source.string_ptr);
+		return AE_OK;
+	}
+
+	/*
+	 * Allocate space to store the _CRS CSI2 entry and its data and add it
+	 * to the list.
+	 */
+	inst = kmalloc(struct_size(inst, remote_name, csi2->resource_source.string_length),
+		       GFP_KERNEL);
+	if (!inst)
+		return AE_OK;
+
+	inst->csi2 = *csi2;
+	strscpy(inst->remote_name, csi2->resource_source.string_ptr,
+		csi2->resource_source.string_length);
+	inst->csi2.resource_source.string_ptr = inst->remote_name;
+	inst->remote_handle = remote_handle;
+
+	list_add(&inst->list, &inst_context->res_head);
+
+	inst_context->handle_count++;
+
+	return AE_OK;
+}
+
+/*
+ * Find all devices with _CRS CSI2 resource descriptors and collect them
+ * into a list for later use
+ */
+static acpi_status scan_check_crs_csi2(acpi_handle handle, u32 nesting_level,
+				       void *context, void **ret)
+{
+	struct scan_check_crs_csi2_context inst_context = {
+		.handle = handle,
+		.res_head = LIST_HEAD_INIT(inst_context.res_head),
+	};
+	struct crs_csi2_all *csi2_all = context;
+	struct crs_csi2 *csi2;
+
+	acpi_walk_resources(handle, METHOD_NAME__CRS,
+			    scan_check_crs_csi2_instance, &inst_context);
+
+	if (list_empty(&inst_context.res_head))
+		return AE_OK;
+
+	/*
+	 * Found entry, so allocate memory for it, fill it and add it to the
+	 * list.
+	 */
+	csi2 = kmalloc(sizeof(*csi2), GFP_KERNEL);
+	if (!csi2)
+		return AE_OK;
+
+	csi2->handle = handle;
+	list_replace(&inst_context.res_head, &csi2->buses);
+	list_add(&csi2->list, &csi2_all->crs_csi2_head);
+
+	/* This handle plus remote handles in _CRS CSI2 resource descriptors */
+	csi2_all->handle_count += 1 + inst_context.handle_count;
+
+	return AE_OK;
+}
+
+struct acpi_handle_ref {
+	acpi_handle handle;
+	unsigned int count;
+};
+
+#define NO_CSI2_PORT (~1U)
+
+static int crs_handle_cmp(const void *__a, const void *__b)
+{
+	const struct acpi_handle_ref *a = __a, *b = __b;
+
+	return a->handle < b->handle ? -1 : a->handle > b->handle;
+}
+
+/*
+ * Release entries in temporary storage of ACPI device nodes with _CRS CSI2
+ * resource descriptors.
+ */
+static void crs_csi2_release(struct list_head *crs_csi2_handles)
+{
+	struct crs_csi2 *csi2, *csi2_tmp;
+
+	list_for_each_entry_safe(csi2, csi2_tmp, crs_csi2_handles, list) {
+		struct crs_csi2_instance *inst, *inst_tmp;
+
+		list_for_each_entry_safe(inst, inst_tmp, &csi2->buses, list) {
+			list_del(&inst->list);
+			kfree(inst);
+		}
+
+		list_del(&csi2->list);
+		kfree(csi2);
+	}
+}
+
+/*
+ * Allocate memory and set up software nodes for an ACPI device with given
+ * number of CSI-2 ports.
+ */
+void acpi_crs_csi2_alloc_fill_swnodes(size_t ports_count, acpi_handle handle)
+{
+	struct acpi_device_software_nodes *ads;
+	struct crs_csi2_swnodes *swnodes;
+	size_t alloc_size;
+	unsigned int i;
+	bool overflow;
+	void *end;
+
+	/*
+	 * Allocate memory for ports, node pointers (number of nodes +
+	 * 1 (guardian), nodes (root + number of ports * 2 (for for
+	 * every port there is an endpoint)).
+	 */
+	overflow = check_mul_overflow(sizeof(*ads->ports) +
+				      sizeof(*ads->nodes) * 2 +
+				      sizeof(*ads->nodeptrs) * 2,
+				      ports_count, &alloc_size);
+	overflow = overflow ||
+		   check_add_overflow(sizeof(*ads) + sizeof(*ads->nodes) +
+				      sizeof(*ads->nodeptrs) * 2,
+				      alloc_size, &alloc_size);
+	if (overflow) {
+		acpi_handle_warn(handle,
+				 "too many _CRS CSI2 resource handles (%zu)",
+				 ports_count);
+		return;
+	}
+
+	swnodes = kzalloc(sizeof(*swnodes), GFP_KERNEL);
+	ads = kzalloc(alloc_size, GFP_KERNEL);
+	ads->ports = (void *)(ads + 1);
+	ads->nodes = (void *)(ads->ports + ports_count);
+	ads->nodeptrs = (void *)(ads->nodes +
+				 ports_count * 2 + 1);
+	end = ads->nodeptrs + ports_count * 2 + 2;
+	if (!swnodes || !ads || WARN_ON((void *)ads + alloc_size != end)) {
+		kfree(swnodes);
+		kfree(ads);
+		acpi_handle_debug(handle,
+				  "cannot allocate for %zu software nodes\n",
+				  ports_count);
+		return;
+	}
+
+	ads->num_ports = ports_count;
+	for (i = 0; i < ports_count * 2 + 1; i++)
+		ads->nodeptrs[i] = &ads->nodes[i];
+	ads->nodeptrs[i] = NULL;
+	for (i = 0; i < ports_count; i++)
+		ads->ports[i].port_nr = NO_CSI2_PORT;
+	swnodes->handle = handle;
+	swnodes->ads = ads;
+	list_add(&swnodes->list, &crs_csi2_swnodes);
+}
+
+/**
+ * acpi_bus_scan_crs_csi2 - Scan a device and its child devices for _CRS CSI-2
+ *
+ * @handle: Root of the ACPI Namespace branch to scan
+ *
+ * This function does a number of things:
+ *
+ * 1. Iteratively scan all ACPI device nodes starting from a handle for _CRS
+ *    CSI-2 instances. The instances are stored for later use.
+ *
+ * 2. Count how many references to other devices _CRS CSI-2 instances have in
+ *    total.
+ *
+ * 3. Count the number of references to other devices for each _CRS CSI-2
+ *    instance.
+ *
+ * 4. Allocate memory for swnodes each ACPI device requires later on, and
+ *    generate a list of such allocations.
+ *
+ * Note that struct acpi_device isn't available yet at this time.
+ *
+ * acpi_scan_lock in scan.c must be held when calling this function.
+ */
+void acpi_bus_scan_crs_csi2(acpi_handle handle)
+{
+	struct acpi_handle_ref *handle_refs;
+	struct acpi_handle_ref *this = NULL;
+	struct crs_csi2_all csi2_all = {
+		.crs_csi2_head = LIST_HEAD_INIT(csi2_all.crs_csi2_head),
+	};
+	size_t this_count;
+	unsigned int curr = 0;
+	struct crs_csi2 *csi2;
+
+	/*
+	 * Collect the devices that have a _CRS CSI-2 resource. Each CSI-2 TX
+	 * port has one.
+	 */
+	acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, ACPI_UINT32_MAX,
+			    scan_check_crs_csi2, NULL, &csi2_all, NULL);
+
+	/* No handles? Bail out here. */
+	if (!csi2_all.handle_count)
+		return;
+
+	handle_refs = kcalloc(csi2_all.handle_count + 1, sizeof(*handle_refs),
+			      GFP_KERNEL);
+	if (!handle_refs) {
+		acpi_handle_debug(handle, "no memory for %zu handle refs\n",
+				  csi2_all.handle_count + 1);
+		return;
+	}
+
+	/* Associate handles to the number of references. */
+	list_for_each_entry(csi2, &csi2_all.crs_csi2_head, list) {
+		struct crs_csi2_instance *inst;
+		struct acpi_handle_ref *handle_ref;
+
+		handle_ref = &handle_refs[curr++];
+		handle_ref->handle = csi2->handle;
+
+		list_for_each_entry(inst, &csi2->buses, list) {
+			handle_refs[curr].handle = inst->remote_handle;
+			handle_refs[curr].count = 1;
+			handle_ref->count++;
+			curr++;
+		}
+	}
+
+	handle_refs[curr].handle = NULL;
+
+	/* Sort the handles by remote so duplicates canbe easily found */
+	sort(handle_refs, csi2_all.handle_count, sizeof(*handle_refs), crs_handle_cmp, NULL);
+
+	/*
+	 * Finally count references in each handle, allocate space for device
+	 * specific ports, properties and fill the _CRS CSI2 descriptor
+	 * originated data.
+	 */
+	this = handle_refs;
+	this_count = this->count;
+	for (curr = 1; curr < csi2_all.handle_count + 1; curr++) {
+		/* Weed out duplicate receiver devices */
+		if (this->handle == handle_refs[curr].handle) {
+			this_count += handle_refs[curr].count;
+			continue;
+		}
+
+		acpi_crs_csi2_alloc_fill_swnodes(this_count, this->handle);
+
+		this = &handle_refs[curr];
+		this_count = this->count;
+	}
+
+	kfree(handle_refs);
+
+	crs_csi2_release(&csi2_all.crs_csi2_head);
+}
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 0c6f06abe3f47..50de874b8f208 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2423,9 +2423,12 @@ EXPORT_SYMBOL_GPL(acpi_dev_get_next_consumer_dev);
 int acpi_bus_scan(acpi_handle handle)
 {
 	struct acpi_device *device = NULL;
+	int ret = 0;
 
 	acpi_bus_scan_second_pass = false;
 
+	acpi_bus_scan_crs_csi2(handle);
+
 	/* Pass 1: Avoid enumerating devices with missing dependencies. */
 
 	if (ACPI_SUCCESS(acpi_bus_check_add(handle, true, &device)))
@@ -2433,13 +2436,15 @@ int acpi_bus_scan(acpi_handle handle)
 				    acpi_bus_check_add_1, NULL, NULL,
 				    (void **)&device);
 
-	if (!device)
-		return -ENODEV;
+	if (!device) {
+		ret = -ENODEV;
+		goto out_release;
+	}
 
 	acpi_bus_attach(device, (void *)true);
 
 	if (!acpi_bus_scan_second_pass)
-		return 0;
+		goto out_release;
 
 	/* Pass 2: Enumerate all of the remaining devices. */
 
@@ -2452,7 +2457,10 @@ int acpi_bus_scan(acpi_handle handle)
 
 	acpi_bus_attach(device, NULL);
 
-	return 0;
+out_release:
+	acpi_crs_csi2_swnodes_del_free();
+
+	return ret;
 }
 EXPORT_SYMBOL(acpi_bus_scan);
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index e44be31115a67..a05fe22c1175c 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -360,6 +360,17 @@ struct acpi_device_data {
 
 struct acpi_gpio_mapping;
 
+struct acpi_device_software_node_port {
+	unsigned int port_nr;
+};
+
+struct acpi_device_software_nodes {
+	struct acpi_device_software_node_port *ports;
+	struct software_node *nodes;
+	const struct software_node **nodeptrs;
+	unsigned int num_ports;
+};
+
 /* Device */
 struct acpi_device {
 	u32 pld_crc;
-- 
2.30.2

