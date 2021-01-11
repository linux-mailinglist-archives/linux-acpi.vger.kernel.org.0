Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9712F17D1
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Jan 2021 15:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbhAKOOz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Jan 2021 09:14:55 -0500
Received: from mga17.intel.com ([192.55.52.151]:16979 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728752AbhAKOOz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Jan 2021 09:14:55 -0500
IronPort-SDR: XUqVRtq8E4OidGC9iBV5IccVChw3E66g+m7uLeo+LXkg0FwcfweqzHyLvmGxkJmjKXJDemMm2n
 zpue7ve4ZOpw==
X-IronPort-AV: E=McAfee;i="6000,8403,9860"; a="157645644"
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; 
   d="scan'208";a="157645644"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 06:10:52 -0800
IronPort-SDR: /R0Opl2sjnfUIkbiEdpOwEfz36xjSdG4dZmFxncfwC03snkbvWjWKAhOiOIIB0EnoWWf9HGxi8
 5+v4LHMRnuvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; 
   d="scan'208";a="464171597"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jan 2021 06:10:49 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Felipe Balbi <balbi@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 1/3] software node: Introduce device_add_software_node()
Date:   Mon, 11 Jan 2021 17:10:43 +0300
Message-Id: <20210111141045.14027-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210111141045.14027-1-heikki.krogerus@linux.intel.com>
References: <20210111141045.14027-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This helper will register a software node and then assign
it to device at the same time. The function will also make
sure that the device can't have more than one software node.

Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/swnode.c    | 69 ++++++++++++++++++++++++++++++++++------
 include/linux/property.h |  3 ++
 2 files changed, 63 insertions(+), 9 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 4a4b2008fbc26..60a8501a4976c 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -48,6 +48,19 @@ EXPORT_SYMBOL_GPL(is_software_node);
 				     struct swnode, fwnode) : NULL;	\
 	})
 
+static inline struct swnode *dev_to_swnode(struct device *dev)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+
+	if (!fwnode)
+		return NULL;
+
+	if (!is_software_node(fwnode))
+		fwnode = fwnode->secondary;
+
+	return to_swnode(fwnode);
+}
+
 static struct swnode *
 software_node_to_swnode(const struct software_node *node)
 {
@@ -843,22 +856,60 @@ void fwnode_remove_software_node(struct fwnode_handle *fwnode)
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
-	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct swnode *swnode;
 	int ret;
 
-	if (!fwnode)
-		return 0;
-
-	if (!is_software_node(fwnode))
-		fwnode = fwnode->secondary;
-	if (!is_software_node(fwnode))
+	swnode = dev_to_swnode(dev);
+	if (!swnode)
 		return 0;
 
-	swnode = to_swnode(fwnode);
-
 	switch (action) {
 	case KOBJ_ADD:
 		ret = sysfs_create_link(&dev->kobj, &swnode->kobj,
diff --git a/include/linux/property.h b/include/linux/property.h
index 0a9001fe7aeab..b0e413dc59271 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -488,4 +488,7 @@ fwnode_create_software_node(const struct property_entry *properties,
 			    const struct fwnode_handle *parent);
 void fwnode_remove_software_node(struct fwnode_handle *fwnode);
 
+int device_add_software_node(struct device *dev, const struct software_node *swnode);
+void device_remove_software_node(struct device *dev);
+
 #endif /* _LINUX_PROPERTY_H_ */
-- 
2.29.2

