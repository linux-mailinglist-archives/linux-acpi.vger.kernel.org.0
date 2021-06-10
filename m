Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248A83A262D
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jun 2021 10:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFJIGI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Jun 2021 04:06:08 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:42778 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhFJIGF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jun 2021 04:06:05 -0400
Received: by mail-wr1-f46.google.com with SMTP id c5so1134464wrq.9
        for <linux-acpi@vger.kernel.org>; Thu, 10 Jun 2021 01:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FJBc4XHO8GWouyeNxEp4BksscCRnIRbJmCxL/Ho6xNQ=;
        b=gU/Ryt42Y4L8Qp2x4zkGmAWsnlMV2urCBzSFHee9R5LvVighC/9rUJhESGZ9a01xq1
         oHASaXq1yQegw1GEOgSrwev0K9L4dtJfB1/izSl/mO7JPn42KlbmwnjFmf2VAimfcVro
         y4bEILLbmi5TtrYBTBr/NsStPwbf+faeN04dStHpGfSdTMYbjNDEQBl5+TJpOZ3MW//u
         Myu6MnpiyjjoAgkFk/Is7V+9lvPzZ8qPMXQtnOdtD1fuc2na97yerJalm+kT29FPETUV
         PgRlnp+36UI5Jzn/PoxE5HrlAq0qsWl3IjeuKyAAIod2yg2sNnomolBdGI01fpDSLEdC
         TEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FJBc4XHO8GWouyeNxEp4BksscCRnIRbJmCxL/Ho6xNQ=;
        b=Gn0k4XTQmIJVjxUT4fi/lMtfoCRnoXuP00Py4PE12lgCzrCbqC9ePzNr/+2JKEgULq
         QCZaZOnib1C8ZrL7FuNPt/CwpHzhuYcCF7inFoXwUkpfHI3no5XJzLkYDmetmkK9708n
         TN5rJEkZYYA4Qa/HY4Wf7f3BAB8HsawWX0qLYV8/6CboxQ+GUTzhPcHvmDbBef4pqyAA
         kYJoDcEdqFMCf4ipHBTBFfEOA5ZyVGDSHfX4wugaKxEwTGBQELiIFYhRrTDFTRvwx0iL
         SRgpgYC7D1+kazGSvciyZx457L6ksEwAvc+LverdTKRX8IUjBinNB/ouci8w7KcCAKOI
         nqmg==
X-Gm-Message-State: AOAM530pqJDmnmqp2bNG68UJJcwuPrtuKBzedrwMFs5WcHZphVi3Dm/Y
        vYNuY2IO41mqzt26INuktl1/Qg==
X-Google-Smtp-Source: ABdhPJwlkaaI7SJCgaZV7OEfblhli4jlnFL/3UcuvdXNz9ii3FGJkj1asIZoobCQXGL2eBrVB559+A==
X-Received: by 2002:adf:f1ca:: with SMTP id z10mr3965395wro.396.1623312172834;
        Thu, 10 Jun 2021 01:02:52 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id o3sm2715059wrm.78.2021.06.10.01.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 01:02:52 -0700 (PDT)
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
Subject: [PATCH v4 5/6] iommu/dma: Simplify calls to iommu_setup_dma_ops()
Date:   Thu, 10 Jun 2021 09:51:32 +0200
Message-Id: <20210610075130.67517-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210610075130.67517-1-jean-philippe@linaro.org>
References: <20210610075130.67517-1-jean-philippe@linaro.org>
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

