Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349AB508DB7
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Apr 2022 18:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355924AbiDTQxT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Apr 2022 12:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380775AbiDTQxS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Apr 2022 12:53:18 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAC32611E
        for <linux-acpi@vger.kernel.org>; Wed, 20 Apr 2022 09:50:31 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kk65N27j6z67NKJ;
        Thu, 21 Apr 2022 00:46:48 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 20 Apr 2022 18:50:29 +0200
Received: from A2006125610.china.huawei.com (10.47.81.194) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 17:50:21 +0100
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>, <will@kernel.org>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <steven.price@arm.com>, <Sami.Mujawar@arm.com>,
        <jon@solid-run.com>, <eric.auger@redhat.com>,
        <laurentiu.tudor@nxp.com>, <hch@infradead.org>
Subject: [PATCH v10 7/9] iommu/arm-smmu-v3: Refactor arm_smmu_init_bypass_stes() to force bypass
Date:   Wed, 20 Apr 2022 17:48:34 +0100
Message-ID: <20220420164836.1181-8-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20220420164836.1181-1-shameerali.kolothum.thodi@huawei.com>
References: <20220420164836.1181-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.81.194]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

By default, disable_bypass flag is set and any dev without
an iommu domain installs STE with CFG_ABORT during
arm_smmu_init_bypass_stes(). Introduce a "force" flag and
move the STE update logic to arm_smmu_init_bypass_stes()
so that we can force it to install CFG_BYPASS STE for specific
SIDs.

This will be useful in a follow-up patch to install bypass
for IORT RMR SIDs.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index df326d8f02c6..a939d9e0f747 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1380,12 +1380,21 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		arm_smmu_cmdq_issue_cmd(smmu, &prefetch_cmd);
 }
 
-static void arm_smmu_init_bypass_stes(__le64 *strtab, unsigned int nent)
+static void arm_smmu_init_bypass_stes(__le64 *strtab, unsigned int nent, bool force)
 {
 	unsigned int i;
+	u64 val = STRTAB_STE_0_V;
+
+	if (disable_bypass && !force)
+		val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_ABORT);
+	else
+		val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_BYPASS);
 
 	for (i = 0; i < nent; ++i) {
-		arm_smmu_write_strtab_ent(NULL, -1, strtab);
+		strtab[0] = cpu_to_le64(val);
+		strtab[1] = cpu_to_le64(FIELD_PREP(STRTAB_STE_1_SHCFG,
+						   STRTAB_STE_1_SHCFG_INCOMING));
+		strtab[2] = 0;
 		strtab += STRTAB_STE_DWORDS;
 	}
 }
@@ -1413,7 +1422,7 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 		return -ENOMEM;
 	}
 
-	arm_smmu_init_bypass_stes(desc->l2ptr, 1 << STRTAB_SPLIT);
+	arm_smmu_init_bypass_stes(desc->l2ptr, 1 << STRTAB_SPLIT, false);
 	arm_smmu_write_strtab_l1_desc(strtab, desc);
 	return 0;
 }
@@ -3051,7 +3060,7 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
 	reg |= FIELD_PREP(STRTAB_BASE_CFG_LOG2SIZE, smmu->sid_bits);
 	cfg->strtab_base_cfg = reg;
 
-	arm_smmu_init_bypass_stes(strtab, cfg->num_l1_ents);
+	arm_smmu_init_bypass_stes(strtab, cfg->num_l1_ents, false);
 	return 0;
 }
 
-- 
2.17.1

