Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D344E2F75DF
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 10:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbhAOJu5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jan 2021 04:50:57 -0500
Received: from mga18.intel.com ([134.134.136.126]:51117 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729700AbhAOJu4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Jan 2021 04:50:56 -0500
IronPort-SDR: ShHX0yd5vW1kdEMPtD4nKLNxVOgwEjIf9aZ/CZxIGMWtAijlgRW97EN7lnP7NaOR/HoPk3CGri
 G28zzaPctK6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="166195721"
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="166195721"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 01:49:20 -0800
IronPort-SDR: zcK7kwaQygU0Itc1iRcWDKEEc/0794bZrjDXecjiLz19eJ8mVTs4OtZ7BR4p37a/7ULILmhuVX
 JZgsXVzV/U5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="465538732"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jan 2021 01:49:17 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg KH <greg@kroah.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v3 1/4] software node: Introduce device_add_software_node()
Date:   Fri, 15 Jan 2021 12:49:11 +0300
Message-Id: <20210115094914.88401-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115094914.88401-1-heikki.krogerus@linux.intel.com>
References: <20210115094914.88401-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This helper will register a software node and then assign
it to device at the same time. The function will also make
sure that the device can't have more than one software node.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Acked-by: Felipe Balbi <balbi@kernel.org>
---
 drivers/base/swnode.c    | 71 +++++++++++++++++++++++++++++++++++-----
 include/linux/property.h |  3 ++
 2 files changed, 65 insertions(+), 9 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 4a4b2008fbc26..4842dd6782000 100644
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
@@ -843,22 +856,62 @@ void fwnode_remove_software_node(struct fwnode_handle *fwnode)
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
+	software_node_notify(dev, KOBJ_REMOVE);
+	set_secondary_fwnode(dev, NULL);
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

