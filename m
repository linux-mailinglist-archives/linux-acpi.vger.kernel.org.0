Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 278A31A26EC
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Apr 2020 18:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbgDHQJ3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Apr 2020 12:09:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:65524 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729808AbgDHQJ2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 8 Apr 2020 12:09:28 -0400
IronPort-SDR: Y/M+8Z/Uo9qkAFzZ1rcnOe7heFb134axY0mNhp1LLYQxW/eFKiGyoWPVaEtZuAQSadiHOE2sHJ
 oeyxq0YiSoAg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 09:09:28 -0700
IronPort-SDR: nltXZ2v/UvJEwS2xkWed221ErHZ4oEWsaRhMLPuDaMG9mEvAYJtYINUzFO5ZZIMOMOKcChvVGx
 tIuTDYykhmFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,359,1580803200"; 
   d="scan'208";a="242397390"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 08 Apr 2020 09:09:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8B91A766; Wed,  8 Apr 2020 19:09:25 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/6] platform/x86: intel_cht_int33fe: Convert software node array to group
Date:   Wed,  8 Apr 2020 19:09:03 +0300
Message-Id: <20200408160905.12101-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408160905.12101-1-andriy.shevchenko@linux.intel.com>
References: <20200408160905.12101-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Code looks and be read cleaner when software nodes are defined individually.
Convert software node array to a group in order to achieve above.

While here, switch struct initializers to C99 standard.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../platform/x86/intel_cht_int33fe_typec.c    | 78 +++++++++++--------
 1 file changed, 44 insertions(+), 34 deletions(-)

diff --git a/drivers/platform/x86/intel_cht_int33fe_typec.c b/drivers/platform/x86/intel_cht_int33fe_typec.c
index 04138215956b..0f547d35c90d 100644
--- a/drivers/platform/x86/intel_cht_int33fe_typec.c
+++ b/drivers/platform/x86/intel_cht_int33fe_typec.c
@@ -21,21 +21,13 @@
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/usb/pd.h>
 
 #include "intel_cht_int33fe_common.h"
 
