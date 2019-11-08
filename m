Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB3EF3EDE
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2019 05:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbfKHEWx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Nov 2019 23:22:53 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42506 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbfKHEWe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Nov 2019 23:22:34 -0500
Received: by mail-pl1-f196.google.com with SMTP id j12so3162820plt.9;
        Thu, 07 Nov 2019 20:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9yY1ilCQrcIHxsUtMS2U9uQS4obcy3+hHr81/tVLigE=;
        b=OW0h2Sc8T1/OqZl9vKn6J0rG0llI6pSnjYdfDfXVjDkdvoHCjRRUHuwYhAenlYzw6Q
         H0trYBnjxOdbnfsTFr5u8Vema3YMZOQQd3gDU3eKCL7bVhdvMrmFtKP4IGTuRRTUFkNP
         GXydufAafgDZX0GAbHBdWGehOWrS8e8GtWxZHg11eGybw+ZHZ7NvKz1VcWRIbmzQZ5En
         4J8Khdq5mF2eJgb+KoLdoVMPzculeT5R/cb2lP89WTZoWkf+p3aBj5laVnX+X+Wx5h+Q
         u4j26D9vAJwlZWgVNnzuEvM/oKd3x2AN+IFjxSSOhlitKeT7rV1l6h2CWQY91SSoeOGA
         SUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9yY1ilCQrcIHxsUtMS2U9uQS4obcy3+hHr81/tVLigE=;
        b=KY6k+67TwyrvTVDqxsj4GtdUxUASomKO5stdY+b7v1Q5gjE6aLUdMHXMt8bnhfGxj7
         6tKxqlLdVWo2r1KBPmSdgn8I7vzmCNJOMhYfudrAssSbgQa1JYYUsqBPjzu8voYPIS3L
         I9fmAD03LGhsWjyt05zKwuJ1QBnAj17i04hJjwJVTkDSQtfrMjP0sJsuX5pOGcppm5FG
         aemWdJ77ijVbuljiwVCJuj+QTIXkmMs/7hZpCprInVK/af9XacaYkvGaYQaH8wV6tS/h
         uLebVl2+maINWy5nGIYXG6AUJ/qB33EaTWtUtMhMzNaScl+ILuPoDAhkL4vCH6MBXS2M
         Zo6Q==
X-Gm-Message-State: APjAAAVu4mYFYhiDJis+Ig0mwhCFKvKyLM1Oaq3hsH1S+m1cwEzud0oa
        Z3KkmkiN1hnOLpfLSgVRqzk=
X-Google-Smtp-Source: APXvYqzOOjtZ+nD42gEULjb2GrTQoJ919yybAAMjf126D4hIXJ+rN1QkdHsPReFQ8HBmkUiGe8aXmw==
X-Received: by 2002:a17:90a:22a6:: with SMTP id s35mr10169084pjc.3.1573186953675;
        Thu, 07 Nov 2019 20:22:33 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 71sm5004106pfx.107.2019.11.07.20.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 20:22:33 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v8 4/6] platform/x86: intel_cht_int33fe: use inline reference properties
Date:   Thu,  7 Nov 2019 20:22:23 -0800
Message-Id: <20191108042225.45391-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191108042225.45391-1-dmitry.torokhov@gmail.com>
References: <20191108042225.45391-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Now that static device properties allow defining reference properties
together with all other types of properties, instead of managing them
separately, let's adjust the driver.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../platform/x86/intel_cht_int33fe_typec.c    | 81 ++++++++++---------
 1 file changed, 41 insertions(+), 40 deletions(-)

diff --git a/drivers/platform/x86/intel_cht_int33fe_typec.c b/drivers/platform/x86/intel_cht_int33fe_typec.c
index 2d097fc2dd465..04138215956bf 100644
--- a/drivers/platform/x86/intel_cht_int33fe_typec.c
+++ b/drivers/platform/x86/intel_cht_int33fe_typec.c
@@ -36,30 +36,6 @@ enum {
 	INT33FE_NODE_MAX,
 };
 
