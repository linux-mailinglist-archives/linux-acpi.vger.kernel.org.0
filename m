Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AE8703424
	for <lists+linux-acpi@lfdr.de>; Mon, 15 May 2023 18:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242929AbjEOQpQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 May 2023 12:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242928AbjEOQpQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 May 2023 12:45:16 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CAC4ECB;
        Mon, 15 May 2023 09:45:12 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id ee62a130fbc1a27d; Mon, 15 May 2023 18:45:11 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 03D7B795F02;
        Mon, 15 May 2023 18:45:11 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     linux-acpi@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v8 03/10] ACPI: property: Parse _CRS CSI-2 descriptor
Date:   Mon, 15 May 2023 18:45:10 +0200
Message-ID: <1865464.tdWV9SEqCh@kreacher>
In-Reply-To: <20230329100951.1522322-4-sakari.ailus@linux.intel.com>
References: <20230329100951.1522322-1-sakari.ailus@linux.intel.com> <20230329100951.1522322-4-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehjedguddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeefudduuedtuefgleffudeigeeitdeufeelvdejgefftdethffhhfethfeljefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghkrghrihdrrghilhhusheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdhmvgguihgrsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghl
 sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohephhgvihhkkhhirdhkrhhoghgvrhhusheslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wednesday, March 29, 2023 12:09:44 PM CEST Sakari Ailus wrote:
> Parse newly added ACPI _CRS CSI-2 descriptor for CSI-2 and camera
> configuration, associate it with appropriate devices and allocate memory for
> software nodes needed to create a DT-like data structure for drivers.

It occurred to me, that there would be so many things I would like to change
in this patch, so it would be better to create my own version of it, which
is appended.

It is based on

https://patchwork.kernel.org/project/linux-acpi/patch/2694293.mvXUDI8C0e@kreacher/

that has just been posted.

IIUC, the idea is to extract the ACPI handle for each resource source in every
_CRS CSI-2 resource descriptor and count how many times each handle appears in
a CSI-2 context, either because it is referenced from a _CRS CSI-2 resource
descriptor (as a "resource source"), or because its device object has CSI-2
resource descriptors in _CRS.

This allows a set of software nodes to be allocated for each of these handles.

If I got that totally wrong, please let me know.  Otherwise, I will rework the
remaining patches in the series to match this one.

Thanks!
---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] ACPI: scan: Parse _CRS CSI-2 descriptors for all devices

Parse ACPI _CRS CSI-2 resource descriptors defined since ACPI 6.4 (for CSI-2 and
camera configuration) for all device objects in the ACPI namespace, find the
corresponding "remote" device objects for them and allocate memory for software
nodes needed to create a DT-like data structure for drivers (that will be taken
care of by subsequent patches).

Co-developed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/Makefile             |    2 
 drivers/acpi/internal.h           |    7 
 drivers/acpi/mipi-disco-imaging.c |  313 ++++++++++++++++++++++++++++++++++++++
 drivers/acpi/scan.c               |   49 ++++-
 include/acpi/acpi_bus.h           |   11 +
 5 files changed, 372 insertions(+), 10 deletions(-)
 create mode 100644 drivers/acpi/mipi-disco-imaging.c

Index: linux-pm/drivers/acpi/Makefile
===================================================================
--- linux-pm.orig/drivers/acpi/Makefile
+++ linux-pm/drivers/acpi/Makefile
@@ -37,7 +37,7 @@ acpi-$(CONFIG_ACPI_SLEEP)	+= proc.o
 # ACPI Bus and Device Drivers
 #
 acpi-y				+= bus.o glue.o
-acpi-y				+= scan.o
+acpi-y				+= scan.o mipi-disco-imaging.o
 acpi-y				+= resource.o
 acpi-y				+= acpi_processor.o
 acpi-y				+= processor_core.o
Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -282,4 +282,11 @@ void acpi_init_lpit(void);
 static inline void acpi_init_lpit(void) { }
 #endif
 
+/*--------------------------------------------------------------------------
+		ACPI _CRS CSI-2 and MIPI DisCo for Imaging
+  -------------------------------------------------------------------------- */
+
+void acpi_mipi_check_crs_csi2(acpi_handle handle);
+void acpi_mipi_scan_crs_csi2(void);
+
 #endif /* _ACPI_INTERNAL_H_ */
