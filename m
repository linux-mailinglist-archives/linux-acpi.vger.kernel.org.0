Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0723D2EF469
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Jan 2021 16:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbhAHPDu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Jan 2021 10:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbhAHPDt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Jan 2021 10:03:49 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFAAC06129D
        for <linux-acpi@vger.kernel.org>; Fri,  8 Jan 2021 07:02:33 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 190so8073896wmz.0
        for <linux-acpi@vger.kernel.org>; Fri, 08 Jan 2021 07:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uvwNHFhdLkaGBie88gzRCcyxfKIG/LYZ2PnvLPGSu2c=;
        b=ISNeho54rmu9ZyTuqnuYWjhj+2mILy1TMBGrvs7XzZBRVbUOjGi1bOIxR1vq9L5T/8
         hACv21cvz6C71l/cwPP5kPHWLxhGTpq32HVVUmyFMxuPuq5CR8U0R0Wo/te2LrbO7RBs
         W144EpMmuqZtpFpBJDVA0rFb+nydLeQLKFNQUvZxLKMfgAeaaBn73IPU+bdDMdLLrLmM
         ESlBzKA0NUJUQ5ZRZ814zmJdf0mjDHRnUXHD22TVzxEIFrd0rvhS3y02u9CyXLaLQ/kD
         AoZFQoQi8qql0RIgbg4vTAOQSj97X/8XrSet3WM6HG0qznl4idxYu7ZZyjBhX5oxfAhK
         kmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uvwNHFhdLkaGBie88gzRCcyxfKIG/LYZ2PnvLPGSu2c=;
        b=nMkFPubt0v4gRFyxQYhO4k+8YhA8Y+cdV5DinAsIxbFxL0FMmDLjpMf7nQDJ6cO5jq
         XcleqD5m4HvsVP8fBnjTdGXKfKEsdhvmtg9piMxkzAXcUpXeFlScRbigQRc5nc37RBog
         obAog0HS4V+imwwZNWuBTMUNU0oFzyzuzQEtZfxsg69Ib7U0+C5CBa+AFfZl5THSqVT5
         iAcfNfM8Rh0Z+QnYPOZRsYZ7vmCNcY8IjrDTA7MBWCflbj2dVKEcy6v77xM0nJDgRv5M
         A0Z9gsJtah8NJWBDJKN1nMzBL88og9A5qfb43zkl0RLK7gWk5ZgDgNjkHRpwVg61n1L9
         VeGw==
X-Gm-Message-State: AOAM533b4sl5Fg0Qnn4vfyOqQsvjCDKkJcy9IckvdHWjDcN94pOVC//q
        Gpt5ok8+huXTCTjojEmpMRGe6Q==
X-Google-Smtp-Source: ABdhPJymvMLKfx6JMwWQypvMx10zrT/uAgWw60V8JEcHGqofEYBbCwP/8ch5rpewZaM7KRA+nDGSgA==
X-Received: by 2002:a05:600c:2042:: with SMTP id p2mr3504371wmg.152.1610118152176;
        Fri, 08 Jan 2021 07:02:32 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id s13sm14258464wra.53.2021.01.08.07.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 07:02:31 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     joro@8bytes.org, will@kernel.org
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, Jonathan.Cameron@huawei.com,
        eric.auger@redhat.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-accelerators@lists.ozlabs.org, baolu.lu@linux.intel.com,
        vdumpa@nvidia.com, zhangfei.gao@linaro.org,
        shameerali.kolothum.thodi@huawei.com, vivek.gautam@arm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH v9 03/10] iommu: Separate IOMMU_DEV_FEAT_IOPF from IOMMU_DEV_FEAT_SVA
Date:   Fri,  8 Jan 2021 15:52:11 +0100
Message-Id: <20210108145217.2254447-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210108145217.2254447-1-jean-philippe@linaro.org>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some devices manage I/O Page Faults (IOPF) themselves instead of relying
on PCIe PRI or Arm SMMU stall. Allow their drivers to enable SVA without
mandating IOMMU-managed IOPF. The other device drivers now need to first
enable IOMMU_DEV_FEAT_IOPF before enabling IOMMU_DEV_FEAT_SVA.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Will Deacon <will@kernel.org>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
---
 include/linux/iommu.h | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 583c734b2e87..701b2eeb0dc5 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -156,10 +156,24 @@ struct iommu_resv_region {
 	enum iommu_resv_type	type;
 };
 
-/* Per device IOMMU features */
+/**
+ * enum iommu_dev_features - Per device IOMMU features
+ * @IOMMU_DEV_FEAT_AUX: Auxiliary domain feature
+ * @IOMMU_DEV_FEAT_SVA: Shared Virtual Addresses
+ * @IOMMU_DEV_FEAT_IOPF: I/O Page Faults such as PRI or Stall. Generally using
+ *			 %IOMMU_DEV_FEAT_SVA requires %IOMMU_DEV_FEAT_IOPF, but
+ *			 some devices manage I/O Page Faults themselves instead
+ *			 of relying on the IOMMU. When supported, this feature
+ *			 must be enabled before and disabled after
+ *			 %IOMMU_DEV_FEAT_SVA.
+ *
+ * Device drivers query whether a feature is supported using
+ * iommu_dev_has_feature(), and enable it using iommu_dev_enable_feature().
+ */
 enum iommu_dev_features {
-	IOMMU_DEV_FEAT_AUX,	/* Aux-domain feature */
-	IOMMU_DEV_FEAT_SVA,	/* Shared Virtual Addresses */
+	IOMMU_DEV_FEAT_AUX,
+	IOMMU_DEV_FEAT_SVA,
+	IOMMU_DEV_FEAT_IOPF,
 };
 
 #define IOMMU_PASID_INVALID	(-1U)
-- 
2.29.2

