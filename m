Return-Path: <linux-acpi+bounces-804-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E375B7D1411
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 18:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120761C209BE
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 16:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745861EA64
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE021C2B0
	for <linux-acpi@vger.kernel.org>; Fri, 20 Oct 2023 14:49:56 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EDFD5D;
	Fri, 20 Oct 2023 07:49:52 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 71104125aa3a43ca; Fri, 20 Oct 2023 16:49:51 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id F009B667008;
	Fri, 20 Oct 2023 16:49:50 +0200 (CEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/6] ACPI: scan: Extract CSI-2 connection graph from _CRS
Date: Fri, 20 Oct 2023 16:36:28 +0200
Message-ID: <3288922.44csPzL39Z@kreacher>
In-Reply-To: <2187487.irdbgypaU6@kreacher>
References: <2187487.irdbgypaU6@kreacher>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrjeekgdektdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeektddvveeijeekveekvdffieffheeitdehkeekfeeiheffkefgledtheelhedvudenucffohhmrghinhepuhgvfhhirdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepfedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghkrghrihdrrghilhhusheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Find ACPI CSI-2 resource descriptors defined since ACPI 6.4 (for
CSI-2 and camera configuration) in _CRS for all device objects in
the given scope of the ACPI namespace that have them, identify the
corresponding "remote endpoint" device objects for them and
allocate memory for software nodes needed to create a DT-like data
structure representing the CSI-2 connection graph for drivers.

The code needed to populate these software nodes will be added by
subsequent change sets.

Link: https://uefi.org/specs/ACPI/6.5/06_Device_Configuration.html#camera-serial-interface-csi-2-connection-resource-descriptor
Co-developed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/Makefile   |    2 
 drivers/acpi/internal.h |    8 +
 drivers/acpi/mipi-di.c  |  295 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/scan.c     |   48 ++++++-
 include/acpi/acpi_bus.h |   18 ++
 5 files changed, 361 insertions(+), 10 deletions(-)
 create mode 100644 drivers/acpi/mipi-di.c

Index: linux-pm/drivers/acpi/Makefile
===================================================================
--- linux-pm.orig/drivers/acpi/Makefile
+++ linux-pm/drivers/acpi/Makefile
@@ -37,7 +37,7 @@ acpi-$(CONFIG_ACPI_SLEEP)	+= proc.o
 # ACPI Bus and Device Drivers
 #
 acpi-y				+= bus.o glue.o
-acpi-y				+= scan.o
+acpi-y				+= scan.o mipi-di.o
 acpi-y				+= resource.o
 acpi-y				+= acpi_processor.o
 acpi-y				+= processor_core.o
Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -281,4 +281,12 @@ void acpi_init_lpit(void);
 static inline void acpi_init_lpit(void) { }
 #endif
 
+/*--------------------------------------------------------------------------
+		ACPI _CRS CSI-2 and MIPI DisCo for Imaging
+  -------------------------------------------------------------------------- */
+
+void acpi_mipi_check_crs_csi2(acpi_handle handle);
+void acpi_mipi_scan_crs_csi2(void);
+void acpi_mipi_crs_csi2_cleanup(void);
+
 #endif /* _ACPI_INTERNAL_H_ */
