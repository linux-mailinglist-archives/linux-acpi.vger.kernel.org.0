Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02AE3369193
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 13:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhDWL5k (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Apr 2021 07:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhDWL5g (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Apr 2021 07:57:36 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6D4C061756
        for <linux-acpi@vger.kernel.org>; Fri, 23 Apr 2021 04:57:00 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id p6so41451334wrn.9
        for <linux-acpi@vger.kernel.org>; Fri, 23 Apr 2021 04:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PPlf6PmudxEBhFFbCtfVg/0ThZVLyT3V5UlJSyz19uQ=;
        b=nRkBopEbDZfyoJj93wf3o22q/jswYgaQWnGlI6oAwmedhv/HGZN7g3FARSljblxKD5
         acjYCanfz5LdD8LEdDSIEHgIlB+f3gnCX35E78fjNUkoXlkSkJoAG+mUiJIeSX1hsyWd
         TgUSR6lrK82ZUQP53r6gGX0ZuRertEVlH4Sx1ROIBbK5ANGDVafwOuWFkaNDut9csDD7
         JSm7sySdFNLmhkzXYfVrer2Y+HT5K4AIjsqUojilCvM2hENpooUfV+o6rjIjG2yuDWPe
         q8wpXSscJjF+jwYonvShzo57XIzap+xqcFXhwpk+LrgZLsyQQUemvwa8GLCvj7lV44zS
         6yKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PPlf6PmudxEBhFFbCtfVg/0ThZVLyT3V5UlJSyz19uQ=;
        b=I/1fOMhESvRRmW3DPH5qk8vm4l0j2u4umC+RNHvJj+onhlM+5APsjFASazQZ7z+1pf
         eCxPSXLU+l7jTXKgtGC+8nGQ3TOrjqPwediBzaPdAyLyH8KZM16LimbuoTm87Jpau4Je
         trosQI+kzGioP7tTSsXR1xEUzs/g9puZSXVu0tVTjeppG73hOxX8N2oTBAo387GiLnwo
         YepsHRcnq1CqUDIKJw01O7CbnTxUaD+cH+M5ODz4azsmiRVMEDhW9GRQiuC2WX9VVggN
         H4/ldaulCPIx4FBGsnQ+F5iAAm8aUz9aZLR4lMelenBI1cVZ674dQPtfMal+CyrmImYZ
         4hvA==
X-Gm-Message-State: AOAM531fREpi0g71iSdVc0gqjntJhl3mnQDy/nAoc8u+fNg0sisqDPko
        IgUteCdGVGQ4lpSX9MqDRekmuA==
X-Google-Smtp-Source: ABdhPJy/J1DbcuIx65t0na0UfxgQvJFfmdbA8jSi+JVISUbWizw5uKkB9RPqHS3oQcM5gZ8NbRw5Pg==
X-Received: by 2002:a05:6000:1209:: with SMTP id e9mr4332783wrx.192.1619179018723;
        Fri, 23 Apr 2021 04:56:58 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id g9sm7485195wmh.21.2021.04.23.04.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 04:56:58 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org, mst@redhat.com
Cc:     will@kernel.org, catalin.marinas@arm.com, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, eric.auger@redhat.com,
        sebastien.boeuf@intel.com, robin.murphy@arm.com,
        kevin.tian@intel.com, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, sudeep.holla@arm.com,
        jean-philippe@linaro.org
Subject: [PATCH v2 5/6] iommu/dma: Simplify calls to iommu_setup_dma_ops()
Date:   Fri, 23 Apr 2021 13:38:36 +0200
Message-Id: <20210423113836.3974972-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210423113836.3974972-1-jean-philippe@linaro.org>
References: <20210423113836.3974972-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

dma-iommu uses the address bounds described in domain->geometry during
IOVA allocation. The address size parameters of iommu_setup_dma_ops()
are useful for describing additional limits set by the platform
firmware, but aren't needed for drivers that call this function from
probe_finalize(). The base parameter can be zero because dma-iommu
already removes the first IOVA page, and the limit parameter can be
U64_MAX because it's only checked against the domain geometry. Simplify
calls to iommu_setup_dma_ops().

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/amd/iommu.c   |  9 +--------
 drivers/iommu/dma-iommu.c   |  4 +++-
 drivers/iommu/intel/iommu.c | 10 +---------
 3 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 50041df43391..bbb09840cf40 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1708,14 +1708,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 
 static void amd_iommu_probe_finalize(struct device *dev)
 {
-	struct iommu_domain *domain;
-
-	/* Domains are initialized for this device - have a look what we ended up with */
-	domain = iommu_get_domain_for_dev(dev);
-	if (domain->type == IOMMU_DOMAIN_DMA)
-		iommu_setup_dma_ops(dev, IOVA_START_PFN << PAGE_SHIFT, U64_MAX);
-	else
-		set_dma_ops(dev, NULL);
+	iommu_setup_dma_ops(dev, 0, U64_MAX);
 }
 
 static void amd_iommu_release_device(struct device *dev)
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index c62e19bed302..175f8eaeb5b3 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1322,7 +1322,9 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
 	if (domain->type == IOMMU_DOMAIN_DMA) {
 		if (iommu_dma_init_domain(domain, dma_base, dma_limit, dev))
 			goto out_err;
-		dev->dma_ops = &iommu_dma_ops;
+		set_dma_ops(dev, &iommu_dma_ops);
+	} else {
+		set_dma_ops(dev, NULL);
 	}
 
 	return;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 39a4e672b1c2..c6fe11d3624e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5160,15 +5160,7 @@ static void intel_iommu_release_device(struct device *dev)
 
 static void intel_iommu_probe_finalize(struct device *dev)
 {
-	dma_addr_t base = IOVA_START_PFN << VTD_PAGE_SHIFT;
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
-	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-
-	if (domain && domain->type == IOMMU_DOMAIN_DMA)
-		iommu_setup_dma_ops(dev, base,
-				    __DOMAIN_MAX_ADDR(dmar_domain->gaw));
-	else
-		set_dma_ops(dev, NULL);
+	iommu_setup_dma_ops(dev, 0, U64_MAX);
 }
 
 static void intel_iommu_get_resv_regions(struct device *device,
-- 
2.31.1

