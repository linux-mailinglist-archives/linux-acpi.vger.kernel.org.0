Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5432B9245
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Nov 2020 13:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgKSMMx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Nov 2020 07:12:53 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7564 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbgKSMMx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Nov 2020 07:12:53 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CcJTb4ZwHzhd1R;
        Thu, 19 Nov 2020 20:12:35 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.210.168.73) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 19 Nov 2020 20:12:44 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <devel@acpica.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <jonathan.cameron@huawei.com>, <steven.price@arm.com>,
        <Sami.Mujawar@arm.com>
Subject: [RFC PATCH v2 4/8] ACPI/IORT: Add RMR memory regions reservation helper
Date:   Thu, 19 Nov 2020 12:11:46 +0000
Message-ID: <20201119121150.3316-5-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
References: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.210.168.73]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a helper function that retrieves RMR memory descriptors
associated with a given IOMMU. This will be used by IOMMU
drivers to setup necessary mappings.

Now that we have this, invoke this from the generic helper
interface.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/acpi/arm64/iort.c | 60 +++++++++++++++++++++++++++++++++++++++
 drivers/iommu/dma-iommu.c |  3 ++
 include/linux/acpi_iort.h |  6 ++++
 3 files changed, 69 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index a9705aa35028..d1a2b09230ab 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -12,6 +12,7 @@
 
 #include <linux/acpi_iort.h>
 #include <linux/bitfield.h>
+#include <linux/dma-iommu.h>
 #include <linux/iommu.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -842,6 +843,63 @@ static inline int iort_add_device_replay(struct device *dev)
 	return err;
 }
 
+/**
+ * iort_iommu_get_rmrs - Helper to retrieve RMR info associated with IOMMU
+ * @iommu: fwnode for the IOMMU
+ * @head: RMR list head to be populated
+ *
+ * Returns: 0 on success, <0 failure
+ */
+int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
+			struct list_head *head)
+{
+	struct iort_rmr_entry *e;
+	struct acpi_iort_node *iommu;
+
+	iommu = iort_get_iort_node(iommu_fwnode);
+	if (!iommu)
+		return 0;
+
+	list_for_each_entry(e, &iort_rmr_list, list) {
+		struct iort_rmr_id *rmr_ids = e->rmr_ids;
+		struct acpi_iort_rmr_desc *rmr_desc;
+		struct iommu_rmr *rmr;
+		u32 *ids, num_ids = 0;
+		int i, j = 0;
+
+		for (i = 0; i < e->rmr_ids_num; i++) {
+			if (rmr_ids[i].smmu == iommu)
+				num_ids++;
+		}
+
+		if (!num_ids)
+			continue;
+
+		ids = kmalloc_array(num_ids, sizeof(*ids), GFP_KERNEL);
+		if (!ids)
+			return -ENOMEM;
+
+		for (i = 0; i < e->rmr_ids_num; i++) {
+			if (rmr_ids[i].smmu == iommu)
+				ids[j++] = rmr_ids[i].sid;
+		}
+
+		rmr_desc = e->rmr_desc;
+		rmr = iommu_dma_alloc_rmr(rmr_desc->base_address,
+					  rmr_desc->length,
+					  ids, num_ids);
+		if (!rmr) {
+			kfree(ids);
+			return -ENOMEM;
+		}
+
+		list_add_tail(&rmr->list, head);
+		kfree(ids);
+	}
+
+	return 0;
+}
+
 /**
  * iort_iommu_msi_get_resv_regions - Reserved region driver helper
  * @dev: Device from iommu_get_resv_regions()
@@ -1112,6 +1170,8 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
 						const u32 *input_id)
 { return NULL; }
+int iort_iommu_get_rmrs(struct fwnode_handle *fwnode, struct list_head *head)
+{ return 0; }
 #endif
 
 static int nc_dma_get_range(struct device *dev, u64 *size)
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d73768ecdd1a..aa8304e50786 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -176,6 +176,9 @@ EXPORT_SYMBOL(iommu_dma_get_resv_regions);
 int iommu_dma_get_rmrs(struct fwnode_handle *iommu_fwnode,
 		       struct list_head *list)
 {
+	if (!is_of_node(iommu_fwnode))
+		return iort_iommu_get_rmrs(iommu_fwnode, list);
+
 	return 0;
 }
 EXPORT_SYMBOL(iommu_dma_get_rmrs);
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 20a32120bb88..0b61b98a4941 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -38,6 +38,8 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *size);
 const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
 						const u32 *id_in);
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
+int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
+			struct list_head *list);
 #else
 static inline void acpi_iort_init(void) { }
 static inline u32 iort_msi_map_id(struct device *dev, u32 id)
@@ -55,6 +57,10 @@ static inline const struct iommu_ops *iort_iommu_configure_id(
 static inline
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 { return 0; }
+static inline
+int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
+			struct list_head *list)
+{ return 0; }
 #endif
 
 #endif /* __ACPI_IORT_H__ */
-- 
2.17.1

