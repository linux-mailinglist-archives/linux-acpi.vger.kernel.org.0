Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D35F20B9B
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2019 17:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfEPPxS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 May 2019 11:53:18 -0400
Received: from foss.arm.com ([217.140.101.70]:50166 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfEPPxS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 May 2019 11:53:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FBED1715;
        Thu, 16 May 2019 08:53:18 -0700 (PDT)
Received: from redmoon.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88C503F71E;
        Thu, 16 May 2019 08:53:16 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2] ACPI/IORT: Fix build error when IOMMU_SUPPORT is disabled
Date:   Thu, 16 May 2019 16:52:58 +0100
Message-Id: <20190516155258.5834-1-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515034253.79348-1-wangkefeng.wang@huawei.com>
References: <20190515034253.79348-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

If IOMMU_SUPPORT is not enabled (and therefore IOMMU_API is not
selected), struct iommu_fwspec is an empty struct and
IOMMU_FWSPEC_PCI_RC_ATS is not defined, resulting in the following
compilation errors:

drivers/acpi/arm64/iort.c: In function iort_iommu_configure:
drivers/acpi/arm64/iort.c:1079:21: error: struct iommu_fwspec has no member named flag:
    dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
                     ^~
drivers/acpi/arm64/iort.c:1079:32: error: IOMMU_FWSPEC_PCI_RC_ATS
undeclared (first use in this function)
    dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
                                ^~~~~~~~~~~~~~~~~~~~~~~
drivers/acpi/arm64/iort.c:1079:32: note: each undeclared identifier is reported only once for each function it appears in

Move iort_iommu_configure() (and the helpers functions it relies on)
into CONFIG_IOMMU_API preprocessor guarded code so that when
CONFIG_IOMMU_SUPPORT is not enabled we prevent compiling code that is
basically equivalent to no-OP, fixing the build errors.

Link: https://lore.kernel.org/linux-arm-kernel/20190515034253.79348-1-wangkefeng.wang@huawei.com/
Reported-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Fixes: 5702ee24182f ("ACPI/IORT: Check ATS capability in root complex nodes")
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/acpi/arm64/iort.c | 238 +++++++++++++++++++-------------------
 1 file changed, 120 insertions(+), 118 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 9058cb084b91..b5390b4c9ade 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -753,31 +753,6 @@ static int __maybe_unused __get_pci_rid(struct pci_dev *pdev, u16 alias,
 	return 0;
 }
 
-static int arm_smmu_iort_xlate(struct device *dev, u32 streamid,
-			       struct fwnode_handle *fwnode,
-			       const struct iommu_ops *ops)
-{
-	int ret = iommu_fwspec_init(dev, fwnode, ops);
-
-	if (!ret)
-		ret = iommu_fwspec_add_ids(dev, &streamid, 1);
-
-	return ret;
-}
-
-static inline bool iort_iommu_driver_enabled(u8 type)
-{
-	switch (type) {
-	case ACPI_IORT_NODE_SMMU_V3:
-		return IS_BUILTIN(CONFIG_ARM_SMMU_V3);
-	case ACPI_IORT_NODE_SMMU:
-		return IS_BUILTIN(CONFIG_ARM_SMMU);
-	default:
-		pr_warn("IORT node type %u does not describe an SMMU\n", type);
-		return false;
-	}
-}
-
 #ifdef CONFIG_IOMMU_API
 static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
 {
@@ -878,15 +853,39 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 
 	return (resv == its->its_count) ? resv : -ENODEV;
 }
-#else
-static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev)
-{ return NULL; }
-static inline int iort_add_device_replay(const struct iommu_ops *ops,
-					 struct device *dev)
-{ return 0; }
-int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
-{ return 0; }
-#endif
+
+static inline bool iort_iommu_driver_enabled(u8 type)
+{
+	switch (type) {
+	case ACPI_IORT_NODE_SMMU_V3:
+		return IS_BUILTIN(CONFIG_ARM_SMMU_V3);
+	case ACPI_IORT_NODE_SMMU:
+		return IS_BUILTIN(CONFIG_ARM_SMMU);
+	default:
+		pr_warn("IORT node type %u does not describe an SMMU\n", type);
+		return false;
+	}
+}
+
+static int arm_smmu_iort_xlate(struct device *dev, u32 streamid,
+			       struct fwnode_handle *fwnode,
+			       const struct iommu_ops *ops)
+{
+	int ret = iommu_fwspec_init(dev, fwnode, ops);
+
+	if (!ret)
+		ret = iommu_fwspec_add_ids(dev, &streamid, 1);
+
+	return ret;
+}
+
+static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
+{
+	struct acpi_iort_root_complex *pci_rc;
+
+	pci_rc = (struct acpi_iort_root_complex *)node->node_data;
+	return pci_rc->ats_attribute & ACPI_IORT_ATS_SUPPORTED;
+}
 
 static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
 			    u32 streamid)
@@ -933,6 +932,93 @@ static int iort_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 	return iort_iommu_xlate(info->dev, parent, streamid);
 }
 