Index: linux-pm/drivers/acpi/mipi-disco-imaging.c
===================================================================
--- /dev/null
+++ linux-pm/drivers/acpi/mipi-disco-imaging.c
@@ -0,0 +1,313 @@
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
+ * resource descriptors in _CRS) and constructs software nodes that are
+ * compatible with Documentation/firmware-guide/acpi/dsd/graph.rst.
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
+static LIST_HEAD(acpi_mipi_crs_csi2_list);
+
+/*
+ * List entry for the list of devices with software nodes allocated in
+ * accordance with the information from _CRS CSI-2 device desciptiors.
+ */
+struct crs_csi2_dev_swnodes {
+	struct list_head entry;
+	acpi_handle handle;
+	struct acpi_device_software_nodes *swnodes;
+};
+
+static LIST_HEAD(crs_csi2_swnodes);
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
+	struct list_head connections;
+	u32 port_count;
+};
+
+static acpi_status csi2_resource_extract(struct acpi_resource *res, void *context)
+{
+	struct crs_csi2 *csi2 = context;
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
+		acpi_handle_debug(csi2->handle,
+				  "unable to find resource source\n");
+		return AE_OK;
+	}
+	csi2_res_src_length = csi2_res_src->string_length;
+	if (!csi2_res_src_length) {
+		acpi_handle_debug(csi2->handle,
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
+	list_add(&conn->entry, &csi2->connections);
+
+	return AE_OK;
+}
+
+static struct crs_csi2 *create_crs_csi2_entry(acpi_handle handle)
+{
+	struct crs_csi2 *csi2_entry;
+
+	csi2_entry = kzalloc(sizeof(*csi2_entry), GFP_KERNEL);
+	if (!csi2_entry)
+		return NULL;
+
+	csi2_entry->handle = handle;
+	INIT_LIST_HEAD(&csi2_entry->connections);
+	csi2_entry->port_count = 1;
+
+	if (ACPI_FAILURE(acpi_attach_data(handle, acpi_mipi_data_tag, csi2_entry))) {
+		kfree(csi2_entry);
+		return NULL;
+	}
+
+	return csi2_entry;
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
+	struct crs_csi2 csi2 = {
+		.handle = handle,
+		.connections = LIST_HEAD_INIT(csi2.connections),
+	};
+	struct crs_csi2 *csi2_entry;
+
+	/*
+	 * Avoid creating _CRS CSI-2 list entries for devices without any CSI-2
+	 * resource descriptions in _CRS to reduce overhead.
+	 */
+	acpi_walk_resources(handle, METHOD_NAME__CRS, csi2_resource_extract, &csi2);
+	if (list_empty(&csi2.connections))
+		return;
+
+	/*
+	 * Create a _CRS CSI-2 entry to store the extracted connection
+	 * information and add it to the global list.
+	 */
+	csi2_entry = create_crs_csi2_entry(handle);
+	if (!csi2_entry)
+		return; /* There's nothing we really can do about this. */
+
+	list_replace(&csi2.connections, &csi2_entry->connections);
+	list_add(&csi2_entry->entry, &acpi_mipi_crs_csi2_list);
+}
+
+#define NO_CSI2_PORT (UINT_MAX - 1)
+
+static void alloc_fill_crs_csi2_swnodes(acpi_handle handle, size_t port_count)
+{
+	struct acpi_device_software_nodes *swnodes;
+	struct crs_csi2_dev_swnodes *swnodes_entry;
+	size_t alloc_size;
+	unsigned int i;
+	bool overflow;
+
+	/*
+	 * Allocate memory for ports, node pointers (number of nodes +
+	 * 1 (guardian), nodes (root + number of ports * 2 (because for
+	 * every port there is an endpoint)).
+	 */
+	overflow = check_mul_overflow(sizeof(*swnodes->ports) +
+				      sizeof(*swnodes->nodes) * 2 +
+				      sizeof(*swnodes->nodeptrs) * 2,
+				      port_count, &alloc_size);
+	overflow = overflow ||
+		   check_add_overflow(sizeof(*swnodes) +
+				      sizeof(*swnodes->nodes) +
+				      sizeof(*swnodes->nodeptrs) * 2,
+				      alloc_size, &alloc_size);
+	if (overflow) {
+		acpi_handle_warn(handle,
+				 "too many _CRS CSI-2 resource handles (%zu)",
+				 port_count);
+		return;
+	}
+
+	swnodes_entry = kzalloc(sizeof(*swnodes_entry), GFP_KERNEL);
+	swnodes = kmalloc(alloc_size, GFP_KERNEL);
+	if (!swnodes_entry || !swnodes)
+		goto out_free;
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
+	swnodes_entry->handle = handle;
+	swnodes_entry->swnodes = swnodes;
+
+	list_add(&swnodes_entry->entry, &crs_csi2_swnodes);
+
+	return;
+
+out_free:
+	kfree(swnodes_entry);
+	kfree(swnodes);
+	acpi_handle_debug(handle, "unable to allocate for %zu software nodes\n",
+			  port_count);
+}
+
+static void acpi_mipi_crs_csi2_release(void)
+{
+	struct crs_csi2 *csi2, *csi2_tmp;
+
+	list_for_each_entry_safe(csi2, csi2_tmp, &acpi_mipi_crs_csi2_list, entry) {
+		struct crs_csi2_connection *conn, *conn_tmp;
+
+		list_for_each_entry_safe(conn, conn_tmp, &csi2->connections,
+					 entry) {
+			list_del(&conn->entry);
+			kfree(conn);
+		}
+
+		list_del(&csi2->entry);
+		acpi_detach_data(csi2->handle, acpi_mipi_data_tag);
+		kfree(csi2);
+	}
+}
+
+/**
+ * acpi_mipi_scan_crs_csi2 - Allocate ACPI _CRS CSI-2 software nodes
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
+			acpi_status status;
+
+			status = acpi_get_data_full(conn->remote_handle,
+						    acpi_mipi_data_tag,
+						    (void **)&remote_csi2,
+						    NULL);
+			if (ACPI_SUCCESS(status) && remote_csi2) {
+				remote_csi2->port_count++;
+				continue;
+			}
+
+			/*
+			 * The "remote" device has no _CRS CSI-2 list entry yet,
+			 * so create one for it and add it to the list.
+			 */
+			remote_csi2 = create_crs_csi2_entry(conn->remote_handle);
+			if (!remote_csi2)
+				continue;
+
+			list_add(&remote_csi2->entry, &aux_list);
+		}
+	}
+	list_splice(&aux_list, &acpi_mipi_crs_csi2_list);
+
+	/* Allocate softwware nodes for representing the CSI-2 information. */
+	list_for_each_entry(csi2, &acpi_mipi_crs_csi2_list, entry)
+		alloc_fill_crs_csi2_swnodes(csi2->handle, csi2->port_count);
+
+	acpi_mipi_crs_csi2_release();
+}
+
+static void crs_csi2_swnode_del_free(struct crs_csi2_dev_swnodes *swnodes)
+{
+	list_del(&swnodes->entry);
+	kfree(swnodes);
+}
+
+/**
+ * acpi_mipi_swnodes_release - Free the list of devices with _CRS CSI-2 swnodes
+ */
+void acpi_mipi_swnodes_release(void)
+{
+	struct crs_csi2_dev_swnodes *sn, *sn_tmp;
+
+	list_for_each_entry_safe(sn, sn_tmp, &crs_csi2_swnodes, entry)
+		crs_csi2_swnode_del_free(sn);
+}
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -363,6 +363,17 @@ struct acpi_device_data {
 
 struct acpi_gpio_mapping;
 
+struct acpi_device_software_node_port {
+	unsigned int port_nr;
+};
+
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
@@ -1970,7 +1970,7 @@ static void acpi_scan_init_hotplug(struc
 	}
 }
 
