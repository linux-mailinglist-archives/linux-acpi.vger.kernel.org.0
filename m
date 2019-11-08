Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4D6F4F84
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2019 16:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfKHP04 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Nov 2019 10:26:56 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38411 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKHP0z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Nov 2019 10:26:55 -0500
Received: by mail-wm1-f67.google.com with SMTP id z19so6624044wmk.3
        for <linux-acpi@vger.kernel.org>; Fri, 08 Nov 2019 07:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mnbYxHwwKDCCUndGgMW6LrNDIvr5LwgLaOHQExbW9co=;
        b=vt/ucZmgN0eSNi3NEFrhHunIf8tyXq2gAai53SFY8mpYU92IidJLVOzDyQcqjyhBSr
         T8V4hxDutApsmCo8XT8vx9ZyQFWiamm0n6iIZ6FFeHocN8Ilpv/vzaCesmkkAXgGkqp6
         Vv2LFDzC6AYGjeW0gkZmEjdOetkTjsCxun2mwuwI0nmbuKtRd8RcHpIsYdLXB0gSL+9r
         7hn0cuTBF5GHBLoTjJ8AKFErIUJQ81Cx/c+1Ke/nQnNGY8yjrhGxGvT7Hv8IlzeQ2+co
         xdCufQTFaCf7u30IWO/faFmuYxPTNPO9uhAlm1Xm/j5QVooBAWITKWn/y10ru9QdDfzP
         a70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mnbYxHwwKDCCUndGgMW6LrNDIvr5LwgLaOHQExbW9co=;
        b=mZoa9le1HLi9H5AFzU5X2Xam87iY4DfRZJLqh3SXXRK6GJ5deuhUejNSJS7uPd7GTB
         LylhFIoDiZok+CylTrw/Puw6SRsnyVGl5S2//fH9YwWlDtBdW1gHPVNu4HVDpnU4jr6y
         smKb9sO6w1IPnSazZtz4/bysyee1ygcpIJsMn/yCSSDv5/dr2e5FLg0gTy5wonGgNISh
         zmizW6MEQYqv9uJbzulR8YuZbGuT07/Se18aZWne+87hCQ50RV+3GqFp5IenK5p5J6S7
         86reQvG+hBhj7AQZS97TiSGOIypkymkAeWF/moJz5dQKeIrmOwnCzCP6QkzTbjPyFHFR
         mVxQ==
X-Gm-Message-State: APjAAAUiHIXn9rlmqsLVS6AwStjB8RtNGlgfKrrbYMFnGSIDpUqDPTxc
        787tYYr4KiXnInhwllRAvBS6Xw==
X-Google-Smtp-Source: APXvYqy+bosXn9E/2BngGdRAG7TJf93oTjX1Hlh96tiGRrvYJauDofVa8+d0UIoSPSzm1vkNaKSd6g==
X-Received: by 2002:a7b:c747:: with SMTP id w7mr9236169wmk.62.1573226813391;
        Fri, 08 Nov 2019 07:26:53 -0800 (PST)
Received: from localhost.localdomain ([85.195.192.192])
        by smtp.gmail.com with ESMTPSA id w18sm6579232wrp.31.2019.11.08.07.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 07:26:52 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        will@kernel.org, robin.murphy@arm.com, zhangfei.gao@linaro.org,
        eric.auger@redhat.com, jonathan.cameron@huawei.com
Subject: [PATCH v2 5/8] iommu/arm-smmu-v3: Add support for Substream IDs
Date:   Fri,  8 Nov 2019 16:25:05 +0100
Message-Id: <20191108152508.4039168-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108152508.4039168-1-jean-philippe@linaro.org>
References: <20191108152508.4039168-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

At the moment, the SMMUv3 driver implements only one stage-1 or stage-2
page directory per device. However SMMUv3 allows more than one address
space for some devices, by providing multiple stage-1 page directories. In
addition to the Stream ID (SID), that identifies a device, we can now have
Substream IDs (SSID) identifying an address space. In PCIe, SID is called
Requester ID (RID) and SSID is called Process Address-Space ID (PASID).

Prepare the driver for SSID support, by adding context descriptor tables
in STEs (previously a single static context descriptor). A complete
stage-1 walk is now performed like this by the SMMU:

      Stream tables          Ctx. tables          Page tables
        +--------+   ,------->+-------+   ,------->+-------+
        :        :   |        :       :   |        :       :
        +--------+   |        +-------+   |        +-------+
   SID->|  STE   |---'  SSID->|  CD   |---'  IOVA->|  PTE  |--> IPA
        +--------+            +-------+            +-------+
        :        :            :       :            :       :
        +--------+            +-------+            +-------+

Implement a single level of context descriptor table for now, but as with
stream and page tables, an SSID can be split to index multiple levels of
tables.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 132 ++++++++++++++++++++++++++++++------
 1 file changed, 111 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 122bed0168a3..df7d45503c65 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -227,6 +227,11 @@
 #define STRTAB_STE_0_S1CTXPTR_MASK	GENMASK_ULL(51, 6)
 #define STRTAB_STE_0_S1CDMAX		GENMASK_ULL(63, 59)
 
