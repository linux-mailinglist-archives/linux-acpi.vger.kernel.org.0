Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD4B4E55B8
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Mar 2022 16:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245284AbiCWP5X (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Mar 2022 11:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245275AbiCWP5W (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2022 11:57:22 -0400
Received: from hillosipuli.retiisi.eu (hillosipuli.retiisi.eu [IPv6:2a01:4f9:c010:4572::81:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064F87A9A2;
        Wed, 23 Mar 2022 08:55:51 -0700 (PDT)
Received: from lanttu.localdomain (unknown [IPv6:fd35:1bc8:1a6:d3d5::c1:2])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 4362B634C91;
        Wed, 23 Mar 2022 17:49:47 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, devicetree@vger.kernel.org,
        "Rafael J.Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/4] device property: Convert device_{dma_supported,get_dma_attr} to fwnode
Date:   Wed, 23 Mar 2022 17:47:34 +0200
Message-Id: <20220323154737.169483-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220323154737.169483-1-sakari.ailus@linux.intel.com>
References: <20220323154737.169483-1-sakari.ailus@linux.intel.com>
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

Make the device_dma_supported and device_get_dma_attr functions to use the
fwnode ops, and move the implementation to ACPI and OF frameworks.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/property.c | 14 ++++++++++++++
 drivers/base/property.c | 25 ++++---------------------
 drivers/of/property.c   | 17 +++++++++++++++++
 include/linux/fwnode.h  |  3 +++
 4 files changed, 38 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index d0986bda2964..1541b318ba46 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1253,6 +1253,17 @@ static bool acpi_fwnode_device_is_available(const struct fwnode_handle *fwnode)
 	return acpi_device_is_present(to_acpi_device_node(fwnode));
 }
 
+static bool acpi_fwnode_device_dma_supported(const struct fwnode_handle *fwnode)
+{
+	return acpi_dma_supported(to_acpi_device_node(fwnode));
+}
+
+static enum dev_dma_attr
+acpi_fwnode_device_get_dma_attr(const struct fwnode_handle *fwnode)
+{
+	return acpi_get_dma_attr(to_acpi_device_node(fwnode));
+}
+
 static bool acpi_fwnode_property_present(const struct fwnode_handle *fwnode,
 					 const char *propname)
 {
@@ -1384,6 +1395,9 @@ acpi_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
 	const struct fwnode_operations ops = {				\
 		.device_is_available = acpi_fwnode_device_is_available, \
 		.device_get_match_data = acpi_fwnode_device_get_match_data, \
+		.device_dma_supported =				\
+			acpi_fwnode_device_dma_supported,		\
+		.device_get_dma_attr = acpi_fwnode_device_get_dma_attr,	\
 		.property_present = acpi_fwnode_property_present,	\
 		.property_read_int_array =				\
 			acpi_fwnode_property_read_int_array,		\
diff --git a/drivers/base/property.c b/drivers/base/property.c
index c0e94cce9c29..09686e2e903e 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -823,33 +823,16 @@ EXPORT_SYMBOL_GPL(device_get_child_node_count);
 
 bool device_dma_supported(struct device *dev)
 {
-	const struct fwnode_handle *fwnode = dev_fwnode(dev);
-
-	/* For DT, this is always supported.
-	 * For ACPI, this depends on CCA, which
-	 * is determined by the acpi_dma_supported().
-	 */
-	if (is_of_node(fwnode))
-		return true;
-
-	return acpi_dma_supported(to_acpi_device_node(fwnode));
+	return fwnode_call_bool_op(dev_fwnode(dev), device_dma_supported);
 }
 EXPORT_SYMBOL_GPL(device_dma_supported);
 
 enum dev_dma_attr device_get_dma_attr(struct device *dev)
 {
-	const struct fwnode_handle *fwnode = dev_fwnode(dev);
-	enum dev_dma_attr attr = DEV_DMA_NOT_SUPPORTED;
-
-	if (is_of_node(fwnode)) {
-		if (of_dma_is_coherent(to_of_node(fwnode)))
-			attr = DEV_DMA_COHERENT;
-		else
-			attr = DEV_DMA_NON_COHERENT;
-	} else
-		attr = acpi_get_dma_attr(to_acpi_device_node(fwnode));
+	if (!fwnode_has_op(dev_fwnode(dev), device_get_dma_attr))
+		return DEV_DMA_NOT_SUPPORTED;
 
-	return attr;
+	return fwnode_call_int_op(dev_fwnode(dev), device_get_dma_attr);
 }
 EXPORT_SYMBOL_GPL(device_get_dma_attr);
 
diff --git a/drivers/of/property.c b/drivers/of/property.c
index 8e90071de6ed..676899566f7c 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -22,6 +22,7 @@
 #define pr_fmt(fmt)	"OF: " fmt
 
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/of_irq.h>
@@ -872,6 +873,20 @@ static bool of_fwnode_device_is_available(const struct fwnode_handle *fwnode)
 	return of_device_is_available(to_of_node(fwnode));
 }
 
+static bool of_fwnode_device_dma_supported(const struct fwnode_handle *fwnode)
+{
+	return true;
+}
+
+static enum dev_dma_attr
+of_fwnode_device_get_dma_attr(const struct fwnode_handle *fwnode)
+{
+	if (of_dma_is_coherent(to_of_node(fwnode)))
+		return DEV_DMA_COHERENT;
+	else
+		return DEV_DMA_NON_COHERENT;
+}
+
 static bool of_fwnode_property_present(const struct fwnode_handle *fwnode,
 				       const char *propname)
 {
@@ -1472,6 +1487,8 @@ const struct fwnode_operations of_fwnode_ops = {
 	.put = of_fwnode_put,
 	.device_is_available = of_fwnode_device_is_available,
 	.device_get_match_data = of_fwnode_device_get_match_data,
+	.device_dma_supported = of_fwnode_device_dma_supported,
+	.device_get_dma_attr = of_fwnode_device_get_dma_attr,
 	.property_present = of_fwnode_property_present,
 	.property_read_int_array = of_fwnode_property_read_int_array,
 	.property_read_string_array = of_fwnode_property_read_string_array,
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 3a532ba66f6c..6f307f21fc65 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -113,6 +113,9 @@ struct fwnode_operations {
 	bool (*device_is_available)(const struct fwnode_handle *fwnode);
 	const void *(*device_get_match_data)(const struct fwnode_handle *fwnode,
 					     const struct device *dev);
+	bool (*device_dma_supported)(const struct fwnode_handle *fwnode);
+	enum dev_dma_attr
+	(*device_get_dma_attr)(const struct fwnode_handle *fwnode);
 	bool (*property_present)(const struct fwnode_handle *fwnode,
 				 const char *propname);
 	int (*property_read_int_array)(const struct fwnode_handle *fwnode,
-- 
2.30.2

