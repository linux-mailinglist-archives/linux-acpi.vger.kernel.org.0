Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC265F4F8A
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2019 16:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKHP06 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Nov 2019 10:26:58 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54243 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfKHP06 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Nov 2019 10:26:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id x4so6586684wmi.3
        for <linux-acpi@vger.kernel.org>; Fri, 08 Nov 2019 07:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dGJYFkJIv52PSafGiVwNPcKfln8k/8BPJx1rxkdK2ds=;
        b=pjkXYKXPb3SLkO7ZaYHacMMb2aAKLwC2PIg9nJYoHIgB8AK7R/rSwGBI4n3lNDsEC6
         LOvAr+IYjgfbfY/yuH9YLHIckOoAzwk1HAzlzFO+a5BKhwxNkwaBYk31MSISiU2nTNEc
         YGWD54Iz6n126lR4eHiap7OVINZTztNhKXEIO+ShKRsCV3AIOsIisi2h3nqevJ8a8DK1
         esua2PGerZRywwDMBSIEtuhLI4IWu4UVTQvE9PtCYy7VKbT0+ewy4WO4cl2rLahrQQmy
         j0zIAr/fp0TvFwOQMAWUL9nl6Z/2EuV2APCYJiH+54BXuuhfLl4ocNGnbUz2W4lo46L9
         5geg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dGJYFkJIv52PSafGiVwNPcKfln8k/8BPJx1rxkdK2ds=;
        b=Xp6SWZzFGm2Wi8OQwX1smfufkDlXC+0+PboWX8BdgT4v7to7n2X/O0HmvFviLum/r1
         eFjy/nDrLnrAc9xupUVQIHDrBjfd0ASHCLPgn1aW6BzQ5KBZhzEVyYuPN1KiPd4jm7ho
         uwcOhkpYu5hVU4igYNFMVL9M/agjjtT7Fzf8QTLti+La/lceERdB41ZJrfmqz0UehgqL
         D45cMWfdfVKQ7a3Uo5AqxS6X0nqRixxZcSjAIvcAfEVuOOXY3T4OYfm2oKOgkvmLdolL
         rrEzYek2piPfpPy6aW+BrhprlDN46gnPJ80jbwTeX+cDT8Y8gsQ4MqZwRXfacSH0MOPh
         WxXQ==
X-Gm-Message-State: APjAAAX7c7Sow5P/qSzTu43MQKtuW/w+4t0ojuazfk8XUWPpgnFlMuQV
        LWjbchc+ILoPWlhje1v7v/gKxg==
X-Google-Smtp-Source: APXvYqwyC1V25omiQD3YSJ6epNfcBx8AhaB28ZLo46gWbL97wHqpIdyjCx0Leb7gqa/Rt/iWQHkMUg==
X-Received: by 2002:a1c:1fcc:: with SMTP id f195mr3521190wmf.137.1573226814586;
        Fri, 08 Nov 2019 07:26:54 -0800 (PST)
Received: from localhost.localdomain ([85.195.192.192])
        by smtp.gmail.com with ESMTPSA id w18sm6579232wrp.31.2019.11.08.07.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 07:26:54 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        will@kernel.org, robin.murphy@arm.com, zhangfei.gao@linaro.org,
        eric.auger@redhat.com, jonathan.cameron@huawei.com
Subject: [PATCH v2 6/8] iommu/arm-smmu-v3: Add second level of context descriptor table
Date:   Fri,  8 Nov 2019 16:25:06 +0100
Message-Id: <20191108152508.4039168-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108152508.4039168-1-jean-philippe@linaro.org>
References: <20191108152508.4039168-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The SMMU can support up to 20 bits of SSID. Add a second level of page
tables to accommodate this. Devices that support more than 1024 SSIDs now
have a table of 1024 L1 entries (8kB), pointing to tables of 1024 context
descriptors (64kB), allocated on demand.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 137 +++++++++++++++++++++++++++++++++---
 1 file changed, 126 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index df7d45503c65..82eac89ee187 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -224,6 +224,7 @@
 
 #define STRTAB_STE_0_S1FMT		GENMASK_ULL(5, 4)
 #define STRTAB_STE_0_S1FMT_LINEAR	0
