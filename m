Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B3A6CBC41
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Mar 2023 12:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjC1KOL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Mar 2023 06:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbjC1KN7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2023 06:13:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9DD7686;
        Tue, 28 Mar 2023 03:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679998421; x=1711534421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2JW1Eec/tOCwHhWCKBzCvwq189YZAIhh+7YDObl4o1I=;
  b=IYbK+nNnnS7ihLq1qabpVCtfNdl5WSivajkJTQ8svWcHfjRbniEo/BVF
   NMKmBdc9YlhfUYrnxNyqLkiotuq3xYMNg3Ei5bXQE+d4TAgL+7OxTihwk
   Xqp1apDoC4tbF9rXC7DDmutYdzrPa3Sch+9/c87ZEZegNYhF+C95G3EuK
   yy6Qzy7dwHoeMOIsGw+KLTEhOmDghJgIK2JxAXHuH+yOvGgWhi7cS5KkV
   EETWzA8f153/O1zoHF8fP23JS+DUcy9rkfW/rrcCqljoZeai3PQ/4quI1
   vHmtXbY80uYh0zQdAcy47P5bhljyzyoANdW89YY7E71ps5PfLeP5QSFwu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328985343"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="328985343"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 03:13:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="827432697"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="827432697"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 03:13:12 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 2080111F937;
        Tue, 28 Mar 2023 13:13:10 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v7 05/10] ACPI: property: Prepare generating swnodes for ACPI and DisCo for Imaging
Date:   Tue, 28 Mar 2023 13:12:58 +0300
Message-Id: <20230328101303.1458570-6-sakari.ailus@linux.intel.com>
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

Prepare generating software nodes for information parsed from ACPI _CRS for
CSI-2 as well as MIPI DisCo for Imaging spec. The software nodes are
compliant with existing ACPI or DT definitions and are parsed by relevant
drivers without changes.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/internal.h |   1 +
 drivers/acpi/mipi.c     | 359 +++++++++++++++++++++++++++++++++++++++-
 drivers/acpi/scan.c     |  18 ++
 include/acpi/acpi_bus.h |  70 ++++++++
 4 files changed, 447 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 9279cdff3b6e..dbb8168e1cfd 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -307,5 +307,6 @@ static inline void acpi_init_lpit(void) { }
 void acpi_crs_csi2_swnodes_del_free(void);
 void acpi_bus_scan_check_crs_csi2(acpi_handle handle, struct acpi_scan_context *ctx);
 void acpi_bus_scan_crs_csi2(struct acpi_scan_context_csi2 *ctx);
+void acpi_init_swnodes(struct acpi_device *device);
 
 #endif /* _ACPI_INTERNAL_H_ */
diff --git a/drivers/acpi/mipi.c b/drivers/acpi/mipi.c
index ffc1768f86ed..5d05d899bede 100644
--- a/drivers/acpi/mipi.c
+++ b/drivers/acpi/mipi.c
@@ -3,7 +3,8 @@
  * MIPI DisCo for Imaging support.
  *
  * Support MIPI DisCo for Imaging by parsing ACPI _CRS CSI2 records and DisCo
- * for Imaging data structures.
+ * for Imaging data structures and generating nodes and properties using
+ * software nodes compliant with DT definitions of the similar scope.
  *
  * Also see <URL:https://www.mipi.org/specifications/mipi-disco-imaging>.
  *
@@ -20,6 +21,8 @@
 #include <linux/sort.h>
 #include <linux/string.h>
 
+#include <media/v4l2-fwnode.h>
+
 #include "internal.h"
 
 /* Temporary ACPI device handle to software node data structure mapping */
