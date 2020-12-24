Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2422E2349
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Dec 2020 02:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgLXBKx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Dec 2020 20:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbgLXBKt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Dec 2020 20:10:49 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E816DC0611CF;
        Wed, 23 Dec 2020 17:09:41 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 3so382696wmg.4;
        Wed, 23 Dec 2020 17:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vTusmbnRBjlWt/j3cFciT3xgDZpg6aLACpGWAtd7ARc=;
        b=Fi9Gc/449zZomb8/eDsWIgN3viJk1nDZWigXwJmwQ+Gc/sXfHbCo5lGRgVntDeHVjW
         Sbh2tT/WJMa5FbnYOzcwGNTs2j9dp1BfuJyq4TqmRKH9qf+VMLPNgLxNnqoSL3fsOaeI
         h1iYxDvG0lcgGqliT5ZRJ/dE0gBon2/MKaA3WzieCcly4T5pP+JIbtJd5BDAj2DPX6hA
         5sCSLYJBgVICtMEkRuSyPpt2jH+f3ALCi8Gl/G9KVybTxs7J+SpZOZWe2xNGQbO3zbch
         SYTh7rxBPckacyBESqI+Op3JN0RUDnVvUSkC/KPQWHW5yQsIpzKVNiBt5bwMJvsHeuPb
         Dfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vTusmbnRBjlWt/j3cFciT3xgDZpg6aLACpGWAtd7ARc=;
        b=QSxKXol4vGyQMonHW8q7goU12SF1Ki80pvMHSmPyVYGvi1ylOG7JYrZz40b0zAP1Qe
         EWThVqjqeZoDUtBa7TloGPZJDb1dHYywA3TROkxVBG+IfqdVkEa4weV0GoADo09djBex
         5Gm9bd0n0gxPKnuVcABLXgT2oPXs/q3m/r0ZNEv7Og03rCM9fAcHtYPybvKrI0jkTYzj
         2igWK/4MapjAGexHsYjC5f3ux6Kj/DtQYNPsepyDtFomu5QRNEqwXQuek4wdUSn2GA0I
         NNL+HObFge5rvWybRArwR3sg3jx0HIVvY2fNJPbCIR1GnQT/QKYrMmABUxFKySybuYi3
         jKcg==
X-Gm-Message-State: AOAM533ViaK6WFG+J6NvwEX8z+Ki0/WIn1Ab+wlE9IhBlPboLLncU026
        prQVW8HBgorSnffFc1ZbhuUb/bniT0OME4hf
X-Google-Smtp-Source: ABdhPJz4vEk4EvSXnymzzA3FIbLFUAOheirfSHIrI9nh2y96pQIFiWsrw3KwdO8ElriCxp2oMPpThQ==
X-Received: by 2002:a7b:ca47:: with SMTP id m7mr1940894wml.33.1608772180659;
        Wed, 23 Dec 2020 17:09:40 -0800 (PST)
Received: from valhalla.home ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id b200sm1598653wmb.10.2020.12.23.17.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 17:09:40 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org
Cc:     rjw@rjwysocki.net, lenb@kernel.org, gregkh@linuxfoundation.org,
        yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com, mchehab@kernel.org,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org,
        Jordan Hand <jorhand@linux.microsoft.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v3 14/14] ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
Date:   Thu, 24 Dec 2020 01:09:07 +0000
Message-Id: <20201224010907.263125-15-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201224010907.263125-1-djrscally@gmail.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently on platforms designed for Windows, connections between CIO2 and
sensors are not properly defined in DSDT. This patch extends the ipu3-cio2
driver to compensate by building software_node connections, parsing the
connection properties from the sensor's SSDB buffer.

