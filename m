Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B756F29E9D5
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 12:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgJ2K7x (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 06:59:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:56275 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbgJ2K7t (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Oct 2020 06:59:49 -0400
IronPort-SDR: Kqc8HuaizFturwdDf0d4FFea0Q6k289EtXRgkJVPsYtnWUha/TnyOryqPRd+wiX6lmTp8XXLyo
 2b6tmimHwNiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="186197285"
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="186197285"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 03:59:48 -0700
IronPort-SDR: +Dsx0wvi00Y54Omx9BJKAZNZ27cnPk7dJLYdJVYaUgoxmUpE3ygnSl/I5o1Vr1Db79PLkHbmul
 WFk1NFyB2W4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="425017603"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Oct 2020 03:59:47 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCHv2 2/3] software node: Introduce device_add_software_node()
Date:   Thu, 29 Oct 2020 13:59:40 +0300
Message-Id: <20201029105941.63410-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029105941.63410-1-heikki.krogerus@linux.intel.com>
References: <20201029105941.63410-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 595a9c240fede..0001fbea19cff 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -1525,6 +1525,51 @@ void fwnode_remove_software_node(struct fwnode_handle *fwnode)
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
index 33b25c8bd4052..993638e0a0b6e 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -495,4 +495,7 @@ fwnode_create_software_node(const struct property_entry *properties,
 			    const struct fwnode_handle *parent);
 void fwnode_remove_software_node(struct fwnode_handle *fwnode);
 
+int device_add_software_node(struct device *dev, const struct software_node *swnode);
+void device_remove_software_node(struct device *dev);
+
 #endif /* _LINUX_PROPERTY_H_ */
-- 
2.28.0

