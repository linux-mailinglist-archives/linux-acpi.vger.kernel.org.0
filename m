Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B196C6CBC39
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Mar 2023 12:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjC1KNt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Mar 2023 06:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjC1KNm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2023 06:13:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66C3728A;
        Tue, 28 Mar 2023 03:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679998411; x=1711534411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v8CvpIr/VVBKPvgtKODw/Rvzu/Mr9yMH7QL3x4FX2Mw=;
  b=Ly2MTzdiIvtKfW098iBryMLjKZ8O+DpoLERjR4FLUQ4UwzpHVEvODpb1
   tlhQBObr8CO1Q8M9qMhhI6O+mEf8vWFAhhgiLdiBLZpYtEJndalt8cGH0
   9XN2cxQ2S/ru4wwTboLVIMVIZg58j+SVtF+8CiOpPFYXCT5MOjMNwl0Fr
   oyZo4c7okIKXvwSqGcoOW63azQSWHeFRIb5jCsf+2TpVGIWJHnhQGZvCs
   btaNMQAlCtBKE5qMuYO290LOyptSIvYLKzJemP80dsZ6slq7t7cofHz42
   6dsJzd20tg/hOEm8Sz5v7xfXjOlV7CsUZZsIhu4xuYo6tVgnoOmrE5Nq9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328985336"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="328985336"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 03:13:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="827432673"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="827432673"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 03:13:11 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 3727212243C;
        Tue, 28 Mar 2023 13:13:08 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v7 03/10] ACPI: property: Parse _CRS CSI-2 descriptor
Date:   Tue, 28 Mar 2023 13:12:56 +0300
Message-Id: <20230328101303.1458570-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230328101303.1458570-1-sakari.ailus@linux.intel.com>
References: <20230328101303.1458570-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Parse newly added ACPI _CRS CSI-2 descriptor for CSI-2 and camera
configuration, associate it with appropriate devices and allocate memory for
software nodes needed to create a DT-like data structure for drivers.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/Makefile   |   2 +-
 drivers/acpi/internal.h |  26 +++
 drivers/acpi/mipi.c     | 345 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/scan.c     |  46 ++++--
 include/acpi/acpi_bus.h |  11 ++
 5 files changed, 415 insertions(+), 15 deletions(-)
 create mode 100644 drivers/acpi/mipi.c

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index feb36c0b9446..a64047282a73 100644
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
index 06ad497067ac..9279cdff3b6e 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -102,6 +102,24 @@ struct acpi_device_bus_id {
 	struct list_head node;
 };
 
+/* Context for scanning ACPI device nodes for _CRS CSI2 resource descriptors */
+struct acpi_scan_context_csi2 {
+	struct list_head crs_csi2_head;
+	size_t handle_count;
+};
+
+/**
+ * struct acpi_scan_context - Context for scanning ACPI devices
+ * @device: The first encountered device, typically the root of the scanned tree
+ * @postponed_head: The list head of the postponed ACPI handles
+ * @csi2: Context for scanning _CRS CSI2 resource descriptors
+ */
+struct acpi_scan_context {
+	struct acpi_device *device;
+	struct list_head postponed_head;
+	struct acpi_scan_context_csi2 csi2;
+};
+
 void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
 			     int type, void (*release)(struct device *));
 int acpi_tie_acpi_dev(struct acpi_device *adev);
@@ -282,4 +300,12 @@ void acpi_init_lpit(void);
 static inline void acpi_init_lpit(void) { }
 #endif
 
+/*--------------------------------------------------------------------------
+			ACPI _CRS CSI2 and MIPI DisCo for Imaging conversion
+  -------------------------------------------------------------------------- */
+
+void acpi_crs_csi2_swnodes_del_free(void);
+void acpi_bus_scan_check_crs_csi2(acpi_handle handle, struct acpi_scan_context *ctx);
+void acpi_bus_scan_crs_csi2(struct acpi_scan_context_csi2 *ctx);
+
 #endif /* _ACPI_INTERNAL_H_ */
