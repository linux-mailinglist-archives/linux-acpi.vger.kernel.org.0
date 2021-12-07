Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F12E46BDEC
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Dec 2021 15:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbhLGOll (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Dec 2021 09:41:41 -0500
Received: from mga03.intel.com ([134.134.136.65]:48412 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238078AbhLGOli (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 Dec 2021 09:41:38 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237528453"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="237528453"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 06:38:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="657725145"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Dec 2021 06:38:05 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] usb: typec: port-mapper: Convert to the component framework
Date:   Tue,  7 Dec 2021 17:37:56 +0300
Message-Id: <20211207143757.21895-5-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211207143757.21895-1-heikki.krogerus@linux.intel.com>
References: <20211207143757.21895-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Instead of trying to keep track of the connections to the
USB Type-C connectors separately, letting the component
framework take care of that.

From now on every USB Type-C connector will register itself
as "aggregate" - component master - and anything that can be
connected to it can then simply register itself as a generic
component.

The matching of the components and the connector shall rely
on ACPI _PLD initially. Before registering itself as the
aggregate, the connector will check the list of other
devices that share the same ACPI _PLD with it, and add a
component match entry for each one of them. Because only
ACPI is supported for now, the driver shall only be build
when ACPI is supported.

This removes the need for the custom API that the driver
exposed. The components and the connector can therefore
exist completely independently of each other. The order in
which they are registered, as well as are they modules or
not, is now irrelevant.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/Makefile      |   3 +-
 drivers/usb/typec/class.c       |   2 -
 drivers/usb/typec/class.h       |  10 +-
 drivers/usb/typec/port-mapper.c | 280 ++++----------------------------
 include/linux/usb/typec.h       |  12 --
 5 files changed, 43 insertions(+), 264 deletions(-)

diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
index a0adb8947a301..57870a2bd7873 100644
--- a/drivers/usb/typec/Makefile
+++ b/drivers/usb/typec/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_TYPEC)		+= typec.o
-typec-y				:= class.o mux.o bus.o port-mapper.o
+typec-y				:= class.o mux.o bus.o
+typec-$(CONFIG_ACPI)		+= port-mapper.o
 obj-$(CONFIG_TYPEC)		+= altmodes/
 obj-$(CONFIG_TYPEC_TCPM)	+= tcpm/
 obj-$(CONFIG_TYPEC_UCSI)	+= ucsi/
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index aeef453aa6585..45a6f0c807cb5 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -2039,8 +2039,6 @@ struct typec_port *typec_register_port(struct device *parent,
 
 	ida_init(&port->mode_ids);
 	mutex_init(&port->port_type_lock);
-	mutex_init(&port->port_list_lock);
-	INIT_LIST_HEAD(&port->port_list);
 
 	port->id = id;
 	port->ops = cap->ops;
diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
index aef03eb7e1523..0f1bd6d19d67e 100644
--- a/drivers/usb/typec/class.h
+++ b/drivers/usb/typec/class.h
@@ -54,11 +54,6 @@ struct typec_port {
 
 	const struct typec_capability	*cap;
 	const struct typec_operations   *ops;
-
-	struct list_head		port_list;
-	struct mutex			port_list_lock; /* Port list lock */
-
-	void				*pld;
 };
 
 #define to_typec_port(_dev_) container_of(_dev_, struct typec_port, dev)
@@ -79,7 +74,12 @@ extern const struct device_type typec_port_dev_type;
 extern struct class typec_mux_class;
 extern struct class typec_class;
 
+#if defined(CONFIG_ACPI)
 int typec_link_ports(struct typec_port *connector);
 void typec_unlink_ports(struct typec_port *connector);
+#else
+static inline int typec_link_ports(struct typec_port *connector) { return 0; }
+static inline void typec_unlink_ports(struct typec_port *connector) { }
+#endif
 
 #endif /* __USB_TYPEC_CLASS__ */
diff --git a/drivers/usb/typec/port-mapper.c b/drivers/usb/typec/port-mapper.c
index 9b0991bdf391a..03dce12bf11ff 100644
--- a/drivers/usb/typec/port-mapper.c
+++ b/drivers/usb/typec/port-mapper.c
@@ -7,273 +7,65 @@
  */
 
 #include <linux/acpi.h>
-#include <linux/usb.h>
-#include <linux/usb/typec.h>
+#include <linux/component.h>
 
 #include "class.h"
 
-struct port_node {
-	struct list_head list;
-	struct device *dev;
-	void *pld;
-};
-
-static int acpi_pld_match(const struct acpi_pld_info *pld1,
-			  const struct acpi_pld_info *pld2)
-{
-	if (!pld1 || !pld2)
-		return 0;
-
-	/*
-	 * To speed things up, first checking only the group_position. It seems
-	 * to often have the first unique value in the _PLD.
-	 */
-	if (pld1->group_position == pld2->group_position)
-		return !memcmp(pld1, pld2, sizeof(struct acpi_pld_info));
-
-	return 0;
-}
-
-static void *get_pld(struct device *dev)
-{
-#ifdef CONFIG_ACPI
-	struct acpi_pld_info *pld;
-	acpi_status status;
-
-	if (!has_acpi_companion(dev))
-		return NULL;
-
-	status = acpi_get_physical_device_location(ACPI_HANDLE(dev), &pld);
-	if (ACPI_FAILURE(status))
-		return NULL;
-
-	return pld;
-#else
-	return NULL;
-#endif
-}
-
-static void free_pld(void *pld)
-{
-#ifdef CONFIG_ACPI
-	ACPI_FREE(pld);
-#endif
-}
-
-static int __link_port(struct typec_port *con, struct port_node *node)
-{
-	int ret;
-
-	ret = sysfs_create_link(&node->dev->kobj, &con->dev.kobj, "connector");
-	if (ret)
-		return ret;
-
-	ret = sysfs_create_link(&con->dev.kobj, &node->dev->kobj,
-				dev_name(node->dev));
-	if (ret) {
-		sysfs_remove_link(&node->dev->kobj, "connector");
-		return ret;
-	}
-
-	list_add_tail(&node->list, &con->port_list);
-
-	return 0;
-}
-
-static int link_port(struct typec_port *con, struct port_node *node)
-{
-	int ret;
-
-	mutex_lock(&con->port_list_lock);
-	ret = __link_port(con, node);
-	mutex_unlock(&con->port_list_lock);
-
-	return ret;
-}
-
-static void __unlink_port(struct typec_port *con, struct port_node *node)
+static int typec_aggregate_bind(struct device *dev)
 {
-	sysfs_remove_link(&con->dev.kobj, dev_name(node->dev));
-	sysfs_remove_link(&node->dev->kobj, "connector");
-	list_del(&node->list);
+	return component_bind_all(dev, NULL);
 }
 
-static void unlink_port(struct typec_port *con, struct port_node *node)
+static void typec_aggregate_unbind(struct device *dev)
 {
-	mutex_lock(&con->port_list_lock);
-	__unlink_port(con, node);
-	mutex_unlock(&con->port_list_lock);
+	component_unbind_all(dev, NULL);
 }
 
-static struct port_node *create_port_node(struct device *port)
-{
-	struct port_node *node;
-
-	node = kzalloc(sizeof(*node), GFP_KERNEL);
-	if (!node)
-		return ERR_PTR(-ENOMEM);
-
-	node->dev = get_device(port);
-	node->pld = get_pld(port);
-
-	return node;
-}
-
-static void remove_port_node(struct port_node *node)
-{
-	put_device(node->dev);
-	free_pld(node->pld);
-	kfree(node);
-}
-
-static int connector_match(struct device *dev, const void *data)
-{
-	const struct port_node *node = data;
-
-	if (!is_typec_port(dev))
-		return 0;
-
-	return acpi_pld_match(to_typec_port(dev)->pld, node->pld);
-}
+static const struct component_master_ops typec_aggregate_ops = {
+	.bind = typec_aggregate_bind,
+	.unbind = typec_aggregate_unbind,
+};
 
-static struct device *find_connector(struct port_node *node)
+static int typec_port_compare(struct device *dev, void *fwnode)
 {
-	if (!node->pld)
-		return NULL;
-
-	return class_find_device(&typec_class, NULL, node, connector_match);
+	return dev_fwnode(dev) == fwnode;
 }
 
-/**
- * typec_link_port - Link a port to its connector
- * @port: The port device
- *
- * Find the connector of @port and create symlink named "connector" for it.
- * Returns 0 on success, or errno in case of a failure.
- *
- * NOTE. The function increments the reference count of @port on success.
- */
-int typec_link_port(struct device *port)
-{
-	struct device *connector;
-	struct port_node *node;
-	int ret;
-
-	node = create_port_node(port);
-	if (IS_ERR(node))
-		return PTR_ERR(node);
-
-	connector = find_connector(node);
-	if (!connector) {
-		ret = 0;
-		goto remove_node;
-	}
-
-	ret = link_port(to_typec_port(connector), node);
-	if (ret)
-		goto put_connector;
-
-	return 0;
-
-put_connector:
-	put_device(connector);
-remove_node:
-	remove_port_node(node);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(typec_link_port);
-
-static int port_match_and_unlink(struct device *connector, void *port)
+int typec_link_ports(struct typec_port *con)
 {
-	struct port_node *node;
-	struct port_node *tmp;
-	int ret = 0;
+	struct acpi_device_location *location;
+	struct component_match *match = NULL;
+	struct acpi_device *adev;
 
-	if (!is_typec_port(connector))
+	location = acpi_device_get_location(ACPI_COMPANION(&con->dev));
+	if (!location)
 		return 0;
 
-	mutex_lock(&to_typec_port(connector)->port_list_lock);
-	list_for_each_entry_safe(node, tmp, &to_typec_port(connector)->port_list, list) {
-		ret = node->dev == port;
-		if (ret) {
-			unlink_port(to_typec_port(connector), node);
-			remove_port_node(node);
-			put_device(connector);
-			break;
-		}
-	}
-	mutex_unlock(&to_typec_port(connector)->port_list_lock);
+	/* Component match for every device that shares the same _PLD. */
+	list_for_each_entry(adev, &location->devices, location_list) {
+		if (adev == ACPI_COMPANION(&con->dev))
+			continue;
 
-	return ret;
-}
-
-/**
- * typec_unlink_port - Unlink port from its connector
- * @port: The port device
- *
- * Removes the symlink "connector" and decrements the reference count of @port.
- */
-void typec_unlink_port(struct device *port)
-{
-	class_for_each_device(&typec_class, NULL, port, port_match_and_unlink);
-}
-EXPORT_SYMBOL_GPL(typec_unlink_port);
-
-static int each_port(struct device *port, void *connector)
-{
-	struct port_node *node;
-	int ret;
-
-	node = create_port_node(port);
-	if (IS_ERR(node))
-		return PTR_ERR(node);
-
-	if (!connector_match(connector, node)) {
-		remove_port_node(node);
-		return 0;
+		component_match_add(&con->dev, &match, typec_port_compare,
+				    acpi_fwnode_handle(adev));
 	}
 
-	ret = link_port(to_typec_port(connector), node);
-	if (ret) {
-		remove_port_node(node->pld);
-		return ret;
-	}
-
-	get_device(connector);
-
-	return 0;
-}
-
-int typec_link_ports(struct typec_port *con)
-{
-	int ret = 0;
-
-	con->pld = get_pld(&con->dev);
-	if (!con->pld)
-		return 0;
-
-	ret = usb_for_each_port(&con->dev, each_port);
-	if (ret)
-		typec_unlink_ports(con);
+	/*
+	 * REVISIT: Now each connector can have only a single component master.
+	 * So far only the USB ports connected to the USB Type-C connector share
+	 * the _PLD with it, but if there one day is something else (like maybe
+	 * the DisplayPort ACPI device object) that also shares the _PLD with
+	 * the connector, every one of those needs to have its own component
+	 * master, because each different type of component needs to be bind to
+	 * the connector independently of the other components. That requires
+	 * improvements to the component framework. Right now you can only have
+	 * one master per device.
+	 */
 
-	return ret;
+	return component_master_add_with_match(&con->dev, &typec_aggregate_ops, match);
 }
 
 void typec_unlink_ports(struct typec_port *con)
 {
-	struct port_node *node;
-	struct port_node *tmp;
-
-	mutex_lock(&con->port_list_lock);
-
-	list_for_each_entry_safe(node, tmp, &con->port_list, list) {
-		__unlink_port(con, node);
-		remove_port_node(node);
-		put_device(&con->dev);
-	}
-
-	mutex_unlock(&con->port_list_lock);
-
-	free_pld(con->pld);
+	component_master_del(&con->dev, &typec_aggregate_ops);
 }
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index e2e44bb1dad85..7ba45a97eeae3 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -305,16 +305,4 @@ void typec_partner_set_svdm_version(struct typec_partner *partner,
 				    enum usb_pd_svdm_ver svdm_version);
 int typec_get_negotiated_svdm_version(struct typec_port *port);
 
-#if IS_REACHABLE(CONFIG_TYPEC)
-int typec_link_port(struct device *port);
-void typec_unlink_port(struct device *port);
-#else
-static inline int typec_link_port(struct device *port)
-{
-	return 0;
-}
-
-static inline void typec_unlink_port(struct device *port) { }
-#endif
-
 #endif /* __LINUX_USB_TYPEC_H */
-- 
2.33.0

