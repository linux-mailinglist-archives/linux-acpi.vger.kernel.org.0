Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C71398F61
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jun 2021 17:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbhFBP5O (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 11:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbhFBP5O (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 11:57:14 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E690FC061756
        for <linux-acpi@vger.kernel.org>; Wed,  2 Jun 2021 08:55:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id g8so4642630ejx.1
        for <linux-acpi@vger.kernel.org>; Wed, 02 Jun 2021 08:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FJBc4XHO8GWouyeNxEp4BksscCRnIRbJmCxL/Ho6xNQ=;
        b=HLBoOUsOdCmAJj4FjB/fu1Loq/8X1A88Bu+3ig+QiYmtd6yqt5X6LmLSVjF6UvasB6
         7+ssFF/PKjYJiNXmeGvOpDtOGzyF+Uo8KyTC6cH/Akitu2K+fyIqBzAXNC6kvR6Yt4lI
         qZIY+7fnySxpkC8AlXr9nCtPhSHMYiS5czzXRe1IHGOuQyvnl+Ciuvrhifcgki61o51h
         DbV52JwnvvaENLzimRhxARWDmR/NzSCxe/U7q0Y2hhWfOd2uYpk7lToahdDsiCbUAvkF
         S/E/EH7mdHv7YJrqbyjMFodbV195eddRHef1viSTEoXHnpw5CDPbgE4uDI0peESVxRj4
         xJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FJBc4XHO8GWouyeNxEp4BksscCRnIRbJmCxL/Ho6xNQ=;
        b=K+jbmBCawYJCB/9yZxcJUXHuMP9URH2e01T8P97pAidgwOHroosUx04bKdFjx3nMuv
         jWnwk65/t/kzBpR+KrVCrfxEPABoUHMA+Ki8mO9LITTSm7l7mdBwEmqeQTdKSnfxzeFx
         gtLmvHJxP7EcMJYgMRdUpeX5mAw/7FIPVCLD4Cl4noP/G3tdrUYF77JFC1vi9HmFcNMa
         hGdJSk1rB6th6OvLSBFM0djlwBgPszHsGyaDq3nIVOiGUciLaAVZRxGxALVvyl2OxX6K
         ySQtYlL1BUyTbMfvSvDgttTU9QvnbRosFU6IZzMEp27xzO/K2MqE13Youx2VTH+6ubGD
         6nvQ==
X-Gm-Message-State: AOAM530OwBx/myT5SCOxNpOJwPrqcpS+3uJ/T2qKuGSyROI6UXRjVnTF
        YgpjD8Nec0MOluvkCxjf+oTBOA==
X-Google-Smtp-Source: ABdhPJzvIihB4u2U21NjmyHazdoodwnPuTYvjpPpgvKWl4ko2Dpr+qcu7Kv+sM483330tcKmVSeTPg==
X-Received: by 2002:a17:907:7b9e:: with SMTP id ne30mr20565194ejc.389.1622649311715;
        Wed, 02 Jun 2021 08:55:11 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id d24sm174249edr.95.2021.06.02.08.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 08:55:11 -0700 (PDT)
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
Subject: [PATCH v3 5/6] iommu/dma: Simplify calls to iommu_setup_dma_ops()
Date:   Wed,  2 Jun 2021 17:44:45 +0200
Message-Id: <20210602154444.1077006-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602154444.1077006-1-jean-philippe@linaro.org>
References: <20210602154444.1077006-1-jean-philippe@linaro.org>
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
index 94b96d81fcfd..d3123bc05c08 100644
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
index 85f18342603c..8d866940692a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5165,15 +5165,7 @@ static void intel_iommu_release_device(struct device *dev)
 
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