Suggested-by: Jordan Hand <jorhand@linux.microsoft.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v3
	- Used Laurent's suggestion to simplify initing the property names
	- Wrapped some lines
	- Fixed return and error handling for cio2_bridge_read_acpi_buffer()
	- Returned an error if more sensors than available ports are detected
	- Used defines for port/endpoint name formats and the bus-type property
	- Some bits of cleanup

 MAINTAINERS                                   |   1 +
 drivers/media/pci/intel/ipu3/Kconfig          |  18 ++
 drivers/media/pci/intel/ipu3/Makefile         |   1 +
 drivers/media/pci/intel/ipu3/cio2-bridge.c    | 272 ++++++++++++++++++
 drivers/media/pci/intel/ipu3/cio2-bridge.h    | 122 ++++++++
 drivers/media/pci/intel/ipu3/ipu3-cio2-main.c |  34 +++
 drivers/media/pci/intel/ipu3/ipu3-cio2.h      |   6 +
 7 files changed, 454 insertions(+)
 create mode 100644 drivers/media/pci/intel/ipu3/cio2-bridge.c
 create mode 100644 drivers/media/pci/intel/ipu3/cio2-bridge.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 16b544624577..e7784b4bc8ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8943,6 +8943,7 @@ INTEL IPU3 CSI-2 CIO2 DRIVER
 M:	Yong Zhi <yong.zhi@intel.com>
 M:	Sakari Ailus <sakari.ailus@linux.intel.com>
 M:	Bingbu Cao <bingbu.cao@intel.com>
+M:	Dan Scally <djrscally@gmail.com>
 R:	Tianshu Qiu <tian.shu.qiu@intel.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
diff --git a/drivers/media/pci/intel/ipu3/Kconfig b/drivers/media/pci/intel/ipu3/Kconfig
index 82d7f17e6a02..dcf5c4b74673 100644
--- a/drivers/media/pci/intel/ipu3/Kconfig
+++ b/drivers/media/pci/intel/ipu3/Kconfig
@@ -16,3 +16,21 @@ config VIDEO_IPU3_CIO2
 	  Say Y or M here if you have a Skylake/Kaby Lake SoC with MIPI CSI-2
 	  connected camera.
 	  The module will be called ipu3-cio2.
+
+config CIO2_BRIDGE
+	bool "IPU3 CIO2 Sensors Bridge"
+	depends on VIDEO_IPU3_CIO2
+	help
+	  This extension provides an API for the ipu3-cio2 driver to create
+	  connections to cameras that are hidden in SSDB buffer in ACPI. It
+	  can be used to enable support for cameras in detachable / hybrid
+	  devices that ship with Windows.
+
+	  Say Y here if your device is a detachable / hybrid laptop that comes
+	  with Windows installed by the OEM, for example:
+
+		- Microsoft Surface models (except Surface Pro 3)
+		- The Lenovo Miix line (for example the 510, 520, 710 and 720)
+		- Dell 7285
+
+	  If in doubt, say N here.
diff --git a/drivers/media/pci/intel/ipu3/Makefile b/drivers/media/pci/intel/ipu3/Makefile
index 429d516452e4..933777e6ea8a 100644
--- a/drivers/media/pci/intel/ipu3/Makefile
+++ b/drivers/media/pci/intel/ipu3/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_VIDEO_IPU3_CIO2) += ipu3-cio2.o
 
 ipu3-cio2-y += ipu3-cio2-main.o
