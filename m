Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0446D3CB481
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jul 2021 10:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237801AbhGPIii (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Jul 2021 04:38:38 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3423 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237055AbhGPIih (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jul 2021 04:38:37 -0400
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GR42F05Bjz6D8n1;
        Fri, 16 Jul 2021 16:21:09 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 10:35:40 +0200
Received: from A2006125610.china.huawei.com (10.47.80.222) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 09:35:33 +0100
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <steven.price@arm.com>, <Sami.Mujawar@arm.com>,
        <jon@solid-run.com>, <eric.auger@redhat.com>,
        <yangyicong@huawei.com>
Subject: [PATCH v6 6/9] =?UTF-8?q?iommu/arm-smmu-v3:=20Refactor=C2=A0arm?= =?UTF-8?q?=5Fsmmu=5Finit=5Fbypass=5Fstes()=20to=20force=20bypass?=
Date:   Fri, 16 Jul 2021 09:34:39 +0100
Message-ID: <20210716083442.1708-7-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210716083442.1708-1-shameerali.kolothum.thodi@huawei.com>
References: <20210716083442.1708-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.80.222]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

By default, disable_bypass flag is set and any dev without
an iommu domain installs STE with CFG_ABORT during
arm_smmu_init_bypass_stes(). Introduce a "force" flag and
move the STE update logic to arm_smmu_init_bypass_stes()
so that we can force it to install CFG_BYPASS STE for specific
SIDs.

This will be useful in follow-up patch to install bypass
for IORT RMR SIDs.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 33f5556aefeb..34f84641dc6a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1356,12 +1356,21 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
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
@@ -1389,7 +1398,7 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 		return -ENOMEM;
 	}
 
-	arm_smmu_init_bypass_stes(desc->l2ptr, 1 << STRTAB_SPLIT);
+	arm_smmu_init_bypass_stes(desc->l2ptr, 1 << STRTAB_SPLIT, false);
 	arm_smmu_write_strtab_l1_desc(strtab, desc);
 	return 0;
 }
@@ -3041,7 +3050,7 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
 	reg |= FIELD_PREP(STRTAB_BASE_CFG_LOG2SIZE, smmu->sid_bits);
 	cfg->strtab_base_cfg = reg;
 
-	arm_smmu_init_bypass_stes(strtab, cfg->num_l1_ents);
+	arm_smmu_init_bypass_stes(strtab, cfg->num_l1_ents, false);
 	return 0;
 }
 
-- 
2.17.1