Index: linux-pm/drivers/acpi/mipi-di.c
===================================================================
--- /dev/null
+++ linux-pm/drivers/acpi/mipi-di.c
@@ -0,0 +1,295 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MIPI DisCo for Imaging support.
+ *
+ * Copyright (C) 2023 Intel Corporation
+ *
+ * Support MIPI DisCo for Imaging by parsing ACPI _CRS CSI-2 records defined in
+ * Section 6.4.3.8.2.4 "Camera Serial Interface (CSI-2) Connection Resource
+ * Descriptor" of ACPI 6.5.
+ *
+ * The implementation looks for the information in the ACPI namespace (CSI-2
+ * resource descriptors in _CRS) and constructs software nodes compatible with
+ * Documentation/firmware-guide/acpi/dsd/graph.rst to represent the CSI-2
+ * connection graph.
+ */
+
+#include <linux/acpi.h>
+#include <linux/limits.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/overflow.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "internal.h"
+
+static LIST_HEAD(acpi_mipi_crs_csi2_list);
+
+static void acpi_mipi_data_tag(acpi_handle handle, void *context)
+{
+}
+
+/* Connection data extracted from one _CRS CSI-2 resource descriptor. */
+struct crs_csi2_connection {
+	struct list_head entry;
+	struct acpi_resource_csi2_serialbus csi2_data;
+	acpi_handle remote_handle;
+	char remote_name[];
+};
+
+/* Data extracted from _CRS CSI-2 resource descriptors for one device. */
+struct crs_csi2 {
+	struct list_head entry;
+	acpi_handle handle;
+	struct acpi_device_software_nodes *swnodes;
+	struct list_head connections;
+	u32 port_count;
+};
+
+struct csi2_resources_walk_data {
+	acpi_handle handle;
+	struct list_head connections;
+};
+
+static acpi_status parse_csi2_resource(struct acpi_resource *res, void *context)
+{
+	struct csi2_resources_walk_data *crwd = context;
+	struct acpi_resource_csi2_serialbus *csi2_res;
+	struct acpi_resource_source *csi2_res_src;
+	u16 csi2_res_src_length;
+	struct crs_csi2_connection *conn;
+	acpi_handle remote_handle;
+
+	if (res->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
+		return AE_OK;
+
+	csi2_res = &res->data.csi2_serial_bus;
+
+	if (csi2_res->type != ACPI_RESOURCE_SERIAL_TYPE_CSI2)
+		return AE_OK;
+
+	csi2_res_src = &csi2_res->resource_source;
+	if (ACPI_FAILURE(acpi_get_handle(NULL, csi2_res_src->string_ptr,
+					 &remote_handle))) {
+		acpi_handle_debug(crwd->handle,
+				  "unable to find resource source\n");
+		return AE_OK;
+	}
+	csi2_res_src_length = csi2_res_src->string_length;
+	if (!csi2_res_src_length) {
+		acpi_handle_debug(crwd->handle,
+				  "invalid resource source string length\n");
+		return AE_OK;
+	}
+
+	conn = kmalloc(struct_size(conn, remote_name, csi2_res_src_length + 1),
+		       GFP_KERNEL);
+	if (!conn)
+		return AE_OK;
+
+	conn->csi2_data = *csi2_res;
+	strscpy(conn->remote_name, csi2_res_src->string_ptr, csi2_res_src_length);
+	conn->csi2_data.resource_source.string_ptr = conn->remote_name;
+	conn->remote_handle = remote_handle;
+
+	list_add(&conn->entry, &crwd->connections);
+
+	return AE_OK;
+}
+
+static struct crs_csi2 *acpi_mipi_add_crs_csi2(acpi_handle handle,
+					       struct list_head *list)
+{
+	struct crs_csi2 *csi2;
+
+	csi2 = kzalloc(sizeof(*csi2), GFP_KERNEL);
+	if (!csi2)
+		return NULL;
+
+	csi2->handle = handle;
+	INIT_LIST_HEAD(&csi2->connections);
+	csi2->port_count = 1;
+
+	if (ACPI_FAILURE(acpi_attach_data(handle, acpi_mipi_data_tag, csi2))) {
+		kfree(csi2);
+		return NULL;
+	}
+
+	list_add(&csi2->entry, list);
+
+	return csi2;
+}
+
+static struct crs_csi2 *acpi_mipi_get_crs_csi2(acpi_handle handle)
+{
+	struct crs_csi2 *csi2;
+
+	if (ACPI_FAILURE(acpi_get_data_full(handle, acpi_mipi_data_tag,
+					    (void **)&csi2, NULL)))
+		return NULL;
+
+	return csi2;
+}
+
+static void csi_csr2_release_connections(struct list_head *list)
+{
+	struct crs_csi2_connection *conn, *conn_tmp;
+
+	list_for_each_entry_safe(conn, conn_tmp, list, entry) {
+		list_del(&conn->entry);
+		kfree(conn);
+	}
+}
+
+static void acpi_mipi_del_crs_csi2(struct crs_csi2 *csi2)
+{
+	list_del(&csi2->entry);
+	acpi_detach_data(csi2->handle, acpi_mipi_data_tag);
+	kfree(csi2->swnodes);
+	csi_csr2_release_connections(&csi2->connections);
+	kfree(csi2);
+}
+
+/**
+ * acpi_mipi_check_crs_csi2 - Look for devices with _CRS CSI-2 resources
+ * @handle: ACPI namespace walk starting point.
+ *
+ * Find all devices with _CRS CSI-2 resource descriptors in the ACPI namespace
+ * branch starting at @handle and collect them into a list.
+ */
+void acpi_mipi_check_crs_csi2(acpi_handle handle)
+{
+	struct csi2_resources_walk_data crwd = {
+		.handle = handle,
+		.connections = LIST_HEAD_INIT(crwd.connections),
+	};
+	struct crs_csi2 *csi2;
+
+	/*
+	 * Avoid allocating _CRS CSI-2 objects for devices without any CSI-2
+	 * resource descriptions in _CRS to reduce overhead.
+	 */
+	acpi_walk_resources(handle, METHOD_NAME__CRS, parse_csi2_resource, &crwd);
+	if (list_empty(&crwd.connections))
+		return;
+
+	/*
+	 * Create a _CRS CSI-2 entry to store the extracted connection
+	 * information and add it to the global list.
+	 */
+	csi2 = acpi_mipi_add_crs_csi2(handle, &acpi_mipi_crs_csi2_list);
+	if (!csi2) {
+		csi_csr2_release_connections(&crwd.connections);
+		return; /* Nothing really can be done about this. */
+	}
+
+	list_replace(&crwd.connections, &csi2->connections);
+}
+
+#define NO_CSI2_PORT (UINT_MAX - 1)
+
+static void alloc_crs_csi2_swnodes(struct crs_csi2 *csi2)
+{
+	size_t port_count = csi2->port_count;
+	struct acpi_device_software_nodes *swnodes;
+	size_t alloc_size;
+	unsigned int i;
+
+	/*
+	 * Allocate memory for ports, node pointers (number of nodes +
+	 * 1 (guardian), nodes (root + number of ports * 2 (because for
+	 * every port there is an endpoint)).
+	 */
+	if (check_mul_overflow(sizeof(*swnodes->ports) +
+			       sizeof(*swnodes->nodes) * 2 +
+			       sizeof(*swnodes->nodeptrs) * 2,
+			       port_count, &alloc_size))
+		goto overflow;
+
+	if (check_add_overflow(sizeof(*swnodes) +
+			       sizeof(*swnodes->nodes) +
+			       sizeof(*swnodes->nodeptrs) * 2,
+			       alloc_size, &alloc_size))
+		goto overflow;
+
+	swnodes = kmalloc(alloc_size, GFP_KERNEL);
+	if (!swnodes)
+		return;
+
+	swnodes->ports = (struct acpi_device_software_node_port *)(swnodes + 1);
+	swnodes->nodes = (struct software_node *)(swnodes->ports + port_count);
+	swnodes->nodeptrs = (const struct software_node **)(swnodes->nodes + 1 +
+				2 * port_count);
+	swnodes->num_ports = port_count;
+
+	for (i = 0; i < 2 * port_count + 1; i++)
+		swnodes->nodeptrs[i] = &swnodes->nodes[i];
+
+	swnodes->nodeptrs[i] = NULL;
+
+	for (i = 0; i < port_count; i++)
+		swnodes->ports[i].port_nr = NO_CSI2_PORT;
+
+	csi2->swnodes = swnodes;
+	return;
+
+overflow:
+	acpi_handle_info(csi2->handle, "too many _CRS CSI-2 resource handles (%zu)",
+			 port_count);
+}
+
+/**
+ * acpi_mipi_scan_crs_csi2 - Create ACPI _CRS CSI-2 software nodes
+ *
+ * Note that this function must be called before any struct acpi_device objects
+ * are bound to any ACPI drivers or scan handlers, so it cannot assume the
+ * existence of struct acpi_device objects for every device present in the ACPI
+ * namespace.
+ *
+ * acpi_scan_lock in scan.c must be held when calling this function.
+ */
+void acpi_mipi_scan_crs_csi2(void)
+{
+	struct crs_csi2 *csi2;
+	LIST_HEAD(aux_list);
+
+	/* Count references to each ACPI handle in the CSI-2 connection graph. */
+	list_for_each_entry(csi2, &acpi_mipi_crs_csi2_list, entry) {
+		struct crs_csi2_connection *conn;
+
+		list_for_each_entry(conn, &csi2->connections, entry) {
+			struct crs_csi2 *remote_csi2;
+
+			csi2->port_count++;
+
+			remote_csi2 = acpi_mipi_get_crs_csi2(conn->remote_handle);
+			if (remote_csi2) {
+				remote_csi2->port_count++;
+				continue;
+			}
+			/*
+			 * The remote endpoint has no _CRS CSI-2 list entry yet,
+			 * so create one for it and add it to the list.
+			 */
+			acpi_mipi_add_crs_csi2(conn->remote_handle, &aux_list);
+		}
+	}
+	list_splice(&aux_list, &acpi_mipi_crs_csi2_list);
+
+	/* Allocate softwware nodes for representing the CSI-2 information. */
+	list_for_each_entry(csi2, &acpi_mipi_crs_csi2_list, entry)
+		alloc_crs_csi2_swnodes(csi2);
+}
+
+/**
+ * acpi_mipi_crs_csi2_cleanup - Free _CRS CSI-2 temporary data
+ */
+void acpi_mipi_crs_csi2_cleanup(void)
+{
+	struct crs_csi2 *csi2, *csi2_tmp;
+
+	list_for_each_entry_safe(csi2, csi2_tmp, &acpi_mipi_crs_csi2_list, entry)
+		acpi_mipi_del_crs_csi2(csi2);
+}
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -366,6 +366,24 @@ struct acpi_device_data {
 
 struct acpi_gpio_mapping;
 
+struct acpi_device_software_node_port {
+	unsigned int port_nr;
+};
+
+/**
+ * struct acpi_device_software_nodes - Software nodes for an ACPI device
+ * @nodes: Software nodes for root as well as ports and endpoints.
+ * @nodeprts: Array of software node pointers, for (un)registering them.
+ * @ports: Information related to each port and endpoint within a port.
+ * @num_ports: The number of ports.
+ */
+struct acpi_device_software_nodes {
+	struct software_node *nodes;
+	const struct software_node **nodeptrs;
+	struct acpi_device_software_node_port *ports;
+	unsigned int num_ports;
+};
+
 /* Device */
 struct acpi_device {
 	u32 pld_crc;
Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -1976,7 +1976,7 @@ static void acpi_scan_init_hotplug(struc
 	}
 }
 
-static u32 acpi_scan_check_dep(acpi_handle handle, bool check_dep)
+static u32 acpi_scan_check_dep(acpi_handle handle)
 {
 	struct acpi_handle_list dep_devices;
 	acpi_status status;
@@ -1989,8 +1989,7 @@ static u32 acpi_scan_check_dep(acpi_hand
 	 * 2. ACPI nodes describing USB ports.
 	 * Still, checking for _HID catches more then just these cases ...
 	 */
-	if (!check_dep || !acpi_has_method(handle, "_DEP") ||
-	    !acpi_has_method(handle, "_HID"))
+	if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID"))
 		return 0;
 
 	status = acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices);
@@ -2036,7 +2035,13 @@ static u32 acpi_scan_check_dep(acpi_hand
 	return count;
 }
 
-static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
+static acpi_status acpi_scan_check_crs_csi2_cb(acpi_handle handle, u32 a, void *b, void **c)
+{
+	acpi_mipi_check_crs_csi2(handle);
+	return AE_OK;
+}
+
+static acpi_status acpi_bus_check_add(acpi_handle handle, bool first_pass,
 				      struct acpi_device **adev_p)
 {
 	struct acpi_device *device = acpi_fetch_acpi_dev(handle);
@@ -2054,9 +2059,25 @@ static acpi_status acpi_bus_check_add(ac
 		if (acpi_device_should_be_hidden(handle))
 			return AE_OK;
 
-		/* Bail out if there are dependencies. */
-		if (acpi_scan_check_dep(handle, check_dep) > 0)
-			return AE_CTRL_DEPTH;
+		if (first_pass) {
+			acpi_mipi_check_crs_csi2(handle);
+
+			/* Bail out if there are dependencies. */
+			if (acpi_scan_check_dep(handle) > 0) {
+				/*
+				 * The entire CSI-2 connection graph needs to be
+				 * extracted before any drivers or scan handlers
+				 * are bound to struct device objects, so scan
+				 * _CRS CSI-2 resource descriptors for all
+				 * devices below the current handle.
+				 */
+				acpi_walk_namespace(ACPI_TYPE_DEVICE, handle,
+						    ACPI_UINT32_MAX,
+						    acpi_scan_check_crs_csi2_cb,
+						    NULL, NULL, NULL);
+				return AE_CTRL_DEPTH;
+			}
+		}
 
 		fallthrough;
 	case ACPI_TYPE_ANY:	/* for ACPI_ROOT_OBJECT */
@@ -2079,10 +2100,10 @@ static acpi_status acpi_bus_check_add(ac
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
 
@@ -2494,12 +2515,21 @@ int acpi_bus_scan(acpi_handle handle)
 	if (!device)
 		return -ENODEV;
 
+	/*
+	 * Allocate ACPI _CRS CSI-2 software nodes using information extracted
+	 * from the _CRS CSI-2 resource descriptors during the ACPI namespace
+	 * walk above.
+	 */
+	acpi_mipi_scan_crs_csi2();
+
 	acpi_bus_attach(device, (void *)true);
 
 	/* Pass 2: Enumerate all of the remaining devices. */
 
 	acpi_scan_postponed();
 
+	acpi_mipi_crs_csi2_cleanup();
+
 	return 0;
 }
 EXPORT_SYMBOL(acpi_bus_scan);