+ipu3-cio2-$(CONFIG_CIO2_BRIDGE) += cio2-bridge.o
diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.c b/drivers/media/pci/intel/ipu3/cio2-bridge.c
new file mode 100644
index 000000000000..3f4ae172fd25
--- /dev/null
+++ b/drivers/media/pci/intel/ipu3/cio2-bridge.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Author: Dan Scally <djrscally@gmail.com> */
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <linux/property.h>
+#include <media/v4l2-fwnode.h>
+
+#include "cio2-bridge.h"
+
+/*
+ * Extend this array with ACPI Hardware ID's of devices known to be working
+ * plus the number of link-frequencies expected by their drivers, along with
+ * the frequency values in hertz. This is somewhat opportunistic way of adding
+ * support for this for now in the hopes of a better source for the information
+ * (possibly some encoded value in the SSDB buffer that we're unaware of)
+ * becoming apparent in the future.
+ *
+ * Do not add an entry for a sensor that is not actually supported.
+ */
+static const struct cio2_sensor_config cio2_supported_sensors[] = {
+	CIO2_SENSOR_CONFIG("INT33BE", 0),
+	CIO2_SENSOR_CONFIG("OVTI2680", 0),
+};
+
+static const struct cio2_property_names prop_names = {
+	.clock_frequency = "clock-frequency",
+	.rotation = "rotation",
+	.bus_type = "bus-type",
+	.data_lanes = "data-lanes",
+	.remote_endpoint = "remote-endpoint",
+	.link_frequencies = "link-frequencies",
+};
+
+static int cio2_bridge_read_acpi_buffer(struct acpi_device *adev, char *id,
+					void *data, u32 size)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+	acpi_status status;
+	int ret = 0;
+
+	status = acpi_evaluate_object(adev->handle, id, NULL, &buffer);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	obj = buffer.pointer;
+	if (!obj) {
+		dev_err(&adev->dev, "Couldn't locate ACPI buffer\n");
+		return -ENODEV;
+	}
+
+	if (obj->type != ACPI_TYPE_BUFFER) {
+		dev_err(&adev->dev, "Not an ACPI buffer\n");
+		ret = -ENODEV;
+		goto out_free_buff;
+	}
+
+	if (obj->buffer.length > size) {
+		dev_err(&adev->dev, "Given buffer is too small\n");
+		ret = -EINVAL;
+		goto out_free_buff;
+	}
+
+	memcpy(data, obj->buffer.pointer, obj->buffer.length);
+
+out_free_buff:
+	kfree(buffer.pointer);
+	return ret;
+}
+
+static void cio2_bridge_create_fwnode_properties(struct cio2_sensor *sensor,
+						 const struct cio2_sensor_config *cfg)
+{
+	unsigned int i;
+
+	sensor->prop_names = prop_names;
+
+	for (i = 0; i < 4; i++)
+		sensor->data_lanes[i] = i + 1;
+
+	sensor->local_ref[0].node = &sensor->swnodes[SWNODE_CIO2_ENDPOINT];
+	sensor->remote_ref[0].node = &sensor->swnodes[SWNODE_SENSOR_ENDPOINT];
+
+	sensor->dev_properties[0] = PROPERTY_ENTRY_U32(sensor->prop_names.clock_frequency,
+						       sensor->ssdb.mclkspeed);
+	sensor->dev_properties[1] = PROPERTY_ENTRY_U8(sensor->prop_names.rotation,
+						      sensor->ssdb.degree);
+
+	sensor->ep_properties[0] = PROPERTY_ENTRY_U32(sensor->prop_names.bus_type,
+						      V4L2_FWNODE_BUS_TYPE_CSI2_DPHY);
+	sensor->ep_properties[1] = PROPERTY_ENTRY_U32_ARRAY_LEN(sensor->prop_names.data_lanes,
+								sensor->data_lanes,
+								sensor->ssdb.lanes);
+	sensor->ep_properties[2] = PROPERTY_ENTRY_REF_ARRAY(sensor->prop_names.remote_endpoint,
+							    sensor->local_ref);
+
+	if (cfg->nr_link_freqs > 0)
+		sensor->ep_properties[3] = PROPERTY_ENTRY_U64_ARRAY_LEN(
+						sensor->prop_names.link_frequencies,
+						cfg->link_freqs,
+						cfg->nr_link_freqs);
+
+	sensor->cio2_properties[0] = PROPERTY_ENTRY_U32_ARRAY_LEN(sensor->prop_names.data_lanes,
+								  sensor->data_lanes,
+								  sensor->ssdb.lanes);
+	sensor->cio2_properties[1] = PROPERTY_ENTRY_REF_ARRAY(sensor->prop_names.remote_endpoint,
+							      sensor->remote_ref);
+}
+
+static void cio2_bridge_init_swnode_names(struct cio2_sensor *sensor)
+{
+	snprintf(sensor->node_names.remote_port, sizeof(sensor->node_names.remote_port),
+		 FWNODE_GRAPH_PORT_NAME_FORMAT, sensor->ssdb.link);
+	snprintf(sensor->node_names.port, sizeof(sensor->node_names.port),
+		 FWNODE_GRAPH_PORT_NAME_FORMAT, 0); /* Always port 0 */
+	snprintf(sensor->node_names.endpoint, sizeof(sensor->node_names.endpoint),
+		 FWNODE_GRAPH_ENDPOINT_NAME_FORMAT, 0); /* And endpoint 0 */
+}
+
+static void cio2_bridge_create_connection_swnodes(struct cio2_bridge *bridge,
+						  struct cio2_sensor *sensor)
+{
+	struct software_node *nodes = sensor->swnodes;
+
+	cio2_bridge_init_swnode_names(sensor);
+
+	nodes[SWNODE_SENSOR_HID] = NODE_SENSOR(sensor->name,
+					       sensor->dev_properties);
+	nodes[SWNODE_SENSOR_PORT] = NODE_PORT(sensor->node_names.port,
+					      &nodes[SWNODE_SENSOR_HID]);
+	nodes[SWNODE_SENSOR_ENDPOINT] = NODE_ENDPOINT(sensor->node_names.endpoint,
+						      &nodes[SWNODE_SENSOR_PORT],
+						      sensor->ep_properties);
+	nodes[SWNODE_CIO2_PORT] = NODE_PORT(sensor->node_names.remote_port,
+					    &bridge->cio2_hid_node);
+	nodes[SWNODE_CIO2_ENDPOINT] = NODE_ENDPOINT(sensor->node_names.endpoint,
+						    &nodes[SWNODE_CIO2_PORT],
+						    sensor->cio2_properties);
+}
+
+static void cio2_bridge_unregister_sensors(struct cio2_bridge *bridge)
+{
+	struct cio2_sensor *sensor;
+	unsigned int i;
+
+	for (i = 0; i < bridge->n_sensors; i++) {
+		sensor = &bridge->sensors[i];
+		software_node_unregister_nodes(sensor->swnodes);
+		acpi_dev_put(sensor->adev);
+	}
+}
+
+static int cio2_bridge_connect_sensors(struct cio2_bridge *bridge,
+				       struct pci_dev *cio2)
+{
+	struct fwnode_handle *fwnode;
+	struct cio2_sensor *sensor;
+	struct acpi_device *adev;
+	unsigned int i;
+	int ret = 0;
+
+	for (i = 0; i < ARRAY_SIZE(cio2_supported_sensors); i++) {
+		const struct cio2_sensor_config *cfg = &cio2_supported_sensors[i];
+
+		for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {
+			if (bridge->n_sensors >= CIO2_NUM_PORTS) {
+				dev_err(&cio2->dev, "Exceeded available CIO2 ports\n");
+				cio2_bridge_unregister_sensors(bridge);
+				ret = -EINVAL;
+				goto err_out;
+			}
+
+			if (!adev->status.enabled)
+				continue;
+
+			sensor = &bridge->sensors[bridge->n_sensors];
+			sensor->adev = adev;
+			strscpy(sensor->name, cfg->hid, sizeof(sensor->name));
+
+			ret = cio2_bridge_read_acpi_buffer(adev, "SSDB",
+							   &sensor->ssdb,
+							   sizeof(sensor->ssdb));
+			if (ret)
+				goto err_put_adev;
+
+			if (sensor->ssdb.lanes > 4) {
+				dev_err(&adev->dev,
+					"Number of lanes in SSDB is invalid\n");
+				ret = -EINVAL;
+				goto err_put_adev;
+			}
+
+			cio2_bridge_create_fwnode_properties(sensor, cfg);
+			cio2_bridge_create_connection_swnodes(bridge, sensor);
+
+			ret = software_node_register_nodes(sensor->swnodes);
+			if (ret)
+				goto err_put_adev;
+
+			fwnode = software_node_fwnode(&sensor->swnodes[SWNODE_SENSOR_HID]);
+			if (!fwnode) {
+				ret = -ENODEV;
+				goto err_free_swnodes;
+			}
+
+			adev->fwnode.secondary = fwnode;
+
+			dev_info(&cio2->dev, "Found supported sensor %s\n",
+				 acpi_dev_name(adev));
+
+			bridge->n_sensors++;
+		}
+	}
+
+	return ret;
+
+err_free_swnodes:
+	software_node_unregister_nodes(sensor->swnodes);
+err_put_adev:
+	acpi_dev_put(sensor->adev);
+err_out:
+	return ret;
+}
+
+int cio2_bridge_init(struct pci_dev *cio2)
+{
+	struct device *dev = &cio2->dev;
+	struct fwnode_handle *fwnode;
+	struct cio2_bridge *bridge;
+	int ret;
+
+	bridge = kzalloc(sizeof(*bridge), GFP_KERNEL);
+	if (!bridge)
+		return -ENOMEM;
+
+	strscpy(bridge->cio2_node_name, CIO2_HID, sizeof(bridge->cio2_node_name));
+	bridge->cio2_hid_node.name = bridge->cio2_node_name;
+
+	ret = software_node_register(&bridge->cio2_hid_node);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register the CIO2 HID node\n");
+		goto err_free_bridge;
+	}
+
+	ret = cio2_bridge_connect_sensors(bridge, cio2);
+	if (ret || bridge->n_sensors == 0)
+		goto err_unregister_cio2;
+
+	dev_info(dev, "Connected %d cameras\n", bridge->n_sensors);
+
+	fwnode = software_node_fwnode(&bridge->cio2_hid_node);
+	if (!fwnode) {
+		dev_err(dev, "Error getting fwnode from cio2 software_node\n");
+		ret = -ENODEV;
+		goto err_unregister_sensors;
+	}
+
+	set_secondary_fwnode(dev, fwnode);
+
+	return 0;
+
+err_unregister_sensors:
+	cio2_bridge_unregister_sensors(bridge);
+err_unregister_cio2:
+	software_node_unregister(&bridge->cio2_hid_node);
+err_free_bridge:
+	kfree(bridge);
+
+	return ret;
+}
diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.h b/drivers/media/pci/intel/ipu3/cio2-bridge.h
new file mode 100644
index 000000000000..004b608f322f
--- /dev/null
+++ b/drivers/media/pci/intel/ipu3/cio2-bridge.h
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Author: Dan Scally <djrscally@gmail.com> */
+#ifndef __CIO2_BRIDGE_H
+#define __CIO2_BRIDGE_H
+
+#include <linux/property.h>
+
+#define CIO2_HID				"INT343E"
+#define CIO2_NUM_PORTS				4
+#define MAX_NUM_LINK_FREQS			3
+
+#define CIO2_SENSOR_CONFIG(_HID, _NR, ...)	\
+	{					\
+		.hid = _HID,			\
+		.nr_link_freqs = _NR,		\
+		.link_freqs = { __VA_ARGS__ }	\
+	}
+
+#define NODE_SENSOR(_HID, _PROPS)		\
+	((const struct software_node) {		\
+		.name = _HID,			\
+		.properties = _PROPS,		\
+	})
+
+#define NODE_PORT(_PORT, _SENSOR_NODE)		\
+	((const struct software_node) {		\
+		_PORT,				\
+		_SENSOR_NODE,			\
+	})
+
+#define NODE_ENDPOINT(_EP, _PORT, _PROPS)	\
+	((const struct software_node) {		\
+		_EP,				\
+		_PORT,				\
+		_PROPS,				\
+	})
+
+enum cio2_sensor_swnodes {
+	SWNODE_SENSOR_HID,
+	SWNODE_SENSOR_PORT,
+	SWNODE_SENSOR_ENDPOINT,
+	SWNODE_CIO2_PORT,
+	SWNODE_CIO2_ENDPOINT,
+	SWNODE_COUNT,
+};
+
+/* Data representation as it is in ACPI SSDB buffer */
+struct cio2_sensor_ssdb {
+	u8 version;
+	u8 sku;
+	u8 guid_csi2[16];
+	u8 devfunction;
+	u8 bus;
+	u32 dphylinkenfuses;
+	u32 clockdiv;
+	u8 link;
+	u8 lanes;
+	u32 csiparams[10];
+	u32 maxlanespeed;
+	u8 sensorcalibfileidx;
+	u8 sensorcalibfileidxInMBZ[3];
+	u8 romtype;
+	u8 vcmtype;
+	u8 platforminfo;
+	u8 platformsubinfo;
+	u8 flash;
+	u8 privacyled;
+	u8 degree;
+	u8 mipilinkdefined;
+	u32 mclkspeed;
+	u8 controllogicid;
+	u8 reserved1[3];
+	u8 mclkport;
+	u8 reserved2[13];
+} __packed;
+
+struct cio2_property_names {
+	char clock_frequency[16];
+	char rotation[9];
+	char bus_type[9];
+	char data_lanes[11];
+	char remote_endpoint[16];
+	char link_frequencies[17];
+};
+
+struct cio2_node_names {
+	char port[7];
+	char endpoint[11];
+	char remote_port[7];
+};
+
+struct cio2_sensor_config {
+	const char *hid;
+	const u8 nr_link_freqs;
+	const u64 link_freqs[MAX_NUM_LINK_FREQS];
+};
+
+struct cio2_sensor {
+	char name[ACPI_ID_LEN];
+	struct acpi_device *adev;
+
+	struct software_node swnodes[6];
+	struct cio2_node_names node_names;
+
+	u32 data_lanes[4];
+	struct cio2_sensor_ssdb ssdb;
+	struct cio2_property_names prop_names;
+	struct property_entry ep_properties[5];
+	struct property_entry dev_properties[3];
+	struct property_entry cio2_properties[3];
+	struct software_node_ref_args local_ref[1];
+	struct software_node_ref_args remote_ref[1];
+};
+
+struct cio2_bridge {
+	char cio2_node_name[ACPI_ID_LEN];
+	struct software_node cio2_hid_node;
+	unsigned int n_sensors;
+	struct cio2_sensor sensors[CIO2_NUM_PORTS];
+};
+
+#endif
diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
index 36e354ecf71e..68ff28abc6a3 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
@@ -1702,11 +1702,28 @@ static void cio2_queues_exit(struct cio2_device *cio2)
 		cio2_queue_exit(cio2, &cio2->queue[i]);
 }
 
