Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BA932A4C6
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Mar 2021 16:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446517AbhCBLRo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Mar 2021 06:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379047AbhCBJiz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Mar 2021 04:38:55 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16767C0617AB
        for <linux-acpi@vger.kernel.org>; Tue,  2 Mar 2021 01:35:36 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id o16so1951921wmh.0
        for <linux-acpi@vger.kernel.org>; Tue, 02 Mar 2021 01:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fAwFmceeI8PT69Qzv7BbL234cbzlwFiSG33CnDCXBuk=;
        b=pVUo6Je1O9n09zMy7XzMnOeoxCf2gwvJSFjHsUpFlcN2ASmVQotVn/P3GJaA2vMsPG
         5Oa73C/bPbSORaAchXIQza2ekIiLHAMzhiBZSlMfN6WbI9De+lb3VRTl3rQ2yQVlngcr
         V2RHEDDpBUjaRbWMvhc/3ySgIrurqPttQruKNTQF2GytX5XdWxpKNvyRtIS3TzMszIvc
         JBZB4CBm0UCJiSKiLxjvSyjWHHMuuOuEHyTWoD+ba6Xp8wX8IFgRMCwyw68DBIQ5z2iC
         eWdpOaKbSD5yQITmiRYw1xTk99A7N0QY50S3SPObJAaXzoV7J2H4ZrpqEenmZmu1CZJM
         pCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fAwFmceeI8PT69Qzv7BbL234cbzlwFiSG33CnDCXBuk=;
        b=Q5NMGlXfS1ximYQp76HpDpinkFPilr/b5oXC0pNtVTYky0gyVMeM61HoCgsxCj2kvx
         WjAbd65YqEtW8LU7xpSkvI3OpAg44lk2dhUV0MLKZ/jDL4zkdRCKVfwuEWGp0ffry5HX
         nQQB8XHhWaT0NVkQZG3f3WsnVl8trMq8+ocfagL7gSjGKUwgUq6A8Ly1koKpJC9r0M8E
         0sYgYTeipUrHhz5XFb+y0JqVvqZxVErjQr/3e3qn8V2htf7jnrHeic1BWN9ZDT0txGWF
         T6elnQ2HDo6K3Z7s+AuUICDNmSKtwCxMlksCBjWeIEwLIpFJ1BF8Zu7Tm4uqL7oeJwzY
         9yHQ==
X-Gm-Message-State: AOAM530epzj/DpWBsEvgjHfVuVsnH3V392jZZA7L+XC2omicI0Bb7P5n
        KRRI4uo9ZPhCuQ4KrCfo2GUNpA==
X-Google-Smtp-Source: ABdhPJwrpaQozpbifmdBMiCZvNYDUDCjs8CDLKRQmFMc/2Y3eNN20yvyuRxJXyxFUTgbOPqB1BFNww==
X-Received: by 2002:a1c:a504:: with SMTP id o4mr3053405wme.174.1614677734793;
        Tue, 02 Mar 2021 01:35:34 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id w131sm1963818wmb.8.2021.03.02.01.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 01:35:34 -0800 (PST)
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
Subject: [PATCH v13 04/10] iommu/vt-d: Support IOMMU_DEV_FEAT_IOPF
Date:   Tue,  2 Mar 2021 10:26:40 +0100
Message-Id: <20210302092644.2553014-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302092644.2553014-1-jean-philippe@linaro.org>
References: <20210302092644.2553014-1-jean-philippe@linaro.org>
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
2.30.1

