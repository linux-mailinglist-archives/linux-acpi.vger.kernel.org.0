Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208912EF467
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Jan 2021 16:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbhAHPDg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Jan 2021 10:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbhAHPDf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Jan 2021 10:03:35 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EADFC06129C
        for <linux-acpi@vger.kernel.org>; Fri,  8 Jan 2021 07:02:32 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t16so9330216wra.3
        for <linux-acpi@vger.kernel.org>; Fri, 08 Jan 2021 07:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1derpUEbTnUCM4pdAeRyThDvUrcl7Y1I17djZN2CXEA=;
        b=EdJl9XQ5F1ey1gL2/1WvftdOw37yPekSWCO7fNK1NLXGdtG0TRVmRjn21vGztVrnQp
         Ym4PcMW/9QPGPvgSa+APqcy34DgALIA9UY0cR1XA1MgcaUmrgVFX4BB/oB/mPIBhgSal
         6uzP1grIpiJ9vK42gZG70OBS4K/BiUzfWKko3e9BKX4oxq+dou8E0H+e7RfGmCuN4JBk
         RIJd6eFitAuDd6FzTdO3LLKac0iKiu77CcThFaijA8roPDWw958o1YbOnmCD+WwGQ13W
         LsukSaouYZgivUdp4iQwXRCZPyYv+rm0oEYyYnL5da6hPrDPKtPHIngVAlSI63mWZ4nv
         oV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1derpUEbTnUCM4pdAeRyThDvUrcl7Y1I17djZN2CXEA=;
        b=uH1vBAmM1pDRDEOwoX895oMQM8zw5YJ53TAozirziIo90CZ3+JCJUPakRYK9vyCZsn
         /Z3xPaD3WqjJLiVWa5e0LAU/OT1GvhISQh/KFoTH6nKrss6EeU6Nc5XPyp4YOp5xTw1k
         7RIh32ONhe8d35wOi0jN7xQc++qt+pb5vtqi3KSPCHCD5KGjxEAofVz/wCdYrOWXpqAO
         gdIUO2j6DAl85WAXaRrmO+RgKSoVvUpf040jo+KBExRFFxJVYcb9SyGJBKEsSCgBPJ5Z
         M7xJNrNNTGAOBwvekznuXbbPNe9B3DwlxmCuw5EN4LyU+7ZTUCvVsXCfRhAXvjnW85i2
         PCsA==
X-Gm-Message-State: AOAM530ju3us654GLsNyWfBo1naIGzJjKbk1WOdg2wqIerv9bbtsyIPT
        P/uqhum5QCYRPJi3PbuckS7NpA==
X-Google-Smtp-Source: ABdhPJw+Gfi7cvkCsRObguyk13KxLpGoVIkXzdtADcC08qLi/L50fMR1aX17YNg6qtedaV/SyDcJdA==
X-Received: by 2002:adf:9b98:: with SMTP id d24mr4097725wrc.240.1610118150769;
        Fri, 08 Jan 2021 07:02:30 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id s13sm14258464wra.53.2021.01.08.07.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 07:02:30 -0800 (PST)
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
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v9 02/10] iommu/arm-smmu-v3: Use device properties for pasid-num-bits
Date:   Fri,  8 Jan 2021 15:52:10 +0100
Message-Id: <20210108145217.2254447-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210108145217.2254447-1-jean-philippe@linaro.org>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pasid-num-bits property shouldn't need a dedicated fwspec field,
it's a job for device properties. Add properties for IORT, and access
the number of PASID bits using device_property_read_u32().

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/iommu.h                       |  2 --
 drivers/acpi/arm64/iort.c                   | 13 +++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  3 ++-
 drivers/iommu/of_iommu.c                    |  5 -----
 4 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 26bcde5e7746..583c734b2e87 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -570,7 +570,6 @@ struct iommu_group *fsl_mc_device_group(struct device *dev);
  * struct iommu_fwspec - per-device IOMMU instance data
  * @ops: ops for this device's IOMMU
  * @iommu_fwnode: firmware handle for this device's IOMMU
- * @num_pasid_bits: number of PASID bits supported by this device
  * @num_ids: number of associated device IDs
  * @ids: IDs which this device may present to the IOMMU
  */
@@ -578,7 +577,6 @@ struct iommu_fwspec {
 	const struct iommu_ops	*ops;
 	struct fwnode_handle	*iommu_fwnode;
 	u32			flags;
-	u32			num_pasid_bits;
 	unsigned int		num_ids;
 	u32			ids[];
 };
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index d4eac6d7e9fb..c9a8bbb74b09 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -968,15 +968,16 @@ static int iort_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 static void iort_named_component_init(struct device *dev,
 				      struct acpi_iort_node *node)
 {
+	struct property_entry props[2] = {};
 	struct acpi_iort_named_component *nc;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-
-	if (!fwspec)
-		return;
 
 	nc = (struct acpi_iort_named_component *)node->node_data;
-	fwspec->num_pasid_bits = FIELD_GET(ACPI_IORT_NC_PASID_BITS,
-					   nc->node_flags);
+	props[0] = PROPERTY_ENTRY_U32("pasid-num-bits",
+				      FIELD_GET(ACPI_IORT_NC_PASID_BITS,
+						nc->node_flags));
+
+	if (device_add_properties(dev, props))
+		dev_warn(dev, "Could not add device properties\n");
 }
 
 static int iort_nc_iommu_map(struct device *dev, struct acpi_iort_node *node)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8ca7415d785d..6a53b4edf054 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2366,7 +2366,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 		}
 	}
 
-	master->ssid_bits = min(smmu->ssid_bits, fwspec->num_pasid_bits);
+	device_property_read_u32(dev, "pasid-num-bits", &master->ssid_bits);
+	master->ssid_bits = min(smmu->ssid_bits, master->ssid_bits);
 
 	/*
 	 * Note that PASID must be enabled before, and disabled after ATS:
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index e505b9130a1c..a9d2df001149 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -210,11 +210,6 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 					     of_pci_iommu_init, &info);
 	} else {
 		err = of_iommu_configure_device(master_np, dev, id);
-
-		fwspec = dev_iommu_fwspec_get(dev);
-		if (!err && fwspec)
-			of_property_read_u32(master_np, "pasid-num-bits",
-					     &fwspec->num_pasid_bits);
 	}
 
 	/*
-- 
2.29.2

