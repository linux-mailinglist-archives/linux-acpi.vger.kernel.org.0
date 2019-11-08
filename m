Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45090F3CB8
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2019 01:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfKHASP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Nov 2019 19:18:15 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44680 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfKHASO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Nov 2019 19:18:14 -0500
Received: by mail-pg1-f193.google.com with SMTP id f19so2956822pgk.11;
        Thu, 07 Nov 2019 16:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9yY1ilCQrcIHxsUtMS2U9uQS4obcy3+hHr81/tVLigE=;
        b=pwTIz0sSlxjLXzC0Ixjx71rddWcGX1a5UNxzxh9KTLmo2ucoPoGpYhtjokwW44m2y2
         Lp5UnPrZLv+CqeTOKnJgE4H8mlF++ziBgTlkKVQGzl5+HSu8xet75fKPm30kfwH9kgaf
         wuRLujthYazXZKvwdoFAuVa3ZmewaNNR7ZBlHavwkU4+bvWieXvNtF+TshABQk35CeVQ
         aQWSMv21Udg9BJljvQuHUGW2kt9gZ4UR0q8xFpNxCLrTvKOJpODJCryOpzZDvWzxx+tH
         tlvVJ0ZNWrnNJL9TU3dfAgiN2C6P/zBqrmZBRtQa5ClUL83y0q2VQ4F5plKMn1eyTX5F
         lqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9yY1ilCQrcIHxsUtMS2U9uQS4obcy3+hHr81/tVLigE=;
        b=ZFLf4uFnZ2tXehelNQsedCHadoWbmy/iffGLq1l7Z+oiaWuPUGhqUSFszVY5Fzqept
         /3WK18anzwetATASzeOMTfF74DsjHe/8BZegrFPtfQ72znyljSVFxa4y05rgwzep1mV1
         DqIVvEqWqQ32rCeFwVc3oHCvTiLFpLOhWBFPNWblpUGVExrtJ6o0o973XeVMmwGUOGli
         eh2Q54IGIZtQM7CN4oT3KSUyGekAFPvnS2dFo1LAm8SDha87JQnwz1h8TBsLBO2t6ZAE
         jbT0PmnyX0G3hK5kgIRi1GUHvI9v8kPwZDlXNjdHELpUFVbW48fNMl7eEmJdPswZ8pWk
         NtUw==
X-Gm-Message-State: APjAAAUBz/fDVSeC8M2YKpKAzjmVtf3SoViQkZw+ORKYn0yVGWW6U1kO
        isMRojkhA2cWBXXgLk+68zCAv8qc
X-Google-Smtp-Source: APXvYqzD0l770YLN/Ptb+lifoS5B9LJmcBFdDZqtWIstMD5frdY7eMMaGQjELWyxCVeEcdBn+/LZbg==
X-Received: by 2002:a63:cb4f:: with SMTP id m15mr8374706pgi.325.1573172293007;
        Thu, 07 Nov 2019 16:18:13 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id m68sm3688764pfb.122.2019.11.07.16.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 16:18:11 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v7 4/6] platform/x86: intel_cht_int33fe: use inline reference properties
Date:   Thu,  7 Nov 2019 16:18:01 -0800
Message-Id: <20191108001803.191541-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191108001803.191541-1-dmitry.torokhov@gmail.com>
References: <20191108001803.191541-1-dmitry.torokhov@gmail.com>
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