+#define STRTAB_STE_0_S1FMT_64K_L2	2
 #define STRTAB_STE_0_S1CTXPTR_MASK	GENMASK_ULL(51, 6)
 #define STRTAB_STE_0_S1CDMAX		GENMASK_ULL(63, 59)
 
@@ -263,7 +264,20 @@
 
 #define STRTAB_STE_3_S2TTB_MASK		GENMASK_ULL(51, 4)
 
-/* Context descriptor (stage-1 only) */
+/*
+ * Context descriptors.
+ *
+ * Linear: when less than 1024 SSIDs are supported
+ * 2lvl: at most 1024 L1 entries,
+ *       1024 lazy entries per table.
+ */
+#define CTXDESC_SPLIT			10
+#define CTXDESC_L2_ENTRIES		(1 << CTXDESC_SPLIT)
+
+#define CTXDESC_L1_DESC_DWORDS		1
+#define CTXDESC_L1_DESC_VALID		1
+#define CTXDESC_L1_DESC_L2PTR_MASK	GENMASK_ULL(51, 12)
+
 #define CTXDESC_CD_DWORDS		8
 #define CTXDESC_CD_0_TCR_T0SZ		GENMASK_ULL(5, 0)
 #define ARM64_TCR_T0SZ			GENMASK_ULL(5, 0)
@@ -577,7 +591,10 @@ struct arm_smmu_cd_table {
 struct arm_smmu_s1_cfg {
 	u8				s1fmt;
 	u8				s1cdmax;
-	struct arm_smmu_cd_table	table;
+	struct arm_smmu_cd_table	*tables;
+	size_t				num_tables;
+	__le64				*l1ptr;
+	dma_addr_t			l1ptr_dma;
 	struct arm_smmu_ctx_desc	cd;
 };
 
@@ -1521,12 +1538,51 @@ static void arm_smmu_free_cd_leaf_table(struct arm_smmu_device *smmu,
 {
 	size_t size = num_entries * (CTXDESC_CD_DWORDS << 3);
 
+	if (!table->ptr)
+		return;
 	dmam_free_coherent(smmu->dev, size, table->ptr, table->ptr_dma);
 }
 
-static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_s1_cfg *cfg, u32 ssid)
+static void arm_smmu_write_cd_l1_desc(__le64 *dst,
+				      struct arm_smmu_cd_table *table)
 {
-	return cfg->table.ptr + ssid * CTXDESC_CD_DWORDS;
+	u64 val = (table->ptr_dma & CTXDESC_L1_DESC_L2PTR_MASK) |
+		  CTXDESC_L1_DESC_VALID;
+
+	WRITE_ONCE(*dst, cpu_to_le64(val));
+}
+
+static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
+				   u32 ssid)
+{
+	__le64 *l1ptr;
+	unsigned int idx;
+	struct arm_smmu_cd_table *table;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
+
+	if (cfg->s1fmt == STRTAB_STE_0_S1FMT_LINEAR) {
+		table = &cfg->tables[0];
+		idx = ssid;
+	} else {
+		idx = ssid >> CTXDESC_SPLIT;
+		if (idx >= cfg->num_tables)
+			return NULL;
+
+		table = &cfg->tables[idx];
+		if (!table->ptr) {
+			if (arm_smmu_alloc_cd_leaf_table(smmu, table,
+							 CTXDESC_L2_ENTRIES))
+				return NULL;
+
+			l1ptr = cfg->l1ptr + idx * CTXDESC_L1_DESC_DWORDS;
+			arm_smmu_write_cd_l1_desc(l1ptr, table);
+			/* An invalid L1CD can be cached */
+			arm_smmu_sync_cd(smmu_domain, ssid, false);
+		}
+		idx = ssid & (CTXDESC_L2_ENTRIES - 1);
+	}
+	return table->ptr + idx * CTXDESC_CD_DWORDS;
 }
 
 static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
@@ -1552,7 +1608,7 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 	u64 val;
 	bool cd_live;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	__le64 *cdptr = arm_smmu_get_cd_ptr(&smmu_domain->s1_cfg, ssid);
