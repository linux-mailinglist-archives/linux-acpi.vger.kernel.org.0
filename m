Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857EA4AAE90
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Feb 2022 10:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbiBFJ0Q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Feb 2022 04:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbiBFJ0P (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Feb 2022 04:26:15 -0500
X-Greylist: delayed 468 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 01:26:14 PST
Received: from hillosipuli.retiisi.eu (retiisi.eu [95.216.213.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F71C061A73;
        Sun,  6 Feb 2022 01:26:14 -0800 (PST)
Received: from lanttu.localdomain (unknown [IPv6:fd35:1bc8:1a6:d3d5::e1:3])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 15709634C96;
        Sun,  6 Feb 2022 11:18:27 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH 4/4] device property: Add irq_get to fwnode operation
Date:   Sun,  6 Feb 2022 11:16:43 +0200
Message-Id: <20220206091643.276833-5-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220206091643.276833-1-sakari.ailus@linux.intel.com>
References: <20220206091643.276833-1-sakari.ailus@linux.intel.com>
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
index 8beb89709740..8a736bac56b9 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1471,6 +1471,12 @@ static void __iomem *of_fwnode_iomap(struct fwnode_handle *fwnode, int index)
 		of_iomap(to_of_node(fwnode), index) : NULL;
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
@@ -1509,6 +1515,7 @@ const struct fwnode_operations of_fwnode_ops = {
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

