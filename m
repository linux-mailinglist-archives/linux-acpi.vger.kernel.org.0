Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA136A9498
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2019 23:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbfIDVLj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Sep 2019 17:11:39 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:37293 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730814AbfIDVLj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Sep 2019 17:11:39 -0400
Received: by mail-pf1-f202.google.com with SMTP id g1so118930pfo.4
        for <linux-acpi@vger.kernel.org>; Wed, 04 Sep 2019 14:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EIXukcSdp+uxpQofKUUVCp+AI9LAzuFCZNBqIe/4iSA=;
        b=I7iAwvNy0BYDx2Hd04bs57afJVCn40P2S+5F/81N2jzkNthhOFXdnOvY62qFcRz49/
         oijEo8evGiM9cQ6sYLAWBkct9hcX7SLyUcO2Psea6nSJb96zy/UEsQtGte3dDSkdMlqT
         sNmv3Q/A/LK8pVkBdfr0rHKZ9VO6lqIY3wAs9PaD1IuWGPDhQzg9dAxciSDxuGVK9OYx
         2rXLFDFkuu5LR97CUHVpbC15OfwPBiiMsslDdbAxnl0satjE9QuA6yK4LCMlN9cCzVP5
         7mLVTVEucHr4zQPQe+3Ygz7XM7QI4oH1b+uuUUBzOCdbv7nN6BrwLqQhwomapXtrqFOW
         gPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EIXukcSdp+uxpQofKUUVCp+AI9LAzuFCZNBqIe/4iSA=;
        b=Q05KVt75yBzzmJbDpN9QwgwA8+9VLNBx+fVth2dd7K0yvfGuSAUaitlt+J15C68FdZ
         DTRg96zq1Spvn9l0gBNV8oMxqiWU2knvMlwG1YKq5Fa8CfyAWO+ci7HVNg3BZvKheria
         Joc7aLouPkuJVYNQbgSUB79Tvv73D3RD8UzA8XBOMdoCvP5RBUMoLDctVerZJte/J0k+
         JtE2t1flWKWjjuOxNm6S5X/odvg9EIgYP5HJPNOhMWl5zBi25ztu+nY7fwJj19iyB4Yw
         6gy/etLCGG2HGY35mbenVCL/epcEH6e31Zfa7ar2uREQEVzqeoQ5W18QpRhw1CPG/c67
         f/nw==
X-Gm-Message-State: APjAAAWvsnISB7CfS2BqJayKnECCqg2dnplkFmksHjF2XvtucRqtIov8
        NKqHlcdL7guQNPRx2D4XAIYaZaVSezrgd18=
X-Google-Smtp-Source: APXvYqytALag+/pT4qSP38GJ/ffVQu/rLmyGfhsRgC4DWn3Pjx5MKv1jN8asTya9rhoV/Pn1LrT/LhLGLhxcPgo=
X-Received: by 2002:a63:2b84:: with SMTP id r126mr138422pgr.308.1567631497483;
 Wed, 04 Sep 2019 14:11:37 -0700 (PDT)
Date:   Wed,  4 Sep 2019 14:11:21 -0700
In-Reply-To: <20190904211126.47518-1-saravanak@google.com>
Message-Id: <20190904211126.47518-3-saravanak@google.com>
Mime-Version: 1.0
References: <20190904211126.47518-1-saravanak@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v11 2/6] driver core: Add support for linking devices during
 device addition
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-acpi@vger.kernel.org, clang-built-linux@googlegroups.com,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The firmware corresponding to a device (dev.fwnode) might be able to
provide functional dependency information between a device and its
supplier and consumer devices.  Tracking this functional dependency
allows optimizing device probe order and informing a supplier when all
its consumers have probed (and thereby actively managing their
resources).

The existing device links feature allows tracking and using
supplier-consumer relationships. So, this patch adds the add_links()
fwnode callback to allow firmware to create device links for each
device as the device is added.

However, when consumer devices are added, they might not have a supplier
device to link to despite needing mandatory resources/functionality from
one or more suppliers. A waiting_for_suppliers list is created to track
such consumers and retry linking them when new devices get added.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 Documentation/driver-api/device_link.rst |  3 +-
 drivers/base/core.c                      | 88 ++++++++++++++++++++++++
 include/linux/device.h                   |  2 +
 include/linux/fwnode.h                   | 17 +++++
 4 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/device_link.rst b/Documentation/driver-api/device_link.rst
