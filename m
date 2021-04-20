Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7FF365562
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Apr 2021 11:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhDTJ3r (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 20 Apr 2021 05:29:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16143 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhDTJ3q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Apr 2021 05:29:46 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FPdbS6mRpzpZTX;
        Tue, 20 Apr 2021 17:26:12 +0800 (CST)
Received: from A2006125610.china.huawei.com (10.47.83.26) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Tue, 20 Apr 2021 17:29:03 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <steven.price@arm.com>, <Sami.Mujawar@arm.com>,
        <jon@solid-run.com>, <eric.auger@redhat.com>
Subject: [PATCH v3 10/10] iommu/arm-smmu: Reserve any RMR regions associated with a dev
Date:   Tue, 20 Apr 2021 10:27:51 +0200
Message-ID: <20210420082751.1829-11-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210420082751.1829-1-shameerali.kolothum.thodi@huawei.com>
References: <20210420082751.1829-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.83.26]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Jon Nettleton <jon@solid-run.com>

Get RMR regions associated with a dev reserved so that there is
a unity mapping for them in SMMU.

Signed-off-by: Jon Nettleton <jon@solid-run.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 33 +++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 4d2f91626d87..8cbe8b98e8f0 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1591,6 +1591,38 @@ static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	return iommu_fwspec_add_ids(dev, &fwid, 1);
 }
 
+static bool arm_smmu_dev_has_rmr(struct arm_smmu_master_cfg *cfg,
+				 struct iommu_fwspec *fwspec,
+				 struct iommu_rmr *e)
+{
+	struct arm_smmu_device *smmu = cfg->smmu;
+	struct arm_smmu_smr *smrs = smmu->smrs;
+	int i, idx;
+
+	for_each_cfg_sme(cfg, fwspec, i, idx) {
+		if (e->sid == smrs[idx].id)
+			return true;
+	}
+
+	return false;
+}
+
+static void arm_smmu_rmr_get_resv_regions(struct device *dev,
+					  struct list_head *head)
+{
+	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct arm_smmu_device *smmu = cfg->smmu;
+	struct iommu_rmr *rmr;
+
+	list_for_each_entry(rmr, &smmu->rmr_list, list) {
+		if (!arm_smmu_dev_has_rmr(cfg, fwspec, rmr))
+			continue;
+
+		iommu_dma_get_rmr_resv_regions(dev, rmr, head);
+	}
+}
+
 static void arm_smmu_get_resv_regions(struct device *dev,
 				      struct list_head *head)
 {
@@ -1605,6 +1637,7 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 	list_add_tail(&region->list, head);
 
 	iommu_dma_get_resv_regions(dev, head);
+	arm_smmu_rmr_get_resv_regions(dev, head);
 }
 
 static int arm_smmu_def_domain_type(struct device *dev)
-- 
2.17.1

