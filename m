Return-Path: <linux-acpi+bounces-7972-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DEE964D28
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 19:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5CB2810C3
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 17:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674A51B7906;
	Thu, 29 Aug 2024 17:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsgoJASn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C568418E031;
	Thu, 29 Aug 2024 17:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953496; cv=none; b=LtR6yuFWVxOAdnfVwfJuv/pp51lTjtXhQCd5SYusWDzOyPDlTVSzpOtZYamnMWjOrAqDMtLFDzAfSrFlmtu/K5jy0hQQqk6KjZ9UJEiRJuRd44l6v0kC5U1OVdGT7E6+OeBZNapCo93glrqg8I0gcbb4SX1C1sSQiAvc0IO6p2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953496; c=relaxed/simple;
	bh=iCs7CK4S1ECvvxh+VL6Q0ELw/ddpVArlblT3R3I64Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LEHOsqlMvtKYFlKQNpa0BQyFxz73FVOoUS/HX6yWJg4goq628CMQN2QgV1hhot3UlaxZOPurXlOj4h7JSj3fDzA559Wf8GyVuHeQi6hNLS2BYNj8LSeUxiz4jgjJAxIgRROFuK96QNn7OuiBqWMgvEknqLFbzjzmsQh1qZfxQwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsgoJASn; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-202089e57d8so7438495ad.0;
        Thu, 29 Aug 2024 10:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724953494; x=1725558294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LRPGfBMGZzpvPkj/HqPh800wLxA7h+m99bFRb1aqa/o=;
        b=ZsgoJASnvK8sljRdyLhtSLdoUuBRx2ZsEakbbziyq68IDkCKk44VQgOZ0VRKQAsPHI
         GJt+JAu6DHBmDpKicbVKDl9bUplhk2YbMCyFLJP1NGkOrv5OL3afYG0hxtF42QFDgiVJ
         eMdVZJcGKBjvTkc4JmzSxaxwwXxlHg4MlxxWISGtEGpHxCVDVIU+vor2ORuT7OtOEdkS
         gIdpV2oesiybXOB7um8M1eP1xGZe4LL5EAsC+vamrcS++cdZyZ3AGVC97yks4o5pG5Bv
         sLBBFY8a4qoCwtDYgJVSMP3LQxy3v4nszZYZ9p7Br0qruaVMDHGEu5AEGuAtbQlh1rvI
         Gtfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724953494; x=1725558294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LRPGfBMGZzpvPkj/HqPh800wLxA7h+m99bFRb1aqa/o=;
        b=ahfIQnmu5MBamKbiWyiqTmIws7c+11Fx94VJ4vmLy2U9ONdIIzYSsKRB7oiBQWb52g
         MjLII1rrXatRwBnMFioSxEqSyDLgnSVHxrk8Gk253uCT9BV3ajIYPvShboUYM8ZlnYam
         ruqiuOmZLpmiywPr/QBIwmMYL8HEHoFtT5fWjit0wiKA2vtJBhF/4BoWWypYQ1qRXhGX
         OgUiQvWLraKScImJhqEG60DV/5khN5gjrCNM7uCMvCdhOJTR/sXx7i01ux6phmktaKx0
         hklV/LlFaIxTx3tQWt2TAKhLfdA7osQ5jz3eSvWryM9XXeTY0rs29K75GITyk1ipMgzg
         robQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIbY9o/mIWgayA/kq3/t2brn5WgpFZ7Un1hO+PW0v8pLEAJFpA7Bs0+9/oKNfNKN0r8vZV0yPZkg7pF7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YynUfCMieyneO2p4WFuMphDMZjLC9PN1Llb/Aqu74Ej8WgPj9aW
	67yO/8Z+KNoN9Qcf0fAFgxBqtBnnxhQEJuSc/bNUeVvB0LIAWAU/
X-Google-Smtp-Source: AGHT+IFWvCE+TxB4cBY4LyUs2M3RnA+2kHuup3XTetabP3uNyeOUqA4NGlbr3xcEbFr4QmhuNdkzmA==
X-Received: by 2002:a17:902:e74a:b0:1fe:d72d:13e1 with SMTP id d9443c01a7336-205168e4310mr31015465ad.30.1724953493746;
        Thu, 29 Aug 2024 10:44:53 -0700 (PDT)
Received: from fedora.. ([106.219.166.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b1546sm14075635ad.18.2024.08.29.10.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 10:44:53 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: lpieralisi@kernel.org,
	guohanjun@huawei.com,
	sudeep.holla@arm.com,
	rafael@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH v2] ACPI: arm64: Fix some parenthesis alignment coding style issues
Date: Thu, 29 Aug 2024 23:13:30 +0530
Message-ID: <20240829174329.3917-3-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adhere to Linux kernel coding style.

Issue reported by checkpatch:
- CHECK: Alignment should match open parenthesis

It has no functional changes.

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
 drivers/acpi/arm64/amba.c |  5 ++---
 drivers/acpi/arm64/apmt.c |  4 ++--
 drivers/acpi/arm64/iort.c | 22 +++++++++++-----------
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/arm64/amba.c b/drivers/acpi/arm64/amba.c
index 1350083bce5f..8d27d86ee052 100644
--- a/drivers/acpi/arm64/amba.c
+++ b/drivers/acpi/arm64/amba.c
@@ -33,8 +33,7 @@ static void amba_register_dummy_clk(void)
 	clk_register_clkdev(amba_dummy_clk, "apb_pclk", NULL);
 }
 
