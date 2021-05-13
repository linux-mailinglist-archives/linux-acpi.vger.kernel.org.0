Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17A037F910
	for <lists+linux-acpi@lfdr.de>; Thu, 13 May 2021 15:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbhEMNs0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 May 2021 09:48:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2478 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbhEMNsQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 May 2021 09:48:16 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FgtDk5dkhzBvBf;
        Thu, 13 May 2021 21:44:22 +0800 (CST)
Received: from A2006125610.china.huawei.com (10.47.81.63) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 13 May 2021 21:46:54 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <steven.price@arm.com>, <Sami.Mujawar@arm.com>,
        <jon@solid-run.com>, <eric.auger@redhat.com>,
        <yangyicong@huawei.com>
Subject: [PATCH v4 6/8] iommu/arm-smmu-v3: Get associated RMR info and install bypass STE
Date:   Thu, 13 May 2021 14:45:48 +0100
Message-ID: <20210513134550.2117-7-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210513134550.2117-1-shameerali.kolothum.thodi@huawei.com>
References: <20210513134550.2117-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.81.63]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Check if there is any RMR info associated with the devices behind
the SMMUv3 and if any, install bypass STEs for them. This is to
keep any ongoing traffic associated with these devices alive
when we enable/reset SMMUv3 during probe().

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 33 +++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f9195b740f48..c2d2e65b9856 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3574,6 +3574,36 @@ static void __iomem *arm_smmu_ioremap(struct device *dev, resource_size_t start,
 	return devm_ioremap_resource(dev, &res);
 }
 
+static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
+{
+	struct list_head rmr_list;
+	struct iommu_rmr *e;
+	int ret;
+
+	INIT_LIST_HEAD(&rmr_list);
+	if (iommu_dma_get_rmrs(dev_fwnode(smmu->dev), &rmr_list))
+		return;
+
+	/*
+	 * Since, we don't have a mechanism to differentiate the RMR
+	 * SIDs that has an ongoing live stream, install bypass STEs
+	 * for all the reported ones. 
+	 */
+	list_for_each_entry(e, &rmr_list, list) {
+		__le64 *step;
+
+		ret = arm_smmu_init_sid_strtab(smmu, e->sid);
+		if (ret) {
+			dev_err(smmu->dev, "RMR bypass(0x%x) failed\n",
+				e->sid);
+			continue;
+		}
+
+		step = arm_smmu_get_step_for_sid(smmu, e->sid);
+		arm_smmu_write_strtab_ent(NULL, e->sid, step, true);
+	}
+}
+
 static int arm_smmu_device_probe(struct platform_device *pdev)
 {
 	int irq, ret;
@@ -3657,6 +3687,9 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	/* Record our private device structure */
 	platform_set_drvdata(pdev, smmu);
 
+	/* Check for RMRs and install bypass STEs if any */
+	arm_smmu_rmr_install_bypass_ste(smmu);
+
 	/* Reset the device */
 	ret = arm_smmu_device_reset(smmu, bypass);
 	if (ret)
-- 
2.17.1