+/**
+ * iort_iommu_configure - Set-up IOMMU configuration for a device.
+ *
+ * @dev: device to configure
+ *
+ * Returns: iommu_ops pointer on configuration success
+ *          NULL on configuration failure
+ */
+const struct iommu_ops *iort_iommu_configure(struct device *dev)
+{
+	struct acpi_iort_node *node, *parent;
+	const struct iommu_ops *ops;
+	u32 streamid = 0;
+	int err = -ENODEV;
+
+	/*
+	 * If we already translated the fwspec there
+	 * is nothing left to do, return the iommu_ops.
+	 */
+	ops = iort_fwspec_iommu_ops(dev);
+	if (ops)
+		return ops;
+
+	if (dev_is_pci(dev)) {
+		struct pci_bus *bus = to_pci_dev(dev)->bus;
+		struct iort_pci_alias_info info = { .dev = dev };
+
+		node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
+				      iort_match_node_callback, &bus->dev);
+		if (!node)
+			return NULL;
+
+		info.node = node;
+		err = pci_for_each_dma_alias(to_pci_dev(dev),
+					     iort_pci_iommu_init, &info);
+
+		if (!err && iort_pci_rc_supports_ats(node))
+			dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
+	} else {
+		int i = 0;
+
+		node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
+				      iort_match_node_callback, dev);
+		if (!node)
+			return NULL;
+
+		do {
+			parent = iort_node_map_platform_id(node, &streamid,
+							   IORT_IOMMU_TYPE,
+							   i++);
+
+			if (parent)
+				err = iort_iommu_xlate(dev, parent, streamid);
+		} while (parent && !err);
+	}
+
+	/*
+	 * If we have reason to believe the IOMMU driver missed the initial
+	 * add_device callback for dev, replay it to get things in order.
+	 */
+	if (!err) {
+		ops = iort_fwspec_iommu_ops(dev);
+		err = iort_add_device_replay(ops, dev);
+	}
+
+	/* Ignore all other errors apart from EPROBE_DEFER */
+	if (err == -EPROBE_DEFER) {
+		ops = ERR_PTR(err);
+	} else if (err) {
+		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
+		ops = NULL;
+	}
+
+	return ops;
+}
+#else
+static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev)
+{ return NULL; }
+static inline int iort_add_device_replay(const struct iommu_ops *ops,
+					 struct device *dev)
+{ return 0; }
+int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
+{ return 0; }
+const struct iommu_ops *iort_iommu_configure(struct device *dev)
+{ return NULL; }
+#endif
+
 static int nc_dma_get_range(struct device *dev, u64 *size)
 {
 	struct acpi_iort_node *node;
@@ -1031,90 +1117,6 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
 	dev_dbg(dev, "dma_pfn_offset(%#08llx)\n", offset);
 }
 
-static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
-{
-	struct acpi_iort_root_complex *pci_rc;
-
-	pci_rc = (struct acpi_iort_root_complex *)node->node_data;
-	return pci_rc->ats_attribute & ACPI_IORT_ATS_SUPPORTED;
-}
-
-/**
- * iort_iommu_configure - Set-up IOMMU configuration for a device.
- *
- * @dev: device to configure
- *
- * Returns: iommu_ops pointer on configuration success
- *          NULL on configuration failure
- */
-const struct iommu_ops *iort_iommu_configure(struct device *dev)
-{
-	struct acpi_iort_node *node, *parent;
-	const struct iommu_ops *ops;
-	u32 streamid = 0;
-	int err = -ENODEV;
-
-	/*
-	 * If we already translated the fwspec there
-	 * is nothing left to do, return the iommu_ops.
-	 */
-	ops = iort_fwspec_iommu_ops(dev);
-	if (ops)
-		return ops;
-
-	if (dev_is_pci(dev)) {
-		struct pci_bus *bus = to_pci_dev(dev)->bus;
-		struct iort_pci_alias_info info = { .dev = dev };
-
-		node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
-				      iort_match_node_callback, &bus->dev);
-		if (!node)
-			return NULL;
-
-		info.node = node;
-		err = pci_for_each_dma_alias(to_pci_dev(dev),
-					     iort_pci_iommu_init, &info);
-
-		if (!err && iort_pci_rc_supports_ats(node))
-			dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
-	} else {
-		int i = 0;
-
-		node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
-				      iort_match_node_callback, dev);
-		if (!node)
-			return NULL;
-
-		do {
-			parent = iort_node_map_platform_id(node, &streamid,
-							   IORT_IOMMU_TYPE,
-							   i++);
-
-			if (parent)
-				err = iort_iommu_xlate(dev, parent, streamid);
-		} while (parent && !err);
-	}
-
-	/*
-	 * If we have reason to believe the IOMMU driver missed the initial
-	 * add_device callback for dev, replay it to get things in order.
-	 */
-	if (!err) {
-		ops = iort_fwspec_iommu_ops(dev);
-		err = iort_add_device_replay(ops, dev);
-	}
-
-	/* Ignore all other errors apart from EPROBE_DEFER */
-	if (err == -EPROBE_DEFER) {
-		ops = ERR_PTR(err);
-	} else if (err) {
-		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
-		ops = NULL;
-	}
-
-	return ops;
-}
-
 static void __init acpi_iort_register_irq(int hwirq, const char *name,
 					  int trigger,
 					  struct resource *res)
-- 
2.21.0

