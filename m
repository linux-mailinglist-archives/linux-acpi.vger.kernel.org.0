Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C22A54C58C
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jun 2022 12:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239805AbiFOKMB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Jun 2022 06:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240143AbiFOKMB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jun 2022 06:12:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8964AE0E
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jun 2022 03:12:00 -0700 (PDT)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LNLf60hpqz67bmq;
        Wed, 15 Jun 2022 18:10:22 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 12:11:58 +0200
Received: from A2006125610.china.huawei.com (10.202.227.178) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 11:11:51 +0100
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>, <will@kernel.org>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <steven.price@arm.com>, <Sami.Mujawar@arm.com>,
        <jon@solid-run.com>, <eric.auger@redhat.com>,
        <laurentiu.tudor@nxp.com>, <hch@infradead.org>
Subject: [PATCH v13 3/9] ACPI/IORT: Provide a generic helper to retrieve reserve regions
Date:   Wed, 15 Jun 2022 11:10:38 +0100
Message-ID: <20220615101044.1972-4-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20220615101044.1972-1-shameerali.kolothum.thodi@huawei.com>
References: <20220615101044.1972-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.227.178]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently IORT provides a helper to retrieve HW MSI reserve regions.
Change this to a generic helper to retrieve any IORT related reserve
regions. This will be useful when we add support for RMR nodes in
subsequent patches.

[Lorenzo: For ACPI IORT]
Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Steven Price <steven.price@arm.com>
Tested-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Tested-by: Hanjun Guo <guohanjun@huawei.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/acpi/arm64/iort.c | 22 +++++++++++++++-------
 drivers/iommu/dma-iommu.c |  2 +-
 include/linux/acpi_iort.h |  4 ++--
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 213f61cae176..cd5d1d7823cb 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -806,15 +806,13 @@ static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
 	return NULL;
 }
 
-/**
- * iort_iommu_msi_get_resv_regions - Reserved region driver helper
- * @dev: Device from iommu_get_resv_regions()
- * @head: Reserved region list from iommu_get_resv_regions()
- *
+/*
+ * Retrieve platform specific HW MSI reserve regions.
  * The ITS interrupt translation spaces (ITS_base + SZ_64K, SZ_64K)
  * associated with the device are the HW MSI reserved regions.
  */
-void iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
+static void iort_iommu_msi_get_resv_regions(struct device *dev,
+					    struct list_head *head)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct acpi_iort_its_group *its;
@@ -863,6 +861,16 @@ void iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 	}
 }
 
+/**
+ * iort_iommu_get_resv_regions - Generic helper to retrieve reserved regions.
+ * @dev: Device from iommu_get_resv_regions()
+ * @head: Reserved region list from iommu_get_resv_regions()
+ */
+void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head)
+{
+	iort_iommu_msi_get_resv_regions(dev, head);
+}
+
 static inline bool iort_iommu_driver_enabled(u8 type)
 {
 	switch (type) {
@@ -1027,7 +1035,7 @@ int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
 }
 
 #else
-void iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
+void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head)
 { }
 int iort_iommu_configure_id(struct device *dev, const u32 *input_id)
 { return -ENODEV; }
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f90251572a5d..970a2e018684 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -385,7 +385,7 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 {
 
 	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
-		iort_iommu_msi_get_resv_regions(dev, list);
+		iort_iommu_get_resv_regions(dev, list);
 
 }
 EXPORT_SYMBOL(iommu_dma_get_resv_regions);
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index a8198b83753d..e5d2de9caf7f 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -36,7 +36,7 @@ int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
 /* IOMMU interface */
 int iort_dma_get_ranges(struct device *dev, u64 *size);
 int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
-void iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
+void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head);
 phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
 #else
 static inline void acpi_iort_init(void) { }
@@ -52,7 +52,7 @@ static inline int iort_dma_get_ranges(struct device *dev, u64 *size)
 static inline int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
 { return -ENODEV; }
 static inline
-void iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
+void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head)
 { }
 
 static inline phys_addr_t acpi_iort_dma_get_max_cpu_address(void)
-- 
2.25.1

