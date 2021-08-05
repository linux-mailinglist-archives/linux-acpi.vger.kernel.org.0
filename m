Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1903E0FF0
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Aug 2021 10:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbhHEIKO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Aug 2021 04:10:14 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3593 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239048AbhHEIKO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Aug 2021 04:10:14 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GgLqp4z5jz6G9VM;
        Thu,  5 Aug 2021 16:09:42 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 10:09:58 +0200
Received: from A2006125610.china.huawei.com (10.47.91.4) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 09:09:51 +0100
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>, <will@kernel.org>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <steven.price@arm.com>, <Sami.Mujawar@arm.com>,
        <jon@solid-run.com>, <eric.auger@redhat.com>,
        <yangyicong@huawei.com>
Subject: [PATCH v7 9/9] iommu/dma: Reserve any RMR regions associated with a dev
Date:   Thu, 5 Aug 2021 09:07:24 +0100
Message-ID: <20210805080724.480-10-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.91.4]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Get ACPI IORT RMR regions associated with a dev reserved
so that there is a unity mapping for them in SMMU.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/dma-iommu.c | 56 +++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 1b6e27475279..c1ae0c3d4b33 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -207,22 +207,68 @@ void iommu_dma_put_rmrs(struct fwnode_handle *iommu_fwnode,
 }
 EXPORT_SYMBOL(iommu_dma_put_rmrs);
 
+static bool iommu_dma_dev_has_rmr(struct iommu_fwspec *fwspec,
+				  struct iommu_resv_region *e)
+{
+	int i;
+
+	for (i = 0; i < fwspec->num_ids; i++) {
+		if (e->fw_data.rmr.sid == fwspec->ids[i])
+			return true;
+	}
+
+	return false;
+}
+
+static void iommu_dma_get_rmr_resv_regions(struct device *dev,
+					   struct list_head *list)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct list_head rmr_list;
+	struct iommu_resv_region *rmr, *tmp;
+
+	INIT_LIST_HEAD(&rmr_list);
+	if (iommu_dma_get_rmrs(fwspec->iommu_fwnode, &rmr_list))
+		return;
+
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+		struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
+
+		if (!host->preserve_config)
+			return;
+	}
+
+	list_for_each_entry_safe(rmr, tmp, &rmr_list, list) {
+		if (!iommu_dma_dev_has_rmr(fwspec, rmr))
+			continue;
+
+		/* Remove from iommu RMR list and add to dev resv_regions */
+		list_del_init(&rmr->list);
+		list_add_tail(&rmr->list, list);
+	}
+
+	iommu_dma_put_rmrs(fwspec->iommu_fwnode, &rmr_list);
+}
+
 /**
  * iommu_dma_get_resv_regions - Reserved region driver helper
  * @dev: Device from iommu_get_resv_regions()
  * @list: Reserved region list from iommu_get_resv_regions()
  *
  * IOMMU drivers can use this to implement their .get_resv_regions callback
- * for general non-IOMMU-specific reservations. Currently, this covers GICv3
- * ITS region reservation on ACPI based ARM platforms that may require HW MSI
- * reservation.
+ * for general non-IOMMU-specific reservations. Currently this covers,
+ *  -GICv3 ITS region reservation on ACPI based ARM platforms that may
+ *   require HW MSI reservation.
+ *  -Any ACPI IORT RMR memory range reservations (IORT spec rev E.b)
  */
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 {
 
-	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
+	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode)) {
 		iort_iommu_msi_get_resv_regions(dev, list);
-
+		iommu_dma_get_rmr_resv_regions(dev, list);
+	}
 }
 EXPORT_SYMBOL(iommu_dma_get_resv_regions);
 
-- 
2.17.1

