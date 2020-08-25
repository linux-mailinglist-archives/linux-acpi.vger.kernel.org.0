Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB526251A5A
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Aug 2020 16:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgHYOAk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Aug 2020 10:00:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:59248 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbgHYOAA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Aug 2020 10:00:00 -0400
IronPort-SDR: XPE+FM/tUJ+s1G5arXB+/fVUovOenPFgla/Aq32wKMQYMz2YKrlIm/2PR4soHpTCTzmjC8az4X
 kFupwjGB3Hmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="217659393"
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; 
   d="scan'208";a="217659393"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 06:59:59 -0700
IronPort-SDR: pDQXdFwToNlKkfdblllbE+aoEzT+aMTv9gRygqxsV/hlIxVFKPzG9hQ0Boa00BqvIfPOwMUsiQ
 OY4WjPvF6d2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; 
   d="scan'208";a="402725580"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Aug 2020 06:59:57 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 2/3] software node: Introduce device_add_software_node()
Date:   Tue, 25 Aug 2020 16:59:50 +0300
Message-Id: <20200825135951.53340-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825135951.53340-1-heikki.krogerus@linux.intel.com>
References: <20200825135951.53340-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This helper will register a software node and then assign
it to device at the same time. The function will also make
sure that the device can't have more than one software node.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/swnode.c    | 45 ++++++++++++++++++++++++++++++++++++++++
 include/linux/property.h |  3 +++
 2 files changed, 48 insertions(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 9a13a61a2f0bb..ec14f02565a65 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -1356,6 +1356,51 @@ void fwnode_remove_software_node(struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(fwnode_remove_software_node);
 
+/**
+ * device_add_software_node - Assign software node to a device
+ * @dev: The device the software node is meant for.
+ * @swnode: The software node.
+ *
+ * This function will register @swnode and make it the secondary firmware node
+ * pointer of @dev. If @dev has no primary node, then @swnode will become the primary
+ * node.
+ */
+int device_add_software_node(struct device *dev, const struct software_node *swnode)
+{
+	int ret;
+
+	/* Only one software node per device. */
+	if (dev_to_swnode(dev))
+		return -EBUSY;
+
+	ret = software_node_register(swnode);
+	if (ret)
+		return ret;
+
+	set_secondary_fwnode(dev, software_node_fwnode(swnode));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(device_add_software_node);
+
+/**
+ * device_remove_software_node - Remove device's software node
+ * @dev: The device with the software node.
+ *
+ * This function will unregister the software node of @dev.
+ */
+void device_remove_software_node(struct device *dev)
+{
+	struct swnode *swnode;
+
+	swnode = dev_to_swnode(dev);
+	if (!swnode)
+		return;
+
+	kobject_put(&swnode->kobj);
+}
+EXPORT_SYMBOL_GPL(device_remove_software_node);
+
 int software_node_notify(struct device *dev, unsigned long action)
 {
 	struct swnode *swnode;
diff --git a/include/linux/property.h b/include/linux/property.h
index 4a2e0edb78275..5f84286183f9a 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -468,4 +468,7 @@ fwnode_create_software_node(const struct property_entry *properties,
 			    const struct fwnode_handle *parent);
 void fwnode_remove_software_node(struct fwnode_handle *fwnode);
 
+int device_add_software_node(struct device *dev, const struct software_node *swnode);
+void device_remove_software_node(struct device *dev);
+
 #endif /* _LINUX_PROPERTY_H_ */
-- 
2.28.0