-static int amba_handler_attach(struct acpi_device *adev,
-				const struct acpi_device_id *id)
+static int amba_handler_attach(struct acpi_device *adev, const struct acpi_device_id *id)
 {
 	struct acpi_device *parent = acpi_dev_parent(adev);
 	struct amba_device *dev;
@@ -94,7 +93,7 @@ static int amba_handler_attach(struct acpi_device *adev,
 	ret = amba_device_add(dev, &iomem_resource);
 	if (ret) {
 		dev_err(&adev->dev, "%s(): amba_device_add() failed (%d)\n",
-		       __func__, ret);
+			__func__, ret);
 		goto err_free;
 	}
 
diff --git a/drivers/acpi/arm64/apmt.c b/drivers/acpi/arm64/apmt.c
index bb010f6164e5..74e8dc33241b 100644
--- a/drivers/acpi/arm64/apmt.c
+++ b/drivers/acpi/arm64/apmt.c
@@ -48,7 +48,7 @@ static int __init apmt_init_resources(struct resource *res,
 		trigger = (trigger == ACPI_APMT_OVFLW_IRQ_FLAGS_MODE_LEVEL) ?
 			ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
 		irq = acpi_register_gsi(NULL, node->ovflw_irq, trigger,
-						ACPI_ACTIVE_HIGH);
+					ACPI_ACTIVE_HIGH);
 
 		if (irq <= 0) {
 			pr_warn("APMT could not register gsi hwirq %d\n", irq);
@@ -132,7 +132,7 @@ static int __init apmt_init_platform_devices(void)
 
 	while (offset < end) {
 		apmt_node = ACPI_ADD_PTR(struct acpi_apmt_node, apmt,
-				 offset);
+					 offset);
 
 		fwnode = acpi_alloc_fwnode_static();
 		if (!fwnode)
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 1b39e9ae7ac1..369a3b506711 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -374,7 +374,7 @@ static struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
 	struct acpi_iort_id_mapping *map;
 
 	if (!node->mapping_offset || !node->mapping_count ||
-				     index >= node->mapping_count)
+	    index >= node->mapping_count)
 		return NULL;
 
 	map = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
@@ -388,7 +388,7 @@ static struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
 	}
 
 	parent = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
-			       map->output_reference);
+			      map->output_reference);
 
 	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
 		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
@@ -1128,8 +1128,8 @@ static void iort_iommu_msi_get_resv_regions(struct device *dev,
 
 	for (i = 0; i < fwspec->num_ids; i++) {
 		its_node = iort_node_map_id(iommu_node,
-					fwspec->ids[i],
-					NULL, IORT_MSI_TYPE);
+					    fwspec->ids[i],
+					    NULL, IORT_MSI_TYPE);
 		if (its_node)
 			break;
 	}
@@ -1429,7 +1429,7 @@ static void __init acpi_iort_register_irq(int hwirq, const char *name,
 
 	if (irq <= 0) {
 		pr_err("could not register gsi hwirq %d name [%s]\n", hwirq,
-								      name);
+		       name);
 		return;
 	}
 
@@ -1561,7 +1561,7 @@ static void __init arm_smmu_v3_dma_configure(struct device *dev,
  * set numa proximity domain for smmuv3 device
  */
 static int  __init arm_smmu_v3_set_proximity(struct device *dev,
-					      struct acpi_iort_node *node)
+					     struct acpi_iort_node *node)
 {
 	struct acpi_iort_smmu_v3 *smmu;
 
@@ -1622,7 +1622,7 @@ static void __init arm_smmu_init_resources(struct resource *res,
 	trigger = IORT_IRQ_TRIGGER_MASK(glb_irq[0]);
 
 	acpi_iort_register_irq(hw_irq, "arm-smmu-global", trigger,
-				     &res[num_res++]);
+			       &res[num_res++]);
 
 	/* Context IRQs */
 	ctx_irq = ACPI_ADD_PTR(u64, node, smmu->context_interrupt_offset);
@@ -1727,9 +1727,9 @@ struct iort_dev_config {
 				  struct acpi_iort_node *node);
 	int (*dev_count_resources)(struct acpi_iort_node *node);
 	void (*dev_init_resources)(struct resource *res,
-				     struct acpi_iort_node *node);
+				   struct acpi_iort_node *node);
 	int (*dev_set_proximity)(struct device *dev,
-				    struct acpi_iort_node *node);
+				 struct acpi_iort_node *node);
 	int (*dev_add_platdata)(struct platform_device *pdev);
 };
 
@@ -1878,13 +1878,13 @@ static void __init iort_enable_acs(struct acpi_iort_node *iort_node)
 				continue;
 
 			parent = ACPI_ADD_PTR(struct acpi_iort_node,
-					iort_table,  map->output_reference);
+					      iort_table,  map->output_reference);
 			/*
 			 * If we detect a RC->SMMU mapping, make sure
 			 * we enable ACS on the system.
 			 */
 			if ((parent->type == ACPI_IORT_NODE_SMMU) ||
-				(parent->type == ACPI_IORT_NODE_SMMU_V3)) {
+			    (parent->type == ACPI_IORT_NODE_SMMU_V3)) {
 				pci_request_acs();
 				acs_enabled = true;
 				return;
-- 
2.46.0


