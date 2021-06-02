Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A4C398F5D
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jun 2021 17:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhFBP5I (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 11:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhFBP5G (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 11:57:06 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16547C06174A
        for <linux-acpi@vger.kernel.org>; Wed,  2 Jun 2021 08:55:12 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id k7so4536438ejv.12
        for <linux-acpi@vger.kernel.org>; Wed, 02 Jun 2021 08:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T0y2iCeYYHmrE1fv4Hgj0FTcnFeMz1q5JiDftJFl4po=;
        b=UU+ar2uiuIssxizF/XowP5GaXfYLplYpn1Nerb/7N0zWP6tskNLr9vCRUsE3fwARUH
         KokNG9WNbX2xrgEdrnbZnTnn3Toqdt1Qxq/f391f20+UIKbP13jlmzNdO31ElLUPY2Dh
         hU3W+Drm7oI+RXtS+S8oCII7VQkfw7M4NvmNI0+2nahkcVlhWUqQV3z3BIKVLOCh4DoB
         bPIzZWQd/7A5ATsgUulJsY1I0BKRz5H0Zq2FYTa29L/SatFBvgoajrAU/TNLoyCdNX9D
         9bUKbLDBcn27eMuJQCuJvuzUvgHQLS1VrbrbNj3xHESrrYSx1hKBJdaCqx+fqIiVdhJg
         zPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T0y2iCeYYHmrE1fv4Hgj0FTcnFeMz1q5JiDftJFl4po=;
        b=kr0U+qPoPMSNlmRdUTwAOHyDP0jHSIR632Xg4kcoYw37h3U+xJgVRMexgn+NJAE4qU
         iNle9biJvMDd+DRwoX3CkkgPQN+UAx+kDalCIILbR/89X0I1SvBlnfvonaYbFtxNgDqD
         KHqh/uSC5H5UzXLf3aSKIGNR1lrQwqLBkJ0RLH0sON7+UJM3alBKXLMafiixgDEmcDV8
         pf4xnNnDlgPDVQ3BCjrJBrtmu1ol4brh+fNnBFaruEENx/bMYjggHFRfuYIBsJcxNRp1
         q7mAZb/7WVKEbwB95Q2dkUwSU17dH8Q+8I4DV+lKIgOiICzUjn3z6cgXo5I9tKHP7zb8
         Yqqg==
X-Gm-Message-State: AOAM533tHNIvLeK1/XsvNHAqCGJq+/8YEI2emdat9bV0cgw5h5rcgiQW
        Pf5MGv81AelFhVfMJjwvh18hlg==
X-Google-Smtp-Source: ABdhPJyGy0NBOJzSJQLD2BsBLdPZKOs9cC7yrRFD8NAp8rayeCfk0SMetwDCXBWEmUHXL74G7L/GJw==
X-Received: by 2002:a17:906:3b92:: with SMTP id u18mr34902477ejf.450.1622649310639;
        Wed, 02 Jun 2021 08:55:10 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id d24sm174249edr.95.2021.06.02.08.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 08:55:10 -0700 (PDT)
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
Subject: [PATCH v3 4/6] iommu/dma: Pass address limit rather than size to iommu_setup_dma_ops()
Date:   Wed,  2 Jun 2021 17:44:44 +0200
Message-Id: <20210602154444.1077006-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602154444.1077006-1-jean-philippe@linaro.org>
References: <20210602154444.1077006-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Passing a 64-bit address width to iommu_setup_dma_ops() is valid on
virtual platforms, but isn't currently possible. The overflow check in
iommu_dma_init_domain() prevents this even when @dma_base isn't 0. Pass
a limit address instead of a size, so callers don't have to fake a size
to work around the check.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/dma-iommu.h   |  4 ++--
 arch/arm64/mm/dma-mapping.c |  2 +-
 drivers/iommu/amd/iommu.c   |  2 +-
 drivers/iommu/dma-iommu.c   | 12 ++++++------
 drivers/iommu/intel/iommu.c |  2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 6e75a2d689b4..758ca4694257 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -19,7 +19,7 @@ int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
 void iommu_put_dma_cookie(struct iommu_domain *domain);
 
 /* Setup call for arch DMA mapping code */
-void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size);
+void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit);
 
 /* The DMA API isn't _quite_ the whole story, though... */
 /*
@@ -50,7 +50,7 @@ struct msi_msg;
 struct device;
 
 static inline void iommu_setup_dma_ops(struct device *dev, u64 dma_base,
-		u64 size)
+				       u64 dma_limit)
 {
 }
 
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 4bf1dd3eb041..7bd1d2199141 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -50,7 +50,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 
 	dev->dma_coherent = coherent;
 	if (iommu)
-		iommu_setup_dma_ops(dev, dma_base, size);
+		iommu_setup_dma_ops(dev, dma_base, size - dma_base - 1);
 
 #ifdef CONFIG_XEN
 	if (xen_swiotlb_detect())
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 3ac42bbdefc6..94b96d81fcfd 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1713,7 +1713,7 @@ static void amd_iommu_probe_finalize(struct device *dev)
 	/* Domains are initialized for this device - have a look what we ended up with */
 	domain = iommu_get_domain_for_dev(dev);
 	if (domain->type == IOMMU_DOMAIN_DMA)
