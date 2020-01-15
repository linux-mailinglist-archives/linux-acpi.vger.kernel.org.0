Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF7B813C1C6
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2020 13:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgAOMxb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Jan 2020 07:53:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44986 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgAOMxb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jan 2020 07:53:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so15622885wrm.11
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jan 2020 04:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qvpO6T6lCyQjsFcC/B3MAQOfFJPvli4NlBcE8bVnq2o=;
        b=Un9dRtM79GzqVUSyAD8iZOkwazLCNFPN06jszbZzjoO5X6y3APf6Ai8m4xLDh1rv+p
         9QpUygnXhnhwj68gkjMH+zGrl+vtJTYPOfVTL2+UTTkmT8asVWfVm8hswGh4oMCiJv6J
         FobO4S5wB3tp7ZFAa9ajhZM3j0+zz352jdcby4we3TkEQ7IiQS7idAfquMS9qPFuK1Lg
         hp67GsukgiTHq6OTCFJKkEn6W6VseusestCZQjMr7nMdk6WS/LI8W+rIfW17KZCi/FVi
         AGdk3/KfLRFvd0K6uSzqopJBpMTMjB2fKWn0V7QdS+tbKdEz2rGjDW/6TF6iw9KRthix
         Dxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qvpO6T6lCyQjsFcC/B3MAQOfFJPvli4NlBcE8bVnq2o=;
        b=HMtKD4uXKvKE7QhM92sGsTzJ6Kyx1rhs+/2pnICanW2SFm5lIcx5+pr6Mz91INTHbt
         L1UX/Hs+R7jyg47y9+HLYbYBUiN0xQbOfR0x6CbycUkLrRLZsH/fDA3U9veNzqFpx4n+
         bu7vcPDaJ7yeTvDFhLl2SusTXDl0+nPIp42xMzmDCblIRIfWF1p+oiFIdXsemywbNYOP
         0wtFZMbUP6+AL/aGDgk1Gu55C7pHAfo5M7Swe8hy2BLuOGVDPBrl09ADjKfuo2HFr5At
         MHfEV8neMnwwqtc5cz10u4K6771WUllCE9hopZu8IKoi40X/wPcnC/j/d+ycv80tpuI4
         mKZA==
X-Gm-Message-State: APjAAAWivbQyE/S7LpGE25pIq34uvXRelw1/giD0KZ2X/5N4LDZUQfGs
        wUiCDxtal6HsqcBVrjdKB2zqVg==
X-Google-Smtp-Source: APXvYqzDH6Ofz9W/fkRMwJX0uclPKkOnzuIwGWl7fHBi5dpcESWKfC7gH7eOZddi3/XzZnxRbT2koQ==
X-Received: by 2002:adf:e6d2:: with SMTP id y18mr32269694wrm.262.1579092808455;
        Wed, 15 Jan 2020 04:53:28 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2266:ba60:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id d12sm25196171wrp.62.2020.01.15.04.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 04:53:28 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, will@kernel.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com, eric.auger@redhat.com,
        jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
Subject: [PATCH v5 01/13] iommu/arm-smmu-v3: Drop __GFP_ZERO flag from DMA allocation
Date:   Wed, 15 Jan 2020 13:52:27 +0100
Message-Id: <20200115125239.136759-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115125239.136759-1-jean-philippe@linaro.org>
References: <20200115125239.136759-1-jean-philippe@linaro.org>
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

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
2.24.1