+#define STRTAB_STE_1_S1DSS		GENMASK_ULL(1, 0)
+#define STRTAB_STE_1_S1DSS_TERMINATE	0x0
+#define STRTAB_STE_1_S1DSS_BYPASS	0x1
+#define STRTAB_STE_1_S1DSS_SSID0	0x2
+
 #define STRTAB_STE_1_S1C_CACHE_NC	0UL
 #define STRTAB_STE_1_S1C_CACHE_WBRA	1UL
 #define STRTAB_STE_1_S1C_CACHE_WT	2UL
@@ -329,6 +334,7 @@
 #define CMDQ_PREFETCH_1_SIZE		GENMASK_ULL(4, 0)
 #define CMDQ_PREFETCH_1_ADDR_MASK	GENMASK_ULL(63, 12)
 
+#define CMDQ_CFGI_0_SSID		GENMASK_ULL(31, 12)
 #define CMDQ_CFGI_0_SID			GENMASK_ULL(63, 32)
 #define CMDQ_CFGI_1_LEAF		(1UL << 0)
 #define CMDQ_CFGI_1_RANGE		GENMASK_ULL(4, 0)
@@ -446,8 +452,11 @@ struct arm_smmu_cmdq_ent {
 
 		#define CMDQ_OP_CFGI_STE	0x3
 		#define CMDQ_OP_CFGI_ALL	0x4
+		#define CMDQ_OP_CFGI_CD		0x5
+		#define CMDQ_OP_CFGI_CD_ALL	0x6
 		struct {
 			u32			sid;
+			u32			ssid;
 			union {
 				bool		leaf;
 				u8		span;
@@ -566,6 +575,7 @@ struct arm_smmu_cd_table {
 };
 
 struct arm_smmu_s1_cfg {
+	u8				s1fmt;
 	u8				s1cdmax;
 	struct arm_smmu_cd_table	table;
 	struct arm_smmu_ctx_desc	cd;
@@ -860,10 +870,16 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 		cmd[1] |= FIELD_PREP(CMDQ_PREFETCH_1_SIZE, ent->prefetch.size);
 		cmd[1] |= ent->prefetch.addr & CMDQ_PREFETCH_1_ADDR_MASK;
 		break;
+	case CMDQ_OP_CFGI_CD:
+		cmd[0] |= FIELD_PREP(CMDQ_CFGI_0_SSID, ent->cfgi.ssid);
+		/* Fallthrough */
 	case CMDQ_OP_CFGI_STE:
 		cmd[0] |= FIELD_PREP(CMDQ_CFGI_0_SID, ent->cfgi.sid);
 		cmd[1] |= FIELD_PREP(CMDQ_CFGI_1_LEAF, ent->cfgi.leaf);
 		break;
+	case CMDQ_OP_CFGI_CD_ALL:
+		cmd[0] |= FIELD_PREP(CMDQ_CFGI_0_SID, ent->cfgi.sid);
+		break;
 	case CMDQ_OP_CFGI_ALL:
 		/* Cover the entire SID range */
 		cmd[1] |= FIELD_PREP(CMDQ_CFGI_1_RANGE, 31);
@@ -1456,6 +1472,33 @@ static int arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
 }
 
 /* Context descriptor manipulation functions */
+static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
+			     int ssid, bool leaf)
+{
+	size_t i;
+	unsigned long flags;
+	struct arm_smmu_master *master;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_cmdq_ent cmd = {
+		.opcode	= CMDQ_OP_CFGI_CD,
+		.cfgi	= {
+			.ssid	= ssid,
+			.leaf	= leaf,
+		},
+	};
+
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+		for (i = 0; i < master->num_sids; i++) {
+			cmd.cfgi.sid = master->sids[i];
+			arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+		}
+	}
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+
+	arm_smmu_cmdq_issue_sync(smmu);
+}
+
 static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
 					struct arm_smmu_cd_table *table,
 					size_t num_entries)
@@ -1481,6 +1524,11 @@ static void arm_smmu_free_cd_leaf_table(struct arm_smmu_device *smmu,
 	dmam_free_coherent(smmu->dev, size, table->ptr, table->ptr_dma);
 }
 
+static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_s1_cfg *cfg, u32 ssid)
+{
+	return cfg->table.ptr + ssid * CTXDESC_CD_DWORDS;
+}
+
 static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
 {
 	u64 val = 0;
@@ -1498,34 +1546,68 @@ static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
 	return val;
 }
 
