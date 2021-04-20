Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C48036554D
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Apr 2021 11:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhDTJ2y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 20 Apr 2021 05:28:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17800 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhDTJ2y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Apr 2021 05:28:54 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FPdbC1Qwdz7wMj;
        Tue, 20 Apr 2021 17:25:59 +0800 (CST)
Received: from A2006125610.china.huawei.com (10.47.83.26) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Tue, 20 Apr 2021 17:28:14 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <steven.price@arm.com>, <Sami.Mujawar@arm.com>,
        <jon@solid-run.com>, <eric.auger@redhat.com>
Subject: [PATCH v3 02/10] iommu/dma: Introduce generic helper to retrieve RMR info
Date:   Tue, 20 Apr 2021 10:27:43 +0200
Message-ID: <20210420082751.1829-3-shameerali.kolothum.thodi@huawei.com>
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

Reserved Memory Regions(RMR) associated with an IOMMU may be
described either through ACPI tables or DT in systems with
devices that require a unity mapping or bypass for those
regions in IOMMU drivers.

Introduce a generic interface so that IOMMU drivers can retrieve
and set up necessary mappings.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/dma-iommu.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/dma-iommu.h |  8 ++++++++
 include/linux/iommu.h     | 19 +++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index af765c813cc8..86a1e48b1fe8 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -191,6 +191,39 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 }
 EXPORT_SYMBOL(iommu_dma_get_resv_regions);
 
+/**
+ * iommu_dma_get_rmrs - Retrieve Reserved Memory Regions(RMRs) associated
+ *                      with a given IOMMU
+ * @iommu_fwnode: fwnode associated with IOMMU
+ * @list: RMR list to be populated
+ *
+ */
+int iommu_dma_get_rmrs(struct fwnode_handle *iommu_fwnode,
+		       struct list_head *list)
+{
+	return 0;
+}
+EXPORT_SYMBOL(iommu_dma_get_rmrs);
+
+struct iommu_rmr *iommu_dma_alloc_rmr(u64 base, u64 length, u32 sid,
+				      u32 flags)
+{
+	struct iommu_rmr *rmr;
+
+	rmr = kzalloc(sizeof(*rmr), GFP_KERNEL);
+	if (!rmr)
+		return NULL;
+
+	INIT_LIST_HEAD(&rmr->list);
+	rmr->base_address = base;
+	rmr->length = length;
+	rmr->sid = sid;
+	rmr->flags = flags;
+
+	return rmr;
+}
+EXPORT_SYMBOL(iommu_dma_alloc_rmr);
+
 static int cookie_init_hw_msi_region(struct iommu_dma_cookie *cookie,
 		phys_addr_t start, phys_addr_t end)
 {
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 706b68d1359b..beb84c4fe5b1 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -40,6 +40,9 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
 		struct iommu_domain *domain);
 
+int iommu_dma_get_rmrs(struct fwnode_handle *iommu, struct list_head *list);
+struct iommu_rmr *iommu_dma_alloc_rmr(u64 base, u64 length, u32 sid, u32 flags);
+
 #else /* CONFIG_IOMMU_DMA */
 
 struct iommu_domain;
@@ -86,5 +89,10 @@ static inline void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
 {
 }
 
+int iommu_dma_get_rmrs(struct fwnode_handle *iommu, struct list_head *list);
+{
+	return 0;
+}
+
 #endif	/* CONFIG_IOMMU_DMA */
 #endif	/* __DMA_IOMMU_H */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5e7fe519430a..fb8820c40144 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -595,6 +595,25 @@ struct iommu_sva {
 	struct device			*dev;
 };
 
+/**
+ * struct iommu_rmr - Reserved Memory Region details per IOMMU
+ * @list: Linked list pointers to hold RMR region info
+ * @base_address: base address of Reserved Memory Region
+ * @length: length of memory region
+ * @sid: associated stream id
+ * @flags: flags that apply to the RMR node
+ */
+struct iommu_rmr {
+	struct list_head	list;
+	phys_addr_t		base_address;
+	u64			length;
+	u32			sid;
+	u32			flags;
+};
+
+/* RMR Remap permitted */
+#define IOMMU_RMR_REMAP_PERMITTED	(1 << 0)
+
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops);
 void iommu_fwspec_free(struct device *dev);
-- 
2.17.1

