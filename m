Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9051F4BDDFF
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Feb 2022 18:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344525AbiBUPrk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Feb 2022 10:47:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379456AbiBUPpn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Feb 2022 10:45:43 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A025D22B06
        for <linux-acpi@vger.kernel.org>; Mon, 21 Feb 2022 07:45:19 -0800 (PST)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K2RMl61rrz67Ys9;
        Mon, 21 Feb 2022 23:40:35 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Feb 2022 16:45:17 +0100
Received: from A2006125610.china.huawei.com (10.47.91.169) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Feb 2022 15:45:09 +0000
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>, <will@kernel.org>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <steven.price@arm.com>, <Sami.Mujawar@arm.com>,
        <jon@solid-run.com>, <eric.auger@redhat.com>,
        <yangyicong@huawei.com>
Subject: [PATCH v8 05/11] ACPI/IORT: Add a helper to retrieve RMR memory regions
Date:   Mon, 21 Feb 2022 15:43:38 +0000
Message-ID: <20220221154344.2126-6-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.91.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add helper functions (iort_iommu_get/put_rmrs()) that
retrieves/releases RMR memory descriptors associated
with a given IOMMU. This will be used by IOMMU drivers
to set up necessary mappings.

Invoke it from the generic iommu helper functions.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/acpi/arm64/iort.c | 56 +++++++++++++++++++++++++++++++++++++++
 drivers/iommu/dma-iommu.c |  4 +++
 include/linux/acpi_iort.h | 14 ++++++++++
 3 files changed, 74 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 05da9ebff50a..b2c959c72fb2 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1055,6 +1055,57 @@ static void iort_find_rmrs(struct acpi_iort_node *iommu, struct device *dev,
 	}
 }
 
+/**
+ * iort_iommu_dma_put_rmrs - Free any memory associated with RMRs.
+ * @iommu_fwnode: fwnode associated with IOMMU
+ * @head: Resereved region list
+ *
+ * This function go through the provided reserved region list and
+ * free up memory associated with RMR entries and delete them from
+ * the list.
+ */
+void iort_iommu_put_rmrs(struct fwnode_handle *iommu_fwnode,
+			 struct list_head *head)
+{
+	struct iommu_resv_region *e, *tmp;
+
+	/*
+	 * RMR entries will have mem allocated for fw_data.rmr.sids.
+	 * Free the mem and delete the node.
+	 */
+	list_for_each_entry_safe(e, tmp, head, list) {
+		if (e->fw_data.rmr.sids) {
+			kfree(e->fw_data.rmr.sids);
+			list_del(&e->list);
+			kfree(e);
+		}
+	}
+}
+
+/**
+ *
+ * iort_iommu_dma_get_rmrs - Retrieve Reserved Memory Regions(RMRs) associated
+ *                      with a given IOMMU and dev.
+ * @iommu_fwnode: fwnode associated with IOMMU
+ * @dev: Device associated with RMR(Optional)
+ * @list: RMR list to be populated
+ *
+ * This function populates the RMR list associated with a given IOMMU and
+ * dev(if provided). If dev is NULL, the function populates all the RMRs
+ * associated with the given IOMMU.
+ */
+void iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode, struct device *dev,
+			 struct list_head *head)
+{
+	struct acpi_iort_node *iommu;
+
+	iommu = iort_get_iort_node(iommu_fwnode);
+	if (!iommu)
+		return;
+
+	iort_find_rmrs(iommu, dev, head);
+}
+
 /**
  * iort_iommu_msi_get_resv_regions - Reserved region driver helper
  * @dev: Device from iommu_get_resv_regions()
@@ -1287,6 +1338,11 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 { return 0; }
 int iort_iommu_configure_id(struct device *dev, const u32 *input_id)
 { return -ENODEV; }
+void iort_iommu_get_rmrs(struct fwnode_handle *fwnode, struct device *dev,
+			 struct list_head *head)
+{ }
+void iort_iommu_put_rmrs(struct fwnode_handle *fwnode, struct list_head *head)
+{ }
 #endif
 
 static int nc_dma_get_range(struct device *dev, u64 *size)
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 65ab01d5128b..b33e4df85de1 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -382,12 +382,16 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 void iommu_dma_get_rmrs(struct fwnode_handle *iommu_fwnode, struct device *dev,
 			struct list_head *list)
 {
+	if (!is_of_node(iommu_fwnode))
+		iort_iommu_get_rmrs(iommu_fwnode, dev, list);
 }
 EXPORT_SYMBOL(iommu_dma_get_rmrs);
 
 void iommu_dma_put_rmrs(struct fwnode_handle *iommu_fwnode,
 			struct list_head *list)
 {
+	if (!is_of_node(iommu_fwnode))
+		iort_iommu_put_rmrs(iommu_fwnode, list);
 }
 EXPORT_SYMBOL(iommu_dma_put_rmrs);
 
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index f1f0842a2cb2..212f7f178ec3 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -38,6 +38,10 @@ int iort_dma_get_ranges(struct device *dev, u64 *size);
 int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
 phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
+void iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode, struct device *dev,
+			 struct list_head *list);
+void iort_iommu_put_rmrs(struct fwnode_handle *iommu_fwnode,
+			 struct list_head *list);
 #else
 static inline void acpi_iort_init(void) { }
 static inline u32 iort_msi_map_id(struct device *dev, u32 id)
@@ -57,6 +61,16 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 
 static inline phys_addr_t acpi_iort_dma_get_max_cpu_address(void)
 { return PHYS_ADDR_MAX; }
+
+static inline
+void iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode, struct device *dev,
+			 struct list_head *list)
+{  }
+void iort_iommu_put_rmrs(struct fwnode_handle *iommu_fwnode,
+			 struct list_head *list)
+{ }
+
+{ }
 #endif
 
 #endif /* __ACPI_IORT_H__ */
-- 
2.25.1

