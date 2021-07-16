Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8AC3CB480
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jul 2021 10:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237240AbhGPIi2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Jul 2021 04:38:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3422 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237055AbhGPIi2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jul 2021 04:38:28 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GR48x1PfNz6FDCj;
        Fri, 16 Jul 2021 16:26:57 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 10:35:32 +0200
Received: from A2006125610.china.huawei.com (10.47.80.222) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 09:35:26 +0100
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <steven.price@arm.com>, <Sami.Mujawar@arm.com>,
        <jon@solid-run.com>, <eric.auger@redhat.com>,
        <yangyicong@huawei.com>
Subject: [PATCH v6 5/9] iommu/arm-smmu-v3: Introduce strtab init helper
Date:   Fri, 16 Jul 2021 09:34:38 +0100
Message-ID: <20210716083442.1708-6-shameerali.kolothum.thodi@huawei.com>
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

Introduce a helper to check the sid range and to init the l2 strtab
entries(bypass). This will be useful when we have to initialize the
l2 strtab with bypass for RMR SIDs.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 28 +++++++++++----------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index dd20b01771c4..33f5556aefeb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2517,6 +2517,19 @@ static bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid)
 	return sid < limit;
 }
 
+static int arm_smmu_init_sid_strtab(struct arm_smmu_device *smmu, u32 sid)
+{
+	/* Check the SIDs are in range of the SMMU and our stream table */
+	if (!arm_smmu_sid_in_range(smmu, sid))
+		return -ERANGE;
+
+	/* Ensure l2 strtab is initialised */
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
+		return arm_smmu_init_l2_strtab(smmu, sid);
+
+	return 0;
+}
+
 static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 				  struct arm_smmu_master *master)
 {
@@ -2540,20 +2553,9 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		new_stream->id = sid;
 		new_stream->master = master;
 
-		/*
-		 * Check the SIDs are in range of the SMMU and our stream table
-		 */
-		if (!arm_smmu_sid_in_range(smmu, sid)) {
-			ret = -ERANGE;
+		ret = arm_smmu_init_sid_strtab(smmu, sid);
+		if (ret)
 			break;
-		}
-
-		/* Ensure l2 strtab is initialised */
-		if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
-			ret = arm_smmu_init_l2_strtab(smmu, sid);
-			if (ret)
-				break;
-		}
 
 		/* Insert into SID tree */
 		new_node = &(smmu->streams.rb_node);
-- 
2.17.1

