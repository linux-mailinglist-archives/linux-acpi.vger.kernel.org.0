Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A4030601F
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Jan 2021 16:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbhA0Prk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Jan 2021 10:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbhA0Ppg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jan 2021 10:45:36 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04200C061797
        for <linux-acpi@vger.kernel.org>; Wed, 27 Jan 2021 07:44:40 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id g10so2413707wrx.1
        for <linux-acpi@vger.kernel.org>; Wed, 27 Jan 2021 07:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0HAbfAEz8TnDqiVsICUxE3hnnLknlvV/GMLCZp7lxlM=;
        b=ad/j4aBI/T3WQEdCN+D6UAssRoPtamKNCApTqJ4FK8vTOMCdUIsdNHY5IzN6j1WbgY
         +8re948rFqrdclQrOU+JQ7TK+1NZcyhl5Aw0t9A0R1Lxy2hKotqfrnQ/TcKW9OYoflRv
         aCDaEnJAJO/9z9KFs4OidYWk8o/9ptYrG9b6u4M/reWw2gwF1+9/jnnx8yRw4vkuau5W
         1o19RF+k1Mb91K5dJ4y+iYEQG9SvHHUf4d0+zb3Lxt4NOo2rs2euYSb+wQGCwe6OEE3C
         1352Mdoft0AYtZ72LLDVh3bk+vfGO2y3Vj5eB8jtgQZy7Kor4+bbXI2vnPnyWLGJuU2b
         VWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0HAbfAEz8TnDqiVsICUxE3hnnLknlvV/GMLCZp7lxlM=;
        b=I5lA31P/5Z8vxmDm5B1ReML4qMxkAqVpe6lm7ecJQejoi5Dzw9m7Gmi0QCmCjNVkc2
         /YMbLdkgFwPDkWTSUsBay/m5UKkn41NqWxIiZYZsLEpS2fGOVfnzZ2m/0OA0AlD8Y0Hm
         pmBDtO+AXUi5SKIX6mGkVSSn9hChLU9Vdj0Qmdja2iU+chxXQ3R116kLRz6kBYpcRRDh
         chbTnrvv448tfP3ZLKcBjZdCIpVs+hOQzX/c67IsGj8QK0rCvSkb6a9K8l1gtjiAz9DD
         UJmdaeewS64mpvXj35k5hHgNRjrN+0A40RUlgE5W4Do1HvFmNgkT/4jtaffXUqmPKxYg
         ZGzQ==
X-Gm-Message-State: AOAM5325cD0wrRHBrbUEPok9HG06tOsUEVzoHg0aWxQ1ymGDFWT0nD+0
        wcEXkxCD+J6K5s8wOGoM4vX0oQ==
X-Google-Smtp-Source: ABdhPJxbp7bo3QjbnBits7bgWrNsTaylW9bW8JBsHqc833dGFAfY18iRqP1/Sk6YqyELC3Kkzp0OAA==
X-Received: by 2002:adf:fc8a:: with SMTP id g10mr12217200wrr.189.1611762278786;
        Wed, 27 Jan 2021 07:44:38 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id r13sm3046921wmh.9.2021.01.27.07.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 07:44:38 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     joro@8bytes.org, will@kernel.org
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, Jonathan.Cameron@huawei.com,
        eric.auger@redhat.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-accelerators@lists.ozlabs.org, baolu.lu@linux.intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        vdumpa@nvidia.com, zhangfei.gao@linaro.org,
        shameerali.kolothum.thodi@huawei.com, vivek.gautam@arm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v12 04/10] iommu/vt-d: Support IOMMU_DEV_FEAT_IOPF
Date:   Wed, 27 Jan 2021 16:43:17 +0100
Message-Id: <20210127154322.3959196-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210127154322.3959196-1-jean-philippe@linaro.org>
References: <20210127154322.3959196-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Allow drivers to query and enable IOMMU_DEV_FEAT_IOPF, which amounts to
checking whether PRI is enabled.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f665322a0991..c777bd94df5d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5330,6 +5330,8 @@ static int siov_find_pci_dvsec(struct pci_dev *pdev)
 static bool
 intel_iommu_dev_has_feat(struct device *dev, enum iommu_dev_features feat)
 {
+	struct device_domain_info *info = get_domain_info(dev);
+
 	if (feat == IOMMU_DEV_FEAT_AUX) {
 		int ret;
 
@@ -5344,13 +5346,13 @@ intel_iommu_dev_has_feat(struct device *dev, enum iommu_dev_features feat)
 		return !!siov_find_pci_dvsec(to_pci_dev(dev));
 	}
 
-	if (feat == IOMMU_DEV_FEAT_SVA) {
-		struct device_domain_info *info = get_domain_info(dev);
+	if (feat == IOMMU_DEV_FEAT_IOPF)
+		return info && info->pri_supported;
 
+	if (feat == IOMMU_DEV_FEAT_SVA)
 		return info && (info->iommu->flags & VTD_FLAG_SVM_CAPABLE) &&
 			info->pasid_supported && info->pri_supported &&
 			info->ats_supported;
-	}
 
 	return false;
 }
@@ -5361,6 +5363,9 @@ intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
 	if (feat == IOMMU_DEV_FEAT_AUX)
 		return intel_iommu_enable_auxd(dev);
 
+	if (feat == IOMMU_DEV_FEAT_IOPF)
+		return intel_iommu_dev_has_feat(dev, feat) ? 0 : -ENODEV;
+
 	if (feat == IOMMU_DEV_FEAT_SVA) {
 		struct device_domain_info *info = get_domain_info(dev);
 
-- 
2.30.0

