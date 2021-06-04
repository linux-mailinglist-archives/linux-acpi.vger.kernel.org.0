Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE6639B99D
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jun 2021 15:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFDNPK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Jun 2021 09:15:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:52389 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230004AbhFDNPK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Jun 2021 09:15:10 -0400
IronPort-SDR: BqdvV0+yZUi33XLe703ecvWl2zG5apmoQZjednwpiyzbE7lXaQC8Qpao4v9gG+OwMST4+Ehqo3
 1fszYInUzVAQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="184656232"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="184656232"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 06:13:24 -0700
IronPort-SDR: oFJ54YqmlG+hMBYyZwiLZoq3y5PlTYCUIYJpJNKGBkITsZitSml+fC58+jWsDdxwiBXSkffWgi
 8mtOzVTu9ujQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="439191754"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 04 Jun 2021 06:13:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F01B81FC; Fri,  4 Jun 2021 16:13:45 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH v1 1/1] device property: Unify access to of_node
Date:   Fri,  4 Jun 2021 16:13:43 +0300
Message-Id: <20210604131343.62016-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Historically we have a few variants how we access dev->fwnode
and dev->of_node. Some of the functions during development
gained different versions of the getters. Unify access to of_node
and as a side change slightly refactor ACPI specific branches.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c  | 29 +++++++++++++----------------
 include/linux/property.h |  2 +-
 2 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index c26370aacdc6..d0874f6c29bb 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -759,13 +759,8 @@ EXPORT_SYMBOL_GPL(fwnode_get_next_available_child_node);
 struct fwnode_handle *device_get_next_child_node(struct device *dev,
 						 struct fwnode_handle *child)
 {
-	struct acpi_device *adev = ACPI_COMPANION(dev);
-	struct fwnode_handle *fwnode = NULL, *next;
-
-	if (dev->of_node)
-		fwnode = of_fwnode_handle(dev->of_node);
-	else if (adev)
-		fwnode = acpi_fwnode_handle(adev);
+	const struct fwnode_handle *fwnode = dev_fwnode(dev);
+	struct fwnode_handle *next;
 
 	/* Try to find a child in primary fwnode */
 	next = fwnode_get_next_child_node(fwnode, child);
@@ -868,28 +863,31 @@ EXPORT_SYMBOL_GPL(device_get_child_node_count);
 
 bool device_dma_supported(struct device *dev)
 {
+	const struct fwnode_handle *fwnode = dev_fwnode(dev);
+
 	/* For DT, this is always supported.
 	 * For ACPI, this depends on CCA, which
 	 * is determined by the acpi_dma_supported().
 	 */
-	if (IS_ENABLED(CONFIG_OF) && dev->of_node)
+	if (is_of_node(fwnode))
 		return true;
 
-	return acpi_dma_supported(ACPI_COMPANION(dev));
+	return acpi_dma_supported(to_acpi_device_node(fwnode));
 }
 EXPORT_SYMBOL_GPL(device_dma_supported);
 
 enum dev_dma_attr device_get_dma_attr(struct device *dev)
 {
+	const struct fwnode_handle *fwnode = dev_fwnode(dev);
 	enum dev_dma_attr attr = DEV_DMA_NOT_SUPPORTED;
 
-	if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
-		if (of_dma_is_coherent(dev->of_node))
+	if (is_of_node(fwnode)) {
+		if (of_dma_is_coherent(to_of_node(fwnode)))
 			attr = DEV_DMA_COHERENT;
 		else
 			attr = DEV_DMA_NON_COHERENT;
 	} else
-		attr = acpi_get_dma_attr(ACPI_COMPANION(dev));
+		attr = acpi_get_dma_attr(to_acpi_device_node(fwnode));
 
 	return attr;
 }
@@ -1007,14 +1005,13 @@ EXPORT_SYMBOL(device_get_mac_address);
  * Returns Linux IRQ number on success. Other values are determined
  * accordingly to acpi_/of_ irq_get() operation.
  */
-int fwnode_irq_get(struct fwnode_handle *fwnode, unsigned int index)
+int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
 {
-	struct device_node *of_node = to_of_node(fwnode);
 	struct resource res;
 	int ret;
 
-	if (IS_ENABLED(CONFIG_OF) && of_node)
-		return of_irq_get(of_node, index);
+	if (is_of_node(fwnode))
+		return of_irq_get(to_of_node(fwnode), index);
 
 	ret = acpi_irq_get(ACPI_HANDLE_FWNODE(fwnode), index, &res);
 	if (ret)
diff --git a/include/linux/property.h b/include/linux/property.h
index 0d876316e61d..073e680c35e2 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -119,7 +119,7 @@ struct fwnode_handle *device_get_named_child_node(struct device *dev,
 struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
 void fwnode_handle_put(struct fwnode_handle *fwnode);
 
-int fwnode_irq_get(struct fwnode_handle *fwnode, unsigned int index);
+int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
 
 unsigned int device_get_child_node_count(struct device *dev);
 
-- 
2.30.2