index 1b5020ec6517..bc2d89af88ce 100644
--- a/Documentation/driver-api/device_link.rst
+++ b/Documentation/driver-api/device_link.rst
@@ -281,7 +281,8 @@ State machine
   :c:func:`driver_bound()`.)
 
 * Before a consumer device is probed, presence of supplier drivers is
-  verified by checking that links to suppliers are in ``DL_STATE_AVAILABLE``
+  verified by checking the consumer device is not in the wait_for_suppliers
+  list and by checking that links to suppliers are in ``DL_STATE_AVAILABLE``
   state.  The state of the links is updated to ``DL_STATE_CONSUMER_PROBE``.
   (Call to :c:func:`device_links_check_suppliers()` from
   :c:func:`really_probe()`.)
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 510fabf8918c..b3896da73b3d 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -44,6 +44,8 @@ early_param("sysfs.deprecated", sysfs_deprecated_setup);
 #endif
 
 /* Device links support. */
+static LIST_HEAD(wait_for_suppliers);
+static DEFINE_MUTEX(wfs_lock);
 
 #ifdef CONFIG_SRCU
 static DEFINE_MUTEX(device_links_lock);
@@ -430,6 +432,58 @@ struct device_link *device_link_add(struct device *consumer,
 }
 EXPORT_SYMBOL_GPL(device_link_add);
 
