Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACAAF36918C
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 13:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhDWL5j (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Apr 2021 07:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhDWL5f (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Apr 2021 07:57:35 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA95C06174A
        for <linux-acpi@vger.kernel.org>; Fri, 23 Apr 2021 04:56:59 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n4-20020a05600c4f84b029013151278decso1064105wmq.4
        for <linux-acpi@vger.kernel.org>; Fri, 23 Apr 2021 04:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I/trhSE6y6Y4tDuE2sk5DuZOlkIOvXsegzt8mA8VmJ0=;
        b=Lovu0ihGApeyFpxtgvSIg+rb/YQtEIE/Mw2PYDYzX//yT9/GkRvDqYeKzJCInDmD06
         CvQH/h1V2qL0xToqgg8GYiiMXNpipQqi9sk1LaaxPOWzY661jZl73a8wkaY4QCDfpA+n
         1+uEqa5V0V6iAOOHbgIid20FdMbz41uOQn/lui5KCGymadEY0jMLD/3JanbM3FNGhfow
         QpBSyNFCU0SXL1+h/40RMiS9YS1jQal3uZiMeTzSwkO4/yiMkjR/FSdOI0dXp/wyKA1d
         Dl5cad5PmOP5yr5spJLRHn40KzML+YvmpIyvLl1iRzL5VqT/0UR3xGeOIUYet4YV0mnN
         p+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I/trhSE6y6Y4tDuE2sk5DuZOlkIOvXsegzt8mA8VmJ0=;
        b=sfhz5R0Cm692d1btCwZld8a13LVIf4+4q5Qhzulf+PNFzicbDUPyOuc4bt5JzEcezT
         hS9CIa2JBwvNNYoQVTuXwH9fda+5bP+8tiBrCtdcGuYp0TL1DlTSdA/geEh3VaiJA8r2
         vVM7W+qfrU+0VuqmCgvjaTCvrRPb/6M3mPZsyaPrRA5axcBL8s6KbvdCxnIsk3qWI24e
         1A3Rp5hBayK2WojIcfBJyeTIwW9xSD3mYIsolfHDy3pIZQA7lXjeJOncHfjbOnBpjiXr
         4NlTg3clynJsMnujoV88IXLIxuO+4M5du1tqUeuUVGWFjy+lqRk3jVBTc92vHwDRqCEG
         1gtQ==
X-Gm-Message-State: AOAM533owtc9TZ0D4/CnK5sQcIjalZEbnbTOIBu9F5/Yy6kPOigjfbo2
        uQQIFFCqmUMK2+o62l/5KNLcHZDDlJn5FK2M
X-Google-Smtp-Source: ABdhPJzX2NU0Oaoj5S34aoNhCvVi36QRFwDALrI3TpnnO4mOTYukcRM3GgXIbYly11+ifgWORhu4oQ==
X-Received: by 2002:a1c:3587:: with SMTP id c129mr3760936wma.80.1619179017764;
        Fri, 23 Apr 2021 04:56:57 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id g9sm7485195wmh.21.2021.04.23.04.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 04:56:57 -0700 (PDT)
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
Subject: [PATCH v2 4/6] iommu/dma: Pass address limit rather than size to iommu_setup_dma_ops()
Date:   Fri, 23 Apr 2021 13:38:35 +0200
Message-Id: <20210423113836.3974972-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210423113836.3974972-1-jean-philippe@linaro.org>
References: <20210423113836.3974972-1-jean-philippe@linaro.org>
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
index 93e87b287556..83f4f4bad5e4 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -50,7 +50,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 
 	dev->dma_coherent = coherent;
 	if (iommu)
-		iommu_setup_dma_ops(dev, dma_base, size);
+		iommu_setup_dma_ops(dev, dma_base, size - dma_base - 1);
 
 #ifdef CONFIG_XEN
 	if (xen_initial_domain())
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 67da96d5b3c2..50041df43391 100644
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
index 708f430af1c4..39a4e672b1c2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5166,7 +5166,7 @@ static void intel_iommu_probe_finalize(struct device *dev)
 
 	if (domain && domain->type == IOMMU_DOMAIN_DMA)
 		iommu_setup_dma_ops(dev, base,
-				    __DOMAIN_MAX_ADDR(dmar_domain->gaw) - base);
+				    __DOMAIN_MAX_ADDR(dmar_domain->gaw));
 	else
 		set_dma_ops(dev, NULL);
 }
-- 
2.31.1

