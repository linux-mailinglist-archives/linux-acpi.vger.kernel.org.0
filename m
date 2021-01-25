Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF03302435
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Jan 2021 12:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbhAYLZr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Jan 2021 06:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbhAYLMg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jan 2021 06:12:36 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5C0C061794
        for <linux-acpi@vger.kernel.org>; Mon, 25 Jan 2021 03:08:46 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id m1so11179438wrq.12
        for <linux-acpi@vger.kernel.org>; Mon, 25 Jan 2021 03:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uiSdj3ahcV4jfiq23D9UAVEBduTBnIEfUfM+Rzx87y0=;
        b=o1trokFtSTCfvkocLi895coCTyzkTkfVye5g5jBBpjAgejVTdH5D1p5iBs5mtxk5kx
         mn6KNV0w7qjzSiXB1pheQswkz5HrDXxVo3wDWV5rM/ULRbJ1r3psOC3kaJ/pE4BmTo36
         HPLBwStDbURpW834zKOhjGc51y2kENbOdl5bZvNk+Hz9cjGYWNACLOU7IA/iXFH3SHIP
         yiu6DtXmE6rzyuRYBY2OIUHos1ZOqe0LMFDLcDopc70vRuGNN8t4ia4kUd7an+ncEQwD
         dvpm1J7Ho4IXV8x4cXbBE8WbeXlwGKe2KLODyr6dUadfFvfEr8JoTpffCM0YnSwz9oK3
         Rmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uiSdj3ahcV4jfiq23D9UAVEBduTBnIEfUfM+Rzx87y0=;
        b=au4gO4XzW41phTTT6g4h5FxK/YgQJDEy9vM3BF68rMWqjMkbYSMbUUBR7/dIBk6Eap
         b8M54KIzkDen1CSU7tyuHu70CCyVFQvyz5456CtoaCT1OBJDRuvVzxtcJyu3mJWcFVRz
         GZ4dNqIkICX3B8IVZf/gPzT7bN7nH/qI7LkTiOVo0f1JfsH8hUTEVmsoOyy1BYjKlnaD
         IHd5p7+2ZBqWr8KCVUFqyOYT2h3RqZvdBTtDwU6mgbpWh6aIJO02NkUvacJtlPaid05e
         vash7MSvMRdUB3nYc+nTd1iJmxtHZKsgQzJ15MFBRMzQxXByX2uQeQeWEMy/XPaPCHSk
         5psQ==
X-Gm-Message-State: AOAM532O2zTlX9eGhdzJWSPo6Bmb4gDJKIWll2NLzIw9AKp+shR+JAZF
        EMmD+rUsnAGl94RB7Bs69zLnCg==
X-Google-Smtp-Source: ABdhPJwwlQQTzJJVFrK3jv6EdbzkxepXZyhe6MIPrsPL57ZER4N2Q2U1BVzXSW+FFTj3InzYFSgEFQ==
X-Received: by 2002:adf:e807:: with SMTP id o7mr334734wrm.308.1611572925581;
        Mon, 25 Jan 2021 03:08:45 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id u6sm16636014wro.75.2021.01.25.03.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 03:08:45 -0800 (PST)
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
        Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH v11 03/10] iommu: Separate IOMMU_DEV_FEAT_IOPF from IOMMU_DEV_FEAT_SVA
Date:   Mon, 25 Jan 2021 12:06:44 +0100
Message-Id: <20210125110650.3232195-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210125110650.3232195-1-jean-philippe@linaro.org>
References: <20210125110650.3232195-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some devices manage I/O Page Faults (IOPF) themselves instead of relying
on PCIe PRI or Arm SMMU stall. Allow their drivers to enable SVA without
mandating IOMMU-managed IOPF. The other device drivers now need to first
enable IOMMU_DEV_FEAT_IOPF before enabling IOMMU_DEV_FEAT_SVA. Enabling
IOMMU_DEV_FEAT_IOPF on its own doesn't have any effect visible to the
device driver, it is used in combination with other features.

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
index b7ea11fc1a93..00348e4c3c26 100644
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
+ * @IOMMU_DEV_FEAT_IOPF: I/O Page Faults such as PRI or Stall. Generally
+ *			 enabling %IOMMU_DEV_FEAT_SVA requires
+ *			 %IOMMU_DEV_FEAT_IOPF, but some devices manage I/O Page
+ *			 Faults themselves instead of relying on the IOMMU. When
+ *			 supported, this feature must be enabled before and
+ *			 disabled after %IOMMU_DEV_FEAT_SVA.
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
2.30.0