+static bool cio2_check_fwnode_graph(struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *endpoint;
+
+	if (IS_ERR_OR_NULL(fwnode))
+		return false;
+
+	endpoint = fwnode_graph_get_next_endpoint(fwnode, NULL);
+	if (endpoint) {
+		fwnode_handle_put(endpoint);
+		return true;
+	}
+
+	return cio2_check_fwnode_graph(fwnode->secondary);
+}
+
 /**************** PCI interface ****************/
 
 static int cio2_pci_probe(struct pci_dev *pci_dev,
 			  const struct pci_device_id *id)
 {
+	struct fwnode_handle *fwnode = dev_fwnode(&pci_dev->dev);
 	struct cio2_device *cio2;
 	int r;
 
@@ -1715,6 +1732,23 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
 		return -ENOMEM;
 	cio2->pci_dev = pci_dev;
 
+	/*
+	 * On some platforms no connections to sensors are defined in firmware,
+	 * if the device has no endpoints then we can try to build those as
+	 * software_nodes parsed from SSDB.
+	 */
+	if (!cio2_check_fwnode_graph(fwnode)) {
+		if (fwnode && !IS_ERR_OR_NULL(fwnode->secondary)) {
+			dev_err(&pci_dev->dev,
+				"fwnode graph has no endpoints connected\n");
+			return -EINVAL;
+		}
+
+		r = cio2_bridge_init(pci_dev);
+		if (r)
+			return r;
+	}
+
 	r = pcim_enable_device(pci_dev);
 	if (r) {
 		dev_err(&pci_dev->dev, "failed to enable device (%d)\n", r);
diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.h b/drivers/media/pci/intel/ipu3/ipu3-cio2.h
index ccf0b85ae36f..520a27c9cdad 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2.h
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.h
@@ -437,4 +437,10 @@ static inline struct cio2_queue *vb2q_to_cio2_queue(struct vb2_queue *vq)
 	return container_of(vq, struct cio2_queue, vbq);
 }
 
+#if IS_ENABLED(CONFIG_CIO2_BRIDGE)
+int cio2_bridge_init(struct pci_dev *cio2);
+#else
+int cio2_bridge_init(struct pci_dev *cio2) { return 0; }
+#endif
+
 #endif
-- 
2.25.1

