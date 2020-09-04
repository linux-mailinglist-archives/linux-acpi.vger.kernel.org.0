Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8D725D8F9
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 14:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbgIDMvp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 08:51:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:65327 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730269AbgIDMvc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Sep 2020 08:51:32 -0400
IronPort-SDR: q8IiDUz+ugiH2E/ruXHwoRM6V+5HjVBsNq9nXd+LNn4iEYPOaq6pjY2wls3lXZknjFd2xY6t14
 Ge402pH4Qy2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="221944959"
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="221944959"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 05:51:31 -0700
IronPort-SDR: g3ywAS/gngJZQf1n9VeU5p5Mo4nY1knbItOu7CWhYyQT7SbwMdHQdSpMSMsLDJJjmQvSTNs/BY
 vfPkWnTH4F5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="405834950"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Sep 2020 05:51:29 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 3/4] device connection: Remove struct device_connection
Date:   Fri,  4 Sep 2020 15:51:22 +0300
Message-Id: <20200904125123.83725-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904125123.83725-1-heikki.krogerus@linux.intel.com>
References: <20200904125123.83725-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Since the connection descriptors can't be stored into the
list anymore, there is no need for the data structure.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/devcon.c     | 20 ++++++++++----------
 drivers/usb/roles/class.c | 12 ++++--------
 drivers/usb/typec/mux.c   | 19 ++++++++++---------
 include/linux/device.h    | 18 +-----------------
 4 files changed, 25 insertions(+), 44 deletions(-)

diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
index 94ab22a451ce3..1790e84dbe7c2 100644
--- a/drivers/base/devcon.c
+++ b/drivers/base/devcon.c
@@ -13,17 +13,17 @@ static void *
 fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
 			  void *data, devcon_match_fn_t match)
 {
-	struct device_connection con = { .id = con_id };
+	struct fwnode_handle *node;
 	struct fwnode_handle *ep;
 	void *ret;
 
 	fwnode_graph_for_each_endpoint(fwnode, ep) {
-		con.fwnode = fwnode_graph_get_remote_port_parent(ep);
-		if (!fwnode_device_is_available(con.fwnode))
+		node = fwnode_graph_get_remote_port_parent(ep);
+		if (!fwnode_device_is_available(node))
 			continue;
 
-		ret = match(&con, -1, data);
-		fwnode_handle_put(con.fwnode);
+		ret = match(node, con_id, data);
+		fwnode_handle_put(node);
 		if (ret) {
 			fwnode_handle_put(ep);
 			return ret;
@@ -36,17 +36,17 @@ static void *
 fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
 		    void *data, devcon_match_fn_t match)
 {
-	struct device_connection con = { };
+	struct fwnode_handle *node;
 	void *ret;
 	int i;
 
 	for (i = 0; ; i++) {
-		con.fwnode = fwnode_find_reference(fwnode, con_id, i);
-		if (IS_ERR(con.fwnode))
+		node = fwnode_find_reference(fwnode, con_id, i);
+		if (IS_ERR(node))
 			break;
 
-		ret = match(&con, -1, data);
-		fwnode_handle_put(con.fwnode);
+		ret = match(node, NULL, data);
+		fwnode_handle_put(node);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index 27d92af296351..97f37077b7f97 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -87,19 +87,15 @@ enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw)
 }
 EXPORT_SYMBOL_GPL(usb_role_switch_get_role);
 
-static void *usb_role_switch_match(struct device_connection *con, int ep,
+static void *usb_role_switch_match(struct fwnode_handle *fwnode, const char *id,
 				   void *data)
 {
 	struct device *dev;
 
-	if (con->fwnode) {
-		if (con->id && !fwnode_property_present(con->fwnode, con->id))
-			return NULL;
+	if (id && !fwnode_property_present(fwnode, id))
+		return NULL;
 
-		dev = class_find_device_by_fwnode(role_class, con->fwnode);
-	} else {
-		dev = class_find_device_by_name(role_class, con->endpoint[ep]);
-	}
+	dev = class_find_device_by_fwnode(role_class, fwnode);
 
 	return dev ? to_role_switch(dev) : ERR_PTR(-EPROBE_DEFER);
 }
diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index 52ad277e4565b..b069a5122aaa9 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -34,15 +34,15 @@ static int switch_fwnode_match(struct device *dev, const void *fwnode)
 	return dev_fwnode(dev) == fwnode && dev_name_ends_with(dev, "-switch");
 }
 
-static void *typec_switch_match(struct device_connection *con, int ep,
+static void *typec_switch_match(struct fwnode_handle *fwnode, const char *id,
 				void *data)
 {
 	struct device *dev;
 
-	if (con->id && !fwnode_property_present(con->fwnode, con->id))
+	if (id && !fwnode_property_present(fwnode, id))
 		return NULL;
 
-	dev = class_find_device(&typec_mux_class, NULL, con->fwnode,
+	dev = class_find_device(&typec_mux_class, NULL, fwnode,
 				switch_fwnode_match);
 
 	return dev ? to_typec_switch(dev) : ERR_PTR(-EPROBE_DEFER);
@@ -183,7 +183,8 @@ static int mux_fwnode_match(struct device *dev, const void *fwnode)
 	return dev_fwnode(dev) == fwnode && dev_name_ends_with(dev, "-mux");
 }
 
-static void *typec_mux_match(struct device_connection *con, int ep, void *data)
+static void *typec_mux_match(struct fwnode_handle *fwnode, const char *id,
+			     void *data)
 {
 	const struct typec_altmode_desc *desc = data;
 	struct device *dev;
@@ -196,20 +197,20 @@ static void *typec_mux_match(struct device_connection *con, int ep, void *data)
 	 * Check has the identifier already been "consumed". If it
 	 * has, no need to do any extra connection identification.
 	 */
-	match = !con->id;
+	match = !id;
 	if (match)
 		goto find_mux;
 
 	/* Accessory Mode muxes */
 	if (!desc) {
-		match = fwnode_property_present(con->fwnode, "accessory");
+		match = fwnode_property_present(fwnode, "accessory");
 		if (match)
 			goto find_mux;
 		return NULL;
 	}
 
 	/* Alternate Mode muxes */
-	nval = fwnode_property_count_u16(con->fwnode, "svid");
+	nval = fwnode_property_count_u16(fwnode, "svid");
 	if (nval <= 0)
 		return NULL;
 
@@ -217,7 +218,7 @@ static void *typec_mux_match(struct device_connection *con, int ep, void *data)
 	if (!val)
 		return ERR_PTR(-ENOMEM);
 
-	nval = fwnode_property_read_u16_array(con->fwnode, "svid", val, nval);
+	nval = fwnode_property_read_u16_array(fwnode, "svid", val, nval);
 	if (nval < 0) {
 		kfree(val);
 		return ERR_PTR(nval);
@@ -234,7 +235,7 @@ static void *typec_mux_match(struct device_connection *con, int ep, void *data)
 	return NULL;
 
 find_mux:
-	dev = class_find_device(&typec_mux_class, NULL, con->fwnode,
+	dev = class_find_device(&typec_mux_class, NULL, fwnode,
 				mux_fwnode_match);
 
 	return dev ? to_typec_switch(dev) : ERR_PTR(-EPROBE_DEFER);
diff --git a/include/linux/device.h b/include/linux/device.h
index 43569297c6cc1..c3ced17d91ee6 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -292,23 +292,7 @@ struct device_dma_parameters {
 	unsigned long segment_boundary_mask;
 };
 
-/**
- * struct device_connection - Device Connection Descriptor
- * @fwnode: The device node of the connected device
- * @endpoint: The names of the two devices connected together
- * @id: Unique identifier for the connection
- *
- * NOTE: @fwnode is not used together with @endpoint. @fwnode is used when
- * platform firmware defines the connection. When the connection is registered
- * with device_connection_add() @endpoint is used instead.
- */
-struct device_connection {
-	struct fwnode_handle	*fwnode;
-	const char		*endpoint[2];
-	const char		*id;
-};
-
-typedef void *(*devcon_match_fn_t)(struct device_connection *con, int ep,
+typedef void *(*devcon_match_fn_t)(struct fwnode_handle *fwnode, const char *id,
 				   void *data);
 
 void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
-- 
2.28.0