@@ -31,6 +34,18 @@ struct crs_csi2_swnodes {
 
 static LIST_HEAD(crs_csi2_swnodes);
 
+/* Obtain pre-allocated software nodes for an ACPI device handle */
+static struct acpi_device_software_nodes *crs_csi2_swnode_get(acpi_handle handle)
+{
+	struct crs_csi2_swnodes *swnodes;
+
+	list_for_each_entry(swnodes, &crs_csi2_swnodes, list)
+		if (swnodes->handle == handle)
+			return swnodes->ads;
+
+	return NULL;
+}
+
 static void crs_csi2_swnode_del_free(struct crs_csi2_swnodes *swnodes)
 {
 	list_del(&swnodes->list);
@@ -166,6 +181,35 @@ struct acpi_handle_ref {
 
 #define NO_CSI2_PORT (UINT_MAX - 1)
 
+/*
+ * Return next free entry in ports array of a software nodes related to an ACPI
+ * device.
+ */
+static unsigned int next_csi2_port_index(struct acpi_device_software_nodes *ads,
+					 unsigned int port_nr)
+{
+	unsigned int i;
+
+	for (i = 0; i < ads->num_ports; i++) {
+		struct acpi_device_software_node_port *port = &ads->ports[i];
+
+		if (port->port_nr == port_nr)
+			return i;
+
+		if (port->port_nr == NO_CSI2_PORT) {
+			port->port_nr = port_nr;
+			return i;
+		}
+	}
+
+	return NO_CSI2_PORT;
+}
+
+/* Print graph port name into a buffer, return non-zero if failed. */
+#define GRAPH_PORT_NAME(var, num)					    \
+	(snprintf((var), sizeof(var), SWNODE_GRAPH_PORT_NAME_FMT, (num)) >= \
+	 sizeof(var))
+
 static int crs_handle_cmp(const void *__a, const void *__b)
 {
 	const struct acpi_handle_ref *a = __a, *b = __b;
@@ -258,6 +302,9 @@ static void acpi_crs_csi2_alloc_fill_swnodes(size_t ports_count, acpi_handle han
 			  ports_count);
 }
 
+#define ACPI_CRS_CSI2_PHY_TYPE_C	0
+#define ACPI_CRS_CSI2_PHY_TYPE_D	1
+
 /**
  * acpi_bus_scan_crs_csi2 - Construct software nodes out of ACPI _CRS CSI2
  *			    resource descriptors
@@ -274,6 +321,8 @@ static void acpi_crs_csi2_alloc_fill_swnodes(size_t ports_count, acpi_handle han
  * 3. Allocate memory for swnodes each ACPI device requires later on, and
  *    generate a list of such allocations.
  *
+ * 4. Set up properties for software nodes.
+ *
  * Note that struct acpi_device may not be available yet at this time.
  *
  * acpi_scan_lock in scan.c must be held when calling this function.
@@ -339,7 +388,315 @@ void acpi_bus_scan_crs_csi2(struct acpi_scan_context_csi2 *ctx)
 		this_count = this->count;
 	}
 
+	/*
+	 * Allocate and set up necessary software nodes for each device and set
+	 * up properties from _CRS CSI2 descriptor.
+	 */
+	list_for_each_entry(csi2, &ctx->crs_csi2_head, list) {
+		struct acpi_device_software_nodes *local_swnodes;
+		struct crs_csi2_instance *inst;
+
+		local_swnodes = crs_csi2_swnode_get(csi2->handle);
+		if (WARN_ON_ONCE(!local_swnodes))
+			continue;
+
+		list_for_each_entry(inst, &csi2->buses, list) {
+			struct acpi_device_software_nodes *remote_swnodes;
+			struct acpi_device_software_node_port *local_port;
+			struct acpi_device_software_node_port *remote_port;
+			struct software_node *local_node, *remote_node;
+			unsigned int local_index, remote_index;
+			unsigned int bus_type;
+
+			remote_swnodes = crs_csi2_swnode_get(inst->remote_handle);
+			if (WARN_ON_ONCE(!remote_swnodes))
+				continue;
+
+			local_index = next_csi2_port_index(local_swnodes, inst->csi2.local_port_instance);
+			remote_index = next_csi2_port_index(remote_swnodes, inst->csi2.resource_source.index);
+
+			if (WARN_ON_ONCE(local_index >= local_swnodes->num_ports) ||
+			    WARN_ON_ONCE(remote_index >= remote_swnodes->num_ports))
+				goto out_free;
+
+			switch (inst->csi2.phy_type) {
+			case ACPI_CRS_CSI2_PHY_TYPE_C:
+				bus_type = V4L2_FWNODE_BUS_TYPE_CSI2_CPHY;
+				break;
+			case ACPI_CRS_CSI2_PHY_TYPE_D:
+				bus_type = V4L2_FWNODE_BUS_TYPE_CSI2_DPHY;
+				break;
+			default:
+				acpi_handle_info(csi2->handle,
+						 "ignoring CSI-2 PHY type %u\n",
+						 inst->csi2.phy_type);
+				continue;
+			}
+
+			local_port = &local_swnodes->ports[local_index];
+			local_node = &local_swnodes->nodes[ACPI_DEVICE_SWNODE_EP(local_index)];
+			local_port->remote_ep_ref[0] = SOFTWARE_NODE_REFERENCE(local_node);
+			local_port->crs_csi2_local = true;
+
+			remote_port = &remote_swnodes->ports[remote_index];
+			remote_node = &remote_swnodes->nodes[ACPI_DEVICE_SWNODE_EP(remote_index)];
+			remote_port->remote_ep_ref[0] = SOFTWARE_NODE_REFERENCE(remote_node);
+
+			local_port->ep_props[ACPI_DEVICE_SWNODE_EP_REMOTE_EP] =
+				PROPERTY_ENTRY_REF_ARRAY("remote-endpoint",
+							 remote_port->remote_ep_ref);
+			local_port->ep_props[ACPI_DEVICE_SWNODE_EP_BUS_TYPE] =
+				PROPERTY_ENTRY_U32("bus-type", bus_type);
+			local_port->ep_props[ACPI_DEVICE_SWNODE_EP_REG] =
+				PROPERTY_ENTRY_U32("reg", 0);
+			local_port->port_props[ACPI_DEVICE_SWNODE_PRT_REG] =
+				PROPERTY_ENTRY_U32("reg", inst->csi2.local_port_instance);
+			if (GRAPH_PORT_NAME(local_port->port_name,
+					    inst->csi2.local_port_instance))
+				acpi_handle_warn(csi2->handle,
+						 "name for local port %u too long",
+						 inst->csi2.local_port_instance);
+
+			remote_port->ep_props[ACPI_DEVICE_SWNODE_EP_REMOTE_EP] =
+				PROPERTY_ENTRY_REF_ARRAY("remote-endpoint", local_port->remote_ep_ref);
+			remote_port->ep_props[ACPI_DEVICE_SWNODE_EP_BUS_TYPE] =
+				PROPERTY_ENTRY_U32("bus-type", bus_type);
+			remote_port->ep_props[ACPI_DEVICE_SWNODE_EP_REG] =
+				PROPERTY_ENTRY_U32("reg", 0);
+			remote_port->port_props[ACPI_DEVICE_SWNODE_PRT_REG] =
+				PROPERTY_ENTRY_U32("reg",
+						   inst->csi2.resource_source.index);
+			if (GRAPH_PORT_NAME(remote_port->port_name,
+					    inst->csi2.resource_source.index))
+				acpi_handle_warn(csi2->handle,
+						 "name for remote port %u too long",
+						 inst->csi2.resource_source.index);
+		}
+	}
+
+out_free:
 	kfree(handle_refs);
 
 	crs_csi2_release(&ctx->crs_csi2_head);
 }
+
+/*
+ * Get the index of the next property in the property array, with a given
+ * maximum values.
+ */
+#define NEXT_PROPERTY(index, max)				\
+	(WARN_ON(++(index) > ACPI_DEVICE_SWNODE_##max + 1) ?	\
+	 ACPI_DEVICE_SWNODE_##max : (index) - 1)
+
+static struct fwnode_handle *get_mipi_port_handle(struct acpi_device *device,
+						  unsigned int port)
+{
+	static const char mipi_port_prefix[] = "mipi-img-port-";
+	char mipi_port_name[sizeof(mipi_port_prefix) + 2];
+
+	if (snprintf(mipi_port_name, sizeof(mipi_port_name), "%s%u",
+		     mipi_port_prefix, port) >= sizeof(mipi_port_name)) {
+		acpi_handle_info(acpi_device_handle(device),
+				 "mipi port name too long for port %u\n", port);
+		return NULL;
+	}
+
+	return fwnode_get_named_child_node(acpi_fwnode_handle(device),
+					   mipi_port_name);
+}
+
+static void init_port_csi2_common(struct acpi_device *device,
+				  struct fwnode_handle *mipi_port_fwnode,
+				  unsigned int *ep_prop_index,
+				  unsigned int port_nr)
+{
+	unsigned int port_index = next_csi2_port_index(device->swnodes, port_nr);
+	struct acpi_device_software_nodes *ads = device->swnodes;
+	struct acpi_device_software_node_port *port = &ads->ports[port_index];
+	unsigned int num_lanes = 0;
+	u8 val[ARRAY_SIZE(port->data_lanes)];
+	int ret;
+
+	*ep_prop_index = ACPI_DEVICE_SWNODE_EP_CLOCK_LANES;
+
+	if (GRAPH_PORT_NAME(port->port_name, port_nr))
+		return;
+
+	ads->nodes[ACPI_DEVICE_SWNODE_PRT(port_index)] =
+		SOFTWARE_NODE(port->port_name, port->port_props,
+			      &ads->nodes[ACPI_DEVICE_SWNODE_ROOT]);
+
+	ret = fwnode_property_read_u8(mipi_port_fwnode, "mipi-img-clock-lane", val);
+	if (!ret) {
+		port->ep_props[NEXT_PROPERTY(*ep_prop_index, EP_CLOCK_LANES)] =
+			PROPERTY_ENTRY_U32("clock-lanes", *val);
+	}
+	ret = fwnode_property_count_u8(mipi_port_fwnode, "mipi-img-data-lanes");
+	if (ret > 0) {
+		num_lanes = ret;
+
+		if (num_lanes > ARRAY_SIZE(port->data_lanes)) {
+			acpi_handle_warn(acpi_device_handle(device),
+					 "too many data lanes (%u)\n",
+					 num_lanes);
+			num_lanes = ARRAY_SIZE(port->data_lanes);
+		}
+
+		ret = fwnode_property_read_u8_array(mipi_port_fwnode, "mipi-img-data-lanes",
+						    val, num_lanes);
+		if (!ret) {
+			unsigned int i;
+
+			for (i = 0; i < num_lanes; i++)
+				port->data_lanes[i] = val[i];
+
+			port->ep_props[NEXT_PROPERTY(*ep_prop_index, EP_DATA_LANES)] =
+				PROPERTY_ENTRY_U32_ARRAY_LEN("data-lanes", port->data_lanes,
+							     num_lanes);
+		}
+	}
+
+	ret = fwnode_property_count_u8(mipi_port_fwnode, "mipi-img-lane-polarities");
+	if (ret > 0) {
+		unsigned int bytes = min_t(unsigned int, ret, sizeof(val));
+
+		fwnode_property_read_u8_array(mipi_port_fwnode,
+					      "mipi-img-lane-polarities",
+					      val, bytes);
+
+		/* Total number of lanes here is clock lane + data lanes */
+		if (bytes * BITS_PER_TYPE(u8) >= 1 + num_lanes) {
+			unsigned int i;
+
+			/* Move polarity bits to the lane polarity u32 array */
+			for (i = 0; i < 1 + num_lanes; i++)
+				port->lane_polarities[i] =
+					(bool)(val[i >> 3] & (1 << (i & 7)));
+
+			port->ep_props[NEXT_PROPERTY(*ep_prop_index, EP_LANE_POLARITIES)] =
+				PROPERTY_ENTRY_U32_ARRAY_LEN("lane-polarities",
+							     port->lane_polarities,
+							     1 + num_lanes);
+		} else {
+			acpi_handle_warn(acpi_device_handle(device),
+					 "too few lane polarity bytes (%u)\n",
+					 bytes);
+		}
+	}
+
+	ads->nodes[ACPI_DEVICE_SWNODE_EP(port_index)] =
+		SOFTWARE_NODE("endpoint@0", ads->ports[port_index].ep_props,
+			      &ads->nodes[ACPI_DEVICE_SWNODE_PRT(port_index)]);
+}
+
+static void init_port_csi2_local(struct acpi_device *device,
+				 unsigned int port_nr)
+{
+	unsigned int port_index = next_csi2_port_index(device->swnodes, port_nr);
+	struct fwnode_handle *mipi_port_fwnode =
+		get_mipi_port_handle(device, port_nr);
+	struct acpi_device_software_node_port *port =
+		&device->swnodes->ports[port_index];
+	unsigned int ep_prop_index;
+	int ret;
+
+	init_port_csi2_common(device, mipi_port_fwnode, &ep_prop_index, port_nr);
+
+	ret = fwnode_property_count_u64(mipi_port_fwnode, "mipi-img-link-frequencies");
+	if (ret > 0) {
+		unsigned int num_link_freqs = ret;
+
+		if (num_link_freqs > ARRAY_SIZE(port->link_frequencies)) {
+			acpi_handle_info(acpi_device_handle(device),
+					 "too many link frequencies %u\n",
+					 num_link_freqs);
+			num_link_freqs = ARRAY_SIZE(port->link_frequencies);
+		}
+
+		ret = fwnode_property_read_u64_array(mipi_port_fwnode,
+						     "mipi-img-link-frequencies",
+						     port->link_frequencies,
+						     num_link_freqs);
+		if (!ret)
+			port->ep_props[NEXT_PROPERTY(ep_prop_index, EP_LINK_FREQUENCIES)] =
+				PROPERTY_ENTRY_U64_ARRAY_LEN("link-frequencies",
+							     port->link_frequencies,
+							     num_link_freqs);
+		else
+			acpi_handle_info(acpi_device_handle(device),
+					 "can't get link frequencies (%d)\n",
+					 ret);
+	}
+
+	fwnode_handle_put(mipi_port_fwnode);
+}
+
+static void init_port_csi2_remote(struct acpi_device *device,
+				  unsigned int port_nr)
+{
+	struct fwnode_handle *mipi_port_fwnode = get_mipi_port_handle(device, port_nr);
+	unsigned int ep_prop_index;
+
+	init_port_csi2_common(device, mipi_port_fwnode, &ep_prop_index, port_nr);
+
+	fwnode_handle_put(mipi_port_fwnode);
+}
+
+/**
+ * acpi_init_swnodes - Set up software nodes for properties gathered elsewhere
+ *
+ * @device: ACPI device for which the software nodes are initialised
+ *
+ * Initialise and register software nodes for properties for which the data is
+ * gathered elsewhere, e.g. _CRS CSI-2 descriptors. The process itself takes
+ * place before this function is called.
+ *
+ * acpi_scan_lock in scan.c must be held when calling this function.
+ */
+void acpi_init_swnodes(struct acpi_device *device)
+{
+	struct acpi_device_software_nodes *ads;
+	struct acpi_buffer buffer = { .length = ACPI_ALLOCATE_BUFFER };
+	acpi_handle handle = acpi_device_handle(device);
+	struct fwnode_handle *primary;
+	acpi_status status;
+	unsigned int i;
+	int ret;
+
+	device->swnodes = ads = crs_csi2_swnode_get(handle);
+	if (!ads)
+		return;
+
+	status = acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_warn(handle, "cannot get path name\n");
+		return;
+	}
+
+	ads->nodes[ACPI_DEVICE_SWNODE_ROOT] =
+		SOFTWARE_NODE(buffer.pointer, ads->dev_props, NULL);
+
+	for (i = 0; i < ads->num_ports; i++) {
+		struct acpi_device_software_node_port *port = &ads->ports[i];
+
+		if (port->crs_csi2_local)
+			init_port_csi2_local(device, port->port_nr);
+		else
+			init_port_csi2_remote(device, port->port_nr);
+	}
+
+	ret = software_node_register_node_group(ads->nodeptrs);
+	if (ret < 0) {
+		acpi_handle_warn(handle,
+				 "cannot register software nodes (%d)!\n", ret);
+		device->swnodes = NULL;
+		return;
+	}
+
+	/*
+	 * Note we can't use set_secondary_fwnode() here as the device's
+	 * primary fwnode hasn't been set yet.
+	 */
+	primary = acpi_fwnode_handle(device);
+	primary->secondary = software_node_fwnode(ads->nodes);
+}
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 4f4f6b0db0a9..c21e5dedc5f1 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -449,10 +449,28 @@ static void acpi_free_power_resources_lists(struct acpi_device *device)
 	}
 }
 
+static void acpi_free_swnodes(struct acpi_device *device)
+{
+	struct acpi_device_software_nodes *ads = device->swnodes;
+	struct fwnode_handle *primary;
+
+	if (!ads)
+		return;
+
+	software_node_unregister_node_group(ads->nodeptrs);
+	primary = acpi_fwnode_handle(device);
+	primary->secondary = NULL;
+	kfree(ads->nodes[ACPI_DEVICE_SWNODE_ROOT].name);
+	kfree(ads);
+
+	device->swnodes = NULL;
+}
+
 static void acpi_device_release(struct device *dev)
 {
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 
+	acpi_free_swnodes(acpi_dev);
 	acpi_free_properties(acpi_dev);
 	acpi_free_pnp_ids(&acpi_dev->pnp);
 	acpi_free_power_resources_lists(acpi_dev);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 71a6f0502f2c..9192b990394d 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -361,15 +361,84 @@ struct acpi_device_data {
 
 struct acpi_gpio_mapping;
 
+enum acpi_device_swnode_dev_props {
+	ACPI_DEVICE_SWNODE_DEV_NUM_OF,
+	ACPI_DEVICE_SWNODE_DEV_NUM_ENTRIES
+};
+
+enum acpi_device_swnode_port_props {
+	ACPI_DEVICE_SWNODE_PRT_REG,
+	ACPI_DEVICE_SWNODE_PRT_NUM_OF,
+	ACPI_DEVICE_SWNODE_PRT_NUM_ENTRIES
+};
+
+enum acpi_device_swnode_ep_props {
+	ACPI_DEVICE_SWNODE_EP_REMOTE_EP,
+	ACPI_DEVICE_SWNODE_EP_BUS_TYPE,
+	ACPI_DEVICE_SWNODE_EP_REG,
+	ACPI_DEVICE_SWNODE_EP_CLOCK_LANES,
+	ACPI_DEVICE_SWNODE_EP_DATA_LANES,
+	ACPI_DEVICE_SWNODE_EP_LANE_POLARITIES,
+	/* TX only */
+	ACPI_DEVICE_SWNODE_EP_LINK_FREQUENCIES,
+	ACPI_DEVICE_SWNODE_EP_NUM_OF,
+	ACPI_DEVICE_SWNODE_EP_NUM_ENTRIES
+};
+
+#define ACPI_DEVICE_SWNODE_ROOT			0
+/*
+ * Each device has a root swnode plus two times as many nodes as the
+ * number of CSI-2 ports.
+ */
+#define ACPI_DEVICE_SWNODE_PRT(port)		(1 + 2 * (port))
+#define ACPI_DEVICE_SWNODE_EP(endpoint)	\
+	(ACPI_DEVICE_SWNODE_PRT(endpoint) + 1)
+
+#define ACPI_DEVICE_SWNODE_CSI2_DATA_LANES		4
+
+/**
+ * struct acpi_device_software_node_port: Software nodes for MIPI DisCo for
+ *					  Imaging support
+ * @port_name: the name of the port
+ * @data_lanes: "data-lanes" property values
+ * @lane_polarities: "lane-polarities" property values
+ * @link_frequencies: "link_frequencies" property values
+ * @port_nr: the number of the port
+ * @crs_crs2_local: whether the _CRS CSI2 record is local to the port (i.e. the
+ *		    port is a transmitter port)
+ * port_props: the port properties
+ * ep_props: the endpoint properties
+ * remote_ep_ref: reference to the remote endpoint
+ */
 struct acpi_device_software_node_port {
+	char port_name[8];
+	u32 data_lanes[ACPI_DEVICE_SWNODE_CSI2_DATA_LANES];
+	u32 lane_polarities[1 /* clock lane */ +
+			    ACPI_DEVICE_SWNODE_CSI2_DATA_LANES];
+	u64 link_frequencies[4];
 	unsigned int port_nr;
+	bool crs_csi2_local;
+
+	struct property_entry port_props[ACPI_DEVICE_SWNODE_PRT_NUM_ENTRIES];
+	struct property_entry ep_props[ACPI_DEVICE_SWNODE_EP_NUM_ENTRIES];
+
+	struct software_node_ref_args remote_ep_ref[1];
 };
 
+/**
+ * struct acpi_device_software_nodes - Software nodes for an ACPI device
+ * @ports: information related to each port and endpoint within a port
+ * @nodes: software nodes for root as well as ports and endpoints
+ * @nodeprts: array of software node pointers, for (un)registering them
+ * @num_ports: the number of ports
+ */
 struct acpi_device_software_nodes {
 	struct acpi_device_software_node_port *ports;
 	struct software_node *nodes;
 	const struct software_node **nodeptrs;
 	unsigned int num_ports;
+
+	struct property_entry dev_props[ACPI_DEVICE_SWNODE_DEV_NUM_ENTRIES];
 };
 
 /* Device */
@@ -378,6 +447,7 @@ struct acpi_device {
 	int device_type;
 	acpi_handle handle;		/* no handle for fixed hardware */
 	struct fwnode_handle fwnode;
+	struct acpi_device_software_nodes *swnodes;
 	struct list_head wakeup_list;
 	struct list_head del_list;
 	struct acpi_device_status status;
-- 
2.30.2

