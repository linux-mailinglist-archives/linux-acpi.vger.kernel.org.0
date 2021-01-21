Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F912FEA5B
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Jan 2021 13:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbhAUMlb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jan 2021 07:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731362AbhAUMlD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Jan 2021 07:41:03 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF8EC061795
        for <linux-acpi@vger.kernel.org>; Thu, 21 Jan 2021 04:39:37 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q7so1568505wre.13
        for <linux-acpi@vger.kernel.org>; Thu, 21 Jan 2021 04:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QfRTrz4FGk7QYqRZvdYQ9j81IIMEaiK0cgAthveICn8=;
        b=cQVnXvxX7ce/tzwytyh2JzCq/8Uvcz1sgn8551t6FHNYSocO2Z8CA5Md0RYrty9/sf
         nR6zspWcun7taP7uDmLQGB4dhSWd4vlipzyyro8VdoBvmhAslUAmXXj6+BTkMz0n4g0q
         lSslcyqBhYjQfDWJrU6sXGAkgm3RdOPPyy9Zo47zOtXrWTAC68UoEBDxiMOlMiUlyL5O
         PNB0hOVIM6X+zwo2F+PuCWADDNaEOQPSWdtsEwKwRAWSqpM4RVF9Ykz6/lG4JpCtE3gT
         4ekdEy5fqlNKQzZRRKDBXyC9IQt+M7xT7yIuHJrTNfvc5HSTIPh6fc16Jg7c5b19PamU
         MEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QfRTrz4FGk7QYqRZvdYQ9j81IIMEaiK0cgAthveICn8=;
        b=OOGKLC7ZuIYlwLwzSBszzRh1C7J98wIaAgtPNChPVJnrmNnt70aPEB1jF7yfd1va09
         U5ARwBT4K+rqMxURjYblsqMQdbidKSt4n0tQewJAZOZFvfapU64bfyWaL1AaNZ05bQ/F
         NDsOv8fBxWZPZ5g0DtY6gyny+z7nNeuj+rsMNcxEQr0aqL2rictZpVf2SgePwYjtmKMv
         9eSjeQ2zMO0+UEGZraQlCSDcKxQRnb7hGe3UhTWdMOU/o7gP5fRccMPg5MxbvgtOSzYC
         /0k1KDcpIs0vYnzN8GGmib4OpqAsXESEUVR5GAnvk/21wWUsrXWjxoTlBqRzCyjiduA/
         o1ig==
X-Gm-Message-State: AOAM530novk8o6J5rMPDuIDUgjWWUulvY9XMDVG67JVPCa6GMBW45H39
        wynEBJTaTPoI3q4XXGhLYQdtMQ==
X-Google-Smtp-Source: ABdhPJwSIF4lYkXg0JDArr7VyYpWpZBMJebamCEs4XGcl3wSjZlLaAvAoz8hiztLDcsi8cTAFpm1/g==
X-Received: by 2002:a5d:504d:: with SMTP id h13mr14277328wrt.246.1611232776100;
        Thu, 21 Jan 2021 04:39:36 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id p18sm7979248wmc.31.2021.01.21.04.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 04:39:35 -0800 (PST)
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
Subject: [PATCH v10 04/10] iommu/vt-d: Support IOMMU_DEV_FEAT_IOPF
Date:   Thu, 21 Jan 2021 13:36:18 +0100
Message-Id: <20210121123623.2060416-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121123623.2060416-1-jean-philippe@linaro.org>
References: <20210121123623.2060416-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Allow drivers to query and enable IOMMU_DEV_FEAT_IOPF, which amounts to
checking whether PRI is enabled.

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

