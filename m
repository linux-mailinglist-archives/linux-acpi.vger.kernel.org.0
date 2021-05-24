Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F2738E4CB
	for <lists+linux-acpi@lfdr.de>; Mon, 24 May 2021 13:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbhEXLFt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 May 2021 07:05:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3976 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbhEXLFt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 May 2021 07:05:49 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FpZ6H2Ft2zmZw3;
        Mon, 24 May 2021 19:01:59 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:04:18 +0800
Received: from A2006125610.china.huawei.com (10.47.80.77) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 12:04:08 +0100
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <steven.price@arm.com>, <Sami.Mujawar@arm.com>,
        <jon@solid-run.com>, <eric.auger@redhat.com>,
        <yangyicong@huawei.com>
Subject: [PATCH v5 7/8] iommu/arm-smmu: Get associated RMR info and install bypass SMR
Date:   Mon, 24 May 2021 12:02:21 +0100
Message-ID: <20210524110222.2212-8-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.80.77]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Jon Nettleton <jon@solid-run.com>

Check if there is any RMR info associated with the devices behind
the SMMU and if any, install bypass SMRs for them. This is to
keep any ongoing traffic associated with these devices alive
when we enable/reset SMMU during probe().

Signed-off-by: Jon Nettleton <jon@solid-run.com>
Signed-off-by: Steven Price <steven.price@arm.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 65 +++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 6f72c4d208ca..56db3d3238fc 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -2042,6 +2042,67 @@ err_reset_platform_ops: __maybe_unused;
 	return err;
 }
 
+static void arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
+{
+	struct list_head rmr_list;
+	struct iommu_resv_region *e;
+	int i, cnt = 0;
+	u32 smr;
+	u32 reg;
+
+	INIT_LIST_HEAD(&rmr_list);
+	if (iommu_dma_get_rmrs(dev_fwnode(smmu->dev), &rmr_list))
+		return;
+
+	reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sCR0);
+
+	if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
+		/*
+		 * SMMU is already enabled and disallowing bypass, so preserve
+		 * the existing SMRs
+		 */
+		for (i = 0; i < smmu->num_mapping_groups; i++) {
+			smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
+			if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
+				continue;
+			smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
+			smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
+			smmu->smrs[i].valid = true;
+		}
+	}
+
+	list_for_each_entry(e, &rmr_list, list) {
+		u32 sid = e->fw_data.rmr.sid;
+
+		i = arm_smmu_find_sme(smmu, sid, ~0);
+		if (i < 0)
+			continue;
+		if (smmu->s2crs[i].count == 0) {
+			smmu->smrs[i].id = sid;
+			smmu->smrs[i].mask = ~0;
+			smmu->smrs[i].valid = true;
+		}
+		smmu->s2crs[i].count++;
+		smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
+		smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
+		smmu->s2crs[i].cbndx = 0xff;
+
+		cnt++;
+	}
+
+	if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
+		/* Remove the valid bit for unused SMRs */
+		for (i = 0; i < smmu->num_mapping_groups; i++) {
+			if (smmu->s2crs[i].count == 0)
+				smmu->smrs[i].valid = false;
+		}
+	}
+
+	dev_notice(smmu->dev, "\tpreserved %d boot mapping%s\n", cnt,
+		   cnt == 1 ? "" : "s");
+	iommu_dma_put_rmrs(dev_fwnode(smmu->dev), &rmr_list);
+}
+
 static int arm_smmu_device_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -2168,6 +2229,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, smmu);
+
+	/* Check for RMRs and install bypass SMRs if any */
+	arm_smmu_rmr_install_bypass_smr(smmu);
+
 	arm_smmu_device_reset(smmu);
 	arm_smmu_test_smr_masks(smmu);
 
-- 
2.17.1

