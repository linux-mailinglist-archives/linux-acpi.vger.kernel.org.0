Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F01365550
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Apr 2021 11:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhDTJ3E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 20 Apr 2021 05:29:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16606 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhDTJ3E (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Apr 2021 05:29:04 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FPdbQ05w2z19M2h;
        Tue, 20 Apr 2021 17:26:10 +0800 (CST)
Received: from A2006125610.china.huawei.com (10.47.83.26) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Tue, 20 Apr 2021 17:28:20 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <steven.price@arm.com>, <Sami.Mujawar@arm.com>,
        <jon@solid-run.com>, <eric.auger@redhat.com>
Subject: [PATCH v3 03/10] ACPI/IORT: Add a helper to retrieve RMR memory regions
Date:   Tue, 20 Apr 2021 10:27:44 +0200
Message-ID: <20210420082751.1829-4-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210420082751.1829-1-shameerali.kolothum.thodi@huawei.com>
References: <20210420082751.1829-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.83.26]
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
 drivers/acpi/arm64/iort.c | 40 +++++++++++++++++++++++++++++++++++++++
 drivers/iommu/dma-iommu.c |  3 +++
 include/linux/acpi_iort.h |  7 +++++++
 3 files changed, 50 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index bd96c5e3b36e..66e314b15692 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -12,6 +12,7 @@
 
 #include <linux/acpi_iort.h>
 #include <linux/bitfield.h>
+#include <linux/dma-iommu.h>
 #include <linux/iommu.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -837,6 +838,43 @@ static inline int iort_add_device_replay(struct device *dev)
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
+		struct acpi_iort_rmr_desc *rmr_desc;
+		struct iommu_rmr *rmr;
+
+		if (e->smmu != iommu)
+			continue;
+
+		rmr_desc = e->rmr_desc;
+		rmr = iommu_dma_alloc_rmr(rmr_desc->base_address,
+					  rmr_desc->length, e->sid,
+					  e->flags);
+		if (!rmr)
+			return -ENOMEM;
+
+		list_add_tail(&rmr->list, head);
+	}
+
+	return 0;
+}
+
 /**
  * iort_iommu_msi_get_resv_regions - Reserved region driver helper
  * @dev: Device from iommu_get_resv_regions()
@@ -1107,6 +1145,8 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
 						const u32 *input_id)
 { return NULL; }
+int iort_iommu_get_rmrs(struct fwnode_handle *fwnode, struct list_head *head)
+{ return 0; }
 #endif
 
 static int nc_dma_get_range(struct device *dev, u64 *size)
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 86a1e48b1fe8..a942cc04eee1 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -201,6 +201,9 @@ EXPORT_SYMBOL(iommu_dma_get_resv_regions);
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
index 1a12baa58e40..e9f3bc2f4842 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -39,6 +39,8 @@ const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
 						const u32 *id_in);
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
 phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
+int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
+			struct list_head *list);
 #else
 static inline void acpi_iort_init(void) { }
 static inline u32 iort_msi_map_id(struct device *dev, u32 id)
@@ -59,6 +61,11 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 
 static inline phys_addr_t acpi_iort_dma_get_max_cpu_address(void)
 { return PHYS_ADDR_MAX; }
+
+static inline
+int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
+			struct list_head *list)
+{ return 0; }
 #endif
 
 #endif /* __ACPI_IORT_H__ */
-- 
2.17.1

