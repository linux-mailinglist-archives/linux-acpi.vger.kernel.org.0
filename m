Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3CF54C58F
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jun 2022 12:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbiFOKMV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Jun 2022 06:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241823AbiFOKMS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jun 2022 06:12:18 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B114AE0F
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jun 2022 03:12:17 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LNLc10nNwz6H8ZZ;
        Wed, 15 Jun 2022 18:08:33 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 12:12:15 +0200
Received: from A2006125610.china.huawei.com (10.202.227.178) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 11:12:08 +0100
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>, <will@kernel.org>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <steven.price@arm.com>, <Sami.Mujawar@arm.com>,
        <jon@solid-run.com>, <eric.auger@redhat.com>,
        <laurentiu.tudor@nxp.com>, <hch@infradead.org>
Subject: [PATCH v13 5/9] ACPI/IORT: Add a helper to retrieve RMR info directly
Date:   Wed, 15 Jun 2022 11:10:40 +0100
Message-ID: <20220615101044.1972-6-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20220615101044.1972-1-shameerali.kolothum.thodi@huawei.com>
References: <20220615101044.1972-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
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

This will provide a way for SMMU drivers to retrieve StreamIDs
associated with IORT RMR nodes and use that to set bypass settings
for those IDs.

Tested-by: Steven Price <steven.price@arm.com>
Tested-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Tested-by: Hanjun Guo <guohanjun@huawei.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/acpi/arm64/iort.c | 28 ++++++++++++++++++++++++++++
 include/linux/acpi_iort.h |  8 ++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index b6273af316c6..cd1349d3544e 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1394,6 +1394,34 @@ int iort_dma_get_ranges(struct device *dev, u64 *size)
 		return nc_dma_get_range(dev, size);
 }
 
+/**
+ * iort_get_rmr_sids - Retrieve IORT RMR node reserved regions with
+ *                     associated StreamIDs information.
+ * @iommu_fwnode: fwnode associated with IOMMU
+ * @head: Resereved region list
+ */
+void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode,
+		       struct list_head *head)
+{
+	iort_iommu_rmr_get_resv_regions(iommu_fwnode, NULL, head);
+}
+EXPORT_SYMBOL_GPL(iort_get_rmr_sids);
+
+/**
+ * iort_put_rmr_sids - Free memory allocated for RMR reserved regions.
+ * @iommu_fwnode: fwnode associated with IOMMU
+ * @head: Resereved region list
+ */
+void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode,
+		       struct list_head *head)
+{
+	struct iommu_resv_region *entry, *next;
+
+	list_for_each_entry_safe(entry, next, head, list)
+		entry->free(NULL, entry);
+}
+EXPORT_SYMBOL_GPL(iort_put_rmr_sids);
+
 static void __init acpi_iort_register_irq(int hwirq, const char *name,
 					  int trigger,
 					  struct resource *res)
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index e5d2de9caf7f..b43be0987b19 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -33,6 +33,10 @@ struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
 					  enum irq_domain_bus_token bus_token);
 void acpi_configure_pmsi_domain(struct device *dev);
 int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
+void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode,
+		       struct list_head *head);
+void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode,
+		       struct list_head *head);
 /* IOMMU interface */
 int iort_dma_get_ranges(struct device *dev, u64 *size);
 int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
@@ -46,6 +50,10 @@ static inline struct irq_domain *iort_get_device_domain(
 	struct device *dev, u32 id, enum irq_domain_bus_token bus_token)
 { return NULL; }
 static inline void acpi_configure_pmsi_domain(struct device *dev) { }
+static inline
+void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode, struct list_head *head) { }
+static inline
+void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode, struct list_head *head) { }
 /* IOMMU interface */
 static inline int iort_dma_get_ranges(struct device *dev, u64 *size)
 { return -ENODEV; }
-- 
2.25.1