-enum {
-	INT33FE_NODE_FUSB302,
-	INT33FE_NODE_MAX17047,
-	INT33FE_NODE_PI3USB30532,
-	INT33FE_NODE_DISPLAYPORT,
-	INT33FE_NODE_USB_CONNECTOR,
-	INT33FE_NODE_MAX,
-};
-
 /*
  * Grrr I severly dislike buggy BIOS-es. At least one BIOS enumerates
  * the max17047 both through the INT33FE ACPI device (it is right there
@@ -66,11 +58,16 @@ static int cht_int33fe_check_for_max17047(struct device *dev, void *data)
 
 static const char * const max17047_suppliers[] = { "bq24190-charger" };
 
-static const struct property_entry max17047_props[] = {
+static const struct property_entry max17047_properties[] = {
 	PROPERTY_ENTRY_STRING_ARRAY("supplied-from", max17047_suppliers),
 	{ }
 };
 
+static const struct software_node max17047_node = {
+	.name = "max17047",
+	.properties = max17047_properties,
+};
+
 /*
  * We are not using inline property here because those are constant,
  * and we need to adjust this one at runtime to point to real
@@ -80,12 +77,17 @@ static struct software_node_ref_args fusb302_mux_refs[] = {
 	{ .node = NULL },
 };
 
-static const struct property_entry fusb302_props[] = {
+static const struct property_entry fusb302_properties[] = {
 	PROPERTY_ENTRY_STRING("linux,extcon-name", "cht_wcove_pwrsrc"),
 	PROPERTY_ENTRY_REF_ARRAY("usb-role-switch", fusb302_mux_refs),
 	{ }
 };
 
+static const struct software_node fusb302_node = {
+	.name = "fusb302",
+	.properties = fusb302_properties,
+};
+
 #define PDO_FIXED_FLAGS \
 	(PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP | PDO_FIXED_USB_COMM)
 
@@ -98,31 +100,40 @@ static const u32 snk_pdo[] = {
 	PDO_VAR(5000, 12000, 3000),
 };
 
-static const struct software_node nodes[];
+static const struct software_node pi3usb30532_node = {
+	.name = "pi3usb30532",
+};
+
+static const struct software_node displayport_node = {
+	.name = "displayport",
+};
 
-static const struct property_entry usb_connector_props[] = {
+static const struct property_entry usb_connector_properties[] = {
 	PROPERTY_ENTRY_STRING("data-role", "dual"),
 	PROPERTY_ENTRY_STRING("power-role", "dual"),
 	PROPERTY_ENTRY_STRING("try-power-role", "sink"),
 	PROPERTY_ENTRY_U32_ARRAY("source-pdos", src_pdo),
 	PROPERTY_ENTRY_U32_ARRAY("sink-pdos", snk_pdo),
 	PROPERTY_ENTRY_U32("op-sink-microwatt", 2500000),
-	PROPERTY_ENTRY_REF("orientation-switch",
-			   &nodes[INT33FE_NODE_PI3USB30532]),
-	PROPERTY_ENTRY_REF("mode-switch",
-			   &nodes[INT33FE_NODE_PI3USB30532]),
-	PROPERTY_ENTRY_REF("displayport",
-			   &nodes[INT33FE_NODE_DISPLAYPORT]),
+	PROPERTY_ENTRY_REF("orientation-switch", &pi3usb30532_node),
+	PROPERTY_ENTRY_REF("mode-switch", &pi3usb30532_node),
+	PROPERTY_ENTRY_REF("displayport", &displayport_node),
 	{ }
 };
 
-static const struct software_node nodes[] = {
-	{ "fusb302", NULL, fusb302_props },
-	{ "max17047", NULL, max17047_props },
-	{ "pi3usb30532" },
-	{ "displayport" },
-	{ "connector", &nodes[0], usb_connector_props },
-	{ }
+static const struct software_node usb_connector_node = {
+	.name = "connector",
+	.parent = &fusb302_node,
+	.properties = usb_connector_properties,
+};
+
+static const struct software_node *node_group[] = {
+	&fusb302_node,
+	&max17047_node,
+	&pi3usb30532_node,
+	&displayport_node,
+	&usb_connector_node,
+	NULL
 };
 
 static int cht_int33fe_setup_dp(struct cht_int33fe_data *data)
@@ -130,7 +141,7 @@ static int cht_int33fe_setup_dp(struct cht_int33fe_data *data)
 	struct fwnode_handle *fwnode;
 	struct pci_dev *pdev;
 
-	fwnode = software_node_fwnode(&nodes[INT33FE_NODE_DISPLAYPORT]);
+	fwnode = software_node_fwnode(&displayport_node);
 	if (!fwnode)
 		return -ENODEV;
 
@@ -155,11 +166,10 @@ static int cht_int33fe_setup_dp(struct cht_int33fe_data *data)
 
 static void cht_int33fe_remove_nodes(struct cht_int33fe_data *data)
 {
-	software_node_unregister_nodes(nodes);
+	software_node_unregister_node_group(node_group);
 
 	if (fusb302_mux_refs[0].node) {
-		fwnode_handle_put(
-			software_node_fwnode(fusb302_mux_refs[0].node));
+		fwnode_handle_put(software_node_fwnode(fusb302_mux_refs[0].node));
 		fusb302_mux_refs[0].node = NULL;
 	}
 
@@ -192,7 +202,7 @@ static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
 	 */
 	fusb302_mux_refs[0].node = mux_ref_node;
 
-	ret = software_node_register_nodes(nodes);
+	ret = software_node_register_node_group(node_group);
 	if (ret)
 		return ret;
 
@@ -222,7 +232,7 @@ cht_int33fe_register_max17047(struct device *dev, struct cht_int33fe_data *data)
 	struct fwnode_handle *fwnode;
 	int ret;
 
-	fwnode = software_node_fwnode(&nodes[INT33FE_NODE_MAX17047]);
+	fwnode = software_node_fwnode(&max17047_node);
 	if (!fwnode)
 		return -ENODEV;
 
@@ -294,7 +304,7 @@ int cht_int33fe_typec_probe(struct cht_int33fe_data *data)
 	if (ret)
 		goto out_remove_nodes;
 
-	fwnode = software_node_fwnode(&nodes[INT33FE_NODE_FUSB302]);
+	fwnode = software_node_fwnode(&fusb302_node);
 	if (!fwnode) {
 		ret = -ENODEV;
 		goto out_unregister_max17047;
@@ -312,7 +322,7 @@ int cht_int33fe_typec_probe(struct cht_int33fe_data *data)
 		goto out_unregister_max17047;
 	}
 
-	fwnode = software_node_fwnode(&nodes[INT33FE_NODE_PI3USB30532]);
+	fwnode = software_node_fwnode(&pi3usb30532_node);
 	if (!fwnode) {
 		ret = -ENODEV;
 		goto out_unregister_fusb302;
-- 
2.25.1

