Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016A92B9250
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Nov 2020 13:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgKSMNV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Nov 2020 07:13:21 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8373 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbgKSMNV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Nov 2020 07:13:21 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CcJV528Nrz70BV;
        Thu, 19 Nov 2020 20:13:01 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.210.168.73) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 19 Nov 2020 20:13:09 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <devel@acpica.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <jonathan.cameron@huawei.com>, <steven.price@arm.com>,
        <Sami.Mujawar@arm.com>
Subject: [RFC PATCH v2 8/8] =?UTF-8?q?iommu/arm-smmu-v3:=20Reserve=20any?= =?UTF-8?q?=20RMR=20regions=20associated=20with=20a=C2=A0dev?=
Date:   Thu, 19 Nov 2020 12:11:50 +0000
Message-ID: <20201119121150.3316-9-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
References: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.210.168.73]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Get RMR regions associated with a dev reserved so that there is
a unity mapping for them in SMMU.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 38 +++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 97df1df001c9..174a9bcfd627 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2492,6 +2492,43 @@ static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	return iommu_fwspec_add_ids(dev, args->args, 1);
 }
 
+static bool arm_smmu_dev_has_rmr(struct arm_smmu_master *master,
+				 struct iommu_rmr *e)
+{
+	int i, j;
+
+	for (i = 0; i < master->num_sids; i++) {
+		for (j = 0; j < e->num_ids; j++) {
+			if (e->ids[j] == master->sids[i])
+				return true;
+		}
+	}
+
+	return false;
+}
+
+static void arm_smmu_rmr_get_resv_regions(struct device *dev,
+					  struct list_head *head)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_device *smmu = master->smmu;
+	struct iommu_rmr *rmr;
+
+	list_for_each_entry(rmr, &smmu->rmr_list, list) {
+		struct iommu_resv_region *region;
+		int prot = IOMMU_READ | IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
+
+		if (!arm_smmu_dev_has_rmr(master, rmr))
+			continue;
+		region = iommu_alloc_resv_region(rmr->base_address,
+						 rmr->length, prot,
+						 IOMMU_RESV_DIRECT);
+		if (!region)
+			return;
+
+		list_add_tail(&region->list, head);
+	}
+}
 static void arm_smmu_get_resv_regions(struct device *dev,
 				      struct list_head *head)
 {
@@ -2506,6 +2543,7 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 	list_add_tail(&region->list, head);
 
 	iommu_dma_get_resv_regions(dev, head);
+	arm_smmu_rmr_get_resv_regions(dev, head);
 }
 
 static bool arm_smmu_dev_has_feature(struct device *dev,
-- 
2.17.1