diff --git a/drivers/acpi/mipi.c b/drivers/acpi/mipi.c
new file mode 100644
index 000000000000..ffc1768f86ed
--- /dev/null
+++ b/drivers/acpi/mipi.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MIPI DisCo for Imaging support.
+ *
+ * Support MIPI DisCo for Imaging by parsing ACPI _CRS CSI2 records and DisCo
+ * for Imaging data structures.
+ *
+ * Also see <URL:https://www.mipi.org/specifications/mipi-disco-imaging>.
+ *
+ * Copyright (C) 2023 Intel Corporation
+ */
+
+#include <linux/acpi.h>
+#include <linux/limits.h>
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
+/* Scan a single CSI2 resource descriptor in _CRS. */
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
+ * into a list for later use.
+ */
+void acpi_bus_scan_check_crs_csi2(acpi_handle handle, struct acpi_scan_context *ctx)
+{
+	struct scan_check_crs_csi2_context inst_context = {
+		.handle = handle,
+		.res_head = LIST_HEAD_INIT(inst_context.res_head),
+	};
+	struct crs_csi2 *csi2;
+
+	acpi_walk_resources(handle, METHOD_NAME__CRS,
+			    scan_check_crs_csi2_instance, &inst_context);
+
+	if (list_empty(&inst_context.res_head))
+		return;
+
+	/*
+	 * Found entry, so allocate memory for it, fill it and add it to the
+	 * list.
+	 */
+	csi2 = kmalloc(sizeof(*csi2), GFP_KERNEL);
+	if (!csi2)
+		return; /* There's nothing we really can do about this. */
+
+	csi2->handle = handle;
+	list_replace(&inst_context.res_head, &csi2->buses);
+	list_add(&csi2->list, &ctx->csi2.crs_csi2_head);
+
+	/* This handle plus remote handles in _CRS CSI2 resource descriptors */
+	ctx->csi2.handle_count += 1 + inst_context.handle_count;
+}
+
+struct acpi_handle_ref {
+	acpi_handle handle;
+	unsigned int count;
+};
+
+#define NO_CSI2_PORT (UINT_MAX - 1)
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
+static void acpi_crs_csi2_alloc_fill_swnodes(size_t ports_count, acpi_handle handle)
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
+	ads = kmalloc(alloc_size, GFP_KERNEL);
+	if (!swnodes || !ads)
+		goto out_free;
+
+	ads->ports = (void *)(ads + 1);
+	ads->nodes = (void *)(ads->ports + ports_count);
+	ads->nodeptrs = (void *)(ads->nodes + ports_count * 2 + 1);
+	end = ads->nodeptrs + ports_count * 2 + 2;
+	if (WARN_ON((void *)ads + alloc_size != end))
+		goto out_free;
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
+
+	return;
+
+out_free:
+	kfree(swnodes);
+	kfree(ads);
+	acpi_handle_debug(handle, "cannot allocate for %zu software nodes\n",
+			  ports_count);
+}
+
+/**
+ * acpi_bus_scan_crs_csi2 - Construct software nodes out of ACPI _CRS CSI2
+ *			    resource descriptors
+ * @ctx: ACPI _CRS CSI2 context, gathered during tree walk earlier
+ *
+ * This function does a number of things:
+ *
+ * 1. Count how many references to other devices _CRS CSI-2 instances have in
+ *    total.
+ *
+ * 2. Count the number of references to other devices for each _CRS CSI-2
+ *    instance.
+ *
+ * 3. Allocate memory for swnodes each ACPI device requires later on, and
+ *    generate a list of such allocations.
+ *
+ * Note that struct acpi_device may not be available yet at this time.
+ *
+ * acpi_scan_lock in scan.c must be held when calling this function.
+ */
+void acpi_bus_scan_crs_csi2(struct acpi_scan_context_csi2 *ctx)
+{
+	struct acpi_handle_ref *handle_refs;
+	struct acpi_handle_ref *this = NULL;
+	size_t this_count;
+	unsigned int curr = 0;
+	struct crs_csi2 *csi2;
+
+	/* No handles? Bail out here. */
+	if (!ctx->handle_count)
+		return;
+
+	handle_refs = kcalloc(ctx->handle_count + 1, sizeof(*handle_refs),
+			      GFP_KERNEL);
+	if (!handle_refs) {
+		pr_debug("no memory for %zu handle refs\n",
+			 ctx->handle_count + 1);
+		return;
+	}
+
+	/* Associate handles to the number of references. */
+	list_for_each_entry(csi2, &ctx->crs_csi2_head, list) {
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
+	/* Sort the handles by remote so duplicates canbe easily found. */
+	sort(handle_refs, ctx->handle_count, sizeof(*handle_refs), crs_handle_cmp, NULL);
+
+	/*
+	 * Finally count references in each handle, allocate space for device
+	 * specific ports, properties and fill the _CRS CSI2 descriptor
+	 * originated data.
+	 */
+	this = handle_refs;
+	this_count = this->count;
+	for (curr = 1; curr < ctx->handle_count + 1; curr++) {
+		/* Weed out duplicate receiver devices. */
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
+	crs_csi2_release(&ctx->crs_csi2_head);
+}
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index df97c2babf39..4f4f6b0db0a9 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2042,16 +2042,6 @@ struct acpi_postponed_handle {
 	struct list_head list;
 };
 
-/**
- * struct acpi_scan_context - Context for scanning ACPI devices
- * @device: The first encountered device, typically the root of the scanned tree
- * @postponed_head: The list head of the postponed ACPI handles
- */
-struct acpi_scan_context {
-	struct acpi_device *device;
-	struct list_head postponed_head;
-};
-
 /**
  * acpi_bus_handle_postpone - Add an ACPI handle to a given postponed list
  * @handle: The ACPI handle
@@ -2073,7 +2063,7 @@ static void acpi_bus_handle_postpone(acpi_handle handle,
 	list_add(&ph->list, head);
 }
 
-static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
+static acpi_status acpi_bus_check_add(acpi_handle handle, bool first_pass,
 				      struct acpi_scan_context *ctx)
 {
 	struct acpi_device *device = acpi_fetch_acpi_dev(handle);
@@ -2091,8 +2081,11 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
 		if (acpi_device_should_be_hidden(handle))
 			return AE_OK;
 
+		if (first_pass)
+			acpi_bus_scan_check_crs_csi2(handle, ctx);
+
 		/* Bail out if there are dependencies. */
-		if (acpi_scan_check_dep(handle, check_dep) > 0) {
+		if (acpi_scan_check_dep(handle, first_pass) > 0) {
 			acpi_bus_handle_postpone(handle, &ctx->postponed_head);
 			return AE_CTRL_DEPTH;
 		}
@@ -2118,10 +2111,10 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
 	}
 
 	/*
-	 * If check_dep is true at this point, the device has no dependencies,
+	 * If first_pass is true at this point, the device has no dependencies,
 	 * or the creation of the device object would have been postponed above.
 	 */
-	acpi_add_single_object(&device, handle, type, !check_dep);
+	acpi_add_single_object(&device, handle, type, !first_pass);
 	if (!device)
 		return AE_CTRL_DEPTH;
 
@@ -2146,6 +2139,14 @@ static acpi_status acpi_bus_check_add_2(acpi_handle handle, u32 lvl_not_used,
 	return acpi_bus_check_add(handle, false, (struct acpi_scan_context *)ctx);
 }
 
+static acpi_status acpi_bus_check_csi2(acpi_handle handle, u32 lvl_not_used,
+				       void *ctx, void **unused)
+{
+	acpi_bus_scan_check_crs_csi2(handle, ctx);
+
+	return AE_OK;
+}
+
 static void acpi_default_enumeration(struct acpi_device *device)
 {
 	/*
@@ -2466,6 +2467,7 @@ int acpi_bus_scan(acpi_handle handle)
 {
 	struct acpi_scan_context ctx = {
 		.postponed_head = LIST_HEAD_INIT(ctx.postponed_head),
+		.csi2.crs_csi2_head = LIST_HEAD_INIT(ctx.csi2.crs_csi2_head),
 	};
 	struct acpi_postponed_handle *ph, *tmp_ph;
 	int ret = 0;
@@ -2480,6 +2482,20 @@ int acpi_bus_scan(acpi_handle handle)
 		goto out_release;
 	}
 
+	/*
+	 * Check _CRS CSI2 resource descriptors for devices that were not
+	 * traversed during the previous pass.
+	 */
+	list_for_each_entry_safe(ph, tmp_ph, &ctx.postponed_head, list) {
+		acpi_bus_check_csi2(ph->handle, 0, &ctx, NULL);
+		acpi_walk_namespace(ACPI_TYPE_DEVICE, ph->handle, ACPI_UINT32_MAX,
+				    acpi_bus_check_csi2, NULL, (void *)&ctx,
+				    NULL);
+	}
+
+	/* Construct software nodes out of _CRS CSI2 records */
+	acpi_bus_scan_crs_csi2(&ctx.csi2);
+
 	acpi_bus_attach(ctx.device, (void *)true);
 
 	/*
@@ -2511,6 +2527,8 @@ int acpi_bus_scan(acpi_handle handle)
 		kfree(ph);
 	}
 
+	acpi_crs_csi2_swnodes_del_free();
+
 	return ret;
 }
 EXPORT_SYMBOL(acpi_bus_scan);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index a6affc0550b0..71a6f0502f2c 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -361,6 +361,17 @@ struct acpi_device_data {
 
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

