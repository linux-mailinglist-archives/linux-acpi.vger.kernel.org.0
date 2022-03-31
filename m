Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B624ED9FE
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Mar 2022 14:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbiCaM7A (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 31 Mar 2022 08:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236426AbiCaM67 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Mar 2022 08:58:59 -0400
Received: from hillosipuli.retiisi.eu (hillosipuli.retiisi.eu [IPv6:2a01:4f9:c010:4572::81:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99CA213517;
        Thu, 31 Mar 2022 05:57:09 -0700 (PDT)
Received: from lanttu.localdomain (unknown [IPv6:fd35:1bc8:1a6:d3d5::c1:2])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 4C828634C96;
        Thu, 31 Mar 2022 15:57:05 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, devicetree@vger.kernel.org,
        "Rafael J.Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 4/4] device property: Add irq_get to fwnode operation
Date:   Thu, 31 Mar 2022 15:54:50 +0300
Message-Id: <20220331125450.218045-5-sakari.ailus@linux.intel.com>
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

Add irq_get() fwnode operation to implement fwnode_irq_get() through
fwnode operations, moving the code in fwnode_irq_get() to OF and ACPI
frameworks.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/property.c | 14 ++++++++++++++
 drivers/base/property.c | 12 +-----------
 drivers/of/property.c   |  7 +++++++
 include/linux/fwnode.h  |  1 +
 4 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 75dc22c117a5..1ad5f097c33a 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1391,6 +1391,19 @@ static int acpi_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 	return 0;
 }
 
+static int acpi_fwnode_irq_get(const struct fwnode_handle *fwnode,
+			       unsigned int index)
+{
+	struct resource res;
+	int ret;
+
+	ret = acpi_irq_get(ACPI_HANDLE_FWNODE(fwnode), index, &res);
+	if (ret)
+		return ret;
+
+	return res.start;
+}
+
 #define DECLARE_ACPI_FWNODE_OPS(ops) \
 	const struct fwnode_operations ops = {				\
 		.device_is_available = acpi_fwnode_device_is_available, \
@@ -1415,6 +1428,7 @@ static int acpi_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 			acpi_graph_get_remote_endpoint,			\
 		.graph_get_port_parent = acpi_fwnode_get_parent,	\
 		.graph_parse_endpoint = acpi_fwnode_graph_parse_endpoint, \
+		.irq_get = acpi_fwnode_irq_get,				\
 	};								\
 	EXPORT_SYMBOL_GPL(ops)
 
diff --git a/drivers/base/property.c b/drivers/base/property.c
index 83dd22e7cb81..3560c4419d11 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -901,17 +901,7 @@ EXPORT_SYMBOL(fwnode_iomap);
  */
 int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
 {
-	struct resource res;
-	int ret;
-
-	if (is_of_node(fwnode))
-		return of_irq_get(to_of_node(fwnode), index);
-
-	ret = acpi_irq_get(ACPI_HANDLE_FWNODE(fwnode), index, &res);
-	if (ret)
-		return ret;
-
-	return res.start;
+	return fwnode_call_int_op(fwnode, irq_get, index);
 }
 EXPORT_SYMBOL(fwnode_irq_get);
 
diff --git a/drivers/of/property.c b/drivers/of/property.c
index ac2aa5221069..9a50ad25906e 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1474,6 +1474,12 @@ static void __iomem *of_fwnode_iomap(struct fwnode_handle *fwnode, int index)
 #endif
 }
 
+static int of_fwnode_irq_get(const struct fwnode_handle *fwnode,
+			     unsigned int index)
+{
+	return of_irq_get(to_of_node(fwnode), index);
+}
+
 static int of_fwnode_add_links(struct fwnode_handle *fwnode)
 {
 	struct property *p;
@@ -1512,6 +1518,7 @@ const struct fwnode_operations of_fwnode_ops = {
 	.graph_get_port_parent = of_fwnode_graph_get_port_parent,
 	.graph_parse_endpoint = of_fwnode_graph_parse_endpoint,
 	.iomap = of_fwnode_iomap,
+	.irq_get = of_fwnode_irq_get,
 	.add_links = of_fwnode_add_links,
 };
 EXPORT_SYMBOL_GPL(of_fwnode_ops);
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index ebbc3bf03f95..6ab69871b06d 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -149,6 +149,7 @@ struct fwnode_operations {
 	int (*graph_parse_endpoint)(const struct fwnode_handle *fwnode,
 				    struct fwnode_endpoint *endpoint);
 	void __iomem *(*iomap)(struct fwnode_handle *fwnode, int index);
+	int (*irq_get)(const struct fwnode_handle *fwnode, unsigned int index);
 	int (*add_links)(struct fwnode_handle *fwnode);
 };
 
-- 
2.30.2

