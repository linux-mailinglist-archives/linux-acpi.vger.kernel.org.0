Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3723464E51
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Dec 2021 13:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349449AbhLANCD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Dec 2021 08:02:03 -0500
Received: from mga01.intel.com ([192.55.52.88]:57001 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349447AbhLANCC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 1 Dec 2021 08:02:02 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="260426455"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="260426455"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 04:58:41 -0800
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="460017249"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 04:58:39 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id DE029209F3;
        Wed,  1 Dec 2021 14:58:34 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1msPCx-003vlH-4c; Wed, 01 Dec 2021 14:59:35 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com,
        rafael@kernel.org
Subject: [PATCH v2 5/7] device property: Implement fwnode_graph_get_endpoint_count()
Date:   Wed,  1 Dec 2021 14:59:33 +0200
Message-Id: <20211201125934.936953-6-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211201125934.936953-1-sakari.ailus@linux.intel.com>
References: <20211201125934.936953-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add fwnode_graph_get_endpoint_count() function to provide generic
implementation of of_graph_get_endpoint_count(). The former by default
only counts endpoints to available devices which is consistent with the
rest of the fwnode graph API. By providing FWNODE_GRAPH_DEVICE_DISABLED
flag, also unconnected endpoints and endpoints to disabled devices are
counted.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c  | 49 ++++++++++++++++++++++++++++++++--------
 include/linux/property.h |  2 ++
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index ecc4e2eb10678..90075c051dccf 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1097,6 +1097,18 @@ fwnode_graph_get_remote_node(const struct fwnode_handle *fwnode, u32 port_id,
 }
 EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_node);
 
+static bool fwnode_graph_remote_available(struct fwnode_handle *ep)
+{
+	struct fwnode_handle *dev_node;
+	bool available;
+
+	dev_node = fwnode_graph_get_remote_port_parent(ep);
+	available = fwnode_device_is_available(dev_node);
+	fwnode_handle_put(dev_node);
+
+	return available;
+}
+
 /**
  * fwnode_graph_get_endpoint_by_id - get endpoint by port and endpoint numbers
  * @fwnode: parent fwnode_handle containing the graph
@@ -1130,16 +1142,8 @@ fwnode_graph_get_endpoint_by_id(const struct fwnode_handle *fwnode,
 		struct fwnode_endpoint fwnode_ep = { 0 };
 		int ret;
 
-		if (enabled_only) {
-			struct fwnode_handle *dev_node;
-			bool available;
-
-			dev_node = fwnode_graph_get_remote_port_parent(ep);
-			available = fwnode_device_is_available(dev_node);
-			fwnode_handle_put(dev_node);
-			if (!available)
-				continue;
-		}
+		if (enabled_only && !fwnode_graph_remote_available(ep))
+			continue;
 
 		ret = fwnode_graph_parse_endpoint(ep, &fwnode_ep);
 		if (ret < 0)
@@ -1172,6 +1176,31 @@ fwnode_graph_get_endpoint_by_id(const struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(fwnode_graph_get_endpoint_by_id);
 
+/**
+ * fwnode_graph_get_endpoint_count - Count endpoints on a device node
+ * @fwnode: The node related to a device
+ * @flags: fwnode lookup flags
+ * Count endpoints in a device node.
+ *
+ * If FWNODE_GRAPH_DEVICE_DISABLED flag is specified, also unconnected endpoints
+ * and endpoints connected to disabled devices are counted.
+ */
+unsigned int fwnode_graph_get_endpoint_count(struct fwnode_handle *fwnode,
+					     unsigned long flags)
+{
+	struct fwnode_handle *ep;
+	unsigned int count = 0;
+
+	fwnode_graph_for_each_endpoint(fwnode, ep) {
+		if (flags & FWNODE_GRAPH_DEVICE_DISABLED ||
+		    fwnode_graph_remote_available(ep))
+			count++;
+	}
+
+	return count;
+}
+EXPORT_SYMBOL_GPL(fwnode_graph_get_endpoint_count);
+
 /**
  * fwnode_graph_parse_endpoint - parse common endpoint node properties
  * @fwnode: pointer to endpoint fwnode_handle
diff --git a/include/linux/property.h b/include/linux/property.h
index af5a7e512c86f..e32b95f42c9db 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -427,6 +427,8 @@ static inline bool fwnode_graph_is_endpoint(struct fwnode_handle *fwnode)
 struct fwnode_handle *
 fwnode_graph_get_endpoint_by_id(const struct fwnode_handle *fwnode,
 				u32 port, u32 endpoint, unsigned long flags);
+unsigned int fwnode_graph_get_endpoint_count(struct fwnode_handle *fwnode,
+					     unsigned long flags);
 
 #define fwnode_graph_for_each_endpoint(fwnode, child)			\
 	for (child = NULL;						\
-- 
2.30.2