+	__le64 *cdptr = arm_smmu_get_cd_ptr(smmu_domain, ssid);
 
 	/*
 	 * This function handles the following cases:
@@ -1612,20 +1668,76 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
 {
+	int ret;
+	size_t size = 0;
+	size_t max_contexts;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 
-	cfg->s1fmt = STRTAB_STE_0_S1FMT_LINEAR;
-	return arm_smmu_alloc_cd_leaf_table(smmu, &cfg->table,
-					    1 << cfg->s1cdmax);
+	max_contexts = 1 << cfg->s1cdmax;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
+	    max_contexts <= CTXDESC_L2_ENTRIES) {
+		cfg->s1fmt = STRTAB_STE_0_S1FMT_LINEAR;
+		cfg->num_tables = 1;
+	} else {
+		cfg->s1fmt = STRTAB_STE_0_S1FMT_64K_L2;
+		cfg->num_tables = DIV_ROUND_UP(max_contexts,
+					       CTXDESC_L2_ENTRIES);
+
+		size = cfg->num_tables * (CTXDESC_L1_DESC_DWORDS << 3);
+		cfg->l1ptr = dmam_alloc_coherent(smmu->dev, size,
+						 &cfg->l1ptr_dma,
+						 GFP_KERNEL | __GFP_ZERO);
+		if (!cfg->l1ptr) {
+			dev_warn(smmu->dev, "failed to allocate L1 context table\n");
+			return -ENOMEM;
+		}
+	}
+
+	cfg->tables = devm_kzalloc(smmu->dev, sizeof(struct arm_smmu_cd_table) *
+				   cfg->num_tables, GFP_KERNEL);
+	if (!cfg->tables) {
+		ret = -ENOMEM;
+		goto err_free_l1;
+	}
+
+	/* With two levels, leaf tables are allocated lazily */
+	if (!cfg->l1ptr) {
+		ret = arm_smmu_alloc_cd_leaf_table(smmu, &cfg->tables[0],
+						   max_contexts);
+		if (ret)
+			goto err_free_tables;
+	}
+
+	return 0;
+
+err_free_tables:
+	devm_kfree(smmu->dev, cfg->tables);
+err_free_l1:
+	if (cfg->l1ptr)
+		dmam_free_coherent(smmu->dev, size, cfg->l1ptr, cfg->l1ptr_dma);
+	return ret;
 }
 
 static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
 {
+	int i;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
+	size_t num_leaf_entries = 1 << cfg->s1cdmax;
+	struct arm_smmu_cd_table *table = cfg->tables;
 
-	arm_smmu_free_cd_leaf_table(smmu, &cfg->table, 1 << cfg->s1cdmax);
+	if (cfg->l1ptr) {
+		size_t size = cfg->num_tables * (CTXDESC_L1_DESC_DWORDS << 3);
+
+		dmam_free_coherent(smmu->dev, size, cfg->l1ptr, cfg->l1ptr_dma);
+		num_leaf_entries = CTXDESC_L2_ENTRIES;
+	}
+
+	for (i = 0; i < cfg->num_tables; i++, table++)
+		arm_smmu_free_cd_leaf_table(smmu, table, num_leaf_entries);
+	devm_kfree(smmu->dev, cfg->tables);
 }
 
 /* Stream table manipulation functions */
@@ -1745,6 +1857,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	}
 
 	if (s1_cfg) {
+		dma_addr_t ptr_dma = s1_cfg->l1ptr ? s1_cfg->l1ptr_dma :
+				     s1_cfg->tables[0].ptr_dma;
+
 		BUG_ON(ste_live);
 		dst[1] = cpu_to_le64(
 			 FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0) |
@@ -1757,7 +1872,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		   !(smmu->features & ARM_SMMU_FEAT_STALL_FORCE))
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
 
-		val |= (s1_cfg->table.ptr_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
+		val |= (ptr_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
 			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
 			FIELD_PREP(STRTAB_STE_0_S1CDMAX, s1_cfg->s1cdmax) |
 			FIELD_PREP(STRTAB_STE_0_S1FMT, s1_cfg->s1fmt);
@@ -2273,7 +2388,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 
-		if (cfg->table.ptr) {
+		if (cfg->tables) {
 			arm_smmu_free_cd_tables(smmu_domain);
 			arm_smmu_bitmap_free(smmu->asid_map, cfg->cd.asid);
 		}
-- 
2.23.0

