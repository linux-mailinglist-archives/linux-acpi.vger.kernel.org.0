Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F395330243A
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Jan 2021 12:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbhAYL10 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Jan 2021 06:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbhAYLMg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jan 2021 06:12:36 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C68C0617A7
        for <linux-acpi@vger.kernel.org>; Mon, 25 Jan 2021 03:08:48 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id i9so3925442wmq.1
        for <linux-acpi@vger.kernel.org>; Mon, 25 Jan 2021 03:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0HAbfAEz8TnDqiVsICUxE3hnnLknlvV/GMLCZp7lxlM=;
        b=rSVIjdC8auMNf3CzZHMj2V5f//KBePOMSE1xJsfhrdqnk+R7tLKov8OtTs4OoGyGCz
         tAhzdrunXOWEUWgI/eb8yjnFbAsLVxgel2IAvs86EletOyYtNUovgXfYIV/Mx1Fi3mdR
         7+g6OkoWx1rQ61ah5fpmX3QQHoF8QWYU4/iT+iSly7H2QW+JG+Gv4HbeLoheGKRPUKjf
         SOCKdkQlMv+MModmy88QGqNISODCenboQjcS5OLpyPGnhdTdQnAug522uBBWgWOHnUoc
         SiOrsSKcq9FBUMUmBZvZT7pj6bYmnWHY2BJjKW8gIDFP/J+hu+5xrm+Atpu14Y4SUVc2
         cHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0HAbfAEz8TnDqiVsICUxE3hnnLknlvV/GMLCZp7lxlM=;
        b=Ay7WnCcbcibiZFuV8+ok8OUTc30DwZejvJDKAm2+CbhedFcwzlZXTEjeLcuzgIwxxS
         imaJzlD6tpVU0XClSaMrXUhhzEOsmGv5wd660Px/lEsW1B6WOBv0K1hMtfkpNNaxZ/pz
         gG17w8hp/qIAFk9dx0fgNiPsfZ/j56zyieroquAWHPpbErFQRSLwZB9ICmMDacuCiKfy
         nym2ePCiLJvHYvk1ZnW9lmEpBT0LrTy96/ayKJFfUsOBHgzoa73jpikskYQRhYA6p8/A
         QPRSxunqEZzBkSlYhPblcmuIwThk76Bc8bLjUoQ3R0qCni1SBTgLx/EsTgruQ5O2c4Dj
         1iXg==
X-Gm-Message-State: AOAM533WBTi3pe144QeuCdrjeN/jjp/dB0MqZDo6IAdfqe3NQje8TZ8v
        kOP+ZPmAdhcYQJLrS51fhKHtdw==
X-Google-Smtp-Source: ABdhPJxW3kalVcKronU/Bq3GDFRBFh6XnccMSbY4dwqLUi+K5Jm1MMI2u1qjVqMNJzzSkl044nm5ug==
X-Received: by 2002:a1c:7312:: with SMTP id d18mr2104533wmb.155.1611572926856;
        Mon, 25 Jan 2021 03:08:46 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id u6sm16636014wro.75.2021.01.25.03.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 03:08:46 -0800 (PST)
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
Subject: [PATCH v11 04/10] iommu/vt-d: Support IOMMU_DEV_FEAT_IOPF
Date:   Mon, 25 Jan 2021 12:06:45 +0100
Message-Id: <20210125110650.3232195-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210125110650.3232195-1-jean-philippe@linaro.org>
References: <20210125110650.3232195-1-jean-philippe@linaro.org>
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

