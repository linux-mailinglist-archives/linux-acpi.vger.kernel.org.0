Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C655C25D8F8
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 14:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbgIDMvp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 08:51:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:65329 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730280AbgIDMve (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Sep 2020 08:51:34 -0400
IronPort-SDR: +jHN4jug9UaknK3w+xoTK+zuDk8WlKBOyYFt2Mc+ZATUHF2vinnBdAMYvblKuMxEt0IUm63XT8
 UvsQXFbqxhmw==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="221944962"
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="221944962"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 05:51:33 -0700
IronPort-SDR: T1DuK81L+S18mu4CxskHa1szYEsR87+CnmYH1KRcpgs4UsHZOQQ+d6HxpAXG0AaYh598fy74r6
 vkh5Ts62LtLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="405834956"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Sep 2020 05:51:31 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 4/4] device property: Move fwnode_connection_find_match() under drivers/base/property.c
Date:   Fri,  4 Sep 2020 15:51:23 +0300
Message-Id: <20200904125123.83725-5-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904125123.83725-1-heikki.krogerus@linux.intel.com>
References: <20200904125123.83725-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The function is now only a helper that searches the
connection from device graph and then by checking if the
supplied connection identifier matches a property that
contains reference.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 .../driver-api/device_connection.rst          |  43 --------
 drivers/base/Makefile                         |   2 +-
 drivers/base/devcon.c                         | 101 ------------------
 drivers/base/property.c                       |  73 +++++++++++++
 include/linux/device.h                        |   9 --
 include/linux/property.h                      |  14 +++
 6 files changed, 88 insertions(+), 154 deletions(-)
 delete mode 100644 Documentation/driver-api/device_connection.rst
 delete mode 100644 drivers/base/devcon.c

diff --git a/Documentation/driver-api/device_connection.rst b/Documentation/driver-api/device_connection.rst
deleted file mode 100644
index ba364224c349b..0000000000000
--- a/Documentation/driver-api/device_connection.rst
+++ /dev/null
@@ -1,43 +0,0 @@
-==================
-Device connections
-==================
-
-Introduction
-------------
-
-Devices often have connections to other devices that are outside of the direct
-child/parent relationship. A serial or network communication controller, which
-could be a PCI device, may need to be able to get a reference to its PHY
-component, which could be attached for example to the I2C bus. Some device
-drivers need to be able to control the clocks or the GPIOs for their devices,
-and so on.
-
-Device connections are generic descriptions of any type of connection between
-two separate devices.
-
-Device connections alone do not create a dependency between the two devices.
-They are only descriptions which are not tied to either of the devices directly.
-A dependency between the two devices exists only if one of the two endpoint
-devices requests a reference to the other. The descriptions themselves can be
-defined in firmware (not yet supported) or they can be built-in.
-
-Usage
------
-
-Device connections should exist before device ``->probe`` callback is called for
-either endpoint device in the description. If the connections are defined in
-firmware, this is not a problem. It should be considered if the connection
-descriptions are "built-in", and need to be added separately.
-
-The connection description consists of the names of the two devices with the
-connection, i.e. the endpoints, and unique identifier for the connection which
-is needed if there are multiple connections between the two devices.
-
-After a description exists, the devices in it can request reference to the other
-endpoint device, or they can request the description itself.
-
-API
----
-
-.. kernel-doc:: drivers/base/devcon.c
-   :functions: device_connection_find_match device_connection_find device_connection_add device_connection_remove
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 157452080f3d7..41369fc7004fd 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -6,7 +6,7 @@ obj-y			:= component.o core.o bus.o dd.o syscore.o \
 			   cpu.o firmware.o init.o map.o devres.o \
 			   attribute_container.o transport_class.o \
 			   topology.o container.o property.o cacheinfo.o \
-			   devcon.o swnode.o
+			   swnode.o
 obj-$(CONFIG_DEVTMPFS)	+= devtmpfs.o
 obj-y			+= power/
 obj-$(CONFIG_ISA_BUS_API)	+= isa.o
diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
deleted file mode 100644
index 1790e84dbe7c2..0000000000000
--- a/drivers/base/devcon.c
+++ /dev/null
@@ -1,101 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/**
- * Device connections
- *
- * Copyright (C) 2018 Intel Corporation
- * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
- */
-
-#include <linux/device.h>
-#include <linux/property.h>
-
-static void *
-fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
-			  void *data, devcon_match_fn_t match)
-{
-	struct fwnode_handle *node;
-	struct fwnode_handle *ep;
-	void *ret;
-
-	fwnode_graph_for_each_endpoint(fwnode, ep) {
-		node = fwnode_graph_get_remote_port_parent(ep);
-		if (!fwnode_device_is_available(node))
-			continue;
-
-		ret = match(node, con_id, data);
-		fwnode_handle_put(node);
-		if (ret) {
-			fwnode_handle_put(ep);
-			return ret;
-		}
-	}
-	return NULL;
-}
-
-static void *
-fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
-		    void *data, devcon_match_fn_t match)
-{
-	struct fwnode_handle *node;
-	void *ret;
-	int i;
-
-	for (i = 0; ; i++) {
-		node = fwnode_find_reference(fwnode, con_id, i);
-		if (IS_ERR(node))
-			break;
-
-		ret = match(node, NULL, data);
-		fwnode_handle_put(node);
-		if (ret)
-			return ret;
-	}
-
-	return NULL;
-}
-
-/**
- * fwnode_connection_find_match - Find connection from a device node
- * @fwnode: Device node with the connection
- * @con_id: Identifier for the connection
- * @data: Data for the match function
- * @match: Function to check and convert the connection description
- *
- * Find a connection with unique identifier @con_id between @fwnode and another
- * device node. @match will be used to convert the connection description to
- * data the caller is expecting to be returned.
- */
-void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
-				   const char *con_id, void *data,
-				   devcon_match_fn_t match)
-{
-	void *ret;
-
-	if (!fwnode || !match)
-		return NULL;
-
-	ret = fwnode_graph_devcon_match(fwnode, con_id, data, match);
-	if (ret)
-		return ret;
-
-	return fwnode_devcon_match(fwnode, con_id, data, match);
-}
-EXPORT_SYMBOL_GPL(fwnode_connection_find_match);
-
-/**
- * device_connection_find_match - Find physical connection to a device
- * @dev: Device with the connection
- * @con_id: Identifier for the connection
- * @data: Data for the match function
- * @match: Function to check and convert the connection description
- *
- * Find a connection with unique identifier @con_id between @dev and another
- * device. @match will be used to convert the connection description to data the
- * caller is expecting to be returned.
- */
-void *device_connection_find_match(struct device *dev, const char *con_id,
-				   void *data, devcon_match_fn_t match)
-{
-	return fwnode_connection_find_match(dev_fwnode(dev), con_id, data, match);
-}
-EXPORT_SYMBOL_GPL(device_connection_find_match);
diff --git a/drivers/base/property.c b/drivers/base/property.c
index d58aa98fe9645..4c43d30145c6b 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1184,3 +1184,76 @@ const void *device_get_match_data(struct device *dev)
 	return fwnode_call_ptr_op(dev_fwnode(dev), device_get_match_data, dev);
 }
 EXPORT_SYMBOL_GPL(device_get_match_data);
+
+static void *
+fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
+			  void *data, devcon_match_fn_t match)
+{
+	struct fwnode_handle *node;
+	struct fwnode_handle *ep;
+	void *ret;
+
+	fwnode_graph_for_each_endpoint(fwnode, ep) {
+		node = fwnode_graph_get_remote_port_parent(ep);
+		if (!fwnode_device_is_available(node))
+			continue;
+
+		ret = match(node, con_id, data);
+		fwnode_handle_put(node);
+		if (ret) {
+			fwnode_handle_put(ep);
+			return ret;
+		}
+	}
+	return NULL;
+}
+
+static void *
+fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
+		    void *data, devcon_match_fn_t match)
+{
+	struct fwnode_handle *node;
+	void *ret;
+	int i;
+
+	for (i = 0; ; i++) {
+		node = fwnode_find_reference(fwnode, con_id, i);
+		if (IS_ERR(node))
+			break;
+
+		ret = match(node, NULL, data);
+		fwnode_handle_put(node);
+		if (ret)
+			return ret;
+	}
+
+	return NULL;
+}
+
+/**
+ * fwnode_connection_find_match - Find connection from a device node
+ * @fwnode: Device node with the connection
+ * @con_id: Identifier for the connection
+ * @data: Data for the match function
+ * @match: Function to check and convert the connection description
+ *
+ * Find a connection with unique identifier @con_id between @fwnode and another
+ * device node. @match will be used to convert the connection description to
+ * data the caller is expecting to be returned.
+ */
+void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
+				   const char *con_id, void *data,
+				   devcon_match_fn_t match)
+{
+	void *ret;
+
+	if (!fwnode || !match)
+		return NULL;
+
+	ret = fwnode_graph_devcon_match(fwnode, con_id, data, match);
+	if (ret)
+		return ret;
+
+	return fwnode_devcon_match(fwnode, con_id, data, match);
+}
+EXPORT_SYMBOL_GPL(fwnode_connection_find_match);
diff --git a/include/linux/device.h b/include/linux/device.h
index c3ced17d91ee6..6f76c1f38e116 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -292,15 +292,6 @@ struct device_dma_parameters {
 	unsigned long segment_boundary_mask;
 };
 
-typedef void *(*devcon_match_fn_t)(struct fwnode_handle *fwnode, const char *id,
-				   void *data);
-
-void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
-				   const char *con_id, void *data,
-				   devcon_match_fn_t match);
-void *device_connection_find_match(struct device *dev, const char *con_id,
-				   void *data, devcon_match_fn_t match);
-
 /**
  * enum device_link_state - Device link states.
  * @DL_STATE_NONE: The presence of the drivers is not being tracked.
diff --git a/include/linux/property.h b/include/linux/property.h
index 9f805c4428195..aedae94dcf41d 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -418,6 +418,20 @@ fwnode_graph_get_endpoint_by_id(const struct fwnode_handle *fwnode,
 int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 				struct fwnode_endpoint *endpoint);
 
+typedef void *(*devcon_match_fn_t)(struct fwnode_handle *fwnode, const char *id,
+				   void *data);
+
+void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
+				   const char *con_id, void *data,
+				   devcon_match_fn_t match);
+
+static inline void *device_connection_find_match(struct device *dev,
+						 const char *con_id, void *data,
+						 devcon_match_fn_t match)
+{
+	return fwnode_connection_find_match(dev_fwnode(dev), con_id, data, match);
+}
+
 /* -------------------------------------------------------------------------- */
 /* Software fwnode support - when HW description is incomplete or missing */
 
-- 
2.28.0