-		iommu_setup_dma_ops(dev, IOVA_START_PFN << PAGE_SHIFT, 0);
+		iommu_setup_dma_ops(dev, IOVA_START_PFN << PAGE_SHIFT, U64_MAX);
 	else
 		set_dma_ops(dev, NULL);
 }
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7bcdd1205535..c62e19bed302 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -319,16 +319,16 @@ static bool dev_is_untrusted(struct device *dev)
  * iommu_dma_init_domain - Initialise a DMA mapping domain
  * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
  * @base: IOVA at which the mappable address space starts
- * @size: Size of IOVA space
+ * @limit: Last address of the IOVA space
  * @dev: Device the domain is being initialised for
  *
- * @base and @size should be exact multiples of IOMMU page granularity to
+ * @base and @limit + 1 should be exact multiples of IOMMU page granularity to
  * avoid rounding surprises. If necessary, we reserve the page at address 0
  * to ensure it is an invalid IOVA. It is safe to reinitialise a domain, but
  * any change which could make prior IOVAs invalid will fail.
  */
 static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
-		u64 size, struct device *dev)
+				 dma_addr_t limit, struct device *dev)
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	unsigned long order, base_pfn;
@@ -346,7 +346,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	/* Check the domain allows at least some access to the device... */
 	if (domain->geometry.force_aperture) {
 		if (base > domain->geometry.aperture_end ||
-		    base + size <= domain->geometry.aperture_start) {
+		    limit < domain->geometry.aperture_start) {
 			pr_warn("specified DMA range outside IOMMU capability\n");
 			return -EFAULT;
 		}
@@ -1308,7 +1308,7 @@ static const struct dma_map_ops iommu_dma_ops = {
  * The IOMMU core code allocates the default DMA domain, which the underlying
  * IOMMU driver needs to support via the dma-iommu layer.
  */
-void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size)
+void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
 {
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 
@@ -1320,7 +1320,7 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size)
 	 * underlying IOMMU driver needs to support via the dma-iommu layer.
 	 */
 	if (domain->type == IOMMU_DOMAIN_DMA) {
-		if (iommu_dma_init_domain(domain, dma_base, size, dev))
+		if (iommu_dma_init_domain(domain, dma_base, dma_limit, dev))
 			goto out_err;
 		dev->dma_ops = &iommu_dma_ops;
 	}
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index be35284a2016..85f18342603c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5171,7 +5171,7 @@ static void intel_iommu_probe_finalize(struct device *dev)
 
 	if (domain && domain->type == IOMMU_DOMAIN_DMA)
 		iommu_setup_dma_ops(dev, base,
-				    __DOMAIN_MAX_ADDR(dmar_domain->gaw) - base);
+				    __DOMAIN_MAX_ADDR(dmar_domain->gaw));
 	else
 		set_dma_ops(dev, NULL);
 }
-- 
2.31.1

