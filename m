Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1052F365553
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Apr 2021 11:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhDTJ3J (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 20 Apr 2021 05:29:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17801 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhDTJ3I (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Apr 2021 05:29:08 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FPdbV3Xh4z7vrv;
        Tue, 20 Apr 2021 17:26:14 +0800 (CST)
Received: from A2006125610.china.huawei.com (10.47.83.26) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Tue, 20 Apr 2021 17:28:26 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <steven.price@arm.com>, <Sami.Mujawar@arm.com>,
        <jon@solid-run.com>, <eric.auger@redhat.com>
Subject: [PATCH v3 04/10] iommu/dma: Add a helper function to reserve RMRs for IOMMU drivers
Date:   Tue, 20 Apr 2021 10:27:45 +0200
Message-ID: <20210420082751.1829-5-shameerali.kolothum.thodi@huawei.com>
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

IOMMU drivers can use this to implement their .get_resv_regions callback
for any RMR address regions specific to a device.

As per ACPI IORT E.b spec, a check is added to make sure OS has preserved
the PCIe configuration done by boot firmware.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/dma-iommu.c | 35 +++++++++++++++++++++++++++++++++++
 include/linux/dma-iommu.h |  7 +++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index a942cc04eee1..c624000bf230 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -191,6 +191,41 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 }
 EXPORT_SYMBOL(iommu_dma_get_resv_regions);
 
+void iommu_dma_get_rmr_resv_regions(struct device *dev, struct iommu_rmr *rmr,
+				    struct list_head *list)
+{
+	int prot = IOMMU_READ | IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
+	struct iommu_resv_region *region;
+	enum iommu_resv_type type;
+
+	/*
+	 * For ACPI, please make sure the OS has preserved the PCIe configuration
+	 * performed by the boot firmware(See IORT revision E.b).
+	 */
+	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode) &&
+	    dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+		struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
+
+		if (!host->preserve_config)
+			return;
+	}
+
+	if (rmr->flags & IOMMU_RMR_REMAP_PERMITTED)
+		type = IOMMU_RESV_DIRECT_RELAXABLE;
+	else
+		type = IOMMU_RESV_DIRECT;
+
+	region = iommu_alloc_resv_region(rmr->base_address,
+					 rmr->length, prot,
+					 type);
+	if (!region)
+		return;
+
+	list_add_tail(&region->list, list);
+}
+EXPORT_SYMBOL(iommu_dma_get_rmr_resv_regions);
+
 /**
  * iommu_dma_get_rmrs - Retrieve Reserved Memory Regions(RMRs) associated
  *                      with a given IOMMU
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index beb84c4fe5b1..dbad5073c9e0 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -40,6 +40,8 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
 		struct iommu_domain *domain);
 
+void iommu_dma_get_rmr_resv_regions(struct device *dev, struct iommu_rmr *rmr,
+				    struct list_head *list);
 int iommu_dma_get_rmrs(struct fwnode_handle *iommu, struct list_head *list);
 struct iommu_rmr *iommu_dma_alloc_rmr(u64 base, u64 length, u32 sid, u32 flags);
 
@@ -89,6 +91,11 @@ static inline void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
 {
 }
 
+static void iommu_dma_get_rmr_resv_regions(struct device *dev, struct iommu_rmr *rmr,
+					   struct list_head *list)
+{
+}
+
 int iommu_dma_get_rmrs(struct fwnode_handle *iommu, struct list_head *list);
 {
 	return 0;
-- 
2.17.1

