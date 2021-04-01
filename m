Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9173518A1
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Apr 2021 19:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbhDARqk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Apr 2021 13:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbhDARmR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Apr 2021 13:42:17 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03DBC02D558
        for <linux-acpi@vger.kernel.org>; Thu,  1 Apr 2021 08:48:18 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j18so2303110wra.2
        for <linux-acpi@vger.kernel.org>; Thu, 01 Apr 2021 08:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sUWtTRDLrHxGgocdCnYzpMC09q0TV2vzmGZT++QRllg=;
        b=iglZ+Ee6thHgb0bhSj83X5eaiV9O2aLtAksg9FEqCkLGGs18RszyBaVuM1/s8cdLcC
         IC6YDWk+v/FZKsUaiwqmmv146BYVIt0m70lItcr2N0SuGaAkzdNF3M0tRz+11Qokz7l1
         lskzXakxl9mU3PS1s7L4BTyQ0eK93mtQnY+okmAo1IBlpkX6MrRL5ciIT6uPpZOEsdD7
         PCYWlLuq1ic0CY7/r/lsDmNH5/RrrfsKoLfLEEgEJuPQWWhMYaCZQy43ZW4xaUV9U5L9
         l8OeftUntEw+OtfNSMz85YRfPFW3x1uIs2+8p5Y2Nn2nZOTnnwMJIelLUA576ha6F+yf
         17tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sUWtTRDLrHxGgocdCnYzpMC09q0TV2vzmGZT++QRllg=;
        b=D/29EJnNb7Djnm+sSD8WfuybJ5nXllEhBwcC2QdLKX1uFXk2LVvwlUoi2E4RU7MsvD
         3Ah0YVRDjyEYqndtmmVpr3RVNB0xV8l1Uv1RNTmf811fCojdytMWkechjtlonCExdd1a
         wUyLOwq5ob7+poxWYMslTdokdHBR0lLxGD9cKcA968pIyN+MlPnUMa/Ee+XRU0ONGMiy
         eF0D1YzhDCFpcCifZdFO5wln4/wUsPH4aaTwDMqnmJMFe+uKXRCpsuovmF1gto5AaEpS
         KAJ+/5YNZGmbxszHptXxmstPxtpnmK8RSTF2Ckz1Lpx2DpatXI/jg2QsrnCcB0qUXfB9
         uMLA==
X-Gm-Message-State: AOAM533FspHm5KPXJ3S6VaJa89qT0TALNJBlIe2E6A4sWI+bWvSuVzO2
        5le5fcVM1xWl2YXSvIM4dOqsrQ==
X-Google-Smtp-Source: ABdhPJz1Rfdsjw9gzRYBDHIMKFUYkmB2ZhwgBz9419vLWB1onBeKqnNMtOUXwIBAc9XzC92qWWLxhQ==
X-Received: by 2002:a5d:5047:: with SMTP id h7mr10862243wrt.111.1617292097577;
        Thu, 01 Apr 2021 08:48:17 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id y8sm8722505wmi.46.2021.04.01.08.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:48:17 -0700 (PDT)
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
        zhukeqian1@huawei.com, wangzhou1@hisilicon.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v14 04/10] iommu/vt-d: Support IOMMU_DEV_FEAT_IOPF
Date:   Thu,  1 Apr 2021 17:47:13 +0200
Message-Id: <20210401154718.307519-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210401154718.307519-1-jean-philippe@linaro.org>
References: <20210401154718.307519-1-jean-philippe@linaro.org>
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
index ee0932307d64..c5c5fd444779 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5343,6 +5343,8 @@ static int siov_find_pci_dvsec(struct pci_dev *pdev)
 static bool
 intel_iommu_dev_has_feat(struct device *dev, enum iommu_dev_features feat)
 {
+	struct device_domain_info *info = get_domain_info(dev);
+
 	if (feat == IOMMU_DEV_FEAT_AUX) {
 		int ret;
 
@@ -5357,13 +5359,13 @@ intel_iommu_dev_has_feat(struct device *dev, enum iommu_dev_features feat)
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
@@ -5374,6 +5376,9 @@ intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
 	if (feat == IOMMU_DEV_FEAT_AUX)
 		return intel_iommu_enable_auxd(dev);
 
+	if (feat == IOMMU_DEV_FEAT_IOPF)
+		return intel_iommu_dev_has_feat(dev, feat) ? 0 : -ENODEV;
+
 	if (feat == IOMMU_DEV_FEAT_SVA) {
 		struct device_domain_info *info = get_domain_info(dev);
 
-- 
2.31.1

