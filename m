Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFC4926255
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2019 12:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbfEVKv6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 May 2019 06:51:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:32515 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729527AbfEVKvu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 22 May 2019 06:51:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 03:51:49 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 22 May 2019 03:51:45 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 15/16] platform/x86: intel_cht_int33fe: Supply fwnodes for the external dependencies
Date:   Wed, 22 May 2019 13:51:12 +0300
Message-Id: <20190522105113.11153-16-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522105113.11153-1-heikki.krogerus@linux.intel.com>
References: <20190522105113.11153-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Supplying also external devices, the DisplayPort connector
and the USB role switch, software fwnodes. After this the
driver has access to all the components tied to the USB
Type-C connector and can start creating software node
references to actually associate them with the USB Type-C
connector device.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/platform/x86/intel_cht_int33fe.c | 128 ++++++++++++++++++++++-
 1 file changed, 125 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index 34bc2d178760..e5c0b6573618 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -21,6 +21,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
@@ -32,6 +33,8 @@ enum {
 	INT33FE_NODE_FUSB302,
 	INT33FE_NODE_MAX17047,
 	INT33FE_NODE_PI3USB30532,
+	INT33FE_NODE_DISPLAYPORT,
+	INT33FE_NODE_ROLE_SWITCH,
 	INT33FE_NODE_USB_CONNECTOR,
 	INT33FE_NODE_MAX,
 };
@@ -42,6 +45,9 @@ struct cht_int33fe_data {
 	struct i2c_client *pi3usb30532;
 	/* Contain a list-head must be per device */
 	struct device_connection connections[4];
+
+	struct fwnode_handle *dp;
+	struct fwnode_handle *mux;
 };
 
 /*
@@ -110,10 +116,126 @@ static const struct software_node nodes[] = {
 	{ "fusb302", NULL, fusb302_props },
 	{ "max17047", NULL, max17047_props },
 	{ "pi3usb30532" },
+	{ "displayport" },
+	{ "usb-role-switch" },
 	{ "connector", &nodes[0], usb_connector_props },
 	{ }
 };
 
+static int cht_int33fe_setup_mux(struct cht_int33fe_data *data)
+{
+	struct fwnode_handle *fwnode;
+	struct device *dev;
+	struct device *p;
+
+	fwnode = software_node_fwnode(&nodes[INT33FE_NODE_ROLE_SWITCH]);
+	if (!fwnode)
+		return -ENODEV;
+
+	/* First finding the platform device */
+	p = bus_find_device_by_name(&platform_bus_type, NULL,
+				    "intel_xhci_usb_sw");
+	if (!p)
+		return -EPROBE_DEFER;
+
+	/* Then the mux child device */
+	dev = device_find_child_by_name(p, "intel_xhci_usb_sw-role-switch");
+	put_device(p);
+	if (!dev)
+		return -EPROBE_DEFER;
+
+	/* If there already is a node for the mux, using that one. */
+	if (dev->fwnode)
+		fwnode_remove_software_node(fwnode);
+	else
+		dev->fwnode = fwnode;
+
+	data->mux = fwnode_handle_get(dev->fwnode);
+	put_device(dev);
+
+	return 0;
+}
+
+static int cht_int33fe_setup_dp(struct cht_int33fe_data *data)
+{
+	struct fwnode_handle *fwnode;
+	struct pci_dev *pdev;
+
+	fwnode = software_node_fwnode(&nodes[INT33FE_NODE_DISPLAYPORT]);
+	if (!fwnode)
+		return -ENODEV;
+
+	/* First let's find the GPU PCI device */
+	pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, NULL);
+	if (!pdev || pdev->vendor != PCI_VENDOR_ID_INTEL) {
+		pci_dev_put(pdev);
+		return -ENODEV;
+	}
+
+	/* Then the DP child device node */
+	data->dp = device_get_named_child_node(&pdev->dev, "DD02");
+	pci_dev_put(pdev);
+	if (!data->dp)
+		return -ENODEV;
+
+	fwnode->secondary = ERR_PTR(-ENODEV);
+	data->dp->secondary = fwnode;
+
+	return 0;
+}
+
+static void cht_int33fe_remove_nodes(struct cht_int33fe_data *data)
+{
+	software_node_unregister_nodes(nodes);
+
+	if (data->mux) {
+		fwnode_handle_put(data->mux);
+		data->mux = NULL;
+	}
+
+	if (data->dp) {
+		data->dp->secondary = NULL;
+		fwnode_handle_put(data->dp);
+		data->dp = NULL;
+	}
+}
+
+static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
+{
+	int ret;
+
+	ret = software_node_register_nodes(nodes);
+	if (ret)
+		return ret;
+
+	/* The devices that are not created in this driver need extra steps. */
+
+	/*
+	 * There is no ACPI device node for the USB role mux, so we need to find
+	 * the mux device and assign our node directly to it. That means we
+	 * depend on the mux driver. This function will return -PROBE_DEFER
+	 * until the mux device is registered.
+	 */
+	ret = cht_int33fe_setup_mux(data);
+	if (ret)
+		goto err_remove_nodes;
+
+	/*
+	 * The DP connector does have ACPI device node. In this case we can just
+	 * find that ACPI node and assing our node as the secondary node to it.
+	 */
+	ret = cht_int33fe_setup_dp(data);
+	if (ret)
+		goto err_remove_nodes;
+
+	return 0;
+
+err_remove_nodes:
+	cht_int33fe_remove_nodes(data);
+
+	return ret;
+}
+
 static int
 cht_int33fe_register_max17047(struct device *dev, struct cht_int33fe_data *data)
 {
@@ -211,7 +333,7 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	ret = software_node_register_nodes(nodes);
+	ret = cht_int33fe_add_nodes(data);
 	if (ret)
 		return ret;
 
@@ -280,7 +402,7 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	device_connections_remove(data->connections);
 
 out_remove_nodes:
-	software_node_unregister_nodes(nodes);
+	cht_int33fe_remove_nodes(data);
 
 	return ret;
 }
@@ -294,7 +416,7 @@ static int cht_int33fe_remove(struct platform_device *pdev)
 	i2c_unregister_device(data->max17047);
 
 	device_connections_remove(data->connections);
-	software_node_unregister_nodes(nodes);
+	cht_int33fe_remove_nodes(data);
 
 	return 0;
 }
-- 
2.20.1

