Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDE711738F
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Dec 2019 19:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfLISL7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Dec 2019 13:11:59 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55733 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfLISL7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Dec 2019 13:11:59 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so314085wmj.5
        for <linux-acpi@vger.kernel.org>; Mon, 09 Dec 2019 10:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tMr0YtGSE17WnD557NimiGUSbd3CWS+6jPhD283bpnk=;
        b=DKcEK1cOMdwaV5V0f6q2cMbZmPW7gZYu64KpfMr2+WQ6ycKdbRUfNWPgfRV3F0vBHs
         7UKDB03yyST3MYk9fbA9XVMuoUvaJKKQkwof4LICYRJRS3vsx2X/+IRlHHkrXtj38MZd
         XN4l1HDeDs1f9EUr0SUtKlD6xRtsiEHYQeTGaBmIRKMTj5SVqV4HFWpcGuqRRJGdZ1gI
         kfKDRtVBKeIares4//dnkrP4bvMLWjLbHQGX8fRDR5CGx0bHULy1wklyi2xjvByTGucj
         bVReQzCTfZvXJkf6xdLU0s7b5fdCwsUjRbzpjiO9Igfd/61c10uwJW+il7syzp8yFqe6
         fhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tMr0YtGSE17WnD557NimiGUSbd3CWS+6jPhD283bpnk=;
        b=ckD3KQqs0vNi/eQj4/ydmr4fOou25ndVvA/agwsUy0WzcW4w1UaApy1K2f4R0B+zE5
         nL3SR3mS/wlovKdVi8q4FWTdUfayBhRwNzjq4e1occVnjhxVtnP1qim4duh56DmUXExr
         LMn/xzOY313bP22USitJ9tb7eAQKhYGwVetjxQi//8BoDH+zX7tNT4dGaG28yC2wnchQ
         5Pc+K3r9k4QlIdpFQf9shobwq1GNSlIOXPIZPEEJ7ViqE9WRFRQuMOcFWbtQBDjOw7rh
         w4NNDf2zqf88E/BnGOVkzgtBGT+eNiK/UGD6RVkrLgUP5haMjocQOfsn2kKyJ4PtvO1D
         nvMw==
X-Gm-Message-State: APjAAAWojMRuoaPb2DmDTbFxWwkDQufdXSfBMImxm0MxJHkDKlQDjt9k
        fycVEuMwM5hGdlwOJwseWkpbpg==
X-Google-Smtp-Source: APXvYqyn5PjD8xxtXCXK1S6VlNWGbZuYGwg+csNTdA3fwLmXia8edlDe7V+Gqp7sUAYQaaZu77s53Q==
X-Received: by 2002:a1c:7d92:: with SMTP id y140mr276297wmc.145.1575915117196;
        Mon, 09 Dec 2019 10:11:57 -0800 (PST)
Received: from localhost.localdomain (adsl-62-167-101-88.adslplus.ch. [62.167.101.88])
        by smtp.gmail.com with ESMTPSA id h2sm309838wrv.66.2019.12.09.10.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 10:11:56 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
        eric.auger@redhat.com, jonathan.cameron@huawei.com,
        zhangfei.gao@linaro.org
Subject: [PATCH v3 01/13] iommu/arm-smmu-v3: Drop __GFP_ZERO flag from DMA allocation
Date:   Mon,  9 Dec 2019 19:05:02 +0100
Message-Id: <20191209180514.272727-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209180514.272727-1-jean-philippe@linaro.org>
References: <20191209180514.272727-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Since commit 518a2f1925c3 ("dma-mapping: zero memory returned from
dma_alloc_*"), dma_alloc_* always initializes memory to zero, so there
is no need to use dma_zalloc_* or pass the __GFP_ZERO flag anymore.

The flag was introduced by commit 04fa26c71be5 ("iommu/arm-smmu: Convert
DMA buffer allocations to the managed API"), since the managed API
didn't provide a dmam_zalloc_coherent() function.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index effe72eb89e7..d4e8b7f8d9f4 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1675,7 +1675,7 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 
 	desc->span = STRTAB_SPLIT + 1;
 	desc->l2ptr = dmam_alloc_coherent(smmu->dev, size, &desc->l2ptr_dma,
-					  GFP_KERNEL | __GFP_ZERO);
+					  GFP_KERNEL);
 	if (!desc->l2ptr) {
 		dev_err(smmu->dev,
 			"failed to allocate l2 stream table for SID %u\n",
@@ -2161,8 +2161,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 		return asid;
 
 	cfg->cdptr = dmam_alloc_coherent(smmu->dev, CTXDESC_CD_DWORDS << 3,
-					 &cfg->cdptr_dma,
-					 GFP_KERNEL | __GFP_ZERO);
+					 &cfg->cdptr_dma, GFP_KERNEL);
 	if (!cfg->cdptr) {
 		dev_warn(smmu->dev, "failed to allocate context descriptor\n");
 		ret = -ENOMEM;
@@ -2883,7 +2882,7 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
 
 	l1size = cfg->num_l1_ents * (STRTAB_L1_DESC_DWORDS << 3);
 	strtab = dmam_alloc_coherent(smmu->dev, l1size, &cfg->strtab_dma,
-				     GFP_KERNEL | __GFP_ZERO);
+				     GFP_KERNEL);
 	if (!strtab) {
 		dev_err(smmu->dev,
 			"failed to allocate l1 stream table (%u bytes)\n",
@@ -2910,7 +2909,7 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
 
 	size = (1 << smmu->sid_bits) * (STRTAB_STE_DWORDS << 3);
 	strtab = dmam_alloc_coherent(smmu->dev, size, &cfg->strtab_dma,
-				     GFP_KERNEL | __GFP_ZERO);
+				     GFP_KERNEL);
 	if (!strtab) {
 		dev_err(smmu->dev,
 			"failed to allocate linear stream table (%u bytes)\n",
-- 
2.24.0

