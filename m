Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE4E365557
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Apr 2021 11:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhDTJ3T (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 20 Apr 2021 05:29:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16485 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhDTJ3S (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Apr 2021 05:29:18 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FPdbj2CmDzrf4J;
        Tue, 20 Apr 2021 17:26:25 +0800 (CST)
Received: from A2006125610.china.huawei.com (10.47.83.26) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Tue, 20 Apr 2021 17:28:38 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <steven.price@arm.com>, <Sami.Mujawar@arm.com>,
        <jon@solid-run.com>, <eric.auger@redhat.com>
Subject: [PATCH v3 06/10] =?UTF-8?q?iommu/arm-smmu-v3:=20Add=20bypass=20fl?= =?UTF-8?q?ag=20to=C2=A0arm=5Fsmmu=5Fwrite=5Fstrtab=5Fent()?=
Date:   Tue, 20 Apr 2021 10:27:47 +0200
Message-ID: <20210420082751.1829-7-shameerali.kolothum.thodi@huawei.com>
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

By default, disable_bypass is set and any dev without an iommu domain
installs STE with CFG_ABORT during arm_smmu_init_bypass_stes(). Introduce
a "bypass" flag to arm_smmu_write_strtab_ent() so that we can force it to
install CFG_BYPASS STE for specific SIDs. This will be useful for RMR
related SIDs.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 29da3b681621..190285812182 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1176,7 +1176,7 @@ static void arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu, u32 sid)
 }
 
 static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
-				      __le64 *dst)
+				      __le64 *dst, bool bypass)
 {
 	/*
 	 * This is hideously complicated, but we only really care about
@@ -1247,7 +1247,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 
 	/* Bypass/fault */
 	if (!smmu_domain || !(s1_cfg || s2_cfg)) {
-		if (!smmu_domain && disable_bypass)
+		if (!smmu_domain && disable_bypass && !bypass)
 			val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_ABORT);
 		else
 			val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_BYPASS);
@@ -1322,7 +1322,7 @@ static void arm_smmu_init_bypass_stes(__le64 *strtab, unsigned int nent)
 	unsigned int i;
 
 	for (i = 0; i < nent; ++i) {
-		arm_smmu_write_strtab_ent(NULL, -1, strtab);
+		arm_smmu_write_strtab_ent(NULL, -1, strtab, false);
 		strtab += STRTAB_STE_DWORDS;
 	}
 }
@@ -2076,7 +2076,7 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
 		if (j < i)
 			continue;
 
-		arm_smmu_write_strtab_ent(master, sid, step);
+		arm_smmu_write_strtab_ent(master, sid, step, false);
 	}
 }
 
-- 
2.17.1