-static const struct software_node nodes[];
-
-static const struct software_node_ref_args pi3usb30532_ref = {
-	&nodes[INT33FE_NODE_PI3USB30532]
-};
-
-static const struct software_node_ref_args dp_ref = {
-	&nodes[INT33FE_NODE_DISPLAYPORT]
-};
-
-static struct software_node_ref_args mux_ref;
-
-static const struct software_node_reference usb_connector_refs[] = {
-	{ "orientation-switch", 1, &pi3usb30532_ref},
-	{ "mode-switch", 1, &pi3usb30532_ref},
-	{ "displayport", 1, &dp_ref},
-	{ }
-};
-
-static const struct software_node_reference fusb302_refs[] = {
-	{ "usb-role-switch", 1, &mux_ref},
-	{ }
-};
-
 /*
  * Grrr I severly dislike buggy BIOS-es. At least one BIOS enumerates
  * the max17047 both through the INT33FE ACPI device (it is right there
@@ -95,8 +71,18 @@ static const struct property_entry max17047_props[] = {
 	{ }
 };
 
+/*
+ * We are not using inline property here because those are constant,
+ * and we need to adjust this one at runtime to point to real
+ * software node.
+ */
+static struct software_node_ref_args fusb302_mux_refs[] = {
+	{ .node = NULL },
+};
+
 static const struct property_entry fusb302_props[] = {
 	PROPERTY_ENTRY_STRING("linux,extcon-name", "cht_wcove_pwrsrc"),
+	PROPERTY_ENTRY_REF_ARRAY("usb-role-switch", fusb302_mux_refs),
 	{ }
 };
 
@@ -112,6 +98,8 @@ static const u32 snk_pdo[] = {
 	PDO_VAR(5000, 12000, 3000),
 };
 
+static const struct software_node nodes[];
+
 static const struct property_entry usb_connector_props[] = {
 	PROPERTY_ENTRY_STRING("data-role", "dual"),
 	PROPERTY_ENTRY_STRING("power-role", "dual"),
@@ -119,15 +107,21 @@ static const struct property_entry usb_connector_props[] = {
 	PROPERTY_ENTRY_U32_ARRAY("source-pdos", src_pdo),
 	PROPERTY_ENTRY_U32_ARRAY("sink-pdos", snk_pdo),
 	PROPERTY_ENTRY_U32("op-sink-microwatt", 2500000),
+	PROPERTY_ENTRY_REF("orientation-switch",
+			   &nodes[INT33FE_NODE_PI3USB30532]),
+	PROPERTY_ENTRY_REF("mode-switch",
+			   &nodes[INT33FE_NODE_PI3USB30532]),
+	PROPERTY_ENTRY_REF("displayport",
+			   &nodes[INT33FE_NODE_DISPLAYPORT]),
 	{ }
 };
 
 static const struct software_node nodes[] = {
-	{ "fusb302", NULL, fusb302_props, fusb302_refs },
+	{ "fusb302", NULL, fusb302_props },
 	{ "max17047", NULL, max17047_props },
 	{ "pi3usb30532" },
 	{ "displayport" },
-	{ "connector", &nodes[0], usb_connector_props, usb_connector_refs },
+	{ "connector", &nodes[0], usb_connector_props },
 	{ }
 };
 
@@ -163,9 +157,10 @@ static void cht_int33fe_remove_nodes(struct cht_int33fe_data *data)
 {
 	software_node_unregister_nodes(nodes);
 
-	if (mux_ref.node) {
-		fwnode_handle_put(software_node_fwnode(mux_ref.node));
-		mux_ref.node = NULL;
+	if (fusb302_mux_refs[0].node) {
+		fwnode_handle_put(
+			software_node_fwnode(fusb302_mux_refs[0].node));
+		fusb302_mux_refs[0].node = NULL;
 	}
 
 	if (data->dp) {
@@ -177,25 +172,31 @@ static void cht_int33fe_remove_nodes(struct cht_int33fe_data *data)
 
 static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
 {
+	const struct software_node *mux_ref_node;
 	int ret;
 
-	ret = software_node_register_nodes(nodes);
-	if (ret)
-		return ret;
-
-	/* The devices that are not created in this driver need extra steps. */
-
 	/*
 	 * There is no ACPI device node for the USB role mux, so we need to wait
 	 * until the mux driver has created software node for the mux device.
 	 * It means we depend on the mux driver. This function will return
 	 * -EPROBE_DEFER until the mux device is registered.
 	 */
-	mux_ref.node = software_node_find_by_name(NULL, "intel-xhci-usb-sw");
-	if (!mux_ref.node) {
-		ret = -EPROBE_DEFER;
-		goto err_remove_nodes;
-	}
+	mux_ref_node = software_node_find_by_name(NULL, "intel-xhci-usb-sw");
+	if (!mux_ref_node)
+		return -EPROBE_DEFER;
+
+	/*
+	 * Update node used in "usb-role-switch" property. Note that we
+	 * rely on software_node_register_nodes() to use the original
+	 * instance of properties instead of copying them.
+	 */
+	fusb302_mux_refs[0].node = mux_ref_node;
+
+	ret = software_node_register_nodes(nodes);
+	if (ret)
+		return ret;
+
+	/* The devices that are not created in this driver need extra steps. */
 
 	/*
 	 * The DP connector does have ACPI device node. In this case we can just
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

