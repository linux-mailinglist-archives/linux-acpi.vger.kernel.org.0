Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5221730FF4
	for <lists+linux-acpi@lfdr.de>; Fri, 31 May 2019 16:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfEaOQe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 May 2019 10:16:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:8345 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfEaOQW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 May 2019 10:16:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 May 2019 07:16:21 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 31 May 2019 07:16:19 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 14/16] platform/x86: intel_cht_int33fe: Provide fwnode for the USB connector
Date:   Fri, 31 May 2019 17:15:45 +0300
Message-Id: <20190531141547.22728-15-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190531141547.22728-1-heikki.krogerus@linux.intel.com>
References: <20190531141547.22728-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In ACPI, and now also in DT, the USB connectors usually have
their own device nodes. In case of USB Type-C, those
connector (port) nodes are child nodes of the controller or
PHY device, in our case the fusb302. The software fwnodes
allow us to create a similar child node for fusb302 that
represents the connector also on Intel CHT.

This makes it possible replace the fusb302 specific device
properties which were deprecated with the common USB
connector properties that tcpm.c is able to use directly.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel_cht_int33fe.c | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index 9eb2ec47b47e..dcfe47baff72 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/usb/pd.h>
 
 #define EXPECTED_PTYPE		4
 
@@ -31,6 +32,7 @@ enum {
 	INT33FE_NODE_FUSB302,
 	INT33FE_NODE_MAX17047,
 	INT33FE_NODE_PI3USB30532,
+	INT33FE_NODE_USB_CONNECTOR,
 	INT33FE_NODE_MAX,
 };
 
@@ -82,10 +84,33 @@ static const struct property_entry fusb302_props[] = {
 	{ }
 };
 
+#define PDO_FIXED_FLAGS \
+	(PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP | PDO_FIXED_USB_COMM)
+
+static const u32 src_pdo[] = {
+	PDO_FIXED(5000, 1500, PDO_FIXED_FLAGS),
+};
+
+static const u32 snk_pdo[] = {
+	PDO_FIXED(5000, 400, PDO_FIXED_FLAGS),
+	PDO_VAR(5000, 12000, 3000),
+};
+
+static const struct property_entry usb_connector_props[] = {
+	PROPERTY_ENTRY_STRING("data-role", "dual"),
+	PROPERTY_ENTRY_STRING("power-role", "dual"),
+	PROPERTY_ENTRY_STRING("try-power-role", "sink"),
+	PROPERTY_ENTRY_U32_ARRAY("source-pdos", src_pdo),
+	PROPERTY_ENTRY_U32_ARRAY("sink-pdos", snk_pdo),
+	PROPERTY_ENTRY_U32("op-sink-microwatt", 2500000),
+	{ }
+};
+
 static const struct software_node nodes[] = {
 	{ "fusb302", NULL, fusb302_props },
 	{ "max17047", NULL, max17047_props },
 	{ "pi3usb30532" },
+	{ "connector", &nodes[0], usb_connector_props },
 	{ }
 };
 
-- 
2.20.1