-static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
-				    struct arm_smmu_s1_cfg *cfg)
+static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
+				   int ssid, struct arm_smmu_ctx_desc *cd)
 {
 	u64 val;
-	__le64 *cdptr = cfg->table.ptr;
+	bool cd_live;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	__le64 *cdptr = arm_smmu_get_cd_ptr(&smmu_domain->s1_cfg, ssid);
 
 	/*
-	 * We don't need to issue any invalidation here, as we'll invalidate
-	 * the STE when installing the new entry anyway.
+	 * This function handles the following cases:
+	 *
+	 * (1) Install primary CD, for normal DMA traffic (SSID = 0).
+	 * (2) Install a secondary CD, for SID+SSID traffic.
+	 * (3) Update ASID of a CD. Atomically write the first 64 bits of the
+	 *     CD, then invalidate the old entry and mappings.
+	 * (4) Remove a secondary CD.
 	 */
-	val = arm_smmu_cpu_tcr_to_cd(cfg->cd.tcr) |
-#ifdef __BIG_ENDIAN
-	      CTXDESC_CD_0_ENDI |
-#endif
-	      CTXDESC_CD_0_R | CTXDESC_CD_0_A | CTXDESC_CD_0_ASET |
-	      CTXDESC_CD_0_AA64 | FIELD_PREP(CTXDESC_CD_0_ASID, cfg->cd.asid) |
-	      CTXDESC_CD_0_V;
 
-	/* STALL_MODEL==0b10 && CD.S==0 is ILLEGAL */
-	if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
-		val |= CTXDESC_CD_0_S;
+	if (!cdptr)
+		return -ENOMEM;
 
-	cdptr[0] = cpu_to_le64(val);
+	val = le64_to_cpu(cdptr[0]);
+	cd_live = !!(val & CTXDESC_CD_0_V);
 
-	val = cfg->cd.ttbr & CTXDESC_CD_1_TTB0_MASK;
-	cdptr[1] = cpu_to_le64(val);
+	if (!cd) { /* (4) */
+		val = 0;
+	} else if (cd_live) { /* (3) */
+		val &= ~CTXDESC_CD_0_ASID;
+		val |= FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid);
+		/*
+		 * Until CD+TLB invalidation, both ASIDs may be used for tagging
+		 * this substream's traffic
+		 */
+	} else { /* (1) and (2) */
+		cdptr[1] = cpu_to_le64(cd->ttbr & CTXDESC_CD_1_TTB0_MASK);
+		cdptr[2] = 0;
+		cdptr[3] = cpu_to_le64(cd->mair);
 
-	cdptr[3] = cpu_to_le64(cfg->cd.mair);
+		/*
+		 * STE is live, and the SMMU might fetch this CD at any
+		 * time. Ensure that it observes the rest of the CD before we
+		 * enable it.
+		 */
+		arm_smmu_sync_cd(smmu_domain, ssid, true);
+
+		val = arm_smmu_cpu_tcr_to_cd(cd->tcr) |
+#ifdef __BIG_ENDIAN
+			CTXDESC_CD_0_ENDI |
+#endif
+			CTXDESC_CD_0_R | CTXDESC_CD_0_A | CTXDESC_CD_0_ASET |
+			CTXDESC_CD_0_AA64 |
+			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
+			CTXDESC_CD_0_V;
+
+		/* STALL_MODEL==0b10 && CD.S==0 is ILLEGAL */
+		if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
+			val |= CTXDESC_CD_0_S;
+	}
+
+	WRITE_ONCE(cdptr[0], cpu_to_le64(val));
+	arm_smmu_sync_cd(smmu_domain, ssid, true);
+	return 0;
 }
 
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
@@ -1533,6 +1615,7 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 
+	cfg->s1fmt = STRTAB_STE_0_S1FMT_LINEAR;
 	return arm_smmu_alloc_cd_leaf_table(smmu, &cfg->table,
 					    1 << cfg->s1cdmax);
 }
@@ -1664,6 +1747,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	if (s1_cfg) {
 		BUG_ON(ste_live);
 		dst[1] = cpu_to_le64(
+			 FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0) |
 			 FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
 			 FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
 			 FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH) |
@@ -1674,7 +1758,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
 
 		val |= (s1_cfg->table.ptr_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
-			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS);
+			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
+			FIELD_PREP(STRTAB_STE_0_S1CDMAX, s1_cfg->s1cdmax) |
+			FIELD_PREP(STRTAB_STE_0_S1FMT, s1_cfg->s1fmt);
 	}
 
 	if (s2_cfg) {
@@ -2224,10 +2310,14 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	cfg->cd.tcr	= pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 	cfg->cd.mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair[0];
 
-	arm_smmu_write_ctx_desc(smmu, cfg);
+	ret = arm_smmu_write_ctx_desc(smmu_domain, 0, &cfg->cd);
+	if (ret)
+		goto out_free_tables;
 
 	return 0;
 
+out_free_tables:
+	arm_smmu_free_cd_tables(smmu_domain);
 out_free_asid:
 	arm_smmu_bitmap_free(smmu->asid_map, asid);
 	return ret;
-- 
2.23.0

