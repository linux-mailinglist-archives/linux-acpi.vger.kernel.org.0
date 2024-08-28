Return-Path: <linux-acpi+bounces-7925-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F679628B0
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 15:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7219EB22D3A
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 13:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FFE1862B5;
	Wed, 28 Aug 2024 13:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+rIer1B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F31184535;
	Wed, 28 Aug 2024 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851968; cv=none; b=H6WLux0x/xVG8n+QE0Hf+069jHKqNkvA0IXLAoa2BQNwzPNmu6XUPROsrP2onmKdMdnU+aA+MdhjEXBb5E+vKZ98xX3eW+Q5DeukPOETgZyD7sO5RKV9Z7xBVf/g+Jd+H/ShlKaW9FaTByJDUBRignrXwVD6VhLFWjfdlFStvpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851968; c=relaxed/simple;
	bh=7SR67HpUr73cEL63aEKrkw71w+3MGtEelfBCivUJxrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TehsTYwsC/zJUSEI8lTfnTm7iSmTPJ0hEzl58RlngFUBc0vMeiPJRcVe/9EZ76yPao+IwtdwGKf+eMjGRmeh28AeI8cwAgZTiG/YuJm5FgnqI6cpABPYzRBzznK6Z4f3y66UfGEoO4gVGYrHbngl3A42Tas0Hf2dPLv5423QX/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+rIer1B; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-715cdc7a153so494374b3a.0;
        Wed, 28 Aug 2024 06:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724851966; x=1725456766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IV9ruV4IKGNQsVpd2T2vGSBXmMJz+AZMZ8d3CyCPB14=;
        b=m+rIer1B15jZreWBzilsiZj5bSAQGo3NP+HL+U6Oyxp4OWePdUpvHTJwLwRLEBXAkQ
         VkSc4dCcMzWbmj/b+6n//z9Oqst6YUvxcFqtvX7MPcMWaXCcHwGVc8IlX7pS548J3ROy
         X3FocgOlgWDdGMI7jCN+Hi7rELoEYARK095ziS+wGWNJJoUY4KvDWiSt3e79girIn9W/
         Z/5xiAEmmEkSVzcwGRNB10OIOsadUg95rcor9McrPLod4AARWrTRGmiLxkt1fleM33GT
         zNf4Cc5BZl9EEq+rfaGCFFZYkP9QVq8AcI9fZpndUK8ZGV2baqzHQ8BazF4T1o+skdIn
         5uiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724851966; x=1725456766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IV9ruV4IKGNQsVpd2T2vGSBXmMJz+AZMZ8d3CyCPB14=;
        b=XyLlz1mHYIg4ysj0exRe2y5OE9K97n+x0zhWkBarSEp6hloYAOb01EyXpDGE5wPRyK
         554FoutAhX3ahmWTmC+NQMtZ3EpvUE4QQi2fDQAdPgSYIt84JnBd1pdDq7RsbOA1YvgQ
         +ivwM+0OlX21oj2BJkq+GpY0sxymHOcVkhfVgNYr7Wv/rcnQuHqhauI8PXpJL1HFyLc4
         yJxm8pCVsrMjYpIT4GfduplcK2/cVUEplTgR3QCyhoF2sveToFP8pzWoqkvYa7l9pnVk
         4Rib6AXJX62nG9pGNzcn5oF8VZRcr4dbwxD8Ksn/QpWoYSJ63A9a0eMgpSlIMSEs+F3t
         jhGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW1uUJ2BrzTPvL/Jc94r6UG1cnygKrD/PrcqNqDWyR+etZe3Yvi4T9UNQ/5FXV/kgofhj6IKUNF3/v+X0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyefpy6dNk4Jt24c2eHNoWH/6PlEOynMQ2VdYSSyxOA/TLXvhgE
	zzlvf5tFDVwNHTLBnA8PB4a36FOkOAe1LQ/j5Ma6aF+JVcr1W9KY
X-Google-Smtp-Source: AGHT+IEWHbHsY9i95mKT7j9Ru9/r62XAXeWnvYGK9s8kwMU9vJh1dKZkgVgeNA4n0rMM5Q8Ge+087Q==
X-Received: by 2002:a05:6a00:3ccc:b0:70d:36ad:3f67 with SMTP id d2e1a72fcca58-715d1120f38mr3360446b3a.11.1724851965649;
        Wed, 28 Aug 2024 06:32:45 -0700 (PDT)
Received: from fedora.. ([106.219.166.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9acdca5dsm11009955a12.49.2024.08.28.06.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 06:32:45 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: lpieralisi@kernel.org,
	guohanjun@huawei.com,
	sudeep.holla@arm.com
Cc: linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH] ACPI: arm64: Fix checkpatch warning - Alignment should match open parenthesis
Date: Wed, 28 Aug 2024 19:02:05 +0530
Message-ID: <20240828133205.17368-1-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adhere to Linux kernel coding style.

Reported by checkpatch:
- CHECK: Alignment should match open parenthesis

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


