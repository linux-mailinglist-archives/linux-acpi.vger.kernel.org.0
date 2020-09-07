Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7645C260397
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 19:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgIGRv2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 13:51:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:8883 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729182AbgIGMFh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 08:05:37 -0400
IronPort-SDR: TWaqynpRCw3eX+8dl9VL/GTfdBQenXZXX6GhVTccq2mAw5bPko9POSiOEoUAFSCu6bSDEJJ0/E
 k6lrtppseQfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="138043153"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="138043153"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 05:05:37 -0700
IronPort-SDR: gpZ4on/2rlDNazBjbL8fzUNDAIahjCWmxd4bzpKL4oGCOrRVHSDqHYCoYMo0R6IkmQjv0i9AL9
 b2XJFtFXHPMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="406818235"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Sep 2020 05:05:35 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v2 1/2] device property: Move fwnode_connection_find_match() under drivers/base/property.c
Date:   Mon,  7 Sep 2020 15:05:31 +0300
Message-Id: <20200907120532.37611-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907120532.37611-1-heikki.krogerus@linux.intel.com>
References: <20200907120532.37611-1-heikki.krogerus@linux.intel.com>
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
 drivers/base/Makefile    |   2 +-
 drivers/base/devcon.c    | 101 ---------------------------------------
 drivers/base/property.c  |  73 ++++++++++++++++++++++++++++
 include/linux/device.h   |   9 ----
 include/linux/property.h |  14 ++++++
 5 files changed, 88 insertions(+), 111 deletions(-)
 delete mode 100644 drivers/base/devcon.c

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

