Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D75530FF2
	for <lists+linux-acpi@lfdr.de>; Fri, 31 May 2019 16:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfEaOQ3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 May 2019 10:16:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:8345 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbfEaOQ0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 May 2019 10:16:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 May 2019 07:16:26 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 31 May 2019 07:16:24 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 16/16] platform/x86: intel_cht_int33fe: Replacing the old connections with references
Date:   Fri, 31 May 2019 17:15:47 +0300
Message-Id: <20190531141547.22728-17-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190531141547.22728-1-heikki.krogerus@linux.intel.com>
References: <20190531141547.22728-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Replacing the old connection descriptions with software node
references. Supplying the USB connector also a reference to
the DisplayPort while at it.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel_cht_int33fe.c | 47 ++++++++++++++----------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index 9e1848e0343d..4fbdff48a4b5 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -43,13 +43,35 @@ struct cht_int33fe_data {
 	struct i2c_client *max17047;
 	struct i2c_client *fusb302;
 	struct i2c_client *pi3usb30532;
-	/* Contain a list-head must be per device */
-	struct device_connection connections[4];
 
 	struct fwnode_handle *dp;
 	struct fwnode_handle *mux;
 };
 
+static const struct software_node nodes[];
+
+static const struct software_node_ref_args pi3usb30532_ref = {
+	&nodes[INT33FE_NODE_PI3USB30532]
+};
+
+static const struct software_node_ref_args dp_ref = {
+	&nodes[INT33FE_NODE_DISPLAYPORT]
+};
+
+static struct software_node_ref_args mux_ref;
+
+static const struct software_node_reference usb_connector_refs[] = {
+	{ "orientation-switch", 1, &pi3usb30532_ref},
+	{ "mode-switch", 1, &pi3usb30532_ref},
+	{ "displayport", 1, &dp_ref},
+	{ }
+};
+
+static const struct software_node_reference fusb302_refs[] = {
+	{ "usb-role-switch", 1, &mux_ref},
+	{ }
+};
+
 /*
  * Grrr I severly dislike buggy BIOS-es. At least one BIOS enumerates
  * the max17047 both through the INT33FE ACPI device (it is right there
@@ -113,12 +135,12 @@ static const struct property_entry usb_connector_props[] = {
 };
 
 static const struct software_node nodes[] = {
-	{ "fusb302", NULL, fusb302_props },
+	{ "fusb302", NULL, fusb302_props, fusb302_refs },
 	{ "max17047", NULL, max17047_props },
 	{ "pi3usb30532" },
 	{ "displayport" },
 	{ "usb-role-switch" },
-	{ "connector", &nodes[0], usb_connector_props },
+	{ "connector", &nodes[0], usb_connector_props, usb_connector_refs },
 	{ }
 };
 
@@ -152,6 +174,7 @@ static int cht_int33fe_setup_mux(struct cht_int33fe_data *data)
 
 	data->mux = fwnode_handle_get(dev->fwnode);
 	put_device(dev);
+	mux_ref.node = to_software_node(data->mux);
 
 	return 0;
 }
@@ -190,6 +213,7 @@ static void cht_int33fe_remove_nodes(struct cht_int33fe_data *data)
 
 	if (data->mux) {
 		fwnode_handle_put(data->mux);
+		mux_ref.node = NULL;
 		data->mux = NULL;
 	}
 
@@ -343,18 +367,6 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_remove_nodes;
 
-	data->connections[0].endpoint[0] = "port0";
-	data->connections[0].endpoint[1] = "i2c-pi3usb30532-switch";
-	data->connections[0].id = "orientation-switch";
-	data->connections[1].endpoint[0] = "port0";
-	data->connections[1].endpoint[1] = "i2c-pi3usb30532-mux";
-	data->connections[1].id = "mode-switch";
-	data->connections[2].endpoint[0] = "i2c-fusb302";
-	data->connections[2].endpoint[1] = "intel_xhci_usb_sw-role-switch";
-	data->connections[2].id = "usb-role-switch";
-
-	device_connections_add(data->connections);
-
 	fwnode = software_node_fwnode(&nodes[INT33FE_NODE_FUSB302]);
 	if (!fwnode) {
 		ret = -ENODEV;
@@ -400,8 +412,6 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 out_unregister_max17047:
 	i2c_unregister_device(data->max17047);
 
-	device_connections_remove(data->connections);
-
 out_remove_nodes:
 	cht_int33fe_remove_nodes(data);
 
@@ -416,7 +426,6 @@ static int cht_int33fe_remove(struct platform_device *pdev)
 	i2c_unregister_device(data->fusb302);
 	i2c_unregister_device(data->max17047);
 
-	device_connections_remove(data->connections);
 	cht_int33fe_remove_nodes(data);
 
 	return 0;
-- 
2.20.1

