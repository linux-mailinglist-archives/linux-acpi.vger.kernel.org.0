Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1D54EDA03
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Mar 2022 14:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbiCaM7I (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 31 Mar 2022 08:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236444AbiCaM67 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Mar 2022 08:58:59 -0400
Received: from hillosipuli.retiisi.eu (retiisi.eu [95.216.213.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBB6214043;
        Thu, 31 Mar 2022 05:57:11 -0700 (PDT)
Received: from lanttu.localdomain (unknown [IPv6:fd35:1bc8:1a6:d3d5::c1:2])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 39B93634C95;
        Thu, 31 Mar 2022 15:57:05 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, devicetree@vger.kernel.org,
        "Rafael J.Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v3 3/4] device property: Add iomap to fwnode operations
Date:   Thu, 31 Mar 2022 15:54:49 +0300
Message-Id: <20220331125450.218045-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220331125450.218045-1-sakari.ailus@linux.intel.com>
References: <20220331125450.218045-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add iomap() fwnode operation to implement fwnode_iomap() through fwnode
operations, moving the code in fwnode_iomap() to OF framework.

Note that the IS_ENABLED(CONFIG_OF_ADDRESS) && is_of_node(fwnode) check is
needed for Sparc that has its own implementation of of_iomap anyway. Let
the pre-compiler to handle that check.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c |  5 +----
 drivers/of/property.c   | 10 ++++++++++
 include/linux/fwnode.h  |  1 +
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 09686e2e903e..83dd22e7cb81 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -887,10 +887,7 @@ EXPORT_SYMBOL_GPL(device_get_phy_mode);
  */
 void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index)
 {
-	if (IS_ENABLED(CONFIG_OF_ADDRESS) && is_of_node(fwnode))
-		return of_iomap(to_of_node(fwnode), index);
-
-	return NULL;
+	return fwnode_call_ptr_op(fwnode, iomap, index);
 }
 EXPORT_SYMBOL(fwnode_iomap);
 
diff --git a/drivers/of/property.c b/drivers/of/property.c
index 676899566f7c..ac2aa5221069 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1465,6 +1465,15 @@ static int of_link_property(struct device_node *con_np, const char *prop_name)
 	return 0;
 }
 
+static void __iomem *of_fwnode_iomap(struct fwnode_handle *fwnode, int index)
+{
+#ifdef CONFIG_OF_ADDRESS
+	return of_iomap(to_of_node(fwnode), index);
+#else
+	return NULL;
+#endif
+}
+
 static int of_fwnode_add_links(struct fwnode_handle *fwnode)
 {
 	struct property *p;
@@ -1502,6 +1511,7 @@ const struct fwnode_operations of_fwnode_ops = {
 	.graph_get_remote_endpoint = of_fwnode_graph_get_remote_endpoint,
 	.graph_get_port_parent = of_fwnode_graph_get_port_parent,
 	.graph_parse_endpoint = of_fwnode_graph_parse_endpoint,
+	.iomap = of_fwnode_iomap,
 	.add_links = of_fwnode_add_links,
 };
 EXPORT_SYMBOL_GPL(of_fwnode_ops);
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 6f307f21fc65..ebbc3bf03f95 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -148,6 +148,7 @@ struct fwnode_operations {
 	(*graph_get_port_parent)(struct fwnode_handle *fwnode);
 	int (*graph_parse_endpoint)(const struct fwnode_handle *fwnode,
 				    struct fwnode_endpoint *endpoint);
+	void __iomem *(*iomap)(struct fwnode_handle *fwnode, int index);
 	int (*add_links)(struct fwnode_handle *fwnode);
 };
 
-- 
2.30.2