-static u32 acpi_scan_check_dep(acpi_handle handle, bool check_dep)
+static u32 acpi_scan_check_dep(acpi_handle handle)
 {
 	struct acpi_handle_list dep_devices;
 	acpi_status status;
@@ -1983,8 +1983,7 @@ static u32 acpi_scan_check_dep(acpi_hand
 	 * 2. ACPI nodes describing USB ports.
 	 * Still, checking for _HID catches more then just these cases ...
 	 */
-	if (!check_dep || !acpi_has_method(handle, "_DEP") ||
-	    !acpi_has_method(handle, "_HID"))
+	if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID"))
 		return 0;
 
 	status = acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices);
@@ -2029,7 +2028,16 @@ static u32 acpi_scan_check_dep(acpi_hand
 	return count;
 }
 
-static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
+static acpi_status acpi_scan_check_crs_csi2_cb(acpi_handle handle,
+					       u32 lvl_not_used,
+					       void *not_used,
+					       void **ret_p_not_used)
+{
+	acpi_mipi_check_crs_csi2(handle);
+	return AE_OK;
+}
+
+static acpi_status acpi_bus_check_add(acpi_handle handle, bool first_pass,
 				      struct acpi_device **adev_p)
 {
 	struct acpi_device *device = acpi_fetch_acpi_dev(handle);
@@ -2047,9 +2055,25 @@ static acpi_status acpi_bus_check_add(ac
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
@@ -2072,10 +2096,10 @@ static acpi_status acpi_bus_check_add(ac
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
 
@@ -2487,6 +2511,13 @@ int acpi_bus_scan(acpi_handle handle)
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