+/**
+ * device_link_wait_for_supplier - Add device to wait_for_suppliers list
+ * @consumer: Consumer device
+ *
+ * Marks the @consumer device as waiting for suppliers to become available by
+ * adding it to the wait_for_suppliers list. The consumer device will never be
+ * probed until it's removed from the wait_for_suppliers list.
+ *
+ * The caller is responsible for adding the links to the supplier devices once
+ * they are available and removing the @consumer device from the
+ * wait_for_suppliers list once links to all the suppliers have been created.
+ *
+ * This function is NOT meant to be called from the probe function of the
+ * consumer but rather from code that creates/adds the consumer device.
+ */
+static void device_link_wait_for_supplier(struct device *consumer)
+{
+	mutex_lock(&wfs_lock);
+	list_add_tail(&consumer->links.needs_suppliers, &wait_for_suppliers);
+	mutex_unlock(&wfs_lock);
+}
+
+/**
+ * device_link_add_missing_supplier_links - Add links from consumer devices to
+ *					    supplier devices, leaving any
+ *					    consumer with inactive suppliers on
+ *					    the wait_for_suppliers list
+ *
+ * Loops through all consumers waiting on suppliers and tries to add all their
+ * supplier links. If that succeeds, the consumer device is removed from
+ * wait_for_suppliers list. Otherwise, they are left in the wait_for_suppliers
+ * list.  Devices left on the wait_for_suppliers list will not be probed.
+ *
+ * The fwnode add_links callback is expected to return 0 if it has found and
+ * added all the supplier links for the consumer device. It should return an
+ * error if it isn't able to do so.
+ *
+ * The caller of device_link_wait_for_supplier() is expected to call this once
+ * it's aware of potential suppliers becoming available.
+ */
+static void device_link_add_missing_supplier_links(void)
+{
+	struct device *dev, *tmp;
+
+	mutex_lock(&wfs_lock);
+	list_for_each_entry_safe(dev, tmp, &wait_for_suppliers,
+				 links.needs_suppliers)
+		if (!fwnode_call_int_op(dev->fwnode, add_links, dev))
+			list_del_init(&dev->links.needs_suppliers);
+	mutex_unlock(&wfs_lock);
+}
+
 static void device_link_free(struct device_link *link)
 {
 	while (refcount_dec_not_one(&link->rpm_active))
@@ -564,6 +618,17 @@ int device_links_check_suppliers(struct device *dev)
 	struct device_link *link;
 	int ret = 0;
 
+	/*
+	 * Device waiting for supplier to become available is not allowed to
+	 * probe.
+	 */
+	mutex_lock(&wfs_lock);
+	if (!list_empty(&dev->links.needs_suppliers)) {
+		mutex_unlock(&wfs_lock);
+		return -EPROBE_DEFER;
+	}
+	mutex_unlock(&wfs_lock);
+
 	device_links_write_lock();
 
 	list_for_each_entry(link, &dev->links.suppliers, c_node) {
@@ -848,6 +913,10 @@ static void device_links_purge(struct device *dev)
 {
 	struct device_link *link, *ln;
 
+	mutex_lock(&wfs_lock);
+	list_del(&dev->links.needs_suppliers);
+	mutex_unlock(&wfs_lock);
+
 	/*
 	 * Delete all of the remaining links from this device to any other
 	 * devices (either consumers or suppliers).
@@ -1712,6 +1781,7 @@ void device_initialize(struct device *dev)
 #endif
 	INIT_LIST_HEAD(&dev->links.consumers);
 	INIT_LIST_HEAD(&dev->links.suppliers);
+	INIT_LIST_HEAD(&dev->links.needs_suppliers);
 	dev->links.status = DL_DEV_NO_DRIVER;
 }
 EXPORT_SYMBOL_GPL(device_initialize);
@@ -2202,6 +2272,24 @@ int device_add(struct device *dev)
 	if (dev->fwnode && !dev->fwnode->dev)
 		dev->fwnode->dev = dev;
 
+	/*
+	 * Check if any of the other devices (consumers) have been waiting for
+	 * this device (supplier) to be added so that they can create a device
+	 * link to it.
+	 *
+	 * This needs to happen after device_pm_add() because device_link_add()
+	 * requires the supplier be registered before it's called.
+	 *
+	 * But this also needs to happe before bus_probe_device() to make sure
+	 * waiting consumers can link to it before the driver is bound to the
+	 * device and the driver sync_state callback is called for this device.
+	 */
+	device_link_add_missing_supplier_links();
+
+	if (fwnode_has_op(dev->fwnode, add_links)
+	    && fwnode_call_int_op(dev->fwnode, add_links, dev))
+		device_link_wait_for_supplier(dev);
+
 	bus_probe_device(dev);
 	if (parent)
 		klist_add_tail(&dev->p->knode_parent,
diff --git a/include/linux/device.h b/include/linux/device.h
index f30e80185825..968316bb3bd1 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1136,11 +1136,13 @@ enum dl_dev_state {
  * struct dev_links_info - Device data related to device links.
  * @suppliers: List of links to supplier devices.
  * @consumers: List of links to consumer devices.
+ * @needs_suppliers: Hook to global list of devices waiting for suppliers.
  * @status: Driver status information.
  */
 struct dev_links_info {
 	struct list_head suppliers;
 	struct list_head consumers;
+	struct list_head needs_suppliers;
 	enum dl_dev_state status;
 };
 
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index d8c6d231d577..6ae05b9ce359 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -66,6 +66,21 @@ struct fwnode_reference_args {
  *			       endpoint node.
  * @graph_get_port_parent: Return the parent node of a port node.
  * @graph_parse_endpoint: Parse endpoint for port and endpoint id.
+ * @add_links:	Called after the device corresponding to the fwnode is added
+ *		using device_add(). The function is expected to create device
+ *		links to all the suppliers of the device that are available at
+ *		the time this function is called.  The function must NOT stop
+ *		at the first failed device link if other unlinked supplier
+ *		devices are present in the system.  If some suppliers are not
+ *		yet available, this function will be called again when other
+ *		devices are added to allow creating device links to any newly
+ *		available suppliers.
+ *
+ *		Return 0 if device links have been successfully created to all
+ *		the suppliers of this device or if the supplier information is
+ *		not known. Return an error if and only if the supplier
+ *		information is known but some of the suppliers are not yet
+ *		available to create device links to.
  */
 struct fwnode_operations {
 	struct fwnode_handle *(*get)(struct fwnode_handle *fwnode);
@@ -103,6 +118,8 @@ struct fwnode_operations {
 	(*graph_get_port_parent)(struct fwnode_handle *fwnode);
 	int (*graph_parse_endpoint)(const struct fwnode_handle *fwnode,
 				    struct fwnode_endpoint *endpoint);
+	int (*add_links)(const struct fwnode_handle *fwnode,
+			 struct device *dev);
 };
 
 #define fwnode_has_op(fwnode, op)				\
-- 
2.23.0.187.g17f5b7556c-goog

