Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5299938E4C7
	for <lists+linux-acpi@lfdr.de>; Mon, 24 May 2021 13:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhEXLF3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 May 2021 07:05:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5533 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbhEXLF2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 May 2021 07:05:28 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FpZ5K1rWszkYvj;
        Mon, 24 May 2021 19:01:09 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:03:58 +0800
Received: from A2006125610.china.huawei.com (10.47.80.77) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 12:03:49 +0100
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <steven.price@arm.com>, <Sami.Mujawar@arm.com>,
        <jon@solid-run.com>, <eric.auger@redhat.com>,
        <yangyicong@huawei.com>
Subject: [PATCH v5 5/8] =?UTF-8?q?iommu/arm-smmu-v3:=20Add=20bypass=20flag?= =?UTF-8?q?=20to=C2=A0arm=5Fsmmu=5Fwrite=5Fstrtab=5Fent()?=
Date:   Mon, 24 May 2021 12:02:19 +0100
Message-ID: <20210524110222.2212-6-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.80.77]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

By default, disable_bypass is set and any dev without an iommu domain
installs STE with CFG_ABORT during arm_smmu_init_bypass_stes(). Introduce
a "bypass" flag to arm_smmu_write_strtab_ent() so that we can force it to
install CFG_BYPASS STE for specific SIDs. This will be useful in follow
up patch to install bypass for IORT RMR SIDs.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 754bad6092c1..f9195b740f48 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1174,7 +1174,7 @@ static void arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu, u32 sid)
 }
 
 static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
-				      __le64 *dst)
+				      __le64 *dst, bool bypass)
 {
 	/*
 	 * This is hideously complicated, but we only really care about
@@ -1245,7 +1245,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 
 	/* Bypass/fault */
 	if (!smmu_domain || !(s1_cfg || s2_cfg)) {
-		if (!smmu_domain && disable_bypass)
+		if (!smmu_domain && disable_bypass && !bypass)
 			val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_ABORT);
 		else
 			val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_BYPASS);
@@ -1320,7 +1320,7 @@ static void arm_smmu_init_bypass_stes(__le64 *strtab, unsigned int nent)
 	unsigned int i;
 
 	for (i = 0; i < nent; ++i) {
-		arm_smmu_write_strtab_ent(NULL, -1, strtab);
+		arm_smmu_write_strtab_ent(NULL, -1, strtab, false);
 		strtab += STRTAB_STE_DWORDS;
 	}
 }
@@ -2097,7 +2097,7 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
 		if (j < i)
 			continue;
 
-		arm_smmu_write_strtab_ent(master, sid, step);
+		arm_smmu_write_strtab_ent(master, sid, step, false);
 	}
 }
 
-- 
2.17.1

