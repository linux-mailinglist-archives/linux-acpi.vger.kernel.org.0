Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF17A76BAA8
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Aug 2023 19:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbjHARES (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Aug 2023 13:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbjHARDu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Aug 2023 13:03:50 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2DC92D76;
        Tue,  1 Aug 2023 10:03:30 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,247,1684767600"; 
   d="scan'208";a="175247330"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 02 Aug 2023 02:03:29 +0900
Received: from localhost.localdomain (unknown [10.226.92.54])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id DD6BC402842A;
        Wed,  2 Aug 2023 02:03:25 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-acpi@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wolfram Sang <wsa@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 1/2] drivers: fwnode: Extend device_get_match_data() to struct bus_type
Date:   Tue,  1 Aug 2023 18:03:17 +0100
Message-Id: <20230801170318.82682-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230801170318.82682-1-biju.das.jz@bp.renesas.com>
References: <20230801170318.82682-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Extend device_get_match_data() to buses (for eg: I2C) by adding a
callback device_get_match_data() to struct bus_type() and call this method
as a fallback for generic fwnode based device_get_match_data().

Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2->v3:
 * Added Rb tag from Andy.
RFC v1-> v2:
 * Replaced "Signed-off-by"->"Suggested-by" tag for Dmitry.
 * Documented device_get_match_data().
 * Added multiple returns to make code path for generic fwnode-based
   lookup faster.
---
 drivers/base/property.c    | 21 ++++++++++++++++++++-
 include/linux/device/bus.h |  3 +++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 8c40abed7852..e12af9ff0f51 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1275,9 +1275,28 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL(fwnode_graph_parse_endpoint);
 
+/**
+ * device_get_match_data - get match data from OF/ACPI/Bus match tables
+ * @dev: device to find the match data
+ *
+ * Find match data using generic fwnode-based lookup and if there is no
+ * match, call the bus->get_match_data() for finding match data.
+ *
+ * Return: a match data pointer or NULL if there is no match in the matching
+ * table.
+ */
 const void *device_get_match_data(const struct device *dev)
 {
-	return fwnode_call_ptr_op(dev_fwnode(dev), device_get_match_data, dev);
+	const void *data;
+
+	data = fwnode_call_ptr_op(dev_fwnode(dev), device_get_match_data, dev);
+	if (data)
+		return data;
+
+	if (dev->bus && dev->bus->get_match_data)
+		return dev->bus->get_match_data(dev);
+
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(device_get_match_data);
 
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index ae10c4322754..2e15b0ae5384 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -60,6 +60,7 @@ struct fwnode_handle;
  *			this bus.
  * @dma_cleanup:	Called to cleanup DMA configuration on a device on
  *			this bus.
+ * @get_match_data:	Called to get match data on a device on this bus.
  * @pm:		Power management operations of this bus, callback the specific
  *		device driver's pm-ops.
  * @iommu_ops:  IOMMU specific operations for this bus, used to attach IOMMU
@@ -102,6 +103,8 @@ struct bus_type {
 	int (*dma_configure)(struct device *dev);
 	void (*dma_cleanup)(struct device *dev);
 
+	const void *(*get_match_data)(const struct device *dev);
+
 	const struct dev_pm_ops *pm;
 
 	const struct iommu_ops *iommu_ops;
-- 
2.25.1

