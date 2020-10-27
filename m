Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5DE29AA95
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Oct 2020 12:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1749912AbgJ0L2Y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Oct 2020 07:28:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:6397 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1749911AbgJ0L2V (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Oct 2020 07:28:21 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CL8b93CqPz6wlp;
        Tue, 27 Oct 2020 19:28:21 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.24.15) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 27 Oct 2020 19:28:10 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <devel@acpica.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <jonathan.cameron@huawei.com>
Subject: [RFC PATCH 4/4] iommu/dma: Reserve any RMR regions associated with a dev
Date:   Tue, 27 Oct 2020 11:26:46 +0000
Message-ID: <20201027112646.44680-5-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20201027112646.44680-1-shameerali.kolothum.thodi@huawei.com>
References: <20201027112646.44680-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.24.15]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Added support to get RMR regions associated with a dev
reserved so that there is a unity mapping for them in
SMMU.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/dma-iommu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 0cbcd3fc3e7e..31eec16f2af8 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -153,15 +153,19 @@ EXPORT_SYMBOL(iommu_put_dma_cookie);
  * @list: Reserved region list from iommu_get_resv_regions()
  *
  * IOMMU drivers can use this to implement their .get_resv_regions callback
- * for general non-IOMMU-specific reservations. Currently, this covers GICv3
- * ITS region reservation on ACPI based ARM platforms that may require HW MSI
- * reservation.
+ * for general non-IOMMU-specific reservations. Currently this covers,
+ *  - GICv3 ITS region reservation on ACPI based ARM platforms that may
+ *    require HW MSI reservation.
+ *  - ACPI IORT RMR memory range reservations that require a unity mapping
+ *    in the SMMU for a given endpoint device.
  */
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 {
 
-	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
+	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode)) {
 		iort_iommu_msi_get_resv_regions(dev, list);
+		iort_dev_rmr_get_resv_regions(dev, list);
+	}
 
 }
 EXPORT_SYMBOL(iommu_dma_get_resv_regions);
-- 
2.17.1

