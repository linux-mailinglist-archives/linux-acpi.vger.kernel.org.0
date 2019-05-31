Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E741D30FEF
	for <lists+linux-acpi@lfdr.de>; Fri, 31 May 2019 16:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfEaOQU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 May 2019 10:16:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:8345 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbfEaOQT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 May 2019 10:16:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 May 2019 07:16:19 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 31 May 2019 07:16:17 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 13/16] platform/x86: intel_cht_int33fe: Provide software nodes for the devices
Date:   Fri, 31 May 2019 17:15:44 +0300
Message-Id: <20190531141547.22728-14-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190531141547.22728-1-heikki.krogerus@linux.intel.com>
References: <20190531141547.22728-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Software nodes provide two features that we will need later.
1) Software nodes can have references to other software nodes.
2) Software nodes can exist before a device entry is created.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel_cht_int33fe.c | 54 ++++++++++++++++++++----
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index 4ab47d6df413..9eb2ec47b47e 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -27,6 +27,13 @@
 
 #define EXPECTED_PTYPE		4
 
+enum {
+	INT33FE_NODE_FUSB302,
+	INT33FE_NODE_MAX17047,
+	INT33FE_NODE_PI3USB30532,
+	INT33FE_NODE_MAX,
+};
+
 struct cht_int33fe_data {
 	struct i2c_client *max17047;
 	struct i2c_client *fusb302;
@@ -72,8 +79,13 @@ static const struct property_entry max17047_props[] = {
 
 static const struct property_entry fusb302_props[] = {
 	PROPERTY_ENTRY_STRING("linux,extcon-name", "cht_wcove_pwrsrc"),
-	PROPERTY_ENTRY_U32("fcs,max-sink-microvolt", 12000000),
-	PROPERTY_ENTRY_U32("fcs,max-sink-microamp",   3000000),
+	{ }
+};
+
+static const struct software_node nodes[] = {
+	{ "fusb302", NULL, fusb302_props },
+	{ "max17047", NULL, max17047_props },
+	{ "pi3usb30532" },
 	{ }
 };
 
@@ -82,14 +94,18 @@ cht_int33fe_register_max17047(struct device *dev, struct cht_int33fe_data *data)
 {
 	struct i2c_client *max17047 = NULL;
 	struct i2c_board_info board_info;
+	struct fwnode_handle *fwnode;
 	int ret;
 
+	fwnode = software_node_fwnode(&nodes[INT33FE_NODE_MAX17047]);
+	if (!fwnode)
+		return -ENODEV;
+
 	i2c_for_each_dev(&max17047, cht_int33fe_check_for_max17047);
 	if (max17047) {
 		/* Pre-existing i2c-client for the max17047, add device-props */
-		ret = device_add_properties(&max17047->dev, max17047_props);
-		if (ret)
-			return ret;
+		fwnode->secondary = ERR_PTR(-ENODEV);
+		max17047->dev.fwnode->secondary = fwnode;
 		/* And re-probe to get the new device-props applied. */
 		ret = device_reprobe(&max17047->dev);
 		if (ret)
@@ -100,7 +116,7 @@ cht_int33fe_register_max17047(struct device *dev, struct cht_int33fe_data *data)
 	memset(&board_info, 0, sizeof(board_info));
 	strlcpy(board_info.type, "max17047", I2C_NAME_SIZE);
 	board_info.dev_name = "max17047";
-	board_info.properties = max17047_props;
+	board_info.fwnode = fwnode;
 	data->max17047 = i2c_acpi_new_device(dev, 1, &board_info);
 
 	return PTR_ERR_OR_ZERO(data->max17047);
@@ -111,6 +127,7 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct i2c_board_info board_info;
 	struct cht_int33fe_data *data;
+	struct fwnode_handle *fwnode;
 	struct regulator *regulator;
 	unsigned long long ptyp;
 	acpi_status status;
@@ -170,10 +187,14 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	ret = software_node_register_nodes(nodes);
+	if (ret)
+		return ret;
+
 	/* Work around BIOS bug, see comment on cht_int33fe_check_for_max17047 */
 	ret = cht_int33fe_register_max17047(dev, data);
 	if (ret)
-		return ret;
+		goto out_remove_nodes;
 
 	data->connections[0].endpoint[0] = "port0";
 	data->connections[0].endpoint[1] = "i2c-pi3usb30532-switch";
@@ -187,10 +208,16 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 
 	device_connections_add(data->connections);
 
+	fwnode = software_node_fwnode(&nodes[INT33FE_NODE_FUSB302]);
+	if (!fwnode) {
+		ret = -ENODEV;
+		goto out_unregister_max17047;
+	}
+
 	memset(&board_info, 0, sizeof(board_info));
 	strlcpy(board_info.type, "typec_fusb302", I2C_NAME_SIZE);
 	board_info.dev_name = "fusb302";
-	board_info.properties = fusb302_props;
+	board_info.fwnode = fwnode;
 	board_info.irq = fusb302_irq;
 
 	data->fusb302 = i2c_acpi_new_device(dev, 2, &board_info);
@@ -199,8 +226,15 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 		goto out_unregister_max17047;
 	}
 
+	fwnode = software_node_fwnode(&nodes[INT33FE_NODE_PI3USB30532]);
+	if (!fwnode) {
+		ret = -ENODEV;
+		goto out_unregister_fusb302;
+	}
+
 	memset(&board_info, 0, sizeof(board_info));
 	board_info.dev_name = "pi3usb30532";
+	board_info.fwnode = fwnode;
 	strlcpy(board_info.type, "pi3usb30532", I2C_NAME_SIZE);
 
 	data->pi3usb30532 = i2c_acpi_new_device(dev, 3, &board_info);
@@ -221,6 +255,9 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 
 	device_connections_remove(data->connections);
 
+out_remove_nodes:
+	software_node_unregister_nodes(nodes);
+
 	return ret;
 }
 
@@ -233,6 +270,7 @@ static int cht_int33fe_remove(struct platform_device *pdev)
 	i2c_unregister_device(data->max17047);
 
 	device_connections_remove(data->connections);
+	software_node_unregister_nodes(nodes);
 
 	return 0;
 }
-- 
2.20.1

