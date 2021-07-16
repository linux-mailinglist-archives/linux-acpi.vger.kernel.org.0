Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43DD3CB47D
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jul 2021 10:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238233AbhGPIiO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Jul 2021 04:38:14 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3420 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238195AbhGPIiN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jul 2021 04:38:13 -0400
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GR45Z5n6pz6H7Mp;
        Fri, 16 Jul 2021 16:24:02 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 10:35:17 +0200
Received: from A2006125610.china.huawei.com (10.47.80.222) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 09:35:10 +0100
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <steven.price@arm.com>, <Sami.Mujawar@arm.com>,
        <jon@solid-run.com>, <eric.auger@redhat.com>,
        <yangyicong@huawei.com>
Subject: [PATCH v6 3/9] iommu/dma: Introduce generic helper to retrieve RMR info
Date:   Fri, 16 Jul 2021 09:34:36 +0100
Message-ID: <20210716083442.1708-4-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210716083442.1708-1-shameerali.kolothum.thodi@huawei.com>
References: <20210716083442.1708-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.80.222]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Reserved Memory Regions(RMR) associated with an IOMMU can be
described through ACPI IORT tables in systems with devices
that require a unity mapping or bypass for those
regions.

Introduce a generic interface so that IOMMU drivers can retrieve
and set up necessary mappings.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/dma-iommu.c | 29 +++++++++++++++++++++++++++++
 include/linux/dma-iommu.h | 13 +++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 98ba927aee1a..2fa2445e9070 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -174,6 +174,35 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 }
 EXPORT_SYMBOL(iommu_put_dma_cookie);
 
+/**
+ *
+ * iommu_dma_get_rmrs - Retrieve Reserved Memory Regions(RMRs) associated
+ *                      with a given IOMMU
+ * @iommu_fwnode: fwnode associated with IOMMU
+ * @list: RMR list to be populated
+ *
+ */
+int iommu_dma_get_rmrs(struct fwnode_handle *iommu_fwnode,
+		       struct list_head *list)
+{
+	return -EINVAL;
+}
+EXPORT_SYMBOL(iommu_dma_get_rmrs);
+
+/**
+ *
+ * iommu_dma_put_rmrs - Release Reserved Memory Regions(RMRs) associated
+ *                      with a given IOMMU
+ * @iommu_fwnode: fwnode associated with IOMMU
+ * @list: RMR list
+ *
+ */
+void iommu_dma_put_rmrs(struct fwnode_handle *iommu_fwnode,
+			struct list_head *list)
+{
+}
+EXPORT_SYMBOL(iommu_dma_put_rmrs);
+
 /**
  * iommu_dma_get_resv_regions - Reserved region driver helper
  * @dev: Device from iommu_get_resv_regions()
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 758ca4694257..3b7b2d096c6e 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -42,12 +42,16 @@ void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
 
 extern bool iommu_dma_forcedac;
 
+int iommu_dma_get_rmrs(struct fwnode_handle *iommu, struct list_head *list);
+void iommu_dma_put_rmrs(struct fwnode_handle *iommu, struct list_head *list);
+
 #else /* CONFIG_IOMMU_DMA */
 
 struct iommu_domain;
 struct msi_desc;
 struct msi_msg;
 struct device;
+struct fwnode_handle;
 
 static inline void iommu_setup_dma_ops(struct device *dev, u64 dma_base,
 				       u64 dma_limit)
@@ -83,5 +87,14 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
 {
 }
 
+static int iommu_dma_get_rmrs(struct fwnode_handle *iommu, struct list_head *list)
+{
+	return -ENODEV;
+}
+
+static void iommu_dma_put_rmrs(struct fwnode_handle *iommu, struct list_head *list)
+{
+}
+
 #endif	/* CONFIG_IOMMU_DMA */
 #endif	/* __DMA_IOMMU_H */
-- 
2.17.1

